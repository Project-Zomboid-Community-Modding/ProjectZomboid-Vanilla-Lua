if debugScenarios == nil then
    debugScenarios = {}
end

debugScenarios.AiteronScenario = {
    name = "Aiteron's Debug Scenario",
    --	forceLaunch = true, -- use this to force the launch of THIS scenario right after main menu was loaded, save more clicks! Don't do multiple scenarii with this options
    startLoc = {x=10710, y=9404, z=0 }, -- lakes
    setSandbox = function()
        SandboxVars.Speed = 3;
        SandboxVars.Zombies = 6; -- 6 = no zombies, 1 = insane (then 2 = low, 3 normal, 4 high..)
        SandboxVars.Distribution = 1;
        SandboxVars.Survivors = 1;
        SandboxVars.DayLength = 3;
        SandboxVars.StartYear = 1;
        SandboxVars.StartMonth = 7;
        SandboxVars.StartDay = 9;
        SandboxVars.StartTime = 2;
        SandboxVars.VehicleEasyUse = true;
        SandboxVars.WaterShutModifier = 14;
        SandboxVars.ElecShutModifier = 14;
        SandboxVars.WaterShut = 2;
        SandboxVars.ElecShut = 2;
        -- 		SandboxVars.FoodLoot = 2;
        -- 		SandboxVars.WeaponLoot = 2;
        -- 		SandboxVars.OtherLoot = 2;
        SandboxVars.LootItemRemovalList = "";
        SandboxVars.Temperature = 3;
        SandboxVars.Rain = 3;
        SandboxVars.ErosionSpeed = 3;
        SandboxVars.StatsDecrease = 3;
        SandboxVars.NatureAbundance = 3;
        SandboxVars.Alarm = 4;
        SandboxVars.LockedHouses = 6;
        SandboxVars.FoodRotSpeed = 3;
        SandboxVars.FridgeFactor = 3;
        SandboxVars.Farming = 3;
        SandboxVars.LootRespawn = 1;
        SandboxVars.StarterKit = false;
        SandboxVars.Nutrition = true;
        SandboxVars.TimeSinceApo = 1;
        SandboxVars.PlantResilience = 3;
        SandboxVars.PlantAbundance = 3;
        SandboxVars.EndRegen = 3;
        SandboxVars.CarSpawnRate = 3;
        SandboxVars.LockedCar = 3;
        SandboxVars.CarAlarm = 2;
        SandboxVars.ChanceHasGas = 1;
        SandboxVars.InitialGas = 2;
        SandboxVars.CarGeneralCondition = 1;
        SandboxVars.RecentlySurvivorVehicles = 2;
        SandboxVars.VehicleStoryChance = 1;

        SandboxVars.MultiplierConfig = {
            XPMultiplierGlobal = 1,
            XPMultiplierGlobalToggle = true,
        }

        SandboxVars.ZombieLore = {
            Speed = 2,
            Strength = 2,
            Toughness = 2,
            Transmission = 1,
            Mortality = 5,
            Reanimate = 3,
            Cognition = 3,
            Memory = 2,
            Sight = 3,
            Hearing = 3,
            ThumpNoChasing = 0,
        }
    end,
    onStart = function()
        getPlayer():getInventory():AddItem("Base.FishingRod");
        getPlayer():getInventory():AddItem("Base.FishingRod");
        getPlayer():getInventory():AddItem("Base.FishingRod");
        getPlayer():getInventory():AddItem("Base.FishingLine");
        getPlayer():getInventory():AddItem("Base.FishingNet");
        getPlayer():getInventory():AddItems("Base.Worm", 20);
        getPlayer():getInventory():AddItem("Base.FishingHook");
        getPlayer():getInventory():AddItem("Base.FishingHook");
        getPlayer():setUnlimitedCarry(true);
        getPlayer():setPerkLevelDebug(Perks.Fishing, 10);

        local clim = getClimateManager();
        local w = clim:getWeatherPeriod();
        if w:isRunning() then
            clim:stopWeatherAndThunder();
        end

        -- remove fog
        local var = clim:getClimateFloat(5);
        var:setEnableOverride(true);
        var:setOverride(0, 1);
    end
}
