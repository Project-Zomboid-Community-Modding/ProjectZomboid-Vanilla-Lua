--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISScrollingListBox"

MapSpawnSelect = ISPanelJoypad:derive("MapSpawnSelect")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local FONT_HGT_LARGE = getTextManager():getFontHeight(UIFont.Large)
local FONT_HGT_TITLE = getTextManager():getFontHeight(UIFont.Title)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local JOYPAD_TEX_SIZE = 32
local WORLD_MAP, WORLD_MAP_X, WORLD_MAP_Y, WORLD_MAP_H, WORLD_MAP_W, WORLD_MAP_SCALE
local ZOOM_X, ZOOM_Y, ZOOM_SCALE

-----

MapSpawnSelectImage = ISUIElement:derive("MapSpawnSelectImage")

function MapSpawnSelectImage:instantiate()
	self.javaObject = UIWorldMap.new(self)
	self.mapAPI = self.javaObject:getAPIv3()
	self.mapAPI:setBoolean("ClampBaseZoomToPoint5", false)
	self.mapAPI:setBoolean("DebugInfo", false)
	self.mapAPI:setBoolean("ImagePyramid", true)
	self.mapAPI:setBoolean("InfiniteZoom", true) -- // FIXME: needed at the moment
	self.mapAPI:setBoolean("Isometric", false)
	self.javaObject:setX(self.x)
	self.javaObject:setY(self.y)
	self.javaObject:setWidth(self.width)
	self.javaObject:setHeight(self.height)
	self.javaObject:setAnchorLeft(self.anchorLeft)
	self.javaObject:setAnchorRight(self.anchorRight)
	self.javaObject:setAnchorTop(self.anchorTop)
	self.javaObject:setAnchorBottom(self.anchorBottom)
	self:createChildren()
end

function MapSpawnSelectImage:prerender()
	ISUIElement.prerender(self)
	if self:getWidth() < 1 then -- size starts at zero
		return
	end
	if not self.hasResetView and (self.mapAPI:getDataCount() > 0) and self.mapAPI:isDataLoaded() then
		self.hasResetView = true
		MapUtils.initDefaultStyleV1(self)
		local styleAPI = self.javaObject:getAPIv1():getStyleAPI()
		styleAPI:removeLayerById("forest")
		MapUtils.overlayPaper(self)
		self.mapAPI:setBoundsFromData()
		self.mapAPI:resetView()
	elseif self.pyramidFileName and not self.hasResetView then
		self.hasResetView = true
		self.mapAPI:setBoundsInSquares(0, 0, self.mapAPI:getImagePyramidWidthInSquares(self.pyramidFileName), self.mapAPI:getImagePyramidHeightInSquares(self.pyramidFileName))
		self.mapAPI:resetView()
	end
	if self.hasResetView and not self.shownInitialLocation then
		self.shownInitialLocation = true
		local selectedItem = self.parent.listbox.items[self.parent.listbox.selected].item
		if selectedItem.zoomS == 0 then

		else
			self.mapAPI:centerOn(selectedItem.zoomX, selectedItem.zoomY)
			self.mapAPI:setZoom(selectedItem.zoomS)
		end
	end
end

function MapSpawnSelectImage:onMouseDown(x, y)
	self.dragging = true
	self.dragMoved = false
	self.dragStartX = x
	self.dragStartY = y
	self.dragStartCX = self.mapAPI:getCenterWorldX()
	self.dragStartCY = self.mapAPI:getCenterWorldY()
	self.dragStartZoomF = self.mapAPI:getZoomF()
	self.dragStartWorldX = self.mapAPI:uiToWorldX(x, y)
	self.dragStartWorldY = self.mapAPI:uiToWorldY(x, y)
	return true
end

function MapSpawnSelectImage:onMouseMove(dx, dy)
	if self.dragging then
		local mouseX = self:getMouseX()
		local mouseY = self:getMouseY()
		if not self.dragMoved and math.abs(mouseX - self.dragStartX) <= 4 and math.abs(mouseY - self.dragStartY) <= 4 then
			return
		end
		self.dragMoved = true
		local worldX = self.mapAPI:uiToWorldX(mouseX, mouseY, self.dragStartZoomF, self.dragStartCX, self.dragStartCY)
		local worldY = self.mapAPI:uiToWorldY(mouseX, mouseY, self.dragStartZoomF, self.dragStartCX, self.dragStartCY)
		self.mapAPI:centerOn(self.dragStartCX + self.dragStartWorldX - worldX, self.dragStartCY + self.dragStartWorldY - worldY)
	end
	return true
end

function MapSpawnSelectImage:onMouseMoveOutside(dx, dy)
	return self:onMouseMove(dx, dy)
end

function MapSpawnSelectImage:onMouseUp(x, y)
	self.dragging = false
	return true
end

function MapSpawnSelectImage:onMouseUpOutside(x, y)
	self.dragging = false
	return true
end

function MapSpawnSelectImage:onMouseDoubleClick(x, y)
	self.mapAPI:resetView()
end

function MapSpawnSelectImage:onMouseWheel(del)
	self.mapAPI:zoomAt(self:getMouseX(), self:getMouseY(), del)
	return true
end

function MapSpawnSelectImage:clear()
	self.mapAPI:clearData()
	self.mapAPI:clearImages()
	self.pyramidFileName = nil
	self.hasResetView = false
	self.shownInitialLocation = false
end

function MapSpawnSelectImage:setImagePyramid(fileName)
	self.mapAPI:addImagePyramid(fileName)
	self.pyramidFileName = fileName
	self.mapAPI:setBoolean("ImagePyramid", true)
end

function MapSpawnSelectImage:initMapData(directory)
	MapUtils.initDirectoryMapData(self, directory)
	self.mapAPI:setBoolean("ImagePyramid", false)
end

function MapSpawnSelectImage:hasSomethingToDisplay()
	return self.mapAPI:getDataCount() + self.mapAPI:getImagesCount() > 0
end

function MapSpawnSelectImage:new(x, y, width, height)
	local o = ISPanel.new(self, x, y, width, height) -- width=0 and height=0
	return o
end

-----

MapSpawnSelectListBox = ISScrollingListBox:derive("MapSpawnSelectListBox")

function MapSpawnSelectListBox:render()
	ISScrollingListBox.render(self)
--	self:drawRectBorder(self.listbox:getX(), self.listbox:getY(), self.listbox:getWidth(), self.listbox:getHeight(), 0.9, 0.4, 0.4, 0.4)
	if self.joyfocus then
		self:drawRectBorder(0, -self:getYScroll(), self:getWidth(), self:getHeight(), 0.4, 0.2, 1.0, 1.0);
		self:drawRectBorder(1, 1-self:getYScroll(), self:getWidth()-2, self:getHeight()-2, 0.4, 0.2, 1.0, 1.0);
	end
end

function MapSpawnSelectListBox:onMouseDown(x, y)
	ISScrollingListBox.onMouseDown(self, x, y)
	self.parent.selectedMapIndex = nil
end

function MapSpawnSelectListBox:onJoypadDirUp(joypadData)
	if self.selected == 1 and self.parent.textEntry and self.parent.textEntry:isVisible() then
		self.parent.textEntry:focus()
		joypadData.focus = self.parent.textEntry
		updateJoypadFocus(joypadData)
		return
	end
	ISScrollingListBox.onJoypadDirUp(self, joypadData)
end

function MapSpawnSelectListBox:onJoypadDirRight(joypadData)
	joypadData.focus = self.parent.richText
	updateJoypadFocus(joypadData)
end

function MapSpawnSelectListBox:onJoypadBeforeDeactivate(joypadData)
	self.parent:onJoypadBeforeDeactivate(joypadData)
end

-----

MapSpawnSelectInfoPanel = ISRichTextPanel:derive("MapSpawnSelectInfoPanel")

function MapSpawnSelectInfoPanel:prerender()
	self:doRightJoystickScrolling(10, 10)
	ISRichTextPanel.prerender(self)
end

function MapSpawnSelectInfoPanel:render()
	ISRichTextPanel.render(self)
	if self.joyfocus then
		self:drawRectBorder(0, -self:getYScroll(), self:getWidth(), self:getHeight(), 0.4, 0.2, 1.0, 1.0);
		self:drawRectBorder(1, 1-self:getYScroll(), self:getWidth()-2, self:getHeight()-2, 0.4, 0.2, 1.0, 1.0);
	end
end

MapSpawnSelectInfoPanel.doRightJoystickScrolling = ISPanelJoypad.doRightJoystickScrolling

function MapSpawnSelectInfoPanel:onJoypadDown(button, joypadData)
	if button == Joypad.AButton then
		self.parent.nextButton:forceClick()
	end
	if button == Joypad.BButton then
		self.parent.backButton:forceClick()
	end
end

function MapSpawnSelectInfoPanel:onJoypadDirUp(joypadData)
	self:setYScroll(self:getYScroll() + 48)
end

function MapSpawnSelectInfoPanel:onJoypadDirDown(joypadData)
	self:setYScroll(self:getYScroll() - 48)
end

function MapSpawnSelectInfoPanel:onJoypadDirLeft(joypadData)
	self:setYScroll(0)
	joypadData.focus = self.parent.listbox
	updateJoypadFocus(joypadData)
end

function MapSpawnSelectInfoPanel:onJoypadBeforeDeactivate(joypadData)
	self.parent:onJoypadBeforeDeactivate(joypadData)
end

-----

function MapSpawnSelect:initialise()
	ISPanelJoypad.initialise(self)
end

function MapSpawnSelect:getFixedSpawnRegion()
	if not isClient() then return nil end
	local spawnPoint = getServerOptions():getOption("SpawnPoint")
	if not spawnPoint or #spawnPoint:split(",") ~= 3 then
		return nil
    end
	local xyz = spawnPoint:split(",")
	local x = tonumber(xyz[1])
	local y = tonumber(xyz[2])
	local z = tonumber(xyz[3])
	if x and y and z and (x ~= 0 or y ~= 0) then
		return { {
			name = getText("UI_mapspawn_ServerSpawnPoint"), points = {
				unemployed = {
					{ posX = x, posY = y, posZ = z },
				},
			}
		} }
	end
	return nil
end

function MapSpawnSelect:getSafehouseSpawnRegion()
	if not isClient() then return nil end
	if not getServerOptions():getBoolean("SafehouseAllowRespawn") then return nil end
	local username = getClientUsername()
	if MainScreen.instance.inGame then
		if CoopCharacterCreation.instance.playerIndex > 0 then
			username = CoopUserName.instance:getUserName()
		end
	end
	for i=0,SafeHouse.getSafehouseList():size()-1 do
		local safe = SafeHouse.getSafehouseList():get(i);
		if safe:isRespawnInSafehouse(username) and (safe:getPlayers():contains(username) or (safe:getOwner() == username)) then
			local x = safe:getX() + (safe:getH() / 2);
			local y = safe:getY() + (safe:getW() / 2);
			local z = 0;
			return { {
				name = getText("UI_mapspawn_Safehouse"), points = {
					unemployed = {
						{ posX = x, posY = y, posZ = z },
					},
				}
			} }
		end
	end
	return nil
end

function MapSpawnSelect:getChallengeSpawnRegion()
	if not getCore():isChallenge() then return nil end
	return LastStandData.getSpawnRegion()
end

function MapSpawnSelect:getSpawnRegions()
	return self:getSafehouseSpawnRegion() or self:getFixedSpawnRegion() or self:getChallengeSpawnRegion() or SpawnRegionMgr.getSpawnRegions()
end

function MapSpawnSelect:hasChoices()
	local regions = self:getSpawnRegions()
	return regions and #regions > 1
end

function MapSpawnSelect:useDefaultSpawnRegion()
	self.selectedRegion = nil
	local regions = self:getSpawnRegions()
	if not regions or #regions == 0 then return end
	self.selectedRegion = regions[1]
	return self.selectedRegion
end

function MapSpawnSelect:fillList()
	self.listbox:clear()
	WORLD_MAP = nil
	self.mapPanel:clear()
	local spawnSelectImagePyramid = nil

	self.sortedList = {};
	self.notSortedList = {};

	local regions = self:getSpawnRegions()
	if not regions then return end
	for _,v in ipairs(regions) do
		local info = getMapInfo(v.name)
		if info then
			local item = {};
			item.name = info.title or "NO TITLE";
			item.region = v;
			item.dir = v.name;
			item.desc = info.description or "NO DESCRIPTION";
			--item.worldimage = info.thumb;
			if info.spawnSelectImagePyramid then
				spawnSelectImagePyramid = info.spawnSelectImagePyramid -- only one is supported
--			elseif info.worldmap then
--				WORLD_MAP = info.worldmap
			end
			item.zoomX = info.zoomX
			item.zoomY = info.zoomY
			item.zoomS = info.zoomS
			item.demoVideo = info.demoVideo
			--self.listbox:addItem(item.name, item);
			self:checkSorted(item);
		else
			local item = {}
			item.name = v.name;
			item.region = v;
			item.dir = "";
			item.desc = "";
			item.worldimage = nil;
			self:checkSorted(item);
			--self.listbox:addItem(item.name, item);
		end
	end
	--self.listbox:sort()
	--self:sortList();
	if #self.listbox.items > 1 then
        local item = {}
        item.name = getText("UI_mapspawn_random");
        item.region = nil;
        item.dir = "";
        item.desc = "";
        item.worldimage = nil;
        --self.listbox:addItem(item.name, item);
		table.insert(self.notSortedList, item);
    end

	if spawnSelectImagePyramid then
		self.mapPanel:setImagePyramid(spawnSelectImagePyramid)
	else
		for _,v in ipairs(regions) do
			local info = getMapInfo(v.name)
			if info then
				self.mapPanel:initMapData('media/maps/'..v.name) -- FIXME: order of multiple maps matters
				for _,dir in ipairs(info.lots) do
					self.mapPanel:initMapData('media/maps/'..dir) -- FIXME: order of multiple maps matters
				end
			end
		end
	end

	-- list has been sorted with MapsOrder
	for i,v in ipairs(self.sortedList) do
		self.listbox:addItem(v.name, v);
	end

	for i,v in ipairs(self.notSortedList) do
		self.listbox:addItem(v.name, v);
	end

	self:hideOrShowSaveName()
	self:recalculateMapSize()

	self.mapPanel.shownInitialLocation = false
end

function MapSpawnSelect:checkSorted(item)

	local found = false;
	if IgnoredMap then
		for i,mapName in ipairs(IgnoredMap) do
			if mapName == item.name then
				print("ignoring", item.name)
				return;
			end
		end
	end

	if MapsOrder then
		for i,mapName in ipairs(MapsOrder) do
			if mapName == item.name then
				table.insert(self.sortedList, i, item);
				found = true;
				break;
			end
		end
	end

	if not found then
		table.insert(self.notSortedList, item)
	end

end

function MapSpawnSelect:hideOrShowSaveName()
	-- There is no "Save Name" field when creating a co-op player
	if MainScreen.instance.inGame then return end

	-- When loading an existing save, don't display "Save Name" field
	if MainScreen.instance.createWorld and not getCore():isChallenge() then
		self.startY = UI_BORDER_SPACING*3+1 + FONT_HGT_TITLE + FONT_HGT_MEDIUM+6
		self.textEntryLabel:setVisible(true)
		self.textEntry:setVisible(true)
		self.seedPanel:setVisible(true)
		self:checkSeed()
	else
		self.startY = UI_BORDER_SPACING*2+1 + FONT_HGT_TITLE;
		self.textEntryLabel:setVisible(false)
		self.textEntry:setVisible(false)
		self.seedPanel:setVisible(false)
	end

	self.listbox:setY(self.startY)
	self.listbox:setHeight((FONT_HGT_LARGE+6)*10)
end

function MapSpawnSelect:onOptionMouseDown(button, x, y)
	self:setVisible(false)
	if button.internal == "BACK" then
		self:clickBack()
	elseif button.internal == "NEXT" then
		self:clickNext()
	end
end

function MapSpawnSelect:onDblClick()
	self.nextButton:forceClick()
end

function MapSpawnSelect:clickBack()
    if MainScreen.instance.createWorld then
        self:discardGenParams()
    end

	if getWorld():getGameMode() == "Multiplayer" then
		backToSinglePlayer()
		getCore():ResetLua("default", "exitJoinServer")
	elseif self.previousScreen == "LastStandPlayerSelect" then
		self.previousScreen = nil
		LastStandPlayerSelect.instance:setVisible(true, self.joyfocus)
	elseif self.previousScreen == "LoadGameScreen" then
		MainScreen.resetLuaIfNeeded()
		self.previousScreen = nil
		LoadGameScreen.instance:setSaveGamesList()
		MainScreen.instance.loadScreen:setVisible(true, self.joyfocus)
	elseif self.previousScreen == "NewGameScreen" then
		self.previousScreen = nil
		MainScreen.instance.soloScreen:setVisible(true, self.joyfocus)
	elseif self.previousScreen == "WorldSelect" then
		self.previousScreen = nil
		MainScreen.instance.worldSelect:setVisible(true, self.joyfocus)
	end
end

function MapSpawnSelect:clickNext()
    if MainScreen.instance.createWorld then
        self:saveGenParams()
    end

    if self.listbox.items[self.listbox.selected].item.name == getText("UI_mapspawn_random") then
        local roll = ZombRand((#self.listbox.items - 1)) + 1
--         print("Roll " .. tostring(roll))
        self.listbox.selected = roll
    end

	self.selectedRegion = self.listbox.items[self.listbox.selected].item.region
	setSpawnRegion(self.selectedRegion.name)
	getCore():setSelectedMap(tostring(self.selectedRegion.name))
     --print("self.selectedRegion.name" .. tostring(self.selectedRegion.name))
	self:setVisible(false)
	if MainScreen.instance.createWorld then
		getWorld():setWorld(sanitizeWorldName(self.textEntry:getText()));
		getWorld():setWorld(sanitizeWorldName(self.textEntry:getText()));
	end
	if getWorld():getGameMode() == "Sandbox" and not checkSaveFileExists("map_sand.bin") then
		MainScreen.instance.sandOptions.previousScreen = "MapSpawnSelect";
		MainScreen.instance.sandOptions:setVisible(true, self.joyfocus)
	else
		MainScreen.instance.charCreationProfession.previousScreen = "MapSpawnSelect";
		MainScreen.instance.charCreationProfession:setVisible(true, self.joyfocus)
	end
end

function MapSpawnSelect:prerender()
	ISPanelJoypad.prerender(self)
	local enable = true
	if self.textEntry and self.textEntry:isVisible() then
		local rawText = self.textEntry:getText()
		local worldName = sanitizeWorldName(rawText)
		if worldName == "" or worldName ~= rawText or luautils.stringStarts(worldName, ".") or luautils.stringEnds(worldName, ".") then
			enable = false
		else
			local checkExistName = getWorld():getGameMode() .. getFileSeparator() .. worldName
			if checkExistName ~= self.checkExistsName then
				self.checkExistsName = checkExistName
				self.checkExist = checkSaveFolderExists(checkExistName)
			end
			if self.checkExist then
				enable = false
			end
		end
	end
	local focusOnEntry = false
	if self.textEntry then
		self.textEntry:setValid(enable)
		if self.textEntry.joyfocus then
			focusOnEntry = true
		end
	end
	self.nextButton:setEnable(enable)
	if self.ISButtonA and focusOnEntry then
		self.ISButtonA = nil
		self.nextButton:clearJoypadButton()
	elseif not self.ISButtonA and not focusOnEntry and self.joyfocus then
		self:setISButtonForA(self.nextButton)
	end
end

function MapSpawnSelect:render()
	ISPanelJoypad.render(self)
	self:drawTextCentre(getText("UI_mapspawn_title"), self.width / 2, UI_BORDER_SPACING+1, 1, 1, 1, 1, UIFont.Title)

	local selectedItem = self.listbox.items[self.listbox.selected].item;
	local tempString = ""
	if selectedItem.demoVideo then
		local w = 1920
		local h = 1080
		local div = w/(self.richText:getWidth() - UI_BORDER_SPACING*2 - 2)
		local w2 = w / div
		local h2 = h / div
		tempString = "<VIDEOCENTRE:".. selectedItem.demoVideo ..","..w..","..h..","..w2..","..h2..">\n"
	end
	self.richText.text = tempString .. (selectedItem.desc or "");
	self.richText:paginate();
	self:drawRectBorder( self.richText.x, self.richText.y, self.richText:getWidth(), self.richText:getHeight(), 0.3, 1, 1, 1);

	if self.mapPanel:hasSomethingToDisplay() and self.mapPanel.shownInitialLocation then
		if self.listbox.selected ~= self.selectedMapIndex then
			self.selectedMapIndex = self.listbox.selected
			if selectedItem.zoomX ~= nil and not (selectedItem.zoomX == 0 and selectedItem.zoomY == 0 and selectedItem.zoomS == 0) then -- nil during post-death at a player's location
				self.mapPanel.mapAPI:transitionTo(selectedItem.zoomX, selectedItem.zoomY, selectedItem.zoomS)
-- 				self.mapPanel.mapAPI:centerOn(x, y)
-- 				self.mapPanel.mapAPI:setZoom(scale)
			elseif selectedItem.region ~= nil and selectedItem.region.points ~= nil then
				local points = selectedItem.region.points.unemployed
				if points then
					local point = points[1] -- spawn with player
					self.mapPanel.mapAPI:transitionTo(point.posX, point.posY, self.mapPanel.mapAPI:getZoomF())
				end
			end
		end
		return
	end

	if WORLD_MAP ~= nil then --if no map exists for the current world, don't add a map panel
		if selectedItem.zoomS == 0 then
			self:zoomMap(WORLD_MAP:getWidth()/2, WORLD_MAP:getHeight()/2, 1)
		else
			self:zoomMap(selectedItem.zoomX, selectedItem.zoomY, selectedItem.zoomS)
		end
	end
end

function MapSpawnSelect:recalculateMapSize()
	if WORLD_MAP ~= nil or self.mapPanel:hasSomethingToDisplay() then
		---old code for matching exact size ratio of map
		--local mapW = WORLD_MAP:getWidth() --width of map image
		--local mapH = WORLD_MAP:getHeight() --height of map image
		--local maxW = self.width - UI_BORDER_SPACING*3 - 2 - self.width/4 --max width for map
		--local maxH = self.height - FONT_HGT_TITLE - UI_BORDER_SPACING*4 - BUTTON_HGT - 2 --max height for map
		--
		--if maxH > mapH and maxW > mapW then
		--	WORLD_MAP_SCALE = 1
		--else
		--	WORLD_MAP_SCALE = math.max(mapW/maxW, mapH/maxH) -- set the scale of the whole image here
		--end
		--
		--ZOOM_SCALE = WORLD_MAP_SCALE
		--
		--WORLD_MAP_W = math.max(mapW/WORLD_MAP_SCALE, (self.width-UI_BORDER_SPACING*3-2)/2)
		--WORLD_MAP_H = maxH
		--WORLD_MAP_X = self.width - UI_BORDER_SPACING - WORLD_MAP_W
		--WORLD_MAP_Y = FONT_HGT_TITLE + UI_BORDER_SPACING*2 + 1

		WORLD_MAP_W = (self.width-UI_BORDER_SPACING*3-2)*0.75
		WORLD_MAP_H = self.height - FONT_HGT_TITLE - UI_BORDER_SPACING*4 - BUTTON_HGT - 2
		WORLD_MAP_X = self.width - UI_BORDER_SPACING - WORLD_MAP_W
		WORLD_MAP_Y = FONT_HGT_TITLE + UI_BORDER_SPACING*2 + 1
	else
		--no map found, set size to 0 and move off screen
		WORLD_MAP_W = 0
		WORLD_MAP_H = 0
		WORLD_MAP_X = -500
		WORLD_MAP_Y = -500
	end

	--set to nil. zoomMap() will then set the map to its initial position.
	ZOOM_X = nil
	ZOOM_Y = nil
	ZOOM_SCALE = nil

	self.mapPanel:setX(WORLD_MAP_X)
	self.mapPanel:setY(WORLD_MAP_Y)
	self.mapPanel:setWidth(WORLD_MAP_W)
	self.mapPanel:setHeight(WORLD_MAP_H)

	local isMap = (WORLD_MAP_W > 0) and 2 or 1 --if map exists, isMap = 2. this is used in multiplying UI_BORDER_SPACING below

	self.listbox:setWidth(self.width - self.listbox.x - UI_BORDER_SPACING*isMap - WORLD_MAP_W - 1)
	self.richText:setWidth(self.listbox.width)

	if not MainScreen.instance.inGame then
		self.textEntry:setWidth(self.listbox:getRight() - self.textEntry.x)
        self.seedPanel:setWidth(self.listbox.width)
	end
end

function MapSpawnSelect:zoomMap(x, y, scale)
	--- this zoom function takes
	---		the x and y coordinates of a central point in the map,
	---		and a zoom factor, clamped between 1 and WORLD_MAP_SCALE.
	---
	--- it calculates the offset relative to the mapPanel position
	---	and draws the map texture with the desired central point displayed
	--- exactly in the middle of the mapPanel.
	---
	--- ~ Fox Chaotica

	local lerpValue = 0.02 -- how fast the zoom takes to move to new location, between 0 and 1. lower numbers make the zoom take longer
	local snapThreshold = 0.1 -- how close to the target location the zoom needs to be before the zoom snaps to position.

	local fpsAdjust = (UIManager.getSecondsSinceLastRender() * 90) -- I assumed the original lerpValue was determined at 90 FPS
	lerpValue = lerpValue * fpsAdjust

	if ZOOM_X == nil then
		--no coordinates or scale factor exist, set them now
		ZOOM_X = x
		ZOOM_Y = y
		ZOOM_SCALE = scale
	elseif math.abs(ZOOM_X - x) <= snapThreshold and math.abs(ZOOM_Y - y) <= snapThreshold and math.abs(ZOOM_SCALE - scale) <= snapThreshold then
		--current coordinates are close enough to target coordinates, snap to position.
		ZOOM_X = x
		ZOOM_Y = y
		ZOOM_SCALE = scale
	else
		--new coordinates supplied, interpolate between current position and target position.
		ZOOM_X = (ZOOM_X * (1-lerpValue)) + (x*lerpValue)
		ZOOM_Y = (ZOOM_Y * (1-lerpValue)) + (y*lerpValue)
		ZOOM_SCALE = (ZOOM_SCALE * (1-lerpValue)) + (scale*lerpValue)
	end

	-- calculate scale factor based on the largest size possible for the entire map to display.
	local scaleFactor = (WORLD_MAP_SCALE/math.min(math.max(ZOOM_SCALE, 1), WORLD_MAP_SCALE))
	-- calculate X and Y offsets using scale factor.
	local newX = -(ZOOM_X/scaleFactor) + WORLD_MAP_W/2
	local newY = -(ZOOM_Y/scaleFactor) + WORLD_MAP_H/2

	--set up scencil, draw texture, clear all parts of the texture not within the bounds of the stencil.
	self:setStencilRect(WORLD_MAP_X+1, WORLD_MAP_Y+1, WORLD_MAP_W-2, WORLD_MAP_H-2)
	self.mapPanel:drawTextureScaled(WORLD_MAP, newX, newY, (WORLD_MAP:getWidth()/scaleFactor), (WORLD_MAP:getHeight()/scaleFactor), 1, 1, 1, 1)
	self:clearStencilRect()
end

function MapSpawnSelect:doDrawItem(y, item, alt)
	local isMouseOver = self.mouseoverselected == item.index and not self:isMouseOverScrollBar()
	if self.selected == item.index then
		self:drawRect(0, (y), self:getWidth(), item.height-1, 0.3, 0.7, 0.35, 0.15)
	elseif isMouseOver then
		self:drawRect(1, y + 1, self:getWidth() - 2, item.height - 2, 0.95, 0.05, 0.05, 0.05);
	end
	self:drawRectBorder(0, (y), self:getWidth(), item.height, 0.5, self.borderColor.r, self.borderColor.g, self.borderColor.b)
	local fontHgt = getTextManager():getFontFromEnum(UIFont.Large):getLineHeight()
	local textY = y + (item.height - fontHgt) / 2
	self:drawText(item.text, 15, textY, 0.9, 0.9, 0.9, 0.9, UIFont.Large)
	y = y + item.height
	return y
end

function MapSpawnSelect:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
    joypadData.focus = self.listbox
    updateJoypadFocus(joypadData)
    self.listbox:setISButtonForA(self.nextButton)
    self.listbox:setISButtonForB(self.backButton)
end

function MapSpawnSelect:onJoypadBeforeDeactivate_child(joypadData)
	self.parent:onJoypadBeforeDeactivate(joypadData)
end

function MapSpawnSelect:onJoypadBeforeDeactivate(joypadData)
	self.backButton:clearJoypadButton()
	self.nextButton:clearJoypadButton()
	-- focus is on listbox
	self.joyfocus = nil
end

function MapSpawnSelect:onJoypadDown_textEntry(button, joypadData)
	if button == Joypad.BButton then
		self:unfocus()
		self.parent.backButton:forceClick()
		return
	end
	ISTextEntryBox.onJoypadDown(self, button, joypadData)
end

function MapSpawnSelect:onJoypadDirDown_textEntry(joypadData)
	self:unfocus()
	joypadData.focus = self.parent.listbox
end

function MapSpawnSelect:onResolutionChange(oldw, oldh, neww, newh)
	self:recalculateMapSize()

	local btnPadding = JOYPAD_TEX_SIZE + UI_BORDER_SPACING*2
	local btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_advWorld_random_btn"))
	--if self.seedPanel then
	--	self.randomButton:setX(self.seedPanel:getRight() - btnWidth - UI_BORDER_SPACING*2 - 2)
	--	self.seedTextBox:setWidth(self.randomButton.x - self.seedLabel:getRight() - UI_BORDER_SPACING*2)
	--end
end

function MapSpawnSelect:checkSeed()
	if self.seedTextBox:getText() == nil or self.seedTextBox:getText() == "" then
		self:generateNewSeed()
	end
end

function MapSpawnSelect:generateNewSeed()
	self.seedTextBox:setText(WGUtils.instance:generateSeed())
end

function MapSpawnSelect:saveGenParams()
	self:checkSeed()
	WGParams.instance:setSeedString(self.seedTextBox:getText())
	--WGParams.instance:setMinXCell(self.minXSlider:getCurrentValue())
	--WGParams.instance:setMinYCell(self.minYSlider:getCurrentValue())
	--WGParams.instance:setMaxXCell(self.maxXSlider:getCurrentValue())
	--WGParams.instance:setMaxYCell(self.maxYSlider:getCurrentValue())
end

function MapSpawnSelect:discardGenParams()
    self.seedTextBox:setText("")
    WGParams.instance:setSeedString(self.seedTextBox:getText())
end

function MapSpawnSelect:create()
	self.mapPanel = MapSpawnSelectImage:new(0, 0, 0, 0)
	self.mapPanel:initialise();
	self.mapPanel:instantiate();
	self.mapPanel:setAnchorLeft(false);
	self.mapPanel:setAnchorRight(true);
	self:addChild(self.mapPanel)

	if not MainScreen.instance.inGame then -- don't show savefile entry in splitscreen

	self.textEntryLabel = ISLabel:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING*2+1 + FONT_HGT_TITLE, FONT_HGT_MEDIUM+6, getText("UI_mapselecter_savename"), 1, 1, 1, 1, UIFont.Medium, true);
	self.textEntryLabel:initialise();
	self.textEntryLabel:instantiate();
	self.textEntryLabel:setAnchorLeft(true);
	self.textEntryLabel:setAnchorRight(true);
	self.textEntryLabel:setAnchorTop(false);
	self.textEntryLabel:setAnchorBottom(false);
	self:addChild(self.textEntryLabel);

	local inset = 6
	self.textEntry = ISTextEntryBox:new("", self.textEntryLabel:getRight() + UI_BORDER_SPACING, self.textEntryLabel.y + (self.textEntryLabel.height - (FONT_HGT_MEDIUM + inset)) / 2, self.width-(self.textEntryLabel:getRight() + UI_BORDER_SPACING) - UI_BORDER_SPACING-1, FONT_HGT_MEDIUM + inset);
	self.textEntry.font = UIFont.Medium
	self.textEntry:initialise();
	self.textEntry:instantiate();
	self.textEntry:setAnchorLeft(true);
	self.textEntry:setAnchorRight(true);
	self.textEntry:setAnchorTop(true);
	self.textEntry:setAnchorBottom(false);
	self.textEntry.onJoypadDown = self.onJoypadDown_textEntry
	self.textEntry.onJoypadDirDown = self.onJoypadDirDown_textEntry
	self:addChild(self.textEntry);
	local sdf = SimpleDateFormat.new("yyyy-MM-dd_HH-mm-ss", Locale.ENGLISH);
	self.textEntry:setText(sdf:format(Calendar.getInstance():getTime()));

	end -- not MainScreen.instance.inGame

--	self.listbox = ISScrollingListBox:new(padX, titleHgt, self.width-padX*2, self.height-btnPadY-btnHgt-24-titleHgt)
--	self.listbox:initialise()
--	self.listbox:setAnchorRight(true)
--	self.listbox:setAnchorBottom(true)
--	self.listbox.doDrawItem = MapSpawnSelect.doDrawItem
--	self.listbox:setOnMouseDoubleClick(self, MapSpawnSelect.onDblClick)
--	self:addChild(self.listbox)


	self.listbox = MapSpawnSelectListBox:new(UI_BORDER_SPACING+1, self.startY, (self.width - UI_BORDER_SPACING*3 - 2) / 4, (FONT_HGT_LARGE+6)*10);
	self.listbox:initialise();
	self.listbox:instantiate();
	self.listbox:setAnchorLeft(true);
	self.listbox:setAnchorTop(true);
	self:addChild(self.listbox);
	self.listbox.itemheight = FONT_HGT_LARGE+6;
	self.listbox.doDrawItem = MapSpawnSelect.doDrawItem
	self.listbox:setOnMouseDoubleClick(self, MapSpawnSelect.onDblClick)
	self.listbox.drawBorder = true;
	self.listbox.backgroundColor  = {r=0, g=0, b=0, a=0.5};

    local advPanelHeight = UI_BORDER_SPACING*2 + BUTTON_HGT + 2
	self.richText = MapSpawnSelectInfoPanel:new(self.listbox.x, self.listbox:getBottom() + UI_BORDER_SPACING, self.listbox.width, self.height - self.listbox:getBottom() - UI_BORDER_SPACING*4 - BUTTON_HGT - 1 - advPanelHeight);
	self.richText.marginRight = UI_BORDER_SPACING+1
	self.richText.marginLeft = UI_BORDER_SPACING+1
	self.richText.autosetheight = false;
	self.richText.clip = true
	self.richText:initialise();
	self.richText:setAnchorLeft(true);
	self.richText:setAnchorBottom(true);
	self.richText.backgroundColor  = {r=0, g=0, b=0, a=0.5};
	self:addChild(self.richText);
	self.richText:addScrollBars()

	local btnPadding = JOYPAD_TEX_SIZE + UI_BORDER_SPACING*2
    if not MainScreen.instance.inGame then -- don't show seed in splitscreen
		--local advPanelHeight = UI_BORDER_SPACING*4 + BUTTON_HGT*3 + 2
		self.seedPanel = ISPanel:new(self.listbox.x,self.richText:getBottom() + UI_BORDER_SPACING, self.listbox.width, advPanelHeight)
		self.seedPanel:initialise()
		self.seedPanel:instantiate()
		self.seedPanel:setAnchorsTBLR(false, true, true, false)
		self.seedPanel.backgroundColor  = {r=0, g=0, b=0, a=0.5};
		self:addChild(self.seedPanel)

		self.seedLabel = ISLabel:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, BUTTON_HGT, getText("UI_advWorld_seed_label") .. ":", 1.0, 1.0, 1.0, 1.0, UIFont.Medium, true)
		self.seedLabel:initialise()
		self.seedLabel:instantiate()
		self.seedLabel:setAnchorsTBLR(true, false, true, false)
		self.seedPanel:addChild(self.seedLabel)

		local btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_advWorld_random_btn"))
		self.randomButton = ISButton:new(self.seedPanel:getRight() - btnWidth - UI_BORDER_SPACING*2 - 2, self.seedLabel.y, btnWidth, BUTTON_HGT, getText("UI_advWorld_random_btn"), self, self.generateNewSeed)
		self.randomButton:initialise()
		self.randomButton:instantiate()
		self.randomButton:setAnchorsTBLR(true, false, false, true)
		self.randomButton:setEnable(true) -- sets the hard-coded border color
		self.seedPanel:addChild(self.randomButton)

		self.seedTextBox = ISTextEntryBox:new("", self.seedLabel:getRight() + UI_BORDER_SPACING, self.seedLabel.y, self.randomButton.x - self.seedLabel:getRight() - UI_BORDER_SPACING*2, BUTTON_HGT)
		self.seedTextBox.font = UIFont.Small
		self.seedTextBox:initialise()
		self.seedTextBox:instantiate()
		self.seedTextBox:setOnlyText(true)
		self.seedTextBox:setMaxTextLength(16)
		self.seedTextBox:setAnchorsTBLR(true, true, true, true)
		self.seedPanel:addChild(self.seedTextBox)
    end -- not MainScreen.instance.inGame

	local btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_btn_back"))
	self.backButton = ISButton:new(UI_BORDER_SPACING+1, self.height - UI_BORDER_SPACING - BUTTON_HGT - 1, btnWidth, BUTTON_HGT, getText("UI_btn_back"), self, MapSpawnSelect.onOptionMouseDown)
	self.backButton.internal = "BACK"
	self.backButton:initialise()
	self.backButton:instantiate()
	self.backButton:setAnchorLeft(true)
	self.backButton:setAnchorTop(false)
	self.backButton:setAnchorBottom(true)
	self.backButton:enableCancelColor()
	self:addChild(self.backButton)

	btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_btn_next"))
	self.nextButton = ISButton:new(self.width - UI_BORDER_SPACING - btnWidth - 1, self.backButton.y, btnWidth, BUTTON_HGT, getText("UI_btn_next"), self, MapSpawnSelect.onOptionMouseDown)
	self.nextButton.internal = "NEXT"
	self.nextButton:initialise()
	self.nextButton:instantiate()
	self.nextButton:setAnchorLeft(false)
	self.nextButton:setAnchorRight(true)
	self.nextButton:setAnchorTop(false)
	self.nextButton:setAnchorBottom(true)
	self.nextButton:enableAcceptColor()
	self:addChild(self.nextButton)
end

function MapSpawnSelect:new(x, y, width, height)
	local o = ISPanelJoypad.new(self, x, y, width, height)
	o.selectedRegion = nil
	o.previousScreen = 'NewGameScreen'
	o.addY = 0;
	o.startY = MainScreen.instance.inGame and UI_BORDER_SPACING*2+1 + FONT_HGT_TITLE or UI_BORDER_SPACING*3+1 + FONT_HGT_TITLE + FONT_HGT_MEDIUM+6;
	MapSpawnSelect.instance = o
	return o
end
