--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

ISFireplaceMenu = {}

function ISFireplaceMenu.OnFillWorldObjectContextMenu(player, context, worldobjects, test)

	if test and ISWorldObjectContextMenu.Test then return true end

	local playerObj = getSpecificPlayer(player)
	if playerObj:getVehicle() then return end

	local fireplace = nil

	for _,object in ipairs(worldobjects) do
		local square = object:getSquare()
		if square then
			local index = square:getNextNonItemObjectIndex(0)
			while index >= 0 and index < square:getObjects():size() do
				local object2 = square:getObjects():get(index)
				index = square:getNextNonItemObjectIndex(index + 1)
				if instanceof(object2, "IsoFireplace") then
					fireplace = object2
				end
			end
		end
	end

	if not fireplace then return end
	if test then return ISWorldObjectContextMenu.setTest() end

	local option = context:addOption(fireplace:getTileName() or getText("ContextMenu_Fireplace") .. " " .. getText("ContextMenu_Info"), worldobjects, ISFireplaceMenu.onDisplayInfo, player, fireplace)
	if playerObj:DistToSquared(fireplace:getX() + 0.5, fireplace:getY() + 0.5) < 4 then -- 2 * 2
		local fireState;
		if fireplace:isLit() then
			fireState = getText("IGUI_Fireplace_Burning")
		elseif fireplace:isSmouldering() then
			fireState = getText("IGUI_Fireplace_Smouldering")
		else
			fireState = getText("IGUI_Fireplace_Unlit")
		end
		option.toolTip = ISWorldObjectContextMenu:addToolTip()
		option.toolTip:setName(fireplace:getTileName() or getText("IGUI_Fireplace_Fireplace"))
		option.toolTip.description = getText("IGUI_BBQ_FuelAmount", ISCampingMenu.timeString(luautils.round(fireplace:getFuelAmount()))) .. " (" .. fireState .. ")"
	end

	local fuelInfo = ISCampingMenu.getNearbyFuelInfo(playerObj)
	ISCampingMenu.doAddFuelOption(context, worldobjects, fireplace:getFuelAmount(), fuelInfo, fireplace, ISFireplaceAddFuel)

	if fireplace:isLit() then
		context:addOption(campingText.putOutCampfire, worldobjects, ISFireplaceMenu.onExtinguish, player, fireplace)
	else
		ISCampingMenu.doLightFireOption(playerObj, context, worldobjects, fireplace:hasFuel(),
				fuelInfo, fireplace, ISFireplaceLightFromPetrol, ISFireplaceLightFromLiterature, ISFireplaceLightFromKindle)
	end
end

function ISFireplaceMenu.onDisplayInfo(worldobjects, player, bbq)
	local playerObj = getSpecificPlayer(player)
	if not AdjacentFreeTileFinder.isTileOrAdjacent(playerObj:getCurrentSquare(), bbq:getSquare()) then
		local adjacent = AdjacentFreeTileFinder.Find(bbq:getSquare(), playerObj)
		if adjacent then
			ISTimedActionQueue.add(ISWalkToTimedAction:new(playerObj, adjacent))
			ISTimedActionQueue.add(ISFireplaceInfoAction:new(playerObj, bbq))
			return
		end
	else
		ISTimedActionQueue.add(ISFireplaceInfoAction:new(playerObj, bbq))
	end
end

function ISFireplaceMenu.onExtinguish(worldobjects, player, fireplace)
	local playerObj = getSpecificPlayer(player)
	if luautils.walkAdj(playerObj, fireplace:getSquare()) then
		ISTimedActionQueue.add(ISFireplaceExtinguish:new(playerObj, fireplace))
	end
end

Events.OnFillWorldObjectContextMenu.Add(ISFireplaceMenu.OnFillWorldObjectContextMenu)

