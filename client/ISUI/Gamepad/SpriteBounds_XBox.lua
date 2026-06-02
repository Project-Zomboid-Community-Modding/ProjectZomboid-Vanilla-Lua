require "ISBaseObject"

SpriteBounds_XBox = ISBaseObject:derive("SpriteBounds_XBox")
function SpriteBounds_XBox:new()
    local newInstance = {}
    setmetatable(newInstance, self)
    self.__index = self

    newInstance.spriteSheetTexture = ISUITextureGetter:new("media/ui/controllerBindingsEditor/XBox_Controller_Spritesheet.png")
    newInstance.spriteSheetTextureSize = { width = 2048, height = 2048 }

    local spriteBoundsGamepad = newInstance:createSpriteBoundsGeneric(0, 0, 258, 258, 1524, 1790)
    local subTextureWidth = spriteBoundsGamepad.subTextureBounds.width
    spriteBoundsGamepad.leftMargin = -64 / subTextureWidth
    spriteBoundsGamepad.rightMargin = -32 / subTextureWidth

    local subSprites = {}
        subSprites[JoypadButton.Start]        = newInstance:createSpriteBoundsGeneric(1075,  488,    0, 129, 130, 127, CharacterJoypadBindingUI.BevelDirection.Left )
        subSprites[JoypadButton.Back]         = newInstance:createSpriteBoundsGeneric( 853,  488,  130, 129, 126, 127, CharacterJoypadBindingUI.BevelDirection.Right)
        subSprites[JoypadAxis1d.LeftTrigger]  = newInstance:createSpriteBoundsGeneric( 441, 1566,    0, 256, 256, 256, CharacterJoypadBindingUI.BevelDirection.Left )
        subSprites[JoypadButton.LeftBump]     = newInstance:createSpriteBoundsGeneric( 438, 1755, 1291,   0, 373, 256, CharacterJoypadBindingUI.BevelDirection.Left )
        subSprites[JoypadAxis1d.RightTrigger] = newInstance:createSpriteBoundsGeneric(1359, 1566,    0, 512, 256, 258, CharacterJoypadBindingUI.BevelDirection.Right)
        subSprites[JoypadButton.RightBump]    = newInstance:createSpriteBoundsGeneric(1240, 1755, 1664,   0, 384, 256, CharacterJoypadBindingUI.BevelDirection.Right)
        subSprites[JoypadButton.B]            = newInstance:createSpriteBoundsGeneric(1444,  487,  130,   0, 126, 129, CharacterJoypadBindingUI.BevelDirection.Left )
        subSprites[JoypadButton.Y]            = newInstance:createSpriteBoundsGeneric(1339,  392,  384,   0, 134, 129, CharacterJoypadBindingUI.BevelDirection.Right)
        subSprites[JoypadButton.A]            = newInstance:createSpriteBoundsGeneric(1339,  582,    0,   0, 130, 129, CharacterJoypadBindingUI.BevelDirection.Left )
        subSprites[JoypadButton.X]            = newInstance:createSpriteBoundsGeneric(1236,  487,  256,   0, 128, 129, CharacterJoypadBindingUI.BevelDirection.Right)
        subSprites[JoypadButton.RightStick]   = newInstance:createSpriteBoundsGeneric(1155,  712,  256, 129, 128, 127, CharacterJoypadBindingUI.BevelDirection.Right)
        subSprites[JoypadAxis2d.RightStick]   = newInstance:createSpriteBoundsGeneric(1155,  712,    0, 770, 128, 127, CharacterJoypadBindingUI.BevelDirection.Left )
        subSprites[JoypadButton.LeftStick]    = newInstance:createSpriteBoundsGeneric( 580,  489,  384, 129, 128, 127, CharacterJoypadBindingUI.BevelDirection.Right)
        subSprites[JoypadAxis2d.LeftStick]    = newInstance:createSpriteBoundsGeneric( 580,  489,  129, 770, 127, 127, CharacterJoypadBindingUI.BevelDirection.Left )
        subSprites[JoypadButton.DPadLeft]     = newInstance:createSpriteBoundsGeneric( 724,  732,  640, 129, 134, 127, CharacterJoypadBindingUI.BevelDirection.Left )
        subSprites[JoypadButton.DPadUp]       = newInstance:createSpriteBoundsGeneric( 765,  688,  512,   0, 128, 129, CharacterJoypadBindingUI.BevelDirection.Left )
        subSprites[JoypadButton.DPadDown]     = newInstance:createSpriteBoundsGeneric( 765,  773,  512, 129, 128, 127, CharacterJoypadBindingUI.BevelDirection.Right)
        subSprites[JoypadButton.DPadRight]    = newInstance:createSpriteBoundsGeneric( 807,  730,  640,   0, 128, 129, CharacterJoypadBindingUI.BevelDirection.Right)
    spriteBoundsGamepad.subSprites = subSprites
    newInstance["Gamepad"] = spriteBoundsGamepad

    local layoutOrderings = {}
        layoutOrderings[CharacterJoypadBindingUI.BindingPanel.TopLeft] = {
            JoypadButton.Back,
            JoypadButton.LeftStick,
            JoypadAxis2d.LeftStick
        }
        layoutOrderings[CharacterJoypadBindingUI.BindingPanel.TopRight] = {
            JoypadButton.Start,
            JoypadButton.X,
            JoypadButton.Y,
            JoypadButton.B,
            JoypadButton.A,
            JoypadButton.RightStick,
            JoypadAxis2d.RightStick
        }
        layoutOrderings[CharacterJoypadBindingUI.BindingPanel.BottomLeft] = {
            JoypadAxis1d.LeftTrigger,
            JoypadButton.LeftBump,
            JoypadButton.DPadLeft,
            JoypadButton.DPadUp,
            JoypadButton.DPadDown,
            JoypadButton.DPadRight
        }
        layoutOrderings[CharacterJoypadBindingUI.BindingPanel.BottomRight] = {
            JoypadAxis1d.RightTrigger,
            JoypadButton.RightBump
        }
    newInstance.layoutOrderings = layoutOrderings

    return newInstance
end

function SpriteBounds_XBox:createSpriteBoundsGeneric(x, y, subX, subY, width, height, initialBevelDirection)
    local newInstance = ISUISpriteBounds:new(self.spriteSheetTexture,self.spriteSheetTextureSize, { x = subX, y = subY, width = width, height = height})
    newInstance.x = x
    newInstance.y = y
    newInstance.initialBevelDirection = initialBevelDirection
    return newInstance
end
