--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

if isClient() then return end

local function noise(message) SCampfireSystem.instance:noise(message) end

local function campfireAt(x, y, z)
	return SCampfireSystem.instance:getLuaObjectAt(x, y, z)
end

function SCampfireSystemCommand(command, player, args)
	if command == 'addFuel' then
		local campfire = campfireAt(args.x, args.y, args.z)
		if campfire then
			campfire:addFuel(args.fuelAmt)
		end
	elseif command == 'lightFire' then
		local campfire = campfireAt(args.x, args.y, args.z)
		if campfire then
			if args.fuelAmt then
				campfire:addFuel(args.fuelAmt)
			end
			campfire:lightFire()
		end
	elseif command == 'putOutCampfire' then
		local campfire = campfireAt(args.x, args.y, args.z)
		if campfire then
			campfire:putOut()
		end
	elseif command == 'removeCampfire' then
		local campfire = campfireAt(args.x, args.y, args.z)
		if campfire then
			SCampfireSystem:removeCampfire(campfire)
			local items = player:getInventory():AddItems("Base.Stone2", 3);
			sendAddItemsToContainer(player:getInventory(), items);
		end
	elseif command == 'setFuel' then
		local campfire = campfireAt(args.x, args.y, args.z)
		if campfire then
			campfire:setFuel(args.fuelAmt)
		end
	end
end

