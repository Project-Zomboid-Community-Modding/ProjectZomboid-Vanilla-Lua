SpeedControlsHandler = {};
SpeedControlsHandler.previousSpeed = 1;

SpeedControlsHandler.onKeyPressed = function(key)
    if isClient() then
        return;
    end

	if not MainScreen.instance or not MainScreen.instance.inGame or MainScreen.instance:getIsVisible() then
		return
	end

	if getCore():isKey(KeybindId.PAUSE, key) then
		if not MainScreen.instance.inGame or MainScreen.instance:getIsVisible() then
			-- Default "Pause" is same as "Main Menu"
		elseif key == Keyboard.KEY_ESCAPE and getCell() and getCell():getDrag(0) then
			-- ToggleEscapeMenu does getCell():setDrag(nil)
		elseif getGameSpeed() > 0 then
			SpeedControlsHandler.previousSpeed = getGameTime():getTrueMultiplier();
			setGameSpeed(0);
		else
			setGameSpeed(1);
			getGameTime():setMultiplier(SpeedControlsHandler.previousSpeed or 1);
			SpeedControlsHandler.previousSpeed = nil;
		end
	elseif getCore():isKey(KeybindId.NORMAL_SPEED, key) then
		setGameSpeed(1);
		getGameTime():setMultiplier(1);
	elseif getCore():isKey(KeybindId.FAST_FORWARD_X1, key) then
		setGameSpeed(2);
		getGameTime():setMultiplier(5);
	elseif getCore():isKey(KeybindId.FAST_FORWARD_X2, key) then
		setGameSpeed(3);
		getGameTime():setMultiplier(20);
	elseif getCore():isKey(KeybindId.FAST_FORWARD_X3, key) then
		setGameSpeed(4);
		getGameTime():setMultiplier(40);
	elseif getCore():isKey("Step Forward",key) then
	    stepForward();
	    getGameTime():setMultiplier(1);
	end
end


Events.OnKeyPressed.Add(SpeedControlsHandler.onKeyPressed);
