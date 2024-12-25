SurvivalGuideManager = ISBaseObject:derive("SurvivalGuideManager");

function SurvivalGuideManager:update()
	if self.panel == nil then
		self.panel = ISTutorialPanel:new(0, 0, 200, 200);
		self.panel:initialise();
		self.panel:addToUIManager();

		self.panel:setX((getCore():getScreenWidth() / 2) - (self.panel.width / 2));
		self.panel:setY((getCore():getScreenHeight() / 2) - (self.panel.height / 2));

		ISLayoutManager.RegisterWindow('survivalguide', SurvivalGuideManager, self) 
	end
end

function SurvivalGuideManager:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function SurvivalGuideManager:RestoreLayout(name, layout)
	-- Only save/restore visibility, the size/position is fixed
	if not getCore():getOptionShowSurvivalGuide() then
		self.panel:setVisible(false);
	end

    -- always show the guide for beginner
    if getCore():getGameMode() == "Beginner" then
        self.panel:setVisible(true);
        self.panel:setX(getCore():getScreenWidth()/2 - self.panel.width / 2);
        self.panel:setY(getCore():getScreenHeight()/2 - self.panel.height / 2);
        self.panel.rightPanel.tickBox:setVisible(false);
    end

    if self.panel.rightPanel.tickBox then
        self.panel.rightPanel.tickBox:setSelected(1, getCore():getOptionShowSurvivalGuide());
    end
end

function SurvivalGuideManager:SaveLayout(name, layout)
	-- Only save/restore visibility, the size/position is fixed
    if self.panel then
        if getCore():getOptionShowSurvivalGuide() then
            layout.visible = 'true';
        else
            layout.visible = 'false';
        end
        ISLayoutManager.SaveWindowVisible(self.panel, layout);
    end
end

function doSurvivalGuide()
	Events.OnTick.Remove(doSurvivalGuide);
	if isServer() then return; end
    -- hide it for tut
--    if getCore():getGameMode() == "Tutorial" and not getCore():isTutorialDone() then
--        return;
--    end
    -- only happens on single player so no splitscreen support required.
    if SurvivalGuideManager.instance == nil then
        SurvivalGuideManager.instance = SurvivalGuideManager:new();
		SurvivalGuideManager.instance:update();
    end

    if (getCore():getGameMode() == "Tutorial" and SurvivalGuideManager.blockSurvivalGuide) or (isDemo() and ISDemoPopup.instance ~= nil) then
        SurvivalGuideManager.instance.panel:setVisible(false);
    elseif getCore():getOptionShowSurvivalGuide() then
		SurvivalGuideManager.instance.panel:setVisible(true);
	end

	if SurvivalGuideManager.instance.panel:isVisible() then
		local joypadData = JoypadState.players[1]
		if joypadData and not joypadData.focus then
			joypadData.focus = SurvivalGuideManager.instance.panel
		end
	end
end

-- FIXME: this won't work for new players?
SurvivalGuideManager.OnNewGame = function()
	if isServer() then return; end
	Events.OnTick.Add(doSurvivalGuide);
end


SurvivalGuideManager.onKeyPressed = function(key)
	if getCore():isKey("Toggle Survival Guide", key) and not SurvivalGuideManager.blockSurvivalGuide then
		if SurvivalGuideManager.instance == nil then
			Events.OnTick.Add(doSurvivalGuide);
		else
			local panel = SurvivalGuideManager.instance.panel
			panel:setVisible(not panel:getIsVisible());
			local joypadData = JoypadState.players[1]
			if panel:isVisible() then
				if joypadData and joypadData.focus ~= panel then
					joypadData.focus = panel
				end
			else
				if joypadData then
					joypadData.focus = nil
				end
			end
		end
	end
end

SurvivalGuideManager.OnGameStart = function()
	if JoypadState.players[1] then return end
--[[ SurvivalGuideEntries.addEntry11 does nothing
	if getCore():isShowFirstTimeSneakTutorial() and getCore():getGameMode() ~= "Tutorial" then
		if SurvivalGuideManager.instance == nil then
			SurvivalGuideManager.instance = SurvivalGuideManager:new();
			SurvivalGuideManager.instance:update();
		end
		local panel = SurvivalGuideManager.instance.panel
		panel:setVisible(true);
		panel:setPage(11)
		getCore():setShowFirstTimeSneakTutorial(false);
		getCore():saveOptions();
	end
--]]
end
SurvivalGuideManager.OnCreatePlayer = function()
	-- ensure respawning players get the survival guide if they haven't disabled it
	Events.OnTick.Add(doSurvivalGuide);
end
--Events.OnGameStart.Add(SurvivalGuideManager.OnGameStart)
Events.OnCreatePlayer.Add(SurvivalGuideManager.OnCreatePlayer)
--Events.OnEnterVehicle.Add(SurvivalGuideManager.onEnterVehicle);
Events.OnKeyPressed.Add(SurvivalGuideManager.onKeyPressed);
--Events.OnNewGame.Add(SurvivalGuideManager.OnNewGame);
Events.OnTick.Add(doSurvivalGuide);
--~ Events.OnMainMenuEnter.Add(doSurvivalGuide);
