--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

ISFluidUtil = {};

ISFluidUtil.isoPanelWalkToDist = 2; -- if player not within this range will walkto
ISFluidUtil.isoMaxPanelDist = 2;   -- used to close fluid panel if outside this range

-- Validates containers for UI purposes
function ISFluidUtil.validateContainer(_container)
    if (not _container) or (not _container.Type) or (_container.Type~="ISFluidContainer") then
        return false;
    end
    if _container:getOwner() then
        if instanceof(_container:getOwner(), "InventoryItem") then
            return _container:getOwner():isInPlayerInventory()
        elseif instanceof(_container:getOwner(), "IsoObject") then
            return _container:getOwner():isExistInTheWorld(); --todo when multi-tile implemented check if multi-tile still valid.
        end
    end
    return false;
end

-- walkto a fluidcontainer that has isoobject as owner
function ISFluidUtil.doWalkTo(_player, _container, _dist)
    if _player and ISFluidUtil.validateContainer(_container) then
        local obj = _container:getOwner();
        if obj and instanceof(obj, "IsoObject") then
            local square = obj:getSquare();
            if not square then
                return false;
            end
            local dist = _dist or ISFluidUtil.isoPanelWalkToDist;
            if _player:getX() < square:getX()-dist or _player:getX() > square:getX()+dist or _player:getY() < square:getY()-dist or _player:getY() > square:getY()+dist then
                return luautils.walkAdj( _player, square, false );
            else
                return true;
            end
        elseif obj and instanceof(obj, "InventoryItem") then
            return obj:isInPlayerInventory();
        end
    end
    return false;
end

function ISFluidUtil.getContainerOwner(_container)
    if instanceof(_container, "ResourceFluid") then
        return _container:getGameEntity();
    else
        return _container:getOwner();
    end
end

function ISFluidUtil.getTransferActionTimePerLiter()
    return FluidUtil.getTransferActionTimePerLiter();
end

function ISFluidUtil.getMinTransferActionTime()
    return FluidUtil.getMinTransferActionTime();
end

function ISFluidUtil:getLuaFluidContainer(container)
    local luaFluidContainer = ISFluidContainer:new(container);

    if not ISFluidUtil.validateContainer(container) then
        print("getLuaFluidContainer not a valid (ISFluidContainer) container?")
    end

    return luaFluidContainer
end