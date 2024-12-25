require "pzapi/ui/ui"
local UI = PZAPI.UI

PZAPI.TESTUI = PZAPI.TESTUI or {}
local TESTUI = PZAPI.TESTUI

TESTUI.show = function()
    if TESTUI.element then
        UIManager.RemoveElement(TESTUI.element.javaObj)
        TESTUI.element = nil
    end

    local element = UI.node{
        x = 1300, y = 100,
        width = 300, height = 200,
        pivotX = 0.2, pivotY = 0.2,
        isStencil = true,

        background = UI.texture{
            r = 1, g = 1, b = 0.5, a = 0.9,
            texture = getTexture("media/ui/slice9TEST.png"),
            sliceLeft = 38, sliceRight = 38, sliceTop = 40, sliceDown = 40,

            anchor = UI.extensions.anchorSide{
                left = 0, right = 0, top = 0, down = 0
            }
        },

        entry = UI.textEntry{
            font = UIFont.SdfOldBold,
            text = "",
            scaleX = 1.4, scaleY = 1.4,
            isMultiline = true,

            onMouseWheel = function(self, del)
                self:setColor(ZombRand(255)/255, ZombRand(255)/255, ZombRand(255)/255, 1)
                return true
            end,

            anchor = UI.extensions.anchorSide{
                left = 40, right = -40, top = 40, down = -40
            }
        },

        onMouseWheel = function(self, del)
            self:setScaleX(self.scaleX + 0.1 * del)
            self:setScaleY(self.scaleY + 0.1 * del)
            return true
        end,

        mouse = UI.extensions.mouse{
            onLeftDrag = function(self, data, dx, dy)
                if data.w == nil then
                    data.w = self.width
                    data.h = self.height
                end
                local a = self.javaObj:getLuaLocalPosition(data.startX, data.startY)
                local b = self.javaObj:getLuaLocalPosition(data.lastX, data.lastY)
                local diff = {x = b.x - a.x, y = b.y - a.y}
                self:setWidth(data.w + diff.x)
                self:setHeight(data.h + diff.y)
            end,

            onRightDrag = function(self, data, dx, dy)
                self:setX(self.x + dx)
                self:setY(self.y + dy)
            end,

            onMiddleDrag = function(self, data, dx, dy)
                if data.pivAbs == nil then
                    data.pivAbs = self.javaObj:getLuaAbsolutePosition(self.width * self.pivotX, self.height * self.pivotY)
                    data.oldAngle = self.angle
                    data.vecA = {x = data.startX - data.pivAbs.x, y = data.startY - data.pivAbs.y}
                end
                local vecB = {x = data.lastX - data.pivAbs.x, y = data.lastY - data.pivAbs.y}

                local dot = data.vecA.x * vecB.x + data.vecA.y * vecB.y
                local det = data.vecA.x * vecB.y - data.vecA.y * vecB.x
                local angle = math.atan2(det, dot)

                self:setAngle(data.oldAngle - angle * 57.3 )
            end
        }
    }

    element:init()
    element:setAlwaysOnTop(true)
    TESTUI.element = element
end

TESTUI.show2 = function()
    if TESTUI.element then
        UIManager.RemoveElement(TESTUI.element.javaObj)
        TESTUI.element = nil
    end

    local element = UI.window{
        x = 1300, y = 100,
        width = 400, height = 500,

        body = UI.window.body{
            anim = UI.texture{
                x = 30, y = 30,
                texture = getTexture("media/ui/UI_ANIMTEST.png"),
                width = 300, height = 200,
                animDelay = 100, animFrameNum = 29, animFrameRows = 6, animFrameColumns = 5,
            },

            playButton = UI.button{
                x = 20, y = 250,
                height = 40, width = 100,
                label = UI.button.label{
                    text = "Play"
                },
                onLeftClick = function(self)
                    self.parent.anim.javaObj:animPlay()
                end
            },

            pauseButton = UI.button{
                x = 130, y = 250,
                height = 40, width = 100,
                label = UI.button.label{
                    text = "Pause"
                },
                onLeftClick = function(self)
                    self.parent.anim.javaObj:animPause()
                end
            }
        }
    }

    element:init()
    element:setAlwaysOnTop(true)
    TESTUI.element = element
end