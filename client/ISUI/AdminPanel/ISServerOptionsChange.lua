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

ISServerOptionsChange = ISPanel:derive("ISServerOptionsChange");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

--************************************************************************--
--** ISPanel:initialise
--**
--************************************************************************--

function ISServerOptionsChange:initialise()
    ISPanel.initialise(self);
    self:create();
end


function ISServerOptionsChange:setVisible(visible)
    --    self.parent:setVisible(visible);
    self.javaObject:setVisible(visible);
end

function ISServerOptionsChange:render()
    local y = UI_BORDER_SPACING+1
    self:drawText(getText("IGUI_PlayerStats_ChangeServerOptionTitle"), self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_PlayerStats_ChangeServerOptionTitle")) / 2), y, 1,1,1,1, UIFont.Medium);
    y = y+FONT_HGT_MEDIUM+UI_BORDER_SPACING
    self:drawText(self.option:getName(), 10, y+3, 1,1,1,1, UIFont.Small);

    if (instanceof(self.option, "EnumConfigOption")) then
        y = y+BUTTON_HGT+UI_BORDER_SPACING
        self:drawText(getText("Sandbox_Default", self.option:getValueTranslationByIndex(self.option:getDefaultValue())), 10, y+3, 1,1,1,1, UIFont.Small);
    elseif instanceof(self.option, "DoubleConfigOption") or instanceof(self.option, "IntegerConfigOption") then
        y = y+BUTTON_HGT+UI_BORDER_SPACING
        self:drawText(getText("Sandbox_MinMaxDefault", self.option:getMin(), self.option:getMax(), self.option:getDefaultValue()), 10, y+3, 1,1,1,1, UIFont.Small);
    end

    if self.errorTxt then
        y = y+BUTTON_HGT+UI_BORDER_SPACING
        self:drawText(self.errorTxt, 10, y+3, 1,0,0,1, UIFont.Small);
    end

    self:setHeight(y+(BUTTON_HGT+UI_BORDER_SPACING)*2+1)

    self:updateButtons();
end

function ISServerOptionsChange:create()
    local btnWid = 100

    local y = FONT_HGT_MEDIUM+UI_BORDER_SPACING*2+1;

    if instanceof(self.option, "BooleanConfigOption") then
        local comboWid = getTextManager():MeasureStringX(UIFont.Small, "false") + 30
        self.booleanOption = ISComboBox:new(getTextManager():MeasureStringX(UIFont.Small, self.option:getName()) + 20, y, comboWid, FONT_HGT_SMALL + 2 * 2, nil,nil);
        self.booleanOption:initialise();
        self.booleanOption:addOption("true");
        self.booleanOption:addOption("false");
        self.booleanOption.parent = self;
        self.defaultBool = 1;
        if not self.option:getValue() then
            self.booleanOption.selected = 2;
            self.defaultBool = 2;
        end
        self:addChild(self.booleanOption);
    end

    if instanceof(self.option, "EnumConfigOption") then
        local comboWid = getTextManager():MeasureStringX(UIFont.Small, "false") + 30
        self.enumOption = ISComboBox:new(getTextManager():MeasureStringX(UIFont.Small, self.option:getName()) + 20, y, comboWid, FONT_HGT_SMALL + 2 * 2, nil,nil);
        self.enumOption:initialise();
        for k=1,self.option:getNumValues() do
            self.enumOption:addOption(self.option:getValueTranslationByIndex(k));
        end
        self.enumOption.parent = self;
        self.defaultOption = self.option:getValue();
        self.enumOption.selected = self.option:getValue();
        self:addChild(self.enumOption);
    elseif instanceof(self.option, "DoubleConfigOption") or instanceof(self.option, "IntegerConfigOption") or instanceof(self.option, "StringConfigOption") then
        local size = self:getWidth() - (getTextManager():MeasureStringX(UIFont.Small, self.option:getName()) + UI_BORDER_SPACING*3+1);
        if size > (self:getWidth() - (getTextManager():MeasureStringX(UIFont.Small, self.option:getName()) + 30)) then
            size = (self:getWidth() - (getTextManager():MeasureStringX(UIFont.Small, self.option:getName()) + 30));
        end
        self.entry = ISTextEntryBox:new(self.option:getValueAsString(), getTextManager():MeasureStringX(UIFont.Small, self.option:getName()) + 20, y, size, FONT_HGT_SMALL + 2 * 2);
        self.entry.font = UIFont.Small
        self.entry:initialise();
        self.entry:instantiate();
        if instanceof(self.option, "DoubleConfigOption") or instanceof(self.option, "IntegerConfigOption") then
            self.entry:setOnlyNumbers(true);
            self.entry.min = self.option:getMin();
            self.entry.max = self.option:getMax();
        end
        self:addChild(self.entry);
        self.defaultText = self.option:getValueAsString();
    end

    self.saveBtn = ISButton:new(UI_BORDER_SPACING+1, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT - 1, btnWid, BUTTON_HGT, getText("UI_characreation_BuildSave"), self, ISServerOptionsChange.onOptionMouseDown);
    self.saveBtn.internal = "SAVE";
    self.saveBtn:initialise();
    self.saveBtn:instantiate();
    self.saveBtn.borderColor = self.buttonBorderColor;
    self.saveBtn.enable = false;
    self:addChild(self.saveBtn);

    self.cancel = ISButton:new(self:getWidth() - btnWid - UI_BORDER_SPACING-1, self.saveBtn.y, btnWid, BUTTON_HGT, getText("UI_Cancel"), self, ISServerOptionsChange.onOptionMouseDown);
    self.cancel.internal = "CANCEL";
    self.cancel:initialise();
    self.cancel:instantiate();
    self.cancel.borderColor = self.buttonBorderColor;
    self:addChild(self.cancel);

    self.resetBtn = ISButton:new(self.cancel.x - btnWid - UI_BORDER_SPACING, self.saveBtn.y, btnWid, BUTTON_HGT, getText("IGUI_PlayerStats_ResetToDefault"), self, ISServerOptionsChange.onOptionMouseDown);
    self.resetBtn.internal = "RESET";
    self.resetBtn:initialise();
    self.resetBtn:instantiate();
    self.resetBtn.borderColor = self.buttonBorderColor;
    self.resetBtn:setX(self.cancel.x - 10 - self.resetBtn.width)
    self:addChild(self.resetBtn);

end

function ISServerOptionsChange:updateButtons()
    self.saveBtn.enable = false;
    self.resetBtn.enable = false;
    self.saveBtn:setY(self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT - 1)
    self.cancel:setY(self.saveBtn.y)
    self.resetBtn:setY(self.saveBtn.y)
    if self.entry then
        if self.entry:getText() ~= self.defaultText then
            self.saveBtn.enable = true;
        end
        if self.entry:getText() ~= self.option:getDefaultValue() then
            self.resetBtn.enable = true;
        end
    end
    if self.booleanOption then
        if self.booleanOption.selected ~= self.defaultBool then
            self.saveBtn.enable = true;
        end

        if (not self.option:getDefaultValue() and self.booleanOption.selected == 1) or (self.option:getDefaultValue() and self.booleanOption.selected == 2) then
            self.resetBtn.enable = true;
        end
    end
    if self.enumOption then
        if self.enumOption.selected ~= self.defaultOption then
            self.saveBtn.enable = true;
        end
        if (self.option:getDefaultValue() ~= self.enumOption.selected) then
            self.resetBtn.enable = true;
        end
    end
end

function ISServerOptionsChange:onOptionMouseDown(button, x, y)

    if button.internal == "SAVE" then
        self.errorTxt = nil;
        if self.onclick ~= nil then
            if self.booleanOption then
                local newValue = "false";
                if self.booleanOption.selected == 1 then
                    newValue = "true";
                end
                self.onclick(self.target, button.parent.option, newValue);
            end
            if self.enumOption then
                self.onclick(self.target, button.parent.option, tostring(self.enumOption.selected));
            end
            if self.entry then
                if self.entry.min then
                    if tonumber(self.entry:getText()) < self.entry.min then
                        self.errorTxt = "The minimum value for this option is " .. self.entry.min;
                        return;
                    end
                end
                if self.entry.max then
                    if tonumber(self.entry:getText()) > self.entry.max then
                        self.errorTxt = "The maximum value for this option is " .. self.entry.max;
                        return;
                    end
                end
                self.onclick(self.target, button.parent.option, self.entry:getText());
            end
            self:setVisible(false);
            self:removeFromUIManager();
        end
    end
    if button.internal == "RESET" then
        if self.booleanOption then
            if not self.option:getDefaultValue() then
                self.booleanOption.selected = 2;
            else
                self.booleanOption.selected = 1;
            end
        end
        if self.enumOption then
            self.enumOption.selected = self.option:getDefaultValue()
        end
        if self.entry then
            self.entry:setText(tostring(button.parent.option:getDefaultValue()));
        end
    end
    if button.internal == "CANCEL" then
        self:setVisible(false);
        self:removeFromUIManager();
    end

    self.target.modifying = false;
end

function ISServerOptionsChange:new(x, y, width, height, target, onclick, option)
    local o = {};
    o = ISPanel:new(x, y, width, height);
    setmetatable(o, self);
    self.__index = self;
    o.variableColor={r=0.9, g=0.55, b=0.1, a=1};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.buttonBorderColor = {r=0.7, g=0.7, b=0.7, a=0.5};
    o.zOffsetSmallFont = 25;
    o.moveWithMouse = true;
    o.target = target;
    o.onclick = onclick;
    o.option = option;
    o.defaultBool = 1;
    o.defaultOption = 2;
    o.defaultText = "";

    return o;
end
