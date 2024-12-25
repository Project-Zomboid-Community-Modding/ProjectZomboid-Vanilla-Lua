--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 21/09/16
-- Time: 10:19
-- To change this template use File | Settings | File Templates.
--

--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "ISUI/ISPanel"

ISPlayerStatsChooseAccessLevelUI = ISPanel:derive("ISPlayerStatsChooseAccessLevelUI");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

--************************************************************************--
--** ISPanel:initialise
--**
--************************************************************************--

function ISPlayerStatsChooseAccessLevelUI:initialise()
    ISPanel.initialise(self);
    self:create();
end


function ISPlayerStatsChooseAccessLevelUI:setVisible(visible)
    --    self.parent:setVisible(visible);
    self.javaObject:setVisible(visible);
end

function ISPlayerStatsChooseAccessLevelUI:render()
    self:drawText(getText("IGUI_PlayerStats_ChangeAccessTitle"), self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_PlayerStats_ChangeAccessTitle")) / 2), UI_BORDER_SPACING+1, 1,1,1,1, UIFont.Medium);
end

function ISPlayerStatsChooseAccessLevelUI:create()
--    for i=0,ProfessionFactory.getProfessions():size()-1 do
--        local prof = ProfessionFactory.getProfessions():get(i);
--        if self.chr:getDescriptor():getProfession() and prof:getType() ~= self.chr:getDescriptor():getProfession() then
--            table.insert(self.comboList, prof);
--        end
--    end

    if self.admin:getRole():haveCapability(Capability.ModifyDB) then
        local roles = getRoles()
        for i=0,roles:size()-1 do
            local role = roles:get(i);
            self.datas:addItem(role:getName(), role);
            if role:rightLevel() <= self.admin:getRole():rightLevel() then
                table.insert(self.comboList, {type=role:getName(), label=role:getName()});
            end
        end
    end

    self.combo = ISComboBox:new(UI_BORDER_SPACING+1, FONT_HGT_MEDIUM+UI_BORDER_SPACING*2+1, self.width-(UI_BORDER_SPACING+1)*2, BUTTON_HGT, nil,nil);
    self.combo:initialise();
    self:addChild(self.combo);

    self:populateComboList();

    local btnWid = 100

    self.ok = ISButton:new((self:getWidth() - UI_BORDER_SPACING) / 2 - btnWid, self.combo:getBottom() + UI_BORDER_SPACING, btnWid, BUTTON_HGT, getText("UI_Ok"), self, ISPlayerStatsChooseAccessLevelUI.onOptionMouseDown);
    self.ok.internal = "OK";
    self.ok:initialise();
    self.ok:instantiate();
    self.ok.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.ok);

    self.cancel = ISButton:new((self:getWidth() + UI_BORDER_SPACING) / 2, self.combo:getBottom() + UI_BORDER_SPACING, btnWid, BUTTON_HGT, getText("UI_Cancel"), self, ISPlayerStatsChooseAccessLevelUI.onOptionMouseDown);
    self.cancel.internal = "CANCEL";
    self.cancel:initialise();
    self.cancel:instantiate();
    self.cancel.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.cancel);

    self:setHeight(self.ok:getBottom() + UI_BORDER_SPACING+1)
end

function ISPlayerStatsChooseAccessLevelUI:populateComboList()
    self.combo:clear();
    for _,v in ipairs(self.comboList) do
        self.combo:addOption(v.label);
        if v.label == self.chr:getRole():getName() then
            self.combo.selected = _;
        end
    end
end

function ISPlayerStatsChooseAccessLevelUI:onOptionMouseDown(button, x, y)
    if button.internal == "OK" then
        self:setVisible(false);
        self:removeFromUIManager();
        if self.onclick ~= nil then
            self.onclick(self.target, button, self.comboList[self.combo.selected].type);
        end
    end
    if button.internal == "CANCEL" then
        self:setVisible(false);
        self:removeFromUIManager();
    end
end

function ISPlayerStatsChooseAccessLevelUI:new(x, y, width, height, target, onclick, player, admin)
    local o = {};
    o = ISPanel:new(x, y, width, height);
    setmetatable(o, self);
    self.__index = self;
    o.variableColor={r=0.9, g=0.55, b=0.1, a=1};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.target = target;
    o.onclick = onclick;
    o.chr = player;
    o.admin = admin;
    o.comboList = {};
    o.zOffsetSmallFont = 25;
    o.moveWithMouse = true;
    return o;
end
