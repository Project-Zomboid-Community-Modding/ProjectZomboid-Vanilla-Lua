--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

--[[
    Displays FluidContainer contents as bar.
    Optionally can display amounts being removed or added.
--]]

require "ISUI/ISPanel"

ISFluidBar = ISPanel:derive("ISFluidBar");

function ISFluidBar:initialise()
    ISPanel.initialise(self)
end

function ISFluidBar:createChildren()
end

function ISFluidBar:prerender()
    ISPanel.prerender(self);
end

function ISFluidBar:getRatioY(_ratio)
    local h = PZMath.ceil(self.innerH * _ratio);
    local y = self.innerH - h;
    return self.innerY + y, h;
end

function ISFluidBar:render()
    ISPanel.render(self);

    if self.container then
        local amount = self.container:getAmount();
        local capacity = self.container:getCapacity();
        local ratioOrig = amount/capacity;
        if ratioOrig~=self.ratioOrig then
            self.ratioOrig = ratioOrig;
            self.ratioNew = self.ratioOrig;
        end
    end

    local c;
    -- Base backdrop.
    self:drawRect(0, 0, self.width, self.height, 1.0, 0, 0, 0);
    self:drawTextureScaled(self.gradientTex, 0, 0, self.width, self.height, self.gradientAlpha, 1, 1, 1);

    self.innerX = 2;
    self.innerY = 2;
    self.innerW = self.width-4;
    self.innerH = self.height-4;

    if self.ratioNew>0 or self.ratioOrig>0 then
        --draw fluids
        local isRemoved = self.ratioOrig>self.ratioNew; --self.ratioNew<self.ratioOrig;
        local y, h = self:getRatioY(isRemoved and self.ratioNew or self.ratioOrig);

        --c = self.fluidColor;
        --self:drawRect(self.innerX, y, self.innerW, h, 1.0, c.r, c.g, c.b);
        if self.ratioOrig==self.ratioNew then
            --no change
            if self.container then
                local y, h = self:getRatioY(self.ratioOrig);
                c = self.container:getColor();
                self:drawRect(self.innerX, y, self.innerW, h, 1.0, c:getRedFloat(), c:getGreenFloat(), c:getBlueFloat());
                self:drawBubbles(self.innerX, y, self.innerW, h, 1.0);
            end
        elseif self.ratioOrig>self.ratioNew then
            --fluid removed
            if self.container then
                local y, h = self:getRatioY(self.ratioNew);
                local y2, h2 = self:getRatioY(self.ratioOrig);

                --transparent removed
                c = self.container:getColor();
                self:drawRect(self.innerX, y2, self.innerW, h2-h, self.differenceAlpha, c:getRedFloat(), c:getGreenFloat(), c:getBlueFloat());
                self:drawBubbles(self.innerX, y2, self.innerW, h2-h, self.differenceAlpha);

                --opaque current
                c = self.container:getColor();
                self:drawRect(self.innerX, y, self.innerW, h, 1.0, c:getRedFloat(), c:getGreenFloat(), c:getBlueFloat());
                self:drawBubbles(self.innerX, y, self.innerW, h, 1.0);
            end
        else
            --fluid added
            if self.container then
                local y, h = self:getRatioY(self.ratioOrig);
                local y2, h2 = self:getRatioY(self.ratioNew);

                --transparent added
                c = self.containerAdd and self.containerAdd:getColor() or self.container:getColor();
                self:drawRect(self.innerX, y2, self.innerW, h2-h, self.differenceAlpha, c:getRedFloat(), c:getGreenFloat(), c:getBlueFloat());
                self:drawBubbles(self.innerX, y2, self.innerW, h2-h, self.differenceAlpha);

                --opaque current
                c = self.container:getColor();
                self:drawRect(self.innerX, y, self.innerW, h, 1.0, c:getRedFloat(), c:getGreenFloat(), c:getBlueFloat());
                self:drawBubbles(self.innerX, y, self.innerW, h, 1.0);

                if (not isRemoved) and self.showMixed and self.containerMixed then
                    local y, h = self:getRatioY(self.ratioNew);
                    --self:drawRect(self.innerX+(self.innerW/2)-1, y, 2, h, 1.0, 0, 0, 0);
                    local c = self.containerMixed:getColor();
                    self:drawRect(self.innerX+(self.innerW/2), y, self.innerW/2, h, 1.0, c:getRedFloat(), c:getGreenFloat(), c:getBlueFloat());
                end
            end
        end
    end

    -- draw overlaying ui parts
    c = self.detailInnerColor;
    self:drawRectBorder(1, 1, self.width-2, self.height-2, c.a, c.r, c.g, c.b);
    c = self.borderColor;
    self:drawRectBorder(0, 0, self.width, self.height, c.a, c.r, c.g, c.b);

    if self.ratioOrig>0 and self.ratioOrig<1.0 then
        local y, _ = self:getRatioY(self.ratioOrig);
        self:drawAmountLine(y);
    end
    if self.ratioNew~=self.ratioOrig then
        local y, _ = self:getRatioY(self.ratioNew);
        self:drawAmountLine(y);
    end
end

function ISFluidBar:drawBubbles(_x,_y,_w,_h, _alpha)
    if self.bubblesTex then
        self:drawTextureTiledYOffset(self.bubblesTex, _x, _y, _w, _h, 1.0, 1.0, 1.0, self.bubblesAlpha * _alpha)
    end
end

function ISFluidBar:drawAmountLine(_y)
    local c = self.detailInnerColor;
    self:drawTriangle(self.triangleWidth+1, 1, _y, c, 1);
    self:drawTriangle(self.triangleWidth+1, self.width-1, _y, c, -1);

    c = self.borderColor;
    self:drawTriangle(self.triangleWidth, 1, _y, c, 1);
    self:drawTriangle(self.triangleWidth, self.width-1, _y, c, -1);

    self:drawRect(1, _y, self.width-2, 1, c.a, c.r, c.g, c.b);
end

--draws the triangle parts on the sides of amount lines
function ISFluidBar:drawTriangle(_size, _sx, _y, _col, _xmod)
    local minY = self.innerY;
    local maxY = self.innerY + self.innerH;

    for i=0,_size-1 do
        local sy = _y - (_size - i);
        local ey = _y + (_size - i);
        sy = PZMath.clamp(sy, minY, maxY);
        ey = PZMath.clamp(ey, minY, maxY);

        local len = ey-sy;
        self:drawRect(_sx, sy, 1, len, _col.a, _col.r, _col.g, _col.b);
        _sx = _sx + _xmod;
    end
end

-- the main FluidContainer for this bar
function ISFluidBar:setContainer(_fluidContainer)
    self.container = _fluidContainer;
    if self.container then
        local amount = self.container:getAmount();
        local capacity = self.container:getCapacity();
        self.ratioOrig = amount/capacity;
    else
        self.ratioOrig = 0;
    end
    self.ratioNew = self.ratioOrig;
end

-- if supplied this FluidContainer will be used to color the "adding" part in the bar.
-- if not supplied, defaults to using self.container.
function ISFluidBar:setContainerAdd(_fluidContainer)
    self.containerAdd = _fluidContainer;
end

-- supply a temporary container with the mix of self.container and the added amount
-- if supplied will use containerMixed for toolTip, if _showMixed == true will also color the bar using containerMixed
function ISFluidBar:setContainerMixed(_fluidContainer, _showMixed)
    self.containerMixed = _fluidContainer;
    self.showMixed = self.containerMixed and _showMixed or false;
end

function ISFluidBar:setRatioNew(_ratio)
    self.ratioNew = _ratio;
end

function ISFluidBar:resetRatioNew()
    self.ratioNew = self.ratioOrig;
end

function ISFluidBar:prerender()
    if self.toolTip and not self:isMouseOver() then
        self:deactivateToolTip();
    end
end

function ISFluidBar:onMouseMove(dx, dy)
    if self:isMouseOver() then
        self:activateToolTip();
    else
        self:deactivateToolTip();
    end
end

function ISFluidBar:onMouseMoveOutside(dx, dy)
    self:deactivateToolTip();
end

function ISFluidBar:activateToolTip()
    if self.doToolTip then
        if self.toolTip ~= nil then
            self.toolTip:setVisible(true);
            self.toolTip:addToUIManager();
            self.toolTip:bringToTop()
        else
            local container = self.container;
            if self.containerMixed then
                container = self.containerMixed; --todo make this based of what the mouse is over, and add self.containerAdd
            end
            if self.resource then
                --override with resource if set
                container = self.resource;
            end
            if not container then
                return;
            end
            self.toolTip = ISToolTipInv:new(container);
            self.toolTip:initialise();
            self.toolTip:setVisible(true);
            self.toolTip:addToUIManager();
            self.toolTip:setOwner(self);
            self.toolTip:setCharacter(self.player);
            --self.toolTip:doLayout();
        end
    end
end
function ISFluidBar:deactivateToolTip()
    if self.toolTip then
        self.toolTip:removeFromUIManager();
        self.toolTip:setVisible(false);
        self.toolTip = nil;
    end
end

function ISFluidBar:new (x, y, width, height, _player, _resource)
    local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.x = x;
    o.y = y;
    o.background = false;
    o.backgroundColor = {r=0, g=0, b=0, a=0.0};
    o.borderColor = {r=0.6, g=0.6, b=0.6, a=1};
    o.detailInnerColor = {r=0,g=0,b=0,a=1}
    o.width = width;
    o.height = height;
    o.anchorLeft = false;
    o.anchorRight = false;
    o.anchorTop = false;
    o.anchorBottom = false;
    o.gradientTex = getTexture("media/ui/Fluids/fluid_gradient.png");
    o.bubblesTex = getTexture("media/ui/Fluids/bubbles_seamless.png");
    o.bubblesAlpha = 0.2;
    o.gradientAlpha = 0.15;
    o.triangleWidth = 4;
    o.player = _player;

    o.fluidColor = {r=1, g=1, b=1, a=1};
    o.fluidAddColor = {r=1, g=1, b=1, a=1};
    o.ratioOrig = 0;
    o.ratioNew = 0;
    o.drawMeasures = true;
    o.doToolTip = true;
    o.differenceAlpha = 0.5;
    o.resource = _resource;
    return o
end