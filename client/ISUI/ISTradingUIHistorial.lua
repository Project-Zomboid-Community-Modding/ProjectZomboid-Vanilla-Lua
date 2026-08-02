ISTradingUIHistorical = ISPanelJoypad:derive("ISTradingUIHistorical");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

function ISTradingUIHistorical:initialise()
    ISPanelJoypad.initialise(self);
    local btnWid = 100
    local btnHgt = BUTTON_HGT
    local padBottom = UI_BORDER_SPACING

    self.list = ISScrollingListBox:new(UI_BORDER_SPACING, 5 + FONT_HGT_MEDIUM + 5, self.width - UI_BORDER_SPACING * 2, FONT_HGT_SMALL * 10);
    self.list:initialise();
    self.list:instantiate();
    self.list.itemheight = FONT_HGT_SMALL;
    self.list.selected = 0;
    self.list.joypadParent = self;
    self.list.font = UIFont.NewSmall;
    self.list.doDrawItem = self.drawList;
    self.list.drawBorder = true;
    self.list.stealJoypadFocusFromParent = false;
    self:addChild(self.list);

    self.no = ISButton:new(self:getWidth() - btnWid - UI_BORDER_SPACING, self.list:getBottom() + 5, btnWid, btnHgt, getText("IGUI_CraftUI_Close"), self, ISTradingUIHistorical.onClick);
    self.no.internal = "OK";
    self.no:initialise();
    self.no:instantiate();
    self.no.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.no);

    self:setHeight(self.no:getBottom() + UI_BORDER_SPACING)

    self:populateList();
end

function ISTradingUIHistorical:populateList(list)
    if list then
        self.msgList = list;
    end
    self.list:clear();

    for i,v in ipairs(self.msgList) do
       self.list:addItem(v.message, v);
    end
end

function ISTradingUIHistorical:drawList(y, item, alt)
    local a = 0.9;
    if self.selected == item.index then
        self:drawSelection(0, y, self:getWidth(), item.height-1)
    end
    self:drawRect(0, y + self.itemheight - 1, self:getWidth(), 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    local r,g,b = 1,1,1;
    if item.item.add then
        r,g,b = 0.2,1,0.2;
    elseif item.item.remove then
        r,g,b = 1,0.2,0.2;
    end
    self:drawText(item.item.message, 10, y, r, g, b, a, self.font);
    return y + self.itemheight;
end

function ISTradingUIHistorical:render()
end

function ISTradingUIHistorical:prerender()
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawTextCentre(getText("IGUI_ISTradingUIHistorical_Title", self.otherPlayer:getDisplayName()), self.width / 2, 5, 1,1,1,1, UIFont.Medium);
end

function ISTradingUIHistorical:onClick(button)
    if button.internal == "OK" then
        self:close()
    end
end

function ISTradingUIHistorical:close()
    self:setVisible(false)
    self:removeFromUIManager()
    if self.joyfocus and self.joyfocus.focus == self then
        self.joyfocus.focus = self.prevFocus
        updateJoypadFocus(self.joyfocus)
    end
end

function ISTradingUIHistorical:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
    self:setISButtonForB(self.no)
end

function ISTradingUIHistorical:onLoseJoypadFocus(joypadData)
    ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
    self:clearJoypadFocus()
    self.no:clearJoypadButton()
end

function ISTradingUIHistorical:onJoypadDirUp(joypadData)
    self.list:onJoypadDirUp(joypadData)
end

function ISTradingUIHistorical:onJoypadDirDown(joypadData)
    self.list:onJoypadDirDown(joypadData)
end

function ISTradingUIHistorical:new(x, y, width, height, list, otherPlayer)
    local o = ISPanelJoypad.new(self, x, y, width, height);
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.width = width;
    o.height = height;
    o.msgList = list;
    o.otherPlayer = otherPlayer;
    o.moveWithMouse = true;
    return o;
end
