--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISAddBaitAction = ISBaseTimedAction:derive("ISAddBaitAction");

function ISAddBaitAction:isValid()
	self.trap:updateFromIsoObject()
	return self.trap:getIsoObject() ~= nil
end

function ISAddBaitAction:waitToStart()
	self.character:faceThisObject(self.trap:getIsoObject())
	return self.character:shouldBeTurning()
end

function ISAddBaitAction:update()
	self.character:faceThisObject(self.trap:getIsoObject())
    self.character:setMetabolicTarget(Metabolics.LightDomestic);
end

function ISAddBaitAction:start()
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
	self:setOverrideHandModels(nil, nil)
end

function ISAddBaitAction:stop()
    ISBaseTimedAction.stop(self);
end

function ISAddBaitAction:perform()

	ISBaseTimedAction.perform(self);
end

function ISAddBaitAction:complete()
	local useAndSync = false
	local bait = self.bait
	local baitAmountMulti = bait:getHungChange();
	bait:multiplyFoodValues(1.0 - math.min(-0.05 / bait:getHungChange(), 1.0))
	if bait:getHungerChange() > -0.01 then
		useAndSync = true
	end
	baitAmountMulti = math.min(baitAmountMulti - bait:getHungChange(), 0);

	local trap = STrapSystem.instance:getLuaObjectAt(self.trap.x, self.trap.y, self.trap.z)
    if trap then
        trap:addBait(self.bait:getFullType(), self.bait:getAge(), baitAmountMulti, self.character)
    else
        print('no trap found at ', self.trap.x,',',self.trap.y,',',self.trap.z)
    end

	if useAndSync then bait:UseAndSync() end

	return true;
end

function ISAddBaitAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return 20;
end

function ISAddBaitAction:new(character, bait, trap)
	local o = ISBaseTimedAction.new(self, character)
	o.trap = trap;
    o.bait = bait;
	o.stopOnWalk = false
	o.stopOnRun = false
    o.maxTime = o:getDuration();
	return o;
end
