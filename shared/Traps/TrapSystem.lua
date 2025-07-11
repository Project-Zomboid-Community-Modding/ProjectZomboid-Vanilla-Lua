---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Yuri.
--- DateTime: 6/1/2023 3:28 AM
---

TrapSystem = {}

function TrapSystem.getTrapZones(square)
    local zones = {};
    if square then
        local mapZones = getWorld():getMetaGrid():getZonesAt(square:getX(), square:getY(), square:getZ());
        local tempZone, tempZoneType;
        for i = 0, mapZones:size() - 1 do
            tempZone = mapZones:get(i);
            tempZoneType = tempZone and tempZone:getType();
            if tempZone and tempZoneType then
                for _, trappingData in pairs(TrapAnimals) do
                    if trappingData.zone[tempZoneType] ~= nil then
                        zones[tempZoneType] = tempZoneType;
                    end;
                end;
            end;
        end;
    end;
    return zones;
end

function TrapSystem.initObjectModData(isoObject, trapDef, north, player)
    local modData = isoObject:getModData()
    local square = isoObject:getSquare()
    modData.trapType = trapDef.type
    modData.trapBait = ""
    modData.trapBaitDay = 0
    modData.animalAliveHour = 0;
    modData.lastUpdate = 0
    modData.baitAmountMulti = 0
    modData.animal = {}
    modData.animalHour = 0
    modData.openSprite = north and trapDef.northSprite or trapDef.sprite
    modData.closedSprite = north and trapDef.northClosedSprite or trapDef.closedSprite
    modData.zones = TrapSystem.getTrapZones(square);
    modData.zone = square:getZone() and square:getZone():getType() or "TownZone"
    if player then
        modData.player = player:getUsername()
        modData.trappingSkill = player:getPerkLevel(Perks.Trapping)
    else
        modData.player = "unknown"
        modData.trappingSkill = 5 -- TODO: Randomize
    end
    modData.destroyed = false;
end