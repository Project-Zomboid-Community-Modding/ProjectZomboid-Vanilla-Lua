--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISHutchCleanFloor = ISBaseTimedAction:derive("ISHutchCleanFloor");

function ISHutchCleanFloor:isValid()
    return self.hutch ~= nil and self.hutch:getHutchDirt() > 0;
end

function ISHutchCleanFloor:waitToStart()
    self.character:faceThisObject(self.tree)
    return self.character:shouldBeTurning()
end

function ISHutchCleanFloor:clean()

    if not self.water or self.water:getFluidContainer():isEmpty() then
        self.water = self.character:getInventory():getFirstWaterFluidSources(true, true)
        if not self.water then
            if isServer() then
                self.netAction:forceComplete()
            else
                self:forceStop()
            end
            return
        end
    end

    if not self.bleach or self.bleach:getFluidContainer():isEmpty() then
        self.bleach = self.character:getInventory():getFirstCleaningFluidSources()
        --[[
        if not self.bleach then
            if isServer() then
                self.netAction:forceComplete()
            else
                self:forceStop()
            end
            return
        end
        ]]
    end

    if self.hutch:getHutchDirt() == 0 then
        if isServer() then
            self.netAction:forceComplete()
        else
            self:forceStop()
        end
        return
    end

    local cleanForce = 1
    if self.bleach and not self.bleach:getFluidContainer():isEmpty() then
        cleanForce = 2
    end

    self.hutch:setHutchDirt(self.hutch:getHutchDirt() - cleanForce)
    if self.hutch:getHutchDirt() < 0 then
        self.hutch:setHutchDirt(0)
    end
    self.hutch:sync()

    self.water:getFluidContainer():removeFluid(0.01, false)
    self.water:sendSyncEntity(nil)

    if self.bleach and not self.bleach:getFluidContainer():isEmpty() then
        self.bleach:getFluidContainer():removeFluid(0.002, false)
        self.bleach:sendSyncEntity(nil)
    end
end

function ISHutchCleanFloor:update()
    self.character:faceThisObject(self.hutch)
    if not isClient() then
        self.timer = self.timer + getGameTime():getMultiplier()
        if math.floor(self.timer / self.timePerDirt) > self.lastTimer then
            self.lastTimer = math.floor(self.timer / self.timePerDirt)
            self:clean()
        end
    end
end

function ISHutchCleanFloor:start()
    self:setActionAnim("Loot")
    self.character:SetVariable("LootPosition", "Low")
    self.character:reportEvent("EventLootItem")

    --self:setOverrideHandModels(nil, "BleachBottle");
    self.sound = self.character:playSound("CleanBloodBleach")
end

function ISHutchCleanFloor:stop()
    self.character:stopOrTriggerSound(self.sound)
    ISBaseTimedAction.stop(self);
end

function ISHutchCleanFloor:perform()
    self.character:stopOrTriggerSound(self.sound)

    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISHutchCleanFloor:complete()
    self.hutch:sync()
    return true
end

function ISHutchCleanFloor:animEvent(event, parameter)
    if isServer() then
        if event == "update" then
            self:clean()
        end
    end
end

function ISHutchCleanFloor:serverStart()
    local period = self.timePerDirt * 20
    emulateAnimEvent(self.netAction, period, "update", nil)
end

function ISHutchCleanFloor:getDuration()
    --if self.character:isTimedActionInstant() then
    --    return 1
    --end
    return (self.hutch:getHutchDirt() * self.timePerDirt) + 5
end

function ISHutchCleanFloor:new(character, hutch, water, mop, bleach)
    local o = ISBaseTimedAction.new(self, character);
    o.hutch = hutch;
    o.playerInv = character:getInventory();
    o.water = water;
    o.mop = mop;
    o.bleach = bleach;
    o.timer = 0;
    o.lastTimer = 0;
    o.timePerDirt = 20;
    o.maxTime = o:getDuration()
    return o;
end
