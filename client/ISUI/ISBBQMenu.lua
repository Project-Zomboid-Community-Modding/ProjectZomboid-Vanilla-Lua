--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

--require 'Camping/camping_fuel'

ISBBQMenu = {}

local function predicateNotEmpty(item)
	return item:getCurrentUsesFloat() > 0
end

function ISBBQMenu.OnFillWorldObjectContextMenu(player, context, worldobjects, test)

	if test and ISWorldObjectContextMenu.Test then return true end
	local playerObj = getSpecificPlayer(player)
	if playerObj:getVehicle() then return end

	local bbq = nil

	for _,object in ipairs(worldobjects) do
		local square = object:getSquare()
		if square then
			local index = square:getNextNonItemObjectIndex(0)
			while index >= 0 and index < square:getObjects():size() do
				local object2 = square:getObjects():get(index)
				index = square:getNextNonItemObjectIndex(index + 1)
				if object2:isFireInteractionObject() then
					bbq = object2
                end
			end
		end
	end

	if not bbq then return end
	if test then return ISWorldObjectContextMenu.setTest() end
	local option = context:addOption(bbq:getTileName() or getText("ContextMenu_BBQInfo") .. " " .. getText("ContextMenu_Info"), worldobjects, ISBBQMenu.onDisplayInfo, player, bbq)
	local fireState;
	if bbq:isLit() then
		fireState = getText("IGUI_Fireplace_Burning")
	elseif bbq:isSmouldering() then
		fireState = getText("IGUI_Fireplace_Smouldering")
	else
		fireState = getText("IGUI_Fireplace_Unlit")
	end
	if playerObj:DistToSquared(bbq:getX() + 0.5, bbq:getY() + 0.5) < 2 * 2 then
		option.toolTip = ISWorldObjectContextMenu:addToolTip()
		option.toolTip:setName(bbq:getTileName())
		-- 		option.toolTip:setName(bbq:isPropaneBBQ() and getText("IGUI_BBQ_TypePropane") or getText("IGUI_BBQ_TypeCharcoal"))
		option.toolTip.description = getText("IGUI_BBQ_FuelAmount", ISCampingMenu.timeString(bbq:getFuelAmount())) .. " (" .. fireState .. ")"
		if bbq:isPropaneBBQ() and not bbq:hasPropaneTank() then
			option.toolTip.description = option.toolTip.description .. " <LINE> <RGB:1,0,0> " .. getText("IGUI_BBQ_NeedsPropaneTank")
		end
	end

    if bbq:isPropaneBBQ() then
            if bbq:hasFuel() then
            if bbq:isLit() then
                context:addOption(getText("ContextMenu_Turn_Off"), worldobjects, ISBBQMenu.onToggle, player, bbq)
            else
                context:addOption(getText("ContextMenu_Turn_On"), worldobjects, ISBBQMenu.onToggle, player, bbq)
            end
        end
        local tank = ISBBQMenu.FindPropaneTank(playerObj, bbq)
        if tank then
            context:addOption(getText("ContextMenu_Insert_Propane_Tank"), worldobjects, ISBBQMenu.onInsertPropaneTank, player, bbq, tank)
        end
        if bbq:isPropaneBBQ() and bbq:hasPropaneTank() then
            if test then return ISWorldObjectContextMenu.setTest() end
            context:addOption(getText("ContextMenu_Remove_Propane_Tank"), worldobjects, ISBBQMenu.onRemovePropaneTank, player, bbq)
        end
        return
    end

	local fuelInfo = ISCampingMenu.getNearbyFuelInfo(playerObj)
	ISCampingMenu.doAddFuelOption(context, worldobjects, bbq:getFuelAmount(), fuelInfo, bbq, ISBBQAddFuel)

	if bbq:isLit() then
		context:addOption(campingText.putOutCampfire, worldobjects, ISBBQMenu.onExtinguish, player, bbq)
	else
		ISCampingMenu.doLightFireOption(playerObj, context, worldobjects, bbq:hasFuel(),
				fuelInfo, bbq, ISBBQLightFromPetrol, ISBBQLightFromLiterature, ISBBQLightFromKindle)
	end
end

function ISBBQMenu.onDisplayInfo(worldobjects, player, bbq)
	local playerObj = getSpecificPlayer(player)
	if not AdjacentFreeTileFinder.isTileOrAdjacent(playerObj:getCurrentSquare(), bbq:getSquare()) then
		local adjacent = AdjacentFreeTileFinder.Find(bbq:getSquare(), playerObj)
		if adjacent then
			ISTimedActionQueue.add(ISWalkToTimedAction:new(playerObj, adjacent))
			ISTimedActionQueue.add(ISBBQInfoAction:new(playerObj, bbq))
			return
		end
	else
		ISTimedActionQueue.add(ISBBQInfoAction:new(playerObj, bbq))
	end
end

function ISBBQMenu.FindPropaneTank(player, bbq)
	local tank = player:getInventory():getFirstTypeEvalRecurse("Base.PropaneTank", predicateNotEmpty)
	if tank and tank:getCurrentUsesFloat() > 0 then
		return tank
	end
	for y=bbq:getY()-1,bbq:getY()+1 do
		for x=bbq:getX()-1,bbq:getX()+1 do
			local square = getCell():getGridSquare(x, y, bbq:getZ())
			if square and not square:isSomethingTo(bbq:getSquare()) then
				local wobs = square:getWorldObjects()
				for i=0,wobs:size()-1 do
					local o = wobs:get(i)
					if o:getItem():getFullType() == "Base.PropaneTank" then
						if o:getItem():getCurrentUsesFloat() > 0 then
							return o
						end
					end
				end
			end
		end
	end
	return nil
end

function ISBBQMenu.onExtinguish(worldobjects, player, bbq)
	local playerObj = getSpecificPlayer(player)
	if luautils.walkAdj(playerObj, bbq:getSquare()) then
		ISTimedActionQueue.add(ISBBQExtinguish:new(playerObj, bbq))
	end
end

function ISBBQMenu.onInsertPropaneTank(worldobjects, player, bbq, tank)
	local playerObj = getSpecificPlayer(player)
	local square = bbq:getSquare()
	if instanceof(tank, "IsoWorldInventoryObject") then
		if playerObj:getSquare() ~= tank:getSquare() then
			ISTimedActionQueue.add(ISWalkToTimedAction:new(playerObj, tank:getSquare()))
		end
		ISTimedActionQueue.add(ISBBQInsertPropaneTank:new(playerObj, bbq, tank))
	elseif luautils.walkAdj(playerObj, square) then
		ISWorldObjectContextMenu.transferIfNeeded(playerObj, tank)
		ISTimedActionQueue.add(ISBBQInsertPropaneTank:new(playerObj, bbq, tank))
	end
end

function ISBBQMenu.onRemovePropaneTank(worldobjects, player, bbq, tank)
	local playerObj = getSpecificPlayer(player)
	if luautils.walkAdj(playerObj, bbq:getSquare()) then
		ISTimedActionQueue.add(ISBBQRemovePropaneTank:new(playerObj, bbq))
	end
end

function ISBBQMenu.onToggle(worldobjects, player, bbq, tank)
	local playerObj = getSpecificPlayer(player)
	if luautils.walkAdj(playerObj, bbq:getSquare()) then
		ISTimedActionQueue.add(ISBBQToggle:new(playerObj, bbq))
	end
end

Events.OnFillWorldObjectContextMenu.Add(ISBBQMenu.OnFillWorldObjectContextMenu)

