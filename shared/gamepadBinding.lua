
-- Customize bindings for Gamepad here.
-- These are the enums you have access to:
-- enum JoypadButton {
--     A,
--     B,
--     X,
--     Y,
--     LeftStick,
--     RightStick,
--     LeftBump,
--     RightBump,
--
-- enum JoypadAxis1d {
--     LeftTrigger,
--     RightTrigger;
--
-- enum JoypadAxis2d {
--     LeftStick,
--     RightStick;
--
-- And these are the enums you modify, by calling setBinding on them:
-- enum CharacterJoypadButtonBinding {
--     Aim(CharacterJoypadAxis2dBinding.Aiming, CharacterInputComponent.GAMEPAD_AIM_VALUE_MIN, Float.MAX_VALUE),
--     PrecisionAim(JoypadAxis1d.RightTrigger, CharacterInputComponent.GAMEPAD_MIN_VALUE_TRIGGER_AIMING, Float.MAX_VALUE),
--     Melee(JoypadAxis1d.LeftTrigger, CharacterInputComponent.GAMEPAD_MIN_VALUE_TRIGGER_MELEE, Float.MAX_VALUE),
--     Attack(JoypadAxis1d.RightTrigger, CharacterInputComponent.GAMEPAD_MIN_VALUE_TRIGGER_SHOOT, Float.MAX_VALUE),
--     Run(CharacterJoypadAxis2dBinding.Movement, CharacterInputComponent.GAMEPAD_MIN_VALUE_RUN, Float.MAX_VALUE),
--     Interact(JoypadButton.A),
--     WalkTo(),
--     Crouch(JoypadButton.LeftStick),
--     ReloadWeapon(JoypadButton.RightBump),
--     RackFirearm(JoypadButton.LeftBump),
--     Sprint(JoypadButton.RightStick),
--     CancelAction(JoypadButton.B),
--     ManualFloorAtk(),
--
-- enum CharacterJoypadAxis2dBinding {
--     Movement(JoypadAxis2d.LeftStick),
--     Aiming(JoypadAxis2d.RightStick);

-- Eg:
-- -- Swap the sticks
-- CharacterJoypadAxis2dBinding.Movement:setBinding(JoypadAxis2d.RightStick)
-- CharacterJoypadAxis2dBinding.Aiming:setBinding(JoypadAxis2d.LeftStick)
--
-- -- Assign buttons
-- CharacterJoypadButtonBinding.Aim:setBinding(JoypadButton.A)
-- CharacterJoypadButtonBinding.PrecisionAim:setBinding(JoypadButton.RightBump)
-- CharacterJoypadButtonBinding.Melee:setBinding(JoypadButton.LeftBump)
-- CharacterJoypadButtonBinding.Attack:setBinding(JoypadAxis1d.LeftTrigger, -0.95)
-- CharacterJoypadButtonBinding.Run:setBinding(JoypadButton.B)
-- CharacterJoypadButtonBinding.Interact:setBinding(JoypadButton.X)
-- CharacterJoypadButtonBinding.WalkTo:setBinding(nil)
-- CharacterJoypadButtonBinding.Crouch:setBinding(JoypadButton.Y)
-- CharacterJoypadButtonBinding.ReloadWeapon:setBinding(nil)
-- CharacterJoypadButtonBinding.RackFirearm:setBinding(nil)
-- CharacterJoypadButtonBinding.Sprint:setBinding(JoypadButton.RightBump)
-- CharacterJoypadButtonBinding.CancelAction:setBinding(nil)
-- CharacterJoypadButtonBinding.ManualFloorAtk:setBinding(nil)

gamepadBinding = {}
gamepadBinding.presets = {}

function gamepadBinding:set(presetKey)
    getCore():setOptionGamepadBindingPreset(presetKey)
end

function gamepadBinding:saveAll()
    CharacterInputBindingSet.saveAll()
end

function gamepadBinding.optionGamepadBindingPresetChanged()
    gamepadBinding:setCurrentPresetToConfigOption()
end

function gamepadBinding:setCurrentPresetToConfigOption()
    local presetKey = self:getCurrentActivePresetName()
    local preset = self.presets[presetKey]
    if (preset == nil) then
        DebugType.General:warn("Gamepad preset not found: '" .. presetKey .. "'. Resetting to Default")
        self:set("Default")
        return
    end

    DebugType.General:debugln("Assigning Gamepad preset: '" .. presetKey .. "'")
    preset:perform()
    self.currentPreset = preset
end

function gamepadBinding:resetCurrentToDefault()
    CharacterInputBindingSet:resetAllToDefault()
end

function gamepadBinding:isCurrentBinding(presetKey)
    return self:getCurrentActivePresetName() == presetKey
end

function gamepadBinding:getCurrentActivePresetName()
    return getCore():getOptionGamepadBindingPreset() or ""
end

function gamepadBinding:isCurrentPresetEditable()
    local currentBinding = self.currentPreset
    return currentBinding ~= nil and currentBinding.loadedSet ~= nil
end

function gamepadBinding:onCurrentSetEdited()
    if (self:isCurrentPresetEditable() == false) then return end
    self.currentPreset.loadedSet:setBindingsToCurrent()
end

function gamepadBinding:populateFromLoadedSets()
    -- Preserve non-loaded, lua-only sets
    local luaSets = {}
    for key,preset in pairs(self.presets) do
        if (preset.loadedSet == nil) then
            luaSets[key] = preset
        end
    end

    self.presets = luaSets

    -- Populate from loaded sets
    local loadedSets = CharacterInputBindingSet:getLoadedBindingSets()
    if (loadedSets ~= nil) then
        for _,inputSet in ipairs(loadedSets) do
            self:addInputSet(inputSet)
        end
    end
end

function gamepadBinding:addInputSet(inputSet)
    local setName = inputSet:getName();
    DebugType.Lua:debugln("Registering CharacterInputBindingSet: " .. setName)
    local setEntry = {
        key = setName,
        loadedSet = inputSet,
        labelText = setName,
        descriptionText = inputSet:getDescription() or "",
        perform = function(self)
            self.loadedSet:apply()
        end
     }
    self.presets[setName] = setEntry
    return setEntry
end

function gamepadBinding:createNewFromCurrent()
    DebugType.Lua:debugln("Creating new CharacterInputBindingSet...")
    local newSet = CharacterInputBindingSet.createNewFromCurrent(nil)
    return self:addInputSet(newSet)
end

gamepadBinding.presets["Default"] = {
        key = "Default",
        labelText = "UI_optionscreen_gamepad_preset_Default_Label",
        descriptionText = "UI_optionscreen_gamepad_preset_Default_Description",
        perform = function()
            CharacterInputBindingSet:resetAllToDefault()
        end
    }

gamepadBinding.presets["Original"] = {
        key = "Original",
        labelText = "UI_optionscreen_gamepad_preset_Original_Label",
        descriptionText = "UI_optionscreen_gamepad_preset_Original_Description",
        perform = function()
            CharacterInputBindingSet:resetAllToDefault()
            CharacterJoypadButtonBinding.Run:setBinding(JoypadAxis1d.RightTrigger, 0.01)
            CharacterJoypadButtonBinding.Sprint:setBinding(JoypadButton.B)
            CharacterJoypadButtonBinding.PrecisionAim:setBinding(JoypadAxis2d.RightStick, .01, 2)
        end
    }

gamepadBinding:populateFromLoadedSets()
gamepadBinding:setCurrentPresetToConfigOption()
Events.OptionGamepadBindingPresetChanged.Add(gamepadBinding.optionGamepadBindingPresetChanged);
