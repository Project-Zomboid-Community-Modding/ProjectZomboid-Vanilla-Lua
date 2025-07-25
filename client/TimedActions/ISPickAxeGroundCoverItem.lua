-- --***********************************************************
-- --**                    ROBERT JOHNSON                     **
-- --***********************************************************
--
-- require "TimedActions/ISBaseTimedAction"
--
-- ISPickAxeGroundCoverItem = ISBaseTimedAction:derive("ISPickAxeGroundCoverItem");
--
-- local function predicatePickAxe(item)
-- 	if item:isBroken() then return false end
-- 	local type = item:getType()
-- 	return item:hasTag("Hammer") or item:hasTag("Sledgehammer") or item:hasTag("ClubHammer") or item:hasTag("PickAxe") or type == "PickAxe" or item:hasTag("StoneMaul")
-- end
--
-- function ISPickAxeGroundCoverItem:isValid()
-- 	if ISBuildMenu.cheat then return true end
-- 	local PickAxe = self.character:getInventory():getFirstEvalRecurse(predicatePickAxe)
-- 	if not PickAxe then return false end
-- 	--ensure the player hasn't moved too far away while the action was in queue
-- 	local diffX = math.abs(self.item:getSquare():getX() + 0.5 - self.character:getX());
-- 	local diffY = math.abs(self.item:getSquare():getY() + 0.5 - self.character:getY());
-- 	return self.item:getObjectIndex() ~= -1 and (diffX <= 1.6 and diffY <= 1.6);
-- end
--
-- function ISPickAxeGroundCoverItem:waitToStart()
-- 	self.character:faceThisObject(self.item)
-- 	return self.character:shouldBeTurning()
-- end
--
-- function ISPickAxeGroundCoverItem:update()
-- 	self.character:faceThisObject(self.item);
-- 	self.spriteFrame = self.character:getSpriteDef():getFrame();
--     self.character:setMetabolicTarget(Metabolics.HeavyWork);
-- end
--
-- function ISPickAxeGroundCoverItem:start()
-- 	if self.item == nil then
-- 		return
-- 	end
-- 	if not self.pickAxe then
-- 		self.pickAxe = self.character:getPrimaryHandItem();
-- 	end
-- 	if self.pickAxe and not self.pickAxe:isTwoHandWeapon() then
-- 	    self:setActionAnim(CharacterActionAnims.BuildLow)
-- 	else
-- 	    self:setActionAnim("DestroyFloor")
-- 	end
-- 	addSound(self.character, self.character:getX(),self.character:getY(),self.character:getZ(), 20, 10);
-- end
--
-- function ISPickAxeGroundCoverItem:stop()
--     ISBaseTimedAction.stop(self);
-- end
--
-- function ISPickAxeGroundCoverItem:perform()
-- 	if self.item == nil then
-- 		return
-- 	end
-- 	local xp = false
-- 	if self.objectType then
-- 		local trashItem
-- 		if self.objectType == "Small Stump" then trashItem = "Base.UnusableWood" end
-- -- 		if self.objectType == "bigRock" or self.objectType == "bigRockTwigs" then trashItem = "Base.LargeStone" end
-- -- 		if self.objectType == "flatRock" then trashItem = "Base.FlatStone" end
--         if (string.find(tostring(self.objectType), "ironOre") ~= nil) then
-- -- 		if self.objectType:contains("ironOre") then
--             trashItem = "Base.IronOre"
--             xp = true
-- -- 			self.item:getSquare():AddWorldInventoryItem(trashItem, 0.0, 0.0, 0.0)
--             if self.objectType == "ironOreMedium" then
-- 			    self.item:getSquare():SpawnWorldInventoryItem(trashItem, 0.0, 0.0, 0.0)
--                 addXp(self.character, Perks.Masonry, 5);
--             elseif self.objectType == "ironOreLarge" then
-- 			    self.item:getSquare():SpawnWorldInventoryItem(trashItem, 0.0, 0.0, 0.0)
-- 			    self.item:getSquare():SpawnWorldInventoryItem(trashItem, 0.0, 0.0, 0.0)
--                 addXp(self.character, Perks.Masonry, 10);
--             end
-- --             self.item:getSquare():AddTileObject(IsoObject.new(self.item:getSquare(), "crafting_ore_" .. tostring(ZombRand(2) + 9)));
--         elseif (string.find(tostring(self.objectType), "copperOre") ~= nil) then
-- -- 		if self.objectType:contains("ironOre") then
--             trashItem = "Base.CopperOre"
--             xp = true
-- -- 			self.item:getSquare():AddWorldInventoryItem(trashItem, 0.0, 0.0, 0.0)
--             if self.objectType == "copperOreMedium" then
-- 			    self.item:getSquare():SpawnWorldInventoryItem(trashItem, 0.0, 0.0, 0.0)
--                 addXp(self.character, Perks.Masonry, 5);
--             elseif self.objectType == "copperOreLarge" then
-- 			    self.item:getSquare():SpawnWorldInventoryItem(trashItem, 0.0, 0.0, 0.0)
-- 			    self.item:getSquare():SpawnWorldInventoryItem(trashItem, 0.0, 0.0, 0.0)
--                 addXp(self.character, Perks.Masonry, 10);
--             end
-- --             self.item:getSquare():AddTileObject(IsoObject.new(self.item:getSquare(), "crafting_ore_" .. tostring(ZombRand(2) + 25)));
--         elseif self.objectType == "FlintBoulder" then
-- 			self.item:getSquare():SpawnWorldInventoryItem("Base.SharpedStone", 0.0, 0.0, 0.0)
--             trashItem = "Base.FlintNodule"
--             xp = true
--             local roll = ZombRand(4) + 1
--             for i = 1, roll do
--                 local trashItem2 = "Base.FlintNodule"
--                 if ZombRand(3) == 0  then trashItem2 = "Base.SharpedStone" end
-- 			    self.item:getSquare():SpawnWorldInventoryItem(trashItem2, 0.0, 0.0, 0.0)
--                 addXp(self.character, Perks.Masonry, 5);
--             end
--         elseif self.objectType == "LimestoneBoulder" then
-- 			self.item:getSquare():SpawnWorldInventoryItem("Base.CrushedLimestone", 0.0, 0.0, 0.0)
--             trashItem = "Base.Limestone"
--             xp = true
--             local roll = ZombRand(4) + 1
--             for i = 1, roll do
--                 local trashItem2 = "Base.Limestone"
--                 if ZombRand(3) == 0 then trashItem2 = "Base.CrushedLimestone" end
-- 			    self.item:getSquare():SpawnWorldInventoryItem(trashItem2, 0.0, 0.0, 0.0)
--                 addXp(self.character, Perks.Masonry, 5);
--             end
-- 		end
-- 		if trashItem then
-- 			local square = self.item:getSquare()
-- 			self.item:getSquare():SpawnWorldInventoryItem(trashItem, 0.0, 0.0, 0.0)
-- 			ISInventoryPage.renderDirty = true
-- 		end
-- -- 		if self.objectType == "bigRockTwigs" then
-- -- 			trashItem = "Base.Twigs"
-- -- 			local square = self.item:getSquare()
-- -- 			self.item:getSquare():AddWorldInventoryItem(trashItem, 0.0, 0.0, 0.0)
-- -- 			ISInventoryPage.renderDirty = true
-- -- 		end
-- 	end
-- 	if isClient() then
-- 		sledgeDestroy(self.item);
-- 	else
-- 		self.item:getSquare():transmitRemoveItemFromSquare(self.item)
-- 	end
--     if xp then
--         addXp(self.character, Perks.Masonry, 5);
--     end
-- 	addSound(self.character, self.character:getX(),self.character:getY(),self.character:getZ(), 10, 10);
--     -- reduce the PickAxe condition
-- 	if not ISBuildMenu.cheat and self.pickaxe then
-- -- 		local pickAxe = self.character:getPrimaryHandItem();
-- -- 		local rollMax = self.pickAxe:getConditionLowerChance() * 2 end
-- -- 	    if self.pickAxe and self.pickAxe:isTwoHandWeapon() then rollMax = self.pickAxe:getConditionLowerChance() * 2
-- 	    self.pickaxe:damageCheck(0,2,false)
-- -- 		if ZombRand(rollmax) == 0 then
-- -- 			pickAxe:setCondition(pickAxe:getCondition() - 1);
-- -- 			ISWorldObjectContextMenu.checkWeapon(self.character);
-- -- 		end
-- 	end
--     -- needed to remove from queue / start next.
-- 	ISBaseTimedAction.perform(self);
-- end
--
-- function ISPickAxeGroundCoverItem:animEvent(event, parameter)
-- --     local pickAxe = self.character:getPrimaryHandItem();
-- 	if event == "PlaySwingSound" and self.pickAxe then
-- -- 		local pickAxe = self.character:getPrimaryHandItem();
-- 		self.character:playSound(self.pickAxe:getSwingSound())
-- 	end
-- 	if event == "PlayHitSound" and self.pickAxe then
--         self.character:addCombatMuscleStrain(self.pickAxe)
-- 		-- FIXME: Pick an appropriate value for hit surface.
-- 		self.character:setMeleeHitSurface("Default")
-- 		self.character:playSound(self.pickAxe:getDoorHitSound())
-- 	end
-- end
--
-- function ISPickAxeGroundCoverItem:new(character, item)
--     if instanceof(item, "IsoObject") and item:getSprite()  then
--         local spriteName = item:getSprite():getName() or item:getSpriteName()
--         if not spriteName then
--             spriteName = item:getSpriteName()
--         end
--
--     end
-- 	local o = ISBaseTimedAction.new(self, character)
-- 	o.item = item;
--     local props = item:getSprite():getProperties()
--     local objectType = props:Is("CustomName") and props:Val("CustomName") or nil
-- 	o.objectType = objectType;
-- 	o.cornerCounter = -1;
-- 	if cornerCounter ~= nil then
-- 		o.cornerCounter = cornerCounter;
-- 	end
-- 	o.maxTime = 300 - (character:getPerkLevel(Perks.Strength) * 10);
-- 	-- if ISBuildMenu.cheat then o.maxTime = 1 end
--     if character:isTimedActionInstant() then
--         o.maxTime = 1;
--     end
-- 	o.spriteFrame = 0
-- 	o.caloriesModifier = 8;
-- 	o.pickAxe = character:getPrimaryHandItem();
-- 	return o;
-- end