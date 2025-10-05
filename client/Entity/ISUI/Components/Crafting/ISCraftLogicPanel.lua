--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

--[[
    Default panel for CraftLogic component.
--]]

require "Entity/ISUI/Components/ISBaseComponentPanel";

ISCraftLogicPanel = ISBaseComponentPanel:derive("ISCraftLogicPanel");

function ISCraftLogicPanel.CanCreatePanelFor(_player, _entity, _component, _componentUiScript)
    if _player and _entity and _component then
        return instanceof(_component, "CraftLogic");
    end
end

--************************************************************************--
--** ISCraftLogicPanel:initialise
--**
--************************************************************************--

function ISCraftLogicPanel:initialise()
	ISBaseComponentPanel.initialise(self);
end

function ISCraftLogicPanel:createChildren()
    ISBaseComponentPanel.createChildren(self);

    --self:createComponentHeader(self.xuiSkin, "S_WidgetComponentHeader_Std", false, nil, nil);

    if self.resourcesComponent and self.inputsGroupName then -- and self.resourceContainer then

        local column, row;
        self.tableLayout = ISXuiSkin.build(self.xuiSkin, "S_TableLayout_Main", ISTableLayout, 0, 0, 10, 10);
        self.tableLayout:addRowFill(nil);
        self.tableLayout:initialise();
        self.tableLayout:instantiate();
        self:addChild(self.tableLayout);

        self:createRecipesColumn();
        self:createRecipePanel();
        self:createInventoryPanel();
        
        -- refresh recipe list
        local viewMode = self.logic:getSelectedRecipeStyle();
        if (viewMode == "grid") then
            self.recipeListMode = false;
        else
            self.recipeListMode = true;
        end
        self:setRecipeListMode(self.recipeListMode);

        self:updateContainers();
    end
end

function ISCraftLogicPanel:updateContainers()
    local containers = ISInventoryPaneContextMenu.getContainers(self.player);
    self.logic:setContainers(containers);
    --self.tooltipLogic:setContainers(containers);
    --self.recipesPanel:updateContainers(containers);
    --self.recipePanel:updateContainers(containers);
    self.inventoryPanel:updateContainers(containers);
    self.resourceInventoryPanel:updateContainers(containers);
end

function ISCraftLogicPanel:onResourceSlotContentsChanged()
    self:updateContainers();
    if self.recipePanel then self.recipePanel:onResourceSlotContentsChanged(); end
    self:calculateLayout(self.width, self.height);
    self:xuiRecalculateLayout();
end

--handle is resource:size()==0
function ISCraftLogicPanel:createItemSlotPanel(_style)
    local panel = ISXuiSkin.build(self.xuiSkin, _style, ISItemSlotPanel, 0,0,20,20, self.player, self.entity, nil, nil);
    --panel.borderText = _title;
    panel:initialise();
    panel:instantiate();

    return panel;
end

function ISCraftLogicPanel:createFluidSlotPanel(_style)
    local panel = ISXuiSkin.build(self.xuiSkin, _style, ISFluidSlotPanel, 0,0,20,20, self.player, self.entity, nil);
    --panel.borderText = _title;
    panel:initialise();
    panel:instantiate();

    return panel;
end

function ISCraftLogicPanel:createEnergySlotPanel(_style)
    local panel = ISXuiSkin.build(self.xuiSkin, _style, ISEnergySlotPanel, 0,0,20,20, self.player, self.entity, nil);
    --panel.borderText = _title;
    panel:initialise();
    panel:instantiate();

    return panel;
end

function ISCraftLogicPanel:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    local headerHeight = 0;
    if self.componentHeader then
        self.componentHeader:setX(0);
        self.componentHeader:setY(0);

        self.componentHeader:calculateLayout(0, 0);

        headerHeight = self.componentHeader:getHeight();

        width = math.max(width, self.componentHeader:getWidth());
    end

    --local x,y = 0,headerHeight;
    if self.tableLayout then
        self.tableLayout:setX(0);
        self.tableLayout:setY(headerHeight);
        self.tableLayout:calculateLayout(width, math.max(0, height-headerHeight));

        width = math.max(width, self.tableLayout:getWidth());
        height = math.max(height, self.tableLayout:getHeight()+headerHeight);

        if self.componentHeader then
            self.componentHeader:calculateLayout(width, 0);
        end
    end

    self:setWidth(width);
    self:setHeight(height);
end

function ISCraftLogicPanel:onResize()
    ISUIElement.onResize(self)
end

function ISCraftLogicPanel:prerender()
    ISBaseComponentPanel.prerender(self);
end

function ISCraftLogicPanel:render()
    ISBaseComponentPanel.render(self);

    if ISEntityUI.drawDebugLines or self.drawDebugLines then
        self:drawRectBorderStatic(0, 0, self.width, self.height, 1.0, 0, 1, 0);
    end
end

function ISCraftLogicPanel:update()
    ISBaseComponentPanel.update(self);
end

function ISCraftLogicPanel:createRecipesColumn()
    self.recipeColumn = self.tableLayout:addColumnFill(nil);

    self.recipesPanel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISWidgetRecipesPanel, 0, 0, 10, 10, self.player, self.craftBench, self.isoObject, self.logic, self);
    self.recipesPanel.ignoreLightIcon = true;
    self.recipesPanel.needSortCombo = true;
    --self.recipesPanel.expandToFitTooltip = true;
    self.recipesPanel.wrapTooltipText = true;
    --self.recipesPanel.showAllVersionTickbox = true;
    self.recipesPanel.ignoreSurface = true;
    self.recipesPanel:initialise();
    self.recipesPanel:instantiate();
    self.recipesPanel.noTooltip = true;
    --self.recipesPanel.recipeListPanel.recipeListPanel:setOnMouseDoubleClick(self, ISCraftLogicPanel.onDoubleClick)

    self.tableLayout:setElement(self.recipeColumn:index(), 0, self.recipesPanel);
    self.tableLayout:cell(self.recipeColumn:index(), 0).padding = 0;
end

function ISCraftLogicPanel:createRecipePanel()
    self.recipePanel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISCraftLogicRecipePanel, 0, 0, 10, 10, self.player, self.logic);
    self.recipePanel:initialise();
    self.recipePanel:instantiate();

    self.recipePanelColumn = self.tableLayout:addColumn(nil);
    self.tableLayout:setElement(self.recipePanelColumn:index(), 0, self.recipePanel);
end

function ISCraftLogicPanel:createInventoryPanel()
    -- create inventoryPanelColumn
    self.inventoryPanelColumn = self.tableLayout:addColumn(nil);
    local inventoryTable = ISXuiSkin.build(self.xuiSkin, "S_TableLayout_Middle", ISTableLayout, 0, 0, 10, 10);
    inventoryTable:addColumnFill(nil);
    inventoryTable:initialise();
    inventoryTable:instantiate();    
    self.tableLayout:setElement(self.inventoryPanelColumn:index(), 0, inventoryTable);
    
    -- create main inventoryPanel    
    local mainInventoryRow = inventoryTable:addRowFill(nil);
    self.inventoryPanel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISCraftInventoryPanel, 0, 0, 10, 10, self.player, self.logic);
    self.inventoryPanel:initialise();
    self.inventoryPanel:instantiate();
    self.inventoryPanel.entity = self.entity;
    self.inventoryPanel.isResourceItemSlot = true;
    inventoryTable:setElement(0, mainInventoryRow:index(), self.inventoryPanel);
    
    -- create resource inventoryPanel
    local resourceInventoryRow = inventoryTable:addRowFill(nil);
    self.resourceInventoryPanel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISCraftInventoryPanel, 0, 0, 10, 10, self.player, self.logic);
    self.resourceInventoryPanel:initialise();
    self.resourceInventoryPanel:instantiate();
    self.resourceInventoryPanel.entity = self.entity;
    self.resourceInventoryPanel.isResourceItemSlot = true;
    self.resourceInventoryPanel.showCurrentContents = true;
    inventoryTable:setElement(0, resourceInventoryRow:index(), self.resourceInventoryPanel);
    
    -- set visibility
    self.inventoryPanelColumn.visible = self.logic:shouldShowManualSelectInputs();
end

function ISCraftLogicPanel:createLegacyRecipePanel()
    local resources = ArrayList.new();

    --[[
        LEFT SIDE PANELS
    --]]

    -- Energy Inputs

    resources = self.resourcesComponent:getResourcesFromGroup(self.inputsGroupName, resources, ResourceIO.Input, ResourceType.Energy);

    if resources:size()>0 then
        self.energyInputs = self:createEnergySlotPanel("S_EnergySlotPanel_Inputs");
        self.energyInputs:addResources(resources, nil, nil, nil);

        column = self.tableLayout:addColumn(nil);
        self.tableLayout:setElement(column:index(), 0, self.energyInputs);
    end

    -- Fluid Inputs

    resources = self.resourcesComponent:getResourcesFromGroup(self.inputsGroupName, resources, ResourceIO.Input, ResourceType.Fluid);

    if resources:size()>0 then
        self.fluidInputs = self:createFluidSlotPanel("S_FluidSlotPanel_Inputs");
        --self.fluidInputs:addResources(resourcesAux, "S_FluidSlot_Locked", nil, nil, nil);
        -- TODO resources need variable to define if player can manually edit
        self.fluidInputs:addResources(resources, "S_FluidSlot_Editable", nil, nil, nil);

        column = self.tableLayout:addColumn(nil);
        self.tableLayout:setElement(column:index(), 0, self.fluidInputs);
    end

    --[[
        MIDDLE PANELS
    --]]

    local middleLayout = ISXuiSkin.build(self.xuiSkin, "S_TableLayout_Middle", ISTableLayout, 0, 0, 10, 10); --, columns, rows);
    middleLayout:addColumnFill(nil);
    middleLayout:initialise();
    middleLayout:instantiate();

    column = self.tableLayout:addColumnFill(nil);
    self.tableLayout:setElement(column:index(), 0, middleLayout);

    local addedPanels = false;

    -- Inputs

    if self.inputsGroupName then
        resources = self.resourcesComponent:getResourcesFromGroup(self.inputsGroupName, resources, ResourceIO.Input, ResourceType.Item);

        if resources:size()>0 then
            self.itemInputs = self:createItemSlotPanel("S_ItemSlotPanel_Inputs");
            self.itemInputs:addResources(resources, "S_ItemSlot_Input");

            row = middleLayout:addRowFill(nil);
            middleLayout:setElement(0, row:index(), self.itemInputs);
            addedPanels = true;
        end
    end

    if not addedPanels then
        --top filler to center middle panel
        middleLayout:addRowFill(nil);
    end

    -- Progress

    self.craftProgress = ISXuiSkin.build(self.xuiSkin, "S_WidgetCraftProgress_Std", ISWidgetCraftProgress, 0, 0, 10, 10, self.player, self.entity, self, nil);
    self.craftProgress.callbackTarget = self;
    self.craftProgress.onGetProgress = function(_self)
        return _self.component:getProgress();
    end
    self.craftProgress:initialise();
    self.craftProgress:instantiate();

    row = middleLayout:addRow(nil);
    middleLayout:setElement(0, row:index(), self.craftProgress);

    -- Craft Control

    if self.component:getStartMode()==StartMode.Manual then
        self.craftControl = ISXuiSkin.build(self.xuiSkin, "S_WidgetCraftControl_Std", ISWidgetCraftControl,0, 0, 10, 10, self.player, self.entity, self.component, self, nil);
        self.craftControl.callbackTarget = self;
        self.craftControl.onGetIsStartEnabled = function(_self)
            return _self.component:cachedCanStart(_self.player);
        end
        self.craftControl.onStart = function(_self)
            local funcCanStart = function(_player, _entity, _component)
                if not _component:getStartMode()==StartMode.Manual then
                    return false;
                end
                return _component:cachedCanStart(_player);
            end
            local funcStart = function(_player, _entity, _component)
                _component:start(_player);
            end
            ISEntityUI.GenericCraftStart( _self.player, _self.entity, _self.component, funcCanStart, funcStart);
        end
        self.craftControl:initialise();
        self.craftControl:instantiate();

        row = middleLayout:addRow(nil);
        middleLayout:setElement(0, row:index(), self.craftControl);
    end

    -- Craft Control Debug

    if getDebug() and getDebugOptions():getBoolean("Entity.DebugUI") then
        self.craftControlDebug = ISXuiSkin.build(self.xuiSkin, "S_WidgetCraftDebug_Std", ISWidgetCraftDebug,0, 0, 10, 10, self.player, self.entity, self.component, self, nil);
        self.craftControlDebug.callbackTarget = self;
        self.craftControlDebug.onStartDebug = function(_self)
            if _self.component then
                local monitor = _self.component:debugCanStart(_self.player);
                if monitor then
                    ISCraftRecipeMonitor.OnOpenPanel(monitor);
                else
                    print("No craft recipe monitor returned!");
                end
            end
        end
        self.craftControlDebug:initialise();
        self.craftControlDebug:instantiate();

        row = middleLayout:addRow(nil);
        middleLayout:setElement(0, row:index(), self.craftControlDebug);
    end

    --addedPanels = false;
    -- Outputs

    if self.outputsGroupName then
        resources = self.resourcesComponent:getResourcesFromGroup(self.outputsGroupName, resources, ResourceIO.Output, ResourceType.Item);

        if resources:size()>0 then
            self.itemOutputs = self:createItemSlotPanel("S_ItemSlotPanel_Outputs");
            self.itemOutputs:addResources(resources, "S_ItemSlot_Output");

            row = middleLayout:addRowFill(nil);
            middleLayout:setElement(0, row:index(), self.itemOutputs);
            addedPanels = true;
        end
    end

    if not addedPanels then
        --bottom filler to center middle panel
        middleLayout:addRowFill(nil);
    end

    --[[
        RIGHT SIDE PANELS
    --]]

    if self.outputsGroupName then
        -- Fluid Outputs

        resources = self.resourcesComponent:getResourcesFromGroup(self.outputsGroupName, resources, ResourceIO.Output, ResourceType.Fluid);

        if resources:size()>0 then
            self.fluidOutputs = self:createFluidSlotPanel("S_FluidSlotPanel_Outputs");
            --_styleFluidSlot, _styleBtnTransfer, _styleBtnClear, _styleBar
            -- TODO resources need variable to define if player can manually edit
            self.fluidOutputs:addResources(resources, "S_FluidSlot_Editable", nil, nil, nil);
            --self.fluidOutputs:addResources(resourcesAux, "S_FluidSlot_Locked", nil, nil, nil);

            column = self.tableLayout:addColumn(nil);
            self.tableLayout:setElement(column:index(), 0, self.fluidOutputs);
        end

        -- Energy Outputs

        resources = self.resourcesComponent:getResourcesFromGroup(self.outputsGroupName, resources, ResourceIO.Output, ResourceType.Energy);

        if resources:size()>0 then
            self.energyOutputs = self:createEnergySlotPanel("S_EnergySlotPanel_Outputs");
            self.energyOutputs:addResources(resources, nil, nil, nil);

            column = self.tableLayout:addColumn(nil);
            self.tableLayout:setElement(column:index(), 0, self.energyOutputs);
        end
    end
end

function ISCraftLogicPanel:onRecipeChanged(_recipe)
    self.recipesPanel:onRecipeChanged(_recipe);

    self.inventoryPanelColumn.visible = self.logic:shouldShowManualSelectInputs() and self.logic:getRecipe() ~= nil;
    self.recipePanelColumn.visible = self.logic:getRecipe() ~= nil;

    --log(DebugType.CraftLogic, "ISHandCraftPanel -> set recipe and calling recalculate layout");
    self:xuiRecalculateLayout();
end

function ISCraftLogicPanel:onUpdateRecipeList(_recipeList)
    local recipeList = self.logic:getRecipeList();

    self.recipesPanel:onUpdateRecipeList(recipeList);

    if self.recipeCategories and not self.recipeCategories.isInitialised then
        self.recipeCategories:populateCategoryList();
    end
end

function ISCraftLogicPanel:setRecipeListMode(_useListMode)
    self.recipesPanel:setRecipeListMode(_useListMode);
    self.logic:setSelectedRecipeStyle(_useListMode and "list" or "grid");
    self:onUpdateRecipeList();
end

function ISCraftLogicPanel:setRecipeFilter(_filterString)
    self._filterString = _filterString;
    self:filterRecipeList();
end

function ISCraftLogicPanel:filterRecipeList()
    self.logic:filterRecipeList(self._filterString, nil);
    self.recipesPanel:filterRecipeList();
end

function ISCraftLogicPanel:setSortMode(_sortMode)
    self.logic:setRecipeSortMode(_sortMode);
    self:sortRecipeList();
end

function ISCraftLogicPanel:sortRecipeList()
    self.logic:sortRecipeList();
    self.recipesPanel:filterRecipeList();
end

function ISCraftLogicPanel:onShowManualSelectChanged(_showManualSelectInputs)
    self.inventoryPanelColumn:setVisible(_showManualSelectInputs, true);
    
    local colWidth = 0;
    local cell = self.tableLayout:cellFor(self.inventoryPanel);
    if cell then
        cell:calculateLayout(0,0);
        colWidth = cell.width;
    else
        colWidth = self.inventoryPanelColumn.width;
    end

    if _showManualSelectInputs then
        local root = self:xuiRootElement();
        if root then
            self:xuiRecalculateLayout(root:getWidth()+colWidth, root:getHeight(), true, false);
        else
            self:xuiRecalculateLayout();
        end
    else
        self:xuiRecalculateLayout(-colWidth, nil, true, false);
    end
end

function ISCraftLogicPanel:OnCloseWindow()
    if self.logic:shouldShowManualSelectInputs() then
        self:onShowManualSelectChanged(false);
    end
end

function ISCraftLogicPanel:onItemSlotAddItems( _itemSlot, _itemList )
    ISCraftLogicPanel.ItemSlotAddItems( self.player, self.entity, _itemSlot, _itemList, self.logic:getCraftLogic() )
end

function ISCraftLogicPanel.ItemSlotAddItems( _player, _entity, _itemSlot, _itemList, _component )
    if #_itemList>0 and ISEntityUI.WalkToEntity( _player, _entity) then
        for index,item in ipairs(_itemList) do
            local maxItems = math.min(_itemSlot.resource:getFreeItemCapacity(), math.max(0, _component:getFreeOutputSlotCount() - _itemSlot.resource:storedSize()));
            if index<=maxItems then
                local action = ISItemSlotAddAction:new(_player, _entity, item, _itemSlot.resource)
                action.itemSlot = _itemSlot;
                action.component = _component;
                action.canAddItem = function(_self)
                    local freeSlots = _self.component:getFreeOutputSlotCount() - _self.resource:storedSize();
                    return freeSlots > 0;
                end
                ISTimedActionQueue.add(action);
            end
        end
    end
end

--************************************************************************--
--** ISCraftLogicPanel:new
--**
--************************************************************************--
function ISCraftLogicPanel:new(x, y, width, height, player, entity, component, componentUiStyle)
	local o = ISBaseComponentPanel:new(x, y, width, height, player, entity, component, componentUiStyle);
    setmetatable(o, self);
    self.__index = self;

    o.inputsGroupName = component:getInputsGroupName();
    o.outputsGroupName = component:getOutputsGroupName();
    o.resourcesComponent = entity and entity:getComponent(ComponentType.Resources);
    o.craftLogicComponent = component;
    o.logic = CraftLogicUILogic.new(player, entity, component);
    
    o.logic:addEventListener("onRecipeChanged", o.onRecipeChanged, o);
    o.logic:addEventListener("onUpdateRecipeList", o.onUpdateRecipeList, o);
    o.logic:addEventListener("onShowManualSelectChanged", o.onShowManualSelectChanged, o);
    o.logic:addEventListener("onResourceSlotContentsChanged", o.onResourceSlotContentsChanged, o);
    
    return o;
end