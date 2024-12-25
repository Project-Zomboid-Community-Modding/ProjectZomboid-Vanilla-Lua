--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISGrabItemAction = ISBaseTimedAction:derive("ISGrabItemAction");

function ISGrabItemAction:isValid()
    -- Prevent grabbing item if another player acts with it
    if isClient() then
        if not self.started and not isItemTransactionConsistent(nil, self.sourceContainer, self.destContainer, nil) then
            -- self.corpse, ItemContainer.new("floor", self.corpseBody:getSquare(), nil)
            return false
        end
    end

	-- Prevent grabbing items through walls
	if self.item:getSquare() and self.character:getSquare() then
		if self.item:getSquare():isBlockedTo(self.character:getSquare()) then
			return false;
		end;
	end;

	-- Check that the item wasn't picked up by a preceding action
	if self.item == nil or self.item:getSquare() == nil then return false end

	-- Check that the item wasn't removed by another player's action
	if not self.item:getSquare():getWorldObjects():contains(self.item) then return false; end;

	return self.destContainer:hasRoomFor(self.character, self.item:getItem())
end

function ISGrabItemAction:update()
	self.item:getItem():setJobDelta(self:getJobDelta());

	if isClient() then
		if isItemTransactionDone(self.transactionId) then
			self:forceComplete();
		elseif isItemTransactionRejected(self.transactionId) then
			self:forceStop();
		end
	end

    if isClient() and self.maxTime == -1 then
        local duration = getItemTransactionDuration(self.transactionId)
        if duration > 0 then
            self.maxTime = duration
            self.action:setTime(self.maxTime)
        end
    end
end

function ISGrabItemAction:start()
	self:setActionAnim("Loot");
	self:setAnimVariable("LootPosition", "Low");
	self:setOverrideHandModels(nil, nil);
	self.item:getItem():setJobType(getText("ContextMenu_Grab"));
	self.item:getItem():setJobDelta(0.0);
	self.character:reportEvent("EventLootItem");
	self.transactionId = createItemTransaction(self.character, nil, self.sourceContainer, self.destContainer)
	self.started = true
end

function ISGrabItemAction:stop()
    removeItemTransaction(self.transactionId, true)
    ISBaseTimedAction.stop(self);
    self.item:getItem():setJobDelta(0.0);
    self.started = false
end

function ISGrabItemAction:perform()
	local queuedItem = table.remove(self.queueList, 1);
	for i,item in ipairs(queuedItem.items) do
		self.item = item
		-- Check destination container capacity and item-count limit.
		if not self:isValid() then
			self.queueList = {}
			break
		end

		if not isClient() and instanceof(item:getItem(), "Radio") then
			local square = item:getItem():getWorldItem():getSquare()
			local _obj = nil
			for i=0, square:getObjects():size()-1 do
				local tObj = square:getObjects():get(i)
				if instanceof(tObj, "IsoRadio") then
					if tObj:getModData().RadioItemID == item:getItem():getID() then
						_obj = tObj
						break
					end
				end
			end
			if _obj ~= nil then
				local deviceData = _obj:getDeviceData();
				if deviceData then
					item:getItem():setDeviceData(deviceData);
				end
				square:transmitRemoveItemFromSquare(_obj)
				square:RecalcProperties();
				square:RecalcAllWithNeighbours(true);
			end
		end
		
		self:transferItem(item);
	end
	if #self.queueList > 0 then
		queuedItem = self.queueList[1]
		self.maxTime = queuedItem.time;
		self.action:setTime(tonumber(queuedItem.time))
		self.item = queuedItem.items[1];
		self:resetJobDelta();
	else
		self.action:stopTimedActionAnim();
		self.action:setLoopedAction(false);
		-- needed to remove from queue / start next.
		ISBaseTimedAction.perform(self);
	end
	self.started = false
end

function ISGrabItemAction:transferItem(item)
	removeItemTransaction(self.transactionId, false)
    if isClient() then
        ISBaseTimedAction.perform(self);
        return
    end

	-- For SP only
	local inventoryItem = self.item:getItem()
	self.item:getSquare():transmitRemoveItemFromSquare(self.item);
	self.item:removeFromWorld()
	self.item:removeFromSquare()
	self.item:setSquare(nil)
	inventoryItem:setWorldItem(nil)
	inventoryItem:setJobDelta(0.0);
	self.destContainer:setDrawDirty(true);
	self.destContainer:AddItem(inventoryItem);

	local pdata = getPlayerData(self.character:getPlayerNum());
	if pdata ~= nil then
		ISInventoryPage.renderDirty = true
--		pdata.playerInventory:refreshBackpacks();
--		pdata.lootInventory:refreshBackpacks();
	end
end

function ISGrabItemAction:checkQueueList()
	-- Get the last timed action in the character's queue.
	-- Reuse the action if it's an ISGrabItemAction.
	local actionQueue = ISTimedActionQueue.getTimedActionQueue(self.character)
	local lastAction = actionQueue.queue[#actionQueue.queue]
	local addTo = self
	if lastAction and (lastAction.Type == "ISGrabItemAction") then
		addTo = lastAction
	end
	local fullType = self.item:getItem():getFullType()
	-- first time we call this
	if addTo == self then
		self.queueList = {};
		local queuedItem = {items = {self.item}, time = self.maxTime, type = fullType};
		table.insert(self.queueList, queuedItem);
	else
		-- ISTimedActionQueue.add() won't add this action.
		self.ignoreAction = true;
		local typeAlreadyExist = false;
		-- we check if in our queue list an item with the same type exist, so we can transfer them in bulk
		-- limit this to 20 items (so transfer 20 per 20 nails)
		for i, v in ipairs(addTo.queueList) do
			if v.type == fullType and #v.items < 20 then
				table.insert(v.items, self.item);
				typeAlreadyExist = true;
				break;
			end
		end
		-- add the current item to our queue list
		if not typeAlreadyExist then
			table.insert(addTo.queueList, {items = {self.item}, time = self.maxTime, type = fullType});
		end
	end
end

function ISGrabItemAction:new (character, item, time)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character;
	o.item = item;
	o.stopOnWalk = true;
	o.stopOnRun = true;
	o.maxTime = time;
	o.loopedAction = true;
	o.destContainer = o.character:getInventory();
	o.started = false;
	o.transactionId = 0;
	o:checkQueueList();
	if isClient() then
        o.maxTime = -1;
        o.sourceContainer = ItemContainer.new("object", item:getSquare(), o.item)
    end
	return o
end
