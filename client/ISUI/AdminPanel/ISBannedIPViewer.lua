--***********************************************************
--**              	  ROBERT JOHNSON                       **
--***********************************************************

ISBannedIPViewer = ISPanel:derive("ISBannedIPViewer");
ISBannedIPViewer.messages = {};

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local FONT_HGT_LARGE = getTextManager():getFontHeight(UIFont.Large)

local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

local COL_1_WIDTH = 200
local COL_2_WIDTH = 150

--************************************************************************--
--** ISBannedIPViewer:initialise
--**
--************************************************************************--

function ISBannedIPViewer:initialise()
    ISPanel.initialise(self);
    local btnWid = 100
    local padBottom = UI_BORDER_SPACING+1

    local y = UI_BORDER_SPACING*2 + FONT_HGT_MEDIUM + BUTTON_HGT + 1
    self.datas = ISScrollingListBox:new(UI_BORDER_SPACING+1, y, self.width - (UI_BORDER_SPACING+1)*2, self.height - padBottom - BUTTON_HGT - UI_BORDER_SPACING - y)
    self.datas:initialise();
    self.datas:instantiate();
    self.datas.itemheight = BUTTON_HGT;
    self.datas.selected = 0;
    self.datas.joypadParent = self;
    self.datas.font = UIFont.NewSmall;
    self.datas.doDrawItem = self.drawDatas;
    self.datas.drawBorder = true;
    self:addChild(self.datas);

    self.no = ISButton:new(UI_BORDER_SPACING+1, self:getHeight() - padBottom - BUTTON_HGT, btnWid, BUTTON_HGT, getText("IGUI_UserList_BannedIPs_Close"), self, ISBannedIPViewer.onClick);
    self.no.internal = "CANCEL";
    self.no.anchorTop = false
    self.no.anchorBottom = true
    self.no:initialise();
    self.no:instantiate();
    self.no.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.no);

    local searchHeight = FONT_HGT_SMALL + 4 * 2
    local titleFilterWid = getTextManager():MeasureStringX(UIFont.Large, getText("IGUI_UsersList_Filter"))
    local titleFilter = ISLabel:new(self.width/2 - 75 - titleFilterWid, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT - 1, searchHeight, getText("IGUI_UsersList_Filter"), 1, 1, 1, 1, UIFont.Small, true)
    titleFilter:initialise()
    titleFilter:instantiate()
    self:addChild(titleFilter)

    self.searchEntry = ISTextEntryBox:new("", self.width/2 - 75, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT - 1, 150 , searchHeight)
    self.searchEntry.font = UIFont.Small
    self.searchEntry:setTooltip(getText("IGUI_UsersList_FilterTooltip"))
    self.searchEntry.onTextChange = function() self:doSearch() end
    self.searchEntry.setText = function(_self, str)
        if not str then
            str = "";
        end
        _self.javaObject:SetText(str);
        _self.title = str;

        if OnScreenKeyboard.IsVisible() then
            _self:onTextChange()
        end
    end
    self.searchEntry.prerender = self.searchPrerender
    self.searchEntry:initialise()
    self.searchEntry:instantiate()
    self:addChild(self.searchEntry)

    self.unbanBtn = ISButton:new(self.width - btnWid - UI_BORDER_SPACING,  self:getHeight() - padBottom - BUTTON_HGT, btnWid, BUTTON_HGT, getText("IGUI_UserList_BannedIPs_Unban"), self, ISBannedIPViewer.onClick);
    self.unbanBtn.internal = "UNBAN";
    self.unbanBtn.anchorTop = false
    self.unbanBtn.anchorBottom = true
    self.unbanBtn:initialise();
    self.unbanBtn:instantiate();
    self.unbanBtn.borderColor = {r=1, g=1, b=1, a=0.1};
    self.unbanBtn:setWidthToTitle(btnWid)
    self:addChild(self.unbanBtn);

    self.refreshBtn = ISButton:new(self.unbanBtn.x - btnWid - UI_BORDER_SPACING,  self:getHeight() - padBottom - BUTTON_HGT, btnWid, BUTTON_HGT, getText("IGUI_UserList_BannedIPs_Refresh"), self, ISBannedIPViewer.onClick);
    self.refreshBtn.internal = "REFRESH";
    self.refreshBtn.anchorTop = false
    self.refreshBtn.anchorBottom = true
    self.refreshBtn:initialise();
    self.refreshBtn:instantiate();
    self.refreshBtn.borderColor = {r=1, g=1, b=1, a=0.1};
    self.refreshBtn:setWidthToTitle(btnWid)
    self.refreshBtn:setX(self.unbanBtn.x - self.refreshBtn.width - UI_BORDER_SPACING)
    self:addChild(self.refreshBtn);

    self:getBannedIPs();

end

function ISBannedIPViewer:getBannedIPs()
    getBannedIPs();
end

function ISBannedIPViewer:populateList()
    self.datas:clear();
    self.selectedIP = nil;
    for i=0,self.bannedIPs:size()-1 do
        local bannedIP = self.bannedIPs:get(i);
        local item = {}
        item.bannedIP = bannedIP
        item.richText = ISRichTextLayout:new(self.datas:getWidth() - 200 - 10 * 2)
        item.richText.marginLeft = 0
        item.richText.marginTop = 0
        item.richText.marginRight = 0
        item.richText.marginBottom = 0
        item.richText:setText(bannedIP:getIp())
        item.richText:initialise()
        item.richText:paginate()

        local searchWord = self.searchEntry:getInternalText();
        if searchWord == ''
            or (not (searchWord == '') and (
                string.find(bannedIP:getUsername(), searchWord) ~= nil or
                string.find(bannedIP:getIp(), searchWord) ~= nil)) then
            self.datas:addItem(bannedIP:getUsername(), item);
        end
        if i == 0 then
            self.selectedIP = bannedIP;
        end
    end
end

function ISBannedIPViewer:update()
    self.unbanBtn.enable = false;
    if self.selectedIP then
        self.unbanBtn.enable = true;
    end
end

function ISBannedIPViewer:drawDatas(y, item, alt)
    local a = 0.9;

    local answerHeight = 0;

    self:drawRectBorder(0, (y), self:getWidth(), item.height, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    local bannedIP = item.item.bannedIP

    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), item.height, 0.3, 0.7, 0.35, 0.15);
        self.parent.selectedIP = bannedIP;
    end

    self:drawText(bannedIP:getUsername(), UI_BORDER_SPACING, y + 3, 1, 1, 1, a, self.font);
    self:drawText(bannedIP:getIp() .. "", UI_BORDER_SPACING + COL_1_WIDTH, y + 3, 1, 1, 1, a, self.font);
    item.item.richText:render(UI_BORDER_SPACING + COL_1_WIDTH + COL_2_WIDTH, y + 3, self)
    local messageHeight = math.max(item.item.richText:getHeight() + 3, self.itemheight)
    self:drawText(bannedIP:getReason(), 205, y + 2, 1, 1, 1, a, self.font);

    self:drawRect(COL_1_WIDTH, y, 1, messageHeight,1,self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawRect(COL_1_WIDTH+COL_2_WIDTH, y, 1, messageHeight,1,self.borderColor.r, self.borderColor.g, self.borderColor.b);

    return y + messageHeight + answerHeight;
end

function ISBannedIPViewer:doSearch()
    self:populateList();
end

function ISBannedIPViewer:prerender()
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawText(getText("IGUI_UserList_BannedIPs"), self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_UserList_BannedIPs")) / 2), UI_BORDER_SPACING+1, 1,1,1,1, UIFont.Medium);
    self.datas.doDrawItem = self.drawDatas
end

function ISBannedIPViewer:render()
    self:drawRectBorder(self.datas.x, self.datas.y - BUTTON_HGT, self.datas:getWidth(), BUTTON_HGT + 1, 1, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawRect(self.datas.x, self.datas.y - BUTTON_HGT, self.datas:getWidth(), BUTTON_HGT + 1, self.listHeaderColor.a, self.listHeaderColor.r, self.listHeaderColor.g, self.listHeaderColor.b);
    local x = self.datas.x
    self:drawText("Username", x + UI_BORDER_SPACING, self.datas.y - BUTTON_HGT + 3, 1,1,1,1,UIFont.Small);
    x = x + COL_1_WIDTH
    self:drawRect(x, 1 + self.datas.y - BUTTON_HGT, 1, BUTTON_HGT,1,self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawText("IP", x + UI_BORDER_SPACING, self.datas.y - BUTTON_HGT + 3, 1,1,1,1,UIFont.Small);
    x = x + COL_2_WIDTH
    self:drawRect(x, 1 + self.datas.y - BUTTON_HGT, 1, BUTTON_HGT,1,self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawText("Reason", x + UI_BORDER_SPACING, self.datas.y - BUTTON_HGT + 3, 1,1,1,1,UIFont.Small);
end

function ISBannedIPViewer:onClick(button)
    if button.internal == "CANCEL" then
        self:setVisible(false);
        self:removeFromUIManager();
    end
    if button.internal == "REFRESH" then
        self.datas:clear();
        self.selectedIP = nil;
        self:getBannedIPs();
    end
    if button.internal == "UNBAN" then
        local modal = ISModalDialog:new(0,0, 250, 150,  getText("IGUI_UserList_BannedIPs_UnbanPopup"), true, self, ISBannedIPViewer.onUnbanIP, nil);
        modal:initialise()
        modal:addToUIManager()
    end
end

function ISBannedIPViewer:onUnbanIP(button)
    if button.internal == "YES" then
       banUnbanUserAction("UnBanIPOnly", self.selectedIP:getIp(), "");
    end
end

ISBannedIPViewer.gotBannedIPs = function(bannedIPs)
    if ISBannedIPViewer.instance and ISBannedIPViewer.instance:isVisible() then
        ISBannedIPViewer.instance.bannedIPs = bannedIPs;
        ISBannedIPViewer.instance:populateList();
    end
end

--************************************************************************--
--** ISBannedIPViewer:new
--**
--************************************************************************--
function ISBannedIPViewer:new(x, y, width, height, player)
    local o = {}
    x = getCore():getScreenWidth() / 2 - (width / 2);
    y = getCore():getScreenHeight() / 2 - (height / 2);
    o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.listHeaderColor = {r=0.4, g=0.4, b=0.4, a=0.3};
    o.width = width;
    o.height = height;
    o.player = player;
    o.selectedFaction = nil;
    o.moveWithMouse = true;
    o.bannedIPs = nil;
    ISBannedIPViewer.instance = o;
    return o;
end

Events.ViewBannedIPs.Add(ISBannedIPViewer.gotBannedIPs)
