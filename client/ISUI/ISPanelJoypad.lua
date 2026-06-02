require "ISUI/ISUIElement"

local rowTree = {}
function rowTree:new(elements)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    o.elements = elements
    o.above = nil
    o.below = nil
    o:splitOverlappingColumns()

    return o
end
function rowTree:splitOverlappingColumns()
    local elementCount = #self.elements
    if (elementCount == 0) then return end

    local i = 1
    while i <= elementCount do
        local element = self.elements[i]
        local overlappingElementIdx = self:findHorizontallyOverlappingElement(element:getAbsoluteX(), element:getAbsoluteRight(),i)
        if (overlappingElementIdx ~= nil and overlappingElementIdx ~= i) then
            local elementsAbove, elementsEqual, elementsBelow = self:getSplitElements(element:getAbsoluteY())
            if (#elementsAbove > 0) then
                self.above = rowTree:new(elementsAbove)
            end
            self.elements = elementsEqual
            if (#elementsBelow > 0) then
                self.below = rowTree:new(elementsBelow)
            end
            break
        end
        i = i + 1
    end
end

function rowTree:getBottomMostBranch()
    if (self.below == nil) then return self end
    return self.below:getBottomMostBranch()
end

function rowTree:getTopMostBranch()
    if (self.above == nil) then return self end
    return self.above:getTopMostBranch()
end

function rowTree:getSplitElements(y)
    local elementsAbove = {}
    local elementsEqual = {}
    local elementsBelow = {}

    for _,element in ipairs(self.elements) do
        local elementY = element:getAbsoluteY()
        if (elementY < y) then
            table.insert(elementsAbove, element)
        elseif (elementY > y) then
             table.insert(elementsBelow, element)
         else
             table.insert(elementsEqual, element)
        end
    end

    return elementsAbove, elementsEqual, elementsBelow
end
function rowTree:findHorizontallyOverlappingElement(left, right, vsElementIdx)
    local overlappingElementIdx = nil
    local elementCount = #self.elements
    local elementIdx = 1
    while elementIdx <= elementCount do
        if (elementIdx ~= vsElementIdx) then
            local element = self.elements[elementIdx]
            local elementLeft = element:getAbsoluteX()
            local elementRight = element:getAbsoluteX() + element:getWidth()
            if (math.rangesOverlap(left, right, elementLeft, elementRight)) then
                overlappingElementIdx = elementIdx
                break
            end
        end
        elementIdx = elementIdx + 1
    end
    return overlappingElementIdx
end
function rowTree:getAllRows(result)
    result = result or {}
    if (self.above ~= nil) then
        self.above:getAllRows(result)
    end

    if (#self.elements > 0) then
        table.insert(result, self.elements)
    end

    if (self.below ~= nil) then
        self.below:getAllRows(result)
    end

    return result
end
function rowTree.rowToString(row)
    local resultStr = "{ "
    for i,element in ipairs(row) do
        if (i > 1) then
            resultStr = resultStr .. ", "
        end
        resultStr = resultStr .. element:toDebugString()
    end
    resultStr = resultStr .. " }"
    return resultStr
end

ISPanelJoypad = ISUIElement:derive("ISPanelJoypad");

function ISPanelJoypad:initialise()
	ISUIElement.initialise(self);
end

function ISPanelJoypad:setVisible(visible, joypadData)
    if visible and joypadData then
        joypadData.focus = self
        updateJoypadFocus(joypadData)
    end
    ISUIElement.setVisible(self, visible);
end

function ISPanelJoypad:insertNewLineOfButtons(button1, button2, button3, button4, button5, button6, button7, button8, button9, button10)
    local newLine = {};
    if button1 then table.insert(newLine, button1); end
    if button2 then table.insert(newLine, button2); end
    if button3 then table.insert(newLine, button3); end
    if button4 then table.insert(newLine, button4); end
    if button5 then table.insert(newLine, button5); end
    if button6 then table.insert(newLine, button6); end
    if button7 then table.insert(newLine, button7); end
    if button8 then table.insert(newLine, button8); end
    if button9 then table.insert(newLine, button9); end
    if button10 then table.insert(newLine, button10); end
    self:insertNewListOfButtons(newLine)
    return newLine;
end

function ISPanelJoypad:insertNewListOfButtons(list)
    self.joypadButtons = list;
    table.insert(self.joypadButtonsY, list);

    for _,element in ipairs(list) do
        table.insert(self.allJoypadButtons, element)
    end
end

function ISPanelJoypad:removeListOfButtons(list)
    local indexOf = luautils.indexOf(self.joypadButtonsY, list)
    if (indexOf == -1) then
        DebugType.ISUI.warn("ISPanelJoypad:removeListOfButtons> row not found.")
        return false
    end

    table.remove(self.joypadButtonsY, list)
    local newIndex = indexOf
    if (indexOf > #self.joypadButtonsY) then
        newIndex = #self.joypadButtonsY
    end
    self.joypadIndexY = newIndex
    self.joypadButtons = self.joypadButtonsY[self.joypadIndexY]

    return true
end

function ISPanelJoypad.rowListToDebugString(list)
    local rowStr = "{"
    local isFirst = true
    for _,uiElement in pairs(list) do
        if (isFirst == false) then
            rowStr = rowStr .. ", "
        else
            rowStr = rowStr .. " "
        end
        rowStr = rowStr .. uiElement:toDebugString()
        isFirst = false
    end
    rowStr = rowStr .. " }"
    return rowStr
end

function ISPanelJoypad:addJoypadButtonRows(rows)
    for _,row in pairs(rows) do
        self:insertNewListOfButtons(row)
    end
end

function ISPanelJoypad:removeJoypadButtonRows(rows)
    for _,row in pairs(rows) do
        self:removeListOfButtons(row)
    end
end

function ISPanelJoypad:autoGenerateJoypadButtonsLists()
    local joypadState = self:recordJoypadState()
    self:clearJoypadButtonsList()
    self:addJoypadButtonRows(ISPanelJoypad.autoGenerateJoypadButtonRowsFromUIElement(self))
    self:restoreJoypadState(joypadState)
end

function ISPanelJoypad:clearJoypadButtonsList()
    self.joypadIndex = 1
    self.joypadIndexY = 1
    self.joypadButtons = {}
    self.joypadButtonsY = {}
    self.allJoypadButtons = {}
end

function ISPanelJoypad.autoGenerateJoypadButtonRowsFromUIElement(uiRootElement)
    local allJoypadButtons = uiRootElement:visitAndAllDescendants({}, ISPanelJoypad.autoAddUIElementToJoypadButtons)

    -- sort elements by X
    table.sort(allJoypadButtons, function(a, b) return a:getAbsoluteX() <= b:getAbsoluteX() end)
    DebugType.ISUI:trace("Automatically adding JoypadButton lists from uiElement.")
    for _,entry in ipairs(allJoypadButtons) do
        DebugType.ISUI:trace("  Entry: " .. entry:toDebugString() .. " }")
    end

    local rootRow = rowTree:new(allJoypadButtons)
    local allRows = rootRow:getAllRows()

    DebugType.ISUI:trace("Completed generating rows.")
    for i,row in ipairs(allRows) do
        DebugType.ISUI:trace("  Row[" .. i .. "]: " .. rowTree.rowToString(row))
    end

    return allRows
end

function ISPanelJoypad.autoAddUIElementToJoypadButtons(allJoypadButtons, uiElement)
    if (uiElement.autoAddJoypadButton == false) then
        return false
    end

    if (luautils.tableContains(allJoypadButtons, uiElement)) then
        return true
    end

    table.insert(allJoypadButtons, uiElement)
end

function ISPanelJoypad:noBackground()
	self.background = false;
	return self
end

function ISPanelJoypad:close()
	self:setVisible(false);
end

function ISPanelJoypad:setISButtonForA(button)
    self.ISButtonA = button;
    button:setJoypadButton(Joypad.Texture.AButton);
end

function ISPanelJoypad:setISButtonForB(button)
    self.ISButtonB = button;
    button:setJoypadButton(Joypad.Texture.BButton);
end

function ISPanelJoypad:setISButtonForY(button)
    self.ISButtonY = button;
    button:setJoypadButton(Joypad.Texture.YButton);
end

function ISPanelJoypad:setISButtonForX(button)
    self.ISButtonX = button;
    button:setJoypadButton(Joypad.Texture.XButton);
end

function ISPanelJoypad:clearISButtonA()
    if self.ISButtonA then
        self.ISButtonA:clearJoypadButton()
        self.ISButtonA = nil
    end
end

function ISPanelJoypad:clearISButtonB()
    if self.ISButtonB then
        self.ISButtonB:clearJoypadButton()
        self.ISButtonB = nil
    end
end

function ISPanelJoypad:clearISButtonX()
    if self.ISButtonX then
        self.ISButtonX:clearJoypadButton()
        self.ISButtonX = nil
    end
end

function ISPanelJoypad:clearISButtonY()
    if self.ISButtonY then
        self.ISButtonY:clearJoypadButton()
        self.ISButtonY = nil
    end
end

function ISPanelJoypad:clearISButtons()
    self:clearISButtonA()
    self:clearISButtonB()
    self:clearISButtonX()
    self:clearISButtonY()
end

function ISPanelJoypad:onJoypadDown(button, joypadData)
    local children = self:getVisibleChildren(self.joypadIndexY)
    local child = children[self.joypadIndex]

    if button == Joypad.AButton and child and (child.isButton or child.isCombobox or child.isTickBox or child.isKnob or child.isRadioButtons) then
        self:ensureVisible();
        child:forceClick();
        return;
    end
    if button == Joypad.AButton and child and child.onJoypadDownInParent and child:onJoypadDownInParent(button, joypadData) then
        return
    end
    if button == Joypad.BButton and child and child.isCombobox and child.expanded then
        child.expanded = false;
        child:hidePopup();
        return;
    end
    if (button == Joypad.AButton or button == Joypad.XButton) and child and (child.Type == "ISTextEntryBox") then
        child:onJoypadDown(button, joypadData);
        return;
    end

    if button == Joypad.BButton and self.ISButtonB then
        self.ISButtonB:forceClick();
    elseif button == Joypad.AButton and self.ISButtonA then
        self.ISButtonA:forceClick();
    elseif button == Joypad.XButton and self.ISButtonX then
        self.ISButtonX:forceClick();
    elseif button == Joypad.YButton and self.ISButtonY then
        self.ISButtonY:forceClick();
    else
        ISUIElement.onJoypadDown(self, button, joypadData)
    end
end

function ISPanelJoypad:getChildJoypadIndexY(child)
    for indexY,children in ipairs(self.joypadButtonsY) do
        for index,child1 in ipairs(children) do
            if child1 == child then
                return indexY
            end
        end
    end
    return -1
end

function ISPanelJoypad:getChildJoypadIndex(child)
    for indexY,children in ipairs(self.joypadButtonsY) do
        for index,child1 in ipairs(children) do
            if child1 == child then
                return index
            end
        end
    end
    return -1
end

function ISPanelJoypad:getVisibleChildren(joypadIndexY)
    local children = {}
    if self.joypadButtonsY[joypadIndexY] then
        local children1 = self.joypadButtonsY[joypadIndexY]
        for _,child in ipairs(children1) do
            if child:isVisible() then
                table.insert(children, child)
            end
        end
    end
    return children
end

function ISPanelJoypad:getMinVisibleRow()
    for i=1,#self.joypadButtonsY do
        local children = self:getVisibleChildren(i)
        if #children > 0 then
            return i
        end
    end
    return -1
end

function ISPanelJoypad:getMaxVisibleRow()
    for i=#self.joypadButtonsY,1,-1 do
        local children = self:getVisibleChildren(i)
        if #children > 0 then
            return i
        end
    end
    return -1
end

function ISPanelJoypad:getPrevVisibleRow(row)
    for i=row-1,1,-1 do
        local children = self:getVisibleChildren(i)
        if #children > 0 then
            return i
        end
    end
    return -1
end

function ISPanelJoypad:getNextVisibleRow(row)
    for i=row+1,#self.joypadButtonsY do
        local children = self:getVisibleChildren(i)
        if #children > 0 then
            return i
        end
    end
    return -1
end

function ISPanelJoypad:getClosestChild(children, x)
	local closestDist = 100000
	local closestIndex = -1
	for i,child in ipairs(children) do
		local dist = math.abs((child.x + child.width / 2) - x)
		if dist <= closestDist then
			closestDist = dist
			closestIndex = i
		end
	end
	return closestIndex
end

function ISPanelJoypad:onJoypadDirLeft(joypadData)
    local children = self:getVisibleChildren(self.joypadIndexY)
    local child = children[self.joypadIndex]
    if child and child.isSlider then
        child:onJoypadDirLeft(joypadData)
    else
        local nextChild = self:findNextNavigableChildX(child, -1)
        if (nextChild ~= nil) then
            child:setJoypadFocused(false, joypadData);
            self:setJoypadFocus(nextChild, joypadData)
        elseif #children > 0 and self.joypadIndex > 1 then
            children[self.joypadIndex]:setJoypadFocused(false, joypadData);
            self.joypadIndex = self.joypadIndex - 1;
            children[self.joypadIndex]:setJoypadFocused(true, joypadData);
        else
            ISUIElement.onJoypadDirLeft(self, joypadData)
        end
    end
    self:ensureVisible()
end

function ISPanelJoypad:onJoypadDirRight(joypadData)
    local children = self:getVisibleChildren(self.joypadIndexY)
    local child = children[self.joypadIndex]
    if child and child.isSlider then
        child:onJoypadDirRight(joypadData)
    else
        local nextChild = self:findNextNavigableChildX(child, 1)
        if (nextChild ~= nil) then
            child:setJoypadFocused(false, joypadData);
            self:setJoypadFocus(nextChild, joypadData)
        elseif #children > 0 and self.joypadIndex ~= #children then
            children[self.joypadIndex]:setJoypadFocused(false, joypadData);
            self.joypadIndex = self.joypadIndex + 1;
            children[self.joypadIndex]:setJoypadFocused(true, joypadData);
        else
            ISUIElement.onJoypadDirRight(self, joypadData)
        end
    end
    self:ensureVisible()
end

function ISPanelJoypad:onJoypadDirUp(joypadData)
    local children = self:getVisibleChildren(self.joypadIndexY)
    local child = children[self.joypadIndex]
    if child and child.isCombobox and child.expanded then
        child:onJoypadDirUp(joypadData)
    elseif child and child.isRadioButtons and child.joypadIndex > 1 then
        child:onJoypadDirUp(joypadData)
    elseif child and child.isTickBox and child.joypadIndex > 1 then
        child:onJoypadDirUp(joypadData)
    elseif child and child.isKnob then
        child:onJoypadDirUp(joypadData)
    else
        local nextChild = self:findNextNavigableChildY(child, -1)
        if (nextChild ~= nil) then
            child:setJoypadFocused(false, joypadData);
            self:setJoypadFocus(nextChild, joypadData)
        elseif (#self.joypadButtonsY > 0) and (self.joypadIndexY > self:getMinVisibleRow()) and (self.joypadIndexY <= #self.joypadButtonsY) then
            child:setJoypadFocused(false, joypadData);
            self.joypadIndexY = self:getPrevVisibleRow(self.joypadIndexY);
            self.joypadButtons = self.joypadButtonsY[self.joypadIndexY];
            children = self:getVisibleChildren(self.joypadIndexY)
            self.joypadIndex = self:getClosestChild(children, child.x + child.width / 2)
            if self.joypadIndex > #children then
                self.joypadIndex = #children;
            end
            children[self.joypadIndex]:setJoypadFocused(true, joypadData);
        else
            ISUIElement.onJoypadDirUp(self, joypadData)
        end
    end
    self:ensureVisible()
end

function ISPanelJoypad:onJoypadDirDown(joypadData)
    local children = self:getVisibleChildren(self.joypadIndexY)
    local child = children[self.joypadIndex]
    if child and child.isCombobox and child.expanded then
        child:onJoypadDirDown(joypadData)
    elseif child and child.isRadioButtons and child.joypadIndex < #child.options then
        child:onJoypadDirDown(joypadData)
    elseif child and child.isTickBox and child.joypadIndex < #child.options then
        child:onJoypadDirDown(joypadData)
    elseif child and child.isKnob then
        child:onJoypadDirDown(joypadData)
    else
        local nextChild = self:findNextNavigableChildY(child, 1)
        if (nextChild ~= nil) then
            child:setJoypadFocused(false, joypadData);
            self:setJoypadFocus(nextChild, joypadData)
        elseif (#self.joypadButtonsY > 0) and (self.joypadIndexY < self:getMaxVisibleRow()) then
            child:setJoypadFocused(false, joypadData);
            self.joypadIndexY = self:getNextVisibleRow(self.joypadIndexY);
            self.joypadButtons = self.joypadButtonsY[self.joypadIndexY];
            children = self:getVisibleChildren(self.joypadIndexY)
            self.joypadIndex = self:getClosestChild(children, child.x + child.width / 2)
            if self.joypadIndex > #children then
                self.joypadIndex = #children;
            end
            children[self.joypadIndex]:setJoypadFocused(true, joypadData);
        else
            ISUIElement.onJoypadDirDown(self, joypadData)
        end
    end
    self:ensureVisible()
end

function ISPanelJoypad:findNextNavigableChildY(fromChild, yDir)
    if (fromChild == nil) then
        self.lastProjectedBounds = nil
        self.lastIntercepts = nil
        return nil
    end

    local minDistance = 0
    local fromChildBounds = fromChild:getAbsoluteBounds()
    local sampleFromBounds = fromChildBounds:getScaledFromCenter(1, 0.5):setHeight(1.0)
    local sampleFromBounds1x = sampleFromBounds:getScaledFromCenter(0.01, 1.0)
    local sampleFromBounds2x = sampleFromBounds:getScaledFromCenter(0.20, 1.0)
    local sampleFromBounds3x = sampleFromBounds:getScaledFromCenter(0.50, 1.0)
    local sampleFromBounds4x = sampleFromBounds:getScaledFromCenter(0.75, 1.0)

    local foundResult = {
        foundChild = nil,
        foundChildDistance = nil,
    }
    self:findClosestNavigableChildAlongBounds(fromChild, sampleFromBounds1x, sampleFromBounds1x:getProjectedAlongY(yDir * 10000), minDistance, ISBounds.getYDistanceTo, foundResult)
    self:findClosestNavigableChildAlongBounds(fromChild, sampleFromBounds2x, sampleFromBounds2x:getProjectedAlongY(yDir * 10000), minDistance, ISBounds.getYDistanceTo, foundResult)
    self:findClosestNavigableChildAlongBounds(fromChild, sampleFromBounds3x, sampleFromBounds3x:getProjectedAlongY(yDir * 10000), minDistance, ISBounds.getYDistanceTo, foundResult)
    self:findClosestNavigableChildAlongBounds(fromChild, sampleFromBounds4x, sampleFromBounds4x:getProjectedAlongY(yDir * 10000), minDistance, ISBounds.getYDistanceTo, foundResult)
    self:findClosestNavigableChildAlongBounds(fromChild, sampleFromBounds, sampleFromBounds:getProjectedAlongY(yDir * 10000), minDistance, ISBounds.getYDistanceTo, foundResult)
    return foundResult.foundChild
end

function ISPanelJoypad:findNextNavigableChildX(fromChild, xDir)
    if (fromChild == nil) then
        self.lastProjectedBounds = nil
        self.lastIntercepts = nil
        return nil
    end

    local minDistance = 0
    local fromChildBounds = fromChild:getAbsoluteBounds()
    local sampleFromBounds = fromChildBounds:getScaledFromCenter(0.5, 1):setWidth(1.0)
    local sampleFromBounds1x = sampleFromBounds:getScaledFromCenter(1.0, 0.01)
    local sampleFromBounds2x = sampleFromBounds:getScaledFromCenter(1.0, 0.20)
    local sampleFromBounds3x = sampleFromBounds:getScaledFromCenter(1.0, 0.50)
    local sampleFromBounds4x = sampleFromBounds:getScaledFromCenter(1.0, 0.75)

    local foundResult = {
        foundChild = nil,
        foundChildDistance = nil,
    }
    self:findClosestNavigableChildAlongBounds(fromChild, sampleFromBounds1x, sampleFromBounds1x:getProjectedAlongX(xDir * 10000), minDistance, ISBounds.getXDistanceTo, foundResult)
    self:findClosestNavigableChildAlongBounds(fromChild, sampleFromBounds2x, sampleFromBounds2x:getProjectedAlongX(xDir * 10000), minDistance, ISBounds.getXDistanceTo, foundResult)
    self:findClosestNavigableChildAlongBounds(fromChild, sampleFromBounds3x, sampleFromBounds3x:getProjectedAlongX(xDir * 10000), minDistance, ISBounds.getXDistanceTo, foundResult)
    self:findClosestNavigableChildAlongBounds(fromChild, sampleFromBounds4x, sampleFromBounds4x:getProjectedAlongX(xDir * 10000), minDistance, ISBounds.getXDistanceTo, foundResult)
    self:findClosestNavigableChildAlongBounds(fromChild, sampleFromBounds, sampleFromBounds:getProjectedAlongX(xDir * 10000), minDistance, ISBounds.getXDistanceTo, foundResult)
    return foundResult.foundChild
end

function ISPanelJoypad:findClosestNavigableChildAlongBounds(fromChild, fromChildBounds, projectedBounds, minDistance, distanceToFunc, results)
    if (fromChild == nil) then
        self.lastProjectedBounds = nil
        self.lastIntercepts = nil
        return nil
    end

    local foundChild = results.foundChild
    local foundChildDistance = results.foundChildDistance
    self.lastProjectedBounds = projectedBounds
    self.lastIntercepts = {}
    for _,child in ipairs(self.allJoypadButtons) do
        if (child:isVisible() and child ~= fromChild) then
            local childBounds = child:getAbsoluteBounds()
            table.insert(self.lastIntercepts, childBounds)
            if (childBounds:intersects(projectedBounds)) then
                local yDistance = distanceToFunc(fromChildBounds, childBounds)
                if ((foundChild == nil or foundChildDistance > yDistance) and yDistance > minDistance) then
                    foundChild = child
                    foundChildDistance = yDistance
                    childBounds.hit = true
                end
            end
        end
    end

    self.lastProjectedBounds.from = fromChild
    self.lastProjectedBounds.fromChildBounds = fromChildBounds
    self.lastProjectedBounds.hit = foundChild
    self.lastProjectedBounds.hitDistance = foundChildDistance
    results.foundChild = foundChild
    results.foundChildDistance = foundChildDistance

    if (self.lastProjectedBounds.hit) then
        DebugType.ISUI:trace("Navigation hit. Using minDistance:" .. minDistance .. ", Found:" .. self.lastProjectedBounds.hit:toDebugString() .. ", at distance:" .. foundChildDistance)
    end

    return foundChild
end

function ISPanelJoypad:getJoypadFocus()
    local children = self:getVisibleChildren(self.joypadIndexY)
    return children[self.joypadIndex]
end

function ISPanelJoypad:setJoypadFocus(child, joypadData)
    for indexY,buttons in ipairs(self.joypadButtonsY) do
        for indexX,button in ipairs(buttons) do
            if button == child then
                self:clearJoypadFocus(joypadData)
                self.joypadIndexY = indexY
                self.joypadIndex = indexX
                self.joypadButtons = buttons
                child:setJoypadFocused(true, joypadData)
                return
            end
        end
    end
end

function ISPanelJoypad:restoreJoypadFocus(joypadData)
    local child = self:getJoypadFocus()
    if child then
        child:setJoypadFocused(true, joypadData)
    end
end

function ISPanelJoypad:clearJoypadFocus(joypadData)
    local child = self:getJoypadFocus()
    if child then
        child:setJoypadFocused(false, joypadData)
    end
end

function ISPanelJoypad:recordJoypadState()
    local state = {}
    state.indexY = math.max(self.joypadIndexY or 1, 1)
    state.index = math.max(self.joypadIndex or 1, 1)
    local joypadData = self.joyfocus
    if joypadData ~= nil and joypadData.focus == self and self.joypadButtons ~= nil and #self.joypadButtons > 0 then
        self:clearJoypadFocus(joypadData)
    end
    return state
end

function ISPanelJoypad:restoreJoypadState(state)
    if not state or #self.joypadButtonsY == 0 then return end
    self.joypadIndexY = math.min(state.indexY or 1, #self.joypadButtonsY)
    self.joypadIndex = math.min(state.index or 1, #self.joypadButtonsY[self.joypadIndexY])
    self.joypadButtons = self.joypadButtonsY[self.joypadIndexY]
    local joypadData = self.joyfocus
    if joypadData ~= nil and joypadData.focus == self then
        self.joypadButtons[self.joypadIndex]:setJoypadFocused(true, joypadData)
    end
end

function ISPanelJoypad:doRightJoystickScrolling(dx, dy)
    if not self.joyfocus then return; end;
    if self.joyfocus.id == -1 then
        self.joyfocus = nil;
        return;
    end;
    if self.isFocusOnControl and self:isFocusOnControl() then return; end;
    dx = dx or 20
    dy = dy or 20
    local axisY = getJoypadAimingAxisY(self.joyfocus.id)
    if axisY > 0.75 then
        self:setYScroll(self:getYScroll() - dy * UIManager.getMillisSinceLastRender() / 33.3)
    end
    if axisY < -0.75 then
        self:setYScroll(self:getYScroll() + dy * UIManager.getMillisSinceLastRender() / 33.3)
    end

    local axisX = getJoypadAimingAxisX(self.joyfocus.id)
    if axisX > 0.75 then
        self:setXScroll(self:getXScroll() - dx * UIManager.getMillisSinceLastRender() / 33.3)
    end
    if axisX < -0.75 then
        self:setXScroll(self:getXScroll() + dx * UIManager.getMillisSinceLastRender() / 33.3)
    end
end

function ISPanelJoypad:ensureVisible()
    if not self.joyfocus then return end
    local children = self:getVisibleChildren(self.joypadIndexY)
    local child = children[self.joypadIndex]
    if not child then return end
    local y = child:getAbsoluteY() - self:getAbsoluteY() - self:getYScroll()
    if 40 + child:getHeight() + 40 > self:getHeight() then
        self:setYScroll(0 - y)
    elseif y - 40 < 0 - self:getYScroll() then
        self:setYScroll(0 - y + 40)
    elseif y + child:getHeight() + 40 > 0 - self:getYScroll() + self:getHeight() then
        local yScroll = 0 - (y + child:getHeight() + 40 - self:getHeight())
        self:setYScroll(yScroll)
    end
end

function ISPanelJoypad:isFocusOnControl()
    local children = self:getVisibleChildren(self.joypadIndexY)
    local child = children[self.joypadIndex]
    if child and child.isCombobox and child.expanded then
        return true
    elseif child and child.isRadioButtons and child.joypadIndex > 1 then
        return true
    elseif child and child.isTickBox and child.joypadIndex > 1 then
        return true
    elseif child and child.isKnob then
        return true
    end
    return false
end

function ISPanelJoypad:onMouseUp(x, y)
    if not self.moveWithMouse then return; end
    if not self:getIsVisible() then
        return;
    end

    self.moving = false;
    if ISMouseDrag.tabPanel then
        ISMouseDrag.tabPanel:onMouseUp(x,y);
    end

    ISMouseDrag.dragView = nil;
end

function ISPanelJoypad:onMouseUpOutside(x, y)
    if not self.moveWithMouse then return; end
    if not self:getIsVisible() then
        return;
    end

    self.moving = false;
    ISMouseDrag.dragView = nil;
end

function ISPanelJoypad:onMouseDown(x, y)
    if not self.moveWithMouse then return; end
    if not self:getIsVisible() then
        return;
    end

    self.downX = x;
    self.downY = y;
    self.moving = true;
    self:bringToTop();
end

function ISPanelJoypad:onMouseMoveOutside(dx, dy)
    if not self.moveWithMouse then return; end
    self.mouseOver = false;

    if self.moving then
        self:setX(self.x + dx);
        self:setY(self.y + dy);
        self:bringToTop();
    end
end

function ISPanelJoypad:onMouseMove(dx, dy)
    if not self.moveWithMouse then return; end
    self.mouseOver = true;

    if self.moving then
        self:setX(self.x + dx);
        self:setY(self.y + dy);
        self:bringToTop();
    end
end

function ISPanelJoypad:prerender()
	if self.background then
		self:drawRectStatic(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
		self:drawRectBorderStatic(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
	end
end

function ISPanelJoypad:render()
    ISPanelJoypad.SuperType.render(self)

    if(JoypadState.dbgDrawUINavigation) then
        self:renderDebugUINavigation()
    end
end

function ISPanelJoypad:renderDebugUINavigation()
    if (self.lastProjectedBounds == nil) then
        return
    end

    local projectedBounds = self:toLocalBounds(self.lastProjectedBounds)
    if (projectedBounds.hit) then
        self:drawRectBounds(projectedBounds, 0.15, 0.35, 0.35, 0.8)
    else
        self:drawRectBounds(projectedBounds, 0.15, 0.5, 0.2, 0.35)
    end

    for _,intercept in ipairs(self.lastIntercepts) do
        local interceptLocal = self:toLocalBounds(intercept)
        if (intercept.hit) then
            self:drawRectBounds(interceptLocal, 0.15, 0.2, 0.5, 0.25)
        else
            self:drawRectBounds(interceptLocal, 0.10, 0.5, 0.2, 0.25)
        end
    end

    if (self.lastProjectedBounds.fromChildBounds) then
        local fromBounds = self:toLocalBounds(self.lastProjectedBounds.fromChildBounds)
        if (projectedBounds.hit) then
            self:drawRectBounds(fromBounds, 0.75, 0.1, 0.1, 0.8)
        else
            self:drawRectBounds(fromBounds, 0.75, 0.1, 0.1, 0.8)
        end
    end

    if (self.lastProjectedBounds.hit) then
        local hitBounds = self:toLocalBounds(self.lastProjectedBounds.hit:getAbsoluteBounds())
        self:drawRectBounds(hitBounds, 0.5, 0.5, 0.9, 0.8)
    end
end

function ISPanelJoypad:new (x, y, width, height)
	local o = {}
	o = ISUIElement:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
	o.x = x;
	o.y = y;
	o.background = true;
	o.backgroundColor = {r=0, g=0, b=0, a=0.5};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.width = width;
	o.height = height;
	o.anchorLeft = true;
	o.anchorRight = false;
	o.anchorTop = true;
	o.anchorBottom = false;
    o.joypadButtons = {};
    o.joypadIndex = 0;
    o.joypadButtonsY = {};
    o.allJoypadButtons = {};
    o.joypadIndexY = 0;
    o.moveWithMouse = false;
   return o
end
