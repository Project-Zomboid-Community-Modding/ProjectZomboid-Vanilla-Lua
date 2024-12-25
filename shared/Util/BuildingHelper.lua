BuildingHelper = {}

BuildingHelper.getFreeTilesFromRandomRoomInBuilding = function(building, count)

	local squares = {}
	if instanceof(building, "BuildingDef") then

	--	while square == nil do
			local roomList = building:getRooms();

			local roomCount = roomList:size();
			local room = nil;

			--print("getting room")
			local timeout = 1;
			while room == nil or room:getW() <= 2 or room:getH() <= 2 do
				room = roomList:get(ZombRand(roomCount));
				timeout = timeout + 1;
				if timeout > 30 then
					return squares;
				end
			end

			for i = 0, count do
				local bDo = true;
				local square = getCell():getFreeTile(room);
				for k, v in ipairs(squares) do
					if v == square then
						bDo = false;
					end
				end
				if bDo and square ~= nil then
					table.insert(squares, square);
				else
					i = i - 1;
				end
			end
		end
	--end

	return squares;
end

BuildingHelper.getFreeTileFromBuilding = function(building)

	if instanceof(building, "BuildingDef") then
		local square = nil;

		while square == nil do
			local roomList = building:getRooms();

			local roomCount = roomList:size();

			--print("getting room")
			local room = roomList:get(ZombRand(roomCount));

			--print("getting square")
			square = getCell():getFreeTile(room);

		end

		if square ~= nil then
			return square;
		end
	end



end

BuildingHelper.getShovelAnim = function(item)
	if not item then
		return CharacterActionAnims.Dig
	end
	if item:getDigType() == "Trowel" or item:getType() == "HandShovel" or item:getType() == "HandFork" or item:getType() == "EntrenchingTool" then
		return CharacterActionAnims.DigTrowel
	elseif item:getDigType() == "Hoe" or item:getType() == "GardenHoe" then
		return CharacterActionAnims.DigHoe
	elseif item:getDigType() == "PickAxe" or item:getType() == "PickAxe" then
		return CharacterActionAnims.DigPickAxe
	elseif item:getDigType() == "Shovel" then
		return CharacterActionAnims.DigShovel
	else
		return CharacterActionAnims.DigShovel
	end
end