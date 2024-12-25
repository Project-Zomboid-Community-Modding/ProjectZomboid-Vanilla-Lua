require "PZAPI/ui/atoms/Texture"
require "PZAPI/ui/atoms/Node"
require "PZAPI/ui/molecules/Panel"
local UI = PZAPI.UI

UI.ScrollBarVertical = UI.Panel{
    width = 11,
    r = 0, g = 0, b = 0, a = 0.7,
    anchorTop = 1, anchorDown = -1, anchorRight = 0,
    children = {
        top = UI.Texture{
            width = 11, height = 20,
            texture = getTexture("media/ui/Panel_VScroll_ButtonUp.png")
        },
        bottom = UI.Texture{
            width = 11, height = 20,
            anchorDown = 0,
            texture = getTexture("media/ui/Panel_VScroll_ButtonDown.png"),
        },
        bar = UI.Node{
            x = 1, y = 16,
            width = 9, height = 40,
            sizeCoeff = 1,
            children = {
                top = UI.Texture{
                    width = 9, height = 3,
                    texture = getTexture("media/ui/Panel_VScroll_BarTop.png")
                },
                mid = UI.Texture{
                    y = 3,
                    width = 9, height = 34,
                    texture = getTexture("media/ui/Panel_VScroll_BarMid.png"),
                },
                bottom = UI.Texture{
                    y = 37,
                    width = 9, height = 3,
                    texture = getTexture("media/ui/Panel_VScroll_BarBot.png")
                }
            },
            onLeftDrag = function(self, data, dx, dy)
                if self.parent.container == nil then
                    return
                end
                self:setY(self.y + dy)
                if self.y + self.height >= self.parent.y + self.parent.height - 16 then
                    self:setY(-self.height + self.parent.height - 16)
                end
                if self.y < 16 then
                    self:setY(16)
                end
                --local yy = self.y - 16
                --self.parent.container:setY((-yy / self.sizeCoeff) * (self.parent.height) / (self.parent.height - 32) )
                local percent = (self.y - 16) / (self.parent.height - self.height - 16 - 16)
                local yy = percent * (self.parent.container.parent.height - self.parent.container.height)
                self.parent.container:setY(yy)
                return true
            end
        }
    },
    setBarSize = function(self, sizeCoeff)
        if sizeCoeff >= 1 then
            self:setVisible(false)
            self:setEnabled(false)
            return
        end
        self.children.bar.sizeCoeff = sizeCoeff
        self:setVisible(true)
        self:setEnabled(true)
        local size = (self.height - 16 - 16) * sizeCoeff
        size = math.floor(size)
        self.children.bar:setHeight(size)
        self.children.bar.children.mid:setHeight(size - 5)
        self.children.bar.children.bottom:setY(size - 3)
    end,
    updateBar = function(self, percent)
        local delta = self.height - self.children.bar.height - 16 - 16
        self.children.bar:setY(math.floor(delta * percent + 16))
    end
}