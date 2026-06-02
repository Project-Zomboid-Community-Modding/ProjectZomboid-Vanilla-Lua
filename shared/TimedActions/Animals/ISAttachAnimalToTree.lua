require "TimedActions/ISBaseTimedAction"

ISAttachAnimalToTree = ISBaseTimedAction:derive("ISAttachAnimalToTree");

function ISAttachAnimalToTree:isValid()
	return self.character:getSquare():DistTo(self.tree:getSquare()) <= 2;
end

function ISAttachAnimalToTree:waitToStart()
	self.character:faceThisObject(self.tree)
	return self.character:shouldBeTurning()
end

function ISAttachAnimalToTree:update()
	self.character:faceThisObject(self.tree)
end

function ISAttachAnimalToTree:start()
	self:setActionAnim("Loot")
	self.character:reportEvent("EventLootItem")
	if self.remove then
		self.sound = self.character:playSound("DetachRopeTree")
	else
		self.sound = self.character:playSound("AttachRopeTree")
	end
end

function ISAttachAnimalToTree:stop()
    self.character:stopOrTriggerSound(self.sound)
    ISBaseTimedAction.stop(self);
end

function ISAttachAnimalToTree:perform()
    self.character:stopOrTriggerSound(self.sound)

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISAttachAnimalToTree:complete()
	if self.remove then
		self.animal:getData():setAttachedTree(nil);
		self:takeRope()
		self.character:getAttachedAnimals():add(self.animal);
		self.animal:getData():setAttachedPlayer(self.character);
	else
		self.animal:getData():setAttachedTree(self.tree);
		self.character:removeAttachedAnimal(self.animal);
		self.animal:getData():setAttachedPlayer(nil);
		self:attachRope()
	end
	return true
end

function ISAttachAnimalToTree:takeRope()
	if self.character:isAnimalCheat() then return end
	local item = self.character:getInventory():AddItem("Base.Rope")
	if item == nil then return end
	sendAddItemToContainer(self.character:getInventory(), item)
end

function ISAttachAnimalToTree:attachRope()
	if self.character:isAnimalCheat() then return end
	local item = self:getRopeToRemoveFromInventory()
	if item == nil then return end
	sendRemoveItemFromContainer(self.character:getInventory(), item)
	self.character:getInventory():Remove(item)
end

function ISAttachAnimalToTree:getRopeToRemoveFromInventory()
	if self.character:getAttachedAnimals():isEmpty() then
		return self.character:getPrimaryHandItem() or self:getRopeNotInHand()
	end
	return self:getRopeNotInHand()
end

function ISAttachAnimalToTree:getRopeNotInHand(ropes)
	local ropes = self.character:getInventory():getAllType("Base.Rope")
	for i=1,ropes:size() do
		local item = ropes:get(i-1)
		if not self.character:isPrimaryHandItem(item) then
			return item
		end
	end
	return nil
end

function ISAttachAnimalToTree:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 30
end

function ISAttachAnimalToTree:new(character, animal, tree, remove)
	local o = ISBaseTimedAction.new(self, character)
	o.animal = animal;
	o.remove = remove;
	o.tree = tree;
	o.maxTime = o:getDuration();
	return o;
end
