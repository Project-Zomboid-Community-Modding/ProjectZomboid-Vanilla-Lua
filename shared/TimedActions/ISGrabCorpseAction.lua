require "TimedActions/ISBaseTimedAction"

ISGrabCorpseAction = ISBaseTimedAction:derive("ISGrabCorpseAction");

function ISGrabCorpseAction:isValid()
    if not self.character:getSquare():canReachTo(self.corpseBody:getSquare()) then return false end
    if self.corpseBody:getStaticMovingObjectIndex() < 0 then
        return false
    end
    if isClient() then
        return true
    end
    return self.character:isDraggingCorpse() == false;
end

function ISGrabCorpseAction:waitToStart()
    self.character:faceThisObject(self.corpseBody)
    return self.character:shouldBeTurning()
end

function ISGrabCorpseAction:update()
    self.corpse:setJobDelta(self:getJobDelta());
    self.character:faceThisObject(self.corpseBody);

    self.character:setMetabolicTarget(Metabolics.MediumWork);
end

function ISGrabCorpseAction:start()
    self.corpse:setJobType(getText("ContextMenu_Grab"));
    self.corpse:setJobDelta(0.0);
    self:setActionAnim("Loot");
    self.character:SetVariable("LootPosition", "Low");
    self.character:reportEvent("EventLootItem");
    self.sound = self.character:playSound(self.corpseBody:getPickUpSound())
end

function ISGrabCorpseAction:stop()
    self:stopSound()
    self.corpse:setJobDelta(0.0);
    ISBaseTimedAction.stop(self);
end

function ISGrabCorpseAction:perform()
    self:stopSound()
    forceDropHeavyItems(self.character)
    self.corpse:setJobDelta(0.0);

    self.character:getInventory():setDrawDirty(true);

    local pdata = getPlayerData(self.character:getPlayerNum());
    if pdata ~= nil then
        pdata.playerInventory:refreshBackpacks();
        pdata.lootInventory:refreshBackpacks();
    end

    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISGrabCorpseAction:complete()
    -- so animal corpse grabbing still works!
    if self.corpse and "Base.CorpseAnimal" == self.corpse:getFullType() then
        self.character:getInventory():AddItem(self.corpse);
        sendAddItemToContainer(self.character:getInventory(), self.corpse);

        self.character:setPrimaryHandItem(self.corpse);
        self.character:setSecondaryHandItem(self.corpse);
        if isServer() then
            sendEquip(self.character)
        end

        self.corpseBody:getSquare():removeCorpse(self.corpseBody, false);
        return;
    end

    self.character:pickUpCorpse(self.corpseBody);

    return true;
end

function ISGrabCorpseAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    --return 50
    return 5
end

function ISGrabCorpseAction:stopSound()
    if self.sound and self.character:getEmitter():isPlaying(self.sound) then
        self.character:stopOrTriggerSound(self.sound);
    end
end

function ISGrabCorpseAction:new (character, corpseBody)
    local o = ISBaseTimedAction.new(self, character)
    o.corpseBody = corpseBody
    o.corpse = corpseBody:getItem();
    o.maxTime = o:getDuration();
    o.forceProgressBar = true;
    return o
end

----

local function OnContextKey(playerObj, timePressedContext)
    if playerObj:isGrappling() then
        return
    end
    if timePressedContext > 700 then
        local playerObj = getPlayer()
        local sq = playerObj:getSquare()
        local z = sq:getZ()
        local dist = 1000
        local body = nil
        for x=sq:getX()-1, sq:getX()+1 do
            for y=sq:getY()-1, sq:getY()+1 do
                local square = getCell():getGridSquare(x,y,z);
                local wobjs = square:getStaticMovingObjects()
                for i=0, wobjs:size()-1 do
                    local v = wobjs:get(i)
                    if instanceof(v, "IsoDeadBody") and not v:isAnimal() and sq:canReachTo(square) and not square:haveFire() then
                        if not (v:getStaticMovingObjectIndex() < 0) and not playerObj:isDraggingCorpse() then
                            local d = playerObj:DistToSquared(x + 0.5, y + 0.5)
                            if d < dist then
                                dist = d
                                body = v
                            end
                        end
                    end
                end
            end
        end
        if body then
            if playerObj:isSitOnGround() then
                playerObj:setVariable("forceGetUp", true)
            end
            if playerObj:getPrimaryHandItem() then
                ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getPrimaryHandItem(), 50));
            end
            if playerObj:getSecondaryHandItem() and playerObj:getSecondaryHandItem() ~= playerObj:getPrimaryHandItem() then
                ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getSecondaryHandItem(), 50));
            end
            ISTimedActionQueue.add(ISGrabCorpseAction:new(playerObj, body))
        end
    end
end

Events.OnContextKey.Add(OnContextKey)