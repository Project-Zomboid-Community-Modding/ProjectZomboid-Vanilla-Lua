--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISTakeWaterAction = ISBaseTimedAction:derive("ISTakeWaterAction");

function ISTakeWaterAction:isValid()
	if self.item and not self.item:getContainer() then return false end
	if self.fluidobject then
		return not self.waterObject:getFluidContainer():isEmpty()
	else
		return self.waterObject:hasWater()
	end
end

function ISTakeWaterAction:waitToStart()
    if self.waterObject then
        self.character:faceThisObject(self.waterObject)
    end
    return self.character:shouldBeTurning()
end

function ISTakeWaterAction:update()
    if self.item ~= nil then
        self.item:setJobDelta(self:getJobDelta());
		if self.item:getFluidContainer() then
			--local amount = self.item:getFluidContainer():getAmount() + 
			--self.item:getFluidContainer():addFluid(Fluid.Water, (0.005));
        end
    end
    if self.waterObject then
        self.character:faceThisObject(self.waterObject);
    end
end

function ISTakeWaterAction:serverStart()
    if self.item and (not self.item:hasComponent(ComponentType.FluidContainer)) and self.item:canStoreWater() and not self.item:isWaterSource() then
        -- we create the item which contain our water
        local newItemType = self.item:getReplaceType("WaterSource");
        local newItem = instanceItem(newItemType,0);
        newItem:setCondition(self.item:getCondition());
        newItem:setFavorite(self.item:isFavorite());
		newItem:setColorRed(self.item:getColorRed());
		newItem:setColorGreen(self.item:getColorGreen());
		newItem:setColorBlue(self.item:getColorBlue());
		newItem:setColor(Color.new(self.item:getColorRed(), self.item:getColorGreen(), self.item:getColorBlue()));
		newItem:setCustomColor(true);

        local container = self.item:getContainer();
        container:Remove(self.item);
        container:AddItem(newItem);
        sendReplaceItemInContainer(container, self.item, newItem)
        self.item = newItem;
    end
end

function ISTakeWaterAction:start()
    if not isClient() then
        self:serverStart()
    end
    local waterAvailable = 0;
	if self.fluidobject then
		waterAvailable = self.waterObject:getFluidContainer():getAmount();
	else
		waterAvailable = self.waterObject:getWaterAmount();
	end
    self.item = self.item;
    local props = self.waterObject:getProperties()
    local hasWaterFlag = (props ~= nil) and props:Is(IsoFlagType.water)
    local isLakeOrRiver = not instanceof(self.waterObject, "IsoWorldInventoryObject") and (props ~= nil) and luautils.stringStarts(self.waterObject:getSprite():getName(), 'blends_natural_02')
    local isPuddle = not hasWaterFlag and not isLakeOrRiver and (props ~= nil) and props:Is(IsoFlagType.solidfloor)
    if self.item ~= nil then
		self.item:setBeingFilled(true)
	    self.item:setJobType(getText("ContextMenu_Fill") .. self.item:getName());
	    self.item:setJobDelta(0.0);
        if (props ~= nil) and (props:Val("CustomName") == "Dispenser") then
            self.sound = self.character:playSound(self.item:getFillFromDispenserSound() or "GetWaterFromDispenser");
        elseif isLakeOrRiver then
            self.sound = self.character:playSound(self.item:getFillFromLakeSound() or "GetWaterFromLake");
        elseif instanceof(self.waterObject, "IsoThumpable") or hasWaterFlag or isLakeOrRiver or isPuddle then -- play the drink sound for rain barrel
            self.sound = self.character:playSound("GetWaterFromLake");
        elseif (props ~= nil) and (props:Val("CustomName") == "Toilet") then
            self.sound = self.character:playSound(self.item:getFillFromToiletSound() or "GetWaterFromToilet");
        else
            self.sound = self.character:playSound(self.item:getFillFromTapSound() or "GetWaterFromTap");
        end
	
		self:setAnimVariable("PourType", self.item:getPourType());
		self:setActionAnim("fill_container_tap");
        if self.character:isSecondaryHandItem(nil) then
            self:setOverrideHandModels(nil, self.item:getStaticModel());
        else
            self:setOverrideHandModels(self.item:getStaticModel(), nil)
        end
    else
        if self.waterObject:getProperties() and (self.waterObject:getProperties():Val("CustomName") == "Toilet") then
            self.sound = self.character:playSound("DrinkingFromToilet");
        elseif isLakeOrRiver or isPuddle then
            self.sound = self.character:playSound("DrinkingFromRiver");
        elseif instanceof(self.waterObject, "IsoThumpable") or hasWaterFlag or isLakeOrRiver then -- play the drink sound for rain barrel
            self.sound = self.character:playSound("DrinkingFromPool");
        else
            self.sound = self.character:playSound("DrinkingFromTap");
        end
	
		self:setActionAnim("drink_tap")
		self:setOverrideHandModels(nil, nil)
	end
	
	self.character:reportEvent("EventTakeWater");
end

function ISTakeWaterAction:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound);
	end
end

function ISTakeWaterAction:stop()
	self:stopSound();

    if self.item ~= nil then
		self.item:setBeingFilled(false)
        self.item:setJobDelta(0.0);
        if self.waterObject:isTaintedWater() then
            -- deprected function
--             self.item:setTaintedWater(true);
        end
    end
    ISBaseTimedAction.stop(self);
end

function ISTakeWaterAction:perform()
	self:stopSound();

    if self.item ~= nil then
        self.item:setBeingFilled(false)
        self.item:getContainer():setDrawDirty(true);
        self.item:setJobDelta(0.0);
    --Without this setUsedDelta call, the final tick never goes through.
    -- the item's UsedDelta value is set at like .99
    --This means that the option to fill that container never goes away.
    --		if self.item:getCurrentUsesFloat() > 0.91 then
    --			self.item:setUsedDelta(1.0);
    --		end
    end

    --ISTakeWaterAction.SendTakeWaterCommand(self.character, self.waterObject, self.waterUnit, newPoisonLevel)

    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISTakeWaterAction:complete()
    if instanceof(object, "IsoWorldInventoryObject") then
        self.waterObject:useWater(self.waterUnit)
    else
        if self.waterObject:useWater(self.waterUnit) > 0 then
            self.waterObject:transmitModData()
        end
    end
    local newPoisonLevel;
	if self.item then
		local fluid = Fluid.Water;
	    if self.waterObject:isTaintedWater() then
            fluid = Fluid.TaintedWater;
        end
	    if self.item:getFluidContainer() then
		    self.item:getFluidContainer():addFluid(fluid, (self.endUsedDelta - self.startUsedDelta));
	    else
            self.item:setUsedDelta(self.startUsedDelta + (self.endUsedDelta - self.startUsedDelta));
        end
        if self.waterObject and self.waterObject:getFluidContainer() then
            self.waterObject:getFluidContainer():removeFluid(self.endUsedDelta);
        end
        self.item:syncItemFields();
        sendItemStats(self.item)
    else
        local thirst = self.character:getStats():getThirst() - (self.waterUnit / 10)
        self.character:getStats():setThirst(math.max(thirst, 0.0));
        --Stat_Thirst
        syncPlayerStats(self.character, 0x00004000);

        -- Trust client in case water is tainted, since we can't compute puddles on the server side
        local isTainted = (isServer() and self.waterTaintedCL) or self.waterObject:isTaintedWater()
        if isTainted then
            --tainted water shouldn't kill the player but make them sick - dangerous when sick
            local bodyDamage	= self.character:getBodyDamage();
            local stats			= self.character:getStats();
            if bodyDamage:getPoisonLevel() < 20 and stats:getSickness() < 0.3 then
                newPoisonLevel = math.min(bodyDamage:getPoisonLevel() + 10 + self.waterUnit, 20);
                bodyDamage:setPoisonLevel(newPoisonLevel);
                sendDamage(self.character)
                --print("Player " .. tostring(self.character:getDisplayName()) .. " just drank tainted water with poison power " .. tostring(newPoisonLevel))
            end
        end
    end

    return true;
end

function ISTakeWaterAction:serverStop()
	if self.item:getFluidContainer() then
		self.item:getFluidContainer():addFluid(Fluid.Water, self.netAction:getProgress()*(self.endUsedDelta - self.startUsedDelta));
	else
		self.item:setUsedDelta(self.startUsedDelta + self.netAction:getProgress()*(self.endUsedDelta - self.startUsedDelta));
	end

    self.item:syncItemFields();
    sendItemStats(self.item)
end

function ISTakeWaterAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end

    if self.item ~= nil then
        return (self.waterUnit * 10) + 30
    else
        return (self.waterUnit * 10) + 15
    end
end

function ISTakeWaterAction:new (character, item, waterObject, waterTaintedCL)
	local o = ISBaseTimedAction.new(self, character)
	o.item = item;
    o.waterObject = waterObject;
	o.fluidobject = waterObject:hasComponent(ComponentType.FluidContainer);
    o.waterTaintedCL = waterTaintedCL;

    local waterAvailable = 0;
	if o.fluidobject then
		waterAvailable = o.waterObject:getFluidContainer():getAmount();
	else
		waterAvailable = o.waterObject:getWaterAmount();
	end
    if o.item ~= nil then
		if o.item:getFluidContainer() then
		    o.waterUnit = math.min(o.item:getFluidContainer():getFreeCapacity(), waterAvailable)
			o.startUsedDelta = o.item:getFluidContainer():getAmount();
			o.endUsedDelta = math.min(o.item:getFluidContainer():getAmount() + o.waterUnit, o.item:getFluidContainer():getCapacity());
        elseif o.item:canStoreWater() and not o.item:isWaterSource() then
            -- we create the item which contain our water
            local newItemType = o.item:getReplaceType("WaterSource");
            local newItem = getScriptManager():FindItem("Base." .. newItemType, true);
            local destCapacity = 1 / newItem:getUseDelta()
            o.waterUnit = math.min(math.ceil(destCapacity - 0.001), waterAvailable)
            o.startUsedDelta = 0
            o.endUsedDelta = math.min(o.waterUnit * newItem:getUseDelta(), 1.0)
        else
            local destCapacity = (1 - o.item:getCurrentUsesFloat()) / o.item:getUseDelta()
            o.waterUnit = math.min(math.ceil(destCapacity - 0.001), waterAvailable)
            o.startUsedDelta = o.item:getCurrentUsesFloat()
            o.endUsedDelta = math.min(o.item:getCurrentUsesFloat() + o.waterUnit * o.item:getUseDelta(), 1.0)
        end

    else
        local thirst = o.character:getStats():getThirst()
        local waterNeeded = math.min(math.ceil(thirst / 0.1), 10)
        o.waterUnit = math.min(waterNeeded, waterAvailable)
        o.startUsedDelta = 0.0
        o.endUsedDelta = math.min(0.0 + o.waterUnit * 0.1, 1.0)
    end

	o.maxTime = o:getDuration()
	return o
end
