--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISPanel"

ISButcherHookProcessorPanel = ISPanel:derive("ISButcherHookProcessorPanel");

--************************************************************************--
--** ISButcherHookProcessorPanel:initialise
--**
--************************************************************************--

function ISButcherHookProcessorPanel:initialise()
    ISPanel.initialise(self);
end

function ISButcherHookProcessorPanel:createChildren()
    ISPanel.createChildren(self);


    if self.craftProcessor and self.resourceContainer then
        local column, row;
        self.tableLayout = ISXuiSkin.build(self.xuiSkin, "S_TableLayout_Main", ISTableLayout, 0, 0, 10, 10);
        self.tableLayout:addRowFill(nil);
        self.tableLayout:initialise();
        self.tableLayout:instantiate();
        self:addChild(self.tableLayout);

        local resources = ArrayList.new();

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

        resources = self.resourceContainer:getResources(resources, ResourceIO.Input, ResourceType.Item);

        --if resources:size()>0 then
            self.itemInputs = self:createItemSlotPanel("S_ItemSlotPanel_Corpse");
            self.itemInputs:addResource(resources:get(0), "S_ItemSlot_Input");

            row = middleLayout:addRowFill(nil);
            middleLayout:setElement(0, row:index(), self.itemInputs);

            self.itemInputs = self:createItemSlotPanel("S_ItemSlotPanel_Tool");
            self.itemInputs:addResource(resources:get(1), "S_ItemSlot_Input");

            row = middleLayout:addRowFill(nil);
            middleLayout:setElement(0, row:index(), self.itemInputs);
            addedPanels = true;
        --end

        if not addedPanels then
            --top filler to center middle panel
            middleLayout:addRowFill(nil);
        end

        -- Progress

        self.craftProgress = ISXuiSkin.build(self.xuiSkin, "S_WidgetCraftProgress_Std", ISWidgetCraftProgress, 0, 0, 10, 10, self.player, self.entity, self.craftProcessor, nil);
        self.craftProgress:initialise();
        self.craftProgress:instantiate();

        row = middleLayout:addRow(nil);
        middleLayout:setElement(0, row:index(), self.craftProgress);

        -- Recipe Select

        if self.craftProcessor:isManualRecipeSelect() then
            self.craftRecipeSelect = ISXuiSkin.build(self.xuiSkin, "S_WidgetRecipeSelect_Std", ISWidgetRecipeSelect,0, 0, 10, 10, self.player, self.entity, self.component, self.craftProcessor, nil);
            self.craftRecipeSelect:initialise();
            self.craftRecipeSelect:instantiate();

            row = middleLayout:addRow(nil);
            middleLayout:setElement(0, row:index(), self.craftRecipeSelect);
        end

        -- Craft Control

        if self.craftProcessor:getStartMode()==StartMode.Manual then
            self.craftControl = ISXuiSkin.build(self.xuiSkin, "S_WidgetCraftControl_Std", ISWidgetCraftControl,0, 0, 10, 10, self.player, self.entity, self.component, self.craftProcessor, nil);
            self.craftControl:initialise();
            self.craftControl:instantiate();

            row = middleLayout:addRow(nil);
            middleLayout:setElement(0, row:index(), self.craftControl);
        end

        -- Craft Control Debug

        if getDebug() and getDebugOptions():getBoolean("Entity.DebugUI") then
            self.craftControlDebug = ISXuiSkin.build(self.xuiSkin, "S_WidgetCraftDebug_Std", ISWidgetCraftDebug,0, 0, 10, 10, self.player, self.entity, self.component, self.craftProcessor, nil);
            self.craftControlDebug:initialise();
            self.craftControlDebug:instantiate();

            row = middleLayout:addRow(nil);
            middleLayout:setElement(0, row:index(), self.craftControlDebug);
        end

        --addedPanels = false;
        -- Outputs

        resources = self.resourceContainer:getResources(resources, ResourceIO.Output, ResourceType.Item);

        if resources:size()>0 then
            self.itemOutputs = self:createItemSlotPanel("S_ItemSlotPanel_Outputs");
            self.itemOutputs:addResources(resources, "S_ItemSlot_Output");

            row = middleLayout:addRowFill(nil);
            middleLayout:setElement(0, row:index(), self.itemOutputs);
            addedPanels = true;
        end

        if not addedPanels then
            --bottom filler to center middle panel
            middleLayout:addRowFill(nil);
        end

        --[[
            RIGHT SIDE PANELS
        --]]

        -- Fluid Outputs

        --resources = self.resourceContainer:getResources(resources, ResourceIO.Output, ResourceType.Fluid);

        --if resources:size()>0 then
        --    self.fluidOutputs = self:createFluidSlotPanel("S_FluidSlotPanel_Outputs");
        --    --_styleFluidSlot, _styleBtnTransfer, _styleBtnClear, _styleBar
        --    -- TODO resources need variable to define if player can manually edit
        --    self.fluidOutputs:addResources(resources, "S_FluidSlot_Editable", nil, nil, nil);
        --    --self.fluidOutputs:addResources(resourcesAux, "S_FluidSlot_Locked", nil, nil, nil);
        --
        --    column = self.tableLayout:addColumn(nil);
        --    self.tableLayout:setElement(column:index(), 0, self.fluidOutputs);
        --end


        resources = self.resourceContainer:getResources(resources, ResourceIO.Output, ResourceType.Fluid);

        self.fluidOutputs = self:createFluidSlotPanel("S_FluidSlotPanel_AnimalBlood");
        self.fluidOutputs:addResource(resources:get(0), "S_FluidSlot_Editable", nil, nil, nil);
        --self.fluidOutputs:addResources(resourcesAux, "S_FluidSlot_Locked", nil, nil, nil);
        column = self.tableLayout:addColumn(nil);
        self.tableLayout:setElement(column:index(), 0, self.fluidOutputs);

        self.fluidOutputs = self:createFluidSlotPanel("S_FluidSlotPanel_AnimalGrease");
        self.fluidOutputs:addResource(resources:get(1), "S_FluidSlot_Editable", nil, nil, nil);
        --self.fluidOutputs:addResources(resourcesAux, "S_FluidSlot_Locked", nil, nil, nil);
        column = self.tableLayout:addColumn(nil);
        self.tableLayout:setElement(column:index(), 0, self.fluidOutputs);

    end
end

--handle is resource:size()==0
function ISButcherHookProcessorPanel:createItemSlotPanel(_style)
    local panel = ISXuiSkin.build(self.xuiSkin, _style, ISItemSlotPanel, 0,0,20,20, self.player, self.entity, nil, nil);
    --panel.borderText = _title;
    panel:initialise();
    panel:instantiate();

    return panel;
end

function ISButcherHookProcessorPanel:createFluidSlotPanel(_style)
    local panel = ISXuiSkin.build(self.xuiSkin, _style, ISFluidSlotPanel, 0,0,20,20, self.player, self.entity, nil);
    --panel.borderText = _title;
    panel:initialise();
    panel:instantiate();

    return panel;
end

function ISButcherHookProcessorPanel:createEnergySlotPanel(_style)
    local panel = ISXuiSkin.build(self.xuiSkin, _style, ISEnergySlotPanel, 0,0,20,20, self.player, self.entity, nil);
    --panel.borderText = _title;
    panel:initialise();
    panel:instantiate();

    return panel;
end

function ISButcherHookProcessorPanel:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);


    --local x,y = 0,headerHeight;
    if self.tableLayout then
        self.tableLayout:setX(0);
        self.tableLayout:setY(0);
        self.tableLayout:calculateLayout(width, height);

        width = math.max(width, self.tableLayout:getWidth());
        height = math.max(height, self.tableLayout:getHeight());
    end

    self:setWidth(width);
    self:setHeight(height);
end

function ISButcherHookProcessorPanel:onResize()
    ISUIElement.onResize(self)
end

function ISButcherHookProcessorPanel:prerender()
    ISPanel.prerender(self);
end

function ISButcherHookProcessorPanel:render()
    ISPanel.render(self);

    if ISEntityUI.drawDebugLines or self.drawDebugLines then
        self:drawRectBorderStatic(0, 0, self.width, self.height, 1.0, 0, 1, 0);
    end
end

function ISButcherHookProcessorPanel:update()
    ISPanel.update(self);
end


--************************************************************************--
--** ISButcherHookProcessorPanel:new
--**
--************************************************************************--
function ISButcherHookProcessorPanel:new(x, y, width, height, player, entity, component, craftProcessor)
    local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self);
    self.__index = self;

    o.player = player;
    o.entity = entity;
    o.craftProcessor = craftProcessor;
    o.component = component;
    o.resourceContainer = craftProcessor and craftProcessor:getResources();

    o.background = false;

    return o;
end