--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISShovelAction = ISBaseTimedAction:derive("ISShovelAction");

function ISShovelAction:isValid()
	self.plant:updateFromIsoObject()
	return self.plant:getIsoObject() ~= nil
end

function ISShovelAction:waitToStart()
	self.character:faceThisObject(self.plant:getObject())
	return  self.character:isTurning() or self.character:shouldBeTurning()
end

function ISShovelAction:update()
	self.item:setJobDelta(self:getJobDelta());
	self.character:faceThisObject(self.plant:getObject())
    self.character:setMetabolicTarget(Metabolics.DiggingSpade);
    local skill = self.character:getPerkLevel(Perks.Farming)
    local strain = (1 - (skill * 0.05))/10 * getGameTime():getMultiplier()
    if self.item then
        self.character:addCombatMuscleStrain(self.item, 1, strain)
    end
end

function ISShovelAction:start()
	self.item:setJobType(getText("ContextMenu_Remove"));
	self.item:setJobDelta(0.0);
    if self.plant:getSquare() then
        self.sound = getSoundManager():PlayWorldSound("Shoveling", self.plant:getSquare(), 0, 10, 1, true);
	end
	local anim = BuildingHelper.getShovelAnim(self.character:getPrimaryHandItem())
	self:setActionAnim(anim)
end

function ISShovelAction:stop()
    if self.sound and self.sound:isPlaying() then
        self.sound:stop();
    end
    ISBaseTimedAction.stop(self);
    self.item:setJobDelta(0.0);
end

function ISShovelAction:perform()
    if self.sound and self.sound:isPlaying() then
        self.sound:stop();
    end
	self.item:getContainer():setDrawDirty(true);
	self.item:setJobDelta(0.0);

	local info = ISFarmingMenu.info[self.character]
	if info and info:isVisible() then
		info:setVisible(false)
	end

	ISBaseTimedAction.perform(self);
end

function ISShovelAction:complete()


    if self.plant:getSquare() then
        local sq = self.plant:getSquare()
        -- we remove grass and vegetation from the square
        SFarmingSystem:removeTallGrass(sq)
        local floor = sq:getFloor();
        if (floor and floor:getSprite():getProperties():Val("grassFloor")) and sq:checkHaveGrass() == true then
            sq:removeGrass()
        end
    end

	local plant = SFarmingSystem.instance:getLuaObjectAt(self.plant.x, self.plant.y, self.plant.z);
	SFarmingSystem.instance:removePlant(plant);
	return true;
end

function ISShovelAction:getDuration()
	return self.maxTime;
end

function ISShovelAction:new (character, item, plant, maxTime)
	local o = ISBaseTimedAction.new(self, character);
	o.character = character;
	o.item = item;
    o.plant = plant;
	o.maxTime = maxTime;
    o.caloriesModifier = 4;
	return o
end
