--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISUIElement"

IS9Patch = ISUIElement:derive("IS9Patch");

function IS9Patch:initialise()
	ISUIElement.initialise(self);
end

function IS9Patch:prerender()
    if self.drawOnPrerender then
        self:renderInternal();
    end
end

function IS9Patch:render()
    if not self.drawOnPrerender then
        self:renderInternal();
    end
end

function IS9Patch:renderInternal()
	if self.background then
		self:drawRectStatic(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
	end
    if self.border then
        self:drawRectBorderStatic(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    end

    local x,y,w,h = 0,0,1,1;
    if self.img and #self.img>=3 then
        w = self.colWidthLeft;
        h = #self.img==3 and self.height or self.rowHeightTop;
        self:drawTextureScaled(self.img[1], x, y, w, h,  1.0, 1, 1, 1);
        x = self.colWidthLeft;
        w = self.width - self.colWidthLeft - self.colWidthRight;
        self:drawTextureTiledX(self.img[2], x, y, w, h,  1.0, 1, 1, 1);
        x = x+w;
        w = self.colWidthLeft;
        self:drawTextureScaled(self.img[3], x, y, w, h,  1.0, 1, 1, 1);
    end

    if self.img and #self.img==9 then
        x = 0;
        y = self.rowHeightTop;
        w = self.colWidthLeft;
        h = self.height - self.rowHeightTop - self.rowHeightBot;
        self:drawTextureTiledY(self.img[4], x, y, w, h,  1.0, 1, 1, 1);
        x = self.colWidthLeft;
        w = self.width - self.colWidthLeft - self.colWidthRight;
        self:drawTextureTiled(self.img[5], x, y, w, h,  1.0, 1, 1, 1);
        x = x+w;
        w = self.colWidthLeft;
        self:drawTextureTiledY(self.img[6], x, y, w, h,  1.0, 1, 1, 1);

        x = 0;
        y = self.rowHeightTop + h;
        w = self.colWidthLeft;
        h = self.rowHeightBot;
        self:drawTextureScaled(self.img[7], x, y, w, h,  1.0, 1, 1, 1);
        x = self.colWidthLeft;
        w = self.width - self.colWidthLeft - self.colWidthRight;
        self:drawTextureTiledX(self.img[8], x, y, w, h,  1.0, 1, 1, 1);
        x = x+w;
        w = self.colWidthLeft;
        self:drawTextureScaled(self.img[9], x, y, w, h,  1.0, 1, 1, 1);
    end
end

-- Requires indexed lua table with images sorted as:
-- topleft, topCenter, topright, midleft, midCenter, midRight, botLeft, botCenter, botRight
-- can act as '3patch' if only first 3 images are supplied
function IS9Patch:new (x, y, width, height, _images)
    local o = ISUIElement:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.x = x;
    o.y = y;
    o.background = false;
    o.backgroundColor = {r=0, g=0, b=0, a=1.0};
    o.border = false;
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.width = width;
    o.height = height;
    o.anchorLeft = true;
    o.anchorRight = false;
    o.anchorTop = true;
    o.anchorBottom = false;
    o.img = _images or {};
    if #o.img>=3 then
        o.colWidthLeft = o.img[1]:getWidthOrig();
        o.colWidthRight = o.img[3]:getWidthOrig();
        o.rowHeightTop = o.img[1]:getHeightOrig();
    end
    if #o.img==9 then
        o.rowHeightBot = o.img[7]:getHeightOrig();
    end
    o.drawOnPrerender = true;
    return o;
end