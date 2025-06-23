--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISPanel"

ISCraftRecipePanel = ISPanel:derive("ISCraftRecipePanel");

--************************************************************************--
--** ISCraftRecipePanel:initialise
--**
--************************************************************************--

function ISCraftRecipePanel:initialise()
	ISPanel.initialise(self);
end

function ISCraftRecipePanel:createChildren()
    ISPanel.createChildren(self);

    local styleCell = "S_TableLayoutCell_Pad2";
    self.rootTable = ISXuiSkin.build(self.xuiSkin, "S_TableLayout_Main", ISTableLayout, 0, 0, 10, 10, nil, nil, styleCell);
    --self.rootTable:addColumnFill(nil);
    self.rootTable:initialise();
    self.rootTable:instantiate();
    self:addChild(self.rootTable);

    self.overlayPanel = ISPanel:new (0, 0, 10, 10);
	self.overlayPanel.background = true;
	self.overlayPanel.backgroundColor = {r=0, g=0, b=0, a=0.7};
    self.overlayPanel.borderColor = {r=0.0, g=0.0, b=0.0, a=0};
    self.overlayPanel:initialise();
    self.overlayPanel:instantiate();
    self.overlayPanel:setVisible(false);

    self:addChild(self.overlayPanel);

    if self.recipe then
        self:createDynamicChildren();
    end
end

function ISCraftRecipePanel:createDynamicChildren()
    self.rootTable:clearTable();

    local recipe = self.logic:getRecipe();

    if not recipe then
        self:xuiRecalculateLayout();
        return;
    end

    self.rootTable:addColumnFill(nil);

    local column, row;

    local favString = BaseCraftingLogic.getFavouriteModDataString(recipe);
    local isFavourite = self.player:getModData()[favString] or false;

    self.titleWidget = ISXuiSkin.build(self.xuiSkin, "S_WidgetTitleHeader_Std", ISWidgetTitleHeader, 0, 0, 10, 10, recipe, self.player, self.logic, isFavourite);
    self.titleWidget:initialise();
    self.titleWidget:instantiate();

    row = self.rootTable:addRow();
    self.rootTable:setElement(0, row:index(), self.titleWidget);

    --filler row
    self.rootTable:addRowFill(nil);

    -- inputs
    self.inputs = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISWidgetIngredientsInputs, 0, 0, 10, 10, self.player, self.logic); --self.recipeData, self.craftBench);
    self.inputs.interactiveMode = true;
    self.inputs:initialise();
    self.inputs:instantiate();

    row = self.rootTable:addRow();
    self.rootTable:setElement(0, row:index(), self.inputs); 
    
    -- outputs
    self.outputs = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISWidgetIngredientsOutputs, 0, 0, 10, 10, self.player, self.logic); --self.recipeData, self.craftBench);
    self.outputs.interactiveMode = true;
    self.outputs:initialise();
    self.outputs:instantiate();

    if #self.outputs.outputs > 0 then
        -- we have some outputs to show
        row = self.rootTable:addRow();
        self.rootTable:setElement(0, row:index(), self.outputs);
    else
        -- no outputs, kill the element
        self.outputs = nil;
    end

    --filler row
    self.rootTable:addRowFill(nil);

    -- craft control
    self.craftControl = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISWidgetHandCraftControl, 0, 0, 10, 10, self.player, self.logic); --self.recipeData, self.craftBench, self.isoObject);
    self.craftControl.interactiveMode = true;
    self.craftControl.allowBatchCraft = recipe:isAllowBatchCraft();
    self.craftControl:initialise();
    self.craftControl:instantiate();

    row = self.rootTable:addRow();
    self.rootTable:setElement(0, row:index(), self.craftControl);

    self:xuiRecalculateLayout();
end

function ISCraftRecipePanel:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    --local x,y = 0,headerHeight;
    if self.rootTable then
        self.rootTable:setX(0);
        self.rootTable:setY(0);
        self.rootTable:calculateLayout(width, height);

        self.titleWidget:setY(0);

        width = math.max(width, self.rootTable:getWidth());
        height = math.max(height, self.rootTable:getHeight());
    end

    self.overlayPanel:setWidth(width);
    self.overlayPanel:setHeight(height);

    --print(width)
    self:setWidth(width);
    self:setHeight(height);
end

function ISCraftRecipePanel:onResize()
    ISUIElement.onResize(self)
end

function ISCraftRecipePanel:prerender()
    ISPanel.prerender(self);
end

function ISCraftRecipePanel:render()
    ISPanel.render(self);
end

function ISCraftRecipePanel:update()
    ISPanel.update(self);
end

function ISCraftRecipePanel:setOverlayVisible(_b)
    self.overlayPanel:setVisible(_b);
end

function ISCraftRecipePanel:onRecipeChanged()
    self:createDynamicChildren();
    --[[
    if ((not self.recipe) and _recipe) or self.recipe~=_recipe then
        self.recipe = _recipe;
        self:createDynamicChildren();
    end
    --]]
    if self.inputs then
        self.inputs:onRecipeChanged();
    end
end

function ISCraftRecipePanel:getRecipe()
    return self.logic:getRecipe();
end

function ISCraftRecipePanel:onRebuildItemNodes(_inputItems)
    if self.inputs then
        self.inputs:onRebuildItemNodes(_inputItems);
    end
end

function ISCraftRecipePanel:onInputsChanged()
    if self.craftControl then
        self.craftControl:onInputsChanged();
    end
end

function ISCraftRecipePanel:updateContainers(containers)
    if self.titleWidget then
        self.titleWidget:updateLabels();
        self.titleWidget:updatePropertyIcons();
        self:calculateLayout(self.width, self.height);
    end
end

function ISCraftRecipePanel:onGainJoypadFocus(joypadData)
    ISPanel.onGainJoypadFocus(self, joypadData)
    joypadData.focus = self.inputs
    updateJoypadFocus(joypadData)
end

--************************************************************************--
--** ISCraftRecipePanel:new
--**
--************************************************************************--
function ISCraftRecipePanel:new(x, y, width, height, player, logic, recipeData, craftBench, isoObject)
    local o = ISPanel.new(self, x, y, width, height);

    o.background = false;
    --o.margin = 5;
    o.player = player;
    --o.recipeData = recipeData;
    --o.craftBench = craftBench;
    --o.isoObject = isoObject;

    o.logic = logic;
    o.logic:addEventListener("onRecipeChanged", o.onRecipeChanged, o);
    o.logic:addEventListener("onRebuildInputItemNodes", o.onRebuildItemNodes, o);
    o.logic:addEventListener("onInputsChanged", o.onInputsChanged, o);

    o.margin = 0;
    o.minimumWidth = 350;
    o.minimumHeight = 0;

    --o.doToolTip = true;

    o.autoFillContents = false;

    -- these may or may not be used by a parent control while calculating layout:
    o.isAutoFill = false;
    o.isAutoFillX = false;
    o.isAutoFillY = false;
    return o;
end