--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISBarricadeAction = ISBaseTimedAction:derive("ISBarricadeAction");

function ISBarricadeAction:isValid()
	if not instanceof(self.item, "BarricadeAble") or self.item:getObjectIndex() == -1 then
		return false
	end
	local barricade = self.item:getBarricadeForCharacter(self.character)
	if self.isMetal then
		if barricade then
			return false
		end
		if not self.character:hasEquipped("BlowTorch") or not self.character:hasEquipped("SheetMetal") then
			return false
        end
    elseif self.isMetalBar then
        if barricade then
            return false
        end
        if not self.character:hasEquipped("BlowTorch") or not self.character:hasEquipped("MetalBar") then
            return false
        end
		if self.character:getInventory():getItemCount("Base.MetalBar", true) < 3 then
			return false
		end
	else
		if barricade and not barricade:canAddPlank() then
			return false
		end
		if not self.character:hasEquippedTag("Hammer") then
			return false
		end
		if not self.character:hasEquipped("Plank") then
			return false
		end
		if self.character:getInventory():getItemCount("Base.Nails", true) < 2 then
			return false
		end
	end
	if self.isStarted then
		if instanceof(self.item, "IsoDoor") or (instanceof(self.item, "IsoThumpable") and self.item:isDoor()) then
			if self.item:IsOpen() then
				return false
			end
		end
	end
	return true
end

function ISBarricadeAction:waitToStart()
	self.character:faceThisObject(self.item)
	return self.character:shouldBeTurning()
end

function ISBarricadeAction:update()
	self.character:faceThisObject(self.item)
    self.character:setMetabolicTarget(Metabolics.LightWork);
end

function ISBarricadeAction:start()
    if self.character:hasEquipped("BlowTorch") then
        self:setActionAnim("BlowTorch")
        self:setOverrideHandModels(self.character:getPrimaryHandItem(), nil)
        self.sound = self.character:getEmitter():playSound("BlowTorch")
        local radius = 20 * self.character:getWeldingSoundMod()
        addSound(self.character, self.character:getX(), self.character:getY(), self.character:getZ(), radius, radius)
    else
        self:setActionAnim("Build")
        -- Hammering sound is played by animation events.
--        self.sound = self.character:getEmitter():playSound("Hammering")
        local radius = 20 * self.character:getHammerSoundMod()
        addSound(self.character, self.character:getX(), self.character:getY(), self.character:getZ(), radius, radius)
    end
    if instanceof(self.item, "IsoDoor") or (instanceof(self.item, "IsoThumpable") and self.item:isDoor()) then
        if self.item:IsOpen() then
            self.item:ToggleDoor(self.character)
        end
        self.isStarted = true
    end
end

function ISBarricadeAction:stop()
	if self.sound then
		self.character:getEmitter():stopSound(self.sound)
		self.sound = nil
	end
    ISBaseTimedAction.stop(self);
end

function ISBarricadeAction:perform()
    if self.sound then
        self.character:getEmitter():stopSound(self.sound)
        self.sound = nil
    end
	local material = self.character:getSecondaryHandItem()
	if not instanceof(material, "InventoryItem") then return end


	if self.isMetalBar or self.isMetal then
        self.sound = self.character:getEmitter():playSound("AddBarricadeMetal")
		self.character:getPrimaryHandItem():Use();
	end

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISBarricadeAction:complete()
    local player = self.character
	local object = self.item
	if object then
		local barricade = IsoBarricade.AddBarricadeToObject(object, player)
		if barricade then
			local material = self.character:getSecondaryHandItem()
			if not instanceof(material, "InventoryItem") then return end

			if self.isMetal then
				local items = player:getInventory():RemoveAll('SheetMetal', 1)
				if items:size() ~= 1 then
					player:getInventory():AddItems(items);
					return;
				end
				local metal = items:get(0)
				metal:setCondition(material:getCondition())
				barricade:addMetal(player, metal)
				barricade:transmitCompleteItemToClients()
				sendRemoveItemsFromContainer(player:getInventory(), items);
                addXpNoMultiplier(player, Perks.MetalWelding, 6);
			elseif self.isMetalBar then
				local items = player:getInventory():RemoveAll('MetalBar', 3)
				if items:size() ~= 3 then
					player:getInventory():AddItems(items);
					return;
				end
				local metal = items:get(0)
				metal:setCondition(material:getCondition())
				barricade:addMetalBar(player, metal)
				barricade:transmitCompleteItemToClients()
				sendRemoveItemsFromContainer(player:getInventory(), items);
                addXpNoMultiplier(player, Perks.MetalWelding, 6);
			else
				local items = player:getInventory():RemoveAll('Plank', 1)
				if items:size() ~= 1 then
					player:getInventory():AddItems(items);
					return;
				end
				local plank = items:get(0)
				plank:setCondition(material:getCondition())
				barricade:addPlank(player, plank)
				if barricade:getNumPlanks() == 1 then
					barricade:transmitCompleteItemToClients()
				else
					if isClient() or isServer() then	 -- FIXME? for MP
						barricade:sendObjectChange('state')
					end
				end
				sendRemoveItemsFromContainer(player:getInventory(), items);
				items = player:getInventory():RemoveAll('Nails', 2)
				sendRemoveItemsFromContainer(player:getInventory(), items);
                addXpNoMultiplier(player, Perks.Woodwork, 3); --no multiplier
			end
			if self.character:getSecondaryHandItem() == material then
            	self.character:setSecondaryHandItem(nil)
            end
		end
	else
		print('ISBarricadeAction: expected BarricadeAble')
	end

	buildUtil.setHaveConstruction(object:getSquare(), true);
	return true;
end

function ISBarricadeAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	local mtime = (100 - (self.character:getPerkLevel(Perks.Woodwork) * 5));
	if self.isMetal or self.isMetalBar then
		mtime = 170 - (self.character:getPerkLevel(Perks.MetalWelding) * 5)
	end
	if self.character:HasTrait("Handy") then
		return mtime - 20
	else
		return mtime
	end

end

function ISBarricadeAction:new(character, item, isMetal, isMetalBar)
	local o = ISBaseTimedAction.new(self, character)
	print("BARRICADE!")
	o.item = item;
	o.maxTime = o:getDuration();
	o.isMetal = isMetal;
    o.isMetalBar = isMetalBar;
    o.caloriesModifier = 8;
	return o;
end
