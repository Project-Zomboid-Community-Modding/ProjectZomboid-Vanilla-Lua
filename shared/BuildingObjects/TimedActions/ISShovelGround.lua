--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISShovelGround = ISBaseTimedAction:derive("ISShovelGround");

function ISShovelGround:isValid()
	if instanceof(self.emptyBag, "InventoryContainer") then
		if self.emptyBag:getInventory():isEmpty() == false then
			return false
		end
	end
	if isClient() and self.emptyBag then
        return self.character:getInventory():containsID(self.emptyBag:getID()) and
            self.sandTile and self.sandTile:getSprite() and
            (self.emptyBag:hasTag("HoldDirt") or self.emptyBag:getCurrentUsesFloat() < 1)
    else
        return self.character:getInventory():contains(self.emptyBag) and
            self.sandTile and self.sandTile:getSprite() and
            (self.emptyBag:hasTag("HoldDirt") or self.emptyBag:getCurrentUsesFloat() < 1)
    end
end

function ISShovelGround:waitToStart()
	self.character:faceThisObject(self.sandTile)
	return self.character:shouldBeTurning()
end

function ISShovelGround:update()
	self.emptyBag:setJobDelta(self:getJobDelta())
	self.character:faceThisObject(self.sandTile)
    self.character:setMetabolicTarget(Metabolics.DiggingSpade);
end

function ISShovelGround:start()
    if isClient() and self.emptyBag then
        self.emptyBag = self.character:getInventory():getItemById(self.emptyBag:getID())
    end
	local jobTypes = {
		["Base.Dirtbag"] = "ContextMenu_Take_some_dirt",
		["Base.Gravelbag"] = "ContextMenu_Take_some_gravel",
		["Base.Sandbag"] = "ContextMenu_Take_some_sands",
		["Base.Claybag"] = "ContextMenu_Take_some_clay"
	}
	self.emptyBag:setJobType(getText(jobTypes[self.newBag]))
--    self.sound = getSoundManager():PlayWorldSound("shoveling", self.sandTile:getSquare(), 0, 5, 1, true);
	self:setActionAnim(BuildingHelper.getShovelAnim(self.character:getPrimaryHandItem()))
    self.sound = self.character:getEmitter():playSound("Shoveling")
	addSound(self.character, self.character:getX(), self.character:getY(), self.character:getZ(), 10, 1)
end

function ISShovelGround:stop()
	self.emptyBag:setJobDelta(0.0)
    if self.sound ~= 0 and self.character:getEmitter():isPlaying(self.sound) then
        self.character:getEmitter():stopSound(self.sound);
    end
    ISBaseTimedAction.stop(self);
end

function ISShovelGround:shovelGround(sq)
	local type,o = ISShovelGroundCursor.GetDirtGravelSand(sq)
	if instanceof(o, 'IsoObject') then
		local shovelledSprites = o:hasModData() and o:getModData().shovelledSprites
		if shovelledSprites then
			o:RemoveAttachedAnims() -- remove blend tiles
			-- Restore the sprites present before dirt/gravel/sand was dumped.
			local sprite = getSprite(shovelledSprites[1])
			if sprite then
				o:setSprite(sprite)
			end
			for i=2,#shovelledSprites do
				sprite = getSprite(shovelledSprites[i])
				if sprite then
					o:AttachExistingAnim(sprite, 0, 0, false, 0, false, 0.0)
				end
			end
			o:getModData().shovelledSprites = nil
			o:getModData().pouredFloor = nil
		else
			-- First time taking dirt/gravel/sand.
			o:getModData().shovelled = true
			o:setSprite(getSprite("blends_natural_01_64"))
			o:RemoveAttachedAnims() -- remove blend tiles
		end
		o:transmitUpdatedSpriteToClients()
		o:transmitModData()
		-- remove vegetation
		for i=sq:getObjects():size(),1,-1 do
			o = sq:getObjects():get(i-1)
			-- FIXME: blends_grassoverlays tiles should have 'vegitation' flag
			if o:getSprite() and (
					o:getSprite():getProperties():Is(IsoFlagType.canBeRemoved) or
							(o:getSprite():getProperties():Is(IsoFlagType.vegitation) and o:getType() ~= IsoObjectType.tree) or
							(o:getSprite():getName() and luautils.stringStarts(o:getSprite():getName(), "blends_grassoverlays"))) then
				sq:transmitRemoveItemFromSquare(o)
			end
		end

		if self.emptyBag:hasTag("HoldDirt") and (self.newBag == "Base.Dirtbag" or
				self.newBag == "Base.Gravelbag" or self.newBag == "Base.Sandbag" or self.newBag == "Base.Claybag") then
			local isPrimary = self.character:isPrimaryHandItem(self.emptyBag)
			local isSecondary = self.character:isSecondaryHandItem(self.emptyBag)
			self.character:removeFromHands(self.emptyBag);
			self.character:getInventory():Remove(self.emptyBag);
			sendRemoveItemFromContainer(self.character:getInventory(), self.emptyBag);
			local item = self.character:getInventory():AddItem(self.newBag);
			sendAddItemToContainer(self.character:getInventory(), item);
			if item ~= nil then
			    if self.newBag ~= "Base.Claybag" then
				    item:setUsedDelta(item:getUseDelta())
				    sendItemStats(item)
				end
				if isPrimary then
					self.character:setPrimaryHandItem(item)
				end
				if isSecondary then
					self.character:setSecondaryHandItem(item)
				end
				sendEquip(self.character)
			end
		elseif self.emptyBag:getCurrentUsesFloat() + self.emptyBag:getUseDelta() <= 1 then
			self.emptyBag:setUsedDelta(self.emptyBag:getCurrentUsesFloat() + self.emptyBag:getUseDelta())
			sendItemStats(self.emptyBag)
		end

        -- moved from ISShovelGround:complete()
        -- maybe give worm ?
        if self.newBag == "Base.Dirtbag" then
            wormCheck(self.character, self.character:getPrimaryHandItem(), sq)
        end

		-- this was removed as producing worms has been revised to be realistic and was handled elsewhere
-- 		if ZombRand(5) == 0 then
-- 			local item = instanceItem("Base.Worm")
-- 			self.character:getInventory():AddItem(item);
-- 			sendAddItemToContainer(self.character:getInventory(), item);
-- 		end
	else
		print('expected IsoObject got '..tostring(o))
		return false
	end

	return true
end

function ISShovelGround:complete()
	if not self:shovelGround(self.sandTile:getSquare()) then
		return false
	end

-- 	-- maybe give worm ?
-- 	if self.newBag == "Base.Dirtbag" then
-- 		wormCheck(self.character, self.item, sq)
-- 	end

	return true;
end

function ISShovelGround:perform()
	self.emptyBag:setJobDelta(0.0)
    if self.sound ~= 0 and self.character:getEmitter():isPlaying(self.sound) then
        self.character:getEmitter():stopSound(self.sound);
    end

	-- refresh backpacks to hide equipped filled dirt bags
	getPlayerInventory(self.character:getPlayerNum()):refreshBackpacks();
	getPlayerLoot(self.character:getPlayerNum()):refreshBackpacks();
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISShovelGround:getDuration()
	return 100;
end

function ISShovelGround:new(character, emptyBag, sandTile, newSprite, newBag)
	local o = ISBaseTimedAction.new(self, character)
	o.character = character
	o.emptyBag = emptyBag;
	o.sandTile = sandTile;
    o.newSprite = newSprite;
    o.newBag = newBag;
	o.maxTime = o:getDuration();
    o.caloriesModifier = 8;
    o.item = true;

	return o;
end
