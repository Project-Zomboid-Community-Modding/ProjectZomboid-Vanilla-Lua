--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************
require "ISUI/ISPanel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small);

ISWidgetTooltipOutput = ISPanel:derive("ISWidgetTooltipOutput");

function ISWidgetTooltipOutput:initialise()
	ISPanel.initialise(self);
end

function ISWidgetTooltipOutput:createChildren()
    ISPanel.createChildren(self);

    self.amountWidth = getTextManager():MeasureStringX(UIFont.Medium, "00/00")
    self.amountWidth2 = getTextManager():MeasureStringX(UIFont.Medium, "00.00")

    self.textColor = { r=1, g=1, b=1, a=1 };
    self.colPartial = safeColorToTable(self.xuiSkin:color("Orange"));
    self.colBad = safeColorToTable(self.xuiSkin:color("C_InvalidRed"));

    self.primary = self:createScriptValues(self.outputScript);

--     self.iconKeep = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISImage, 0, 0, 24, 24, self.textureKeep);
-- --     self.iconKeep = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISImage, 0, 0, 26, 12, self.textureKeep);
--     self.iconKeep.autoScale = true;
--     self.iconKeep:initialise();
--     self.iconKeep:instantiate();
--     self.iconKeep:setVisible(self.primary.isKeep);
--     self:addChild(self.iconKeep);

    local arrowTexture = nil;
    if self.consumeScript then
        --note: currently outputs cannot have a nested 'consume' script
        --self.secondary = ISWidgetInput.createScriptValues(self, self.consumeScript);
        --arrowTexture = self.textureConsume;
    elseif self.createScript then
        self.secondary = self:createScriptValues(self.createScript);
        arrowTexture = self.textureCreate;
    end

    if arrowTexture then
        self.arrow = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISImage, 0, 0, self.iconSize/2, self.iconSize, arrowTexture);
        --self.consumeArrow.noAspect = true;
        self.arrow.scaledWidth = self.iconSize/2;
        self.arrow.scaledHeight = self.iconSize;
        self.arrow:initialise();
        self.arrow:instantiate();
        self:addChild(self.arrow);
    end
end

function ISWidgetTooltipOutput:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    local spacing = self.margin;
    local minWidth = self.margin*2;

    minWidth = minWidth + self.iconSize + spacing;
    minWidth = minWidth + self.amountWidth + spacing;
    if self.interactiveMode or self.secondary then
        minWidth = minWidth + (self.iconSize/2) + spacing;
        minWidth = minWidth + self.iconSize + spacing;
        minWidth = minWidth + self.amountWidth2;
    else
        minWidth = minWidth + self.iconSize;
    end


    --width = math.max(width, minWidth);

    height = math.max(height, self.iconSize +(self.margin*2));

    local x = self.margin;

    self.primary.icon:setX(x);
    self.primary.icon:setY((height/2)-(self.primary.icon:getHeight()/2));
    x = self.primary.icon:getX() + self.primary.icon:getWidth() + spacing;

    local iconMid = self.primary.icon:getX() + (self.primary.icon:getWidth() / 2);
--     self.iconKeep:setX(iconMid - (self.iconKeep:getWidth()/2));
--     self.iconKeep:setY(height - self.iconKeep:getHeight() - 1);

    self.primary.label:setX(x);
    self.primary.label.originalX = self.primary.label:getX();
    self.primary.label:setY((height/2)-self.primary.label:getHeight()/2);
    x = self.primary.label:getX() + self.amountWidth + spacing;

    if self.arrow then
        self.arrow:setX(x);
        self.arrow:setY((height/2)-(self.arrow:getHeight()/2));
        x = self.arrow:getX() + self.arrow:getWidth() + spacing;
    end

    if self.secondary then
        self.secondary.icon:setX(x);
        self.secondary.icon:setY((height/2)-(self.secondary.icon:getHeight()/2));
        x = self.secondary.icon:getX() + self.secondary.icon:getWidth() + spacing;

        self.secondary.label:setX(x);
        self.secondary.label.originalX = self.secondary.label:getX();
        self.secondary.label:setY((height/2)-self.secondary.label:getHeight()/2);
        x = self.secondary.label:getX() + self.amountWidth2 + spacing;
    end

    self:setWidth(width);
    self:setHeight(height);
end

function ISWidgetTooltipOutput:onResize()
    --ISUIElement.onResize(self)
    ISUIElement.onResize(self)
end

function ISWidgetTooltipOutput:prerender()
    self:updateValues();
    ISPanel.prerender(self);
end

function ISWidgetTooltipOutput:render()
    ISPanel.render(self);
end

function ISWidgetTooltipOutput:update()
    ISPanel.update(self);
end

function ISWidgetTooltipOutput:createScriptValues(_script)
    local table = {};
    table.isCreate = true;
    table.script = _script;
    table.isKeep = false;
    table.iconTexture = nil;
    table.iconColor = { r=1,g=1,b=1,a=1 };
    table.cycleIcons = false;
    if _script:getResourceType()==ResourceType.Item then
        table.amount = _script:getIntAmount();
        table.maxAmount = _script:getIntMaxAmount();
        table.amountStr = tostring(round(table.amount,2));
        if _script:isVariableAmount() then
            table.amountStr = table.amountStr .. "-" .. tostring(round(table.maxAmount,2));
        end
        table.outputObjects = _script:getPossibleResultItems();
        if table.outputObjects:size()>0 then
            table.iconTexture = table.outputObjects:get(0):getNormalTexture();
            table.cycleIcons = table.outputObjects:size() > 1;
        end
    elseif _script:getResourceType()==ResourceType.Fluid then
        table.amount = _script:getAmount();
        table.maxAmount = _script:getMaxAmount();
        table.amountStr = tostring(round(table.amount,2)).."L";
        table.iconTexture = getTexture("media/textures/Item_Waterdrop_Grey.png");
        table.outputObjects = _script:getPossibleResultFluids();
        table.cycleIcons = table.outputObjects:size() > 1;
    elseif _script:getResourceType()==ResourceType.Energy then
        table.amount = _script:getAmount();
        table.maxAmount = _script:getMaxAmount();
        table.amountStr = tostring(Temperature.getRoundedDisplayTemperature(table.amount))..Temperature.getTemperaturePostfix();
        table.outputObjects = _script:getPossibleResultEnergies();
        if table.outputObjects:size()>0 then
            table.iconTexture = table.outputObjects:get(0):getIconTexture();
            table.cycleIcons = table.outputObjects:size() > 1;
        end
    end

    table.icon = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISImage, 0, 0, self.iconSize, self.iconSize, table.iconTexture);
    table.icon.autoScale = true;
    table.icon:initialise();
    table.icon:instantiate();
    self:addChild(table.icon);

    table.icon.tooltipUI = ISToolTip:new();
    table.icon.tooltipUI:setOwner(table.icon);
    table.icon.tooltipUI:setVisible(false);
    table.icon.tooltipUI:setAlwaysOnTop(true);
    table.icon.tooltipUI.maxLineWidth = 1000 -- don't wrap the lines
    table.icon.tooltipUI.nameMarginX = 0;
    table.icon.tooltipUI.defaultMyWidth = 0;

    local fontHeight = -1; -- <=0 sets label initial height to font
    table.label = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, table.amountStr, 1.0, 1.0, 1.0, 1, UIFont.Medium, true);
    --table.label.textColor = self.textColor;
    table.label:initialise();
    table.label:instantiate();
    self:addChild(table.label);

    return table;
end

function ISWidgetTooltipOutput:updateScriptValues(_table)
    local index = 0;
    if _table.script:getResourceType()==ResourceType.Item then
        if _table.cycleIcons then
            local playerIndex = self.player:getPlayerNum();
            index = UIManager.getSyncedIconIndex(playerIndex, _table.outputObjects:size());
        end
        local item = _table.outputObjects:get(index);
        _table.iconTexture = item:getNormalTexture();
		_table.iconColor.r = item:getR();
        _table.iconColor.g = item:getG();
        _table.iconColor.b = item:getB();
        _table.iconText = item:getDisplayName();
    elseif _table.script:getResourceType()==ResourceType.Fluid then
        if _table.cycleIcons then
            local playerIndex = self.player:getPlayerNum();
            index = UIManager.getSyncedIconIndex(playerIndex, _table.outputObjects:size());
        end
        local fluid = _table.outputObjects:get(index);
        local c = fluid:getColor();
        _table.iconColor.r = c:getRedFloat();
        _table.iconColor.g = c:getGreenFloat();
        _table.iconColor.b = c:getBlueFloat();
        _table.iconText = fluid:getDisplayName();
    elseif _table.script:getResourceType()==ResourceType.Energy then
        if _table.cycleIcons then
            local playerIndex = self.player:getPlayerNum();
            index = UIManager.getSyncedIconIndex(playerIndex, _table.outputObjects:size());
        end
        local energy = _table.outputObjects:get(index);
        _table.iconTexture = energy:getIconTexture();
        local c = energy:getColor();
        _table.iconColor.r = c:getRedFloat();
        _table.iconColor.g = c:getGreenFloat();
        _table.iconColor.b = c:getBlueFloat();
        _table.iconText = energy:getDisplayName();
    end

    if _table.icon then
        _table.icon.texture = _table.iconTexture;
        _table.icon.backgroundColor.r = _table.iconColor.r;
        _table.icon.backgroundColor.g = _table.iconColor.g;
        _table.icon.backgroundColor.b = _table.iconColor.b;

        if _table.iconText then
            _table.icon:setMouseOverText(_table.iconText);
        end
    end
end

function ISWidgetTooltipOutput:updateValues()
    if self.primary then
        self:updateScriptValues(self.primary);

        --if self.iconKeep then
            --self.iconKeep:setVisible(self.primary.isKeep);
        --end
    end

    if self.secondary then
        if self.secondary.isCreate then
            self:updateScriptValues(self.secondary);
        else
            ISWidgetInput.updateScriptValues(self, self.secondary);
        end
    end

    if self.logic and self.interactiveMode and self.outputScript:getResourceType()==ResourceType.Item then
        if self.logic:isManualSelectInputs() then
            local outputMapper = self.outputScript:getOutputMapper();
            local outputItem = outputMapper:getOutputItem(self.logic:getRecipeData(), true);
            if outputItem and outputItem:getNormalTexture() then
                self.primary.icon.texture = outputItem:getNormalTexture();
                self.primary.icon:setMouseOverText(outputItem:getDisplayName());
            end
        end
    end
end

--************************************************************************--
--** ISWidgetTooltipOutput:new
--**
--************************************************************************--
function ISWidgetTooltipOutput:new (x, y, width, height, player, logic, outputScript) --recipeData, outputScript)
	local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.player = player;
    o.logic = logic;
    --o.recipeData = recipeData;
    o.outputScript = outputScript;
    o.createScript = outputScript:getCreateToItemScript();

    o.iconSize = 32;

    o.interactiveMode = false;

    o.textureFluid = getTexture("media/textures/Item_Waterdrop_Grey.png");
    o.textureKeep = getTexture("media/ui/Entity/Crafting_Keep_24.png");
    o.textureDrain = getTexture("media/ui/Entity/Crafting_Drain_24.png");
--     o.textureKeep = getTexture("media/ui/Entity/keep_item_icon.png");
    o.textureConsume = getTexture("media/ui/Entity/icon_arrow_consume_grey.png");
    o.textureCreate = getTexture("media/ui/Entity/icon_arrow_create_grey.png");

    --o.background = false;

    o.margin = 5;
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