if isServer() then return; end;

forageClient = {};
forageData = {};

function forageClient.init()
	forageData = ModData.getOrCreate("forageData");
end
Events.OnInitGlobalModData.Add(forageClient.init)

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

function forageClient.requestZone(_character)
	if isClient() and _character then
		local sw = ISSearchWindow.players[_character];
		local focus = (sw and sw.searchFocusCategory) or "None";
		sendForageRequestZone(_character, focus);
	end;
end

LuaEventManager.AddEvent("OnForagePool");
Events.OnForagePool.Add(function(_player, _zoneId, _icons)
	local manager = ISSearchManager.getManager(_player);
	if manager then manager:applyServerPool(_zoneId, _icons); end;
end);

function forageClient.showForageHalo(_character, _itemList)
	if not (_character and _itemList) then return; end;
	local counts = {};
	for i = 0, _itemList:size() - 1 do
		local item = _itemList:get(i);
		local key = item:getFullType();
		if not counts[key] then counts[key] = { item = item, count = 0 }; end;
		counts[key].count = counts[key].count + 1;
	end;
	for _, data in pairs(counts) do
		local item = data.item;
		local tex = "";
		if item:getTexture() ~= nil then
			local name = tostring(item:getTexture():getName());
			if string.find(name, "media") and string.find(name, "textures") then
				tex = "[img=" .. name .. "]";
			else
				tex = "[img=media/textures/" .. name .. "]";
			end;
		end;
		HaloTextHelper.addText(_character, tex .. "    " .. data.count .. " " .. item:getDisplayName());
	end;
end
