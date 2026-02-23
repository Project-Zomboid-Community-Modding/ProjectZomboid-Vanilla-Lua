require "ISUI/ISPanel"

ISPlayerStatsChooseTraitUI = ISPanel:derive("ISPlayerStatsChooseTraitUI");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

function ISPlayerStatsChooseTraitUI:initialise()
    ISPanel.initialise(self);
    self:create();
end

function ISPlayerStatsChooseTraitUI:setVisible(visible)
    self.javaObject:setVisible(visible);
end

function ISPlayerStatsChooseTraitUI:render()
    self:drawText(getText("IGUI_PlayerStats_AddTraitTitle"), self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_PlayerStats_AddTraitTitle")) / 2), UI_BORDER_SPACING+1, 1,1,1,1, UIFont.Medium);
end

function ISPlayerStatsChooseTraitUI:create()
    for i=0,CharacterTraitDefinition.getTraits():size()-1 do
        local characterTraitDefinition = CharacterTraitDefinition.getTraits():get(i);
        if not self.chr:hasTrait(characterTraitDefinition:getType()) then
            if characterTraitDefinition:getCost() >= 0 then
                table.insert(self.goodTraits, characterTraitDefinition)
            else
                table.insert(self.badTraits, characterTraitDefinition)
            end
        end
    end
    table.sort(self.goodTraits, function(a,b) return not string.sort(a:getLabel(), b:getLabel()) end)
    table.sort(self.badTraits, function(a,b) return not string.sort(a:getLabel(), b:getLabel()) end)

    self.combo = ISComboBox:new(UI_BORDER_SPACING+1, FONT_HGT_MEDIUM+UI_BORDER_SPACING*2+1, self.width - (UI_BORDER_SPACING+1)*2, BUTTON_HGT, nil,nil);
    self.combo:initialise();
    self.combo:setEditable(true)
    self.goodTrait = {};
    self:addChild(self.combo);

    self.traitsSelector = ISTickBox:new(self.combo.x, self.combo.y + self.combo.height + UI_BORDER_SPACING, 100, BUTTON_HGT, "", self, ISPlayerStatsChooseTraitUI.onChangeList);
    self.traitsSelector:initialise();
    self.traitsSelector:instantiate();
    self.traitsSelector:setAnchorLeft(true);
    self.traitsSelector:setAnchorRight(false);
    self.traitsSelector:setAnchorTop(true);
    self.traitsSelector:setAnchorBottom(false);
    self.traitsSelector.selected[1] = true;
    self.traitsSelector:addOption("Good Trait");
    self:addChild(self.traitsSelector);

    self:populateComboList();

    local btnWid = 100

    self.ok = ISButton:new((self:getWidth() - UI_BORDER_SPACING) / 2 - btnWid, self.traitsSelector:getBottom() + UI_BORDER_SPACING, btnWid, BUTTON_HGT, getText("UI_Ok"), self, ISPlayerStatsChooseTraitUI.onOptionMouseDown);
    self.ok.internal = "OK";
    self.ok:initialise();
    self.ok:instantiate();
    self.ok:enableAcceptColor();
    self:addChild(self.ok);

    self.cancel = ISButton:new((self:getWidth() + UI_BORDER_SPACING) / 2, self.ok:getY(), btnWid, BUTTON_HGT, getText("UI_Cancel"), self, ISPlayerStatsChooseTraitUI.onOptionMouseDown);
    self.cancel.internal = "CANCEL";
    self.cancel:initialise();
    self.cancel:instantiate();
    self.cancel:enableCancelColor();
    self:addChild(self.cancel);

    self:setHeight(self.cancel:getBottom() + UI_BORDER_SPACING+1)
end


function ISPlayerStatsChooseTraitUI:onChangeList()
    self:populateComboList();
end

function ISPlayerStatsChooseTraitUI:populateComboList()
    self.combo:clear();
    local list = self.badTraits;
    if self.traitsSelector.selected[1] then
        list = self.goodTraits;
    end
    local tooltipMap = {};
    for _,v in ipairs(list) do
        self.combo:addOption(v:getLabel());
        tooltipMap[v:getLabel()] = v:getDescription();
    end
    self.combo:setToolTipMap(tooltipMap);

    if self.traitsSelector.selected[1] then
        local hc = getCore():getGoodHighlitedColor()
        self.combo.textColor = {r=hc:getR(), g=hc:getG(), b=hc:getB(),a=0.9};
    else
        local hc = getCore():getBadHighlitedColor()
        self.combo.textColor = {r=hc:getR(), g=hc:getG(), b=hc:getB(),a=0.9};
    end
end

function ISPlayerStatsChooseTraitUI:onOptionMouseDown(button, x, y)
    if button.internal == "OK" then
        self:setVisible(false);
        self:removeFromUIManager();
        if self.onclick ~= nil then
            local list = self.badTraits;
            if self.traitsSelector.selected[1] then
                list = self.goodTraits;
            end
            self.onclick(self.target, button, list[self.combo.selected]);
        end
    end
    if button.internal == "CANCEL" then
        self:setVisible(false);
        self:removeFromUIManager();
    end
end

function ISPlayerStatsChooseTraitUI:new(x, y, width, height, target, onclick, player)
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
    o.comboList = {};
    o.zOffsetSmallFont = 25;
    o.goodTraits = {};
    o.badTraits = {};
    o.moveWithMouse = true;
    return o;
end
