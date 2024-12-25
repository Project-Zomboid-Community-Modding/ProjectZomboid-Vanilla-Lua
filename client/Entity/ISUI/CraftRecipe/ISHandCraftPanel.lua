--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

--[[
    Default panel for CraftRecipe HandCraft mode recipes.

    This panel is used in Entity UI but is also intended to function without entity/component data.
--]]
require "ISUI/ISPanel"

local UI_BORDER_SPACING = 10

ISHandCraftPanel = ISPanel:derive("ISHandCraftPanel");

--************************************************************************--
--** ISHandCraftPanel:initialise
--**
--************************************************************************--

function ISHandCraftPanel:initialise()
	ISPanel.initialise(self);
end

function ISHandCraftPanel:createChildren()
    ISPanel.createChildren(self);
    log(DebugType.CraftLogic, "=== CREATING HANDCRAFT PANEL ===")

    local styleCell = "S_TableLayoutCell_Pad5";
    self.rootTable = ISXuiSkin.build(self.xuiSkin, "S_TableLayout_Main", ISTableLayout, 0, 0, 10, 10, nil, nil, styleCell);
    self.rootTable:addRowFill(nil);
    self.rootTable:initialise();
    self.rootTable:instantiate();
    self:addChild(self.rootTable);

    if self.leftHandedMode then
        self:createRecipeCategoryColumn();
        self:createRecipesColumn();
        self:createRecipePanel();
        self:createInventoryPanel();
    else
        self:createInventoryPanel();
        self:createRecipePanel();
        self:createRecipesColumn();
        self:createRecipeCategoryColumn();
    end

    local viewMode = self.logic:getSelectedRecipeStyle("handcraft", self.player);
    if (viewMode == "grid") then
        self.recipeListMode = false;
    else
        self.recipeListMode = true;
    end

    self:setRecipeListMode(self.recipeListMode);

    self:refreshRecipeList();
end

--*****************************************
-- ISWidgetRecipeCategories
--*****************************************
function ISHandCraftPanel:createRecipeCategoryColumn()
    self.recipeCategories = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISWidgetRecipeCategories, 0, 0, 10, 10);
    --self.recipeCategories.autoWidth = true;
    self.recipeCategories.callbackTarget = self;
    self.recipeCategories:initialise();
    self.recipeCategories:instantiate();

    local column = self.rootTable:addColumn(nil);
    self.rootTable:setElement(column:index(), 0, self.recipeCategories);
end

--*****************************************
-- ISWidgetRecipesPanel
--*****************************************
function ISHandCraftPanel:createRecipesColumn()
    --self.recipeColumn = self.rootTable:addColumnFill(nil);

    self.recipesPanel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISWidgetRecipesPanel, 0, 0, 10, 10, self.player, self.craftBench, self.isoObject, self.logic, self);
    self.recipesPanel.needFilterCombo = true;
    self.recipesPanel:initialise();
    self.recipesPanel:instantiate();
    self.recipesPanel.noTooltip = true;

    local column = self.rootTable:addColumn(nil);
    self.rootTable:setElement(column:index(), 0, self.recipesPanel);
    --self.rootTable:cell(column:index(), 0).padding = 0;
end

    --*****************************************
    -- ISCraftInventoryPanel
    --*****************************************
function ISHandCraftPanel:createInventoryPanel()
    self.inventoryPanel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISCraftInventoryPanel, 0, 0, 10, 10, self.player, self.logic); --self.recipeData, self.inputItems, self.craftBench);
    self.inventoryPanel:initialise();
    self.inventoryPanel:instantiate();

    local column = self.rootTable:addColumn(nil);
    self.rootTable:setElement(column:index(), 0, self.inventoryPanel);

    self.inventoryPanelColumn = column;
    self.inventoryPanelColumn.visible = self.logic:shouldShowManualSelectInputs();
end

    --*****************************************
    -- ISCraftRecipePanel
    --*****************************************
function ISHandCraftPanel:createRecipePanel()
    self.recipePanel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISCraftRecipePanel, 0, 0, 10, 10, self.player, self.logic); --, self.logic:getRecipeData(), self.craftBench, self.isoObject);
    self.recipePanel:initialise();
    self.recipePanel:instantiate();

    self.recipePanelColumn = self.rootTable:addColumn(nil);
    self.rootTable:setElement(self.recipePanelColumn:index(), 0, self.recipePanel);
end

function ISHandCraftPanel:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    --local x,y = 0,headerHeight;
    if self.rootTable then
        self.rootTable:setX(0);
        self.rootTable:setY(0);
        self.rootTable:calculateLayout(width, height);

        width = math.max(width, self.rootTable:getWidth());
        height = math.max(height, self.rootTable:getHeight());
    end

    local categoryCell = self.rootTable:cellFor(self.recipeCategories);
    if self.recipeCategories then
        local categoryHeight = categoryCell:getHeight() - (UI_BORDER_SPACING*2);
        self.recipeCategories:setInternalHeight(categoryHeight);
        self.recipeCategories:setHeight(categoryHeight);
    end

    self:setWidth(width);
    self:setHeight(height);

    self.tooltipRecipe = nil;
end

function ISHandCraftPanel:onResize()
    ISUIElement.onResize(self)
end

function ISHandCraftPanel:prerender()
    ISPanel.prerender(self);

    if self.tooltipCounter>0 then
        self.tooltipCounter = self.tooltipCounter-UIManager.getSecondsSinceLastUpdate();
    end
    self:updateTooltip();
end

function ISHandCraftPanel:render()
    ISPanel.render(self);

    if ISEntityUI.drawDebugLines or self.drawDebugLines then
        self:drawRectBorderStatic(0, 0, self.width, self.height, 1.0, 0, 1, 0);
    end
end

function ISHandCraftPanel:update()
    ISPanel.update(self);

    if self.logic:isCraftActionInProgress() then 
        -- prevent updates while craftaction is in progress
        return; 
    end
    
    if self.updateTimer > 0 then
        self.updateTimer = self.updateTimer - 1;
    end

    --if not self.isoObject then
    if not self.craftBench then
        local newIsoObject = ISEntityUI.FindCraftSurface(self.player, 2);
        if self.isoObject ~= newIsoObject then
            --if not newIsoObject and self.isoObject then
            --    self.isoObject:setOutlineHighlight(false);
            --    self.isoObject:setOutlineHlAttached(false);
            --end
            self.isoObject = newIsoObject;
            self.parent.isoObject = self.isoObject;
            self.logic:setIsoObject(self.isoObject);
            self.updateTimer = 0;
        end
    end

    if ISHandCraftPanel.drawDirty and self.updateTimer == 0 then
        --local previousSelected = self.recipesPanel.recipeListPanel.recipeListPanel.selected;
        ISHandCraftPanel.drawDirty = false;
        self:refreshRecipeList();
        self.logic:autoPopulateInputs();
        -- change the timer value depending on the list, so it's faster if the list is small
        if #self.recipesPanel.recipeListPanel.recipeListPanel.items < 100 then
            self.updateTimer = 1;
        else
            self.updateTimer = 10;
        end
        --self.recipesPanel.recipeListPanel.recipeListPanel.selected = previousSelected;
    end
end

function ISHandCraftPanel:refreshRecipeList()
    self:updateContainers();

    if self.recipeQuery then
        self.logic:setRecipes(CraftRecipeManager.queryRecipes(self.recipeQuery));
    else
        self.logic:setRecipes(self.craftBench:getRecipes());
    end
    if getDebugOptions():getBoolean("Cheat.Recipe.SeeAll") then
        self.logic:setRecipes(ScriptManager.instance:getAllCraftRecipes())
    end
end

function ISHandCraftPanel:updateContainers()
    local containers = ISInventoryPaneContextMenu.getContainers(self.player);
    self.logic:setContainers(containers);
    self.tooltipLogic:setContainers(containers);
    self.recipesPanel:updateContainers(containers);
    self.recipePanel:updateContainers(containers);
    self.inventoryPanel:updateContainers(containers);
end

function ISHandCraftPanel:updateTooltip()
    if self:getSelectedRecipe()==self.tooltipRecipe or (not self.tooltipRecipe) then
        self:deactivateTooltip();
        return;
    end

    if self.activeTooltip and (self:getSelectedRecipe()==self.activeTooltip.recipe) then
        self:deactivateTooltip();
        return;
    end

    local titleOnly = self.tooltipCounter>0;
    if self.activeTooltip then
        self.activeTooltip:setRecipe(self.tooltipRecipe, titleOnly);
    else
        self.tooltipLogic:setRecipe(self.tooltipRecipe);
        self.activeTooltip = ISCraftRecipeTooltip.activateToolTipFor(self.recipesPanel, self.player, self.tooltipRecipe, self.tooltipLogic, true, titleOnly);
    end
end

function ISHandCraftPanel:deactivateTooltip()
    if self.activeTooltip then
        ISCraftRecipeTooltip.deactivateToolTipFor(self.recipesPanel);
        self.activeTooltip = nil;
    end
end

function ISHandCraftPanel:getSelectedRecipe()
    return self.logic:getRecipe();
end

function ISHandCraftPanel:setRecipeList(_recipeList)
    self.logic:setRecipes(_recipeList);
end

function ISHandCraftPanel:setRecipes(_recipeQuery)
    self.logic:setRecipes(_recipeQuery);
end

function ISHandCraftPanel:onRecipeChanged(_recipe)
    self.recipesPanel:onRecipeChanged(_recipe);

    self.inventoryPanelColumn.visible = self.logic:shouldShowManualSelectInputs() and self.logic:getRecipe() ~= nil;
    self.recipePanelColumn.visible = self.logic:getRecipe() ~= nil;

    --log(DebugType.CraftLogic, "ISHandCraftPanel -> set recipe and calling recalculate layout");
    self:xuiRecalculateLayout();
end

function ISHandCraftPanel:onUpdateRecipeList(_recipeList)
    local recipeList = self.logic:getRecipeList();

    self.recipesPanel:onUpdateRecipeList(recipeList);

    if self.recipeCategories then
        self.recipeCategories:populateCategoryList();
    end
end

function ISHandCraftPanel:onShowManualSelectChanged(_showManualSelectInputs)
    self.inventoryPanelColumn:setVisible(_showManualSelectInputs, true);

    local colWidth = 0;
    local cell = self.rootTable:cellFor(self.inventoryPanel);
    if cell then
        cell:calculateLayout(0,0);
        colWidth = cell.width;
    else
        colWidth = self.inventoryPanelColumn.width;
    end

    if _showManualSelectInputs then
        local root = self:xuiRootElement();
        if root then
            self:xuiRecalculateLayout(root:getWidth()+colWidth, root:getHeight(), true, not self.leftHandedMode);
        else
            self:xuiRecalculateLayout();
        end
    else
        self:xuiRecalculateLayout(-colWidth, nil, true, not self.leftHandedMode); --, true);
    end
end

function ISHandCraftPanel:onStopCraft()
    --log(DebugType.CraftLogic, "Calling listener ISHandCraftPanel.onStopCraft")
    self:updateContainers();
    self.logic:sortRecipeList();
    self.logic:refresh();
    self:xuiRecalculateLayout();
    if not self.logic:canPerformCurrentRecipe() then
        self.recipesPanel.recipeListPanel.recipeListPanel:setScrollHeight(0);
        self.recipesPanel.recipeListPanel.recipeListPanel.selected = 1;
    end
end

function ISHandCraftPanel:getCategoryList()
    return self.logic:getCategoryList();
end

function ISHandCraftPanel:setRecipeFilter(_filterString, _filterMode)
    self._filterString = _filterString;
    self._filterMode = _filterMode;
    self:filterRecipeList();
end

function ISHandCraftPanel:filterRecipeList(_category)
    -- there was a lot of methods for filterRecipeList, so i'm just adding the mode to the filter string, it's cut in java
    if self._filterMode and self._filterString then
        self._filterString = self._filterString .. "-@-" .. self._filterMode;
    end
    self.logic:filterRecipeList(self._filterString, _category);
    self.recipesPanel:filterRecipeList(_category);
end

function ISHandCraftPanel:onCategoryChanged(_category)
    self:filterRecipeList(_category);
    self.logic:checkValidRecipeSelected();
    self:onRecipeChanged(self.logic:getRecipe());
end

function ISHandCraftPanel:setRecipeListMode(_useListMode)
    self.recipesPanel:setRecipeListMode(_useListMode);
    self.logic:setSelectedRecipeStyle("handcraft", _useListMode and "list" or "grid", self.player);
    self:onUpdateRecipeList();
end

--************************************************************************--
--** ISHandCraftPanel:new
--** _craftBench (component) param is optional,
--** when handcrafting from workstation having a craftbench, its input resources may be used
--** _isoObject param is optional:
--** if supplied, the isoobject may be used in actions to face towards the object.
--************************************************************************--
function ISHandCraftPanel:new(x, y, width, height, player, craftBench, isoObject, recipeQuery)
    local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self

    o.background = false;

    o.logic = HandcraftLogic.new(player, craftBench, isoObject);
    o.logic:setManualSelectInputs(true);
    --o.logic:addEventListener("onUpdateContainers", o.onUpdateContainers, o);
    o.logic:addEventListener("onRecipeChanged", o.onRecipeChanged, o);
    --o.logic:addEventListener("onSetRecipeList", o.onSetRecipeList, o);
    o.logic:addEventListener("onUpdateRecipeList", o.onUpdateRecipeList, o);
    o.logic:addEventListener("onShowManualSelectChanged", o.onShowManualSelectChanged, o);
    o.logic:addEventListener("onStopCraft", o.onStopCraft, o);
    o.tooltipLogic = HandcraftLogic.new(player, craftBench, isoObject);
    --o.margin = 5;
    o.player = player;
    o.craftBench = craftBench;
    o.isoObject = isoObject;
    --can set recipe query to specify what tagged recipes should be loaded.
    --if a craftBench is present, leave recipeQuery nil/false value to load the craftBench recipes
    o.recipeQuery = recipeQuery;

    o.leftHandedMode = true;
    o.recipeListMode = true;

    o.minimumWidth = 0;
    o.minimumHeight = 0;

    o.tooltipCounterTime = 0.75;
    o.tooltipCounter = o.tooltipCounterTime;
    o.tooltipRecipe = nil;
    o.activeTooltip = nil;
    o.updateTimer = 0; -- just to not update everytime we refresh backpacks, adding bit of a timer as sometimes it can trigger fast

    --local test = getScriptManager():getAllRecipes();
    --log(DebugType.CraftLogic, "Recipe count: "..tostring(test:size()))

    return o;
end