--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISRemoveBaitAction = ISBaseTimedAction:derive("ISRemoveBaitAction");

function ISRemoveBaitAction:isValid()
	self.trap:updateFromIsoObject()
	return self.trap:getIsoObject() ~= nil
end

function ISRemoveBaitAction:waitToStart()
	self.character:faceThisObject(self.trap:getIsoObject())
	return self.character:shouldBeTurning()
end

function ISRemoveBaitAction:update()
	self.character:faceThisObject(self.trap:getIsoObject())
    self.character:setMetabolicTarget(Metabolics.LightDomestic);
end

function ISRemoveBaitAction:start()
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
	self:setOverrideHandModels(nil, nil)
end

function ISRemoveBaitAction:stop()
    ISBaseTimedAction.stop(self);
end

function ISRemoveBaitAction:perform()

	ISBaseTimedAction.perform(self);
end

function ISRemoveBaitAction:complete()
	local trap = STrapSystem.instance:getLuaObjectAt(self.trap.x, self.trap.y, self.trap.z)
    if trap then
        trap:removeBait(self.character)
    else
        print('no trap found at ', self.trap.x,',',self.trap.y,',',self.trap.z)
        return false;
    end

	return true;
end

function ISRemoveBaitAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return 20;
end

function ISRemoveBaitAction:new(character, trap)
	local o = ISBaseTimedAction.new(self, character)
	o.trap = trap;
	o.stopOnWalk = false
	o.stopOnRun = false
	o.maxTime = o:getDuration();
	return o;
end
