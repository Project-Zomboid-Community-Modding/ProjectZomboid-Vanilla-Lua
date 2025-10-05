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

	local subMenu;
	if context.troughSubmenu then
		subMenu = context.troughSubmenu;
	--else
	--	local subOption = context:addOption(getText("ContextMenu_FeedingTrough"), worldobjects, nil);
	--	subMenu = ISContextMenu:getNew(context);
	--	context:addSubMenu(subOption, subMenu);
	--else
	--	return;
	end

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

	if test then return ISWorldObjectContextMenu.setTest() end

	local isoObject = luaObject:getIsoObject()

	-- if don't have our submenu, means we clicked on the slave part of the trough
	if not subMenu and isoObject:getFluidContainer() then
		subMenu = ISWorldObjectContextMenu.doFluidContainerMenu(context, isoObject, player);
	end

	-- if we don't have submenu it means we can't have water currently, only food, still needs to create the submenu
	if not subMenu then
		local menuName = ISWorldObjectContextMenu.getMoveableDisplayName(isoObject) or isoObject:getFluidUiName();
		local subOption = context:addOption(menuName, worldobjects, nil);
		subMenu = ISContextMenu:getNew(context);
		context:addSubMenu(subOption, subMenu);
	end

	local option
	local tooltip

	option = subMenu:addOption(getText("ContextMenu_FeedingTrough_Info"), isoObject, ISFeedingTroughMenu.onInfo, playerObj)
	option.iconTexture = getTexture("media/ui/inventoryPanes/Button_Info.png")

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

	if not isoObject:getFluidContainer() then
		isoObject:createFluidContainer();
	end
	isoObject:addWater(FluidType.TaintedWater, isoObject:getMaxWater());

	isoObject:checkOverlayAfterAnimalEat();
end

ISFeedingTroughMenu.onRemoveFoodDebug = function(playerObj, isoObject)
	isoObject:getContainer():removeAllItems();

	if not isoObject:getFluidContainer() then
		isoObject:createFluidContainer();
	end

	isoObject:checkOverlayAfterAnimalEat();
end

ISFeedingTroughMenu.onAddFoodDebug = function(playerObj, isoObject)
	isoObject:removeFluidContainer();
	if not isoObject:getContainer() then
		isoObject:setContainer(ItemContainer.new());
	end

	isoObject:getContainer():addItems(ItemKey.Drainable.ANIMAL_FEED_BAG, 2)

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

--Events.OnFillWorldObjectContextMenu.Add(ISFeedingTroughMenu.OnFillWorldObjectContextMenu)