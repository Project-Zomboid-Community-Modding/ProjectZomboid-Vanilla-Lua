CDDA = {}

CDDA.Add = function()
	addChallenge(CDDA);
end

CDDA.OnGameStart = function()
	local pl = getPlayer();

	if pl:getHoursSurvived() > 0 then return end

	local square = pl:getCurrentSquare();
	if not square then return end
	local room = square:getRoom();
	if not room then return end
	local building = room:getBuilding();
	if not building then return end

	local i = 0
	while i <= 4 do
		local tile = building:getRandomRoom():getRandomSquare();
		if tile:getRoom() == room then
			-- nothing
		else
			i = i + 1;
	        IsoFireManager.explode(getCell(), tile, 100000)
		end
	end
end

CDDA.OnInitWorld = function()
	SandboxVars.Zombies = 1;
	SandboxVars.Distribution = 1;
	SandboxVars.DayLength = 3;
	SandboxVars.StartMonth = 12;
	SandboxVars.StartTime = 2;
	SandboxVars.WaterShutModifier = -1;
	SandboxVars.ElecShutModifier = -1;
    SandboxVars.LootItemRemovalList = "";
	SandboxVars.Temperature = 3;
	SandboxVars.Rain = 3;
	SandboxVars.ErosionSpeed = 1
	SandboxVars.Farming = 3;
	SandboxVars.NatureAbundance = 5;
	SandboxVars.PlantResilience = 3;
	SandboxVars.PlantAbundance = 3;
	SandboxVars.Alarm = 3;
	SandboxVars.LockedHouses = 3;
	SandboxVars.FoodRotSpeed = 3;
	SandboxVars.FridgeFactor = 3;
	SandboxVars.LootRespawn = 1;
	SandboxVars.StatsDecrease = 3;
	SandboxVars.StarterKit = false;
	SandboxVars.TimeSinceApo = 13;
	SandboxVars.MultiHitZombies = false;

	SandboxVars.MultiplierConfig = {
		XPMultiplierGlobal = 1,
		XPMultiplierGlobalToggle = true,
	}
	

	SandboxVars.ZombieConfig.PopulationMultiplier = ZombiePopulationMultiplier.Insane

	Events.OnGameStart.Add(CDDA.OnGameStart);
end

CDDA.RemovePlayer = function(p)

end

CDDA.AddPlayer = function(playerNum, playerObj)
	if playerObj:getHoursSurvived() > 0 then return end

	playerObj:getStats():set(CharacterStat.INTOXICATION, 100);

	playerObj:getInventory():clear();
	playerObj:clearWornItems();
	playerObj:getStats():set(CharacterStat.WETNESS, CharacterStat.WETNESS:getMaximumValue());
    for i=0, playerObj:getBodyDamage():getBodyParts():size() - 1 do
        playerObj:getBodyDamage():getBodyParts():get(i):setWetness(CharacterStat.WETNESS:getMaximumValue())
    end
	playerObj:getBodyDamage():setCatchACold(0.0);
	playerObj:getBodyDamage():setHasACold(true);
	playerObj:getBodyDamage():setColdStrength(50.0);
	playerObj:getBodyDamage():setTimeToSneezeOrCough(0);
	playerObj:setClothingItem_Feet(nil)
	playerObj:setClothingItem_Legs(nil)
	playerObj:setClothingItem_Torso(nil)
	playerObj:getBodyDamage():getBodyPart(BodyPartType.Groin):generateDeepShardWound();
end

CDDA.Render = function()
end

CDDA.id = "AReallyCDDAy";
CDDA.completionText = "Survive a night to unlock next challenge.";
CDDA.image = "media/lua/client/LastStand/AReallyCDDAy.png";
CDDA.video = "CDDA.bik";
CDDA.gameMode = "A Really CD DA";
CDDA.world = "Muldraugh, KY";
CDDA.x = 36 * 300 + 21;
CDDA.y = 31 * 300 + 111;
CDDA.z = 0;

CDDA.spawns = {
	{x = 10788, y = 9985, z = 0},
	{x = 10693, y = 9745, z = 0},
	{x = 10770, y = 9688, z = 0},
	{x = 10746, y = 9413, z = 1},
	{x = 11791, y = 6855, z = 0},
	{x = 11604, y = 6877, z = 1},
	{x = 11496, y = 6700, z = 1},
	{x = 11415, y = 6665, z = 0},
	{x = 11218, y = 6791, z = 1},
	{x = 11217, y = 6797, z = 1},
	{x = 10639, y = 6800, z = 1},
	{x = 10839, y = 12153, z = 1},
	{x = 11673, y = 6810, z = 1},
}

CDDA.hourOfDay = 7;
Events.OnChallengeQuery.Add(CDDA.Add)
