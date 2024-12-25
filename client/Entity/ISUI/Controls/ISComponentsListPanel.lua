--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************
require "ISUI/ISPanel"

ISComponentsListPanel = ISPanel:derive("ISComponentsListPanel");

function ISComponentsListPanel:initialise()
	ISPanel.initialise(self);
end

function ISComponentsListPanel:createChildren()
    ISPanel.createChildren(self);

    self.container = ISPanel:new(0,0,1,1);
    self.container.background = self.background;
    self.container.backgroundColor = self.backgroundColor;
    self.container.borderColor = self.borderColor;
    self.container:initialise();
    self.container:instantiate();
    self.container:addScrollBars();
    self.container:setScrollChildren(true);
    self.container.doStencilRender = true;
    self.container.onMouseWheel = onMouseWheelScrollHandler;
    ISXuiSkin.RegisterXuiSkinFunctions(self.container, true);
    self:addChild(self.container);

    self.container.prerender = function(_self)
        if _self.doStencilRender then
            _self:setStencilRect(0,0,_self:getWidth(),_self:getHeight());
        end
        ISPanel.prerender(_self);
    end

    self.container.render = function(_self)
        ISPanel.render(_self);
        if _self.doStencilRender then
            _self:clearStencilRect();
        end
    end

    self.panels = ISEntityUI.GetComponentPanels(self.player, self.entity);

    for index,v in ipairs(self.panels) do
        self.container:addChild(v.panel);
    end

    self.scrollBarWidth = 17;
end

function ISComponentsListPanel:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(0, _preferredWidth or 0);
    local height = math.max(0, _preferredHeight or 0);

    local x,y = 0,0;
    local widestPanelWidth = 0;

    --print("components pref w = "..tostring(_preferredWidth)..", h = "..tostring(_preferredHeight)..", container = "..tostring(containerWidth))

    self.container:setX(self.margin);
    self.container:setY(self.margin);

    -- calculateLayout with (0,0) for all components to get minimum sizes.
    for index,v in ipairs(self.panels) do
        v.panel:setX(x);
        v.panel:setY(y);

        v.panel:calculateLayout(0, 0);

        widestPanelWidth = math.max(widestPanelWidth, v.panel:getWidth());

        y = v.panel:getY() + v.panel:getHeight();
        --height = height + v.panel:getHeight();
    end

    -- first handle the height:

    local containerHeight = math.max(y, height - (self.margin*2));

    if self.maximumHeight>0 and (containerHeight>self.maximumHeight - (self.margin*2)) then
        containerHeight = self.maximumHeight - (self.margin*2);
    end

    self.container:setHeight(containerHeight);
    self.container:setScrollHeight(y);
    self.container:updateScrollbars();

    height = self.container:getY() + self.container:getHeight() + self.margin;

    -- handle width, adjust width if were going to have scrollbar.

    local scrollBarMod = (y > containerHeight and self.scrollBarWidth) or 0;

    local panelWidth = width - (self.margin*2) - scrollBarMod;

    --print("panelw = "..tostring(panelWidth)..", widest = "..tostring(widestPanelWidth)..", s-mod = "..tostring(scrollBarMod))

    panelWidth = math.max(panelWidth, widestPanelWidth);

    --print(">>> Y = "..tostring(y)..", CONTAINER HEIGHT = "..tostring(containerHeight));
    for index,v in ipairs(self.panels) do
        if y<containerHeight and index==#self.panels then
            --if room left over this sizes the last panel to fit that space
            v.panel:calculateLayout(panelWidth, v.panel:getHeight() + (containerHeight-y));
            --print("panelW = "..tostring(panelWidth)..", actualW = "..tostring(v.panel:getWidth()))
        else
            v.panel:calculateLayout(panelWidth, 0);
        end
    end

    self.container:setWidth(panelWidth + scrollBarMod);

    width = self.container:getWidth() + (self.margin*2);

    self:setWidth(width);
    self:setHeight(height);
    --print("components w = "..tostring(width)..", h = "..tostring(height)..", y = "..tostring(y))
end

function ISComponentsListPanel:onResize()
    --ISUIElement.onResize(self)
    ISUIElement.onResize(self)
end

function ISComponentsListPanel:prerender()
    ISPanel.prerender(self);
end

function ISComponentsListPanel:render()
    ISPanel.render(self);

    if ISEntityUI.drawDebugLines or self.drawDebugLines then
        self:drawRectBorderStatic(0, 0, self.width, self.height, 1.0, 1, 0, 0);
    end
end

function ISComponentsListPanel:update()
    ISPanel.update(self);
end

--************************************************************************--
--** ISComponentsListPanel:new
--**
--************************************************************************--
function ISComponentsListPanel:new(x, y, width, height, player, entity, entityConfig)
	local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.player = player;
    o.entity = entity;
    o.entityConfig = entityConfig;

    o.background = true;

    o.minimumWidth = 0;
    o.minimumHeight = 0;
    o.maximumWidth = 0;
    o.maximumHeight = 0;

    o.padding = 0;
    o.margin = 5;

    return o
end