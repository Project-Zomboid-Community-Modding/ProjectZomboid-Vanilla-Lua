--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISDropWorldItemAction = ISBaseTimedAction:derive("ISDropWorldItemAction");

function ISDropWorldItemAction:isValid()	
	local ground = self.sq:getTotalWeightOfItemsOnFloor()
	if ground + self.item:getUnequippedWeight() > 50 then
		return false
	end
	return self.character:getInventory():contains(self.item);
end

function ISDropWorldItemAction:update()
	self.item:setJobDelta(self:getJobDelta());
end

function ISDropWorldItemAction:start()
	self.item:setJobType(getText("IGUI_JobType_Dropping"));
	self.item:setJobDelta(0.0);
	local sound = self.item:getPlaceOneSound() or "PutItemInBag"
	if self.isMultiple and self.item:getPlaceMultipleSound() then
		sound = self.item:getPlaceMultipleSound()
	end
	if not self.character:getEmitter():isPlaying(sound) then
		self.sound = self.character:playSound(sound)
	end
end

function ISDropWorldItemAction:stop()
    self.item:setJobDelta(0.0);
    self.character:stopOrTriggerSound(self.sound)
    ISBaseTimedAction.stop(self);
end

function ISDropWorldItemAction:perform()
	if self.sound then
		local actionQueue = ISTimedActionQueue.getTimedActionQueue(self.character)
		local nextAction = actionQueue.queue[2]
		if not nextAction or (nextAction.Type ~= ISDropWorldItemAction.Type) or (nextAction.item:getFullType() ~= self.item:getFullType()) then
			self.character:stopOrTriggerSound(self.sound)
		else
			nextAction.sound = self.sound -- pass it to the next action so it can be stopped
		end
	end

	if self.item:getType() == "CandleLit" then
		local candle = self.character:getInventory():AddItem("Base.Candle");
		candle:setUsedDelta(self.item:getUsedDelta());
		candle:setCondition(self.item:getCondition());
		candle:setFavorite(self.item:isFavorite());
		self.character:getInventory():Remove(self.item);
		self.item = candle;
	end

    self.item:getContainer():setDrawDirty(true);
    self.item:setJobDelta(0.0);

	local worldItem = self.sq:AddWorldInventoryItem(self.item, self.xoffset, self.yoffset, self.zoffset, false)
	if worldItem then
		worldItem:setWorldZRotation(self.rotation);
		worldItem:getWorldItem():setIgnoreRemoveSandbox(true); -- avoid the item to be removed by the SandboxOption WorldItemRemovalList
	end
	worldItem:getWorldItem():transmitCompleteItemToServer();
	self.character:getInventory():Remove(self.item);

	if instanceof(worldItem, "Radio") then
		local square = worldItem:getWorldItem():getSquare()
		local _obj = IsoRadio.new(getCell(), square, nil)
		local deviceData = worldItem:getDeviceData();
		if deviceData then
			_obj:setDeviceData(deviceData);
		end

		_obj:getModData().RadioItemID = worldItem:getID()
		square:AddSpecialObject(_obj, square:getObjects():size())
		if isClient() then _obj:transmitCompleteItemToServer(); end
		_obj:transmitModData()
		triggerEvent("OnObjectAdded", _obj)
		square:RecalcProperties()
		square:RecalcAllWithNeighbours(true)
	end

	ISInventoryPage.renderDirty = true
    
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISDropWorldItemAction:new(character, item, sq, xoffset, yoffset, zoffset, rotation, isMultiple)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character;
	o.item = item;
	o.sq = sq;
	o.xoffset = xoffset;
	o.yoffset = yoffset;
	o.zoffset = zoffset;
	o.rotation = rotation;
	o.stopOnWalk = false;
	o.stopOnRun = false;
	o.maxTime = 50;
	o.srcContainer = item:getContainer();
	o.isMultiple = isMultiple;
	
	-- o.cont = ItemContainer.new("floor", nil, nil, 10, 10)
	-- o.cont:setExplored(true)

	local w = item:getActualWeight();
	if w > 3 then w = 3; end;
	o.maxTime = o.maxTime * (w)

	o.maxTime = o.maxTime * 0.1;

	if character:HasTrait("Dextrous") then
		o.maxTime = o.maxTime * 0.5
	end
	if character:HasTrait("AllThumbs") then
		o.maxTime = o.maxTime * 4.0
	end

	if o.character:isTimedActionInstant() then o.maxTime = 1; end
	return o
end
