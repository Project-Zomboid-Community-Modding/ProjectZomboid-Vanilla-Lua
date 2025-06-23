--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************
require "ISUI/ISPanel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

ISCraftRecipeInfoBox = ISPanel:derive("ISCraftRecipeInfoBox");

local debugSpam = true
-- local debugSpam = false

function ISCraftRecipeInfoBox:initialise()
	ISPanel.initialise(self);
end

function ISCraftRecipeInfoBox:createChildren()
    ISPanel.createChildren(self);

    self:createDynamicChildren();
end

function ISCraftRecipeInfoBox:createDynamicChildren()
    for k,childElement in pairs(self.children) do
        self:removeChild(childElement);
    end


    local colGood = {
        r=getCore():getGoodHighlitedColor():getR(),
        g=getCore():getGoodHighlitedColor():getG(),
        b=getCore():getGoodHighlitedColor():getB(),
        a=getCore():getGoodHighlitedColor():getA(),
    }
    local colBad = {
        r=getCore():getBadHighlitedColor():getR(),
        g=getCore():getBadHighlitedColor():getG(),
        b=getCore():getBadHighlitedColor():getB(),
        a=getCore():getBadHighlitedColor():getA(),
    }

    self.infoPairs = {};

    if not self.recipe then
        self:xuiRecalculateLayout();
        return;
    end

    if (isDebugEnabled() and debugSpam) or getSandboxOptions():isUnstableScriptNameSpam() then
        self:addInfo("Recipe Reports: " .. self.recipe:getName());
    end

    local time = round(self.recipe:getTime(self.player)/10,2);
--     local time = round(self.recipe:getTime()/10,2);
    self:addInfoPair(getText("IGUI_CraftingWindow_CraftTime"), tostring(time).." " .. getText("IGUI_CraftingWindow_Seconds"));

    if self.recipe:isInHandCraftCraft() then
        self:addInfoPair(getText("IGUI_CraftingWindow_RequiresSurface") .. ":", getText("IGUI_No"));
    elseif self.recipe:isAnySurfaceCraft() then
        self:addInfoPair(getText("IGUI_CraftingWindow_RequiresSurface") .. ":", getText("IGUI_Yes"));
    end

    if not self.recipe:canBeDoneInDark() then
        local b = self.player:tooDarkToRead();
        self:addInfoPair(getText("IGUI_CraftingWindow_RequiresLight") .. ":", getText("IGUI_Yes"), b and colBad or colGood);
    else
        self:addInfoPair(getText("IGUI_CraftingWindow_RequiresLight") .. ":", getText("IGUI_No"));
    end

    if self.recipe:isCanWalk() and not self.player:hasAwkwardHands() then
        self:addInfoPair(getText("IGUI_CraftingWindow_CanWalk") .. ":", getText("IGUI_Yes"));
    elseif self.recipe:isCanWalk() and self.player:hasAwkwardHands() then
        self:addInfoPair(getText("IGUI_CraftingWindow_CanWalk") .. ":", getText("IGUI_No"), colBad);
    else
        self:addInfoPair(getText("IGUI_CraftingWindow_CanWalk") .. ":", getText("IGUI_No"));
    end

    local needsLearning = self.recipe:needToBeLearn();
    local learned = CraftRecipeManager.hasPlayerLearnedRecipe(self.recipe, self.player);
    local notKnown = needsLearning and not learned
    self:addInfoPair(getText("IGUI_CraftingWindow_RequiresLearning"),   needsLearning and "Yes" or "No");
    if needsLearning then
        self:addInfoPair(getText("IGUI_CraftingWindow_HasLearned"), learned and "Yes" or "No", learned and colGood or colBad);
    end

    if self.recipe:getRequiredSkillCount()>0 then
        for i=0,self.recipe:getRequiredSkillCount()-1 do
            local requiredSkill = self.recipe:getRequiredSkill(i);

            local hasSkill = CraftRecipeManager.hasPlayerRequiredSkill(requiredSkill, self.player);
            local key = getText("IGUI_CraftingWindow_Requires2").." ".. tostring(requiredSkill:getPerk():getName()).." "..getText("IGUI_CraftingWindow_Level").." " .. tostring(requiredSkill:getLevel());
--             local key = "Has "..tostring(requiredSkill:getPerk():getName()).." "..tostring(requiredSkill:getLevel())..":";
            local val = getText("IGUI_CraftingWindow_Has") .. " "..tostring(self.player:getPerkLevel(requiredSkill:getPerk()));
--             local val = b and "Yes" or "No ("..tostring(self.player:getPerkLevel(requiredSkill:getPerk()))..")";
            self:addInfoPair(key, " ", hasSkill and colGood or colBad, true)
--             self:addInfoPair(key, val, b and colGood or colBad)
        end
    end

    self:addInfoPair("XXXX", " ", colGood)


    if self.displayTags and self.recipe:getTags():size()>0 then
        local colTags = namedColorToTable("CornFlowerBlue");
        for i=0,self.recipe:getTags():size()-1 do
            local tag = self.recipe:getTags():get(i);
            if i==0 then
                self:addInfoPair(getText("IGUI_CraftingWIndow_Tags"), tag, colTags);
            else
                self:addInfoPair("", tag, colTags);
            end
        end
    end
    if self.recipe:getTooltip() then
        self:addInfo(getText(self.recipe:getTooltip()), "");
    end

    self:xuiRecalculateLayout();
end

-- function ISCraftRecipeInfoBox:addInfoPair(_key, _value, _valueColor)
--
--     local data = {};
--
--     local fontHeight = -1; -- <=0 sets label initial height to font
--     data.keyLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, tostring(_key), 1.0, 1.0, 1.0, 1, UIFont.Small, true)
--     data.keyLabel:initialise();
--     data.keyLabel:instantiate();
--     self:addChild(data.keyLabel);
--
--     data.valueLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, tostring(_value), 1.0, 1.0, 1.0, 1, UIFont.Small, true)
--     data.valueLabel.textColor = _valueColor;
--     data.valueLabel:initialise();
--     data.valueLabel:instantiate();
--     self:addChild(data.valueLabel);
--
--     table.insert(self.infoPairs, data);
-- end

function ISCraftRecipeInfoBox:addInfoPair(_key, _value, _valueColor, fullColor)

    local data = {};

    local fontHeight = -1; -- <=0 sets label initial height to font
    data.keyLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, tostring(_key), 1.0, 1.0, 1.0, 1, UIFont.Small, true)
    if fullColor then
        data.keyLabel.textColor = _valueColor;
    end
    data.keyLabel:initialise();
    data.keyLabel:instantiate();
    self:addChild(data.keyLabel);

    data.valueLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, tostring(_value), 1.0, 1.0, 1.0, 1, UIFont.Small, true)
    data.valueLabel.textColor = _valueColor;
    data.valueLabel:initialise();
    data.valueLabel:instantiate();
    self:addChild(data.valueLabel);

    table.insert(self.infoPairs, data);
end

function ISCraftRecipeInfoBox:addInfo(_key,fullColor)

    local data = {};

    local fontHeight = -1; -- <=0 sets label initial height to font
    data.keyLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, tostring(_key), 1.0, 1.0, 1.0, 1, UIFont.Small, true)
    if fullColor then
        data.keyLabel.textColor = _valueColor;
    end
    data.keyLabel:initialise();
    data.keyLabel:instantiate();
    self:addChild(data.keyLabel);

    table.insert(self.infoPairs, data);
end

function ISCraftRecipeInfoBox:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    local minWidth = self.margin*4;
    local minHeight = self.margin;

    local minLeft,minRight = 0, 0;
    for k,v in ipairs(self.infoPairs) do
        if v.valueLabel then
            minHeight = minHeight + v.keyLabel:getHeight() + self.margin;

            minLeft = math.max(minLeft, (self.margin*2)+v.keyLabel:getWidth());
            minRight = math.max(minRight, (self.margin*2)+v.valueLabel:getWidth());
            local w = (self.margin*4)+v.keyLabel:getWidth()+v.valueLabel:getWidth() + 10;
            minWidth = math.max(minWidth, w);
        else
            minHeight = minHeight + v.keyLabel:getHeight() + self.margin;
--             minLeft = math.max(minLeft, (self.margin*2)+v.keyLabel:getWidth());
            local w = (self.margin*4)+v.keyLabel:getWidth();
            minWidth = math.max(minWidth, w);
        end
    end

    width = math.max(width, minWidth);
    height = math.max(height, minHeight);

    local centerX = math.max(minLeft);
--     local centerX = math.max(width/2, minLeft);

    local y = self.margin;

    for k,v in ipairs(self.infoPairs) do
        v.keyLabel:setY(y);
        if v.valueLabel then
            v.valueLabel:setY(y);
        end
        y = y + v.keyLabel:getHeight() + self.margin;

        v.keyLabel:setX(self.margin); --centerX-self.margin-v.keyLabel:getWidth());
        v.keyLabel.originalX = v.keyLabel:getX();
        if v.valueLabel then
            v.valueLabel:setX(centerX+self.margin);
            v.valueLabel.originalX = v.valueLabel:getX();
        end
    end

    self:setWidth(width);
    self:setHeight(height);
end

function ISCraftRecipeInfoBox:onResize()
    --ISUIElement.onResize(self)
    ISUIElement.onResize(self)
end

function ISCraftRecipeInfoBox:prerender()
    ISPanel.prerender(self);
end

function ISCraftRecipeInfoBox:render()
    ISPanel.render(self);
end

function ISCraftRecipeInfoBox:update()
    ISPanel.update(self);
end

function ISCraftRecipeInfoBox:setRecipe(_recipe)
    self.recipe = _recipe;
    self:createDynamicChildren();
end

--************************************************************************--
--** ISCraftRecipeInfoBox:new
--**
--************************************************************************--
function ISCraftRecipeInfoBox:new (x, y, width, height, player, recipe)
	local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.player = player;
    o.recipe = recipe;
    o.displayTags = false;

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