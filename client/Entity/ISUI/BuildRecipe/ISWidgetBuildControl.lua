require "ISUI/ISPanelJoypad"

local FONT_SCALE = getTextManager():getFontHeight(UIFont.Small) / 19; -- normalize to 1080p
local ICON_SCALE = math.max(1, math.floor(FONT_SCALE));
local BUTTON_ICON_SIZE = 16 * ICON_SCALE;

ISWidgetBuildControl = ISPanelJoypad:derive("ISWidgetBuildControl");

local debugSpam = true

function ISWidgetBuildControl:initialise()
	ISPanelJoypad.initialise(self);
end

function ISWidgetBuildControl:createChildren()
    ISPanelJoypad.createChildren(self);

    self.colProgress = safeColorToTable(self.xuiSkin:color("C_ValidGreen"));

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
    if isDebugEnabled() and debugSpam and (self.player:getRole() and self.player:getRole():hasCapability(Capability.UseBuildCheat)) then
        self.buttonForceCraft = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, 48, 32, "Force Action")
        self.buttonForceCraft.iconTexture = getTexture("media/textures/Item_Plumpabug_Left.png");
        self.buttonForceCraft.joypadTextureWH = BUTTON_ICON_SIZE;
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

    self.boxHeight = self.height;
end

function ISWidgetBuildControl:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    local minHeight = self.margin*3;
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

    self.joypadButtonsY = {}
    self.joypadButtons = {}
    self.joypadIndexY = 1
    self.joypadIndex = 1
    if self.slider and self.slider:isVisible() then
        self:insertNewLineOfButtons(self.slider)
    end
    self:insertNewLineOfButtons(self.buttonCraft)
    if self.buttonForceCraft then
        self:insertNewLineOfButtons(self.buttonForceCraft)
    end
end

function ISWidgetBuildControl:onResize()
    ISUIElement.onResize(self)
end

function ISWidgetBuildControl:prerender()
	if self.background then
		self:drawRectStatic(0, 0, self.width, self.boxHeight, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
		self:drawRectBorderStatic(0, 0, self.width, self.boxHeight, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
	end
    if self.buttonCraft then
        local cheat = self.player:isBuildCheat();
        local canBuild = self.logic:cachedCanPerformCurrentRecipe() or cheat;

        if self.logic:isCraftActionInProgress() then
            canBuild = false;
        end
        self.buttonCraft.enable = canBuild;
        self.buttonCraft:setVisible(true);
    end
end

function ISWidgetBuildControl:render()
    ISPanelJoypad.render(self);
    self:renderJoypadFocus()
end

function ISWidgetBuildControl:update()
    ISPanelJoypad.update(self);
end

function ISWidgetBuildControl:onAutoToggled(_newState)
    self.logic:setManualSelectInputs(_newState);
    self.logic:setLastManualInputMode(_newState);
end

function ISWidgetBuildControl:onButtonClick(_button)
    if self.buttonCraft and _button==self.buttonCraft then
        self:startBuild(false);
    end
    if self.buttonForceCraft and _button==self.buttonForceCraft then
        ISBuildMenu.cheat = true;
        self.player:setBuildCheat(true);
        sendPlayerExtraInfo(self.player)
        self:startBuild(true);
    end
    if self.buttonKnowAllRecipes and _button==self.buttonKnowAllRecipes then
        self.player:setKnowAllRecipes(not self.player:isKnowAllRecipes())
    end
end

function ISWidgetBuildControl:startBuild(force)
    ISBuildWindow.instance:createBuildIsoEntity();
    ISBuildWindow.instance:updateManualInputs();
    self.logic:updateManualInputAllowedItemTypes();
end

function ISWidgetBuildControl:onHandcraftActionComplete()
    self.logic:stopCraftAction();
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

function ISWidgetBuildControl:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
    self:restoreJoypadFocus()
end

function ISWidgetBuildControl:onLoseJoypadFocus(joypadData)
    ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
    self:clearJoypadFocus()
end

function ISWidgetBuildControl:new(x, y, width, height, player, logic)
    local o = ISPanelJoypad:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self

    o.background = true;
    o.backgroundColor = {r=0.2, g=0.2, b=0.2, a=0.5};
    o.player = player;
    o.logic = logic;
    o.interactiveMode = false;
    o.allowBatchCraft = true;

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
