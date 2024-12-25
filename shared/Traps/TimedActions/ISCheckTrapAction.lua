--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISCheckTrapAction = ISBaseTimedAction:derive("ISCheckTrapAction");

function ISCheckTrapAction:isValid()
	self.trap:updateFromIsoObject()
	return self.trap:getIsoObject() ~= nil;
end

function ISCheckTrapAction:update()
	self.character:faceThisObject(self.trap:getIsoObject())
    self.character:setMetabolicTarget(Metabolics.HeavyDomestic);
end

function ISCheckTrapAction:start()
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
	self:setOverrideHandModels(nil, nil)
end

function ISCheckTrapAction:stop()
    ISBaseTimedAction.stop(self);
end

function ISCheckTrapAction:perform()

	ISBaseTimedAction.perform(self);
end

function ISCheckTrapAction:complete()

	local trap = STrapSystem.instance:getLuaObjectAt(self.trap.x, self.trap.y, self.trap.z)
    if trap then
        if trap.animal.type then
            trap:removeAnimal(self.character)
        else
            print('no animal found at ', self.trap.x,',',self.trap.y,',',self.trap.z)
        end
    else
        print('no trap found at ', self.trap.x,',',self.trap.y,',',self.trap.z)
    end

	return true;
end

function ISCheckTrapAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return 40;
end

function ISCheckTrapAction:new(character, trap)
	local o = ISBaseTimedAction.new(self, character)
	o.trap = trap;
    o.stopOnWalk = false
    o.stopOnRun = false
    o.maxTime = o:getDuration();
	return o;
end
