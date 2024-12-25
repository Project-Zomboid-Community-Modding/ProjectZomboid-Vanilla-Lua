--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISTakeTrap = ISBaseTimedAction:derive("ISTakeTrap");

function ISTakeTrap:isValid()
	return self.trap:getObjectIndex() ~= -1 and self.trap:getItem() ~= nil
end

function ISTakeTrap:waitToStart()
	self.character:faceThisObject(self.trap)
	return self.character:shouldBeTurning()
end

function ISTakeTrap:update()
	self.character:faceThisObject(self.trap)

    self.character:setMetabolicTarget(Metabolics.LightDomestic);
end

function ISTakeTrap:start()
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
end

function ISTakeTrap:stop()
    ISBaseTimedAction.stop(self);
end

function ISTakeTrap:perform()

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISTakeTrap:complete()
	self.character:getInventory():AddItem(self.trap:getItem());
	sendAddItemToContainer(self.character:getInventory(), self.trap:getItem());
	self.trap:getSquare():transmitRemoveItemFromSquare(self.trap);
	self.trap:removeFromWorld();
	self.trap:removeFromSquare();

	return true;
end

function ISTakeTrap:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 50
end

function ISTakeTrap:new(character, trap, time)
	local o = ISBaseTimedAction.new(self, character)
	o.trap = trap;
	o.maxTime = o:getDuration();
	return o;
end
