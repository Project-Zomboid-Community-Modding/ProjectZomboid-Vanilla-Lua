require "ISBaseObject"
require "defines"

GameOption = ISBaseObject:derive("GameOption")
GameOptions = ISBaseObject:derive("GameOptions")

function GameOption:new(name, control, arg1, arg2)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.name = name
	o.control = control
	o.arg1 = arg1
	o.arg2 = arg2
	if control.isCombobox then
		control.onChange = self.onChangeComboBox
		control.target = o
	end
	if control.isTickBox then
		control.changeOptionMethod = self.onChangeTickBox
		control.changeOptionTarget = o
	end
	if control.isSlider then
		control.targetFunc = self.onChangeVolumeControl
		control.target = o
	end
	if control.Type == "ISTextEntryBox" then
		control.onTextChange = function()
			o.gameOptions:onChange(o)
			if o.onChange then
				o:onChange(control:getInternalText())
			end
		end
	end
	if control.Type == "ISSliderPanel" then
		control.target = o
		control.onValueChange = function(self, val)
			self:invokeOnChangeEvent()
			if self.onChange then
				self:onChange(val)
			end
		end
	end
	return o
end

function GameOption:storeCurrentValue()
end

function GameOption:restoreOriginalValue()
end

function GameOption:toUI()
	print('ERROR: option "'..self.name..'" missing toUI()')
end

function GameOption:apply()
	print('ERROR: option "'..self.name..'" missing apply()')
end

function GameOption:resetLua()
	MainOptions.instance.resetLua = true
end

function GameOption:restartRequired(oldValue, newValue)
	if getCore():getOptionOnStartup(self.name) == nil then
		getCore():setOptionOnStartup(self.name, oldValue)
	end
	if getCore():getOptionOnStartup(self.name) == newValue then
		return
	end
	MainOptions.instance.restartRequired = true
end

function GameOption:invokeOnChangeEvent()
    self.gameOptions:onChange(self)
end

function GameOption:onChangeComboBox(box)
	self:invokeOnChangeEvent()
	if self.onChange then
		self:onChange(box)
	end
end

function GameOption:onChangeSlider(value, control)
	self:invokeOnChangeEvent()
	if self.onChange then
		self:onChange(control, value)
	end
end

function GameOption:onChangeTickBox(index, selected)
	self:invokeOnChangeEvent()
	if self.onChange then
		self:onChange(index, selected)
	end
end

function GameOption:onChangeVolumeControl(control, volume)
	self:invokeOnChangeEvent()
	if self.onChange then
		self:onChange(control, volume)
	end
end

function GameOptions:add(option)
    if (option == nil) then
        DebugType.GameOption:warn("GameOption:add - option is nil.")
        return false
    end

    if (GameOption:instanceof(option) == false) then
        DebugType.GameOption:warn("GameOption:add option not a GameOption: " .. tostring(option.name))
        return false
    end

    if (self:containsOption(option)) then
        DebugType.GameOption:warn("GameOption:add option already added: " .. tostring(option.name))
        return true
    end

    DebugType.GameOption:trace("GameOption:add - Registering option: " .. tostring(option.name))
	option.gameOptions = self
	table.insert(self.options, option)
	return true
end

function GameOptions:tryAdd(option)
    if (option == nil) then
        return false
    end

    if (GameOption:instanceof(option) == false) then
        return false
    end

    return self:add(option)
end

function GameOptions:containsOption(option)
    if (option == nil) then
        return false
    end

    local indexOf = luautils.indexOf(self.options, option)
    return indexOf > -1
end

function GameOptions:remove(option)
    if (option == nil) then
        DebugType.GameOption:warn("GameOption:remove - option is nil.")
        return false
     end

    local indexOf = luautils.remove(self.options, option)
    if (indexOf == -1) then
        DebugType.GameOption:warn("GameOption:remove - option is not in list: " .. tostring(option.name))
        return false
    end

    option.gameOptions = nil
    DebugType.GameOption:debugln("GameOption:remove - option removed: " .. tostring(option.name))
    return true
end

function GameOptions:tryRemove(option)
    if (option == nil) then
        return false
    end

    if (GameOption:instanceof(option) == false) then
        return false
    end

    return self:remove(option)
end

function GameOptions:addAllFromUIElement(uiRootElement)
    DebugType.ISUI:debugln("GameOption:addAllFromUIElement: " .. uiRootElement.Type)
    uiRootElement:visitAndAllDescendants(self, GameOptions.addFromUIElement)
end

function GameOptions:addFromUIElement(uiElement)
    self:tryAdd(uiElement.gameOption)
end

function GameOptions:removeAllFromUIElement(uiRootElement)
    DebugType.ISUI:debugln("GameOption:removeAllFromUIElement: " .. uiRootElement.Type)
    uiRootElement:visitAndAllDescendants(self, GameOptions.removeFromUIElement)
end

function GameOptions:removeFromUIElement(uiElement)
    self:tryRemove(uiElement.gameOption)
end

function GameOptions:get(optionName)
	for _,option in ipairs(self.options) do
		if option.name == optionName then
			return option
		end
	end
	return nil
end

function GameOptions:apply()
	for _,option in ipairs(self.options) do
		option:apply()
	end
	self.changed = false
end

function GameOptions:storeCurrentValues()
	for _,option in ipairs(self.options) do
		option:storeCurrentValue()
	end
end

function GameOptions:restoreOriginalValues()
	for _,option in ipairs(self.options) do
		option:restoreOriginalValue()
	end
end

function GameOptions:toUI()
	for _,option in ipairs(self.options) do
		option:toUI()
	end
	self.changed = false
end

function GameOptions:onChange(option)
	self.changed = true
end

function GameOptions:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.options = {}
	o.changed = false
	return o
end
