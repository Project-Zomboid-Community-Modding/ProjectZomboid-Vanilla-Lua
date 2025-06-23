--***********************************************************
--**                    THE INDIE STONE                    **
--**            Author: turbotutone / spurcival            **
--***********************************************************
require "ISUI/ISPanel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small);
local FONT_SCALE = getTextManager():getFontHeight(UIFont.Small) / 19; -- normalize to 1080p
local ICON_SCALE = math.max(1, math.floor(FONT_SCALE));

ISWidgetOutput = ISPanel:derive("ISWidgetOutput");

function ISWidgetOutput:initialise()
	ISPanel.initialise(self);
end

function ISWidgetOutput:createChildren()
    ISPanel.createChildren(self);

    self.amountWidth = getTextManager():MeasureStringX(UIFont.Small, "00/00")
    self.amountWidth2 = getTextManager():MeasureStringX(UIFont.Small, "00.00")

    self.textColor = { r=1, g=1, b=1, a=1 };
    self.colPartial = safeColorToTable(self.xuiSkin:color("Orange"));
    self.colBad = safeColorToTable(self.xuiSkin:color("C_InvalidRed"));

    self.primary = self:createScriptValues(self.outputScript);

    -- identifier icons
    --self.iconConsumed = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISImage, 0, 0, self.labelIconSize, self.labelIconSize, self.textureConsumed);
    --self.iconConsumed.autoScale = true;
    --self.iconConsumed:initialise();
    --self.iconConsumed:instantiate();
    --self.iconConsumed:setVisible(not self.primary.isKeep);
    --self:addChild(self.iconConsumed);

    self.iconCreate = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISImage, 0, 0, self.labelIconSize, self.labelIconSize, self.textureCreate);
    self.iconCreate.autoScale = true;
    self.iconCreate:initialise();
    self.iconCreate:instantiate();
    self.iconCreate:setVisible(true);
    self:addChild(self.iconCreate);

    --self.iconTool = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISImage, 0, 0, self.labelIconSize, self.labelIconSize, self.textureTool);
    --self.iconTool.autoScale = true;
    --self.iconTool:initialise();
    --self.iconTool:instantiate();
    --self.iconTool:setVisible(self.primary.isKeep and self.primary.isTool and not self.displayAsOutput);
    --self:addChild(self.iconTool);

    --self.iconReturned = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISImage, 0, 0, self.labelIconSize, self.labelIconSize, self.textureReturned);
    --self.iconReturned.autoScale = true;
    --self.iconReturned:initialise();
    --self.iconReturned:instantiate();
    --self.iconReturned:setVisible(self.primary.isKeep and (self.displayAsOutput or not self.primary.isTool));
    --self:addChild(self.iconReturned);

    local arrowTexture = nil;
    if self.consumeScript then
        --note: currently outputs cannot have a nested 'consume' script
        --self.secondary = ISWidgetInput.createScriptValues(self, self.consumeScript, true);
        --arrowTexture = self.textureConsume;
    elseif self.createScript then
        self.secondary = self:createScriptValues(self.createScript, true);
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

function ISWidgetOutput:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    local spacing = self.margin;
    local labelHeight = math.max(self.primary.label:getHeight(), self.labelIconSize);
    local minHeight = self.iconBorderSizeY + spacing + labelHeight + self.margin;

    width = math.max(width, self.iconBorderSizeX);
    height = math.max(height, minHeight);

    self.primary.icon:setX((width/2)-(self.primary.icon:getWidth()/2));
    self.primary.icon:setY((self.iconBorderSizeY/2)-(self.primary.icon:getHeight()/2));
    if self.secondary then
        self.secondary.icon:setX((width/2)-(self.secondary.icon:getWidth()/2));
        self.secondary.icon:setY((self.iconBorderSizeY/2)-(self.secondary.icon:getHeight()/2));
    end

    -- set qty label
    local x = self.iconBorderSizeX - (self.margin*2) - self.primary.label:getWidth();
    local y = self.iconBorderSizeY - self.margin - self.primary.label:getHeight();
    self.primary.label:setX(x);
    self.primary.label.originalX = self.primary.label:getX();
    self.primary.label:setY(y);
    if self.secondary then
        x = self.iconBorderSizeX - (self.margin*2) - self.secondary.label:getWidth();
        self.secondary.label:setX(x);
        self.secondary.label.originalX = self.secondary.label:getX();
        self.secondary.label:setY(y);
    end
    self.primary.label:setVisible(self.secondary == nil);

    -- set icon positions
    x = 0
    y = self.margin + self.iconBorderSizeY + spacing;
    local iconAdj = (self.primary.label:getHeight() - self.labelIconSize) / 2;

    self.iconCreate:setX(x);
    self.iconCreate:setY(y + iconAdj);

    -- set item name label
    x = self.labelIconSize + spacing;
    local clampToWidth = width - x;
    local itemLabel = self.secondary and self.secondary.iconText or self.primary.iconText or "";
    local wrappedText = getTextManager():WrapText(self.primary.itemNameLabel.font, itemLabel, clampToWidth, 3, "...");
    local textHeight = getTextManager():MeasureStringY(self.primary.itemNameLabel.font, wrappedText);
    self.primary.itemNameLabel:setX(x);
    self.primary.itemNameLabel.originalX = self.primary.itemNameLabel:getX();
    self.primary.itemNameLabel:setName(wrappedText);
    self.primary.itemNameLabel:setHeight(textHeight);
    self.primary.itemNameLabel:setY(y);

    minHeight = self.iconBorderSizeY + spacing + (getTextManager():getFontHeight(UIFont.Small)*3) + self.margin;
    height = math.max(height, minHeight);

    if self.arrow then
        self.arrow:setX(x);
        self.arrow:setY((height/2)-(self.arrow:getHeight()/2));
        x = self.arrow:getX() + self.arrow:getWidth() + spacing;
    end

    self:setWidth(width);
    self:setHeight(height);
end

function ISWidgetOutput:onResize()
    --ISUIElement.onResize(self)
    ISUIElement.onResize(self)
end

function ISWidgetOutput:prerender()
    self:updateValues();
    ISPanel.prerender(self);
    
    -- border the main icon
    self:drawRectStatic(0, 0, self.iconBorderSizeX, self.iconBorderSizeY, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawRectBorderStatic(0, 0, self.iconBorderSizeX, self.iconBorderSizeY, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
end

function ISWidgetOutput:render()
    ISPanel.render(self);
end

function ISWidgetOutput:update()
    ISPanel.update(self);
end

function ISWidgetOutput:createScriptValues(_script)
    local table = {};
    table.isCreate = true;
    table.script = _script;
    table.isKeep = false;
    table.isTool = false;
    table.iconTexture = nil;
    table.iconColor = { r=1,g=1,b=1,a=1 };
    table.cycleIcons = false;
    if _script:getResourceType()==ResourceType.Item then
        table.amount = _script:getIntAmount();
        table.amountStr = tostring(round(table.amount,2));
        table.outputObjects = _script:getPossibleResultItems();
        if table.outputObjects:size()>0 then
            table.iconTexture = table.outputObjects:get(0):getNormalTexture();
            --table.cycleIcons = table.outputObjects:size() > 1;
        end
    elseif _script:getResourceType()==ResourceType.Fluid then
        table.amount = _script:getAmount();
        table.amountStr = tostring(round(table.amount,2)).."L";
        table.iconTexture = getTexture("media/textures/Item_Waterdrop_Grey.png");
        table.outputObjects = _script:getPossibleResultFluids();
        --table.cycleIcons = table.outputObjects:size() > 1;
    elseif _script:getResourceType()==ResourceType.Energy then
        table.amount = _script:getAmount();
        table.amountStr = tostring(Temperature.getRoundedDisplayTemperature(table.amount))..Temperature.getTemperaturePostfix();
        table.outputObjects = _script:getPossibleResultEnergies();
        if table.outputObjects:size()>0 then
            table.iconTexture = table.outputObjects:get(0):getIconTexture();
            --table.cycleIcons = table.outputObjects:size() > 1;
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
    table.label = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, table.amountStr, 1.0, 1.0, 1.0, 1, UIFont.Small, true);
    --table.label.textColor = self.textColor;
    table.label:initialise();
    table.label:instantiate();
    self:addChild(table.label);

    if not isSecondary then
        local fontHeight = -1; -- <=0 sets label initial height to font
        table.itemNameLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, table.amountStr, 1.0, 1.0, 1.0, 1, UIFont.Small, true);
        table.itemNameLabel.textColor = self.textColor;
        table.itemNameLabel:initialise();
        table.itemNameLabel:instantiate();
        self:addChild(table.itemNameLabel);
    end
    
    return table;
end

function ISWidgetOutput:updateScriptValues(_table)
    local index = 0;
    local oldIconText = _table.iconText;
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

    if _table.itemNameLabel and oldIconText ~= _table.iconText then
        self.editedLabels = true;
    end
end

function ISWidgetOutput:updateValues()
    if self.primary then
        self:updateScriptValues(self.primary);
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
            if outputItem and self.primary.itemNameLabel then
                self.primary.iconText = outputItem:getDisplayName();
                self.editedLabels = true;
            end
        end

        if self.editedLabels then
            self.editedLabels = false;
            self:calculateLayout(self.width,self.height);
        end
    end
end

--************************************************************************--
--** ISWidgetOutput:new
--**
--************************************************************************--
function ISWidgetOutput:new (x, y, width, height, player, logic, outputScript) --recipeData, outputScript)
	local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.player = player;
    o.logic = logic;
    --o.recipeData = recipeData;
    o.outputScript = outputScript;
    o.createScript = outputScript:getCreateToItemScript();

    o.iconSize = 48 * ICON_SCALE;
    o.iconMargin = 12 * FONT_SCALE;
    o.labelIconSize = 18 * ICON_SCALE;

    o.normalBorderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.iconBorderSizeX = (o.iconMargin * 2) + (o.iconSize*1.5);
    o.iconBorderSizeY = (o.iconMargin * 2) + o.iconSize;

    o.interactiveMode = false;

    o.textureReturned = getTexture("media/ui/Entity/Icon_Returned_48x48.png");
    o.textureConsumed = getTexture("media/ui/Entity/Icon_ItemConsumed_48x48.png");
    o.textureTool = getTexture("media/ui/Entity/Icon_Tools_48x48.png");
    o.textureCreate = getTexture("media/ui/Entity/Icon_Crafted_48x48.png");

    o.background = false;

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