--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "Map/CGlobalObject"

CRainBarrelGlobalObject = CGlobalObject:derive("CRainBarrelGlobalObject")

function CRainBarrelGlobalObject:new(luaSystem, globalObject)
	local o = CGlobalObject.new(self, luaSystem, globalObject)
	return o
end

function CRainBarrelGlobalObject:getObject()
	return self:getIsoObject()
end
