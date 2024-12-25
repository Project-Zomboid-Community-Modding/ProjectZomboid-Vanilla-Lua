--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: tea-amuller       		   **
--***********************************************************

require "ISUI/ISPanel"

local UI_BORDER_SPACING = 10
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local LIST_ICON_SIZE = 64
local LIST_FAVICON_SIZE = 16

ISWidgetRecipeListPanel = ISPanel:derive("ISWidgetRecipeListPanel");

function ISWidgetRecipeListPanel:initialise()
    ISPanel.initialise(self);
end

function ISWidgetRecipeListPanel:createChildren()
    ISPanel.createChildren(self);

    self.recipeListPanel = ISScrollingListBox:new(0, 0, 10, 10);
    self.recipeListPanel:initialise();
    self.recipeListPanel:instantiate();

    self.recipeListPanel.starUnsetTexture = getTexture("media/ui/inventoryPanes/FavouriteNo.png")
    self.recipeListPanel.starSetTexture = getTexture("media/ui/inventoryPanes/FavouriteYes.png")

    self.recipeListPanel.itemheight = math.max(2 + FONT_HGT_MEDIUM + FONT_HGT_SMALL + UI_BORDER_SPACING, LIST_ICON_SIZE + UI_BORDER_SPACING);
    self.recipeListPanel.doDrawItem = function(_self, _y, _item, _alt)
        local craftRecipe = _item and _item.item;
        if craftRecipe then
            local yActual = _self:getYScroll() + _y;
            if _item.cachedHeight and (yActual > _self.height or (yActual + _item.cachedHeight) < 0) then
                -- we are outside stencil, dont draw, just return cachedHeight
                return _y + _item.cachedHeight;
            end
            
            if not _item.height then _item.height = _self.itemheight end -- compatibililty
            local usedHeight = _item.height;
            local safeDrawWidth = _self:getWidth() - (_self.vscroll and _self.vscroll:getWidth() or 0);

            -- set colours
            local color = {r=1.0, g=1.0, b=1.0, a=1.0};
            local cachedRecipeInfo = self.logic:getCachedRecipeInfo(craftRecipe)
            if not self.logic:isCraftCheat() then
                if cachedRecipeInfo and (not cachedRecipeInfo:isValid()) then
                    color = {r=0.5, g=0.5, b=0.5, a=1.0};
                elseif cachedRecipeInfo and (not cachedRecipeInfo:isCanPerform()) then
                    color = {r=0.5, g=0.5, b=0.5, a=1.0};
                end
            end

            if _self.selected == _item.index then
                _self:drawRect(0, _y, _self:getWidth(), _item.height-1, 0.3, 0.7, 0.35, 0.15);
            end

            _self:drawRectBorder(0, _y, _self:getWidth(), _item.height, 0.5, _self.borderColor.r, _self.borderColor.g, _self.borderColor.b);

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

            if self.logic:isCraftCheat() then
                colBad = colGood;
            end

            local detailsLeft = UI_BORDER_SPACING + LIST_ICON_SIZE + UI_BORDER_SPACING;
            local detailsCentre = detailsLeft + ((safeDrawWidth - detailsLeft) / 2);
            local iconRight = _self:getWidth() - 34;

            -- header
            local detailsY = 2;
            local titleStr = craftRecipe:getTranslationName();
            if isDebugEnabled() then
                local tags = "";
                for i=0,craftRecipe:getTags():size() -1 do
                    tags = tags .. craftRecipe:getTags():get(i);
                    if i < craftRecipe:getTags():size()-1 then
                        tags = tags .. ",";
                    end
                end
                --titleStr = titleStr .. " ( DBG:" .. craftRecipe:getTags() .. ")";
                titleStr = titleStr .. " (tags: " .. tags .. ")";
            end
            _self:drawText(titleStr, detailsLeft, _y+detailsY, color.r, color.g, color.b, color.a, UIFont.Medium);

            -- favourite button
            local favString = BaseCraftingLogic.getFavouriteModDataString(craftRecipe);
            local isFavourite = self.player:getModData()[favString] or false;
            local headerTextWidth = getTextManager():MeasureStringX(UIFont.Medium, craftRecipe:getTranslationName());
            local headerTextHeight = getTextManager():getFontHeight(UIFont.Medium);
            local starIconY = _y+detailsY + (headerTextHeight/2) - (LIST_FAVICON_SIZE/2);
            if isFavourite then
                _self:drawTextureScaledAspect(_self.starSetTexture, detailsLeft + headerTextWidth + UI_BORDER_SPACING, starIconY, LIST_FAVICON_SIZE, LIST_FAVICON_SIZE, color.a, color.r, color.g, color.b);
            --else
            --    _self:drawTextureScaledAspect(_self.starUnsetTexture, detailsLeft + headerTextWidth + UI_BORDER_SPACING, starIconY, LIST_FAVICON_SIZE, LIST_FAVICON_SIZE, color.a, color.r, color.g, color.b);
            end

            -- icons
            if craftRecipe:isCanWalk() then
                local iconTexture = getTexture("media/ui/craftingMenus/BuildProperty_Walking.png");
                _self:drawTextureScaledAspect(iconTexture, iconRight, _y+detailsY+2, 16, 16, color.a, color.r, color.g, color.b);
                iconRight = iconRight - 18;
            end
            if not craftRecipe:canBeDoneInDark() and not self.ignoreLightIcon then
                --local iconTexture = getTexture("media/ui/craftingMenus/Icon_Moon_48x48.png");
                local iconTexture = getTexture("media/ui/craftingMenus/BuildProperty_Light.png");
                _self:drawTextureScaledAspect(iconTexture, iconRight, _y+detailsY+2, 16, 16, color.a, color.r, color.g, color.b);
                iconRight = iconRight - 18;
            end
            if craftRecipe:needToBeLearn() then
                local iconTexture = getTexture("media/ui/craftingMenus/BuildProperty_Book.png");
                local alpha = 1;
                if not self.player:isRecipeKnown(craftRecipe, true) then
                    alpha = 0.5;
                end
                _self:drawTextureScaledAspect(iconTexture, iconRight, _y+detailsY+2, 16, 16, alpha, color.r, color.g, color.b);
                iconRight = iconRight - 18;
            end
            if not craftRecipe:isInHandCraftCraft() and not self.ignoreSurface then
                local iconTexture = getTexture("media/ui/craftingMenus/BuildProperty_Surface.png");
                _self:drawTextureScaledAspect(iconTexture, iconRight, _y+detailsY+2, 16, 16, color.a, color.r, color.g, color.b);
                iconRight = iconRight - 18;
            end

            detailsY = detailsY + FONT_HGT_MEDIUM;

            -- craft time
            --local time = round(craftRecipe:getTime()/10,2);
            --local timeText = tostring(time).." " .. getText("IGUI_CraftingWindow_Seconds");
            --_self:drawText(getText("IGUI_CraftingWindow_CraftTime"), detailsLeft, _y+detailsY, color.r, color.g, color.b, color.a, UIFont.Small);
            --_self:drawText(timeText, detailsCentre, _y+detailsY, color.r, color.g, color.b, color.a, UIFont.Small);
            --detailsY = detailsY + FONT_HGT_SMALL ;

            -- description
            if craftRecipe:getTooltip() then
                local text = getText(craftRecipe:getTooltip());
                _self:drawText(text, detailsLeft, _y+detailsY, 0.5, 0.5, 0.5, color.a, UIFont.Small);
                -- add more space for each <br> (which are turned into \n)
                local split = luautils.split(text, "\n");
                for i,v in ipairs(split) do
                    detailsY = detailsY + FONT_HGT_SMALL;
                end
            end

            -- learning
            --[[
            local needsLearning = craftRecipe:needToBeLearn();
            local learned = CraftRecipeManager.hasPlayerLearnedRecipe(craftRecipe, self.player);
            _self:drawText(getText("IGUI_CraftingWindow_RequiresLearning"), detailsLeft, _y+detailsY, color.r, color.g, color.b, color.a, UIFont.Small);
            _self:drawText(needsLearning and "Yes" or "No", detailsCentre, _y+detailsY, color.r, color.g, color.b, color.a, UIFont.Small);
            detailsY = detailsY + FONT_HGT_SMALL;
            if needsLearning then
                local lineColor = learned and colGood or colBad;
                _self:drawText(getText("IGUI_CraftingWindow_HasLearned"), detailsLeft, _y+detailsY, lineColor.r, lineColor.g, lineColor.b, lineColor.a, UIFont.Small);
                _self:drawText(learned and "Yes" or "No", detailsCentre, _y+detailsY, lineColor.r, lineColor.g, lineColor.b, lineColor.a, UIFont.Small);
                detailsY = detailsY + FONT_HGT_SMALL;
            end
            --]]

            -- skill
            if craftRecipe:getRequiredSkillCount()>0 then
                for i=0,craftRecipe:getRequiredSkillCount()-1 do
                    local requiredSkill = craftRecipe:getRequiredSkill(i);
                    local hasSkill = CraftRecipeManager.hasPlayerRequiredSkill(requiredSkill, self.player);
                    local lineColor = hasSkill and colGood or colBad;

                    local text = getText("IGUI_CraftingWindow_Requires2").." ".. tostring(requiredSkill:getPerk():getName()).." "..getText("IGUI_CraftingWindow_Level").." " .. tostring(requiredSkill:getLevel());
                    _self:drawText(text, detailsLeft, _y+detailsY, lineColor.r, lineColor.g, lineColor.b, lineColor.a, UIFont.Small);
                    detailsY = detailsY + FONT_HGT_SMALL;
                end
            end

            usedHeight = math.max(usedHeight, detailsY + UI_BORDER_SPACING)
            _item.height = usedHeight;
            _item.cachedHeight = usedHeight;

            -- draw icon mid-high
            local iconY = _y + (usedHeight/2)-(LIST_ICON_SIZE/2);
            local texture = craftRecipe:getIconTexture()
            _self:drawTextureScaledAspect(texture, UI_BORDER_SPACING, iconY, LIST_ICON_SIZE, LIST_ICON_SIZE, color.a, color.r, color.g, color.b);

            return _y + usedHeight;
        end
        return _y;
    end

    self.recipeListPanel.onItemMouseHover = function(_self, _item)
        self.callbackTarget:onRecipeItemMouseHover(_item);
    end
    --
    self.recipeListPanel.onScrolled = function(_self)
        self.callbackTarget:onRecipeListPanelScrolled();
    end

    self.recipeListPanel.selected = 0;
    --self.recipeListPanel.joypadParent = self;
    self.recipeListPanel.drawBorder = true
    self.recipeListPanel:setOnMouseDownFunction(self, function(_self, _recipe) _self.logic:setRecipe(_recipe) end);
    self.recipeListPanel.drawDebugLines = self.drawDebugLines;

    self:addChild(self.recipeListPanel);
end

function ISWidgetRecipeListPanel:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    self:setWidth(width);
    self:setHeight(height);
end

function ISWidgetRecipeListPanel:onResize()
    ISUIElement.onResize(self)

    if self.recipeListPanel and self.recipeListPanel.selected then
        self.recipeListPanel:ensureVisible(self.recipeListPanel.selected);
    end
end

function ISWidgetRecipeListPanel:prerender()
    ISPanel.prerender(self);

    if self.recipeListPanel and self.recipeListPanel.vscroll then
        self.recipeListPanel.vscroll:setHeight(self.recipeListPanel:getHeight());
        self.recipeListPanel.vscroll:setX(self.recipeListPanel:getWidth()-self.recipeListPanel.vscroll:getWidth());
    end
end

function ISWidgetRecipeListPanel:render()
    ISPanel.render(self);
end

function ISWidgetRecipeListPanel:update()
    ISPanel.update(self);
end

function ISWidgetRecipeListPanel:setSelectedData(_recipe)
    for i = 1, #self.recipeListPanel.items do
        if self.recipeListPanel.items[i].item == _recipe then
            self.recipeListPanel.selected = i;
            self.recipeListPanel:ensureVisible(i);
            break;
        end
    end
end

function ISWidgetRecipeListPanel:setDataList(_recipeList)
    local currentRecipe = self.logic:getRecipe();

    self.recipeListPanel:clear();
    for i = 0, _recipeList:size()-1 do
        local failed = false;
        if _recipeList:get(i):getOnAddToMenu() then
            local func = _recipeList:get(i):getOnAddToMenu();
            local params = {player = self.player, recipe = _recipeList:get(i), shouldShowAll = self.enabledShowAllFilter}

            failed = not callLuaBool(func, params);
        end
        if not failed then
            local listItem = self.recipeListPanel:addItem(_recipeList:get(i):getTranslationName(), _recipeList:get(i));
            
            if listItem.item == currentRecipe then
                -- restore selection
                self.recipeListPanel.selected = listItem.itemindex;
            end
        end
    end
end

function ISWidgetRecipeListPanel:setInternalDimensions(_x, _y, _width, _height)
    if self.recipeListPanel then
        self.recipeListPanel:setHeight(_height);
        self.recipeListPanel:setWidth(_width);
        self.recipeListPanel:setX(_x);
        self.recipeListPanel:setY(_y);
    end
end

--************************************************************************--
--** ISWidgetRecipeListPanel:new
--**
--************************************************************************--
function ISWidgetRecipeListPanel:new(x, y, width, height, player, logic, callbackTarget)
    local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self

    o.player = player;
    o.logic = logic;
    o.callbackTarget = callbackTarget;
    o.enabledShowAllFilter = false;

    return o
end