require "ISUI/ISPanelJoypad"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.NewSmall);
local UI_BORDER_SPACING = 5
local BUTTON_HGT = FONT_HGT_SMALL + 6

ISWidgetRecipeFilterPanel = ISPanelJoypad:derive("ISWidgetRecipeFilterPanel");

function ISWidgetRecipeFilterPanel:initialise()
	ISPanelJoypad.initialise(self);
end

function ISWidgetRecipeFilterPanel:createChildren()
    ISPanelJoypad.createChildren(self);

    self.searchEntryBox = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISTextEntryBox, "", 0, 0, 10, BUTTON_HGT);
    self.searchEntryBox.font = UIFont.NewSmall;
    self.searchEntryBox:initialise();
    self.searchEntryBox:instantiate();
    self.searchEntryBox.onTextChange = ISWidgetRecipeFilterPanel.onTextChange;
    self.searchEntryBox.target = self;
    self.searchEntryBox:setClearButton(true);
    self.searchEntryBox.javaObject:setCentreVertically(true);
    self.searchEntryBox:setPlaceholderText(self.searchInfoText);
    self:addChild(self.searchEntryBox);

    if self.needFilterCombo then
        local comboWidth = BUTTON_HGT + math.max(
            getTextManager():MeasureStringX(UIFont.NewSmall, getText("IGUI_FilterType_RecipeName")),
            getTextManager():MeasureStringX(UIFont.NewSmall, getText("IGUI_FilterType_InputName")),
            getTextManager():MeasureStringX(UIFont.NewSmall, getText("IGUI_FilterType_OutputName"))
        )

        self.filterTypeCombo = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISComboBox, 0, 0, comboWidth, BUTTON_HGT, self, ISWidgetRecipeFilterPanel.OnClickFilterType);
        self.filterTypeCombo.font = UIFont.NewSmall;
        self.filterTypeCombo:initialise();
        self.filterTypeCombo:instantiate();
        self.filterTypeCombo.target = self;
        self.filterTypeCombo.doRepaintStencil = true
        self:addChild(self.filterTypeCombo);

        self:populateComboList();
    end

    if self.needSortCombo then
        local comboWidth = BUTTON_HGT + math.max(
            getTextManager():MeasureStringX(UIFont.NewSmall, getText("IGUI_SortType_RecipeName")),
            getTextManager():MeasureStringX(UIFont.NewSmall, getText("IGUI_SortType_LastUsed")),
            getTextManager():MeasureStringX(UIFont.NewSmall, getText("IGUI_SortType_MostUsed"))
        )

        self.sortComboLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, BUTTON_HGT, getText("IGUI_Sort_Name"), 0.9, 0.9, 0.9, 0.9, UIFont.NewSmall, true)
        self.sortComboLabel.textColor = self.textColor;
        self.sortComboLabel:initialise();
        self.sortComboLabel:instantiate();
        self:addChild(self.sortComboLabel);
        
        self.sortCombo = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISComboBox, 0, 0, comboWidth, BUTTON_HGT, self, ISWidgetRecipeFilterPanel.OnClickSortType);
        self.sortCombo.font = UIFont.NewSmall;
        self.sortCombo:initialise();
        self.sortCombo:instantiate();
        self.sortCombo.target = self;
        self.sortCombo.doRepaintStencil = true
        self:addChild(self.sortCombo);

        self:populateSortList();
    end

    self.viewModeButton = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, BUTTON_HGT, BUTTON_HGT, nil)
    self.viewModeButton.image = self.iconGrid;
    self.viewModeButton.target = self;
    self.viewModeButton.onclick = ISWidgetRecipeFilterPanel.onButtonClick;
    self.viewModeButton.enable = true;
    self.viewModeButton:initialise();
    self.viewModeButton:instantiate();
    self:addChild(self.viewModeButton);
    self:updateViewModeButton();

    if self.isBuildMenu then
        self.tickBoxShowAllVersion = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISTickBox, 0, 0, BUTTON_HGT, BUTTON_HGT, "tickbox", self, ISWidgetRecipeFilterPanel.onShowAllVersionClick)
        self.tickBoxShowAllVersion:initialise();
        self.tickBoxShowAllVersion:instantiate();
        self.tickBoxShowAllVersion.selected[1] = false;
        self.tickBoxShowAllVersion:addOption(getText("IGUI_CraftingUI_ShowAllVersion"));
        self.tickBoxShowAllVersion:setWidth(BUTTON_HGT + getTextManager():MeasureStringX(UIFont.Small, "IGUI_CraftingUI_ShowAllVersion"));
        self:addChild(self.tickBoxShowAllVersion);
    elseif self.showAllCraftFilterTickBox then
        self.showAllRecipeTickBox = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISTickBox, 0, 0, BUTTON_HGT, BUTTON_HGT, "tickbox", self, ISWidgetRecipeFilterPanel.onShowAllRecipeClick)
        self.showAllRecipeTickBox:initialise();
        self.showAllRecipeTickBox:instantiate();
        self.showAllRecipeTickBox.selected[1] = false;
        self.showAllRecipeTickBox:addOption(getText("IGUI_CraftingUI_ShowAllRecipe"));
        self.showAllRecipeTickBox:setWidth(BUTTON_HGT + getTextManager():MeasureStringX(UIFont.Small, "IGUI_CraftingUI_ShowAllRecipe"));
        self.showAllRecipeTickBox.tooltip = getText("IGUI_CheatPanel_SeeAllRecipes_tooltip");
        self:addChild(self.showAllRecipeTickBox);
    end

    self.joypadButtonsY = {}
    self.joypadButtons = {}
    self.joypadIndexY = 1
    self.joypadIndex = 1
    
    if self.filterTypeCombo and self.sortCombo then
        self:insertNewLineOfButtons(self.searchEntryBox, self.filterTypeCombo, self.sortCombo, self.viewModeButton, self.showAllRecipeTickBox)
    elseif self.filterTypeCombo then
        self:insertNewLineOfButtons(self.searchEntryBox, self.filterTypeCombo, self.viewModeButton, self.showAllRecipeTickBox)
    elseif self.sortCombo then
        self:insertNewLineOfButtons(self.searchEntryBox, self.sortCombo, self.viewModeButton, self.showAllRecipeTickBox)
    else
        self:insertNewLineOfButtons(self.searchEntryBox, self.viewModeButton, self.showAllRecipeTickBox)
    end
end

function ISWidgetRecipeFilterPanel:updateViewModeButton()
    local viewMode = self.callbackTarget.logic:getSelectedRecipeStyle();
    if (viewMode == "grid") then
        self.viewModeButton.image = self.iconList;
    else
        self.viewModeButton.image = self.iconGrid;
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

function ISWidgetRecipeFilterPanel:onShowAllVersionClick(clickedOption, enabled)
    self.parent.parent:OnFilterAll(enabled);
end

function ISWidgetRecipeFilterPanel:onShowAllRecipeClick(clickedOption, enabled)
    self.parent.parent.parent.parent:setSeeAllRecipe(enabled);
end

function ISWidgetRecipeFilterPanel:filter(textFilter, selectedCombo)
    self.searchEntryBox:setText(textFilter);
    self.filterTypeCombo:selectOptionFromText(selectedCombo);
    self.showAllRecipeTickBox:setSelected(1, true);
    self.parent.parent.parent.parent:setSeeAllRecipe(true);
    self.searchEntryBox:onTextChange();
end

function ISWidgetRecipeFilterPanel:onButtonClick(_button)
    if _button == self.viewModeButton then
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

    box.parent.searchEntryBox.target.callbackTarget:setRecipeFilter(box.parent.searchEntryBox:getInternalText(), mode);
end

function ISWidgetRecipeFilterPanel:OnClickSortType(box)
    local mode = nil;
    if box:getSelected() > 0 then
        mode = box.options[box:getSelected()].data;
    end

    box.parent.searchEntryBox.target.callbackTarget:setSortMode(mode);
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
    local x = UI_BORDER_SPACING + 1

    -- set filter combo and sort combo widths
    if self.filterTypeCombo and self.sortCombo then
        local widthDiff = self.viewModeButton:getWidth() + UI_BORDER_SPACING
        local targetWidth = math.max(
            self.sortCombo:getWidth(),
            self.filterTypeCombo:getWidth() + widthDiff
        )
        self.filterTypeCombo:setWidth(targetWidth - widthDiff);
        self.sortCombo:setWidth(targetWidth);
    end

    -- view mode button
    self.viewModeButton:setX(width - self.viewModeButton:getWidth() - x);
    self.viewModeButton:setY(x);

    -- filter combo
    if self.filterTypeCombo then
        self.filterTypeCombo:setX(self.viewModeButton:getX() - self.filterTypeCombo:getWidth() - UI_BORDER_SPACING)
        self.filterTypeCombo:setY(self.viewModeButton:getY())
    end

    -- search bar
    self.searchEntryBox:setX(x);
    if self.filterTypeCombo then
        self.searchEntryBox:setWidth(self.filterTypeCombo:getX() - self.searchEntryBox:getX() - UI_BORDER_SPACING);
    else
        self.searchEntryBox:setWidth(self.viewModeButton:getX() - self.searchEntryBox:getX() - UI_BORDER_SPACING);
    end
    self.searchEntryBox:setY(self.viewModeButton:getY())

    local y = self.searchEntryBox:getBottom() + UI_BORDER_SPACING;
    local yOffset = 0

    -- sort combo
    if self.sortCombo and self.sortComboLabel then
        if self.filterTypeCombo then
            self.sortCombo:setX(self.filterTypeCombo:getX())
        else
            self.sortCombo:setX(self.viewModeButton:getX() + self.viewModeButton:getWidth() - self.sortCombo:getWidth())
        end
        self.sortCombo:setY(y);

        self.sortComboLabel:setX(self.sortCombo:getX() - self.sortComboLabel:getWidth() - UI_BORDER_SPACING);
        self.sortComboLabel:setY(y + ((self.sortCombo:getHeight() - self.sortComboLabel:getHeight())/2));
        yOffset = BUTTON_HGT + UI_BORDER_SPACING
    end

    local tickboxWidth = 0

    if self.showAllRecipeTickBox then
        self.showAllRecipeTickBox:setX(x);
        self.showAllRecipeTickBox:setY(y);
        x = self.showAllRecipeTickBox:getX() + UI_BORDER_SPACING
        yOffset = BUTTON_HGT + UI_BORDER_SPACING
        tickboxWidth = self.showAllRecipeTickBox:getWidth()
    end

    if self.tickBoxShowAllVersion then
        self.tickBoxShowAllVersion:setX(x)
        self.tickBoxShowAllVersion:setY(y)
        yOffset = BUTTON_HGT + UI_BORDER_SPACING
        tickboxWidth = math.max(self.tickBoxShowAllVersion:getWidth(), tickboxWidth)
    end

    self.minimumWidth = tickboxWidth + self.sortCombo:getWidth() + UI_BORDER_SPACING

    self:setWidth(width);
    self:setHeight(y + yOffset + 1);
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
    self.searchEntryBox:unfocus()
    self:clearJoypadFocus()
end

function ISWidgetRecipeFilterPanel:setSearchInfoText(_text)
    self.searchInfoText = _text
    if self.searchEntryBox then
        self.searchEntryBox:setPlaceholderText(_text)
    end
end

function ISWidgetRecipeFilterPanel:new(x, y, width, height, callbackTarget)
	local o = ISPanelJoypad.new(self, x, y, width, height);

    o.callbackTarget = callbackTarget;
    
    o.backgroundColor = {r=0, g=0, b=0, a=0};

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
