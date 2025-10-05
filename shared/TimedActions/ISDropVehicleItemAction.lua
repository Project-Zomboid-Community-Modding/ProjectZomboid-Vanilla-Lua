--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISDropVehicleItemAction = ISBaseTimedAction:derive("ISDropVehicleItemAction");

function ISDropVehicleItemAction:isValid()	
	local ground = self.dropSquare:getTotalWeightOfItemsOnFloor()
	if ground + self.item:getUnequippedWeight() > 50 then
		return false
	end
	if isClient() and self.item then
	    return self.character:getInventory():containsID(self.item:getID());
	else
	    return self.character:getInventory():contains(self.item);
	end
end

function ISDropVehicleItemAction:update()
	self.dropSquare = self.vehicle:getSquareForArea(self.area)
	self.item:setJobDelta(self:getJobDelta());
end

function ISDropVehicleItemAction:start()
    if isClient() and self.item then
        self.item = self.character:getInventory():getItemById(self.item:getID())
    end
	self.item:setJobType(getText("IGUI_JobType_Dropping"));
	self.item:setJobDelta(0.0);
	local sound = self.item:getPlaceOneSound() or "PutItemInBag"
	if not self.character:getEmitter():isPlaying(sound) then
		self.sound = self.character:playSound(sound)
	end
end

function ISDropVehicleItemAction:stop()
    self.item:setJobDelta(0.0);

	if self.sound then
		self.character:stopOrTriggerSound(self.sound)
	end
    ISBaseTimedAction.stop(self);
end

function ISDropVehicleItemAction:complete()
	local worldItem = self.dropSquare:AddWorldInventoryItem(self.item, 0, 0, 0, false)
	if worldItem then
		worldItem:setWorldZRotation(self.rotation);
		if worldItem:getWorldItem() then
			worldItem:getWorldItem():setIgnoreRemoveSandbox(true); -- avoid the item to be removed by the SandboxOption WorldItemRemovalList
            worldItem:getWorldItem():setExtendedPlacement(false)
            worldItem:getWorldItem():transmitCompleteItemToClients();
		end
	end
	self.character:getInventory():Remove(self.item);
	sendRemoveItemFromContainer(self.character:getInventory(), self.item);

	if instanceof(worldItem, "Radio") then
		local square = worldItem:getWorldItem():getSquare()
		local _obj = IsoRadio.new(getCell(), square, nil)
		local deviceData = worldItem:getDeviceData();
		if deviceData then
			_obj:setDeviceData(deviceData);
		end

		_obj:getModData().RadioItemID = worldItem:getID()
		square:AddSpecialObject(_obj, square:getObjects():size())

		_obj:transmitCompleteItemToClients()
		_obj:transmitModData()

		triggerEvent("OnObjectAdded", _obj)
		square:RecalcProperties()
		square:RecalcAllWithNeighbours(true)
	end

	return true;
end

function ISDropVehicleItemAction:perform()
	if self.sound then
		local actionQueue = ISTimedActionQueue.getTimedActionQueue(self.character)
		local nextAction = actionQueue.queue[2]
		if not nextAction or (nextAction.Type ~= ISDropVehicleItemAction.Type) or (nextAction.item:getFullType() ~= self.item:getFullType()) then
			self.character:stopOrTriggerSound(self.sound)
		else
			nextAction.sound = self.sound -- pass it to the next action so it can be stopped
		end
	end

    if self.item:getContainer() then self.item:getContainer():setDrawDirty(true) end
    self.item:setJobDelta(0.0);

	ISInventoryPage.renderDirty = true
    
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISDropVehicleItemAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end

	local maxTime = 50;

	local w = self.item:getActualWeight();
	if w > 3 then w = 3; end;
	maxTime = maxTime * (w)
	maxTime = maxTime * 0.1

	if self.character:HasTrait("Dextrous") then
		maxTime = maxTime * 0.5
	end
	if self.character:HasTrait("AllThumbs") or self.character:isWearingAwkwardGloves() then
		maxTime = maxTime * 2.0
	end

	return maxTime;
end

function ISDropVehicleItemAction:new(character, item, vehicle, door, dropSquare)
	local o = ISBaseTimedAction.new(self, character);
	o.character = character;
	o.item = item;
	o.vehicle = vehicle;
	o.door = door;
	o.dropSquare = dropSquare;
	o.stopOnWalk = false;
	o.stopOnRun = false;
	o.area = door:getArea()
	o.rotation = ZombRand(360)
	o.maxTime = o:getDuration();
	return o
end
