if not isClient() then return end

local ServerCommands = {}
local Commands = {}


Commands.player = {}
Commands.player.setWeight = function(args)
    getPlayer():getNutrition():setWeight(args.weight)
    getPlayer():getNutrition():setCalories(1000)
end

Commands.player.syncWeight = function(args)
    getPlayer():getNutrition():syncWeight()
end

ServerCommands.OnServerCommand = function(module, command, args)
    if Commands[module] and Commands[module][command] then
        local argStr = ''
        for k,v in pairs(args) do argStr = argStr..' '..k..'='..tostring(v) end
        print('received '..module..' '..command..' '..argStr)
        Commands[module][command](args)
    end
end
Events.OnServerCommand.Add(ServerCommands.OnServerCommand)