--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISPadlockAction = ISBaseTimedAction:derive("ISPadlockAction");

function ISPadlockAction:isValid()
	return true;
end

function ISPadlockAction:update()
end

function ISPadlockAction:start()
end

function ISPadlockAction:stop()
    ISBaseTimedAction.stop(self);
end

function ISPadlockAction:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISPadlockAction:complete()
    if self.lock then
        self.thump:setLockedByPadlock(true);
        self.thump:setKeyId(self.padlock:getKeyId());
        local keys = self.character:getInventory():AddItems("Base.KeyPadlock", self.padlock:getNumberOfKey());
        for i=0,keys:size()-1 do
            keys:get(i):setKeyId(self.padlock:getKeyId());
            sendAddItemToContainer(self.character:getInventory(), keys:get(i));
        end
        self.character:getInventory():Remove(self.padlock);
        sendRemoveItemFromContainer(self.character:getInventory(), self.padlock);
        self.thump:sync()
    else
        self.thump:setLockedByPadlock(false);
        local padlock = instanceItem("Base.Padlock")
        self.character:getInventory():AddItem(padlock);
        sendAddItemToContainer(self.character:getInventory(), padlock);
        local keyToUse = self.character:getInventory():haveThisKeyId(self.thump:getKeyId());
        padlock:setNumberOfKey(1);
        padlock:setKeyId(keyToUse:getKeyId());
        keyToUse:getContainer():Remove(keyToUse);
        sendRemoveItemFromContainer(self.character:getInventory(), keyToUse);
        self.thump:setKeyId(-1);
        self.thump:sync()
    end
    if not isServer() then
        local pdata = getPlayerData(self.character:getPlayerNum())
        pdata.lootInventory:refreshBackpacks();
        pdata.playerInventory:refreshBackpacks();

    end
    return true
end

function ISPadlockAction:getDuration()
    return 20;
end

function ISPadlockAction:new(character, thump, padlock, lock)
    local o = ISBaseTimedAction.new(self, character)
	o.thump = thump;
    o.padlock = padlock;
    o.lock = lock
	o.maxTime = o:getDuration()
	return o;
end
