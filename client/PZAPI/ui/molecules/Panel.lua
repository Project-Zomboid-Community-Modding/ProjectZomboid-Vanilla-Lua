require "PZAPI/ui/atoms/Texture"
local UI = PZAPI.UI

UI.Panel = UI.Texture{
    r=0, g=0, b=0, a=0.7,
    children = {
        leftBorder = UI.Texture{
            width = 1,
            pivotX = 0, pivotY = 0.5,
            anchorLeft = 0, anchorTop = 0, anchorDown = 0
        },
        rightBorder = UI.Texture{
            width = 1,
            pivotX = 1, pivotY = 0.5,
            anchorRight = 0, anchorTop = 0, anchorDown = 0
        },
        topBorder = UI.Texture{
            height = 1,
            pivotX = 0.5, pivotY = 0,
            anchorLeft = 0, anchorTop = 0, anchorRight = 0
        },
        downBorder = UI.Texture{
            height = 1,
            pivotX = 0.5, pivotY = 1,
            anchorLeft = 0, anchorRight = 0, anchorDown = 0
        }
    },
    setBorderColor = function(self, r, g, b, a)
        self.children.leftBorder:setColor(r, g, b, a)
        self.children.rightBorder:setColor(r, g, b, a)
        self.children.topBorder:setColor(r, g, b, a)
        self.children.downBorder:setColor(r, g, b, a)
    end,
    init = function(self)
        self:setBorderColor(0.4, 0.4, 0.4, 1)
    end
}