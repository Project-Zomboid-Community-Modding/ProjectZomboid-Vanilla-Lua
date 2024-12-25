--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISCraftAction = ISBaseTimedAction:derive("ISCraftAction");

function ISCraftAction:isValid()
    if isClient() and self.character and self.item then
        self.item = self.character:getInventory():getItemById(self.item:getID())
    end
	--fixme: when crafting multiple items, we can lose the original item
	if self.item and self.item:getContainer() == nil then
		self.item = nil;
	end;
	return RecipeManager.IsRecipeValid(self.recipe, self.character, self.item, self.containers) and not self.character:isDriving();
end

function ISCraftAction:update()
    if self.item then
	    self.item:setJobDelta(self:getJobDelta());
        -- players that aren't desensitized gain mild stress and unhappiness from stripping items from corpses
        if self.character and ( not self.character:getTraits():contains("Desensitized") ) and self.item:getContainer() and self.item:getContainer():getType() and ( self.item:getContainer():getType() == "inventoryfemale" or self.item:getContainer() == "inventorymale" ) then
            local rate =  getGameTime():getMultiplier()
            if self.character:getTraits():contains("Cowardly") then rate = rate*2
--             if self.character:getTraits():contains("Cowardly") or self.character:getTraits():contains("Hemophobic") then rate = rate*2
            elseif self.character:getTraits():contains("Brave") then rate = rate/2 end
            local stats = self.character:getStats()
            stats:setStress(stats:getStress() + rate/10000);
            local bodyDamage = self.character:getBodyDamage()
            bodyDamage:setUnhappynessLevel(bodyDamage:getUnhappynessLevel()  + rate/100);
        end
        -- characters that are scared of blood gain stress from bloody items
        if self.character and self.character:getTraits():contains("Hemophobic") and self.item:getBloodLevel() > 0 then
            local rate =  self.item:getBloodLevelAdjustedLow() * getGameTime():getMultiplier()
            local stats = self.character:getStats()
            stats:setStress(stats:getStress() + rate/10000);
        end
		--fixme: when crafting multiple items, we can lose the original item
		if (self.item:getContainer() == nil) then
			self.item = nil;
		end
	end
	self.character:setMetabolicTarget(Metabolics.UsingTools);
end

function ISCraftAction:start()
	showDebugInfoInChat("CRAFT \'"..self.recipe:getOriginalname().."\'")
	if self.recipe:getSound() then
		self.craftSound = self.character:playSound(self.recipe:getSound());
	end
	self.item:setJobType(self.recipe:getName());
	self.item:setJobDelta(0.0);
	if self.recipe:getProp1() or self.recipe:getProp2() then
		self:setOverrideHandModels(self:getPropItemOrModel(self.recipe:getProp1()), self:getPropItemOrModel(self.recipe:getProp2()))
	end
	if self.recipe:getAnimNode() then
		self:setActionAnim(self.recipe:getAnimNode());
	else
		self:setActionAnim(CharacterActionAnims.Craft);
	end
	--fixme: when crafting multiple items, we can lose the original item
	if self.item and self.item:getContainer() == nil then
		self.item = nil;
	end
end

function ISCraftAction:stop()
	if self.craftSound and self.character:getEmitter():isPlaying(self.craftSound) then
		self.character:stopOrTriggerSound(self.craftSound);
	end
	if self.item ~= nil then
		self.item:setJobDelta(0.0);
	end
	ISBaseTimedAction.stop(self);
end

function ISCraftAction:perform()
	if self.craftSound and self.character:getEmitter():isPlaying(self.craftSound) then
		self.character:stopOrTriggerSound(self.craftSound);
	end
	if self.item then
		self.item:setJobDelta(0.0);
	end

	ISInventoryPage.dirtyUI()

	if self.onCompleteFunc then
		local args = self.onCompleteArgs
		self.onCompleteFunc(args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8])
	end

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISCraftAction:complete()

	local fromFloor = false;
	if self.container:getType() == "floor" then
		fromFloor = true;
	end

	local list = RecipeManager.PerformMakeItem(self.recipe, self.item, self.character, self.containers);

	if list then
		for i=0,list:size()-1 do
			local item = list:get(i);
			if fromFloor then
				self.character:getCurrentSquare():AddWorldInventoryItem(item,
						self.character:getX() - math.floor(self.character:getX()) + ZombRandFloat(0.1,0.5),
						self.character:getY() - math.floor(self.character:getY()) + ZombRandFloat(0.1,0.5),
						self.character:getZ() - math.floor(self.character:getZ()))
				self.container:AddItem(item)
			else
				Actions.addOrDropItem(self.character, item)
			end
		end
	end

	return true
end

function ISCraftAction:getPropItemOrModel(propStr)
	if not propStr then return nil end
	if propStr == "" then return nil end
	if not propStr:contains("Source=") then return propStr end
	local sourceIndex = tonumber(propStr:sub(propStr:find("=") + 1))
	if not sourceIndex or (sourceIndex < 1) or (sourceIndex > self.recipe:getSource():size()) then return nil end
	local items = RecipeManager.getSourceItemsNeeded(self.recipe, sourceIndex - 1, self.character, self.containers, self.item, nil, nil)
	if items:isEmpty() then return nil end
	-- It would be best to use the item instead of the model, so any blood/etc appears as expected.
	-- But things like flashlights have animation masks which break the "Dismantle Flashlight" animation, for example.
	-- So return the model name instead of the item.  Returning the item does work, though.
	return items:get(0):getStaticModel()
end

function ISCraftAction:setOnComplete(func, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
	self.onCompleteFunc = func
	self.onCompleteArgs = { arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 }
end

function ISCraftAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	local additionalTime = 0
	if self.container == self.character:getInventory() and self.recipe:isCanBeDoneFromFloor() then
		local items = RecipeManager.getAvailableItemsNeeded(self.recipe, self.character, self.containers, self.item, nil)
		for i=1,items:size() do
			local item = items:get(i-1)
			if item:getContainer() ~= self.character:getInventory() then
				local w = item:getActualWeight()
				if w > 3 then w = 3; end;
				additionalTime = additionalTime + 50*w
			end
		end
	end
	return self.recipe:getTimeToMake() + additionalTime
end

--fixme: item passed when crafting "all" is always the first selected item, this action will not show a progress bar on the items after the first is consumed
function ISCraftAction:new(character, item, recipe, container, containersIn)
	local o = ISBaseTimedAction.new(self, character)
	o.item = item;
	o.recipe = recipe;
	o.container = container;
	o.containersIn = containersIn;
	o.containers = recipe:isCanBeDoneFromFloor() and containersIn or nil;
	o.stopOnWalk = recipe:isStopOnWalk();
	o.stopOnRun = recipe:isStopOnRun();
	o.maxTime = o:getDuration();
	o.jobType = recipe:getName();
	o.forceProgressBar = true;
	return o;
end
