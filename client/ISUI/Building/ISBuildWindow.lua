--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISCollapsableWindow"

ISBuildWindow = ISCollapsableWindow:derive("ISBuildWindow");


function ISBuildWindow:initialise()
    ISCollapsableWindow.initialise(self);

    if self.maximumHeightPercent>0 then
        local maxPercent = math.min(self.maximumHeightPercent, 1);
        self.maximumHeight = getCore():getScreenHeight() * maxPercent;
    end
end


function ISBuildWindow:isKeyConsumed(key)
    return key == Keyboard.KEY_ESCAPE or getCore():isKey("Building UI", key)
--     return key == Keyboard.KEY_ESCAPE
end

function ISBuildWindow:onKeyRelease(key)
    if self:isVisible() and (key == Keyboard.KEY_ESCAPE or getCore():isKey("Building UI", key)) then
        self:close()
        self:removeFromUIManager();
        return
    end
end

function ISBuildWindow:createChildren()
    ISCollapsableWindow.createChildren(self);

    self.windowHeader = ISXuiSkin.build(self.xuiSkin, nil, ISBuildWindowHeader, 0, 0, 10, 10, self.player);
    if self.isoObject then
		local header = getText("IGUI_BuildingWindow_Header");
		local props = self.isoObject:getProperties();
		local surface = (props and props:Is("IsMoveAble") and props:Is("CustomName") and props:Val("CustomName")) or getText("IGUI_BuildingWindow_Surface"); --self.isoObject:getProperties():Is("IsMoveAble") and
        self.windowHeader.titleStr = header .. surface;
    end
    self.windowHeader:initialise();
    self.windowHeader:instantiate();
    self:addChild(self.windowHeader);

    self.BuildPanel = ISXuiSkin.build(self.xuiSkin, nil, ISBuildPanel, 0, 0, 10, 10, self.player, nil, self.isoObject);

    self.BuildPanel.recipeQuery = "AnySurfaceCraft";

    self.BuildPanel:initialise();
    self.BuildPanel:instantiate();
    self:addChild(self.BuildPanel);

    --self.maximumHeight = 200;
    if self.pinButton then
        self.pinButton:setAnchorRight(false);
    end
    if self.collapseButton then
        self.collapseButton:setAnchorRight(false);
    end

    -- due to onResize -> calculateLayout anchors causing issues we set custom resize function to widgets.
    self.resizeWidget.resizeFunction = ISBuildWindow.calculateLayout;
    self.resizeWidget2.resizeFunction = ISBuildWindow.calculateLayout;

    --self:calculateLayout();
    self:xuiRecalculateLayout();
end

function ISBuildWindow:xuiRecalculateLayout(_preferredWidth, _preferredHeight, _force, _anchorRight)
    if self.calculateLayout and ((not self.dirtyLayout) or _force) then
        --print("xuiRecalculateLayout setting dirty state")
        self.xuiPreferredResizeWidth = self.width;
        self.xuiPreferredResizeHeight = self.height;
        self.xuiResizeAnchorRight = _anchorRight;
        if _preferredWidth then
            self.xuiPreferredResizeWidth = _preferredWidth<0 and self.width+_preferredWidth or _preferredWidth;
        end
        if _preferredHeight then
            self.xuiPreferredResizeHeight = _preferredHeight<0 and self.height+_preferredHeight or _preferredHeight;
        end
        self.dirtyLayout = true;
        --self:calculateLayout(self.width, self.height);
    end
end

function ISBuildWindow:calculateLayout(_preferredWidth, _preferredHeight)
    --print("############# CALC LAYOUT ##############")
    self:validateSizeBounds();

    local th = self:titleBarHeight();
    local rh = self.resizable and self:resizeWidgetHeight() or 0;

    local width = math.max(_preferredWidth or 0, self.minimumWidth);
    local height = math.max(_preferredHeight or 0, self.minimumHeight);

    -- limit the preferred sizes to maximum bounds (can be overruled by children sizes)
    if self.maximumWidth>0 then width = math.min(width, self.maximumWidth); end
    if self.maximumHeight>0 then height = math.min(height, self.maximumHeight); end

    self.windowHeader:calculateLayout(0, 0);
    self.BuildPanel:calculateLayout(0, 0);

    width = math.max(width, self.windowHeader:getWidth());
    width = math.max(width, self.BuildPanel:getWidth());


    local x,y = 0,th;

    self.windowHeader:setX(0);
    self.windowHeader:setY(th);
    self.windowHeader:calculateLayout(width, 0);

    local wh = self.windowHeader:getHeight();

    if self.BuildPanel then
        self.BuildPanel:setX(0);
        self.BuildPanel:setY(th+wh);
        self.BuildPanel:calculateLayout(width, math.max(0, height-th-rh-wh));

        width = math.max(width, self.BuildPanel:getWidth());
        height = math.max(height, self.BuildPanel:getHeight()+th+rh+wh);
    end


    self:setWidth(width);
    self:setHeight(height);

    self.dirtyLayout = false;

    if self.pinButton then
        self.pinButton:setX(width - 3 - self.pinButton:getWidth())
    end
    if self.collapseButton then
        self.collapseButton:setX(width - 3 - self.collapseButton:getWidth())
    end
end

function ISBuildWindow:prerender()
    self:stayOnSplitScreen();

    if self.dirtyLayout then
        local oldX = self:getX();
        local oldWidth = self:getWidth();
        if self.calculateLayout then self:calculateLayout(self.xuiPreferredResizeWidth, self.xuiPreferredResizeHeight); end
        self.dirtyLayout = false;

        if self.xuiResizeAnchorRight then
            self:setX(oldX - (self:getWidth()-oldWidth))
            self.xuiResizeAnchorRight = false;
        end
    end

    ISCollapsableWindow.prerender(self);
end

function ISBuildWindow:stayOnSplitScreen()
    ISUIElement.stayOnSplitScreen(self, self.playerNum)
end


function ISBuildWindow:render()
    self:stayOnSplitScreen();
    ISCollapsableWindow.render(self);
    self:renderJoypadNavigateOverlay(self.playerNum)
end

function ISBuildWindow:update()
    ISCollapsableWindow.update(self);

    local valid = false;

    if self.isoObject and self.player then
        local dist = self.panelCloseDistance or 10;
        -- in case of IsoObject check distance.
        local ex, ey = self.isoObject:getX(), self.isoObject:getY();
        local px, py = self.player:getX(), self.player:getY();

        if self.isoObject:getSquare() and px > ex-dist and px < ex+dist and py > ey-dist and py < ey+dist then
            valid = true;
        end
    else
        valid = self.player;
    end
    if self.hasClosedWindowInstance then --to prevent occasional double calling of close due to a call in self.update.
        return;
    end

    if not valid then
       self:close();
    end
    return valid;
end

function ISBuildWindow:close()
    if self.hasClosedWindowInstance then --to prevent occasional double calling of close due to a call in self.update.
        return;
    end
    self.hasClosedWindowInstance = true;
    
    -- let build panel know we are closing so it can tidy up
    if self.BuildPanel then
        self.BuildPanel:close();
    end

    ISCollapsableWindow.close(self);
    ISEntityUI.OnCloseWindow(self);
    if JoypadState.players[self.playerNum+1] then
        if self.unfocusRecursive then
            self:unfocusRecursive(getFocusForPlayer(self.playerNum), self.playerNum);
        elseif isJoypadFocusOnElementOrDescendant(self.playerNum, self) then
            setJoypadFocus(self.playerNum, nil);
        end
    end
    if self.entity then
        self.entity:setUsingPlayer(nil);
    end
    if self.isoObject and getCore():getOptionDoContainerOutline() then
        self.isoObject:setOutlineHighlight(false);
        self.isoObject:setOutlineHlAttached(false);
    end
    self:removeFromUIManager();
end

function ISBuildWindow:validateSizeBounds()
    if (not self.minimumWidth) or self.minimumWidth<0 then self.minimumWidth = 0; end
    if (not self.minimumHeight) or self.minimumHeight<0 then self.minimumHeight = 0; end

    if (not self.maximumWidth) or self.maximumWidth<0 then self.maximumWidth = 0; end
    if (not self.maximumHeight) or self.maximumHeight<0 then self.maximumHeight = 0; end

    if self.maximumWidth>0 and self.maximumWidth<self.minimumWidth then
        self.maximumWidth = self.minimumWidth;
    end
    if self.maximumHeight>0 and self.maximumHeight<self.minimumHeight then
        self.maximumHeight = self.minimumHeight;
    end
end

function ISBuildWindow:onGainJoypadFocus(joypadData)
    ISCollapsableWindow.onGainJoypadFocus(self, joypadData)
    local recipeCategories = self.BuildPanel.recipeCategories.recipeCategoryPanel
    recipeCategories:setJoypadFocused(true, joypadData)
end

function ISBuildWindow:onJoypadDown_Descendant(descendant, button, joypadData)
    if button == Joypad.AButton then
        local craftControl = self.BuildPanel.craftRecipePanel.craftControl
        craftControl.buttonCraft:forceClick()
    end
    if button == Joypad.BButton then
        self:close()
    end
end

function ISBuildWindow:onJoypadNavigateStart_Descendant(descendant, joypadData)
    local recipeCategories = self.BuildPanel.recipeCategories.recipeCategoryPanel
    local recipeFilterPanel = self.BuildPanel.recipesPanel.recipeFilterPanel
    local recipeIconPanel = self.BuildPanel.recipesPanel.recipeIconPanel
    local recipeListPanel = self.BuildPanel.recipesPanel.recipeListPanel.recipeListPanel
    local listOrIconPanel = recipeIconPanel:isVisible() and recipeIconPanel or recipeListPanel
    local recipePanel = self.BuildPanel.craftRecipePanel
    local recipeInputs = recipePanel and recipePanel.inputs or nil
    local craftControl = recipePanel and recipePanel.craftControl or nil
--    local inventoryPanel = self.BuildPanel.inventoryPanel.itemListBox
--    inventoryPanel.joypadNavigate = { left = recipePanel.inputs }
--    if not inventoryPanel:isReallyVisible() then inventoryPanel = nil end
    local inventoryPanel = nil
    recipeCategories.joypadNavigate = { right = listOrIconPanel }
    recipeFilterPanel.joypadNavigate = { left = recipeCategories, right = recipeInputs, down = listOrIconPanel }
    listOrIconPanel.joypadNavigate = { left = recipeCategories,  up = recipeFilterPanel, right = recipeInputs }
    if recipeInputs then
        recipeInputs.joypadNavigate = { left = listOrIconPanel, right = inventoryPanel, down = craftControl }
    end
    if craftControl then
        craftControl.joypadNavigate = { left = listOrIconPanel, right = inventoryPanel, up = recipeInputs }
    end
end

function ISBuildWindow:new(x, y, width, height, player, isoObject, queryOverride)
    local o = ISCollapsableWindow:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self

    o.x = x;
    o.y = y;
    o.player = player;
    o.playerNum = player:getPlayerNum();
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.width = width;
    o.height = height;
    o.anchorLeft = true;
    o.anchorRight = false;
    o.anchorTop = true;
    o.anchorBottom = false;
    o.pin = true;
    o.isCollapsed = false;
    o.collapseCounter = 0;
    o.title = nil;
    --o.resizable = false;
    o.drawFrame = true;

    o.panelCloseDistance = 8;
    o.isoObject = isoObject;
    o.queryOverride = queryOverride;

    o.resizable = true;
    o.enableHeader = true;

    o.minimumWidth = 600;
    o.minimumHeight = 400;

    o.maximumWidth = 0;
    o.maximumHeight = 0;

    o.maximumHeightPercent = -1;

    o.overrideBPrompt = true;
    o:setWantKeyEvents(true)

    if isoObject and getCore():getOptionDoContainerOutline() then
        isoObject:setOutlineHighlight(true);
        isoObject:setOutlineHlAttached(true);
        isoObject:setOutlineHighlightCol(1, 1, 1, 1);
    end

    return o
end
