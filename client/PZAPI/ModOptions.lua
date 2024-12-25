PZAPI = PZAPI or {}
PZAPI.ModOptions = {}
PZAPI.ModOptions.Data = {}
PZAPI.ModOptions.Dict = {}
PZAPI.ModOptions.OtherOptions = {}

PZAPI.ModOptions.Options = {}
local Options = PZAPI.ModOptions.Options

function Options:new(modOptionsID, name)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.data = {}
    o.dict = {}
    o.modOptionsID = modOptionsID
    o.name = name
    return o
end

function Options:apply()
end

function Options:getOption(id)
    return self.dict[id]
end

function Options:addTitle(name)
    table.insert(self.data, { type = "title", name = name })
end

function Options:addDescription(text)
    table.insert(self.data, { type = "description", text = getText(text) })
end

function Options:addSeparator()
    table.insert(self.data, { type = "separator" })
end

function Options:addTextEntry(id, name, value, _tooltip)
    local option = { type = "textentry", id = id, name = name, value = value, tooltip = _tooltip, isEnabled = true }

    option.getValue = function(self) return self.value end
    option.setValue = function(self, value)
        self.value = value
        if self.element ~= nil then
            self.element:setText(value)
        end
    end
    option.setEnabled = function(self, bool)
        self.isEnabled = bool
        if self.element ~= nil then
            self.element:setEditable(bool)
        end
    end

    table.insert(self.data, option)
    self.dict[id] = option
    return option
end

function Options:addTickBox(id, name, value, _tooltip)
    local option = { type = "tickbox", id = id, name = name, value = value, tooltip = _tooltip, isEnabled = true }

    option.getValue = function(self) return self.value end
    option.setValue = function(self, value)
        self.value = value
        if self.element ~= nil then
            self.element:setSelected(1, value)
        end
    end
    option.setEnabled = function(self, bool)
        self.isEnabled = bool
        if self.element ~= nil then
            self.element:disableOption("", not bool)
        end
    end

    table.insert(self.data, option)
    self.dict[id] = option
    return option
end

function Options:addMultipleTickBox(id, name, _tooltip)
    local option = {}
    option.type = "multipletickbox"
    option.id = id
    option.name = name
    option.tooltip = _tooltip
    option.values = {}
    option.nameToIndex = {}
    option.addTickBox = function(self, name, value)
        table.insert(self.values, { name = name, value = value, isEnabled = true })
        self.nameToIndex[name] = #self.values
    end
    option.setEnabled = function(self, optionName, value)
        self.values[self.nameToIndex[optionName]].isEnabled = value
        if self.element ~= nil then
            self.element:disableOption(optionName, not value)
        end
    end
    option.getValue = function(self, index) return self.values[index].value end
    option.setValue = function(self, index, value)
        self.values[index].value = value
        if self.element ~= nil then
            self.element:setSelected(index, value)
        end
    end

    table.insert(self.data, option)
    self.dict[id] = option
    return option
end

function Options:addComboBox(id, name, _tooltip)
    local option = {}
    option.type = "combobox"
    option.id = id
    option.name = name
    option.tooltip = _tooltip
    option.isEnabled = {}
    option.values = {}
    option.selected = 1

    option.addItem = function(self, name, _isSelected)
        table.insert(self.values, getText(name))
        if _isSelected then
            self.selected = #self.values
        end
    end
    option.getValue = function(self) return self.selected end
    option.setValue = function(self, value)
        self.selected = value
        if self.element ~= nil then
            self.element.selected = value
        end
    end
    option.setEnabled = function(self, bool)
        self.isEnabled = bool
        if self.element ~= nil then
            self.element.disabled = not bool
        end
    end

    table.insert(self.data, option)
    self.dict[id] = option
    return option
end

function Options:addColorPicker(id, name, r, g, b, a, _tooltip)
    local option = { type = "colorpicker", id = id, name = name, color = { r = r, g = g, b = b, a = a }, tooltip = _tooltip, isEnabled = true }

    option.setEnabled = function(self, bool)
        self.isEnabled = bool
        if self.element ~= nil then
            self.element:setEnable(bool)
        end
    end
    option.getValue = function(self) return self.color end
    option.setValue = function(self, color)
        self.color = color
        if self.element ~= nil then
            self.element.backgroundColor = self.color
        end
    end

    table.insert(self.data, option)
    self.dict[id] = option
    return option
end

function Options:addKeyBind(id, name, key, _tooltip)
    local option = { type = "keybind", id = id, name = name, tooltip = _tooltip, key = key, defaultkey = key, isEnabled = true }

    option.setEnabled = function(self, bool)
        self.isEnabled = bool
        if self.element ~= nil then
            self.element:setEnable(bool)
        end
    end
    option.getValue = function(self) return self.key end
    option.setValue = function(self, key)
        self.key = key
        if self.element ~= nil then
            self.element.keyCode = key
        end
    end

    table.insert(self.data, option)
    self.dict[id] = option
    return option
end

function Options:addSlider(id, name, min, max, step, value, _tooltip)
    local option = { type = "slider", id = id, name = name, tooltip = _tooltip, min = min, max = max, step = step, value = value, isEnabled = true }

    option.setEnabled = function(self, bool)
        self.isEnabled = bool
        if self.element ~= nil then
            self.element.disabled = not bool
        end
    end
    option.getValue = function(self) return self.value end
    option.setValue = function(self, value)
        self.value = value
        if self.element ~= nil then
            self.element:setCurrentValue(value, true)
        end
    end

    table.insert(self.data, option)
    self.dict[id] = option
    return option
end

function Options:addButton(id, name, tooltip, onclickfunc, target, arg1, arg2, arg3, arg4)
    local option = { type = "button", id = id, name = name, tooltip = tooltip, onclick = onclickfunc, target = target, args = { arg1, arg2, arg3, arg4 }, isEnabled = true }

    option.setEnabled = function(self, bool)
        self.isEnabled = bool
        if self.element ~= nil then
            self.element:setEnable(bool)
        end
    end

    table.insert(self.data, option)
    self.dict[id] = option
    return option
end

-----------

function PZAPI.ModOptions:create(modOptionsID, name)
    name = name or modOptionsID
    local options = Options:new(modOptionsID, name)
    table.insert(PZAPI.ModOptions.Data, options)
    PZAPI.ModOptions.Dict[modOptionsID] = options
    return options
end

function PZAPI.ModOptions:getOptions(modOptionsID)
    return PZAPI.ModOptions.Dict[modOptionsID]
end

function PZAPI.ModOptions:save()
    local fileOutput = getFileWriter("ModOptions.ini", true, false)
    for _, options in ipairs(self.Data) do
        for _, option in ipairs(options.data) do
            if option.getValue ~= nil then
                local data = option.type .. "|" .. options.modOptionsID .. "|" .. option.id .. "|"
                if option.type == "textentry" or option.type == "tickbox" or option.type == "slider" then
                    data = data .. tostring(option.value)
                elseif option.type == "multipletickbox" then
                    for _, v in ipairs(option.values) do
                        data = data .. tostring(v.value) .. " "
                    end
                    data = data
                elseif option.type == "combobox" then
                    data = data .. tostring(option.selected)
                elseif option.type == "colorpicker" then
                    data = data .. tostring(option.color.r) .. " " .. tostring(option.color.g) .. " " .. tostring(option.color.b) .. " " .. tostring(option.color.a)
                elseif option.type == "keybind" then
                    if option.element ~= nil then
                        option.key = option.element.keyCode
                    end
                    data = data .. tostring(tonumber(option.key))
                end
                fileOutput:write(data .. "\r\n")
            end
        end
    end
    for i, line in ipairs(PZAPI.ModOptions.OtherOptions) do
        fileOutput:write(line)
    end
    fileOutput:close()
end

function PZAPI.ModOptions:load()
    local stringtoboolean = { ["true"] = true, ["false"] = false }
    PZAPI.ModOptions.OtherOptions = {}

    local file = getFileReader("modOptions.ini", true)
    local line = nil
    while true do
        line = file:readLine()
        if line == nil then
            file:close();
            break;
        end
        local t = luautils.split(line, "|")
        if PZAPI.ModOptions.Dict[t[2]] ~= nil and PZAPI.ModOptions.Dict[t[2]].dict[t[3]] ~= nil then
            if t[1] == "textentry" and t[4] ~= "" then
                PZAPI.ModOptions.Dict[t[2]].dict[t[3]].value = t[4]
            elseif t[1] == "tickbox" and stringtoboolean[t[4]] ~= nil then
                PZAPI.ModOptions.Dict[t[2]].dict[t[3]].value = stringtoboolean[t[4]]
            elseif t[1] == "slider" and tonumber(t[4]) ~= nil then
                PZAPI.ModOptions.Dict[t[2]].dict[t[3]].value = tonumber(t[4])
            elseif t[1] == "multipletickbox" then
                local t2 = luautils.split(t[4], " ")
                for i, v in ipairs(t2) do
                    if stringtoboolean[v] ~= nil and PZAPI.ModOptions.Dict[t[2]].dict[t[3]].values[i] ~= nil then
                        PZAPI.ModOptions.Dict[t[2]].dict[t[3]].values[i].value = stringtoboolean[v]
                    end
                end
            elseif t[1] == "combobox" and tonumber(t[4]) ~= nil then
                PZAPI.ModOptions.Dict[t[2]].dict[t[3]].selected = tonumber(t[4])
            elseif t[1] == "colorpicker" then
                local t2 = luautils.split(t[4], " ")
                if #t2 == 4 and tonumber(t2[1]) ~= nil and tonumber(t2[2]) ~= nil and tonumber(t2[3]) ~= nil and tonumber(t2[4]) ~= nil then
                    PZAPI.ModOptions.Dict[t[2]].dict[t[3]].color = { r = tonumber(t2[1]), g = tonumber(t2[2]), b = tonumber(t2[3]), a = tonumber(t2[4]) }
                end
            elseif t[1] == "keybind" and tonumber(t[4]) then
                PZAPI.ModOptions.Dict[t[2]].dict[t[3]].key = tonumber(t[4])
            end
        else
            table.insert(PZAPI.ModOptions.OtherOptions, line)
        end
    end
end