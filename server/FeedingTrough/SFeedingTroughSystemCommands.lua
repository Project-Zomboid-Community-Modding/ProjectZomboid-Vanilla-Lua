--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

if isClient() then return end

local function noise(message) SFeedingTroughSystem.instance:noise(message) end

local function feedingTroughAt(x, y, z)
	return SFeedingTroughSystem.instance:getLuaObjectAt(x, y, z)
end

function SFeedingTroughSystemCommand(command, player, args)
--	if command == 'setFeedAmount' then
--		local luaObject = feedingTroughAt(args.x, args.y, args.z)
--		if luaObject then
--			luaObject:setFeedAmount(args.feedAmount or 0)
--		end
--	end
	if command == 'addFeed' then
--		print("got command add feed", args.type, args.amount)
		local luaObject = feedingTroughAt(args.x, args.y, args.z)
		if luaObject then
			luaObject:addFeed(args.type, args.amount)
		end
	end
	if command == 'addWater' then
--		print("got command add water", args.amount)
		local luaObject = feedingTroughAt(args.x, args.y, args.z)
		if luaObject then
			luaObject:addWater(args.amount)
		end
	end
end

