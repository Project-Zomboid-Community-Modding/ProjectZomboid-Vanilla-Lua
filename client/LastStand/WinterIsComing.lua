WinterIsComing = {}

WinterIsComing.Add = function()
	addChallenge(WinterIsComing);
end

WinterIsComing.OnGameStart = function()
    if getGameTime():getWorldAgeHours()-2 >= 4*24 then --WorldAgeHours has 2 subtracted from it to delay the storm's start from 7 am to 9 am
        getCore():setForceSnow(true);
        forceSnowCheck();
    end

    if getGameTime():getWorldAgeHours()+2 >=3*24 and getGameTime():getWorldAgeHours()-2 <=4*24 then
        getClimateManager():triggerWinterIsComingStorm();
    end
    --getClimateManager():forceDayInfoUpdate();

	if getGameTime():getDay() == 8 and getGameTime():getTimeOfDay() == 9 then
		local modal = ISModalRichText:new(getCore():getScreenWidth()/2 - 100, getCore():getScreenHeight()/2 - 50, 200, 100, getText("Challenge_WinterIsComingInfoBox"), false, nil, nil, 0);
		modal:initialise();
		modal:addToUIManager();
		if JoypadState.players[1] then
			JoypadState.players[1].focus = modal
		end
	end
end

WinterIsComing.OnInitSeasons = function(_season)
    _season:init(
        50, -- Newfoundland. _season:getLat(),
        -5,
        -20,
        8,
        _season:getSeasonLag(),
        _season:getHighNoon(),
        _season:getSeedA(),
        _season:getSeedB(),
        _season:getSeedC()
    );
end

WinterIsComing.OnInitWorld = function()
	SandboxVars.Zombies = 1;
	SandboxVars.Distribution = 1;
	SandboxVars.DayLength = 3;
	SandboxVars.StartMonth = 7;
	SandboxVars.StartTime = 2;
	SandboxVars.WaterShutModifier = 7;
	SandboxVars.ElecShutModifier = 7;
-- 	SandboxVars.FoodLoot = 3;
-- 	SandboxVars.CannedFoodLoot = 3;
-- 	SandboxVars.RangedWeaponLoot = 3;
-- 	SandboxVars.AmmoLoot = 3;
-- 	SandboxVars.SurvivalGearsLoot = 3;
-- 	SandboxVars.MechanicsLoot = 3;
-- 	SandboxVars.LiteratureLoot = 3;
-- 	SandboxVars.MedicalLoot = 3;
-- 	SandboxVars.WeaponLoot = 3;
-- 	SandboxVars.OtherLoot = 3;
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
	SandboxVars.TimeSinceApo = 3;
	SandboxVars.MultiHitZombies = false;

	SandboxVars.MultiplierConfig = {
		XPMultiplierGlobal = 1,
		XPMultiplierGlobalToggle = true,
	}

	SandboxVars.ZombieConfig.PopulationMultiplier = ZombiePopulationMultiplier.Insane

	Events.OnGameStart.Add(WinterIsComing.OnGameStart);
    Events.EveryHours.Add(WinterIsComing.EveryHours);
    --Events.EveryTenMinutes.Add(WinterIsComing.EveryTenMinutes);
    Events.OnInitSeasons.Add(WinterIsComing.OnInitSeasons);
end

WinterIsComing.EveryHours = function()
    if getGameTime():getWorldAgeHours()+2 >=4*24 then
        getCore():setForceSnow(true);
    end
    if getGameTime():getWorldAgeHours()-2 >=3*24 and getGameTime():getWorldAgeHours()-2 <=4*24 then
        getClimateManager():triggerWinterIsComingStorm();
    end
end

--[[
WinterIsComing.EveryTenMinutes = function()
    if getGameTime():getDaysSurvived() >= 7 then
        getWorld():setGlobalTemperature(ZombRand(-10,0));
    end
end
--]]

WinterIsComing.RemovePlayer = function(p)

end

WinterIsComing.AddPlayer = function(playerNum, playerObj)

end

WinterIsComing.Render = function()

--~ 	getTextManager():DrawStringRight(UIFont.Small, getCore():getOffscreenWidth() - 20, 20, "Zombies left : " .. (EightMonthsLater.zombiesSpawned - EightMonthsLater.deadZombie), 1, 1, 1, 0.8);

--~ 	getTextManager():DrawStringRight(UIFont.Small, (getCore():getOffscreenWidth()*0.9), 40, "Next wave : " .. tonumber(((60*60) - EightMonthsLater.waveTime)), 1, 1, 1, 0.8);
end

WinterIsComing.id = "WinterIsComing";
WinterIsComing.image = "media/lua/client/LastStand/WinterIsComing.png";
WinterIsComing.video = "WinterIsComing.bik";
WinterIsComing.gameMode = "Winter is Coming";
WinterIsComing.world = "Muldraugh, KY";
WinterIsComing.x = 36 * 300 + 21;
WinterIsComing.y = 31 * 300 + 111;
WinterIsComing.z = 0;

WinterIsComing.spawns = {
    {x = 10862, y = 10247, z = 0}, -- Medium house2
    {x = 10916, y = 10132, z = 0}, -- little house2
    {x = 10803, y = 10073, z = 0}, -- little house2
    {x = 10918, y = 10129, z = 0}, -- little house2
    {x = 10942, y = 9372, z = 0},
    {x = 10951, y = 9490, z = 0},

}

WinterIsComing.hourOfDay = 7;

Events.OnChallengeQuery.Add(WinterIsComing.Add)

