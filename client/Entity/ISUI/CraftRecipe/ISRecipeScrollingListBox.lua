require "ISUI/ISScrollingListBox"

local UI_BORDER_SPACING = 10
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_HEADING = getTextManager():getFontHeight(UIFont.Small)
local FONT_SCALE = getTextManager():getFontHeight(UIFont.Small) / 19; -- normalize to 1080p
local ICON_SCALE = math.max(1, (FONT_SCALE - math.floor(FONT_SCALE)) < 0.5 and math.floor(FONT_SCALE) or math.ceil(FONT_SCALE));
local LIST_ICON_SIZE = 32 * ICON_SCALE;
local LIST_SUBICON_SIZE = 16 * ICON_SCALE
local LIST_FAVICON_SIZE = 10 * ICON_SCALE
local LIST_SUBICON_SPACING = 2 * ICON_SCALE

local SUBCATEGORY_INDENT = LIST_ICON_SIZE;

ISRecipeScrollingListBox = ISScrollingListBox:derive("ISRecipeScrollingListBox");

function ISRecipeScrollingListBox:initialise()
    ISScrollingListBox.initialise(self);
end

function ISRecipeScrollingListBox:doDrawItem(y, item, _alt)
    if item.groupNode then
        return self:doDrawGroup(y, item, _alt);
    else
        local nodeParent = item.node and item.node:getParent();
        local shouldShowItem = true;
        if nodeParent then 
            local expandedState = nodeParent:getExpandedState();
            shouldShowItem = expandedState == CraftRecipeListNodeExpandedState.OPEN or (expandedState == CraftRecipeListNodeExpandedState.PARTIAL and self:isCraftable(item.item));
        end
        if shouldShowItem then
            return self:doDrawNode(y, item, _alt);
        end
    end
    return y;
end

function ISRecipeScrollingListBox:isCraftable(_craftRecipe)
    if instanceof(self.logic, "BaseCraftingLogic") then
        if not self.player:isBuildCheat() then
            local cachedRecipeInfo = self.logic:getCachedRecipeInfo(_craftRecipe)
            if cachedRecipeInfo and (not cachedRecipeInfo:isValid()) then
                return false;
            elseif cachedRecipeInfo and (not cachedRecipeInfo:isCanPerform()) then
                return false;
            end
        end
    end
    return true;
end

function ISRecipeScrollingListBox:doDrawNode(y, item, _alt)
    local craftRecipe = item and item.item;
    local isInGroup = item and item.node and item.node:getParent() ~= nil;
    local xOffset = isInGroup and SUBCATEGORY_INDENT or 0;
    
    if craftRecipe then
        local favString = BaseCraftingLogic.getFavouriteModDataString(craftRecipe);
        local isFavourite = self.player:getModData()[favString] or false;

        local yActual = self:getYScroll() + y;
        if item.cachedHeight and (yActual > self.height or (yActual + item.cachedHeight) < 0) then
            -- we are outside stencil, dont draw, just return cachedHeight
            return y + item.cachedHeight;
        end

        if not item.height then item.height = self.itemheight end -- compatibililty
        local safeDrawWidth = self:getWidth() - (self.vscroll and self.vscroll:getWidth() or 0) - xOffset;

        local cheat = self.player:isBuildCheat()

        -- set colours
        local color = self:isCraftable(craftRecipe) and {r=1.0, g=1.0, b=1.0, a=1.0} or {r=0.5, g=0.5, b=0.5, a=1.0};

        if self.selected == item.index then
            self:drawSelection(0, y, self:getWidth(), item.height-1);
        elseif (self.mouseoverselected == item.index) and self:isMouseOver() and not self:isMouseOverScrollBar() then
            self:drawMouseOverHighlight(0, y, self:getWidth(), item.height-1);
        end

        self:drawRectBorder(0, y, self:getWidth(), item.height, 0.5, self.borderColor.r, self.borderColor.g, self.borderColor.b);

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

        if cheat then
            colBad = colGood;
        end

        local detailsLeft = UI_BORDER_SPACING + LIST_ICON_SIZE + UI_BORDER_SPACING + xOffset;
        local detailsY = 4;

        -- icons

        --if the image display size is 16x16, then this will automatically grab the 16x16 version
        local fileSize = ".png"
        if LIST_SUBICON_SIZE == 16 then
            fileSize = "_16.png"
        end

        local iconRight = safeDrawWidth - UI_BORDER_SPACING - (LIST_SUBICON_SIZE/2) - LIST_SUBICON_SPACING;
        if craftRecipe:isCanWalk() then
            local iconTexture = getTexture("media/ui/craftingMenus/BuildProperty_Walking" .. fileSize);
            self:drawTextureScaledAspect(iconTexture, iconRight, y +detailsY, LIST_SUBICON_SIZE, LIST_SUBICON_SIZE, color.a, color.r, color.g, color.b);
            iconRight = iconRight - LIST_SUBICON_SIZE - LIST_SUBICON_SPACING;
        end
        if not craftRecipe:canBeDoneInDark() and not self.ignoreLightIcon then
            local iconTexture = getTexture("media/ui/craftingMenus/BuildProperty_Light" .. fileSize);
            self:drawTextureScaledAspect(iconTexture, iconRight, y +detailsY, LIST_SUBICON_SIZE, LIST_SUBICON_SIZE, color.a, color.r, color.g, color.b);
            iconRight = iconRight - LIST_SUBICON_SIZE - LIST_SUBICON_SPACING;
        end
        if craftRecipe:needToBeLearn() then
            local iconTexture = getTexture("media/ui/craftingMenus/BuildProperty_Book" .. fileSize);
            local alpha = 1;
            if not self.player:isRecipeKnown(craftRecipe, true) then
                alpha = 0.5;
            end
            self:drawTextureScaledAspect(iconTexture, iconRight, y +detailsY, LIST_SUBICON_SIZE, LIST_SUBICON_SIZE, alpha, color.r, color.g, color.b);
            iconRight = iconRight - LIST_SUBICON_SIZE - LIST_SUBICON_SPACING;
        end
        if not craftRecipe:isInHandCraftCraft() and not self.ignoreSurface then
            local iconTexture = getTexture("media/ui/craftingMenus/BuildProperty_Surface" .. fileSize);
            self:drawTextureScaledAspect(iconTexture, iconRight, y +detailsY, LIST_SUBICON_SIZE, LIST_SUBICON_SIZE, color.a, color.r, color.g, color.b);
            iconRight = iconRight - LIST_SUBICON_SIZE - LIST_SUBICON_SPACING;
        end

        -- header
        local headerAdj = (LIST_SUBICON_SIZE - FONT_HGT_HEADING) / 2;
        detailsY = detailsY + headerAdj;
        local maxTitleWidth = (iconRight - detailsLeft) - (UI_BORDER_SPACING + LIST_SUBICON_SIZE + LIST_SUBICON_SPACING); -- current gap, minus space for Favicon
        local titleStr = getTextManager():WrapText(UIFont.Small, craftRecipe:getTranslationName(), maxTitleWidth, 2, "...");
        if isDebugEnabled() then
            local tags = "";
            for i=0,craftRecipe:getTags():size() -1 do
                tags = tags .. craftRecipe:getTags():get(i);
                if i < craftRecipe:getTags():size()-1 then
                    tags = tags .. ",";
                end
            end
            titleStr = titleStr .. "\n (tags: " .. tags .. ")";
        end
        self:drawText(titleStr, detailsLeft, y +detailsY, color.r, color.g, color.b, color.a, UIFont.Small);

        local headerTextHeight = getTextManager():MeasureStringY(UIFont.Small, titleStr);
        detailsY = detailsY + headerTextHeight;

        -- description
        if craftRecipe:getTooltip() then
            local text = getText(craftRecipe:getTooltip());
            if self.wrapTooltipText then
                local tooltipAvailableWidth = (safeDrawWidth - detailsLeft) - (UI_BORDER_SPACING*2 + LIST_SUBICON_SPACING);
                text = text:gsub("\n", " ");    -- remove existing tooltip newlines before resplitting. This seems to be generally better for our use case - spurcival
                text = getTextManager():WrapText(UIFont.Small, text, tooltipAvailableWidth)
            end
            self:drawText(text, detailsLeft, y +detailsY, 0.5, 0.5, 0.5, color.a, UIFont.Small);
            -- add more space for each <br> (which are turned into \n)
            local split = luautils.split(text, "\n");
            for i,v in ipairs(split) do
                detailsY = detailsY + FONT_HGT_SMALL;
            end
        end

        -- skill
        if craftRecipe:getRequiredSkillCount()>0 then
            for i=0,craftRecipe:getRequiredSkillCount()-1 do
                local requiredSkill = craftRecipe:getRequiredSkill(i);
                local hasSkill = CraftRecipeManager.hasPlayerRequiredSkill(requiredSkill, self.player);
                local lineColor = hasSkill and colGood or colBad;

                local text = getText("IGUI_CraftingWindow_Requires2").." ".. tostring(requiredSkill:getPerk():getName()).." "..getText("IGUI_CraftingWindow_Level").." " .. tostring(requiredSkill:getLevel());
                self:drawText(text, detailsLeft, y +detailsY, lineColor.r, lineColor.g, lineColor.b, lineColor.a, UIFont.Small);
                detailsY = detailsY + FONT_HGT_SMALL;
            end
        end

        local usedHeight = math.max(self.itemheight, detailsY + UI_BORDER_SPACING)
        if isFavourite then
            usedHeight = math.max(usedHeight, LIST_ICON_SIZE + (LIST_FAVICON_SIZE/2));
        end

        item.height = usedHeight;
        item.cachedHeight = usedHeight;

        -- draw icon mid-high
        local iconY = y + (usedHeight/2)-(LIST_ICON_SIZE/2);
        local texture = craftRecipe:getIconTexture()
        self:drawTextureScaledAspect(texture, UI_BORDER_SPACING + xOffset, iconY, LIST_ICON_SIZE, LIST_ICON_SIZE, color.a, color.r, color.g, color.b);

        -- favourite button
        local starIconY = iconY + (LIST_ICON_SIZE) - (LIST_FAVICON_SIZE);
        if isFavourite then
            self:drawTextureScaledAspect(self.starSetTexture, UI_BORDER_SPACING + xOffset, starIconY, LIST_FAVICON_SIZE, LIST_FAVICON_SIZE, color.a, getCore():getGoodHighlitedColor():getR(), getCore():getGoodHighlitedColor():getG(), getCore():getGoodHighlitedColor():getB());
        end

        return y + usedHeight;
    end
    return y;
end

function ISRecipeScrollingListBox:doDrawGroup(y, item, _alt)
    local childNodes = item.groupNode:getChildren();
    
    -- check if all children are craftable
    local allChildrenCraftable = true;
    for i = 0, childNodes:size()-1 do
        local craftRecipe = childNodes:get(i):getRecipe();
        if not self:isCraftable(craftRecipe) then
            allChildrenCraftable = false;
            break;
        end
    end
    -- if all children are craftable, partial should be changed to fully open
    if allChildrenCraftable and item.groupNode:getExpandedState() == CraftRecipeListNodeExpandedState.PARTIAL then
        item.groupNode:setExpandedState(CraftRecipeListNodeExpandedState.OPEN);
    end
    
    local yActual = self:getYScroll() + y;
    if item.cachedHeight and (yActual > self.height or (yActual + item.cachedHeight) < 0) then
        -- we are outside stencil, dont draw, just return cachedHeight
        return y + item.cachedHeight;
    end

    if not item.height then item.height = self.itemheight end -- compatibililty
    local safeDrawWidth = self:getWidth() - (self.vscroll and self.vscroll:getWidth() or 0);

    local cheat = self.player:isBuildCheat()

    -- set colours
    local color = {r=0.5, g=0.5, b=0.5, a=1.0};
    if instanceof(self.logic, "BaseCraftingLogic") then
        -- verify if any child recipe is valid - show group as valid if so
        for i = 0, childNodes:size()-1 do
            local craftRecipe = childNodes:get(i):getRecipe();
            if self:isCraftable(craftRecipe) then
                color = {r=1.0, g=1.0, b=1.0, a=1.0};
                break;
            end
        end
    end

    if self.selected == item.index then
        self:drawSelection(0, y, self:getWidth(), item.height-1);
    elseif (self.mouseoverselected == item.index) and self:isMouseOver() and not self:isMouseOverScrollBar() then
        self:drawMouseOverHighlight(0, y, self:getWidth(), item.height-1);
    end

    self:drawRectBorder(0, y, self:getWidth(), item.height, 0.5, self.borderColor.r, self.borderColor.g, self.borderColor.b);

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

    if cheat then
        colBad = colGood;
    end

    local detailsLeft = UI_BORDER_SPACING + LIST_ICON_SIZE + UI_BORDER_SPACING;
    local detailsY = 4;

    -- icons

    --if the image display size is 16x16, then this will automatically grab the 16x16 version
    local fileSize = ".png"
    if LIST_SUBICON_SIZE == 16 then
        fileSize = "_16.png"
    end

    local iconRight = safeDrawWidth - UI_BORDER_SPACING - (LIST_SUBICON_SIZE/2) - LIST_SUBICON_SPACING;

    -- header
    local headerAdj = (LIST_SUBICON_SIZE - FONT_HGT_HEADING) / 2;
    detailsY = detailsY + headerAdj;
    local maxTitleWidth = (iconRight - detailsLeft) - (UI_BORDER_SPACING + LIST_SUBICON_SIZE + LIST_SUBICON_SPACING); -- current gap, minus space for Favicon
    local titleText = item.groupNode:getTitle();
    local titleStr = getTextManager():WrapText(UIFont.Small, titleText, maxTitleWidth, 2, "...");
    if isDebugEnabled() then
        local debugGroup = item.groupNode:getGroup():toString();
        titleStr = titleStr .. "\n (group: " .. debugGroup .. ")";
    end
    self:drawText(titleStr, detailsLeft, y +detailsY, color.r, color.g, color.b, color.a, UIFont.Small);

    local headerTextHeight = getTextManager():MeasureStringY(UIFont.Small, titleStr);
    detailsY = detailsY + headerTextHeight;

    local usedHeight = math.max(self.itemheight, detailsY + UI_BORDER_SPACING)

    item.height = usedHeight;
    item.cachedHeight = usedHeight;

    -- draw icon mid-high
    local iconY = y + (usedHeight/2)-(LIST_ICON_SIZE/2);
    local texture = item.groupNode:getIconTexture();
    local iconColor = {r=1.0, g=1.0, b=1.0, a=0.5};
    self:drawTextureScaledAspect(texture, UI_BORDER_SPACING, iconY, LIST_ICON_SIZE, LIST_ICON_SIZE, iconColor.a, iconColor.r, iconColor.g, iconColor.b);
    
    -- draw expansion arrow
    local texture = self.groupClosedTexture;
    if item.groupNode:getExpandedState() == CraftRecipeListNodeExpandedState.OPEN then texture = self.groupOpenTexture end
    if item.groupNode:getExpandedState() == CraftRecipeListNodeExpandedState.PARTIAL then texture = self.groupPartialTexture end
    
    local iconColor = {r=1.0, g=1.0, b=1.0, a=1.0};
    self:drawTextureScaledAspect(texture, UI_BORDER_SPACING + (LIST_SUBICON_SIZE / 2), iconY + (LIST_SUBICON_SIZE / 2), LIST_SUBICON_SIZE, LIST_SUBICON_SIZE, iconColor.a, iconColor.r, iconColor.g, iconColor.b);

    return y + usedHeight;
end

function ISRecipeScrollingListBox:addGroup(_groupNode, _nodes, _recipeToSelect, _enabledShowAllFilter)
    local recipeFoundIndex = -1;

    -- add category
    if _groupNode then
        local groupTitle = _groupNode:getTitle();
        
        local listItem = self:addItem(groupTitle, nil);
        listItem.groupNode = _groupNode;
    end
    
    -- add nodes
    for i = 0, _nodes:size()-1 do
        local craftRecipeListNode = _nodes:get(i);
        if craftRecipeListNode:getType() == CraftRecipeListNode.CraftRecipeListNodeType.RECIPE then
            local failed = false;
            local craftRecipe = craftRecipeListNode:getRecipe();
            
            if craftRecipe and craftRecipe:getOnAddToMenu() then
                local func = craftRecipe:getOnAddToMenu();
                local params = {player = self.player, recipe = craftRecipe, shouldShowAll = _enabledShowAllFilter}
                failed = not callLuaBool(func, params);
            end
            
            if not failed then
                local listItem = self:addItem(craftRecipe:getTranslationName(), craftRecipe);
                listItem.node = craftRecipeListNode;
                if listItem.item == _recipeToSelect then
                    -- restore selection
                    recipeFoundIndex = listItem.itemindex;
                end
            end          
        elseif craftRecipeListNode:getType() == CraftRecipeListNode.CraftRecipeListNodeType.GROUP then
            local groupRecipeFoundIndex = self:addGroup(craftRecipeListNode, craftRecipeListNode:getChildren(), _recipeToSelect, _enabledShowAllFilter);
            if groupRecipeFoundIndex ~= -1 then
                recipeFoundIndex = groupRecipeFoundIndex;
            end
        end
    end
    
    return recipeFoundIndex;
end

function ISRecipeScrollingListBox:onMouseDoubleClick(x, y)
    if self:isMouseOverScrollBar() then
        return self.vscroll:onMouseDoubleClick(x - self.vscroll.x, y + self:getYScroll() - self.vscroll.y)
    end

    local selected = self.items[self.selected];

    if selected then
        if selected.groupNode then
            self:toggleGroup(selected.groupNode);
        else
            if self.onmousedblclick then
                self.onmousedblclick(self.target, selected.item);
            end
        end
    end
end

function ISRecipeScrollingListBox:onMouseDown(x, y)
    if #self.items == 0 then return end
    local row = self:rowAt(x, y)

    if row > #self.items then
        row = #self.items;
    end
    if row < 1 then
        return
    end

    getSoundManager():playUISound("UISelectListItem")

    self.selected = row;
    local selected = self.items[self.selected];

    if selected then
        if selected.groupNode then
            self:toggleGroup(selected.groupNode);
        else
            if self.onmousedown then
                self.onmousedown(self.target, selected.item);
            end
        end
    end
end

function ISRecipeScrollingListBox:toggleGroup(_groupNode)
    local childNodes = _groupNode:getChildren();
    
    -- check how many children are craftable
    local craftableChildCount = 0;
    for i = 0, childNodes:size()-1 do
        local craftRecipe = childNodes:get(i):getRecipe();
        if self:isCraftable(craftRecipe) then
            craftableChildCount = craftableChildCount + 1;
        end
    end

    if craftableChildCount == 0 or craftableChildCount == childNodes:size() then
        -- dont bother with partial, just flip between open and closed
        local newExpandedState = (_groupNode:getExpandedState() == CraftRecipeListNodeExpandedState.OPEN) and CraftRecipeListNodeExpandedState.CLOSED or CraftRecipeListNodeExpandedState.OPEN; 
        _groupNode:setExpandedState(newExpandedState);
    else
        _groupNode:toggleExpandedState();
    end 
end

function ISRecipeScrollingListBox:onJoypadDirUp()
    self.selected = self:prevVisibleIndex(self.selected)

    if self.selected <= 0 then
        self.selected = self:prevVisibleIndex(self.count + 1);
    end

    getSoundManager():playUISound("UISelectListItem")

    self:ensureVisible(self.selected)

    local selected = self.items[self.selected];

    if selected then
        if selected.groupNode then
            -- do nothing for groups
        else
            if self.onmousedown and selected then
                self.onmousedown(self.target, selected.item);
            end
        end
    end
end

function ISRecipeScrollingListBox:onJoypadDirDown()
    self.selected = self:nextVisibleIndex(self.selected)
    if self.selected == -1 then
        self.selected = self:nextVisibleIndex(0);
    end

    getSoundManager():playUISound("UISelectListItem")

    self:ensureVisible(self.selected)

    local selected = self.items[self.selected];

    if selected then
        if selected.groupNode then
            -- do nothing for groups
        else
            if self.onmousedown and selected then
                self.onmousedown(self.target, selected.item);
            end
        end
    end
end

function ISRecipeScrollingListBox:onJoypadDown(button, joypadData)
    local selected = self.items[self.selected];
    if selected then
        if button == Joypad.AButton and selected.groupNode then
            selected.groupNode:toggleExpandedState();
        elseif button == Joypad.AButton and self.onmousedblclick then
            local previousSelected = self.selected;
            self.onmousedblclick(self.target, self.items[self.selected].item);
            self.selected = previousSelected;
        elseif button == Joypad.BButton and self.joypadParent then
            self.joypadFocused = false;
            joypadData.focus = self.joypadParent;
            updateJoypadFocus(joypadData);
        else
            ISPanelJoypad.onJoypadDown(self, button, joypadData);
        end
    end
end

function ISRecipeScrollingListBox:new (x, y, width, height, player, logic)
    local o = {}
    o = ISScrollingListBox:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self

    o.player = player;
    o.logic = logic;
    
    o.starUnsetTexture = getTexture("media/ui/inventoryPanes/FavouriteNo.png");
    o.starSetTexture = getTexture("media/ui/inventoryPanes/FavouriteYes.png");
    
    o.groupOpenTexture = getTexture("media/ui/Icon_RecipeGroup_Open_48x48.png");
    o.groupPartialTexture = getTexture("media/ui/Icon_RecipeGroup_Partial_48x48.png");
    o.groupClosedTexture = getTexture("media/ui/Icon_RecipeGroup_Closed_48x48.png");

    o.itemheight = math.max(2 + FONT_HGT_HEADING + FONT_HGT_SMALL + UI_BORDER_SPACING, LIST_ICON_SIZE + UI_BORDER_SPACING);
    
    o.selected = 0;
    o.drawBorder = true;

    return o
end

