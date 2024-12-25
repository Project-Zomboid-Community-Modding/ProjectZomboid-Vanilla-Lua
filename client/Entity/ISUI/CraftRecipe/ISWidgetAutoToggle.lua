--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************
require "ISUI/ISPanel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small);

ISWidgetAutoToggle = ISPanel:derive("ISWidgetAutoToggle");
--ISWidgetAutoToggle.defWidth = 50;
--ISWidgetAutoToggle.defHeight = 12;

function ISWidgetAutoToggle:initialise()
	ISPanel.initialise(self);
end

function ISWidgetAutoToggle:createChildren()
    ISPanel.createChildren(self);
end

function ISWidgetAutoToggle:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    self:setWidth(width);
    self:setHeight(height);
end

function ISWidgetAutoToggle:onResize()
    --ISUIElement.onResize(self)
    ISUIElement.onResize(self)
end

function ISWidgetAutoToggle:prerender()
    ISPanel.prerender(self);

    local tex;
    if self.toggleState then
        tex = self.hover and self.textureOnOver or self.textureOn;
    else
        tex = self.hover and self.textureOffOver or self.textureOff;
    end

    self:drawTextureScaledAspect(tex, 0, 0, self.width, self.height, 1.0, 1, 1, 1);
end

function ISWidgetAutoToggle:render()
    ISPanel.render(self);
end

function ISWidgetAutoToggle:update()
    ISPanel.update(self);
end

function ISWidgetAutoToggle:onMouseDown(x, y)
    getSoundManager():playUISound("UISelectListItem");
    self.toggleState = not self.toggleState;

    if self.target and self.onToggled then
        self.onToggled(self.target, self.toggleState);
    end
end

function ISWidgetAutoToggle:onMouseUp(x, y)

end

function ISWidgetAutoToggle:onMouseMove(dx, dy)
    self.hover = true;
end

function ISWidgetAutoToggle:onMouseMoveOutside(x, y)
    self.hover = false;
end

--************************************************************************--
--** ISWidgetAutoToggle:new
--** default image is 50x12 pix
--************************************************************************--
function ISWidgetAutoToggle:new (x, y, width, height, doSmall, target, onToggled)
    if width==nil then
        if doSmall then
            width = 28;
        else
            width = 50;
        end
    end
    if height==nil then
        if doSmall then
            height = 12;
        else
            height = 12;
        end
    end
	local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self

    o.background = false;

    o.toggleState = false;
    if doSmall then
        o.textureOn = getTexture("media/ui/Entity/widget_toggle_on.png");
        o.textureOff = getTexture("media/ui/Entity/widget_toggle_off.png");
        o.textureOnOver = getTexture("media/ui/Entity/widget_toggle_on_over.png");
        o.textureOffOver = getTexture("media/ui/Entity/widget_toggle_off_over.png");
    else
        o.textureOn = getTexture("media/ui/Entity/widget_auto_toggle_on.png");
        o.textureOff = getTexture("media/ui/Entity/widget_auto_toggle_off.png");
        o.textureOnOver = getTexture("media/ui/Entity/widget_auto_toggle_on_over.png");
        o.textureOffOver = getTexture("media/ui/Entity/widget_auto_toggle_off_over.png");
    end

    o.target = target;
    o.onToggled = onToggled;

    o.margin = 5;
    o.minimumWidth = width;
    o.minimumHeight = height;

    o.doToolTip = true;

    o.autoFillContents = false;

    -- these may or may not be used by a parent control while calculating layout:
    o.isAutoFill = false;
    o.isAutoFillX = false;
    o.isAutoFillY = false;

    return o
end