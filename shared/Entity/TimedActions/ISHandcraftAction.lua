--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISHandcraftAction = ISBaseTimedAction:derive("ISHandcraftAction");

function ISHandcraftAction:isValid()
	if self.craftBench then
		if (not self.isoObject) or (not self.isoObject:isUsingPlayer(self.character)) then
			return false;
		end
	end
	if (not self.craftRecipe) then
		return false;
	end
	return true;
end

function ISHandcraftAction:update()

    if self.actionScript and self.actionScript:hasMuscleStrain() then
        self.actionScript:applyMuscleStrain(self.character)
    end

    if self.items then
		for i=0,self.items:size()-1 do
-- 	        self.items:get(i):setJobDelta(self:getJobDelta());
		    local item = self.items:get(i)
	        if item then
	            item:setJobDelta(self:getJobDelta());
            end
        end
    end

    if self.actionScript then
        self.character:setMetabolicTarget(self.actionScript:getMetabolics());

        if self.isoObject and self.actionScript:isFaceObject() then
            self.character:faceThisObject(self.isoObject);
        end
    end
    -- sitting stuff
    if self.actionScript and self.actionScript:isCantSit() == true and self.character:isSitOnGround() then
        self.character:setSitOnGround(false)
    end
end

function ISHandcraftAction:serverStart()
	self.logic = HandcraftLogic.new(self.character, self.craftBench, self.isoObject);
	self.logic:setContainers(self.containers);
	self.logic:setRecipe(self.craftRecipe);
end

function ISHandcraftAction:start()
	--log(DebugType.CraftLogic, "ISHandcraftAction.start")
	self.logic = HandcraftLogic.new(self.character, self.craftBench, self.isoObject);
	self.logic:setContainers(self.containers);
	self.logic:setRecipe(self.craftRecipe);
	if self.manualInputs then
		self.logic:setManualSelectInputs(true);

		--log(DebugType.CraftLogic, "-= reading manual inputs =-")
		for inputIndex, items in pairs(self.manualInputs) do
			local inputScript = self.craftRecipe:getIOForIndex(inputIndex);
			if (not inputScript) or (not self.logic:setManualInputsFor(inputScript, items)) then
				log(DebugType.CraftLogic, "ISHandcraftAction.start -> failed to set manual input items for recipe.")
			end
		end

		if not self.force and not self.logic:canPerformCurrentRecipe() then
			log(DebugType.CraftLogic, "ISHandcraftAction.start -> canPerformCurrentRecipe failed.")
			self:forceStop();
			return;
		end
	end

	if not self.items then
		-- populate with what recipe has now filled
		if self.logic:getRecipeData() then
			self.items = self.logic:getRecipeData():getAllInputItems()
		end
	end
	
	if self.items then
		for i=0,self.items:size()-1 do
			local item = self.items:get(i)
			if item then
				item:setJobDelta(0.0);
				item:setJobType(self.craftRecipe:getTranslationName())
			end
		end
	end
	
    if self.actionScript then
        self:setActionAnim(self.actionScript:getActionAnim());
        if self.actionScript:getAnimVarKey() then
            self:setAnimVariable(self.actionScript:getAnimVarKey(), self.actionScript:getAnimVarVal());
        end
		if self.actionScript:getSound() then
			self.sound = self.character:playSound(self.actionScript:getSound());
		end
    end

    -- sitting stuff
    if self.actionScript and self.actionScript:isCantSit() == true and self.character:isSitOnGround() then
        self.character:setSitOnGround(false)
    end

    self:setOverrideHandModels(self.logic:getModelHandOne(), self.logic:getModelHandTwo());

	if self.onStartFunc then
		self.onStartFunc(self.onStartTarget, self);
	end
end

function ISHandcraftAction:stop()
	--log(DebugType.CraftLogic, "ISHandcraftAction.stop")

    if self.items then
		for i=0,self.items:size()-1 do
		    local item = self.items:get(i)
	        if item then
	            item:setJobDelta(0.0);
            end
        end
    end
    ISBaseTimedAction.stop(self);
	
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound);
	end
	
	if self.onCancelFunc then
		self.onCancelFunc(self.onCancelTarget);
	end

	if self.onCompleteFunc then
		self.onCompleteFunc(self.onCompleteTarget);
	end
end

function ISHandcraftAction:perform()
	--log(DebugType.CraftLogic, "ISHandcraftAction.perform")
	-- spurcival - moved here as subsequent crafts were starting before this craft was finalised
	if not isClient() then
		if self.items then
			for i=0,self.items:size()-1 do
				local item = self.items:get(i)
				if item then
					item:setJobDelta(0.0);
				end
			end
		end
		if self.logic then
			if self.logic:performCurrentRecipe() then
				-- perform succeeded
				local items = ArrayList.new();
				self.logic:getCreatedOutputItems(items);

				for i=0,items:size()-1 do
					local item = items:get(i);
					Actions.addOrDropItem(self.character, item)
				end
			end
		end

		if self.onCompleteFunc then
			self.onCompleteFunc(self.onCompleteTarget);
		end
	end
	-- /spurcival

	ISBaseTimedAction.perform(self);
	
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound);
	end

	ISInventoryPage.dirtyUI();

	if isClient() and self.onCompleteFunc then
		self.onCompleteFunc(self.onCompleteTarget);
	end
end
--[[ -- spurcival - this code has been moved to perform()
function ISHandcraftAction:complete()
    if self.items then
		for i=0,self.items:size()-1 do
		    local item = self.items:get(i)
	        if item then
	            item:setJobDelta(0.0);
            end
        end
    end
	if self.logic then
		if self.logic:performCurrentRecipe() then
			-- perform succeeded
			local items = ArrayList.new();
			self.logic:getCreatedOutputItems(items);

			for i=0,items:size()-1 do
				local item = items:get(i);
				Actions.addOrDropItem(self.character, item)
			end
		end
	end

	if self.onCompleteFunc then
		self.onCompleteFunc(self.onCompleteTarget);
	end
	return true
end
]]--
--ADDED A MULTIPLIER TO THE BASE TIME VALUE
function ISHandcraftAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	if not self.craftRecipe then
		return -1;
	end
	return self.craftRecipe:getTime() * 5;
end

function ISHandcraftAction:setOnStart(_func, _target)
	self.onStartFunc = _func;
	self.onStartTarget = _target;
end

function ISHandcraftAction:setOnComplete(_func, _target)
	self.onCompleteFunc = _func;
	self.onCompleteTarget = _target;
end

function ISHandcraftAction:setOnCancel(_func, _target)
	self.onCancelFunc = _func;
	self.onCancelTarget = _target;
end

function ISHandcraftAction.FromLogicMultiple(handcraftLogic)
	log(DebugType.CraftLogic, "Creating handcraft action from logic, manual = "..tostring(handcraftLogic:isManualSelectInputs()))
	local character = handcraftLogic:getPlayer();
	local isoObject = handcraftLogic:getIsoObject();
	local craftBench = handcraftLogic:getCraftBench();
	local containers = handcraftLogic:getContainers();
	local craftRecipe = handcraftLogic:getRecipe();
	local manualInputs = false;
	if handcraftLogic:isManualSelectInputs() then
		manualInputs = {};
		local inputScripts = craftRecipe:getInputs();
		for i=0,inputScripts:size()-1 do
			local inputScript = inputScripts:get(i);
			if inputScript:getResourceType()==ResourceType.Item then
				local inputIndex = craftRecipe:getIndexForIO(inputScript);
				manualInputs[inputIndex] = handcraftLogic:getMulticraftConsumedItemsFor(inputScript, ArrayList.new());
			end
		end
	end

	local action = ISHandcraftAction:new(character, craftRecipe, containers, isoObject, craftBench, manualInputs, nil);

	return action;
end

function ISHandcraftAction.FromLogic(handcraftLogic)
	log(DebugType.CraftLogic, "Creating handcraft action from logic, manual = "..tostring(handcraftLogic:isManualSelectInputs()))
	local character = handcraftLogic:getPlayer();
	local isoObject = handcraftLogic:getIsoObject();
	local craftBench = handcraftLogic:getCraftBench();
    local containers = handcraftLogic:getContainers();
	local craftRecipe = handcraftLogic:getRecipe();
	local manualInputs = false;
	if handcraftLogic:isManualSelectInputs() then
		manualInputs = {};
		local inputScripts = craftRecipe:getInputs();
		for i=0,inputScripts:size()-1 do
			local inputScript = inputScripts:get(i);
			if inputScript:getResourceType()==ResourceType.Item then
				local inputIndex = craftRecipe:getIndexForIO(inputScript);
				manualInputs[inputIndex] = handcraftLogic:getManualInputsFor(inputScript, ArrayList.new());
			end
		end
	end
	local items
	if handcraftLogic:getRecipeData() then
	    items = handcraftLogic:getRecipeData():getAllInputItems()
-- 		for i=0,items:size()-1 do
-- 		    local item = items:get(i)
-- 	        if item then
-- 			    item:setJobType(craftRecipe:getTranslationName())
--             end
--         end
	end

	local action = ISHandcraftAction:new(character, craftRecipe, containers, isoObject, craftBench, manualInputs, items);

	return action;
end

function ISHandcraftAction:new(character, craftRecipe, containers, isoObject, craftBench, manualInputs, items)
	log(DebugType.CraftLogic, "Creating handcraft action")
	local o = ISBaseTimedAction.new(self, character);

	o.stopOnAim = false;
	o.character = character;
	o.isoObject = isoObject;
	o.craftBench = craftBench; -- may be nil, if not nil the craftbench is a component of the supplied isoObject.
    o.containers = containers;
	o.manualInputs = manualInputs; -- a non-ordered key,value table where key=integer index of InputScript, and value=ArrayList of InventoryItem's.
	o.craftRecipe = craftRecipe;
	o.actionScript = o.craftRecipe and o.craftRecipe:getTimedActionScript();
	--o.usesCustomDelta = true;
-- 	log(DebugType.CraftLogic, tostring(craftRecipe:getName()) .. " - can walk " .. tostring(craftRecipe:isCanWalk()))
	o.stopOnWalk = not craftRecipe:isCanWalk();
	if character and (character:HasTrait("AllThumbs") or character:isWearingAwkwardGloves()) then
	    o.stopOnWalk = true;
    end
-- 	o.stopOnWalk = true;
	o.stopOnRun = true;
	o.maxTime = o:getDuration();

	o.items = items;
	return o
end