--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISPanel"

ISVendorSpiral = ISPanel:derive("ISVendorSpiral");


function ISVendorSpiral:initialise()
	ISPanel.initialise(self);
end

function ISVendorSpiral:prerender()
end

function ISVendorSpiral:render()
    if self.renderTarget then
        self:renderToTarget(self.renderTarget);
    end
end

function ISVendorSpiral:renderToTarget(_target)
    if self.texture then
        _target:DrawTextureAngle(self.texture, self:getX() + (self:getWidth()/2), self:getY()+(self:getHeight()/2), self.rotation)
    end
end

function ISVendorSpiral:setRotation(_rot)
    if _rot>=0 and _rot<=360 then
        self.rotation = _rot;
    end
end

--************************************************************************--
--** ISPanel:new
--**
--************************************************************************--
function ISVendorSpiral:new (x, y, width, height, texture)
	local o = {}
	--o.data = {}
	o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
	o.x = x;
	o.y = y;
	o.background = false;
	o.backgroundColor = {r=0, g=0, b=0, a=0.0};
    o.borderColor = {r=0.0, g=0.0, b=0.0, a=0};
    o.width = width;
	o.height = height;
	o.anchorLeft = true;
	o.anchorRight = false;
	o.anchorTop = true;
	o.anchorBottom = false;
    o.moveWithMouse = false;

    o.texture = texture;
    o.rotation = 0;
    o.renderTarget = false;
   return o
end

