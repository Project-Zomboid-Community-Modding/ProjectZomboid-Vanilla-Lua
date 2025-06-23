--***********************************************************
--**              	  ROBERT JOHNSON                       **
--***********************************************************

ISAdminTicketsUI = ISPanel:derive("ISAdminTicketsUI");
ISAdminTicketsUI.messages = {};

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local FONT_HGT_LARGE = getTextManager():getFontHeight(UIFont.Large)

local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

local COL_1_WIDTH = 200
local COL_2_WIDTH = 50
local COL_3_WIDTH = 75

--************************************************************************--
--** ISAdminTicketsUI:initialise
--**
--************************************************************************--

function ISAdminTicketsUI:initialise()
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

    self.no = ISButton:new(UI_BORDER_SPACING+1, self:getHeight() - padBottom - BUTTON_HGT, btnWid, BUTTON_HGT, getText("UI_Cancel"), self, ISAdminTicketsUI.onClick);
    self.no.internal = "CANCEL";
    self.no.anchorTop = false
    self.no.anchorBottom = true
    self.no:initialise();
    self.no:instantiate();
    self.no.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.no);

    self.answerTicketBtn = ISButton:new(self:getWidth() - btnWid - UI_BORDER_SPACING+1,  self:getHeight() - padBottom - BUTTON_HGT, btnWid, BUTTON_HGT, getText("IGUI_TicketUI_AnswerTicket"), self, ISAdminTicketsUI.onClick);
    self.answerTicketBtn.internal = "ANSWERTICKET";
    self.answerTicketBtn.anchorTop = false
    self.answerTicketBtn.anchorBottom = true
    self.answerTicketBtn:initialise();
    self.answerTicketBtn:instantiate();
    self.answerTicketBtn.borderColor = {r=1, g=1, b=1, a=0.1};
    self.answerTicketBtn:setWidthToTitle(btnWid)
    self.answerTicketBtn:setX(self.width - self.answerTicketBtn.width - UI_BORDER_SPACING - 1)
    self:addChild(self.answerTicketBtn);

    self.removeBtn = ISButton:new(self.answerTicketBtn.x - btnWid - UI_BORDER_SPACING,  self:getHeight() - padBottom - BUTTON_HGT, btnWid, BUTTON_HGT, getText("IGUI_TicketUI_RemoveTicket"), self, ISAdminTicketsUI.onClick);
    self.removeBtn.internal = "REMOVE";
    self.removeBtn.anchorTop = false
    self.removeBtn.anchorBottom = true
    self.removeBtn:initialise();
    self.removeBtn:instantiate();
    self.removeBtn.borderColor = {r=1, g=1, b=1, a=0.1};
    self.removeBtn:setWidthToTitle(btnWid)
    self.removeBtn:setX(self.answerTicketBtn.x - self.removeBtn.width - UI_BORDER_SPACING)
    self:addChild(self.removeBtn);

    self.refreshBtn = ISButton:new(self.removeBtn.x - btnWid - UI_BORDER_SPACING,  self:getHeight() - padBottom - BUTTON_HGT, btnWid, BUTTON_HGT, getText("IGUI_DbViewer_Refresh"), self, ISAdminTicketsUI.onClick);
    self.refreshBtn.internal = "REFRESH";
    self.refreshBtn.anchorTop = false
    self.refreshBtn.anchorBottom = true
    self.refreshBtn:initialise();
    self.refreshBtn:instantiate();
    self.refreshBtn.borderColor = {r=1, g=1, b=1, a=0.1};
    self.refreshBtn:setWidthToTitle(btnWid)
    self.refreshBtn:setX(self.removeBtn.x - self.refreshBtn.width - UI_BORDER_SPACING)
    self:addChild(self.refreshBtn);

    self:getTickets();

end

function ISAdminTicketsUI:getTickets()
    getTickets(nil);
end

function ISAdminTicketsUI:populateList()
    self.datas:clear();
    self.selectedTicket = nil;
    for i=0,self.tickets:size()-1 do
        local ticket = self.tickets:get(i);
        local item = {}
        item.ticket = ticket

        item.richText = ISRichTextLayout:new(self.datas:getWidth() - 200 - 10 * 2)
        item.richText.marginLeft = 0
        item.richText.marginTop = 0
        item.richText.marginRight = 0
        item.richText.marginBottom = 0
        item.richText:setText(ticket:getMessage())
        item.richText:initialise()
        item.richText:paginate()

        if ticket:getAnswer() then
            item.richText2 = ISRichTextLayout:new(self.datas:getWidth() - 20 - 10 * 2)
            item.richText2.marginLeft = 0
            item.richText2.marginTop = 0
            item.richText2.marginRight = 0
            item.richText2.marginBottom = 0
            item.richText2:setText(ticket:getAnswer():getAuthor() .. ": " .. ticket:getAnswer():getMessage())
            item.richText2:initialise()
            item.richText2:paginate()
        end

        self.datas:addItem(ticket:getAuthor(), item);
        if i == 0 then
            self.selectedTicket = ticket;
        end
    end
end

function ISAdminTicketsUI:update()
    self.answerTicketBtn.enable = false;
    self.removeBtn.enable = false;
    if self.selectedTicket then
        self.removeBtn.enable = true;
        if not self.selectedTicket:getAnswer() then
            self.answerTicketBtn.enable = true;
            self.removeBtn.enable = false;
        end
    end
end

function ISAdminTicketsUI:drawDatas(y, item, alt)
    local a = 0.9;

    local answerHeight = 0;


--    self.parent.selectedTicket = nil;
    self:drawRectBorder(0, (y), self:getWidth(), item.height, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);



    local ticket = item.item.ticket

    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), item.height, 0.3, 0.7, 0.35, 0.15);
        self.parent.selectedTicket = ticket;
    end

    self:drawText(ticket:getAuthor(), UI_BORDER_SPACING, y + 3, 1, 1, 1, a, self.font);
    self:drawText(ticket:getTicketID() .. "", UI_BORDER_SPACING + COL_1_WIDTH, y + 3, 1, 1, 1, a, self.font);
    self:drawText(tostring(ticket:isViewed()) .. "", UI_BORDER_SPACING + COL_1_WIDTH + COL_2_WIDTH, y + 3, 1, 1, 1, a, self.font);
    item.item.richText:render(UI_BORDER_SPACING + COL_1_WIDTH + COL_2_WIDTH + COL_3_WIDTH, y + 3, self)
    local messageHeight = math.max(item.item.richText:getHeight() + 3, self.itemheight)
--    self:drawText(ticket:getMessage(), 205, y + 2, 1, 1, 1, a, self.font);

    if ticket:getAnswer() then
        answerHeight = math.max(item.item.richText2:getHeight() + 6, self.itemheight)
--        self:drawText("Answer", 30, y + 2 + messageHeight, 1, 1, 1, a, self.font);
        item.item.richText2:render(UI_BORDER_SPACING*2, y + messageHeight+3, self)
--        self:drawText(item.item:getAnswer():getAuthor() .. ": " .. item.item:getAnswer():getMessage(), 100, y + self.itemheight +  2, 1, 1, 1, a, self.font);
        self:drawRect(0, (y + messageHeight), self:getWidth(), answerHeight, 0.15, 1, 1, 1);
    end

    self:drawRect(COL_1_WIDTH, y, 1, messageHeight,1,self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawRect(COL_1_WIDTH+COL_2_WIDTH, y, 1, messageHeight,1,self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawRect(COL_1_WIDTH+COL_2_WIDTH+COL_3_WIDTH, y, 1, messageHeight,1,self.borderColor.r, self.borderColor.g, self.borderColor.b);

    return y + messageHeight + answerHeight;
end

function ISAdminTicketsUI:prerender()
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawText(getText("IGUI_AdminPanel_SeeTickets"), self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_AdminPanel_SeeTickets")) / 2), UI_BORDER_SPACING+1, 1,1,1,1, UIFont.Medium);
    self.datas.doDrawItem = self.drawDatas
end

function ISAdminTicketsUI:render()
    self:drawRectBorder(self.datas.x, self.datas.y - BUTTON_HGT, self.datas:getWidth(), BUTTON_HGT + 1, 1, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawRect(self.datas.x, self.datas.y - BUTTON_HGT, self.datas:getWidth(), BUTTON_HGT + 1, self.listHeaderColor.a, self.listHeaderColor.r, self.listHeaderColor.g, self.listHeaderColor.b);



    local x = self.datas.x


    self:drawText("Author", x + UI_BORDER_SPACING, self.datas.y - BUTTON_HGT + 3, 1,1,1,1,UIFont.Small);
    x = x + COL_1_WIDTH
    self:drawRect(x, 1 + self.datas.y - BUTTON_HGT, 1, BUTTON_HGT,1,self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawText("ID", x + UI_BORDER_SPACING, self.datas.y - BUTTON_HGT + 3, 1,1,1,1,UIFont.Small);
    x = x + COL_2_WIDTH
    self:drawRect(x, 1 + self.datas.y - BUTTON_HGT, 1, BUTTON_HGT,1,self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawText("Viewed", x + UI_BORDER_SPACING, self.datas.y - BUTTON_HGT + 3, 1,1,1,1,UIFont.Small);
    x = x + COL_3_WIDTH
    self:drawRect(x, 1 + self.datas.y - BUTTON_HGT, 1, BUTTON_HGT,1,self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawText("Message", x + UI_BORDER_SPACING, self.datas.y - BUTTON_HGT + 3, 1,1,1,1,UIFont.Small);
end

function ISAdminTicketsUI:onClick(button)
    if button.internal == "CANCEL" then
        self:setVisible(false);
        self:removeFromUIManager();
    end
    if button.internal == "ANSWERTICKET" then
        local inset = 2
        local titleBarHeight = 16
        local height = titleBarHeight + 8 + FONT_HGT_SMALL + 8 + FONT_HGT_MEDIUM * 5 + inset * 2 + BUTTON_HGT + 10 * 2
        height = math.max(height, 200)
        local modal = ISTextBox:new(self.x + 50, 200, 400, height, getText("IGUI_TicketUI_AnswerTicket"), "", self, ISAdminTicketsUI.onAnswerTicket);
        modal:setNumberOfLines(5)
        modal:setMaxLines(5)
        modal:setMultipleLine(true)
        modal.changedName = button.changedName;
        modal:initialise();
        modal.ticketID = self.selectedTicket:getTicketID();
        modal:addToUIManager();
        if not self.selectedTicket:isViewed() then
            self.selectedTicket:setViewed(true);
            viewedTicket(self.player:getUsername(), self.selectedTicket:getTicketID());
        end
    end
    if button.internal == "REFRESH" then
        self.datas:clear();
        self.selectedTicket = nil;
        self:getTickets();
    end
    if button.internal == "REMOVE" then
        local modal = ISModalDialog:new(0,0, 250, 150,  getText("IGUI_TicketUI_RemoveTicketPopup"), true, self, ISAdminTicketsUI.onRemoveTicket, nil);
        modal:initialise()
        modal:addToUIManager()
    end
end

function ISAdminTicketsUI:onRemoveTicket(button)
    if button.internal == "YES" then
       removeTicket(self.selectedTicket:getTicketID());
    end
end

ISAdminTicketsUI.gotTickets = function(tickets)
    if ISAdminTicketsUI.instance and ISAdminTicketsUI.instance:isVisible() then
        ISAdminTicketsUI.instance.tickets = tickets;
        ISAdminTicketsUI.instance:populateList();
    end
end

function ISAdminTicketsUI:onAnswerTicket(button)
    if button.internal == "OK" then
        if (button.parent.entry:getText() and button.parent.entry:getText() ~= "")then
            addTicket(self.player:getUsername(), button.parent.entry:getText(),button.parent.ticketID);
        end
    end
end

--************************************************************************--
--** ISAdminTicketsUI:new
--**
--************************************************************************--
function ISAdminTicketsUI:new(x, y, width, height, player)
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
    o.tickets = nil;
    ISAdminTicketsUI.instance = o;
    return o;
end

Events.ViewTickets.Add(ISAdminTicketsUI.gotTickets)
