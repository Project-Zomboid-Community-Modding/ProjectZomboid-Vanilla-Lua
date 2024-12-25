--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

ISFeedingTroughMenu = {}

ISFeedingTroughMenu.FEED_PER_DELTA = 10;

local function predicateNotFull(item)
	return item:getCurrentUsesFloat() < 1
end

local function predicateEmptySandbag(item)
	return not instanceof(item, "InventoryContainer") or item:getInventory():isEmpty()
end

function ISFeedingTroughMenu.OnFillWorldObjectContextMenu(player, context, worldobjects, test)
	if test and ISWorldObjectContextMenu.Test then return true end

	local playerObj = getSpecificPlayer(player)
	local playerInv = playerObj:getInventory()

	if playerObj:getVehicle() then return false end

	local luaObject = nil
	for i,v in ipairs(worldobjects) do
		luaObject = CFeedingTroughSystem.instance:getLuaObjectOnSquare(v:getSquare())
		if luaObject then
			if luaObject.linkedX and luaObject.linkedY and luaObject.linkedX > 0 and luaObject.linkedY > 0 then
				local square = getSquare(luaObject.linkedX, luaObject.linkedY, v:getSquare():getZ());
				if square then
					luaObject = CFeedingTroughSystem.instance:getLuaObjectOnSquare(square)
					if luaObject then
						break
					end
				end
			end
			break
		end
	end

	if luaObject == nil then return false end

--	print("found feeding trough")

	if test then return ISWorldObjectContextMenu.setTest() end

	local isoObject = luaObject:getIsoObject()

	local option
	local tooltip


	local subOption = context:addOption(getText("ContextMenu_FeedingTrough"), worldobjects, nil);
	local subMenu = ISContextMenu:getNew(context);
	context:addSubMenu(subOption, subMenu);

	subMenu:addOption(getText("ContextMenu_FeedingTrough_Info"), isoObject, ISFeedingTroughMenu.onInfo, playerObj)

	--
	-- Add water to trough
	--
	if isoObject:getWater() < isoObject:getMaxWater() then
		--local waterItems = playerInv:getAllEvalRecurse(function(item)
		--	-- or our item have water
		--	if item:canStoreWater() and item:isWaterSource() and not item:isBroken() and instanceof(item, "DrainableComboItem") and item:getCurrentUsesFloat() > 0 then
		--		return true
		--	end
		--
		--	return false
		--end)

		local waterItems = playerObj:getInventory():getAllWaterFluidSources(true);

		local waterOption = subMenu:addOption(getText("ContextMenu_AddWaterFromItem"), worldobjects, nil);
		local subMenuWater = ISContextMenu:getNew(subMenu);
		subMenu:addSubMenu(waterOption, subMenuWater);

		if isoObject:getContainer() and not isoObject:getContainer():isEmpty() then
			local waterOption = subMenuWater:addOption(getText("ContextMenu_FeedingTrough_RemoveItemForWater"), worldobjects, nil);
			waterOption.notAvailable = true;
		else
			if not waterItems:isEmpty() then
				local alreadyAdded = {};

				if isoObject:getContainer() and not isoObject:getContainer():isEmpty() then
					waterOption.notAvailable = true;
					local tooltip = ISWorldObjectContextMenu.addToolTip();
					tooltip:setName(getText("Tooltip_FeedingTrough_FeedPresent"));
					waterOption.toolTip = tooltip;
				else
					for i=0, waterItems:size() - 1 do
						local item = waterItems:get(i);
						local text = item:getFluidContainer():getUiName() .. " (" .. round(item:getFluidContainer():getAmount() * 1000, 2) .. " mL)";
						if not alreadyAdded[text] then
							subMenuWater:addOption(text, playerObj, ISFeedingTroughMenu.onAddWater, luaObject, item)
							alreadyAdded[text] = true;
						end
					end
				end

				-- all will relaunch the action as soon as one item is empty
				if waterItems:size() > 1 then
					subMenuWater:addOption(getText("ContextMenu_Eat_All"), playerObj, ISFeedingTroughMenu.onAddWater, luaObject, waterItems:get(0), true)
				end
			else
				local waterOption = subMenuWater:addOption(getText("ContextMenu_NoWaterItemFound"), worldobjects, nil);
				waterOption.notAvailable = true;
			end
		end
	else
		local waterOption = subMenu:addOption(getText("ContextMenu_AddWaterFromItem"), worldobjects, nil);
		waterOption.notAvailable = true;
		local tooltip = ISWorldObjectContextMenu.addToolTip();
		tooltip:setName(getText("Tooltip_FeedingTrough_Full"));
		waterOption.toolTip = tooltip;
	end

	if isoObject:getWater() > 0 then
		subMenu:addOption(getText("ContextMenu_FeedingTrough_EmptyWater"), playerObj, ISFeedingTroughMenu.onEmptyWater, isoObject);
	end

	if AnimalContextMenu.cheat then
		subMenu:addDebugOption("Add Food", playerObj, ISFeedingTroughMenu.onAddFoodDebug, isoObject);

		if isoObject:getContainer() and not isoObject:getContainer():getItems():isEmpty() then
			subMenu:addDebugOption("Remove Food", playerObj, ISFeedingTroughMenu.onRemoveFoodDebug, isoObject);
		end

		subMenu:addDebugOption("Add Water", playerObj, ISFeedingTroughMenu.onAddWaterDebug, isoObject);
	end

	return true
end

ISFeedingTroughMenu.onAddWaterDebug = function(playerObj, isoObject)
	if isoObject:getContainer() then
		isoObject:getContainer():removeAllItems();
	end

	isoObject:setWater(isoObject:getMaxWater());

	isoObject:checkOverlayAfterAnimalEat();
end

ISFeedingTroughMenu.onRemoveFoodDebug = function(playerObj, isoObject)
	isoObject:getContainer():removeAllItems();

	isoObject:checkOverlayAfterAnimalEat();
end

ISFeedingTroughMenu.onAddFoodDebug = function(playerObj, isoObject)
	isoObject:setWater(0);
	--print(isoObject, isoObject:getContainer())

	isoObject:getContainer():AddItem("Base.AnimalFeedBag")
	isoObject:getContainer():AddItem("Base.AnimalFeedBag")

	isoObject:checkOverlayAfterAnimalEat();
end

ISFeedingTroughMenu.onEmptyWater = function(playerObj, isoObject)
	if luautils.walkAdj(playerObj, isoObject:getSquare()) then
		ISTimedActionQueue.add(ISEmptyWaterInTrough:new(playerObj, isoObject))
	end
end

ISFeedingTroughMenu.onAddWater = function(playerObj, luaObject, waterItem, all)
	if luautils.walkAdj(playerObj, luaObject:getSquare()) then
		ISWorldObjectContextMenu.transferIfNeeded(playerObj, waterItem)
		ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), waterItem, true, false)
		ISTimedActionQueue.add(ISAddWaterToTrough:new(playerObj, luaObject:getIsoObject(), waterItem, all))
	end
end

ISFeedingTroughMenu.onInfo = function(trough, chr)
	local ui = ISFeedingTroughUI:new(100, 100, 500, 250, trough, chr)
	ui:initialise();
	ui:addToUIManager();
end

function ISFeedingTroughMenu.isValidAnimalFeed(item)
	if not item then return false end
	return item:isAnimalFeed() and instanceof(item, "Drainable");
end

Events.OnFillWorldObjectContextMenu.Add(ISFeedingTroughMenu.OnFillWorldObjectContextMenu)

