--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: spurcival 				   **
--***********************************************************

require "ISUI/ISPanel"

ISCraftLogicRecipePanel = ISPanel:derive("ISCraftLogicRecipePanel");

--************************************************************************--
--** ISCraftLogicRecipePanel:initialise
--**
--************************************************************************--

function ISCraftLogicRecipePanel:initialise()
    ISPanel.initialise(self);
end

function ISCraftLogicRecipePanel:createChildren()
    ISPanel.createChildren(self);

    self.overlayPanel = ISPanel:new (0, 0, 10, 10);
    self.overlayPanel.background = true;
    self.overlayPanel.backgroundColor = {r=0, g=0, b=0, a=0.7};
    self.overlayPanel.borderColor = {r=0.0, g=0.0, b=0.0, a=0};
    self.overlayPanel:initialise();
    self.overlayPanel:instantiate();
    self.overlayPanel:setVisible(false);

    self:addChild(self.overlayPanel);

    --if self.recipe then
    self:createDynamicChildren();
    --end
end

function ISCraftLogicRecipePanel:createDynamicChildren()
    local recipe = self.logic:getRecipe();

    if self.titleWidget then self:removeChild(self.titleWidget); end
    if self.inputControlWidget then self:removeChild(self.inputControlWidget); end
    if self.outputProgressWidget then self:removeChild(self.outputProgressWidget); end
    
    if not recipe then
        self:xuiRecalculateLayout();
        return;
    end

    -- Title
    self.titleWidget = ISXuiSkin.build(self.xuiSkin, "S_WidgetTitleHeader_Std", ISWidgetCraftLogicTitle, 0, 0, 10, 10, self.player, self.logic);
    self.titleWidget:initialise();
    self.titleWidget:instantiate();
    self:addChild(self.titleWidget);
    
    -- Input/Craft control
    self.inputControlWidget = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISWidgetCraftLogicInputControl, 0, 0, 10, 10, self.player, self.logic);
    self.inputControlWidget:initialise();
    self.inputControlWidget:instantiate();
    self:addChild(self.inputControlWidget);

    -- Output / Progress
    self.outputProgressWidget = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISWidgetCraftLogicOutputProgress, 0, 0, 10, 10, self.player, self.logic);
    self.outputProgressWidget:initialise();
    self.outputProgressWidget:instantiate();
    self:addChild(self.outputProgressWidget);

    -- Recalc
    self:xuiRecalculateLayout();
end

function ISCraftLogicRecipePanel:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    -- update min sizes
    self.titleWidget:calculateLayout(0, 0);
    self.inputControlWidget:calculateLayout(0, 0);
    self.outputProgressWidget:calculateLayout(0, 0);
    
    -- get min sizes
    local titleWidgetMinHeight = self.titleWidget:getHeight();
    local inputControlWidgetMinHeight = self.inputControlWidget:getHeight();
    local outputProgressWidgetMinHeight = self.outputProgressWidget:getHeight();    
    local titleWidgetMinWidth = self.titleWidget:getWidth();
    local inputControlWidgetMinWidth = self.inputControlWidget:getWidth();
    local outputProgressWidgetMinWidth = self.outputProgressWidget:getWidth();
    
    local minHeight = titleWidgetMinHeight + inputControlWidgetMinHeight + self.elementSpacing + outputProgressWidgetMinHeight;
    local minWidth = math.max(titleWidgetMinWidth, inputControlWidgetMinWidth, outputProgressWidgetMinWidth);

    width = math.max(width, minWidth);
    height = math.max(height, minHeight);

    -- update sizes
    self.titleWidget:calculateLayout(width, titleWidgetMinHeight);
    self.inputControlWidget:calculateLayout(width, inputControlWidgetMinHeight);
    self.outputProgressWidget:calculateLayout(width, outputProgressWidgetMinHeight);
    
    -- set positions
    local x = 0;
    local y = 0;
    
    self.titleWidget:setX(x);
    self.titleWidget:setY(y);
    
    y = y + self.titleWidget:getHeight();
    self.inputControlWidget:setX(x);
    self.inputControlWidget:setY(y);    
    
    y = y + self.inputControlWidget:getHeight() + self.elementSpacing;
    self.outputProgressWidget:setX(x);
    self.outputProgressWidget:setY(y);

    if self.overlayPanel then
        self.overlayPanel:setWidth(width);
        self.overlayPanel:setHeight(height);
    end

    --print(width)
    self:setWidth(width);
    self:setHeight(height);
end

function ISCraftLogicRecipePanel:onResize()
    ISUIElement.onResize(self)
end

function ISCraftLogicRecipePanel:prerender()
    ISPanel.prerender(self);

    if not self.titleWidget or not self.inputControlWidget then
        return;
    end
    
    local rectWidth = self.width - (self.elementPadding * 2);
    local rectHeight = (self.titleWidget:getHeight() + self.inputControlWidget:getHeight()) - (self.elementPadding * 2);
    self:drawRect(self.elementPadding, self.elementPadding, rectWidth, rectHeight, 0.1, 1, 1, 1);
end

function ISCraftLogicRecipePanel:render()
    ISPanel.render(self);
end

function ISCraftLogicRecipePanel:update()
    ISPanel.update(self);
end

function ISCraftLogicRecipePanel:setOverlayVisible(_b)
    self.overlayPanel:setVisible(_b);
end

function ISCraftLogicRecipePanel:onRecipeChanged()
    self:createDynamicChildren();
    
    if self.inputControlWidget then
        self.inputControlWidget:onRecipeChanged();
    end
end

function ISCraftLogicRecipePanel:getRecipe()
    return self.logic:getRecipe();
end

function ISCraftLogicRecipePanel:onRebuildItemNodes(_inputItems)
    --if self.inputControlWidget then
    --    self.inputControlWidget:onRebuildItemNodes(_inputItems);
    --end
end

function ISCraftLogicRecipePanel:onInputsChanged()
    if self.craftControl then
        self.craftControl:onInputsChanged();
    end
end

function ISCraftLogicRecipePanel:onGainJoypadFocus(joypadData)
    ISPanel.onGainJoypadFocus(self, joypadData)
    joypadData.focus = self.inputs
    updateJoypadFocus(joypadData)
end

function ISCraftLogicRecipePanel:onResourceSlotContentsChanged()
    if self.inputControlWidget then self.inputControlWidget:onResourceSlotContentsChanged(); end
    if self.outputProgressWidget then self.outputProgressWidget:onResourceSlotContentsChanged(); end
    self:calculateLayout(self.width, self.height);
end

--************************************************************************--
--** ISCraftLogicRecipePanel:new
--**
--************************************************************************--
function ISCraftLogicRecipePanel:new(x, y, width, height, player, logic)
    local o = ISPanel.new(self, x, y, width, height);

    o.background = false;
    --o.margin = 5;
    o.player = player;
    
    o.craftLogicComponent = logic:getCraftLogic();
    o.inputsGroupName = o.craftLogicComponent:getInputsGroupName();
    o.outputsGroupName = o.craftLogicComponent:getOutputsGroupName();
    
    o.logic = logic;
    o.logic:addEventListener("onRecipeChanged", o.onRecipeChanged, o);
    o.logic:addEventListener("onRebuildInputItemNodes", o.onRebuildItemNodes, o);
    o.logic:addEventListener("onInputsChanged", o.onInputsChanged, o);
    
    o.entity = logic:getEntity();
    o.resourcesComponent = o.entity:getComponent(ComponentType.Resources);
    
    o.margin = 0;
    o.minimumWidth = 350;
    o.minimumHeight = 0;
    o.elementSpacing = 5;
    o.elementPadding = 2;

    --o.doToolTip = true;

    o.autoFillContents = false;

    -- these may or may not be used by a parent control while calculating layout:
    o.isAutoFill = false;
    o.isAutoFillX = false;
    o.isAutoFillY = false;
    return o;
end