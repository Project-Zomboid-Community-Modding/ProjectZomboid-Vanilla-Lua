--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISPadlockByCodeAction = ISBaseTimedAction:derive("ISPadlockByCodeAction");

function ISPadlockByCodeAction:isValid()
	return true;
end

function ISPadlockByCodeAction:update()
end

function ISPadlockByCodeAction:start()
end

function ISPadlockByCodeAction:stop()
    ISBaseTimedAction.stop(self);
end

function ISPadlockByCodeAction:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISPadlockByCodeAction:complete()
    if self.lock then
        self.character:getInventory():Remove(self.padlock);
        sendRemoveItemFromContainer(self.character:getInventory(), self.padlock);
        self.thump:setLockedByCode(self.code);
    else
        if self.thump:getLockedByCode() == self.code then
            self.thump:setLockedByCode(0);
            local padlock = instanceItem("Base.CombinationPadlock")
            self.character:getInventory():AddItem(padlock);
            sendAddItemToContainer(self.character:getInventory(), padlock);
        end
    end
    if not isServer() then
        local pdata = getPlayerData(self.character:getPlayerNum())
        pdata.lootInventory:refreshBackpacks();
        pdata.playerInventory:refreshBackpacks();
    end
    return true
end

function ISPadlockByCodeAction:getDuration()
    return 20;
end

function ISPadlockByCodeAction:new(character, thump, padlock, lock, code)
    local o = ISBaseTimedAction.new(self, character)
	o.thump = thump;
    o.padlock = padlock;
    o.lock = lock
    o.code = code
	o.maxTime = o:getDuration()
	return o;
end
