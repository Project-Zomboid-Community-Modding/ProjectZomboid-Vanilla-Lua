--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************
require "ISUI/ISPanel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small);

ISWidgetTooltipInput = ISPanel:derive("ISWidgetTooltipInput");

function ISWidgetTooltipInput:initialise()
	ISPanel.initialise(self);
end

function ISWidgetTooltipInput:createChildren()
    ISPanel.createChildren(self);

    self.amountWidth = getTextManager():MeasureStringX(UIFont.Medium, "00/00")
    self.amountWidth2 = getTextManager():MeasureStringX(UIFont.Medium, "00.00")

    self.textColor = { r=1, g=1, b=1, a=1 };
    self.colPartial = safeColorToTable(self.xuiSkin:color("Orange"));
    self.colBad = safeColorToTable(self.xuiSkin:color("C_InvalidRed"));

    self.primary = self:createScriptValues(self.inputScript);

--     self.iconKeep = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISImage, 0, 0, 24, 24, self.textureKeep);
--     self.iconKeep.autoScale = true;
--     self.iconKeep:initialise();
--     self.iconKeep:instantiate();
--     self.iconKeep:setVisible(self.primary.isKeep);
--     self:addChild(self.iconKeep);


--     self.iconDrain = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISImage, 0, 0, 24, 24, self.textureDrain);
--     self.iconDrain.autoScale = true;
--     self.iconDrain:initialise();
--     self.iconDrain:instantiate();
--     self.iconDrain:setVisible(self.primary.isUse);
--     self:addChild(self.iconDrain);

    local arrowTexture = nil;
    if self.consumeScript then
        self.secondary = self:createScriptValues(self.consumeScript);
        arrowTexture = self.textureConsume;
    elseif self.createScript and self.displayAsOutput then
        self.secondary = ISWidgetOutput.createScriptValues(self, self.createScript);
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

function ISWidgetTooltipInput:calculateLayout(_preferredWidth, _preferredHeight)
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
--     self.iconDrain:setX(iconMid - (self.iconDrain:getWidth()/2));
--     self.iconDrain:setY(height - self.iconDrain:getHeight() - 1);

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

function ISWidgetTooltipInput:onResize()
    --ISUIElement.onResize(self)
    ISUIElement.onResize(self)
end

function ISWidgetTooltipInput:prerender()
    self:updateValues();
    ISPanel.prerender(self);
end

function ISWidgetTooltipInput:render()
    ISPanel.render(self);
end

function ISWidgetTooltipInput:update()
    ISPanel.update(self);
    --self:updateValues();
end

function ISWidgetTooltipInput:createScriptValues(_script)
    local table = {};
    table.isConsume = true;
    table.script = _script;
    table.isKeep = _script:isKeep();
    table.isUse = _script:isUse();
    table.iconTexture = nil;
    table.iconColor = { r=1,g=1,b=1,a=1 };
    table.cycleIcons = false;
    if _script:getResourceType()==ResourceType.Item then
        table.amount = _script:getIntAmount();
        table.amountStr = tostring(round(table.amount,2));
        table.inputObjects = _script:getPossibleInputItems();
        if table.inputObjects:size()>0 then
            table.iconTexture = table.inputObjects:get(0):getNormalTexture();
			table.iconColor = { r=table.inputObjects:get(0):getR(),g=table.inputObjects:get(0):getG(),b=table.inputObjects:get(0):getB(),a=1 };
            table.cycleIcons = table.inputObjects:size() > 1;
        end
    elseif _script:getResourceType()==ResourceType.Fluid then
        table.amount = _script:getAmount();
        table.amountStr = tostring(round(table.amount,2)).."L";
        table.iconTexture = getTexture("media/textures/Item_Waterdrop_Grey.png");
        table.inputObjects = _script:getPossibleInputFluids();
        --if table.inputObjects:size()>0 then
        --    local fluid = table.inputObjects:get(0);
        --    table.cycleIcons = table.inputObjects:size() > 1;
        --end
        table.cycleIcons = table.inputObjects:size() > 1;
    elseif _script:getResourceType()==ResourceType.Energy then
        --if not getDebug() then
            table.isKeep = false; --not displaying 'keep' for energies for now
        --end
        table.amount = _script:getAmount();
        table.amountStr = tostring(Temperature.getRoundedDisplayTemperature(table.amount))..Temperature.getTemperaturePostfix();
        table.inputObjects = _script:getPossibleInputEnergies();
        if table.inputObjects:size()>0 then
            table.iconTexture = table.inputObjects:get(0):getIconTexture();
            table.cycleIcons = table.inputObjects:size() > 1;
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
    table.label.textColor = self.textColor;
    table.label.amountValue = table.amount;
    table.label.satisfiedValue = -1;
    table.label:initialise();
    table.label:instantiate();
    self:addChild(table.label);

    return table;
end

function ISWidgetTooltipInput:updateScriptValues(_table)
    local index = 0;
    if _table.script:getResourceType()==ResourceType.Item then
        if _table.cycleIcons then
            local playerIndex = self.player:getPlayerNum();
            index = UIManager.getSyncedIconIndex(playerIndex, _table.inputObjects:size());
        end
        local item = _table.inputObjects:get(index);
        _table.iconTexture = item:getNormalTexture();
		_table.iconColor.r = item:getR();
        _table.iconColor.g = item:getG();
        _table.iconColor.b = item:getB();
        _table.iconText = item:getDisplayName();
    elseif _table.script:getResourceType()==ResourceType.Fluid then
        if _table.cycleIcons then
            local playerIndex = self.player:getPlayerNum();
            index = UIManager.getSyncedIconIndex(playerIndex, _table.inputObjects:size());
        end
        local fluid = _table.inputObjects:get(index);
        local c = fluid:getColor();
        _table.iconColor.r = c:getRedFloat();
        _table.iconColor.g = c:getGreenFloat();
        _table.iconColor.b = c:getBlueFloat();
        _table.iconText = fluid:getDisplayName();
    elseif _table.script:getResourceType()==ResourceType.Energy then
        if _table.cycleIcons then
            local playerIndex = self.player:getPlayerNum();
            index = UIManager.getSyncedIconIndex(playerIndex, _table.inputObjects:size());
        end
        local energy = _table.inputObjects:get(index);
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
            local text = _table.iconText
--             if _table.script:isBaseItem() then
--                text = text .. " <BR> " .. getText("IGUI_CraftingWindow_IsBaseItem")
--             end
            if _table.script:isSharpenable() then
               text = text .. " <BR> " .. getText("IGUI_CraftingWindow_IsSharpenable")
            end
            if _table.script:mayDegrade() and _table.script:isKeep() then
               text = text .. " <BR> " .. getText("IGUI_CraftingWindow_MayDegrade")
            end
            if _table.script:mayDegradeLight() and _table.script:isKeep() then
               text = text .. " <BR> " .. getText("IGUI_CraftingWindow_MayDegradeLight")
            end
            if _table.script:sharpnessCheck() and _table.script:isKeep() then
               text = text .. " <BR> " .. getText("IGUI_CraftingWindow_SharpnessCheck")
            end
            if _table.script:mayDegradeHeavy() and _table.script:isKeep() then
               text = text .. " <BR> " .. getText("IGUI_CraftingWindow_MayDegradeHeavy")
            end
            if _table.script:isNotDull() then
               text = text .. " <BR> " .. getText("IGUI_CraftingWindow_IsNotDull")
            end
            if _table.script:isWorn() then
               text = text .. " <BR> " .. getText("IGUI_CraftingWindow_IsWorn")
            end
            if _table.script:isNotWorn() then
               text = text .. "<BR>" .. getText("IGUI_CraftingWindow_IsNotWorn")
            end
            if _table.script:isFull() then
               text = text .. " <BR> " .. getText("IGUI_CraftingWindow_IsFull")
            end
            if _table.script:isEmpty() then
               text = text .. "<BR>" .. getText("IGUI_CraftingWindow_IsEmpty")
            end
            if _table.script:notFull() then
               text = text .. " <BR> " .. getText("IGUI_CraftingWindow_NotFull")
            end
            if _table.script:notEmpty() then
               text = text .. "<BR>" .. getText("IGUI_CraftingWindow_NotEmpty")
            end
            if _table.script:isDamaged() then
               text = text .. "<BR>" .. getText("IGUI_CraftingWindow_IsDamaged")
            end
            if _table.script:isUndamaged() then
               text = text .. "<BR>" .. getText("IGUI_CraftingWindow_IsUndamaged")
            end
            if _table.script:allowFrozenItem() then
               text = text .. " <BR> " .. getText("IGUI_CraftingWindow_AllowFrozenItem")
            end
            if _table.script:allowRottenItem() then
               text = text .. " <BR> " .. getText("IGUI_CraftingWindow_AllowRottenItem")
            end
            if _table.script:allowDestroyedItem() then
               text = text .. " <BR> " .. getText("IGUI_CraftingWindow_AllowDestroyedItem")
            end
            if _table.script:isEmptyContainer() then
               text = text .. " <BR> " .. getText("IGUI_CraftingWindow_IsEmptyContainer")
            end
            if _table.script:isWholeFoodItem() then
               text = text .. " <BR> " .. getText("IGUI_CraftingWindow_IsWholeFoodItem")
            end
            if _table.script:isUncookedFoodItem() then
               text = text .. " <BR> " .. getText("IGUI_CraftingWindow_IsUncookedFoodItem")
            end
            if _table.script:isCookedFoodItem() then
               text = text .. " <BR> " .. getText("IGUI_CraftingWindow_IsCookedFoodItem")
            end
--             if _table.script:isHandlePart() then
--                text = text .. " <BR> " .. getText("IGUI_CraftingWindow_IsHandle")
--             end
            if _table.script:isHeadPart() then
               text = text .. " <BR> " .. getText("IGUI_CraftingWindow_IsHead")
            end
            _table.icon:setMouseOverText(text);

        end
    end
end

function ISWidgetTooltipInput:updateValues()
    if self.primary then
        self:updateScriptValues(self.primary);

--         if self.iconKeep then
--             self.iconKeep:setVisible((not self.displayAsOutput) and self.primary.isKeep);
--         end
    end

    if self.secondary then
        if self.secondary.isConsume then
            self:updateScriptValues(self.secondary);
        else
            ISWidgetOutput.updateScriptValues(self, self.secondary);
        end
    end

    self.primary.icon.backgroundColor.a = 1.0;
--     self.iconKeep.backgroundColor.a = 1.0;
--     self.iconDrain.backgroundColor.a = 1.0;

    local satisfied = true;
    if self.logic then
        satisfied = self.logic:isInputSatisfied(self.inputScript);
    end

    if not satisfied then
        self.primary.label.textColor = self.colBad;
        if self.secondary and (not self.displayAsOutput) then
            self.secondary.label.textColor = self.colBad;
        end
        self.borderColor = self.colBad;
    else
        self.primary.label.textColor = self.textColor;
        if self.secondary and (not self.displayAsOutput) then
            self.secondary.label.textColor = self.textColor;
        end
        self.borderColor = self.normalBorderColor;
    end

    if self.logic and self.interactiveMode and self.inputScript:getResourceType()==ResourceType.Item then
        if self.logic:isManualSelectInputs() then
            self.editedLabels = true;
            local amount = self.inputScript:getIntAmount();
            local satisfiedAmount = self.logic:getInputCount(self.inputScript);
            if self.primary.label.amountValue~=amount or self.primary.label.satisfiedValue~=satisfiedAmount then
                if not self.displayAsOutput then
                    self.primary.label:setName(tostring(satisfiedAmount).."/"..tostring(amount));
                end
                self.primary.label.amountValue = amount;
                self.primary.label.satisfiedValue = satisfiedAmount;
            end
            if satisfiedAmount>0 and satisfiedAmount<amount then
                self.primary.label.textColor = self.colPartial;
                self.borderColor = self.colPartial;
            elseif satisfiedAmount<amount then
                self.primary.icon.backgroundColor.a = 0.25;
--                 self.iconKeep.backgroundColor.a = 0.25;
            end
            local inputItem = self.logic:getRecipeData():getFirstManualInputFor(self.inputScript);
            if inputItem and inputItem:getScriptItem() and inputItem:getScriptItem():getNormalTexture() then
                self.primary.icon.texture = inputItem:getScriptItem():getNormalTexture();
                self.primary.icon:setMouseOverText(inputItem:getDisplayName());
            end
        elseif self.editedLabels then
            self.editedLabels = false;
            self.primary.label:setName(tostring(self.primary.amountStr));
        end
    end
end

--************************************************************************--
--** ISWidgetTooltipInput:new
--**
--************************************************************************--
function ISWidgetTooltipInput:new (x, y, width, height, player, logic, inputScript) --recipeData, inputScript)
	local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.player = player;
    o.logic = logic;
    --o.recipeData = recipeData;
    o.inputScript = inputScript;
    o.consumeScript = inputScript:getConsumeFromItemScript();
    o.createScript = inputScript:getCreateToItemScript();

    o.iconSize = 32;

    o.interactiveMode = false;
    o.displayAsOutput = false;

    o.normalBorderColor = {r=0.4, g=0.4, b=0.4, a=1};

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