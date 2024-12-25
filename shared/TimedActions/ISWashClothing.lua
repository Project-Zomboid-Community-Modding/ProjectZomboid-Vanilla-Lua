--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISWashClothing = ISBaseTimedAction:derive("ISWashClothing");

function ISWashClothing:isValid()
	if self.sink:getWaterAmount() < ISWashClothing.GetRequiredWater(self.item) then
		return false
	end
	return true
end

function ISWashClothing:update()
	self.item:setJobDelta(self:getJobDelta())
	self.character:faceThisObjectAlt(self.sink)
    self.character:setMetabolicTarget(Metabolics.HeavyDomestic);
end

function ISWashClothing:start()
	self:setActionAnim("ScrubClothWithSoap")
	self:setOverrideHandModels(getScriptManager():FindItem("Soap2"):getStaticModel(), getScriptManager():FindItem("DishCloth"):getStaticModel())
	self.sound = self.character:playSound("WashClothing")
	self.character:reportEvent("EventWashClothing");
end

function ISWashClothing:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound)
	end
end

function ISWashClothing:stop()
	self:stopSound()
	self.item:setJobDelta(0.0)
    ISBaseTimedAction.stop(self);
end

function ISWashClothing.GetSoapRemaining(soaps)
	local total = 0
	for _,soap in ipairs(soaps) do
		if instanceof(soap, "DrainableComboItem") then
			total = total + soap:getCurrentUses();
		elseif soap:getFluidContainer() and soap:getFluidContainer():contains(Fluid.CleaningLiquid) then
			total = total + (soap:getFluidContainer():getAmount() * 10);
		end
	end
	return total
end

function ISWashClothing.GetRequiredSoap(item)
	local total = 0
	if instanceof(item, "Clothing") then
		local coveredParts = BloodClothingType.getCoveredParts(item:getBloodClothingType())
		if coveredParts then
			for i=1,coveredParts:size() do
				local part = coveredParts:get(i-1)
				if item:getBlood(part) > 0 then
					total = total + 1
				end
			end
		end
	else
		if item:getBloodLevel() > 0 then
			total = total + 1
		end
	end
	return total
end

function ISWashClothing.GetRequiredWater(item)
	local blood, dirt = 0, 0
	if instanceof(item, "Clothing") then
		local coveredParts = BloodClothingType.getCoveredParts(item:getBloodClothingType())
		if coveredParts then
			for i=1,coveredParts:size() do
				local part = coveredParts:get(i-1)
				blood = blood + item:getBlood(part)
				dirt = dirt + item:getDirt(part)
			end
		end
	else
		blood = blood + item:getBloodLevel()
	end
	-- use 4 as a base amount
	return Math.ceil(4 + (blood*3) + dirt)
end

function ISWashClothing:useSoap(item, part)
	local blood = 0;
	if part then
		blood = item:getBlood(part);
	else
		blood = item:getBloodLevel();
	end
	if blood > 0 then
		for i,soap in ipairs(self.soaps) do
			if soap:hasComponent(ComponentType.FluidContainer) then
				soap:getFluidContainer():adjustAmount(soap:getFluidContainer():getAmount() - 0.1);
				return true;
			elseif soap:getCurrentUses() > 0 then
				soap:UseAndSync();
				return true;
			end
		end
	else
		return true;
	end
	return false;
end

function ISWashClothing:complete()
	local item = self.item;
	local water = ISWashClothing.GetRequiredWater(item)

	if instanceof(item, "Clothing") then
		local coveredParts = BloodClothingType.getCoveredParts(item:getBloodClothingType())
		if coveredParts then
			for j=0,coveredParts:size()-1 do
				if self.noSoap == false then
					self:useSoap(item, coveredParts:get(j));
				end
				item:setBlood(coveredParts:get(j), 0);
				item:setDirt(coveredParts:get(j), 0);
			end
		end
		item:setWetness(100);
		item:setDirtyness(0);

	else
		self:useSoap(item, nil);
	end

	item:setBloodLevel(0);

	--sync Wetness, Dirtyness, BloodLevel
	syncItemFields(self.character, item);
	syncVisuals(self.character);
	self.character:updateHandEquips();

	if self.character:isPrimaryHandItem(item) then
		self.character:setPrimaryHandItem(item);
	end
	if self.character:isSecondaryHandItem(item) then
		self.character:setSecondaryHandItem(item);
	end

	self.sink:useWater(water);

	return true;
end

function ISWashClothing:perform()
	self:stopSound()
	self.item:setJobDelta(0.0)
	
	local obj = self.sink
	if instanceof (obj, "Drainable") then
		self.obj:setUsedDelta(self.startUsedDelta + (self.endUsedDelta - self.startUsedDelta) * self:getJobDelta());
	end

	self.character:resetModel();
	triggerEvent("OnClothingUpdated", self.character);

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISWashClothing:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end

	local maxTime = ((self.bloodAmount + self.dirtAmount) * 15);
	if maxTime > 500 then
		maxTime = 500;
	end

	if self.noSoap == true then
		maxTime = maxTime * 5;
	end

	if maxTime > 800 then
		maxTime = 800;
	end

	if maxTime < 100 then
		maxTime = 100;
	end

	return maxTime;
end

function ISWashClothing:new(character, sink, soaps, item, bloodAmount, dirtAmount, noSoap)
	local o = ISBaseTimedAction.new(self, character)
	o.sink = sink;
	o.item = item;
	o.bloodAmount = bloodAmount;
	o.dirtAmount = dirtAmount;
	o.soaps = soaps;
	o.noSoap = noSoap
	o.forceProgressBar = true;
	o.maxTime = o:getDuration();

	return o;
end
