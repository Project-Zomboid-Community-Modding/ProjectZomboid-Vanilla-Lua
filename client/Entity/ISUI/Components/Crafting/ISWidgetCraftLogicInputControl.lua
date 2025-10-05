--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: spurcival 				   **
--***********************************************************

--[[
    Input and Control widget for CraftLogic based entities
--]]
require "ISUI/ISPanel"

ISWidgetCraftLogicInputControl = ISPanel:derive("ISWidgetCraftLogicInputControl");

function ISWidgetCraftLogicInputControl:initialise()
    ISPanel.initialise(self);
end

function ISWidgetCraftLogicInputControl:createChildren()
    ISPanel.createChildren(self);
    self:createDynamicChildren();
end

function ISWidgetCraftLogicInputControl:createDynamicChildren()
    -- Inputs - Items
    local inputResourceItems = self.inputsGroupName and self.resourcesComponent:getResourcesFromGroup(self.inputsGroupName, ArrayList.new(), ResourceIO.Input, ResourceType.Item) or ArrayList.new();
    if inputResourceItems:size() > 0 then
        self.inputItems = ISXuiSkin.build(self.xuiSkin, "S_ItemSlotPanel_InputsCraftLogic", ISItemSlotPanel, 0, 0, 10, 10, self.player, self.entity, self.logic, nil, nil);
        self.inputItems.resourceType = ResourceType.Item;
        self.inputItems.interactiveMode = true;
        self.inputItems.showSelectInputsButton = true;
        self.inputItems.functionTarget = self;
        self.inputItems.renderRequiredItemCount = true;
        self.inputItems.onSelectInputsButtonClicked = ISWidgetCraftLogicInputControl.onSelectInputsButtonClicked;
        self.inputItems.onItemSlotContentsChanged = ISWidgetCraftLogicInputControl.onItemSlotContentsChanged;
        self.inputItems:initialise();
        self.inputItems:instantiate()
        self:addChild(self.inputItems);
    end

    -- Inputs - Tools
    local showToolsSeparate = false; -- TOOLS cannot work yet as KEEPS does not work for resources. In Discussion - spurcival
    
    local recipeInputs = self.recipe:getInputs();
    local hasTools = false;
    
    if showToolsSeparate then
        for i = 0, recipeInputs:size()-1 do
            local recipeInput = recipeInputs:get(i);
            if recipeInput:isTool() or recipeInput:isKeep() then
                hasTools = true;
                break;
            end
        end
    end
    
    if hasTools and inputResourceItems:size() > 0 then
        self.inputTools = ISXuiSkin.build(self.xuiSkin, "S_ItemSlotPanel_ToolsCraftLogic", ISItemSlotPanel, 0, 0, 10, 10, self.player, self.entity, self.logic, nil, nil);
        self.inputTools.resourceType = ResourceType.Item;
        self.inputTools.interactiveMode = true;
        self.inputTools:initialise();
        self.inputTools:instantiate()
        self:addChild(self.inputTools);
    end

    for i = 0, recipeInputs:size()-1 do
        local recipeInput = recipeInputs:get(i);
        local itemSlot = nil;
        if showToolsSeparate and (recipeInput:isTool() or recipeInput:isKeep()) then
            itemSlot = self.inputTools:addResource(inputResourceItems:get(i), "S_ItemSlot_Input");
        else
            itemSlot = self.inputItems:addResource(inputResourceItems:get(i), "S_ItemSlot_Input");
            itemSlot.onItemDropped = ISCraftLogicPanel.onItemSlotAddItems; --when items dragged under mouse are dropped in box
        end
        itemSlot.inputScript = recipeInput;
        itemSlot.showPreviewItem = true;
    end
    local missingSlotCount = inputResourceItems:size() - recipeInputs:size();
    for i = 1, missingSlotCount do
        local itemSlot = self.inputItems:addResource(inputResourceItems:get(i), "S_ItemSlot_Input");
        itemSlot.onItemDropped = ISCraftLogicPanel.onItemSlotAddItems; --when items dragged under mouse are dropped in box
    end

    -- Inputs - Full Label
    local badColor = getCore():getBadHighlitedColor()
    self.inputsFullLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, -1, getText("EC_CraftLogic_Inputs_Full"), badColor:getR(), badColor:getG(), badColor:getB(), 1, UIFont.Small, true);
    self.inputsFullLabel:initialise();
    self.inputsFullLabel:instantiate();
    self:addChild(self.inputsFullLabel);

    -- Control
    self.controlWidget = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISWidgetCraftLogicControl, 0, 0, 10, 10, self.player, self.logic, self.entity);
    self.controlWidget.interactiveMode = true;
    self.controlWidget.allowBatchCraft = self.logic:getCraftLogic():getStartMode() == StartMode.Automatic; 
    self.controlWidget:initialise();
    self.controlWidget:instantiate();

    self:addChild(self.controlWidget);
    
    -- Outputs - Items
    local recipeOutputs = self.recipe:getOutputs();
    if recipeOutputs:size() > 0 then
        self.outputItems = ISXuiSkin.build(self.xuiSkin, "S_ItemSlotPanel_OutputsCraftLogic", ISItemSlotPanel, 0, 0, 10, 10, self.player, self.entity, nil, nil);
        self.outputItems.isOutput = true;
        self.outputItems.resourceType = ResourceType.Item;
        self.outputItems.interactiveMode = false;
        self.outputItems.renderItemCount = true;
        self.outputItems.drawTooltip = function(_itemSlot, _tooltip) self.logic:doPreviewSlotTooltip(_itemSlot, _tooltip); end;
        self.outputItems:initialise();
        self.outputItems:instantiate();        
        self:addChild(self.outputItems);
    end

    self:updateOutputItems();
    
    -- Outputs - Duration
    self.durationLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, -1, getText("EC_CraftLogic_Duration_Unknown"), 1, 1, 1, 1, UIFont.Small, true);
    self.durationLabel:initialise();
    self.durationLabel:instantiate();    
    self:addChild(self.durationLabel);

    if self.durationLabel then
        if self.logic and self.logic:getRecipe() then
            local seconds = self.logic:getRecipe():getTime(self.player);

            local ss = math.fmod(seconds, 60);
            local mm = math.fmod(seconds / 60, 60);
            local hh = math.fmod(seconds / 3600, 24);
            local dd = math.floor(seconds / 86400);
            
            local text = string.format(getText("EC_CraftLogic_Duration", "%02dd %02dh %02dm %02ds"):gsub('\\n', '\n'), dd, hh, mm, ss);
            self.durationLabel:setName(text)
            self.durationLabel:setHeightToName(0)
        else
            self.durationLabel:setName(getText("EC_CraftLogic_Duration_Unknown"));
        end
    end
end

function ISWidgetCraftLogicInputControl:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);
    --
    
    -- get elements to figure out how big they want to be
    if self.inputItems then self.inputItems:calculateLayout(0, 0); end
    if self.inputTools then self.inputTools:calculateLayout(0, 0); end
    if self.outputItems then self.outputItems:calculateLayout(0, 0); end
    self.durationLabel:setWidthToName(0);
    self.durationLabel:setHeightToName(0);
    self.controlWidget:calculateLayout(0, 0);
    
    -- get min width for each element
    local inputItemsMinW = self.inputItems and self.inputItems:getWidth() or 0;
    local inputToolsMinW = self.inputTools and self.inputTools:getWidth() or 0;
    local inputFullLabelMinW = self.inputsFullLabel and self.inputsFullLabel:getWidth() or 0;
    local outputItemsMinW = self.outputItems and self.outputItems:getWidth() or 0;
    local durationLabelMinW = self.durationLabel:getWidth();
    local controlWidgetMinW = self.controlWidget:getWidth();

    local controlColWidth = math.max(durationLabelMinW, controlWidgetMinW);
    local minimumWidth = (math.max(inputItemsMinW, inputToolsMinW, outputItemsMinW, inputFullLabelMinW) * 2) + math.max(durationLabelMinW, controlWidgetMinW) + (self.elementSpacing * 2);
    width = math.max(width, minimumWidth);
    
    -- get min height for each element
    local inputItemsMinH = self.inputItems and self.inputItems:getHeight() or 0;
    local inputToolsMinH = self.inputTools and self.inputTools:getHeight() or 0;
    local inputFullLabelMinH = self.inputsFullLabel and self.inputsFullLabel:getHeight() or 0;
    local outputItemsMinH = self.outputItems and self.outputItems:getHeight() or 0;
    local durationLabelMinH = self.durationLabel:getHeight();
    local controlWidgetMinH = self.controlWidget:getHeight();

    local inputColHeight = inputItemsMinH + self.elementSpacing + inputToolsMinH + self.elementSpacing + inputFullLabelMinH;
    local controlColHeight = durationLabelMinH + controlWidgetMinH + self.elementSpacing;
    local minimumHeight = math.max(inputColHeight, controlColHeight, outputItemsMinH) + self.marginTop + self.marginBottom;
    height = math.max(height, minimumHeight);

    -- resize elements to fit
    local sideColWidth = (width - (self.elementSpacing * 2) - controlColWidth) / 2;
    local inputHeight = (height - self.elementSpacing - self.marginTop - self.marginBottom) / (self.inputItems and self.inputTools and 2 or 1);
    local outputHeight = (height - self.marginTop - self.marginBottom);
    local controlWidgetHeight = height - self.elementSpacing - durationLabelMinH - self.marginTop - self.marginBottom;
    
    if self.inputItems then self.inputItems:calculateLayout(sideColWidth, inputHeight); end
    if self.inputTools then self.inputTools:calculateLayout(sideColWidth, inputHeight); end
    if self.outputItems then self.outputItems:calculateLayout(sideColWidth, outputHeight); end
    self.controlWidget:calculateLayout(self.controlWidget:getWidth(), controlWidgetHeight);
    
    -- position elements
    local x = 0;
    local y = self.marginTop;

    if self.inputItems then 
        self.inputItems:setX(x); 
        self.inputItems:setY(y);
        y = y + self.inputItems:getHeight() + self.elementSpacing;
    end
    if self.inputTools then 
        self.inputTools:setX(x); 
        self.inputTools:setY(y);
        y = y + self.inputTools:getHeight() + self.elementSpacing;
    end
    if self.inputsFullLabel then
        local labelX = x + (sideColWidth - self.inputsFullLabel:getWidth())/2;
        local labelY = y - self.elementSpacing - self.inputsFullLabel:getHeight();
        self.inputsFullLabel:setX(labelX);
        self.inputsFullLabel:setY(labelY);
    end
    
    x = x + sideColWidth + self.elementSpacing;
    y = self.marginTop;
    
    local controlWidgetOffset = (self.controlWidget:getWidth() < controlColWidth) and ((controlColWidth - self.controlWidget:getWidth()) / 2) or 0;
    self.controlWidget:setX(x + controlWidgetOffset);
    self.controlWidget:setY(y);
    y = y + controlWidgetHeight + self.elementSpacing;
    
    local durationLabelOffset = (self.durationLabel:getWidth() < controlColWidth) and ((controlColWidth - self.durationLabel:getWidth()) / 2) or 0;
    self.durationLabel:setX(x + durationLabelOffset);
    self.durationLabel:setY(y);
    
    x = x + controlColWidth + self.elementSpacing;
    y = self.marginTop;
    if self.outputItems then
        self.outputItems:setX(x);
        self.outputItems:setY(y);
    end
    
    --
    self:setWidth(width);
    self:setHeight(height);
end

function ISWidgetCraftLogicInputControl:onResize()
    ISUIElement.onResize(self)
end

function ISWidgetCraftLogicInputControl:prerender()
    ISPanel.prerender(self);
end

function ISWidgetCraftLogicInputControl:render()
    ISPanel.render(self);
end

function ISWidgetCraftLogicInputControl:update()
    ISPanel.update(self);
end

function ISWidgetCraftLogicInputControl:onSelectInputsButtonClicked( _itemSlot )
    -- check if we are already the active button
    local itemFilter = _itemSlot.inputScript;
    if self.logic:getManualSelectInputScriptFilter() == itemFilter then
        -- we are active - close the manual inputs panel
        self.logic:setShowManualSelectInputs(false);
        self.logic:setManualSelectInputScriptFilter(nil, nil);
        return;
    end

    self.logic:setManualSelectInputScriptFilter(itemFilter, _itemSlot);
    self.logic:setShowManualSelectInputs(true);
end

function ISWidgetCraftLogicInputControl:onItemSlotContentsChanged( _itemSlot )
    self.logic:onResourceSlotContentsChanged();
end

function ISWidgetCraftLogicInputControl:onResourceSlotContentsChanged()
    self:updateOutputItems();
    self.controlWidget:onInputsChanged();
    self:calculateLayout(self.width, self.height);
end

function ISWidgetCraftLogicInputControl:updateOutputItems()
    -- update output teaser
    self.outputItems:removeAllSlots();
    local outputItems = self.logic:getOutputItems();
    local itemCount = 0
    self.outputItemCount = 0;
    for item,count in pairs(outputItems) do
        local slot = self.outputItems:addDisplayItem(item, "S_ItemSlot_OutputAux");
        slot.overrideItemCount = count;
        self.outputItemCount = self.outputItemCount + count;
        itemCount = itemCount + 1;
    end
    
    local recipeOutputs = self.recipe:getOutputs();
    local unfilledCount = recipeOutputs:size() - itemCount;
    for i = 1, unfilledCount do
        self.outputItems:addDisplayEmptySlot("S_ItemSlot_OutputAux");
    end

    -- SET INPUTS FULL VISIBILITY
    --self.inputsFullLabel:setVisible(self.logic:getCraftLogic():getFreeOutputSlotCount() <= self.outputItemCount); -- this is the more correct way of doing this - but using the method below for now, as its only used for 1:1 drying - spurcival
    local resourceCount = 0;
    local inputResourceItems = self.inputsGroupName and self.resourcesComponent:getResourcesFromGroup(self.inputsGroupName, ArrayList.new(), ResourceIO.Input, ResourceType.Item) or ArrayList.new();
    for i = 0, inputResourceItems:size()-1 do
        resourceCount = resourceCount + inputResourceItems:get(i):getItemAmount();
    end
    self.inputsFullLabel:setVisible(self.logic:getCraftLogic():getFreeOutputSlotCount() <= resourceCount);
end

function ISWidgetCraftLogicInputControl:onRecipeChanged()
    if self.logic:shouldShowManualSelectInputs() then
        local slots = self.inputItems:getItemSlots();
        if #slots > 0 then
            self.inputItems:onSelectInputsButton(slots[1]);
            --self:onSelectInputsButtonClicked(slots[1]);
        end
    end
end

--************************************************************************--
--** ISWidgetCraftLogicInputControl:new
--**
--************************************************************************--
function ISWidgetCraftLogicInputControl:new(x, y, width, height, player, logic)
    local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self

    o.player = player;
    o.recipe = logic:getRecipe();
    o.logic = logic;
    o.entity = logic:getEntity();
    o.resourcesComponent = o.entity:getComponent(ComponentType.Resources);
    o.craftLogicComponent = logic:getCraftLogic();
    
    o.inputsGroupName = o.craftLogicComponent:getInputsGroupName();
    o.outputsGroupName = o.craftLogicComponent:getOutputsGroupName();

    o.elementSpacing = 0;
    
    o.paddingTop = 2;
    o.paddingBottom = 2;
    o.paddingLeft = 2;
    o.paddingRight = 2;
    o.marginTop = 5;
    o.marginBottom = 5;
    o.marginLeft = 5;
    o.marginRight = 5;

    o.colWhite = { r=1.0, g=1.0, b=1.0, a=1.0 }
    o.colGood = {
        r=getCore():getGoodHighlitedColor():getR(),
        g=getCore():getGoodHighlitedColor():getG(),
        b=getCore():getGoodHighlitedColor():getB(),
        a=getCore():getGoodHighlitedColor():getA(),
    }
    o.colBad = {
        r=getCore():getBadHighlitedColor():getR(),
        g=getCore():getBadHighlitedColor():getG(),
        b=getCore():getBadHighlitedColor():getB(),
        a=getCore():getBadHighlitedColor():getA(),
    }
    
    o.backgroundColor = { r=1.0, g=1.0, b=1.0, a=0.2 };
    o.outputItemCount = 0;

    return o
end