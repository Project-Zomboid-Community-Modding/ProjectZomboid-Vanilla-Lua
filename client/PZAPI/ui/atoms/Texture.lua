require "PZAPI/ui/atoms/Node"
local UI = PZAPI.UI

UI.Texture = UI.Node{
    _ATOM_UI_CLASS = AtomUITexture,
    texture = nil,
    sliceLeft = 0, sliceRight = 0, sliceTop = 0, sliceDown = 0,
    animDelay = 0, animFrameNum = 0, animFrameRows = 0, animFrameColumns = 0,
    setTexture = function(self, texture)
        self.texture = texture
        if self.javaObj then
            self.javaObj:setTexture(texture)
        end
    end,
    setSlice9 = function(self, sliceLeft, sliceRight, sliceTop, sliceDown)
        self.sliceLeft = sliceLeft
        self.sliceRight = sliceRight
        self.sliceTop = sliceTop
        self.sliceDown = sliceDown
        if self.javaObj then
            self.javaObj:setSlice9(sliceLeft, sliceRight, sliceTop, sliceDown)
        end
    end,
    setAnimValues = function(self, animDelay, animFrameNum, animFrameRows, animFrameColumns)
        self.animDelay = animDelay
        self.animFrameNum = animFrameNum
        self.animFrameRows = animFrameRows
        self.animFrameColumns = animFrameColumns
        if self.javaObj then
            self.javaObj:setAnimValues(animDelay, animFrameNum, animFrameRows, animFrameColumns)
        end
    end
}