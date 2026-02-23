require "Map/CGlobalObjectSystem"

CRainBarrelSystem = CGlobalObjectSystem:derive("CRainBarrelSystem")

function CRainBarrelSystem:new()
	local o = CGlobalObjectSystem.new(self, "rainbarrel")
	return o
end

function CRainBarrelSystem:isValidIsoObject(isoObject)
	return instanceof(isoObject, "IsoThumpable") and isoObject:getProperties() and (isoObject:getProperties():get("CustomName") == "Rain Collector Barrel")
end

function CRainBarrelSystem:newLuaObject(globalObject)
	return CRainBarrelGlobalObject:new(self, globalObject)
end

CGlobalObjectSystem.RegisterSystemClass(CRainBarrelSystem)
