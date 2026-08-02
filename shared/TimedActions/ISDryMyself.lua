require "TimedActions/ISBaseTimedAction"

ISDryMyself = ISBaseTimedAction:derive("ISDryMyself");

local MAX_USES = 10
local TICKS_TO_MILLIS = 10

function ISDryMyself:isValid()
	if isClient() then
		if self.started then
			return self.character:getStats():get(CharacterStat.WETNESS) > 0;
		elseif self.item then
			return self.character:getInventory():containsID(self.item:getID()) and self.character:getStats():get(CharacterStat.WETNESS) > 0 and self.item:getCurrentUsesFloat() > 0
		end
    else
        return self.character:getInventory():contains(self.item) and self.character:getStats():get(CharacterStat.WETNESS) > 0 and self.item:getCurrentUsesFloat() > 0;
    end
end

function ISDryMyself:update()
    if not isClient() then
        if getTimeInMillis() - self.lastUse >= self.useDelay then
            self.lastUse = getTimeInMillis()
            self:useAndDry(false)
        end
    end
    self.character:setMetabolicTarget(Metabolics.LightDomestic);
end

function ISDryMyself:useAndDry(isSyncNeeded)
    self.character:getBodyDamage():decreaseBodyWetness( self.character:getStats():get(CharacterStat.WETNESS) / MAX_USES )
    if isSyncNeeded then
        sendDamage(self.character)
        self.item:UseAndSync()
    else
        self.item:Use()
    end
end

function ISDryMyself:start()
	if isClient() and self.item then
		self.item = self.character:getInventory():getItemById(self.item:getID())
	end

	self.started = true
end

function ISDryMyself:stop()
    ISBaseTimedAction.stop(self);
end

function ISDryMyself:perform()
	self.started = false;
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISDryMyself:complete()
	return true
end

function ISDryMyself:serverStart()
    emulateAnimEvent(self.netAction, self.useDelay, "serverTick", nil)
end

function ISDryMyself:animEvent(event, parameter)
    if isServer() and self.item and event == "serverTick" then
        if self.item:getCurrentUses() > 0 then
            self:useAndDry(true)
        else
			self.netAction:forceComplete()
        end
    end
end

function ISDryMyself:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 200
end

function ISDryMyself:new(character, item)
	local o = ISBaseTimedAction.new(self, character)
	o.item = item;
	o.maxTime = o:getDuration();
	o.lastUse = 0
	o.useDelay = o.maxTime * TICKS_TO_MILLIS / MAX_USES
    o.caloriesModifier = 4;
	return o;
end
