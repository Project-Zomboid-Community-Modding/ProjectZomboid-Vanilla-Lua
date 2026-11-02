require "TimedActions/ISBaseTimedAction"

ISTakeBricks = ISBaseTimedAction:derive("ISTakeBricks");

function ISTakeBricks:isValid()
	return self.pallet:isExistInTheWorld() and self.item ~= nil;
end

function ISTakeBricks:waitToStart()
	self.character:faceThisObject(self.pallet)
	return self.character:shouldBeTurning()
end

function ISTakeBricks:update()
	self.character:faceThisObject(self.pallet)
	self.character:setMetabolicTarget(Metabolics.HeavyDomestic);
end

function ISTakeBricks:start()
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
end

function ISTakeBricks:stop()
    ISBaseTimedAction.stop(self);
end

function ISTakeBricks:perform()
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISTakeBricks:complete()
	if not self.item or not self.pallet:isExistInTheWorld() then
		return false
	end
    if self.pallet:getContainer() and not self.pallet:getContainer():isEmpty() then
        local items = self.pallet:dumpContentsInSquare();
    end
    self.pallet:getSquare():transmitRemoveItemFromSquare(self.pallet)

	local bricks = self.character:getInventory():AddItems(self.item, self.amount);
	sendAddItemsToContainer(self.character:getInventory(), bricks);

    if self.sprite then
	    local newPallet = IsoObject.new(getCell(), self.square, self.sprite);
	    self.square:AddTileObject(newPallet);
	    newPallet:transmitCompleteItemToClients()
	    self.square:RecalcProperties();
	end

    return true;
end

function ISTakeBricks:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end
    return 10 * self.amount;
end

function ISTakeBricks:new(character, pallet, square, sprite, item, amount)
    local o = ISBaseTimedAction.new(self, character)
	o.character = character;
	o.pallet = pallet;
	o.square = pallet and pallet:getSquare() or square;

	o.amount = 1
	if pallet then
		local spriteName = pallet:getSprite() and pallet:getSprite():getName()
		if spriteName == "construction_01_4" then
			o.sprite = "construction_01_5"
			o.item = "Base.ClayBrick"
			o.amount = 20
		elseif spriteName == "vegetation_farm_01_16"
			or spriteName == "vegetation_farm_01_8"
			or spriteName == "vegetation_farm_01_9"
			or spriteName == "vegetation_farm_01_17" then
			o.sprite = nil
			o.item = "Base.HayTuft"
			o.amount = 20
		elseif spriteName == "vegetation_farm_01_18"
			or spriteName == "vegetation_farm_01_10"
			or spriteName == "vegetation_farm_01_11"
			or spriteName == "vegetation_farm_01_19" then
			o.sprite = nil
			o.item = "Base.HayTuft"
			o.amount = 40
		elseif spriteName == "location_military_knox_01_1" then
			o.sprite = "location_military_knox_01_0"
			o.item = "Base.GoldBar"
			o.amount = 30
		end
	end

	o.maxTime = o:getDuration();
	o.stopOnWalk = true;
	o.stopOnRun = true;
	return o;
end
