--***********************************************************
--**                    THE INDIE STONE                    **
--**            Author: turbotutone / spurcival            **
--***********************************************************

--[[
    Default panel for CraftRecipe HandCraft mode recipes.

    This panel is used in Entity UI but is also intended to function without entity/component data.
--]]
require "ISUI/ISPanel"

local UI_BORDER_SPACING = 10

ISBuildPanel = ISPanel:derive("ISBuildPanel");

--************************************************************************--
--** ISBuildPanel:initialise
--**
--************************************************************************--

function ISBuildPanel:initialise()
	ISPanel.initialise(self);
end

function ISBuildPanel:createChildren()
    ISPanel.createChildren(self);
    print("=== CREATING BUILD PANEL ===")

    local styleCell = "S_TableLayoutCell_Pad5";
    self.rootTable = ISXuiSkin.build(self.xuiSkin, "S_TableLayout_Main", ISTableLayout, 0, 0, 10, 10, nil, nil, styleCell);
    self.rootTable.drawDebugLines = self.drawDebugLines;
    self.rootTable:addRowFill(nil);
    self.rootTable:initialise();
    self.rootTable:instantiate();
    self:addChild(self.rootTable);

    self:createRecipeCategoryColumn();
    self:createRecipesColumn();
    self:createRecipePanel();
    self:createInventoryPanel();

    local viewMode = self.logic:getSelectedRecipeStyle();
    if (viewMode == "grid") then
        self.recipeListMode = false;
    else
        self.recipeListMode = true;
    end
    
    self:setRecipeListMode(self.recipeListMode);
    
    self:updateContainers();

    --if self.recipeQuery then
    --    self.logic:setRecipes(CraftRecipeManager.queryRecipes(self.recipeQuery));
    --else
    --    self.logic:setRecipes(self.craftBench:getRecipes());
    --end

    --local list = self.logic:getAllBuildableRecipes();
    --self.logic:setRecipes(list);
    --
    ---- TODO RJ: There's probably a smarter way of doing this, but somehow it's not called during the build of BuildPanel compared to the HandCraftPanel?
    --self.logic:setRecipe(self.recipesPanel.recipeListPanel.recipeListPanel.items[self.recipesPanel.recipeListPanel.recipeListPanel.selected].item);

    self:refreshList();
    --self.recipesPanel.recipeListPanel.recipeListPanel.selected = 0;
end

function ISBuildPanel:refreshList()
    local list = self.logic:getAllBuildableRecipes();
    self.logic:setRecipes(list);
    
    self:ReselectRecipeOrFirst(self.logic:getLastSelectedRecipe());
end

function ISBuildPanel:ReselectRecipeOrFirst(_recipe)
    -- check if recipe if still in the list - clear if not
    local recipeFound = false;
    if self.recipesPanel.recipeListMode then
        if self.recipesPanel.recipeListPanel and self.recipesPanel.recipeListPanel.recipeListPanel and self.recipesPanel.recipeListPanel.recipeListPanel.items then
            for i = 1, #self.recipesPanel.recipeListPanel.recipeListPanel.items do
                if self.recipesPanel.recipeListPanel.recipeListPanel.items[i].item == _recipe then
                    recipeFound = true;
                    break;
                end
            end
        end
    else
        if self.recipesPanel.recipeIconPanel and self.recipesPanel.recipeIconPanel.sourceDataList and self.recipesPanel.recipeIconPanel.sourceDataList:contains(_recipe) then
            recipeFound = true;
        end
    end
    if not recipeFound then
        _recipe = nil;
    end

    -- check if we have recipe
    if not _recipe then
        -- get first recipe
        if self.recipesPanel.recipeListMode then
            _recipe = self.recipesPanel.recipeListPanel and self.recipesPanel.recipeListPanel.recipeListPanel and self.recipesPanel.recipeListPanel.recipeListPanel.items and self.recipesPanel.recipeListPanel.recipeListPanel.items[1] and self.recipesPanel.recipeListPanel.recipeListPanel.items[1].item;
        else
            _recipe = self.recipesPanel.recipeIconPanel and self.recipesPanel.recipeIconPanel.sourceDataList and self.recipesPanel.recipeIconPanel.sourceDataList:size() > 0 and self.recipesPanel.recipeIconPanel.sourceDataList:get(0);
        end
    end

    if _recipe then
        -- set selected recipe
        if self.recipesPanel.recipeListMode then
            if self.recipesPanel.recipeListPanel then self.recipesPanel.recipeListPanel:setSelectedData(_recipe); end
        else
            if self.recipesPanel.recipeIconPanel then self.recipesPanel.recipeIconPanel:setSelectedData(_recipe); end
        end

        if _recipe ~= self.logic:getRecipe() then
            self.logic:setRecipe(_recipe);
        end
    end
end

function ISBuildPanel:createInventoryPanel()
    self.inventoryPanel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISCraftInventoryPanel, 0, 0, 10, 10, self.player, self.logic); --self.recipeData, self.inputItems, self.craftBench);
    self.inventoryPanel:initialise();
    self.inventoryPanel:instantiate();

    local column = self.rootTable:addColumn(nil);
    self.rootTable:setElement(column:index(), 0, self.inventoryPanel);

    self.inventoryPanelColumn = column;
    self.inventoryPanelColumn.visible = self.logic:shouldShowManualSelectInputs();
end

function ISBuildPanel:createRecipePanel()
    self.craftRecipePanel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISBuildRecipePanel, 0, 0, 10, 10, self.player, self.logic); --, self.logic:getRecipeData(), self.craftBench, self.isoObject);
    self.craftRecipePanel:initialise();
    self.craftRecipePanel:instantiate();

    local column = self.rootTable:addColumn(nil);
    self.rootTable:setElement(column:index(), 0, self.craftRecipePanel);
end

function ISBuildPanel:createRecipeCategoryColumn()
    self.categoryColumn = self.rootTable:addColumn(nil);

    self.recipeCategories = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISWidgetRecipeCategories, 0, 0, 10, 10);
    --self.recipeCategories.autoWidth = true;
    self.recipeCategories.callbackTarget = self;
    self.recipeCategories:initialise();
    self.recipeCategories:instantiate();

    self.rootTable:setElement(self.categoryColumn:index(), 0, self.recipeCategories);
end

function ISBuildPanel:onDoubleClick(item)
    if self.craftRecipePanel.craftControl.buttonCraft.enable then
        ISBuildWindow.instance:createBuildIsoEntity();
        ISBuildWindow.instance:updateManualInputs();
    end
end

function ISBuildPanel:createRecipesColumn()
    self.recipeColumn = self.rootTable:addColumnFill(nil);

    self.recipesPanel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISWidgetRecipesPanel, 0, 0, 10, 10, self.player, self.craftBench, self.isoObject, self.logic, self);
    self.recipesPanel.ignoreLightIcon = true;
    self.recipesPanel.needSortCombo = true;
    self.recipesPanel.needFilterCombo = true;
    self.recipesPanel.showFilterByOutputItem = false;
    --self.recipesPanel.expandToFitTooltip = true;
    self.recipesPanel.wrapTooltipText = true;
    self.recipesPanel.showAllVersionTickbox = true;
    self.recipesPanel.ignoreSurface = true;
    self.recipesPanel:initialise();
    self.recipesPanel:instantiate();
    self.recipesPanel.noTooltip = true;
    self.recipesPanel.recipeListPanel.recipeListPanel:setOnMouseDoubleClick(self, ISBuildPanel.onDoubleClick)

    self.rootTable:setElement(self.recipeColumn:index(), 0, self.recipesPanel);
    self.rootTable:cell(self.recipeColumn:index(), 0).padding = 0;
end

--function ISBuildPanel:createRecipePanel(_parentTable)
--    self.recipeInfoPanel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISRecipeListItem, 0, 0, 10, 10, self.player, self.logic); --, self.logic:getRecipeData(), self.craftBench, self.isoObject);
--    self.recipeInfoPanel:initialise();
--    self.recipeInfoPanel:instantiate();
--
--    self.recipeInfoPanelRow = _parentTable:addRowFill(nil);
--    _parentTable:setElement(0, self.recipeInfoPanelRow:index(), self.recipeInfoPanel);
--end

function ISBuildPanel:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);
    
    if self.rootTable then
        self.rootTable:setX(0);
        self.rootTable:setY(0);
        self.rootTable:calculateLayout(width, height);

        width = math.max(width, self.rootTable:getWidth());
        height = math.max(height, self.rootTable:getHeight());
    end
    
    self:setWidth(width);
    self:setHeight(height);
end

function ISBuildPanel:onResize()
    ISUIElement.onResize(self)
end

function ISBuildPanel:prerender()
    ISPanel.prerender(self);

    -- update scrollbars
    --if self.recipeCategoryPanel then
    --    self.recipeCategoryPanel.vscroll:setHeight(self.recipeCategoryPanel.height);
    --end
end

function ISBuildPanel:render()
    ISPanel.render(self);

    if ISEntityUI.drawDebugLines or self.drawDebugLines then
        self:drawRectBorderStatic(0, 0, self.width, self.height, 1.0, 0, 1, 0);
    end
end

function ISBuildPanel:update()
    ISPanel.update(self);
    
    local isVisible = self.windowInstance and self.windowInstance:getIsVisible() or true;
    if isVisible and (ISBuildPanel.drawDirty or self:hasPlayerMoved()) then
        self:updateContainers();
        ISBuildPanel.drawDirty = false;
    end
end

function ISBuildPanel:hasPlayerMoved()
    local square = self.player:getCurrentSquare();

    -- this can happen on teleport
    if not square then
        return;
    end

    if not self.playerLastSquare then
        self.playerLastSquare = square;
    end

    if self.playerLastSquare:getX() ~= square:getX() then self.playerLastSquare = square; return true; end
    if self.playerLastSquare:getY() ~= square:getY() then self.playerLastSquare = square; return true; end
    if self.playerLastSquare:getZ() ~= square:getZ() then self.playerLastSquare = square; return true; end
    
    return false;
end

function ISBuildPanel:updateContainers(_forceRefresh)
    local containers = ISInventoryPaneContextMenu.getContainers(self.player);
    if self.logic:setContainers(containers) or _forceRefresh then
        self.recipesPanel:updateContainers(containers);
        self.inventoryPanel:updateContainers(containers);
        self.logic:autoPopulateInputs();
    end
end

local function getTool(_info, _inventory)   -- takes: InputScript, ItemContainer -- returns InventoryItem
    if _info then
        local inputScript = _info;
        local entryItems = inputScript:getPossibleInputItems(); -- List<Item>

        local item = false;
        for m=0, entryItems:size()-1 do
            local itemType = entryItems:get(m):getFullName(); -- Item
            local result = _inventory:getAllTypeEvalRecurse(itemType, ISBuildIsoEntity.predicateMaterial);  -- ArrayList<InventoryItem>
            if result:size()>0 then
                item = result:get(0):getFullType();
                break;
            end
        end
        if item then
            return item;
        else
            print("ISEntityBuildMenu.onBuildEntity -> tool item missing!")
            return;
        end
    end
end

function ISBuildPanel:setRecipeListMode(_useListMode)
    self.recipesPanel:setRecipeListMode(_useListMode);
    self.logic:setSelectedRecipeStyle(_useListMode and "list" or "grid");
    self:onUpdateRecipeList();
end

function ISBuildPanel:getSelectedRecipe()
    return self.logic:getRecipe();
end

function ISBuildPanel:setRecipeList(_recipeList)
    self.logic:setRecipes(_recipeList);
end

function ISBuildPanel:setRecipes(_recipeQuery)
    self.logic:setRecipes(_recipeQuery);
end

function ISBuildPanel:onRecipeChanged(_recipe)
    self.recipesPanel:onRecipeChanged(_recipe);

    --self:createBuildIsoEntity();
    --print("ISBuildPanel -> set recipe and calling recalculate layout");
end

function ISBuildPanel:setRecipeFilter(_filterString, _filterMode)
    self._filterString = _filterString;
    self._filterMode = _filterMode;
    self:filterRecipeList();
end

function ISBuildPanel:filterRecipeList()
    -- there was a lot of methods for filterRecipeList, so i'm just adding the mode to the filter string, it's cut in java
    if self._filterMode and self._filterString and self._filterString ~= "" then
        self._filterString = self._filterString .. "-@-" .. self._filterMode;
    end
    self.logic:filterRecipeList(self._filterString, self._categoryString);
    self.recipesPanel:filterRecipeList();
end

function ISBuildPanel:setSortMode(_sortMode)
    self.logic:setRecipeSortMode(_sortMode);
    self:sortRecipeList();
end

function ISBuildPanel:sortRecipeList()
    self.logic:sortRecipeList();
    self.recipesPanel:filterRecipeList();
end

function ISBuildPanel:onCategoryChanged(_category)
    self._categoryString = _category;
    self:filterRecipeList();
    self:ReselectRecipeOrFirst(self.logic:getLastSelectedRecipe());
    self:onRecipeChanged(self.logic:getRecipe());
end

--[[
function ISBuildPanel:populateCategoryList()
    self.recipeCategoryPanel:clear();
    self.recipeCategoryPanel:addItem("-- ALL --", "");
    --self.recipeCategoryPanel:addItem("Favourites", "*");
    
    local currentCategoryFilterFound = self.selectedCategory == "";

    if self.selectedCategory == "*" then
        self.recipeCategoryPanel.selected = 2;
        currentCategoryFilterFound = true;
    end

    local categories = self.logic:getCategoryList();
    for i = 0, categories:size()-1 do
        local categoryNameCapitalised = string.upper(string.sub(categories:get(i), 1, 1)) .. string.sub(categories:get(i), 2, string.len(categories:get(i)));
        local item = self.recipeCategoryPanel:addItem(categoryNameCapitalised, categories:get(i));

        if categories:get(i) == self.selectedCategory then
            self.recipeCategoryPanel.selected = item.itemindex;
            currentCategoryFilterFound = true;
        end
    end

    if not currentCategoryFilterFound then
        -- reset filter
        self:onCategoryChanged("");
    end
end
--]]

function ISBuildPanel:onUpdateContainers()
    -- if we are dragging, backfill inputs
    if not self.logic:isManualSelectInputs() and self.buildEntity and getCell():getDrag(self.player:getPlayerNum()) == self.buildEntity then
        self.logic:autoPopulateInputs();
    end
    
    self:createBuildIsoEntity(true);
end

function ISBuildPanel:createBuildIsoEntity(dontSetDrag)
    local _player = self.player;
    local _info = self.logic:getSelectedBuildObject();
    local _recipe = self.logic:getRecipe();
    
    if _info ~= nil and _recipe ~= nil then
        if self.buildEntity == nil or self.buildEntity.objectInfo ~= _info then
            local containers = ISInventoryPaneContextMenu.getContainers(self.player)
            self.buildEntity = ISBuildIsoEntity:new(_player, _info, 1, containers, self.logic);
            self.buildEntity.dragNilAfterPlace = false;
            self.buildEntity.blockAfterPlace = true;
    
            local inventory = _player:getInventory();
            self.buildEntity.equipBothHandItem = getTool(_recipe:getToolBoth(), inventory);
            self.buildEntity.firstItem = getTool(_recipe:getToolRight(), inventory);
            self.buildEntity.secondItem = getTool(_recipe:getToolLeft(), inventory);
        end

    	local cheat = self.player:isBuildCheat();
        local canBuild = self.logic:canPerformCurrentRecipe() or cheat;
        
        if self.logic:isCraftActionInProgress() then
            canBuild = false;
        end

        self.buildEntity.blockBuild = not canBuild;

        if not dontSetDrag then
            getCell():setDrag(self.buildEntity, _player:getPlayerNum());
        end
    else
        self.buildEntity = nil;
        getCell():setDrag(nil, _player:getPlayerNum());
    end
end

function ISBuildPanel:updateManualInputs()
    if self.buildEntity then
        self.buildEntity:updateManualInputs(self.logic);
    end
end

function ISBuildPanel:onUpdateRecipeList(_recipeList)
    local recipeList = self.logic:getRecipeList();

    self.recipesPanel:onUpdateRecipeList(recipeList);

    if self.recipeCategories and not self.recipeCategories.isInitialised then
        self.recipeCategories:populateCategoryList();
    end
end

function ISBuildPanel:onManualSelectChanged(_manualSelectInputs)
    if _manualSelectInputs == false then
        self.logic:setShowManualSelectInputs(false);
        self.logic:setManualSelectInputScriptFilter(nil);
    end
end

function ISBuildPanel:onShowManualSelectChanged(_showManualSelectInputs)
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

function ISBuildPanel:OnCloseWindow()
    self.buildEntity = nil;
    getCell():setDrag(nil, self.player:getPlayerNum());
    
    if self.logic:shouldShowManualSelectInputs() then
        self:onShowManualSelectChanged(false);
    end
end

function ISBuildPanel:onStopCraft()
    --print("Calling listener ISBuildPanel.onStopCraft")
    self:updateContainers();
    self.logic:sortRecipeList();
    self.logic:refresh();
    self:xuiRecalculateLayout();
    
    -- recreate build entity for quick sequential building by player  
    self:createBuildIsoEntity();
end

function ISBuildPanel:getCategoryList()
    return self.logic:getCategoryList();
end

function ISBuildPanel.SetDragItem(item, playerNum)
    -- TODO RJ: For now i'm setting invisible as i didn't figured out yet why the stencil isn't updated once i pin the window again...
    
    local windowKey = "BuildWindow";
    if not ISEntityUI.IsWindowOpen(playerNum, windowKey) then return; end

    local windowInstance = ISEntityUI.GetWindowInstance(playerNum, windowKey);
    if item then
        if isJoypadFocusOnElementOrDescendant(playerNum, windowInstance) then
            setJoypadFocus(playerNum, nil)
        end
        windowInstance:setVisible(false)
        --windowInstance.isCollapsed = true;
        --windowInstance:setMaxDrawHeight(windowInstance:titleBarHeight());
    else
        windowInstance.originalSquare = windowInstance.player:getSquare();
        windowInstance:setVisible(true)
       if JoypadState.players[playerNum+1] then
            JoypadState.players[playerNum+1].focus = windowInstance
       end
        --windowInstance:pin();
        --windowInstance.pin = true;
        --windowInstance.collapseButton:setVisible(true);
        --windowInstance.pinButton:setVisible(false);
        --windowInstance.collapseButton:bringToTop();
        --windowInstance.isCollapsed = false;
        --windowInstance:setDrawFrame(true);
        --windowInstance.clearStentil = false;
    end
end

--************************************************************************--
--** ISBuildPanel:new
--** _craftBench (component) param is optional,
--** when handcrafting from workstation having a craftbench, its input resources may be used
--************************************************************************--
function ISBuildPanel:new(x, y, width, height, player, craftBench, isoObject, recipeQuery)
    local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self

    o.background = false;
    
    o.logic = BuildLogic.new(player, craftBench, isoObject);
    o.logic:addEventListener("onUpdateContainers", o.onUpdateContainers, o);
    o.logic:addEventListener("onRecipeChanged", o.onRecipeChanged, o);
    --o.logic:addEventListener("onSetRecipeList", o.onSetRecipeList, o);
    o.logic:addEventListener("onUpdateRecipeList", o.onUpdateRecipeList, o);
    o.logic:addEventListener("onShowManualSelectChanged", o.onShowManualSelectChanged, o);
    o.logic:addEventListener("onManualSelectChanged", o.onManualSelectChanged, o);
    o.logic:addEventListener("onStopCraft", o.onStopCraft, o);
    
    --o.margin = 5;
    o.player = player;
    o.craftBench = craftBench;
    o.isoObject = isoObject;
    --can set recipe query to specify what tagged recipes should be loaded.
    o.recipeQuery = recipeQuery;

    o.leftHandedMode = true;
    o.recipeListMode = true;

    o.minimumWidth = 600;
    o.minimumHeight = 500;

    o.playerLastSquare = nil;
    
    o.drawDebugLines = false;
    
    ISBuildWindow.instance = o;
    o.windowInstance = ISEntityUI.GetWindowInstance(player, "BuildWindow");
    
    --local test = getScriptManager():getAllRecipes();
    --print("Recipe count: "..tostring(test:size()))

    return o;
end

Events.SetDragItem.Add(ISBuildPanel.SetDragItem);