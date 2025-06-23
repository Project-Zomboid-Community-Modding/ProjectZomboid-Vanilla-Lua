--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISUnbarricadeAction = ISBaseTimedAction:derive("ISUnbarricadeAction");

function ISUnbarricadeAction:isValid()
	if not instanceof(self.item, "BarricadeAble") or not self.item:getBarricadeForCharacter(self.character) then
		return false
	end
	local barricade = self.item:getBarricadeForCharacter(self.character)
	if barricade:isMetal() or barricade:isMetalBar() then
		if not self.character:hasEquipped("BlowTorch") then
			return false
		end
	else
		if barricade:getNumPlanks() == 0 then
			return false
		end
		if not self.character:hasEquippedTag("RemoveBarricade") then
			return false
		end
	end
	return true;
end

function ISUnbarricadeAction:waitToStart()
	self.character:faceThisObject(self.item)
	return self.character:shouldBeTurning()
end

function ISUnbarricadeAction:update()
	self.character:faceThisObject(self.item)

    self.character:setMetabolicTarget(Metabolics.LightWork);
end

function ISUnbarricadeAction:start()
--    getSoundManager():PlayWorldSound("crackwood", false, self.character:getSquare(), 1, 5, 1, false)
    local barricade = self.item:getBarricadeForCharacter(self.character)
    if barricade:isMetal() or barricade:isMetalBar() then
        self:setActionAnim("BlowTorch")
        self:setOverrideHandModels(self.character:getPrimaryHandItem(), nil)
        self.sound = self.character:playSound("BeginRemoveBarricadeMetal");
        local radius = 20 * self.character:getWeldingSoundMod()
        addSound(self.character, self.character:getX(), self.character:getY(), self.character:getZ(), radius, radius)
    else
        self:setActionAnim("RemoveBarricade")
        if self.character:getPrimaryHandItem():hasTag("Crowbar") or self.character:getPrimaryHandItem():hasTag("PryBar") then
            if barricade:getNumPlanks() == 2 or barricade:getNumPlanks() == 4 then
                self:setAnimVariable("RemoveBarricade", "CrowbarHigh")
            else
                self:setAnimVariable("RemoveBarricade", "CrowbarMid")
            end
            self:setOverrideHandModels(self.character:getPrimaryHandItem(), nil)
            self.sound = self.character:playSound("BeginRemoveBarricadePlankCrowbar");
        else
            self.character:clearVariable("RemoveBarricade")
            self:setOverrideHandModels(nil, nil)
            self.sound = self.character:playSound("BeginRemoveBarricadePlank");
        end
        addSound(self.character, self.character:getX(), self.character:getY(), self.character:getZ(), 10, 1)
    end
end

function ISUnbarricadeAction:stop()
	if self.sound then
		self.character:getEmitter():stopSound(self.sound)
		self.sound = nil
	end
    ISBaseTimedAction.stop(self);
end

function ISUnbarricadeAction:perform()
    if self.sound then
        self.character:getEmitter():stopSound(self.sound)
        self.sound = nil
    end
    if not self.character:hasEquipped("BlowTorch") then
        self.character:playSound("RemoveBarricadePlank")
        addSound(self.character, self.character:getX(), self.character:getY(), self.character:getZ(), 10, 1)
    end

    local barricade = self.item:getBarricadeForCharacter(self.character)
    if barricade then
        local isMetal = barricade:isMetal()
        local isMetalBar = barricade:isMetalBar()
        if isMetal or isMetalBar then
            self.character:playSound("RemoveBarricadeMetal")
            addSound(self.character, self.character:getX(), self.character:getY(), self.character:getZ(), 10, 1)
            self.character:getPrimaryHandItem():Use()
        end
    end

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISUnbarricadeAction:complete()

	local player = self.character

    if self.item and self.item:isBarricaded() then
    	local barricade = self.item:getBarricadeForCharacter(player)
    	if barricade then
    		if barricade:isMetal() then
    			local metal = barricade:removeMetal(nil)
    			if metal then
    				player:getInventory():AddItem(metal);
    				sendAddItemToContainer(player:getInventory(), metal);
    			end
    		elseif barricade:isMetalBar() then
    			local bar = barricade:removeMetalBar(nil)
    			if bar then
    				player:getInventory():AddItem(bar);
    				sendAddItemToContainer(player:getInventory(), bar);
    				local bar2 = instanceItem('Base.MetalBar')
    				bar2:setCondition(bar:getCondition())
    				player:getInventory():AddItem(bar2);
    				sendAddItemToContainer(player:getInventory(), bar2);
    				local bar3 = instanceItem('Base.MetalBar')
    				bar3:setCondition(bar:getCondition())
    				player:getInventory():AddItem(bar3);
    				sendAddItemToContainer(player:getInventory(), bar3);
    			end
    		else
    			local plank = barricade:removePlank(nil)
    			if barricade:getNumPlanks() > 0 then
    				barricade:sendObjectChange('state')
    			end
    			if plank then
    				player:getInventory():AddItem(plank);
    				sendAddItemToContainer(player:getInventory(), plank);
    				addXpNoMultiplier(player, Perks.Woodwork, 2);
    				addXp(player, Perks.Strength, 2);
    			end
    		end
    	end
    end

	buildUtil.setHaveConstruction(self.item:getSquare(), true);
	return true;
end

function ISUnbarricadeAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	local maxTime = (200 - (self.character:getPerkLevel(Perks.Woodwork) * 5))
	if self.character:HasTrait("Handy") then
		maxTime = maxTime - 20;
	end
	return maxTime
end

function ISUnbarricadeAction:new(character, item)
	local o = ISBaseTimedAction.new(self, character)
	o.item = item;
	o.maxTime = o:getDuration()
	return o;
end
