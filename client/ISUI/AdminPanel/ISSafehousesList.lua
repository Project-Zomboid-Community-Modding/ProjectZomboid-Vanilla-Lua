--***********************************************************
--**              	  ROBERT JOHNSON                       **
--***********************************************************

ISSafehousesList = ISPanel:derive("ISSafehousesList");
ISSafehousesList.messages = {};

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

--************************************************************************--
--** ISSafehousesList:initialise
--**
--************************************************************************--

function ISSafehousesList:initialise()
    ISPanel.initialise(self);
    local btnWid = 100

    self.no = ISButton:new(UI_BORDER_SPACING+1, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT - 1, btnWid, BUTTON_HGT, getText("IGUI_CraftUI_Close"), self, ISSafehousesList.onClick);
    self.no.internal = "CANCEL";
    self.no.anchorTop = false
    self.no.anchorBottom = true
    self.no:initialise();
    self.no:instantiate();
    self.no.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.no);

    local listY = UI_BORDER_SPACING*2 + FONT_HGT_MEDIUM + 1
    self.datas = ISScrollingListBox:new(UI_BORDER_SPACING+1, listY, self.width - (UI_BORDER_SPACING+1)*2, self.height - UI_BORDER_SPACING*2 - BUTTON_HGT - listY - 1);
    self.datas:initialise();
    self.datas:instantiate();
    self.datas.itemheight = BUTTON_HGT;
    self.datas.selected = 0;
    self.datas.joypadParent = self;
    self.datas.font = UIFont.NewSmall;
    self.datas.doDrawItem = self.drawDatas;
    self.datas.drawBorder = true;
    self:addChild(self.datas);

    self.teleportBtn = ISButton:new(self:getWidth() - btnWid - 10,  self.no.y, btnWid, BUTTON_HGT, getText("IGUI_PlayerStats_Teleport"), self, ISSafehousesList.onClick);
    self.teleportBtn.internal = "TELEPORT";
    self.teleportBtn.anchorTop = false
    self.teleportBtn.anchorBottom = true
    self.teleportBtn:initialise();
    self.teleportBtn:instantiate();
    self.teleportBtn.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.teleportBtn);
    self.teleportBtn.enable = false;
    self.teleportBtn:setX(self.width - self.teleportBtn.width - UI_BORDER_SPACING - 1)

    self.viewBtn = ISButton:new(self.teleportBtn.x - self.teleportBtn.width - UI_BORDER_SPACING,  self.no.y, btnWid, BUTTON_HGT, getText("IGUI_PlayerStats_View"), self, ISSafehousesList.onClick);
    self.viewBtn.internal = "VIEW";
    self.viewBtn.anchorTop = false
    self.viewBtn.anchorBottom = true
    self.viewBtn:initialise();
    self.viewBtn:instantiate();
    self.viewBtn.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.viewBtn);
    self.viewBtn.enable = false;
    self.viewBtn:setX(self.teleportBtn.x - self.viewBtn.width - UI_BORDER_SPACING)

    self:populateList();

end

function ISSafehousesList:populateList()
    self.datas:clear();
    for i=0,SafeHouse.getSafehouseList():size()-1 do
        local safe = SafeHouse.getSafehouseList():get(i);
       self.datas:addItem(safe:getTitle(), safe);
    end
end

function ISSafehousesList:drawDatas(y, item, alt)
    local a = 0.9;

--    self.parent.selectedSafehouse = nil;
    self:drawRectBorder(0, (y), self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15);
        if ISSafehousesList.instance.player:getRole():hasCapability(Capability.TeleportToCoordinates) then
            self.parent.teleportBtn.enable = true;
        end
        self.parent.viewBtn.enable = true;
        self.parent.selectedSafehouse = item.item;
    end

    self:drawText(item.item:getTitle() .. " - " .. getText("IGUI_FactionUI_FactionsListPlayers", item.item:getPlayers():size() + 1, item.item:getOwner()), 10, y + 2, 1, 1, 1, a, self.font);

    return y + self.itemheight;
end

function ISSafehousesList:prerender()
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawText(getText("IGUI_AdminPanel_SeeSafehouses"), self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_AdminPanel_SeeSafehouses")) / 2), UI_BORDER_SPACING+1, 1,1,1,1, UIFont.Medium);
end

function ISSafehousesList:onClick(button)
    if button.internal == "CANCEL" then
        self:close()
    end
    if button.internal == "TELEPORT" then
        self.player:teleportTo(self.selectedSafehouse:getX(), self.selectedSafehouse:getY(), 0);
        if isClient() then
            SendCommandToServer("/teleportto " .. tostring(self.selectedSafehouse:getX()) .. "," .. tostring(self.selectedSafehouse:getY()) .. ",0");
        else
            getPlayer():teleportTo(self.selectedSafehouse:getX(), self.selectedSafehouse:getY(), 0)
        end
    end
    if button.internal == "VIEW" then
        local safehouseUI = ISSafehouseUI:new(getCore():getScreenWidth() / 2 - 250,getCore():getScreenHeight() / 2 - 225, 500, 450, self.selectedSafehouse, self.player);
        safehouseUI:initialise()
        safehouseUI:addToUIManager()
    end
end

function ISSafehousesList:close()
    self:setVisible(false)
    self:removeFromUIManager()
    ISSafehousesList.instance = nil
end

--************************************************************************--
--** ISSafehousesList:new
--**
--************************************************************************--
function ISSafehousesList:new(x, y, width, height, player)
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
    o.selectedFaction = nil;
    o.moveWithMouse = true;
    ISSafehousesList.instance = o;
    return o;
end

function ISSafehousesList.OnSafehousesChanged()
    if ISSafehousesList.instance then
        ISSafehousesList.instance:populateList()
    end
end

Events.OnSafehousesChanged.Add(ISSafehousesList.OnSafehousesChanged)

