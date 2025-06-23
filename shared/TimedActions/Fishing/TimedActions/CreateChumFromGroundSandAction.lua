require "TimedActions/ISBaseTimedAction"

CreateChumFromGroundSandAction = ISBaseTimedAction:derive("CreateChumFromGroundSandAction");

function CreateChumFromGroundSandAction:isValid()
    return true
end

function CreateChumFromGroundSandAction:update()
    self.character:setMetabolicTarget(Metabolics.LightDomestic);
end

function CreateChumFromGroundSandAction:start()
    self:setActionAnim("Loot")
    self.character:SetVariable("LootPosition", "Low")
    self.sound = self.character:playSound("MakeChumBase")
end

function CreateChumFromGroundSandAction:stop()
    self:stopSound()
    ISBaseTimedAction.stop(self);
end

function CreateChumFromGroundSandAction:perform()
    self:stopSound()
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function CreateChumFromGroundSandAction:complete()
    local groundType = ISShovelGroundCursor.GetDirtGravelSand(self.square)
    if not (groundType == "sand" and self.character:isRecipeActuallyKnown("MakeChum")) then
        --noise('The action is not available')
        print('The action is not available')
        return false
    end

    local item = instanceItem("Base.Chum")
    self.character:getInventory():AddItem(item);
    sendAddItemToContainer(self.character:getInventory(), item);

    local _, o = ISShovelGroundCursor.GetDirtGravelSand(self.square)
    o:setSprite(getSprite("blends_natural_01_64"))
    o:RemoveAttachedAnims() -- remove blend tiles
    o:transmitUpdatedSpriteToClients()


    return true;
end

function CreateChumFromGroundSandAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end
    return 200
end

function CreateChumFromGroundSandAction:stopSound()
    if self.sound and self.character:getEmitter():isPlaying(self.sound) then
        self.character:stopOrTriggerSound(self.sound)
    end
end

function CreateChumFromGroundSandAction:new(character, square)
    local o = ISBaseTimedAction.new(self, character);
    o.character = character;
    o.square = square;
    o.maxTime = o:getDuration();
    return o;
end
