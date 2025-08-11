--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

--[[
    A generic title header widget
--]]
require "ISUI/ISPanel"

ISWidgetTitleHeader = ISPanel:derive("ISWidgetTitleHeader");
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.NewSmall)
local FONT_SCALE = getTextManager():getFontHeight(UIFont.Small) / 19; -- normalize to 1080p
local ICON_SCALE = math.max(1, (FONT_SCALE - math.floor(FONT_SCALE)) < 0.5 and math.floor(FONT_SCALE) or math.ceil(FONT_SCALE));
local ICON_SIZE = 48 * math.max(1, FONT_SCALE);

function ISWidgetTitleHeader:initialise()
	ISPanel.initialise(self);
end

function ISWidgetTitleHeader:createChildren()
    ISPanel.createChildren(self);

    if self.enableIcon then
        self.icon = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISImage, 0, 0, ICON_SIZE, ICON_SIZE, self.iconTex);
        self.icon.autoScale = true;
        --self.icon.scaledWidth = self.iconSize;
        --self.icon.scaledHeight = self.iconSize;
        --self.icon.texture = self.entityStyle:getIcon();
        self.icon:initialise();
        self.icon:instantiate();
        self:addChild(self.icon);

        self.iconSize = self.icon:getHeight();
    else
        self.iconSize = ICON_SIZE;
    end

    local titleStr = self.title or "Unknown Object";

    if isDebugEnabled() then
        titleStr = titleStr .. "\n( DBG:" .. self.recipe:getName() .. ")";
    end
    
    local fontHeight = -1; -- <=0 sets label initial height to font
    self.titleLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, titleStr, 1, 1, 1, 1, UIFont.Small, true);
    self.titleLabel.origTitleStr = titleStr;
    self.titleLabel:initialise();
    self.titleLabel:instantiate();
    self.titleLabel:setHeightToName(0);
    self:addChild(self.titleLabel);
    
    -- favourite button
    self.favouritesIcon = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, self.propertyIconSize, self.propertyIconSize, "", self, ISWidgetTitleHeader.onFavouritesClick);
    if self.isFavourite then
        self.favouritesIcon.image = getTexture("media/ui/inventoryPanes/FavouriteYes.png");
        self.favouritesIcon.textureColor = { r=getCore():getGoodHighlitedColor():getR(),g=getCore():getGoodHighlitedColor():getG(),b=getCore():getGoodHighlitedColor():getB(),a=1 };
    else
        self.favouritesIcon.image = getTexture("media/ui/inventoryPanes/FavouriteNo.png");
        self.favouritesIcon.textureColor = { r=1, g=1, b=1 ,a=1 };
    end
    self.favouritesIcon.borderColor.a = 0.0;
    self.favouritesIcon.backgroundColor.a = 0;
    self.favouritesIcon.backgroundColorMouseOver.a = 0;
    self.favouritesIcon.enable = true;
    self.favouritesIcon:initialise();
    self.favouritesIcon:instantiate();
    self:addChild(self.favouritesIcon);
    
    if self.showPropertyIcons then

        --if the image display size is 16x16, then this will automatically grab the 16x16 version
        local fileSize = ".png"
        if self.propertyIconSize == 16 then
            fileSize = "_16.png"
        end

        if self.isCanWalk then
            local iconTex = getTexture("media/ui/craftingMenus/BuildProperty_Walking" .. fileSize);
            self.isCanWalkIcon = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISImage, 0, 0, self.propertyIconSize, self.propertyIconSize, iconTex);
            self.isCanWalkIcon.autoScale = true;
            self.isCanWalkIcon.mouseovertext = getText("IGUI_CraftingWindow_CanWalk");
            self.isCanWalkIcon:initialise();
            self.isCanWalkIcon:instantiate();
            self:addChild(self.isCanWalkIcon);
        end
        if not self.canBeDoneInDark and not self.ignoreLightIcon then
            --local iconTex = getTexture("media/ui/craftingMenus/Icon_Moon_48x48.png");
            local iconTex = getTexture("media/ui/craftingMenus/BuildProperty_Light" .. fileSize);
            self.canBeDoneInDarkIcon = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISImage, 0, 0, self.propertyIconSize, self.propertyIconSize, iconTex);
            self.canBeDoneInDarkIcon.autoScale = true;
            self.canBeDoneInDarkIcon.mouseovertext = getText("IGUI_CraftingWindow_RequiresLight");
            self.canBeDoneInDarkIcon:initialise();
            self.canBeDoneInDarkIcon:instantiate();
            self:addChild(self.canBeDoneInDarkIcon);
        end
        if self.needToBeLearn then
            local iconTex = getTexture("media/ui/craftingMenus/BuildProperty_Book" .. fileSize);
            self.needToBeLearnIcon = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISImage, 0, 0, self.propertyIconSize, self.propertyIconSize, iconTex);
            self.needToBeLearnIcon.autoScale = true;
            if not self.player:isRecipeKnown(self.recipe, true) then
                self.needToBeLearnIcon.mouseovertext = getText("IGUI_CraftingWindow_RequiresLearning");
            elseif self.recipeBenefitLabel and self.recipeBenefitLabel.active then
                self.needToBeLearnIcon.mouseovertext = getText("IGUI_CraftingWindow_ValidateBenefitFromRecipeAtHand");
            else
                self.needToBeLearnIcon.mouseovertext = getText("IGUI_CraftingWindow_RecipeKnown");
            end
            self.needToBeLearnIcon:initialise();
            self.needToBeLearnIcon:instantiate();
            self:addChild(self.needToBeLearnIcon);
        end        
        if self.requiresSurface and not self.ignoreSurface then
            local iconTex = getTexture("media/ui/craftingMenus/BuildProperty_Surface" .. fileSize);
            self.requiresSurfaceIcon = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISImage, 0, 0, self.propertyIconSize, self.propertyIconSize, iconTex);
            self.requiresSurfaceIcon.autoScale = true;
            self.requiresSurfaceIcon.mouseovertext = getText("IGUI_CraftingWindow_RequiresSurface");
            self.requiresSurfaceIcon:initialise();
            self.requiresSurfaceIcon:instantiate();
            self:addChild(self.requiresSurfaceIcon);
        end

        if self.player then
            --local color = {r=0.5, g=0.5, b=0.5, a=1.0};
            -- modified to scale by player skill level
            local time = round(self.recipe:getTime(self.player)/10,2);
--             local time = round(self.recipe:getTime()/10,2);

            local timeText = getText("IGUI_CraftingWindow_CraftTime") .. " " .. tostring(time).." " .. getText("IGUI_CraftingWindow_Seconds");
            --self.timeLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, getText("IGUI_CraftingWindow_CraftTime") .. " " .. timeText, color.r, color.g, color.b, color.a, UIFont.NewSmall, true);
            --self.timeLabel:initialise();
            --self.timeLabel:instantiate();
            --self:addChild(self.timeLabel);

            local iconTex = getTexture("media/ui/craftingMenus/BuildProperty_Clock" .. fileSize);
            self.timeIcon = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISImage, 0, 0, self.propertyIconSize, self.propertyIconSize, iconTex);
            self.timeIcon.autoScale = true;
            self.timeIcon.mouseovertext = timeText;
            self.timeIcon:initialise();
            self.timeIcon:instantiate();
            self:addChild(self.timeIcon);
        end
    end
    
    if self.recipe then
        if self.recipe:getTooltip() then
            local color = {r=0.5, g=0.5, b=0.5, a=1.0};
            self.tooltipLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, getText(self.recipe:getTooltip()), color.r, color.g, color.b, color.a, UIFont.NewSmall, true);
            self.tooltipLabel:initialise();
            self.tooltipLabel:instantiate();
            self.tooltipLabel:setHeightToName(0);
            self:addChild(self.tooltipLabel);
        end


        local color = self.colGood;
        if self.recipe:requiresSpecificWorkstation() and self.logic and not self.logic:hasRequiredWorkstation() then color = self.colBad end
        self.specificWorkstationLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, "", color.r, color.g, color.b, color.a, UIFont.NewSmall, true);
        self.specificWorkstationLabel.text = "";
        self.specificWorkstationLabel:initialise();
        self.specificWorkstationLabel:instantiate();
        self:addChild(self.specificWorkstationLabel);

        if self.player and self.recipe:getRequiredSkillCount()>0 then
            for i=0,self.recipe:getRequiredSkillCount()-1 do
                local requiredSkill = self.recipe:getRequiredSkill(i);
                local hasSkill = CraftRecipeManager.hasPlayerRequiredSkill(requiredSkill, self.player);
                local lineColor = hasSkill and self.colGood or self.colBad;
                local text = getText("IGUI_CraftingWindow_Requires2").." ".. tostring(requiredSkill:getPerk():getName()).." "..getText("IGUI_CraftingWindow_Level").." " .. tostring(requiredSkill:getLevel());

                local requiredSkillLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, text, lineColor.r, lineColor.g, lineColor.b, lineColor.a, UIFont.NewSmall, true);
                requiredSkillLabel.origTitleStr = text;
                requiredSkillLabel:initialise();
                requiredSkillLabel:instantiate();
                self:addChild(requiredSkillLabel);
                table.insert(self.requiredSkillList, requiredSkillLabel);
            end
        end

--             -- UI information if a player could or would benefit from having a recipe item at hand
--         if self.player and self.recipe:couldBenefitFromRecipeAtHand(self.player) then
--             local text = getText("IGUI_CraftingWindow_CouldBenefitFromRecipeAtHand")
--             local lineColor = self.colBad
--             if self.recipe:validateBenefitFromRecipeAtHand(self.player, self.logic:getContainers()) then
--                  text = getText("IGUI_CraftingWindow_ValidateBenefitFromRecipeAtHand")
--                  lineColor = self.colGood
--             end
--
--             self.recipeBenefitLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, text, lineColor.r, lineColor.g, lineColor.b, lineColor.a, UIFont.NewSmall, true);
--             self.recipeBenefitLabel.origTitleStr = text;
--             self.recipeBenefitLabel:initialise();
--             self.recipeBenefitLabel:instantiate();
--             self:addChild(self.recipeBenefitLabel);
--         end

    end

    self.recipeBenefitLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, "", self.colGood.r, self.colGood.g, self.colGood.b, self.colGood.a, UIFont.NewSmall, true);
    self.recipeBenefitLabel.text = "";
    self.recipeBenefitLabel:initialise();
    self.recipeBenefitLabel:instantiate();
    self:addChild(self.recipeBenefitLabel);

    self.errorLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, "", self.colBad.r, self.colBad.g, self.colBad.b, self.colBad.a, UIFont.NewSmall, true);
    self.errorLabel.errorText = "";
    self.errorLabel:initialise();
    self.errorLabel:instantiate();
    self:addChild(self.errorLabel);
    
    self:updateLabels();
    self:updatePropertyIcons();    
end

function ISWidgetTitleHeader:updateLabels()
    if self.logic and not self.logic:cachedCanPerformCurrentRecipe() then
        local errorText = "";

        if not self.logic:areAllInputItemsSatisfied() then
            if errorText ~= "" then errorText = errorText .. ", " end
            errorText = errorText .. getText("IGUI_CraftingWindow_Error_Inputs");
        end

        if not self.isCanWalk and self.player:isPlayerMoving() then
            if errorText ~= "" then errorText = errorText .. ", " end
            errorText = errorText .. getText("IGUI_CraftingWindow_Error_Moving");
        end

        if self.needToBeLearn and not self.player:isRecipeKnown(self.recipe, true) then
            if errorText ~= "" then errorText = errorText .. ", " end
            errorText = errorText .. getText("IGUI_CraftingWindow_Error_NotLearn");
        end

        if not self.canBeDoneInDark and self.player:tooDarkToRead() then
            if errorText ~= "" then errorText = errorText .. ", " end
            errorText = errorText .. getText("IGUI_CraftingWindow_Error_TooDark");
        end

        if self.requiresSurface and not self.logic:isCharacterInRangeOfWorkbench() then
            if errorText ~= "" then errorText = errorText .. ", " end
            errorText = errorText .. getText("IGUI_CraftingWindow_Error_Workbench");
        end

        errorText = getText("IGUI_CraftingWindow_Error_NotAvailable") .. errorText;

        self.errorLabel.errorText = errorText;
        self.errorLabel:setVisible(true);
    else
        self.errorLabel:setVisible(false);
    end

    if self.player and self.recipe and self.recipe:couldBenefitFromRecipeAtHand(self.player) and not self.recipe:characterHasRequiredSkills(self.player) then
        local text
        if self.recipe:validateBenefitFromRecipeAtHand(self.player, self.logic:getContainers()) then
             text = getText("IGUI_CraftingWindow_ValidateBenefitFromRecipeAtHand")
            self.recipeBenefitLabel.active = true
        else
            text = getText("IGUI_CraftingWindow_CouldBenefitFromRecipeAtHand")
            self.recipeBenefitLabel.active = false
        end
        self.recipeBenefitLabel.text = text;
        self.recipeBenefitLabel:setVisible(true);
    else
        self.recipeBenefitLabel:setVisible(false);
        self.recipeBenefitLabel.active = false
    end

    if self.recipe:requiresSpecificWorkstation() then
        self.specificWorkstationLabel.text = tostring(self.recipe:getTags())

        local text = getText("IGUI_CraftingWindow_RequiresA");
        local moreThanOne = self.recipe:getTags():size() > 1
        for i=0, self.recipe:getTags():size()-1 do
            local tag = self.recipe:getTags():get(i)
            text = text .. " " .. getText("IGUI_CraftingWindow_" .. tag)
            if moreThanOne and i < self.recipe:getTags():size()-1 then
                if i < self.recipe:getTags():size()-2 then
                    text = text .. ","
                else
                    text = text .. " " .. getText("IGUI_CraftingWindow_Or")
                end
            end
        end
        text = text .. "."
        self.specificWorkstationLabel.text = text

        self.specificWorkstationLabel:setVisible(true);
        self.specificWorkstationLabel.active = true
    else
        self.specificWorkstationLabel:setVisible(false);
        self.specificWorkstationLabel.active = false
    end

    if self.recipe and self.player and self.needToBeLearnIcon and self.needToBeLearnIcon.mouseovertext then
        if not self.player:isRecipeKnown(self.recipe, true) then
            self.needToBeLearnIcon.mouseovertext = getText("IGUI_CraftingWindow_RequiresLearning");
        elseif self.recipeBenefitLabel and self.recipeBenefitLabel.active then
            self.needToBeLearnIcon.mouseovertext = getText("IGUI_CraftingWindow_ValidateBenefitFromRecipeAtHand");
        elseif self.recipe:couldBenefitFromRecipeAtHand(self.player) then
            self.needToBeLearnIcon.mouseovertext = getText("IGUI_CraftingWindow_CouldBenefitFromRecipeAtHand2");
        else
            self.needToBeLearnIcon.mouseovertext = getText("IGUI_CraftingWindow_RecipeKnown");
        end
    end
end
function ISWidgetTitleHeader:updatePropertyIcons()
    if self.showPropertyIcons then
        if self.canBeDoneInDarkIcon then
            self.canBeDoneInDarkIcon.backgroundColor = self.player:tooDarkToRead() and self.colBad or self.colWhite;
        end
        if self.needToBeLearnIcon then
            self.needToBeLearnIcon.backgroundColor = not self.player:isRecipeKnown(self.recipe, true) and self.colBad or self.colWhite;
            -- make the book icon green instead if a recipe ininventory enables performing the recipe
            if self.recipeBenefitLabel.active then self.needToBeLearnIcon.backgroundColor = self.colGood end
        end
        if self.requiresSurfaceIcon then
            self.requiresSurfaceIcon.backgroundColor = self.logic and not self.logic:isCharacterInRangeOfWorkbench() and self.colBad or self.colWhite;
        end
    end
end

function ISWidgetTitleHeader:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, 0);--math.max(self.minimumHeight, _preferredHeight or 0);

    local spacing = 15;
    local propertyIconSpacing = 5;

    -- update
    self:updateLabels();
    self:updatePropertyIcons();
    
    -- calc width
    local requiredWidth = spacing;
    if self.favouritesIcon then
        requiredWidth = requiredWidth + (self.favouritesIcon:getWidth()/3);
    end
    if self.icon then
        requiredWidth = requiredWidth + self.icon:getWidth() + spacing;
    end
    
    requiredWidth = requiredWidth + self.titleLabel:getWidth() + spacing;

    if self.isCanWalkIcon then
        requiredWidth = requiredWidth + self.isCanWalkIcon:getWidth() + propertyIconSpacing;
    end
    if self.canBeDoneInDarkIcon then
        requiredWidth = requiredWidth + self.canBeDoneInDarkIcon:getWidth() + propertyIconSpacing;
    end
    if self.needToBeLearnIcon then
        requiredWidth = requiredWidth + self.needToBeLearnIcon:getWidth() + propertyIconSpacing;
    end    
    if self.requiresSurfaceIcon then
        requiredWidth = requiredWidth + self.requiresSurfaceIcon:getWidth() + propertyIconSpacing;
    end
    if self.timeIcon then
        requiredWidth = requiredWidth + self.timeIcon:getWidth() + propertyIconSpacing;
    end
    
    width = math.max(width, requiredWidth + (self.paddingLeft + self.paddingRight) + (self.marginLeft+self.marginRight));
    
    -- calc height
    if self.icon then
        height = math.max(height, self.icon:getHeight() + (self.paddingTop + self.paddingBottom) + (self.marginTop+self.marginBottom));
    end
    if self.favouritesIcon then
        height = height + (self.favouritesIcon:getHeight()/3);
    end
    
    local labelsHeight = self.titleLabel:getHeight() + (self.paddingTop + self.paddingBottom) + (self.marginTop+self.marginBottom);
    local labelSpacing = 3;
    local skillLabelSpacing = 2;
    
    if self.tooltipLabel then
        labelsHeight = labelsHeight + labelSpacing + self.tooltipLabel:getHeight();
    end
    if self.timeLabel then
        labelsHeight = labelsHeight + labelSpacing + self.timeLabel:getHeight();
    end
    if self.specificWorkstationLabel and self.specificWorkstationLabel:isVisible() then
        local labelWidth = width - (self.paddingLeft + self.marginLeft + self.paddingRight + self.marginRight);
        if self.icon then
            labelWidth = labelWidth - (spacing + self.icon:getWidth() + spacing);
        end

        local wrappedText = getTextManager():WrapText(self.specificWorkstationLabel.font, self.specificWorkstationLabel.text, labelWidth)
        self.specificWorkstationLabel:setName(wrappedText);
        self.specificWorkstationLabel:setHeightToName(0);
        labelsHeight = labelsHeight + labelSpacing + self.specificWorkstationLabel:getHeight();
    end
    if #self.requiredSkillList > 0 then
        labelsHeight = labelsHeight + labelSpacing;
        for i = 1, #self.requiredSkillList do
            labelsHeight = labelsHeight + skillLabelSpacing + self.requiredSkillList[i]:getHeight() ;
        end
    end
    if self.recipeBenefitLabel and self.recipeBenefitLabel:isVisible() then
        local labelWidth = width - (self.paddingLeft + self.marginLeft + self.paddingRight + self.marginRight);
        if self.icon then
            labelWidth = labelWidth - (spacing + self.icon:getWidth() + spacing);
        end

        local wrappedText = getTextManager():WrapText(self.recipeBenefitLabel.font, self.recipeBenefitLabel.text, labelWidth)
        self.recipeBenefitLabel:setName(wrappedText);
        self.recipeBenefitLabel:setHeightToName(0);
        labelsHeight = labelsHeight + labelSpacing + self.recipeBenefitLabel:getHeight();
    end
    if self.errorLabel and self.errorLabel:isVisible() then
        local errorLabelWidth = width - (self.paddingLeft + self.marginLeft + self.paddingRight + self.marginRight);
        if self.icon then
            errorLabelWidth = errorLabelWidth - (spacing + self.icon:getWidth() + spacing);
        end
        
        local wrappedText = getTextManager():WrapText(self.errorLabel.font, self.errorLabel.errorText, errorLabelWidth)
        self.errorLabel:setName(wrappedText);
        self.errorLabel:setHeightToName(0);
        labelsHeight = labelsHeight + labelSpacing + getTextManager():MeasureStringY(self.errorLabel.font, wrappedText);
    end
    
    height = math.max(height, labelsHeight);
    local y = (height/2) - (labelsHeight/2) + self.paddingTop + self.marginTop;
    
    -- draw labels
    local x = self.paddingLeft + self.marginLeft;

    if self.favouritesIcon then
        x = x + (self.favouritesIcon:getWidth()/3);
    end
    
    if self.icon then
        self.icon:setX(x);
        local iconAreaHeight = self.icon:getHeight();
        if self.favouritesIcon then
            iconAreaHeight = iconAreaHeight + (self.favouritesIcon:getHeight()/3);
        end
        self.icon:setY((height/2)-(iconAreaHeight/2));
        x = self.icon:getX() + self.icon:getWidth() + spacing;
    end
    
    self.titleLabel:setX(x);
    self.titleLabel.originalX = self.titleLabel:getX();
    self.titleLabel:setY(y);
    y = y + self.titleLabel:getHeight();

    if self.tooltipLabel then
        y = y + labelSpacing;
        self.tooltipLabel:setX(self.titleLabel:getX());
        self.tooltipLabel.originalX = self.titleLabel:getX();
        self.tooltipLabel:setY(y);
        y = y + self.tooltipLabel:getHeight();
    end

    if self.timeLabel then
        y = y + labelSpacing;
        self.timeLabel:setX(self.titleLabel:getX());
        self.timeLabel.originalX = self.timeLabel:getX();
        self.timeLabel:setY(y);
        y = y + self.timeLabel:getHeight();
    end
    
    if self.favouritesIcon then
        self.favouritesIcon:setX(self.icon:getX() - (self.favouritesIcon:getWidth()/3));
        self.favouritesIcon:setY(self.icon:getY() + self.icon:getHeight() - (self.favouritesIcon:getHeight()*(2/3)));
    end

    if self.specificWorkstationLabel and self.specificWorkstationLabel:isVisible() then
        y = y + labelSpacing;
        self.specificWorkstationLabel:setX(self.titleLabel:getX());
        self.specificWorkstationLabel.originalX = self.specificWorkstationLabel:getX();
        self.specificWorkstationLabel:setY(y);
        y = y + self.specificWorkstationLabel:getHeight();
    end

    if #self.requiredSkillList > 0 then
        y = y + labelSpacing + skillLabelSpacing;
    end
    for i,v in ipairs(self.requiredSkillList) do
        v:setX(self.titleLabel:getX())
        v.originalX = v:getX();
        v:setY(y);
        y = y + FONT_HGT_SMALL + skillLabelSpacing;
    end

    if self.recipeBenefitLabel and self.recipeBenefitLabel:isVisible() then
        y = y + labelSpacing;
        self.recipeBenefitLabel:setX(self.titleLabel:getX());
        self.recipeBenefitLabel.originalX = self.recipeBenefitLabel:getX();
        self.recipeBenefitLabel:setY(y);
        y = y + self.recipeBenefitLabel:getHeight();
    end

    if self.errorLabel and self.errorLabel:isVisible() then
        y = y + labelSpacing;
        self.errorLabel:setX(self.titleLabel:getX());
        self.errorLabel.originalX = self.errorLabel:getX();
        self.errorLabel:setY(y);
        y = y + self.errorLabel:getHeight();
    end

    x = width - (self.propertyIconSize + self.paddingRight + self.marginRight);
    if self.requiresSurfaceIcon then
        self.requiresSurfaceIcon:setX(x);
        self.requiresSurfaceIcon:setY(propertyIconSpacing);
        x = x - (self.requiresSurfaceIcon:getWidth() + propertyIconSpacing);
    end    
    if self.needToBeLearnIcon then
        self.needToBeLearnIcon:setX(x);
        self.needToBeLearnIcon:setY(propertyIconSpacing);
        x = x - (self.needToBeLearnIcon:getWidth() + propertyIconSpacing);
    end
    if self.canBeDoneInDarkIcon then
        self.canBeDoneInDarkIcon:setX(x);
        self.canBeDoneInDarkIcon:setY(propertyIconSpacing);
        x = x - (self.canBeDoneInDarkIcon:getWidth() + propertyIconSpacing);
    end
    if self.isCanWalkIcon then
        self.isCanWalkIcon:setX(x);
        self.isCanWalkIcon:setY(propertyIconSpacing);
        x = x - (self.isCanWalkIcon:getWidth() + propertyIconSpacing);
    end
    if self.timeIcon then
        self.timeIcon:setX(x);
        self.timeIcon:setY(propertyIconSpacing);
        x = x - (self.timeIcon:getWidth() + propertyIconSpacing);
    end
    
    self:setWidth(width);
    self:setHeight(height);
end

function ISWidgetTitleHeader:onResize()
    ISUIElement.onResize(self)
end

function ISWidgetTitleHeader:prerender()
    ISPanel.prerender(self);
end

function ISWidgetTitleHeader:render()
    ISPanel.render(self);
end

function ISWidgetTitleHeader:update()
    ISPanel.update(self);
end

function ISWidgetTitleHeader:onFavouritesClick()
    self.isFavourite = not self.isFavourite;

    local favString = BaseCraftingLogic.getFavouriteModDataString(self.recipe);
    self.player:getModData()[favString] = self.isFavourite;

    if self.isFavourite then
        self.favouritesIcon.image = getTexture("media/ui/inventoryPanes/FavouriteYes.png");
        self.favouritesIcon.textureColor = { r=getCore():getGoodHighlitedColor():getR(),g=getCore():getGoodHighlitedColor():getG(),b=getCore():getGoodHighlitedColor():getB(),a=1 };
    else
        self.favouritesIcon.image = getTexture("media/ui/inventoryPanes/FavouriteNo.png");
        self.favouritesIcon.textureColor = { r=1, g=1, b=1 ,a=1 };
    end
end

--************************************************************************--
--** ISWidgetTitleHeader:new
--**
--************************************************************************--
function ISWidgetTitleHeader:new(x, y, width, height, recipe, player, logic, isFavourite)
	local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    
    o.title = recipe and recipe:getTranslationName() or "Title";
    o.iconTex = recipe and recipe:getIconTexture();
    
    o.isCanWalk = recipe and recipe:isCanWalk() or false;
    o.canBeDoneInDark = recipe and recipe:canBeDoneInDark() or false;
    o.needToBeLearn = recipe and recipe:needToBeLearn() or false;
    o.requiresSurface = recipe and recipe:isAnySurfaceCraft() or false;

    o.showPropertyIcons = recipe and true;
    o.propertyIconSize = 16 * ICON_SCALE;

    o.player = player;
    o.recipe = recipe;
    o.logic = logic;
    
    o.paddingTop = 2;
    o.paddingBottom = 2;
    o.paddingLeft = 2;
    o.paddingRight = 2;
    o.marginTop = 5;
    o.marginBottom = 5;
    o.marginLeft = 5;
    o.marginRight = 5;
    o.requiredSkillList = {};

    o.colWhite = { r=1.0, g=1.0, b=1.0, a=1.0 }
    o.colGood = {
        r=getCore():getGoodHighlitedColor():getR(),
        g=getCore():getGoodHighlitedColor():getG(),
        b=getCore():getGoodHighlitedColor():getB(),
        a=getCore():getGoodHighlitedColor():getA(),
    }
    o.colBad = {
        r=getCore():getBadHighlitedColor():getR(),
        g=getCore():getBadHighlitedColor():getG(),
        b=getCore():getBadHighlitedColor():getB(),
        a=getCore():getBadHighlitedColor():getA(),
    }

    o.enableIcon = true;

    o.isFavourite = isFavourite or false;

    return o
end