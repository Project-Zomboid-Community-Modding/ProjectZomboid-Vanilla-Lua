--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISRemoveTrapAction = ISBaseTimedAction:derive("ISRemoveTrapAction");

function ISRemoveTrapAction:isValid()
	self.trap:updateFromIsoObject()
	return self.trap:getIsoObject() ~= nil
end

function ISRemoveTrapAction:waitToStart()
	self.character:faceThisObject(self.trap:getIsoObject())
	return self.character:shouldBeTurning()
end

function ISRemoveTrapAction:update()
	self.character:faceThisObject(self.trap:getIsoObject())
    self.character:setMetabolicTarget(Metabolics.HeavyDomestic);
end

function ISRemoveTrapAction:start()
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
	self:setOverrideHandModels(nil, nil)
end

function ISRemoveTrapAction:stop()
    ISBaseTimedAction.stop(self);
end

function ISRemoveTrapAction:perform()

	ISBaseTimedAction.perform(self);
end

function ISRemoveTrapAction:complete()
	local trap = STrapSystem.instance:getLuaObjectAt(self.trap.x, self.trap.y, self.trap.z)
    if trap then
        local item = instanceItem(trap.trapType)
        self.character:getInventory():AddItem(item);
        sendAddItemToContainer(self.character:getInventory(), item);
        trap:removeBait(self.character)
        trap:removeIsoObject()
    else
        print('no trap found at ', self.trap.x,',',self.trap.y,',',self.trap.z)
    end

	return true;
end

function ISRemoveTrapAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return 40;
end

function ISRemoveTrapAction:new(character, trap)
	local o = ISBaseTimedAction.new(self, character)
	o.trap = trap;
    o.stopOnWalk = false
    o.stopOnRun = false
    o.maxTime = o:getDuration();
	return o;
end
