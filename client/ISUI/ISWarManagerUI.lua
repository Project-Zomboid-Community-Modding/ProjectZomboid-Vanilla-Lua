---
--- Created by Iurii.
--- DateTime: 3/6/2024 3:46 AM
---

ISWarManagerUI = ISPanel:derive("ISWarManagerUI");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local prevWarNum = 0


--************************************************************************--
--** ISWarManagerUI:initialise
--**
--************************************************************************--

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

function ISWarManagerUI:drawDatas(y, item, alt)
    if ISWarManagerUI.instance then
        local a = 0.9;

        self:drawRectBorder(0, (y), self:getWidth(), self.itemheight, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

        if self.selected == item.index then
            self:drawRect(0, (y), self:getWidth(), self.itemheight, 0.3, 0.7, 0.35, 0.15);
        end

        local attacker = item.text:getAttacker()
        self:drawText(getText("IGUI_WarManager_Attacker"), UI_BORDER_SPACING, y + UI_BORDER_SPACING/2, 1, 1, 1, 1, UIFont.Small);
        if ISWarManagerUI.instance.player:getUsername() == attacker then
            self:drawText(getText("IGUI_WarManager_You"), UI_BORDER_SPACING, y + FONT_HGT_SMALL + UI_BORDER_SPACING/2, 0, 1, 0, 1, UIFont.Medium);
        else
            self:drawText(attacker, UI_BORDER_SPACING, y + FONT_HGT_SMALL + UI_BORDER_SPACING/2, 1, 0, 0, 1, UIFont.Medium);
        end

        local defender = item.text:getDefender()
        self:drawText(getText("IGUI_WarManager_Defender"), self.width - (getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_WarManager_Defender"))) - ISWarManagerUI.instance.scrollBarSpacing, y + UI_BORDER_SPACING/2, 1, 1, 1, 1, UIFont.Small);
        if ISWarManagerUI.instance.player:getUsername() == defender then
            self:drawText(getText("IGUI_WarManager_You"), self.width - (getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_WarManager_You"))) - ISWarManagerUI.instance.scrollBarSpacing, y + FONT_HGT_SMALL + UI_BORDER_SPACING/2, 0, 1, 0, 1, UIFont.Medium);
        else
            self:drawText(defender, self.width - (getTextManager():MeasureStringX(UIFont.Medium, defender)) - ISWarManagerUI.instance.scrollBarSpacing, y + FONT_HGT_SMALL  + UI_BORDER_SPACING/2, 1, 0, 0, 1, UIFont.Medium);
        end

        local state = item.text:getState():name()
        self:drawText(state, self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, state) / 2), y + UI_BORDER_SPACING/2, 1, 1, 1, 1, UIFont.Medium);
        local time = ""

        if state == 'Claimed' then
            time = getText("IGUI_WarManager_TimeToAccept", item.text:getTime())
        elseif state == 'Accepted' then
            time = getText("IGUI_WarManager_TimeToStart", item.text:getTime())
        elseif state == 'Refused' or state == 'Canceled' or state == 'Started' or state == 'Blocked' then
            time = getText("IGUI_WarManager_TimeToEnd", item.text:getTime())
        end

        self:drawText(time, self.width/2 - (getTextManager():MeasureStringX(UIFont.Small, time) / 2), y + FONT_HGT_MEDIUM + UI_BORDER_SPACING / 2, 1, 1, 1, 1, UIFont.Small);
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

--************************************************************************--
--** ISWarManagerUI:new
--**
--************************************************************************--
function ISWarManagerUI:new(x, y, width, height, player)
    local o = {}
    local itemheight = FONT_HGT_SMALL + UI_BORDER_SPACING + FONT_HGT_MEDIUM
    height = UI_BORDER_SPACING * 5 + FONT_HGT_MEDIUM + itemheight * 3 + BUTTON_HGT * 2
    x = getCore():getScreenWidth() / 2 - (width / 2);
    y = getCore():getScreenHeight() / 2 - (height / 2);
    o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
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
