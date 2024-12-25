--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "Map/CGlobalObjectSystem"

CTrapSystem = CGlobalObjectSystem:derive("CTrapSystem")

function CTrapSystem:new()
	local o = CGlobalObjectSystem.new(self, "trap")
	return o
end

function CTrapSystem:isValidIsoObject(isoObject)
	return instanceof(isoObject, "IsoThumpable") and isoObject:getName() == "Trap"
end

function CTrapSystem:newLuaObject(globalObject)
	return CTrapGlobalObject:new(self, globalObject)
end

CGlobalObjectSystem.RegisterSystemClass(CTrapSystem)

