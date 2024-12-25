--***********************************************************
--**                    THE INDIE STONE                    **
--**		           Author: spurcival	    	       **
--***********************************************************

require "ISUI/ISPanel"

local FONT_HGT_SEARCH = getTextManager():getFontHeight(UIFont.Medium);
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.NewSmall);
local UI_BORDER_SPACING = 10
local BUTTON_HGT_SEARCH = FONT_HGT_SEARCH + 6

ISWidgetRecipeFilterPanel = ISPanel:derive("ISWidgetRecipeFilterPanel");

function ISWidgetRecipeFilterPanel:initialise()
	ISPanel.initialise(self);
end

function ISWidgetRecipeFilterPanel:createChildren()
    ISPanel.createChildren(self);

    local fontHeight = -1; -- <=0 sets label initial height to font

    self.entryBox = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISTextEntryBox, "", 0, 0, 100, BUTTON_HGT_SEARCH);
    self.entryBox.font = UIFont.Medium;
    self.entryBox:initialise();
    self.entryBox:instantiate();
    self.entryBox.onTextChange = ISWidgetRecipeFilterPanel.onTextChange;
    self.entryBox.target = self;
    self.entryBox:setClearButton(true);
    --self.entryBox:focus();
    self:addChild(self.entryBox);

    if self.needFilterCombo then
        self.filterTypeCombo = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISComboBox, 0, 0, 100, BUTTON_HGT_SEARCH, self, ISWidgetRecipeFilterPanel.OnClickFilterType);
        self.filterTypeCombo.font = UIFont.NewSmall;
        self.filterTypeCombo:initialise();
        self.filterTypeCombo:instantiate();
        self.filterTypeCombo.target = self;
        self:addChild(self.filterTypeCombo);

        self:populateComboList();
    end

    self.searchHackLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, self.searchInfoText, 0.3, 0.3, 0.3, 1, UIFont.Medium, true)
    --self.searchHackLabel.center = true;
    --self.searchHackLabel.textColor = self.textColor;
    self.searchHackLabel:initialise();
    self.searchHackLabel:instantiate();
    self:addChild(self.searchHackLabel);

    self.buttonGrid = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, BUTTON_HGT_SEARCH, BUTTON_HGT_SEARCH, nil)
    --self.buttonPrev.image = (not self.showInfo) and self.iconInfo or self.iconPanel;
    self.buttonGrid.image = getTexture("media/ui/craftingMenus/Icon_Grid.png");
    self.buttonGrid.target = self;
    self.buttonGrid.onclick = ISWidgetRecipeFilterPanel.onButtonClick;
    self.buttonGrid.enable = true;
    self.buttonGrid:initialise();
    self.buttonGrid:instantiate();
    self:addChild(self.buttonGrid);

    self.buttonList = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, BUTTON_HGT_SEARCH, BUTTON_HGT_SEARCH, nil)
    --self.buttonPrev.image = (not self.showInfo) and self.iconInfo or self.iconPanel;
    self.buttonList.image = getTexture("media/ui/craftingMenus/Icon_List.png");
    self.buttonList.target = self;
    self.buttonList.onclick = ISWidgetRecipeFilterPanel.onButtonClick;
    self.buttonList.enable = true;
    self.buttonList:initialise();
    self.buttonList:instantiate();
    self:addChild(self.buttonList);

    if self.showAllVersionTickbox then
        self.tickbox = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISTickBox, 0, 0, 25, FONT_HGT_SMALL, "tickbox", self, ISWidgetRecipeFilterPanel.OnShowAllClick)
        self.tickbox:initialise();
        self.tickbox:instantiate();
        self.tickbox.selected[1] = false;
        self.tickbox:addOption(getText("IGUI_CraftingUI_ShowAllVersion"));
        self.tickbox:setWidth(15 + getTextManager():MeasureStringX(UIFont.Small, "IGUI_CraftingUI_ShowAllVersion"));
        self:addChild(self.tickbox);
    end
end

function ISWidgetRecipeFilterPanel:populateComboList()
    self.filterTypeCombo:clear();

    self.filterTypeCombo:addOptionWithData(getText("IGUI_FilterType_RecipeName"), "RecipeName")
    self.filterTypeCombo:addOptionWithData(getText("IGUI_FilterType_InputName"), "InputName")
    self.filterTypeCombo:addOptionWithData(getText("IGUI_FilterType_OutputName"), "OutputName")

    local tooltipMap = {};
    tooltipMap[getText("IGUI_FilterType_RecipeName")] = getText("IGUI_FilterType_RecipeNameTooltip");
    tooltipMap[getText("IGUI_FilterType_InputName")] = getText("IGUI_FilterType_InputNameTooltip");
    tooltipMap[getText("IGUI_FilterType_OutputName")] = getText("IGUI_FilterType_OutputNameTooltip");
    self.filterTypeCombo:setToolTipMap(tooltipMap);

    self.filterTypeCombo:setWidthToOptions(50);
end

function ISWidgetRecipeFilterPanel:OnShowAllClick(clickedOption, enabled)
    self.parent.parent:OnFilterAll(enabled);
end

function ISWidgetRecipeFilterPanel:onButtonClick(_button)
    if self.buttonGrid and _button==self.buttonGrid then
        self.callbackTarget:setRecipeListMode(false);
    elseif self.buttonList and _button==self.buttonList then
        self.callbackTarget:setRecipeListMode(true);
    end
end

function ISWidgetRecipeFilterPanel:OnClickFilterType(box)
    local mode = nil;
    -- ignore the first values as it's the classic "recipe name"
    if box:getSelected() > 1 then
        mode = box.options[box:getSelected()].data;
    end

    box.parent.entryBox.target.callbackTarget:setRecipeFilter(box.parent.entryBox.target.searchInfoText, mode);
end

function ISWidgetRecipeFilterPanel.onTextChange(box)
    if not box then
        return;
    end

    local mode = nil;
    -- ignore the first values as it's the classic "recipe name"
    if box.parent.filterTypeCombo and box.parent.filterTypeCombo:getSelected() > 1 then
        mode = box.parent.filterTypeCombo.options[box.parent.filterTypeCombo:getSelected()].data;
    end

    if box:getInternalText() ~= box.target.searchInfoText then
        box.target.searchInfoText = box:getInternalText();
        box.target.callbackTarget:setRecipeFilter(box.target.searchInfoText, mode);
    end
end

function ISWidgetRecipeFilterPanel:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    local testHeight = self.entryBox:getHeight()+(self.margin*2);
    height = math.max(height, testHeight);

    -- view toggle
    local buttonX = width - (self.buttonGrid:getWidth() + UI_BORDER_SPACING+1 + self.buttonList:getWidth() + UI_BORDER_SPACING+1);
    self.buttonGrid:setX(buttonX);
    self.buttonGrid:setY(UI_BORDER_SPACING+1);

    self.buttonList:setX(buttonX + self.buttonGrid:getWidth() + UI_BORDER_SPACING+1);
    self.buttonList:setY(UI_BORDER_SPACING+1);

    local searchWidth = buttonX - ((UI_BORDER_SPACING+1)*2);
    if self.filterTypeCombo then
        searchWidth = buttonX - self.filterTypeCombo:getWidth() - ((UI_BORDER_SPACING+1)*2);
    end

    -- filter combo
    if self.filterTypeCombo then
        self.filterTypeCombo:setX(searchWidth)
        self.filterTypeCombo:setY(UI_BORDER_SPACING+1)
    end

    -- search
    self.entryBox:setX(UI_BORDER_SPACING+1);
    self.entryBox:setY(UI_BORDER_SPACING+1)
    self.entryBox:setWidth(searchWidth - 15);

    self.searchHackLabel:setX(self.entryBox:getX()+4);
    self.searchHackLabel.originalX = self.searchHackLabel:getX();
    local y = self.entryBox:getY() + (self.entryBox:getHeight()/2);
    y = y - self.searchHackLabel:getHeight()/2;
    self.searchHackLabel:setY(y);

    if self.tickbox then
        self.tickbox:setX(self.entryBox:getX())
        self.tickbox:setY(self.entryBox:getY() + self.entryBox:getHeight() + 3)
        height = height + self.tickbox:getHeight();
    end

    self:setWidth(width);
    self:setHeight(height);
end

function ISWidgetRecipeFilterPanel:onResize()
    ISUIElement.onResize(self)
end

function ISWidgetRecipeFilterPanel:prerender()
    ISPanel.prerender(self);
    
    if self.entryBox:isFocused() or (self.entryBox:getText() and #self.entryBox:getText()>0) then
        self.searchHackLabel:setVisible(false);
    else
        self.searchHackLabel:setVisible(true);
    end
end

function ISWidgetRecipeFilterPanel:render()
    ISPanel.render(self);
end

function ISWidgetRecipeFilterPanel:update()
    ISPanel.update(self);
end


--************************************************************************--
--** ISWidgetRecipeFilterPanel:new
--**
--************************************************************************--
function ISWidgetRecipeFilterPanel:new(x, y, width, height, callbackTarget)
	local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    
    o.callbackTarget = callbackTarget;
    
    o.backgroundColor = {r=0, g=0, b=0, a=0};
    
    o.paddingTop = 2;
    o.paddingBottom = 2;
    o.paddingLeft = 2;
    o.paddingRight = 2;
    o.marginTop = 5;
    o.marginBottom = 5;
    o.marginLeft = 5;
    o.marginRight = 5;
    
    o.margin = UI_BORDER_SPACING;

    o.autoFillContents = false;

    -- these may or may not be used by a parent control while calculating layout:
    o.isAutoFill = false;
    o.isAutoFillX = false;
    o.isAutoFillY = false;

    return o
end