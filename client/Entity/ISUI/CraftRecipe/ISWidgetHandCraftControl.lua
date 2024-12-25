--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISPanel"

ISWidgetHandCraftControl = ISPanel:derive("ISWidgetHandCraftControl");

local debugSpam = true
-- local debugSpam = false
--************************************************************************--
--** ISWidgetHandCraftControl:initialise
--**
--************************************************************************--

function ISWidgetHandCraftControl:initialise()
	ISPanel.initialise(self);
end

function ISWidgetHandCraftControl:createChildren()
    ISPanel.createChildren(self);

    self.colProgress = safeColorToTable(self.xuiSkin:color("C_ValidGreen"));

    self.entryBox = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISTextEntryBox, "1", 0, 0, 70, 20);
    self.entryBox.font = UIFont.Small;
    self.entryBox:initialise();
    self.entryBox:instantiate();
    self.entryBox.onTextChange = ISWidgetHandCraftControl.onTextChange;
    self.entryBox.target = self;
    self.entryBox:setClearButton(true);
    self.entryBox:setOnlyNumbers(true);
    self:addChild(self.entryBox);

    self.slider = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISSliderPanel,0, 0, 100, 18, self, ISWidgetHandCraftControl.onSliderChange );
    self.slider.minValue = 1;
    self.slider:initialise();
    self.slider:instantiate();
    self.slider.valueLabel = false;
    self.slider.maxValue = self.logic:getPossibleCraftCount(false);
    self.slider:setCurrentValue( 1, true );
    --self.slider.customData = _data;
    self:addChild(self.slider);

    self.buttonCraft = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, 48, 32, getText("IGUI_CraftingWindow_Craft"))
    --self.buttonPrev.image = getTexture("ArrowLeft");
    self.buttonCraft.font = UIFont.Medium;
    self.buttonCraft.target = self;
    self.buttonCraft.onclick = ISWidgetHandCraftControl.onButtonClick;
    self.buttonCraft.enable = true;
    self.buttonCraft:initialise();
    self.buttonCraft:instantiate();
    self.buttonCraft.originalTitle = self.buttonCraft.title;
    self:addChild(self.buttonCraft);

    self.origButtonHeight = self.buttonCraft:getHeight();

    -- Debug tool to force being able to do recipes regardless of knowing recipes, skills, whatever
    if isDebugEnabled() and debugSpam then
        self.buttonForceCraft = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, 48, 32, "Force Action")
        self.buttonForceCraft.iconTexture = getTexture("media/textures/Item_Insect_Aphid.png");
        --self.buttonPrev.image = getTexture("ArrowLeft");
        self.buttonForceCraft.font = UIFont.Medium;
        self.buttonForceCraft.target = self;
        self.buttonForceCraft.onclick = ISWidgetHandCraftControl.onButtonClick;
        self.buttonForceCraft.enable = true;
        self.buttonForceCraft:initialise();
        self.buttonForceCraft:instantiate();
        self.buttonForceCraft.originalTitle = self.buttonForceCraft.title;
        self:addChild(self.buttonForceCraft);
    end
    -- debug tool to know all recipes
--     if isDebugEnabled() and debugSpam then
--         self.buttonKnowAllRecipes = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, 48, 32, "(DEBUG) TOGGLE KNOW ALL RECIPES")
--         self.buttonKnowAllRecipes.iconTexture = getTexture("media/textures/Item_Insect_Aphid.png");
--         --self.buttonPrev.image = getTexture("ArrowLeft");
--         self.buttonKnowAllRecipes.font = UIFont.Medium;
--         self.buttonKnowAllRecipes.target = self;
--         self.buttonKnowAllRecipes.onclick = ISWidgetHandCraftControl.onButtonClick;
--         self.buttonKnowAllRecipes.enable = true;
--         self.buttonKnowAllRecipes:initialise();
--         self.buttonKnowAllRecipes:instantiate();
--         self.buttonKnowAllRecipes.originalTitle = self.buttonKnowAllRecipes.title;
--         self:addChild(self.buttonKnowAllRecipes);
--     end

    self.boxHeight = self.height;
end

function ISWidgetHandCraftControl:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    local minHeight = self.margin*3;
    --minHeight = minHeight + self.autoToggle:getHeight() + self.margin;
    minHeight = minHeight + self.entryBox:getHeight() + self.margin;
    minHeight = minHeight + self.buttonCraft:getHeight();
--     if isDebugEnabled() then
    if self.buttonForceCraft then
        minHeight = minHeight + self.buttonForceCraft:getHeight();
    end
    if self.buttonKnowAllRecipes then
        minHeight = minHeight + self.buttonForceCraft:getHeight();
    end
--     end

    height = math.max(height, minHeight);

    local x = self.margin;
    local y = self.margin;

    if self.allowBatchCraft and self.entryBox and self.slider then
        self.entryBox:setVisible(true);
        self.slider:setVisible(true);

        self.entryBox:setX(x);
        self.entryBox:setY(y);

        local centerY = self.entryBox:getY() + (self.entryBox:getHeight()/2);

        local offX = self.entryBox:getX() + self.entryBox:getWidth() + self.margin;
        self.slider:setX(offX);
        self.slider:setY(centerY - (self.slider:getHeight()/2));
        self.slider:setWidth(width-self.margin-offX);
        self.slider:paginate();

        y = self.entryBox:getY() + self.entryBox:getHeight() + self.margin;

    else
        if self.entryBox then self.entryBox:setVisible(false); end
        if self.slider then self.slider:setVisible(false); end

    end

    self.buttonCraft:setX(x);
    self.buttonCraft:setWidth(width-(self.margin*2));
    self.buttonCraft:setY(y);

    y = self.buttonCraft:getY() + self.buttonCraft:getHeight() + self.margin;

--     if isDebugEnabled() then
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
--     end

    self.boxHeight = y;
    --[[
    self.progressBar:setX(x);
    self.progressBar:setWidth(width-(self.margin*2));
    self.progressBar:setY(y);
    --]]

    self:setWidth(width);
    self:setHeight(height);
end

function ISWidgetHandCraftControl:onResize()
    ISUIElement.onResize(self)
end

function ISWidgetHandCraftControl:prerender()
    --ISPanel.prerender(self);

	if self.background then
		self:drawRectStatic(0, 0, self.width, self.boxHeight, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
		self:drawRectBorderStatic(0, 0, self.width, self.boxHeight, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
	end

    --local y = self.autoToggle:getY() + self.autoToggle:getHeight() + self.margin;
    --self:drawRectStatic(0, y, self.width, 1, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    if self.logic and self.logic:isCraftActionInProgress() and self.logic:getCraftActionTable() then
        local action = self.logic:getCraftActionTable();
        local plrQueue = ISTimedActionQueue.getTimedActionQueue(self.player);
        if plrQueue and plrQueue.queue and plrQueue.queue[1] and plrQueue.queue[1]==action then
            if self.buttonCraft then
                self.buttonCraft:setVisible(false);
                self.buttonCraft.enable = false;
                --self.buttonCraft.displayBackground = false;
                --self.buttonCraft:drawProgressBar(0, 0, self.buttonCraft:getWidth(), self.buttonCraft:getHeight(), action:getJobDelta(), self.colProgress);
                --self.buttonCraft.title = tostring(round(action:getJobDelta()*100, 0)).."%";

                local title = tostring(round(action:getJobDelta()*100, 0)).."%";
                local x = self.buttonCraft:getX();
                local y = self.buttonCraft:getY();
                local width = self.buttonCraft:getWidth();
                local height = self.buttonCraft:getHeight();

                self:drawProgressBar(x, y, width, height, action:getJobDelta(), self.colProgress);

                local c = 0.3;
                self:drawRectBorder(x, y, width, height, 1.0, c, c, c);

                local textW = getTextManager():MeasureStringX(self.buttonCraft.font, title)
                local textH = getTextManager():MeasureStringY(self.buttonCraft.font, title)
                --log(DebugType.CraftLogic, "TextH = "..tostring(textH)..", TextW = "..tostring(textW))
                x = x + ((width / 2) - (textW / 2));
                y = y + ((height / 2) - (textH/2) + self.buttonCraft.yoffset);
                c = 0.1;
                self:drawText(title, x+1, y+1, c, c, c, 1, self.buttonCraft.font);
                self:drawText(title, x+1, y-1, c, c, c, 1, self.buttonCraft.font);
                self:drawText(title, x-1, y-1, c, c, c, 1, self.buttonCraft.font);
                self:drawText(title, x-1, y+1, c, c, c, 1, self.buttonCraft.font);
                c = 0.95;
                self:drawText(title, x, y, c, c, c, 1, self.buttonCraft.font);
            end
        end
    else
        if self.buttonCraft then
            self.buttonCraft.enable = self.logic:cachedCanPerformCurrentRecipe();
            self.buttonCraft:setVisible(true);
            --self.buttonCraft.displayBackground = true;
            --self.buttonCraft.title = self.buttonCraft.originalTitle;
        end
    end
end

function ISWidgetHandCraftControl:render()
    ISPanel.render(self);
end

function ISWidgetHandCraftControl:update()
    ISPanel.update(self);
end

function ISWidgetHandCraftControl:onAutoToggled(_newState)
    self.logic:setManualSelectInputs(_newState);
    --self:triggerEvent(ISWidgetHandCraftControl.onAutoToggled, self, _newState);
end

function ISWidgetHandCraftControl:onButtonClick(_button)
    if self.buttonCraft and _button==self.buttonCraft then
        self:startHandcraft(false);
    end
    if self.buttonForceCraft and _button==self.buttonForceCraft then
        self:startHandcraft(true);
    end
    if self.buttonKnowAllRecipes and _button==self.buttonKnowAllRecipes then
--         self:startHandcraft(true);
--         getDebugOptions():getBoolean("Cheat.Recipe.KnowAll")
        local option = true
        if getDebugOptions():getBoolean("Cheat.Recipe.KnowAll") then option = false end
        getDebugOptions():setBoolean("Cheat.Recipe.KnowAll", option)
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

    self.returnToContainer = {}; -- keep track of items we moved to put them back to their original container
    --local items = self.logic:getRecipeData():getAllInputItems()
    --local itemsToReturn = self.logic:getRecipeData():getAllPutBackInputItems()
    --local recipe = self.logic:getRecipe()
    --log(DebugType.CraftLogic, "Recipe " .. tostring(recipe))
    --
    --if not recipe:isCanBeDoneFromFloor() then
    --    for i=1,items:size() do
    --        local item = items:get(i-1)
    --        if item:getContainer() ~= self.player:getInventory() then
    --            ISTimedActionQueue.add(ISInventoryTransferAction:new(self.player, item, item:getContainer(), self.player:getInventory(), nil))
    --            if itemsToReturn:contains(item) then
    --                table.insert(self.returnToContainer, item)
    --            end
    --        end
    --    end
    --end

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
end

function ISWidgetHandCraftControl:onHandcraftActionStart(action)
    log(DebugType.CraftLogic, "ISWidgetHandCraftControl -> Craft action started")
    self.logic:startCraftAction(action);
    self:triggerEvent(ISEntityUI.HandcraftStart, self, self.player, self.logic);     
end

function ISWidgetHandCraftControl:onHandcraftActionComplete()
    log(DebugType.CraftLogic, "ISWidgetHandCraftControl -> Craft action completed")
    self.logic:stopCraftAction();

    if self.craftTimes then
        self.craftTimes = self.craftTimes - 1;
        if self.craftTimes <= 0 then
            self.craftTimes = nil;
        else
            self.slider:setCurrentValue( self.craftTimes, false );
        end
    end

    if not self.craftTimes then
        ISCraftingUI.ReturnItemsToOriginalContainer(self.player, self.returnToContainer)
        --self.logic:stopCraftAction();
    end
end

function ISWidgetHandCraftControl:onHandcraftActionCancelled()
    log(DebugType.CraftLogic, "ISWidgetHandCraftControl -> Craft action cancelled")
    self.logic:stopCraftAction();
    self.craftTimes = nil;
end

function ISWidgetHandCraftControl:onSliderChange(_newval, _slider)
    if _slider==self.slider then
        self.entryBox:setText(tostring(_newval));
    end
end

function ISWidgetHandCraftControl.onTextChange(box)
    if not box then
        return;
    end
    if box==box.target.entryBox then
        local amount = tonumber(box.target.entryBox:getInternalText());
        if not amount then amount = 1; end
        amount = PZMath.clamp(amount, 1, 100);
        if tostring(amount)~=box.target.entryBox:getInternalText() then
            box.target.entryBox:setText(tostring(amount));
        end

        box.target.slider:setCurrentValue( amount, true );
    end
end

function ISWidgetHandCraftControl:onInputsChanged()
    if self.slider then
        self.slider.maxValue = self.logic:getPossibleCraftCount(false);
        local sliderVal = math.min(self.slider.currentValue, self.slider.maxValue);
        self.slider:setCurrentValue(sliderVal, false);
    end 
end

--************************************************************************--
--** ISWidgetHandCraftControl:new
--**
--************************************************************************--
function ISWidgetHandCraftControl:new(x, y, width, height, player, logic)
    local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self

    o.background = true;
    o.backgroundColor = {r=0.2, g=0.2, b=0.2, a=0.5};
    --o.margin = 5;
    o.player = player;
    o.logic = logic;

    o.interactiveMode = false;
    o.allowBatchCraft = true;

    o.margin = 5;
    o.minimumWidth = 100;
    o.minimumHeight = 0;

    --o.doToolTip = true;

    o.autoFillContents = false;

    -- these may or may not be used by a parent control while calculating layout:
    o.isAutoFill = false;
    o.isAutoFillX = false;
    o.isAutoFillY = false;
    return o;
end