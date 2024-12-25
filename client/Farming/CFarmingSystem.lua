--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "Map/CGlobalObjectSystem"

CFarmingSystem = CGlobalObjectSystem:derive("CFarmingSystem")

function CFarmingSystem:new()
	local o = CGlobalObjectSystem.new(self, "farming")
	-- no idea what the point of this error message is but it disrupts the testers
-- 	if not o.hoursElapsed then error "hoursElapsed wasn't sent from the server?" end

	return o
end

function CFarmingSystem:isValidIsoObject(isoObject)
	if not isoObject or not isoObject:hasModData() then return false end
	local modData = isoObject:getModData()
	if modData.state and modData.nbOfGrow and modData.health then return true end
	return false
end

function CFarmingSystem:newLuaObject(globalObject)
	return CPlantGlobalObject:new(self, globalObject)
end

function CFarmingSystem:OnServerCommand(command, args)
	if command == "hoursElapsed" then
		self.hoursElapsed = args.hoursElapsed
	else
		CGlobalObjectSystem.OnServerCommand(self, command, args)
	end
end

-- get the farming xp of the player
function CFarmingSystem:getXp(character)
	if not character then character = getPlayer() end
	return character:getPerkLevel(Perks.Farming)
end

-- make the player more tired etc. when plowing land
function CFarmingSystem:changePlayer(player)
-- 	player:getStats():setFatigue(player:getStats():getFatigue() + 0.006)
	player:getStats():setEndurance(player:getStats():getEndurance() - 0.0013)
end

CGlobalObjectSystem.RegisterSystemClass(CFarmingSystem)

local function DoSpecialTooltip1(tooltip, square)
	if ISFarmingCursorMouse.IsVisible() then return end
	
	local playerObj = getSpecificPlayer(0)
	if not playerObj then return end
	if playerObj:DistTo(square:getX(), square:getY()) > 6 then return end
	if CFarmingSystem.instance:getXp(playerObj) < 3 and not ISFarmingMenu.cheat then return end
-- 	if not playerObj or CFarmingSystem.instance:getXp(playerObj) < 4 then return end

	local plant = CFarmingSystem.instance:getLuaObjectOnSquare(square)
	if not plant or plant.typeOfSeed == "none" then return end
	if not plant:isAlive() and not ISFarmingMenu.cheat then return end

	local farmingLevel = CFarmingSystem.instance:getXp(playerObj)
	local water_rgb = ISFarmingInfo.getWaterLvlColor(plant, farmingLevel)

	tooltip:DrawTextureScaled(tooltip:getTexture(), 0, 0, tooltip:getWidth(), tooltip:getHeight(), 0.75)

	local title_rgb = ISFarmingInfo.getTitleColor(plant)
	tooltip:DrawTextCentre(tooltip:getFont(), farming_vegetableconf.getObjectName(plant), tooltip:getWidth() / 2, 5, title_rgb["r"], title_rgb["g"], title_rgb["b"], 1)
	tooltip:adjustWidth(5, farming_vegetableconf.getObjectName(plant))
-- 	tooltip:adjustWidth(5, plant:getObject():getObjectName())

	local layout = tooltip:beginLayout()



	local layout = tooltip:beginLayout()
	if ISFarmingMenu.cheat then
		local layoutItem = layout:addItem()
		layoutItem:setLabel("state: " .. tostring(plant.state), 1, 1, 1, 1)
-- 		layoutItem = layout:addItem()
--         layoutItem:setLabel("isAlive: " .. tostring(SPlantGlobalObject.isAlive(plant)), 1, 1, 1, 1)
		layoutItem = layout:addItem()
        layoutItem:setLabel("nbOfGrow: " .. tostring(plant.nbOfGrow), 1, 1, 1, 1)
        if plant.hasVegetable then
            layoutItem = layout:addItem()
            layoutItem:setLabel("hasVegetable: " .. tostring(plant.hasVegetable), 1, 1, 1, 1)
        end
        if plant.hasSeed then
            layoutItem = layout:addItem()
            layoutItem:setLabel("hasSeed: " .. tostring(plant.hasSeed), 1, 1, 1, 1)
        end
        if plant.cursed then
            layoutItem = layout:addItem()
            layoutItem:setLabel("cursed: " .. tostring(plant.cursed), 1, 1, 1, 1)
        end
        if plant.bonusYield then
            layoutItem = layout:addItem()
            layoutItem:setLabel("bonusYield: " .. tostring(plant.bonusYield), 1, 1, 1, 1)
        end
        if plant.hasWeeds then
            layoutItem = layout:addItem()
            layoutItem:setLabel("hasWeeds: " .. tostring(plant.hasWeeds), 1, 1, 1, 1)
        end
        if plant.fertilizer > 0 then
            layoutItem = layout:addItem()
            layoutItem:setLabel("fertilizer: " .. tostring(plant.fertilizer), 1, 1, 1, 1)
        end
        if plant.compost then
            layoutItem = layout:addItem()
            layoutItem:setLabel("compost: " .. tostring(plant.compost), 1, 1, 1, 1)
        end
	end
    if plant:isAlive() then
        local layoutItem = layout:addItem()
        layoutItem:setLabel(getText("Farming_Water_levels")..' :', 1, 1, 1, 1)
        layoutItem:setValue(ISFarmingInfo.getWaterLvl(plant, farmingLevel), water_rgb["r"], water_rgb["g"], water_rgb["b"], 1)
        if farmingLevel >= 6 or ISFarmingMenu.cheat then
            layoutItem = layout:addItem()
            layoutItem:setLabel(getText("Farming_Next_growing_phase")..' :', 1, 1, 1, 1)
            local info = {}
            info.plant = plant
            info.character = playerObj
            layoutItem:setValue(ISFarmingInfo.getNextGrowingPhase(info), getCore():getBadHighlitedColor():getR(), getCore():getBadHighlitedColor():getG(), getCore():getBadHighlitedColor():getB(), 1)
        end
        if ISFarmingMenu.cheat then
            local layoutItem = layout:addItem()
            layoutItem:setLabel("hoursElapsed"..' :', 1, 0.8, 0.8, 1)
            layoutItem:setValue(tostring(CFarmingSystem.instance.hoursElapsed), 1, 0.8, 0.8, 1)
        end

	    if farmingLevel >= 3 or ISFarmingMenu.cheat then
            if plant.aphidLvl > 0 then
                layoutItem = layout:addItem()
                layoutItem:setLabel(getText("Farming_Aphid")..' :', 1, 1, 1, 1)
                layoutItem:setValue(ISFarmingInfo.getDiseaseString(plant.aphidLvl, farmingLevel), getCore():getBadHighlitedColor():getR(), getCore():getBadHighlitedColor():getG(), getCore():getBadHighlitedColor():getB(), 1)
            end
            if plant.mildewLvl > 0 then
                layoutItem = layout:addItem()
                layoutItem:setLabel(getText("Farming_Mildew")..' :', 1, 1, 1, 1)
                layoutItem:setValue(ISFarmingInfo.getDiseaseString(plant.mildewLvl, farmingLevel), getCore():getBadHighlitedColor():getR(), getCore():getBadHighlitedColor():getG(), getCore():getBadHighlitedColor():getB(), 1)
            end
            if plant.fliesLvl > 0 then
                layoutItem = layout:addItem()
                layoutItem:setLabel(getText("Farming_Pest_Flies")..' :', 1, 1, 1, 1)
                layoutItem:setValue(ISFarmingInfo.getDiseaseString(plant.fliesLvl, farmingLevel), getCore():getBadHighlitedColor():getR(), getCore():getBadHighlitedColor():getG(), getCore():getBadHighlitedColor():getB(), 1)
            end
            if plant.slugsLvl > 0 then
                layoutItem = layout:addItem()
                layoutItem:setLabel(getText("Farming_Slugs")..' :', 1, 1, 1, 1)
                layoutItem:setValue(ISFarmingInfo.getDiseaseString(plant.slugsLvl, farmingLevel), getCore():getBadHighlitedColor():getR(), getCore():getBadHighlitedColor():getG(), getCore():getBadHighlitedColor():getB(), 1)
            end
	    end
--         local text
--         local lastWateredHour = ISFarmingInfo.getLastWatedHour(plant)
--         if math.floor(lastWateredHour/24) == 1 then
--             text =  math.floor((lastWateredHour/24)) .. " " .. getText("Farming_Day");
--         elseif  math.floor(lastWateredHour/24) > 1 then
--             text =  math.floor((lastWateredHour/24)) .. " " .. getText("Farming_Days");
--         elseif lastWateredHour == 1 then
--             text = lastWateredHour .. " " .. getText("Farming_Hour");
--         else
--             text = lastWateredHour .. " " .. getText("Farming_Hours");
--         end
--         lastWaterdHour = lastWateredHour .. " " .. getText("Farming_Hours")
--         local nowateredsince_rgb = ISFarmingInfo.getNoWateredSinceColor(plant, lastWateredHour, farmingLevel)
--         layoutItem = layout:addItem()
--         layoutItem:setLabel(getText("Farming_Last_time_watered")..':', 1, 1, 1, 1)
--         layoutItem:setValue(text, nowateredsince_rgb["r"], nowateredsince_rgb["g"], nowateredsince_rgb["b"], 1)
    end

        local y = layout:render(5, 5 + getTextManager():getFontHeight(tooltip:getFont()), tooltip)
        tooltip:setHeight(y + 5)
        tooltip:endLayout(layout)
end

local function DoSpecialTooltip(tooltip, square)
	tooltip:setWidth(100)
	tooltip:setMeasureOnly(true)
	DoSpecialTooltip1(tooltip, square)
	tooltip:setMeasureOnly(false)
	DoSpecialTooltip1(tooltip, square)
end

Events.DoSpecialTooltip.Add(DoSpecialTooltip)

