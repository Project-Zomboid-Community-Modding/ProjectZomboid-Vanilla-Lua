--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISWaterPlantAction = ISBaseTimedAction:derive("ISWaterPlantAction");

function ISWaterPlantAction:isValid()
	local plant = CFarmingSystem.instance:getLuaObjectOnSquare(self.sq)
	if not plant or plant.waterLvl >= 100 then return false end
	if isClient() and self.item then
	    if not self.character:getInventory():containsID(self.item:getID()) then return false end
	else
	    if not self.character:getInventory():contains(self.item) then return false end
	end
	if ISFarmingMenu.getWaterUsesInteger(self.item) == 0 then return false end

	return true;
end

function ISWaterPlantAction:waitToStart()
	self.character:faceLocation(self.sq:getX(), self.sq:getY())
	return  self.character:isTurning() or self.character:shouldBeTurning()
end

function ISWaterPlantAction:update()
    local progress = self:getJobDelta() - (self.usesUsed * self.deltaPerUse)
    if progress >= self.deltaPerUse and self.uses > 0 and ISFarmingMenu.getWaterUsesInteger(self.item) > 0 then
--     if progress >= self.deltaPerUse and self.usesUsed < self.uses and self.item:getCurrentUsesFloat() >= self.item:getUseDelta() then
        local args = { x = self.sq:getX(), y = self.sq:getY(), z = self.sq:getZ(), uses = 1 }
        CFarmingSystem.instance:sendCommand(self.character, 'water', args)
        self.uses = self.uses - 1
        self.usesUsed = self.usesUsed + 1
--         self.item:setUsedDelta(self.item:getCurrentUsesFloat() - self.item:getUseDelta())
        self:useItemOneUnit()
    end

	self.item:setJobDelta(self:getJobDelta());
	self.character:faceLocation(self.sq:getX(), self.sq:getY())
    self.character:setMetabolicTarget(Metabolics.LightWork);
end

function ISWaterPlantAction:start()
    if isClient() and self.item then
        self.item = self.character:getInventory():getItemById(self.item:getID())
    end
	self.item:setJobType(getText("ContextMenu_Water"));
	self.item:setJobDelta(0.0);
    self:setActionAnim(CharacterActionAnims.Pour);
    self:setAnimVariable("PourType", self.item:getPourType());
    self:setOverrideHandModels(self.item, nil);

	self.sound = self.character:playSound("WaterCrops");
end

function ISWaterPlantAction:stop()
	if self.sound and self.sound ~= 0 then
		self.character:getEmitter():stopOrTriggerSound(self.sound)
	end
	self.item:setJobDelta(0.0);
	ISBaseTimedAction.stop(self);
-- 	local leftUses =math.floor(self.item:getCurrentUsesFloat()/self.item:getUseDelta())
-- 	self.item:setUsedDelta(leftUses * self.item:getUseDelta())
end

function ISWaterPlantAction:perform()
	if self.sound and self.sound ~= 0 then
		self.character:getEmitter():stopOrTriggerSound(self.sound)
	end

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISWaterPlantAction:complete()
    if self.item then
        self.item:setJobDelta(0.0);
    end
    -- we check for the watering item's existence, just in case it has already been used up.
    if self.item and self.uses > 0 then
        if self.item:getContainer() then
            self.item:getContainer():setDrawDirty(true);
        end
--         self.item:setJobDelta(0.0);
        -- 	local args = { x = self.sq:getX(), y = self.sq:getY(), z = self.sq:getZ(), uses = self.uses }
        -- 	CFarmingSystem.instance:sendCommand(self.character, 'water', args)

        -- Hack: use the water, too hard to get the server to update the client's inventory
        local plant = SFarmingSystem.instance:getLuaObjectOnSquare(self.sq)
        local waterLvl = plant.waterLvl
        local uses = self.uses
        --         local uses = self.uses - self.usesUsed

        if uses > 0 then
            plant:water(nil, uses);

            for i=1,uses do
                if(waterLvl < 100) then
                    self:useItemOneUnit()
                    waterLvl = waterLvl + 10
                    if(waterLvl > 100) then
                        waterLvl = 100
                    end
                end
            end
        end
    end

    return true;
end

function ISWaterPlantAction:getDuration()
    return self.maxTime;
end

function ISWaterPlantAction:useItemOneUnit()
    if self.item:hasComponent(ComponentType.FluidContainer) then
        local fluidContainer = self.item:getFluidContainer()
        if fluidContainer then
            local use = ISFarmingMenu.getFluidContainerMillilitresPerUse() / 1000
            fluidContainer:adjustAmount(fluidContainer:getAmount() - use)
        end
        return
    end
    if self.item:IsDrainable() then
        if self.item:getCurrentUsesFloat() > 0 then
--            self.item:setUsedDelta(self.item:getCurrentUsesFloat() - self.item:getUseDelta())
            self.item:UseAndSync()
        end
    end
end

function ISWaterPlantAction:new(character, item, uses, sq, maxTime)
	local o = ISBaseTimedAction.new(self, character);
	o.character = character;
	o.item = item;
	o.uses = uses;
	o.usesUsed = 0;
	o.maxTime = maxTime;
	o.deltaPerUse = 1.0 / uses;
	if character:isTimedActionInstant() then
		o.maxTime = 1;
	end
    o.sq = sq;
	return o;
end
