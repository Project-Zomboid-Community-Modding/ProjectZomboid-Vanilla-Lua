require "TimedActions/ISBaseTimedAction"

ISDrinkFromBottle = ISBaseTimedAction:derive("ISDrinkFromBottle");

function ISDrinkFromBottle:isValid()
	if self.item:getFluidContainer():isEmpty() then return false end
    if isClient() and self.item then
        return self.character:getInventory():containsID(self.item:getID());
    else
        return self.character:getInventory():contains(self.item);
    end
end

function ISDrinkFromBottle:update()
    self.item:setJobDelta(self:getJobDelta());
    if self.eatAudio ~= 0 and not self.character:getEmitter():isPlaying(self.eatAudio) then
        self.eatAudio = self.character:getEmitter():playSound(self.eatSound);
    end
end

function ISDrinkFromBottle:start()
    if isClient() and self.item then
        self.item = self.character:getInventory():getItemById(self.item:getID())
    end
    if self.eatSound ~= '' then
        self.eatAudio = self.character:getEmitter():playSound(self.eatSound);
    end
    if self.item:getCustomMenuOption() then
        self.item:setJobType(self.item:getCustomMenuOption())
    else
        self.item:setJobType(getText("ContextMenu_Drink"));
    end
    self.item:setJobDelta(0.0);

    self:setActionAnim(CharacterActionAnims.Drink);
    self:setOverrideHandModels(nil, self.item);
    if self.item:getEatType() then
        self:setAnimVariable("FoodType", self.item:getEatType());
        if self.item:getEatType() == "Pot" then
            self:setOverrideHandModels(self.item, nil);
        end
    else
        self:setAnimVariable("FoodType", "bottle");
    end
    self.character:reportEvent("EventEating");
end

function ISDrinkFromBottle:stop()
    if self.eatAudio ~= 0 and self.character:getEmitter():isPlaying(self.eatAudio) then
        self.character:getEmitter():stopSound(self.eatAudio);
    end
    self.item:setJobDelta(0.0);
    if self.character:getInventory():contains(self.item) then
        self:drink(self.item, self:getJobDelta());
    end
    ISBaseTimedAction.stop(self);
end

function ISDrinkFromBottle:perform()
    if self.eatAudio ~= 0 and self.character:getEmitter():isPlaying(self.eatAudio) then
        self.character:getEmitter():stopSound(self.eatAudio);
    end
    self.item:setJobDelta(0.0);
    self.item:getContainer():setDrawDirty(true);

    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISDrinkFromBottle:drink(food, percentage)
    if percentage > 0.95 then
        percentage = 1.0;
    end
    local uses = math.floor(self.uses * percentage + 0.001);

    for i=1,uses do
        if not self.character:getInventory():contains(self.item) then
            break
        end
        if self.character:getStats():isAboveMinimum(CharacterStat.THIRST) then
            self.character:getStats():remove(CharacterStat.THIRST, 0.1);
            syncPlayerStats(self.character, SyncPlayerStatsPacket.Stat_Thirst);

            if self.item:getFluidContainer():contains(Fluid.TaintedWater) then
                --tainted water shouldn't kill the player but make them sick - dangerous when sick
                local bodyDamage	= self.character:getBodyDamage();
                local stats			= self.character:getStats();
                if stats:get(CharacterStat.POISON) < 20 and stats:getSickness() < 0.3 then
					local basePoison = 10;
					if self.character:hasTrait(CharacterTrait.IRON_GUT) then
						basePoison = 5;
					end
					if self.character:hasTrait(CharacterTrait.WEAK_STOMACH) then
						basePoison = 15;
					end
					stats:set(CharacterStat.POISON, math.min(stats:get(CharacterStat.POISON) + basePoison , 20));
                    if isServer() then
                        sendDamage(self.character)
                    end
                end
            end
			if self.item:getFluidContainer() then
				local amount = self.item:getFluidContainer():getAmount() - 0.12;
				if amount < 0 then amount = 0 end;
				self.item:getFluidContainer():adjustAmount(amount);
			end
        end
    end
end

function ISDrinkFromBottle:complete()
    self:drink(self.item, 1);
    return true
end

function ISDrinkFromBottle:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end
    if self.uses < 4 then
        return 120
    end
    return self.uses * 30
end

function ISDrinkFromBottle:new (character, item, uses)
    local o = ISBaseTimedAction.new(self, character);
    o.item = item;
    o.stopOnWalk = false;
    o.stopOnRun = true;
    o.stopOnAim = false;
    o.uses = uses;
    if o.uses < 1 then
        o.uses = 1;
    end
    if not o.uses then
        o.uses = 1;
    end
    o.maxTime = o:getDuration()
    o.eatSound = "DrinkingFromBottle";
	if o.item:getFluidContainer() then
		o.eatSound = o.item:getFluidContainer():getCustomDrinkSound();
	end
    o.eatAudio = 0
    o.tick = 0;
    o.ignoreHandsWounds = true;
    o.isEating = true;
    return o
end
