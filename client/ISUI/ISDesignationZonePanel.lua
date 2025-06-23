--***********************************************************
--**              	  ROBERT JOHNSON                       **
--***********************************************************

require "ISUI/ISCollapsableWindowJoypad"

ISDesignationZonePanel = ISCollapsableWindowJoypad:derive("ISDesignationZonePanel");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.NewSmall)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.NewMedium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

--************************************************************************--
--** ISDesignationZonePanel:initialise
--**
--************************************************************************--

function ISDesignationZonePanel:initialise()
    ISCollapsableWindowJoypad.initialise(self);
    local btnWid = 150

    local width = UI_BORDER_SPACING*2 + 2 + math.max(
            getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_DesignationZone_WanderInfo")),
            getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_DesignationZone_WanderInfo2"))
    )
    self:setWidth(math.max(width, self.width))

    self.zoneList = ISScrollingListBox:new(UI_BORDER_SPACING+1, self:titleBarHeight() + UI_BORDER_SPACING, self.width - (UI_BORDER_SPACING+1)*2, BUTTON_HGT * 16);
    self.zoneList:initialise();
    self.zoneList:instantiate();
    self.zoneList.itemheight = BUTTON_HGT;
    self.zoneList.selected = 0;
    self.zoneList.joypadParent = self;
    self.zoneList.font = UIFont.NewSmall;
    self.zoneList.doDrawItem = self.drawList;
    self.zoneList.drawBorder = true;
    self:addChild(self.zoneList);

    self.addZone = ISButton:new(self.zoneList.x, self.zoneList.y + self.zoneList.height + UI_BORDER_SPACING, btnWid, BUTTON_HGT, getText("IGUI_PvpZone_AddZone"), self, ISDesignationZonePanel.onClick);
    self.addZone.internal = "ADDZONE";
    self.addZone:initialise();
    self.addZone:instantiate();
    self.addZone.borderColor = self.buttonBorderColor;
    self:addChild(self.addZone);

    self.removeZone = ISButton:new(self.width - 1 - btnWid - UI_BORDER_SPACING, self.addZone.y, btnWid, BUTTON_HGT, getText("ContextMenu_Remove"), self, ISDesignationZonePanel.onClick);
    self.removeZone.internal = "REMOVEZONE";
    self.removeZone:initialise();
    self.removeZone:instantiate();
    self.removeZone.borderColor = self.buttonBorderColor;
    self:addChild(self.removeZone);
    self.removeZone.enable = false;

    self.renameZone = ISButton:new(self.removeZone.x - btnWid - UI_BORDER_SPACING, self.addZone.y, btnWid, BUTTON_HGT, getText("ContextMenu_RenameBag"), self, ISDesignationZonePanel.onClick);
    self.renameZone.internal = "RENAMEZONE";
    self.renameZone:initialise();
    self.renameZone:instantiate();
    self.renameZone.borderColor = self.buttonBorderColor;
    self:addChild(self.renameZone);
    self.renameZone.enable = false;

--    self.teleportToZone = ISButton:new(self.zoneList.x + self.zoneList.width - 70, self.removeZone.y + btnHgt2 + 5, 70, btnHgt2, getText("IGUI_PvpZone_TeleportToZone"), self, ISDesignationZonePanel.onClick);
--    self.teleportToZone:setX(self.zoneList.x + self.zoneList.width - self.teleportToZone.width)
--    self.teleportToZone.internal = "TELEPORTTOZONE";
--    self.teleportToZone:initialise();
--    self.teleportToZone:instantiate();
--    self.teleportToZone.borderColor = self.buttonBorderColor;
--    self:addChild(self.teleportToZone);
--    self.teleportToZone.enable = false;

--    self.seeZoneOnGround = ISButton:new(self.zoneList.x, self.addZone.y + btnHgt2 + 5, 70, btnHgt2, getText("IGUI_PvpZone_SeeZone"), self, ISDesignationZonePanel.onClick);
--    self.seeZoneOnGround.internal = "SEEZONE";
--    self.seeZoneOnGround:initialise();
--    self.seeZoneOnGround:instantiate();
--    self.seeZoneOnGround.borderColor = self.buttonBorderColor;
--    self:addChild(self.seeZoneOnGround);

    self.closeButton = ISButton:new(self.removeZone.x, self.addZone:getBottom() + BUTTON_HGT*2, btnWid, BUTTON_HGT, getText("IGUI_CraftUI_Close"), self, ISDesignationZonePanel.onClick);
    self.closeButton.internal = "OK";
    self.closeButton:initialise();
    self.closeButton:instantiate();
    self.closeButton:enableCancelColor();
    self:addChild(self.closeButton);

    self:setHeight(self.closeButton:getBottom() + UI_BORDER_SPACING + 1)

    if self.listTakesFocus then
        self.joypadIndexY = 1
        self.joypadIndex = 1
        self.joypadButtonsY = {}
        self.joypadButtons = {}
        self:insertNewLineOfButtons(self.zoneList)
        self:insertNewLineOfButtons(self.addZone, self.renameZone, self.removeZone)
    end

    self:populateList();

end

function ISDesignationZonePanel:close()
    self:setVisible(false);
    self:removeFromUIManager();
    self.player:setSeeDesignationZone(false);
    if isJoypadFocusOnElementOrDescendant(self.playerNum, self) then
        setJoypadFocus(self.playerNum, nil)
    end
end

function ISDesignationZonePanel:populateList()
    self.zoneList:clear();
    local zoneDisplayedAlready = ArrayList.new(); -- a zone could have multiple connected zone, but we display only the first connected, no need for the others
    local allZones = DesignationZoneAnimal.getAllZones();
    for i=0,allZones:size()-1 do
        local zone = allZones:get(i);
        if not zoneDisplayedAlready:contains(zone) then
            local connectedZones = DesignationZoneAnimal.getAllDZones(nil, zone, nil);
            -- don't show zone that's not streamed
            if zone:isStillStreamed() then
                local newZone = {};
                newZone.title = zone:getName();
                newZone.size = zone:getW() * zone:getH();
                newZone.zone = zone;
                self.zoneList:addItem(newZone.title, newZone);
            end

            for j=0,connectedZones:size()-1 do
                zoneDisplayedAlready:add(connectedZones:get(j));
            end
        end
    end
end

function ISDesignationZonePanel:drawList(y, item, alt)
    local a = 0.9;
    if not self.currentWidth then self.currentWidth = 0; end
    self:drawRectBorder(0, (y), self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15);
    end

    self:drawText(item.item.title, 10, y + 2, 1, 1, 1, a, self.font);
    local newWidth = getTextManager():MeasureStringX(self.font, item.item.title)
    if newWidth > self.currentWidth then
        self.currentWidth = newWidth;
    end

    self:drawText("Size: " .. item.item.size, self.currentWidth + 20, y + 2, 1, 1, 1, a, self.font);
--    self:drawText(item.item.zone:getSize() .. "", 100, y + 2, 1, 1, 1, a, self.font);

    return y + self.itemheight;
end

function ISDesignationZonePanel:prerender()
    ISCollapsableWindowJoypad.prerender(self)

    self:setInfo(getText("IGUI_DesignationZone_Info"));

    local z = 20;
    local splitPoint = 100;
    local x = 10;
--    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
--    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
--    self:drawText(getText("IGUI_DesignationZone_Title"), self.width/2 - (getTextManager():MeasureStringX(UIFont.NewMedium, getText("IGUI_DesignationZone_Title")) / 2), z, 1,1,1,1, UIFont.NewMedium);
end

function ISDesignationZonePanel:updateButtons()
end

function ISDesignationZonePanel:render()
    ISCollapsableWindowJoypad.render(self);

    self:updateButtons();

    self.removeZone.enable = false;
    self.renameZone.enable = false;
--    self.teleportToZone.enable = false;
    if self.zoneList.selected > 0 then
        self.removeZone.enable = true;
        self.renameZone.enable = true;
--        self.teleportToZone.enable = true;
        -- reset the list of zones to highlight when clicking another zone
        if self.zoneList.items[self.zoneList.selected].item.zone ~= self.selectedZone then
            self.player:resetSelectedZonesForHighlight();
        end
        self.selectedZone = self.zoneList.items[self.zoneList.selected].item.zone;
    else
        self.selectedZone = nil;
        self.player:resetSelectedZonesForHighlight();
    end

    if not self.zoneList.joypadFocused and self.joypadIndexY == 1 then
		local x,y,w,h = self.zoneList.x, self.zoneList.y, self.zoneList.width, self.zoneList.height
		self:drawRectBorderStatic(x, y, w, h, 1.0, 1.0, 1.0, 1.0)
		self:drawRectBorderStatic(x+1, y+1, w-2, h-2, 1.0, 1.0, 1.0, 1.0)
    end

--    self.player:setSelectedZoneForHighlight(0);
    if self.selectedZone then
        local connectedZones = DesignationZoneAnimal.getAllDZones(nil, self.selectedZone, nil);
        self.player:setSeeDesignationZone(true);
        for i=0, connectedZones:size()-1 do
            self.player:addSelectedZoneForHighlight(connectedZones:get(i):getId());
        end
    end

    local BHC = getCore():getBadHighlitedColor()
    self:drawText(getText("IGUI_DesignationZone_WanderInfo"), self.addZone.x, self.addZone.y + BUTTON_HGT + 3, BHC:getR(), BHC:getG(), BHC:getB(), 1, self.font);
    self:drawText(getText("IGUI_DesignationZone_WanderInfo2"), self.addZone.x, self.addZone.y + BUTTON_HGT*2 + 3, BHC:getR(), BHC:getG(), BHC:getB(), 1, self.font);
end

function ISDesignationZonePanel:onClick(button)
    if button.internal == "OK" then
        self:close();
    end
    if button.internal == "REMOVEZONE" then
        local modal = ISModalDialog:new(0,0, 350, 150, getText("IGUI_Designation_RemoveConfirm", self.selectedZone:getName()), true, nil, ISDesignationZonePanel.onRemoveZone);
        modal:initialise()
        modal:addToUIManager()
        modal.ui = self;
        modal.selectedZone = self.selectedZone;
        modal.moveWithMouse = true;
        if getJoypadData(self.playerNum) then
            modal:centerOnScreen(self.playerNum)
            modal.prevFocus = self
            setJoypadFocus(self.playerNum, modal)
        end
    end
    if button.internal == "RENAMEZONE" then
        local modal = ISTextBox:new(0, 0, 280, 180, getText("ContextMenu_RenameBag"), self.selectedZone:getName(), self, ISDesignationZonePanel.onRenameZoneClick);
        modal:initialise();
        modal:addToUIManager();
        modal.maxChars = 30;
        if getJoypadData(self.playerNum) then
            modal:centerOnScreen(self.playerNum)
            modal.prevFocus = self
            setJoypadFocus(self.playerNum, modal)
        end
    end
    if button.internal == "ADDZONE" then
        local ui = ISAddDesignationAnimalZoneUI:new(getPlayerScreenLeft(self.playerNum)+10, getPlayerScreenTop(self.playerNum)+10, 320, FONT_HGT_MEDIUM*8, self.player);
        ui:initialise()
        ui:addToUIManager()
        ui.parentUI = self;
        self:setVisible(false);
        if getJoypadData(self.playerNum) then
            setJoypadFocus(self.playerNum, ui)
        end
    end
--    if button.internal == "SEEZONE" then
--        self.player:setSeeDesignationZone(not self.player:setSeeDesignationZone());
--    end
end

function ISDesignationZonePanel:onRenameZoneClick(button, animal)
    if button.internal == "OK" then
        if button.parent.entry:getText() and button.parent.entry:getText() ~= "" then
            self.selectedZone:setName(button.parent.entry:getText());
            self:populateList();
        end
    end
end

function ISDesignationZonePanel:onRemoveZone(button)
    if button.internal == "YES" then
        DesignationZoneAnimal.removeZone(button.parent.selectedZone);

        -- flag for hotsave, no need to flag all squares as DesignationZoneAnimal is not actually on chunk - spurcival
        getSquare(button.parent.selectedZone:getX(), button.parent.selectedZone:getY(), button.parent.selectedZone:getZ()):flagForHotSave();

        button.parent.ui:populateList();
    end
end

function ISDesignationZonePanel:onGainJoypadFocus(joypadData)
    ISCollapsableWindowJoypad.onGainJoypadFocus(self, joypadData)
    if self.listTakesFocus then
        if joypadData.switchingFocusFrom == self.zoneList then
            self:setISButtonForB(self.closeButton)
        else
            self.joypadIndexY = 1
            self.joypadIndex = 1
            self.zoneList:setJoypadFocused(true, joypadData)
            setJoypadFocus(self.playerNum, self.zoneList)
        end
    else
        self:setISButtonForA(self.closeButton)
        self:setISButtonForB(self.removeZone)
        self:setISButtonForX(self.renameZone)
        self:setISButtonForY(self.addZone)
    end
end

function ISDesignationZonePanel:onLoseJoypadFocus(joypadData)
    ISCollapsableWindowJoypad.onLoseJoypadFocus(self, joypadData)
    self:clearISButtons()
    self:clearJoypadFocus(joypadData)
end

function ISDesignationZonePanel:onJoypadDirUp(joypadData)
    if not self.listTakesFocus then
        self.zoneList:onJoypadDirUp(joypadData)
        return
    end
    ISCollapsableWindowJoypad.onJoypadDirUp(self, joypadData)
end

function ISDesignationZonePanel:onJoypadDirDown(joypadData)
    if not self.listTakesFocus then
        self.zoneList:onJoypadDirDown(joypadData)
        return
    end
    ISCollapsableWindowJoypad.onJoypadDirDown(self, joypadData)
end

ISDesignationZonePanel.toggleZoneUI = function(playerNum)
    local ui = getPlayerZoneUI(playerNum)
    if ui then
        if ui:getIsVisible() then
            ui:setVisible(false)
            ui:removeFromUIManager() -- avoid update() while hidden
            ui.player:setSeeDesignationZone(false)
        else
            ui:setVisible(true)
            ui:centerOnScreen(playerNum)
            ui:addToUIManager()
            ui:populateList();
            if getJoypadData(playerNum) then
                setJoypadFocus(playerNum, ui)
            end
        end
    end
end

--************************************************************************--
--** ISDesignationZonePanel:new
--**
--************************************************************************--
function ISDesignationZonePanel:new(x, y, width, height, player)
    x = getCore():getScreenWidth() / 2 - (width / 2);
    y = getCore():getScreenHeight() / 2 - (height / 2);
    local o = ISCollapsableWindowJoypad.new(self, x, y, width, height);
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.width = width;
    o.playerNum = player:getPlayerNum();
    o.height = height;
    o.player = player;
    o:setResizable(false);
    o.moveWithMouse = true;
    ISDesignationZonePanel.instance = o;
    o.player:setSeeDesignationZone(true)
    o.buttonBorderColor = {r=0.7, g=0.7, b=0.7, a=0.5};
    o.listTakesFocus = false
    o:setTitle(getText("IGUI_DesignationZone_Title"));
    return o;
end
