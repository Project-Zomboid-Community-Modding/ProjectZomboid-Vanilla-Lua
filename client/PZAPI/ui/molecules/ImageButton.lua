require "PZAPI/ui/atoms/Texture"
local UI = PZAPI.UI

UI.ImageButton = UI.Texture{
    sounds = {
        activate = "UIActivateButton"
    },
    onHover = function(self, state)
        if state then
            self:setColor(0.4, 0.4, 0.8, 0.8)
        else
            self:setColor(1, 1, 1, 1)
        end
    end,
    onLeftClick = function(self)
        getSoundManager():playUISound(self.sounds.activate)
    end
}