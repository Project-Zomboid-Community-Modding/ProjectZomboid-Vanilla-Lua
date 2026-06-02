require "ISUI/ISPanelJoypad"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 5
local INPUT_COLUMNS = 4 -- moved here for quick access in future, if needed

ISBuildWidgetIngredientsInputs = ISPanelJoypad:derive("ISBuildWidgetIngredientsInputs");

function ISBuildWidgetIngredientsInputs:initialise()
	ISPanelJoypad.initialise(self);
end

function ISBuildWidgetIngredientsInputs:createChildren()
    ISPanelJoypad.createChildren(self);
    local recipe = self.logic and self.logic:getRecipe() or self.recipe;

    self.inputsLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, FONT_HGT_SMALL, getText("IGUI_CraftingWindow_Requires"), 1.0, 1.0, 1.0, 1, UIFont.Small, true);
    self.inputsLabel:initialise();
    self.inputsLabel:instantiate();
    self:addChild(self.inputsLabel);
    
    self.inputs = {};
    
    for i=0,recipe:getInputs():size()-1 do
        local input = recipe:getInputs():get(i);
        if input:getCreateToItemScript() and (not input:isAutomationOnly()) then
            self:addInput(input);
        end
    end
    for i=0,recipe:getInputs():size()-1 do
        local input = recipe:getInputs():get(i);
        if (not input:getCreateToItemScript()) and (not input:isAutomationOnly()) then
            self:addInput(input);
        end
    end
end

function ISBuildWidgetIngredientsInputs:addInput(_inputScript)
    local input = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISWidgetInput, 0, 0, 10, 10, self.player, self.logic, _inputScript);
    input.isBuildMenu = self.isBuildMenu;
    input.interactiveMode = self.interactiveMode;
    input:initialise();
    input:instantiate();
    self:addChild(input);
    table.insert(self.inputs, input);
end

function ISBuildWidgetIngredientsInputs:calculateLayout(_preferredWidth, _preferredHeight)

    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    local minWidth = UI_BORDER_SPACING*2;
    local minHeight = UI_BORDER_SPACING;

    minWidth = math.max(minWidth, minWidth + self.inputsLabel:getWidth());
    minHeight = minHeight + self.inputsLabel:getHeight() + UI_BORDER_SPACING;

    local minInputWidth = 0;
    local minInputHeight = 0;
    for k,v in ipairs(self.inputs) do
        v:calculateLayout(0,0);

        minInputWidth = math.max(minInputWidth, v:getWidth());
        minInputHeight = math.max(minInputHeight, v:getHeight());
    end
    
    local inputCount = #self.inputs;
    local inputRows = math.ceil(inputCount / INPUT_COLUMNS);
    inputRows = math.max(1, inputRows);

    local margins = inputRows * UI_BORDER_SPACING;
    minHeight = minHeight + (minInputHeight * inputRows) + margins;

    minWidth = math.max(minWidth, (UI_BORDER_SPACING*(INPUT_COLUMNS+1))+(minInputWidth*INPUT_COLUMNS)+2);

    width = math.max(width, minWidth);
    height = math.max(height, minHeight);

    local x = UI_BORDER_SPACING+1;
    local y = x;

    self.inputsLabel:setX(x);
    self.inputsLabel.originalX = self.inputsLabel:getX();
    self.inputsLabel:setY(y);

    local joypadState = self:recordJoypadState()

    self.joypadButtons = {}
    self.joypadButtonsY = {}

    local inputTop = self.inputsLabel:getY() + self.inputsLabel:getHeight() + UI_BORDER_SPACING;
    local column = 0;
    local row = 0;
    for k,v in ipairs(self.inputs) do
        v:calculateLayout(minInputWidth, minInputHeight);

        x = UI_BORDER_SPACING + (column*(minInputWidth+UI_BORDER_SPACING));
        y = inputTop + (row*(minInputHeight+UI_BORDER_SPACING));
        v:setX(x);
        v:setY(y);
        
        table.insert(self.joypadButtons, v)

        column = column + 1;
        if column >= INPUT_COLUMNS then
            column = 0;
            row = row + 1;
            table.insert(self.joypadButtonsY, self.joypadButtons)
            self.joypadButtons = {}
        end
        end

    if #self.joypadButtons > 0 then
        table.insert(self.joypadButtonsY, self.joypadButtons)
    end

    self:restoreJoypadState(joypadState)

    self:setWidth(width);
    self:setHeight(height);
end

function ISBuildWidgetIngredientsInputs:onResize()
    ISUIElement.onResize(self)
end

function ISBuildWidgetIngredientsInputs:prerender()
    ISPanelJoypad.prerender(self);
end

function ISBuildWidgetIngredientsInputs:render()
    ISPanelJoypad.render(self);
end

function ISBuildWidgetIngredientsInputs:update()
    ISPanelJoypad.update(self);
end

function ISBuildWidgetIngredientsInputs:onRebuildItemNodes(_inputItems)
    if self.inputs then
        for k,v in ipairs(self.inputs) do
           v:onRebuildItemNodes(_inputItems); 
        end
    end
end

function ISBuildWidgetIngredientsInputs:onRecipeChanged()
    if self.logic:shouldShowManualSelectInputs() and self.inputs and #self.inputs > 0 then
        -- select first input as the active manual input
        self.logic:setManualSelectInputScriptFilter(self.inputs[1].inputScript);
    end
end

function ISBuildWidgetIngredientsInputs:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
    self:restoreJoypadFocus()
end

function ISBuildWidgetIngredientsInputs:onLoseJoypadFocus(joypadData)
    ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
    self:clearJoypadFocus(joypadData)
end

function ISBuildWidgetIngredientsInputs:onJoypadDown(button, joypadData)
    if button == Joypad.AButton then
        local input = self.joypadButtons[self.joypadIndex]
        if input and input.primary and input.primary.selectInputButton then
            input:onSelectInputsClicked(input.primary.selectInputButton)
        end
        return
    end
    ISPanelJoypad.onJoypadDown(self, button, joypadData)
end

function ISBuildWidgetIngredientsInputs:onManualSelectChanged(_manualSelect)
    self:xuiRecalculateLayout();
end

function ISBuildWidgetIngredientsInputs:new (x, y, width, height, player, logic) -- recipeData, craftBench)
	local o = ISPanelJoypad:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.player = player;
    o.logic = logic;
    o.logic:setManualSelectInputs(true);

    o.interactiveMode = false;

    o.backgroundColor = {r=0, g=0, b=0, a=0};
    o.borderColor = {r=1, g=1, b=1, a=0.7};

    o.textureLink = getTexture("media/ui/Entity/icon_link_io.png");

    o.minimumWidth = 0;
    o.minimumHeight = 0;
    o.itemNameMaxLines = 2;

    o.doToolTip = true;

    o.autoFillContents = false;

    -- these may or may not be used by a parent control while calculating layout:
    o.isAutoFill = false;
    o.isAutoFillX = false;
    o.isAutoFillY = false;

    return o
end
