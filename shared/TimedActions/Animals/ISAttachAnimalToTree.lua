--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

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
	else
		self.animal:getData():setAttachedTree(self.tree);
		self.character:removeAttachedAnimal(self.animal);
		self.animal:getData():setAttachedPlayer(nil);
	end
	sendAttachAnimalToTree(self.animal, self.character, self.tree, self.remove)
	return true
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
