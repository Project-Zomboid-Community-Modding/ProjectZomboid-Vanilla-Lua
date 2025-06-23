require "ISBaseObject"

ISTransferAction = ISBaseObject:derive("ISTransferAction");

function ISTransferAction:floorHasRoomFor(square, character, item, destContainer)
	local capacity = destContainer:getEffectiveCapacity(character)
	local totalWeight = square:getTotalWeightOfItemsOnFloor()
	if totalWeight >= capacity then
		return false
	end
	if ItemContainer.floatingPointCorrection(totalWeight) + item:getUnequippedWeight() <= capacity then
		return true
	end
	-- Hack for single bag greater than 50 weight
	if item:getUnequippedWeight() >= capacity then
		return true
	end
	return false
end

function ISTransferAction:canDropOnFloor(square, character)
	if not square then
		return false
	end
	if not square:TreatAsSolidFloor() then
		return false
	end
	if square:isSolid() or square:isSolidTrans() then
		return false
	end
	local current = character:getCurrentSquare()
	if current ~= nil and square ~= current then
		if current:isBlockedTo(square) or current:isWindowTo(square) then
			return false
		end
		if current:HasStairs() ~= square:HasStairs() then
			return false
		end
		if current:HasStairs() and not current:isSameStaircase(square:getX(), square:getY(), square:getZ()) then
			return false
		end
	end
	return true
end

function ISTransferAction:getNotFullFloorSquare(character, item, destContainer)
	local square = character:getCurrentSquare()
	if ISTransferAction:canDropOnFloor(square, character) and ISTransferAction:floorHasRoomFor(square, character, item, destContainer) then
		return square
	end
	local cx = character:getX()
	local cy = character:getY()
	local cz = character:getZ()
	for dy=-1,1 do
		for dx=-1,1 do
			if dx ~= 0 or dy ~= 0 then
				square = getCell():getGridSquare(cx + dx, cy + dy, cz)
				if ISTransferAction:canDropOnFloor(square, character) and ISTransferAction:floorHasRoomFor(square, character, item, destContainer) then
					return square
				end
			end
		end
	end
	return nil
end

function ISTransferAction.GetDropItemOffset(character, square, item)
	-- local dropX = character:getX() - math.floor(character:getX())
	-- local dropY = character:getY() - math.floor(character:getY())
	local dropX = ZombRandFloat(0.0, 1.0)
	local dropY = ZombRandFloat(0.0, 1.0)
	local dropZ = character:getZ() - math.floor(character:getZ())
	dropZ = square:getApparentZ(dropX, dropY) - square:getZ()
	if character:isSeatedInVehicle() then
		dropZ = math.floor(character:getZ())
	end
	-- if (square ~= character:getCurrentSquare()) or getCore():getOptionDropItemsOnSquareCenter() then
	if getCore():getOptionDropItemsOnSquareCenter() then
		dropX = ZombRand(3, 7) / 10.0
		dropY = ZombRand(3, 7) / 10.0
		dropZ = square:getApparentZ(dropX, dropY) - square:getZ()
	end
	return dropX,dropY,dropZ
end

function ISTransferAction:removeItemOnCharacter(character, item)
	character:removeAttachedItem(item)
	if not character:isEquipped(item) then return true end
	local addToWorld = character:removeFromHands(item)
	character:removeWornItem(item, false)
	triggerEvent("OnClothingUpdated", character)
	return addToWorld
end

function ISTransferAction:transferItem(character, item, srcContainer, destContainer, dropSquare)

	if destContainer:getType() ~= "TradeUI" then
		srcContainer:DoRemoveItem(item);
		if isServer() then
			sendRemoveItemFromContainer(srcContainer, item)
		end
	end

	-- deal with containers that are floor
	if destContainer:getType() == "floor" then
		if dropSquare then
			local addToWorld = ISTransferAction:removeItemOnCharacter(character, item)
			-- might have been added by the masking system (if you have a bag equipped and drop it on ground for example)
			if addToWorld then
				destContainer:DoAddItemBlind(item)
				local dropX,dropY,dropZ = ISTransferAction.GetDropItemOffset(character, dropSquare, item)
				dropSquare:AddWorldInventoryItem(item, dropX, dropY, dropZ)
				if instanceof(item, "Radio") then
					local _obj = IsoRadio.new(getCell(), dropSquare, nil)
					local deviceData = item:getDeviceData()
					if deviceData then
						_obj:setDeviceData(deviceData)
					end
					_obj:getModData().RadioItemID = item:getID()
					dropSquare:AddSpecialObject(_obj, dropSquare:getObjects():size())
					_obj:transmitModData()
					triggerEvent("OnObjectAdded", _obj)
					dropSquare:RecalcProperties()
					dropSquare:RecalcAllWithNeighbours(true)
				end
			end
		else
			error "no square to drop item on"
		end
	elseif srcContainer:getType() == "floor" and item:getWorldItem() ~= nil then
		DesignationZoneAnimal.removeItemFromGround(item:getWorldItem())
		if instanceof(item, "Radio") then
			local grabSquare = item:getWorldItem():getSquare()
			local _obj = nil
			for i=0, grabSquare:getObjects():size()-1 do
				local tObj = grabSquare:getObjects():get(i)
				if instanceof(tObj, "IsoRadio") then
					if tObj:getModData().RadioItemID == item:getID() then
						_obj = tObj
						break
					end
				end
			end
			if _obj ~= nil then
				local deviceData = _obj:getDeviceData()
				if deviceData then
					item:setDeviceData(deviceData)
				end
				grabSquare:transmitRemoveItemFromSquare(_obj)
				grabSquare:RecalcProperties()
				grabSquare:RecalcAllWithNeighbours(true)
			end
		end

		item:getWorldItem():getSquare():transmitRemoveItemFromSquare(item:getWorldItem())
		item:getWorldItem():getSquare():removeWorldObject(item:getWorldItem())
		--item:getWorldItem():getSquare():getObjects():remove(item:getWorldItem())
		item:setWorldItem(nil)
		destContainer:AddItem(item)
	else
		if srcContainer:getType() ~= "TradeUI" then
			destContainer:AddItem(item)
		end
		if character:getInventory() ~= destContainer then
			ISTransferAction:removeItemOnCharacter(character, item)
		end
		if item:getType() == "CandleLit" then
			local candle = destContainer:AddItem("Base.Candle")
			candle:setUsedDelta(item:getCurrentUsesFloat())
			candle:setCondition(item:getCondition())
			candle:setFavorite(item:isFavorite())
			destContainer:Remove(item)
			item = candle
		end
        if item:getType() == "Lantern_HurricaneLit" then
            local candle = destContainer:AddItem("Base.Lantern_Hurricane");
            candle:setUsedDelta(self.item:getCurrentUsesFloat());
            candle:setCondition(self.item:getCondition());
            candle:setFavorite(self.item:isFavorite());
            destContainer:Remove(self.item)
            item = candle;
        end
	end

	if destContainer:getParent() and instanceof(destContainer:getParent(), "BaseVehicle") and destContainer:getParent():getPartById(destContainer:getType()) then
		local part = destContainer:getParent():getPartById(destContainer:getType())
		part:setContainerContentAmount(part:getItemContainer():getCapacityWeight())
	end

	if srcContainer:getParent() and instanceof(srcContainer:getParent(), "BaseVehicle") and srcContainer:getParent():getPartById(srcContainer:getType()) then
		local part = srcContainer:getParent():getPartById(srcContainer:getType())
		part:setContainerContentAmount(part:getItemContainer():getCapacityWeight())
	end

	return item
end
