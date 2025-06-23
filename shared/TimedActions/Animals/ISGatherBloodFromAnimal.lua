--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISGatherBloodFromAnimal = ISBaseTimedAction:derive("ISGatherBloodFromAnimal");

function ISGatherBloodFromAnimal:isValid()
	if isClient() then
		if self.started then
			return true;
		end

		if not ButcheringUtil.isHookUsingSameCharacter(self.hook, self.character) then
			return false;
		end
	end

	return self.body ~= nil and self.body:getModData()["BloodQty"] and self.body:getModData()["BloodQty"] > 0;
end

function ISGatherBloodFromAnimal:waitToStart()
	if self.hook then
		self.character:faceThisObject(self.hook)
	elseif self.body and self.body:isExistInTheWorld() then
		self.character:faceThisObject(self.body)
	end
	return self.character:shouldBeTurning()
end

function ISGatherBloodFromAnimal:updateBucket()
	self.lastTimer = math.floor(self.timer / self.timePerLiter);
	local rest = self.body:getModData()["BloodQty"];
	if rest > self.literPerTick then
		rest = self.literPerTick;
	end
	-- add possible blood on character
	if ZombRand(20 + (self.perkLevel * 3)) then
		self.character:addBlood(nil, true, false, false);
		syncVisuals(self.character);
	end
	self.bucket:getFluidContainer():addFluid(FluidType.AnimalBlood, rest);
	self.bucket:sendSyncEntity(nil);
	self.body:getModData()["BloodQty"] = self.body:getModData()["BloodQty"] - rest;
	if self.luaHook then
		self.luaHook:updateCorpseDatas();
	else
		ButcheringUtil.updateCorpseDatas({ }, self.body, self.hook);
	end
	if self.body:getModData()["BloodQty"] <= 0 then
		self.body:getModData()["BloodQty"] = 0;
		if self.bucket then
			self.bucket:setJobDelta(0.0);
		end
	end
	if self.bucket:getFluidContainer():isFull() then
		if self.bucket then
			self.bucket:setJobDelta(0.0);
		end
		self.bucket = self.character:getInventory():getFirstAvailableFluidContainer("AnimalBlood");
	end
	if not self.bucket or not self.body:getModData()["BloodQty"] or self.body:getModData()["BloodQty"] == 0 then
		if isServer() then
			self.netAction:forceComplete()
		else
			self:forceStop()
		end
		return;
	end
end

function ISGatherBloodFromAnimal:update()
	if self.hook then
		self.character:faceThisObject(self.hook)
	elseif self.body and self.body:isExistInTheWorld() then
		self.character:faceThisObject(self.body)
	end

	if self.bucket then
		self.bucket:setJobDelta(self:getJobDelta());
	end

	if not isClient() then
		self.timer = self.timer + getGameTime():getMultiplier();
		if math.floor(self.timer / self.timePerLiter) > self.lastTimer then
			self:updateBucket();
		end
	end

	-- update the hook UI
	if self.luaHook then
		self.luaHook.doingAction = true;
		self.luaHook.actionText = getText("IGUI_Animal_GatheringBlood");
		self.luaHook:updateProgressBar(self:getJobDelta());
	end
end

function ISGatherBloodFromAnimal:start()
	self:setActionAnim("Loot")
	self.luaHook.hook:setPlayRemovingBloodSound(true)
	--self.character:SetVariable("LootPosition", "Low")

	if self.bucket then
		self.bucket:setJobType(getText("IGUI_Animal_GatheringBlood"));
	end

	self.character:reportEvent("EventLootItem")
	self.started = true;
end

function ISGatherBloodFromAnimal:serverStart()
	if not self.hook:getUsingPlayer() then
		ButcheringUtil.setUsingPlayerForHook(self.hook, self.character);
	end

	local period = self.timePerLiter * 20;
	emulateAnimEvent(self.netAction, period, "update", nil)
end

function ISGatherBloodFromAnimal:serverStop()
	if ButcheringUtil.isHookUsingSameCharacter(self.hook, self.character) then
		ButcheringUtil.setUsingPlayerForHook(self.hook, nil);

		self.hook:startRemovingBlood(nil);
	end
end

function ISGatherBloodFromAnimal:animEvent(event, parameter)
	if isServer() then
		if event == "update" then
			self:updateBucket();
		end
	end
end

function ISGatherBloodFromAnimal:forceStop()
	if self.luaHook then
		self.luaHook.hook:setPlayRemovingBloodSound(false)
		self.luaHook.doingAction = false;
	end

	if self.bucket then
		self.bucket:setJobDelta(0.0);
	end

	if not isClient() then
		self.hook:startRemovingBlood(self.luaHook);
	end

	ISBaseTimedAction.stop(self);
end

function ISGatherBloodFromAnimal:stop()
	if self.luaHook then
		self.luaHook.hook:setPlayRemovingBloodSound(false)
		self.luaHook.doingAction = false;
	end

	if self.bucket then
		self.bucket:setJobDelta(0.0);
	end

	if not isClient() then
		self.hook:startRemovingBlood(self.luaHook);
	end

	ISBaseTimedAction.stop(self);
end

function ISGatherBloodFromAnimal:perform()
	if self.luaHook then
		self.luaHook.doingAction = false;
		self.luaHook:updateCorpseDatas();
	end

	if self.bucket then
		self.bucket:setJobDelta(0.0);
	end

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISGatherBloodFromAnimal:complete()
	if not ButcheringUtil.isHookUsingSameCharacter(self.hook, self.character) then
		return false;
	end

	if self.luaHook then
		self.luaHook.doingAction = false;
		self.luaHook:updateCorpseDatas();
	else
		ButcheringUtil.updateCorpseDatas({ }, self.body, self.hook);
	end

	if self.bucket then
		self.bucket:setJobDelta(0.0);
	end

	self.hook:startRemovingBlood(self.luaHook);

	ButcheringUtil.setUsingPlayerForHook(self.hook, nil);

	return true
end

function ISGatherBloodFromAnimal:getDuration()
	local animalBlood = self.body:getModData()["BloodQty"];
	--local bucketSpace = self.bucket:getFluidContainer():getCapacity();
	local buckets;
	if self.luaHook then
		buckets = self.luaHook:getBuckets();
	else
		buckets = ButcheringUtil.getBuckets(self.character);
	end

	local totalBucketSpace = 0;
	for i=0,buckets:size()-1 do
		totalBucketSpace = totalBucketSpace + (buckets:get(i):getFluidContainer():getCapacity() - buckets:get(i):getFluidContainer():getAmount());
	end
	local amountToGet = animalBlood;
	if totalBucketSpace < amountToGet then
		amountToGet = totalBucketSpace;
	end

	return 2 + (amountToGet * self.timePerLiter * (1/self.literPerTick));
end

function ISGatherBloodFromAnimal:new(character, body, hook, luaHookUI, bucket)
	local o = ISBaseTimedAction.new(self, character)
	o.body = body;
	o.hook = hook;
	o.luaHook = luaHookUI;
	o.bucket = bucket;
	o.timePerLiter = 30;
	o.literPerTick = 0.5;
	o.timer = 0;
	o.lastTimer = 0;
	o.animalDef = ButcheringUtil.getAnimalDef(body:getTypeAndBreed())
	o.perkLevel = character:getPerkLevel(Perks.Butchering);
	o.xp = o.animalDef.xpPerItem;
	o.maxTime = o:getDuration()
	return o;
end
