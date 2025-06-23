--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISPickupDung = ISBaseTimedAction:derive("ISPickupDung");

function ISPickupDung:isValid()
    return true;
end

function ISPickupDung:update()
   	self.item:setJobDelta(self:getJobDelta());
    self.character:setMetabolicTarget(Metabolics.HeavyWork);
end

function ISPickupDung:start()
    self.item:setJobType(getText("ContextMenu_RakeDung"));
 	self.item:setJobDelta(0.0);

    --self:setActionAnim("scything")
    --self:setOverrideHandModels("Scythe", nil)
end

function ISPickupDung:stop()
    ISBaseTimedAction.stop(self);
    self.item:setJobDelta(0.0);
end

function ISPickupDung:perform()
    self.item:setJobDelta(0.0);

    ISBaseTimedAction.perform(self);
end

function ISPickupDung:complete()
    --if self.item:getType() == "HandScythe" then
    --    return self:getGrass(self.sq);
    --end
    for x=self.sq:getX(), self.sq:getX()+self.radius-1 do
        for y=self.sq:getY(), self.sq:getY()+self.radius-1 do
            local sq = getSquare(x, y, self.sq:getZ());
            if sq then
                self:pickUpDung(sq);
            end
        end
    end
    sendServerCommand("animal", "removeDung", {x = self.sq:getX(), y = self.sq:getY(), z = self.sq:getZ(), radius = self.radius});
    return true
end

function ISPickupDung:pickUpDung(sq)
    local items = self.character:getInventory():AddItems(sq:removeAllDung());
    sendAddItemsToContainer(self.character:getInventory(), items);
    --if sq:removeGrass() then
    --    if isServer() then
    --        local args = { x = sq:getX(), y = sq:getY(), z = sq:getZ() }
    --        sendServerCommand('square', 'removeGrass', args)
    --    end
    --    local items = self.character:getInventory():AddItems("Base.GrassTuft", ZombRand(5,10));
    --    sendAddItemsToContainer(self.character:getInventory(), items);
    --end
    --local plant = SFarmingSystem.instance:getLuaObjectOnSquare(sq)
    --if plant and plant.state ~= "destroyed"  and plant.state ~= "harvested"  and plant.state ~= "plow" then
    --    if farming_vegetableconf.props[plant.typeOfSeed].scytheHarvest and plant:isAlive() and plant:canHarvest() then
    --        SFarmingSystem.instance:harvest(plant, self.character)
    --    else
    --        plant:destroyThis()
    --    end
    --end
end

function ISPickupDung:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return 250
end

function ISPickupDung:new (character, item, sq, radius)
    local o = ISBaseTimedAction.new(self, character)
    o.stopOnWalk = true;
    o.stopOnRun = true;
    o.maxTime = o:getDuration();
    o.item = item;
    o.radius = radius;
    o.sq = sq or character:getCurrentSquare();
    return o
end


