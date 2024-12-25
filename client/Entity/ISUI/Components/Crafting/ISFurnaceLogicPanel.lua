--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

--[[
    Default panel for CraftLogic component.
--]]

require "Entity/ISUI/Components/ISBaseComponentPanel";

ISFurnaceLogicPanel = ISBaseComponentPanel:derive("ISFurnaceLogicPanel");

function ISFurnaceLogicPanel.CanCreatePanelFor(_player, _entity, _component, _componentUiScript)
    if _player and _entity and _component then
        return _component:getComponentType()==ComponentType.FurnaceLogic;
    end
end

--************************************************************************--
--** ISFurnaceLogicPanel:initialise
--**
--************************************************************************--

function ISFurnaceLogicPanel:initialise()
	ISBaseComponentPanel.initialise(self);
end

function ISFurnaceLogicPanel:createChildren()
    ISBaseComponentPanel.createChildren(self);

    self:createComponentHeader(self.xuiSkin, "S_WidgetComponentHeader_Std", false, nil, nil);

    if self.resourcesComponent then
        local column, row;
        self.tableLayout = ISXuiSkin.build(self.xuiSkin, "S_TableLayout_Main", ISTableLayout, 0, 0, 10, 10);
        self.tableLayout:addColumnFill(nil);
        self.tableLayout:initialise();
        self.tableLayout:instantiate();
        self:addChild(self.tableLayout);

        local resources = ArrayList.new();

        -- Furnace Inputs

        resources = self.resourcesComponent:getResourcesFromGroup(self.furnaceInputsGroupName, resources, ResourceIO.Input, ResourceType.Item);

        if resources:size()>0 then
            self.furnaceInputs = self:createItemSlotPanel("S_ItemSlotPanel_Inputs", true);
            self.furnaceInputs:addResources(resources, "S_ItemSlot_Input", nil, nil);

            row = self.tableLayout:addRowFill(nil);
            self.tableLayout:setElement(0, row:index(), self.furnaceInputs);
        end

        -- Furnace Outputs

        resources = self.resourcesComponent:getResourcesFromGroup(self.furnaceOutputsGroupName, resources, ResourceIO.Output, ResourceType.Item);

        if resources:size()>0 then
            self.furnaceOutputs = self:createItemSlotPanel("S_ItemSlotPanel_Outputs", true);
            self.furnaceOutputs:addResources(resources, "S_ItemSlot_Output", nil, nil);

            row = self.tableLayout:addRowFill(nil);
            self.tableLayout:setElement(0, row:index(), self.furnaceOutputs);
        end

        --[[
            INNER FUEL TABLE
        --]]

        self.fuelTableLayout = ISXuiSkin.build(self.xuiSkin, "S_TableLayout_Main", ISTableLayout, 0, 0, 10, 10);
        self.fuelTableLayout:addRowFill(nil);
        self.fuelTableLayout:initialise();
        self.fuelTableLayout:instantiate();

        row = self.tableLayout:addRow(nil);
        self.tableLayout:setElement(0, row:index(), self.fuelTableLayout);

        -- Fuel Inputs

        resources = self.resourcesComponent:getResourcesFromGroup(self.fuelInputsGroupName, resources, ResourceIO.Input, ResourceType.Item);

        if resources:size()>0 then
            self.fuelInputs = self:createItemSlotPanel("S_ItemSlotPanel_InputsFuel");
            self.fuelInputs:addResources(resources, "S_ItemSlot_Input", nil, nil);

            column = self.fuelTableLayout:addColumn(nil);
            self.fuelTableLayout:setElement(column:index(), 0, self.fuelInputs);
        end

        --[[
            MIDDLE PANELS
        --]]

        local middleLayout = ISXuiSkin.build(self.xuiSkin, "S_TableLayout_Middle", ISTableLayout, 0, 0, 10, 10); --, columns, rows);
        middleLayout:addColumnFill(nil);
        middleLayout:initialise();
        middleLayout:instantiate();

        column = self.fuelTableLayout:addColumnFill(nil);
        self.fuelTableLayout:setElement(column:index(), 0, middleLayout);

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
                return _self.component:canStart(_self.player);
            end
            self.craftControl.onStart = function(_self)
                local funcCanStart = function(_player, _entity, _component)
                    if not _component:getStartMode()==StartMode.Manual then
                        return false;
                    end
                    return _component:canStart(_player);
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

        -- Fuel Inputs

        resources = self.resourcesComponent:getResourcesFromGroup(self.fuelOutputsGroupName, resources, ResourceIO.Output, ResourceType.Item);

        if resources:size()>0 then
            self.fuelOutputs = self:createItemSlotPanel("S_ItemSlotPanel_OutputsFuel");
            self.fuelOutputs:addResources(resources, "S_ItemSlot_Output", nil, nil);

            column = self.fuelTableLayout:addColumn(nil);
            self.fuelTableLayout:setElement(column:index(), 0, self.fuelOutputs);
        end
    end
end

--handle is resource:size()==0
function ISFurnaceLogicPanel:createItemSlotPanel(_style, _drawProgress)
    local panel = ISXuiSkin.build(self.xuiSkin, _style, ISItemSlotPanel, 0,0,20,20, self.player, self.entity, nil, nil);
    panel.drawProgress = _drawProgress;
    --panel.borderText = _title;
    panel:initialise();
    panel:instantiate();

    return panel;
end

function ISFurnaceLogicPanel:createFluidSlotPanel(_style)
    local panel = ISXuiSkin.build(self.xuiSkin, _style, ISFluidSlotPanel, 0,0,20,20, self.player, self.entity, nil);
    --panel.borderText = _title;
    panel:initialise();
    panel:instantiate();

    return panel;
end

function ISFurnaceLogicPanel:createEnergySlotPanel(_style)
    local panel = ISXuiSkin.build(self.xuiSkin, _style, ISEnergySlotPanel, 0,0,20,20, self.player, self.entity, nil);
    --panel.borderText = _title;
    panel:initialise();
    panel:instantiate();

    return panel;
end

function ISFurnaceLogicPanel:calculateLayout(_preferredWidth, _preferredHeight)
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

function ISFurnaceLogicPanel:onResize()
    ISUIElement.onResize(self)
end

function ISFurnaceLogicPanel:prerender()
    ISBaseComponentPanel.prerender(self);
end

function ISFurnaceLogicPanel:render()
    ISBaseComponentPanel.render(self);

    if ISEntityUI.drawDebugLines or self.drawDebugLines then
        self:drawRectBorderStatic(0, 0, self.width, self.height, 1.0, 0, 1, 0);
    end
end

function ISFurnaceLogicPanel:update()
    ISBaseComponentPanel.update(self);
end


--************************************************************************--
--** ISFurnaceLogicPanel:new
--**
--************************************************************************--
function ISFurnaceLogicPanel:new(x, y, width, height, player, entity, component, componentUiStyle)
	local o = ISBaseComponentPanel:new(x, y, width, height, player, entity, component, componentUiStyle);
    setmetatable(o, self);
    self.__index = self;

    o.furnaceInputsGroupName = component:getFurnaceInputsGroupName();
    o.furnaceOutputsGroupName = component:getFurnaceOutputsGroupName();
    o.fuelInputsGroupName = component:getFuelInputsGroupName();
    o.fuelOutputsGroupName = component:getFuelOutputsGroupName();
    o.resourcesComponent = entity and entity:getComponent(ComponentType.Resources);

    return o;
end