--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************
require "ISUI/ISPanel"

ISGroupBox = ISPanel:derive("ISGroupBox");

function ISGroupBox:initialise()
	ISPanel.initialise(self);
end

function ISGroupBox:createChildren()
    ISPanel.createChildren(self);

    if self.title then
        local fontHeight = -1; -- <=0 sets label initial height to font
        self.borderLabel = ISXuiSkin.build(self.xuiSkin, self.styleLabel, ISLabel, 0, 0, fontHeight, self.title, 1.0, 1.0, 1.0, 1, UIFont.Small, true)
        --self.borderLabel.center = true;
        self.borderLabel.textColor = self.textColor;
        self.borderLabel:initialise();
        self.borderLabel:instantiate();
        --self:addChild(self.borderLabel);
        ISUIElement.addChild(self, self.borderLabel);
    end

    self.marginBorder = self.margin * 0.5;
end

function ISGroupBox:setElement(_element)
    if self.element then
        self:removeChild(self.element);
    end
    ISUIElement.addChild(self, _element);
    self.element = _element;
end

function ISGroupBox:addChild(_element)
    print("ISGroupBox -> addChild not allowed, use setElement...")
end

function ISGroupBox:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    if self.borderLabel and self.margin<self.borderLabel:getHeight()+4 then
        self.margin = self.borderLabel:getHeight()+4;
    end

    self.marginBorder = self.margin * 0.5;

    local margin2x = self.margin * 2;

    if self.borderLabel then
        width = math.max(width, self.borderLabel:getWidth() + (self.marginBorder*6))
    end

    if self.element then
        if self.element.calculateLayout then
            self.element:calculateLayout(math.max(0, width-margin2x), math.max(0, height-margin2x));
        end
        --self.element:setX(self.margin);
        --self.element:setY(self.margin);
        width = math.max(width, self.element:getWidth()+margin2x);
        height = math.max(height, self.element:getHeight()+margin2x);

        self.element:setX((width/2) - (self.element:getWidth()/2));
        self.element:setY((height/2) - (self.element:getHeight()/2));
    else
        width = math.max(width, margin2x);
        height = math.max(height, margin2x);
    end

    if self.borderLabel then
        self.borderLabel:setX((width/2) - (self.borderLabel:getWidth()/2));
        self.borderLabel:setY(self.marginBorder - (self.borderLabel:getHeight()/2));
    end

    self:setWidth(width);
    self:setHeight(height);
end

function ISGroupBox:onResize()
    --ISUIElement.onResize(self)
    ISUIElement.onResize(self)
end

function ISGroupBox:prerender()
    --ISPanel.prerender(self);

    local x, y = self.marginBorder, self.marginBorder;
    local w, h = self.width-(self.marginBorder*2), self.height - (self.marginBorder*2);
    local c = self.backgroundColor;
    if self.background then
        self:drawRectStatic(x, y, w, h, c.a, c.r, c.g, c.b);
    end

    if self.drawBorder then
        c = self.borderColor;
        if self.borderLabel then
            -- top, avoids drawing over title if set
            local w1 = self.borderLabel:getX()-(self.marginBorder*2);
            self.javaObject:DrawTextureScaledColor(nil, x, y, w1, 1, c.r, c.g, c.b, c.a);
            local x1 = self.borderLabel:getX()+self.borderLabel:getWidth()+self.marginBorder;
            local w2 = w-x1+self.marginBorder;
            self.javaObject:DrawTextureScaledColor(nil, x1, y, w2, 1, c.r, c.g, c.b, c.a);

            -- sides
            self.javaObject:DrawTextureScaledColor(nil, x, y, 1, h, c.r, c.g, c.b, c.a);
            self.javaObject:DrawTextureScaledColor(nil, x+w, y, 1, h, c.r, c.g, c.b, c.a);

            -- bottom
            self.javaObject:DrawTextureScaledColor(nil, x, y+h, w, 1, c.r, c.g, c.b, c.a);
        else
            self:drawRectBorderStatic(x, y, w, h, c.a, c.r, c.g, c.b);
        end
    end
end

function ISGroupBox:render()
    ISPanel.render(self);

    if ISEntityUI.drawDebugLines or self.drawDebugLines then
        self:drawRectBorderStatic(0, 0, self.width, self.height, 1.0, 1, 0, 0);
    end
end

function ISGroupBox:update()
    ISPanel.update(self);
end

--************************************************************************--
--** ISGroupBox:new
--**
--************************************************************************--
function ISGroupBox:new (x, y, width, height, _styleLabel)
	local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self

    o.styleLabel = _styleLabel;

    o.element = nil;

    o.margin = 24;
    o.title = "group"; --can be set false.
    o.background = false;
    o.drawBorder = true;
    o.textColor = {1,1,1,1};

    o.minimumWidth = 0;
    o.minimumHeight = 0;

    o.autoFillContents = false;

    -- these may or may not be used by a parent control while calculating layout:
    o.isAutoFill = false;
    o.isAutoFillX = false;
    o.isAutoFillY = false;

    return o
end