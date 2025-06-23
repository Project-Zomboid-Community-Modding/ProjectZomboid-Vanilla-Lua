--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISScything = ISBaseTimedAction:derive("ISScything");

function ISScything:isValid()
    return true;
end

function ISScything:update()
   	self.item:setJobDelta(self:getJobDelta());
    self.character:setMetabolicTarget(Metabolics.HeavyWork);
end

function ISScything:start()
    self.item:setJobType(getText("ContextMenu_ScytheGrass"));
 	self.item:setJobDelta(0.0);

    self:setActionAnim("scything")
    self:setOverrideHandModels(self.item, nil)

    self.sound = self.character:playSound("ScytheGrass")
end

function ISScything:stop()
    self:stopSound()
    self.item:setJobDelta(0.0);

    ISBaseTimedAction.stop(self);
end

function ISScything:perform()
    self:stopSound()
    self.item:setJobDelta(0.0);

    ISBaseTimedAction.perform(self);
end

function ISScything:complete()
    --if self.item:getType() == "HandScythe" then
    --    return self:getGrass(self.sq);
    --end
    for x=self.sq:getX(), self.sq:getX()+self.radius-1 do
        for y=self.sq:getY(), self.sq:getY()+self.radius-1 do
            local sq = getSquare(x, y, self.sq:getZ());
            if sq then
                self:getGrass(sq);
            end
        end
    end
    return true
end

function ISScything:getGrass(sq)
    if sq:removeGrass() then
        if isServer() then
            local args = { x = sq:getX(), y = sq:getY(), z = sq:getZ() }
            sendServerCommand('square', 'removeGrass', args)
        end
        local items = self.character:getInventory():AddItems("Base.GrassTuft", ZombRand(3,7));
        sendAddItemsToContainer(self.character:getInventory(), items);
    end
    local plant = SFarmingSystem.instance:getLuaObjectOnSquare(sq)
    if plant and plant.state ~= "destroyed"  and plant.state ~= "harvested"  and plant.state ~= "plow" then
        if farming_vegetableconf.props[plant.typeOfSeed].scytheHarvest and plant:isAlive() and plant:canHarvest() then
            SFarmingSystem.instance:harvest(plant, self.character)
        else
            plant:destroyThis()
        end
    end
end

function ISScything:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return 250
end

function ISScything:stopSound()
    if self.sound and self.character:getEmitter():isPlaying(self.sound) then
        self.character:stopOrTriggerSound(self.sound);
    end
end

function ISScything:new (character, item, sq, radius)
    local o = ISBaseTimedAction.new(self, character)
    o.maxTime = o:getDuration();
    o.item = item;
    if item and not radius then
        radius = 3
        if item:getType() == "HandScythe" or item:hasTag("HandScythe") then
           radius = 1
        end
    end
    o.radius = radius;
    o.sq = sq or character:getCurrentSquare();
    return o
end


