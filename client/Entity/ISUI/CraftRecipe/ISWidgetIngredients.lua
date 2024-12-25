--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************
require "ISUI/ISPanel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

ISWidgetIngredients = ISPanel:derive("ISWidgetIngredients");

function ISWidgetIngredients:initialise()
	ISPanel.initialise(self);
end

function ISWidgetIngredients:createChildren()
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

    self.outputsLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, getText("IGUI_CraftingWindow_Creates"), 1.0, 1.0, 1.0, 1, UIFont.Medium, true);
    self.outputsLabel:initialise();
    self.outputsLabel:instantiate();
    self:addChild(self.outputsLabel);

    self.inputs = {};
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
        if input:getCreateToItemScript() and (not input:isAutomationOnly()) then
            self:addInput(input);
            self:addKeeps(input);
        end
    end
    for i=0,recipe:getInputs():size()-1 do
        local input = recipe:getInputs():get(i);
        if (not input:getCreateToItemScript()) and (not input:isAutomationOnly()) then
            self:addInput(input);
            self:addKeeps(input);
        end
    end
end

function ISWidgetIngredients:addInput(_inputScript)
    if _inputScript:isKeep() then
        return;
    end
    local input = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISWidgetTooltipInput, 0, 0, 10, 10, self.player, self.logic, _inputScript);
    input.interactiveMode = self.interactiveMode;
    input:initialise();
    input:instantiate();
    self:addChild(input);
    table.insert(self.inputs, input);

    if _inputScript:getCreateToItemScript() then
        local output = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISWidgetTooltipInput, 0, 0, 10, 10, self.player, self.logic, _inputScript);
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

function ISWidgetIngredients:addKeeps(_inputScript)
    if not _inputScript:isKeep() then
        return;
    end
    
    -- add to inputs
    local input = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISWidgetTooltipInput, 0, 0, 10, 10, self.player, self.logic, _inputScript);
    input.interactiveMode = self.interactiveMode;
    input:initialise();
    input:instantiate();
    self:addChild(input);
    table.insert(self.inputs, input);
    
    -- add to outputs too as keeps
    if _inputScript:getCreateToItemScript() then
        local output = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISWidgetTooltipInput, 0, 0, 10, 10, self.player, self.logic, _inputScript);
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
        local output = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISWidgetTooltipInput, 0, 0, 10, 10, self.player, self.logic, _inputScript);
        output.interactiveMode = self.interactiveMode;
        output.displayAsOutput = true;
        output:initialise();
        output:instantiate();
        self:addChild(output);
        table.insert(self.outputs, output);
    end
end

function ISWidgetIngredients:addOutput(_outputScript)
    local output = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISWidgetTooltipOutput, 0, 0, 10, 10, self.player, self.logic, _outputScript);
    output.interactiveMode = self.interactiveMode;
    output:initialise();
    output:instantiate();
    self:addChild(output);
    table.insert(self.outputs, output);
end

function ISWidgetIngredients:calculateLayout(_preferredWidth, _preferredHeight)

    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    local minWidth = self.margin*2;
    local minHeight = self.margin;

    minWidth = math.max(minWidth, minWidth + self.inputsLabel:getWidth() + self.margin + self.outputsLabel:getWidth());
    minHeight = minHeight + self.inputsLabel:getHeight() + self.margin;

    local minInputWidth = 0;
    local minInputHeight = 0;
    for k,v in ipairs(self.inputs) do
        v:calculateLayout(0,0);

        minInputWidth = math.max(minInputWidth, v:getWidth()); --+(self.margin*2));
        minInputHeight = math.max(minInputHeight, v:getHeight());
        --minHeight = minHeight + self.margin;
    end

    local minOutputWidth = 0;
    local minOutputHeight = 0;
    for k,v in ipairs(self.outputs) do
        v:calculateLayout(0,0);

        minOutputWidth = math.max(minOutputWidth, v:getWidth()); --+(self.margin*2));
        minOutputHeight = math.max(minOutputHeight, v:getHeight());
        --minHeight = minHeight + self.margin;
    end

    local minIOWidth = math.max(minInputWidth, minOutputWidth);
    local minIOHeight = math.max(minInputHeight, minOutputHeight);

    local margins = math.max(#self.inputs, #self.outputs) * self.margin;
    minHeight = minHeight + math.max(#self.inputs * minIOHeight, #self.outputs * minIOHeight) + margins;

    minWidth = math.max(minWidth, (self.margin*3)+(minIOWidth*2));

    width = math.max(width, minWidth);
    height = math.max(height, minHeight);

    local IOWidth = (width-(self.margin*4)) /3;
--     local IOWidth = (width-(self.margin*3)) /2;

    local x = self.margin;
    local y = self.margin;

    self.inputsLabel:setX(x);
    self.inputsLabel.originalX = self.inputsLabel:getX();
    self.inputsLabel:setY(y);

    y = self.inputsLabel:getY() + self.inputsLabel:getHeight() + self.margin;

    for k,v in ipairs(self.inputs) do
        v:calculateLayout(IOWidth,minIOHeight);

        v:setX(x);
        v:setY(y);

        y = v:getY() + v:getHeight() + self.margin;
    end

    local x = self.margin + IOWidth + self.margin + IOWidth + self.margin;
    local y = self.margin;
    
    self.outputsLabel:setX(x);
    self.outputsLabel.originalX = self.outputsLabel:getX();
    self.outputsLabel:setY(y);

    y = self.outputsLabel:getY() + self.outputsLabel:getHeight() + self.margin;

    for k,v in ipairs(self.outputs) do
        v:calculateLayout(width - x - self.margin - self.margin,minIOHeight);

        v:setX(x);
        v:setY(y);

        if v.iconLink then
            v.iconLink:setX(x-12);
            v.iconLink:setY(y+15);
        end

        y = v:getY() + v:getHeight() + self.margin;
    end


    self:setWidth(width);
    self:setHeight(height);
end

function ISWidgetIngredients:onResize()
    ISUIElement.onResize(self)
end

function ISWidgetIngredients:prerender()
    ISPanel.prerender(self);
    for k,v in ipairs(self.outputs) do
        if v.iconLink then
            local r,g,b = v.borderColor.r, v.borderColor.g, v.borderColor.b;
            v.iconLink:setColor(r,g,b);
        end
    end
end

function ISWidgetIngredients:render()
    ISPanel.render(self);
end

function ISWidgetIngredients:update()
    ISPanel.update(self);
end

--************************************************************************--
--** ISWidgetIngredients:new
--**
--************************************************************************--
function ISWidgetIngredients:new (x, y, width, height, player, logic) -- recipeData, craftBench)
	local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.player = player;
    o.logic = logic;
    --o.recipeData = recipeData;
    --o.craftBench = craftBench;

    o.interactiveMode = false;

    o.background = false;

    o.textureLink = getTexture("media/ui/Entity/icon_link_io.png");

    o.margin = UI_BORDER_SPACING;
    o.minimumWidth = 0;
    o.minimumHeight = 0;

    o.doToolTip = true;

    o.autoFillContents = false;

    -- these may or may not be used by a parent control while calculating layout:
    o.isAutoFill = false;
    o.isAutoFillX = false;
    o.isAutoFillY = false;

    return o
end