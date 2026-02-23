if isServer() then return; end;

forageClient = {};
forageData = {};

function forageClient.init()
	forageData = ModData.getOrCreate("forageData");
end
Events.OnInitGlobalModData.Add(forageClient.init)

function forageClient.getZones() return forageData; end;

function forageClient.updateData()
	forageData = ModData.getOrCreate("forageData");
end

function forageClient.clearData()
	ModData.remove("forageData");
end

function forageClient.syncForageData()
end

function forageClient.addZone(_zoneData)
	forageData[_zoneData.id] = _zoneData;
end

function forageClient.removeZone(_zoneData)
	forageData[_zoneData.id] = nil;
end

function forageClient.updateZone(_zoneData)
	forageClient.addZone(_zoneData);
end

function forageClient.updateIcon(_zoneData, _iconID, _icon)
	triggerEvent("onUpdateIcon", _zoneData, _iconID, _icon);
	forageData[_zoneData.id].forageIcons[_iconID] = _icon;
end
