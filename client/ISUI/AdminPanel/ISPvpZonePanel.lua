--***********************************************************
--**              	  ROBERT JOHNSON                       **
--***********************************************************

ISPvpZonePanel = ISPanel:derive("ISPvpZonePanel");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

--************************************************************************--
--** ISPvpZonePanel:initialise
--**
--************************************************************************--

function ISPvpZonePanel:initialise()
    ISPanel.initialise(self);
    local btnWid = 100

    local listY = UI_BORDER_SPACING*2 + FONT_HGT_MEDIUM + 1
    self.nonPvpList = ISScrollingListBox:new(UI_BORDER_SPACING+1, listY, self.width - (UI_BORDER_SPACING+1)*2, BUTTON_HGT * 16);
    self.nonPvpList:initialise();
    self.nonPvpList:instantiate();
    self.nonPvpList.itemheight = BUTTON_HGT;
    self.nonPvpList.selected = 0;
    self.nonPvpList.joypadParent = self;
    self.nonPvpList.font = UIFont.NewSmall;
    self.nonPvpList.doDrawItem = self.drawList;
    self.nonPvpList.drawBorder = true;
    self:addChild(self.nonPvpList);

    self.removeZone = ISButton:new(self.nonPvpList.x + self.nonPvpList.width - btnWid, self.nonPvpList.y + self.nonPvpList.height + UI_BORDER_SPACING, btnWid, BUTTON_HGT, getText("ContextMenu_Remove"), self, ISPvpZonePanel.onClick);
    self.removeZone:setX(self.nonPvpList.x + self.nonPvpList.width - self.removeZone.width)
    self.removeZone.internal = "REMOVEZONE";
    self.removeZone:initialise();
    self.removeZone:instantiate();
    self.removeZone.borderColor = self.buttonBorderColor;
    self:addChild(self.removeZone);
    self.removeZone.enable = false;

    self.teleportToZone = ISButton:new(self.nonPvpList.x + self.nonPvpList.width - 70, self.removeZone.y + BUTTON_HGT + UI_BORDER_SPACING, 70, BUTTON_HGT, getText("IGUI_PvpZone_TeleportToZone"), self, ISPvpZonePanel.onClick);
    self.teleportToZone:setX(self.nonPvpList.x + self.nonPvpList.width - self.teleportToZone.width)
    self.teleportToZone.internal = "TELEPORTTOZONE";
    self.teleportToZone:initialise();
    self.teleportToZone:instantiate();
    self.teleportToZone.borderColor = self.buttonBorderColor;
    self:addChild(self.teleportToZone);
    self.teleportToZone.enable = false;

    self.addZone = ISButton:new(self.nonPvpList.x, self.nonPvpList.y + self.nonPvpList.height + UI_BORDER_SPACING, 70, BUTTON_HGT, getText("IGUI_PvpZone_AddZone"), self, ISPvpZonePanel.onClick);
    self.addZone.internal = "ADDZONE";
    self.addZone:initialise();
    self.addZone:instantiate();
    self.addZone.borderColor = self.buttonBorderColor;
    self:addChild(self.addZone);

    self.seeZoneOnGround = ISButton:new(self.nonPvpList.x, self.addZone.y + BUTTON_HGT + UI_BORDER_SPACING, 70, BUTTON_HGT, getText("IGUI_PvpZone_SeeZone"), self, ISPvpZonePanel.onClick);
    self.seeZoneOnGround.internal = "SEEZONE";
    self.seeZoneOnGround:initialise();
    self.seeZoneOnGround:instantiate();
    self.seeZoneOnGround.borderColor = self.buttonBorderColor;
    self:addChild(self.seeZoneOnGround);

    self.no = ISButton:new(self.nonPvpList.x + self.nonPvpList.width - btnWid, self.seeZoneOnGround:getBottom() + UI_BORDER_SPACING, btnWid, BUTTON_HGT, getText("IGUI_CraftUI_Close"), self, ISPvpZonePanel.onClick);
    self.no.internal = "OK";
    self.no:initialise();
    self.no:instantiate();
    self.no.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.no);

    self:setHeight(self.no:getBottom() + UI_BORDER_SPACING+1)

    self:populateList();

end

function ISPvpZonePanel:populateList()
    self.nonPvpList:clear();
    for i=0,NonPvpZone.getAllZones():size()-1 do
        local zone = NonPvpZone.getAllZones():get(i);
        local newZone = {};
        newZone.title = zone:getTitle();
        newZone.zone = zone;
        self.nonPvpList:addItem(newZone.title, newZone);
    end
end

function ISPvpZonePanel:drawList(y, item, alt)
    local a = 0.9;
    self:drawRectBorder(0, (y), self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15);
    end

    self:drawText(item.item.title, 10, y + 2, 1, 1, 1, a, self.font);
--    self:drawText(item.item.zone:getSize() .. "", 100, y + 2, 1, 1, 1, a, self.font);

    return y + self.itemheight;
end

function ISPvpZonePanel:render()

end

function ISPvpZonePanel:prerender()
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawText(getText("IGUI_PvpZone_Title"), self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_PvpZone_Title")) / 2), UI_BORDER_SPACING+1, 1,1,1,1, UIFont.Medium);

    if not self.player:getRole():hasCapability(Capability.CanSetupNonPVPZone) then
        self:close()
    end
end

function ISPvpZonePanel:updateButtons()
end

function ISPvpZonePanel:render()
    self:updateButtons();

    self.removeZone.enable = false;
    self.teleportToZone.enable = false;
    if self.nonPvpList.selected > 0 then
        self.removeZone.enable = true;
        if self.player:getRole():hasCapability(Capability.TeleportToCoordinates) then
            self.teleportToZone.enable = true;
        end
        self.selectedZone = self.nonPvpList.items[self.nonPvpList.selected].item.zone;
    else
        self.selectedZone = nil;
    end
end

function ISPvpZonePanel:onClick(button)
    if button.internal == "OK" then
        self:setVisible(false);
        self:removeFromUIManager();
        self.player:setSeeNonPvpZone(false);
    end
    if button.internal == "REMOVEZONE" then
        local modal = ISModalDialog:new(0,0, 350, 150, getText("IGUI_PvpZone_RemoveConfirm", self.selectedZone:getTitle()), true, nil, ISPvpZonePanel.onRemoveZone);
        modal:initialise()
        modal:addToUIManager()
        modal.ui = self;
        modal.selectedZone = self.selectedZone;
        modal.moveWithMouse = true;
    end
    if button.internal == "ADDZONE" then
        local addPvpZone = ISAddNonPvpZoneUI:new(10,10, 300+(getCore():getOptionFontSizeReal()*50), FONT_HGT_MEDIUM+UI_BORDER_SPACING*8+BUTTON_HGT*6+2, self.player);
        addPvpZone:initialise()
        addPvpZone:addToUIManager()
        addPvpZone.parentUI = self;
        self:setVisible(false);
        if not self.player:isInvisible() then
            SendCommandToServer("/invisible");
        end
    end
    if button.internal == "SEEZONE" then
        self.player:setSeeNonPvpZone(not self.player:isSeeNonPvpZone());
    end
    if button.internal == "TELEPORTTOZONE" then
        SendCommandToServer("/teleportto " .. self.selectedZone:getX() .. "," .. self.selectedZone:getY() .. ",0");
    end
end

function ISPvpZonePanel:onRemoveZone(button)
    if button.internal == "YES" then
        NonPvpZone.removeNonPvpZone(button.parent.selectedZone:getTitle());
        button.parent.ui:populateList();
    end
end

--************************************************************************--
--** ISPvpZonePanel:new
--**
--************************************************************************--
function ISPvpZonePanel:new(x, y, width, height, player)
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
    o.player = player;
    o.moveWithMouse = true;
    ISPvpZonePanel.instance = o;
    o.buttonBorderColor = {r=0.7, g=0.7, b=0.7, a=0.5};
    return o;
end
