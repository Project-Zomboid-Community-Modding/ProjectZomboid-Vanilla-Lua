--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

TheDescendingFog = {}

TheDescendingFog.Add = function()
    addChallenge(TheDescendingFog);
end

TheDescendingFog.OnGameStart = function()
    --[[
    local modal = ISModalRichText:new(getCore():getScreenWidth()/2 - 100, getCore():getScreenHeight()/2 - 50, 200, 100, getText("Challenge_TheDescendingFogInfoBox"), false, nil, nil, 0);
    modal:initialise();
    modal:addToUIManager();
    if JoypadState.players[1] then
        JoypadState.players[1].focus = modal
    end
    --]]
end

TheDescendingFog.OnInitSeasons = function(_season)
    _season:init(
        _season:getLat(), --aprox miami florida
        _season:getTempMin(), --min
        _season:getTempMax(), --max
        _season:getTempDiff(), --amount of degrees temp can go lower or higher then mean
        _season:getSeasonLag(),
        _season:getHighNoon(),
        _season:getSeedA(),
        _season:getSeedB(),
        _season:getSeedC()
    );
end

TheDescendingFog.OnInitWorld = function()
    SandboxVars.Zombies = 1;
    SandboxVars.Distribution = 1;
    SandboxVars.DayLength = 3;
    SandboxVars.StartMonth = 7;
    SandboxVars.StartTime = 2;
    SandboxVars.WaterShutModifier = 7;
    SandboxVars.ElecShutModifier = 7;
--     SandboxVars.FoodLoot = 3;
--     SandboxVars.CannedFoodLoot = 3;
--     SandboxVars.RangedWeaponLoot = 3;
--     SandboxVars.AmmoLoot = 3;
--     SandboxVars.SurvivalGearsLoot = 3;
--     SandboxVars.MechanicsLoot = 3;
--     SandboxVars.LiteratureLoot = 3;
--     SandboxVars.MedicalLoot = 3;
--     SandboxVars.WeaponLoot = 3;
--     SandboxVars.OtherLoot = 3;
    SandboxVars.LootItemRemovalList = "";
    SandboxVars.Temperature = 3;
    SandboxVars.Rain = 3;
    --	    SandboxVars.erosion = 12
    SandboxVars.ErosionSpeed = 1
    SandboxVars.Farming = 3;
    SandboxVars.NatureAbundance = 5;
    SandboxVars.PlantResilience = 3;
    SandboxVars.PlantAbundance = 3;
    SandboxVars.Alarm = 3;
    SandboxVars.LockedHouses = 5;
    SandboxVars.FoodRotSpeed = 3;
    SandboxVars.FridgeFactor = 3;
    SandboxVars.LootRespawn = 1;
    SandboxVars.StatsDecrease = 3;
    SandboxVars.StarterKit = false;
    SandboxVars.TimeSinceApo = 1;
    SandboxVars.MultiHitZombies = false;

    SandboxVars.MultiplierConfig = {
        XPMultiplierGlobal = 1,
        XPMultiplierGlobalToggle = true,
    }

    SandboxVars.ZombieConfig.PopulationMultiplier = ZombiePopulationMultiplier.Insane

    Events.OnGameStart.Add(TheDescendingFog.OnGameStart);
    --Events.EveryDays.Add(TheDescendingFog.EveryDays);
    Events.EveryTenMinutes.Add(TheDescendingFog.EveryTenMinutes);
    Events.OnInitSeasons.Add(TheDescendingFog.OnInitSeasons);
end

TheDescendingFog.EveryTenMinutes = function()
    --getClimateManager():triggerCustomWeather(0.95, true);
end


TheDescendingFog.RemovePlayer = function(p)
end

TheDescendingFog.AddPlayer = function(playerNum, playerObj)

end

TheDescendingFog.Render = function()
end

TheDescendingFog.id = "TheDescendingFog";
TheDescendingFog.image = "media/lua/client/LastStand/TheDescendingFog.png";
TheDescendingFog.gameMode = "The Descending Fog";
TheDescendingFog.world = "Muldraugh, KY";
TheDescendingFog.x = 36 * 300 + 21;
TheDescendingFog.y = 31 * 300 + 111;
TheDescendingFog.z = 0;

TheDescendingFog.spawns = {
    {x = 10862, y = 10247, z = 0}, -- Medium house2
    {x = 10916, y = 10132, z = 0}, -- little house2
    {x = 10803, y = 10073, z = 0}, -- little house2
    {x = 10918, y = 10129, z = 0}, -- little house2
    {x = 10942, y = 9372, z = 0},
    {x = 10951, y = 9490, z = 0},
}

TheDescendingFog.hourOfDay = 7;

--Events.OnChallengeQuery.Add(TheDescendingFog.Add)

