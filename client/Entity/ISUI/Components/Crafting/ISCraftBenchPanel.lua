--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

--[[
    Default panel for CraftBench component.

    uses ISHandCraftPanel
--]]

require "Entity/ISUI/Components/ISBaseComponentPanel";

ISCraftBenchPanel = ISBaseComponentPanel:derive("ISCraftBenchPanel");

function ISCraftBenchPanel.CanCreatePanelFor(_player, _entity, _component, _componentUiScript)
    if _player and _entity and _component then
        return _component:getComponentType()==ComponentType.CraftBench;
    end
end

--************************************************************************--
--** ISCraftBenchPanel:initialise
--**
--************************************************************************--

function ISCraftBenchPanel:initialise()
	ISBaseComponentPanel.initialise(self);
end

function ISCraftBenchPanel:createChildren()
    ISBaseComponentPanel.createChildren(self);

    self:createComponentHeader(self.xuiSkin, "S_WidgetComponentHeader_Std", false, nil, nil);

    self.handCraftPanel = ISXuiSkin.build(self.xuiSkin, nil, ISHandCraftPanel, 0, 0, 10, 10, self.player, self.component, self.entity);
    self.handCraftPanel:initialise();
    self.handCraftPanel:instantiate();
    self:addChild(self.handCraftPanel);
end

function ISCraftBenchPanel:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    local headerHeight = 0;
    if self.componentHeader then
        self.componentHeader:setX(0);
        self.componentHeader:setY(0);

        self.componentHeader:calculateLayout(0, 0);

        headerHeight = self.componentHeader:getHeight();

        width = math.max(width, self.componentHeader:getWidth());
    end

    --local x,y = 0,headerHeight;
    if self.handCraftPanel then
        self.handCraftPanel:setX(0);
        self.handCraftPanel:setY(headerHeight);
        self.handCraftPanel:calculateLayout(width, math.max(0, height-headerHeight));

        width = math.max(width, self.handCraftPanel:getWidth());
        height = math.max(height, self.handCraftPanel:getHeight()+headerHeight);

        if self.componentHeader then
            self.componentHeader:calculateLayout(width, 0);
        end
    end

    self:setWidth(width);
    self:setHeight(height);
end

function ISCraftBenchPanel:onResize()
    ISUIElement.onResize(self)
end

function ISCraftBenchPanel:prerender()
    ISBaseComponentPanel.prerender(self);
end

function ISCraftBenchPanel:render()
    ISBaseComponentPanel.render(self);

    if ISEntityUI.drawDebugLines or self.drawDebugLines then
        self:drawRectBorderStatic(0, 0, self.width, self.height, 1.0, 0, 1, 0);
    end
end

function ISCraftBenchPanel:update()
    ISBaseComponentPanel.update(self);
end


--************************************************************************--
--** ISCraftBenchPanel:new
--**
--************************************************************************--
function ISCraftBenchPanel:new(x, y, width, height, player, entity, component, componentUiStyle)
	local o = ISBaseComponentPanel:new(x, y, width, height, player, entity, component, componentUiStyle);
    setmetatable(o, self);
    self.__index = self;

    --o.recipeData = component:getPrimaryRecipeData();

    return o;
end