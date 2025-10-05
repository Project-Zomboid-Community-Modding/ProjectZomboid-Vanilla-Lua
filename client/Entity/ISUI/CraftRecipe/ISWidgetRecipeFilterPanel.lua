--***********************************************************
--**                    THE INDIE STONE                    **
--**		           Author: spurcival	    	       **
--***********************************************************

require "ISUI/ISPanelJoypad"

local FONT_HGT_SEARCH = getTextManager():getFontHeight(UIFont.Medium);
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.NewSmall);
local UI_BORDER_SPACING = 5
local BUTTON_HGT_SEARCH = FONT_HGT_SEARCH + 6

ISWidgetRecipeFilterPanel = ISPanelJoypad:derive("ISWidgetRecipeFilterPanel");

function ISWidgetRecipeFilterPanel:initialise()
	ISPanelJoypad.initialise(self);
end

function ISWidgetRecipeFilterPanel:createChildren()
    ISPanelJoypad.createChildren(self);

    local fontHeight = -1; -- <=0 sets label initial height to font

    self.entryBox = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISTextEntryBox, "", 0, 0, 10, BUTTON_HGT_SEARCH);
    self.entryBox.font = UIFont.NewSmall;
    self.entryBox:initialise();
    self.entryBox:instantiate();
    self.entryBox.onTextChange = ISWidgetRecipeFilterPanel.onTextChange;
    self.entryBox.target = self;
    self.entryBox:setClearButton(true);
    self.entryBox.javaObject:setCentreVertically(true);
    self.entryBox:setPlaceholderText(self.searchInfoText);
    --self.entryBox:focus();
    self:addChild(self.entryBox);

    if self.needFilterCombo then
        self.filterTypeCombo = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISComboBox, 0, 0, 10, BUTTON_HGT_SEARCH, self, ISWidgetRecipeFilterPanel.OnClickFilterType);
        self.filterTypeCombo.font = UIFont.NewSmall;
        self.filterTypeCombo:initialise();
        self.filterTypeCombo:instantiate();
        self.filterTypeCombo.target = self;
        self.filterTypeCombo.doRepaintStencil = true
        self:addChild(self.filterTypeCombo);

        self:populateComboList();
    end

    if self.needSortCombo then
        local fontHeight = -1; -- <=0 sets label initial height to font
        self.sortComboLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, getText("IGUI_Sort_Name"), 0.9, 0.9, 0.9, 0.9, UIFont.NewSmall, true)
        self.sortComboLabel.textColor = self.textColor;
        self.sortComboLabel:initialise();
        self.sortComboLabel:instantiate();
        self:addChild(self.sortComboLabel);
        
        self.sortCombo = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISComboBox, 0, 0, 10, BUTTON_HGT_SEARCH, self, ISWidgetRecipeFilterPanel.OnClickSortType);
        self.sortCombo.font = UIFont.NewSmall;
        self.sortCombo:initialise();
        self.sortCombo:instantiate();
        self.sortCombo.target = self;
        self.sortCombo.doRepaintStencil = true
        self:addChild(self.sortCombo);

        self:populateSortList();
    end

    self.buttonViewMode = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, BUTTON_HGT_SEARCH, BUTTON_HGT_SEARCH, nil)
    --self.buttonPrev.image = (not self.showInfo) and self.iconInfo or self.iconPanel;
    self.buttonViewMode.image = self.iconGrid;
    self.buttonViewMode.target = self;
    self.buttonViewMode.onclick = ISWidgetRecipeFilterPanel.onButtonClick;
    self.buttonViewMode.enable = true;
    self.buttonViewMode:initialise();
    self.buttonViewMode:instantiate();
    self:addChild(self.buttonViewMode);
    self:updateViewModeButton();

    if self.showAllVersionTickbox then
        self.tickbox = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISTickBox, 0, 0, 15, FONT_HGT_SMALL, "tickbox", self, ISWidgetRecipeFilterPanel.OnShowAllClick)
        self.tickbox:initialise();
        self.tickbox:instantiate();
        self.tickbox.selected[1] = false;
        self.tickbox:addOption(getText("IGUI_CraftingUI_ShowAllVersion"));
        self.tickbox:setWidth(15 + getTextManager():MeasureStringX(UIFont.Small, "IGUI_CraftingUI_ShowAllVersion"));
        self:addChild(self.tickbox);
    end

    self.joypadButtonsY = {}
    self.joypadButtons = {}
    self.joypadIndexY = 1
    self.joypadIndex = 1
    
    if self.filterTypeCombo and self.sortCombo then
        self:insertNewLineOfButtons(self.entryBox, self.filterTypeCombo, self.sortCombo, self.buttonViewMode)
    elseif self.filterTypeCombo then
        self:insertNewLineOfButtons(self.entryBox, self.filterTypeCombo, self.buttonViewMode)
    elseif self.sortCombo then
        self:insertNewLineOfButtons(self.entryBox, self.sortCombo, self.buttonViewMode)
    else
        self:insertNewLineOfButtons(self.entryBox, self.buttonViewMode)
    end

    if self.showAllVersionTickbox then
        self:insertNewLineOfButtons(self.tickbox)
    end
end

function ISWidgetRecipeFilterPanel:updateViewModeButton()
    local viewMode = self.callbackTarget.logic:getSelectedRecipeStyle();
    if (viewMode == "grid") then
        self.buttonViewMode.image = self.iconList;
    else
        self.buttonViewMode.image = self.iconGrid;
    end
end

function ISWidgetRecipeFilterPanel:populateComboList()
    self.filterTypeCombo:clear();
    
    self.filterTypeCombo:addOptionWithData(getText("IGUI_FilterType_RecipeName"), "RecipeName")
    self.filterTypeCombo:addOptionWithData(getText("IGUI_FilterType_InputName"), "InputName")
    if self.showFilterByOutputItem then
        self.filterTypeCombo:addOptionWithData(getText("IGUI_FilterType_OutputName"), "OutputName")
    end

    local tooltipMap = {};
    tooltipMap[getText("IGUI_FilterType_RecipeName")] = getText("IGUI_FilterType_RecipeNameTooltip");
    tooltipMap[getText("IGUI_FilterType_InputName")] = getText("IGUI_FilterType_InputNameTooltip");
    tooltipMap[getText("IGUI_FilterType_OutputName")] = getText("IGUI_FilterType_OutputNameTooltip");
    self.filterTypeCombo:setToolTipMap(tooltipMap);

    self.filterTypeCombo:setWidthToOptions(50);
end

function ISWidgetRecipeFilterPanel:populateSortList()
    self.sortCombo:clear();

    self.sortCombo:addOptionWithData(getText("IGUI_SortType_RecipeName"), "RecipeName")
    self.sortCombo:addOptionWithData(getText("IGUI_SortType_LastUsed"), "LastUsed")
    self.sortCombo:addOptionWithData(getText("IGUI_SortType_MostUsed"), "MostUsed")

    local tooltipMap = {};
    tooltipMap[getText("IGUI_SortType_RecipeName")] = getText("IGUI_SortType_RecipeNameTooltip");
    tooltipMap[getText("IGUI_SortType_LastUsed")] = getText("IGUI_SortType_LastUsedTooltip");
    tooltipMap[getText("IGUI_SortType_MostUsed")] = getText("IGUI_SortType_MostUsedTooltip");
    self.sortCombo:setToolTipMap(tooltipMap);

    self.sortCombo:setWidthToOptions(50);

    local sortMode = self.callbackTarget.logic:getRecipeSortMode();
    self.sortCombo:selectData(sortMode);
end

function ISWidgetRecipeFilterPanel:OnShowAllClick(clickedOption, enabled)
    self.parent.parent:OnFilterAll(enabled);
end

function ISWidgetRecipeFilterPanel:onButtonClick(_button)
    if _button == self.buttonViewMode then
        if self.callbackTarget.logic:getSelectedRecipeStyle() == "grid" then
            self.callbackTarget:setRecipeListMode(true);
        else
            self.callbackTarget:setRecipeListMode(false);
        end
    end
    self:updateViewModeButton();
end

function ISWidgetRecipeFilterPanel:OnClickFilterType(box)
    local mode = nil;
    -- ignore the first values as it's the classic "recipe name"
    if box:getSelected() > 1 then
        mode = box.options[box:getSelected()].data;
    end

    box.parent.entryBox.target.callbackTarget:setRecipeFilter(box.parent.entryBox:getInternalText(), mode);
end

function ISWidgetRecipeFilterPanel:OnClickSortType(box)
    local mode = nil;
    if box:getSelected() > 0 then
        mode = box.options[box:getSelected()].data;
    end

    box.parent.entryBox.target.callbackTarget:setSortMode(mode);
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
        box.target.callbackTarget:setRecipeFilter(box:getInternalText(), mode);
    end
end

function ISWidgetRecipeFilterPanel:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    local testHeight = self.entryBox:getHeight()+(self.margin*2);
    if self.sortCombo and self.sortComboLabel then
        testHeight = testHeight + math.max(self.sortCombo:getHeight(), self.sortComboLabel:getHeight()) + 3;
    end
    if self.tickbox then
        testHeight = testHeight + self.tickbox:getHeight() + 3;
    end
    
    height = math.max(height, testHeight);

    local entryBoxWidth = getTextManager():MeasureStringX(UIFont.NewSmall, self.entryBox:getPlaceholderText() or "") + ((UI_BORDER_SPACING+1)*2);
    local testWidth = self.margin + entryBoxWidth + (self.buttonViewMode:getWidth() + UI_BORDER_SPACING+1) + self.margin;

    if self.filterTypeCombo and self.sortCombo then
        -- line up combos for aesthetics
        local filterWidth = self.filterTypeCombo:getWidth() + UI_BORDER_SPACING+1 + self.buttonViewMode:getWidth();
        local bestWidth = math.max(filterWidth, self.sortCombo:getWidth());
        self.filterTypeCombo:setWidth(bestWidth - (UI_BORDER_SPACING+1 + self.buttonViewMode:getWidth()));
        self.sortCombo:setWidth(bestWidth);
    end
    
    if self.filterTypeCombo then
        testWidth = testWidth + self.filterTypeCombo:getWidth() + ((UI_BORDER_SPACING+1));
    end
    
    width = math.max(width, testWidth);
    
    local y = UI_BORDER_SPACING + 1;
    
    -- view toggle
    local buttonX = width - (self.buttonViewMode:getWidth() + UI_BORDER_SPACING+1);
    self.buttonViewMode:setX(buttonX);
    self.buttonViewMode:setY(y);

    local searchWidth = buttonX - ((UI_BORDER_SPACING+1)*2);
    if self.filterTypeCombo then
        searchWidth = searchWidth - (self.filterTypeCombo:getWidth() + UI_BORDER_SPACING);
    end

    -- filter combo
    if self.filterTypeCombo then
        local comboX = UI_BORDER_SPACING+1 + searchWidth + UI_BORDER_SPACING;
        self.filterTypeCombo:setX(comboX)
        self.filterTypeCombo:setY(y)
    end

    -- search
    self.entryBox:setX(UI_BORDER_SPACING+1);
    self.entryBox:setY(UI_BORDER_SPACING+1)
    self.entryBox:setWidth(searchWidth);
    
    y = y + math.max(self.buttonViewMode:getHeight(), self.entryBox:getHeight(), self.filterTypeCombo and self.filterTypeCombo:getHeight() or 0) + 3;

    -- sort combo label
    if self.sortCombo and self.sortComboLabel then
        local comboX = self.filterTypeCombo and self.filterTypeCombo:getX() or (width - (self.sortCombo:getWidth() + UI_BORDER_SPACING+1));
        self.sortCombo:setX(comboX);
        self.sortCombo:setY(y);
        
        local x = comboX - (self.sortComboLabel:getWidth() + UI_BORDER_SPACING+1);
        self.sortComboLabel:setX(x);
        self.sortComboLabel:setY(y + ((self.sortCombo:getHeight() - self.sortComboLabel:getHeight())/2));
    
        y = y + math.max(self.sortCombo:getHeight() ,self.sortComboLabel:getHeight()) + 3;
    end    
    
    -- tickbox
    if self.tickbox then
        self.tickbox:setX(UI_BORDER_SPACING+1)
        self.tickbox:setY(y)
    end

    self:setWidth(width);
    self:setHeight(height);
end

function ISWidgetRecipeFilterPanel:onResize()
    ISUIElement.onResize(self)
end

function ISWidgetRecipeFilterPanel:prerender()
    ISPanelJoypad.prerender(self);
end

function ISWidgetRecipeFilterPanel:render()
    ISPanelJoypad.render(self);
    self:renderJoypadFocus()
end

function ISWidgetRecipeFilterPanel:update()
    ISPanelJoypad.update(self);
end

function ISWidgetRecipeFilterPanel:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
    self.joypadIndexY = 1
    self.joypadIndex = 1
    self:restoreJoypadFocus(joypadData)
end

function ISWidgetRecipeFilterPanel:onLoseJoypadFocus(joypadData)
    ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
    self.entryBox:unfocus()
    self:clearJoypadFocus()
end

function ISWidgetRecipeFilterPanel:setSearchInfoText(_text)
    self.searchInfoText = _text
    if self.entryBox then
        self.entryBox:setPlaceholderText(_text)
    end
end

--************************************************************************--
--** ISWidgetRecipeFilterPanel:new
--**
--************************************************************************--
function ISWidgetRecipeFilterPanel:new(x, y, width, height, callbackTarget)
	local o = ISPanelJoypad.new(self, x, y, width, height);

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
    
    o.needFilterCombo = false;
    o.needSortCombo = false;
    o.showFilterByOutputItem = true;

    -- these may or may not be used by a parent control while calculating layout:
    o.isAutoFill = false;
    o.isAutoFillX = false;
    o.isAutoFillY = false;
    
    o.iconGrid = getTexture("media/ui/craftingMenus/Icon_Grid.png");
    o.iconList = getTexture("media/ui/craftingMenus/Icon_List.png");

    return o
end