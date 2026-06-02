
ISBounds = {}

function ISBounds:new(x, y, width, height)
    local o = setmetatable({}, self)
    self.__index = self
    o.x = x
    o.y = y
    o.width = width
    o.height = height
    return o
end

function ISBounds:setPosition(x, y)
    self.x = x
    self.y = y
end

function ISBounds:getWidth() return self.width end

function ISBounds:setWidth(width)
    self.width = width
    return self
end

function ISBounds:getHeight() return self.height end

function ISBounds:setHeight(height)
    self.height = height
    return self
end

function ISBounds:getLeft() return self.x end

function ISBounds:setLeft(left)
    local right = self:getRight()
    self.x = left
    self.width = right - left
end

function ISBounds:getRight() return self.x + self.width end

function ISBounds:setRight(right)
    self.width = right - self.x
end

function ISBounds:getCenterX()
    return self.x + self.width * 0.5
end

function ISBounds:getTop() return self.y end

function ISBounds:setTop(top)
    local bottom = self:getBottom()
    self.y = top
    self.height = bottom - top
end

function ISBounds:getBottom() return self.y + self.height end

function ISBounds:setBottom(bottom)
    self.height = bottom - self.y
end

function ISBounds:getCenterY()
    return self.y + self.height * 0.5
end

function ISBounds:clone()
    return ISBounds:new(self.x, self.y, self.width, self.height)
end

function ISBounds:getMovedTo(x, y)
    local movedBounds = self:clone()
    movedBounds:setPosition(x, y)
    return movedBounds
end

function ISBounds:getMoved(x, y)
    local movedBounds = self:clone()
    movedBounds:move(x, y)
    return movedBounds
end

function ISBounds:move(x, y)
    self:setPosition(self.x + x, self.y + y)
    return self
end

function ISBounds:scaleFromCenter(scaleX, scaleY)
    self:scaleXFromCenter(scaleX)
    self:scaleYFromCenter(scaleY)
    return self
end

function ISBounds:scaleXFromCenter(scale)
    local scaledWidth = self.width * scale
    self.x = self:getCenterX() - scaledWidth * 0.5
    self.width = scaledWidth
    return self
end

function ISBounds:scaleYFromCenter(scale)
    local scaledHeight = self.height * scale
    self.y = self:getCenterY() - scaledHeight * 0.5
    self.height = scaledHeight
    return self
end

function ISBounds:getScaledFromCenter(scaleX, scaleY)
    local clone = self:clone()
    clone:scaleFromCenter(scaleX, scaleY)
    return clone
end

function ISBounds.intersection(a, b)
    local clippedLeft = math.max(a.x, b.x)
    local clippedRight = math.min(a:getRight(), b:getRight())
    local clippedTop = math.max(a.y, b.y)
    local clippedBottom = math.min(a:getBottom(), b:getBottom())
    clippedBottom = math.max(clippedTop, clippedBottom)
    clippedRight = math.max(clippedLeft, clippedRight)
    return ISBounds:new(clippedLeft, clippedTop, clippedRight - clippedLeft, clippedBottom - clippedTop)
end

function ISBounds.intersects(a, b)
    local xDistance = a:getXDistanceTo(b)
    local yDistance = a:getYDistanceTo(b)
    return xDistance < 0 and yDistance < 0
end

function ISBounds.getProjectedAlongY(bounds, yDistance)
    local top = bounds.y
    local bottom = bounds:getBottom()
    if (yDistance > 0) then
        bottom = bottom + yDistance
    else
        top = top + yDistance
    end

    return ISBounds:new(bounds.x, top, bounds.width, bottom - top)
end

function ISBounds.getProjectedAlongX(bounds, yDistance)
    local left = bounds.x
    local right = bounds:getRight()
    if (yDistance > 0) then
        right = right + yDistance
    else
        left = left + yDistance
    end

    return ISBounds:new(left, bounds.y, right - left, bounds.height)
end

function ISBounds.getYDistanceTo(boundsA, boundsB)
    if (boundsA.y < boundsB.y) then
        return boundsB.y - boundsA:getBottom()
    else
        return boundsA.y - boundsB:getBottom()
    end
end

function ISBounds.getXDistanceTo(boundsA, boundsB)
    if (boundsA.x < boundsB.x) then
        return boundsB.x - boundsA:getRight()
    else
        return boundsA.x - boundsB:getRight()
    end
end

function ISBounds:tostring()
    return "{ left:" .. self.x .. ", top:" .. self.y .. ", right:" .. self:getRight() .. ", bottom:" .. self:getBottom() .. " }"
end
