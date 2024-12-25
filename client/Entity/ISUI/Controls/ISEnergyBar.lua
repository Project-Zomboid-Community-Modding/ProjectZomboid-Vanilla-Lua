--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISUIElement"

ISEnergyBar = ISUIElement:derive("ISEnergyBar");

function ISEnergyBar:initialise()
	ISUIElement.initialise(self);
end

function ISEnergyBar:noBackground()
	self.background = false;
end

function ISEnergyBar:prerender()
    if self.toolTip and not self:isMouseOver() then
        self:deactivateToolTip();
    end

    local c;
	if self.background then
        c = self.backgroundColor;
		self:drawRectStatic(0, 0, self.width, self.height, c.a, c.r, c.g, c.b);
		c = self.borderColor;
        self:drawRectBorderStatic(0, 0, self.width, self.height, c.a, c.r, c.g, c.b);
	end
    if self.resource and self.resource:getEnergyRatio() > 0 then
        local ratio = self.resource:getEnergyRatio();
        c = self.progressColor;
        local pad2 = self.padding*2;
        if self.isVertical then
            local ih = self.height - pad2;
            local h = ih*ratio;
            if self:getRenderTexture() then
                self:renderTexture(self.padding, self.padding, self.width - pad2, self.height - pad2, true);
            else
                self:drawRectStatic(self.padding, self.padding + (ih-h), self.width - pad2, h, c.a, c.r, c.g, c.b);
            end
        else
            local w = self.width - pad2;
            if self:getRenderTexture() then
                self:renderTexture(self.padding, self.padding, self.width - pad2, self.height-pad2, false);
            else
                self:drawRectStatic(self.padding, self.padding, w*ratio, self.height-pad2, c.a, c.r, c.g, c.b);
            end
        end
    end
end

function ISEnergyBar:getRenderTexture()
    if self.doRenderTexture then
        if self.isVertical then
            return self.verticalTexture;
        else
            return self.horizontalTexture;
        end
    end
end

function ISEnergyBar:renderTexture(_x, _y, _w, _h, _vertical)
    if self:getRenderTexture() and self.resource:getEnergyRatio()>0 then
        local ratio = self.resource:getEnergyRatio();
        if self.javaObject ~= nil then
            if _vertical then
                self.javaObject:DrawTexturePercentageBottomUp(self:getRenderTexture(), ratio, _x, _y, _w, _h, 1, 1, 1, 1.0);
            else
                self.javaObject:DrawTexturePercentage(self:getRenderTexture(), ratio, _x, _y, _w, _h, 1, 1, 1, 1.0);
            end
        end
    end
end

function ISEnergyBar:onMouseMove(dx, dy)
    if self:isMouseOver() then
        self:activateToolTip();
    else
        self:deactivateToolTip();
    end
end

function ISEnergyBar:onMouseMoveOutside(dx, dy)
    self:deactivateToolTip();
end

function ISEnergyBar:activateToolTip()
    if self.doToolTip then
        if self.toolTip ~= nil then
            self.toolTip:setVisible(true);
            self.toolTip:addToUIManager();
            self.toolTip:bringToTop()
        else
            self.toolTip = ISToolTipInv:new(self.resource);
            self.toolTip:initialise();
            self.toolTip:setVisible(true);
            self.toolTip:addToUIManager();
            self.toolTip:setOwner(self);
            self.toolTip:setCharacter(self.player);
            --self.toolTip:doLayout();
        end
    end
end

function ISEnergyBar:deactivateToolTip()
    if self.toolTip then
        self.toolTip:removeFromUIManager();
        self.toolTip:setVisible(false);
        self.toolTip = nil;
    end
end

function ISEnergyBar:new (x, y, width, height, player, resource)
	local o = {}
	--o.data = {}
	o = ISUIElement:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
	o.x = x;
	o.y = y;
	o.background = true;
	o.backgroundColor = {r=0, g=0, b=0, a=1.0};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.progressColor = {r=0.2, g=1.0, b=0.2, a=1};
    o.width = width;
	o.height = height;
	o.anchorLeft = true;
	o.anchorRight = false;
	o.anchorTop = true;
	o.anchorBottom = false;
    o.moveWithMouse = false;
    o.isVertical = false; --if true will draw progress vertically from bottom up
    o.padding = 2;
    o.doToolTip = true;
    o.player = player;
    o.resource = resource;
    o.doRenderTexture = true;
    o.horizontalTexture = resource:getEnergy():getHorizontalBarTexture();
    o.verticalTexture = resource:getEnergy():getVerticalBarTexture();
   return o
end
