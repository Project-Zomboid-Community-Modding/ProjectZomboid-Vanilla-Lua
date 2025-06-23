require "PZAPI/ui/atoms/Node"
require "PZAPI/ui/molecules/Panel"
require "PZAPI/ui/molecules/ImageButton"
local UI = PZAPI.UI

local tooltipButton = UI.Texture{
    height = 32,
    anchorLeft = 0, anchorRight = 0,
    a = 0,
    children = {
        text = UI.Text{
            y = 16,
            height = 32,
            anchorLeft = 0, anchorRight = 0,
            scaleX = 0.5, scaleY = 0.5,
            pivotY = 0.5, pivotX = 0.5,
            init = function(self)
                self:setText(self.parent.name)
            end
        }
    },
    onLeftClick = function(self)
        self.parent.body:setScaleX(self.parent.body.scaleX + self.scale)
        self.parent.body:setScaleY(self.parent.body.scaleY + self.scale)
        UIManager.RemoveElement(self.parent.javaObj)
    end,
    onMouseButtonUpOutside = function(self)
        UIManager.RemoveElement(self.parent.javaObj)
    end,
    onHover = function(self, val)
        if val then
            self:setColor(1, 1, 1, 0.5)
        else
            self:setColor(1, 1, 1, 0)
        end
    end
}

local WindowSettingsTooltip = UI.Texture{
    r=0, g=0, b=0, a=0.5,
    width = 120, height = 32 * 2,
    children = {
        scale1 = tooltipButton{
            x = 0, y = 0,
            scale = 0.1,
            name = "Scale +10%"
        },
        scale2 = tooltipButton{
            x = 0, y = 32,
            scale = -0.1,
            name = "Scale -10%"
        }
    }
}



UI.Window = UI.Node{
    children = {
        bar = UI.Panel{
            height = 20,
            r = 1, g = 1, b = 1, a = 1,
            anchorLeft = 0, anchorRight = 0,
            texture = getTexture("media/ui/Panel_TitleBar.png"),
            sliceLeft = 1, sliceRight = 1,
            children = {
                closeButton = UI.ImageButton{
                    x = 3, y = 2,
                    width = 16, height = 16,
                    texture = getTexture("media/ui/inventoryPanes/Button_Close.png"),
                    onLeftClick = function(self)
                        getSoundManager():playUISound(self.sounds.activate)
                        UIManager.RemoveElement(self.parent.parent.javaObj)
                    end
                },
                infoButton = UI.ImageButton{
                    x = 25, y = 2,
                    width = 16, height = 16,
                    texture = getTexture("media/ui/inventoryPanes/Button_Info.png"),
                    onLeftClick = function(self)
                        getSoundManager():playUISound(self.sounds.activate)
                        print("Info")
                    end
                },
                settingsButton = UI.ImageButton{
                    x = 46, y = 2,
                    width = 16, height = 16,
                    texture = getTexture("media/ui/inventoryPanes/Button_Settings.png"),
                    onLeftClick = function(self)
                        getSoundManager():playUISound(self.sounds.activate)
                        local pos = self.javaObj:getLuaAbsolutePosition(8, 8)
                        local tooltip = WindowSettingsTooltip{
                            x = pos.x, y = pos.y
                        }
                        tooltip.body = self.parent.parent
                        tooltip:instantiate()
                    end
                },
                pinButton = UI.ImageButton{
                    y = 2,
                    width = 16, height = 16,
                    anchorRight = -10,
                    pinTexture = getTexture("media/ui/inventoryPanes/Button_Pin.png"),
                    collapseTexture = getTexture("media/ui/inventoryPanes/Button_Collapse.png"),
                    init = function(self)
                        self.super.init(self)
                        if self.parent.parent.isPin then
                            self:setTexture(self.pinTexture)
                        else
                            self:setTexture(self.collapseTexture)
                        end
                    end,
                    onLeftClick = function(self)
                        getSoundManager():playUISound(self.sounds.activate)
                        self.parent.parent.isPin = not self.parent.parent.isPin

                        if self.parent.parent.isPin then
                            self:setTexture(self.pinTexture)
                        else
                            self:setTexture(self.collapseTexture)
                        end
                    end
                }
            },
            onLeftDrag = function(self, data, dx, dy)
                self.parent.leftDragX = self.parent.x + dx
                self.parent.leftDragY = self.parent.y + dy
            end,
            onHover = function(self, state)
                if state then
                    self.parent:setCollapsed(false)
                end
            end
        },
        body = UI.Panel{
            anchorLeft = 0, anchorRight = 0, anchorTop = 19, anchorDown = -8
        },
        bottomBar = UI.Panel{
            height = 9,
            r = 1, g = 1, b = 1, a = 1,
            texture = getTexture("media/ui/Panel_TitleBar.png"),
            sliceLeft = 1, sliceRight = 1,
            anchorLeft = 0, anchorRight = 0, anchorDown = 0,
            children = {
                resizeButton = UI.ImageButton{
                    y = 1,
                    width = 7, height = 6,
                    anchorRight = -2,
                    texture = getTexture("media/ui/ResizeIcon.png"),
                    onLeftDrag = function(self, data, dx, dy)
                        local oldW = self.parent.parent.width
                        local oldH = self.parent.parent.height
                        local w = oldW + dx
                        local h = oldH + dy
                        if (w >= 90 or oldW < w) and (h >= 90 or oldH < h) then
                            self.parent.parent.delayResizeW = w
                            self.parent.parent.delayResizeH = h
                        end
                    end
                }
            }
        }
    },
    init = function(self)
        if self.isPin then
            self:setCollapsed(true)
        end
    end,
    renderUpdate = function(self)
        if tonumber(self.delayResizeW) and tonumber(self.delayResizeH) then
            self:setWidth(self.delayResizeW)
            self:setHeight(self.delayResizeH)
            self.delayResizeW = nil
            self.delayResizeH = nil
        end
        if tonumber(self.leftDragX) and tonumber(self.leftDragY) then
            self:setX(self.leftDragX)
            self:setY(self.leftDragY)
            self.leftDragX = nil
            self.leftDragY = nil
        end
    end,
    onMouseButtonDownOutside = function(self)
        if self.isPin then
            self:setCollapsed(true)
        end
    end,
    setCollapsed = function(self, collapsed)
        self.children.body:setVisible(not collapsed)
        self.children.bottomBar:setVisible(not collapsed)
    end
}