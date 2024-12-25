--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "BuildingObjects/ISBuildingObject"

ISPaperCursor = ISBuildingObject:derive("ISPaperCursor");

local function predicateNotBroken(item)
 return not item:isBroken()
end

local function predicateEnoughPaste(item)
 return item:getCurrentUsesFloat() >= 0.1
end

function ISPaperCursor:create(x, y, z, north, sprite)
	local sq = getWorld():getCell():getGridSquare(x, y, z)
	local playerObj = self.character
	local playerInv = playerObj:getInventory()
	local object = self:getObjectList()[self.objectIndex]
	-- local args = self.args
	-- if self.action == "paintThump" then
		local paper
		-- if not ISBuildMenu.cheat then
			local paintBrush = playerInv:getFirstTypeRecurse("Paintbrush")
			ISWorldObjectContextMenu.transferIfNeeded(playerObj, paintBrush)
-- 			print("self.paperType " .. tostring(self.paperType))
-- 			getPlayer():Say("self.paperType " .. tostring(self.paperType))
			paper = playerInv:getFirstTypeRecurse(self.paperType)
-- 			print("paper " .. tostring(paper:getType()))
-- 			getPlayer():Say("paper " .. tostring(paper:getType()))
			ISWorldObjectContextMenu.transferIfNeeded(playerObj, paper)
			local paste = playerInv:getFirstTagEvalRecurse("WallpaperPaste", predicateEnoughPaste)
			ISWorldObjectContextMenu.transferIfNeeded(playerObj, paper)
			local scissors = playerInv:getFirstTagEvalRecurse("Scissors", predicateNotBroken)
			ISWorldObjectContextMenu.transferIfNeeded(playerObj, scissors)
		-- end
		ISTimedActionQueue.add(ISWallpaperAction:new(playerObj, object, paper, self.paperType))
		-- ISTimedActionQueue.add(ISPaintAction:new(playerObj, object, paper, args.paperType, 100))
		-- ISTimedActionQueue.add(ISWallpaperAction:new(playerObj, thumpable, wallPaper, papering, 100));
	-- end
	-- if self.action == "plaster" then
		-- local plaster = nil
		-- if not ISBuildMenu.cheat then
			-- plaster = playerInv:getFirstTypeRecurse("BucketPlasterFull")
			-- ISWorldObjectContextMenu.transferIfNeeded(playerObj, plaster)
		-- end
		-- ISTimedActionQueue.add(ISPlasterAction:new(playerObj, object, plaster))
	-- end
end

function ISPaperCursor:walkTo(x, y, z)
	local object = self:getObjectList()[self.objectIndex]
	self.isWallLike = self:_isWall(object) or self:_isDoorFrame(object)
	return ISBuildingObject.walkTo(self, x, y, z)
end

function ISPaperCursor:_isWall(object)
	if object and object:getProperties() then
		return object:getProperties():Is(IsoFlagType.cutW) or object:getProperties():Is(IsoFlagType.cutN)
	end
	return false
end

function ISPaperCursor:_isDoorFrame(object)
	return object and (object:getType() == IsoObjectType.doorFrW or object:getType() == IsoObjectType.doorFrN)
end

function ISPaperCursor:rotateKey(key)
	if getCore():isKey("Rotate building", key) then
		self.objectIndex = self.objectIndex + 1
		local objects = self:getObjectList()
		if self.objectIndex > #objects then
			self.objectIndex = 1
		end
	end
end

function ISPaperCursor:isValid(square)
	self.renderX = square:getX()
	self.renderY = square:getY()
	self.renderZ = square:getZ()
	-- getPlayer():Say("#self:getObjectList() " .. tostring( #self:getObjectList()))
	return #self:getObjectList() > 0
end

function ISPaperCursor:render(x, y, z, square)
	local hc = getCore():getGoodHighlitedColor()
	
	-- getPlayer():Say("square" .. tostring(square))
	if not self:isValid(square) then
		hc = getCore():getBadHighlitedColor()
	end
	self:getFloorCursorSprite():RenderGhostTileColor(x, y, z, hc:getR(), hc:getG(), hc:getB(), 0.8)

	if self.currentSquare ~= square then
		self.objectIndex = 1
		self.currentSquare = square
	end

	self.renderX = x
	self.renderY = y
	self.renderZ = z

	local objects = self:getObjectList()
	if self.objectIndex >= 1 and self.objectIndex <= #objects then
		local object = objects[self.objectIndex]
        local props =object:getProperties()

        if props and (props:Is("WallN") or props:Is("WallW") or props:Is("DoorWallN") or props:Is("DoorWallW")or props:Is("WindowN") or props:Is("WindowW"))
--                 or (instanceof(object, "IsoThumpable") and object:isPaintable())
                then
            -- getPlayer():Say("object" .. tostring(object))
            local color = {r=0.8, g=0.8, b=0.8}
            -- if self.action == "paintnewSprite" then
--             if not self.newSpriteSprite then
--             local newSprite = self.newSprite
            local wallType = object:getSprite():getProperties():Val("PaintingType");
            local newSprite = WallPaper[wallType][self.paperType]
             local north = props:Val("WallStyle") and props:Val("WallStyle"):contains("North");
                 -- local modData = object:getModData()
--                  if north then
            if props:Is("WallN") or props:Is("DoorWallN") or props:Is("WindowN") then
--                 getPlayer():Say("North")
--                 local wallType = object:getSprite():getProperties():Val("PaintingType");
--                 getPlayer():Say(wallType .. "-".. self.paperType)
                newSprite = WallPaper[wallType][self.paperType .. "North"]
--                     getPlayer():Say(tostring(newSprite))
            end
            self.newSpriteSprite = IsoSprite.new()
            self.newSpriteSprite:LoadSingleTexture(newSprite)
            self.newSprite = newSprite
            self.newSpriteSprite:RenderGhostTileColor(x, y, z, color.r, color.g, color.b, 1.0)
        end
	end
end

function ISPaperCursor:onJoypadPressButton(joypadIndex, joypadData, button)
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

function ISPaperCursor:getAPrompt()
	return getText("ContextMenu_ApplyWallpaper")
end

function ISPaperCursor:getLBPrompt()
	if #self:getObjectList() > 1 then
		return "Previous Object"
	end
	return nil
end

function ISPaperCursor:getRBPrompt()
	if #self:getObjectList() > 1 then
		return "Next Object"
	end
	return nil
end

function ISPaperCursor:canPaper(object)
	if not object or not object:getSquare() or not object:getSprite() then return false end
	if not object:getSquare():isCouldSee(self.player) then return false end
	if not self:hasItems() then return false end
	local props = object:getProperties()
	-- if self.action == "paintThump" then
		-- if instanceof(object, "IsoThumpable") and object:isPaintable() then
			-- local modData = object:getModData()
			-- return Painting[modData.wallType][self.args.paperType] ~= nil
		-- end
		if props and props:Is("IsPaintable") then
			local wallType = props:Val("PaintingType")
			if WallPaper[wallType] ~= nil and WallPaper[wallType][self.paperType] ~= nil then
				-- getPlayer():Say("YES!")
				return true
			end
		end
	-- end
	-- if self.action == "plaster" then
		-- if instanceof(object, "IsoThumpable") and object:canBePlastered() then
			-- return true
		-- end
	-- end
	return false
end

function ISPaperCursor:hasItems()
	local playerObj = self.character
	local playerInv = playerObj:getInventory()
	-- if self.action == "paintnewSprite" or self.action == "paintThump" then
		if not ISBuildMenu.cheat then
			local paintBrush = playerInv:getFirstTagRecurse("Paintbrush")
			-- local paintCan = playerInv:getFirstTypeRecurse(self.args.paperType)"
			local paintCan = true
			local paste = playerInv:getFirstTagEvalRecurse("WallpaperPaste", predicateEnoughPaste)
			local scissors = playerInv:getFirstTagEvalRecurse("Scissors", predicateNotBroken)
			-- getPlayer():Say("Has Items " .. tostring(paintBrush ~= nil and paintCan ~= nil and paste ~= nil))
			return paintBrush ~= nil and paintCan ~= nil and paste ~= nil and scissors ~= nil
		end
		return true
	-- end
	-- if self.action == "plaster" then
		-- if not ISBuildMenu.cheat then
			-- local plaster = playerInv:getFirstTypeRecurse("BucketPlasterFull")
			-- return plaster ~= nil
		-- end
		-- return true
	-- end
	-- error "unhandled action in ISPaperCursor:hasItems()"
end

function ISPaperCursor:getObjectList()
	local square = getCell():getGridSquare(self.renderX, self.renderY, self.renderZ)
	if not square then return {} end
	local objects = {}
	for i = square:getObjects():size(),1,-1 do
		local object = square:getObjects():get(i-1)
		if self:canPaper(object) then
			table.insert(objects, object)
		end
	end
		-- getPlayer():Say("objects" .. tostring(objects))
	return objects
end

function ISPaperCursor:new(character, paperType, newSprite)
-- 	print("paperType " .. tostring(paperType))
-- 	getPlayer():Say("paperType " .. tostring(paperType))
-- 	print("newSpite " .. tostring(newSprite))
-- 	getPlayer():Say("newSpite " .. tostring(newSprite))
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o:init()
	o.character = character
	o.player = character:getPlayerNum()
	o.skipBuildAction = true
	o.noNeedHammer = false
	o.skipWalk = true
	o.renderFloorHelper = true
--	o.dragNilAfterPlace = true
	o.action = action
	o.paperType = paperType
	o.newSprite = newSprite
	o.objectIndex = 1
	o.renderX = -1
	o.renderY = -1
	o.renderZ = -1
	return o
end

