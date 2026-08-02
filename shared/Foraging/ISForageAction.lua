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
	if isClient() then
		if forageClient and self.forageIcon then
			forageClient.showForageHalo(self.character, self.forageIcon.itemList);
		end;
		if self.manager and self.manager.forageIcons[self.iconID] then
			local icon = self.manager.forageIcons[self.iconID];
			if icon.zoneData and icon.zoneData.forageIcons then icon.zoneData.forageIcons[self.iconID] = nil; end;
			self.manager.seenIcons[self.iconID] = nil;
			self.manager:removeIcon(icon);
		end;
	elseif not isServer() then
		forageSystem.actionComplete(self.character, self.iconID)
	end
	ISBaseTimedAction.perform(self); -- remove from queue / start next.
end

function ISForageAction:complete()
	if isServer() then
		return forageServer.onPickup(self.character, self.iconID, self.targetContainer);
	end
	if isClient() then
		return true
	end

	local itemList = self.forageIcon.itemList or ArrayList.new()

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
