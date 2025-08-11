--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: spurcival 				   **
--***********************************************************

--[[
    Input and Control widget for CraftLogic based entities
--]]
require "ISUI/ISPanel"

local FONT_SCALE = getTextManager():getFontHeight(UIFont.Small) / 19; -- normalize to 1080p
local ICON_SCALE = math.max(1, (FONT_SCALE - math.floor(FONT_SCALE)) < 0.5 and math.floor(FONT_SCALE) or math.ceil(FONT_SCALE));
local BUTTON_SIZE = getTextManager():getFontHeight(UIFont.Small);

ISWidgetCraftLogicOutputProgress = ISPanel:derive("ISWidgetCraftLogicOutputProgress");

function ISWidgetCraftLogicOutputProgress:initialise()
    ISPanel.initialise(self);
end

function ISWidgetCraftLogicOutputProgress:createChildren()
    ISPanel.createChildren(self);
    self:createDynamicChildren();
end

function ISWidgetCraftLogicOutputProgress:createDynamicChildren()
    -- Top Row - Title
    local fontHeight = -1; -- <=0 sets label initial height to font
    local entityName = self.entity:getEntityDisplayName();
    self.entityTitle = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, entityName, 1, 1, 1, 1, UIFont.Small, true);
    self.entityTitle.origTitleStr = entityName;
    self.entityTitle:initialise();
    self.entityTitle:instantiate();
    self.entityTitle:setHeightToName(0);
    self:addChild(self.entityTitle);
    
    -- Middle Row - In Progress Inputs
    local recipeInputs = self.recipe:getInputs();
    if recipeInputs:size() > 0 then
        self.progressItems = ISXuiSkin.build(self.xuiSkin, "S_ItemSlotPanel_InputsInProgressCraftLogic", ISItemSlotPanel, 0, 0, 10, 10, self.player, self.entity, nil, nil);
        self.progressItems.resourceType = ResourceType.Item;
        self.progressItems.interactiveMode = false;
        self.progressItems.drawProgress = true;
        self.progressItems.drawTooltip = function(_itemSlot, _tooltip) self.logic:doProgressSlotTooltip(_itemSlot, _tooltip); end;
        self.progressItems:initialise();
        self.progressItems:instantiate()
        self:addChild(self.progressItems);
    end

    -- Middle Row - Entity Icon
    local entityIcon = self.logic:getEntityIcon();
    self.entityIconWidget = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISImage, 0, 0, self.entityIconSize, self.entityIconSize, entityIcon);
    self.entityIconWidget.autoScale = true;
    self.entityIconWidget:initialise();
    self.entityIconWidget:instantiate();

    self:addChild(self.entityIconWidget);
    
    -- Middle Row - Outputs
    local outputItems = self.outputsGroupName and self.resourcesComponent:getResourcesFromGroup(self.outputsGroupName, ArrayList.new(), ResourceIO.Output, ResourceType.Item) or ArrayList.new();
    if outputItems:size() > 0 then
        self.outputItems = ISXuiSkin.build(self.xuiSkin, "S_ItemSlotPanel_CompletedCraftLogic", ISItemSlotPanel, 0, 0, 10, 10, self.player, self.entity, nil, nil);
        self.outputItems.resourceType = ResourceType.Item;
        self.outputItems.interactiveMode = true;
        self.outputItems.allowDrop = false;
        self.outputItems:initialise();
        self.outputItems:instantiate()

        self.outputItems:addResources(outputItems, "S_ItemSlot_Output");

        self:addChild(self.outputItems);
    end
    
    -- Bottom Row - Take Button
    self.buttonTake = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, BUTTON_SIZE * 1.5, BUTTON_SIZE, getText("IGUI_invpage_Loot_all"))
    self.buttonTake.font = UIFont.Small;
    self.buttonTake.target = self;
    self.buttonTake.onclick = ISWidgetCraftLogicOutputProgress.takeAllOutputs;
    self.buttonTake.enable = true;
    self.buttonTake:initialise();
    self.buttonTake:instantiate();

    self:addChild(self.buttonTake);

    self:updateProgressItems();
end

function ISWidgetCraftLogicOutputProgress:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);
    --

    -- get elements to figure out how big they want to be
    if self.progressItems then self.progressItems:calculateLayout(0, 0); end
    if self.outputItems then self.outputItems:calculateLayout(0, 0); end
    self.buttonTake:setWidthToTitle(0);
    self.entityTitle:setWidthToName(0);
    self.entityTitle:setHeightToName(0);
    
    -- get min widths
    local outputItemsMinW = self.outputItems and self.outputItems:getWidth() or 0;
    local progressItemsMinW = self.progressItems and self.progressItems:getWidth() or 0;
    local colMinW = math.max(outputItemsMinW, self.buttonTake:getWidth(), progressItemsMinW);
    local contentMinW = (colMinW * 2) + self.entityIconWidget:getWidth() + (self.elementSpacing * 2);
    local minimumWidth = math.max(self.entityTitle:getWidth(), contentMinW);
    width = math.max(width, minimumWidth);
    
    -- get min heights
    local outputItemsMinH = self.outputItems and self.outputItems:getHeight() or 0;
    local progressItemsMinH = self.progressItems and self.progressItems:getHeight() or 0;
    local middleRowMinH = math.max(outputItemsMinH, progressItemsMinH, self.entityIconWidget:getHeight());
    local minimumHeight = self.entityTitle:getHeight() + self.elementSpacing + middleRowMinH + self.elementSpacing + self.buttonTake:getHeight() + self.marginTop + self.marginBottom;
    height = math.max(height, minimumHeight);
    
    -- resize elements
    local colWidth = (width - self.entityIconWidget:getWidth() - (self.elementSpacing * 2)) / 2;
    if self.progressItems then self.progressItems:calculateLayout(colWidth, middleRowMinH); end
    if self.outputItems then self.outputItems:calculateLayout(colWidth, middleRowMinH); end

    -- set positions
    local x = 0;
    local y = self.marginTop;
    
    x = (width - self.entityTitle:getWidth()) / 2;
    self.entityTitle:setX(x);
    self.entityTitle:setY(y);
    
    x = 0;
    y = y + self.entityTitle:getHeight() + self.elementSpacing;
    if self.progressItems then
        self.progressItems:setX(x);
        self.progressItems:setY(y);
    end
    
    x = x + colWidth + self.elementSpacing;
    
    local iconY = y + ((middleRowMinH - self.entityIconWidget:getHeight()) / 2);
    self.entityIconWidget:setX(x);
    self.entityIconWidget:setY(iconY);
    x = x + self.entityIconWidget:getWidth() + self.elementSpacing;

    if self.outputItems then
        self.outputItems:setX(x);
        self.outputItems:setY(y);
    end
    
    x = x + ((colWidth - self.buttonTake:getWidth()) / 2);
    y = y + middleRowMinH + self.elementSpacing;
    self.buttonTake:setX(x);
    self.buttonTake:setY(y);    

    --
    self:setWidth(width);
    self:setHeight(height);
end

function ISWidgetCraftLogicOutputProgress:onResize()
    ISUIElement.onResize(self)
end

function ISWidgetCraftLogicOutputProgress:prerender()
    ISPanel.prerender(self);
end

function ISWidgetCraftLogicOutputProgress:render()
    ISPanel.render(self);
end

function ISWidgetCraftLogicOutputProgress:update()
    ISPanel.update(self);

    if self.craftInProgress ~= self.craftLogicComponent:isRunning() then
        self.craftInProgress = self.craftLogicComponent:isRunning();
        self:updateProgressItems();
    end

    local progressSlots = self.progressItems:getItemSlots();
    for i = 1, #progressSlots do
        progressSlots[i].progressDelta = self.craftLogicComponent:getProgress()
        progressSlots[i]:setStatusIcons(self.logic:getStatusIconsForItemInProgress(i))
    end
end

function ISWidgetCraftLogicOutputProgress:updateProgressItems()
    self.progressItems:removeAllSlots();
    local progressItems = self.logic:getItemsInProgress();
    for i = 0, progressItems:size()-1 do
        self.progressItems:addDisplayInventoryItem(progressItems:get(i), "S_ItemSlot_InputAux");
    end

    local recipeInputs = self.recipe:getInputs();
    local unfilledCount = recipeInputs:size() - progressItems:size();
    for i = 1, unfilledCount do
        self.progressItems:addDisplayEmptySlot("S_ItemSlot_OutputAux");
    end
    
    self:calculateLayout(self.width, self.height);
end

function ISWidgetCraftLogicOutputProgress:takeAllOutputs()
    if ISEntityUI.WalkToEntity( self.player, self.entity) then
        local outputSlots = self.outputItems:getItemSlots();
        for i = 1, #outputSlots do
            for j = 0, outputSlots[i].resource:getItemAmount()-1 do
                local action = ISItemSlotRemoveAction:new(self.player, self.entity, outputSlots[i].resource)
                action.itemSlot = outputSlots[i];
                ISTimedActionQueue.add(action);
            end
        end
    end
end
    
--************************************************************************--
--** ISWidgetCraftLogicOutputProgress:new
--**
--************************************************************************--
function ISWidgetCraftLogicOutputProgress:new(x, y, width, height, player, logic)
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

    o.entityIconSize = 48 * ICON_SCALE;

    o.craftInProgress = false;

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

    return o
end