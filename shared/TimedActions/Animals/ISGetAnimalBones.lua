--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISGetAnimalBones = ISBaseTimedAction:derive("ISGetAnimalBones");

function ISGetAnimalBones:isValid()
	return self.body ~= nil and self.body:isAnimalSkeleton();
end

function ISGetAnimalBones:waitToStart()
	self.character:faceThisObject(self.body)
	return self.character:shouldBeTurning()
end

function ISGetAnimalBones:update()
	self.character:faceThisObject(self.animal)
end

function ISGetAnimalBones:start()
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
	self.character:reportEvent("EventLootItem")
	self.sound = self.character:playSound("ButcheringGatherBones")
end

function ISGetAnimalBones:stop()
	self:stopSound();
    ISBaseTimedAction.stop(self);
end

function ISGetAnimalBones:perform()
	self:stopSound();
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISGetAnimalBones:complete()
	--local invItem = instanceItem(self.body:getCorpseItem());
	--if invItem then
		--invItem:setWeight(self.body:getWeight() * self.body:getMeatRatio())
		--invItem:setActualWeight(invItem:getWeight())
		--self.body:getSquare():AddWorldInventoryItem(invItem, 0, 0, 0);
	--else
	--	print("Tried to butcher animal, ", self.body:getCorpseItem(), "is not a valid carcass item")
	--end

	--self.body:removeFromWorld();
	--self.body:removeFromSquare();

	ButcheringUtil.butcherAnimalFromGround(self.body, self.character);

	--sendButcherAnimal(self.body, self.character)

	return true
end

function ISGetAnimalBones:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 150
end

function ISGetAnimalBones:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:getEmitter():stopOrTriggerSound(self.sound);
	end
end

function ISGetAnimalBones:new(character, body)
	local o = ISBaseTimedAction.new(self, character)
	o.body = body;
	o.maxTime = o:getDuration()
	return o;
end
