--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

MapUtils = {}

function MapUtils.initDirectoryMapData(mapUI, directory)
	local mapAPI = mapUI.javaObject:getAPIv1()
	local file = directory..'/worldmap-forest.xml'
	if fileExists(file) then
		mapAPI:addData(file)
	end
	file = directory..'/worldmap.xml'
	if fileExists(file) then
		mapAPI:addData(file)
	end

	-- This call indicates the end of XML data files for the directory.
	-- If map features exist for a particular cell in this directory,
	-- then no data added afterwards will be used for that same cell.
	mapAPI:endDirectoryData()

	mapAPI:addImages(directory)
end

function MapUtils.initDefaultMapData(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	mapAPI:clearData()
	-- Add data from highest priority (mods) to lowest priority (vanilla)
	local dirs = getLotDirectories()
	for i=1,dirs:size() do
		MapUtils.initDirectoryMapData(mapUI, 'media/maps/'..dirs:get(i-1))
	end
end

function MapUtils.initDirectoryStreetData(mapUI, directory)
	local mapAPI = mapUI.javaObject:getAPIv3()
	local streetsAPI = mapAPI:getStreetsAPI()
	local file = directory..'/streets.xml'
	if fileExists(file) then
		streetsAPI:addStreetData(file)
	end
end

function MapUtils.initDefaultStreetData(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv3()
	local streetsAPI = mapAPI:getStreetsAPI()
	streetsAPI:clearStreetData()
	-- Add data from highest priority (mods) to lowest priority (vanilla)
	local dirs = getLotDirectories()
	for i=1,dirs:size() do
		MapUtils.initDirectoryStreetData(mapUI, 'media/maps/'..dirs:get(i-1))
	end
end

local MINZ = 0
local MAXZ = 24
local MINZ_BUILDINGS = 13

local WATER_TEXTURE = false

function MapUtils.initDefaultStyleV1(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	local styleAPI = mapAPI:getStyleAPI()

	local ColorblindPatterns = getCore():getOptionColorblindPatterns()
	mapAPI:setBoolean("ColorblindPatterns", ColorblindPatterns)

	local r,g,b = 219/255, 215/255, 192/255
	mapAPI:setBackgroundRGBA(r, g, b, 1.0)
	mapAPI:setUnvisitedRGBA(r * 0.915, g * 0.915, b * 0.915, 1.0)
	mapAPI:setUnvisitedGridRGBA(r * 0.777, g * 0.777, b * 0.777, 1.0)

	styleAPI:clear()

	local layer = styleAPI:newPolygonLayer("forest")
	layer:setMinZoom(13.5)
	layer:setFilter("natural", "forest")
	if true then
		layer:addFill(MINZ, 189, 197, 163, 0)
		layer:addFill(14.5, 189, 197, 163, 0)
		layer:addFill(15, 189, 197, 163, 255)
		layer:addFill(MAXZ, 189, 197, 163, 255)
	else
		layer:addFill(MINZ, 255, 255, 255, 255)
		layer:addFill(MAXZ, 255, 255, 255, 255)
		layer:addTexture(MINZ, "media/textures/worldMap/Grass.png")
		layer:addTexture(MAXZ, "media/textures/worldMap/Grass.png")
		layer:addScale(13.5, 4.0)
		layer:addScale(MAXZ, 4.0)
	end
	
	layer = styleAPI:newPolygonLayer("water")
	layer:setMinZoom(MINZ)
	layer:setFilter("water", "river")
	if not WATER_TEXTURE then
		layer:addFill(MINZ, 59, 141, 149, 255)
		layer:addFill(MAXZ, 59, 141, 149, 255)
	else
		layer:addFill(MINZ, 59, 141, 149, 255)
		layer:addFill(14.5, 59, 141, 149, 255)
		layer:addFill(14.5, 255, 255, 255, 255)
		layer:addTexture(MINZ, nil)
		layer:addTexture(14.5, nil)
		layer:addTexture(14.5, "media/textures/worldMap/Water.png")
		layer:addTexture(MAXZ, "media/textures/worldMap/Water.png")
--		layer:addScale(MINZ, 4.0)
--		layer:addScale(MAX, 4.0)
	end

	layer = styleAPI:newPolygonLayer("road-trail")
	layer:setMinZoom(12.0)
	layer:setFilter("highway", "trail")
	layer:addFill(12.25, 185, 122, 87, 0)
	layer:addFill(13, 185, 122, 87, 255)
	layer:addFill(MAXZ, 185, 122, 87, 255)

	layer = styleAPI:newPolygonLayer("road-tertiary")
	layer:setMinZoom(11.0)
	layer:setFilter("highway", "tertiary")
	layer:addFill(11.5, 171, 158, 143, 0)
	layer:addFill(13, 171, 158, 143, 255)
	layer:addFill(MAXZ, 171, 158, 143, 255)

	layer = styleAPI:newPolygonLayer("road-secondary")
	layer:setMinZoom(11.0)
	layer:setFilter("highway", "secondary")
	layer:addFill(MINZ, 134, 125, 113, 255)
	layer:addFill(MAXZ, 134, 125, 113, 255)

	layer = styleAPI:newPolygonLayer("road-primary")
	layer:setMinZoom(11.0)
	layer:setFilter("highway", "primary")
	layer:addFill(MINZ, 134, 125, 113, 255)
	layer:addFill(MAXZ, 134, 125, 113, 255)

	layer = styleAPI:newPolygonLayer("railway")
	layer:setMinZoom(14.0)
	layer:setFilter("railway", "*")
	layer:addFill(MINZ, 200, 191, 231, 255)
	layer:addFill(MAXZ, 200, 191, 231, 255)

	-- Default, same as building-Residential
	layer = styleAPI:newPolygonLayer("building")
	layer:setMinZoom(MINZ_BUILDINGS)
	layer:setFilter("building", "yes")
	if ColorblindPatterns then
		layer:addTexture(MINZ, "media/textures/worldMap/Colorblind Patterns/Pattern_Residential.png", "ScreenPixel")
		layer:addScale(MINZ, 4)
	end
	layer:addFill(MINZ_BUILDINGS, 210, 158, 105, 0)
	layer:addFill(MINZ_BUILDINGS + 0.5, 210, 158, 105, 255)
	layer:addFill(MAXZ, 210, 158, 105, 255)

	layer = styleAPI:newPolygonLayer("building-Residential")
	layer:setMinZoom(MINZ_BUILDINGS)
	layer:setFilter("building", "Residential")
	if ColorblindPatterns then
		layer:addTexture(MINZ, "media/textures/worldMap/Colorblind Patterns/Pattern_Residential.png", "ScreenPixel")
		layer:addScale(MINZ, 4)
	end
	layer:addFill(MINZ_BUILDINGS, 210, 158, 105, 0)
	layer:addFill(MINZ_BUILDINGS + 0.5, 210, 158, 105, 255)
	layer:addFill(MAXZ, 210, 158, 105, 255)

	layer = styleAPI:newPolygonLayer("building-CommunityServices")
	layer:setMinZoom(MINZ_BUILDINGS)
	layer:setFilter("building", "CommunityServices")
	if ColorblindPatterns then
		layer:addTexture(MINZ, "media/textures/worldMap/Colorblind Patterns/Pattern_Community.png", "ScreenPixel")
		layer:addScale(MINZ, 4)
	end
	layer:addFill(MINZ_BUILDINGS, 139, 117, 235, 0)
	layer:addFill(MINZ_BUILDINGS + 0.5, 139, 117, 235, 255)
	layer:addFill(MAXZ, 139, 117, 235, 255)

	layer = styleAPI:newPolygonLayer("building-Hospitality")
	layer:setMinZoom(MINZ_BUILDINGS)
	layer:setFilter("building", "Hospitality")
	if ColorblindPatterns then
		layer:addTexture(MINZ, "media/textures/worldMap/Colorblind Patterns/Pattern_Hospitality.png", "ScreenPixel")
		layer:addScale(MINZ, 4)
	end
	layer:addFill(MINZ_BUILDINGS, 127, 206, 225, 0)
	layer:addFill(MINZ_BUILDINGS + 0.5, 127, 206, 225, 255)
	layer:addFill(MAXZ, 127, 206, 225, 255)

	layer = styleAPI:newPolygonLayer("building-Industrial")
	layer:setMinZoom(MINZ_BUILDINGS)
	layer:setFilter("building", "Industrial")
	if ColorblindPatterns then
		layer:addTexture(MINZ, "media/textures/worldMap/Colorblind Patterns/Pattern_Industrial.png", "ScreenPixel")
		layer:addScale(MINZ, 4)
	end
	layer:addFill(MINZ_BUILDINGS, 56, 54, 53, 0)
	layer:addFill(MINZ_BUILDINGS + 0.5, 56, 54, 53, 255)
	layer:addFill(MAXZ, 56, 54, 53, 255)

	layer = styleAPI:newPolygonLayer("building-Medical")
	layer:setMinZoom(MINZ_BUILDINGS)
	layer:setFilter("building", "Medical")
	if ColorblindPatterns then
		layer:addTexture(MINZ, "media/textures/worldMap/Colorblind Patterns/Pattern_Medical.png", "ScreenPixel")
		layer:addScale(MINZ, 4)
	end
	layer:addFill(MINZ_BUILDINGS, 229, 128, 151, 0)
	layer:addFill(MINZ_BUILDINGS + 0.5, 229, 128, 151, 255)
	layer:addFill(MAXZ, 229, 128, 151, 255)

	layer = styleAPI:newPolygonLayer("building-RestaurantsAndEntertainment")
	layer:setMinZoom(MINZ_BUILDINGS)
	layer:setFilter("building", "RestaurantsAndEntertainment")
	if ColorblindPatterns then
		layer:addTexture(MINZ, "media/textures/worldMap/Colorblind Patterns/Pattern_RestaurantsEntertainment.png", "ScreenPixel")
		layer:addScale(MINZ, 4)
	end
	layer:addFill(MINZ_BUILDINGS, 245, 225, 60, 0)
	layer:addFill(MINZ_BUILDINGS + 0.5, 245, 225, 60, 255)
	layer:addFill(MAXZ, 245, 225, 60, 255)

	layer = styleAPI:newPolygonLayer("building-RetailAndCommercial")
	layer:setMinZoom(MINZ_BUILDINGS)
	layer:setFilter("building", "RetailAndCommercial")
	if ColorblindPatterns then
		layer:addTexture(MINZ, "media/textures/worldMap/Colorblind Patterns/Pattern_RetailCommercial.png", "ScreenPixel")
		layer:addScale(MINZ, 4)
	end
	layer:addFill(MINZ_BUILDINGS, 184, 205, 84, 0)
	layer:addFill(MINZ_BUILDINGS + 0.5, 184, 205, 84, 255)
	layer:addFill(MAXZ, 184, 205, 84, 255)
end

function MapUtils.initDefaultStyleV3(mapUI)
    MapUtils.initDefaultStyleV1(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv3()
	local styleAPI = mapAPI:getStyleAPI()

	local ignoreForestFeatures = false
	if ignoreForestFeatures then
    	styleAPI:removeLayerById("forest")
    end

    local pyramidLayer = mapAPI:getStyleAPI():newPyramidLayer("pyramid-forest")
    pyramidLayer:setPyramidFileName("forest.pyramid.zip")
    pyramidLayer:addFill(0.0, 189, 197, 163, 255.0)
    if not ignoreForestFeatures then
        pyramidLayer:addFill(14.999, 189, 197, 163, 255.0)
        pyramidLayer:addFill(15.0, 0.0, 0.0, 0.0, 0.0)
    end

    local index1 = styleAPI:indexOfLayer("pyramid-forest")
    local index2 = styleAPI:indexOfLayer("forest")
    styleAPI:moveLayer(index1, index2 + 1)
end

function MapUtils.overlayPaper(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	local styleAPI = mapAPI:getStyleAPI()
	local layer = styleAPI:newTextureLayer("paper")
	layer:setMinZoom(0.00)
	local x1 = mapAPI:getMinXInSquares()
	local y1 = mapAPI:getMinYInSquares()
	local x2 = mapAPI:getMaxXInSquares() + 1
	local y2 = mapAPI:getMaxYInSquares() + 1
	layer:setBoundsInSquares(x1, y1, x2, y2)
	layer:setTile(true)
	layer:setUseWorldBounds(true)
	layer:addFill(14.00, 128, 128, 128, 0)
	layer:addFill(15.00, 128, 128, 128, 32)
	layer:addFill(15.00, 255, 255, 255, 32)
	layer:addTexture(0.00, "media/white.png")
	layer:addTexture(15.00, "media/white.png")
	layer:addTexture(15.00, "media/textures/worldMap/Paper.png")
end

function MapUtils.revealKnownArea(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	local x1 = mapAPI:getMinXInSquares()
	local y1 = mapAPI:getMinYInSquares()
	local x2 = mapAPI:getMaxXInSquares()
	local y2 = mapAPI:getMaxYInSquares()
	WorldMapVisited.getInstance():setKnownInSquares(x1, y1, x2, y2)
end

function MapUtils.renderDarkModeOverlay(mapUI)
	local alpha = getCore():getOptionWorldMapBrightness()
	alpha = 1 - PZMath.lerp(0.2, 1.0, alpha)
	mapUI:drawTextureScaled(Texture.getWhite(), 0, 0, mapUI.width, mapUI.height, alpha, 0.0, 0.0, 0.0)
end

-----

local function replaceWaterStyle(mapUI)
	if not WATER_TEXTURE then return end
	local mapAPI = mapUI.javaObject:getAPIv1()
	local styleAPI = mapAPI:getStyleAPI()
	local layer = styleAPI:getLayerByName("water")
	if not layer then return end
	layer:setMinZoom(MINZ)
	layer:setFilter("water", "river")
	layer:removeAllFill()
	layer:removeAllTexture()
	layer:addFill(MINZ, 59, 141, 149, 255)
	layer:addFill(MAXZ, 59, 141, 149, 255)
end

local function overlayPNG(mapUI, x, y, scale, layerName, tex, alpha)
	local texture = getTexture(tex)
	if not texture then return end
	local mapAPI = mapUI.javaObject:getAPIv1()
	local styleAPI = mapAPI:getStyleAPI()
	local layer = styleAPI:newTextureLayer(layerName)
	layer:setMinZoom(MINZ)
	layer:addFill(MINZ, 255, 255, 255, (alpha or 1.0) * 255)
	layer:addTexture(MINZ, tex)
	layer:setBoundsInSquares(x, y, x + texture:getWidth() * scale, y + texture:getHeight() * scale)
end

local function overlayPNG2(mapUI, x, y, scaleX, scaleY, tex)
	local mapAPI = mapUI.javaObject:getAPIv1()
	local styleAPI = mapAPI:getStyleAPI()
	local layer = styleAPI:newTextureLayer("lootMapPNG")
	layer:setMinZoom(MINZ)
	local texture = getTexture(tex)
	layer:addFill(MINZ, 255, 255, 255, 128)
	layer:addTexture(MINZ, tex)
	layer:setBoundsInSquares(x, y, x + texture:getWidth() * scaleX, y + texture:getHeight() * scaleY)
end

local function worldMapImage(fileName)
	if getCore():getOptionColorblindPatterns() then
		return "media/textures/worldMap/Colorblind Patterns/" .. fileName
	end
	return "media/textures/worldMap/" .. fileName
end

-- -- -- -- --

LootMaps = {}
LootMaps.Init = {}

function LootMaps.callLua(functionName, mapUI, arg1, arg2, arg3, arg4)
	local t = LootMaps[functionName]
	if not t then
		print("LootMaps.callLua(): no such function LootMaps." .. functionName)
		return
	end
	local mapItem = mapUI.mapItem or mapUI.mapObj
	local f = t[mapItem:getStashMap()] or t[mapItem:getMapID()]
	if not f then
		print("LootMaps.callLua(): no such function LootMaps." .. functionName .. "." .. mapItem:getMapID())
		return
	end
	return f(mapUI, arg1, arg2, arg3, arg4)
end

-- Init functions for each MapItem.getMapID().

LootMaps.DEFAULT_MAP_DIRECTORY = 'media/maps/Muldraugh, KY'

LootMaps.Init.MarchRidgeMap = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()

	-- Add XML data from base-game map directories.
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)

	-- Specify the appearance of the map.
	MapUtils.initDefaultStyleV3(mapUI)

	-- Use solid color for water instead of a texture.
	replaceWaterStyle(mapUI)

	-- Show only this area from the full map.
	mapAPI:setBoundsInSquares(9700, 12470, 10579, 13199)

	-- Add the town-name PNG.
	overlayPNG(mapUI, 9769, 12492, 0.666, "badge", "media/textures/worldMap/MarchRidgeBadge.png")

	-- Add the legend PNG.
	overlayPNG(mapUI, 10103, 12846, 0.666, "legend", worldMapImage("Legend.png"))

	-- Draw a paper-like texture overtop the map.
	MapUtils.overlayPaper(mapUI)

	-- The original loot map texture, used to position things correctly.
--	overlayPNG(mapUI, 32*300+55, 41*300+155, 0.666, "lootMapPNG", "media/ui/LootableMaps/marchridgemap.png", 0.5)
end

local LVx = 11700
local LVy = 900
local LVw = 300 * 4
local LVh = 300 * 4
local LVdx = 300 * 3
local LVdy = 300 * 3
local LVbadgeHgt = 150
local function lvGridX1(col)
	return LVx + LVdx * col
end
local function lvGridY1(row)
	return LVy + LVdy * row - LVbadgeHgt
end
local function lvGridX2(col)
	return lvGridX1(col) + LVw - 1
end
local function lvGridY2(row)
	return lvGridY1(row) + LVh - 1 + LVbadgeHgt
end

LootMaps.Init.LouisvilleMap1 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(lvGridX1(0), lvGridY1(0), lvGridX2(0), lvGridY2(0))
--	overlayPNG(mapUI, 11093, 9222, 0.666, "badge", "media/textures/worldMap/MuldraughBadge.png")
	overlayPNG(mapUI, lvGridX1(0), lvGridY1(0), 1.0, "legend", worldMapImage("LouisvilleBadge.png"))
	MapUtils.overlayPaper(mapUI)
end

LootMaps.Init.LouisvilleMap2 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(lvGridX1(1), lvGridY1(0), lvGridX2(1), lvGridY2(0))
--	overlayPNG(mapUI, 11093, 9222, 0.666, "badge", "media/textures/worldMap/MuldraughBadge.png")
	overlayPNG(mapUI, lvGridX1(1), lvGridY1(0), 1.0, "legend", worldMapImage("LouisvilleBadge.png"))
	MapUtils.overlayPaper(mapUI)
end

LootMaps.Init.LouisvilleMap3 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(lvGridX1(2), lvGridY1(0), lvGridX2(2), lvGridY2(0))
--	overlayPNG(mapUI, 11093, 9222, 0.666, "badge", "media/textures/worldMap/MuldraughBadge.png")
	overlayPNG(mapUI, lvGridX1(2), lvGridY1(0), 1.0, "legend", worldMapImage("LouisvilleBadge.png"))
	MapUtils.overlayPaper(mapUI)
end

LootMaps.Init.LouisvilleMap4 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(lvGridX1(0), lvGridY1(1), lvGridX2(0), lvGridY2(1))
--	overlayPNG(mapUI, 11093, 9222, 0.666, "badge", "media/textures/worldMap/MuldraughBadge.png")
	overlayPNG(mapUI, lvGridX1(0), lvGridY1(1), 1.0, "legend", worldMapImage("LouisvilleBadge.png"))
	MapUtils.overlayPaper(mapUI)
end

LootMaps.Init.LouisvilleMap5 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(lvGridX1(1), lvGridY1(1), lvGridX2(1), lvGridY2(1))
--	overlayPNG(mapUI, 11093, 9222, 0.666, "badge", "media/textures/worldMap/MuldraughBadge.png")
	overlayPNG(mapUI, lvGridX1(1), lvGridY1(1), 1.0, "legend", worldMapImage("LouisvilleBadge.png"))
	MapUtils.overlayPaper(mapUI)
end

LootMaps.Init.LouisvilleMap6 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(lvGridX1(2), lvGridY1(1), lvGridX2(2), lvGridY2(1))
--	overlayPNG(mapUI, 11093, 9222, 0.666, "badge", "media/textures/worldMap/MuldraughBadge.png")
	overlayPNG(mapUI, lvGridX1(2), lvGridY1(1), 1.0, "legend", worldMapImage("LouisvilleBadge.png"))
	MapUtils.overlayPaper(mapUI)
end

LootMaps.Init.LouisvilleMap7 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(lvGridX1(0), lvGridY1(2), lvGridX2(0), lvGridY2(2))
--	overlayPNG(mapUI, 11093, 9222, 0.666, "badge", "media/textures/worldMap/MuldraughBadge.png")
	overlayPNG(mapUI, lvGridX1(0), lvGridY1(2), 1.0, "legend", worldMapImage("LouisvilleBadge.png"))
	MapUtils.overlayPaper(mapUI)
end

LootMaps.Init.LouisvilleMap8 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(lvGridX1(1), lvGridY1(2), lvGridX2(1), lvGridY2(2))
--	overlayPNG(mapUI, 11093, 9222, 0.666, "badge", "media/textures/worldMap/MuldraughBadge.png")
	overlayPNG(mapUI, lvGridX1(1), lvGridY1(2), 1.0, "legend", worldMapImage("LouisvilleBadge.png"))
	MapUtils.overlayPaper(mapUI)
end

LootMaps.Init.LouisvilleMap9 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(lvGridX1(2), lvGridY1(2), lvGridX2(2), lvGridY2(2))
--	overlayPNG(mapUI, 11093, 9222, 0.666, "badge", "media/textures/worldMap/MuldraughBadge.png")
	overlayPNG(mapUI, lvGridX1(2), lvGridY1(2), 1.0, "legend", worldMapImage("LouisvilleBadge.png"))
	MapUtils.overlayPaper(mapUI)
end

LootMaps.Init.MuldraughMap = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(10540, 9240, 11217, 10696)
	overlayPNG(mapUI, 11093, 9222, 0.666, "badge", "media/textures/worldMap/MuldraughBadge.png")
	overlayPNG(mapUI, 10807, 10342, 0.666, "legend", worldMapImage("Legend.png"))
	MapUtils.overlayPaper(mapUI)
--	overlayPNG(mapUI, 10524, 9222, 0.666, "lootMapPNG", "media/ui/LootableMaps/muldraughmap.png", 0.5)
end

LootMaps.Init.RosewoodMap = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(7900, 11140, 8604, 12139)
	overlayPNG(mapUI, 7958, 11962, 0.666, "badge", "media/textures/worldMap/RosewoodBadge.png")
	overlayPNG(mapUI, 8213, 11161, 0.666, "legend", worldMapImage("Legend.png"))
	MapUtils.overlayPaper(mapUI)
--	overlayPNG(mapUI, 26*300+100, 37*300+30, 0.666, "lootMapPNG", "media/ui/LootableMaps/rosewoodmap.png", 0.5)
end

LootMaps.Init.RiversideMap = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(6000, 5035, 6899, 5669)
	overlayPNG(mapUI, 6155, 5053, 0.385, "badge", "media/textures/worldMap/RiversideBadge.png")
	overlayPNG(mapUI, 6500, 5062, 0.385, "legend", worldMapImage("Legend2.png"))
	MapUtils.overlayPaper(mapUI)
	-- This is the only map with different x/y scales
--	overlayPNG2(mapUI, 20*300-2, 17*300-69, 0.385, 0.455, "media/ui/LootableMaps/riversidemap.png", 0.5)
end

LootMaps.Init.WestpointMap = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(10820, 6500, 12389, 7469)
	overlayPNG(mapUI, 10868, 7314, 0.666, "badge", "media/textures/worldMap/WestPointBadge.png")
	overlayPNG(mapUI, 10956, 7006, 0.666, "legend", worldMapImage("Legend.png"))
	MapUtils.overlayPaper(mapUI)
--	overlayPNG(mapUI, 36*300, 21*300+190, 0.666, "lootMapPNG", "media/ui/LootableMaps/westpointmap.png", 0.5)
end

-- -- -- -- --

LootMaps.Init.MulStashMap1 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(10540, 9550, 10789, 9789)
end
LootMaps.Init.MulStashMap2 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(10760, 10150, 10949, 10259)
end
LootMaps.Init.MulStashMap3 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(10660, 10030, 11009, 10229)

end
LootMaps.Init.MulStashMap4 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(10650, 9930, 10909, 10109)
end
LootMaps.Init.MulStashMap5 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(10810, 10020, 10929, 10129)
end
LootMaps.Init.MulStashMap6 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(10650, 9500, 11029, 9709)
end
LootMaps.Init.MulStashMap7 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(10700, 9780, 10939, 9909)
end
LootMaps.Init.MulStashMap8 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(10660, 9850, 10999, 9969)
end
LootMaps.Init.MulStashMap9 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(10590, 9860, 10739, 9999)
end
LootMaps.Init.MulStashMap10 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(10710, 9850, 10889, 10049)	
end
LootMaps.Init.MulStashMap11 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(10590, 9630, 10789, 9859)	
end
LootMaps.Init.MulStashMap12 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(10590, 10400, 10819, 10629)
end
LootMaps.Init.MulStashMap13 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(10650, 10270, 11019, 10509)
end
LootMaps.Init.MulStashMap14 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(10570, 9550, 10849, 9719)
end
LootMaps.Init.MulStashMap15 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(10680, 9860, 10939, 9989)
end
LootMaps.Init.MulStashMap16 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(10570, 9620, 10849, 9769)
end
LootMaps.Init.MulStashMap17 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(10590, 9600, 10909, 9729)
end
LootMaps.Init.MulStashMap18 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(10900, 9710, 11149, 9829)
end
LootMaps.Init.MulStashMap19 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(10000, 8216, 10183, 8375)
end

LootMaps.Init.LouisvilleStashMap1 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(12760, 3430, 12979, 3649)
end
LootMaps.Init.LouisvilleStashMap2 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(12530, 3200, 12749, 3389)
end
LootMaps.Init.LouisvilleStashMap3 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(12930, 3130, 13239, 3319)

end
LootMaps.Init.LouisvilleStashMap4 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(13910, 3080, 14239, 3299)
end
LootMaps.Init.LouisvilleStashMap5 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(12140, 2380, 12549, 2559)
end
LootMaps.Init.LouisvilleStashMap6 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(13690, 2310, 13879, 2449)
end
LootMaps.Init.LouisvilleStashMap7 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(14000, 2570, 14279, 2719)
end
LootMaps.Init.LouisvilleStashMap8 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(13160, 2090, 13519, 2249)
end
LootMaps.Init.LouisvilleStashMap9 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(13010, 2810, 13279, 2929)
end
LootMaps.Init.LouisvilleStashMap10 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(12180, 2010, 12449, 2199)
end
LootMaps.Init.LouisvilleStashMap11 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(12670, 1890, 12999, 2129)
end
LootMaps.Init.LouisvilleStashMap12 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(13660, 1850, 13899, 2079)
end
LootMaps.Init.LouisvilleStashMap13 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(13200, 1700, 13489, 1919)
end
LootMaps.Init.LouisvilleStashMap14 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(12120, 1730, 12489, 1959)
end
LootMaps.Init.LouisvilleStashMap15 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(12340, 1120, 12809, 1479)
end
LootMaps.Init.LouisvilleStashMap16 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(13300, 1930, 13709, 2139)
end
LootMaps.Init.MarchRidgeStashMap1 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(9870, 12610, 10089, 12699)
end
LootMaps.Init.MarchRidgeStashMap2 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(9910, 12660, 10239, 12839)
end
LootMaps.Init.MarchRidgeStashMap3 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(9910, 12660, 10239, 12839)
end
LootMaps.Init.MarchRidgeStashMap4 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(9850, 12700, 10299, 12829)
end
LootMaps.Init.MarchRidgeStashMap5 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(9960, 12730, 10269, 12859)
end
LootMaps.Init.MarchRidgeStashMap6 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(9900, 12780, 10209, 12929)
end
LootMaps.Init.MarchRidgeStashMap7 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(9780, 12730, 10089, 12849)
end
LootMaps.Init.MarchRidgeStashMap8 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(9800, 13090, 9989, 13179)
end
LootMaps.Init.MarchRidgeStashMap9 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(10040, 12600, 10329, 12739)
end
LootMaps.Init.MarchRidgeStashMap10 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(10240, 12720, 10409, 12829)
end
LootMaps.Init.RiversideStashMap1 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(6600, 5400, 6859, 5549)
end
LootMaps.Init.RiversideStashMap2 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(6360, 5220, 6569, 5319)
end
LootMaps.Init.RiversideStashMap3 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(6160, 5320, 6299, 5409)
end
LootMaps.Init.RiversideStashMap4 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(6520, 5270, 6879, 5409)
end
LootMaps.Init.RiversideStashMap5 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(6290, 5230, 6589, 5379)
end
LootMaps.Init.RiversideStashMap6 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(6110, 5450, 6389, 5569)
end
LootMaps.Init.RiversideStashMap7 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(6420, 5280, 6709, 5409)
end
LootMaps.Init.RiversideStashMap8 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(6480, 5500, 6889, 5629)
end
LootMaps.Init.RiversideStashMap9 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(6030, 5280, 6289, 5419)
end
LootMaps.Init.RiversideStashMap10 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(6450, 5240, 6709, 5409)
end
LootMaps.Init.RosewoodStashMap1 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(8190, 11530, 8299, 11609)
end
LootMaps.Init.RosewoodStashMap2 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(8150, 11530, 8439, 11659)
end
LootMaps.Init.RosewoodStashMap3 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(8220, 11540, 8609, 11649)
end
LootMaps.Init.RosewoodStashMap4 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(7910, 11360, 8209, 11499)
end
LootMaps.Init.RosewoodStashMap5 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(7930, 11290, 8189, 11409)
end
LootMaps.Init.WpStashMap1 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(10920, 6700, 11189, 6799)
end
LootMaps.Init.WpStashMap2 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(11010, 6710, 11389, 6809)
end
LootMaps.Init.WpStashMap3 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(11260, 6690, 11399, 6809)
end
LootMaps.Init.WpStashMap4 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(11140, 6700, 11419, 6819)
end
LootMaps.Init.WpStashMap5 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(11400, 6710, 11549, 6829)
end
LootMaps.Init.WpStashMap6 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(11450, 6690, 11669, 6839)
end
LootMaps.Init.WpStashMap7 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(11550, 6740, 11699, 6839)
end
LootMaps.Init.WpStashMap8 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(11490, 6750, 11779, 6839)
end
LootMaps.Init.WpStashMap9 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(11640, 6770, 11849, 6869)
end
LootMaps.Init.WpStashMap10 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(11610, 6670, 11839, 6819)
end
LootMaps.Init.WpStashMap11 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(11850, 6740, 12199, 6929)
end
LootMaps.Init.WpStashMap12 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(11900, 6750, 12199, 6979)
end
LootMaps.Init.WpStashMap13 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(10800, 6650, 10989, 6839)
end
LootMaps.Init.WpStashMap14 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(11250, 6540, 11579, 6709)
end
LootMaps.Init.WpStashMap15 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(11850, 7170, 12319, 7429)
end
LootMaps.Init.WpStashMap16 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(11020, 6820, 11389, 7009)
end

-- Brandenburg
LootMaps.Init.BBurgStashMap1 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(2060, 6000, 2279, 6069)
end
LootMaps.Init.BBurgStashMap2 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(1680, 5880, 1929, 6009)
end
LootMaps.Init.BBurgStashMap3 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(2100, 6330, 2249, 6449)
end
LootMaps.Init.BBurgStashMap4 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(2620, 6210, 2879, 6469)
end
LootMaps.Init.BBurgStashMap5 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(1840, 6480, 2099, 6619)
end
LootMaps.Init.BBurgStashMap6 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(1450, 6000, 1759, 6189)
end
LootMaps.Init.BBurgStashMap7 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(2100, 5730, 2289, 5889)
end
LootMaps.Init.BBurgStashMap8 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(2570, 5790, 2999, 6169)
end

--Ekron
LootMaps.Init.EkronStashMap1 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(410, 9300, 629, 9499)
end
LootMaps.Init.EkronStashMap2 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(300, 9600, 449, 9689)
end
LootMaps.Init.EkronStashMap3 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(760, 9480, 869, 9689)
end
LootMaps.Init.EkronStashMap4 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(380, 9810, 459, 9899)
end
LootMaps.Init.EkronStashMap5 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(600, 9800, 869, 9899)
end
LootMaps.Init.EkronStashMap6 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(230, 9670, 549, 9809)
end
LootMaps.Init.EkronStashMap7 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(8, 9384, 223, 9519)
end
LootMaps.Init.EkronStashMap8 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(1744, 8328, 2239, 8719)
end

-- Irvington
LootMaps.Init.IrvingtonStashMap1 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(720, 12470, 1589, 13549)
end
LootMaps.Init.IrvingtonStashMap2 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(2810, 14520, 2989, 14709)
end
LootMaps.Init.IrvingtonStashMap3 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(2080, 14250, 2329, 14419)
end
LootMaps.Init.IrvingtonStashMap4 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(1620, 14610, 1889, 14829)
end
LootMaps.Init.IrvingtonStashMap5 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(2170, 13950, 2409, 14109)
end
LootMaps.Init.IrvingtonStashMap6 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(2590, 13930, 2819, 14059)
end
LootMaps.Init.IrvingtonStashMap7 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(2470, 14330, 2629, 14449)
end
LootMaps.Init.IrvingtonStashMap8 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(2400, 14430, 2599, 14589)
end
LootMaps.Init.IrvingtonStashMap9 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(3864, 13544, 4087, 13743)
end
LootMaps.Init.IrvingtonStashMap10 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(1232, 13424, 1415, 13823)

end
-- Non-town maps
LootMaps.Init.WorldStashMap1 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(7210, 8330, 7379, 8479)
end
LootMaps.Init.WorldStashMap2 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(6890, 8030, 7119, 8179)
end
LootMaps.Init.WorldStashMap3 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(5390, 9630, 5579, 9759)
end
LootMaps.Init.WorldStashMap4 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(4630, 7860, 4779, 7999)
end
LootMaps.Init.WorldStashMap5 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(3890, 6200, 4149, 6349)
end
LootMaps.Init.WorldStashMap6 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(10060, 6570, 10329, 6779)
end
LootMaps.Init.WorldStashMap7 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(11590, 8750, 11779, 8909)
end
LootMaps.Init.WorldStashMap8 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(11410, 8870, 11539, 8999)
end
LootMaps.Init.WorldStashMap9 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(11490, 9620, 11939, 10259)
end
LootMaps.Init.WorldStashMap10 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(11550, 8230, 11739, 8419)
end
LootMaps.Init.WorldStashMap11 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(10184, 8696, 10447, 8879)
end
LootMaps.Init.WorldStashMap12 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(13700, 6580, 13949, 6819)
end
LootMaps.Init.WorldStashMap13 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(13930, 5460, 14119, 5579)
end
LootMaps.Init.WorldStashMap14 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(14290, 5350, 14419, 5539)
end
LootMaps.Init.WorldStashMap15 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(14440, 3980, 14859, 4249)
end
LootMaps.Init.WorldStashMap16 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(12420, 4290, 12609, 4569)
end
LootMaps.Init.WorldStashMap17 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(5440, 12370, 5919, 12609)
end
LootMaps.Init.WorldStashMap18 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(13470, 3990, 13799, 4209)
	
end
LootMaps.Init.WorldStashMap19 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(9990, 7320, 10429, 7529)
end
LootMaps.Init.WorldStashMap20 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(14370, 4920, 14619, 5069)
end
LootMaps.Init.WorldStashMap21 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(3528, 10864, 3751, 10959)
end
LootMaps.Init.WorldStashMap22 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(1168, 11808, 1295, 11959)
end
LootMaps.Init.WorldStashMap23 = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(8672, 14040, 8775, 14159)

end
-- -- -- -- --

PrintMediaMaps = {}
PrintMediaMaps.Init = {}

function PrintMediaMaps.callLua(functionName, mapUI, arg1, arg2, arg3, arg4)
	local t = PrintMediaMaps[functionName]
	if not t then
		print("PrintMediaMaps.callLua(): no such function PrintMediaMaps." .. functionName)
		return
	end
	local f = t[mapUI.mapID]
	if f then
		return f(mapUI, arg1, arg2, arg3, arg4)
	end
	if functionName == "Init" and tonumber(arg1) ~= nil then
		local details = PrintMediaDefinitions.MiscDetails[mapUI.mapID]
		if details and details.locations and (#details.locations >= 1) and (#details.locations >= arg1) then
			local location = details.locations[arg1]
			if location.x1 and location.y1 and location.x2 and location.y2 then
				local mapAPI = mapUI.javaObject:getAPIv1()
				MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
				MapUtils.initDefaultStyleV3(mapUI)
				replaceWaterStyle(mapUI)
				mapAPI:setBoundsInSquares(location.x1, location.y1, location.x2, location.y2)
				mapUI.centerX = location.x
				mapUI.centerY = location.y
				return
			end
		end
	end
	print("PrintMediaMaps.callLua(): no such function PrintMediaMaps." .. functionName .. "." .. tostring(mapUI.mapID))
end

--[[
PrintMediaMaps.Init.WestMapleCountryClub = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, LootMaps.DEFAULT_MAP_DIRECTORY)
	MapUtils.initDefaultStyleV3(mapUI)
	replaceWaterStyle(mapUI)
	mapAPI:setBoundsInSquares(11020, 6820, 11389, 7009)
end
--]]
