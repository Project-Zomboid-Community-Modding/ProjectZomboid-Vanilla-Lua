--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

--[[
    Default entity ui window.
--]]

require "Entity/ISUI/ISBaseEntityWindow"

ISEntityWindow = ISBaseEntityWindow:derive("ISEntityWindow");

function ISEntityWindow.CanOpenWindowFor(_player, _entity)
    if _player and _entity then
        return ISEntityUI.HasComponentPanels(_player, _entity);
    end
end

function ISEntityWindow:initialise()
    ISBaseEntityWindow.initialise(self);
end

function ISEntityWindow:createChildren()
    ISBaseEntityWindow.createChildren(self);

    -- this creates the entity header with provided style or default if nil
    -- and provided self.enableHeader is true
    self:createEntityHeader(self.xuiSkin, "S_WidgetEntityHeader_Std", false, nil, nil, nil);

    if getDebug() and getDebugOptions():getBoolean("Entity.DebugUI") then
        self.entityDebug = ISXuiSkin.build(self.xuiSkin, "S_WidgetEntityDebug_Std", ISWidgetEntityDebug,0, 0, 10, 10, self.player, self.entity, nil);
        self.entityDebug:initialise();
        self.entityDebug:instantiate();

        self:addChild(self.entityDebug);
    end

    self.componentsPanel = ISXuiSkin.build(self.xuiSkin, "S_ComponentsListPanel_Std", ISComponentsListPanel, 0, 0, 100, 100, self.player, self.entity, self.entityConfig);
    self.componentsPanel:initialise();
    self.componentsPanel:instantiate();
    self:addChild(self.componentsPanel);

    --self.maximumHeight = 200;
    if self.pinButton then
        self.pinButton:setAnchorRight(false);
    end
    if self.collapseButton then
        self.collapseButton:setAnchorRight(false);
    end

    -- due to onResize -> calculateLayout anchors causing issues we set custom resize function to widgets.
    self.resizeWidget.resizeFunction = ISEntityWindow.calculateLayout;
    self.resizeWidget2.resizeFunction = ISEntityWindow.calculateLayout;

    --self:calculateLayout();
    self:xuiRecalculateLayout();
end

--[[
    Function calculateLayout can be given a preferred with and height, which may be passed nil or 0 to ignore.
    Note that there is no guarantee this will be the actual width or height.
    The actual width and height may be limited to the minimum sizes of child elements.
--]]
function ISEntityWindow:calculateLayout(_preferredWidth, _preferredHeight)
    --print("############# CALC LAYOUT ##############")
    self:validateSizeBounds();

    local th = self:titleBarHeight();
    local rh = self.resizable and self:resizeWidgetHeight() or 0;

    local width = math.max(_preferredWidth or 0, self.minimumWidth);
    local height = math.max(_preferredHeight or 0, self.minimumHeight);

    -- limit the preferred sizes to maximum bounds (can be overruled by children sizes)
    if self.maximumWidth>0 then width = math.min(width, self.maximumWidth); end
    if self.maximumHeight>0 then height = math.min(height, self.maximumHeight); end

    --print("_width = "..tostring(_preferredWidth)..", width = "..tostring(width)..", self.width = "..tostring(self.width))

    local x,y = 0,th;

    -- calculate entity header first pass
    if self.entityHeader then
        self.entityHeader:setX(x);
        self.entityHeader:setY(y);

        self.entityHeader:calculateLayout(width, 0);
        width = math.max(width, self.entityHeader:getWidth());

        y = self.entityHeader:getY() + self.entityHeader:getHeight();
    end

    if self.entityDebug then
        self.entityDebug:setX(x);
        self.entityDebug:setY(y);

        self.entityDebug:calculateLayout(width, 0);
        width = math.max(width, self.entityDebug:getWidth());

        y = self.entityDebug:getY() + self.entityDebug:getHeight();
    end

    -- calculate componentsPanel
    self.componentsPanel:setX(x);
    self.componentsPanel:setY(y);

    if self.maximumHeight>0 then
        self.componentsPanel.maximumHeight = self.maximumHeight - y - rh;
    else
        self.componentsPanel.maximumHeight = 0;
    end

    local preferredHeight = math.max(0, height - y - rh);
    self.componentsPanel:calculateLayout(width, preferredHeight);

    width = math.max(width, self.componentsPanel:getWidth());

    -- if needed recalculate entity header
    if self.entityHeader and width>self.entityHeader:getWidth() then
        self.entityHeader:calculateLayout(width, 0);
    end

    if self.entityDebug and width>self.entityDebug:getWidth() then
        self.entityDebug:calculateLayout(width, 0);
    end

    y = self.componentsPanel:getY() + self.componentsPanel:getHeight();

    height = math.max(height, y + rh);

    self:setWidth(width);
    self:setHeight(height);

    self.dirtyLayout = false;

    if self.pinButton then
        self.pinButton:setX(width - 3 - self.pinButton:getWidth())
    end
    if self.collapseButton then
        self.collapseButton:setX(width - 3 - self.collapseButton:getWidth())
    end
    --print("entitywindow w = "..tostring(self.minimumWidth)..", h = "..tostring(self.minimumHeight))
    --print("entitywindow w = "..tostring(width)..", h = "..tostring(height)..", resizable = "..tostring(self.resizable))
end

function ISEntityWindow:onResize(_width, _height)
    ISUIElement.onResize(self);
end

function ISEntityWindow:onCraftButtonClick(_button)
    if self.debugButton and _button==self.debugButton then
        if self.entity then
            ISEntityViewWindow.OnOpenPanel(self.entity);
        end
    end
end

function ISEntityWindow:onKeyRelease(key)
    if key == Keyboard.KEY_ESCAPE then
        self:close();
        return;
    end
end

function ISEntityWindow:update()
    if ISBaseEntityWindow.update(self) then
    end
end

function ISEntityWindow:render()
    ISBaseEntityWindow.render(self);

    if ISEntityUI.drawDebugLines or self.drawDebugLines then
        self:drawRectBorder(self.resizeWidget:getX(), self.resizeWidget:getY(), self.resizeWidget:getWidth(), self.resizeWidget:getHeight(), 1.0, 1, 0, 0);
        self:drawRectBorder(self.resizeWidget2:getX(), self.resizeWidget2:getY(), self.resizeWidget2:getWidth(), self.resizeWidget2:getHeight(), 1.0, 1, 1, 0);
    end
end

function ISEntityWindow:prerender()
    self:stayOnSplitScreen();
    ISBaseEntityWindow.prerender(self);
end

function ISEntityWindow:stayOnSplitScreen()
    ISUIElement.stayOnSplitScreen(self, self.playerNum)
end


function ISEntityWindow:refresh()
    --ISCraftingUI.refresh(self);
end

function ISEntityWindow:close()
    if self.componentsPanel then
        self.componentsPanel:OnCloseWindow();
        self:prerender();
    end
    
    ISBaseEntityWindow.close(self);
end

function ISEntityWindow:onGainJoypadFocus(joypadData)
    ISBaseEntityWindow.onGainJoypadFocus(self, joypadData)
    -- Pass focus to ISCraftBenchPanel, for example.
    local panelInfo = self.componentsPanel.panels[1]
    if panelInfo and panelInfo.panel then
        joypadData.focus = panelInfo.panel
        updateJoypadFocus(joypadData)
    end
end

function ISEntityWindow:onJoypadDown_Descendant(descendant, button, joypadData)
    if button == Joypad.BButton then
        self:close()
        self:removeFromUIManager();
    end
end

function ISEntityWindow:new (x, y, width, height, player, entity, entityConfig)
    local o = ISBaseEntityWindow:new(x, y, width, height, player, entity, entityConfig);
    setmetatable(o, self)
    self.__index = self;

    return o
end