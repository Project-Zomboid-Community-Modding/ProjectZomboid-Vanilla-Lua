--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "BuildingObjects/ISBuildingObject"

ISPickCharacterCursor = ISBuildingObject:derive("ISPickCharacterCursor")

function ISPickCharacterCursor:create(x, y, z, north, sprite)
    showDebugInfoInChat("Cursor Create \'ISPickCharacterCursor\' "..tostring(x)..", "..tostring(y)..", "..tostring(z)..", "..tostring(north)..", "..tostring(sprite))
	local square = getCell():getGridSquare(x, y, z)
	local chr = self:getObjectList(square)[self.objectIndex]
	self:onPickCharacter(chr)
end

function ISPickCharacterCursor:rotateKey(key)
	if getCore():isKey("Rotate building", key) then
		self.objectIndex = self.objectIndex + 1
		local objects = self:getObjectList(nil)
		if self.objectIndex > #objects then
			self.objectIndex = 1
		end
	end
end

function ISPickCharacterCursor:isValid(square)
	self.squareX = square:getX()
	self.squareY = square:getY()
	self.squareZ = square:getZ()
	return #self:getObjectList(square) > 0
end

function ISPickCharacterCursor:render(x, y, z, square)
	local r,g,b,a = 0.0,1.0,0.0,0.8
	if not self:isValid(square) then
		r = 1.0
		g = 0.0
	end
	self:getFloorCursorSprite():RenderGhostTileColor(x, y, z, r, g, b, a)

	if self.currentSquare ~= square then
		self.objectIndex = 1
		self.currentSquare = square
	end

	self.squareX = x
	self.squareY = y
	self.squareZ = z

	local chr = self:getHighlightedCharacter(square)
	if chr then
		chr:setOutlineHighlight(self.player, true)
		chr:setOutlineHighlightCol(self.player, 0.0, 1.0, 0.0, 1.0)
	end
end

function ISPickCharacterCursor:isValidCharacter(chr)
	error "override me"
end

function ISPickCharacterCursor:onPickCharacter(chr)
	error "override me"
end

function ISPickCharacterCursor:getObjectList(square)
	if not self.squareX then return {} end
	local square = square or getCell():getGridSquare(self.squareX, self.squareY, self.squareZ)
	if not square then return {} end
	local objects = {}
	for i=1,square:getMovingObjects():size() do
		local object = square:getMovingObjects():get(i-1)
		if self:isValidCharacter(object) then
			table.insert(objects, object)
		end
	end
	return objects
end

function ISPickCharacterCursor:getHighlightedCharacter(square)
	local objects = self:getObjectList(square)
	if #objects == 0 then return end
	return objects[self.objectIndex]
end

function ISPickCharacterCursor:onJoypadPressButton(joypadIndex, joypadData, button)
	local playerObj = getSpecificPlayer(joypadData.player)

	if button == Joypad.AButton or button == Joypad.BButton then
		return ISBuildingObject.onJoypadPressButton(self, joypadIndex, joypadData, button)
	end

	if button == Joypad.RBumper then
		self.objectIndex = self.objectIndex + 1
		local objects = self:getObjectList()
		if self.objectIndex > #objects then
			self.objectIndex = 1
		end
	end

	if button == Joypad.LBumper then
		self.objectIndex = self.objectIndex - 1
		if self.objectIndex < 1 then
			local objects = self:getObjectList()
			self.objectIndex = #objects
		end
	end
end

function ISPickCharacterCursor:getLBPrompt()
	if #self:getObjectList() > 1 then
		return "Previous Object"
	end
	return nil
end

function ISPickCharacterCursor:getRBPrompt()
	if #self:getObjectList() > 1 then
		return "Next Object"
	end
	return nil
end

function ISPickCharacterCursor:new(character)
	local o = ISBuildingObject.new(self)
	o:init()
	o.character = character
	o.player = character:getPlayerNum()
	o.noNeedHammer = true
	o.skipBuildAction = true
	o.objectIndex = 1
	showDebugInfoInChat("Cursor New \'ISPickCharacterCursor\'")
	return o
end

