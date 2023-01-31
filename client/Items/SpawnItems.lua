-------------------------------------------------
-------------------------------------------------
--
-- SpawnItems
--
-- eris
--
-------------------------------------------------
-------------------------------------------------
local SpawnItems = {};

function SpawnItems.OnNewGame(playerObj, square)
	-- spawn with a belt
	local belt = playerObj:getInventory():AddItem("Base.Belt2");
	playerObj:setWornItem(belt:getBodyLocation(), belt);

	-- add StarterKit if configured
	if SandboxVars.StarterKit then
		local bag = playerObj:getInventory():AddItem("Base.Bag_Schoolbag");
		local bat = bag:getItemContainer():AddItem("Base.BaseballBat");
		bat:setCondition(7);
		local hammer = bag:getItemContainer():AddItem("Base.Hammer");
		hammer:setCondition(5);
		playerObj:getInventory():AddItem("Base.WaterBottleFull");
		playerObj:getInventory():AddItem("Base.Crisps");
		playerObj:setClothingItem_Back(bag);
	end;

	-- add starting items (depends on difficulty)
	if getWorld():getDifficulty() == "Easy" then
		local bag =  playerObj:getInventory():FindAndReturn("Base.Bag_Schoolbag");
		if not bag then
			bag = playerObj:getInventory():AddItem("Base.Bag_Schoolbag");
			playerObj:getInventory():AddItem("Base.WaterBottleFull");
			bag:getItemContainer():AddItem("Base.BaseballBat");
			bag:getItemContainer():AddItem("Base.Hammer");
			playerObj:getInventory():AddItem("Base.Crisps");
			playerObj:setClothingItem_Back(bag);
		end;
		bag:getItemContainer():AddItem("Base.Saw");
		playerObj:getInventory():AddItem("Base.Crisps2");
		playerObj:getInventory():AddItem("Base.Crisps3");
	elseif getWorld():getDifficulty() == "Normal" then
		local bag =  playerObj:getInventory():FindAndReturn("Base.Bag_Schoolbag");
		if not bag then
			bag = playerObj:getInventory():AddItem("Base.Bag_Schoolbag");
			local bat = bag:getItemContainer():AddItem("Base.BaseballBat");
			bat:setCondition(7);
			local hammer = bag:getItemContainer():AddItem("Base.Hammer");
			hammer:setCondition(5);
			playerObj:setClothingItem_Back(bag);
		end;
		playerObj:getInventory():AddItem("Base.WaterBottleFull");
		playerObj:getInventory():AddItem("Base.Crisps");
	elseif getWorld():getDifficulty() == "Hard" then
		playerObj:getInventory():AddItem("Base.WaterBottleFull");
		playerObj:getInventory():AddItem("Base.Crisps");
	end;

	-- give the new players the SpawnItem if configured (MP Only)
	if isClient() then
		if getServerOptions():getOption("SpawnItems") and getServerOptions():getOption("SpawnItems")~= "" then
			local items = luautils.split(getServerOptions():getOption("SpawnItems"), ",");
			for i,v in pairs(items) do
				playerObj:getInventory():AddItem(v);
			end;
		end;
	end;
end

function SpawnItems.OnGameStart()
	-- temp, need to remove this & option when everyone got it basically...
	if not getCore():gotNewBelt() then
		local playerObj = getSpecificPlayer(0);
		local belt = playerObj:getInventory():AddItem("Base.Belt2");
		playerObj:setWornItem(belt:getBodyLocation(), belt);
		getCore():setGotNewBelt(true);
		getCore():saveOptions();
		local hotbar = getPlayerHotbar(0);
		if hotbar then
			hotbar:refresh();
		end;
	end;
end

-------------------------------------------------
-------------------------------------------------
Events.OnNewGame.Add(SpawnItems.OnNewGame);
Events.OnGameStart.Add(SpawnItems.onNewGame);
-------------------------------------------------
-------------------------------------------------