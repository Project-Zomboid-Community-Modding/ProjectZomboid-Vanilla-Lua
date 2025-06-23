--[[---------------------------------------------
-------------------------------------------------
--
-- generateAmmoDefs
--
-- eris
--
-------------------------------------------------
--]]---------------------------------------------

require "Foraging/forageDefinitions";
require "Foraging/forageSystem";

local function generateAmmoDefs()
	local ammunition = {
		uncommon = {
			chance = 50,
			xp = 5,
			maxCount = 3,
			items = {
				["ShotgunShells"]    = "Base.ShotgunShells",
				["Bullets38"]        = "Base.Bullets38",
				["Bullets9mm"]       = "Base.Bullets9mm",
				["Bullets45"]        = "Base.Bullets45",
				["Bullets44"]        = "Base.Bullets44",
				["223Bullets"]       = "Base.223Bullets",
				["308Bullets"]       = "Base.308Bullets",
				["556Bullets"]       = "Base.556Bullets",
			},
		},
		rare = {
			chance = 5,
			xp = 10,
			maxCount = 2,
			items = {
				["44Clip"]           = "Base.44Clip",
				["45Clip"]           = "Base.45Clip",
				["556Clip"]          = "Base.556Clip",
				["9mmClip"]          = "Base.9mmClip",
				["M14Clip"]          = "Base.M14Clip",
			},
		},
		legendary = {
			chance = 1,
			xp = 25,
			maxCount = 1,
			items = {
				["223Box"]           = "Base.223Box",
				["308Box"]           = "Base.308Box",
				["Bullets38Box"]     = "Base.Bullets38Box",
				["Bullets44Box"]     = "Base.Bullets44Box",
				["Bullets45Box"]     = "Base.Bullets45Box",
				["Bullets9mmBox"]    = "Base.Bullets9mmBox",
				["ShotgunShellsBox"] = "Base.ShotgunShellsBox",
				["556Box"]           = "Base.556Box",
			},
		},
	};
	for _, spawnTable in pairs(ammunition) do
		for itemName, itemFullName in pairs(spawnTable.items) do
			forageSystem.addForageDef(
				itemName,
				{
					type = itemFullName,
					minCount = 1,
					maxCount = spawnTable.maxCount;
					skill = 4,
					xp = spawnTable.xp,
					categories = { "Ammunition" },
					zones = {
						TrailerPark = spawnTable.chance,
						TownZone = spawnTable.chance,
						ForagingNav = spawnTable.chance,
					},
					forceOutside = false,
					canBeAboveFloor = true,
				}
			);
		end;
	end;
end

generateAmmoDefs();