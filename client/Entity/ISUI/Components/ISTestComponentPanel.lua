--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

--[[
    Test Dummy
--]]

require "Entity/ISUI/Components/ISBaseComponentPanel";

ISTestComponentPanel = ISBaseComponentPanel:derive("ISTestComponentPanel");

function ISTestComponentPanel.CanCreatePanelFor(_player, _entity, _component, _componentUiScript)
    if _player and _entity and _component then
        return _component:getComponentType()==ComponentType.TestComponent;
    end
end

--************************************************************************--
--** ISTestComponentPanel:initialise
--**
--************************************************************************--

function ISTestComponentPanel:initialise()
	ISBaseComponentPanel.initialise(self);
end

function ISTestComponentPanel:createChildren()
    ISBaseComponentPanel.createChildren(self);

    self:createComponentHeader(self.xuiSkin, "S_WidgetComponentHeader_Std", false, nil, nil);

    local titleStr = "Dummy Test Component";

    local fontHeight = -1; -- <=0 sets label initial height to font
    local style = nil; --self.styleLabel or "S_Label_ComponentHeaderTitle";
    self.title = ISXuiSkin.build(self.xuiSkin, style, ISLabel, 0, 0, fontHeight, titleStr, 1.0, 1.0, 1.0, 1, UIFont.Medium, true);
    self.title.origTitleStr = titleStr;
    self.title:initialise();
    self.title:instantiate();
    self:addChild(self.title);
end

function ISTestComponentPanel:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    local y = 0;
    if self.componentHeader then
        self.componentHeader:setX(0);
        self.componentHeader:setY(0);

        self.componentHeader:calculateLayout(0, 0);

        width = math.max(width, self.componentHeader:getWidth());
        height = math.max(height, self.componentHeader:getHeight());

        --self.componentHeader:calculateLayout(width, 0);

        y = self.componentHeader:getHeight();
    end

    width = math.max(width, self.title:getWidth() + (self.margin*2));
    height = math.max(height, y + self.title:getHeight() + (self.margin*2));

    self.title:setX((width/2) - (self.title:getWidth()/2));
    local y2 = ((height-y)/2) - (self.title:getHeight()/2);
    self.title:setY(y+y2);

    if self.componentHeader then
        self.componentHeader:calculateLayout(width, 0);
    end

    self:setWidth(width);
    self:setHeight(height);
end

function ISTestComponentPanel:onResize()
    ISUIElement.onResize(self)
end

function ISTestComponentPanel:prerender()
    ISBaseComponentPanel.prerender(self);
end

function ISTestComponentPanel:render()
    ISBaseComponentPanel.render(self);

    local y = 0;
    if self.componentHeader then
        y = self.componentHeader:getHeight();
    end

    self:drawRectBorderStatic(6, y+6, self.width-12, self.height-y-12, 1.0, 0.4, 0.4, 0.4);

    if ISEntityUI.drawDebugLines or self.drawDebugLines or false then
        self:drawRectBorderStatic(0, 0, self.width-1, self.height-1, 1.0, 0, 1, 0);
    end
end

function ISTestComponentPanel:update()
    ISBaseComponentPanel.update(self);
end


--************************************************************************--
--** ISTestComponentPanel:new
--**
--************************************************************************--
function ISTestComponentPanel:new(x, y, width, height, player, entity, component, componentUiStyle)
	local o = ISBaseComponentPanel:new(x, y, width, height, player, entity, component, componentUiStyle);
    setmetatable(o, self);
    self.__index = self;

    --o.minimumWidth = 500;
    --o.minimumHeight = 300;
    o.margin = 30;

    return o;
end