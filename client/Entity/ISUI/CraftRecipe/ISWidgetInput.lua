--***********************************************************
--**                    THE INDIE STONE                    **
--**             Author: turbotutone / spurcival           **
--***********************************************************
require "ISUI/ISPanel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small);
local FONT_SCALE = getTextManager():getFontHeight(UIFont.Small) / 19; -- normalize to 1080p
local ICON_SCALE = math.max(1, math.floor(FONT_SCALE));

ISWidgetInput = ISPanel:derive("ISWidgetInput");

function ISWidgetInput:initialise()
	ISPanel.initialise(self);
end

function ISWidgetInput:createChildren()
    ISPanel.createChildren(self);

    self.amountWidth = getTextManager():MeasureStringX(UIFont.Small, "00/00")
    self.amountWidth2 = getTextManager():MeasureStringX(UIFont.Small, "00.00")

    self.textColor = { r=1, g=1, b=1, a=1 };
    self.colPartial = safeColorToTable(self.xuiSkin:color("Orange"));
    self.colBad = safeColorToTable(self.xuiSkin:color("C_InvalidRed"));

    self.primary = self:createScriptValues(self.inputScript);

    -- identifier icons
    local icon = self.textureConsumed;
    --if not self.primary.isItemCount then
    --    self.iconConsumed.texture = self.textureUsed;
    --end
    self.iconConsumed = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISImage, 0, 0, self.labelIconSize, self.labelIconSize, icon);
    self.iconConsumed.autoScale = true;
    self.iconConsumed:initialise();
    self.iconConsumed:instantiate();
    self.iconConsumed:setVisible(not self.primary.isKeep);
    self.iconConsumed.mouseovertext = getText("IGUI_CraftingWindow_WillBeDestroyed");
    self:addChild(self.iconConsumed);

    --self.iconCreate = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISImage, 0, 0, self.labelIconSize, self.labelIconSize, self.textureCreate);
    --self.iconCreate.autoScale = true;
    --self.iconCreate:initialise();
    --self.iconCreate:instantiate();
    --self.iconCreate:setVisible(self.primary.isKeep);
    --self:addChild(self.iconCreate);

    self.iconTool = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISImage, 0, 0, self.labelIconSize, self.labelIconSize, self.textureTool);
    self.iconTool.autoScale = true;
    self.iconTool:initialise();
    self.iconTool:instantiate();
    self.iconTool:setVisible(self.primary.isKeep and self.primary.isTool and not self.displayAsOutput);
    self.iconTool.mouseovertext = getText("IGUI_CraftingWindow_WillBeKept");
    self:addChild(self.iconTool);

    self.iconReturned = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISImage, 0, 0, self.labelIconSize, self.labelIconSize, self.textureReturned);
    self.iconReturned.autoScale = true;
    self.iconReturned:initialise();
    self.iconReturned:instantiate();
    self.iconReturned:setVisible(self.primary.isKeep and (self.displayAsOutput or not self.primary.isTool));
    self.iconReturned.mouseovertext = getText("IGUI_CraftingWindow_WillBeKept");
    self:addChild(self.iconReturned);

    local arrowTexture = nil;
    if self.consumeScript then
        self.secondary = self:createScriptValues(self.consumeScript, true);
        arrowTexture = self.textureConsume;
    elseif self.createScript and self.displayAsOutput then
        self.secondary = ISWidgetOutput.createScriptValues(self, self.createScript, true);
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

function ISWidgetInput:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    local topMargin = self.logic:isManualSelectInputs() and self.selectInputButtonSize / 2 or 0;
    local spacing = self.margin;
    local labelHeight = math.max(self.primary.label:getHeight(), self.labelIconSize);
    local minHeight = topMargin + self.iconBorderSizeY + spacing + labelHeight + self.margin;
    
    width = math.max(width, self.iconBorderSizeX + topMargin);
    height = math.max(height, minHeight);

    self.primary.icon:setX((self.iconBorderSizeX/2)-(self.primary.icon:getWidth()/2));
    self.primary.icon:setY(topMargin + (self.iconBorderSizeY/2)-(self.primary.icon:getHeight()/2));
    if self.secondary then
        self.secondary.icon:setX((self.iconBorderSizeX/2)-(self.secondary.icon:getWidth()/2));
        self.secondary.icon:setY(topMargin + (self.iconBorderSizeY/2)-(self.secondary.icon:getHeight()/2));
    end
    
    -- set qty label
    local x = self.iconBorderSizeX - (self.margin*2) - self.primary.label:getWidth();
    local y = topMargin + self.iconBorderSizeY - self.margin - self.primary.label:getHeight();
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

    -- set selectInputButton pos
    if self.primary.selectInputButton then
        x = self.iconBorderSizeX - self.primary.selectInputButton:getWidth() + topMargin;
        y = 0
        self.primary.selectInputButton:setX(x);
        self.primary.selectInputButton:setY(y);
    end
    
    -- set icon positions
    x = 0
    y = topMargin + self.iconBorderSizeY + spacing;
    local iconAdj = (self.primary.label:getHeight() - self.labelIconSize) / 2;

    self.iconTool:setX(x);
    self.iconTool:setY(y + iconAdj);
    self.iconConsumed:setX(x);
    self.iconConsumed:setY(y + iconAdj);
    self.iconReturned:setX(x);
    self.iconReturned:setY(y + iconAdj);
    
    -- set item name label
    x = self.labelIconSize + spacing;
    local clampToWidth = self.iconBorderSizeX - x;
    local itemLabel = self.secondary and self.secondary.iconText or self.primary.iconText or "";
    if self.primary.isItemCount and self.primary.iconText and self.secondary and self.secondary.iconText then
        -- combine the labels for itemcount primaries with drainable contents
        itemLabel = getText("IGUI_CraftingWindow_InputWithContents", self.primary.iconText, self.secondary.iconText);
    end
    
    local wrappedText = getTextManager():WrapText(self.primary.itemNameLabel.font, itemLabel, clampToWidth, 3, "...");
    local textHeight = getTextManager():MeasureStringY(self.primary.itemNameLabel.font, wrappedText);
    self.primary.itemNameLabel:setX(x);
    self.primary.itemNameLabel.originalX = self.primary.itemNameLabel:getX();
    self.primary.itemNameLabel:setName(wrappedText);
    self.primary.itemNameLabel:setHeight(textHeight);
    self.primary.itemNameLabel:setY(y);

    minHeight = topMargin + self.iconBorderSizeY + spacing + (getTextManager():getFontHeight(UIFont.Small)*3) + self.margin;
    height = math.max(height, minHeight);

    if self.arrow then
        self.arrow:setX(x);
        self.arrow:setY((height/2)-(self.arrow:getHeight()/2));
        x = self.arrow:getX() + self.arrow:getWidth() + spacing;
    end
    
    self:setWidth(width);
    self:setHeight(height);
end

function ISWidgetInput:onResize()
    --ISUIElement.onResize(self)
    ISUIElement.onResize(self)
end

function ISWidgetInput:prerender()
    self:updateValues();
    ISPanel.prerender(self);

    if self.primary and self.primary.selectInputButton and self:isMouseOver() then
        self:drawRect(-4, -4, self.width + 4 * 2, self.height + 4 * 2, 0.1, 1.0, 1.0, 1.0)
    end
    
    -- border the main icon
    local topMargin = self.primary.selectInputButton:isVisible() and self.selectInputButtonSize / 2 or 0;
    self:drawRectStatic(0, topMargin, self.iconBorderSizeX, self.iconBorderSizeY, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawRectBorderStatic(0, topMargin, self.iconBorderSizeX, self.iconBorderSizeY, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
end

function ISWidgetInput:render()
    ISPanel.render(self);
    self:renderJoypadFocus(-4, -4, self.width + 8, self.height + 8)
end

function ISWidgetInput:update()
    ISPanel.update(self);
    --self:updateValues();
end

function ISWidgetInput:createScriptValues(_script, isSecondary)
    local table = {};
    table.isConsume = true;
    table.script = _script;
    table.isDrain = false;
    table.isKeep = _script:isKeep();
    table.isTool = _script:isTool();
    table.isItemCount = _script:isItemCount();
    table.inputFullName = nil;
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

        --table.inputObjects = _script:getPossibleInputItems();
        table.inputObjects = self.logic:getSatisfiedInputItems(_script);
        if table.inputObjects:size() == 0 then
            table.inputObjects = _script:getPossibleInputItems();
        end

        if table.inputObjects:size()>0 then
            table.iconTexture = table.inputObjects:get(0):getNormalTexture();
            table.iconColor = { r=table.inputObjects:get(0):getR(),g=table.inputObjects:get(0):getG(),b=table.inputObjects:get(0):getB(),a=1 };
            --table.cycleIcons = table.inputObjects:size() > 1;
            table.inputFullName = table.inputObjects:get(0):getFullName();
            table.inputItem = table.inputObjects:get(0);
        end
    elseif _script:getResourceType()==ResourceType.Fluid then
        table.amount = _script:getAmount();
        table.satisfiedAmount = self.logic:getInputUses(_script);
        if self.displayAsOutput then
            table.amount = self.logic:getResidualFluidFromInput(_script);
        end
        if table.amount < 0 then
            table.amountStr = "?";
        else
            if self.displayAsOutput then
                table.amountStr = tostring(round(table.amount,2)).."L";
            else
                table.amountStr = tostring(round(table.satisfiedAmount,2)).."/"..tostring(round(table.amount,2)).."L";
            end
        end
        table.iconTexture = getTexture("media/textures/Item_Waterdrop_Grey.png");
        table.inputObjects = self.logic:getSatisfiedInputFluids(_script);
        if table.inputObjects:size() == 0 then
            table.inputObjects = _script:getPossibleInputFluids();
        end
        if table.inputObjects:size()>0 then
            table.inputFullName = table.inputObjects:get(0):getFluidTypeString();
        --    local fluid = table.inputObjects:get(0);
        --    table.cycleIcons = table.inputObjects:size() > 1;
        end
        --table.cycleIcons = table.inputObjects:size() > 1;
    elseif _script:getResourceType()==ResourceType.Energy then
        --if not getDebug() then
            table.isKeep = false; --not displaying 'keep' for energies for now
        --end
        table.amount = _script:getAmount();
        table.amountStr = tostring(Temperature.getRoundedDisplayTemperature(table.amount))..Temperature.getTemperaturePostfix();
        table.inputObjects = _script:getPossibleInputEnergies();
        if table.inputObjects:size()>0 then
            table.iconTexture = table.inputObjects:get(0):getIconTexture();
            --table.cycleIcons = table.inputObjects:size() > 1;
            table.inputFullName = table.inputObjects:get(0):getEnergyTypeString();
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
    table.label.textColor = self.textColor;
    table.label.amountValue = table.amount;
    table.label.satisfiedValue = -1;
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
        
        -- draw manual input button
        table.selectInputButton =ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, self.selectInputButtonSize, self.selectInputButtonSize, nil);
        table.selectInputButton.image = self.textureSwapInput;
        table.selectInputButton.borderColor = {r=0, g=0, b=0, a=0};
        table.selectInputButton.backgroundColor = {r=0.8, g=0.8, b=0.8, a=1};
        table.selectInputButton.backgroundColorMouseOver = {r=0.365, g=0.196, b=0.125, a=1};
        table.selectInputButton.textureColor = {r=0, g=0, b=0, a=1};
        table.selectInputButton.target = self;
        table.selectInputButton:initialise();
        table.selectInputButton:instantiate();
        self:addChild(table.selectInputButton)
        table.selectInputButton:setVisible(self.logic:isManualSelectInputs());
    end

    return table;
end

function ISWidgetInput:onMouseDown(x, y)
    if self.primary and self.primary.selectInputButton then
        getSoundManager():playUISound("UIActivateButton")
        self:onSelectInputsClicked(self.primary.selectInputButton)
    end
end

function ISWidgetInput:onMouseDownOutside(x, y)
    if self:isMouseOver() then -- clicked in a child
        self:onMouseDown(x, y)
    end
end

function ISWidgetInput:onSelectInputsClicked(_button)
    -- check if we are already the active button
    if self.logic:getManualSelectInputScriptFilter() == self.inputScript then
        -- we are active - close the manual inputs panel
        self.logic:setShowManualSelectInputs(false);
        self.logic:setManualSelectInputScriptFilter(nil);
        return;
    end

    self.logic:setShowManualSelectInputs(true);
    self.logic:setManualSelectInputScriptFilter(self.inputScript);
    
    --print("onSelectInputsClicked()");
end

function ISWidgetInput:updateScriptValues(_table)
    local index = 0;
    local oldIconText = _table.iconText;
    if _table.script:getResourceType()==ResourceType.Item then
        -- update table with satisfied items if possible
        _table.inputObjects = self.logic:getSatisfiedInputItems(_table.script);
        if _table.inputObjects:size() == 0 then
            _table.inputObjects = _table.script:getPossibleInputItems();
        end

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
        _table.inputFullName = item:getFullName();
        _table.inputItem = item;
    elseif _table.script:getResourceType()==ResourceType.Fluid then
        -- update table with satisfied fluids if possible
        _table.inputObjects = self.logic:getSatisfiedInputFluids(_table.script);
        if _table.inputObjects:size() == 0 then
            _table.inputObjects = _table.script:getPossibleInputFluids();
        end

        if _table.cycleIcons then
            local playerIndex = self.player:getPlayerNum();
            index = UIManager.getSyncedIconIndex(playerIndex, _table.inputObjects:size());
        end
        local fluid = _table.inputObjects:get(index);
        _table.amount = _table.script:getAmount();
        _table.satisfiedAmount = self.logic:getInputUses(_table.script);
        if self.displayAsOutput then
            _table.amount = self.logic:getResidualFluidFromInput(_table.script);
        end
        if _table.amount < 0 then
            _table.amountStr = "?";
        else
            if self.displayAsOutput then
                _table.amountStr = tostring(round(_table.amount,2)).."L";
            else
                _table.amountStr = tostring(round(_table.satisfiedAmount,2)).."/"..tostring(round(_table.amount,2)).."L";
            end
        end
        _table.label:setName(_table.amountStr);
        local c = fluid:getColor();
        _table.iconColor.r = c:getRedFloat();
        _table.iconColor.g = c:getGreenFloat();
        _table.iconColor.b = c:getBlueFloat();
        _table.iconText = _table.script:getInputFluidFilterDisplayName() or fluid:getDisplayName();
        _table.tooltipText = _table.script:getInputFluidFilterTooltip();
        _table.inputFullName = fluid:getFluidTypeString();
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
        _table.inputFullName = energy:getEnergyTypeString();
    end

    if _table.icon then
        _table.icon.texture = _table.iconTexture;
        _table.icon.backgroundColor.r = _table.iconColor.r;
        _table.icon.backgroundColor.g = _table.iconColor.g;
        _table.icon.backgroundColor.b = _table.iconColor.b;

        if _table.iconText then
            local text = _table.tooltipText or _table.iconText
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
            if _table.script:mayDegradeVeryLight() and _table.script:isKeep() then
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
               text = text .. " <BR> " .. getText("IGUI_CraftingWindow_IsNotWorn")
            end
            if _table.script:isFull() then
               text = text .. " <BR> " .. getText("IGUI_CraftingWindow_IsFull")
            end
            if _table.script:isEmpty() then
               text = text .. " <BR> " .. getText("IGUI_CraftingWindow_IsEmpty")
            end
            if _table.script:notFull() then
               text = text .. " <BR> " .. getText("IGUI_CraftingWindow_NotFull")
            end
            if _table.script:notEmpty() then
               text = text .. " <BR> " .. getText("IGUI_CraftingWindow_NotEmpty")
            end
            if _table.script:isDamaged() then
               text = text .. " <BR> " .. getText("IGUI_CraftingWindow_IsDamaged")
            end
            if _table.script:isUndamaged() then
               text = text .. " <BR> " .. getText("IGUI_CraftingWindow_IsUndamaged")
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
               text = text .. " <BR> " .. getText("IGUI_CraftingWindow_IsHeadPart")
            end
            _table.icon:setMouseOverText(text);

        end
    end

    if _table.itemNameLabel and oldIconText ~= _table.iconText then
        self.editedLabels = true;
    end
end

function ISWidgetInput:updateValues()
    if self.primary then
        self:updateScriptValues(self.primary);

        self.iconTool:setVisible(self.primary.isKeep and self.primary.isTool and not self.displayAsOutput);
        self.iconReturned:setVisible(self.primary.isKeep and (self.displayAsOutput or not self.primary.isTool));
        self.iconConsumed:setVisible(not self.primary.isKeep);
    end

    if self.secondary then
        if self.secondary.isConsume then
            self:updateScriptValues(self.secondary);
        else
            ISWidgetOutput.updateScriptValues(self, self.secondary);
        end
    end

    self.primary.icon.backgroundColor.a = 1.0;

    local satisfied = true;
    if self.logic then
        satisfied = self.logic:isInputSatisfied(self.inputScript);
    end
    
    if self.primary.selectInputButton then
        self.primary.selectInputButton:setVisible(self.logic:isManualSelectInputs());
        self.primary.selectInputButton.image = satisfied and self.textureSwapInput or self.textureMissingInput;
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
            local inputItem = self.logic:getRecipeData():getFirstManualInputFor(self.inputScript);
            if inputItem then
                self.primary.icon:setMouseOverText(self.primary.tooltipText or inputItem:getDisplayName());
                if self.primary.itemNameLabel then
                    self.primary.iconText = inputItem:getDisplayName();
                end
                if inputItem:getScriptItem() then
                    self.primary.inputFullName = inputItem:getScriptItem():getFullName();
                    self.primary.icon.texture = inputItem:getScriptItem():getNormalTexture();
                end
            end
        end
        
        local amount = self.primary.inputFullName and self.inputScript:getAmount(self.primary.inputFullName) or self.inputScript:getIntAmount();
        local maxAmount = self.primary.inputFullName and self.inputScript:getMaxAmount(self.primary.inputFullName) or self.inputScript:getIntMaxAmount();
        local satisfiedAmount = self.logic:getInputCount(self.inputScript);
        
        if self.primary.label.amountValue~=maxAmount or self.primary.label.satisfiedValue~=satisfiedAmount then
            self.editedLabels = true;
            if not self.primary.isKeep and self.primary.inputItem and self.primary.inputItem:getTypeString() == "Drainable" and not self.inputScript:isItemCount() then
                self.iconConsumed.texture = self.textureUsed;
                self.iconConsumed.mouseovertext = getText("IGUI_CraftingWindow_WillBeConsume", tostring(amount));
            end
            if not self.displayAsOutput then
                local inputItem = self.logic:getRecipeData():getFirstManualInputFor(self.inputScript);
                local item = inputItem and inputItem:getScriptItem() or self.primary.inputItem;
                if self.inputScript:isUsesPartialItem(item) then
                    if inputItem and not self.logic:getRecipeData():getDataForInputScript(self.inputScript):isInputItemsSatisfied() then 
                        self.primary.label:setName(tostring(satisfiedAmount).."/"..tostring(maxAmount).." "..getText("Attributes_Type_Uses"));                        
                    else
                        if self.primary.script:isVariableAmount() then
                            self.primary.label:setName(tostring(amount).."-"..tostring(maxAmount).." "..getText("Attributes_Type_Uses"));
                        else
                            self.primary.label:setName(tostring(amount).." "..getText("Attributes_Type_Uses"));
                        end
                    end
                else
                    self.primary.label:setName(tostring(satisfiedAmount).."/"..tostring(maxAmount));
                end
                
            end
            self.primary.label.amountValue = maxAmount;
            self.primary.label.satisfiedValue = satisfiedAmount;
        end

        if satisfiedAmount>0 and satisfiedAmount<amount then
            self.primary.label.textColor = self.colPartial;
            self.borderColor = self.colPartial;
        elseif satisfiedAmount<amount then
            self.primary.icon.backgroundColor.a = 0.25;
        end

        if self.editedLabels then
            self.editedLabels = false;
            self:calculateLayout(self.width,self.height);
        end
    end
end

function ISWidgetInput:onRebuildItemNodes(_inputItems)
    if self.primary and self.primary.selectInputButton then
        if self.logic:shouldShowManualSelectInputs() and self.logic:getManualSelectInputScriptFilter() == self.inputScript then
            -- lock our button to active visual
            self.primary.selectInputButton.backgroundColor = self.selectInputButtonBackgroundColorMouseOver;
            self.primary.selectInputButton.backgroundColorMouseOver = self.selectInputButtonBackgroundColor;
            self.primary.selectInputButton.textureColor = self.selectInputButtonTextureColorMouseOver;
            self.primary.selectInputButton.textureColorMouseOver = self.selectInputButtonTextureColor;
        else
            -- revert button to normal colour
            self.primary.selectInputButton.backgroundColor = self.selectInputButtonBackgroundColor;
            self.primary.selectInputButton.backgroundColorMouseOver = self.selectInputButtonBackgroundColorMouseOver;
            self.primary.selectInputButton.textureColor = self.selectInputButtonTextureColor;
            self.primary.selectInputButton.textureColorMouseOver = self.selectInputButtonTextureColorMouseOver;
        end
    end
end

--************************************************************************--
--** ISWidgetInput:new
--**
--************************************************************************--
function ISWidgetInput:new (x, y, width, height, player, logic, inputScript) --recipeData, inputScript)
	local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.player = player;
    o.logic = logic;

    --o.recipeData = recipeData;
    o.inputScript = inputScript;
    o.consumeScript = inputScript:getConsumeFromItemScript();
    o.createScript = inputScript:getCreateToItemScript();

    o.iconSize = 48 * ICON_SCALE;
    o.iconMargin = 12 * FONT_SCALE;
    o.labelIconSize = 18 * ICON_SCALE;
    o.selectInputButtonSize = 24 * ICON_SCALE;
    
    o.selectInputButtonBackgroundColor = {r=0.8, g=0.8, b=0.8, a=1};
    o.selectInputButtonBackgroundColorMouseOver = {r=0.365, g=0.196, b=0.125, a=1};
    o.selectInputButtonTextureColor = {r=0, g=0, b=0, a=1};
    o.selectInputButtonTextureColorMouseOver = {r=0.909, g=0.929, b=0.78, a=1};

    o.normalBorderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.iconBorderSizeX = (o.iconMargin * 2) + (o.iconSize*1.5);
    o.iconBorderSizeY = (o.iconMargin * 2) + o.iconSize;
    
    o.interactiveMode = false;
    o.displayAsOutput = false;

    o.textureReturned = getTexture("media/ui/Entity/Icon_Returned_48x48.png");
    o.textureConsumed = getTexture("media/ui/Entity/BuildProperty_Consume.png");
    o.textureUsed = getTexture("media/ui/Entity/Icon_ItemConsumed_48x48.png");
    o.textureTool = getTexture("media/ui/Entity/Icon_Tools_48x48.png");
    o.textureCreate = getTexture("media/ui/Entity/Icon_Crafted_48x48.png");
    o.textureSwapInput = getTexture("media/ui/Entity/BTN_Swap_Icon_48x48.png");
    o.textureMissingInput = getTexture("media/ui/Entity/BTN_Missing_Icon_48x48.png");
    o.textureButtonBG = getTexture("media/ui/Entity/BTN_BASE_48x48.png");
    
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