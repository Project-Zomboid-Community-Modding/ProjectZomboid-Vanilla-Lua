--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISPanel"

ISWidgetBuildControl = ISPanel:derive("ISWidgetBuildControl");

local debugSpam = true
-- local debugSpam = false
--************************************************************************--
--** ISWidgetBuildControl:initialise
--**
--************************************************************************--

function ISWidgetBuildControl:initialise()
	ISPanel.initialise(self);
end

function ISWidgetBuildControl:createChildren()
    ISPanel.createChildren(self);

    self.colProgress = safeColorToTable(self.xuiSkin:color("C_ValidGreen"));

    --local fontHeight = -1; -- <=0 sets label initial height to font
    --self.autoLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, getText("IGUI_CraftingWindow_ManualSelect"), 1.0, 1.0, 1.0, 1, UIFont.Small, true);
    --self.autoLabel:initialise();
    --self.autoLabel:instantiate();
    --self:addChild(self.autoLabel);
--
    --self.autoToggle = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISWidgetAutoToggle, 0, 0, nil, nil, true, self, ISWidgetBuildControl.onAutoToggled);
    --self.autoToggle.toggleState = self.logic:isManualSelectInputs();
    --self.autoToggle:initialise();
    --self.autoToggle:instantiate();
    --self:addChild(self.autoToggle);

    self.entryBox = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISTextEntryBox, "1", 0, 0, 70, 20);
    self.entryBox.font = UIFont.Small;
    self.entryBox:initialise();
    self.entryBox:instantiate();
    self.entryBox.onTextChange = ISWidgetBuildControl.onTextChange;
    self.entryBox.target = self;
    self.entryBox:setClearButton(true);
    self.entryBox:setOnlyNumbers(true);
    self:addChild(self.entryBox);

    self.slider = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISSliderPanel,0, 0, 100, 18, self, ISWidgetBuildControl.onSliderChange );
    self.slider.minValue = 1;
    self.slider:initialise();
    self.slider:instantiate();
    self.slider.valueLabel = false;
    self.slider:setCurrentValue( 1, true );
    --self.slider.customData = _data;
    self:addChild(self.slider);

    self.buttonCraft = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, 48, 32, getText("IGUI_CraftingWindow_Build"))
    --self.buttonPrev.image = getTexture("ArrowLeft");
    self.buttonCraft.font = UIFont.Medium;
    self.buttonCraft.target = self;
    self.buttonCraft.onclick = ISWidgetBuildControl.onButtonClick;
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
        self.buttonForceCraft.onclick = ISWidgetBuildControl.onButtonClick;
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
--         self.buttonKnowAllRecipes.onclick = ISWidgetBuildControl.onButtonClick;
--         self.buttonKnowAllRecipes.enable = true;
--         self.buttonKnowAllRecipes:initialise();
--         self.buttonKnowAllRecipes:instantiate();
--         self.buttonKnowAllRecipes.originalTitle = self.buttonKnowAllRecipes.title;
--         self:addChild(self.buttonKnowAllRecipes);
--     end

    self.boxHeight = self.height;
end

function ISWidgetBuildControl:calculateLayout(_preferredWidth, _preferredHeight)
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

    --self.autoToggle:setX(width-self.margin-self.autoToggle:getWidth());
    --self.autoToggle:setY(y);

    --local centerY = self.autoToggle:getY() + (self.autoToggle:getHeight()/2)
    --self.autoLabel:setX(self.autoToggle:getX() - self.margin - self.autoLabel:getWidth());
    --self.autoLabel.originalX = self.autoLabel:getX();
    --self.autoLabel:setY(centerY - (self.autoLabel:getHeight()/2));

    --y = y + self.autoToggle:getHeight() + (self.margin * 2);

    if self.allowBatchCraft and (not self.logic:isManualSelectInputs()) and self.entryBox and self.slider then
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

function ISWidgetBuildControl:onResize()
    ISUIElement.onResize(self)
end

function ISWidgetBuildControl:prerender()
    --ISPanel.prerender(self);

	if self.background then
		self:drawRectStatic(0, 0, self.width, self.boxHeight, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
		self:drawRectBorderStatic(0, 0, self.width, self.boxHeight, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
	end

    --local y = self.autoToggle:getY() + self.autoToggle:getHeight() + self.margin;
    --self:drawRectStatic(0, y, self.width, 1, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    --if self.logic and self.logic:isCraftActionInProgress() and self.logic:getCraftActionTable() then
        --local action = self.logic:getCraftActionTable();
        --local plrQueue = ISTimedActionQueue.getTimedActionQueue(self.player);
        --if plrQueue and plrQueue.queue and plrQueue.queue[1] and plrQueue.queue[1]==action then
        --    if self.buttonCraft then
        --        self.buttonCraft:setVisible(false);
        --        self.buttonCraft.enable = false;
        --        --self.buttonCraft.displayBackground = false;
        --        --self.buttonCraft:drawProgressBar(0, 0, self.buttonCraft:getWidth(), self.buttonCraft:getHeight(), action:getJobDelta(), self.colProgress);
        --        --self.buttonCraft.title = tostring(round(action:getJobDelta()*100, 0)).."%";
        --
        --        local title = tostring(round(action:getJobDelta()*100, 0)).."%";
        --        local x = self.buttonCraft:getX();
        --        local y = self.buttonCraft:getY();
        --        local width = self.buttonCraft:getWidth();
        --        local height = self.buttonCraft:getHeight();
        --
        --        self:drawProgressBar(x, y, width, height, action:getJobDelta(), self.colProgress);
        --
        --        local c = 0.3;
        --        self:drawRectBorder(x, y, width, height, 1.0, c, c, c);
        --
        --        local textW = getTextManager():MeasureStringX(self.buttonCraft.font, title)
        --        local textH = getTextManager():MeasureStringY(self.buttonCraft.font, title)
        --        --print("TextH = "..tostring(textH)..", TextW = "..tostring(textW))
        --        x = x + ((width / 2) - (textW / 2));
        --        y = y + ((height / 2) - (textH/2) + self.buttonCraft.yoffset);
        --        c = 0.1;
        --        self:drawText(title, x+1, y+1, c, c, c, 1, self.buttonCraft.font);
        --        self:drawText(title, x+1, y-1, c, c, c, 1, self.buttonCraft.font);
        --        self:drawText(title, x-1, y-1, c, c, c, 1, self.buttonCraft.font);
        --        self:drawText(title, x-1, y+1, c, c, c, 1, self.buttonCraft.font);
        --        c = 0.95;
        --        self:drawText(title, x, y, c, c, c, 1, self.buttonCraft.font);
        --    end
        --end
    --else
    if self.buttonCraft then
        local canBuild = self.logic:canPerformCurrentRecipe() or self.logic:isCraftCheat();

        if self.logic:isCraftActionInProgress() then
            canBuild = false;
        end
        self.buttonCraft.enable = canBuild;
        self.buttonCraft:setVisible(true);
        --self.buttonCraft.displayBackground = true;
        --self.buttonCraft.title = self.buttonCraft.originalTitle;
    end
    --end
end

function ISWidgetBuildControl:render()
    ISPanel.render(self);
end

function ISWidgetBuildControl:update()
    ISPanel.update(self);
end

function ISWidgetBuildControl:onAutoToggled(_newState)
    self.logic:setManualSelectInputs(_newState);
    --self:triggerEvent(ISWidgetBuildControl.onAutoToggled, self, _newState);
end

function ISWidgetBuildControl:onButtonClick(_button)
    if self.buttonCraft and _button==self.buttonCraft then
        self:startBuild(false);
    end
    if self.buttonForceCraft and _button==self.buttonForceCraft then
        self:startBuild(true);
    end
    if self.buttonKnowAllRecipes and _button==self.buttonKnowAllRecipes then
--         self:startHandcraft(true);
--         getDebugOptions():getBoolean("Cheat.Recipe.KnowAll")
        local option = true
        if getDebugOptions():getBoolean("Cheat.Recipe.KnowAll") then option = false end
        getDebugOptions():setBoolean("Cheat.Recipe.KnowAll", option)
    end
end

function ISWidgetBuildControl:startBuild(force)
    ISBuildWindow.instance:createBuildIsoEntity();
end

function ISWidgetBuildControl:onHandcraftActionComplete()
    print("ISWidgetBuildControl -> Craft action completed")
--     print("Return to container " .. tostring(self.returnToContainer))
    self.logic:stopCraftAction();
--     ISCraftingUI.ReturnItemsToOriginalContainer(self.player, self.returnToContainer)
end

function ISWidgetBuildControl:onSliderChange(_newval, _slider)
    if _slider==self.slider then
        self.entryBox:setText(tostring(_newval));
    end
end

function ISWidgetBuildControl.onTextChange(box)
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


--************************************************************************--
--** ISWidgetBuildControl:new
--**
--************************************************************************--
function ISWidgetBuildControl:new(x, y, width, height, player, logic)
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