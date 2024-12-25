PZAPI = PZAPI or {}
PZAPI.UI = {}
PZAPI.UI.Extensions = {}
PZAPI.UI.Extensions.Hooks = {}

local Extensions = PZAPI.UI.Extensions
local Hooks = PZAPI.UI.Extensions.Hooks

local EMPTY_FUNC = function()  end

-----------

Extensions.Mouse = function(ui)
    if ui._atomExtMouse and ui._atomExtMouse.hookDone then return end

    ui._atomExtMouse = ui._atomExtMouse or {}
    if ui._atomExtMouse.consumeButtonDown == nil then
        ui._atomExtMouse.consumeButtonDown = true
    end
    if ui._atomExtMouse.consumeMove == nil then
        ui._atomExtMouse.consumeMove = true
    end
    ui._atomExtMouse.isHover = false
    ui._atomExtMouse.pressed = {}

    ---
    local oldFunc = ui.onMouseButtonDown or EMPTY_FUNC
    ui.onMouseButtonDown = function(self, btn, x, y)
        oldFunc(self, btn, x, y)
        self._atomExtMouse.pressed[btn] = {startX = getMouseX(), startY = getMouseY(), lastX = getMouseX(), lastY = getMouseY()}
        return self._atomExtMouse.consumeButtonDown
    end

    local oldFunc2 = ui.onMouseButtonUp or EMPTY_FUNC
    ui.onMouseButtonUp = function(self, btn, x, y)
        oldFunc2(self, btn, x, y)
        if self._atomExtMouse.pressed[0] then
            if self.onLeftClick then
                self:onLeftClick(x, y)
            end
        elseif self._atomExtMouse.pressed[1] then
            if self.onRightClick then
                self:onRightClick(x, y)
            end
        end
        self._atomExtMouse.pressed[btn] = nil

        return self._atomExtMouse.consumeButtonUp
    end

    local oldFunc3 = ui.onMouseButtonUpOutside or EMPTY_FUNC
    ui.onMouseButtonUpOutside = function(self, btn, x, y)
        oldFunc3(self, btn, x, y)
        self._atomExtMouse.pressed[btn] = nil
    end

    local oldFunc4 = ui.renderUpdate or EMPTY_FUNC
    ui.renderUpdate = function(self)
        oldFunc4(self)
        local mx = getMouseX()
        local my = getMouseY()

        if self.onLeftDrag then
            local data = self._atomExtMouse.pressed[0]
            if data and (data.lastX ~= mx or data.lastY ~= my) then
                self:onLeftDrag(data, mx - data.lastX, my - data.lastY)
                data.lastX = mx
                data.lastY = my
            end
        end

        if self.onRightDrag then
            local data = self._atomExtMouse.pressed[1]
            if data and (data.lastX ~= mx or data.lastY ~= my) then
                self:onRightDrag(data, mx - data.lastX, my - data.lastY)
                data.lastX = mx
                data.lastY = my
            end
        end

        if self.onMiddleDrag then
            local data = self._atomExtMouse.pressed[2]
            if data and (data.lastX ~= mx or data.lastY ~= my) then
                self:onMiddleDrag(data, mx - data.lastX, my - data.lastY)
                data.lastX = mx
                data.lastY = my
            end
        end
    end

    local oldFunc5 = ui.onMouseMove or EMPTY_FUNC
    ui.onMouseMove = function(self, dx, dy)
        oldFunc5(self, dx, dy)
        if not self._atomExtMouse.isHover and self.onHover then
            self:onHover(true)
        end
        self._atomExtMouse.isHover = true

        return self._atomExtMouse.consumeMove
    end

    local oldFunc6 = ui.onMouseMoveOutside or EMPTY_FUNC
    ui.onMouseMoveOutside = function(self, dx, dy)
        oldFunc6(self, dx, dy)
        if self._atomExtMouse.isHover and self.onHover then
            self:onHover(false)
        end
        self._atomExtMouse.isHover = false
    end

    ---

    ui._atomExtMouse.hookDone = true
end

Hooks.onLeftClick = Extensions.Mouse
Hooks.onRightClick = Extensions.Mouse
Hooks.onLeftDrag = Extensions.Mouse
Hooks.onRightDrag = Extensions.Mouse
Hooks.onMiddleDrag = Extensions.Mouse
Hooks.onHover = Extensions.Mouse

--------

Extensions.Scroll = function(ui)
    if ui._atomExtScroll and ui._atomExtScroll.hookDone then return end

    ui._atomExtScroll = ui._atomExtScroll or {}

    local oldFunc = ui.onMouseWheel or EMPTY_FUNC
    ui.onMouseWheel = function(self, del)
        oldFunc(self, del)
        self:setY(self.y - del * 25)
        if (self.y + self.height) < self.parent.y + self.parent.height then
            self:setY(- self.height + self.parent.height)
        end
        if self.y > 0 then
            self:setY(0)
        end

        self:onScroll(self.y / (self.parent.height - self.height))

        return true
    end

    ui._atomExtScroll.hookDone = true
end

Hooks.onScroll = Extensions.Scroll