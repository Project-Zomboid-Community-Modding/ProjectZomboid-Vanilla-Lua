--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISRemoveBurntVehicle = ISBaseTimedAction:derive("ISRemoveBurntVehicle")

local function predicateBlowTorch(item)
	return (item ~= nil) and
		(item:hasTag("BlowTorch") or item:getType() == "BlowTorch") and
		(item:getCurrentUses() >= 10)
end

function ISRemoveBurntVehicle:isValid()
	if not predicateBlowTorch(self.character:getPrimaryHandItem()) then
		return false
	end
	return self.vehicle and not self.vehicle:isRemovedFromWorld();
end

function ISRemoveBurntVehicle:update()
	self.character:faceThisObject(self.vehicle)
	self.item:setJobDelta(self:getJobDelta())
	self.item:setJobType(getText("ContextMenu_RemoveBurntVehicle"))

	if self.sound ~= 0 and not self.character:getEmitter():isPlaying(self.sound) then
		self.sound = self.character:playSound("BlowTorch")
	end

    self.character:setMetabolicTarget(Metabolics.HeavyWork);
end

function ISRemoveBurntVehicle:start()
    self:serverStart()
	self:setActionAnim("BlowTorch")
	self:setOverrideHandModels(self.item, nil)
	self.sound = self.character:playSound("BlowTorch")
end

function ISRemoveBurntVehicle:serverStart()
	self.item = self.character:getPrimaryHandItem()
end

function ISRemoveBurntVehicle:stop()
	if self.item then
		self.item:setJobDelta(0)
	end
	if self.sound ~= 0 then
		self.character:getEmitter():stopSound(self.sound)
	end
	ISBaseTimedAction.stop(self)
end

function ISRemoveBurntVehicle:perform()
	if self.sound ~= 0 then
		self.character:getEmitter():stopSound(self.sound)
	end
	self.item:setJobDelta(0);
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISRemoveBurntVehicle:complete()
	local totalXp = 5;
	for i=1,math.max(5,self.character:getPerkLevel(Perks.MetalWelding)) do
        -- removed due to render issues
-- 		if self:checkAddItem("BrokenGlass", 12) then totalXp = totalXp + 1 end;
-- 		if self:checkAddItem("BrokenGlass", 12) then totalXp = totalXp + 1 end;

		if self:checkAddItem("AluminumScrap", 12) then totalXp = totalXp + 1 end;
		if self:checkAddItem("AluminumScrap", 12) then totalXp = totalXp + 1 end;

		if self:checkAddItem("CopperScrap", 12) then totalXp = totalXp + 1 end;
		if self:checkAddItem("CopperScrap", 12) then totalXp = totalXp + 1 end;

		if self:checkAddItem("ElectricWire", 25) then totalXp = totalXp + 1 end;
		if self:checkAddItem("ElectricWire", 25) then totalXp = totalXp + 1 end;

        if self:checkAddItem("EngineParts", 25) then totalXp = totalXp + 1 end;
        if self:checkAddItem("EngineParts", 25) then totalXp = totalXp + 1 end;

		if self:checkAddItem("IronBand", 25) then totalXp = totalXp + 1 end;
		if self:checkAddItem("IronBand", 25) then totalXp = totalXp + 1 end;
--
		if self:checkAddItem("IronBandSmall", 15) then totalXp = totalXp + 1 end;
		if self:checkAddItem("IronBandSmall", 15) then totalXp = totalXp + 1 end;

		if self:checkAddItem("IronScrap", 12) then totalXp = totalXp + 1 end;
		if self:checkAddItem("IronScrap", 12) then totalXp = totalXp + 1 end;

		if self:checkAddItem("MetalBar", 15) then totalXp = totalXp + 1 end;
		if self:checkAddItem("MetalBar", 15) then totalXp = totalXp + 1 end;

		if self:checkAddItem("MetalPipe", 15) then totalXp = totalXp + 1 end;
		if self:checkAddItem("MetalPipe", 15) then totalXp = totalXp + 1 end;

		if self:checkAddItem("NutsBolts", 25) then totalXp = totalXp + 1 end;
		if self:checkAddItem("NutsBolts", 25) then totalXp = totalXp + 1 end;

		if self:checkAddItem("ScrapMetal", 12) then totalXp = totalXp + 1 end;
		if self:checkAddItem("ScrapMetal", 12) then totalXp = totalXp + 1 end;

		if self:checkAddItem("Screws", 25) then totalXp = totalXp + 1 end;
		if self:checkAddItem("Screws", 25) then totalXp = totalXp + 1 end;

		if self:checkAddItem("SheetMetal", 25) then totalXp = totalXp + 1 end;
		if self:checkAddItem("SheetMetal", 25) then totalXp = totalXp + 1 end;

		if self:checkAddItem("SmallSheetMetal", 15) then totalXp = totalXp + 1 end;
		if self:checkAddItem("SmallSheetMetal", 15) then totalXp = totalXp + 1 end;

        if self:checkAddItem("SteelBar", 25) then totalXp = totalXp + 1 end;
        if self:checkAddItem("SteelBar", 25) then totalXp = totalXp + 1 end;

        if self:checkAddItem("SteelBarHalf", 15) then totalXp = totalXp + 1 end;
        if self:checkAddItem("SteelBarHalf", 15) then totalXp = totalXp + 1 end;

        if self:checkAddItem("SteelBarQuarter", 12) then totalXp = totalXp + 1 end;
        if self:checkAddItem("SteelBarQuarter", 12) then totalXp = totalXp + 1 end;

        if self:checkAddItem("SteelBlock", 25) then totalXp = totalXp + 1 end;
        if self:checkAddItem("SteelBlock", 25) then totalXp = totalXp + 1 end;

        if self:checkAddItem("SteelChunk", 15) then totalXp = totalXp + 1 end;
        if self:checkAddItem("SteelChunk", 15) then totalXp = totalXp + 1 end;

        if self:checkAddItem("SteelPiece", 12) then totalXp = totalXp + 1 end;
        if self:checkAddItem("SteelPiece", 12) then totalXp = totalXp + 1 end;

		if self:checkAddItem("Wire", 25) then totalXp = totalXp + 1 end;
		if self:checkAddItem("Wire", 25) then totalXp = totalXp + 1 end;
	end
	for i=1,10 do
		self.item:Use(false, false, true);
	end
	addXp(self.character, Perks.MetalWelding, totalXp);
    if self.vehicle then
        self.vehicle:permanentlyRemove()
    else
        print('no such vehicle id=',self.vehicle:getId())
        return false
    end
    return true
end

function ISRemoveBurntVehicle:checkAddItem(item, baseChance)
    local skillLevel = self.character:getPerkLevel(Perks.MetalWelding)

    if item == "EngineParts" then
        skillLevel = math.min(self.character:getPerkLevel(Perks.Mechanics), skillLevel)
    end

	if ZombRand(baseChance-skillLevel) == 0 then
		self.vehicle:getSquare():AddWorldInventoryItem(item, ZombRandFloat(0,0.9), ZombRandFloat(0,0.9), 0);
		return true;
    elseif ZombRand(baseChance-self.character:getPerkLevel(Perks.MetalWelding)) == 0 then
        local itemType = nil

        if item == "AluminumScrap" then itemType = "AluminumFragments"
        elseif item == "EngineParts" then itemType = "IronScrap"
        elseif item == "IronBand" then itemType = "IronScrap "
        elseif item == "IronBandSmall" then itemType = "IronScrap"
        elseif item == "IronScrap" then itemType = "IronPiece"
        elseif item == "MetalBar" then itemType = "SteelRodHalf"
        elseif item == "MetalPipe" then itemType = "MetalPipe_Broken"
        elseif item == "SheetMetal" then itemType = "UnusableMetal"
        elseif item == "SmallSheetMetal" then itemType = "UnusableMetal"
        elseif item == "SteelBar" then itemType = "SteelBarHalf"
        elseif item == "SteelBarHalf" then itemType = "SteelBarQuarter"
        elseif item == "SteelBarQuarter" then itemType = "SteelScrap"
        elseif item == "SteelBlock" then itemType = "SteelScrap"
        elseif item == "SteelChunk" then itemType = "SteelScrap"
        elseif item == "SteelScrap" then itemType = "SteelPiece"
        end
        if itemType then
		    self.vehicle:getSquare():AddWorldInventoryItem(itemType, ZombRandFloat(0,0.9), ZombRandFloat(0,0.9), 0);
        end
	end
	return false;
end

function ISRemoveBurntVehicle:getDuration()
    if self.character:isMechanicsCheat() or self.character:isTimedActionInstant() then
        return 10
    end
	return 800 - (self.character:getPerkLevel(Perks.MetalWelding) * 20);
end

function ISRemoveBurntVehicle:new(character, vehicle)
	local o = ISBaseTimedAction.new(self, character)
	o.vehicle = vehicle
	o.stopOnWalk = false
	o.stopOnRun = false
	o.maxTime = o:getDuration()
	return o
end

