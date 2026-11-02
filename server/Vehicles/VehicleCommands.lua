if isClient() then return end

local VehicleCommands = {}
local Commands = {}

local noise = function(msg, ...)
	DebugType.VehicleClientCommand:debugln(msg, unpack({...}))
end

function Commands.startEngine(player, args)
	local vehicle = player:getVehicle()
	if vehicle then
		if vehicle:isDriver(player) then
			if true or vehicle:isEngineWorking() then
				local haveKey = player:getInventory():haveThisKeyId(vehicle:getKeyId()) ~= nil
				vehicle:tryStartEngine(haveKey)
			else
				noise('engine not working')
			end
		else
			noise('player not driver')
		end
	else
		noise('player not in vehicle')
	end
end

function Commands.setPartCondition(player, args)
	local vehicle = getVehicleById(args.vehicle)
	if vehicle and checkPermissions(player, Capability.UseMechanicsCheat) then
		local part = vehicle:getPartById(args.part)
		if not part then
			noise('no such part %s', tostring(args.part))
			return
		end
		part:setCondition(args.condition)
		part:doInventoryItemStats(part:getInventoryItem(), part:getMechanicSkillInstaller())
		vehicle:transmitPartCondition(part)
	else
		noise('no such vehicle id=%s', tostring(args.vehicle))
	end
end

function Commands.setContainerContentAmount(player, args)
	local vehicle = getVehicleById(args.vehicle)
	if vehicle and checkPermissions(player, Capability.UseMechanicsCheat) then
		local part = vehicle:getPartById(args.part)
		if not part then
			noise('no such part %s', tostring(args.part))
			return
		end
		part:setContainerContentAmount(args.amount)
		vehicle:transmitPartModData(part)
	else
		noise('no such vehicle id=%s', tostring(args.vehicle))
	end
end

function Commands.toggleHeater(player, args)
	local vehicle = player:getVehicle();
	if vehicle then
		local part = vehicle:getPartById("Heater");
		if part then
			part:getModData().active = args.on;
			part:getModData().temperature = args.temp;
			vehicle:transmitPartModData(part);
		end
	else
		noise('player not in vehicle');
	end
end

function Commands.setHeadlightsOn(player, args)
	local vehicle = player:getVehicle()
	if vehicle then
		vehicle:setHeadlightsOn(args.on)
	else
		noise('player not in vehicle')
	end
end

function Commands.setTrunkLocked(player, args)
	local vehicle = player:getVehicle()
	if vehicle then
		vehicle:setTrunkLocked(args.locked)
	else
		noise('player not in vehicle')
	end
end

function Commands.setStoplightsOn(player, args)
	local vehicle = player:getVehicle()
	if vehicle then
		vehicle:setStoplightsOn(args.on)
	else
		noise('player not in vehicle')
	end
end

function Commands.damageWindow(player, args)
	local vehicle = getVehicleById(args.vehicle)
	if vehicle then
		local part = vehicle:getPartById(args.part)
		if not part then
			noise('no such part %s', tostring(args.part))
			return
		end
		if not part:getWindow() then
			noise('part %s has no window', args.part)
			return
		end
		part:getWindow():damage(tonumber(args.amount))
	else
		noise('no such vehicle id=%s', tostring(args.vehicle))
	end
end

function Commands.onHorn(player, args)
	local vehicle = player:getVehicle()
	local state = args.state;
	if vehicle then
		if state == "start" then
			vehicle:onHornStart();
		end
		if state == "stop" then
			vehicle:onHornStop();
		end
	else
		noise('player not in vehicle')
	end
end

function Commands.onBackSignal(player, args)
	local vehicle = player:getVehicle()
	local state = args.state;
	if vehicle then
		if state == "start" then
			vehicle:onBackMoveSignalStart();
		end
		if state == "stop" then
			vehicle:onBackMoveSignalStop();
		end
	else
		noise('player not in vehicle')
	end
end

function Commands.setLightbarLightsMode(player, args)
	local vehicle = player:getVehicle()
	local mode = tonumber(args.mode);
	if vehicle then
		local part = vehicle:getPartById("lightbar")
		if mode > 0 and part and part:getCondition() == 0 then
			mode = 0
		end
		vehicle:setLightbarLightsMode(mode)
	else
		noise('player not in vehicle')
	end
end

function Commands.setLightbarSirenMode(player, args)
	local vehicle = player:getVehicle()
	local mode = tonumber(args.mode);
	if vehicle then
		local part = vehicle:getPartById("lightbar")
		if mode > 0 and part and part:getCondition() == 0 then
			mode = 0
		end
		vehicle:setLightbarSirenMode(mode)
		vehicle:setSirenStartTime(getGameTime():getWorldAgeHours())
	else
		noise('player not in vehicle')
	end
end

function Commands.putKeyInIgnition(player, args)
	local vehicle = player:getVehicle()
	if vehicle and vehicle:isDriver(player) then
		vehicle:putKeyInIgnition(args.key, args.container)
	else
		noise('player not driving vehicle')
	end
end

function Commands.removeKeyFromIgnition(player, args)
	local vehicle = player:getVehicle()
	if vehicle and vehicle:isDriver(player) then
		vehicle:removeKeyFromIgnition()
	else
		noise('player not driving vehicle')
	end
end

function Commands.putKeyOnDoor(player, args)
	local vehicle = getVehicleById(args.vehicle)
	if vehicle then
		vehicle:putKeyOnDoor(args.key)
	else
		noise('no such vehicle id=%s', tostring(args.vehicle))
	end
end

function Commands.removeKeyFromDoor(player, args)
	local vehicle = getVehicleById(args.vehicle)
	if vehicle then
		vehicle:removeKeyFromDoor()
	else
		noise('no such vehicle id=%s', tostring(args.vehicle))
	end
end

function Commands.crash(player, args)
	local vehicle = getVehicleById(args.vehicle);
	if not vehicle then
		noise('no such vehicle id=%s', tostring(args.vehicle))
		return
	end
	if not vehicle:isDriver(player) then
		noise('player not driving vehicle')
		return
	end
	vehicle:crash(args.amount, args.front);
end

function Commands.damageObjects(player, args)
	local vehicle = getVehicleById(args.vehicle);
	if not vehicle then
		noise('no such vehicle id=%s', tostring(args.vehicle))
		return
	end
	if not vehicle:isDriver(player) then
		noise('player not driving vehicle')
		return
	end
	vehicle:damageObjects(args.damage)
end

function Commands.damageFromHitChr(player, args)
	local vehicle = getVehicleById(args.vehicle);
	if vehicle and vehicle:isDriver(player) then
		vehicle:damageFromHitChr(args.dmgFront, args.dmgBack);
	else
		noise('no such vehicle id=%s', tostring(args.vehicle))
	end
end

function Commands.getKey(player, args)
	local vehicle = getVehicleById(args.vehicle)
	if vehicle and checkPermissions(player, Capability.UseMechanicsCheat) then
		local item = vehicle:createVehicleKey()
		if item then
			player:getInventory():AddItem(item);
			sendAddItemToContainer(player:getInventory(), item);
		end
	else
		noise('no such vehicle id=%s', tostring(args.vehicle))
	end
end

function Commands.repair(player, args)
	local vehicle = getVehicleById(args.vehicle)
	if vehicle and checkPermissions(player, Capability.UseMechanicsCheat) then
		vehicle:repair()
	else
		noise('no such vehicle id=%s,', tostring(args.vehicle))
	end
end

function Commands.setBloodIntensity(player, args)
	local vehicle = getVehicleById(args.vehicle)
	if vehicle then
		vehicle:setBloodIntensity(args.id, args.intensity)
	else
		noise('no such vehicle id=%s', tostring(args.vehicle))
	end
end

function Commands.setRust(player, args)
	local vehicle = getVehicleById(args.vehicle)
	if vehicle and checkPermissions(player, Capability.UseMechanicsCheat) then
		vehicle:setRust(args.rust)
		vehicle:transmitRust()
	else
		noise('no such vehicle id=%s', tostring(args.vehicle))
	end
end

function Commands.repairPart(player, args)
	local vehicle = getVehicleById(args.vehicle)
	if vehicle and checkPermissions(player, Capability.UseMechanicsCheat) then
		local part = vehicle:getPartById(args.part)
		if not part then
			noise('no such part %s', tostring(args.part))
			return
		end
		part:repair()
	else
		noise('no such vehicle id=%s', tostring(args.vehicle))
	end
end

function Commands.remove(player, args)
	local vehicle = getVehicleById(args.vehicle)
	if vehicle and checkPermissions(player, Capability.UseMechanicsCheat) then
		vehicle:permanentlyRemove()
	else
		noise('no such vehicle id=%s', tostring(args.vehicle))
	end
end

function Commands.configHeadlight(player, args)
	local vehicle = getVehicleById(args.vehicle)
	if vehicle then
		local part = vehicle:getPartById(args.part)
		if not part then
			noise('no such part %s', tostring(args.part))
			return
		end
		if args.dir == 1 then
			part:getLight():setFocusingUp()
		else
			part:getLight():setFocusingDown()
		end
	else
		noise('no such vehicle id=%s', tostring(args.vehicle))
	end
end

function Commands.attachTrailer(player, args)
	local vehicleA = getVehicleById(args.vehicleA)
	local vehicleB = getVehicleById(args.vehicleB)
	if not vehicleA then
		noise('no such vehicle (A) id=%s', tostring(args.vehicleA))
		return
	end
	if not vehicleB then
		noise('no such vehicle (B) id=%s', tostring(args.vehicleB))
		return
	end
	vehicleA:addPointConstraint(player, vehicleB, args.attachmentA, args.attachmentB)
end

function Commands.detachTrailer(player, args)
	local vehicle = getVehicleById(args.vehicle)
	if not vehicle then
		noise('no such vehicle id=%s', tostring(args.vehicle))
		return
	end
	vehicle:breakConstraint(player, true, false)
end

function Commands.detachTrailerSpontaneous(player, args)
	local vehicle = getVehicleById(args.vehicle)
	if not vehicle then
		noise('no such vehicle id=%s', tostring(args.vehicle))
		return
	end
	vehicle:breakConstraint(player, true, false)
end

function Commands.cheatHotwire(player, args)
	local vehicle = getVehicleById(args.vehicle)
	if vehicle and checkPermissions(player, Capability.UseMechanicsCheat) then
		vehicle:cheatHotwire(args.hotwired, args.broken)
	else
		noise('no such vehicle id=%s', tostring(args.vehicle))
	end
end

function Commands.setHSV(player, args)
	local vehicle = getVehicleById(args.vehicle)
	if vehicle then
		vehicle:setColorHSV(args.h, args.s, args.v)
		vehicle:transmitColorHSV()
	else
		noise('no such vehicle id=%s', tostring(args.vehicle))
	end
end

function Commands.setSkinIndex(player, args)
	local vehicle = getVehicleById(args.vehicle)
	if vehicle then
		vehicle:setSkinIndex(args.index)
		vehicle:transmitSkinIndex()
	else
		noise('no such vehicle id=%s', tostring(args.vehicle))
	end
end

function Commands.setAlarmed(player, args)
	local vehicle = getVehicleById(args.vehicle)
	if vehicle and checkPermissions(player, Capability.UseMechanicsCheat) then
		vehicle:setAlarmed(args.alarmed or false)
		vehicle:transmitAlarmed()
	else
		noise('no such vehicle id=%s', tostring(args.vehicle))
	end
end

VehicleCommands.OnClientCommand = function(module, command, player, args)
	if module == 'vehicle' and Commands[command] then
		local argStr = ''
		args = args or {}
		for k,v in pairs(args) do
			argStr = argStr..' '..k..'='..tostring(v)
		end
		noise('received %s %s %s %s', module, command, tostring(player), argStr)
		Commands[command](player, args)
	end
end

Events.OnClientCommand.Add(VehicleCommands.OnClientCommand)
