ISWarManagerUI = ISPanel:derive("ISWarManagerUI");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

function ISWarManagerUI:initialise()
    ISPanel.initialise(self);
    local btnWid = 100

    self.acceptBtn = ISButton:new(UI_BORDER_SPACING, self:getHeight() - UI_BORDER_SPACING*2 - BUTTON_HGT*2, btnWid, BUTTON_HGT, getText("IGUI_WarManager_AcceptWar"), self, ISWarManagerUI.onClick);
    self.acceptBtn.internal = "ACCEPT";
    self.acceptBtn.anchorTop = false
    self.acceptBtn.anchorBottom = true
    self.acceptBtn:initialise();
    self.acceptBtn:instantiate();
    self.acceptBtn.borderColor = self.borderColor;
    self:addChild(self.acceptBtn);
    self.acceptBtn:setVisible(false);
    self.acceptBtn.enable = false;

    self.refuseBtn = ISButton:new(UI_BORDER_SPACING, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT, btnWid, BUTTON_HGT, getText("IGUI_WarManager_RefuseWar"), self, ISWarManagerUI.onClick);
    self.refuseBtn.internal = "REFUSE";
    self.refuseBtn.anchorTop = false
    self.refuseBtn.anchorBottom = true
    self.refuseBtn:initialise();
    self.refuseBtn:instantiate();
    self.refuseBtn.borderColor = self.borderColor;
    self:addChild(self.refuseBtn);
    self.refuseBtn:setVisible(false);
    self.refuseBtn.enable = false;

    self.endBtn = ISButton:new(self.width - btnWid - UI_BORDER_SPACING, self:getHeight() - UI_BORDER_SPACING*2 - BUTTON_HGT*2, btnWid, BUTTON_HGT, getText("IGUI_WarManager_EndWar"), self, ISWarManagerUI.onClick);
    self.endBtn.internal = "END";
    self.endBtn.anchorTop = false
    self.endBtn.anchorBottom = true
    self.endBtn:initialise();
    self.endBtn:instantiate();
    self.endBtn.borderColor = self.borderColor;
    self:addChild(self.endBtn);
    self.endBtn:setVisible(false);
    self.endBtn.enable = false;

    self.cancelBtn = ISButton:new(self.width/2 - btnWid/2,self:getHeight() - UI_BORDER_SPACING*2 - BUTTON_HGT*2, btnWid, BUTTON_HGT, getText("IGUI_WarManager_CancelWar"), self, ISWarManagerUI.onClick);
    self.cancelBtn.internal = "CANCEL";
    self.cancelBtn.anchorTop = false
    self.cancelBtn.anchorBottom = true
    self.cancelBtn:initialise();
    self.cancelBtn:instantiate();
    self.cancelBtn.borderColor = self.borderColor;
    self:addChild(self.cancelBtn);
    self.cancelBtn:setVisible(false);
    self.cancelBtn.enable = false;

    self.closeBtn = ISButton:new(self.width/2 - btnWid/2,self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT, btnWid, BUTTON_HGT, getText("IGUI_RolesList_Close"), self, ISWarManagerUI.onClick);
    self.closeBtn.internal = "CLOSE";
    self.closeBtn.anchorTop = false
    self.closeBtn.anchorBottom = true
    self.closeBtn:initialise();
    self.closeBtn:instantiate();
    self.closeBtn.borderColor = self.borderColor;
    self:addChild(self.closeBtn);

    self.datas = ISScrollingListBox:new(UI_BORDER_SPACING, FONT_HGT_MEDIUM + UI_BORDER_SPACING * 2, self.width - UI_BORDER_SPACING * 2, self.itemheight * 3);
    self.datas:initialise();
    self.datas:instantiate();
    self.datas.itemheight = self.itemheight
    self.datas.selected = 0;
    self.datas.joypadParent = self;
    self.datas.font = UIFont.Small;
    self.datas.doDrawItem = self.drawDatas;
    self.datas.onmousedown = self.onSelectWar;
    self.datas.drawBorder = true;
    self:addChild(self.datas);

    self:populateList();
end

function ISWarManagerUI:populateList()
    self.datas:clear();
    local wars = getWars();
    if wars:size() > 3 then
        self.scrollBarSpacing = UI_BORDER_SPACING * 2
    else
        self.scrollBarSpacing = UI_BORDER_SPACING
    end
    for i=0,wars:size()-1 do
        local war = wars:get(i);
        self.datas:addItem(war);
    end
end

function ISWarManagerUI:drawTextRecordWidth(text, x, y, r, g, b, a, font)
    local textWid = getTextManager():MeasureStringX(font, text)
    local textPadX = 8
    self.parent.minListWidth = math.max(self.parent.minListWidth, x + textWid + textPadX)
    self:drawText(text, x, y, r, g, b, a, font)
end

function ISWarManagerUI:drawDatas(y, item, alt)
    if ISWarManagerUI.instance then
        local a = 0.9;

        self:drawRectBorder(0, (y), self:getWidth(), self.itemheight, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

        if self.selected == item.index then
            self:drawRect(0, (y), self:getWidth(), self.itemheight, 0.3, 0.7, 0.35, 0.15);
        end

        local text1 = getText("IGUI_WarManager_Attacker")
        local text2 = getText("IGUI_WarManager_Defender")
        local state = item.text:getState():name()

        local textWid1 = getTextManager():MeasureStringX(UIFont.Small, text1)
        local textWid2 = getTextManager():MeasureStringX(UIFont.Small, text2)
        local textWid3 = getTextManager():MeasureStringX(UIFont.Small, state)
        local textWid = math.max(textWid1, textWid2, textWid3)

        local labelR,labelG,labelB = 0.66,0.66,0.66
        self.drawTextRecordWidth = self.parent.drawTextRecordWidth

        local attacker = item.text:getAttacker()
        local textX = 8
        local textY = y + (item.height - FONT_HGT_SMALL * 3) / 2
        local textGap = 8
        self:drawText(text1, textX, textY, labelR, labelG, labelB, 1, UIFont.Small);
        if ISWarManagerUI.instance.player:getUsername() == attacker then
            self:drawTextRecordWidth(getText("IGUI_WarManager_You"), textX + textWid + textGap, textY, 0, 1, 0, 1, UIFont.Small);
        else
            self:drawTextRecordWidth(attacker, textX + textWid + textGap, textY, 1, 0, 0, 1, UIFont.Small);
        end
        textY = textY + FONT_HGT_SMALL

        local defender = item.text:getDefender()
        self:drawText(text2, textX, textY, labelR, labelG, labelB, 1, UIFont.Small);
        if ISWarManagerUI.instance.player:getUsername() == defender then
            self:drawTextRecordWidth(getText("IGUI_WarManager_You"), textX + textWid2 + textGap, textY, 0, 1, 0, 1, UIFont.Small);
        else
            self:drawTextRecordWidth(defender, textX + textWid + textGap, textY, 1, 0, 0, 1, UIFont.Small);
        end
        textY = textY + FONT_HGT_SMALL

        self:drawText(state, textX, textY, labelR, labelG, labelB, 1, UIFont.SMALL);
        local time = ""
        if state == 'Claimed' then
            time = getText("IGUI_WarManager_TimeToAccept", item.text:getTime())
        elseif state == 'Accepted' then
            time = getText("IGUI_WarManager_TimeToStart", item.text:getTime())
        elseif state == 'Refused' or state == 'Canceled' or state == 'Started' or state == 'Blocked' then
            time = getText("IGUI_WarManager_TimeToEnd", item.text:getTime())
        end
        self:drawTextRecordWidth(time, textX + textWid + textGap, textY, 1, 1, 1, 1, UIFont.Small);
    end
    return y + self.itemheight;
end

function ISWarManagerUI:onSelectWar(_item)
    local selectedWar = ISWarManagerUI.instance.datas.items[ISWarManagerUI.instance.datas.selected]

    if selectedWar then

        ISWarManagerUI.instance.acceptBtn:setVisible(false)
        ISWarManagerUI.instance.acceptBtn.enable = false

        ISWarManagerUI.instance.refuseBtn:setVisible(false)
        ISWarManagerUI.instance.refuseBtn.enable = false

        ISWarManagerUI.instance.endBtn:setVisible(false)
        ISWarManagerUI.instance.endBtn.enable = false

        ISWarManagerUI.instance.cancelBtn:setVisible(false)
        ISWarManagerUI.instance.cancelBtn.enable = false

        if selectedWar.text:getState():name() == "Claimed" and selectedWar.text:getDefender() == getPlayer():getUsername() then
            ISWarManagerUI.instance.acceptBtn:setVisible(true)
            ISWarManagerUI.instance.acceptBtn.enable = true

            ISWarManagerUI.instance.refuseBtn:setVisible(true)
            ISWarManagerUI.instance.refuseBtn.enable = true
        end

        if selectedWar.text:getState():name() == "Claimed" and selectedWar.text:getAttacker() == getPlayer():getUsername() then
            ISWarManagerUI.instance.cancelBtn:setVisible(true)
            ISWarManagerUI.instance.cancelBtn.enable = true
        end

        if getPlayer():getRole() and getPlayer():getRole():hasCapability(Capability.CanGoInsideSafehouses) then
            ISWarManagerUI.instance.endBtn:setVisible(true)
            ISWarManagerUI.instance.endBtn.enable = true
        end
    end
end

function ISWarManagerUI:prerender()
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawText(getText("IGUI_AdminPanel_SeeWars"), self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_AdminPanel_SeeWars")) / 2), UI_BORDER_SPACING+1, 1,1,1,1, UIFont.Medium);
    self.minListWidth = 0 -- window expands to contents
end

function ISWarManagerUI:update()
    ISPanel.update(self)
    local minListWidth = self.minListWidth or 0
    if self.datas:isVScrollBarVisible() then
        minListWidth = minListWidth + self.datas.vscroll.width
    end
    if minListWidth > self.datas.width then
        self.datas:setWidth(minListWidth)
        self:shrinkWrap(UI_BORDER_SPACING, UI_BORDER_SPACING, nil)
    end
end

function ISWarManagerUI:onClick(button)
    if button.internal == "ACCEPT" then
        local selecwartedWar = ISWarManagerUI.instance.datas.items[ISWarManagerUI.instance.datas.selected].text
        sendWarManagerUpdate(selecwartedWar:getOnlineID(), selecwartedWar:getAttacker(), State.Accepted);
    end
    if button.internal == "REFUSE" then
        local selecwartedWar = ISWarManagerUI.instance.datas.items[ISWarManagerUI.instance.datas.selected].text
        sendWarManagerUpdate(selecwartedWar:getOnlineID(), selecwartedWar:getAttacker(), State.Refused);
    end
    if button.internal == "CANCEL" then
        local selecwartedWar = ISWarManagerUI.instance.datas.items[ISWarManagerUI.instance.datas.selected].text
        sendWarManagerUpdate(selecwartedWar:getOnlineID(), selecwartedWar:getAttacker(), State.Canceled);
    end
    if button.internal == "END" then
        local selecwartedWar = ISWarManagerUI.instance.datas.items[ISWarManagerUI.instance.datas.selected].text
        sendWarManagerUpdate(selecwartedWar:getOnlineID(), selecwartedWar:getAttacker(), State.Ended);
    end
    if button.internal == "CLOSE" then
        ISWarManagerUI.instance:closeModal()
        return;
    end
end

function ISWarManagerUI:closeModal()
    self:setVisible(false);
    self:removeFromUIManager();
    ISWarManagerUI.instance = nil
end

function ISWarManagerUI:new(x, y, width, height, player)
    local itemheight = FONT_HGT_SMALL * 3
    height = UI_BORDER_SPACING * 5 + FONT_HGT_MEDIUM + itemheight * 3 + BUTTON_HGT * 2
    x = getCore():getScreenWidth() / 2 - (width / 2);
    y = getCore():getScreenHeight() / 2 - (height / 2);
    local o = ISPanel.new(self, x, y, width, height);
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=8};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.width = width;
    o.height = height;
    o.player = player;
    o.moveWithMouse = true;
    o.scrollBarSpacing = UI_BORDER_SPACING
    o.itemheight = itemheight
    ISWarManagerUI.instance = o;
    return o;
end

ISWarManagerUI.OnWarUpdate = function()
    if ISWarManagerUI.instance then
        ISWarManagerUI.instance:populateList()
        ISWarManagerUI.instance:onSelectWar()
    end
end

Events.OnWarUpdate.Add(ISWarManagerUI.OnWarUpdate)
