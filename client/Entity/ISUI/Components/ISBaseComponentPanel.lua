--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************
require "ISUI/ISPanel"

ISBaseComponentPanel = ISPanel:derive("ISBaseComponentPanel");

function ISBaseComponentPanel.CanCreatePanelFor(_player, _entity, _component, _componentUiStyle)
    if _player and _entity and _component then
        return true;
    end
end

--************************************************************************--
--** ISBaseComponentPanel:initialise
--**
--************************************************************************--

function ISBaseComponentPanel:initialise()
	ISPanel.initialise(self);
end

function ISBaseComponentPanel:createChildren()
    ISPanel.createChildren(self);
end

function ISBaseComponentPanel:createComponentHeader(_xuiSkin, _styleName, _force, _styleIcon, _styleLabel)
    if self.enableHeader or _force then
        self.componentHeader = ISXuiSkin.build(_xuiSkin, _styleName, ISWidgetComponentHeader, 0, 0, 200, 20, self.player, self.entity, self.component, self.componentUiStyle, _styleIcon, _styleLabel);
        self.componentHeader:initialise();
        self.componentHeader:instantiate();
        self:addChild(self.componentHeader);
    end
end

function ISBaseComponentPanel:removeComponentHeader()
    if self.enableHeader and self.componentHeader then
        self:removeChild(self.componentHeader);
        self.componentHeader = nil;
    end
end

function ISBaseComponentPanel:calculateLayout(_preferredWidth, _preferredHeight)
    print("ISBaseComponentPanel.calculateLayout not overridden.");
end

function ISBaseComponentPanel:onResize()
    ISUIElement.onResize(self)
end

function ISBaseComponentPanel:prerender()
    ISPanel.prerender(self);
end

function ISBaseComponentPanel:render()
    ISPanel.render(self);
end

function ISBaseComponentPanel:update()
    ISPanel.update(self);
end

function ISBaseComponentPanel:getUiOrderZ()
    if self.componentUiStyle then
        return self.componentUiStyle:getListOrderZ();
    end
    return 0;
end

function ISBaseComponentPanel:getUiDisplayName()
    if self.componentUiStyle and self.componentUiStyle:getDisplayName() then
        return self.componentUiStyle:getDisplayName();
    end
    if self.component then
        return self.component:getComponentType():toString();
    end
    return "?Component?";
end

function ISBaseComponentPanel:getUiIcon()
    if self.componentUiStyle and self.componentUiStyle:getIcon() then
        return self.componentUiStyle:getIcon();
    end
    return nil;
end


--************************************************************************--
--** ISBaseComponentPanel:new
--**
--************************************************************************--
--[[
function ISBaseComponentPanel:new(x, y, width, height, player, entity, component, componentUiStyle)
	local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.background = false;
    --o.margin = 5;
    o.player = player;
    o.entity = entity;
    o.component = component;
    o.componentUiStyle = componentUiStyle;
    o.minimumWidth = 0;
    o.minimumHeight = 0;

    o.enableHeader = true;
    return o
end
--]]

--[[ TEMP HACK, See ISRecipeLogicPanel.lua --]]

function ISBaseComponentPanel:new (x, y, width, height, player, entity, component, componentUiStyle)
    local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    --o:setBucket(true);
    return ISBaseComponentPanel.table_constructor(o, x, y, width, height, player, entity, component, componentUiStyle);
end

function ISBaseComponentPanel.table_constructor(o, x, y, width, height, player, entity, component, componentUiStyle)
    o.background = false;
    --o.margin = 5;
    o.player = player;
    o.entity = entity;
    o.component = component;
    o.componentUiStyle = componentUiStyle;
    o.minimumWidth = 0;
    o.minimumHeight = 0;

    o.enableHeader = true;
    return o
end