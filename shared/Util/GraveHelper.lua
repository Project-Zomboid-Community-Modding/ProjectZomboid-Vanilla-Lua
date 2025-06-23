GraveHelper = {}

GraveHelper.onBuryAnimalCorpse = function(grave, playerObj, animal)
	playerObj:setPrimaryHandItem(nil);
	sendRemoveItemFromContainer(animal:getContainer(), animal);
	animal:getContainer():Remove(animal);


	if isServer() then
		sendServerCommand(playerObj, 'ui', 'dirtyUI', { });
	else
		ISInventoryPage.dirtyUI();
	end

	GraveHelper.updateGrave(grave);
	return true;
end

GraveHelper.updateGrave = function(grave)
	grave:getModData()["corpses"] = grave:getModData()["corpses"] + 1;
	grave:transmitModData()

	local sq1 = grave:getSquare();
	local sq2 = nil;
	if grave:getNorth() then
		if grave:getModData()["spriteType"] == "sprite1" then
			sq2 = getCell():getGridSquare(sq1:getX(), sq1:getY() - 1, sq1:getZ());
		elseif grave:getModData()["spriteType"] == "sprite2" then
			sq2 = getCell():getGridSquare(sq1:getX(), sq1:getY() + 1, sq1:getZ());
		end
	else
		if grave:getModData()["spriteType"] == "sprite1" then
			sq2 = getCell():getGridSquare(sq1:getX() - 1, sq1:getY(), sq1:getZ());
		elseif grave:getModData()["spriteType"] == "sprite2" then
			sq2 = getCell():getGridSquare(sq1:getX() + 1, sq1:getY(), sq1:getZ());
		end
	end

	for j=0, sq2:getSpecialObjects():size()-1 do
		local grave2 = sq2:getSpecialObjects():get(j);
		if grave2:getName() == "EmptyGraves" then
			grave2:getModData()["corpses"] = grave2:getModData()["corpses"] + 1;
			grave2:transmitModData()
		end
	end
end