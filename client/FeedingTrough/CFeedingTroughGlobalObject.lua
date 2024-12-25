--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "Map/CGlobalObject"

CFeedingTroughGlobalObject = CGlobalObject:derive("CFeedingTroughGlobalObject")

function CFeedingTroughGlobalObject:new(luaSystem, globalObject)
	local o = CGlobalObject.new(self, luaSystem, globalObject)
	return o
end

function CFeedingTroughGlobalObject:OnLuaObjectUpdated()
	if not isClient() then return end -- Already updated in singleplayer
	local isoObject = self:getIsoObject()
	if isoObject then
		print("lua object updated")
		for type,amount in pairs(self.feedAmount) do
--			print("feed amount",type, amount)
			isoObject:setFeedAmount(type, amount);
		end
		isoObject:setLinkedX(self.linkedX or 0)
		isoObject:setLinkedY(self.linkedY or 0)
		isoObject:setMaxFeed(self.maxFeed or 0);
		isoObject:setMaxWater(self.maxWater or 0);
		isoObject:setWater(self.water or 0);
	end
end

