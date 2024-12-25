--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 16/02/2017
-- Time: 11:23
-- To change this template use File | Settings | File Templates.
--

StashDebug = ISPanel:derive("StashDebug");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

--************************************************************************--
--** StashDebug:initialise
--**
--************************************************************************--

function StashDebug:initialise()
    ISPanel.initialise(self);
    local btnWid = UI_BORDER_SPACING*2 + math.max(
            getTextManager():MeasureStringX(UIFont.Small, getText("UI_Cancel")),
            getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_StashDebug_Spawn")),
            getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_StashDebug_Reinitialize"))
    )

    self.width = UI_BORDER_SPACING*3 + btnWid*2 + 2

    self.no = ISButton:new(UI_BORDER_SPACING+1, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT - 1, btnWid, BUTTON_HGT, getText("UI_Cancel"), self, StashDebug.onClick);
    self.no.internal = "CANCEL";
    self.no.anchorTop = false
    self.no.anchorBottom = true
    self.no:initialise();
    self.no:instantiate();
    self.no:enableCancelColor()
    self:addChild(self.no);

    self.viewBtn = ISButton:new(self:getWidth() - btnWid - UI_BORDER_SPACING-1,  self.no.y, btnWid, BUTTON_HGT, getText("IGUI_StashDebug_Spawn"), self, StashDebug.onClick);
    self.viewBtn.internal = "SPAWN";
    self.viewBtn.anchorTop = false
    self.viewBtn.anchorBottom = true
    self.viewBtn:initialise();
    self.viewBtn:instantiate();
    self.viewBtn.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.viewBtn);
    self.viewBtn.enable = false;

    self.reinitBtn = ISButton:new((self.width - btnWid)/2,  self.viewBtn.y - BUTTON_HGT - UI_BORDER_SPACING, btnWid, BUTTON_HGT, getText("IGUI_StashDebug_Reinitialize"), self, StashDebug.onClick);
    self.reinitBtn.internal = "REINIT";
    self.reinitBtn.anchorTop = false
    self.reinitBtn.anchorBottom = true
    self.reinitBtn:initialise();
    self.reinitBtn:instantiate();
    self.reinitBtn.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.reinitBtn);

    self.datas = ISScrollingListBox:new(UI_BORDER_SPACING+1, FONT_HGT_MEDIUM + UI_BORDER_SPACING*2+1, self.width - (UI_BORDER_SPACING+1)*2, self.height - FONT_HGT_MEDIUM - UI_BORDER_SPACING*5 - BUTTON_HGT*2 - 2);
    self.datas:initialise();
    self.datas:instantiate();
    self.datas.selected = 0;
    self.datas.joypadParent = self;
    self.datas.doDrawItem = self.drawDatas;
    self.datas.drawBorder = true;
    self:addChild(self.datas);
    self.datas:setFont(UIFont.Small, 3)

    self:populateList();
end

function StashDebug:populateList()
    self.datas:clear();
    for i=0,StashSystem.getPossibleStashes():size()-1 do
        local stash = StashSystem.getStash(StashSystem.getPossibleStashes():get(i):getName());
        self.datas:addItem(stash:getName(), stash);
    end
end

function StashDebug:drawDatas(y, item, alt)
    local a = 0.9;

    --    self.parent.selectedStash = nil;
    self:drawRectBorder(0, (y), self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15);
        self.parent.viewBtn.enable = true;
        self.parent.selectedStash = item.item;
    end

    self:drawText( item.item:getName(), UI_BORDER_SPACING, y + 3, 1, 1, 1, a, self.font);

    return y + self.itemheight;
end

function StashDebug:prerender()
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawTextCentre(getText("IGUI_DebugMenu_Dev_Stash"), self.width/2, UI_BORDER_SPACING+1, 1,1,1,1, UIFont.Medium);
end

function StashDebug:onClick(button)
    if button.internal == "CANCEL" then
        self:removeFromUIManager();
    end
    if button.internal == "SPAWN" then
        if self.selectedStash then
            local map = instanceItem(self.selectedStash:getItem());
            StashSystem.doStashItem(self.selectedStash, map);
            getPlayer():getInventory():AddItem(map);
            local mapUI = ISMap:new(0, 0, 0, 0, map, 0);
            map:doBuildingStash();
--             getPlayer():setX(self.selectedStash:getBuildingX() + 2);
--             getPlayer():setY(self.selectedStash:getBuildingY() + 2);
--             getPlayer():setLastX(self.selectedStash:getBuildingX() + 2);
--             getPlayer():setLastY(self.selectedStash:getBuildingY() + 2);
            self:populateList();
        end
    end
    if button.internal == "REINIT" then
        StashSystem.reinit();
        self:populateList();
    end

end

function StashDebug.OnOpenPanel()
    if not StashDebug.instance then
        local ui = StashDebug:new(0, 0, 300+(getCore():getOptionFontSizeReal()*10), 600);
        ui:initialise();
        StashDebug.instance = ui;
    else
        StashDebug.instance:populateList();
    end
    StashDebug.instance:addToUIManager();
end

--************************************************************************--
--** StashDebug:new
--**
--************************************************************************--
function StashDebug:new(x, y, width, height)
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
    o.selectedStash = nil;
    o.moveWithMouse = true;
    ISDebugMenu.RegisterClass(self);
    return o;
end
