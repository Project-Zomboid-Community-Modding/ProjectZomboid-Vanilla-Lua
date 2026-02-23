require "ISUI/ISPanelJoypad"

ISWidgetHandCraftControl = ISPanelJoypad:derive("ISWidgetHandCraftControl");

local debugSpam = true

local FONT_SCALE = getTextManager():getFontHeight(UIFont.Small) / 19; -- normalize to 1080p
local BUTTON_SIZE = getTextManager():getFontHeight(UIFont.Small) * 1.5
local ICON_SCALE = math.max(1, (FONT_SCALE - math.floor(FONT_SCALE)) < 0.5 and math.floor(FONT_SCALE) or math.ceil(FONT_SCALE));
local BUTTON_ICON_SIZE = 16 * ICON_SCALE;

function ISWidgetHandCraftControl:initialise()
	ISPanelJoypad.initialise(self);
end

function ISWidgetHandCraftControl:createChildren()
    ISPanelJoypad.createChildren(self);

    self.colProgress = safeColorToTable(self.xuiSkin:color("C_ValidGreen"));

    local fontHeight = -1; -- <=0 sets label initial height to font
    
    self.quantityLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, "Quantity:", 1, 1, 1, 1, UIFont.Small, true);
    self.quantityLabel:initialise();
    self.quantityLabel:instantiate();
    self:addChild(self.quantityLabel);
    
    self.durationLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, "Time Required:", 1, 1, 1, 1, UIFont.Small, true);
    self.durationLabel:initialise();
    self.durationLabel:instantiate();
    self:addChild(self.durationLabel);

    self.entryBox = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISTextEntryBox, "", 0, 0, 70, 20);
    self.entryBox.font = UIFont.Small;
    self.entryBox:initialise();
    self.entryBox:instantiate();
    self.entryBox.onLostFocus = ISWidgetHandCraftControl.onTextChange;
    self.entryBox.target = self;
    self.entryBox:setClearButton(true);
    self.entryBox:setOnlyNumbers(true);
    self:addChild(self.entryBox);

    local buttonSize = getTextManager():getFontHeight(UIFont.Small) + 2;
    
    self.buttonMax = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, buttonSize*2, buttonSize, "MAX")
    self.buttonMax.font = UIFont.Small;
    self.buttonMax.target = self;
    self.buttonMax.onclick = ISWidgetHandCraftControl.onButtonClick;
    self.buttonMax.enable = true;
    self.buttonMax:initialise();
    self.buttonMax:instantiate();
    self:addChild(self.buttonMax);

    self.buttonMore = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, buttonSize, buttonSize, "")
    self.buttonMore.image = getTexture("media/ui/Entity/BTN_Plus_Icon_48x48.png");
    self.buttonMore.target = self;
    self.buttonMore.onclick = ISWidgetHandCraftControl.onButtonClick;
    self.buttonMore.enable = true;
    self.buttonMore:initialise();
    self.buttonMore:instantiate();
    self:addChild(self.buttonMore);

    self.buttonLess = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, buttonSize, buttonSize, "")
    self.buttonLess.image = getTexture("media/ui/Entity/BTN_Minus_Icon_48x48.png");
    self.buttonLess.target = self;
    self.buttonLess.onclick = ISWidgetHandCraftControl.onButtonClick;
    self.buttonLess.enable = true;
    self.buttonLess:initialise();
    self.buttonLess:instantiate();
    self:addChild(self.buttonLess);

    local style = self.styleBar or "S_ProgressBar_Craft";
    self.progressBar = ISXuiSkin.build(self.xuiSkin, style, ISProgressBar, 0, 0, 150, buttonSize, false, UIFont.Small);
    self.progressBar.progressColor = self.colProgress;
    self.progressBar:initialise();
    self.progressBar:instantiate();
    self.progressBar:setProgress(0);
    self:addChild(self.progressBar);

    self.buttonCraft = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, BUTTON_SIZE * 1.5, BUTTON_SIZE, getText("IGUI_CraftingWindow_Craft"))
    self.buttonCraft.font = UIFont.Small;
    self.buttonCraft.target = self;
    self.buttonCraft.onclick = ISWidgetHandCraftControl.onButtonClick;
    self.buttonCraft.enable = true;
    self.buttonCraft:initialise();
    self.buttonCraft:instantiate();
    self:addChild(self.buttonCraft);

    self.origButtonHeight = self.buttonCraft:getHeight();

    -- Debug tool to force being able to do recipes regardless of knowing recipes, skills, whatever
    if isDebugEnabled() and debugSpam then
        self.buttonForceCraft = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, BUTTON_SIZE * 1.5, BUTTON_SIZE, "Force Action")
        self.buttonForceCraft.iconTexture = getTexture("media/textures/Item_Plumpabug_Left.png");
        self.buttonForceCraft.joypadTextureWH = BUTTON_ICON_SIZE;
        self.buttonForceCraft.font = UIFont.Small;
        self.buttonForceCraft.target = self;
        self.buttonForceCraft.onclick = ISWidgetHandCraftControl.onButtonClick;
        self.buttonForceCraft.enable = true;
        self.buttonForceCraft:initialise();
        self.buttonForceCraft:instantiate();
        self.buttonForceCraft.originalTitle = self.buttonForceCraft.title;
        self:addChild(self.buttonForceCraft);
    end

    self.boxHeight = self.height;
    
    self:setCraftQuantity(1);
end

function ISWidgetHandCraftControl:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    local minHeight = self.margin*3;
    
    minHeight = minHeight + self.quantityLabel:getHeight() + self.margin;
    minHeight = minHeight + self.entryBox:getHeight() + self.margin;
    minHeight = minHeight + self.buttonCraft:getHeight();
    if self.buttonForceCraft then
        minHeight = minHeight + self.buttonForceCraft:getHeight();
    end
    if self.buttonKnowAllRecipes then
        minHeight = minHeight + self.buttonForceCraft:getHeight();
    end

    height = math.max(height, minHeight);

    local x = self.margin;
    local y = self.margin;
    local midX = width / 2;
    
    -- labels
    local heightUsed = 0;
    if self.allowBatchCraft then
        if self.quantityLabel then
            self.quantityLabel:setVisible(true);
            self.quantityLabel:setX(x);
            self.quantityLabel:setY(y);
            heightUsed = math.max(heightUsed, self.quantityLabel:getHeight())
        end
    else
        self.quantityLabel:setVisible(false);
    end

    if self.durationLabel then
        self.durationLabel:setX(midX);
        self.durationLabel.originalX = self.durationLabel:getX();
        self.durationLabel:setY(y);
        heightUsed = math.max(heightUsed, self.durationLabel:getHeight())
    end
    
    if heightUsed > 0 then
        y = y + heightUsed + self.margin;
    end
    
    -- qty buttons and progressBar
    heightUsed = 0;
    if self.allowBatchCraft then
        if self.buttonLess then
            self.buttonLess:setVisible(true);
            self.buttonLess:setX(x);
            self.buttonLess:setY(y);
            x = x + self.buttonPadding + self.buttonLess:getWidth();
            heightUsed = math.max(heightUsed, self.buttonLess:getHeight())
        end

        if self.entryBox then
            self.entryBox:setVisible(true);
            self.entryBox:setX(x);
            self.entryBox:setY(y);
            x = x + self.buttonPadding + self.entryBox:getWidth();
            heightUsed = math.max(heightUsed, self.entryBox:getHeight())
        end

        if self.buttonMore then
            self.buttonMore:setVisible(true);
            self.buttonMore:setX(x);
            self.buttonMore:setY(y);
            x = x + self.buttonPadding + self.buttonMore:getWidth();
            heightUsed = math.max(heightUsed, self.buttonMore:getHeight())
        end

        if self.buttonMax then
            self.buttonMax:setVisible(true);
            self.buttonMax:setX(x);
            self.buttonMax:setY(y);
            x = x + self.buttonPadding + self.buttonMax:getWidth();
            heightUsed = math.max(heightUsed, self.buttonMax:getHeight())
        end
    else
        if self.entryBox then self.entryBox:setVisible(false); end
        if self.buttonMax then self.buttonMax:setVisible(false); end
        if self.buttonMore then self.buttonMore:setVisible(false); end
        if self.buttonLess then self.buttonLess:setVisible(false); end
    end

    if self.progressBar then
        local progressBarWidth = width - midX - self.margin;
        self.progressBar:setWidth(progressBarWidth);
        self.progressBar:setX(midX);
        self.progressBar:setY(y);
        heightUsed = math.max(heightUsed, self.progressBar:getHeight())
    end

    if heightUsed > 0 then
        y = y + heightUsed + self.margin;
    end

    -- craft buttons
    x = self.margin;
    self.buttonCraft:setX(x);
    self.buttonCraft:setWidth(width-(self.margin*2));
    self.buttonCraft:setY(y);

    y = self.buttonCraft:getY() + self.buttonCraft:getHeight() + self.margin;

    if self.buttonForceCraft then
        self.buttonForceCraft:setX(x);
        self.buttonForceCraft:setWidth(width-(self.margin*2));
        self.buttonForceCraft:setY(y);

        y = self.buttonForceCraft:getY() + self.buttonForceCraft:getHeight() + self.margin;
    end

    if self.buttonKnowAllRecipes then
        self.buttonKnowAllRecipes:setX(x);
        self.buttonKnowAllRecipes:setWidth(width-(self.margin*2));
        self.buttonKnowAllRecipes:setY(y);

        y = self.buttonKnowAllRecipes:getY() + self.buttonKnowAllRecipes:getHeight() + self.margin;
    end

    self.boxHeight = y;

    self:setWidth(width);
    self:setHeight(height);

    local joypadState = self:recordJoypadState()

    self.joypadButtonsY = {}
    self.joypadButtons = {}
    self.joypadIndexY = 1
    self.joypadIndex = 1
    if self.buttonLess:isVisible() then
        self:insertNewLineOfButtons(self.buttonLess, self.buttonMore, self.buttonMax)
    end
    self:insertNewLineOfButtons(self.buttonCraft)
    if self.buttonForceCraft then
        self:insertNewLineOfButtons(self.buttonForceCraft)
    end

    self:restoreJoypadState(joypadState)
end

function ISWidgetHandCraftControl:onResize()
    ISUIElement.onResize(self)
end

function ISWidgetHandCraftControl:prerender()
	if self.background then
		self:drawRectStatic(0, 0, self.width, self.boxHeight, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
		self:drawRectBorderStatic(0, 0, self.width, self.boxHeight, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
	end

    if self.durationLabel then
        if self.logic and self.logic:getRecipe() then
            local seconds = self.logic:getRecipe():getTime(self.player);
            -- changed because weird artifacts were happening for sub 1 minute recipes
            local mm
            if seconds < 60 then mm = 0
            else mm = round(seconds / 60, 0) end;

            local ss = math.fmod(seconds, 60);
            local text = string.format("Time Required: %02dm %02ds", mm, ss);
            self.durationLabel:setName(text)
        else
            self.durationLabel:setName("Time Required: ??")
        end
    end
    
    if self.logic and self.logic:isCraftActionInProgress() and self.logic:getCraftActionTable() then
        local action = self.logic:getCraftActionTable();
        local plrQueue = ISTimedActionQueue.getTimedActionQueue(self.player);
        if plrQueue and plrQueue.queue and plrQueue.queue[1] and plrQueue.queue[1]==action then
            if self.progressBar then
                self.progressBar:setProgress(action:getJobDelta());
                local title = tostring(round(action:getJobDelta()*100, 0)).."%"
                self.progressBar:setText(title);
            end
            if self.buttonCraft then
                self.buttonCraft.enable = false;
            end
        end
    else
        if self.buttonCraft then
            self.buttonCraft.enable = self.logic:cachedCanPerformCurrentRecipe();
        end
        if self.progressBar then
            self.progressBar:setProgress(0);
            self.progressBar:setText("");
        end
    end
end

function ISWidgetHandCraftControl:render()
    ISPanelJoypad.render(self);
    self:renderJoypadFocus()
end

function ISWidgetHandCraftControl:update()
    ISPanelJoypad.update(self);
end

function ISWidgetHandCraftControl:onAutoToggled(_newState)
    self.logic:setManualSelectInputs(_newState);
    self.logic:setLastManualInputMode(_newState);
end

function ISWidgetHandCraftControl:onButtonClick(_button)
    if self.buttonCraft and _button==self.buttonCraft then
        self:startHandcraft(false);
    end
    if self.buttonForceCraft and _button==self.buttonForceCraft then
        self:startHandcraft(true);
    end
    if self.buttonKnowAllRecipes and _button==self.buttonKnowAllRecipes then
        self.player:setKnowAllRecipes(not self.player:isKnowAllRecipes())
    end
    if self.buttonMax and _button==self.buttonMax then
        local amount = self.logic:getPossibleCraftCount(false);
        if tostring(amount)~=self.entryBox:getInternalText() then
            self:setCraftQuantity(amount);
        end
    end
    if self.buttonMore and _button==self.buttonMore then
        local amount = tonumber(self.entryBox:getInternalText());
        if not amount then amount = 1; end
        amount = amount + 1;

        if tostring(amount)~=self.entryBox:getInternalText() then
            self:setCraftQuantity(amount);
        end
    end
    if self.buttonLess and _button==self.buttonLess then
        local amount = tonumber(self.entryBox:getInternalText());
        if not amount then amount = 1; end
        amount = amount - 1;

        if tostring(amount)~=self.entryBox:getInternalText() then
            self:setCraftQuantity(amount);
        end
    end
end

function ISWidgetHandCraftControl:startHandcraft(force)
    if (not self.logic) or self.logic:isCraftActionInProgress() then
        return;
    end

    if self.allowBatchCraft then
        if not self.craftTimes then
            self.craftTimes = tonumber(self.entryBox:getInternalText()) or 1;
            self.craftTimes = math.max(1, self.craftTimes);
        end
    else
        self.craftTimes = 1;
    end

    self.returnToContainer = {};
    local items = self.logic:getRecipeData():getAllInputItems()
    local itemsToReturn = self.logic:getRecipeData():getAllPutBackInputItems()

    if self.logic:isUsingRecipeAtHandBenefit() then
        recipeAtHandItem = self.logic:getUsingRecipeAtHandItem()
        if recipeAtHandItem then
            items:add(recipeAtHandItem)
            itemsToReturn:add(recipeAtHandItem)
        end
    end

    if not self.logic:getRecipe():isCanBeDoneFromFloor() then
        for i=1,items:size() do
        local item = items:get(i-1)
            if item:getContainer() ~= self.player:getInventory() then
                ISInventoryPaneContextMenu.transferIfNeeded(self.player, item)
                if itemsToReturn:contains(item) then
                    table.insert(self.returnToContainer, item)
                end
            end
        end
    end

    self.logic:updateManualInputAllowedItemTypes();
    
    local actions = ISEntityUI.HandcraftStartMultiple(self.player, self.logic, force, self.craftTimes, false );
    if not actions then return; end
    for k,action in ipairs(actions) do
        if action then
            log(DebugType.CraftLogic, "=========== queuing craft ===========")
            action:setOnStart(self.onHandcraftActionStart, self);
            action:setOnComplete(self.onHandcraftActionComplete, self);
            action:setOnCancel(self.onHandcraftActionCancelled, self);
            ISTimedActionQueue.add(action);
        else
            log(DebugType.CraftLogic, "Aborting ISWidgetHandCraftControl:startHandcraft, cannot perform.")
            return
        end
    end
    ISCraftingUI.ReturnItemsToOriginalContainer(self.player, self.returnToContainer)
end

function ISWidgetHandCraftControl:onHandcraftActionStart(action)
    log(DebugType.CraftLogic, "ISWidgetHandCraftControl -> Craft action started")
    self.logic:startCraftAction(action);
    self:triggerEvent(ISEntityUI.HandcraftStart, self, self.player, self.logic);     
end

function ISWidgetHandCraftControl:onHandcraftActionComplete()
    log(DebugType.CraftLogic, "ISWidgetHandCraftControl -> Craft action completed")

    if self.craftTimes then
        self.craftTimes = self.craftTimes - 1;
        if self.craftTimes <= 0 then
            self.craftTimes = nil;
            self.logic:stopCraftAction();
        else
            self:setCraftQuantity(self.craftTimes);
        end
    end

    if not self.craftTimes then
        self.logic:stopCraftAction();
    end
end

function ISWidgetHandCraftControl:onHandcraftActionCancelled()
    log(DebugType.CraftLogic, "ISWidgetHandCraftControl -> Craft action cancelled")
    self.logic:stopCraftAction();
    self.craftTimes = nil;
end

function ISWidgetHandCraftControl.onTextChange(box)
    if not box then
        return;
    end
    if box==box.target.entryBox then
        box.target:sanitizeCraftQuantity();
    end
end

function ISWidgetHandCraftControl:onInputsChanged()
    self:sanitizeCraftQuantity();
end

function ISWidgetHandCraftControl:setCraftQuantity(amount)
    self.entryBox:setText(tostring(amount));
    self:sanitizeCraftQuantity();
end

function ISWidgetHandCraftControl:sanitizeCraftQuantity()
    local amount = tonumber(self.entryBox:getInternalText());
    if not amount then amount = 1; end
    
    local max = self.logic:getPossibleCraftCount(false);
    amount = PZMath.clamp(amount, 0, max);

    if amount == 0 and max > 0 then amount = 1; end
    
    if tostring(amount)~=self.entryBox:getInternalText() then
        self.entryBox:setText(tostring(amount));
    end
end

function ISWidgetHandCraftControl:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
    self:restoreJoypadFocus()
end

function ISWidgetHandCraftControl:onLoseJoypadFocus(joypadData)
    ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
    self:clearJoypadFocus()
end

function ISWidgetHandCraftControl:new(x, y, width, height, player, logic)
    local o = ISPanelJoypad.new(self, x, y, width, height);

    o.background = true;
    o.backgroundColor = {r=0.2, g=0.2, b=0.2, a=0.5};
    o.player = player;
    o.logic = logic;

    o.interactiveMode = false;
    o.allowBatchCraft = true;

    o.buttonPadding = 5;
    
    o.margin = 5;
    o.minimumWidth = 100;
    o.minimumHeight = 0;

    o.autoFillContents = false;

    -- these may or may not be used by a parent control while calculating layout:
    o.isAutoFill = false;
    o.isAutoFillX = false;
    o.isAutoFillY = false;
    return o;
end
