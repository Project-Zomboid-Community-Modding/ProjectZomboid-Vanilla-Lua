local function CreateSourceItem1(recipe, source, sourceFullType)
	local item = nil
	if sourceFullType == "Water" then
		item = InventoryItemFactory.CreateItem("Base.WaterBottleFull")
		item:setUsedDelta(item:getUseDelta()) -- a single use
	elseif source:isDestroy() then
		item = InventoryItemFactory.CreateItem(sourceFullType)
	elseif getScriptManager():isDrainableItemType(sourceFullType) then
		item = InventoryItemFactory.CreateItem(sourceFullType)
		item:setUsedDelta(item:getUseDelta()) -- a single use
	elseif source:getUse() > 0 then
		item = InventoryItemFactory.CreateItem(sourceFullType)
		if not instanceof(item, "Food") then error(sourceFullType..' is not food') end
		item:setHungChange(-source:getUse() / 100)
	else
		item = InventoryItemFactory.CreateItem(sourceFullType)
	end
	if recipe:getOriginalname() == "Insert Battery into Flashlight" and sourceFullType == "Base.Torch" then
		item:setUsedDelta(0.0)
	end
	if recipe:getOriginalname() == "Slice Fillet" and not source:isKeep() then -- the fish
		item:setActualWeight(1.1) -- must be > 1
	end
	return item
end

local containers = nil
local pack = nil

local function addToInv(item)
	local playerObj = getPlayer()
--	playerObj:getInventory():AddItem(item)
	while true do
		local r = ZombRand(containers:size())
		if containers:get(r):getType() ~= "floor" then -- TODO: world inventory items
			containers:get(r):AddItem(item)
			break
		end
	end
	return item
end

local function getNumberOfItem(sourceFullType)
	local count = 0
	for i=1,containers:size() do
		count = count + containers:get(i-1):getNumberOfItem(sourceFullType)
	end
	return count
end

local itemText = {}

local function CreateSourceItem2(recipe, source, sourceFullType)
	local playerObj = getPlayer()
	local item = nil
	if sourceFullType == "Water" then
		for i=1,source:getCount() do
			item = addToInv(CreateSourceItem1(recipe, source, sourceFullType))
			table.insert(itemText, '  '..sourceFullType.. ' uses='..item:getDrainableUsesInt()..'/'..source:getCount())
		end
	elseif source:isDestroy() then
		for i=1,source:getCount() do
			item = addToInv(CreateSourceItem1(recipe, source, sourceFullType))
			table.insert(itemText, '  '..sourceFullType..' '..getNumberOfItem(sourceFullType)..'/'..source:getCount())
		end
	elseif getScriptManager():isDrainableItemType(sourceFullType) then
		item = addToInv(CreateSourceItem1(recipe, source, sourceFullType))
		table.insert(itemText, '  '..sourceFullType.. ' uses='..item:getDrainableUsesInt()..'/'..source:getCount())
	elseif source:getUse() > 0 then
		item = addToInv(CreateSourceItem1(recipe, source, sourceFullType))
		table.insert(itemText, '  '..sourceFullType..' '..math.floor(-item:getHungerChange()*100)..'/'..source:getUse())
	else
		for i=1,source:getCount() do
			item = addToInv(CreateSourceItem1(recipe, source, sourceFullType))
			table.insert(itemText, '  '..sourceFullType..' '..getNumberOfItem(sourceFullType)..'/'..source:getCount())
		end
	end
end

local function CreateSourceItem(recipe, source, sourceFullType)
	local playerObj = getPlayer()
	if sourceFullType == "Water" then
		CreateSourceItem2(recipe, source, sourceFullType)
	elseif source:isDestroy() then
		CreateSourceItem2(recipe, source, sourceFullType)
	elseif source:getUse() > 0 then
		CreateSourceItem2(recipe, source, sourceFullType)
	elseif getScriptManager():isDrainableItemType(sourceFullType) then
		for i=1,source:getCount() do
			CreateSourceItem2(recipe, source, sourceFullType)
		end
	else
		CreateSourceItem2(recipe, source, sourceFullType)
	end
end

local bag = nil
local pause = 0

local function SetupContainers()
	local playerObj = getPlayer()
	playerObj:getInventory():removeAllItems()
	playerObj:setClothingItem_Torso(nil)
	playerObj:setClothingItem_Feet(nil)
	playerObj:setClothingItem_Legs(nil)
	playerObj:setPrimaryHandItem(nil)
	playerObj:setSecondaryHandItem(nil)
	-- FIXME: clear all loot-window containers
	bag = InventoryItemFactory.CreateItem('Base.Bag_BigHikingBag')
	playerObj:getInventory():AddItem(bag)
	playerObj:setClothingItem_Back(bag)
	getPlayerInventory(playerObj:getPlayerNum()):refreshBackpacks()
	getPlayerLoot(playerObj:getPlayerNum()):refreshBackpacks()
	containers = ISInventoryPaneContextMenu.getContainers(playerObj)
end

local theRecipe = nil
local multiSourceIndex = 2

local function TestRecipe(recipe)
	local playerObj = getPlayer()
	print(recipe:getOriginalname())
	
	for i=1,containers:size() do
		local container = containers:get(i-1)
		for j=1,container:getItems():size() do
			local item = container:getItems():get(j-1)
			getCell():getProcessItems():remove(item)
		end
		containers:get(i-1):removeAllItems()
	end
	playerObj:getInventory():AddItem(bag)
	playerObj:setClothingItem_Back(bag)
	getPlayerInventory(playerObj:getPlayerNum()):refreshBackpacks()
	getPlayerLoot(playerObj:getPlayerNum()):refreshBackpacks()
	containers = ISInventoryPaneContextMenu.getContainers(playerObj)

	-- Create the ingredients
	itemText = {}
	for j=1,recipe:getSource():size() do
		local source = recipe:getSource():get(j-1)
		if source:getItems():size() > 1 then
--			for k=1,source:getItems():size() do
				local sourceFullType = source:getItems():get(multiSourceIndex-1)
				CreateSourceItem(recipe, source, sourceFullType)
--				break;
--			end
		else
			local sourceFullType = source:getOnlyItem()
			CreateSourceItem(recipe, source, sourceFullType)
		end
	end

	local numberOfTimes = RecipeManager.getNumberOfTimesRecipeCanBeDone(recipe, playerObj, containers, nil)
	if numberOfTimes ~= 1 then
		print('  #times=' .. tostring(numberOfTimes) .. ' expected 1')
	end
	
	-- Test with each source as selectedItem
	for i=1,containers:size() do
		local container = containers:get(i-1)
		for j=1,container:getItems():size() do
			local item = container:getItems():get(j-1)
			if item ~= bag then
				local valid = RecipeManager.IsRecipeValid(recipe, playerObj, item, containers)
				if not valid then
					print('  valid='..tostring(valid)..' with selectedItem='..item:getFullType())
					for k=1,#itemText do
						print(itemText[k])
					end
				end
			end
		end
	end
	if not RecipeManager.IsRecipeValid(recipe, playerObj, null, containers) then
		print('  valid=false '..' known='..tostring(playerObj:isRecipeKnown(recipe)))
		for k=1,#itemText do
			print(itemText[k])
		end
	else
		print('  valid=true')
		if true then
			for i=1,100 do
				local r = ZombRand(containers:size())
				local container = containers:get(r)
				if not container:getItems():isEmpty() then
					r = ZombRand(container:getItems():size())
					local selectedItem = container:getItems():get(r)
					if selectedItem ~= bag then
						print('  OnCraft with selectedItem='..selectedItem:getFullType())
						ISInventoryPaneContextMenu.OnCraft(selectedItem, recipe, playerObj:getPlayerNum(), false)
						theRecipe = recipe
						pause = getPerformance():getFramerate() * 1
						return
					end
				end
			end
		end
		
		local resultItem = RecipeManager.PerformMakeItem(recipe, null, playerObj, containers)
	end
end

local function PostValidate(recipe)
	local resultFullType = recipe:getResult():getFullType()
	local resultScriptItem = getScriptManager():FindItem(resultFullType)
	if resultScriptItem then
		local countFound = getNumberOfItem(resultFullType)
		local countExpected = recipe:getResult():getCount() * resultScriptItem:getCount()
		if countFound ~= countExpected then
			print('  ERROR result not created '..resultFullType..' '..tostring(countFound)..'/'..tostring(countExpected))
		end
	else
		print('  ERROR result '..resultFullType..' doesn\'t exist')
	end
	for j=1,recipe:getSource():size() do
		local source = recipe:getSource():get(j-1)
		local sourceFullType = nil
		if source:getItems():size() > 1 then
--			for k=1,source:getItems():size() do
				sourceFullType = source:getItems():get(multiSourceIndex-1)
--				break;
--			end
		else
			sourceFullType = source:getOnlyItem()
		end
		local count = getNumberOfItem(sourceFullType)
		if source:isDestroy() then
			if count > 0 and recipe:getResult():getFullType() ~= sourceFullType then
				print('  ERROR wasn\'t destroyed '..sourceFullType)
			end
		elseif source:isKeep() then
			if count == 0 then
				print('  ERROR wasn\'t kept '..sourceFullType)
			end
		elseif count ~= 0 then
			print('  ERROR wasn\'t used up '..sourceFullType)
		end
	end
	print('  validated')
end

local function ShouldSkipRecipe(recipe)
	if recipe == nil then return true end
	if recipe:getNearItem() and recipe:getNearItem() ~= "" then return true end
	return false
end

local tickRegistered = false
local recipesToTest = {}

local function OnTick()
	if isKeyDown(Keyboard.KEY_ESCAPE) then
		table.wipe(recipesToTest)
	end
	local playerObj = getPlayer()
	local queue = ISTimedActionQueue.getTimedActionQueue(playerObj)
	if not queue or not queue.queue or not queue.queue[1] then
		if theRecipe then
			PostValidate(theRecipe)
			theRecipe = nil
		end
		if #recipesToTest == 0 then return end
		if pause > 0 then -- pause so we can view the result
			pause = pause - 1
			return
		end
		local recipe = recipesToTest[1]
		table.remove(recipesToTest, 1)
		if not ShouldSkipRecipe(recipe) then
			TestRecipe(recipe)
		end
	end
end

-- Call from debug console to test one recipe (or several with the same name)
function RecipeTestOne(recipeName)
	local playerObj = getPlayer()
	SetupContainers()
	local recipes = getAllRecipes()
	recipesToTest = {}
	for i=1,recipes:size() do
		local recipe = recipes:get(i-1)
		if recipe:getOriginalname() == recipeName or
				(recipe:getModule():getName() .. "." .. recipe:getOriginalname()) == recipeName then
			table.insert(recipesToTest, recipe)
		end
	end
	if #recipesToTest == 0 then
		print('recipe '..recipeName..' not found, try adding module as module.name')
		return
	end
	if not tickRegistered then
		Events.OnTick.Add(OnTick)
		tickRegistered = true
	end
end

-- Call from debug console to test every recipe
function RecipeTestAll()
	local playerObj = getPlayer()
	SetupContainers()
	local recipes = getAllRecipes()
	recipesToTest = {}
	for i=1,recipes:size() do
		local recipe = recipes:get(i-1)
		table.insert(recipesToTest, recipe)
	end
--	TestRecipe(recipe)
	if not tickRegistered then
		Events.OnTick.Add(OnTick)
		tickRegistered = true
	end
end

-- Call from debug console to check available but less-than-needed items
function RecipeTestAvailableItems()
	local playerObj = getPlayer()
	if containers then
		for i=1,containers:size() do
			local container = containers:get(i-1)
			for j=1,container:getItems():size() do
				local item = container:getItems():get(j-1)
				getCell():getProcessItems():remove(item)
			end
			containers:get(i-1):removeAllItems()
		end
	end
	SetupContainers()
	local item1 = playerObj:getInventory():AddItem("Base.Needle")
	local item2 = playerObj:getInventory():AddItem("Base.Thread")
	local item3 = playerObj:getInventory():AddItem("Base.Sheet") -- too few on purpose
	local item4 = playerObj:getInventory():AddItem("Base.Pillow") -- too few on purpose
	local recipe = ScriptManager.instance:getRecipe("Base.Make Mattress")
	local items = RecipeManager.getAvailableItemsAll(recipe, playerObj, containers, nil, nil)
	if items:contains(item1) and items:contains(item2) and items:contains(item3) and items:contains(item4) then
		print('PASSED (all)')
	else
		print('FAILED (all)')
	end
	items = RecipeManager.getAvailableItemsNeeded(recipe, playerObj, containers, nil, nil)
	if items:isEmpty() then
		print('PASSED (needed)')
	else
		print('FAILED (needed)')
	end
end

-- Call from debug console to check if water sources are counted properly
function RecipeTestNumberOfTimes()
	local playerObj = getPlayer()
	if containers then
		for i=1,containers:size() do
			local container = containers:get(i-1)
			for j=1,container:getItems():size() do
				local item = container:getItems():get(j-1)
				getCell():getProcessItems():remove(item)
			end
			containers:get(i-1):removeAllItems()
		end
	end
	SetupContainers()
	local item = playerObj:getInventory():AddItem("Base.WaterMug") -- 1 use of water
	local item = playerObj:getInventory():AddItem("Base.WaterMug") -- 1 use of water
	playerObj:getInventory():AddItem("Base.BandageDirty")
	playerObj:getInventory():AddItem("Base.BandageDirty")
	playerObj:getInventory():AddItem("Base.BandageDirty")
	local recipe = ScriptManager.instance:getRecipe("Base.Clean Bandage")
	local numberOfTimes = RecipeManager.getNumberOfTimesRecipeCanBeDone(recipe, playerObj, containers, nil)
	if numberOfTimes == 2 then
		print('PASSED')
	else
		print('FAILED')
	end
end

-- Call from debug console to check if the selected item is the one used.
function RecipeTestSelectedItem()
	local playerObj = getPlayer()
	if containers then
		for i=1,containers:size() do
			local container = containers:get(i-1)
			for j=1,container:getItems():size() do
				local item = container:getItems():get(j-1)
				getCell():getProcessItems():remove(item)
			end
			containers:get(i-1):removeAllItems()
		end
	end
	SetupContainers()
	-- Could rip Sheet or Vest.  Select the item that comes last in the list of ingredients.
	local item1 = playerObj:getInventory():AddItem("Base.Sheet")
	local item2 = playerObj:getInventory():AddItem("Base.Vest")
	local selectedItem = item1
	local recipe = ScriptManager.instance:getRecipe("Base.Rip sheets")
	if recipe:getSource():get(0):getItems():indexOf("Base.Sheet") < recipe:getSource():get(0):getItems():indexOf("Base.Vest") then
		selectedItem = item2
	end
	local resultItem = RecipeManager.PerformMakeItem(recipe, selectedItem, playerObj, containers)
	if playerObj:getInventory():contains(selectedItem) then
		print('FAILED')
	else
		print('PASSED')
	end
end


