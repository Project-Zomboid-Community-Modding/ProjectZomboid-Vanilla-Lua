--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

if isClient() then return end

local ClientCommands = {}
local Commands = {}
Commands.object = {}

ClientCommands.wantNoise = getDebug()
local noise = function(msg)
	if (ClientCommands.wantNoise) then print('ClientCommand: '..msg) end
end

Commands.object.addFireOnSquare = function(player, args)
	local sq = getCell():getGridSquare(args.x, args.y, args.z)
	IsoFireManager.StartFire(getCell(), sq, true, 100, 500);
end

Commands.object.addSmokeOnSquare = function(player, args)
	local sq = getCell():getGridSquare(args.x, args.y, args.z)
	IsoFireManager.StartSmoke(getCell(), sq, true, 100, 500)
end

Commands.object.addExplosionOnSquare = function(player, args)
	local sq = getCell():getGridSquare(args.x, args.y, args.z)
	IsoFireManager.explode(getCell(), sq, 100)
end

-- FIXME: getting objects by index is fragile, should have a unique ID
local getThumpable = function(x, y, z, index)
	local sq = getCell():getGridSquare(x, y, z)
	if sq and index >= 0 and index < sq:getObjects():size() then
		local o = sq:getObjects():get(index)
		if instanceof(o, 'IsoThumpable') then
			return o
		end
	end
	return nil
end

Commands.object.rotate = function(player, args)
	local sq = getCell():getGridSquare(args.x, args.y, args.z)
	if sq and args.index >= 0 and args.index < sq:getObjects():size() then
		local o = sq:getObjects():get(args.index)
		if instanceof(o, 'IsoMannequin') then
			o:rotate(args.dir)
		else
			noise('expected rotate-able got '..tostring(o))
		end
	else
		noise('sq is null or index is invalid')
	end
end

Commands.object.openCloseCurtain = function(player, args)
	local sq = getCell():getGridSquare(args.x, args.y, args.z)
	if sq and args.index >= 0 and args.index < sq:getObjects():size() then
		local o = sq:getObjects():get(args.index)
		if instanceof(o, 'IsoDoor') then
			noise('isCurtainOpen='..tostring(o:isCurtainOpen()))
			if args.open ~= o:isCurtainOpen() then
				o:toggleCurtain()
			end
		else
			noise('expected door got '..tostring(o))
		end
	else
		noise('sq is null or index is invalid')
	end
end

Commands.object.plumbObject = function(player, args)
	local sq = getCell():getGridSquare(args.x, args.y, args.z)
	if sq and args.index >= 0 and args.index < sq:getObjects():size() then
		local object = sq:getObjects():get(args.index)
		object:getModData().canBeWaterPiped = false
		object:setUsesExternalWaterSource(true)
		object:transmitModData()
		object:sendObjectChange('usesExternalWaterSource', { value = true })
	else
		noise('sq is null or index is invalid')
	end
end

local function _getWallVineObject(square)
	if not square then return end
	for i=0,square:getObjects():size()-1 do
		local object = square:getObjects():get(i);
		local attached = object:getAttachedAnimSprite()
		if attached then
			for n=1,attached:size() do
				local sprite = attached:get(n-1)
--					if sprite and sprite:getParentSprite() and sprite:getParentSprite():getProperties():Is(IsoFlagType.canBeCut) then
				if sprite and sprite:getParentSprite() and sprite:getParentSprite():getName() and luautils.stringStarts(sprite:getParentSprite():getName(), "f_wallvines_") then
					return object, n-1
				end
			end
		end
	end
end

Commands.object.removeBush = function(player, args)
	local sq = getCell():getGridSquare(args.x, args.y, args.z)
	if sq then
		if args.wallVine then
			local object,index = _getWallVineObject(sq)
			if object and index then
				object:RemoveAttachedAnim(index)
				object:transmitUpdatedSpriteToClients()
				sq:removeErosionObject("WallVines")
			end
			-- and the top one, if any
			local topSq = getCell():getGridSquare(sq:getX(), sq:getY(), sq:getZ() + 1)
			local object,index = _getWallVineObject(topSq)
			if object and index then
				object:RemoveAttachedAnim(index)
				object:transmitUpdatedSpriteToClients()
				topSq:removeErosionObject("WallVines")
			end
		else
			for i=0,sq:getObjects():size()-1 do
				local object = sq:getObjects():get(i);
				if object:getProperties():Is(IsoFlagType.canBeCut) then
					sq:transmitRemoveItemFromSquare(object)
					if ZombRand(2) == 0 then
						sq:AddWorldInventoryItem("Base.TreeBranch2", 0, 0, 0);
					end
					if ZombRand(1) == 0 then
						sq:AddWorldInventoryItem("Base.Twigs", 0, 0, 0);
					end
					i = i - 1; -- FIXME: illegal in Lua
				end
			end
		end
	else
		noise('sq is null')
	end
end

Commands.object.shovelGround = function(player, args)
	local sq = getCell():getGridSquare(args.x, args.y, args.z)
	if sq then
		local type,o = ISShovelGroundCursor.GetDirtGravelSand(sq)
		if instanceof(o, 'IsoObject') then
			local shovelledSprites = o:hasModData() and o:getModData().shovelledSprites
			if shovelledSprites then
				o:RemoveAttachedAnims() -- remove blend tiles
				-- Restore the sprites present before dirt/gravel/sand was dumped.
				local sprite = getSprite(shovelledSprites[1])
				if sprite then
					o:setSprite(sprite)
				end
				for i=2,#shovelledSprites do
					sprite = getSprite(shovelledSprites[i])
					if sprite then
						o:AttachExistingAnim(sprite, 0, 0, false, 0, false, 0.0)
					end
				end
				o:getModData().shovelledSprites = nil
				o:getModData().pouredFloor = nil
			else
				-- First time taking dirt/gravel/sand.
				o:getModData().shovelled = true
				o:setSprite(getSprite("blends_natural_01_64"))
				o:RemoveAttachedAnims() -- remove blend tiles
			end
			o:transmitUpdatedSpriteToClients()
			-- remove vegetation
			for i=sq:getObjects():size(),1,-1 do
				o = sq:getObjects():get(i-1)
				-- FIXME: blends_grassoverlays tiles should have 'vegitation' flag
				if o:getSprite() and (
						o:getSprite():getProperties():Is(IsoFlagType.canBeRemoved) or
						(o:getSprite():getProperties():Is(IsoFlagType.vegitation) and o:getType() ~= IsoObjectType.tree) or
						(o:getSprite():getName() and luautils.stringStarts(o:getSprite():getName(), "blends_grassoverlays"))) then
					sq:transmitRemoveItemFromSquare(o)
				end
			end
			local emptyBag = player:getInventory():getItemWithID(args.emptyBag)
			if emptyBag:hasTag("HoldDirt") and (args.newBag == "Base.Dirtbag" or args.newBag == "Base.Gravelbag" or args.newBag == "Base.Sandbag" or args.newBag == "Base.Claybag") then
				local isPrimary = player:isPrimaryHandItem(emptyBag)
				local isSecondary = player:isSecondaryHandItem(emptyBag)
				player:removeFromHands(emptyBag);
				player:getInventory():Remove(emptyBag);
				sendRemoveItemFromContainer(player:getInventory(), emptyBag);
				local item = player:getInventory():AddItem(args.newBag);
				sendAddItemToContainer(player:getInventory(), item);
				if item ~= nil then
					item:setUsedDelta(item:getUseDelta())
					sendItemStats(item)
					if isPrimary then
						player:setPrimaryHandItem(item)
					end
					if isSecondary then
						player:setSecondaryHandItem(item)
					end
					sendEquip(player)
				end
			elseif emptyBag:getCurrentUsesFloat() + emptyBag:getUseDelta() <= 1 then
				emptyBag:setUsedDelta(emptyBag:getCurrentUsesFloat() + emptyBag:getUseDelta())
				sendItemStats(emptyBag)
			end
			if ZombRand(5) == 0 then
				local item = instanceItem("Base.Worm")
				player:getInventory():AddItem(item);
				sendAddItemToContainer(player:getInventory(), item);
			end
		else
			noise('expected IsoObject got '..tostring(o))
		end
	else
		noise('sq is null')
	end
end

Commands.object.OnDestroyIsoThumpable = function(player, args)
	local thump = getThumpable(args.x, args.y, args.z, args.index)
	if thump then
--		RainCollectorBarrel.OnDestroyIsoThumpable(thump, nil)
--		TrapSystem.OnDestroyIsoThumpable(thump, nil)
	else
		noise('expected IsoThumpable, got '..tostring(thump))
	end
end

Commands.object.triggerRemote = function(player, args)
	if args.id and args.range then
		IsoTrap.triggerRemote(player, args.id, args.range)
	else
		noise('missing args')
	end
end

local _getTrashCan = function(x, y, z, index)
	local sq = getCell():getGridSquare(x, y, z)
	if sq and index >= 0 and index < sq:getObjects():size() then
		local object = sq:getObjects():get(index)
		if object:getSprite() and object:getSprite():getProperties():Is("IsTrashCan") then
			return object
		end
	end
	return nil
end

Commands.object.emptyTrash = function(player, args)
	local object = _getTrashCan(args.x, args.y, args.z, args.index)
	if object then
		if isServer() then
			local container = object:getContainer()
			while container:getItems():size() > 0 do
				local item = container:getItems():get(0)
				container:DoRemoveItem(item)
				print("emptyTrash: removing item !!!")
			end
			container:clear()

			if object:getOverlaySprite() then
				ItemPicker.updateOverlaySprite(object)
			end
		end

		-- sendObjectChange will do all needed logic in SP and for clients
		object:sendObjectChange('emptyTrash');
	else
		print('expected trash can')
	end
end

Commands.object.setWaterAmount = function(player, args)
	-- This command works for *any* object that the player takes
	-- water from, including sinks and rain barrels.
	if args.amount < 0 then
		print('invalid water amount')
		return
	end
	local gs = getCell():getGridSquare(args.x, args.y, args.z)
	if not gs then
		print('square is nil')
		return
	end
	if args.index < 0 or args.index >= gs:getObjects():size() then
		print('invalid object')
	end
	local obj = gs:getObjects():get(args.index)
	local amount = obj:getFluidAmount()
	if amount == args.amount then
		return
	end
	
	obj:emptyFluid();
	obj:addFluid(FluidType.Water, args.amount);
	obj:transmitModData()
end

Commands.object.clearContainerExplore = function(player, args)
	local sq = getCell():getGridSquare(args.x, args.y, args.z)
	if not sq then
		return
	end
	if sq and args.index >= 0 and args.index < sq:getObjects():size() then
		local o = sq:getObjects():get(args.index)
		if o ~= nil then
			if args.containerIndex == -1 then
				local container = o:getContainer()
				container:setExplored(false)
				container:getSourceGrid():getRoom():getRoomDef():getProceduralSpawnedContainer():clear()
			else
				local container = o:getContainerByIndex(args.containerIndex)
				container:setExplored(false)
				container:getSourceGrid():getRoom():getRoomDef():getProceduralSpawnedContainer():clear()
			end
		end
	end
end

Commands.object.updateOverlaySprite = function(player, args)
	local sq = getCell():getGridSquare(args.x, args.y, args.z)
	if not sq then
		return
	end
	if sq and args.index >= 0 and args.index < sq:getObjects():size() then
		local o = sq:getObjects():get(args.index)
		if o ~= nil then
			if args.containerIndex == -1 then
				local container = o:getContainer()
				ItemPicker.updateOverlaySprite(container:getParent())
			else
				local container = o:getContainerByIndex(args.containerIndex)
				ItemPicker.updateOverlaySprite(container:getParent())
			end
		end
	end
end

Commands.object.addWaterContainer = function(player, args)
	local sq = getCell():getGridSquare(args.x, args.y, args.z)
	if sq and args.index >= 0 and args.index < sq:getObjects():size() then
		local o = sq:getObjects():get(args.index)
		if o ~= nil then
			local f = ComponentType.FluidContainer:CreateComponent();
			f:setCapacity(5.0);
			f:addFluid(FluidType.Water, 5.0);
			GameEntityFactory.AddComponent(o, true, f);
			print("Adding water container to object");
		end
	end
end

Commands.object.removeFluidContainer = function(player, args)
	local sq = getCell():getGridSquare(args.x, args.y, args.z)
	if sq and args.index >= 0 and args.index < sq:getObjects():size() then
		local o = sq:getObjects():get(args.index)
		if o ~= nil then
			GameEntityFactory.RemoveComponentType(o, ComponentType.FluidContainer);
			print("Removing water container from object");
		end
	end
end

Commands.object.setBombTimer = function(player, args)
	local itemBomb = player:getInventory():getItemWithID(args.itemID);
	if not itemBomb then
		print("Cannot find bomb in player's inventory");
		return
	end
	itemBomb:setExplosionTimer(args.time);
end
-- -- -- -- --

Commands.fireplace = {}

local getFireplace = function(x, y, z)
	local gs = getCell():getGridSquare(x, y, z)
	if not gs then return nil end
	for i=0,gs:getObjects():size()-1 do
		local o = gs:getObjects():get(i)
		if o and instanceof(o, 'IsoFireplace') then
			return o
		end
	end
	return nil
end

Commands.fireplace.setFuel = function(player, args)
	local fp = getFireplace(args.x, args.y, args.z)
	if fp then
		fp:setFuelAmount(args.fuelAmt)
		fp:sendObjectChange('state')
	end
end


Commands.bbq = {}

local getBarbecue = function(x, y, z)
	local gs = getCell():getGridSquare(x, y, z)
	if not gs then return nil end
	for i=0,gs:getObjects():size()-1 do
		local o = gs:getObjects():get(i)
		if o and instanceof(o, 'IsoBarbecue') then
			return o
		end
	end
	return nil
end


Commands.bbq.setFuel = function(player, args)
	local bbq = getBarbecue(args.x, args.y, args.z)
	if bbq then
		bbq:setFuelAmount(args.fuelAmt)
		bbq:sendObjectChange('state')
	end
end

-- -- -- -- --

Commands.player = {}
Commands.player.onHealthCheat = function(player, args)
	local otherPlayer = getPlayerByOnlineID(args.id)
	if otherPlayer and checkPermissions(player, Capability.UseHealthCheat) then
		sendServerCommand(otherPlayer, "ISHealthPanel", "onHealthCheat", args)
	end
end

Commands.player.onHealthCheatCurrentPlayer = function(player, args)
	local otherPlayer = getPlayerByOnlineID(args.id)
	local action = args.action
	local bodyPart = otherPlayer:getBodyDamage():getBodyParts():get(args.bodyPartIndex)
	if action == "bleeding" then
		bodyPart:setBleedingTime((bodyPart:getBleedingTime() > 0) and 0 or 10)
	end
	if action == "hole" then
		otherPlayer:addHole(BloodBodyPartType.FromIndex(BodyPartType.ToIndex(bodyPart:getType())));
	end
	if action == "patch" then
		otherPlayer:addBasicPatch(BloodBodyPartType.FromIndex(BodyPartType.ToIndex(bodyPart:getType())));
	end
	if action == "blood" then
		otherPlayer:addBlood(BloodBodyPartType.FromIndex(BodyPartType.ToIndex(bodyPart:getType())), false, true, false);
	end
	if action == "removeblood" then
		otherPlayer:getVisual():setBlood(BloodBodyPartType.FromIndex(BodyPartType.ToIndex(bodyPart:getType())), 0);
		otherPlayer:resetModelNextFrame();
	end
	if action == "dirt" then
		otherPlayer:addDirt(BloodBodyPartType.FromIndex(BodyPartType.ToIndex(bodyPart:getType())), nil, false);
	end
	if action == "removedirt" then
		otherPlayer:getVisual():setDirt(BloodBodyPartType.FromIndex(BodyPartType.ToIndex(bodyPart:getType())), 0);
		otherPlayer:resetModelNextFrame();
	end
	if action == "bite" then
		if bodyPart:bitten() then
			bodyPart:SetBitten(false);
			bodyPart:SetInfected(false);
			bodyPart:SetFakeInfected(false);
		else
			bodyPart:SetBitten(true);
		end
	end
	if action == "holeback" then
		otherPlayer:addHole(BloodBodyPartType.Back);
	end
	if action == "bullet" then
		if bodyPart:haveBullet() then
			local deepWound = bodyPart:isDeepWounded()
			local deepWoundTime = bodyPart:getDeepWoundTime()
			local bleedTime = bodyPart:getBleedingTime()
			bodyPart:setHaveBullet(false, 0)
			bodyPart:setDeepWoundTime(deepWoundTime)
			bodyPart:setDeepWounded(deepWound)
			bodyPart:setBleedingTime(bleedTime)
		else
			bodyPart:setHaveBullet(true, 0)
		end
	end
	if action == "burned" then
		if bodyPart:getBurnTime() > 0 then
			bodyPart:setBurnTime(0)
		else
			bodyPart:setBurnTime(50)
		end
	end
	if action == "burnWash" then
		if bodyPart:getBurnTime() > 0 then
			bodyPart:setNeedBurnWash(not bodyPart:isNeedBurnWash())
		end
	end
	if action == "deepWound" then
		if bodyPart:getDeepWoundTime() > 0 then
			bodyPart:setDeepWoundTime(0)
			bodyPart:setDeepWounded(false)
			bodyPart:setBleedingTime(0)
		else
			bodyPart:generateDeepWound();
		end
	end
	if action == "fracture" then
		if bodyPart:getFractureTime() > 0 then
			bodyPart:setFractureTime(0)
		else
			bodyPart:setFractureTime(21)
		end
	end
	if action == "healthFull" then
		bodyPart:RestoreToFullHealth();

		if bodyPart:getStiffness() > 0 then
			bodyPart:setStiffness(0)
			player:getFitness():removeStiffnessValue(BodyPartType.ToString(bodyPart:getType()))
		end
	end
	if action == "healthFullBody" then
		local bodyParts = player:getBodyDamage():getBodyParts()
		for i=1, bodyParts:size() do
			local bP = bodyParts:get(i-1)
			bP:RestoreToFullHealth();

			if bP:getStiffness() > 0 then
				bP:setStiffness(0)
				player:getFitness():removeStiffnessValue(BodyPartType.ToString(bP:getType()))
			end
		end
	end
	if action == "glass" then
		bodyPart:generateDeepShardWound();
	end
	if action == "infected" then
		if bodyPart:isInfectedWound() then
			bodyPart:setWoundInfectionLevel(-1)
		else
			bodyPart:setWoundInfectionLevel(10)
		end
	end
	if action == "scratched" then
		if bodyPart:getScratchTime() > 0 then
			bodyPart:setScratched(false, true)
			bodyPart:setScratchTime(0)
		else
			bodyPart:setScratched(true, false);
		end
	end
	if action == "cut" then
		if bodyPart:isCut() then
			bodyPart:setCut(false)
			bodyPart:setCutTime(0)
		else
			bodyPart:setCut(true)
		end
	end
	if action == "fatique" then
		if bodyPart:getStiffness() > 0 then
			bodyPart:setStiffness(0)
			player:getFitness():removeStiffnessValue(BodyPartType.ToString(bodyPart:getType()))
		else
			bodyPart:setStiffness(100)
		end
	end
	syncBodyPart(bodyPart, 0xFFFFFFFFFFF);
end

Commands.player.setWeight = function(player, args)
	local otherPlayer = getPlayerByOnlineID(args.id)
	if otherPlayer then
		sendServerCommand(otherPlayer, "player", "setWeight", args)
	end
end

Commands.player.syncWeight = function(player, args)
	local otherPlayer = getPlayerByOnlineID(args.id)
	if otherPlayer then
		sendServerCommand(otherPlayer, "player", "syncWeight", args)
	end
end

Commands.erosion = {};
Commands.erosion.disableForSquare = function(player, args)
    local sq = getCell():getGridSquare(args.x, args.y, args.z);
    if sq ~= nil then
        sq:disableErosion();
    end
end

Commands.event = {}
Commands.event.thunder = function(player, args)
	if args.isAll then
		local thunder = getClimateManager():getThunderStorm()
		local onlineUsers = getOnlinePlayers()
		for i=0, onlineUsers:size()-1 do
			local sq = onlineUsers:get(i):getSquare()
			thunder:triggerThunderEvent(sq:getX(), sq:getY(), true, true, true)
		end
	else
		getClimateManager():getThunderStorm():triggerThunderEvent(args.x, args.y, true, true, true)
	end
end

 -- -- -- -- --

Commands.debugAction = {}
Commands.debugAction.getBuildingKey = function(player, args)
	if not player:getRole():hasCapability(Capability.AddItem) then
		print('debugAction.getBuildingKey The player\'s access level is not sufficient to perform this action')
		return
	end

    local sq = player:getCurrentSquare()
    if sq and sq:getBuilding() then
        local key = instanceItem("Base.Key1")
        key:setKeyId(sq:getBuilding():getDef():getKeyId())
        ItemPickerJava.keyNamerBuilding(key, sq)

        player:getInventory():AddItem(key)
        sendAddItemToContainer(player:getInventory(), key);
    end
end

Commands.debugAction.getDoorKey = function(player, args)
	if not player:getRole():hasCapability(Capability.AddItem) then
		print('debugAction.getBuildingKey The player\'s access level is not sufficient to perform this action')
		return
	end

	local gs = getCell():getGridSquare(args.x, args.y, args.z)
	if not gs then
		print('square is nil')
		return
	end
	if args.index < 0 or args.index >= gs:getObjects():size() then
		print('invalid object')
	end
	local door = gs:getObjects():get(args.index)

	local keyID = -1
	if instanceof(door, "IsoDoor") then
		keyID = door:checkKeyId()
	elseif instanceof(door, "IsoThumpable") then
		keyID = door:getKeyId()
	end

	if keyID == -1 then
		keyID = ZombRand(100000000)
	end
	door:setKeyId(keyID)

	local doubleDoorObjects = buildUtil.getDoubleDoorObjects(door)
	for i=1,#doubleDoorObjects do
		local object = doubleDoorObjects[i]
		object:setKeyId(keyID)
	end

	local garageDoorObjects = buildUtil.getGarageDoorObjects(door)
	for i=1,#garageDoorObjects do
		local object = garageDoorObjects[i]
		object:setKeyId(keyID)
	end

	local key = instanceItem("Base.Key1")
	key:setKeyId(keyID)

	player:getInventory():AddItem(key)
	sendAddItemToContainer(player:getInventory(), key);
end

Commands.debugAction.mannequinCreateItem = function(player, args)
	if not player:getRole():hasCapability(Capability.AddItem) then
		print('debugAction.getBuildingKey The player\'s access level is not sufficient to perform this action')
		return
	end

	local script = getScriptManager():getMannequinScript(args.script)

	local spriteName = script:isFemale() and "location_shop_mall_01_65" or "location_shop_mall_01_68"
	local obj = IsoMannequin.new(getCell(), nil, getSprite(spriteName))
	obj:setMannequinScriptName(script:getName())
	local item = instanceItem("Moveables.Moveable")
	item:ReadFromWorldSprite(spriteName)
	obj:setCustomSettingsToItem(item)

	player:getInventory():AddItem(item)
	sendAddItemToContainer(player:getInventory(), item);
end

-- -- -- -- --
Commands.animal = {}
Commands.animal.forceEgg = function(player, args)
	if not player:getRole():hasCapability(Capability.AnimalCheats) then
		print('animal.hutch The player\'s access level is not sufficient to perform this action')
		return
	end
	local animal = getAnimal(tonumber(args.id))
	animal:debugForceEgg()
	sendServerCommandV("animal", "forceEgg",
			"id", animal:getOnlineID())
end
Commands.animal.add = function(player, args)
	if not player:getRole():hasCapability(Capability.AnimalCheats) then
		print('animal.hutch The player\'s access level is not sufficient to perform this action')
		return
	end
	local breed = AnimalDefinitions.getDef(args.type):getBreedByName(args.breed)
	local animal = addAnimal(getCell(), tonumber(args.x), tonumber(args.y), tonumber(args.z), args.type, breed, args.skeleton)
	animal:addToWorld()
end
Commands.animal.addBaby = function(player, args)
	if not player:getRole():hasCapability(Capability.AnimalCheats) then
		print('animal.hutch The player\'s access level is not sufficient to perform this action')
		return
	end
	local animal = getAnimal(tonumber(args.id))
	animal:addBaby()
end
Commands.animal.addEgg = function(player, args)
	if not player:getRole():hasCapability(Capability.AnimalCheats) then
		print('animal.hutch The player\'s access level is not sufficient to perform this action')
		return
	end
	local animal = getAnimal(tonumber(args.id))
	animal:addEgg(false)
end
Commands.animal.forceEgg = function(player, args)
	if not player:getRole():hasCapability(Capability.AnimalCheats) then
		print('animal.hutch The player\'s access level is not sufficient to perform this action')
		return
	end
	local animal = getAnimal(tonumber(args.id))
	animal:debugForceEgg()
end
Commands.animal.remove = function(player, args)
	if not player:getRole():hasCapability(Capability.AnimalCheats) then
		print('animal.hutch The player\'s access level is not sufficient to perform this action')
		return
	end
	removeAnimal(tonumber(args.id))
end
Commands.animal.removeFromHutch = function(player, args)
	if not player:getRole():hasCapability(Capability.AnimalCheats) then
		print('animal.removeFromHutch The player\'s access level is not sufficient to perform this action')
		return
	end
	local animal = getAnimal(tonumber(args.id))
	sendHutchRemoveAnimalAction(animal, player, animal:getHutch());
	animal:getHutch():removeAnimal(animal)
end
Commands.animal.removeEggFromNestBox = function(player, args)
	if not player:getRole():hasCapability(Capability.AnimalCheats) then
		print('animal.removeEggFromNestBox The player\'s access level is not sufficient to perform this action')
		return
	end
	local hutch = getHutch(tonumber(args.x), tonumber(args.y), tonumber(args.z))
	local nestBox = hutch:getNestBox(tonumber(args.nestIdx))
	local egg = nestBox:removeEgg(ZombRand(nestBox:getEggsNb()))
	hutch:sync()
	player:getInventory():AddItem(egg)
end
Commands.animal.forceHutch = function(player, args)
	local animal = getAnimal(tonumber(args.id))
	sendServerCommand(animal:getOwner(), "animal", "forceHutch", args)
end
Commands.animal.forceWander = function(player, args)
	local animal = getAnimal(tonumber(args.id))
	sendServerCommand(animal:getOwner(), "animal", "forceWander", args)
end
Commands.animal.hutch = function(player, args)
	if not player:getRole():hasCapability(Capability.AnimalCheats) then
		print('animal.hutch The player\'s access level is not sufficient to perform this action')
		return
	end
	local breed = AnimalDefinitions.getDef(args.type):getBreedByName(args.breed)
	local animal = addAnimal(getCell(), args.x, args.y, args.z, args.type, breed)
	local hutch = getHutch(tonumber(args.x), tonumber(args.y), tonumber(args.z))
	animal:setX(tonumber(args.x))
	animal:setY(tonumber(args.y))
	animal:setZ(tonumber(args.z))
	if args.index then
		animal:getData():setPreferredHutchPosition(tonumber(args.index))
		hutch:addAnimalInside(animal)
	else
		hutch:addAnimalInNestBox(animal)
	end
end
Commands.animal.invincible = function(player, args)
	if not player:getRole():hasCapability(Capability.AnimalCheats) then
		print('animal.invincible The player\'s access level is not sufficient to perform this action')
		return
	end
	local animal = getAnimal(tonumber(args.id))
	animal:setIsInvincible(not animal:isInvincible())
	sendServerCommandV("animal", "invincible",
			"id", args.id,
			"value", animal:isInvincible())
end
Commands.animal.kill = function(player, args)
	if not player:getRole():hasCapability(Capability.AnimalCheats) then
		print('animal.invincible The player\'s access level is not sufficient to perform this action')
		return
	end
	local animal = getAnimal(tonumber(args.id))
	if args.index then
		local hutch = getHutch(tonumber(args.x), tonumber(args.y), tonumber(args.z))
		animal:getData():setHutchPosition(tonumber(args.index))
		hutch:killAnimal(animal)
		hutch:sync()
		--sendServerCommandV("animal", "kill",
		--		"id", args.id,
		--		"index", animal:getData():getHutchPosition(),
		--		"x", args.x,
		--		"y", args.y,
		--		"z", args.z)
	else
		animal:setAttackedBy(getFakeAttacker())
		animal:setHealth(0)
		sendServerCommandV("animal", "kill",
				"id", args.id)
	end

end
Commands.animal.setWool = function(player, args)
	local animal = getAnimal(tonumber(args.id))
	animal:getData():setWoolQuantity(tonumber(args.value), true)
	sendServerCommandV("animal", "setWool",
			"id", args.id,
			"value", args.value)
end
Commands.animal.setMilk = function(player, args)
	local animal = getAnimal(tonumber(args.id))
	animal:getData():setMaxMilkActual(tonumber(args.value))
	animal:getData():setMilkQuantity(tonumber(args.value))
	sendServerCommandV("animal", "setMilk",
			"id", args.id,
			"value", args.value)
end
Commands.animal.setStress = function(player, args)
	local animal = getAnimal(tonumber(args.id))
	animal:setDebugStress(tonumber(args.value))
	sendServerCommandV("animal", "setStress",
			"id", args.id,
			"value", args.value)
end
Commands.animal.setAge = function(player, args)
	local animal = getAnimal(tonumber(args.id))
	animal:setAgeDebug(tonumber(args.value))
	sendServerCommandV("animal", "setAge",
			"id", args.id,
			"value", args.value)
end
Commands.animal.setHunger = function(player, args)
	local animal = getAnimal(tonumber(args.id))
	animal:getStats():setHunger(tonumber(args.value));
	sendServerCommandV("animal", "setHunger",
			"id", args.id,
			"value", args.value)
end
Commands.animal.setThirst = function(player, args)
	local animal = getAnimal(tonumber(args.id))
	animal:getStats():setThirst(tonumber(args.value));
	sendServerCommandV("animal", "setThirst",
			"id", args.id,
			"value", args.value)
end
Commands.animal.addBucketMilk = function(player, args)
	local animal = getAnimal(tonumber(args.id))
	local item = animal:addDebugBucketOfMilk(player)
	player:getInventory():AddItem(item)
	sendAddItemToContainer(player:getInventory(), item)
end
Commands.animal.acceptance = function(player, args)
	local animal = getAnimal(tonumber(args.id))
	local player = getPlayerByOnlineID(tonumber(args.player))
	animal:setDebugAcceptance(player, tonumber(args.acceptance))
	sendServerCommandV("animal", "acceptance",
			"id", args.id,
			"player", player:getOnlineID(),
			"acceptance", args.acceptance)
end
Commands.animal.updateStatsAway = function(player, args)
	print("id="..tostring(args.id))
	local animal = getAnimal(tonumber(args.id))
	animal:updateLastTimeSinceUpdate();
	animal:updateStatsAway(tonumber(args.value));
	sendServerCommandV("animal", "updateStatsAway",
			"id", args.id,
			"value", args.value)
end
Commands.animal.fertilized = function(player, args)
	local animal = getAnimal(tonumber(args.id))
	animal:getData():setFertilized(args.value)
	local male = getAnimal(tonumber(args.male))
	if male and args.value then
		animal:getData():setMaleGenome(male:getFullGenome())
	end
	sendServerCommandV("animal", "fertilized",
			"id", args.id,
			"value", args.value,
			"male", args.male)
end
Commands.animal.fertilizedTime = function(player, args)
	local animal = getAnimal(tonumber(args.id))
	animal:getData():setFertilizedTime(args.value)
	sendServerCommandV("animal", "fertilizedTime",
			"id", args.id,
			"value", args.value)
end
Commands.animal.pregnant = function(player, args)
	local animal = getAnimal(tonumber(args.id))
	animal:getData():setPregnant(args.value)
	sendServerCommandV("animal", "pregnant",
		"id", args.id,
		"value", args.value)
end
Commands.animal.pregnancyTime = function(player, args)
	local animal = getAnimal(tonumber(args.id))
	animal:getData():setPregnancyTime(args.value)
	sendServerCommandV("animal", "pregnancyTime",
			"id", args.id,
			"value", args.value)
end
Commands.animal.dung = function(player, args)
	if not player:getRole():hasCapability(Capability.AnimalCheats) then
		print('animal.dung The player\'s access level is not sufficient to perform this action')
		return
	end

	local animal = getAnimal(tonumber(args.id))
	animal:getData():checkPoop(false, true);
end
Commands.animal.happy = function(player, args)
	local animal = getAnimal(tonumber(args.id))
	animal:debugRandomHappyAnim()
	sendServerCommandV("animal", "happy",
			"id", args.id)
end
Commands.animal.attach = function(player, args)
	local animal = getAnimal(tonumber(args.id))
	local item = instanceItem(args.item)
	animal:setAttachedItem(args.location, item)
	sendServerCommandV("animal", "attach",
			"id", args.id,
			"location", args.location,
			"item", args.item)
end
-- -- -- -- --
Commands.hutch = {}
Commands.hutch.dirt = function(player, args)
	local hutch = getHutch(tonumber(args.x), tonumber(args.y), tonumber(args.z))
	hutch:setHutchDirt(args.dirt)
	sendServerCommandV("hutch", "dirt",
			"x", hutch:getX(),
			"y", hutch:getY(),
			"z", hutch:getZ(),
			"dirt", args.dirt)
end
Commands.hutch.nestBoxDirt = function(player, args)
	local hutch = getHutch(tonumber(args.x), tonumber(args.y), tonumber(args.z))
	hutch:setNestBoxDirt(args.dirt)
	sendServerCommandV("hutch", "nestBoxDirt",
			"x", hutch:getX(),
			"y", hutch:getY(),
			"z", hutch:getZ(),
			"dirt", args.dirt)
end
-- -- -- -- --
Commands.stove = {}
Commands.stove.setOvenParamsAndToggle = function(player, args)
	local sq = getSquare(args.x, args.y, args.z);
	if sq then
		for i=0, sq:getObjects():size()-1 do
			local obj = sq:getObjects():get(i);
			if instanceof(obj, "IsoStove") then
				obj:setTimer(args.timer);
				obj:setMaxTemperature(args.maxTemperature);
				obj:Toggle();
			end
		end
	end
end

ClientCommands.OnClientCommand = function(module, command, player, args)
	if Commands[module] and Commands[module][command] then
		local argStr = ''
		if args then
		    for k,v in pairs(args) do argStr = argStr..' '..k..'='..tostring(v) end
        end
		noise('received '..module..' '..command..' '..tostring(player)..argStr)
		Commands[module][command](player, args)
	end
end

Events.OnClientCommand.Add(ClientCommands.OnClientCommand)
