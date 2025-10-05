--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

ISUIHandler = {};
ISUIHandler.allUIVisible = true;
ISUIHandler.visibleUI = {};

ISUIHandler.setVisibleAllUI = function(visible)
	local ui = UIManager.getUI();
	-- if we asked for not visible, we're gonna fetch all our UI, and if they are visible we get them invisible + we keep wich one we closed
	-- into a map, so when we're going to set them visible, we know exactly wich one to set visible
	if not visible then
		for i=0,ui:size()-1 do
			if ui:get(i):isVisible() then
				table.insert(ISUIHandler.visibleUI, ui:get(i):toString());
				ui:get(i):setVisible(false);
			end
		end
	else
		for i,v in ipairs(ISUIHandler.visibleUI) do
			for i=0,ui:size()-1 do
				if v == ui:get(i):toString() then
					ui:get(i):setVisible(true);
					break;
				end
			end
		end
		table.wipe(ISUIHandler.visibleUI);
	end
	UIManager.setVisibleAllUI(visible)
end

ISUIHandler.toggleUI = function()
    ISUIHandler.allUIVisible = not ISUIHandler.allUIVisible;
    ISUIHandler.setVisibleAllUI(ISUIHandler.allUIVisible);
end

--ISUIHandler.showPing = function()
--    getCore():setShowPing(not getCore():isShowPing());
--end

ISUIHandler.onKeyStartPressed = function(key)
    if not getCore():isKey("VehicleRadialMenu", key) and
            not getCore():isKey("AnimalRadialMenu", key) then
        return
    end
	local playerObj = getSpecificPlayer(0)
	if not playerObj then return end
	if playerObj:isDead() then return end
	local vehicle = ISVehicleMenu.getVehicleToInteractWith(playerObj)
	local animal = AnimalContextMenu.getAnimalToInteractWith(playerObj)
    -- 'V' can be 'Toggle UI' when outside a vehicle
    if getCore():isKey("Toggle UI", key) and getCore():getGameMode() ~= "Tutorial" and not vehicle and not animal then
        return
    end
	if getCore():isKey("VehicleRadialMenu", key) then
		if vehicle then
			ISVehicleMenu.showRadialMenu(playerObj)
			return;
		end
	end
	if getCore():isKey("AnimalRadialMenu", key) then
		AnimalContextMenu.showRadialMenu(playerObj)
		return;
	end
end

ISUIHandler.onKeyPressed = function(key)
    if not getCore():isKey("VehicleRadialMenu", key) and
            not getCore():isKey("AnimalRadialMenu", key) and
            not getCore():isKey("Toggle UI", key) then
        return
    end
	local playerObj = getSpecificPlayer(0)
	if not playerObj then return end
	local vehicle = ISVehicleMenu.getVehicleToInteractWith(playerObj)
	local animal = AnimalContextMenu.getAnimalToInteractWith(playerObj)
    -- 'V' can be 'Toggle UI' when outside a vehicle
    if getCore():isKey("Toggle UI", key) and getCore():getGameMode() ~= "Tutorial" and not vehicle and not animal then
        ISUIHandler.toggleUI()
        return
    end
	if getCore():isKey("VehicleRadialMenu", key) then
		if playerObj:isDead() then return end
		if not getCore():getOptionRadialMenuKeyToggle() then
			-- Hide radial menu when 'V' is released.
			local menu = getPlayerRadialMenu(0)
			if menu:isReallyVisible() and vehicle then
				ISVehicleMenu.showRadialMenu(playerObj)
				return;
			end
		end
	end
	if getCore():isKey("AnimalRadialMenu", key) then
		if playerObj:isDead() then return end
		if not getCore():getOptionRadialMenuKeyToggle() then
			-- Hide radial menu when 'V' is released.
			local menu = getPlayerRadialMenu(0)
			if menu:isReallyVisible() then
				AnimalContextMenu.showRadialMenu(playerObj)
				return;
			end
		end
		return
	end
--    if getCore():isKey("Show Ping", key) and isClient() then
--        ISUIHandler.showPing();
--    end
end

local function OnGameStart()
	Events.OnKeyStartPressed.Add(ISUIHandler.onKeyStartPressed);
	Events.OnKeyPressed.Add(ISUIHandler.onKeyPressed);
end

Events.OnGameStart.Add(OnGameStart)
