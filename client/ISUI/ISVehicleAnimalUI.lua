require "ISUI/ISCollapsableWindowJoypad"

ISVehicleAnimalUI = ISCollapsableWindowJoypad:derive("ISVehicleAnimalUI")
ISVehicleAnimalUI.ui = nil;

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local BUTTON_HGT = FONT_HGT_SMALL + 6

-----

-- Avatar and controls for a single animal in a vehicle.
ISAnimalInVehiclePanel = ISPanelJoypad:derive("ISAnimalInVehiclePanel")

function ISAnimalInVehiclePanel:createChildren()
    local btnWidth = self.animalUI.btnWidth
    local btnHeight = self.animalUI.btnHeight

    self.avatar = ISVehicleAnimal3DModel:new(0, 0, self.width, self.height - btnHeight - 5)
    self:addChild(self.avatar)
end

function ISAnimalInVehiclePanel:prerender()
    local x,y,w,h = 0, 0, self.avatar.width, self.avatar.height
    self:drawRectBorder(x - 2, y - 2, w + 4, h + 4, 1, 0.3, 0.3, 0.3)
    self:drawTextureScaled(self.animalUI.avatarBackgroundTexture, x, y, w, h, 1, 0.4, 0.4, 0.4)
    if self.joypadFocused then
        self:renderJoypadFocus(-2, -2, w + 4, h + 4)
    end
end

function ISAnimalInVehiclePanel:onRightMouseUp(x, y)
    local animal = self.avatar.animal
    local context = ISContextMenu.get(self.animalUI.playerNum, x + self:getAbsoluteX(), y + self:getAbsoluteY())
    context:addOption(getText("ContextMenu_AnimalInfo"), self.animalUI, ISVehicleAnimalUI.onAnimalInfo, animal);
    local option = context:addOption(getText("ContextMenu_Grab"), self.animalUI, ISVehicleAnimalUI.onGrabAnimal, animal);
    if not animal:canBePicked(self.animalUI.character) then
        option.notAvailable = true;
        local toolTip = ISToolTip:new()
        toolTip:initialise()
        toolTip:setVisible(false)
        toolTip:setName(getText("Tooltip_Animal_TooHeavy"))
        option.toolTip = toolTip
    end

    context:addOption(getText("IGUI_TicketUI_RemoveTicket"), self.animalUI, ISVehicleAnimalUI.onRemoveAnimal, animal);
    if not animal:isDead() and animal:getStats():getThirst() >= 0.1 then
        AnimalContextMenu.doWaterAnimalMenu(context, animal, self.animalUI.character);
    end
    if not animal:isDead() and animal:getStats():getHunger() >= 0.1 then
        AnimalContextMenu.doFeedFromHandMenu(self.animalUI.character, animal, context);
    end
    if AnimalContextMenu.cheat and not animal:isDead() then
        context:addDebugOption("Kill", animal, ISVehicleAnimalUI.onKillAnimalDebug, self.animalUI.character);
    end
    local joypadData = getJoypadData(self.animalUI.playerNum)
    if self.joypadFocused and joypadData then
        context.mouseOver = 1
        context.origin = self.parent
        setJoypadFocus(self.animalUI.playerNum, context)
    end
    return true
end

function ISAnimalInVehiclePanel:onJoypadDownInParent(button, joypadData)
    if button == Joypad.AButton then
        self:onRightMouseUp(self:getWidth() + 4, 0)
    end
end

function ISAnimalInVehiclePanel:new(width, height, animalUI)
    local o = ISPanelJoypad.new(self, 0, 0, width, height)
    o.animalUI = animalUI
    return o
end

-----

function ISVehicleAnimalUI:initialise()
    ISCollapsableWindowJoypad.initialise(self);
end

function ISVehicleAnimalUI:createChildren()
    ISCollapsableWindowJoypad.createChildren(self)

    local titleBarHeight = self:titleBarHeight()
    local resizeWidgetHeight = self:resizeWidgetHeight()
    self.progressBar = ISProgressBar:new (17, titleBarHeight + FONT_HGT_SMALL, 166, self.btnHeight, "", UIFont.NewSmall);
    self.progressBar:setVisible(true);
    self:addChild(self.progressBar);

    self.addBtn = ISButton:new(self.progressBar.x + self.progressBar:getWidth() + 50, titleBarHeight + 10, self.btnWidth, BUTTON_HGT, getText("ContextMenu_AddAnimal"), self, ISVehicleAnimalUI.onAddAnimal);
    self.addBtn:initialise();
    self.addBtn:instantiate();
    self.addBtn.borderColor = {r=1, g=1, b=1, a=0.8};
    self:addChild(self.addBtn);

    local panelY = self.progressBar:getBottom() + 5
    local panelHgt = self.height - resizeWidgetHeight - panelY
    self.scrollPanel = ISPanelJoypad:new(0, panelY, self:getWidth(), panelHgt)
    self.scrollPanel:initialise()
    self.scrollPanel:instantiate()
    self.scrollPanel:setAnchorLeft(true);
    self.scrollPanel:setAnchorRight(true);
    self.scrollPanel:setAnchorTop(true);
    self.scrollPanel:setAnchorBottom(true);
    self.scrollPanel:setScrollChildren(true)
    self.scrollPanel:noBackground()
    self.scrollPanel:addScrollBars()
    self.scrollPanel.vscroll.doRepaintStencil = true
    self.scrollPanel.vehicle = self.vehicle;
    self.scrollPanel.animals = {};
    self.scrollPanel.avatars = {};
    self:addChild(self.scrollPanel);

    for i=0, self.vehicle:getAnimals():size()-1 do
        table.insert(self.scrollPanel.animals, self.vehicle:getAnimals():get(i));
    end

    self.scrollPanel.reset = ISVehicleAnimalUI.reset;
    self.scrollPanel.prerender = ISVehicleAnimalUI.prerenderScrollPanel;

    self.scrollPanel.render = function(_self)
        ISPanelJoypad.render(_self)
        _self:clearStencilRect()
        local joypadData = getJoypadData(_self.parent.playerNum)
        if joypadData then
            local jf = _self.joyfocus
            _self.joyfocus = joypadData
            _self:ensureVisible()
            _self.joyfocus = jf
        end
    end
    self.scrollPanel.onMouseWheel = function(_self, del)
        if _self:getScrollHeight() > 0 then
            _self:setYScroll(_self:getYScroll() - (del * 40))
            return true
        end
        return false
    end

    self:create();
end

function ISVehicleAnimalUI:checkCanAddAnimal()
    if not self.vehicle or not self.vehicle:getSquare() then return; end

    self.addBtn.enable = false;

    local doorOpen = true;
    local trunkDoor = self.vehicle:getPartById("TrunkDoor") or self.vehicle:getPartById("DoorRear") or self.vehicle:getPartById("TrunkDoorOpened")
    if trunkDoor and trunkDoor:getDoor() then
        if not trunkDoor:getDoor():isOpen() then doorOpen = false end
    end

    local haveAnimals = false;

    if instanceof(self.character:getPrimaryHandItem(), "AnimalInventoryItem") then
        haveAnimals = true;
    end
    if self.character:getPrimaryHandItem() and self.character:getPrimaryHandItem():getType() == "CorpseAnimal" and not self.character:getPrimaryHandItem():getDeadBodyObject():isAnimalSkeleton() then
        haveAnimals = true;
    end
    for x=self.vehicle:getSquare():getX() - 6, self.vehicle:getSquare():getX()+5 do
        for y=self.vehicle:getSquare():getY() - 6, self.vehicle:getSquare():getY()+5 do
            local sq = getSquare(x, y, self.vehicle:getSquare():getZ());
            if sq then
                local animals = sq:getAnimals();
                if not animals:isEmpty() then
                    haveAnimals = true;
                    break;
                end
                local deadbodies = sq:getDeadBodys();
                for i=0, deadbodies:size()-1 do
                    local body = deadbodies:get(i);
                    if body:isAnimal() and not body:isAnimalSkeleton() and body:getSquare() then
                        haveAnimals = true;
                        break;
                    end
                end
            end
        end
        if haveAnimals then
            break;
        end
    end

    if haveAnimals and doorOpen then
        self.addBtn.enable = true;
    end
end

function ISVehicleAnimalUI:onAddAnimal()
    local context = ISContextMenu.get(self.playerNum, self.addBtn:getAbsoluteX() + 10, self.addBtn:getAbsoluteY() + 10)
    ISVehicleMenu.doAnimalSubMenu(context, self.character, self.vehicle);
    if getJoypadData(self.playerNum) then
        context.mouseOver = 1
        context.origin = self
        setJoypadFocus(self.playerNum, context)
    end
end

function ISVehicleAnimalUI.onKillAnimalDebug(animal, player)
    animal:setHealth(0)
end

function ISVehicleAnimalUI:prerenderScrollPanel()
    ISPanelJoypad.prerender(self)

    local joypadIndexY = math.max(self.joypadIndexY, 1)
    local joypadIndex = math.max(self.joypadIndex, 1)
    self.joypadButtonsY = {}
    self.joypadButtons = {}
    self.joypadIndexY = 1
    self.joypadIndex = 1
    local lineOfButtons = {}
    local joypadData = getJoypadData(self.parent.playerNum)
    if joypadData then
        self:clearJoypadFocus(joypadData)
    end

    local xoffset = 10;
    local yoffset = 10;
    local index = 0;
    --self:drawText(getText("IGUI_Animal_TrailerAvailability") .. round(self.vehicle:getCurrentTotalAnimalSize(), 1) .. "/" .. self.vehicle:getAnimalTrailerSize(), 20, 12, 1,1,1,1, UIFont.NewSmall);
    for i,animalPanel in ipairs(self.avatars) do
        animalPanel:setX(xoffset);
        animalPanel:setY(yoffset);
        local avatar = animalPanel.avatar
        xoffset = xoffset + avatar.width + 10;

        if avatar.animal then
            --            self:drawRectBorder(avatar.x, avatar.y, avatar.width, avatar.height, 1, 0.3, 0.3, 0.3);
            local x,y,w,h = avatar.x, avatar.y, avatar.width, avatar.height
            local avatarDef = AnimalAvatarDefinition[avatar.animal:getAnimalType()];
            if avatarDef then
                avatar:setZoom(avatarDef.trailerZoom * avatar.animal:getData():getSize());
                avatar:setXOffset(avatarDef.trailerXoffset * avatar.animal:getData():getSize());
                avatar:setYOffset(avatarDef.trailerYoffset * avatar.animal:getData():getSize());
                avatar:setDirection(avatarDef.trailerDir);
                if avatar.animal:isDead() then
                    avatar:setVariable("TrailerAnimation", "dead")
                else
                    avatar:setVariable("TrailerAnimation", "idle1")
                end
                --                print("def values", avatar.animal:getCustomName(),  "zoom: ", avatarDef.trailerZoom, "xoffset", avatarDef.trailerXoffset, "yoffset", avatarDef.trailerYoffset)
                --                print("final values", avatar.animal:getCustomName(),  "zoom: ", avatarDef.trailerZoom * avatar.animal:getData():getSize(), "xoffset", avatarDef.trailerXoffset * avatar.animal:getData():getSize(), "yoffset", avatarDef.trailerYoffset * avatar.animal:getData():getSize())
            end

            if avatar.animal:getCustomName() then
                local text = avatar.animal:getCustomName();
                if avatar.animal:isDead() then
                    text = getText("IGUI_Item_AnimalCorpse", avatar.animal:getCustomName())
                end
                self:drawTextCentre(text, avatar.x + avatar.width / 2, avatar.y + 10, 1,1,1,1, UIFont.NewSmall);
            end
            table.insert(lineOfButtons, animalPanel)
            index = index + 1;
        else
            animalPanel:setVisible(false);
        end

        if index >= 4 then
            self:insertNewListOfButtons(lineOfButtons)
            lineOfButtons = {}
            yoffset = yoffset + avatar.height + 10 + self.parent.btnHeight;
            xoffset = 10;
            index = 0;
        end
    end
    if #lineOfButtons > 0 then
        self:insertNewListOfButtons(lineOfButtons)
    end
    if joypadData ~= nil and joypadData:isConnected() and joypadIndexY <= #self.joypadButtonsY then
        self.joypadIndexY = joypadIndexY
        self.joypadButtons = self.joypadButtonsY[joypadIndexY]
        if joypadIndex <= #self.joypadButtons then
            self.joypadIndex = joypadIndex
        end
        self:restoreJoypadFocus(joypadData)
    end
    self:setScrollHeight(yoffset + 20 + self.parent.avatarHeight)
    self:setStencilRect(0, 0, self:getWidth(), self:getHeight())
end

function ISVehicleAnimalUI:update()
    if self.scrollPanel ~= nil then
        if self.animalCount ~= self.vehicle:getAnimals():size() then
            self:reset(self.scrollPanel);
            self.animalCount = self.vehicle:getAnimals():size();
        end
    end
end

function ISVehicleAnimalUI:prerender()
    ISCollapsableWindowJoypad.prerender(self)

--    if not AnimalContextMenu.cheat then
        if not self.vehicle or not self.vehicle:getCurrentSquare() or not self.character or not self.character:getCurrentSquare() or self.vehicle:getCurrentSquare():DistToProper(self.character) > 4 then
            self:close();
        end
--    end
end

--
function ISVehicleAnimalUI:render()
    ISCollapsableWindowJoypad.render(self)

    self:drawText(getText("IGUI_Animal_TrailerAvailability"), self.progressBar.x, self.progressBar.y - FONT_HGT_SMALL, 1,1,1,1, UIFont.NewSmall);

    self.progressBar:setText(round(self.vehicle:getAnimalTrailerSize() - self.vehicle:getCurrentTotalAnimalSize(), 1) .. "");
    self.progressBar.progress = self.vehicle:getCurrentTotalAnimalSize() / self.vehicle:getAnimalTrailerSize();

    self:setInfo(getText("IGUI_AnimalTrailer_Info"));

    self:checkCanAddAnimal();
end

function ISVehicleAnimalUI:create(reset)
    for i, animal in ipairs(self.scrollPanel.animals) do
        local addAvatar = false;

        local animalPanel = self.scrollPanel.avatars[i];
        if not animalPanel then
            addAvatar = true;
            animalPanel = ISAnimalInVehiclePanel:new(self.avatarWidth, self.avatarHeight + 5 + self.btnHeight, self)
            self.scrollPanel:addChild(animalPanel)
        end
        animalPanel:setVisible(true)
        animalPanel:setX(100)
        animalPanel:setY(100)
        local avatar = animalPanel.avatar
        if animal then
            avatar:setAnimSetName(animal:GetAnimSetName())
            avatar:setCharacter(animal)
            avatar:setDirection(IsoDirections.S)
            avatar.animal = animal;
        else
            animalPanel:setVisible(false)
        end

        if addAvatar then
            self.scrollPanel.avatars[i] = animalPanel;
        end
--[[
        local removeBtn = animalPanel.removeBtn;
        local grabBtn = animalPanel.grabBtn;
        local infoBtn = animalPanel.infoBtn;
        removeBtn.animal = animal;
        removeBtn.borderColor = {r=1, g=1, b=1, a=0.8};
        grabBtn.animal = animal;
        grabBtn.borderColor = {r=1, g=1, b=1, a=0.8};
        infoBtn.animal = animal;
        infoBtn.borderColor = {r=1, g=1, b=1, a=0.8};
--]]
    end

    -- custom size
    if #self.scrollPanel.animals < 20 then
        local row = math.floor(#self.scrollPanel.animals / 4) + 1;
        self:setHeight((row * (self.avatarHeight + self.btnHeight + 40)) + 100)
    end
end

function ISVehicleAnimalUI:onAnimalInfo(animal)
    local vec = self.vehicle:getAreaCenter("AnimalEntry");
    local sq = getSquare(vec:getX(), vec:getY(), self.vehicle:getZ());
    if luautils.walkAdj(self.character, sq) then
        ISTimedActionQueue.add(ISOpenAnimalInfo:new(self.character, animal, self));
    end
end

function ISVehicleAnimalUI:onRemoveAnimal(animal)
    local vec = self.vehicle:getAreaCenter("AnimalEntry");
    local sq = getSquare(vec:getX(), vec:getY(), self.vehicle:getZ());
    if luautils.walkAdj(self.character, sq) then
        ISTimedActionQueue.add(ISRemoveAnimalFromTrailer:new(self.character, self.vehicle, animal, false));
    end
end

function ISVehicleAnimalUI:onGrabAnimal(animal)
    local vec = self.vehicle:getAreaCenter("AnimalEntry");
    local sq = getSquare(vec:getX(), vec:getY(), self.vehicle:getZ());
    if luautils.walkAdj(self.character, sq) then
        ISTimedActionQueue.add(ISRemoveAnimalFromTrailer:new(self.character, self.vehicle, animal, true));
    end
end

function ISVehicleAnimalUI:reset(panel)
    panel.animals = {};
    for i=0, panel.vehicle:getAnimals():size()-1 do
        table.insert(panel.animals, panel.vehicle:getAnimals():get(i));
    end

    local joypadData = getJoypadData(self.playerNum)
    if joypadData then
        self.scrollPanel:clearJoypadFocus(joypadData)
    end

    for _,animalPanel in ipairs(panel.avatars) do
        animalPanel:setVisible(false);
        local avatar = animalPanel.avatar
        avatar:setCharacter(nil);
        avatar.animal = nil;
    end

    panel.parent:create(true);
end

function ISVehicleAnimalUI:close()
    self:setVisible(false);
    self:removeFromUIManager()
    ISVehicleAnimalUI.ui = nil;
    if getJoypadData(self.playerNum) then
        setJoypadFocus(self.playerNum, nil)
    end
end

function ISVehicleAnimalUI:onGainJoypadFocus(joypadData)
    ISCollapsableWindowJoypad.onGainJoypadFocus(self, joypadData)
    self.scrollPanel:setISButtonForY(self.addBtn)
    joypadData.focus = self.scrollPanel
end

function ISVehicleAnimalUI:onJoypadDown_Descendant(descendant, button, joypadData)
    if button == Joypad.BButton then
        self:close()
        return
    end
    ISCollapsableWindowJoypad.onJoypadDown_Descendant(self, descendant, button, joypadData)
end

function ISVehicleAnimalUI:onJoypadBeforeDeactivate(joypadData)
    for _,animalPanel in ipairs(self.scrollPanel.avatars) do
        animalPanel:setJoypadFocused(false, joypadData)
    end
end

function ISVehicleAnimalUI:onJoypadBeforeDeactivate_Descendant(descendant, joypadData)
    self:onJoypadBeforeDeactivate(joypadData)
end

function ISVehicleAnimalUI:new(vehicle, player)
    local avatarWidth = 160;
    local avatarHeight = 200;
    local btnHeight = 25;
    local playerNum = player:getPlayerNum()
    local o = ISCollapsableWindowJoypad.new(self, getPlayerScreenLeft(playerNum)+100, getPlayerScreenTop(playerNum)+10, (avatarWidth * 4) + 100, avatarHeight * 4 + (3*(btnHeight+10)) + 40)
    o.avatarWidth = avatarWidth;
    o.avatarHeight = avatarHeight;
    o.btnHeight = btnHeight;
    o.btnWidth = 60;
    o.character = player
    o.playerNum = playerNum
    o.vehicle = vehicle;
    o.animalCount = o.vehicle:getAnimals():size();
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.btnBorder = {r=1, g=1, b=1, a=0.7};
    o:setResizable(true)
    o:setWantKeyEvents(true)
    ISVehicleAnimalUI.ui = o;
    local carName = vehicle:getScript():getCarModelName() or vehicle:getScript():getName()
    local name = getText("IGUI_VehicleName" .. carName);
    o:setTitle(name);
    o.avatarBackgroundTexture = getTexture("media/ui/avatarBackgroundWhite.png")
    return o
end

ISVehicleAnimal3DModel = ISUI3DModel:derive("ISVehicleAnimal3DModel")

function ISVehicleAnimal3DModel:instantiate()
    ISUI3DModel.instantiate(self)
    self:setIsometric(false)
    --    self.javaObject:setConsumeMouseEvents(false)
end

function ISVehicleAnimal3DModel:onMouseDown(x, y)
    return false
end

function ISVehicleAnimal3DModel:onMouseMove(dx, dy)
    return false
end

function ISVehicleAnimal3DModel:onMouseMoveOutside(dx, dy)
    return false
end

function ISVehicleAnimal3DModel:onMouseUp(x, y)
    return false
end

function ISVehicleAnimal3DModel:onMouseUpOutside(x, y)
    return false
end

function ISVehicleAnimal3DModel:onRightMouseUp(x, y)
    return false
end

function ISVehicleAnimal3DModel:new(x, y, width, height)
    local o = ISUI3DModel.new(self, x, y, width, height)
    return o
end

function ISVehicleAnimalUI:isKeyConsumed(key)
    return self.playerNum == 0 and key == Keyboard.KEY_ESCAPE
end

function ISVehicleAnimalUI:onKeyRelease(key)
    if self.playerNum == 0 and key == Keyboard.KEY_ESCAPE then
        self:close()
        return
    end
end
