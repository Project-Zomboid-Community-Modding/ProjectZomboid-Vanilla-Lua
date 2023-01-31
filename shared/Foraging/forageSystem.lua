--[[---------------------------------------------
-------------------------------------------------
--
-- forageSystem
--
-- eris
--
-------------------------------------------------
--]]---------------------------------------------
if isServer() then return; end;  --temp block server from loading this module
-------------------------------------------------
-------------------------------------------------
require "Foraging/forageDefinitions";
-------------------------------------------------
-------------------------------------------------
local table = table;
local math  = math;
-------------------------------------------------
-------------------------------------------------
local function iterList(_list)
	local list = _list;
	local size = list:size() - 1;
	local i = -1;
	return function()
		i = i + 1;
		if i <= size and not list:isEmpty() then
			return list:get(i), i;
		end;
	end;
end

local function isInRect(_x, _y, _x1, _x2, _y1, _y2)
	return (_x >= _x1 and _x <= _x2 and _y >= _y1 and _y <= _y2) or false;
end

local function clamp(_value, _min, _max)
	if _min > _max then _min, _max = _max, _min; end;
	return math.min(math.max(_value, _min), _max);
end
--[[---------------------------------------------
--
-- forageSystem
--
--]]---------------------------------------------

--[[--======== forageSystem ========--]]--

forageSystem = {
	isInitialised		 = false,
	-- definition tables
	itemDefs             = {}, -- item table
	catDefs    		     = {}, -- category definitions
	zoneDefs             = {}, -- zone definitions
	skillDefs            = {   -- occupation and trait bonus definitions
		occupation = {},
		trait      = {},
	},
	-- forage system loot tables
	lootTables			 = {},  -- the loot table - see generateLootTable for structure
	lootTableMonth   	 = nil, -- used to keep the loot table in line with the game date
	--
	--tracking for rerolling icons
	currentMonth         = 0,
	currentTime          = "isDay",
	currentWeather       = "isNormal",
	--
	maxIconsPerZone      = 2000,-- maximum icons possible in any zone
	zoneDensityMulti     = 20,  -- default icon density value for all zones.
	-- sandbox settings
	abundanceSettings    = {
		NatureAbundance  = { -75, -50, 0, 50, 100 }, -- bonus percent density per zone
		OtherLoot        = { -100, -95, -75, -50, 0, 50, 100 }, -- bonus percent density per zone
	},
	-- extended chance settings (percents)
	monthBonus           = 50,  -- good forage months
	monthMalus           = -50, -- bad forage months
	-- vision settings (squares)
	levelBonus           = 0.5, -- bonus per perk level
	-- vision settings (radius multipliers)
	aimMultiplier		 = 1.33,    --multiply radius by this amount when aiming/looking around
	sneakMultiplier		 = 1.10,    --multiply radius by this amount when sneaking
	darkVisionRadius	 = 1.5,     --icon radius for dark squares (less than lightPenaltyCutoff)
	minVisionRadius      = 3.0,     --the minimum radius from center for vision checks (well lit squares)
	maxVisionRadius      = 10.0,    --the maximum radius from center for vision checks (before bonuses)
	visionRadiusCap      = 15.0,    --the maximum radius cap from center for vision checks (after bonuses)
	minimumSizeBonus     = 0.50,    --used in calculating bonus for item size

	-- foraging penalty
	endurancePenalty     = 0.015,
	fatiguePenalty       = -0.001,

	-- vision settings (percents) (search radius)
	lightPenaltyMax      = 95, -- darkness effect on search radius (light level)
	weatherPenaltyMax    = 75, -- weather effect (rain, fog, snow)
	exhaustionPenaltyMax = 75, -- exhaustion effect (endurance, fatigue)
	panicPenaltyMax      = 95, -- panic effect (fear, panic, stress)
	bodyPenaltyMax       = 75, -- body effect (drunk, pain, sickness, food sickness)
	clothingPenaltyMax   = 95, -- clothing effect (helmet, glasses, blindfolds)
	hungerBonusMax       = 50, -- hunger effect (finding food when hungry)
	effectReductionMax   = 75, -- maximum effect reduction from traits/occupation

	-- specific to lighting level - if penalty is higher than this, cannot spot anything (radius will still change)
	lightPenaltyCutoff	 = 50,

	clothingPenalties 	  = {  -- clothing vision penalties (percents)
		--unless it covers the eye area, it has no penalty
		--regular hats, bandanas, etc. have no penalty
		FullSuitHead    = 75,   --completely covers the head, face and eyes
		FullHat		    = 75,   --completely covers the head, face and eyes
		MaskFull	    = 50,   --covering the face and eyes but not head
		MaskEyes	    = 20,   --just covering the face but with eye holes
		Mask	        = 20,   --just covering the face but with eye holes
		Eyes		    = 2.5,  --small debuff for wearing sunglasses
		LeftEye		    = 2.5,  --yarr, eyepatches give a little debuff
		RightEye	    = 2.5,  --yarr, eyepatches give a little debuff
	};

	isForageableFuncs = {
		"isItemExist",		"isValidMonth",		 "isItemInZone", 		"hasNeededPerks",
		"hasNeededTraits",	"hasNeededRecipes",	 "hasRequiredItems",
	},

	-- world object sprites (used by ISSearchManager scanner)
	spriteAffinities	 = {},

	-- base XP modifier for foraging (percent)
	globalXPModifier     = 800,

	-- diminishing base XP returns per level for foraging items below skill level (percent)
	levelXPModifier      = 5,
};

function forageSystem.integrityCheck()
	print("[forageSystem][integrityCheck] checking all zoneData.");
	local zonesChecked = 0;
	local zonesRemoved = 0;
	local iconsChecked = 0;
	local iconsRemoved = 0;
	local isInRect = isInRect;
	local metaGrid = getWorld():getMetaGrid();
	local wx1, wx2, wy1, wy2 = metaGrid:getMinX() * 300, metaGrid:getMaxX() * 300, metaGrid:getMinY() * 300, metaGrid:getMaxY() * 300;
	for zoneID, zoneData in pairs(forageData) do
		local removeZone = false;
		local x1, x2, y1, y2;
		if zoneData.bounds then
			x1, x2, y1, y2 = zoneData.bounds.x1, zoneData.bounds.x2, zoneData.bounds.y1, zoneData.bounds.y2;
		end;
		if not forageSystem.zoneDefs[zoneData.name] then
			removeZone = true;
			print("[forageSystem][integrityCheck] zoneDef does not exist for " .. (zoneData.name or "[no type]"));
			print("[forageSystem][integrityCheck] removing zone " .. zoneID .. ".");
		elseif not (x1 and x2 and y1 and y2) then
			removeZone = true;
			print("[forageSystem][integrityCheck] zoneDef does not have valid bounds " .. (zoneData.name or "[no type]"));
			print("[forageSystem][integrityCheck] removing zone " .. zoneID .. ".");
		elseif not (isInRect(x1, y1, wx1, wx2, wy1, wy2) and isInRect(x2, y2, wx1, wx2, wy1, wy2)) then
			removeZone = true;
			print("[forageSystem][integrityCheck] zone is outside the world boundary " .. (zoneData.name or "[no type]"));
			print("[forageSystem][integrityCheck] removing zone " .. zoneID .. ".");
		end
		if not removeZone and not forageSystem.checkMetaZone(zoneData) then
			removeZone = true;
			print("[forageSystem][integrityCheck] metagrid zone doesn't exist " .. (zoneData.name or "[no type]"));
			print("[forageSystem][integrityCheck] removing zone " .. zoneID .. ".");
		end;
		if not removeZone then
			--ensure itemsLeft is within limits
			if zoneData.itemsLeft < 0 then zoneData.itemsLeft = 0; end;
			if zoneData.itemsLeft > zoneData.itemsTotal then zoneData.itemsLeft = zoneData.itemsTotal; end;
			--
			for iconID, iconData in pairs(zoneData.forageIcons) do
				local removeIcon = false;
				if not forageSystem.itemDefs[iconData.itemType] then removeIcon = true;
					print("[forageSystem][integrityCheck] itemDef does not exist for " .. (iconData.itemType or "[no type]"));
					print("[forageSystem][integrityCheck] removing icon " .. iconID .. ".");
				elseif not forageSystem.catDefs[iconData.catName] then removeIcon = true;
					print("[forageSystem][integrityCheck] catDef does not exist for " .. (iconData.catName or "[no category]"));
					print("[forageSystem][integrityCheck] removing icon " .. iconID .. ".");
				elseif not (iconData.x and iconData.y and iconData.z) then removeIcon = true;
					print("[forageSystem][integrityCheck] icon has invalid or missing x/y/z location " .. iconID .. ".");
					print("[forageSystem][integrityCheck] removing icon " .. iconID .. ".");
				elseif not isInRect(iconData.x, iconData.y, x1, x2,	y1, y2) then removeIcon = true;
					print("[forageSystem][integrityCheck] icon is out of zone bounds " .. iconID .. ".");
					print("[forageSystem][integrityCheck] removing icon " .. iconID .. ".");
				end;
				--
				if removeIcon then
					zoneData.forageIcons[iconID] = nil;
					iconsRemoved = iconsRemoved + 1;
				end;
				--
				iconsChecked = iconsChecked + 1;
			end;
		end;
		if removeZone then
			forageData[zoneID] = nil;
			zonesRemoved = zonesRemoved + 1;
		end;
		zonesChecked = zonesChecked + 1;
	end;
	print("[forageSystem][integrityCheck] checked integrity of " .. zonesChecked .. " zones.");
	if zonesRemoved > 0 then
		print("[forageSystem][integrityCheck] " .. zonesRemoved .. " zones failed integrity check and were removed.");
	else
		print("[forageSystem][integrityCheck] all zones passed testing.");
	end;
	print("[forageSystem][integrityCheck] checked integrity of " .. iconsChecked .. " icons.");
	if iconsRemoved > 0 then
		print("[forageSystem][integrityCheck] " .. iconsRemoved .. " icons failed integrity check and were removed.");
	else
		print("[forageSystem][integrityCheck] all icons passed testing.");
	end;
end

function forageSystem.init()
	--prevent multiple initialisations
	if forageSystem.isInitialised then return; end;
	--
	triggerEvent("preAddForageDefs", forageSystem);
	--
	triggerEvent("preAddSkillDefs", forageSystem);
	forageSystem.populateSkillDefs();
	--
	triggerEvent("preAddZoneDefs", forageSystem);
	forageSystem.populateZoneDefs();
	--
	triggerEvent("preAddCatDefs", forageSystem);
	forageSystem.populateCatDefs();
	--
	triggerEvent("preAddItemDefs", forageSystem);
	forageSystem.populateScavengeDefs();
	forageSystem.populateItemDefs();
	--
	triggerEvent("onAddForageDefs", forageSystem);
	--forageSystem.generateLootTable2();
	forageSystem.generateLootTable();
	--
	--initialise forageData table
	if isClient() then
		forageClient.init();
		forageClient.updateData();
	end;
	--
	--check integrity of forageData
	forageSystem.integrityCheck();
	--
	--forageSystem.statisticsDebug(); --debug spawn rates
	--forageClient.clearData(); --debug clear forageData database
	--forageClient.syncForageData();
	--
	forageSystem.updateTimeValues();
	--
	Events.EveryHours.Add(forageSystem.recreateIcons);
	Events.EveryDays.Add(forageSystem.recreateIcons);
	Events.EveryDays.Add(forageSystem.lootTableUpdate);
	Events.OnWeatherPeriodStart.Add(forageSystem.recreateIcons);
	Events.OnWeatherPeriodStage.Add(forageSystem.recreateIcons);
	Events.OnWeatherPeriodComplete.Add(forageSystem.recreateIcons);
	--
	forageSystem.isInitialised = true;
end

Events.OnLoadedMapZones.Add(forageSystem.init);

--[[---------------------------------------------
--
-- zoneData
--
--]]---------------------------------------------

--[[--======== createZoneData ========--
	@param _forageZone
	@param _zoneDef
]]--

function forageSystem.createZoneData(_forageZone, _zoneDef)
	local zoneData = {};
	--
	zoneData.id             = _forageZone:getName();
	_forageZone:setName(zoneData.id);
	_forageZone:setOriginalName(zoneData.id);
	zoneData.name           = _zoneDef.name;
	zoneData.x              = _forageZone:getX();
	zoneData.y              = _forageZone:getY();
	zoneData.size           = _forageZone:getWidth() * _forageZone:getHeight();
	zoneData.bounds         = {
		x1			    = zoneData.x,
		y1			    = zoneData.y,
		x2			    = zoneData.x + _forageZone:getWidth(),
		y2			    = zoneData.y + _forageZone:getHeight(),
	};
	zoneData.itemsTotal     = 0;
	zoneData.itemsLeft      = 0;
	zoneData.forageIcons    = {};
	forageSystem.checkMetaZone(zoneData);
	--
	forageSystem.fillZone(zoneData);
	forageClient.addZone(zoneData);
	--
	return zoneData;
end

function forageSystem.checkMetaZone(_zoneData)
	if _zoneData.metaZone then return true end
	local metaGrid = getWorld():getMetaGrid();
	local bounds = _zoneData.bounds;
	local zone = metaGrid:getZoneWithBoundsAndType(bounds.x1, bounds.y1, 0, bounds.x2 - bounds.x1, bounds.y2 - bounds.y1, _zoneData.name);
	if zone ~= nil then
		_zoneData.size = zone:getTotalArea();
		_zoneData.metaZone = zone;
		return true;
	end
	return false;
end

function forageSystem.zoneContains(_zoneData, _x, _y, _z)
	if not _zoneData or not _zoneData.metaZone then return false; end;
	return _zoneData.metaZone:contains(_x, _y, _z);
end

function forageSystem.zoneIntersects(_zoneData, _x, _y, _z, _w, _h)
	if not _zoneData or not _zoneData.metaZone then return false; end;
	return _zoneData.metaZone:intersects(_x, _y, _z, _w, _h);
end

function forageSystem.fillZone(_zoneData)
	local zoneDef = forageSystem.zoneDefs[_zoneData.name];
	local refillValue = zoneDef.densityMin;
	if zoneDef.densityMin ~= zoneDef.densityMax then
		refillValue = ZombRandFloat(zoneDef.densityMin, zoneDef.densityMax * forageSystem.getRefillBonus(_zoneData));
	end;
	refillValue = math.floor((_zoneData.size / (forageSystem.zoneDensityMulti * 100)) * refillValue);
	--roll for up to 3 bonus items if the zone would otherwise be empty
	if (refillValue < 1) and (ZombRand(100) <= 10) then refillValue = (ZombRand(3) + 1); end;
	_zoneData.itemsLeft = refillValue;
	_zoneData.itemsTotal = _zoneData.itemsLeft;
	_zoneData.lastRefill = forageSystem.getWorldAge();
end

--[[--======== checkRefillZone ========--
	@param _zoneData
]]--

function forageSystem.checkRefillZone(_zoneData)
	--don't refill zones which are active/seen today
	--local zones = getZones(_zoneData.x, _zoneData.y, 0);
	--for zone in iterList(zones) do
	--	if zone:getType() == "ForageZone" then
	--		if zone:getHoursSinceLastSeen() <= 24 then
	--			return;
	--		end;
	--	end;
	--end;
	--
	local worldAge = forageSystem.getWorldAge();
	local zoneDef = forageSystem.zoneDefs[_zoneData.name];
	if zoneDef then
		if _zoneData.itemsTotal > _zoneData.itemsLeft then
			local lastRefillDays = math.floor((worldAge - _zoneData.lastRefill) / 24);
			local refillAmount = _zoneData.itemsTotal * (lastRefillDays * (zoneDef.refillPercent / 100));
			if refillAmount >= 1 then
				_zoneData.itemsLeft = math.floor(_zoneData.itemsLeft + refillAmount);
				if _zoneData.itemsLeft > _zoneData.itemsTotal then _zoneData.itemsLeft = _zoneData.itemsTotal; end;
				_zoneData.lastRefill = worldAge
			end;
		elseif _zoneData.itemsTotal <= _zoneData.itemsLeft then
			--if the zone is full or has too many items, re-roll the density and icons
			forageSystem.fillZone(_zoneData);
		end;
		forageSystem.updateZone(_zoneData);
	end;
end

--[[--======== updateZone ========--]]--

function forageSystem.updateZone(_zoneData)
	_zoneData.lastAction = forageSystem.getWorldAge();
	forageClient.updateZone(_zoneData);
end

--[[--======== takeItem ========--
	@param _zoneData
	@param _number - (optional) number of items to take

	Returns number of forages remaining
]]--

function forageSystem.takeItem(_zoneData, _number)
	local number = _number or 1;
	_zoneData.itemsLeft = clamp(_zoneData.itemsLeft - number, 0, _zoneData.itemsLeft);
	forageClient.updateZone(_zoneData);
	return _zoneData.itemsLeft;
end

function forageSystem.getWorldAge()
	return getGameTime():getWorldAgeHours();
end

--[[--======== statisticsDebug ========--
	Gathers and prints item spawn statistics for each loot table

	For debugging and balancing loot rates.
]]--

--function forageSystem.statisticsDebug()
--	local numberOfTests = 10000;
--	local category, itemType, lootTable;
--	local categorySpawned = {};
--	local itemsSpawned = {};
--	local fileWriterObj = getFileWriter("statisticsDebug.log", true, false);
--	for zoneName, zoneLoot in pairs(forageSystem.lootTables) do
--		for month, monthLoot in pairs(zoneLoot) do
--			for timeOfDay, timeLoot in pairs(monthLoot) do
--				for weatherType, weatherLoot in pairs(timeLoot) do
--					if weatherType == "isNormal" then
--						fileWriterObj:write(zoneName.." - "..month.." - "..weatherType.."\r\n");
--						print("[forageSystem][statisticsDebug] TESTING ZONE: " .. zoneName .. " - (" .. numberOfTests .. " ROLLS)");
--						print("[forageSystem][statisticsDebug] MONTH : " .. month);
--						print("[forageSystem][statisticsDebug] WEATHER TYPE: " .. weatherType);
--						lootTable = weatherLoot;
--						for i = 1, numberOfTests do
--							itemType, category = forageSystem.pickRandomItemType(lootTable);
--							categorySpawned[category] = (categorySpawned[category] or 0) + 1;
--							itemsSpawned[itemType] = (itemsSpawned[itemType] or 0) + 1;
--						end;
--						print("[forageSystem][statisticsDebug] CATEGORIES PICKED");
--						for category, amount in pairs(categorySpawned) do
--							--fileWriterObj:write(category..","..amount.."\r\n");
--							print(category.." = "..amount.." (".. tonumber(string.format("%.3f",  (amount/numberOfTests) * 100)) .."%)");
--						end;
--						print("[forageSystem][statisticsDebug] ITEMS PICKED");
--						for itemType, amount in pairs(itemsSpawned) do
--							fileWriterObj:write(itemType..","..amount.."\r\n");
--							print(itemType .. " = " .. amount);
--						end;
--						itemsSpawned = {};
--						categorySpawned = {};
--						print("[forageSystem][statisticsDebug] FINISHED TESTING: " .. zoneName);
--						--fileWriterObj:write("\r\n");
--					end;
--				end;
--			end;
--		end;
--	end;
--	fileWriterObj:close();
--end

--[[--======== createForageIcons ========--
	@param _zoneData
	@param _recreate
	@param _count - number of items to create
]]--

function forageSystem.createForageIcons(_zoneData, _recreate, _count)
	forageSystem.lootTableUpdate();
	local maxIconsPerZone = forageSystem.maxIconsPerZone;
	local count = _count or maxIconsPerZone;
	local forageIcons = {};
	--
	if _recreate then _zoneData.forageIcons = {}; end;
	--
	for _, icon in pairs(_zoneData.forageIcons) do
		if forageSystem.itemDefs[icon.itemType] then
			table.insert(forageIcons, icon);
		else
			print("[forageSystem][createForageIcons] itemDef not defined for itemType, skipping " .. icon.itemType);
		end;
	end;
	if (not _zoneData) or (not _zoneData.name) or (not forageSystem.zoneDefs[_zoneData.name]) then
		print("[forageSystem][createForageIcons] zoneDef not defined for zoneData type, skipping " .. _zoneData.name or "undefined");
		return forageIcons;
	end;
	if (not forageSystem.lootTables[_zoneData.name]) then
		print("[forageSystem][createForageIcons] a loot table is not generated for zoneData type, skipping " .. _zoneData.name);
		return forageIcons;
	end;
	--
	local month = getGameTime():getMonth() + 1;
	local timeOfDay = forageSystem.getTimeOfDay() or "isDay";
	local weatherType = forageSystem.getWeatherType() or "isNormal";
	local lootTable = forageSystem.lootTables[_zoneData.name][month][timeOfDay][weatherType];
	local getRandomUUID = getRandomUUID;
	local itemsLeft = math.floor(_zoneData.itemsLeft);
	if itemsLeft > 0 and #forageIcons < itemsLeft then
		--create icons
		local i = 0;
		local zoneid    = _zoneData.id;
		local x1, x2    = _zoneData.bounds.x1, _zoneData.bounds.x2;
		local y1, y2    = _zoneData.bounds.y1, _zoneData.bounds.y2;
		local rX, rY    = x1, y1;
		local forageIcon, itemType, catName;
		local getRandomCoord = forageSystem.getRandomCoord;
		local location = Location.new();
		repeat
			itemType, catName = forageSystem.pickRandomItemType(lootTable);
			if itemType and catName then
--				rX, rY = getRandomCoord(x1, x2, y1, y2);
				local location = _zoneData.metaZone:pickRandomLocation(location)
				if location then
					rX, rY = location:getX(), location:getY()
					forageIcon = {
						id          = getRandomUUID(),
						zoneid      = zoneid,
						x           = rX,
						y           = rY,
						z           = 0,
						catName     = catName,
						itemType    = itemType,
						isBonusIcon = false,
					};
					table.insert(forageIcons, forageIcon);
					_zoneData.forageIcons[forageIcon.id] = forageIcon;
				end
			end;
			i = i + 1;
		until	i >= count
		or		i >= maxIconsPerZone
		or		#forageIcons >= maxIconsPerZone
		or		#forageIcons >= itemsLeft
	end;
	forageClient.updateZone(_zoneData);
	return forageIcons;
end

--[[--======== updateTimeValues ========--]]--

function forageSystem.updateTimeValues()
	forageSystem.currentMonth = (getGameTime():getMonth() + 1);
	forageSystem.currentTime = forageSystem.getTimeOfDay();
	forageSystem.currentWeather = forageSystem.getWeatherType();
end

--[[--======== checkIfRecreateIcons ========--]]--

function forageSystem.checkIfRecreateIcons()
 return forageSystem.currentMonth ~= (getGameTime():getMonth() + 1)
    or  forageSystem.currentTime ~= forageSystem.getTimeOfDay()
    or  forageSystem.currentWeather ~= forageSystem.getWeatherType();
end

--[[--======== recreateIcons ========--

]]--

function forageSystem.recreateIcons()
	forageSystem.lootTableUpdate();
	--
	if forageSystem.checkIfRecreateIcons() then
		local icon;
		for zoneID, zoneData in pairs(forageData) do
			if (not zoneData.forageIcons) then zoneData.forageIcons = {}; end;
			for iconID in pairs(zoneData.forageIcons) do
				local removeIcon = true;
				for character, manager in pairs(ISSearchManager.players) do
					if manager and manager.isSearchMode then
						icon = manager.forageIcons[iconID];
						if icon and (icon:getIsSeen() or icon:getIsNoticed()) then
							removeIcon = false;
							icon.isNoticed = false;
						end;
					end;
				end;
				if removeIcon then
					triggerEvent("onUpdateIcon", zoneData, iconID, nil);
					zoneData.forageIcons[iconID] = nil;
				end;
			end;
			forageSystem.checkRefillZone(zoneData);
			forageClient.updateZone(zoneData);
		end;
	end;
	--update tracking values
	forageSystem.updateTimeValues();
end

--[[--======== getZoneData ========--
	@param _forageZone - IsoZone

]]--

function forageSystem.getZoneData(_forageZone, _zoneDef, _x, _y)
	if not _forageZone then return nil; end;
	if _forageZone:getType() == "ForageZone" then
		local zoneData = forageData[_forageZone:getName()];
		if zoneData then
			forageClient.updateZone(zoneData);
			return zoneData;
		else
			if _zoneDef then
				print("[forageSystem][getZoneData] zoneData will be initialised for ".. _forageZone:getType());
				return forageSystem.createZoneData(_forageZone, _zoneDef);
			end;
			if _x and _y then
				local defZone, zoneDef = forageSystem.getDefinedZoneAt(_x, _y);
				if (defZone and zoneDef) then
					print("[forageSystem][getZoneData] zoneData will be initialised for ".. _forageZone:getType());
					return forageSystem.createZoneData(_forageZone, zoneDef);
				end;
			end;
		end;
	else
		print("[forageSystem][getZoneData] tried to get zoneData for non scavenge zone: ".. _forageZone:getType());
	end;
	print("[forageSystem][getZoneData] zoneData not found, removing ".. _forageZone:getType());
	return nil;
end

--[[---------------------------------------------
--
-- lootTables
--
--]]---------------------------------------------

--[[--======== pickRandomItemType ========--
	@param _lootTable - the loot table to use

	 See forageSystem.generateLootTable for loot table structure
]]--

function forageSystem.pickRandomItemType(_lootTable)
	if #_lootTable > 0 then
		local rolledCategory = _lootTable[ZombRand(#_lootTable) + 1];
		if rolledCategory then
			local rolledItem = rolledCategory.items[ZombRand(#rolledCategory.items) + 1];
			if rolledItem then
				return rolledItem, rolledCategory.category;
			end;
		end;
	end;
	return nil, nil;
end

--[[--======== lootTableUpdate ========--]]--

function forageSystem.lootTableUpdate()
	--if the month has changed then we need to generate a new loot table
	if forageSystem.lootTableMonth ~= getGameTime():getMonth() + 1 then
		forageSystem.generateLootTable();
	end;
end

--[[--======== generateLootTable ========--]]--

function forageSystem.generateLootTable()
	--local timeStart = getTimestampMs();
	--reset loot tables
	forageSystem.lootTables = {};
	--
	local pairs                 = pairs;
	local ipairs                = ipairs;
	local unpack                = unpack;
	local insert                = table.insert;
	local itemDefs              = forageSystem.itemDefs;
	local zoneDefs              = forageSystem.zoneDefs;
	local catDefs               = forageSystem.catDefs;
	local lootTables            = forageSystem.lootTables;
	local getMonthBonus         = forageSystem.getMonthBonus;
	local getWeatherBonus       = forageSystem.getWeatherBonus;
	local getTimeOfDayBonus     = forageSystem.getTimeOfDayBonus;
	local isValidMonth          = forageSystem.isValidMonth;
	--
	local monthBonus;
	local timeBonus;
	local weatherBonus;
	local catChance;
	--
	--loot table month
	local month = getGameTime():getMonth() + 1;
	forageSystem.lootTableMonth = month;
	--generate for these types of weather - the tables here are passed as parameters to forageSystem.getWeatherBonus
	local weatherTypes = {
		isNormal  = {   false,  false,  false   },
		isRaining = {   true,   false,  false   },
		hasRained = {   false,  false,  true    },
		isSnowing = {   false,  true,   false   },
	};
	--generate for these times of day - the values here are passed as parameters to forageSystem.getTimeOfDayBonus
	local timesOfDay = {
		isDay   = true,
		isNight = false,
	};
	--create the table structure
	print("[forageSystem][generateLootTable] Begin generating loot tables");
	-- do final loot table for zone
	local zoneLootTable = {};
	for zoneName in pairs(zoneDefs) do
		lootTables[zoneName] = {};
		zoneLootTable[zoneName] = {};
		lootTables[zoneName][month] = {};
		zoneLootTable[zoneName][month] = {};
		for timeOfDay in pairs(timesOfDay) do
			lootTables[zoneName][month][timeOfDay] = {};
			zoneLootTable[zoneName][month][timeOfDay] = {};
			for weatherType in pairs(weatherTypes) do
				lootTables[zoneName][month][timeOfDay][weatherType] = {};
				zoneLootTable[zoneName][month][timeOfDay][weatherType] = {};
				for catName in pairs(catDefs) do
					zoneLootTable[zoneName][month][timeOfDay][weatherType][catName] = {category = catName, items = {}};
				end;
			end;
		end;
	end;
	print("[forageSystem][generateLootTable] Finished generating loot table structure");
	--
	print("[forageSystem][generateLootTable] Begin populating loot table");
	for itemType, itemDef in pairs(itemDefs) do
		if isValidMonth(nil, itemDef, nil, month) then
			monthBonus = getMonthBonus(itemDef, month);
			for timeOfDay, timeBonusParams in pairs(timesOfDay) do
				timeBonus = getTimeOfDayBonus(itemDef, timeBonusParams);
				for weatherType, weatherBonusParams in pairs(weatherTypes) do
					weatherBonus = getWeatherBonus(itemDef, unpack(weatherBonusParams));
					for zoneName, zoneChance in pairs(itemDef.zones) do
						if zoneDefs[zoneName] then
							for _, catName in ipairs(itemDef.categories) do
								if catDefs[catName] then
									for i = 1, zoneChance * monthBonus * timeBonus * weatherBonus do
										insert(zoneLootTable[zoneName][month][timeOfDay][weatherType][catName].items, itemType);
									end;
								else
									print("[forageSystem][generateLootTable] no such category is defined "..catName..", ignoring for definition "..itemType);
								end;
							end;
						else
							print("[forageSystem][generateLootTable] no such zone is defined "..zoneName..", ignoring for definition "..itemType);
						end;
					end;
				end;
			end;
		end;
	end;
	print("[forageSystem][generateLootTable] Finished populating loot table");
	--
	print("[forageSystem][generateLootTable] Begin populating loot table categories");
	for zoneName in pairs(zoneDefs) do
		for catName, catDef in pairs(catDefs) do
			catChance = (catDef.zoneChance[zoneName] or catDef.chance or 0);
			for timeOfDay, timeBonusParams in pairs(timesOfDay) do
				timeBonus = getTimeOfDayBonus(catDef, timeBonusParams);
				for weatherType, weatherBonusParams in pairs(weatherTypes) do
					weatherBonus = getWeatherBonus(catDef, unpack(weatherBonusParams));
					if #zoneLootTable[zoneName][month][timeOfDay][weatherType][catName].items > 0 then
						for _ = 1, catChance * timeBonus * weatherBonus do
							insert(lootTables[zoneName][month][timeOfDay][weatherType], zoneLootTable[zoneName][month][timeOfDay][weatherType][catName]);
						end;
					end;
				end;
			end;
		end;
	end;
	print("[forageSystem][generateLootTable] Finished populating loot table categories");
	--
	forageSystem.lootTables = lootTables;
	print("[forageSystem][generateLootTable] Finished generating loot tables");
	--print("[forageSystem][generateLootTable] Finished populating loot tables, took "..(getTimestampMs() - timeStart).."ms");
end

--[[---------------------------------------------
--
-- itemDefs
--
--]]---------------------------------------------

--[[--======== addItemDef ========--
	@param _itemDef

	Adds a definition to forageSystem.itemDefs

	example:

	an apple
	only in Forest zone
	chance is 1
	only available in July
	only in the ForestGoods category
	granting 10 xp

	(All missing definition info will be filled in automatically!)
	(See forageDefaultDefs.defaultItemDef for the possible values)

	local appleDef = {
		type = "Base.Apple",
        zones = {
            Forest      = 1,
        },
        categories = { "ForestGoods" },
		months = { 7, },
		xp = 10,
	};

	forageSystem.addItemDef(appleDef);

	if the definition exists, it will overwrite the existing one.
	only one definition may exist per item.

	To modify a definition: see forageSystem.modifyItemDef
]]--

function forageSystem.addItemDef(_itemDef)
	if not (_itemDef and _itemDef.type) then return; end;
	if forageSystem.isItemExist(nil, _itemDef) then
		local def = forageSystem.importDef(_itemDef, forageDefaultDefs.defaultItemDef);
		local defType = def.type;
		--set itemSize before importing
		if (not def.itemSize) then def.itemSize = forageSystem.getItemDefSize(def); end;
		if not forageSystem.itemDefs[defType] then
			--add definition
			forageSystem.itemDefs[defType] = def;
			return defType, true; -- defType is added
		else
			print("[forageSystem][addItemDef] item is already defined! ".._itemDef.type);
			print("[forageSystem][addItemDef] using forageSystem.modifyItemDef to change a defined itemDef for ".._itemDef.type);
			forageSystem.modifyItemDef(_itemDef);
		end;
		return defType, false; -- defType was not added
	else
		print("[forageSystem][addItemDef] no such item, ignoring ".._itemDef.type);
	end;
	return _itemDef.type, false; -- _itemDef.type could not be added
end

--[[--======== removeItemDef ========--
	@param _itemDef

	Removes a definition from forageSystem.itemDefs (matching _itemDef.type)

	example:

	to remove the definition for Base.Apple - this is all that is strictly required.

	forageSystem.removeItemDef({type = "Base.Apple"})

	an existing itemDef may be passed to this function too.

	example:

	local appleDef = forageSystem.itemDefs["Base.Apple"];

	forageSystem.removeItemDef(appleDef);
]]--

function forageSystem.removeItemDef(_itemDef)
	if _itemDef and forageSystem.isItemExist(nil, _itemDef) then
		forageSystem.itemDefs[_itemDef.type] = nil; --wipe the definition
	else
		print("[forageSystem][removeItemDef] no such item, ignoring "..((_itemDef and _itemDef.type) or "unknown type"));
	end;
end

--[[--======== modifyItemDef ========--
	@param _itemDef

	Removes a definition from forageSystem.itemDefs and replaces it with _itemDef.

	example:

	local appleDef = {
		type = "Base.Apple",
        zones = {
            Forest      = 10,
        },
        categories = { "ForestGoods", "Junk" },
		months = { 7, 8, 9 },
		xp = 1000,
	};

	forageSystem.modifyItemDef(appleDef);

	this can also be done with forageSystem.addItemDef
	both functions are provided for convenience
	if the itemDef does not exist, it will not be added via this function.
]]--

function forageSystem.modifyItemDef(_itemDef)
	if _itemDef and forageSystem.itemDefs[_itemDef.type] and forageSystem.isItemExist(nil, _itemDef) then
		forageSystem.removeItemDef(_itemDef);
		forageSystem.addItemDef(_itemDef);
	else
		print("[forageSystem][modifyItemDef] no such item or itemDef, ignoring "..((_itemDef and _itemDef.type) or "unknown type"));
	end;
end

--[[--======== populateScavengeDefs ========--
	The main functions for bulk adding old foraging system definitions to the new system.

	This should always be called before populateItemDefs, so any new definitions can overwrite the old ones!
]]--

function forageSystem.populateScavengeDefs()
	--add backwards compatible definitions
	for categoryName, category in pairs(scavenges) do
		for _, def in ipairs(category) do
			if not def.categories then
				local categoryToUse = categoryName;
				for catName in pairs(forageSystem.catDefs) do
					if string.lower(catName) == string.lower(categoryName) then
						categoryToUse = catName;
					end;
				end;
				def.categories = {tostring(categoryToUse)};
				if not forageSystem.catDefs[categoryToUse] then
					print("[forageSystem][populateScavengeDefs] no such category and did not find a match for " .. categoryName);
					print("[forageSystem][populateScavengeDefs] adding a new category "..categoryToUse.." with the default definition for "..categoryName);
					forageSystem.addCatDef({name = categoryToUse});
				end;
			end;
			forageSystem.addItemDef(def);
		end;
	end;
end

--[[--======== populateItemDefs ========--
	@param _itemDefs - (optional) a table of itemsDefs to add
	@param _clearAllExisting - (optional) clear all existing definitions

	The main function for bulk adding definitions. It can also be used to clear and recreate the entire itemDef table.
	A table full of itemDefs may be added via this function. See forageDefs for how to structure bulk tables.
]]--

function forageSystem.populateItemDefs(_itemDefs, _clearAllExisting)
	--clear the tables
	if (not _itemDefs) or _clearAllExisting then
		forageSystem.itemDefs = {};
	end;
	--populate itemDefs
	for _, def in pairs(_itemDefs or forageDefs) do
		forageSystem.addItemDef(def);
	end;
end

--[[---------------------------------------------
--]]---------------------------------------------

--[[--======== createForageZone ========--
	@param _x, _y - coordinates for zone
	@param _definedZone - (optional) IsoZone - use this defZone instead

	Create a scavenge zone at x/y, optionally sets number of forages remaining
]]--

function forageSystem.createForageZone(_x, _y, _defZone)
	local zoneDef, defZone;
	if _defZone then
		defZone = _defZone;
		zoneDef = forageSystem.getZoneDef(_defZone);
	else
		zoneDef, defZone = forageSystem.getDefinedZoneAt(_x, _y);
	end;
	if not (zoneDef and defZone) then return false; end;
	local forageZone = getWorld():registerZone(getRandomUUID(), "ForageZone", defZone:getX(), defZone:getY(), 0, defZone:getWidth(), defZone:getHeight());
	local zoneData = forageSystem.createZoneData(forageZone, zoneDef);
	forageClient.updateZone(zoneData);
	return zoneData;
end

function forageSystem.getForageZoneAt(_x, _y)
	local zones = getZones(_x, _y, 0);
	local forageZone, defZone;
	if zones then
		for zone in iterList(zones) do
			local zoneName = zone:getType();
			if forageSystem.zoneDefs[zoneName] then defZone = zone; end;
		end;
		if not defZone then return nil; end;
		-- There can be multiple rectangular ForageZone zones at the location.
		for zone in iterList(zones) do
			if zone:getType() == "ForageZone" then
				if zone:getX() == defZone:getX() and zone:getY() == defZone:getY() and zone:getZ() == defZone:getZ() and zone:getWidth() == defZone:getWidth() and zone:getHeight() == defZone:getHeight() then
					return forageSystem.getZoneData(zone, forageSystem.zoneDefs[defZone:getType()], _x, _y);
				end;
			end;
		end
	end;
	if defZone then return forageSystem.createForageZone(_x, _y, defZone); end;
	return nil;
end

function forageSystem.getRandomCoord(_x1, _x2, _y1, _y2)
	return ZombRand(_x1, _x2) + 1, ZombRand(_y1, _y2) + 1;
end

function forageSystem.getZoneRandomCoord(_zoneData)
	local location = _zoneData.metaZone:pickRandomLocation(Location.new())
	if location then
		return location:getX(), location:getY()
	end
	local x1, x2 = _zoneData.bounds.x1, _zoneData.bounds.x2;
	local y1, y2 = _zoneData.bounds.y1, _zoneData.bounds.y2;
	return ZombRand(x1, x2) + 1, ZombRand(y1, y2) + 1;
end

function forageSystem.getZoneRandomCoordNearPoint(_zoneData, _minDist, _x, _y)
	local x1, x2    = _zoneData.bounds.x1, _zoneData.bounds.x2;
	local y1, y2    = _zoneData.bounds.y1, _zoneData.bounds.y2;
	local newX      = _x + ZombRand(_minDist / 2, _minDist);
	local newY      = _y + ZombRand(_minDist / 2, _minDist);
	if isInRect(newX, newY, x1, x2, y1, y2) then
		return newX, newY;
	end;
	return ZombRand(x1, x2) + 1, ZombRand(y1, y2) + 1;
end

function forageSystem.getDefinedZoneAt(_x, _y)
	local zones = getZones(_x, _y, 0);
	if zones then
		for zone in iterList(zones) do
			if forageSystem.zoneDefs[zone:getType()] then
				return forageSystem.zoneDefs[zone:getType()], zone;
			end;
		end;
	end;
	return false, false;
end

--[[--======== getRefillBonus ========--
	@param _value - (optional) alternate value

	Returns refill bonus value for sandbox setting NatureAbundance
]]--

function forageSystem.getRefillBonus(_zoneData)
	local zoneDef = forageSystem.zoneDefs[_zoneData.name];
	if not zoneDef then
		print("[forageSystem][getRefillBonus] could not find a zoneDef for "..tostring(_zoneData.name));
		print("[forageSystem][getRefillBonus] using bonus value of 0 for " .. tostring(_zoneData.name));
		return 0;
	end;
	--
	local abundanceSetting = zoneDef.abundanceSetting or "NatureAbundance";
	if not (forageSystem.abundanceSettings[abundanceSetting] and SandboxVars[abundanceSetting]) then
		print("[forageSystem][getRefillBonus] could not find an abundance setting or invalid value for "..tostring(_zoneData.name));
		print("[forageSystem][getRefillBonus] using bonus value of 0 for " .. tostring(_zoneData.name));
		return 0;
	end;
	--
	return 1 + (forageSystem.abundanceSettings[abundanceSetting][SandboxVars[abundanceSetting]] / 100) or 0;
end

--[[--======== importDef ========--]]--

function forageSystem.importDef(_def, _defaultDef)
	for key, value in pairs(_defaultDef) do
		if _def[key] == nil then _def[key] = value; end;
	end;
	return _def;
end

--[[--======== getZoneDefByType ========--]]--

function forageSystem.getZoneDefByType(_zoneName)
	return forageSystem.zoneDefs[_zoneName];
end

--[[--======== getZoneDef ========--]]--

function forageSystem.getZoneDef(_definedZone)
	return forageSystem.zoneDefs[_definedZone:getType()];
end

--[[--======== addZoneDef ========--]]--

function forageSystem.addZoneDef(_zoneDef, _overwrite)
	local def = forageSystem.importDef(_zoneDef, forageDefaultDefs.defaultZoneDef);
	if forageSystem.zoneDefs[def.name] then
		if _overwrite then
			forageSystem.zoneDefs[def.name] = def;
			print("[forageSystem][addZoneDef] overwriting definition for "..def.name);
		else
			print("[forageSystem][addZoneDef] definition for "..def.name.." exists, ignoring");
		end;
	else
		forageSystem.zoneDefs[def.name] = def;
	end;
end

--[[--======== populateZoneDefs ========--
	@param _zoneDefs - (optional) override default (forageZones) with a new table

	Initialises the zone list, clears forageSystem.zoneDefs
]]--

function forageSystem.populateZoneDefs(_zoneDefs)
	--clear the table
	forageSystem.zoneDefs = {};
	--populate zones
	for _, def in pairs(_zoneDefs or forageZones) do
		print("[forageSystem][populateZoneDefs] Adding zoneDef: " .. def.name)
		forageSystem.addZoneDef(def);
	end;
end;

--[[--======== addCatDef ========--
	@param _catDef
	@param _overwrite - (optional) force overwrite if definition exists

	Adds category definition to global table, optionally overwrites existing definition
]]--

function forageSystem.addCatDef(_catDef, _overwrite)
	local def = forageSystem.importDef(_catDef, forageDefaultDefs.defaultCatDef);
	local categoryName = def.name;
	if forageSystem.catDefs[categoryName] then
		if _overwrite then
			print("[forageSystem][addCatDef] overwriting definition for "..categoryName);
		else
			print("[forageSystem][addCatDef] definition for "..categoryName.." exists, ignoring");
			return;
		end;
	end;
	--if there are any spriteAffinities, it will also add them to forageSystem.spriteAffinities here
	local woSprites = def.spriteAffinities;
	if woSprites and #woSprites > 0 then
		for _, spriteName in ipairs(woSprites) do
			if (not forageSystem.spriteAffinities[spriteName]) then
				forageSystem.spriteAffinities[spriteName] = {};
			end;
			table.insert(forageSystem.spriteAffinities[spriteName], def.name);
		end;
	end;
	forageSystem.catDefs[categoryName] = def;
end

--[[--======== populateCatDefs ========--
	@param _catDefs - (optional) override default (forageCategories) with a new table

	Initialises the category list, clears forageSystem.catDefs
]]--

function forageSystem.populateCatDefs(_catDefs)
	--clear the table
	forageSystem.catDefs = {};
	--populate catDefs
	for _, def in pairs(_catDefs or forageCategories) do
		forageSystem.addCatDef(def);
	end;
end

--[[--======== addSkillDef ========--
	@param _skillDef
	@param _overwrite - (optional) force overwrite if definition exists

	Adds skill definition to global table, optionally overwrites existing definition
]]--

function forageSystem.addSkillDef(_skillDef, _overwrite)
	local def = forageSystem.importDef(_skillDef, forageDefaultDefs.defaultSkillDef);
	local skillName = def.name;
	local skillType = def.type;
	if (not forageSystem.skillDefs[skillType]) then
		print("[forageSystem][addSkillDef] invalid type for definition, ignoring "..skillName .. " : " .. skillType);
		return;
	end
	if forageSystem.skillDefs[skillType][skillName] then
		if _overwrite then
			print("[forageSystem][addSkillDef] overwriting definition for "..skillName);
		else
			print("[forageSystem][addSkillDef] definition for "..skillName.." exists, ignoring");
			return;
		end;
	end;
	--print("[forageSystem][addSkillDef] adding definition "..skillName .. " : " .. skillType);
	forageSystem.skillDefs[skillType][skillName] = def;
end

--[[--======== populateSkillDefs ========--
	@param _skillDefs - (optional) override default table (forageSkills) with a new table

	Initialises the skill list, clears forageSystem.skillDefs
]]--

function forageSystem.populateSkillDefs(_skillDefs)
	--clear the table
	forageSystem.skillDefs = {occupation = {}, trait = {}};
	--populate skillDefs
	for _, def in pairs(_skillDefs or forageSkills) do
		forageSystem.addSkillDef(def);
	end;
end

--[[---------------------------------------------
--
-- Item
--
--]]---------------------------------------------


--[[--======== getItemDefSize ========--
	@param _itemDef
]]--

function forageSystem.getItemDefSize(_itemDef)
	local itemObj = ScriptManager.instance:FindItem(_itemDef.type);
	local itemSize = (itemObj and itemObj:getActualWeight()) or 1.0;
	if _itemDef.itemSizeModifier > 0 then
		if _itemDef.isItemOverrideSize then
			itemSize = _itemDef.itemSizeModifier;
		else
			itemSize = itemSize + _itemDef.itemSizeModifier;
		end;
	end;
	return itemSize;
end

--[[--======== addOrDropItems ========--
	@param _character - IsoPlayer
	@param _inventory - inventory used
	@param _items - ArrayList of items to add
]]--

function forageSystem.addOrDropItems(_character, _inventory, _items, _discardItems)
	local inv = _inventory;
	local plInv = _character:getInventory();
	if (not _discardItems) then
		for item in iterList(_items) do
			inv:AddItem(item);
			if (inv:getCapacityWeight() > inv:getEffectiveCapacity(_character)) then
				inv:Remove(item);
				if inv == plInv then
					_character:getCurrentSquare():AddWorldInventoryItem(item, 0.0, 0.0, 0.0);
				else
					plInv:AddItem(item);
				end;
			end;
			if (plInv:getCapacityWeight() > plInv:getEffectiveCapacity(_character)) then
				_character:getCurrentSquare():AddWorldInventoryItem(item, 0.0, 0.0, 0.0);
				inv:Remove(item);
			end;
			triggerEvent("OnContainerUpdate");
		end;
	end
	return _items;
end

function forageSystem.isValidFloor(_square, _itemDef, _catDef)
	if not _square then return false; end;
	if not _square:getFloor() then return false; end;
	if _square:Is(IsoFlagType.water) then return (_itemDef.isOnWater or _itemDef.forceOnWater); end;
	local floorTexture = _square:getFloor():getTextureName();
	if floorTexture then
		for _, floorType in ipairs(_catDef.validFloors) do
			if floorType == "ANY" then return true; end;
			if luautils.stringStarts(floorTexture, floorType) then return true; end;
		end;
	end;
	return false;
end

function forageSystem.isValidSquare(_square, _itemDef, _catDef)
	if (not _square) then return false; end;
	if _square:Is(IsoFlagType.solid) then return false; end;
	if _square:Is(IsoFlagType.solidtrans) then return false; end;
	if (not _square:isNotBlocked(false)) then return false; end;
	if _itemDef.forceOutside and (not _square:Is(IsoFlagType.exterior)) then return false; end;
	if _itemDef.forceOnWater and not (_square:Is(IsoFlagType.water)) then return false; end;
	if _square:HasTree() and (not _itemDef.canBeOnTreeSquare) then return false; end;
	if _catDef.validFunc then
		_catDef.validFunc(_square, _itemDef, _catDef);
	else
		return forageSystem.isValidFloor(_square, _itemDef, _catDef);
	end;
	return false;
end

--[[---------------------------------------------
--
--	Vision Radius
--
--]]---------------------------------------------

--[[--======== getCategoryBonus ========--]]--

function forageSystem.getCategoryBonus(_character, _catDef)
	if not (_catDef and _catDef.name) then return 1.0; end;
	local categoryName = _catDef.name;
	local specBonus = 0;
	local professionDef = forageSystem.skillDefs.occupation[_character:getDescriptor():getProfession()];
	if professionDef then
		if forageSystem.isValidSkillDefEffect(_character, professionDef, "specialisations") then
			specBonus = specBonus + (professionDef.specialisations[categoryName] or 0);
		end;
	end;
	for trait, traitDef in pairs(forageSystem.skillDefs.trait) do
		if _character:HasTrait(trait) then
			if forageSystem.isValidSkillDefEffect(_character, traitDef, "specialisations") then
				specBonus = specBonus + (traitDef.specialisations[categoryName] or 0);
			end;
		end;
	end;
	return 1 + (specBonus / 100);
end

--[[--======== getLevelVisionBonus ========--]]--

function forageSystem.getLevelVisionBonus(_perkLevel)
	return (_perkLevel * forageSystem.levelBonus);
end

--[[--======== getAimVisionBonus ========--
	@param _character - IsoPlayer
]]--

function forageSystem.getAimVisionBonus(_character)
	if _character then
		if _character:isAiming() then
			return forageSystem.aimMultiplier;
		end;
	end;
	return 1.0;
end

--[[--======== getSneakVisionBonus ========--
	@param _character - IsoPlayer
]]--

function forageSystem.getSneakVisionBonus(_character)
	if _character then
		--aim takes priority over crouching
		if _character:isSneaking() and (not _character:isAiming()) then
			return forageSystem.sneakMultiplier;
		end;
	end;
	return 1.0;
end

--[[--======== getMovementVisionPenalty ========--
	@param _character - IsoPlayer
]]--

function forageSystem.getMovementVisionPenalty(_character)
	local movementPenalty = 0;
	if _character:isPlayerMoving() then
		if _character:isRunning() then
			movementPenalty = 1;
		elseif _character:isSprinting() then
			movementPenalty = 1;
		end;
	end;
	return 1 - movementPenalty;
end

--[[--======== getHungerBonus ========--
	@param _character - IsoPlayer

	Returns bonus to spot food items when hungry as float 1 - (0-hungerBonusMax)
]]--

function forageSystem.getHungerBonus(_character, _itemDef)
	if not (_itemDef and _itemDef.type) then return 1; end;
	local itemObj = InventoryItemFactory.CreateItem(_itemDef.type);
	local hungerBonus = 0;
	if itemObj and itemObj:IsFood() then
		local hungerLevel = _character:getStats():getHunger();
		hungerBonus = (forageSystem.hungerBonusMax * hungerLevel) / 100;
	end;
	return 1 + hungerBonus;
end

--[[--======== getItemSizePenalty ========--
	@param _itemSize - item weight
]]--

function forageSystem.getItemSizePenalty(_itemSize)
	return math.log(clamp(_itemSize, 0.1, 10)) + forageSystem.minimumSizeBonus;
end

--[[--======== getDifficultyPenalty ========--
	@param _perkLevel

	Returns penalty for an item (based on skill) as float 1 - 0
]]--

function forageSystem.getDifficultyPenalty(_perkLevel)
	return (_perkLevel + 1) / 10;
end

--[[--======== getBodyPenalty ========--
	@param _character - IsoPlayer

	Returns penalty for body conditions as float 1 - (0-bodyPenaltyMax)
]]--

function forageSystem.getBodyPenalty(_character)
	local sickLevel = _character:getStats():getSickness();
	local painLevel = _character:getStats():getPain() / 100;
	local foodSickLevel = _character:getBodyDamage():getFoodSicknessLevel() / 100;
	local drunkLevel = _character:getStats():getDrunkenness() / 100;
	--
	local bodyPenalty = math.max(painLevel, sickLevel, foodSickLevel, drunkLevel);
	return clamp(1 - bodyPenalty, 1 - (forageSystem.bodyPenaltyMax / 100), 1);
end

--[[--======== getClothingPenalty ========--
	@param _character - IsoPlayer

	Returns penalty for clothing as float 1 - (0-clothingPenaltyMax)
]]--

function forageSystem.getClothingPenalty(_character)
	local clothingPenalty = 0;
	local wornItems = _character:getWornItems();
	for wornItem in iterList(wornItems) do
		if wornItem and wornItem:getLocation() then
			clothingPenalty = clothingPenalty + (forageSystem.clothingPenalties[wornItem:getLocation()] or 0);
		end;
	end;
	return clamp(1 - (clothingPenalty / 100), 1 - (forageSystem.clothingPenaltyMax / 100), 1);
end

--[[--======== getPanicPenalty ========--
	@param _character - IsoPlayer

	Returns penalty for panic conditions as float 1 - (0-panicPenaltyMax)
]]--

function forageSystem.getPanicPenalty(_character)
	local panicLevel = _character:getStats():getPanic() / 100;
	local fearLevel = _character:getStats():getFear();
	local stressLevel = _character:getStats():getStress();
	--
	local panicPenalty = math.max(panicLevel, fearLevel, stressLevel);
	return clamp(1 - panicPenalty, 1 - (forageSystem.panicPenaltyMax / 100), 1);
end

--[[--======== getExhaustionPenalty ========--
	@param _character - IsoPlayer

	Returns penalty for exhaustion conditions as float 1 - (0-exhaustionPenaltyMax)
]]--

function forageSystem.getExhaustionPenalty(_character)
	local enduranceLevel = 1 - _character:getStats():getEndurance();
	local fatigueLevel = _character:getStats():getFatigue();
	--
	local exhaustionPenalty = math.max(enduranceLevel + fatigueLevel);
	return clamp(1 - exhaustionPenalty, 1 - (forageSystem.exhaustionPenaltyMax / 100), 1);
end

--[[--======== getWeatherEffectReduction ========--
	@param _character - IsoPlayer

	Returns weather effect total reduction for character as percent
]]--

function forageSystem.getWeatherEffectReduction(_character)
	local effectReduction = 0;
	local professionDef = forageSystem.skillDefs.occupation[_character:getDescriptor():getProfession()];
	if professionDef then
		if forageSystem.isValidSkillDefEffect(_character, professionDef, "weatherEffect") then
			effectReduction = effectReduction + professionDef.weatherEffect;
		end;
	end;
	for trait, traitDef in pairs(forageSystem.skillDefs.trait) do
		if _character:HasTrait(trait) then
			if forageSystem.isValidSkillDefEffect(_character, traitDef, "weatherEffect") then
				effectReduction = effectReduction + traitDef.weatherEffect;
			end;
		end;
	end;
	effectReduction = clamp(effectReduction / 100, 0, forageSystem.effectReductionMax / 100);
	return 1 - effectReduction;
end

--[[--======== getWeatherPenalty ========--
	@param _character - IsoPlayer
	@param _square - IsoGridSquare

	Returns penalty for weather conditions as float 1 - (0-weatherPenaltyMax)
]]--

function forageSystem.getWeatherPenalty(_character, _square)
	if not (_character and _square) then return 1; end;
	if not _square:isOutside() then return 1; end;
	local weatherPenalty = 0;
	local climateManager = getClimateManager();
	local fogLevel = climateManager:getFogIntensity();
	local snowLevel = math.min(climateManager:getSnowStrength(), 1);
	--
	local rainLevel = climateManager:getPrecipitationIntensity();
	local primaryItem = _character:getPrimaryHandItem();
	local secondaryItem = _character:getSecondaryHandItem();
	local umbrellaPrimary = primaryItem and primaryItem:isProtectFromRainWhileEquipped();
	local umbrellaSecondary = secondaryItem and secondaryItem:isProtectFromRainWhileEquipped();
	--if using an umbrella rain penalty is reduced by 90%
	if umbrellaPrimary or umbrellaSecondary then
		rainLevel = rainLevel * 0.1;
	end;
	--use highest of rain/fog
	weatherPenalty = rainLevel + fogLevel;
	--add up to 25% for snow covered ground
	weatherPenalty = weatherPenalty + (snowLevel / 4);
	--add up to 10% for cloudy days
	local cloudLevel = climateManager:getCloudIntensity();
	weatherPenalty = weatherPenalty + (cloudLevel * 0.1);
	local effectReduction = forageSystem.getWeatherEffectReduction(_character);
	weatherPenalty = math.min(weatherPenalty, forageSystem.weatherPenaltyMax / 100);
	return 1 - (weatherPenalty * effectReduction);
end

--[[--======== getDarknessEffectReduction ========--
	@param _character - IsoPlayer

	Returns darkness effect total reduction for character as percent
]]--

function forageSystem.getDarknessEffectReduction(_character)
	local effectReduction = 0;
	local professionDef = forageSystem.skillDefs.occupation[_character:getDescriptor():getProfession()];
	if professionDef then
		if forageSystem.isValidSkillDefEffect(_character, professionDef, "darknessEffect") then
			effectReduction = effectReduction + professionDef.darknessEffect;
		end;
	end;
	for trait, traitDef in pairs(forageSystem.skillDefs.trait) do
		if _character:HasTrait(trait) then
			if forageSystem.isValidSkillDefEffect(_character, traitDef, "darknessEffect") then
				effectReduction = effectReduction + traitDef.darknessEffect;
			end;
		end;
	end;
	effectReduction = clamp(effectReduction / 100, 0, forageSystem.effectReductionMax / 100);
	return 1 - effectReduction;
end

--[[--======== getLightLevelPenalty ========--
	@param _character - IsoPlayer
	@param _square - IsoGridSquare

	Returns penalty for IsoGridSquare as float (0 to 1)
]]--

function forageSystem.getLightLevelPenalty(_character, _square, _doReduction)
	if not (_square and _character) then return 0; end;
	local lightLevel = _square:getLightLevel(_character:getPlayerNum());
	local dayLightStrength = getClimateManager():getDayLightStrength();
	--just make it fully bright if over 80%
	if lightLevel > 0.8 then lightLevel = 1; end;
	if _square:isOutside() then
		lightLevel = math.max(dayLightStrength, lightLevel);
	end;
	local effectReduction = forageSystem.getDarknessEffectReduction(_character);
	local lightPenalty = 0;
	if _doReduction then
		lightPenalty = (1 - lightLevel) * effectReduction;
	else
		lightPenalty = (1 - lightLevel);
	end;
	return clamp(1 - lightPenalty, 1 - (forageSystem.lightPenaltyMax / 100), 1);
end

--[[--======== getProfessionVisionBonus ========--
	@param _character - IsoPlayer

	Returns profession bonus vision in squares
]]--

function forageSystem.getProfessionVisionBonus(_character)
	local professionDef = forageSystem.skillDefs.occupation[_character:getDescriptor():getProfession()];
	if professionDef then
		if forageSystem.isValidSkillDefEffect(_character, professionDef, "visionBonus") then
			return professionDef.visionBonus;
		end;
	end;
	return 0;
end

--[[--======== getTraitVisionBonus ========--
	@param _character - IsoPlayer

	Returns trait bonus vision total in squares
]]--

function forageSystem.getTraitVisionBonus(_character)
	local traitBonus = 0;
	for trait, traitDef in pairs(forageSystem.skillDefs.trait) do
		if _character:HasTrait(trait) then
			if forageSystem.isValidSkillDefEffect(_character, traitDef, "visionBonus") then
				traitBonus = traitBonus + traitDef.visionBonus;
			end;
		end;
	end;
	return traitBonus;
end

--[[--======== isValidSkillDefEffect ========--
	@param _character - IsoPlayer
	@param _skillDef
	@param _bonusEffect

	Tests if skillDef effect should be applied (using skillDef.testFunc)
]]--

function forageSystem.isValidSkillDefEffect(_character, _skillDef, _bonusEffect)
	for _, testFunc in ipairs(_skillDef.testFuncs) do
		if not testFunc(_character, _skillDef, _bonusEffect) then return false; end;
	end;
	return true;
end

--[[--======== getMonthBonus ========--
	@param _itemDef
	@param _month - (optional) month to check

	Returns month bonus total for itemDef as percent
]]--

function forageSystem.getMonthBonus(_itemDef, _month)
	if not _itemDef then return 1; end;
	local month = _month or getGameTime():getMonth() + 1;
	local monthBonus, monthMalus = 0, 0;
	for _, bonusMonth in ipairs(_itemDef.bonusMonths) do
		if month == bonusMonth then monthBonus = forageSystem.monthBonus; break; end;
	end;
	for _, malusMonth in ipairs(_itemDef.malusMonths) do
		if month == malusMonth then monthMalus = forageSystem.monthMalus; break; end;
	end;
	return 1 - ((monthBonus + monthMalus) / 100);
end

--[[--======== getTimeOfDay ========--]]--

function forageSystem.getTimeOfDay()
	local season = getClimateManager():getSeason();
	local dawn = season:getDawn();
	local dusk = season:getDusk();
	local timeOfDay = getGameTime():getTimeOfDay();
	if (timeOfDay < dawn) or (timeOfDay > dusk) then return "isNight"; end;
	return "isDay";
end

--[[--======== getTimeOfDayBonus ========--
	@param _def - itemDef or catDef
	@param _isDay - true/false (optional) get result for time of day

	Returns time of day bonus total in percent for itemDef
]]--

function forageSystem.getTimeOfDayBonus(_def, _isDay)
	if (not _def) then return 1; end;
	local isDay = (_isDay == true) or (forageSystem.getTimeOfDay() == "isDay");
	local isNight = (_isDay == false) or (forageSystem.getTimeOfDay() == "isNight");
	local bonusChance = 100;
	if isDay then bonusChance = bonusChance + _def.dayChance; end;
	if isNight then bonusChance = bonusChance + _def.nightChance; end;
	return (bonusChance / 100)
end

--[[--======== getWeatherType ========--]]--

function forageSystem.getWeatherType()
	if getClimateManager():getPrecipitationIntensity() > 0 then return "isRaining"; end;
	if getPuddlesManager():getPuddlesSize() > 0.1 then return "hasRained"; end;
	if getClimateManager():getSnowStrength() > 0 then return "isSnowing"; end;
	return "isNormal";
end

--[[--======== getWeatherBonus ========--
	@param _def

	Returns weather bonus total in percent for itemDef or catDef
]]--

function forageSystem.getWeatherBonus(_def, _isRaining, _isSnowing, _hasRained)
	if not _def then return 1; end;
	local isRaining = _isRaining or getClimateManager():getPrecipitationIntensity() > 0;
	local hasRained = _hasRained or getPuddlesManager():getPuddlesSize() > 0.1;
	local isSnowing = _isSnowing or getClimateManager():getSnowStrength() > 0;
	local bonusChance = 100;
	if isRaining then bonusChance = bonusChance + _def.rainChance; end;
	if hasRained then bonusChance = bonusChance + _def.hasRainedChance; end;
	if isSnowing then bonusChance = bonusChance + _def.snowChance; end;
	return (bonusChance / 100)
end

--[[--======== hasRequiredItems ========--
	@param _character - IsoPlayer
	@param _itemDef

	Returns true if all items in itemDef are in inventory (matching by tag)
]]--

function forageSystem.hasRequiredItems(_character, _itemDef)
	local itemTest = function(_item, _tag)
		return not _item:isBroken() and _item:hasTag(_tag);
	end;
	local playerInv = _character:getInventory();
	local requiredItems = 0;
	for _, itemTag in ipairs(_itemDef.itemTags) do
		if playerInv:getFirstEvalArgRecurse(itemTest, itemTag) then
			requiredItems = requiredItems + 1;
		end;
	end;
	return #_itemDef.itemTags == requiredItems;
end

--[[--======== hasNeededTraits ========--
	@param _character - IsoPlayer
	@param _itemDef

	Returns true if all traits in itemDef are known
]]--

function forageSystem.hasNeededTraits(_character, _itemDef)
	local knownTraits = 0;
	for _, trait in ipairs(_itemDef.traits) do
		if _character:HasTrait(trait) then
			knownTraits = knownTraits + 1;
		end;
	end;
	return #_itemDef.traits == knownTraits;
end

--[[--======== hasNeededRecipes ========--
	@param _character - IsoPlayer
	@param _itemDef

	Returns true if all recipes in itemDef are known
]]--

function forageSystem.hasNeededRecipes(_character, _itemDef)
	local knownRecipes = 0;
	for _, recipe in ipairs(_itemDef.recipes) do
		if _character:isRecipeKnown(recipe) then
			knownRecipes = knownRecipes + 1;
		end;
	end;
	return #_itemDef.recipes == knownRecipes;
end

--[[--======== getPerkLevel ========--
	@param _character - IsoPlayer
	@param _itemDef

	Returns perk level / number of perks
]]--

function forageSystem.getPerkLevel(_character, _itemDef)
	local perkLevel = 0;
	local numPerks = #_itemDef.perks;
	if numPerks <= 0 then return 0; end;
	for _, perk in ipairs(_itemDef.perks) do
		perkLevel = perkLevel + _character:getPerkLevel(Perks.FromString(perk));
	end;
	perkLevel = math.ceil(perkLevel / numPerks);
	return perkLevel;
end

--[[--======== isItemTypeExist ========--
@param _itemDef

Returns true if an item type exists
]]--

function forageSystem.isItemTypeExist(_itemType)
	return (_itemType and ScriptManager.instance:FindItem(_itemType) and true) or false;
end;

--[[--======== hasNeededPerks ========--
@param _character - IsoPlayer
@param _itemDef

Returns true if player is sufficient level for all perk requirements
]]--

function forageSystem.hasNeededPerks(_character, _itemDef, _zoneDef)
	return (_itemDef and _itemDef.skill <= forageSystem.getPerkLevel(_character, _itemDef)) or false;
end


--[[--======== isItemExist ========--
	@param _itemDef
	@param _zoneDef - zoneDef

	Returns true if an item type exists
]]--

function forageSystem.isItemExist(_character, _itemDef, _zoneDef)
	local itemObj = (_itemDef and _itemDef.type) and ScriptManager.instance:FindItem(_itemDef.type);
	return (itemObj and (not itemObj:getObsolete()) and true) or false;
end

--[[--======== isItemInZone ========--
	@param _itemDef
	@param _zoneDef - zoneDef

	Returns true if an item spawns in this zone
]]--

function forageSystem.isItemInZone(_character, _itemDef, _zoneDef)
	for zoneName in pairs(_itemDef.zones) do
		if zoneName == _zoneDef.name then return true; end;
	end;
	return false;
end

function forageSystem.isValidMonth(_, _itemDef, _zoneDef, _month)
	local month = _month or getGameTime():getMonth() + 1;
	for _, thisMonth in ipairs(_itemDef.months) do
		if month == thisMonth then return true; end;
	end;
	return false;
end

--[[--======== isForageable ========--
	@param _character - IsoPlayer
	@param _zoneDef - zoneDef
	@param _itemDef
]]--

function forageSystem.isForageable(_character, _itemDef, _zoneDef)
	for _, testFunc in ipairs(forageSystem.isForageableFuncs) do
		if type(testFunc) == "function" then
			if not testFunc(_character, _itemDef, _zoneDef) then
				return false;
			end;
		elseif type(testFunc) == "string" then
			if forageSystem[testFunc] then
				if not forageSystem[testFunc](_character, _itemDef, _zoneDef) then
					return false;
				end;
			else
				print("[forageSystem][isForageable] could not find function forageSystem."..testFunc);
			end;
		else
			print("[forageSystem][isForageable] not string or function "..type(testFunc));
			return false;
		end;
	end;
	return true;
end

--[[---------------------------------------------
--
--	Character
--
--]]---------------------------------------------

--[[--======== giveItemXP ========--
	@param _character - IsoPlayer
	@param _itemDef
	@param _amount - (optional) override amount of xp by a percent (float 0-1)

	Awards the _character an (_amount) of the _itemDef defined xp value
]]--

function forageSystem.giveItemXP(_character, _itemDef, _amount)
	local manager = ISSearchManager.getManager(_character);
	if not manager then return; end;
	local pfPerk, currentXP, gainedXP;
	--
	local xpAmount              = _itemDef.xp * (_amount or 1);
	local globalXPModifier      = forageSystem.globalXPModifier / 100;
	local levelXPModifier       = forageSystem.levelXPModifier / 100;
	local perkLevel             = forageSystem.getPerkLevel(_character, _itemDef);
	local diminishingReturn     = 1 - ((perkLevel - _itemDef.skill) * levelXPModifier);
	--
	xpAmount = math.max((xpAmount * globalXPModifier) * diminishingReturn, 1);
	for _, perk in ipairs(_itemDef.perks) do
		pfPerk = Perks.FromString(perk);
		if pfPerk then
			currentXP = _character:getXp():getXP(pfPerk);
			_character:getXp():AddXP(pfPerk, xpAmount);
			gainedXP = _character:getXp():getXP(pfPerk) - currentXP;
			if gainedXP > 0 then
				gainedXP = string.format("%.2f", gainedXP);
				table.insert(manager.haloNotes, "[col=137,232,148]"..pfPerk:getName().." "..getText("Challenge_Challenge2_CurrentXp", gainedXP) .. "[/] [img=media/ui/ArrowUp.png]");
			end;
		end;
	end;
end

--[[--======== doEndurancePenalty ========--
	@param _character - IsoPlayer
	@param _amount - (optional) amount to endure

	Returns endurance level
]]--

function forageSystem.doEndurancePenalty(_character, _amount)
	local enduranceLevel = _character:getStats():getEndurance();
	enduranceLevel = enduranceLevel - (_amount or forageSystem.endurancePenalty);
	_character:getStats():setEndurance(enduranceLevel);
	return enduranceLevel;
end

--[[--======== doFatiguePenalty ========--
	@param _character - IsoPlayer
	@param _amount - (optional) amount to fatigue

	Returns fatigue level
]]--

function forageSystem.doFatiguePenalty(_character, _amount)
	local fatigueLevel = _character:getStats():getFatigue();
	fatigueLevel = fatigueLevel + (_amount or forageSystem.fatiguePenalty);
	_character:getStats():setFatigue(fatigueLevel);
	return fatigueLevel;
end
