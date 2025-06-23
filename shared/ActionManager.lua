--***********************************************************
--**                    THE INDIE STONE                    **
--**                      Author: Yuri                     **
--***********************************************************

--if isClient() then return end

local ActionProcessor = {}
Actions = {}

function Actions.addOrDropItem(character, item)
	local inv = character:getInventory()
	local itemWasAddedToInventory = false
	if not inv:contains(item) then
		inv:AddItem(item)
		itemWasAddedToInventory = true
	end
	if inv:getCapacityWeight() > inv:getEffectiveCapacity(character) then
		if inv:contains(item) then
			inv:Remove(item)
			itemWasAddedToInventory = false
		end
		character:getCurrentSquare():AddWorldInventoryItem(item,
			character:getX() - math.floor(character:getX()),
			character:getY() - math.floor(character:getY()),
			character:getZ() - math.floor(character:getZ()))
	end
	if itemWasAddedToInventory then
	    sendAddItemToContainer(inv, item);
	end
end

Actions.build = function(character, args)
    args.item.character = character
    args.item:create(args.x, args.y, args.z, args.north, args.spriteName);
    local square = getCell():getGridSquare(args.x, args.y, args.z);
    square:RecalcAllWithNeighbours(true);
    buildUtil.setHaveConstruction(square, true);
end

ActionProcessor.OnProcessAction = function(action, character, args)
    if Actions[action] then
        local argStr = ''
        if args then
            for k,v in pairs(args) do argStr = argStr..' '..k..'='..tostring(v) end
        else
            argStr = '[no args]'
        end
        if getDebug() then
            print('OnProcessAction action:'..action..' Character:'..tostring(character)..' argStr:'..argStr)
        end
        Actions[action](character, args)
    else
        print('OnProcessAction ERROR action:'..action..' Character:'..tostring(character)..' argStr:'..argStr)
    end
end

Events.OnProcessAction.Add(ActionProcessor.OnProcessAction)
