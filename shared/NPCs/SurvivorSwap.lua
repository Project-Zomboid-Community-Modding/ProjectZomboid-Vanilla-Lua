--[[-
    debugging tool for hot-swapping survivor details and inventory based on predefined tables.
]]

if isClient() then return end

SurvivorSwap = {
    --- if non empty, shown in world context menus [Debug] > Survivor Swap > Survivors
    Survivors = {},
    --- if non empty, shown in world context menus [Debug] > Survivor Swap > Inventory
    Loadouts = {},
    --- not used currently
    Vehicles = {},
}

--[[- Modifies a survivor.

    Modifies a survivors visual appearance, name, profession, gender, perks and traits based on data defined in an lua table.

    @tparam IsoPlayer playerObj the survivor to modify
    @tparam table data a table containing the character details.

    Valid key/value pairs for the `data` table are:
    * forename = string forename. If nil, existing forename is kept.
    * surname = string surname. If nil, existing forename is kept.
    * profession = string profession. If nil, existing profession is kept.
    * traits = a list style table of traits to apply. Existing traits will be cleared regardless of this keys existence.
    * perks = a table of perks (keys) and levels (values). If this key is nil, then existing perks are kept.
    * weight = int character weight. (default: 80)
    * hairColor = a table of 4 float 0-1 values {r, g, b, a} (default: {0.2, 0.2, 0.2, 1})
    * female = boolean true/false. (default: false)
    * voiceType = int value (default: 0)
    * voicePitch = int value (default: 0)
    * skinTexture = int value (default: 1)
    * beardModel = string (default: "")
    * hairModel = string (default: "")

]]
SurvivorSwap.applyCharacter = function(playerObj, data)
    local desc = playerObj:getDescriptor()
    local visual = playerObj:getHumanVisual()
    local traits = playerObj:getTraits()
    desc:setForename(data.forename or desc:getForename())
    desc:setSurname(data.surname or desc:getSurname())
    desc:setProfession(data.profession or desc:getProfession())
    traits:clear()
    for _, trait in ipairs(data.traits or {}) do
        traits:add(trait)
    end
    if data.perks then
        for i=1,Perks.getMaxIndex() do
            local perk = PerkFactory.getPerk(Perks.fromIndex(i - 1));
            if perk and perk:getParent() ~= Perks.None then
                local default = 0;
                if perk == Perks.Strength or perk == Perks.Fitness then default = 5 end
                playerObj:setPerkLevelDebug(perk, data.perks[perk] or default)
            end
        end
    end
    
    playerObj:getNutrition():setWeight(data.weight or 80)
    playerObj:setFemale(data.female or false)
    desc:setFemale(data.female or false)
    desc:setVoicePrefix(data.female and "VoiceFemale" or "VoiceMale")
    desc:setVoiceType(data.voiceType or 0)
    desc:setVoicePitch(data.voicePitch or 0)

    -- set the look
    local immutableColor = ImmutableColor.new(unpack(data.hairColor or {0.2, 0.2, 0.2, 1}))
    visual:setHairColor(immutableColor)
    visual:setBeardColor(immutableColor)
    visual:setSkinTextureIndex(data.skinTexture or 1)
    visual:setBeardModel(data.beard or "")
    visual:setHairModel(data.hair or "")
    playerObj:resetModel()
    if playerObj:getPlayerNum() then
        getPlayerInfoPanel(playerObj:getPlayerNum()).charScreen.refreshNeeded = true
    end
end

--[[- Clears and modifies a survivors inventory.

    Modifies a survivor's inventory based on data defined in an lua table.

    @tparam IsoPlayer playerObj the survivor to modify
    @tparam table data a table containing the inventory details.

    Valid key/value pairs for the `data` table are:
    * worn = a list-style table of items to wear. These should include full name such as "Base.Glasses_Aviators"
    * inventory = a list-style table of additional items to place in the inventory. As above, use full names.
    * setup = an optional function to be called to perform additional setup such as weapon attachments,
        hotbar setup, etc. This function will be passed 2 args: the survivor and the survivor's inventory

]]
SurvivorSwap.applyLoadout = function(playerObj, data)
    playerObj:clearWornItems()
    playerObj:setPrimaryHandItem(nil)
    playerObj:setSecondaryHandItem(nil)
    local inv = playerObj:getInventory()
    inv:clear()
    if playerObj:getPlayerNum() then
        getPlayerHotbar(playerObj:getPlayerNum()):update()
    end
    for _, value in pairs(data.worn or {}) do
        local item = inv:AddItem(value)
        playerObj:setWornItem(item:getBodyLocation(), item)
    end
    for _, value in pairs(data.inventory or {}) do
        inv:AddItem(value)
    end
    if data.setup then
        data.setup(playerObj, inv)
    end
    inv:setDrawDirty(true) -- dont forget this when messing with inventory
    playerObj:resetModel()
    if playerObj:getPlayerNum() then
        getPlayerHotbar(playerObj:getPlayerNum()):update()
    end
end

--[[- Completely modifies a vehicle and its inventory.

    Modifies a vehicle's script, color, and inventory based on data defined in an lua table.

    @tparam BaseVehicle vehicle the vehicle to modify
    @tparam table data a table containing the vehicle details.

    Valid key/value pairs for the `data` table are:
    * script = string script name such as "Base.SUV"
    * color = table of 3 float values {h, s, v}
    * containers = a table of string container names (keys) and function (values)
    * parts = a table of string locations (keys) and parts to use (values). The parts should use full names such as
         "Base.BigGasTank2"

]]
SurvivorSwap.applyVehicle = function(vehicle, data)
    vehicle:setScriptName(data.script)
    vehicle:setScript()
    vehicle:setColorHSV(unpack(data.color))
    for part, replacement in pairs(data.parts) do
        vehicle:getPartById(part):setInventoryItem(instanceItem(replacement))
    end
    vehicle:repair()

    for part, setup in pairs(data.containers) do
        local container = vehicle:getPartById(part):getItemContainer()
        container:clear()
        setup(container)
    end
    vehicle:addKeyToGloveBox()
end
