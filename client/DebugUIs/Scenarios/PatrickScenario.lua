if debugScenarios == nil then
	debugScenarios = {}
end

debugScenarios.PatrickScenario = {
	name = "Patrick's Debug Scenario",
--	forceLaunch = true, -- use this to force the launch of THIS scenario right after main menu was loaded, save more clicks! Don't do multiple scenarii with this options
	startLoc = {x=10601, y=8834, z=0 }, -- highway muldraugh
--	startLoc = {x=12755, y=1655, z=0 }, -- LOUISVILLE
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

--		addZombiesInOutfit(10591, 8877, 0, 5, nil, nil);
--		addZombiesInOutfit(getPlayer():getX() - 25, getPlayer():getY() + 6, getPlayer():getZ(), 3, nil, nil);
		local vehicle = addVehicle("Base.CarNormal", getPlayer():getX() + 2, getPlayer():getY() - 1, 0);
		sendClientCommand(getPlayer(), "vehicle", "repair", { vehicle = vehicle:getId() })
		sendClientCommand(getPlayer(), "vehicle", "getKey", { vehicle = vehicle:getId() })
		getPlayer():getInventory():AddItem("Base.Pistol");
		getPlayer():getInventory():AddItem("Base.Pistol2");
		getPlayer():getInventory():AddItem("Base.Pistol3");
		getPlayer():getInventory():AddItem("Base.Shotgun");
		getPlayer():getInventory():AddItem("Base.ShotgunSawnoff");
		getPlayer():getInventory():AddItem("Base.DoubleBarrelShotgun");
		getPlayer():getInventory():AddItem("Base.DoubleBarrelShotgunSawnoff");
		getPlayer():getInventory():AddItem("Base.AssaultRifle");
		getPlayer():getInventory():AddItem("Base.AssaultRifle2");
		getPlayer():getInventory():AddItem("Base.Revolver");
		getPlayer():getInventory():AddItem("Base.Revolver_Short");
		getPlayer():getInventory():AddItem("Base.Revolver_Long");
		getPlayer():getInventory():AddItem("Base.VarmintRifle");
		getPlayer():getInventory():AddItem("Base.HuntingRifle");
        getPlayer():getInventory():AddItem("Base.BaseballBat");
        getPlayer():getInventory():AddItem("Base.Axe");
		getPlayer():setUnlimitedCarry(true);
		getPlayer():setPerkLevelDebug(Perks.Aiming,10);

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
