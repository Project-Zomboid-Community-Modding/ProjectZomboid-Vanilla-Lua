--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************
require "ISUI/ISPanel"

ISWidgetComponentHeader = ISPanel:derive("ISWidgetComponentHeader");

function ISWidgetComponentHeader:initialise()
	ISPanel.initialise(self);
end

function ISWidgetComponentHeader:createChildren()
    ISPanel.createChildren(self);

    if self.enableIcon then
        local iconTex = self.componentUiStyle and self.componentUiStyle:getIcon();
        local style = self.styleIcon or "S_Image_ComponentHeaderIcon";
        self.icon = ISXuiSkin.build(self.xuiSkin, style, ISImage, 0, 0, self.iconSize, self.iconSize, iconTex);
        self.icon:initialise();
        self.icon:instantiate();
        self:addChild(self.icon);
        self.iconSize = self.icon:getHeight();
    else
        self.iconSize = 24;
    end

    local titleStr = self.componentUiStyle and self.componentUiStyle:getDisplayName() or "";

    --self.title = ISLabel:new(0, 0, FONT_HGT_SMALL, titleStr, 1.0, 1.0, 1.0, 1, UIFont.Small, true);
    local fontHeight = -1; -- <=0 sets label initial height to font
    local style = self.styleLabel or "S_Label_ComponentHeaderTitle";
    self.title = ISXuiSkin.build(self.xuiSkin, style, ISLabel, 0, 0, fontHeight, titleStr, 1.0, 1.0, 1.0, 1, UIFont.Small, true);
    self.title.origTitleStr = titleStr;
    self.title:initialise();
    self.title:instantiate();
    self:addChild(self.title);
end

function ISWidgetComponentHeader:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    local requiredWidth = 0;
    if self.icon then
        requiredWidth = self.icon:getWidth() + (self.margin*2);
    end

    requiredWidth = requiredWidth + self.title:getWidth();

    width = math.max(width, requiredWidth + (self.padding*2) + (self.margin*2));

    if self.icon then
        height = math.max(height, self.icon:getHeight() + (self.padding*2) + (self.margin*2));
    end

    height = math.max(height, self.title:getHeight() + (self.padding*2) + (self.margin*2));

    local x = (width/2) - (requiredWidth/2);
    local y = self.padding + self.margin;

    if self.icon then
        self.icon:setX(x);
        self.icon:setY((height/2)-(self.icon:getHeight()/2));

        x = self.icon:getX() + self.icon:getWidth() + (self.margin*2);
    end

    self.title:setX(x);
    self.title:setY((height/2) - (self.title:getHeight()/2));

    self:setWidth(width);
    self:setHeight(height);
end

function ISWidgetComponentHeader:onResize()
    ISUIElement.onResize(self)
end

function ISWidgetComponentHeader:prerender()
    --ISPanel.prerender(self);

	if self.background then
		self:drawRectStatic(self.margin, self.margin, self.width - (self.margin*2), self.height - (self.margin*2), self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
        if self.textureBackground then
            self:drawTextureScaled(self.textureBackground, self.margin, self.margin, self.width - (self.margin*2), self.height - (self.margin*2),  1.0, 1, 1, 1);
        end
		self:drawRectBorderStatic(self.margin, self.margin, self.width - (self.margin*2), self.height - (self.margin*2), self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
	end
end

function ISWidgetComponentHeader:render()
    ISPanel.render(self);

    if ISEntityUI.drawDebugLines or self.drawDebugLines then
        self:drawRectBorderStatic(0, 0, self.width, self.height, 1.0, 1, 0.5, 0);
    end
end

function ISWidgetComponentHeader:update()
    ISPanel.update(self);
end

--************************************************************************--
--** ISWidgetComponentHeader:new
--**
--************************************************************************--
function ISWidgetComponentHeader:new (x, y, width, height, player, entity, component, componentUiStyle, _styleIcon, _styleLabel)
	local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.player = player;
    o.entity = entity;
    --o.entityConfig = entityConfig;
    o.component = component;
    o.componentUiStyle = componentUiStyle;

    o.styleIcon = _styleIcon;
    o.styleLabel = _styleLabel;

    o.padding = 3;
    o.margin = 5;
    o.enableIcon = true;
    --o.iconSize = 24;

    o.textureBackground = nil; --getTexture("media/ui/Panel_TitleBar.png");

    return o
end