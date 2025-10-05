if debugScenarios == nil then
    debugScenarios = {}
end


debugScenarios.BobKateHouse = {
    name = "Bob Kate House Start",
    world = "Muldraugh, KY",
    --startLoc = {x=12025, y=2592, z=0 },
    startLoc = {x=12367, y=1952, z=0 },
     --  startLoc = {x=12289, y=1244, z=0 },
    --   startLoc = {x=12007, y=2051, z=0 },

    setSandbox = function()
        SandboxVars.Zombies = 5;
        SandboxVars.Distribution = 1;
        SandboxVars.DayLength = 3;
        SandboxVars.StartMonth = 12;
        SandboxVars.StartTime = 2;
        SandboxVars.WaterShutModifier = 110;
        SandboxVars.ElecShutModifier = 110;
--         SandboxVars.FoodLoot = 1;
--         SandboxVars.WeaponLoot = 1;
--         SandboxVars.OtherLoot = 1;
        SandboxVars.LootItemRemovalList = "";
        SandboxVars.Temperature = 3;
        SandboxVars.Rain = 3;
        --    SandboxVars.erosion = 12
        SandboxVars.ErosionSpeed = 1
        SandboxVars.Farming = 3;
        SandboxVars.NatureAbundance = 5;
        SandboxVars.PlantResilience = 3;
        SandboxVars.PlantAbundance = 3;
        SandboxVars.Alarm = 3;
        SandboxVars.LockedHouses = 3;
        SandboxVars.FoodRotSpeed = 3;
        SandboxVars.FridgeFactor = 3;
        SandboxVars.ZombiesRespawn = 2;
        SandboxVars.LootRespawn = 1;
        SandboxVars.StatsDecrease = 3;
        SandboxVars.StarterKit = false;
        SandboxVars.TimeSinceApo = 0;

        SandboxVars.MultiplierConfig = {
            XPMultiplierGlobal = 1,
            XPMultiplierGlobalToggle = true,
        }


    end,
    onStart = function()
        getPlayer():getInventory():AddItem("Base.Shovel");
        local item = getPlayer():getInventory():AddItem("Base.Torch");


    end
}
