--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: RJ         				   **
--***********************************************************

require "ISUI/ISPanel"

ISBuildRecipePanel = ISPanel:derive("ISBuildRecipePanel");

--************************************************************************--
--** ISBuildRecipePanel:initialise
--**
--************************************************************************--

function ISBuildRecipePanel:initialise()
	ISPanel.initialise(self);
end

function ISBuildRecipePanel:createChildren()
    ISPanel.createChildren(self);

    local styleCell = "S_TableLayoutCell_Pad5";
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

function ISBuildRecipePanel:createDynamicChildren()
    self.rootTable:clearTable();

    local recipe = self.logic:getRecipe();

    if not recipe then
        self:xuiRecalculateLayout();
        return;
    end

    self.rootTable:addColumnFill(nil);

    local column, row;

    self.titleWidget = ISXuiSkin.build(self.xuiSkin, "S_WidgetTitleHeader_Std", ISWidgetTitleHeader, 0, 0, 10, 10, recipe, self.player, self.logic);
    --self.titleWidget.ignoreLightIcon = true;
    self.titleWidget.ignoreSurface = true;
    self.titleWidget:initialise();
    self.titleWidget:instantiate();
    self.titleWidget.player = self.player;

    row = self.rootTable:addRow();
    self.rootTable:setElement(0, row:index(), self.titleWidget);

    --filler row
    self.rootTable:addRowFill(nil);

    -- inputs
    self.inputs = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISBuildWidgetIngredientsInputs, 0, 0, 10, 10, self.player, self.logic); --self.recipeData, self.craftBench);
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
    self.craftControl = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISWidgetBuildControl, 0, 0, 10, 10, self.player, self.logic); --self.recipeData, self.craftBench, self.isoObject);
    self.craftControl.interactiveMode = true;
    self.craftControl.allowBatchCraft = false;
    self.craftControl:initialise();
    self.craftControl:instantiate();

    row = self.rootTable:addRow();
    self.rootTable:setElement(0, row:index(), self.craftControl);

    self:xuiRecalculateLayout();
end

function ISBuildRecipePanel:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    --local x,y = 0,headerHeight;
    if self.rootTable then
        self.rootTable:setX(0);
        self.rootTable:setY(0);
        self.rootTable:calculateLayout(width, height);

        if self.titleWidget then
            self.titleWidget:setY(0);
        end

        width = math.max(width, self.rootTable:getWidth());
        height = math.max(height, self.rootTable:getHeight());
    end

    self.overlayPanel:setWidth(width);
    self.overlayPanel:setHeight(height);

    --print(width)
    self:setWidth(width);
    self:setHeight(height);
end

function ISBuildRecipePanel:onResize()
    ISUIElement.onResize(self)
end

function ISBuildRecipePanel:prerender()
    ISPanel.prerender(self);
end

function ISBuildRecipePanel:render()
    ISPanel.render(self);
end

function ISBuildRecipePanel:update()
    ISPanel.update(self);
    self:updateTitleWidget();
end

function ISBuildRecipePanel:setOverlayVisible(_b)
    self.overlayPanel:setVisible(_b);
end

function ISBuildRecipePanel:onRecipeChanged()
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

function ISBuildRecipePanel:getRecipe()
    return self.logic:getRecipe();
end

function ISBuildRecipePanel:onRebuildItemNodes(_inputItems)
    if self.inputs then
        self.inputs:onRebuildItemNodes(_inputItems);
    end
end

function ISBuildRecipePanel:updateTitleWidget()
    if self.titleWidget then
        self.titleWidget:updateLabels();
        self.titleWidget:updatePropertyIcons();
        self:calculateLayout(self.width, self.height);
    end
end

function ISBuildRecipePanel:onManualSelectChanged(_manualSelectInputs)
    if self.inputs then
        self.inputs:onManualSelectChanged(_manualSelectInputs);
    end
end


--************************************************************************--
--** ISBuildRecipePanel:new
--**
--************************************************************************--
function ISBuildRecipePanel:new(x, y, width, height, player, logic, recipeData, craftBench, isoObject)
    local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self

    o.background = false;
    --o.margin = 5;
    o.player = player;
    --o.recipeData = recipeData;
    --o.craftBench = craftBench;
    --o.isoObject = isoObject;

    o.logic = logic;
    o.logic:addEventListener("onRecipeChanged", o.onRecipeChanged, o);
    o.logic:addEventListener("onRebuildInputItemNodes", o.onRebuildItemNodes, o);
    o.logic:addEventListener("onManualSelectChanged", o.onManualSelectChanged, o);

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