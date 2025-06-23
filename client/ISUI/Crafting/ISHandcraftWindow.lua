--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISCollapsableWindow"

ISHandcraftWindow = ISCollapsableWindow:derive("ISHandcraftWindow");


function ISHandcraftWindow:initialise()
    ISCollapsableWindow.initialise(self);

    if self.maximumHeightPercent>0 then
        local maxPercent = math.min(self.maximumHeightPercent, 1);
        self.maximumHeight = getCore():getScreenHeight() * maxPercent;
    end
end

function ISHandcraftWindow:createChildren()
    ISCollapsableWindow.createChildren(self);

    self.windowHeader = ISXuiSkin.build(self.xuiSkin, nil, ISHandcraftWindowHeader, 0, 0, 10, 10, self.player);
    if self.isoObject then
		local header = getText("IGUI_CraftingWindow_Header");
		local props = self.isoObject:getProperties();
		local surface = (props and props:Is("IsMoveAble") and props:Is("CustomName") and props:Val("CustomName")) or getText("IGUI_CraftingWindow_Surface"); --self.isoObject:getProperties():Is("IsMoveAble") and  
        self.windowHeader.titleStr = header .. surface;
    end
    self.windowHeader:initialise();
    self.windowHeader:instantiate();
    self:addChild(self.windowHeader);

    self.handCraftPanel = ISXuiSkin.build(self.xuiSkin, nil, ISHandCraftPanel, 0, 0, 10, 10, self.player, nil, self.isoObject);
    if self.queryOverride then
        self.handCraftPanel.recipeQuery = self.queryOverride;
    elseif self.isoObject then
        self.handCraftPanel.recipeQuery = "InHandCraft;AnySurfaceCraft";
    else
        self.handCraftPanel.recipeQuery = "InHandCraft;AnySurfaceCraft";
    end
    self.handCraftPanel:initialise();
    self.handCraftPanel:instantiate();
    self:addChild(self.handCraftPanel);

    --self.maximumHeight = 200;
    if self.pinButton then
        self.pinButton:setAnchorRight(false);
    end
    if self.collapseButton then
        self.collapseButton:setAnchorRight(false);
    end

    -- due to onResize -> calculateLayout anchors causing issues we set custom resize function to widgets.
    self.resizeWidget.resizeFunction = ISHandcraftWindow.calculateLayout;
    self.resizeWidget2.resizeFunction = ISHandcraftWindow.calculateLayout;

    --self:calculateLayout();
    self:xuiRecalculateLayout();
end

function ISHandcraftWindow:xuiRecalculateLayout(_preferredWidth, _preferredHeight, _force, _anchorRight)
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

function ISHandcraftWindow:calculateLayout(_preferredWidth, _preferredHeight)
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
    self.handCraftPanel:calculateLayout(0, 0);

    width = math.max(width, self.windowHeader:getWidth());
    width = math.max(width, self.handCraftPanel:getWidth());


    local x,y = 0,th;

    self.windowHeader:setX(0);
    self.windowHeader:setY(th);
    self.windowHeader:calculateLayout(width, 0);

    local wh = self.windowHeader:getHeight();

    if self.handCraftPanel then
        self.handCraftPanel:setX(0);
        self.handCraftPanel:setY(th+wh);
        self.handCraftPanel:calculateLayout(width, math.max(0, height-th-rh-wh));

        width = math.max(width, self.handCraftPanel:getWidth());
        height = math.max(height, self.handCraftPanel:getHeight()+th+rh+wh);
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

function ISHandcraftWindow:prerender()
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

    if self.isoObject then
        if self.isoObjectInProximity then
            --if getCore():getOptionDoContainerOutline() then
            --    self.isoObject:setOutlineHighlight(true);
            --    self.isoObject:setOutlineHlAttached(true);
            --    self.isoObject:setOutlineHighlightCol(getCore():getWorkstationHighlitedColor():getR(), getCore():getWorkstationHighlitedColor():getG(), getCore():getWorkstationHighlitedColor():getB(), 1);
            --end

            local header = getText("IGUI_CraftingWindow_Header");
            local props = self.isoObject:getProperties();
            local surface = (props and props:Is("IsMoveAble") and props:Is("CustomName") and props:Val("CustomName")) or getText("IGUI_CraftingWindow_Surface"); --self.isoObject:getProperties():Is("IsMoveAble") and
            self.windowHeader.title.name = header .. surface;
        else
--             self.isoObject:setOutlineHighlight(false);
--             self.isoObject:setOutlineHlAttached(false);
            self.windowHeader.title.name = getText("IGUI_CraftingWindow_Title");
        end
    else
        self.windowHeader.title.name = getText("IGUI_CraftingWindow_Title");
    end

    ISCollapsableWindow.prerender(self);
end

function ISHandcraftWindow:stayOnSplitScreen()
    ISUIElement.stayOnSplitScreen(self, self.playerNum)
end


function ISHandcraftWindow:render()
    self:stayOnSplitScreen();
    ISCollapsableWindow.render(self);
    local playerNum = self.player:getPlayerNum()
    self:renderJoypadNavigateOverlay(playerNum)
end

function ISHandcraftWindow:update()
    ISCollapsableWindow.update(self);

    local valid = false;
    local isoObjectProximityChanged = false;

    if self.isoObject and self.player then
        local dist = self.panelCloseDistance or 10;
        -- in case of IsoObject check distance.
        local ex, ey, ez = self.isoObject:getX(), self.isoObject:getY(), self.isoObject:getZ();
        local px, py, pz = self.player:getX(), self.player:getY(), self.player:getZ();

        if self.isoObject:getSquare() then
            --if px > ex-dist and px < ex+dist and py > ey-dist and py < ey+dist and ez == pz then
            if self.isoObject:getSquare():DistToProper(self.player) <= dist then
                valid = true;
                if not self.isoObjectInProximity then
                    self.isoObjectInProximity = true;
                    ISHandCraftPanel.drawDirty = true;
                    self.handCraftPanel.updateTimer = 0;
                end
            else
                valid = true;
                if self.isoObjectInProximity then
                    self.isoObjectInProximity = false;
                    ISHandCraftPanel.drawDirty = true;
                    self.handCraftPanel.updateTimer = 0;
                end
            end
        end
        
        -- check to prevent players in vehicles from using this stuff
        if self.player and self.player:getVehicle() then
            valid = false
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

function ISHandcraftWindow:close()
    if self.hasClosedWindowInstance then --to prevent occasional double calling of close due to a call in self.update.
        return;
    end
    self.hasClosedWindowInstance = true;

    if self.handCraftPanel then
        self.handCraftPanel:OnCloseWindow();
        self:prerender();
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
--         self.isoObject:setOutlineHighlight(false);
--         self.isoObject:setOutlineHlAttached(false);
    end
    self:removeFromUIManager();
end

function ISHandcraftWindow:validateSizeBounds()
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

function ISHandcraftWindow:isKeyConsumed(key)
    return key == Keyboard.KEY_ESCAPE or getCore():isKey("Crafting UI", key)
end

function ISHandcraftWindow:onKeyRelease(key)
    if self:isVisible() and (key == Keyboard.KEY_ESCAPE or getCore():isKey("Crafting UI", key)) then
        self:close()
        self:removeFromUIManager();
        return
    end
end

function ISHandcraftWindow:onGainJoypadFocus(joypadData)
    ISCollapsableWindow.onGainJoypadFocus(self, joypadData)
    local recipeCategories = self.handCraftPanel.recipeCategories.recipeCategoryPanel
    recipeCategories:setJoypadFocused(true, joypadData)
end

function ISHandcraftWindow:onLoseJoypadFocus(joypadData)
    ISCollapsableWindow.onLoseJoypadFocus(self, joypadData)
end

function ISHandcraftWindow:onJoypadDown(button, joypadData)
    ISCollapsableWindow.onJoypadDown(self, button, joypadData)
end

function ISHandcraftWindow:onJoypadDown_Descendant(descendant, button, joypadData)
    if button == Joypad.AButton then
        local craftControl = self.handCraftPanel.recipePanel.craftControl
        craftControl.buttonCraft:forceClick()
    end
    if button == Joypad.BButton then
        self:close()
    end
end

function ISHandcraftWindow:onJoypadNavigateStart_Descendant(descendant, joypadData)
    local recipeCategories = self.handCraftPanel.recipeCategories.recipeCategoryPanel
    local recipeFilterPanel = self.handCraftPanel.recipesPanel.recipeFilterPanel
    local recipeIconPanel = self.handCraftPanel.recipesPanel.recipeIconPanel
    local recipeListPanel = self.handCraftPanel.recipesPanel.recipeListPanel.recipeListPanel
    local listOrIconPanel = recipeIconPanel:isVisible() and recipeIconPanel or recipeListPanel
    local recipePanel = self.handCraftPanel.recipePanel
    local inventoryPanel = self.handCraftPanel.inventoryPanel.itemListBox
    inventoryPanel.joypadNavigate = { left = recipePanel.inputs }
    if not inventoryPanel:isReallyVisible() then inventoryPanel = nil end
    recipeCategories.joypadNavigate = { right = listOrIconPanel }
    recipeFilterPanel.joypadNavigate = { left = recipeCategories, right = recipePanel.inputs, down = listOrIconPanel }
    listOrIconPanel.joypadNavigate = { left = recipeCategories,  up = recipeFilterPanel, right = recipePanel.inputs }
    recipePanel.inputs.joypadNavigate = { left = listOrIconPanel, right = inventoryPanel, down = recipePanel.craftControl }
    recipePanel.craftControl.joypadNavigate = { left = listOrIconPanel, right = inventoryPanel, up = recipePanel.inputs }
end

function ISHandcraftWindow:new(x, y, width, height, player, isoObject, queryOverride)
    local o = ISCollapsableWindow.new(self, x, y, width, height);

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

    -- reduced distance to be consistent with the distance at which you can initially interact with a workstation
    o.panelCloseDistance = 2;
--     o.panelCloseDistance = 8;
    o.isoObject = isoObject;
    o.queryOverride = queryOverride;
    o.isoObjectInProximity = true;
    
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
--         isoObject:setOutlineHighlight(true);
--         isoObject:setOutlineHlAttached(true);
--         isoObject:setOutlineHighlightCol(getCore():getWorkstationHighlitedColor():getR(), getCore():getWorkstationHighlitedColor():getG(), getCore():getWorkstationHighlitedColor():getB(), 1);
    end

    return o
end
