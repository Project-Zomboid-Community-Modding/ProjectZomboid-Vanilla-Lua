--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISWashYourself = ISBaseTimedAction:derive("ISWashYourself");

function ISWashYourself:isValid()
	return true;
end

function ISWashYourself:update()
	self.character:faceThisObjectAlt(self.sink)
    self.character:setMetabolicTarget(Metabolics.LightDomestic);
end

function ISWashYourself:start()
	self:setActionAnim("WashFace")
	self:setOverrideHandModels(nil, nil)
	self.sound = self.character:playSound("WashYourself")
	self.character:reportEvent("EventWashClothing");
end

function ISWashYourself:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound)
	end
end

function ISWashYourself:stop()
	self:stopSound()
    ISBaseTimedAction.stop(self);
end

function ISWashYourself:washPart(visual, part)
	if visual:getBlood(part) + visual:getDirt(part) <= 0 then
		return false
	end
	if visual:getBlood(part) > 0 then
		-- Soap is used for blood but not for dirt.
		for _,soap in ipairs(self.soaps) do
			if soap:getCurrentUses() > 0 then
				soap:UseAndSync()
				break
			end
		end
	end
	visual:setBlood(part, 0)
	visual:setDirt(part, 0)
	return true
end

function ISWashYourself:removeAllMakeup()
	local item = self.character:getWornItem("MakeUp_FullFace");
	self:removeMakeup(item);
	item = self.character:getWornItem("MakeUp_Eyes");
	self:removeMakeup(item);
	item = self.character:getWornItem("MakeUp_EyesShadow");
	self:removeMakeup(item);
	item = self.character:getWornItem("MakeUp_Lips");
	self:removeMakeup(item);
end

function ISWashYourself:removeMakeup(item)
	if item then
		self.character:removeWornItem(item);
		self.character:getInventory():Remove(item);
	end
end

function ISWashYourself.GetRequiredSoap(character)
	local units = 0
	local visual = character:getHumanVisual()
	for i=1,BloodBodyPartType.MAX:index() do
		local part = BloodBodyPartType.FromIndex(i-1)
		-- Soap is used for blood but not for dirt.
		if visual:getBlood(part) > 0 then
			units = units + 1
		end
	end
	return units
end

function ISWashYourself.GetRequiredWater(character)
	local units = 0
	local visual = character:getHumanVisual()
	for i=1,BloodBodyPartType.MAX:index() do
		local part = BloodBodyPartType.FromIndex(i-1)
		if visual:getBlood(part) + visual:getDirt(part) > 0 then
			units = units + 1
		end
	end
	return units
end

function ISWashYourself:perform()
	self:stopSound()
	self.character:resetModelNextFrame();
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISWashYourself:complete()
	local visual = self.character:getHumanVisual()
	local waterUsed = 0
	for i=1,BloodBodyPartType.MAX:index() do
		local part = BloodBodyPartType.FromIndex(i-1)
		if self:washPart(visual, part) then
			waterUsed = waterUsed + 1
			-- using soap provides a modest happiness boost
			if self.soaps then
				self.character:getBodyDamage():setUnhappynessLevel(self.character:getBodyDamage():getUnhappynessLevel() - 2);
			end
			if waterUsed >= self.sink:getFluidAmount() then
				break
			end
		end
	end

	--triggerEvent("OnClothingUpdated", self.character)

	-- remove makeup
	self:removeAllMakeup()

	--sendVisual(self.character);
	sendHumanVisual(self.character);

	if instanceof(self.sink, "IsoWorldInventoryObject") then
		self.sink:useFluid(waterUsed)
	else
		if self.sink:useFluid(waterUsed) > 0 then
			self.sink:transmitModData()
		end
	end

	return true
end

function ISWashYourself:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	local waterUnits = math.min(ISWashYourself.GetRequiredWater(self.character), self.sink:getFluidAmount());
	if not self.soaps then
		return waterUnits * 126;
	else
		return waterUnits * 70;
	end
end

function ISWashYourself:new(character, sink, soaps)
	local o = ISBaseTimedAction.new(self, character)
	o.sink = sink;
	o.soaps = soaps;
	o.useSoap = (ISWashYourself.GetRequiredSoap(character) <= ISWashClothing.GetSoapRemaining(soaps))
	o.maxTime = o:getDuration();
	o.forceProgressBar = true;
	return o;
end
