
ISLine = {}
function ISLine:new(startX, startY, endX, endY)
    local line = {}
    setmetatable(line, self)
    self.__index = self
    line.segments = {}
    line.startX = startX
    line.startY = startY
    line.endX = endX
    line.endY = endY
    line.color = { r = 1, g = 1, b = 1, a = 1}
    line.thickness = 1.5
    return line
end

function ISLine:numSegments()
    return #(self.segments)
end

function ISLine:getSegmentAt(i)
    return self.segments[i]
end

function ISLine:getAllPoints()
    local allPoints = {}
    if (self:numSegments() > 0) then
        table.insert(allPoints, self.segments[1]:getStartPoint())
        for _,segment in ipairs(self.segments) do
            table.insert(allPoints, segment:getEndPoint())
        end
    end
    return allPoints
end

function ISLine:addSegment(x1, y1, x2, y2)
    local lineSegment = {}
    lineSegment.x1 = x1
    lineSegment.y1 = y1
    lineSegment.x2 = x2
    lineSegment.y2 = y2
    function lineSegment:getStartPoint()
        return { x = self.x1, y = self.y1 }
    end
    function lineSegment:getEndPoint()
        return { x = self.x2, y = self.y2 }
    end
    table.insert(self.segments, lineSegment)
    return lineSegment
end

function ISLine:getLastSegment()
    local segmentCount = self:numSegments()
    if (segmentCount == 0) then return nil end
    return self:getSegmentAt(segmentCount)
end

function ISLine:getLastPoint()
    local lastSegment = self:getLastSegment()
    if (lastSegment == nil) then return { x = self.startX, y = self.startY } end
    return lastSegment:getEndPoint()
end

function ISLine:appendPoint(newPoint)
   local last = self:getLastPoint()
   self:addSegment(last.x, last.y, newPoint.x, newPoint.y)
end

function ISLine:appendBevelPoint(bevelCenter, next, bevelRadius, includeNext)
    local lastPoint = self:getLastPoint()

    local lastToBevelX = bevelCenter.x - lastPoint.x
    local lastToBevelY = bevelCenter.y - lastPoint.y
    local lastToBevelLength = math.length2(lastToBevelX, lastToBevelY)
    if (lastToBevelLength < bevelRadius) then
        self:appendPoint(bevelCenter)
        if (includeNext) then self:appendPoint(next) end
        return
     end

    local bevelToNextX = next.x - bevelCenter.x
    local bevelToNextY = next.y - bevelCenter.y
    local bevelToNextLength = math.length2(bevelToNextX, bevelToNextY)
    if (bevelToNextLength < bevelRadius) then
        self:appendPoint(bevelCenter)
        if (includeNext) then self:appendPoint(next) end
        return
    end

    local lastToBevelNX = lastToBevelX / lastToBevelLength
    local lastToBevelNY = lastToBevelY / lastToBevelLength
    self:appendPoint({ x = bevelCenter.x - lastToBevelNX * bevelRadius, y = bevelCenter.y - lastToBevelNY * bevelRadius })

    local bevelToNextNX = bevelToNextX / bevelToNextLength
    local bevelToNextNY = bevelToNextY / bevelToNextLength
    self:appendPoint({ x = bevelCenter.x + bevelToNextNX * bevelRadius, y = bevelCenter.y + bevelToNextNY * bevelRadius })

    if (includeNext) then self:appendPoint(next) end
end

function ISLine:bevelAllJoints(bevelRadius)
    local allPoints = self:getAllPoints()
    self.segments = {}

    if (#allPoints > 0) then
        self:appendPoint(allPoints[1])
        for i=2,#allPoints do
            self:appendBevelPoint(allPoints[i], allPoints[i+1], bevelRadius, false)
        end
        self:appendPoint(allPoints[#allPoints])
    end
end

function ISLine:render(drawer, a, r, g, b)
    a = a or self.color.a
    r = r or self.color.r
    g = g or self.color.g
    b = b or self.color.b
    for _,lineSegment in ipairs(self.segments) do
        drawer:drawLineAbsolute(nil, lineSegment.x1, lineSegment.y1, lineSegment.x2, lineSegment.y2, self.thickness, a, r, g, b)
    end
end
