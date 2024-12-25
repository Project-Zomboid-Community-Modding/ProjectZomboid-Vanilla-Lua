--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISUIElement"

ISProgressBar = ISUIElement:derive("ISProgressBar");

function ISProgressBar:initialise()
	ISUIElement.initialise(self);

end

function ISProgressBar:noBackground()
	self.background = false;
end

function ISProgressBar:setProgress(_p)
	self.progress = PZMath.clamp_01(_p);
end

function ISProgressBar:setText(_text)
    if (not self.text) or self.text~=_text then
        self.text = _text;

        if self.text then
            self.textW = getTextManager():MeasureStringX(self.font, self.text);
            self.textH = getTextManager():getFontFromEnum(self.font):getLineHeight();
        end
    end
end

function ISProgressBar:prerender()
    local c;
	if self.background then
        c = self.backgroundColor;
		self:drawRectStatic(0, 0, self.width, self.height, c.a, c.r, c.g, c.b);
		c = self.borderColor;
        self:drawRectBorderStatic(0, 0, self.width, self.height, c.a, c.r, c.g, c.b);
	end
    if self.progress > 0 then
        c = self.progressColor;
        if self.isVertical then
            local ih = self.height - self.paddingTop - self.paddingBottom;
            local h = ih*self.progress;
            if self:getRenderTexture() then
                self:renderTexture(self.paddingLeft, self.paddingTop, self.width - self.paddingLeft - self.paddingRight, self.height - self.paddingTop - self.paddingBottom, true);
            else
                self:drawRectStatic(self.paddingLeft, self.paddingTop + (ih-h), self.width - self.paddingLeft - self.paddingRight, h, c.a, c.r, c.g, c.b);
            end
        else
            local w = self.width - self.paddingLeft - self.paddingRight;
            if self:getRenderTexture() then
                self:renderTexture(self.paddingLeft, self.paddingTop, self.width - self.paddingLeft - self.paddingRight, self.height - self.paddingTop - self.paddingBottom, false);
            else
                self:drawRectStatic(self.paddingLeft, self.paddingTop, w*self.progress, self.height - self.paddingTop - self.paddingBottom, c.a, c.r, c.g, c.b);
            end
        end
    end
    if self.text then
        local x = (self.width/2) - (self.textW/2);
        local y = (self.height/2) - (self.textH/2);

        if self.doTextBackdrop then
            c = self.textBackColor;
            self:drawText(self.text, x-1, y-1, c.r, c.g, c.b, c.a, self.font);
            self:drawText(self.text, x+1, y-1, c.r, c.g, c.b, c.a, self.font);
            self:drawText(self.text, x+1, y+1, c.r, c.g, c.b, c.a, self.font);
            self:drawText(self.text, x-1, y+1, c.r, c.g, c.b, c.a, self.font);
        end

        c = self.textColor;
        self:drawText(self.text, x, y, c.r, c.g, c.b, c.a, self.font);
    end
end

function ISProgressBar:getRenderTexture()
    if self.doRenderTexture then
        if self.isVertical then
            return self.verticalTexture;
        else
            return self.horizontalTexture;
        end
    end
end

function ISProgressBar:renderTexture(_x, _y, _w, _h, _vertical)
    if self:getRenderTexture() and self.progress>0 then
        if self.javaObject ~= nil then
            if _vertical then
                self.javaObject:DrawTexturePercentageBottomUp(self:getRenderTexture(), self.progress, _x, _y, _w, _h, 1, 1, 1, 1.0);
            else
                self.javaObject:DrawTexturePercentage(self:getRenderTexture(), self.progress, _x, _y, _w, _h, 1, 1, 1, 1.0);
            end
        end
    end
end

function ISProgressBar:new (x, y, width, height, text, font)
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
    o.textColor = {r=1.0, g=1.0, b=1.0, a=1};
    o.textBackColor = {r=0.0, g=0.0, b=0.0, a=1};
    o.width = width;
	o.height = height;
	o.anchorLeft = true;
	o.anchorRight = false;
	o.anchorTop = true;
	o.anchorBottom = false;
    o.moveWithMouse = false;
    o.font = font or UIFont.Small;
    o.progress = 0;
    o.isVertical = false; --if true will draw progress vertically from bottom up
    o.doRenderTexture = false;
    o.horizontalTexture = getTexture("media/ui/Entity/bar_efficiency_horz.png");
    o.verticalTexture = getTexture("media/ui/Entity/bar_efficiency_vert.png");
    o.doTextBackdrop = true;
    --o.padding = 2;
    o.paddingTop = 2;
    o.paddingBottom = 2;
    o.paddingLeft = 2;
    o.paddingRight = 2;
    o:setText(text);
   return o
end
