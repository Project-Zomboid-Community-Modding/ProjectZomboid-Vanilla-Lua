require "TimedActions/ISBaseTimedAction"

ISAddTakeDispenserBottle = ISBaseTimedAction:derive("ISAddTakeDispenserBottle");

function ISAddTakeDispenserBottle:isValid()
	return self.waterdispenser:hasComponent(ComponentType.FluidContainer) ~= bottle;
end

function ISAddTakeDispenserBottle:waitToStart()
    self.character:faceThisObject(self.waterdispenser)
    return self.character:shouldBeTurning()
end

function ISAddTakeDispenserBottle:update()
    self.character:faceThisObject(self.waterdispenser)
    self.character:setMetabolicTarget(Metabolics.HeavyDomestic);
end

function ISAddTakeDispenserBottle:start()
    self:setActionAnim("Loot")
    self.character:SetVariable("LootPosition", "Mid")
end

function ISAddTakeDispenserBottle:stop()
    ISBaseTimedAction.stop(self);
end

function ISAddTakeDispenserBottle:perform()
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISAddTakeDispenserBottle:complete()
	if not self.bottle then
		-- ADD ITEM --
		local newBottle = self.character:getInventory():AddItem("Base.WaterDispenserBottle")
		newBottle:getFluidContainer():copyFluidsFrom(self.waterdispenser:getFluidContainer())
		sendAddItemToContainer(self.character:getInventory(), newBottle);
		-- REMOVE OBJECT --
		self.square:transmitRemoveItemFromSquare(self.waterdispenser)
		self.square:RemoveTileObject(self.waterdispenser)
		-- ADD OBJECT --
		local facing = self.waterdispenser:getFacing();
		local sprite = "location_business_office_generic_01_58";
		if facing == IsoDirections.N then
			sprite = "location_business_office_generic_01_61";
		elseif facing == IsoDirections.S then
			sprite = "location_business_office_generic_01_59";		
		elseif facing == IsoDirections.W then
			sprite = "location_business_office_generic_01_60";		
		end
		local newdispenser = self.square:addWorkstationEntity("WaterDispenserNoBottle", sprite)
		newdispenser:sync()
	else
		-- REMOVE OBJECT --
		self.square:transmitRemoveItemFromSquare(self.waterdispenser)
		self.square:RemoveTileObject(self.waterdispenser)
		-- ADD OBJECT --
		local facing = self.waterdispenser:getFacing();
		local sprite = "location_business_office_generic_01_48";
		if facing == IsoDirections.N then
			sprite = "location_business_office_generic_01_57";
		elseif facing == IsoDirections.S then
			sprite = "location_business_office_generic_01_49";		
		elseif facing == IsoDirections.W then
			sprite = "location_business_office_generic_01_56";		
		end
		local newdispenser = self.square:addWorkstationEntity("WaterDispenser", sprite)
		if newdispenser and newdispenser:hasComponent(ComponentType.FluidContainer) then
			newdispenser:getFluidContainer():setInputLocked(false)
			newdispenser:getFluidContainer():copyFluidsFrom(self.bottle:getFluidContainer())
			newdispenser:getFluidContainer():setInputLocked(true)
		end
		-- transmitCompleteItemToClients has already been sent in the addWorkstationEntity function
		newdispenser:sync()
		-- REMOVE ITEM --
		sendRemoveItemFromContainer(self.character:getInventory(), self.bottle);
		self.character:getInventory():Remove(self.bottle)
	end

    return true;
end

function ISAddTakeDispenserBottle:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end
    return 30
end

function ISAddTakeDispenserBottle:new(character, waterdispenser, bottle)
    local o = ISBaseTimedAction.new(self, character)
    o.maxTime = o:getDuration();
	o.character = character;
    o.waterdispenser = waterdispenser;
	o.square = waterdispenser:getSquare();
    o.bottle = bottle;
    return o;
end
