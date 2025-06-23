--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISPanel"

ISVehicleDashboard = ISPanel:derive("ISVehicleDashboard")

function ISVehicleDashboard:createChildren()
	self.backgroundTex = ISImage:new(100,35, self.dashboardBG:getWidth(), self.dashboardBG:getHeight(), self.dashboardBG);
	self.backgroundTex:initialise();
	self.backgroundTex:instantiate();
	self:addChild(self.backgroundTex);


--	self.btn_partEngine = ISButton:new(100, 53, 35, 35, "", self, ISVehicleDashboard.onMouseDown);
--	self.btn_partEngine:setTooltip("Engine");
--	self.btn_partEngine.internal = "ENGINE";
--	self.btn_partEngine:initialise();
--	self.btn_partEngine:instantiate();
--	self.btn_partEngine.borderColor = {r=1, g=1, b=1, a=0};
--	self.btn_partEngine:setImage(self.texEngine);
--	self:addChild(self.btn_partEngine);
	
	self.btn_partSpeed = ISLabel:new(100, 53, 24, "S", 1,1,1,0.85, UIFont.Small);
	self.btn_partSpeed:initialise();
	self.btn_partSpeed:instantiate();
	self.btn_partSpeed.tooltip = getText("Tooltip_Dashboard_Shift")
	self:addChild(self.btn_partSpeed);
	
	self.doorTex = ISImage:new(200,35, self.iconDoor:getWidthOrig(), self.iconDoor:getHeightOrig(), self.iconDoor);
	self.doorTex:initialise();
	self.doorTex:instantiate();
	self.doorTex.onclick = ISVehicleDashboard.onClickDoors;
	self.doorTex.target = self;
	self.doorTex.mouseovertext = getText("Tooltip_Dashboard_LockedDoors")
	self:addChild(self.doorTex);

	self.engineTex = ISImage:new(100,35, self.iconEngine:getWidthOrig(), self.iconEngine:getHeightOrig(), self.iconEngine);
	self.engineTex:initialise();
	self.engineTex:instantiate();
	self.engineTex.onclick = ISVehicleDashboard.onClickEngine;
	self.engineTex.mouseovertext = getText("Tooltip_Dashboard_Engine")
	self.engineTex.target = self;
	self:addChild(self.engineTex);
	
-- 	self.lightsTex = ISImage:new(250,35, self.iconLights:getWidthOrig(), self.iconLights:getHeightOrig(), self.iconLights);
	self.lightsTex = ISImage:new(300,35, self.iconLights:getWidthOrig(), self.iconLights:getHeightOrig(), self.iconLights);
	self.lightsTex:initialise();
	self.lightsTex:instantiate();
	self.lightsTex.onclick = ISVehicleDashboard.onClickHeadlights;
	self.lightsTex.mouseovertext = getText("Tooltip_Dashboard_Headlights")
	self.lightsTex.target = self;
	self:addChild(self.lightsTex);
	
	self.radioTex = ISImage:new(350,35, self.iconRadio:getWidthOrig()/2, self.iconRadio:getHeightOrig()/2, self.iconRadio);
-- 	self.radioTex = ISImage:new(350,35, self.iconRadio:getWidthOrig(), self.iconRadio:getHeightOrig(), self.iconRadio);
    self.radioTex.scaledWidth = 16;
    self.radioTex.scaledHeight = 16;
	self.radioTex:initialise();
	self.radioTex:instantiate();
	self.radioTex.onclick = ISVehicleDashboard.onClickRadio;
	self.radioTex.mouseovertext = getText("Tooltip_Dashboard_Radio")
	self.radioTex.target = self;
	self:addChild(self.radioTex);


-- 	self.heaterTex = ISImage:new(450,35, self.iconHeater:getWidthOrig(), self.iconHeater:getHeightOrig(), self.iconHeater);
	self.heaterTex = ISImage:new(400,35, self.iconHeater:getWidthOrig(), self.iconHeater:getHeightOrig(), self.iconHeater);
	self.heaterTex:initialise();
	self.heaterTex:instantiate();
	self.heaterTex.onclick = ISVehicleDashboard.onClickHeater;
	self.heaterTex.mouseovertext = getText("Tooltip_Dashboard_Heater")
	self.heaterTex.target = self;
	self:addChild(self.heaterTex);

	self.ignitionTex = ISImage:new(500,35, self.iconIgnition:getWidthOrig(), self.iconIgnition:getHeightOrig(), self.iconIgnition);
	self.ignitionTex:initialise();
	self.ignitionTex:instantiate();
	self.ignitionTex.onclick = ISVehicleDashboard.onClickKeys;
	self.ignitionTex.target = self;
	self.ignitionTex.mouseovertext = getText("Tooltip_Dashboard_KeysIgnition")
	self:addChild(self.ignitionTex);
	
	self.batteryTex = ISImage:new(600,35, self.iconBattery:getWidthOrig(), self.iconBattery:getHeightOrig(), self.iconBattery);
	self.batteryTex:initialise();
	self.batteryTex:instantiate();
	self.batteryTex.mouseovertext = getText("Tooltip_Dashboard_Battery")
	self:addChild(self.batteryTex);
	
	self.trunkTex = ISImage:new(700,35, self.iconTrunk:getWidthOrig(), self.iconTrunk:getHeightOrig(), self.iconTrunk);
	self.trunkTex:initialise();
	self.trunkTex:instantiate();
	self.trunkTex.onclick = ISVehicleDashboard.onClickTrunk;
	self.trunkTex.target = self;
	self:addChild(self.trunkTex);

	self.speedregulatorTex = ISImage:new(14, 93, self.iconSpeedRegulator:getWidthOrig(), self.iconSpeedRegulator:getHeightOrig(), self.iconSpeedRegulator);
	self.speedregulatorTex:initialise();
	self.speedregulatorTex:instantiate();
	self.speedregulatorTex.mouseovertext = getText("Tooltip_Dashboard_SpeedRegulator", Keyboard.getKeyName(Keyboard.KEY_LSHIFT), Keyboard.getKeyName(getCore():getKey("Forward")), Keyboard.getKeyName(getCore():getKey("Backward")))
	self:addChild(self.speedregulatorTex);

	-- Use DebugConsole font which font-mods can't override.
--	self.outsidetemp = ISLabel:new(700, 35, self.engineTex.height, "???", 1, 1, 1, 1, UIFont.DebugConsole, true)
--	self.outsidetemp:initialise();
--	self.outsidetemp:instantiate();
--	self.outsidetemp.backgroundColor = {r=0.9,g=0.9,b=0.9,a=0.85};
--	self.outsidetemp.tooltip = getText("Tooltip_Dashboard_OutsideTemp");
--	self:addChild(self.outsidetemp);

	local x = (self.backgroundTex:getWidth() / 2) - 40
	local y = self.backgroundTex:getHeight() - self.gaugeFull:getHeight() - 20
	self.fuelGauge = ISVehicleGauge:new(x, y, self.gaugeFull, 40, 37, 180, 0)
	self.fuelGauge:initialise()
	self.fuelGauge:instantiate()
	self.fuelGauge:setNeedleWidth(25)
	self:addChild(self.fuelGauge)

	self.leftSideFuel = ISImage:new(x - 20 + 40, y + 55, self.leftSideFuelTex:getWidthOrig(), self.leftSideFuelTex:getHeightOrig(), self.leftSideFuelTex);
	self.leftSideFuel:initialise()
	self.leftSideFuel:instantiate()
	self:addChild(self.leftSideFuel)

	self.rightSideFuel = ISImage:new(x + 10 + 40, y + 55, self.rightSideFuelTex:getWidthOrig(), self.rightSideFuelTex:getHeightOrig(), self.rightSideFuelTex);
	self.rightSideFuel:initialise()
	self.rightSideFuel:instantiate()
	self:addChild(self.rightSideFuel)

	x = 85
	y = self.backgroundTex:getHeight() - self.engineGaugeTex:getHeight()
	self.engineGauge = ISVehicleGauge:new(x, y, self.engineGaugeTex, 64, 60, 180, 0)
	self.engineGauge:initialise()
	self.engineGauge:instantiate()
	self:addChild(self.engineGauge)

	x = self.backgroundTex:getWidth() - 211
	y = self.backgroundTex:getHeight() - self.speedGaugeTex:getHeight()
	self.speedGauge = ISVehicleGauge:new(x, y, self.speedGaugeTex, 64, 60, 180, 0)
	self.speedGauge:initialise()
	self.speedGauge:instantiate()
	self:addChild(self.speedGauge)

	self:onResolutionChange()
end

function ISVehicleDashboard.damageFlick(character)
	local dash = nil;
	if instanceof(character, 'IsoPlayer') and character:isLocalPlayer() then
		local vehicle = character:getVehicle()
		dash = getPlayerVehicleDashboard(character:getPlayerNum())
	end
	if dash then
		dash.flickAlpha = 0;
		dash.flickAlphaUp = true;
		dash.flickingTimer = 100;
	end
end

function ISVehicleDashboard:getAlphaFlick(default)
	if self.flickingTimer > 0 then
		self.flickingTimer = self.flickingTimer - 1;
		
		if self.flickAlphaUp then
			self.flickAlpha = self.flickAlpha + 0.2;
			if self.flickAlpha >= 1 then
				self.flickAlpha = 0.8;
				self.flickAlphaUp = false;
			end
		else
			self.flickAlpha = self.flickAlpha - 0.2;
			if self.flickAlpha <= 0 then
				self.flickAlpha = 0.2;
				self.flickAlphaUp = true;
			end
		end
		
		return self.flickAlpha;
	else
		return default;
	end
end

function ISVehicleDashboard:setVehicle(vehicle)
	self.vehicle = vehicle
	for _,gauge in ipairs(self.gauges) do
		gauge:setVisible(false)
	end
	self.gauges = {}
	if not vehicle then
		self:removeFromUIManager()
		return
	end
	local part = vehicle:getPartById("GasTank")
	if part and part:isContainer() and part:getContainerContentType() then
		self.gasTank = part
		if self.vehicle:isEngineRunning() then
			self.fuelValue = self.gasTank:getContainerContentAmount() / self.gasTank:getContainerCapacity()
		else
			self.fuelValue = 0.0
		end
		self.fuelGauge:setVisible(true)

        self.leftSideFuel:setVisible(false)
        self.rightSideFuel:setVisible(false)
        local gasArea = part:getArea()
        if gasArea then
            if vehicle:leftSideFuel() then
                self.leftSideFuel:setVisible(true)
            elseif vehicle:rightSideFuel() then
                self.rightSideFuel:setVisible(true)
            end
        end
		table.insert(self.gauges, self.fuelGauge)
	else
		self.gasTank = nil
		self.fuelGauge:setVisible(false)
	end
	self.engineGauge:setVisible(true)
	table.insert(self.gauges, self.engineGauge)
	self.speedGauge:setVisible(true)
	table.insert(self.gauges, self.speedGauge)
	if #self.gauges > 0 then
		self:setVisible(true)
		self:addToUIManager()
		self:onResolutionChange()
	else
		self:removeFromUIManager()
	end
	if not ISUIHandler.allUIVisible then
		self:removeFromUIManager()
	end
end

function ISVehicleDashboard:prerender()
	if not self.vehicle or not ISUIHandler.allUIVisible then return end
	local alpha = self:getAlphaFlick(0.65);
	local greyBg = {r=0.5, g=0.5, b=0.5, a=alpha};
	local goodColor = { r = getCore():getGoodHighlitedColor():getR(), g = getCore():getGoodHighlitedColor():getG(), b = getCore():getGoodHighlitedColor():getB(), a = alpha }
	local badColor = { r = getCore():getBadHighlitedColor():getR(), g = getCore():getBadHighlitedColor():getG(), b = getCore():getBadHighlitedColor():getB(), a = alpha }
	if self.gasTank then
		local current = 0.0
		if self.vehicle:isEngineRunning() or self.vehicle:isKeysInIgnition() then
			current = self.gasTank:getContainerContentAmount() / self.gasTank:getContainerCapacity()
		end
		if self.fuelValue < current then
			self.fuelValue = math.min(self.fuelValue + 0.015 * (30 / getPerformance():getUIRenderFPS()), current)
		elseif self.fuelValue > current then
			self.fuelValue = math.max(self.fuelValue - 0.05 * (30 / getPerformance():getUIRenderFPS()), current)
		end
		self.fuelGauge:setValue(self.fuelValue)
		local engineSpeedValue = 0;
		local speedValue = 0;
		if self.vehicle:isEngineRunning() then
			engineSpeedValue = math.max(0,math.min(1,(self.vehicle:getEngineSpeed()-1000)/(7000 - 1000)));
			speedValue = math.max(0,math.min(1,math.abs(self.vehicle:getCurrentSpeedKmHour())/120));
		end
		self.engineGauge:setValue(engineSpeedValue)
		-- RJ: Fake the speedometer a tad
		self.speedGauge:setValue(speedValue * BaseVehicle.getFakeSpeedModifier())
	end
	self.batteryTex.backgroundColor = greyBg;
	if not self:checkEngineFull() and self.vehicle:isKeysInIgnition() and (not self.vehicle:isEngineRunning() and not self.vehicle:isEngineStarted()) then
		self.engineTex.backgroundColor = badColor
-- 		self.engineTex.backgroundColor = {r=1, g=0, b=0, a=alpha};
	else
		if self.vehicle:isEngineRunning() then

	        local cond = self.vehicle:getPartById("Engine"):getCondition()
            local color = ColorInfo.new(0, 0, 0, 1)
            getCore():getBadHighlitedColor():interp(getCore():getGoodHighlitedColor(), cond/100, color);
-- 			self.engineTex.backgroundColor = goodColor
			self.engineTex.backgroundColor = {r=color:getR(), g=color:getG(), b=color:getB(), a=alpha};
			self.btn_partSpeed.name = self.vehicle:getTransmissionNumberLetter();
		elseif self.vehicle:isEngineStarted() then
			self.engineTex.backgroundColor = {r=1, g=0.5, b=0.1, a=alpha};
			self.btn_partSpeed.name = "P";
		else
			self.engineTex.backgroundColor = greyBg;
			self.btn_partSpeed.name = "P";
		end
	end
	if self.vehicle:isEngineRunning() or self.vehicle:isKeysInIgnition() then
		if self.vehicle:getBatteryCharge() > 0 then
            local color = ColorInfo.new(0, 0, 0, 1)
            local charge = self.vehicle:getBatteryCharge()
            getCore():getBadHighlitedColor():interp(getCore():getGoodHighlitedColor(), charge, color);
-- 			self.batteryTex.backgroundColor = goodColor
			self.batteryTex.backgroundColor = {r=color:getR(), g=color:getG(), b=color:getB(), a=alpha};
		else
			self.batteryTex.backgroundColor = badColor
-- 			self.batteryTex.backgroundColor = {r=1, g=0, b=0, a=alpha};
		end
	end
	if not self.vehicle:isKeysInIgnition() then
		if self.character:getInventory():haveThisKeyId(self.vehicle:getKeyId()) then
			self.ignitionTex.mouseovertext = getText("Tooltip_Dashboard_PutKeysInIgnition")
		else
			self.ignitionTex.mouseovertext = getText("Tooltip_Dashboard_NoKey")
		end
		if self.vehicle:isHotwired() then
			self.ignitionTex.mouseovertext = getText("Tooltip_Dashboard_Hotwired")
		end
	end

	if self.vehicle:isKeysInIgnition() and not self.vehicle:isHotwired() and not (self.vehicle:isEngineRunning() or self.vehicle:isStarting()) then
		self.ignitionTex.texture = self.iconIgnitionKey;
		self.ignitionTex.mouseovertext = getText("Tooltip_Dashboard_KeysIgnition")
	elseif (self.vehicle:isEngineRunning() or self.vehicle:isStarting()) and not self.vehicle:isHotwired() then
		self.ignitionTex.texture = self.iconIgnitionStarted;
	elseif self.vehicle:isHotwired() then
		self.ignitionTex.texture = self.iconIgnitionHotwired;
	else
		self.ignitionTex.texture = self.iconIgnition;
	end

	if (self.ignitionTex.texture == self.iconIgnitionKey) or (self.ignitionTex.texture == self.iconIgnitionStarted) then
		if not self.wasKeyInIgnition then
			self.wasKeyInIgnition = true
			if self.character then
				self.character:playSound("VehicleInsertIgnitionKey")
			end
		end
	else
		if self.wasKeyInIgnition then
			self.wasKeyInIgnition = false
			if self.character then
				self.character:playSound("VehicleRemoveIgnitionKey")
			end
		end
	end

	if self.vehicle:getHeadlightsOn() and not self.vehicle:getHeadlightCanEmmitLight() then
		self.lightsTex.backgroundColor = badColor
-- 		self.lightsTex.backgroundColor = {r=1, g=0, b=0, a=alpha};
	elseif self.vehicle:getHeadlightsOn() then
		self.lightsTex.backgroundColor = goodColor
-- 		self.lightsTex.backgroundColor = {r=0, g=1, b=0, a=alpha};
	else
		self.lightsTex.backgroundColor = greyBg;
	end
	if self.vehicle:areAllDoorsLocked() then
		self.doorTex.backgroundColor = goodColor
-- 		self.doorTex.backgroundColor = {r=0, g=1, b=0, a=alpha};
	elseif self.vehicle:isAnyDoorLocked() then
		self.doorTex.backgroundColor = {r=1, g=1, b=0, a=alpha};
	else
		self.doorTex.backgroundColor = greyBg;
	end
	if self.vehicle:getPartById("Heater") then
		if self.vehicle:getPartById("Heater"):getModData().active then
			self.heaterTex.backgroundColor = goodColor
-- 			self.heaterTex.backgroundColor = {r=0, g=1, b=0, a=alpha};
		else
			self.heaterTex.backgroundColor = greyBg;
		end
	end
	if self.vehicle:isRegulator() then
		self.speedregulatorTex.backgroundColor = goodColor
-- 		self.speedregulatorTex.backgroundColor = {r=0, g=1, b=0, a=alpha};
	else
		self.speedregulatorTex.backgroundColor = greyBg;
	end
	self.trunkTex:setVisible(self.vehicle:getPartById("TruckBed") ~= nil)
	if self.vehicle:isTrunkLocked() then
		self.trunkTex.backgroundColor = goodColor
-- 		self.trunkTex.backgroundColor = {r=0, g=1, b=0, a=alpha};
		self.trunkTex.mouseovertext = getText("Tooltip_Dashboard_TrunkLocked")
	else
		self.trunkTex.backgroundColor = greyBg;
		self.trunkTex.mouseovertext = getText("Tooltip_Dashboard_TrunkUnlocked")
	end

	if (self.vehicle:isEngineRunning() or self.vehicle:isKeysInIgnition()) and self.vehicle:getRemainingFuelPercentage() < 15 then
		self.fuelGauge:setTexture(self.gaugeLow);
		if self.vehicle:getRemainingFuelPercentage() < 5 then
			self.fuelGauge:setTexture(self.gaugeEmpty);
		end
	else
		self.fuelGauge:setTexture(self.gaugeFull);
	end

	if self.radioTex then
	    self.radioTex.backgroundColor = greyBg;
        if self.vehicle:getPartById("Radio") and self.vehicle:getPartById("Radio"):getDeviceData()  and self.vehicle:getPartById("Radio"):getDeviceData():getIsTurnedOn() then
            self.radioTex.backgroundColor = goodColor
--             self.radioTex.backgroundColor = {r=0, g=1, b=0, a=alpha};
        end
	    if self.vehicle:isKeysInIgnition() or  (self.vehicle:isHotwired() and (self.vehicle:isEngineRunning() or self.vehicle:isStarting())) and self.vehicle:getBatteryCharge() > 0 then
            if not self.vehicle:getPartById("Radio") or not self.vehicle:getPartById("Radio"):getInventoryItem() then
                self.radioTex.backgroundColor = badColor
            end
        end
	end
end

function ISVehicleDashboard:checkEngineFull()
	for i=0,self.vehicle:getPartCount() do
		local part = self.vehicle:getPartByIndex(i);
		if part and part:getLuaFunction("checkEngine") and not VehicleUtils.callLua(part:getLuaFunction("checkEngine"), self.vehicle, part) then
			return false;
		end
	end
	return true;
end
		
function ISVehicleDashboard:render()
	if not self.vehicle then return end
	if self.vehicle:isRegulator() then
		self:drawText(self.vehicle:getRegulatorSpeed() .. "", self.speedregulatorTex.x + self.speedregulatorTex:getWidth() + 5, self.speedregulatorTex.y, 0, 1, 0, 0.8, UIFont.Medium);
	else
		self:drawText(self.vehicle:getRegulatorSpeed() .. "", self.speedregulatorTex.x + self.speedregulatorTex:getWidth() + 5, self.speedregulatorTex.y, 1, 1, 1, 0.3, UIFont.Medium);
	end
--	self:onResolutionChange();
--	if self.outsidetemp then
--		local engine = self.vehicle:getPartById("Engine");
--		if engine then
--			self.outsidetemp.name = Temperature.getTemperatureString(engine:getModData().temperature); --round(getWorld():getGlobalTemperature(),1) .. "";
--			self.outsidetemp:setWidthToName()
--		end
--	end
end

function ISVehicleDashboard:onResolutionChange()

	local screenLeft = getPlayerScreenLeft(self.playerNum)
	local screenTop = getPlayerScreenTop(self.playerNum)
	local screenWidth = getPlayerScreenWidth(self.playerNum)
	local screenHeight = getPlayerScreenHeight(self.playerNum)

	if self.backgroundTex == nil then
		return;
	end
	
	self:setHeight(self.backgroundTex:getHeight());
	self:setX(screenLeft + (screenWidth - self.backgroundTex:getWidth()) / 2);
	self:setY(screenTop + screenHeight - self.height);

	if self.backgroundTex then
		self.backgroundTex:setX(0)
		self.backgroundTex:setY(0)
	end
	
	local x = self:getX();

	if self.btn_partSpeed ~= nil then
		self.btn_partSpeed:setX(self.backgroundTex:getX() + 60);
		self.btn_partSpeed:setY(self.backgroundTex:getY() + 55);
	end
	
	if self.engineTex then
		self.engineTex:setX(self.backgroundTex:getX() + 105);
		self.engineTex:setY(self.backgroundTex:getY() + 26);
	end
	
	if self.batteryTex then
		self.batteryTex:setX(self.engineTex:getX() + 32); --36
		self.batteryTex:setY(self.engineTex:getY());
	end
	
--	if self.outsidetemp then
--		self.outsidetemp:setX(self.batteryTex:getX() + 26); --34
--		self.outsidetemp:setY(self.batteryTex:getY());
--	end
	
	if self.doorTex then
		self.doorTex:setX(self.batteryTex:getX() + 32);
		self.doorTex:setY(self.batteryTex:getY());
	end
	
	if self.lightsTex then
		self.lightsTex:setX(self.engineTex:getX() + 247);
-- 		self.lightsTex:setX(self.engineTex:getX() + 255);
		self.lightsTex:setY(self.engineTex:getY());
	end

	if self.radioTex then
		self.radioTex:setX(self.lightsTex:getX() + 32);
		self.radioTex:setY(self.lightsTex:getY() + 2);
	end
	
	if self.heaterTex then
		self.heaterTex:setX(self.radioTex:getX() + 27);
-- 		self.heaterTex:setX(self.radioTex:getX() + 32);
		self.heaterTex:setY(self.radioTex:getY() - 2);
	end

-- 	if self.heaterTex then
-- 		self.heaterTex:setX(self.lightsTex:getX() + 32);
-- 		self.heaterTex:setY(self.lightsTex:getY());
-- 	end
	
	if self.trunkTex then
		self.trunkTex:setX(self.heaterTex:getX() + 27);
		self.trunkTex:setY(self.heaterTex:getY());
	end

	if self.ignitionTex then
		self.ignitionTex:setX(self.engineTex:getX() + 255 + 32 + 31 + 52);
-- 		self.ignitionTex:setX(self.trunkTex:getX() + 52);
		self.ignitionTex:setY(self.trunkTex:getY() + 34);
	end

end

function ISVehicleDashboard:onClickEngine()
	if getGameSpeed() == 0 then return; end
	if getGameSpeed() > 1 then setGameSpeed(1); end
	if not self.vehicle then return end
	if self.vehicle:isEngineRunning() then
		ISVehicleMenu.onShutOff(self.character)
	else
		ISVehicleMenu.onStartEngine(self.character)
	end
end

function ISVehicleDashboard:onClickHeadlights()
	if getGameSpeed() == 0 then return; end
	if getGameSpeed() > 1 then setGameSpeed(1); end
	ISVehicleMenu.onToggleHeadlights(self.character);
end

function ISVehicleDashboard:onClickDoors()
	if getGameSpeed() == 0 then return; end
	if getGameSpeed() > 1 then setGameSpeed(1); end
	ISVehiclePartMenu.onLockDoors(self.character, self.vehicle, not self.vehicle:isAnyDoorLocked());
end

function ISVehicleDashboard:onClickTrunk()
	if getGameSpeed() == 0 then return; end
	if getGameSpeed() > 1 then setGameSpeed(1); end
	ISVehicleMenu.onToggleTrunkLocked(self.character);
end

function ISVehicleDashboard:onClickHeater()
	if getGameSpeed() == 0 then return; end
	if getGameSpeed() > 1 then setGameSpeed(1); end
	ISVehicleMenu.onToggleHeater(self.character)
end

function ISVehicleDashboard:onClickRadio()
	if getGameSpeed() == 0 then return; end
	if getGameSpeed() > 1 then setGameSpeed(1); end
	local radio = self.vehicle:getPartById("Radio")
	if not radio or not radio:getInventoryItem() or not radio:getDeviceData() then return end
	getSoundManager():playUISound("VehicleRadioButton")
	if radio:getDeviceData():getIsTurnedOn() then
        radio:getDeviceData():setIsTurnedOn(false)
        if ISRadioWindow.isActive(self.character, radio) then
            ISRadioWindow.closeIfActive(self.character, radio)
        end
        return
    end
    if ISRadioWindow.isActive(self.character, radio) then
        ISRadioWindow.closeIfActive(self.character, radio)
	else
        ISVehicleMenu.onSignalDevice(self.character, radio)
    end
end
function ISVehicleDashboard:onClickKeys()
	if getGameSpeed() == 0 then return; end
	if getGameSpeed() > 1 then setGameSpeed(1); end
	if not self.vehicle then return end
	if self.vehicle:isEngineRunning() then
		ISVehicleMenu.onShutOff(self.character)
	elseif not self.vehicle:isEngineStarted() then
		self.vehicle:setKeysInIgnition(not self.vehicle:isKeysInIgnition());
	end
end

function ISVehicleDashboard:new(playerNum, chr)
	local o = ISPanel:new(0, 0, 200, 200)
	setmetatable(o, self)
	self.__index = self
	o.playerNum = playerNum
	o.character = chr;
	o.gauges = {}
	o.texEngine = getTexture("media/ui/vehicle/engine.png")
	o.iconEngine = getTexture("media/ui/vehicles/icon_enginetrouble_light.png");
	o.iconAirCondition = getTexture("media/ui/vehicles/icon_airconditioning_light.png");
	o.iconDoor = getTexture("media/ui/vehicles/icon_doorslocked_light.png");
	o.iconLights = getTexture("media/ui/vehicles/icon_headlights_light.png");
	o.iconHeater = getTexture("media/ui/vehicles/icon_heating_light.png");
	o.iconIgnition = getTexture("media/ui/vehicles/ignition.png");
	o.iconIgnitionKey = getTexture("media/ui/vehicles/ignition_key_off.png");
	o.iconIgnitionStarted = getTexture("media/ui/vehicles/ignition_key_on.png");
	o.iconIgnitionHotwired = getTexture("media/ui/vehicles/ignition_hotwired.png");
	o.iconBattery = getTexture("media/ui/vehicles/icon_lowbattery_light.png");
	o.iconTrunk = getTexture("media/ui/vehicles/icon_trunk_light.png")
	o.iconSpeedRegulator = getTexture("media/ui/vehicles/speedregulator_light.png")
	o.dashboardBG = getTexture("media/ui/vehicles/dashboard.png");
	o.gaugeFull = getTexture("media/ui/vehicles/rj-vehicle_fuelguage-full.png");
	o.gaugeLow = getTexture("media/ui/vehicles/rj-vehicle_fuelguage-low.png");
	o.gaugeEmpty = getTexture("media/ui/vehicles/rj-vehicle_fuelguage-empty.png");
	o.engineGaugeTex = getTexture("media/ui/vehicles/rj-vehicle_engineguage.png")
	o.speedGaugeTex = getTexture("media/ui/vehicles/vehicle_spedometer.png")
	o.leftSideFuelTex = getTexture("media/ui/ArrowLeft.png")
	o.rightSideFuelTex = getTexture("media/ui/ArrowRight.png")
	o.iconRadio = getTexture("Icon_Radio_Speaker");
	o.flickingTimer = 0;
	o:setWidth(o.dashboardBG:getWidth());
	return o
end

function ISVehicleDashboard.onEnterVehicle(character)
	local vehicle = character:getVehicle()
	if instanceof(character, 'IsoPlayer') and character:isLocalPlayer() and vehicle:isDriver(character) then
		getPlayerVehicleDashboard(character:getPlayerNum()):setVehicle(vehicle)
	end
end

function ISVehicleDashboard.onExitVehicle(character)
	if instanceof(character, 'IsoPlayer') and character:isLocalPlayer() then
		local data = getPlayerVehicleDashboard(character:getPlayerNum())
		if data then data:setVehicle(nil) end
	end
end

function ISVehicleDashboard.onSwitchVehicleSeat(character)
	if instanceof(character, 'IsoPlayer') and character:isLocalPlayer() then
		local vehicle = character:getVehicle()
		if vehicle:isDriver(character) then
			getPlayerVehicleDashboard(character:getPlayerNum()):setVehicle(vehicle)
		else
			getPlayerVehicleDashboard(character:getPlayerNum()):setVehicle(nil)
		end
	end
end

function ISVehicleDashboard.OnGameStart()
	if isServer() then return end
	for i=1,getNumActivePlayers() do
		local playerObj = getSpecificPlayer(i-1)
		if playerObj and not playerObj:isDead() and playerObj:getVehicle() then
			ISVehicleDashboard.onEnterVehicle(playerObj)
		end
	end
end


function ISVehicleDashboard.getVehicleCondition(vehicle)
	local parts = {}
	for i=1, vehicle:getPartCount() do
		local part = vehicle:getPartByIndex(i-1)
		parts[part] = part:getCondition()
	end
	return parts
end

local function comparePartsDamage(parts1, parts2)
	for part, condition in pairs(parts1) do
		if parts2[part] ~= nil then
			if math.abs(parts2[part] - condition) > 10 then
				return true
			end
		end	
	end
	return false
end

ISVehicleDashboard.lastVehicleDamage = nil
ISVehicleDashboard.lastVehicleDamageTimer = 0
function ISVehicleDashboard.damageChecker()
	local character = getPlayer()
	if character == nil then return end
	if character:getVehicle() == nil then
        ISVehicleDashboard.onExitVehicle(character)
    end

	if ISVehicleDashboard.lastVehicleDamageTimer <= 0 then	
		local vehicle = character:getVehicle()
		if vehicle ~= nil then
			if ISVehicleDashboard.lastVehicleDamage == nil then
				ISVehicleDashboard.lastVehicleDamage = ISVehicleDashboard.getVehicleCondition(vehicle)
			else
				local condition = ISVehicleDashboard.getVehicleCondition(vehicle)
				if comparePartsDamage(ISVehicleDashboard.lastVehicleDamage, condition) then
					ISVehicleDashboard.damageFlick(character)
				end
				ISVehicleDashboard.lastVehicleDamage = condition
			end
		else
			ISVehicleDashboard.lastVehicleDamage = nil
		end	
		ISVehicleDashboard.lastVehicleDamageTimer = 10
	else
		ISVehicleDashboard.lastVehicleDamageTimer = ISVehicleDashboard.lastVehicleDamageTimer - 1
	end
end

function ISVehicleDashboard.onGameStart()
	-- Doing this to avoid a big pause entering a vehicle the first time.
	local textures = {}
	textures.texEngine = getTexture("media/ui/vehicle/engine.png")
	textures.iconEngine = getTexture("media/ui/vehicles/icon_enginetrouble_light.png");
	textures.iconAirCondition = getTexture("media/ui/vehicles/icon_airconditioning_light.png");
	textures.iconDoor = getTexture("media/ui/vehicles/icon_doorslocked_light.png");
	textures.iconLights = getTexture("media/ui/vehicles/icon_headlights_light.png");
	textures.iconHeater = getTexture("media/ui/vehicles/icon_heating_light.png");
	textures.iconIgnition = getTexture("media/ui/vehicles/ignition.png");
	textures.iconIgnitionKey = getTexture("media/ui/vehicles/ignition_key_off.png");
	textures.iconIgnitionStarted = getTexture("media/ui/vehicles/ignition_key_on.png");
	textures.iconIgnitionHotwired = getTexture("media/ui/vehicles/ignition_hotwired.png");
	textures.iconBattery = getTexture("media/ui/vehicles/icon_lowbattery_light.png");
	textures.iconTrunk = getTexture("media/ui/vehicles/icon_trunk_light.png")
	textures.iconSpeedRegulator = getTexture("media/ui/vehicles/speedregulator_light.png")
	textures.dashboardBG = getTexture("media/ui/vehicles/dashboard.png");
	textures.gaugeFull = getTexture("media/ui/vehicles/rj-vehicle_fuelguage-full.png");
	textures.gaugeLow = getTexture("media/ui/vehicles/rj-vehicle_fuelguage-low.png");
	textures.gaugeEmpty = getTexture("media/ui/vehicles/rj-vehicle_fuelguage-empty.png");
	textures.engineGaugeTex = getTexture("media/ui/vehicles/rj-vehicle_engineguage.png")
	textures.speedGaugeTex = getTexture("media/ui/vehicles/vehicle_spedometer.png")
	textures.rightSideFuelTex = getTexture("media/ui/ArrowRight.png")
	textures.leftSideFuelTex = getTexture("media/ui/ArrowLeft.png")
end

Events.OnGameStart.Add(ISVehicleDashboard.onGameStart)

LuaEventManager.AddEvent("OnExitVehicle")
LuaEventManager.AddEvent("OnSwitchVehicleSeat")
Events.OnEnterVehicle.Add(ISVehicleDashboard.onEnterVehicle)
Events.OnExitVehicle.Add(ISVehicleDashboard.onExitVehicle)
Events.OnSwitchVehicleSeat.Add(ISVehicleDashboard.onSwitchVehicleSeat)
Events.OnGameStart.Add(ISVehicleDashboard.OnGameStart)
--Events.OnVehicleDamageTexture.Add(ISVehicleDashboard.damageFlick)
Events.OnTick.Add(ISVehicleDashboard.damageChecker)
