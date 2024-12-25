--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: RJ				   **
--***********************************************************

require "Entity/ISUI/Components/ISBaseComponentPanel";

ISButcherHookCraftPanel = ISBaseComponentPanel:derive("ISButcherHookCraftPanel");

function ISButcherHookCraftPanel.CanCreatePanelFor(_player, _entity, _component, _componentUiScript)
    if _player and _entity and _component then
        return _component:getComponentType()==ComponentType.CraftLogic;
    end
end

--************************************************************************--
--** ISButcherHookCraftPanel:initialise
--**
--************************************************************************--

function ISButcherHookCraftPanel:initialise()
	ISBaseComponentPanel.initialise(self);
end

function ISButcherHookCraftPanel:createChildren()
    ISBaseComponentPanel.createChildren(self);

    self:createComponentHeader(self.xuiSkin, "S_WidgetComponentHeader_Std", false, nil, nil);

    local processors = self.component:getCraftProcessors();
    if processors:size()>0 then
        local first = processors:get(0);
        self.processorPanel = ISXuiSkin.build(self.xuiSkin, nil, ISButcherHookProcessorPanel, 0, 0, 10, 10, self.player, self.entity, self.component, first);
        self.processorPanel:initialise();
        self.processorPanel:instantiate();

        self:addChild(self.processorPanel);
    end
end

function ISButcherHookCraftPanel:calculateLayout(_preferredWidth, _preferredHeight)
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
    if self.processorPanel then
        self.processorPanel:setX(0);
        self.processorPanel:setY(headerHeight);
        self.processorPanel:calculateLayout(width, math.max(0, height-headerHeight));

        width = math.max(width, self.processorPanel:getWidth());
        height = math.max(height, self.processorPanel:getHeight()+headerHeight);

        if self.componentHeader then
            self.componentHeader:calculateLayout(width, 0);
        end
    end

    self:setWidth(width);
    self:setHeight(height);
end

function ISButcherHookCraftPanel:onResize()
    ISUIElement.onResize(self)
end

function ISButcherHookCraftPanel:prerender()
    ISBaseComponentPanel.prerender(self);
end

function ISButcherHookCraftPanel:render()
    ISBaseComponentPanel.render(self);

    if ISEntityUI.drawDebugLines or self.drawDebugLines then
        self:drawRectBorderStatic(0, 0, self.width, self.height, 1.0, 0, 1, 0);
    end
end

function ISButcherHookCraftPanel:update()
    ISBaseComponentPanel.update(self);
end


--************************************************************************--
--** ISButcherHookCraftPanel:new
--**
--************************************************************************--
function ISButcherHookCraftPanel:new(x, y, width, height, player, entity, component, componentUiStyle)
	local o = ISBaseComponentPanel:new(x, y, width, height, player, entity, component, componentUiStyle);
    setmetatable(o, self);
    self.__index = self;

    --o.recipeData = component:getPrimaryRecipeData();

    return o;
end