require "Foraging/forageSystem";
require "TimedActions/ISBaseTimedAction";
ISForageAction = ISBaseTimedAction:derive("ISForageAction");

function ISForageAction:isValid()
	if not self.forageIcon.square and self.character:getSquare() then return false; end; --ensure the icon and players have a valid square, or can walk there as it may not be loaded.
	if self.forageIcon.square:isBlockedTo(self.character:getSquare()) then return false; end; --ensure character can reach and see the item
	return true;
end

function ISForageAction:waitToStart()
    self.character:faceLocation(self.forageIcon.square:getX(), self.forageIcon.square:getY());
	return self.character:shouldBeTurning();
end

function ISForageAction:update()
    self.character:faceLocation(self.forageIcon.square:getX(), self.forageIcon.square:getY())
	self.character:setMetabolicTarget(Metabolics.LightWork);
end

function ISForageAction:stop()
	ISBaseTimedAction.stop(self);
end

function ISForageAction:start()
	self.action:setUseProgressBar(false);
    self:setActionAnim("Forage");
    self:setOverrideHandModels(nil, nil);
	self.character:playSound("ForagingPickup")
end

function ISForageAction:perform()
	if not isClient() then
        forageSystem.actionComplete(self.character, self.iconID)
    end
	ISBaseTimedAction.perform(self); -- remove from queue / start next.
end

function ISForageAction:complete()
	-- add the items to player inventory
	local itemList
	if isServer() then
		itemList = ArrayList.new()
		for _, data in pairs(self.itemDataList) do
			local item = instanceItem(data.type)
			if instanceof(item, "Food") then
				item:setPoisonPower(data.poisonPower)
				item:setPoisonDetectionLevel(data.poisonDetectionLevel)
			end
			itemList:add(item)
		end
        sendServerCommand(self.character, 'forage', 'complete', { iconID = self.iconID })
	else
		itemList = self.forageIcon.itemList or ArrayList.new()
	end

	forageSystem.addOrDropItems(self.character, self.targetContainer, itemList)

	return true
end

function ISForageAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end;
    return 50;
end

function ISForageAction:new(character, iconID, itemDataList, targetContainer, itemType)
	local o = ISBaseTimedAction.new(self, character);
	o.targetContainer = targetContainer;
	o.itemType = itemType;
	o.itemDataList = itemDataList;
	--
	if not isServer() then
		o.manager = ISSearchManager.getManager(character);
		o.forageIcon = o.manager.forageIcons[iconID];
		o.zoneData = o.forageIcon.zoneData;
	end;
    o.iconID = iconID;
	o.itemDef = forageSystem.itemDefs[o.itemType];
	--
    o.stopOnWalk = false;
    o.stopOnRun = true;
	o.maxTime = o:getDuration();
	o.currentTime = 0;
	o.started = false;
	--
	return o;
end
