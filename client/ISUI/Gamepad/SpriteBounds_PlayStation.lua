require "ISBaseObject"

SpriteBounds_PlayStation = ISBaseObject:derive("SpriteBounds_PlayStation")
function SpriteBounds_PlayStation:new()
    local newInstance = {}
    setmetatable(newInstance, self)
    self.__index = self

    newInstance.spriteSheetTexture = ISUITextureGetter:new("media/ui/controllerBindingsEditor/PS5_Controller_Spritesheet.png")
    newInstance.spriteSheetTextureSize = { width = 2048, height = 2048 }

    local spriteBoundsGamepad = newInstance:createSpriteBoundsGeneric(0, 0, 256, 288, 1536, 1662)
    local subTextureWidth = spriteBoundsGamepad.subTextureBounds.width
    spriteBoundsGamepad.leftMargin = -64 / subTextureWidth
    spriteBoundsGamepad.rightMargin = -32 / subTextureWidth

    local subSprites = {}
        subSprites[JoypadButton.Start]        = newInstance:createSpriteBoundsGeneric(1305,  339,  128,  128, 128, 128, CharacterJoypadBindingUI.BevelDirection.Left )
        subSprites[JoypadButton.Back]         = newInstance:createSpriteBoundsGeneric( 615,  338,    0,  128, 128, 128, CharacterJoypadBindingUI.BevelDirection.Right)
        subSprites[JoypadAxis1d.LeftTrigger]  = newInstance:createSpriteBoundsGeneric( 415, 1333, 1280,    0, 256, 256, CharacterJoypadBindingUI.BevelDirection.Left )
        subSprites[JoypadButton.LeftBump]     = newInstance:createSpriteBoundsGeneric( 410, 1512, 1024,    0, 256, 256, CharacterJoypadBindingUI.BevelDirection.Right)
        subSprites[JoypadAxis1d.RightTrigger] = newInstance:createSpriteBoundsGeneric(1376, 1333, 1792,    0, 256, 256, CharacterJoypadBindingUI.BevelDirection.Right)
        subSprites[JoypadButton.RightBump]    = newInstance:createSpriteBoundsGeneric(1382, 1512, 1536,    0, 256, 256, CharacterJoypadBindingUI.BevelDirection.Left )
        subSprites[JoypadButton.B]            = newInstance:createSpriteBoundsGeneric(1531,  514,  128,    0, 128, 128, CharacterJoypadBindingUI.BevelDirection.Left )
        subSprites[JoypadButton.Y]            = newInstance:createSpriteBoundsGeneric(1422,  407,  384,    0, 128, 128, CharacterJoypadBindingUI.BevelDirection.Right)
        subSprites[JoypadButton.A]            = newInstance:createSpriteBoundsGeneric(1421,  622,    0,    0, 128, 128, CharacterJoypadBindingUI.BevelDirection.Left )
        subSprites[JoypadButton.X]            = newInstance:createSpriteBoundsGeneric(1314,  515,  256,    0, 128, 128, CharacterJoypadBindingUI.BevelDirection.Right)
        subSprites[JoypadButton.RightStick]   = newInstance:createSpriteBoundsGeneric(1198,  717,  256,  128, 128, 128, CharacterJoypadBindingUI.BevelDirection.Right)
        subSprites[JoypadAxis2d.RightStick]   = newInstance:createSpriteBoundsGeneric(1198,  717,    0,  256, 128, 128, CharacterJoypadBindingUI.BevelDirection.Left )
        subSprites[JoypadButton.LeftStick]    = newInstance:createSpriteBoundsGeneric( 722,  717,  384,  128, 128, 128, CharacterJoypadBindingUI.BevelDirection.Right)
        subSprites[JoypadAxis2d.LeftStick]    = newInstance:createSpriteBoundsGeneric( 722,  717,  128,  256, 128, 128, CharacterJoypadBindingUI.BevelDirection.Left )
        subSprites[JoypadButton.DPadLeft]     = newInstance:createSpriteBoundsGeneric( 425,  514,  640,  128, 128, 128, CharacterJoypadBindingUI.BevelDirection.Left )
        subSprites[JoypadButton.DPadUp]       = newInstance:createSpriteBoundsGeneric( 498,  443,  512,    0, 128, 128, CharacterJoypadBindingUI.BevelDirection.Left )
        subSprites[JoypadButton.DPadDown]     = newInstance:createSpriteBoundsGeneric( 498,  587,  512,  128, 128, 128, CharacterJoypadBindingUI.BevelDirection.Right)
        subSprites[JoypadButton.DPadRight]    = newInstance:createSpriteBoundsGeneric( 571,  514,  640,    0, 128, 128, CharacterJoypadBindingUI.BevelDirection.Right)
    spriteBoundsGamepad.subSprites = subSprites
    newInstance["Gamepad"] = spriteBoundsGamepad

    local layoutOrderings = {}
        layoutOrderings[CharacterJoypadBindingUI.BindingPanel.TopLeft] = {
            JoypadButton.LeftStick,
            JoypadAxis2d.LeftStick,
            JoypadButton.Back,
            JoypadButton.DPadRight,
            JoypadButton.DPadDown,
            JoypadButton.DPadUp,
            JoypadButton.DPadLeft,
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
        }
        layoutOrderings[CharacterJoypadBindingUI.BindingPanel.BottomRight] = {
            JoypadAxis1d.RightTrigger,
            JoypadButton.RightBump
        }
    newInstance.layoutOrderings = layoutOrderings

    return newInstance
end

function SpriteBounds_PlayStation:createSpriteBoundsGeneric(x, y, subX, subY, width, height, initialBevelDirection)
    local newInstance = ISUISpriteBounds:new(self.spriteSheetTexture,self.spriteSheetTextureSize, { x = subX, y = subY, width = width, height = height})
    newInstance.x = x
    newInstance.y = y
    newInstance.initialBevelDirection = initialBevelDirection
    return newInstance
end
