--***********************************************************
--**                      Aiteron                          **
--***********************************************************

require "OptionScreens/ModSelector/ModSelector"

ModSelector.Model = {}

ModSelector.Model.categories = {}
ModSelector.Model.categories[""] = ""
ModSelector.Model.categories["map"] = "Item_Map"
ModSelector.Model.categories["vehicle"] = "Item_CarTire"
ModSelector.Model.categories["features"] = "Item_ElectronicsScrap"
ModSelector.Model.categories["modpack"] = "Item_SewingBox"

function ModSelector.Model:new(view)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.view = view
    o.mods = {}
    o.sortedMods = {}
    o.presets = {}
    o.favs = {}
    o.currentMods = {}
    o.isUnsupportedModsVisible = false

    o.mapGroups = MapGroups.new()
    return o
end

function ModSelector.Model:showUnsupportedMods(value)
    self.isUnsupportedModsVisible = value
    self.view:updateView()
end

function ModSelector.Model:setExistingSavefile(folder)
    local activeMods = getSaveInfo(folder).activeMods or ActiveMods.getById("default")
    ActiveMods.getById("currentGame"):copyFrom(activeMods)
    self.loadGameFolder = folder
end

function ModSelector.Model:setServerSettingsMods(data, finishFunc)
    self.serverSettingsFinishFunc = finishFunc
    self.isServerSettingsMods = true
    self.serverSettingsMods = ActiveMods.getById("serversettings")

    local modArray = self.serverSettingsMods:getMods()
    modArray:clear()
    for i, mod in ipairs(data) do
        modArray:add(mod.modID)
    end
end

function ModSelector.Model:setFavorite(id, val)
    self.favs[id] = val
    self:refreshMods()
end

function ModSelector.Model:reloadMods()
    self:loadModDataFromFile()

    table.wipe(self.mods)
    table.wipe(self.sortedMods)
    for _, directory in ipairs(getModDirectoryTable()) do
        local modInfo = getModInfo(directory)
        local modId = modInfo:getId()
        if modInfo and not self.mods[modId] then
            local data = {}
            data.modId = modId
            data.modInfo = modInfo
            data.name = modInfo:getName()
            data.icon = modInfo:getIcon()
            data.category = modInfo:getCategory()
            data.defaultActive = self:isModActive(modId)
            data.defaultFav = self.favs[modId]
            if data.icon == "" then data.icon = ModSelector.Model.categories[data.category] end

            self.mods[modId] = data
            table.insert(self.sortedMods, data)
        end
    end
    table.sort(self.sortedMods, function(a, b)
        return not string.sort(a.name, b.name)
    end)

    self.ModsEnabled = getCore():getOptionModsEnabled()

    self:refreshMods()
end

function ModSelector.Model:refreshMods()
    self.incompatibles = {}
    local function addIncompatibles(id, data)
        self.incompatibles[id] = self.incompatibles[id] or {}
        if data == nil then return end
        for i = 0, data:size()-1 do
            local id2 = data:get(i)

            self.incompatibles[id][id2] = true

            self.incompatibles[id2] = self.incompatibles[id2] or {}
            self.incompatibles[id2][id] = true
        end
    end

    self.requirements = {}
    local function addRequire(id, data)
        self.requirements[id] = self.requirements[id] or { dependsOn = {}, neededFor = {} }
        if data == nil then return end
        for i = 0, data:size()-1 do
            local id2 = data:get(i)
            self.requirements[id2] = self.requirements[id2] or { dependsOn = {}, neededFor = {} }
            self.requirements[id].dependsOn[id2] = true
            self.requirements[id2].neededFor[id] = true
        end
    end

    for modId, modData in pairs(self.mods) do
        modData.isAvailable = modData.modInfo:isAvailable()
        modData.isActive = self:isModActive(modId)
        modData.favorite = self.favs[modId]

        addIncompatibles(modId, modData.modInfo:getIncompatible())
        addRequire(modId, modData.modInfo:getRequire())
    end

    for modId, modData in pairs(self.mods) do
        modData.incompatibleWith = self.incompatibles[modId]
        modData.isIncompatible = false
        for id, _ in pairs(self.incompatibles[modId]) do
            if self.mods[id] and self.mods[id].isActive then
                modData.isIncompatible = true
            end
        end

        modData.requireMods = self.requirements[modId].dependsOn
    end
    self.view:updateView()
end

function ModSelector.Model:correctAndSaveModOrder(data)
    local autoOrder = {}
    local added = {}
    for _, id in ipairs(data) do
        local loadAfter = self.mods[id].modInfo:getRequire()
        if loadAfter ~= nil then
            for j = 0, loadAfter:size()-1 do
                local iid = loadAfter:get(j)
                if added[iid] == nil then
                    table.insert(autoOrder, iid)
                    added[iid] = true
                end
            end
        end
        if added[id] == nil then
            table.insert(autoOrder, id)
            added[id] = true
        end
    end

    local modArray = self:getActiveMods():getMods()
    modArray:clear()
    for i, val in ipairs(autoOrder) do
        modArray:add(val)
    end
end

function ModSelector.Model:checkMapConflicts()
    self.mapGroups:createGroups(self:getActiveMods(), false)
    return self.mapGroups:checkMapConflicts()
end

function ModSelector.Model:getAllMapsInOrder()
    self.mapGroups:createGroups(self:getActiveMods(), false)
    self.mapGroups:checkMapConflicts()
    return self.mapGroups:getAllMapsInOrder()
end

function ModSelector.Model:getMapConflicts(mapName)
    return self.mapGroups:getMapConflicts(mapName)
end

function ModSelector.Model:filterMods(category, searchWord, favoriteMode, onlyEnabled)
    table.wipe(self.currentMods)
    for _, modData in ipairs(self.sortedMods) do
        local show = true
        -- Category
        if category ~= "" and modData.category ~= category then
            show = false
        end

        -- Search
        if searchWord ~= "" then
            local isMatch = false
            if string.find(string.lower(modData.modInfo:getName()), searchWord) then
                isMatch = true
            end
            if string.find(string.lower(modData.modInfo:getId()), searchWord) then
                isMatch = true
            end
            if string.find(tostring(modData.modInfo:getWorkshopID()), searchWord) then
                isMatch = true
            end
            if not isMatch then
                show = false
            end
        end

        -- Favorite
        if favoriteMode and not modData.favorite then
            show = false
        end

        -- Only enabled
        if onlyEnabled and not modData.isActive then
            show = false
        end

        local verMin = modData.modInfo:getVersionMin()
        --if not self.isUnsupportedModsVisible and (verMin == nil or verMin:isLessThan(getBreakModGameVersion())) then
        --    show = false
        --end

        if show then
            table.insert(self.currentMods, modData)
        end
    end
end

function ModSelector.Model:isModActive(id)
    return self:getActiveMods():isModActive(id)
end

function ModSelector.Model:getActiveMods()
    if self.isServerSettingsMods then
        return self.serverSettingsMods
    end
    if self.loadGameFolder then
        return ActiveMods.getById("currentGame")
    end
    return ActiveMods.getById(self.isNewGame and "currentGame" or "default")
end

function ModSelector.Model:setModActive(id, active)
    self:getActiveMods():setModActive(id, active)
end

function ModSelector.Model:acceptChanges()
    self:saveModDataToFile()

    local activeMods = self:getActiveMods()
    -- Remove mod IDs for missing mods from ActiveMods.mods
    activeMods:checkMissingMods()
    -- Remove unused map directories from ActiveMods.mapOrder
    activeMods:checkMissingMaps()

    if self.loadGameFolder then
        local saveFolder = self.loadGameFolder
        self.loadGameFolder = nil
        manipulateSavefile(saveFolder, "WriteModsDotTxt")

        -- Setting 'currentGame' to 'default' in case other places forget to set it
        -- before starting a game (DebugScenarios.lua, etc).
        local defaultMods = ActiveMods.getById("default")
        local currentMods = ActiveMods.getById("currentGame")
        currentMods:copyFrom(defaultMods)

        LoadGameScreen.instance:onSavefileModsChanged(saveFolder)
        LoadGameScreen.instance:setVisible(true, self.joyfocus)
        return
    end

    if self.isNewGame then
        NewGameScreen.instance:setVisible(true, self.joyfocus)
    elseif self.isServerSettingsMods then
        local result = {}
        local mods = activeMods:getMods()
        for i = 0, mods:size()-1 do
            local id = mods:get(i)
            local info = self.mods[id].modInfo
            table.insert(result, {modID = id, modInfo = info})
        end
        self.serverSettingsFinishFunc(result)
        self.isServerSettingsMods = false
        return
    else
        saveModsFile()

        -- Setting 'currentGame' to 'default' in case other places forget to set it
        -- before starting a game (DebugScenarios.lua, etc).
        local defaultMods = ActiveMods.getById("default")
        local currentMods = ActiveMods.getById("currentGame")
        currentMods:copyFrom(defaultMods)

        MainScreen.instance.bottomPanel:setVisible(true)
    end

    local reset = self.ModsEnabled ~= getCore():getOptionModsEnabled()
    if ActiveMods.requiresResetLua(activeMods) then
        reset = true
    end
    if reset then
        if self.isNewGame then
            getCore():ResetLua("currentGame", "NewGameMods")
        else
            MainScreen.instance.bottomPanel:setVisible(false)
            getCore():ResetLua("default", "modsChanged")
        end
    end
end

function ModSelector.Model:loadModDataFromFile()
    table.wipe(self.presets)
    table.wipe(self.favs)

    local file = getFileReader("pz_modlist_settings.cfg", true)
    local line = file:readLine()
    local count = 0
    while line ~= nil do
        if luautils.stringStarts(line, "!fav!") and count == 0 then
            local sepIndex = string.find(line, ":")
            local modsString = ""
            if sepIndex ~= nil then
                modsString = string.sub(line, sepIndex + 1)
            end
            for i, val in ipairs(luautils.split(modsString, ";")) do
                local data = luautils.split(val, "\\")
                self.favs[val] = data[1]
            end
        else
            local sepIndex = string.find(line, ":")
            local presetName = ""
            local modsString = ""
            if sepIndex ~= nil then
                presetName = string.sub(line, 0, sepIndex - 1)
                modsString = string.sub(line, sepIndex + 1)
            end
            if presetName ~= "" then
                self.presets[presetName] = {}
                for i, val in ipairs(luautils.split(modsString, ";")) do
                    local data = luautils.split(val, "\\")
                    self.presets[presetName][val] = data[1]
                end
            end
        end
        count = count + 1
        line = file:readLine()
    end
    file:close()
end

function ModSelector.Model:saveModDataToFile()
    local file = getFileWriter("pz_modlist_settings.cfg", true, false)
    -- Favorite
    local modsStrTable = {}
    for modId, modData in pairs(self.mods) do
        if modData.favorite then
            table.insert(modsStrTable, modId)
            table.insert(modsStrTable, ";")
        end
    end
    file:write("!fav!:" .. table.concat(modsStrTable) .. "\n")
    -- Presets
    for name, data in pairs(self.presets) do
        modsStrTable = {}
        for id, wID in pairs(data) do
            table.insert(modsStrTable, id)
            table.insert(modsStrTable, ";")
        end
        file:write(name .. ":" .. table.concat(modsStrTable) .. "\n")
    end
    file:close()
end

function ModSelector.Model:getPresetShareText(name)
    local data = self.presets[name]
    local modsStrTable = {}
    for id, wID in pairs(data) do
        table.insert(modsStrTable, id)
        table.insert(modsStrTable, ";")
    end
    return name .. ":" .. table.concat(modsStrTable) .. "\n"
end

function ModSelector.Model:addSharedPreset(button)
    if button.internal == "OK" then
        local line = button.parent.entry:getText()
        local sepIndex = string.find(line, ":")
        local presetName = ""
        local modsString = ""
        if sepIndex ~= nil then
            presetName = string.sub(line, 0, sepIndex - 1)
            modsString = string.sub(line, sepIndex + 1)
        end
        if presetName ~= "" then
            self.presets[presetName] = {}
            for i, val in ipairs(luautils.split(modsString, ";")) do
                local data = luautils.split(val, "\\")
                self.presets[presetName][val] = data[1]
            end
        end
    end
end

function ModSelector.Model:forceActivateMods(modInfo, activate)
    local modId = modInfo:getId()
    local isModActive = self:isModActive(modId)

    if isModActive == activate then return end

    if activate then
        if modInfo:isAvailable() and not self.mods[modId].isIncompatible then
            self:setModActive(modId, true)
            self.mods[modId].isActive = true

            if self:isModActive(modId) and modInfo:getRequire() then
                local requiredMods = modInfo:getRequire()
                for i = 0, requiredMods:size()-1 do
                    local reqId = requiredMods:get(i)
                    if self.mods[reqId] then
                        self:forceActivateMods(self.mods[reqId].modInfo, true)
                    end
                end
            end
        end
    else
        self:setModActive(modId, false)
        self.mods[modId].isActive = false
        if not self:isModActive(modId) then
            for id, _ in pairs(self.requirements[modId].neededFor) do
                self:forceActivateMods(self.mods[id].modInfo, false)
            end
        end
    end
    self:refreshMods()
end

