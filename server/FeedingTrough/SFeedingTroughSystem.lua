--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

if isClient() then return end

require "Map/SGlobalObjectSystem"

SFeedingTroughSystem = SGlobalObjectSystem:derive("SFeedingTroughSystem")

function SFeedingTroughSystem:new()
	local o = SGlobalObjectSystem.new(self, "feedingTrough")
	return o
end

function SFeedingTroughSystem:initSystem()
	SGlobalObjectSystem.initSystem(self)

	-- Specify GlobalObjectSystem fields that should be saved.
	self.system:setModDataKeys(nil)
	
	-- Specify GlobalObject fields that should be saved.
	self.system:setObjectModDataKeys({'feedAmount', 'linkedX', 'linkedY', 'maxFeed', 'maxWater', 'water'})

	-- Specify GlobalObject fields that should be synced on clients.
	self.system:setObjectSyncKeys({'feedAmount', 'linkedX', 'linkedY', 'maxFeed', 'maxWater', 'water'})
end

function SFeedingTroughSystem:newLuaObject(globalObject)
--	print("new lua object S")
	return SFeedingTroughGlobalObject:new(self, globalObject)
end

function SFeedingTroughSystem:addTrough(grid, def, north, slave)
	if not grid then return end
	if self:getIsoObjectOnSquare(grid) then return nil end

	local luaObject = self:newLuaObjectOnSquare(grid)
	luaObject:initNew()
	luaObject:addObject(def, north, slave)
	--luaObject:addContainer()
	luaObject:stateFromIsoObject(luaObject:getIsoObject())
	luaObject:updateOnClient()
	luaObject:getIsoObject():transmitCompleteItemToClients()

	--self:noise("#feedingTrough="..self:getLuaObjectCount())
	--luaObject:saveData()
	return luaObject;
end

function SFeedingTroughSystem:isValidIsoObject(isoObject)
	return instanceof(isoObject, "IsoFeedingTrough")
end

function SFeedingTroughSystem:OnClientCommand(command, playerObj, args)
	SFeedingTroughSystemCommand(command, playerObj, args)
end

SGlobalObjectSystem.RegisterSystemClass(SFeedingTroughSystem)

