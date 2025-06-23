--***********************************************************
--**              	  ROBERT JOHNSON                       **
--***********************************************************

ISAddDesignationAnimalZoneUI = ISPanelJoypad:derive("ISAddDesignationAnimalZoneUI");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.NewSmall)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.NewMedium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

--************************************************************************--
--** ISAddDesignationAnimalZoneUI:initialise
--**
--************************************************************************--

function ISAddDesignationAnimalZoneUI:initialise()
    ISPanelJoypad.initialise(self);
    local btnWid = 150

--    self.parentUI:setVisible(false);

    self.buttonAdd = ISButton:new(UI_BORDER_SPACING, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT, btnWid, BUTTON_HGT, getText("IGUI_DesignationZone_SetPosition"), self, ISAddDesignationAnimalZoneUI.onClick);
    self.buttonAdd.internal = "ADD"
    self.buttonAdd.anchorTop = false
    self.buttonAdd.anchorBottom = true
    self.buttonAdd:enableAcceptColor()
    self:addChild(self.buttonAdd)
    self.buttonAdd:setVisible(false)

    self.cancel = ISButton:new(self:getWidth() - btnWid - UI_BORDER_SPACING, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT, btnWid, BUTTON_HGT, getText("UI_Cancel"), self, ISAddDesignationAnimalZoneUI.onClick);
    self.cancel.internal = "CANCEL";
    self.cancel.anchorTop = false
    self.cancel.anchorBottom = true
    self.cancel:enableCancelColor();
    self.cancel:initialise();
    self.cancel:instantiate();
    self:addChild(self.cancel);

    local zoneid = DesignationZoneAnimal.getAllZones():size() + 1;
    local title = getText("IGUI_DesignationZone_Type_" .. DesignationZoneAnimal.ZONE_TYPE) .. " #" .. zoneid;
    local found = false;
    while not found do
        if DesignationZoneAnimal.getZoneByName(title) then
            zoneid = zoneid + 1;
            title = getText("IGUI_DesignationZone_Type_" .. DesignationZoneAnimal.ZONE_TYPE) .. " #" .. zoneid;
        else
            break;
        end
    end

    self.titleEntry = ISLabel:new(10, 10, FONT_HGT_SMALL + 2 * 2, title,1 ,1,1,1,UIFont.NewSmall);
    self.titleEntry:initialise();
    self.titleEntry:instantiate();
    self:addChild(self.titleEntry);

end

function ISAddDesignationAnimalZoneUI:onMouseDownOutside(x, y)
    if self.playerNum ~= 0 then return end
    if not self.drawTileMouse or self.startingX then return; end
    local sq = self:pickSquare(x + self:getAbsoluteX(), y + self:getAbsoluteY())
    if sq then
        self.startRenderTile = true;
        self.drawTileMouse = true;
        self.startingX = sq:getX();
        self.startingY = sq:getY();
        self.endX = sq:getX();
        self.endY = sq:getY();
        ISWorldObjectContextMenu.disableWorldMenu = true;
    end
end

function ISAddDesignationAnimalZoneUI:onMouseMoveOutside(dx, dy)
    if self.playerNum ~= 0 then return end
    local sq = self:pickSquare(getMouseX(), getMouseY())
    if sq and self.drawTileMouse then
        self.endX = sq:getX();
        self.endY = sq:getY();
    end
end

function ISAddDesignationAnimalZoneUI:onMouseUpOutside(x, y)
    if self.playerNum ~= 0 then return end
    self:askCreateZone()
end

function ISAddDesignationAnimalZoneUI:askCreateZone()
    if not self.drawTileMouse or not self.startingX or not self.startingY or not self.widthCorrect or not self.heightCorrect then
        self:undisplay();
        return;
    end
    self.drawTileMouse = false;
    --self.cancel.enable = false;
    self.waitingConfirm = true;
    local modal = ISModalDialog:new(0,0, 350, 150, getText("IGUI_DesignationZone_AddZone"), true, self, ISAddDesignationAnimalZoneUI.onCreateZone);
    modal:initialise()
    modal:addToUIManager()
    modal.modal = self;
    modal.moveWithMouse = true;
    if getJoypadData(self.playerNum) then
        modal:centerOnScreen(self.playerNum)
        modal.prevFocus = self
        setJoypadFocus(self.playerNum, modal)
    end
--    self:addZone();
end

function ISAddDesignationAnimalZoneUI:onCreateZone(button)
    if button.internal == "YES" then
        self:addZone();
    else
        self:undisplay();
    end
    button.parent.modal.cancel.enable = true;
    button.parent.modal.waitingConfirm = false;
end

function ISAddDesignationAnimalZoneUI:addZone()
    ISWorldObjectContextMenu.disableWorldMenu = false;

    if not self.widthCorrect or not self.heightCorrect then
        local h = 150;
        local w = 350;
        local modal = ISModalDialog:new(getCore():getScreenWidth()/2 - w/2, getCore():getScreenHeight() / 2 - h/2, w, h, getText("IGUI_DesignationZone_Type_IncorrectSize"), false, nil, nil);
        modal:initialise()
        modal:addToUIManager()
        modal.moveWithMouse = true;

        self:reset();
        self.drawTileMouse = true;
        return;
    end

    if DesignationZoneAnimal.getZoneByName(self.titleEntry.name) then
        local modal = ISModalDialog:new(0,0, 350, 150, getText("IGUI_PvpZone_ZoneAlreadyExistTitle"), false, self, self.onZoneWithNameExists);
        modal:initialise()
        modal:addToUIManager()
        modal.moveWithMouse = true;
        if getJoypadData(self.playerNum) then
            modal:centerOnScreen(self.playerNum)
            modal.prevFocus = self
            setJoypadFocus(self.playerNum, modal)
        end
        self.drawTileMouse = true;
        return;
    end

    self:setVisible(false);
    self:removeFromUIManager();
    local startX = self.startingX;
    local startY = self.startingY;
    local endX = self.endX + 1;
    local endY = self.endY + 1;
    if startX > endX then
        endX = endX - 1;
        startX = startX + 1;
    end
    if startY > endY  then
        endY = endY - 1;
        startY = startY + 1;
    end
    local zone = DesignationZoneAnimal.new(self.titleEntry.name, startX, startY,luautils.round(self.player:getZ(),0),endX,endY)
    zone:createSurroundingFence();

    -- flag for hotsave - no need to flag all squares as zone is not actually stored on chunk - spurcival
    getSquare(startX, startY, self.player:getZ()):flagForHotSave(); 
    
    self:reset();

    self.parentUI:populateList();
    self.parentUI:setVisible(true);
    if getJoypadData(self.playerNum) then
        setJoypadFocus(self.playerNum, self.parentUI)
    end
end

function ISAddDesignationAnimalZoneUI:reset()
    if not self.startingX or not self.startingY then return; end
    local startingX = self.startingX;
    local startingY = self.startingY;
    local endX = self.endX;
    local endY = self.endY;
    if startingX > endX then
        local x2 = endX;
        endX = startingX;
        startingX = x2;
    end
    if startingY > endY then
        local y2 = endY;
        endY = startingY;
        startingY = y2;
    end

    for x2=startingX, endX do
        for y=startingY, endY do
            local sq = getCell():getGridSquare(x2,y,self.player:getCurrentSquare():getZ());
            if sq and sq:getFloor() then
                sq:getFloor():setHighlighted(false, false);
                --for n = 0,sq:getObjects():size()-1 do
                --    local obj = sq:getObjects():get(n);
                --    obj:setHighlighted(false, false);
--                    obj:setHighlightColor(self.zoneColor.r,self.zoneColor.g,self.zoneColor.b,self.zoneColor.a);
--                end
            end
        end
    end


    self.startRenderTile = false;
    self.drawTileMouse = false;
    self.startingX = nil;
    self.startingY = nil;
    self.endX = nil;
    self.endY = nil;
    ISWorldObjectContextMenu.disableWorldMenu = false;
end

function ISAddDesignationAnimalZoneUI:prerender()
    local z = UI_BORDER_SPACING+1;
    local splitPoint = getTextManager():MeasureStringX(UIFont.NewSmall, getText("IGUI_PvpZone_ZoneName")) + UI_BORDER_SPACING*2;
    local x = UI_BORDER_SPACING+1;
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawText(getText("IGUI_PvpZone_AddZone"), self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_PvpZone_AddZone")) / 2), z, 1,1,1,1, UIFont.Medium);

    z = z + FONT_HGT_MEDIUM + UI_BORDER_SPACING;
    self:drawText(getText("IGUI_PvpZone_ZoneName"), x, z + 2,1,1,1,1,UIFont.Small);
    self.titleEntry:setY(z);
    self.titleEntry:setX(splitPoint);
    z = z + FONT_HGT_SMALL;

    local howTo = getText("IGUI_DesignationZone_HowTo")
    if getJoypadData(self.playerNum) then
        if self.startingX == nil then
            howTo = getText("IGUI_DesignationZone_HowToJoypadStart")
        else
            howTo = getText("IGUI_DesignationZone_HowToJoypadEnd")
        end
    end
    self:drawText(howTo, x, z + 2,1,1,1,1,UIFont.Small);
    self:setWidth(math.max(self.width, UI_BORDER_SPACING*2 + 2 +getTextManager():MeasureStringX(UIFont.Small, howTo)))
    self.cancel:setX(self.width - self.cancel.width - UI_BORDER_SPACING - 1)
    z = z + FONT_HGT_SMALL + UI_BORDER_SPACING;

    if not self.startingX or not self.startRenderTile then
        self:highlightSquareAtMousePointer()
        self:highlightSquareAtStartPosition()
        self:updateButtons()
        return
     end

    local startingX = self.startingX;
    local startingY = self.startingY;
    local endX = self.endX;
    local endY = self.endY;
    if startingX > endX then
        local x2 = endX;
        endX = startingX;
        startingX = x2;
    end
    if startingY > endY then
        local y2 = endY;
        endY = startingY;
        startingY = y2;
    end

    local width = (endX - startingX) + 1;
    local height = (endY - startingY) + 1;
    local size = width * height;
    self.widthCorrect = true;
    self.heightCorrect = true;
    local correctColor = {r=1,g=1,b=1};
    local badColor = {r=0.9,g=0.1,b=0.1};
    local widthColor = correctColor;
    local heightColor = correctColor;
    if width > 40 or width < 2 then
        self.widthCorrect = false;
        widthColor = badColor;
    end
    if height > 40 or height < 2 then
        self.heightCorrect = false;
        heightColor = badColor;
    end
    self:drawText(getText("IGUI_DesignationZone_Type_Width") .. ": " .. width, x, z + 2,widthColor.r,widthColor.g,widthColor.b,1,UIFont.NewSmall);
    z = z + FONT_HGT_SMALL;
    self:drawText(getText("IGUI_DesignationZone_Type_Height") .. ": " .. height, x, z + 2,heightColor.r,heightColor.g,heightColor.b,1,UIFont.NewSmall);
    z = z + FONT_HGT_SMALL;
    self:drawText(getText("IGUI_DesignationZone_Type_TotalSize") .. ": " .. size, x, z + 2,1,1,1,1,UIFont.NewSmall);

    local r,g,b,a = self.zoneColor.r, self.zoneColor.g, self.zoneColor.b, self.zoneColor.a
    if not self.widthCorrect or not self.heightCorrect then
        r,g,b = 1,0,0
    end
    addAreaHighlightForPlayer(self.playerNum, startingX, startingY, endX + 1, endY + 1, self.player:getCurrentSquare():getZ(), r, g, b, a)

    self:highlightSquareAtMousePointer()
    self:updateButtons();
end

function ISAddDesignationAnimalZoneUI:updateButtons()
--    self.ok.enable = self.size > 1;
    if getJoypadData(self.playerNum) then
        self.buttonAdd:setVisible(true)
        if self.startingX == nil then
            self.buttonAdd:setTitle(getText("IGUI_DesignationZone_SetPosition"))
        else
            self.buttonAdd:setTitle(getText("IGUI_PvpZone_AddZone"))
        end
        self.buttonAdd.enable = (not self.startingX) or (self.widthCorrect and self.heightCorrect)
        -- Don't disable the cancel button.
        return
    end
    self.buttonAdd:setVisible(false)
    if not self.startingX or not self.startRenderTile then return; end
    if self.widthCorrect and self.heightCorrect then
        self.cancel.enable = not self.drawTileMouse and not self.waitingConfirm;
    end
end

function ISAddDesignationAnimalZoneUI:pickSquare(screenX, screenY)
    local playerIndex = self.playerNum
    local z = self.player:getCurrentSquare():getZ()
    local worldX = screenToIsoX(playerIndex, screenX, screenY, z)
    local worldY = screenToIsoY(playerIndex, screenX, screenY, z)
    return getCell():getGridSquare(worldX, worldY, z), worldX, worldY, z
end

function ISAddDesignationAnimalZoneUI:highlightSquareAtMousePointer()
    if (self.playerNum ~= 0) or ((getJoypadData(self.playerNum) ~= nil) and not wasMouseActiveMoreRecentlyThanJoypad()) then return end
    local square,x,y,z = self:pickSquare(getMouseX(), getMouseY())
    local r,g,b,a = self.zoneColor.r, self.zoneColor.g, self.zoneColor.b, self.zoneColor.a
    a = 1.0
    addAreaHighlightForPlayer(self.playerNum, x, y, x + 1, y + 1, z, r, g, b, a)
    return
end

function ISAddDesignationAnimalZoneUI:highlightSquareAtStartPosition()
    if (self.playerNum == 0) and ((getJoypadData(self.playerNum) == nil) or wasMouseActiveMoreRecentlyThanJoypad()) then return end
    local x,y,z = self.joypadWorldX,self.joypadWorldY,self.player:getZ()
    local r,g,b,a = self.zoneColor.r, self.zoneColor.g, self.zoneColor.b, self.zoneColor.a
    a = 1.0
    addAreaHighlightForPlayer(self.playerNum, x, y, x + 1, y + 1, z, r, g, b, a)
    return
end

function ISAddDesignationAnimalZoneUI:undisplay()
    self:reset()
    self:setVisible(false)
    self:removeFromUIManager()
    self.parentUI:setVisible(true)
    if getJoypadData(self.playerNum) then
        setJoypadFocus(self.playerNum, self.parentUI)
    end
end

function ISAddDesignationAnimalZoneUI:onClick(button)
    if button.internal == "ADD" then
        if self.startingX == nil then
            self.startingX = self.joypadWorldX
            self.startingY = self.joypadWorldY
            self.endX = self.startingX
            self.endY = self.startingY
            self.startRenderTile = true;
            self.drawTileMouse = true
        else
            self:askCreateZone()
        end
    end
    if button.internal == "CANCEL" then
        self:undisplay();
        self.parentUI:populateList();
    end
end

function ISAddDesignationAnimalZoneUI:onZoneWithNameExists()
    self:undisplay()
end

function ISAddDesignationAnimalZoneUI:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
    self:setISButtonForA(self.buttonAdd)
    self:setISButtonForB(self.cancel)
    self.joypadWorldX = self.player:getCurrentSquare():getX()
    self.joypadWorldY = self.player:getCurrentSquare():getY()
end

function ISAddDesignationAnimalZoneUI:onJoypadDown(button, joypadData)
    ISPanelJoypad.onJoypadDown(self, button, joypadData)
end

function ISAddDesignationAnimalZoneUI:onJoypadDirUp(joypadData)
    if self.startingX == nil then
        self.joypadWorldY = self.joypadWorldY - 1
    else
        self.endY = self.endY - 1
    end
end

function ISAddDesignationAnimalZoneUI:onJoypadDirDown(joypadData)
    if self.startingX == nil then
        self.joypadWorldY = self.joypadWorldY + 1
    else
        self.endY = self.endY + 1
    end
end

function ISAddDesignationAnimalZoneUI:onJoypadDirLeft(joypadData)
    if self.startingX == nil then
        self.joypadWorldX = self.joypadWorldX - 1
    else
        self.endX = self.endX - 1
    end
end

function ISAddDesignationAnimalZoneUI:onJoypadDirRight(joypadData)
    if self.startingX == nil then
        self.joypadWorldX = self.joypadWorldX + 1
    else
        self.endX = self.endX + 1
    end
end

--************************************************************************--
--** ISAddDesignationAnimalZoneUI:new
--**
--************************************************************************--
function ISAddDesignationAnimalZoneUI:new(x, y, width, height, player)
    height = 1 + UI_BORDER_SPACING + FONT_HGT_MEDIUM + UI_BORDER_SPACING + FONT_HGT_SMALL * 2 + UI_BORDER_SPACING + FONT_HGT_SMALL * 3 + UI_BORDER_SPACING + BUTTON_HGT + UI_BORDER_SPACING+1
    local o = ISPanelJoypad.new(self, x, y, width, height);
    if y == 0 then
        o.y = o:getMouseY() - (height / 2)
        o:setY(o.y)
    end
    if x == 0 then
        o.x = o:getMouseX() - (width / 2)
        o:setX(o.x)
    end
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.zoneColor = {r=DesignationZoneAnimal.ZONECOLORR, g=DesignationZoneAnimal.ZONECOLORG, b=DesignationZoneAnimal.ZONECOLORB, a=0.5};
    o.width = width;
    o.height = height;
    o.player = player;
    o.playerNum = player:getPlayerNum();
    o.startingX = nil;
    o.startingY = nil;
    o.endX = nil;
    o.endY = nil;
    o.drawTileMouse = true;
--    o.moveWithMouse = true;
    o.startRenderTile = false;
    ISAddDesignationAnimalZoneUI.instance = o;
    o.buttonBorderColor = {r=0.7, g=0.7, b=0.7, a=0.5};
    player:setSeeDesignationZone(true);
    return o;
end
