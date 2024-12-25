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

ISPlayerStatsAddXPUI = ISPanel:derive("ISPlayerStatsAddXPUI");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

--************************************************************************--
--** ISPanel:initialise
--**
--************************************************************************--

function ISPlayerStatsAddXPUI:initialise()
    ISPanel.initialise(self);
    self:create();
end


function ISPlayerStatsAddXPUI:setVisible(visible)
    --    self.parent:setVisible(visible);
    self.javaObject:setVisible(visible);
end

function ISPlayerStatsAddXPUI:render()
    self:drawText(getText("IGUI_PlayerStats_AddXPTitle"), self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_PlayerStats_AddXPTitle")) / 2), UI_BORDER_SPACING+1, 1,1,1,1, UIFont.Medium);
    self:drawText(getText("IGUI_PlayerStats_Perk"), UI_BORDER_SPACING+1, self.combo.y - self.combo.height-UI_BORDER_SPACING+3, 1,1,1,1, UIFont.Small);
    self:drawText(getText("IGUI_PlayerStats_Amount"), UI_BORDER_SPACING+1, self.entry.y - self.entry.height-UI_BORDER_SPACING+3, 1,1,1,1, UIFont.Small);
end

function ISPlayerStatsAddXPUI:create()
    self.perkList = {}
    for i=1,Perks.getMaxIndex() do
        local perk = PerkFactory.getPerk(Perks.fromIndex(i - 1));
        if perk and perk:getParent() ~= Perks.None then
            table.insert(self.perkList, perk)
        end
    end
    table.sort(self.perkList, function(a,b) return not string.sort(a:getName(), b:getName()) end)

    self.combo = ISComboBox:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING*3 + FONT_HGT_MEDIUM + BUTTON_HGT + 1, self.width - (UI_BORDER_SPACING+1)*2, BUTTON_HGT, self, ISPlayerStatsAddXPUI.onSelectPerk);
    self.combo:initialise();
    self:addChild(self.combo);

    for i=1,#self.perkList do
        local perk = self.perkList[i]
        self.combo:addOption(perk:getName() .. " (" .. PerkFactory.getPerkName(perk:getParent()) .. ")");
    end

    self.entry = ISTextEntryBox:new("1", self.combo.x, UI_BORDER_SPACING*5 + FONT_HGT_MEDIUM + BUTTON_HGT*3 + 1, 100, BUTTON_HGT);
    self.entry.font = UIFont.Small;
    self.entry:initialise();
    self.entry:instantiate();
    self.entry:setOnlyNumbers(true);
    self:addChild(self.entry);

    self.useMultipliers = ISTickBox:new(self.entry:getRight() + UI_BORDER_SPACING, UI_BORDER_SPACING*5 + FONT_HGT_MEDIUM + BUTTON_HGT*3 + 1, 100, BUTTON_HGT, "");
    self.useMultipliers.internal = "MULTIPLIERS";
    self.useMultipliers:initialise();
    self.useMultipliers:instantiate();
    self.useMultipliers.borderColor = {r=1, g=1, b=1, a=0.1};
    self.useMultipliers:addOption(getText("IGUI_PlayerStats_AddXPMultipliers"))
    self:addChild(self.useMultipliers);
    self.useMultipliers:setSelected(1,true);

--[[
    self.addGlobalXP = ISTickBox:new(10, self.entry.y + self.entry.height + 5, 100, 18, "", nil, nil);
    self.addGlobalXP:initialise();
    self.addGlobalXP:instantiate();
    self.addGlobalXP:setAnchorLeft(true);
    self.addGlobalXP:setAnchorRight(false);
    self.addGlobalXP:setAnchorTop(true);
    self.addGlobalXP:setAnchorBottom(false);
    self.addGlobalXP.selected[1] = true;
    self.addGlobalXP:addOption(getText("IGUI_PlayerStats_AddGlobalXP"));
    self:addChild(self.addGlobalXP);
--]]

    local btnWid = 100

--    self.ok = ISButton:new((self:getWidth() / 2) - 100 - 5, self.addGlobalXP:getBottom() + padBottom, btnWid, btnHgt, getText("UI_Ok"), self, ISPlayerStatsAddXPUI.onOptionMouseDown);
    self.ok = ISButton:new((self:getWidth() - UI_BORDER_SPACING) / 2 - btnWid, self.entry:getBottom() + UI_BORDER_SPACING, btnWid, BUTTON_HGT, getText("UI_Ok"), self, ISPlayerStatsAddXPUI.onOptionMouseDown);
    self.ok.internal = "OK";
    self.ok:initialise();
    self.ok:instantiate();
    self.ok.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.ok);

    self.cancel = ISButton:new((self:getWidth() + UI_BORDER_SPACING) / 2, self.entry:getBottom() + UI_BORDER_SPACING, btnWid, BUTTON_HGT, getText("UI_Cancel"), self, ISPlayerStatsAddXPUI.onOptionMouseDown);
    self.cancel.internal = "CANCEL";
    self.cancel:initialise();
    self.cancel:instantiate();
    self.cancel.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.cancel);

    self:setHeight(self.cancel:getBottom() + UI_BORDER_SPACING+1)
end

function ISPlayerStatsAddXPUI:onSelectPerk()

--    local perk = PerkFactory.getPerk(Perks.fromIndex(self.combo.selected));
--    print(self.combo.selected, perk);
--    self.addGlobalXP:setVisible(not self.perkList[self.combo.selected]:isPassiv())
end

function ISPlayerStatsAddXPUI:onOptionMouseDown(button, x, y)
    if button.internal == "OK" then
        self:setVisible(false);
        self:removeFromUIManager();
        if self.onclick ~= nil then
--            self.onclick(self.target, button, self.perkList[self.combo.selected], self.entry:getText(), self.addGlobalXP.selected[1]);
            self.onclick(self.target, button, self.perkList[self.combo.selected], self.entry:getText(), false, self.useMultipliers:isSelected(1));
        end
    end
    if button.internal == "CANCEL" then
        self:setVisible(false);
        self:removeFromUIManager();
    end
end

function ISPlayerStatsAddXPUI:new(x, y, width, height, target, onclick)
    local o = {};
    o = ISPanel:new(x, y, width, height * 2);
    setmetatable(o, self);
    self.__index = self;
    o.variableColor={r=0.9, g=0.55, b=0.1, a=1};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.target = target;
    o.onclick = onclick;
    o.zOffsetSmallFont = math.max(25, FONT_HGT_SMALL);
    o.moveWithMouse = true;

    return o;
end
