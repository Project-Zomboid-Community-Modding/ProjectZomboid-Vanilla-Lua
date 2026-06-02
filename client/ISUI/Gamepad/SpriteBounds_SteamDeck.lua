require "ISBaseObject"

SpriteBounds_SteamDeck = ISBaseObject:derive("SpriteBounds_SteamDeck")
function SpriteBounds_SteamDeck:new()
    local newInstance = {}
    setmetatable(newInstance, self)
    self.__index = self

    newInstance.spriteSheetTexture = ISUITextureGetter:new("media/ui/controllerBindingsEditor/Steamdeck_Controller_Spritesheet.png")
    newInstance.spriteSheetTextureSize = { width = 2048, height = 2048 }

    local spriteBoundsGamepad = newInstance:createSpriteBoundsGeneric(0, 0, 612, 37, 1338, 1949)
    local subTextureWidth = spriteBoundsGamepad.subTextureBounds.width
    spriteBoundsGamepad.leftMargin = -64 / subTextureWidth
    spriteBoundsGamepad.rightMargin = -32 / subTextureWidth

    local subSprites = {}
        subSprites[JoypadButton.Start]        = newInstance:createSpriteBoundsGeneric(1451,   71,  128,  128, 128, 128, CharacterJoypadBindingUI.BevelDirection.Left )
        subSprites[JoypadButton.Back]         = newInstance:createSpriteBoundsGeneric( 981,   70,    0,  128, 128, 128, CharacterJoypadBindingUI.BevelDirection.Right)
        subSprites[JoypadAxis1d.LeftTrigger]  = newInstance:createSpriteBoundsGeneric( 748, 1804,    0, 1272, 256, 133, CharacterJoypadBindingUI.BevelDirection.Left )
        subSprites[JoypadButton.LeftBump]     = newInstance:createSpriteBoundsGeneric( 754, 1863,    0, 1405, 256, 128, CharacterJoypadBindingUI.BevelDirection.Left )
        subSprites[JoypadAxis1d.RightTrigger] = newInstance:createSpriteBoundsGeneric(1561, 1805,  256, 1272, 256, 133, CharacterJoypadBindingUI.BevelDirection.Right)
        subSprites[JoypadButton.RightBump]    = newInstance:createSpriteBoundsGeneric(1554, 1863,  256, 1405, 256, 128, CharacterJoypadBindingUI.BevelDirection.Right)
        subSprites[JoypadButton.B]            = newInstance:createSpriteBoundsGeneric(1694,  160,  128,    0, 128, 128, CharacterJoypadBindingUI.BevelDirection.Left )
        subSprites[JoypadButton.Y]            = newInstance:createSpriteBoundsGeneric(1620,   94,  384,    0, 128, 128, CharacterJoypadBindingUI.BevelDirection.Right)
        subSprites[JoypadButton.A]            = newInstance:createSpriteBoundsGeneric(1620,  229,    0,    0, 128, 128, CharacterJoypadBindingUI.BevelDirection.Left )
        subSprites[JoypadButton.X]            = newInstance:createSpriteBoundsGeneric(1545,  160,  256,    0, 128, 128, CharacterJoypadBindingUI.BevelDirection.Right)
        subSprites[JoypadButton.RightStick]   = newInstance:createSpriteBoundsGeneric(1415,  251,  384,  128, 128, 128, CharacterJoypadBindingUI.BevelDirection.Right)
        subSprites[JoypadAxis2d.RightStick]   = newInstance:createSpriteBoundsGeneric(1415,  251,  384,  640, 128, 128, CharacterJoypadBindingUI.BevelDirection.Left )
        subSprites[JoypadButton.LeftStick]    = newInstance:createSpriteBoundsGeneric(1017,  251,  256,  128, 128, 128, CharacterJoypadBindingUI.BevelDirection.Right)
        subSprites[JoypadAxis2d.LeftStick]    = newInstance:createSpriteBoundsGeneric(1017,  252,  384,  512, 128, 128, CharacterJoypadBindingUI.BevelDirection.Left )
        subSprites[JoypadButton.DPadLeft]     = newInstance:createSpriteBoundsGeneric( 763,  166,  256,  256, 128, 128, CharacterJoypadBindingUI.BevelDirection.Left )
        subSprites[JoypadButton.DPadUp]       = newInstance:createSpriteBoundsGeneric( 807,  121,    0,  256, 128, 128, CharacterJoypadBindingUI.BevelDirection.Left )
        subSprites[JoypadButton.DPadDown]     = newInstance:createSpriteBoundsGeneric( 808,  213,  128,  256, 128, 128, CharacterJoypadBindingUI.BevelDirection.Right)
        subSprites[JoypadButton.DPadRight]    = newInstance:createSpriteBoundsGeneric( 853,  167,  384,  256, 128, 128, CharacterJoypadBindingUI.BevelDirection.Right)
    spriteBoundsGamepad.subSprites = subSprites
    newInstance["Gamepad"] = spriteBoundsGamepad

    local layoutOrderings = {}
        layoutOrderings[CharacterJoypadBindingUI.BindingPanel.TopLeft] = {
            JoypadButton.Back,
            JoypadButton.LeftStick,
            JoypadAxis2d.LeftStick,
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

function SpriteBounds_SteamDeck:createSpriteBoundsGeneric(x, y, subX, subY, width, height, initialBevelDirection)
    local newInstance = ISUISpriteBounds:new(self.spriteSheetTexture,self.spriteSheetTextureSize, { x = subX, y = subY, width = width, height = height})
    newInstance.x = x
    newInstance.y = y
    newInstance.initialBevelDirection = initialBevelDirection
    return newInstance
end
