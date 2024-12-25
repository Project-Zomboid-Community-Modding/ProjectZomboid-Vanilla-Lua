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

ISPlayerStatsWarningPointUI = ISPanel:derive("ISPlayerStatsWarningPointUI");
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6


--************************************************************************--
--** ISPanel:initialise
--**
--************************************************************************--

function ISPlayerStatsWarningPointUI:initialise()
    ISPanel.initialise(self);
    self:create();
end


function ISPlayerStatsWarningPointUI:setVisible(visible)
    --    self.parent:setVisible(visible);
    self.javaObject:setVisible(visible);
end

function ISPlayerStatsWarningPointUI:render()
    self:drawText(getText("IGUI_PlayerStats_WarningPointTitle"), self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_PlayerStats_WarningPointTitle")) / 2), UI_BORDER_SPACING+1, 1,1,1,1, UIFont.Medium);
    self:drawText(getText("IGUI_PlayerStats_Reason"), UI_BORDER_SPACING+1, self.reason.y - self.reason.height-UI_BORDER_SPACING+3, 1,1,1,1, UIFont.Small);
    self:drawText(getText("IGUI_PlayerStats_Amount"), UI_BORDER_SPACING+1, self.amount.y - self.amount.height-UI_BORDER_SPACING+3, 1,1,1,1, UIFont.Small);

end

function ISPlayerStatsWarningPointUI:create()
    self.reason = ISTextEntryBox:new("", UI_BORDER_SPACING+1, UI_BORDER_SPACING*3 + FONT_HGT_MEDIUM + BUTTON_HGT + 1, self.width - (UI_BORDER_SPACING+1)*2, BUTTON_HGT);
    self.reason.font = UIFont.Small;
    self.reason:initialise();
    self.reason:instantiate();
    self:addChild(self.reason);

    self.amount = ISTextEntryBox:new("1", self.reason.x, UI_BORDER_SPACING*5 + FONT_HGT_MEDIUM + BUTTON_HGT*3 + 1, 50, BUTTON_HGT);
    self.amount.font = UIFont.Small;
    self.amount:initialise();
    self.amount:instantiate();
    self.amount:setOnlyNumbers(true);
    self:addChild(self.amount);

    local btnWid = 100

    self.ok = ISButton:new((self:getWidth() - UI_BORDER_SPACING) / 2 - btnWid, self.amount:getBottom() + UI_BORDER_SPACING, btnWid, BUTTON_HGT, getText("UI_Ok"), self, ISPlayerStatsWarningPointUI.onOptionMouseDown);
    self.ok.internal = "OK";
    self.ok:initialise();
    self.ok:instantiate();
    self.ok.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.ok);

    self.cancel = ISButton:new((self:getWidth() + UI_BORDER_SPACING) / 2, self.amount:getBottom() + UI_BORDER_SPACING, btnWid, BUTTON_HGT, getText("UI_Cancel"), self, ISPlayerStatsWarningPointUI.onOptionMouseDown);
    self.cancel.internal = "CANCEL";
    self.cancel:initialise();
    self.cancel:instantiate();
    self.cancel.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.cancel);

    self:setHeight(self.ok:getBottom() + UI_BORDER_SPACING+1)
end


function ISPlayerStatsWarningPointUI:onOptionMouseDown(button, x, y)
    if button.internal == "OK" then
        self:setVisible(false);
        self:removeFromUIManager();
        if self.onclick ~= nil then
            self.onclick(self.target, button, self.reason:getText(), self.amount:getText());
        end
    end
    if button.internal == "CANCEL" then
        self:setVisible(false);
        self:removeFromUIManager();
    end
end

function ISPlayerStatsWarningPointUI:new(x, y, width, height, target, onclick)
    local o = {};
    o = ISPanel:new(x, y, width, height);
    setmetatable(o, self);
    self.__index = self;
    o.variableColor={r=0.9, g=0.55, b=0.1, a=1};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.target = target;
    o.onclick = onclick;
    o.moveWithMouse = true;
    return o;
end