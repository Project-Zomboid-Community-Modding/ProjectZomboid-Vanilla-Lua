require "ISUI/ISPanel"

ISPlayerStatsSuspicionActivityUI = ISPanel:derive("ISPlayerStatsSuspicionActivityUI");
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local x_Amount =    15 * (getCore():getOptionFontSizeReal() + 10)

function ISPlayerStatsSuspicionActivityUI:initialise()
    ISPanel.initialise(self);
    self:create();
end


function ISPlayerStatsSuspicionActivityUI:setVisible(visible)
    self.javaObject:setVisible(visible);
    for _,v in ipairs(self.windows) do
        v:removeFromUIManager();
    end
end

function ISPlayerStatsSuspicionActivityUI:render()

    self:drawText(self.username .. " suspicion points", self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, self.username .. " suspicion points") / 2), UI_BORDER_SPACING+1, 1,1,1,1, UIFont.Medium);

    self:drawRectBorder(0,0, self.width, self.height,1,self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawRectBorder(self.points.x, self.points.y - self.points.itemheight, self.points:getWidth(), self.points.itemheight + 1, 1, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawRect(self.points.x, self.points.y - self.points.itemheight, self.points:getWidth(), self.points.itemheight + 1, self.listHeaderColor.a, self.listHeaderColor.r, self.listHeaderColor.g, self.listHeaderColor.b);
    self:drawRect(self.points.x + x_Amount, 1 + self.points.y - self.points.itemheight, 1, self.points.itemheight,1,self.borderColor.r, self.borderColor.g, self.borderColor.b);

    self:drawText(getText("IGUI_PlayerStats_Type"), self.points.x + 10, self.points.y - FONT_HGT_SMALL-3, 1, 1, 1, 1, UIFont.Small);
    self:drawText(getText("IGUI_PlayerStats_Amount"), self.points.x + x_Amount + 10, self.points.y - FONT_HGT_SMALL-3, 1, 1, 1, 1, UIFont.Small);
end

function ISPlayerStatsSuspicionActivityUI:create()

    self.points = ISScrollingListBox:new(UI_BORDER_SPACING + 1, FONT_HGT_MEDIUM + UI_BORDER_SPACING * 2 + 1 + BUTTON_HGT, self.width - (UI_BORDER_SPACING + 1) * 2, self.height - FONT_HGT_MEDIUM-UI_BORDER_SPACING * 4 - 2 - BUTTON_HGT * 2);
    self.points:initialise();
    self.points:instantiate();
    self.points.itemheight = BUTTON_HGT;
    self.points.selected = 0;
    self.points.joypadParent = self;
    self.points.font = UIFont.NewSmall;
    self.points.doDrawItem = self.drawLog;
    self.points.drawBorder = true;
    self:addChild(self.points);

    local btnWid = 150

    self.ok = ISButton:new(UI_BORDER_SPACING + 1, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT - 1, btnWid, BUTTON_HGT, getText("UI_Ok"), self, ISPlayerStatsSuspicionActivityUI.onOptionMouseDown);
    self.ok.internal = "OK";
    self.ok:initialise();
    self.ok:instantiate();
    self.ok.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.ok);

    self:populate();
end

function ISPlayerStatsSuspicionActivityUI:drawLog(y, item, alt)
    local a = 0.9;

    self:drawRectBorder(0, (y), self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    self:drawRect(x_Amount, y-1, 1, self.itemheight,1,self.borderColor.r, self.borderColor.g, self.borderColor.b);

    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15);
    end

    self:drawText(item.item.type, UI_BORDER_SPACING, y + 3, 1, 1, 1, a, self.font);
    self:drawText(item.item.amount, x_Amount + UI_BORDER_SPACING, y + 3, 1, 1, 1, a, self.font);

    return y + self.itemheight;
end

ISPlayerStatsSuspicionActivityUI.populate = function(self)
    for _,v in ipairs(self.suspicionActivity) do
        self.points:addItem(self.username, v);
    end
end

function ISPlayerStatsSuspicionActivityUI:onOptionMouseDown(button, x, y)
    if button.internal == "OK" then
        self:setVisible(false);
        self:removeFromUIManager();
    end
end

function ISPlayerStatsSuspicionActivityUI:new(x, y, width, height, target, onclick, username, suspicionActivity)
    local o = {};
    o = ISPanel:new(x, y, width, height);
    setmetatable(o, self);
    self.__index = self;
    o.variableColor={r=0.9, g=0.55, b=0.1, a=1};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.target = target;
    o.onclick = onclick;
    o.username = username;
    o.suspicionActivity = suspicionActivity;
    o.zOffsetSmallFont = 25;
    o.moveWithMouse = true;
    o.listHeaderColor = {r=0.4, g=0.4, b=0.4, a=0.3};
    ISPlayerStatsSuspicionActivityUI.instance = o;
    o.windows = {};
    return o;
end

ISPlayerStatsSuspicionActivityUI.receiveSuspicionActivity = function(username, userLog, suspiciousActivity)
    if not ISPlayerStatsSuspicionActivityUI.instance or username ~= ISPlayerStatsSuspicionActivityUI.instance.username then
        return;
    end

    ISPlayerStatsSuspicionActivityUI.instance.suspicionActivity = {};

    if suspiciousActivity then
        for k,v in pairs(suspiciousActivity) do
            table.insert(ISPlayerStatsSuspicionActivityUI.instance.suspicionActivity, {type = k, amount = v});
        end
    end

    ISPlayerStatsSuspicionActivityUI.instance.points:clear();
    for _,v in ipairs(ISPlayerStatsSuspicionActivityUI.instance.suspicionActivity) do
        ISPlayerStatsSuspicionActivityUI.instance.points:addItem(ISPlayerStatsSuspicionActivityUI.instance.username, v);
    end
end

Events.OnReceiveUserlog.Add(ISPlayerStatsSuspicionActivityUI.receiveSuspicionActivity);
