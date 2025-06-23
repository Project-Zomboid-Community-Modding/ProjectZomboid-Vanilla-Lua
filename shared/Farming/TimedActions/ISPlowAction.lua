--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISPlowAction = ISBaseTimedAction:derive("ISPlowAction");

function ISPlowAction:isValid()
	local plant = CFarmingSystem.instance:getLuaObjectOnSquare(self.gridSquare)
	if plant and plant.state == "plow" then return false end
    if isClient() and self.item then
        return self.character:getInventory():containsID(self.item:getID());
    else
        return true;
    end
end

function ISPlowAction:waitToStart()
	self.character:faceLocation(self.gridSquare:getX(), self.gridSquare:getY())
	return self.character:isTurning() or self.character:shouldBeTurning()
-- 	return self.character:shouldBeTurning()
end

function ISPlowAction:update()
	self.character:faceLocation(self.gridSquare:getX(), self.gridSquare:getY())
    if self.item then
	    self.item:setJobDelta(self:getJobDelta());
    end
    self.character:setMetabolicTarget(Metabolics.DiggingSpade);


end

function ISPlowAction:start()

    if isClient() and self.item then
        self.item = self.character:getInventory():getItemById(self.item:getID())
    end

    if self.item then
        self.item:setJobType(getText("ContextMenu_Dig"));
        self.item:setJobDelta(0.0);
        if self.item:getDigType() == "Trowel" or self.item:getType() == "HandShovel" then
            self.sound = self.character:playSound("DigFurrowWithTrowel");
        else
            self.sound = self.character:playSound("DigFurrowWithShovel");
        end
    else
        self.sound = self.character:playSound("DigFurrowWithHands");
    end
    --    self.gridSquare:playSound("shoveling", true);
    addSound(self.character, self.character:getX(), self.character:getY(), self.character:getZ(), 10, 1)
	self:setActionAnim(BuildingHelper.getShovelAnim(self.item))
	if self.item then
		self:setOverrideHandModels(self.item:getStaticModel(), nil)
	else
		self:setOverrideHandModels(nil, nil)
	end
end

function ISPlowAction:stop()
    if self.sound and self.sound ~= 0 then
        self.character:getEmitter():stopOrTriggerSound(self.sound)
    end
    ISBaseTimedAction.stop(self);
    if self.item then
        self.item:setJobDelta(0.0);
    end
end

function ISPlowAction:perform()
    if self.item then
        self.item:getContainer():setDrawDirty(true);
        self.item:setJobDelta(0.0);
    end

    if self.sound and self.sound ~= 0 then
        self.character:getEmitter():stopOrTriggerSound(self.sound)
    end

	ISBaseTimedAction.perform(self);
end

function ISPlowAction:complete()

    if not self.item and not self.character:getClothingItem_Hands() and ZombRand(10) == 0 then -- chance of getting hurt
        local bodyPart;
        if ZombRand(2) == 0 then
            bodyPart = self.character:getBodyDamage():getBodyPart(BodyPartType.Hand_L);
        else
            bodyPart = self.character:getBodyDamage():getBodyPart(BodyPartType.Hand_R);
        end
        bodyPart:SetScratchedWeapon(true);

        --BD_scratched + BD_scratchTime + BD_stitched + BD_bandaged + BD_bandageLife + BD_Bleeding + BD_bleedingTime
        syncBodyPart(bodyPart, 0x000218ca);
    end


    local tool = false
    local bendOver = false
    if self.item then
        tool = true
        if string.contains(self.item:getType(), "Trowel") then
            bendOver = true
        end
    else
        bendOver = true
    end
    local skill = self.character:getPerkLevel(Perks.Farming)
    local strain = (1 - (skill * 0.05))
    if tool and instanceof(tool, "HandWeapon")then
        self.character:addCombatMuscleStrain(self.item, 1, strain)
    else
        self.character:addArmMuscleStrain(strain * 1)
    end
    if bendOver then
        self.character:addBackMuscleStrain(strain * 1)
    end



    local sq = self.gridSquare

    -- we remove grass and vegetation from the square
	SFarmingSystem:removeTallGrass(sq)
    local floor = sq:getFloor();
    if (floor and floor:getSprite():getProperties():Val("grassFloor")) and sq:checkHaveGrass() == true then
	    sq:removeGrass()
	end

    -- for removing destroyed tiles that are being re-plowed
    local plant = SFarmingSystem.instance:getLuaObjectOnSquare(sq)
    if plant then
        SFarmingSystem.instance:removePlant(plant)
    end

    SFarmingSystem.instance:plow(sq)

    SFarmingSystem.instance:changePlayer(self.character)
    -- maybe give worm ?
    wormCheck(self.character, self.item, self.gridSquare)

    return true;
end

function ISPlowAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end

    local time = 110;

    -- custom fields
    if not self.item then
        return time * 2;
    end

    return time;
end

function ISPlowAction:new(character, gridSquare, item)
    local o = ISBaseTimedAction.new(self, character);
	o.character = character;
    o.item = item;
	o.maxTime = o:getDuration();
	o.item = item;
	o.gridSquare = gridSquare
    o.caloriesModifier = 5;
	return o
end

function wormCheck(character, item, square)
    if (not square) or (not square:isOutside()) or (square:getZ() > 0) then return end

    local wormTime = getGameTime():getWorldAgeHours() / 24
    local mData = square:getModData()
    if mData.wormTime and (wormTime - 7) <= mData.wormTime then
        mData.wormTime = wormTime
        return
    end
    mData.wormTime = wormTime
    if getClimateManager():getSeasonName() == "Winter" then return end
    local wormChance = 40
    -- increase chance if morning
    if GameTime.getInstance():getTimeOfDay() > getClimateManager():getSeason():getDawn() and GameTime.getInstance():getTimeOfDay() < getClimateManager():getSeason():getDawn() + 2 then
       wormChance = wormChance/2
    end
    if RainManager.isRaining() then wormChance = wormChance/2 end
    -- if you use your hands and not a tool, you have a better chance of finding a worm
    local hand = (not item) or (item and instanceof(item, "InventoryItem") and (item:hasTag("DigWorms") or item:getType() == "HandShovel" or item:getType() == "HandFork"))
    if hand then wormChance = wormChance/2 end
    if ZombRand(wormChance) == 0 then
--         local worm = InventoryItemFactory.CreateItem("Base.Worm")
	    local worm = instanceItem("Base.Worm")
        if hand then
            character:getInventory():AddItem(worm);
            sendAddItemToContainer(character:getInventory(), worm);
        else
            square:AddWorldInventoryItem(worm, ZombRand(10)/10, ZombRand(10)/10, 0);
        end
        local pdata = getPlayerData(character:getPlayerNum());
        if pdata ~= nil then
            pdata.playerInventory:refreshBackpacks();
            pdata.lootInventory:refreshBackpacks();
        end
    end
end
