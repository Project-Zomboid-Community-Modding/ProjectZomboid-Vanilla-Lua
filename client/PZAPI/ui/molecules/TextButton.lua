require "PZAPI/ui/atoms/Text"
require "PZAPI/ui/molecules/Panel"
local UI = PZAPI.UI

UI.TextButton = UI.Panel{
    children = {
        label = UI.Text{
            pivotX = 0.5, pivotY = 0.5,
            scaleX = 0.5, scaleY = 0.5,
            anchorRight = 0, anchorLeft = 0, anchorTop = 0, anchorDown = 0
        }
    },
    sounds = {
        activate = "UIActivateButton"
    },
    onHover = function(self, state)
        if state then
            self:setColor(0.1, 0.1, 0.1, 0.7)
        else
            self:setColor(0, 0, 0, 0.7)
        end
    end,
    onLeftClick = function(self)
        getSoundManager():playUISound(self.sounds.activate)
    end
}