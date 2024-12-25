--***********************************************************
--**                    THE INDIE STONE                    **
--**            Author: turbotutone / spurcival            **
--***********************************************************
require "ISUI/ISPanel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

ISWidgetIngredientsInputs = ISPanel:derive("ISWidgetIngredientsInputs");

function ISWidgetIngredientsInputs:initialise()
	ISPanel.initialise(self);
end

function ISWidgetIngredientsInputs:createChildren()
    ISPanel.createChildren(self);

    --[[
    local column, row;

    self.rootTable = ISXuiSkin.build(self.xuiSkin, "S_TableLayout_Main", ISTableLayout, 0, 0, 10, 10);
    self.rootTable:addRowFill(nil);
    self.rootTable:initialise();
    self.rootTable:instantiate();
    self:addChild(self.rootTable);
    --]]

    local recipe = self.logic and self.logic:getRecipe() or self.recipe;

    local fontHeight = -1; -- <=0 sets label initial height to font
    self.inputsLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, getText("IGUI_CraftingWindow_Requires"), 1.0, 1.0, 1.0, 1, UIFont.Medium, true);
    self.inputsLabel:initialise();
    self.inputsLabel:instantiate();
    self:addChild(self.inputsLabel);
    
    self.inputs = {};

    -- so we display first the keep/tool in the list
    local keepToolInputList = {};
    local ingredientsInputList = {};

    for i=0,recipe:getInputs():size()-1 do
        local input = recipe:getInputs():get(i);
        if input:getCreateToItemScript() and (not input:isAutomationOnly()) then
            --self:addInput(input);
            if input:isKeep() or input:isTool() then
                table.insert(keepToolInputList, input);
            else
                table.insert(ingredientsInputList, input);
            end
        end
    end
    for i=0,recipe:getInputs():size()-1 do
        local input = recipe:getInputs():get(i);
        if (not input:getCreateToItemScript()) and (not input:isAutomationOnly()) then
            --self:addInput(input);
            if input:isKeep() or input:isTool() then
                table.insert(keepToolInputList, input);
            else
                table.insert(ingredientsInputList, input);
            end
        end
    end

    for i,v in ipairs(keepToolInputList) do
        self:addInput(v);
    end
    for i,v in ipairs(ingredientsInputList) do
        self:addInput(v);
    end
end

function ISWidgetIngredientsInputs:addInput(_inputScript)
    local input = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISWidgetInput, 0, 0, 10, 10, self.player, self.logic, _inputScript);
    input.interactiveMode = self.interactiveMode;
    if _inputScript:isKeep() then
        -- set keep flag
    end
    input:initialise();
    input:instantiate();
    self:addChild(input);
    table.insert(self.inputs, input);
end

function ISWidgetIngredientsInputs:calculateLayout(_preferredWidth, _preferredHeight)

    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    local minWidth = self.margin*2;
    local minHeight = self.margin;

    minWidth = math.max(minWidth, minWidth + self.inputsLabel:getWidth());
    minHeight = minHeight + self.inputsLabel:getHeight() + self.margin;

    local minInputWidth = 0;
    local minInputHeight = 0;
    for k,v in ipairs(self.inputs) do
        v:calculateLayout(0,0);

        minInputWidth = math.max(minInputWidth, v:getWidth()); --+(self.margin*2));
        minInputHeight = math.max(minInputHeight, v:getHeight());
        --minHeight = minHeight + self.margin;
    end
    
    local inputCount = #self.inputs;
    local inputCols = 4;
    local inputRows = math.ceil(inputCount / inputCols);
    inputRows = math.max(1, inputRows);

    local margins = inputRows * self.margin;
    minHeight = minHeight + (minInputHeight * inputRows) + margins;

    minWidth = math.max(minWidth, (self.itemMargin*2)+(minInputWidth*inputCols)+(self.itemSpacing*(inputCols - 1)));

    width = math.max(width, minWidth);
    height = math.max(height, minHeight);

    local x = self.margin;
    local y = self.margin;

    self.inputsLabel:setX(x);
    self.inputsLabel.originalX = self.inputsLabel:getX();
    self.inputsLabel:setY(y);

    local inputTop = self.inputsLabel:getY() + self.inputsLabel:getHeight() + self.margin;
    local column = 0;
    local row = 0;
    for k,v in ipairs(self.inputs) do
        v:calculateLayout(minInputWidth, minInputHeight);

        x = self.itemMargin + (column*(minInputWidth+self.itemSpacing));
        y = inputTop + (row*(minInputHeight+self.margin));
        v:setX(x);
        v:setY(y);
        
        column = column + 1;
        if column >= 4 then
            column = 0;
            row = row + 1;
        end
    end
    
    self:setWidth(width);
    self:setHeight(height);
end

function ISWidgetIngredientsInputs:onResize()
    ISUIElement.onResize(self)
end

function ISWidgetIngredientsInputs:prerender()
    ISPanel.prerender(self);
end

function ISWidgetIngredientsInputs:render()
    ISPanel.render(self);
end

function ISWidgetIngredientsInputs:update()
    ISPanel.update(self);
end

function ISWidgetIngredientsInputs:onRebuildItemNodes(_inputItems)
    if self.inputs then
        for k,v in ipairs(self.inputs) do
           v:onRebuildItemNodes(_inputItems); 
        end
    end
end

function ISWidgetIngredientsInputs:onRecipeChanged()
    if self.logic:shouldShowManualSelectInputs() and self.inputs and #self.inputs > 0 then
        -- select first input as the active manual input
        self.logic:setManualSelectInputScriptFilter(self.inputs[1].inputScript);
    end
end

--************************************************************************--
--** ISWidgetIngredientsInputs:new
--**
--************************************************************************--
function ISWidgetIngredientsInputs:new (x, y, width, height, player, logic) -- recipeData, craftBench)
	local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.player = player;
    o.logic = logic;
    --o.recipeData = recipeData;
    --o.craftBench = craftBench;

    o.interactiveMode = false;

    o.backgroundColor = {r=0, g=0, b=0, a=0};
    o.borderColor = {r=1, g=1, b=1, a=0.7};

    o.background = true;

    o.textureLink = getTexture("media/ui/Entity/icon_link_io.png");

    o.margin = UI_BORDER_SPACING;
    o.minimumWidth = 0;
    o.minimumHeight = 0;
    o.itemSpacing = 24;
    o.itemMargin = 24;
    o.itemNameMaxLines = 3;

    o.doToolTip = true;

    o.autoFillContents = false;

    -- these may or may not be used by a parent control while calculating layout:
    o.isAutoFill = false;
    o.isAutoFillX = false;
    o.isAutoFillY = false;

    return o
end