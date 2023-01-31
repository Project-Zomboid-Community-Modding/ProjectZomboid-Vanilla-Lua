--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "Map/CGlobalObject"

CCampfireGlobalObject = CGlobalObject:derive("CCampfireGlobalObject")

function CCampfireGlobalObject:new(luaSystem, globalObject)
	local o = CGlobalObject.new(self, luaSystem, globalObject)
	return o
end

function CCampfireGlobalObject:getObject()
	return self:getIsoObject()
end

