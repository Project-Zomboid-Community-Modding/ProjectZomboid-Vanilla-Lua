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

		if self:checkAddItem("BrokenGlass", 12) then totalXp = totalXp + 1 end;
		if self:checkAddItem("BrokenGlass", 12) then totalXp = totalXp + 1 end;

		if self:checkAddItem("ElectricWire", 12) then totalXp = totalXp + 1 end;
		if self:checkAddItem("ElectricWire", 12) then totalXp = totalXp + 1 end;

		if self:checkAddItem("NutsBolts", 12) then totalXp = totalXp + 1 end;
		if self:checkAddItem("NutsBolts", 12) then totalXp = totalXp + 1 end;

		if self:checkAddItem("Wire", 12) then totalXp = totalXp + 1 end;
		if self:checkAddItem("Wire", 12) then totalXp = totalXp + 1 end;

        if self:checkAddItem("EngineParts", 25) then totalXp = totalXp + 1 end;
        if self:checkAddItem("EngineParts", 25) then totalXp = totalXp + 1 end;

        if self:checkAddItem("SteelBar", 25) then totalXp = totalXp + 1 end;
        if self:checkAddItem("SteelBar", 25) then totalXp = totalXp + 1 end;
--         if self:checkAddItem("SteelBar", 25) then totalXp = totalXp + 1 end;
--
        if self:checkAddItem("SteelBarHalf", 15) then totalXp = totalXp + 1 end;
        if self:checkAddItem("SteelBarHalf", 15) then totalXp = totalXp + 1 end;
--         if self:checkAddItem("SteelBarHalf", 15) then totalXp = totalXp + 1 end;
--
        if self:checkAddItem("SteelBarQuarter", 12) then totalXp = totalXp + 1 end;
        if self:checkAddItem("SteelBarQuarter", 12) then totalXp = totalXp + 1 end;
--         if self:checkAddItem("SteelBarQuarter", 12) then totalXp = totalXp + 1 end;
--
        if self:checkAddItem("SteelPiece", 12) then totalXp = totalXp + 1 end;
        if self:checkAddItem("SteelPiece", 12) then totalXp = totalXp + 1 end;
--         if self:checkAddItem("SteelPiece", 12) then totalXp = totalXp + 1 end;
--
        if self:checkAddItem("SteelBlock", 25) then totalXp = totalXp + 1 end;
        if self:checkAddItem("SteelBlock", 25) then totalXp = totalXp + 1 end;
--         if self:checkAddItem("SteelBlock", 25) then totalXp = totalXp + 1 end;
--
        if self:checkAddItem("SteelChunk", 15) then totalXp = totalXp + 1 end;
        if self:checkAddItem("SteelChunk", 15) then totalXp = totalXp + 1 end;
--         if self:checkAddItem("SteelChunk", 15) then totalXp = totalXp + 1 end;

		if self:checkAddItem("MetalBar", 15) then totalXp = totalXp + 1 end;
		if self:checkAddItem("MetalBar", 15) then totalXp = totalXp + 1 end;
-- 		if self:checkAddItem("MetalBar", 15) then totalXp = totalXp + 1 end;

		if self:checkAddItem("MetalPipe", 15) then totalXp = totalXp + 1 end;
		if self:checkAddItem("MetalPipe", 15) then totalXp = totalXp + 1 end;
-- 		if self:checkAddItem("MetalPipe", 15) then totalXp = totalXp + 1 end;

		if self:checkAddItem("SheetMetal", 25) then totalXp = totalXp + 1 end;
		if self:checkAddItem("SheetMetal", 25) then totalXp = totalXp + 1 end;
-- 		if self:checkAddItem("SheetMetal", 25) then totalXp = totalXp + 1 end;

		if self:checkAddItem("SmallSheetMetal", 15) then totalXp = totalXp + 1 end;
		if self:checkAddItem("SmallSheetMetal", 15) then totalXp = totalXp + 1 end;
-- 		if self:checkAddItem("SmallSheetMetal", 15) then totalXp = totalXp + 1 end;

		if self:checkAddItem("ScrapMetal", 12) then totalXp = totalXp + 1 end;
		if self:checkAddItem("ScrapMetal", 12) then totalXp = totalXp + 1 end;
-- 		if self:checkAddItem("ScrapMetal", 12) then totalXp = totalXp + 1 end;


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
	if ZombRand(baseChance-self.character:getPerkLevel(Perks.MetalWelding)) == 0 then
		self.vehicle:getSquare():AddWorldInventoryItem(item, ZombRandFloat(0,0.9), ZombRandFloat(0,0.9), 0);
		return true;
    elseif (not item == "BrokenGlass") and ZombRand(baseChance-self.character:getPerkLevel(Perks.MetalWelding)) == 0 then
		self.vehicle:getSquare():AddWorldInventoryItem("UnusableMetal", ZombRandFloat(0,0.9), ZombRandFloat(0,0.9), 0);
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

