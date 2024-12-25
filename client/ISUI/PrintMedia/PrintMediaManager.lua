PrintMediaManager = ISBaseObject:derive("PrintMediaManager");

function PrintMediaManager:update()
	if self.panel == nil then
		self.panel = ISPrintMediaPanel:new(0, 0, 200, 200);
		self.panel:initialise();
		self.panel:addToUIManager();

		self.panel:setX((getCore():getScreenWidth() / 2) - (self.panel.width / 2) - 500);
		self.panel:setY((getCore():getScreenHeight() / 2) - (self.panel.height / 2));

		ISLayoutManager.RegisterWindow('PrintMedia', PrintMediaManager, self) 
	end
-- 	if self.panel2 == nil then
-- 		self.panel2 = ISPrintMediaPage:new(0, 0, 200, 200, 1);
-- 		self.panel2:initialise();
-- 		self.panel2:addToUIManager();
--
-- 		self.panel2:setX((getCore():getScreenWidth() / 2) - (self.panel.width / 2));
-- 		self.panel2:setY((getCore():getScreenHeight() / 2) - (self.panel.height / 2));
--
-- 		ISLayoutManager.RegisterWindow('PrintMedia', PrintMediaManager, self)
-- 	end
end

function PrintMediaManager:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self
    return o
end

-- function PrintMediaManager:RestoreLayout(name, layout)
	-- -- Only save/restore visibility, the size/position is fixed
	-- -- if not getCore():getOptionShowPrintMedia() then
		-- -- self.panel:setVisible(false);
	-- -- end

    -- -- always show the guide for beginner
    -- if getCore():getGameMode() == "Beginner" then
        -- self.panel:setVisible(true);
        -- self.panel:setX(getCore():getScreenWidth()/2 - self.panel.width / 2);
        -- self.panel:setY(getCore():getScreenHeight()/2 - self.panel.height / 2);
        -- self.panel.rightPanel.tickBox:setVisible(false);
    -- end

    -- -- if self.panel.rightPanel.tickBox then
        -- -- self.panel.rightPanel.tickBox:setSelected(1, getCore():getOptionShowPrintMedia());
    -- -- end
-- end

-- function PrintMediaManager:SaveLayout(name, layout)
	-- -- Only save/restore visibility, the size/position is fixed
    -- if self.panel then
        -- if getCore():getOptionShowPrintMedia() then
            -- layout.visible = 'true';
        -- else
            -- layout.visible = 'false';
        -- end
        -- ISLayoutManager.SaveWindowVisible(self.panel, layout);
    -- end
-- end

function doPrintMediaDebug()
-- 	Events.OnTick.Remove(doPrintMedia);
	if isServer() then return; end
    -- hide it for tut
--    if getCore():getGameMode() == "Tutorial" and not getCore():isTutorialDone() then
--        return;
--    end
    -- only happens on single player so no splitscreen support required.
--     if PrintMediaManager.instance == nil then
        PrintMediaManager.instance = PrintMediaManager:new();
		PrintMediaManager.instance:update();
--     end

    -- if (getCore():getGameMode() == "Tutorial" and PrintMediaManager.blockPrintMedia) or (isDemo() and ISDemoPopup.instance ~= nil) then
        -- PrintMediaManager.instance.panel:setVisible(false);
    -- elseif getCore():getOptionShowPrintMedia() then
		-- PrintMediaManager.instance.panel:setVisible(true);
	-- end

-- 	if PrintMediaManager.instance.panel:isVisible() then
-- 		local joypadData = JoypadState.players[1]
-- 		if joypadData and not joypadData.focus then
-- 			joypadData.focus = PrintMediaManager.instance.panel
-- 		end
-- 	end
end

-- -- FIXME: this won't work for new players?
-- PrintMediaManager.OnNewGame = function()
	-- if isServer() then return; end
	-- Events.OnTick.Add(doPrintMedia);
-- end


-- PrintMediaManager.onKeyPressed = function(key)
	-- if getCore():isKey("Toggle Survival Guide", key) and not PrintMediaManager.blockPrintMedia then
		-- if PrintMediaManager.instance == nil then
			-- Events.OnTick.Add(doPrintMedia);
		-- else
			-- local panel = PrintMediaManager.instance.panel
			-- panel:setVisible(not panel:getIsVisible());
			-- local joypadData = JoypadState.players[1]
			-- if panel:isVisible() then
				-- if joypadData and joypadData.focus ~= panel then
					-- joypadData.focus = panel
				-- end
			-- else
				-- if joypadData then
					-- joypadData.focus = nil
				-- end
			-- end
		-- end
	-- end
-- end

-- PrintMediaManager.OnGameStart = function()
	-- if JoypadState.players[1] then return end
-- --[[ PrintMediaEntries.addEntry11 does nothing
	-- if getCore():isShowFirstTimeSneakTutorial() and getCore():getGameMode() ~= "Tutorial" then
		-- if PrintMediaManager.instance == nil then
			-- PrintMediaManager.instance = PrintMediaManager:new();
			-- PrintMediaManager.instance:update();
		-- end
		-- local panel = PrintMediaManager.instance.panel
		-- panel:setVisible(true);
		-- panel:setPage(11)
		-- getCore():setShowFirstTimeSneakTutorial(false);
		-- getCore():saveOptions();
	-- end
-- --]]
-- end
-- PrintMediaManager.OnCreatePlayer = function()
	-- -- ensure respawning players get the survival guide if they haven't disabled it
	-- Events.OnTick.Add(doPrintMedia);
-- end
-- --Events.OnGameStart.Add(PrintMediaManager.OnGameStart)
-- Events.OnCreatePlayer.Add(PrintMediaManager.OnCreatePlayer)
-- --Events.OnEnterVehicle.Add(PrintMediaManager.onEnterVehicle);
-- Events.OnKeyPressed.Add(PrintMediaManager.onKeyPressed);
-- --Events.OnNewGame.Add(PrintMediaManager.OnNewGame);
-- Events.OnTick.Add(doPrintMedia);
-- --~ Events.OnMainMenuEnter.Add(doPrintMedia);
