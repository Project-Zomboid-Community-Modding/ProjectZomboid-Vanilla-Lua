--***********************************************************
--**                    THE INDIE STONE                    **
--**            Author: turbotutone / spurcival            **
--***********************************************************
require "ISUI/ISPanel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

ISWidgetIngredientsOutputs = ISPanel:derive("ISWidgetIngredientsOutputs");

function ISWidgetIngredientsOutputs:initialise()
	ISPanel.initialise(self);
end

function ISWidgetIngredientsOutputs:createChildren()
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
    self.outputsLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, getText("IGUI_CraftingWindow_Creates"), 1.0, 1.0, 1.0, 1, UIFont.Small, true);
    self.outputsLabel:initialise();
    self.outputsLabel:instantiate();
    self:addChild(self.outputsLabel);

    self.outputs = {};

    -- add outputs first so that they show up at top/left of outputs list
    for i=0,recipe:getOutputs():size()-1 do
        local output = recipe:getOutputs():get(i);
        if not output:isAutomationOnly() then
            self:addOutput(output);
        end
    end
    
    for i=0,recipe:getInputs():size()-1 do
        local input = recipe:getInputs():get(i);
        if not input:isAutomationOnly() and input:hasFlag(InputFlag.FakeOutput) then
            self:addInput(input);
            self:addKeeps(input);
        end
    end
end

function ISWidgetIngredientsOutputs:addInput(_inputScript)
    if _inputScript:isKeep() then
        return;
    end

    if _inputScript:getCreateToItemScript() then
        local output = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISWidgetInput, 0, 0, 10, 10, self.player, self.logic, _inputScript);
        output.interactiveMode = self.interactiveMode;
        output.displayAsOutput = true;
        output:initialise();
        output:instantiate();
        self:addChild(output);
        table.insert(self.outputs, output);

        local iconLink = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISImage, 0, 0, 19, 12, self.textureLink);
        iconLink.autoScale = true;
        iconLink:initialise();
        iconLink:instantiate();
        self:addChild(iconLink);
        output.iconLink = iconLink;
    end
end

function ISWidgetIngredientsOutputs:addKeeps(_inputScript)
    if not _inputScript:isKeep() then
        return;
    end
    
    -- add to outputs too as keeps
    if _inputScript:getCreateToItemScript() then
        local output = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISWidgetInput, 0, 0, 10, 10, self.player, self.logic, _inputScript);
        output.interactiveMode = self.interactiveMode;
        output.displayAsOutput = true;
        output:initialise();
        output:instantiate();
        self:addChild(output);
        table.insert(self.outputs, output);

        local iconLink = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISImage, 0, 0, 19, 12, self.textureLink);
        iconLink.autoScale = true;
        iconLink:initialise();
        iconLink:instantiate();
        self:addChild(iconLink);
        output.iconLink = iconLink;
    else
        local output = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISWidgetInput, 0, 0, 10, 10, self.player, self.logic, _inputScript);
        output.interactiveMode = self.interactiveMode;
        output.displayAsOutput = true;
        output:initialise();
        output:instantiate();
        self:addChild(output);
        table.insert(self.outputs, output);
    end
end

function ISWidgetIngredientsOutputs:addOutput(_outputScript)
    local output = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISWidgetOutput, 0, 0, 10, 10, self.player, self.logic, _outputScript);
    output.interactiveMode = self.interactiveMode;
    output:initialise();
    output:instantiate();
    self:addChild(output);
    table.insert(self.outputs, output);
end

function ISWidgetIngredientsOutputs:calculateLayout(_preferredWidth, _preferredHeight)

    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    local minWidth = self.margin*2;
    local minHeight = self.margin;

    minWidth = math.max(minWidth, minWidth + self.outputsLabel:getWidth());
    minHeight = minHeight + self.outputsLabel:getHeight() + self.margin;
    
    local minOutputWidth = 0;
    local minOutputHeight = 0;
    for k,v in ipairs(self.outputs) do
        v:calculateLayout(0,0);

        minOutputWidth = math.max(minOutputWidth, v:getWidth()); --+(self.margin*2));
        minOutputHeight = math.max(minOutputHeight, v:getHeight());
        --minHeight = minHeight + self.margin;
    end

    local outputCount = #self.outputs;
    local outputCols = 4;
    local outputRows = math.ceil(outputCount / outputCols);
    outputRows = math.max(1, outputRows);

    local margins = outputRows * self.margin;
    minHeight = minHeight + (minOutputHeight * outputRows) + margins;

    minWidth = math.max(minWidth, (self.itemMargin*2)+(minOutputWidth*outputCols)+(self.itemSpacing*(outputCols - 1)));

    width = math.max(width, minWidth);
    height = math.max(height, minHeight);

    local x = self.margin;
    local y = self.margin;

    self.outputsLabel:setX(x);
    self.outputsLabel.originalX = self.outputsLabel:getX();
    self.outputsLabel:setY(y);

    local outputTop = self.outputsLabel:getY() + self.outputsLabel:getHeight() + self.margin;
    local column = 0;
    local row = 0;
    for k,v in ipairs(self.outputs) do
        v:calculateLayout(minOutputWidth, minOutputHeight);

        x = self.itemMargin + (column*(minOutputWidth+self.itemSpacing));
        y = outputTop + (row*(minOutputHeight+self.margin));
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

function ISWidgetIngredientsOutputs:onResize()
    ISUIElement.onResize(self)
end

function ISWidgetIngredientsOutputs:prerender()
    ISPanel.prerender(self);
    for k,v in ipairs(self.outputs) do
        if v.iconLink then
            local r,g,b = v.borderColor.r, v.borderColor.g, v.borderColor.b;
            v.iconLink:setColor(r,g,b);
        end
    end
end

function ISWidgetIngredientsOutputs:render()
    ISPanel.render(self);
end

function ISWidgetIngredientsOutputs:update()
    ISPanel.update(self);
end

--************************************************************************--
--** ISWidgetIngredientsOutputs:new
--**
--************************************************************************--
function ISWidgetIngredientsOutputs:new (x, y, width, height, player, logic) -- recipeData, craftBench)
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

    local fontScale = getTextManager():getFontHeight(UIFont.Small) / 19; -- normalize to 1080p

    o.itemSpacing = 10 * fontScale;
    o.itemMargin = 10 * fontScale;
    o.itemNameMaxLines = 3;

    o.doToolTip = true;

    o.autoFillContents = false;

    -- these may or may not be used by a parent control while calculating layout:
    o.isAutoFill = false;
    o.isAutoFillX = false;
    o.isAutoFillY = false;

    return o
end