--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

ISPickUpGroundCoverItem = ISBaseTimedAction:derive("ISPickUpGroundCoverItem")

function ISPickUpGroundCoverItem:isValid()
	return self.square:getObjects():contains(self.object)
end

function ISPickUpGroundCoverItem:waitToStart()
	self.character:faceLocation(self.square:getX(), self.square:getY())
	return self.character:shouldBeTurning()
end

function ISPickUpGroundCoverItem:update()
	self.character:faceLocation(self.square:getX(), self.square:getY())
	self.spriteFrame = self.character:getSpriteDef():getFrame()
    self.character:setMetabolicTarget(Metabolics.DiggingSpade);
end

function ISPickUpGroundCoverItem:start()
	addSound(self.character, self.character:getX(), self.character:getY(), self.character:getZ(), 20, 10)
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
	self:setOverrideHandModels(nil, nil)
end

function ISPickUpGroundCoverItem:stop()
    ISBaseTimedAction.stop(self)
end

function ISPickUpGroundCoverItem:animEvent(event, parameter)
	if event == 'Chop' then
		self.square:playSound("ChopTree");
		addSound(self.character, self.character:getX(), self.character:getY(), self.character:getZ(), 20, 1)
		if self.weapon and self.weapon:damageCheck(0,4,false) then
			ISWorldObjectContextMenu.checkWeapon(self.character)
		end
-- 		if self.weapon and ZombRand(self.weapon:getConditionLowerChance() * 4) == 0 then
-- 			self.weapon:setCondition(self.weapon:getCondition() - 1)
-- 			ISWorldObjectContextMenu.checkWeapon(self.character)
-- 		end
	end

end


function ISPickUpGroundCoverItem:perform()
    ISInventoryPage.renderDirty = true
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self)
end

function ISPickUpGroundCoverItem:complete()
	if self.objectType then
		local trashItem
		if ScriptManager.instance:getItem(self.objectType) then trashItem = self.objectType
        elseif (string.find(tostring(self.objectType), "Stones") ~= nil) then trashItem = "Base.Stone2"
		elseif self.objectType == "StoneTwigs" then trashItem = "Base.Stone2"
		elseif self.objectType == "LargeStoneTwigs" then trashItem = "Base.LargeStone"
		elseif self.objectType == "flatRock" then trashItem = "Base.FlatStone" end
		if trashItem then
			local player = self.character
			local item = instanceItem(trashItem)
			if player:getInventory():hasRoomFor(player, item) then
				player:getInventory():AddItem(item);
				sendAddItemToContainer(player:getInventory(), item);
			else
				local square = player:getCurrentSquare()
				local dropX,dropY,dropZ = ISTransferAction.GetDropItemOffset(player, square, item)
				square:SpawnWorldInventoryItem(trashItem, dropX, dropY, dropZ);
			end
		end
        if self.objectType == "StoneTwigs" or self.objectType == "LargeStoneTwigs"then
            trashItem = "Base.Twigs"
			local player = self.character
			local item = instanceItem(trashItem)
			if player:getInventory():hasRoomFor(player, item) then
				player:getInventory():AddItem(item);
				sendAddItemToContainer(player:getInventory(), item);
			else
				local square = player:getCurrentSquare()
				local dropX,dropY,dropZ = ISTransferAction.GetDropItemOffset(player, square, item)
				square:SpawnWorldInventoryItem(trashItem, dropX, dropY, dropZ);
			end
        elseif self.objectType == "Stones" then
            trashItem = "Base.Stone2"
            for i = 1, 3 do
                local player = self.character
                local item = instanceItem(trashItem)
                if player:getInventory():hasRoomFor(player, item) then
                    player:getInventory():SpawnItem(item);
                    sendAddItemToContainer(player:getInventory(), item);
                else
                    local square = player:getCurrentSquare()
                    local dropX,dropY,dropZ = ISTransferAction.GetDropItemOffset(player, square, item)
                    square:SpawnWorldInventoryItem(trashItem, dropX, dropY, dropZ);
                end
			end
		end
	end
	self.object:getSquare():transmitRemoveItemFromSquare(self.object)

	return true;
end

ISPickUpGroundCoverItem.grabItemTime2 = function(playerObj, trashItemWeight)
	local maxTime = 120;
	-- increase time for bigger objects or when backpack is more full.
	local destCapacityDelta = 1.0;
	local inv = playerObj:getInventory();
	destCapacityDelta = inv:getCapacityWeight() / inv:getMaxWeight();

	if destCapacityDelta < 0.4 then
		destCapacityDelta = 0.4;
	end

	local w = trashItemWeight
	if w > 3 then w = 3; end;
	maxTime = maxTime * (w) * destCapacityDelta;

	if getCore():getGameMode()=="LastStand" then
		maxTime = maxTime * 0.3;
	end

	if playerObj:HasTrait("Dextrous") then
		maxTime = maxTime * 0.5
	end
	if playerObj:HasTrait("AllThumbs") or playerObj:isWearingAwkwardGloves() then
		maxTime = maxTime * 2.0
	end

	if playerObj:isTimedActionInstant() then
		maxTime = 1;
	end

	return maxTime;
end

function ISPickUpGroundCoverItem:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	local maxTime = 100
	if self.objectType	then
		local trashItem
		if ScriptManager.instance:getItem(self.objectType) then trashItem = self.objectType
        elseif (string.find(tostring(self.objectType), "Stones") ~= nil) then trashItem = "Base.Stone2"
		elseif self.objectType == "StoneTwigs" then trashItem = "Base.Stone2"
		elseif self.objectType == "LargeStoneTwigs" then trashItem = "Base.LargeStone" end
		if trashItem then
			maxTime = ISPickUpGroundCoverItem.grabItemTime2(self.character, getItemActualWeight(trashItem))
-- 			ISInventoryPage.renderDirty = true
		end
	end
	return maxTime;
end

function ISPickUpGroundCoverItem:new(character, square, object)
	local objectType;
    if instanceof(object, "IsoObject") and object:getSprite()  then
        local spriteName = object:getSprite():getName() or object:getSpriteName()
        if not spriteName then
            spriteName = object:getSpriteName()
        end
        if spriteName and spriteName == ("d_generic_1_23") then
            objectType = "flatRock"
        end
    end
	local o = ISBaseTimedAction.new(self, character)
	o.square = square
	o.object = object
    local props = object:getSprite():getProperties()
    objectType = objectType or props:Is("CustomName") and props:Val("CustomName") or nil
	o.objectType = objectType;
	o.objectType = objectType;
	o.maxTime = o:getDuration()
	o.spriteFrame = 0
	return o
end
GroundCoverItems = {}
GroundCoverItems["4Stones"] = "Stone2";
GroundCoverItems["LargeStoneTwigs"] = "LargeStone";
GroundCoverItems["StoneTwigs"] = "Stone2";