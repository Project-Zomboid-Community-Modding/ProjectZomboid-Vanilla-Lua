Fishing = Fishing or {}

Fishing.ISTensionUI = ISUIElement:derive("ISTensionUI")
local ISTensionUI = Fishing.ISTensionUI

function ISTensionUI:initialise()
    ISUIElement.initialise(self);
end

function ISTensionUI:prerender()
    local offX = isoToScreenX(self.playerIndex, self.player:getX(), self.player:getY(), self.player:getZ() + 0.6) - getCore():getScreenWidth() / 2
    local offY = isoToScreenY(self.playerIndex, self.player:getX(), self.player:getY(), self.player:getZ() + 0.6) - getCore():getScreenHeight() / 2

    self:drawTextureScaled(self.bckgTex, offX, offY + 60, 120, 120, 1, 1, 1, 1);
end

function ISTensionUI:render()
    local offX = isoToScreenX(self.playerIndex, self.player:getX(), self.player:getY(), self.player:getZ() + 0.6) - getCore():getScreenWidth() / 2
    local offY = isoToScreenY(self.playerIndex, self.player:getX(), self.player:getY(), self.player:getZ() + 0.6) - getCore():getScreenHeight() / 2

    self:DrawTextureAngle(self.tex, 60 + offX, 60 + offY + 60, self.val);
end

function ISTensionUI:updateValue(val)
    if val < 0 then
        self.val = -70 + 20*(1+val)
    else
        if val > 1 then val = 1 end
        self.val = -50 + 120*val
    end
end

function ISTensionUI:new(player)
    local o = ISUIElement:new((getCore():getScreenWidth() / 2) - 60, (getCore():getScreenHeight() / 2) - 60 - 40, 100, 300);
    setmetatable(o, self)
    self.__index = self

    o.playerIndex = player:getPlayerNum()
    o.player = player
    o.val = 0

    o.tex = getTexture("media/ui/PointTensionN.png")
    o.bckgTex = getTexture("media/ui/ScaleTensionN.png")    -- 120 120

    return o
end
