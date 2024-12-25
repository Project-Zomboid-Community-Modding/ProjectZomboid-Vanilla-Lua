function loadMapBasementLuaFiles()
	local dirs = getLotDirectories()
	for i=dirs:size(),1,-1 do
		local dirName = dirs:get(i-1)
		local file = 'media/maps/'..dirName..'/basements.lua'
		if fileExists(file) then
			reloadLuaFile(file)
		end
	end
end

Events.OnLoadMapZones.Add(loadMapBasementLuaFiles);

