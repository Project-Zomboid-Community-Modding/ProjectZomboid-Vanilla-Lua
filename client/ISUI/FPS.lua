ISFPS = {};

ISFPS.lastSec = -1;
ISFPS.frame = 0;
ISFPS.start = false;
ISFPS.init = false;

function ISFPS.onKeyPressed(key)
	if getCore():isKey("Display FPS", key) then
		if ISFPS.start then
			ISFPS.start = false;
			ISEquippedItem.text = nil;
		else
			-- add the event to start calculing the FPS
			ISFPS.start = true;
		end
	end
end

Events.OnKeyPressed.Add(ISFPS.onKeyPressed);
