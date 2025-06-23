--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISDismantleAction = ISBaseTimedAction:derive("ISDismantleAction");

local function predicateNotBroken(item)
	return not item:isBroken()
end

function ISDismantleAction:isValid()
	--ensure the player hasn't moved too far away while the action was in queue
	local diffX = math.abs(self.thumpable:getSquare():getX() + 0.5 - self.character:getX());
	local diffY = math.abs(self.thumpable:getSquare():getY() + 0.5 - self.character:getY());
	return self.character:getInventory():containsTagEval("Saw", predicateNotBroken) and
			self.character:getInventory():containsTagEval("Screwdriver", predicateNotBroken) and
			self.thumpable:getObjectIndex() ~= -1 and
			(diffX <= 1.6 and diffY <= 1.6)
end

function ISDismantleAction:waitToStart()
	self.character:faceThisObject(self.thumpable)
	return self.character:shouldBeTurning()
end

function ISDismantleAction:update()
	self.character:PlayAnim("Idle")
	self.character:faceThisObject(self.thumpable)

    self.character:setMetabolicTarget(Metabolics.UsingTools);
end

function ISDismantleAction:start()
	self:setActionAnim("SawLog")
	self:setOverrideHandModels("Hacksaw", nil)
end

function ISDismantleAction:stop()
    ISBaseTimedAction.stop(self);
end

function ISDismantleAction:perform()
	ISInventoryPage.dirtyUI();

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISDismantleAction:complete()
	-- we add the items contained inside the item we destroyed to put them randomly on the ground
	if self.thumpable:getContainer() and self.thumpable:getContainer():getItems() then
		for i=0,self.thumpable:getContainer():getItems():size()-1 do
			self.thumpable:getSquare():AddWorldInventoryItem(self.thumpable:getContainer():getItems():get(i), 0.0, 0.0, 0.0)
		end
	end

	for k,v in pairs(self.thumpable:getModData()) do
		if luautils.stringStarts(k, "need:") then
			local type = luautils.split(k, ":")[2]
			if type == "Base.Torch" then
				-- Big hack for ISLightSource
				self.thumpable:toggleLightSource(false)
				local item = instanceItem(type)
				if item then
					item:setUsedDelta(0)
					self.thumpable:getSquare():AddWorldInventoryItem(item, 0, 0, 0)
				end
				item = self.thumpable:removeCurrentFuel(nil)
				if item then
					self.thumpable:getSquare():AddWorldInventoryItem(item, 0, 0, 0)
				end
			else
				local count = ZombRand(tonumber(v))+1
				for i=1,count do
					self.thumpable:getSquare():AddWorldInventoryItem(type, 0, 0, 0)
				end
			end
		end
	end

	-- Dismantle all 3 stair objects (and sometimes the floor at the top)
	local stairObjects = buildUtil.getStairObjects(self.thumpable)
	if #stairObjects > 0 then
		for i=1,#stairObjects do
			stairObjects[i]:getSquare():transmitRemoveItemFromSquare(stairObjects[i])
		end
	elseif (self.thumpable:getSquare():getZ() <= 0) and (self.thumpable:isFloor() or (self.thumpable:getSprite() and self.thumpable:getSprite():getProperties():Is(IsoFlagType.solidfloor))) then
		local floor = self.thumpable:getSquare():getFloor();
		if floor then
			floor:setSpriteFromName("blends_natural_01_64");
			if isClient() then floor:transmitUpdatedSpriteToServer(); end
			if isServer() then floor:transmitUpdatedSpriteToClients(); end
		end;
	else
		self.thumpable:getSquare():transmitRemoveItemFromSquare(self.thumpable)
	end



	return true;
end

function ISDismantleAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	if self.character:HasTrait("Dismantler") then
		return 100 - (self.character:getPerkLevel(Perks.Strength) * 5);
	end
	return 200 - (self.character:getPerkLevel(Perks.Strength) * 10);
end

function ISDismantleAction:new(character, thumpable)
	local o = ISBaseTimedAction.new(self, character)
	o.thumpable = thumpable;
	o.maxTime = o:getDuration();
    o.caloriesModifier = 2;
	return o;
end
