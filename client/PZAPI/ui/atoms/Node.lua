require "PZAPI/ui/atoms/Meta"
local UI = PZAPI.UI

UI.Node = UI._mt.__call{
    _ATOM_UI_CLASS = AtomUI,
    x = 0, y = 0,
    width = 256, height = 256,
    pivotX = 0, pivotY = 0,
    angle = 0,
    scaleX = 1, scaleY = 1,
    r = 1, g = 1, b = 1, a = 1,
    anchorLeft = false, anchorRight = false, anchorTop = false, anchorDown = false,
    visible = true,
    enabled = true,
    alwaysBack = false,
    alwaysOnTop = false,
    isStencil = false,
    setX = function(self, value)
        self.x = value
        if self.javaObj then
            self.javaObj:setX(value)
        end
    end,
    setY = function(self, value)
        self.y = value
        if self.javaObj then
            self.javaObj:setY(value)
        end
    end,
    setWidth = function(self, value)
        self.width = value
        if self.javaObj then
            self.javaObj:setWidth(value)
        end
    end,
    setHeight = function(self, value)
        self.height = value
        if self.javaObj then
            self.javaObj:setHeight(value)
        end
    end,
    setWidthSilent = function(self, value)
        self.width = value
        if self.javaObj then
            self.javaObj:setWidthSilent(value)
        end
    end,
    setHeightSilent = function(self, value)
        self.height = value
        if self.javaObj then
            self.javaObj:setHeightSilent(value)
        end
    end,
    setPivotX = function(self, value)
        self.pivotX = value
        if self.javaObj then
            self.javaObj:setPivotX(value)
        end
    end,
    setPivotY = function(self, value)
        self.pivotY = value
        if self.javaObj then
            self.javaObj:setPivotY(value)
        end
    end,
    setAngle = function(self, value)
        self.angle = value
        if self.javaObj then
            self.javaObj:setAngle(value)
        end
    end,
    setScaleX = function(self, value)
        self.scaleX = value
        if self.javaObj then
            self.javaObj:setScaleX(value)
        end
    end,
    setScaleY = function(self, value)
        self.scaleY = value
        if self.javaObj then
            self.javaObj:setScaleY(value)
        end
    end,
    setColor = function(self, r, g, b, a)
        self.r = r
        self.g = g
        self.b = b
        self.a = a
        if self.javaObj then
            self.javaObj:setColor(r, g, b, a)
        end
    end,
    setVisible = function(self, value)
        self.visible = value
        if self.javaObj then
            self.javaObj:setVisible(value)
        end
    end,
    setEnabled = function(self, value)
        self.enable = value
        if self.javaObj then
            self.javaObj:setEnabled(value)
        end
    end,
    setAlwaysOnTop = function(self, value)
        self.alwaysOnTop = value
        if self.javaObj then
            self.javaObj:setAlwaysOnTop(value)
        end
    end,
    setAlwaysBack = function(self, value)
        self.alwaysBack = value
        if self.javaObj then
            self.javaObj:setAlwaysBack(value)
        end
    end,
    centerOnScreen = function(self, playerNum)
        local x = getPlayerScreenLeft(playerNum) + (getPlayerScreenWidth(playerNum) - self.width) / 2
        local y = getPlayerScreenTop(playerNum) + (getPlayerScreenHeight(playerNum) - self.height) / 2
        self:setX(x)
        self:setY(y)
    end
}