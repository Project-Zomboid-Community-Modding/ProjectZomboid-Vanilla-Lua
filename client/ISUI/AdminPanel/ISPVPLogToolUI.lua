ISPVPLogToolUI = ISPanel:derive("ISPVPLogToolUI");
ISPVPLogToolUI.instance = nil

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

function ISPVPLogToolUI:initialise()
    ISPanel.initialise(self);

    requestPVPEvents()

    local buttonWidth = 100
    local tickBoxWidth = 150

    self.tickBox = ISTickBox:new(UI_BORDER_SPACING + 10, FONT_HGT_SMALL * 4, tickBoxWidth, BUTTON_HGT, "PVPLog", self, self.onTicked)
    self.tickBox.choicesColor = {r=1, g=1, b=1, a=1}
    self.tickBox:setFont(UIFont.Small)
    self:addChild(self.tickBox)

    local n = self.tickBox:addOption(getText("IGUI_PVPLogTool_SendToChat"))
    self.tickBox:setSelected(n, getServerOptions():getBoolean("PVPLogToolChat"))

    local n = self.tickBox:addOption(getText("IGUI_PVPLogTool_WriteToFile"))
    self.tickBox:setSelected(n, getServerOptions():getBoolean("PVPLogToolFile"))

    self.close = ISButton:new(UI_BORDER_SPACING * 2, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT - 1, buttonWidth, BUTTON_HGT, getText("IGUI_RolesList_Close"), self, ISPVPLogToolUI.onClick);
    self.close.internal = "CLOSE";
    self.close.anchorTop = false
    self.close.anchorBottom = true
    self.close:initialise();
    self.close:instantiate();
    self.close.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.close);

    self.clear = ISButton:new(self.width - buttonWidth - UI_BORDER_SPACING * 2, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT - 1, buttonWidth, BUTTON_HGT, getText("UI_chat_Clear"), self, ISPVPLogToolUI.onClick);
    self.clear.internal = "CLEAR";
    self.clear.anchorTop = false
    self.clear.anchorBottom = true
    self.clear:initialise();
    self.clear:instantiate();
    self.clear.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.clear);

    self.teleport = ISButton:new(self.width - buttonWidth - UI_BORDER_SPACING * 2 - buttonWidth - UI_BORDER_SPACING * 2, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT - 1, buttonWidth, BUTTON_HGT, getText("IGUI_UserList_Teleport"), self, ISPVPLogToolUI.onClick);
    self.teleport.internal = "TELEPORT";
    self.teleport.anchorTop = false
    self.teleport.anchorBottom = true
    self.teleport:initialise();
    self.teleport:instantiate();
    self.teleport.borderColor = {r=1, g=1, b=1, a=0.1};
    self.teleport:setVisible(false)
    self:addChild(self.teleport);

    self.pvpEvents = ISScrollingListBox:new(UI_BORDER_SPACING + tickBoxWidth, FONT_HGT_SMALL * 4, self.width - tickBoxWidth - UI_BORDER_SPACING * 3, 10 * (FONT_HGT_SMALL + 4));
    self.pvpEvents:initialise();
    self.pvpEvents:instantiate();
    self.pvpEvents.itemheight = FONT_HGT_SMALL + 4
    self.pvpEvents.selected = 0;
    self.pvpEvents.joypadParent = self;
    self.pvpEvents.font = UIFont.Small;
    self.pvpEvents.doDrawItem = self.drawEvents;
    self.pvpEvents.onmousedown = self.onSelect
    self.pvpEvents.drawBorder = true;
    self:addChild(self.pvpEvents);

    local events = PVPLogTool.getEvents()
    for i=0,events:size()-1 do
        local event = events:get(i)
        self.pvpEvents:addItem(event.timestamp, event);
    end
end

function ISPVPLogToolUI:onSelect(_item)
    if ISPVPLogToolUI.instance.selectedItem == _item or not _item:isSet() then
        ISPVPLogToolUI.instance.selectedItem = nil
        ISPVPLogToolUI.instance.pvpEvents.selected = 0
    else
        ISPVPLogToolUI.instance.selectedItem = _item
    end
end

function ISPVPLogToolUI:drawEvents(y, item, alt)
    local a = 0.9;

    self:drawRectBorder(0, (y), self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15);
    end

    if item.item:isSet() then
        self:drawText(item.item:getText(), UI_BORDER_SPACING, y + 2, 1, 1, 1, a, UIFont.Small)
    end

    return y + self.itemheight;
end

function ISPVPLogToolUI:prerender()
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawText(getText("IGUI_AdminPanel_PVPLogTool"), self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_AdminPanel_PVPLogTool")) / 2), UI_BORDER_SPACING + 1, 1, 1, 1, 1, UIFont.Medium);
    self:drawRect(UI_BORDER_SPACING * 2, UI_BORDER_SPACING * 2 + FONT_HGT_SMALL, self.width - UI_BORDER_SPACING * 4, 1, 0.5, 1, 1, 1);

    self.teleport:setVisible(ISPVPLogToolUI.instance.selectedItem ~= nil)
end

function ISPVPLogToolUI:onClick(button)
    if button.internal == "CLOSE" then
        SendCommandToServer("/reloadoptions")
        ISPVPLogToolUI.instance:closeModal()
        return
    end
    if button.internal == "TELEPORT" then
        getPlayer():setX(tonumber(ISPVPLogToolUI.instance.selectedItem:getX()));
        getPlayer():setY(tonumber(ISPVPLogToolUI.instance.selectedItem:getY()));
        getPlayer():setZ(tonumber(ISPVPLogToolUI.instance.selectedItem:getZ()));
        getPlayer():setLastX(tonumber(ISPVPLogToolUI.instance.selectedItem:getX()));
        getPlayer():setLastY(tonumber(ISPVPLogToolUI.instance.selectedItem:getY()));
        getPlayer():setLastZ(tonumber(ISPVPLogToolUI.instance.selectedItem:getZ()));
    end
    if button.internal == "CLEAR" then
        clearPVPEvents()
        ISPVPLogToolUI.instance.selectedItem = nil
        ISPVPLogToolUI.instance.pvpEvents.selected = 0
    end
end

function ISPVPLogToolUI:onTicked(index, selected)
    if index == 1 then
        SendCommandToServer("/changeoption PVPLogToolChat \"" .. tostring(selected) .. "\"")
    end
    if index == 2 then
        SendCommandToServer("/changeoption PVPLogToolFile \"" .. tostring(selected) .. "\"")
    end
end

function ISPVPLogToolUI:closeModal()
    self:setVisible(false)
    self:removeFromUIManager()
    ISPVPLogToolUI.instance = nil
end

function ISPVPLogToolUI:new(x, y, width, height)
    local o = {}
    x = getCore():getScreenWidth() / 2 - (width / 2);
    y = getCore():getScreenHeight() / 2 - (height / 2);
    o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.width = width;
    o.height = height;
    o.moveWithMouse = true;
    ISPVPLogToolUI.instance = o;
    return o;
end
