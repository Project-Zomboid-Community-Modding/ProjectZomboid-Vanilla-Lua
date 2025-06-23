--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISMilkAnimal = ISBaseTimedAction:derive("ISMilkAnimal");

function ISMilkAnimal:isValid()
	return self.character:getSquare():DistTo(self.animal:getSquare()) < 3;
end

function ISMilkAnimal:waitToStart()
	self.character:faceThisObject(self.animal)
	return self.character:shouldBeTurning()
end

function ISMilkAnimal:stress()

	-- stress can make the animal break from the milking
	if self.animal:getStress() > 40 and self.character:getPerkLevel(Perks.Husbandry) <= 7 then
		local chance = self.animal:getStress();
		chance = chance - (self.character:getPerkLevel(Perks.Husbandry) * 5); -- skill make it happen less often

		-- acceptance lower this possibility
		chance = chance - (self.animal:getAcceptanceLevel(self.character) * 5);
		chance = 120;

		if ZombRand(100) < chance then

			-- extra stress the animal!
			self.animal:changeStress((ZombRand(3, 8) / 5));

			local sq;
			-- make the animal flee somewhere
			if self.animal:getDZone() then
				sq = self.animal:getRandomSquareInZone();
			end
			if not sq then
				sq = getSquare(ZombRand(self.animal:getSquare():getX() - 5, self.animal:getSquare():getX() + 5), ZombRand(self.animal:getSquare():getY() - 5, self.animal:getSquare():getY() + 5), self.animal:getSquare():getZ());
			end
			self.animal:fleeTo(sq);

			-- if the bucket has milk, spill it!
			self.bucket:getFluidContainer():removeFluid();

			-- put the bucket on the ground
			self.character:getInventory():Remove(self.bucket);
			sendRemoveItemFromContainer(self.character:getInventory(), self.bucket);
			self.animal:getSquare():AddWorldInventoryItem(self.bucket, 0,0,0);
			self.character:getInventory():setDrawDirty(true);

			self.animal:playStressedSound();
			return true;
		end
	end

	return false;
end

function ISMilkAnimal:milk()

	-- too much stress, we stop
	if self:stress() then
		if isServer() then
			self.netAction:forceComplete()
		else
			self:forceStop()
		end
		return
	end

	-- no available container, we stop
	if not self.bucket or self.bucket:getFluidContainer():isFull() then
		--print("checking for another bucket")
		if self.bucket then
			self.bucket:setJobDelta(0.0);
		end
		-- look for any other container than can have milk if we selected "All"
		if self.all then
			--print("all selected")
			self.bucket = self.character:getInventory():getFirstAvailableFluidContainer(self.animal:getData():getBreed():getMilkType())
		end
		-- else we look for any type of this container (ex. you have 2 empty bucket and one half full, and you selected an empty bucket to fill, we look for any other bucket once this one is full)
		if self.bucket then
			--print("looking for my new bucket: ", self.bucket:getFullType())
			local list = self.character:getInventory():getItemsFromFullType(self.bucket:getFullType());
			for i=0,list:size()-1 do
				local newBucket = list:get(i);
				if not newBucket:getFluidContainer():isFull() then
					self.bucket = newBucket;
					break;
				end
			end
		end
		if not self.bucket or self.bucket:getFluidContainer():isFull() then
			--print("no bucket or full", self.bucket)
			if isServer() then
				self.netAction:forceComplete()
			else
				self:forceStop()
			end
			return
		end
	end

	-- no more milk, we stop
	if self.animal:getData():getMilkQuantity() < 0.1 then
		if self.bucket then
			self.bucket:setJobDelta(0.0);
		end
		if isServer() then
			self.netAction:forceComplete()
		else
			self:forceStop()
		end
		return
	end

	self.animal:milkAnimal(self.character, self.bucket)
	self.bucket:sendSyncEntity(nil)
end

function ISMilkAnimal:update()
	self.character:setIsAiming(false);
	self.character:faceThisObject(self.animal)
	if self.bucket then
		self.bucket:setJobDelta(self:getJobDelta());
	end

	if not isClient() then
		self.timer = self.timer + getGameTime():getMultiplier();
		if math.floor(self.timer / self.timePerLiter) > self.lastTimer then
			self.lastTimer = math.floor(self.timer / self.timePerLiter);
			self:milk()
		end
	end
end

function ISMilkAnimal:start()
	forceDropHeavyItems(self.character)
	self:setOverrideHandModels(nil, nil)
	self.character:setVariable("milkanimalout", false)
	self.character:setVariable("AnimalSizeX", 0.01);
	local range = self.animal:getData():getMaxSize() - self.animal:getData():getMinSize()
	local current = self.animal:getData():getSize() - self.animal:getData():getMinSize()
	if current <= 0.001 then
		current = 0.001;
	end
	self.character:setVariable("AnimalSizeY", current/range);

	if self.bucket then
		self.bucket:setJobType(getText("ContextMenu_Milk"));
		self.bucket:setJobDelta(0.0);
	end

	self.animal:getBehavior():setBlockMovement(true);
	self.character:setVariable("milkanimal", true)
	self.character:setVariable("milkAnim", self.milkAnim)
	self.sound = self.character:playSound("MilkAnimal")
end

function ISMilkAnimal:forceStop()
	self.character:setVariable("milkanimalout", true)
	self.animal:getBehavior():setBlockMovement(false);
	if self.bucket then
		self.bucket:setJobDelta(0.0);
	end
	self.action:forceStop();
end

function ISMilkAnimal:stop()
	self:stopSound()
	self.character:setVariable("milkanimalout", true)
	self.animal:getBehavior():setBlockMovement(false);
	if self.bucket then
		self.bucket:setJobDelta(0.0);
	end
    ISBaseTimedAction.stop(self);
end

function ISMilkAnimal:perform()
	self:stopSound()
--	self.bucket = self.animal:milkAnimal(self.character, self.bucket);

	self.character:setVariable("milkanimalout", true)
	self.animal:getBehavior():setBlockMovement(false);
	if self.bucket then
		self.bucket:setJobDelta(0.0);
	end

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISMilkAnimal:complete()
	return true
end

function ISMilkAnimal:animEvent(event, parameter)
	if isServer() then
		if event == "update" then
			self:milk()
			sendServerCommandV("animal", "setMilk",
					"id", self.animal:getOnlineID(),
					"value", self.animal:getData():getMilkQuantity())
		end
	end
end

function ISMilkAnimal:serverStart()
	local period = self.timePerLiter * 20
	emulateAnimEvent(self.netAction, period, "update", nil)
end

function ISMilkAnimal:getDuration()
	--if self.character:isTimedActionInstant() then
	--	return 1
	--end
	--local maxMilk = self.animal:getData():getMilkQuantity();
	--if self.bucket:getFluidContainer():getFreeCapacity() < maxMilk then
	--	maxMilk = self.bucket:getFluidContainer():getFreeCapacity();
	--end
	--if self.bucket:getMaxMilk() > 0 and maxMilk > (self.bucket:getMaxMilk() - self.bucket:getMilkQty()) then
	--	maxMilk = (self.bucket:getMaxMilk() - self.bucket:getMilkQty()) + 1;
	--end
	--	print(bucket, bucket:getMilkReplaceItem())
	--if self.bucket:getMilkReplaceItem() then
	--
	--	local newBucket = instanceItem(self.bucket:getMilkReplaceItem());
	--	if newBucket and newBucket:getMaxMilk() > 0 and maxMilk > newBucket:getMaxMilk() then
	--		maxMilk = newBucket:getMaxMilk();
	--	end
	--end

	--local maxQuantity = self.animal:getData():getMilkQuantity()
	--local maxCapacity = self.character:getInventory():getAvailableFluidContainersCapacity(self.animal:getData():getBreed():getMilkType());
	--local milkMl = math.floor(math.min(maxQuantity, maxCapacity))
	--self.timePerLiter = self.timePerLiter - (self.character:getPerkLevel(Perks.Husbandry) * 2)
	--print("milk ml", milkMl, "max qqty: ",self.animal:getData():getMilkQuantity(), "max capacity", maxCapacity, "time per litter", self.timePerLiter)
	--print("get duration", (math.max((milkMl * self.timePerLiter), self.timePerLiter) + 5) * 10)
	--return (math.max((milkMl * self.timePerLiter), self.timePerLiter) + 5) * 10
	return -1;
end

function ISMilkAnimal:stopSound()
    if self.sound and self.character:getEmitter():isPlaying(self.sound) then
        self.character:stopOrTriggerSound(self.sound);
    end
end

function ISMilkAnimal:new(character, animal, bucket, right, all)
	local o = ISBaseTimedAction.new(self, character);
	o.animal = animal;
	o.bucket = bucket;
	o.all = all;
	o.timePerLiter = 40;
	o.timer = 0;
	o.lastTimer = 0;
	local leftorright = "L";
	if right then
		leftorright = "R";
	end
	o.milkAnim = animal:getMilkAnimPreset() .. leftorright .. "In";
	o.maxTime = o:getDuration()
	o.stopOnAim = false;
	return o;
end
