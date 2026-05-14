require "ISUI/ISPanelJoypad"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 5
local INPUT_COLUMNS = 4 -- moved here for quick access in future, if needed

ISWidgetIngredientsInputs = ISPanelJoypad:derive("ISWidgetIngredientsInputs");

function ISWidgetIngredientsInputs:initialise()
	ISPanelJoypad.initialise(self);
end

function ISWidgetIngredientsInputs:createChildren()
    self:setScrollChildren(true)
    self:addScrollBars()
    ISPanelJoypad.createChildren(self);
    local recipe = self.logic and self.logic:getRecipe() or self.recipe;

    self.inputsLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, FONT_HGT_SMALL, getText("IGUI_CraftingWindow_Requires"), 1.0, 1.0, 1.0, 1, UIFont.Small, true);
    self.inputsLabel:initialise();
    self.inputsLabel:instantiate();
    self:addChild(self.inputsLabel);
    
    -- create scroll panel for input slots
    self.panel = ISPanel:new(0, self.inputsLabel:getBottom() + UI_BORDER_SPACING, 30, 10)
    self.panel.prerender = function(self)
        self:setStencilRect(0, 0, self:getWidth(), self:getHeight())
        ISPanel.prerender(self)
    end
    self.panel.render = function(self)
        ISPanel.render(self)
        self:clearStencilRect()
    end
    self.panel.onMouseWheel = function(self, del)
        if self:getScrollHeight() > 0 then
            self:setYScroll(self:getYScroll() - (del * 40))
            return true
        end
        return false
    end
    self.panel:initialise()
    self.panel:instantiate()
    self.panel:noBackground()
    self.panel:setScrollChildren(true)
    self.panel:addScrollBars();
    self:addChild(self.panel)
    
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
    input.isBuildMenu = self.isBuildMenu;
    input.interactiveMode = self.interactiveMode;
    input:initialise();
    input:instantiate();
    self.panel:addChild(input);
    table.insert(self.inputs, input);
end

function ISWidgetIngredientsInputs:calculateLayout(_preferredWidth, _preferredHeight)

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
    local contentHeight = (minInputHeight * inputRows) + margins;
    
    local inputRowsToShow = math.min(2, inputRows)
    margins = inputRowsToShow * UI_BORDER_SPACING;
    local panelHeight = (minInputHeight * inputRowsToShow) + margins;
    minHeight = minHeight + panelHeight;

    minWidth = math.max(minWidth, (UI_BORDER_SPACING*(INPUT_COLUMNS+1))+(minInputWidth*INPUT_COLUMNS)+2);
    if inputRows > inputRowsToShow then
        minWidth = minWidth + UI_BORDER_SPACING;
    end
        
    width = math.max(width, minWidth);
    height = math.max(height, minHeight);

    self.panel.vscroll:setX(minWidth - self.panel.vscroll.width)
    self.panel.vscroll:setY(0)
    self.panel.vscroll:setHeight(panelHeight)
    self.panel:setScrollHeight(contentHeight);
    self.panel:setWidth(width);
    self.panel:setHeight(panelHeight);
    
    local x = UI_BORDER_SPACING+1;
    local y = x;

    self.inputsLabel:setX(x);
    self.inputsLabel.originalX = self.inputsLabel:getX();
    self.inputsLabel:setY(y);

    local joypadState = self:recordJoypadState()

    self.joypadButtons = {}
    self.joypadButtonsY = {}

    local column = 0;
    local row = 0;
    for k,v in ipairs(self.inputs) do
        v:calculateLayout(minInputWidth, minInputHeight);

        x = UI_BORDER_SPACING + (column*(minInputWidth+UI_BORDER_SPACING));
        y = UI_BORDER_SPACING + (row*(minInputHeight+UI_BORDER_SPACING));
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

function ISWidgetIngredientsInputs:onResize()
    ISPanelJoypad.onResize(self)
end

function ISWidgetIngredientsInputs:prerender()
    ISPanelJoypad.prerender(self);
end

function ISWidgetIngredientsInputs:render()
    ISPanelJoypad.render(self);
end

function ISWidgetIngredientsInputs:update()
    ISPanelJoypad.update(self);
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

function ISWidgetIngredientsInputs:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
    if self.joypadButtons and #self.joypadButtons > 0 then
        self.joypadIndexY = 1
        self.joypadIndex = 1
        self.joypadButtons = self.joypadButtonsY[self.joypadIndexY]
        self.joypadButtons[self.joypadIndex]:setJoypadFocused(true, joypadData)
    end
end

function ISWidgetIngredientsInputs:onLoseJoypadFocus(joypadData)
    ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
    self:clearJoypadFocus(joypadData)
end

function ISWidgetIngredientsInputs:onJoypadDown(button, joypadData)
    if button == Joypad.AButton then
        local input = self.joypadButtons[self.joypadIndex]
        if input and input.primary and input.primary.selectInputButton then
            input:onSelectInputsClicked(input.primary.selectInputButton)
        end
        return
    end
    ISPanelJoypad.onJoypadDown(self, button, joypadData)
end

function ISWidgetIngredientsInputs:new (x, y, width, height, player, logic)
	local o = ISPanelJoypad.new(self, x, y, width, height);
    o.player = player;
    o.logic = logic;

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
