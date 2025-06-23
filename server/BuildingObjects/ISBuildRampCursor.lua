--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

ISBuildRampCursor = ISBuildingObject:derive("ISBuildRampCursor")

function ISBuildRampCursor:create(x, y, z, north, sprite)
    showDebugInfoInChat("Cursor Create \'ISBuildRampCursor\' "..tostring(x)..", "..tostring(y)..", "..tostring(z)..", "..tostring(north)..", "..tostring(sprite))
	if self.which == "north20" then
		for i=1,20 do
			self:removeRampObjects(x, y-(i-1), z)
			if not isShiftKeyDown() then
				self:addRampObject(x, y-(i-1), z, string.format("ramps_01_%d", i-1))
			end
		end
	end
	if self.which == "south20" then
		for i=1,20 do
			self:removeRampObjects(x, y-19+(i-1), z)
			if not isShiftKeyDown() then
				self:addRampObject(x, y-19+(i-1), z, string.format("ramps_01_%d", 24+i-1))
			end
		end
	end
	if self.which == "west20" then
		for i=1,20 do
			self:removeRampObjects(x-(i-1), y, z)
			if not isShiftKeyDown() then
				self:addRampObject(x-(i-1), y, z, string.format("ramps_01_%d", 48+i-1))
			end
		end
	end
	if self.which == "east20" then
		for i=1,20 do
			self:removeRampObjects(x-19+(i-1), y, z)
			if not isShiftKeyDown() then
				self:addRampObject(x-19+(i-1), y, z, string.format("ramps_01_%d", 72+i-1))
			end
		end
	end
end

function ISBuildRampCursor:removeRampObjects(x, y, z)
	local square = getCell():getGridSquare(x, y, z)
	if not square then return end
	for i=square:getObjects():size(),1,-1 do
		local object = square:getObjects():get(i-1)
		if object:getSprite() and object:getSprite():getName() and luautils.stringStarts(object:getSprite():getName(), "ramps_01") then
			square:RemoveTileObject(object)
		end
	end
end

function ISBuildRampCursor:addRampObject(x, y, z, spriteName)
	if not getWorld():isValidSquare(x, y, z) then return end
	local square = getCell():getGridSquare(x, y, z)
	if square == nil then
		square = IsoGridSquare.new(getCell(), nil, x, y, z)
		getCell():ConnectNewSquare(square, false)
	end
	local object = IsoObject.new(getCell(), square, getSprite(spriteName))
	square:AddTileObject(object)
	return object
end

function ISBuildRampCursor:render(x, y, z, square)
	if self.which == "north20" then
		for i=1,20 do
			local sprite = getSprite(string.format("ramps_01_%d", i-1))
			if sprite then
				sprite:RenderGhostTile(x, y-(i-1), z)
			end
		end
	end
	if self.which == "south20" then
		for i=1,20 do
			local sprite = getSprite(string.format("ramps_01_%d", 24+i-1))
			if sprite then
				sprite:RenderGhostTile(x, y-19+(i-1), z)
			end
		end
	end
	if self.which == "west20" then
		for i=1,20 do
			local sprite = getSprite(string.format("ramps_01_%d", 48+i-1))
			if sprite then
				sprite:RenderGhostTile(x-(i-1), y, z)
			end
		end
	end
	if self.which == "east20" then
		for i=1,20 do
			local sprite = getSprite(string.format("ramps_01_%d", 72+i-1))
			if sprite then
				sprite:RenderGhostTile(x-19+(i-1), y, z)
			end
		end
	end
end

function ISBuildRampCursor:isValid(square)
	return true
end

function ISBuildRampCursor:new(character, which)
	local o = ISBuildingObject.new(self)
	o:init()
	o.character = character
	o.which = which
	showDebugInfoInChat("Cursor New \'ISBuildRampCursor\'")
	return o
end

