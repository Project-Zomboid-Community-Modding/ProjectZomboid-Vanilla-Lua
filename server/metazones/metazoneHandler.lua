local function handleAnimalZone(file, v)
	if v.geometry then
		getWorld():getMetaGrid():registerGeometryZone(v.name, v.type, v.z, v.geometry, v.points, v.properties)
		return
	end
	getWorld():registerAnimalZone(v.name, v.type, v.x, v.y, v.z, v.width, v.height, v.properties)
end

local function handleBasementSpawnLocation(mapID, v)
	local api = Basements.getAPIv1()
	api:registerBasementSpawnLocation(mapID, v.name, v.type, v.x, v.y, v.z, v.width, v.height, v.properties)
end

local function handleMannequinZone(file, v)
	if v.properties == nil then
		print('ERROR: Mannequin zone missing properties in '..file..' at '..v.x..','..v.y..','..v.z)
		return
	end
	getWorld():registerMannequinZone(v.name, v.type, v.x, v.y, v.z, v.width, v.height, v.properties)
end

local function handleRoomTone(file, v)
	if v.properties == nil then
		print('ERROR: RoomTone missing properties in '..file..' at '..v.x..','..v.y..','..v.z)
		return
	end
	getWorld():registerRoomTone(v.name, v.type, v.x, v.y, v.z, v.width, v.height, v.properties)
end

local function handleSpawnOrigin(file, v)
	getWorld():registerSpawnOrigin(v.x, v.y, v.width, v.height, v.properties)
end

local function handleWaterFlow(file, v)
	if v.properties == nil then
		print('ERROR: WaterFlow missing properties in '..file..' at '..v.x..','..v.y..','..v.z)
		return
	end
	if v.properties.WaterDirection == nil then
		print('ERROR: WaterFlow missing properties.WaterDirection in '..file..' at '..v.x..','..v.y..','..v.z)
		return
	end
	if v.properties.WaterSpeed == nil then
		print('ERROR: WaterFlow missing properties.WaterSpeed in '..file..' at '..v.x..','..v.y..','..v.z)
		return
	end
	getWorld():registerWaterFlow(v.x, v.y, v.properties.WaterDirection, v.properties.WaterSpeed)
end

local function handleWaterZone(file, v)
	if v.properties == nil then
		print('ERROR: WaterZone missing properties in '..file..' at '..v.x..','..v.y..','..v.z)
		return
	end
	if v.properties.WaterGround == nil then
		print('ERROR: WaterZone missing properties.WaterGround in '..file..' at '..v.x..','..v.y..','..v.z)
		return
	end
	if v.properties.WaterShore == nil then
		print('ERROR: WaterZone missing properties.WaterShore in '..file..' at '..v.x..','..v.y..','..v.z)
		return
	end
	getWorld():registerWaterZone(v.x, v.y, v.x + v.width, v.y + v.height,
		v.properties.WaterShore and 1.0 or 0.0, v.properties.WaterGround and 1.0 or 0.0)
end

local function loadRoomTones(dirName)
	local filePath = 'media/maps/'..dirName..'/roomtones.lua'
	if fileExists(filePath) then
		objects = {}
		reloadLuaFile(filePath)
		for k,v in ipairs(objects) do
			if v.type == "RoomTone" then
				handleRoomTone(filePath, v)
			end
			table.wipe(v)
		end
		table.wipe(objects)
	end
end

function doMapZones()
    local dirs = getLotDirectories()
    for i=dirs:size(),1,-1 do
		local dirName = dirs:get(i-1)
        local file = 'media/maps/'..dirName..'/objects.lua'
        if fileExists(file) then
			getWorld():removeZonesForLotDirectory(dirs:get(i-1))
			objects = {}
            reloadLuaFile(file)
            for k,v in ipairs(objects) do
				-- Lua seriously needs a "continue", and yes, i refuse to use goto :D
				if v.type ~= "Vegitation" and v.type ~= "DeepForest" and v.type ~= "Forest" and v.type ~= "TownZone" and v.type ~= "Farm" and v.type ~= "FarmLand" and v.type ~= "TrailerPark" then
					if v.type == "Animal" then
						handleAnimalZone(file, v)
					elseif v.type == "Basement" then
						handleBasementSpawnLocation(dirName, v)
					elseif v.type == "Mannequin" then
						handleMannequinZone(file, v)
					elseif v.type == "RoomTone" then
						--					handleRoomTone(file, v)
					elseif v.type == "SpawnOrigin" then
						handleSpawnOrigin(file, v)
					elseif v.type == "WaterFlow" then
						handleWaterFlow(file, v)
					elseif v.type == "WaterZone" then
						handleWaterZone(file, v)
					elseif v.type == "Region" or v.type == "BuildingName" then
						-- 					getWorld():registerRegionZone(v.name, v.type, v.x, v.y, v.z, v.width, v.height)
						getWorld():registerZone(v.name, v.type, v.x, v.y, v.z, v.width, v.height)
					elseif v.geometry ~= nil then
						if tonumber(v.lineWidth) then
							v.properties = v.properties or {}
							v.properties.LineWidth = v.lineWidth
						end
						getWorld():getMetaGrid():registerGeometryZone(v.name, v.type, v.z, v.geometry, v.points, v.properties)
					elseif v.type == "WorldGen" then
						getWorld():getMetaGrid():registerWorldGenZone(v.name, v.type, v.x, v.y, v.z, v.width, v.height, v.properties)
					else
						local vzone = getWorld():registerVehiclesZone(v.name, v.type, v.x, v.y, v.z, v.width, v.height, v.properties)
						if vzone == nil then
							getWorld():registerZone(v.name, v.type, v.x, v.y, v.z, v.width, v.height)
						end
					end
					table.wipe(v)
				end
            end
            table.wipe(objects)
        else
            print('can\'t find map objects file: '..file)
        end
        local file2 = 'media/maps/'..dirs:get(i-1)..'/regions.lua'
        if fileExists(file2) then
			regions = {}
            reloadLuaFile(file2)
            for k,v in ipairs(regions) do
				if v.type == "Mannequin" then
					handleMannequinZone(file2, v)
				elseif v.type == "Region" or v.type == "BuildingName" then
-- 					getWorld():registerRegionZone(v.name, v.type, v.x, v.y, v.z, v.width, v.height)
					getWorld():registerZone(v.name, v.type, v.x, v.y, v.z, v.width, v.height)
				else
					local vzone = getWorld():registerVehiclesZone(v.name, v.type, v.x, v.y, v.z, v.width, v.height, v.properties)
					if vzone == nil then
						getWorld():registerZone(v.name, v.type, v.x, v.y, v.z, v.width, v.height)
					end
				end
				table.wipe(v)
            end
            table.wipe(regions)
        end
		loadRoomTones(dirName)
		getWorld():checkVehiclesZones();
    end
end

-- Normally a map's objects.lua file (handled above) will contain SpawnOrigin
-- objects.  A map may also have a separate spawnOrigins.lua file that does the
-- same thing.
function doSpawnOrigins()
	local dirs = getLotDirectories()
	for i=dirs:size(),1,-1 do
		local file = 'media/maps/'..dirs:get(i-1)..'/spawnOrigins.lua'
		if fileExists(file) then
			objects = {}
			reloadLuaFile(file)
			for k,v in ipairs(objects) do
				if v.type == "SpawnOrigin" then
					handleSpawnOrigin(file, v)
				end
				table.wipe(v)
			end
			table.wipe(objects)
		end
	end
end

Events.OnLoadMapZones.Add(doMapZones);
Events.OnLoadMapZones.Add(doSpawnOrigins);

