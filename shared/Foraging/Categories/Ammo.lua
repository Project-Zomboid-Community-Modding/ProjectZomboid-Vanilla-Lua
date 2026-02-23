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
				["Bullets357"]        = "Base.Bullets357",
				["Bullets38"]        = "Base.Bullets38",
				["Bullets9mm"]       = "Base.Bullets9mm",
				["Bullets45"]        = "Base.Bullets45",
				["Bullets44"]        = "Base.Bullets44",
				["3030Bullets"]       = "Base.3030Bullets",
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
				["3030Box"]           = "Base.3030Box",
				["308Box"]           = "Base.308Box",
				["Bullets357Box"]     = "Base.Bullets357Box",
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
