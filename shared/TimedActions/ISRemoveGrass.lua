--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISRemoveGrass = ISBaseTimedAction:derive("ISRemoveGrass")

function ISRemoveGrass:isValid()
    for i=0,self.square:getObjects():size()-1 do
        local object = self.square:getObjects():get(i);
        if object:getProperties() and object:getProperties():Is(IsoFlagType.canBeRemoved) then
            return true
        end
    end
    return false
end

function ISRemoveGrass:waitToStart()
	self.character:faceLocation(self.square:getX(), self.square:getY())
	return self.character:shouldBeTurning()
end

function ISRemoveGrass:update()
	self.character:faceLocation(self.square:getX(), self.square:getY())

    self.character:setMetabolicTarget(Metabolics.DiggingSpade);
end

function ISRemoveGrass:start()
	self:setActionAnim("RemoveGrass")
	self:setOverrideHandModels(nil, nil)
    self.square:playSound("RemovePlant");
	addSound(self.character, self.character:getX(), self.character:getY(), self.character:getZ(), 10, 5)
end

function ISRemoveGrass:stop()
    ISBaseTimedAction.stop(self)
end

function ISRemoveGrass:perform()
	ISBaseTimedAction.perform(self)
end

function ISRemoveGrass:complete()
    local skill = self.character:getPerkLevel(Perks.Farming)
    self.character:addBackMuscleStrain(1 - (skill * 0.05))
	local sq = self.square
	for i=sq:getObjects():size(),1,-1 do
		local object = sq:getObjects():get(i-1)
		if object:getProperties() and object:getProperties():Is(IsoFlagType.canBeRemoved) then
			sq:transmitRemoveItemFromSquare(object)
		end
	end

	local items = self.character:getInventory():AddItems("Base.GrassTuft", ZombRand(2,4));
	sendAddItemsToContainer(self.character:getInventory(), items);
	return true
end

function ISRemoveGrass:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end

	return 50
end

function ISRemoveGrass:new(character, square)
	local o = ISBaseTimedAction.new(self, character)
	o.square = square
	o.maxTime = o:getDuration()
	o.spriteFrame = 0
	return o
end
