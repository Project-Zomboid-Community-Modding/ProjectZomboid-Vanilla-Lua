if not isClient() then return end

local ServerCommands = {}
local Commands = {}

Commands.player = {}

Commands.fishing = {}
Commands.fishing.attachLure = function(args)
    local rod = getPlayer():getInventory():getItemWithID(args.rodId)
    local lure = getPlayer():getInventory():getItemWithID(args.lureId)

    log(DebugType.Action, '[ServerCommands.fishing.attachLure] '..tostring(getPlayer())..' rod '..tostring(rod)..' lure '..tostring(lure))

    local defaultName = rod:getScriptItem():getName()
    rod:setName(getText(defaultName) .. " " .. getText("UI_AttachLure_With") .. " " .. getItemName(args.lureFullType))

    rod:getModData().fishing_Lure = args.lureFullType

    if Fishing.lure.All[args.lureFullType].amountOfFoodHunger ~= -1 then
        local lureItem = getPlayer():getInventory():getItemWithID(args.lureId)
        lureItem:setHungChange(lureItem:getHungChange() + Fishing.lure.All[args.lureFullType].amountOfFoodHunger / 100)
    end

    getPlayer():setPrimaryHandItem(rod);
    getPlayer():setSecondaryHandItem(nil);
end

Commands.fishing.removeLure = function(args)
    local rod = getPlayer():getInventory():getItemWithID(args.rodId)
    local lure = getPlayer():getInventory():getItemWithID(args.lureId)

    log(DebugType.Action, '[ServerCommands.fishing.removeLure] '..tostring(getPlayer())..' rod '..tostring(rod)..' lure '..tostring(lure))

    local defaultName = rod:getScriptItem():getName()
    rod:setName(getText(defaultName))

    if Fishing.IsArtificalLure(rod:getModData().fishing_Lure) then
        getPlayer():setSecondaryHandItem(lure);
    end
    rod:getModData().fishing_Lure = nil
end

Commands.fishing.consumeLure = function(args)
    local rod = getPlayer():getInventory():getItemWithID(args.rodId)

    log(DebugType.Action, '[ServerCommands.fishing.consumeLure] '..tostring(getPlayer())..' rod '..tostring(rod))

    local defaultName = rod:getScriptItem():getName()
    rod:setName(getText(defaultName))

    rod:getModData().fishing_Lure = nil
end

Commands.fishing.addChumToWater = function(args)
    FishSchoolManager.getInstance():addChum(args.x, args.y, args.force)
end

Commands.erosion = {};
Commands.erosion.disableForSquare = function(args)
    local sq = getCell():getGridSquare(args.x, args.y, args.z);
    if sq ~= nil then
        sq:disableErosion();
    end
end

Commands.character = {};
Commands.character.rested = function(args)
    getPlayer():setIsResting(false)
    getPlayer():setBed(nil)
end

Commands.literature = {};
Commands.literature.readLiterature = function(args)
    local book = getPlayer():getInventory():getItemWithID(args.itemId)
    getPlayer():ReadLiterature(book);
    log(DebugType.Action, '[ServerCommands.literature.readLiterature] '..tostring(getPlayer())..' book '..tostring(book));
end

Commands.square = {};
Commands.square.removeGrass = function(args)
    local sq = getCell():getGridSquare(args.x, args.y, args.z);
    if sq ~= nil then
        sq:removeGrass();
    end
end

Commands.animal = {}
Commands.animal.removeDung = function(args)
    local initialSquare = getSquare(tonumber(args.x), tonumber(args.y), tonumber(args.z))
    if not initialSquare then
        return;
    end
    local radius = tonumber(args.radius)

    for x=initialSquare:getX(), initialSquare:getX() + radius-1 do
        for y=initialSquare:getY(), initialSquare:getY() + radius-1 do
            local sq = getSquare(x, y, initialSquare:getZ());
            if sq then
                sq:removeAllDung();
            end
        end
    end
end

Commands.hutch = {}
Commands.hutch.dirt = function(args)
    local hutch = getHutch(tonumber(args.x), tonumber(args.y), tonumber(args.z))
    if hutch then
        hutch:setHutchDirt(args.dirt)
    end
end
Commands.hutch.nestBoxDirt = function(args)
    local hutch = getHutch(tonumber(args.x), tonumber(args.y), tonumber(args.z))
    if hutch then
        hutch:setNestBoxDirt(args.dirt)
    end
end

Commands.ui = {}
Commands.ui.DirtyUI = function(args)
    ISInventoryPage.dirtyUI();
end

Commands.recipe = {}
Commands.recipe.OpenMysteryCan = function(args)
    local item = getPlayer():getInventory():getItemWithID(args.itemId)
    if item ~= nil then
        item:setTexture(getTexture("Item_CannedUnlabeled_Open"))
        item:setWorldStaticModel(ModelKey.TIN_CAN_EMPTY)
        item:setStaticModel(ModelKey.MYSTERY_CAN_OPEN)
        item:getModData().NoLabel = "true"
    end
end

Commands.recipe.OpenDentedCan = function(args)
    local item = getPlayer():getInventory():getItemWithID(args.itemId)
    if item ~= nil then
        item:setTexture(getTexture("Item_CannedUnlabeled_Gross"))
        item:setWorldStaticModel(args.modelName)
        item:setStaticModel(args.modelName)
    end
end

Commands.recipe.SayText = function(args)
    local player = getPlayerByOnlineID(args.onlineID)
    if player ~= nil then
        local text = ""
        if args.type == 0 then -- RollOneDice
            text = "* " .. player:getUsername().. " " .. getText("IGUI_Rolls") .. " " .. args.rollText .. " " .. args.diceNameText .. " *"
        elseif args.type == 1 or args.type == 2 then -- RollDice or Roll3d6
            text = "* " .. player:getUsername().. " " .. getText("IGUI_Rolls") .. " " .. args.rollText .. " " .. args.diceNameText .. " *"
        elseif args.type == 3 then -- Rolld100
            text = "* " .. player:getUsername().. " " .. getText("IGUI_Rolls") .. " " .. args.rollText .. " " .. getText("IGUI_With") .. " " .. getText("IGUI_PercentileDice") .. " *"        elseif args.type == 4 then --DrawRandomCard
            text = "* " .. player:getUsername().. " " .. getText("IGUI_Draws") .." " .. args.text .. " *"
        elseif args.type == 5 then --ISResearchRecipe
            if player:isLocalPlayer() then
                for k,v in pairs(args.names) do
                    HaloTextHelper.addGoodText(player, getText("IGUI_HaloNote_LearnedRecipe", getRecipeDisplayName(tostring(v)), "[br/]"))
                end
            end
        end

        player:Say(text);
    end
end

Commands.recipe.openAndEat = function(args)
    local player = getPlayerByOnlineID(args.onlineID)
    if player ~= nil then
        local item = player:getInventory():getItemWithID(args.itemId)
        if item ~= nil then
            ISTimedActionQueue.add(ISEatFoodAction:new(player, item, args.eatPercentage));
        end
    end
end

Commands.forage = {}
Commands.forage.complete = function(args)
    forageSystem.actionComplete(getPlayer(), args.iconID)
end

ServerCommands.OnServerCommand = function(module, command, args)
    if Commands[module] and Commands[module][command] then
        local argStr = ''
        -- Can be nil if sending an empty table
        if args then
            for k,v in pairs(args) do argStr = argStr..' '..k..'='..tostring(v) end
        end
        print('received command '..module..' '..command..' argStr: '..argStr)
        Commands[module][command](args)
    end
end
Events.OnServerCommand.Add(ServerCommands.OnServerCommand)
