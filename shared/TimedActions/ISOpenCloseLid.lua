--***********************************************************
--**                     SOUL FILCHER                      **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISOpenCloseLid = ISBaseTimedAction:derive("ISOpenCloseLid");

function ISOpenCloseLid:isValid()
	return true;
end

function ISOpenCloseLid:waitToStart()
	self.character:faceThisObject(self.barrel)
	return self.character:shouldBeTurning()
end

function ISOpenCloseLid:update()
	self.character:faceThisObject(self.barrel)
	self.character:setMetabolicTarget(Metabolics.HeavyDomestic);
end

function ISOpenCloseLid:start()
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Mid")
end

function ISOpenCloseLid:stop()
    ISBaseTimedAction.stop(self);
end

function ISOpenCloseLid:perform()
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISOpenCloseLid:complete()

	local name = self.barrel:getEntityScript():getName();
	local newName;
	if luautils.stringEnds(name, "Closed") then
		newName = string.gsub(name, "Closed", "");
	else
		newName = name .. "Closed";
	end
	local tempCont;
	if self.barrel:hasComponent(ComponentType.FluidContainer) then
		tempCont = self.barrel:getFluidContainer():copy();
	end
    local health = self.barrel:getHealth();
    local maxHealth = self.barrel:getMaxHealth();
	self.square:transmitRemoveItemFromSquare(self.barrel);
	self.square:RemoveTileObject(self.barrel);

	local newbarrel = self.square:addWorkstationEntity(newName, self.sprite)
	newbarrel:setMaxHealth(maxHealth);
	newbarrel:setHealth(health);
	if newbarrel and tempCont and newbarrel:hasComponent(ComponentType.FluidContainer) then
		newbarrel:getFluidContainer():copyFluidsFrom(tempCont)
		FluidContainer.DisposeContainer(tempCont)
	end
	newbarrel:sync();

    return true;
end

function ISOpenCloseLid:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end
    return 15
end

function ISOpenCloseLid:new(character, barrel, square, sprite)
    local o = ISBaseTimedAction.new(self, character)
    o.maxTime = o:getDuration();
	o.character = character
	o.barrel = barrel
	o.square = square
	o.sprite = sprite
	o.stopOnWalk = true;
	o.stopOnRun = true;
	return o;
end