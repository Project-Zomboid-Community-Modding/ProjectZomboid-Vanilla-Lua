--***********************************************************
--**                    ROBERT JOHNSON                     **
--**    The (not so) famouns farming info panel            **
--***********************************************************

require "ISUI/ISPanelJoypad"

ISFarmingInfo = ISPanelJoypad:derive("ISFarmingInfo");

local FONT_HGT_NORMAL = getTextManager():getFontHeight(UIFont.Normal)

local water_rgb = {["r"]=255.0,["g"]=255.0,["b"]=255.0};
local waterbar_rgb = {["r"]=0.15,["g"]=0.3,["b"]=0.63};
local fertilizer_rgb = {["r"]=0.0,["g"]=0.0,["b"]=0.0};
local compost_rgb = {["r"]=0.0,["g"]=0.0,["b"]=0.0};
local health_rgb = {["r"]=0.0,["g"]=0.0,["b"]=0.0};
local nowateredsince_rgb = {["r"]=255.0,["g"]=255.0,["b"]=255.0};
local disease_rgb = {["0r"]=255.0,["0g"]=255.0,["0b"]=255.0};
local title_rgb = {["r"]=1.0,["g"]=1.0,["b"]=1.0};

--************************************************************************--
--** ISPanel:initialise
--**
--************************************************************************--

function ISFarmingInfo:initialise()
	ISPanelJoypad.initialise(self);
end

function ISFarmingInfo:setPlant(plant)
	self.plant = plant;
	self.vegetable = getTexture(farming_vegetableconf.props[plant.typeOfSeed].icon);
-- 	self.vegetable = getTexture(farming_vegetableconf.icons[plant.typeOfSeed]);
end

function ISFarmingInfo:setEnabled(val)
	self.isEnabled = val
end


--************************************************************************--
--** ISPanel:render
--**
--************************************************************************--
function ISFarmingInfo:prerender()
	if self:isPlantValid() then
		local square = self.plant:getSquare()
		-- Hide the window when the plant is out-of-bounds
--		if not square then self:getParent():setVisible(false); return end
		if isClient() then
			-- Hack: because the client does not have an up-to-date list of plants
			local object = self.plant:getObject()
			if object then
				self.plant:fromModData(object:getModData())
			end
		end
	end
end


function ISFarmingInfo:render()
	if not self:isPlantValid() then return end
	local farmingLevel = CFarmingSystem.instance:getXp(self.character)
	ISFarmingInfo.getFertilizerColor(self);
	ISFarmingInfo.getWaterLvlColor(self.plant, farmingLevel);
	local lastWatedHour = ISFarmingInfo.getLastWatedHour(self.plant);
	ISFarmingInfo.getTitleColor(self.plant);
	ISFarmingInfo.getHealthColor(self, farmingLevel);
	ISFarmingInfo.getNoWateredSinceColor(self, lastWatedHour, farmingLevel);
-- 	local disease = ISFarmingInfo.getDiseaseName(self);
	ISFarmingInfo.getWaterLvlBarColor(self, farmingLevel);
	local top = 69
	local y = top;
	-- icon of the plant
	self:drawTextureScaled(self.vegetable, 20,20,25,25,1,1,1,1);
	-- title of the plant
	local titleWidth = 0
	if self.plant:getObject() then
-- 		local displayName = ISFarmingMenu.getPlantName(self.plant)
		local displayName = farming_vegetableconf.getObjectName(self.plant)
		local textw = getTextManager():MeasureStringX(UIFont.Normal, displayName);
		if textw > 190 then
			-- Maybe will be problems when translated text will be used
			local words = string.split(displayName, " ")
			local newName = words[1]
			for i = 2, #words - 1 do
				newName = newName .. " " .. words[i]
			end
			displayName = newName .. "\n" .. words[#words]
		end
		self:drawText(displayName, 60, (top - FONT_HGT_NORMAL) / 2, title_rgb["r"], title_rgb["g"], title_rgb["b"], 1, UIFont.Normal);
		titleWidth = getTextManager():MeasureStringX(UIFont.Normal, displayName)
	else
		self:drawText("Dead " .. getText("Farming_" .. self.plant.typeOfSeed), 60, (top - FONT_HGT_NORMAL) / 2, title_rgb["r"], title_rgb["g"], title_rgb["b"], 1, UIFont.Normal);
	end
	local fontHgt = FONT_HGT_NORMAL
	local pady = 1
	local lineHgt = fontHgt + pady * 2
	-- background for current growing phase
    if ISFarmingMenu.cheat then
        self:drawRect(13, y, self.width - 25, lineHgt, 0.1, 1.0, 1.0, 1.0);
        -- text for current growing phase
        self:drawText(getText("Farming_Current_growing_phase") .. " : ", 13, y + pady, 1, 1, 1, 1, UIFont.Normal);
--         self:drawText(getText("Farming_Current_growing_phase") .. " : ", 20, y + pady, 1, 1, 1, 1, UIFont.Normal);
        -- stat (next growing state) on the right
        self:drawTextRight(ISFarmingInfo.getCurrentGrowingPhase(self, farmingLevel), self.width - 17, y + pady, 1, 1, 1, 1, UIFont.Normal);
        y = y + lineHgt;
    end
    if (farmingLevel >= 6 or ISFarmingMenu.cheat) and self.plant:isAlive() then
        self:drawRect(13, y, self.width - 25, lineHgt, 0.05, 1.0, 1.0, 1.0);
        self:drawText(getText("Farming_Next_growing_phase") .. " : ", 13, y + pady, 1, 1, 1, 1, UIFont.Normal);
--         self:drawText(getText("Farming_Next_growing_phase") .. " : ", 20, y + pady, 1, 1, 1, 1, UIFont.Normal);
        self:drawTextRight(ISFarmingInfo.getNextGrowingPhase(self), self.width - 17, y + pady, 1, 1, 1, 1, UIFont.Normal);
	    y = y + lineHgt;
    end
	if isDebugEnabled() and ISFarmingMenu.cheat then
		self:drawRect(13, y, self.width - 25, lineHgt, 0.05, 1.0, 1.0, 1.0);
		self:drawText("hoursElapsed" .. " : ", 13, y + pady, 1, 0.8, 0.8, 1, UIFont.Normal);
		self:drawTextRight(tostring(CFarmingSystem.instance.hoursElapsed), self.width - 17, y + pady, 1, 0.8, 0.8, 1, UIFont.Normal);
		y = y + lineHgt;
	end
-- 	y = y + lineHgt;
-- 	self:drawRect(13, y, self.width - 25, lineHgt, 0.1, 1.0, 1.0, 1.0);
-- 	self:drawText(getText("Farming_Last_time_watered") .. " : ", 20, y + pady, 1, 1, 1, 1, UIFont.Normal);
--
--     if math.floor(lastWatedHour/24) == 1 then
--         lastWatedHour =  math.floor((lastWatedHour/24)) .. " " .. getText("Farming_Day");
--     elseif  math.floor(lastWatedHour/24) > 1 then
--         lastWatedHour =  math.floor((lastWatedHour/24)) .. " " .. getText("Farming_Days");
--     elseif lastWatedHour == 1 then
--         lastWatedHour = lastWatedHour .. " " .. getText("Farming_Hour");
--     else
--         lastWatedHour = lastWatedHour .. " " .. getText("Farming_Hours");
--     end
-- -- 	lastWatedHour = lastWatedHour .. " " .. getText("Farming_Hours");
-- 	self:drawTextRight(lastWatedHour, self.width - 17, y + pady, nowateredsince_rgb["r"], nowateredsince_rgb["g"], nowateredsince_rgb["b"], 1, UIFont.Normal);
-- 	y = y + lineHgt;

    if (ISFarmingMenu.cheat)  then
--     if((farmingLevel) >= 3 or ISFarmingMenu.cheat)  then
        self:drawRect(13, y, self.width - 25, lineHgt, 0.05, 1.0, 1.0, 1.0);
        self:drawText(getText("Farming_Fertilized") .. " : ", 13, y + pady, 1.0, 1.0, 1.0, 1, UIFont.Normal);
        local fertilizer = getText("Farming_Compost_False")
        if self.plant.fertilizer == 1 then fertilizer = getText("Farming_Compost_True")
        elseif self.plant.fertilizer > 1 then fertilizer = getText("Farming_Fertilizer_TooMuch") end
        self:drawTextRight(fertilizer, self.width - 17, y + pady, fertilizer_rgb["r"], fertilizer_rgb["g"], fertilizer_rgb["b"], 1, UIFont.Normal);
        y = y + lineHgt;
    end
	self:drawRect(13, y, self.width - 25, lineHgt, 0.05, 1.0, 1.0, 1.0);
	self:drawText(getText("Farming_Compost") .. " : ", 13, y + pady, 1.0, 1.0, 1.0, 1, UIFont.Normal);
	local compost = getText("Farming_Compost_False")
	if self.plant.compost then compost = getText("Farming_Compost_True") end
	self:drawTextRight(compost, self.width - 17, y + pady, compost_rgb["r"], compost_rgb["g"], compost_rgb["b"], 1, UIFont.Normal);
	y = y + lineHgt;
-- 	self:drawRect(13, y, self.width - 25, lineHgt, 0.05, 1.0, 1.0, 1.0);
-- 	self:drawText(getText("Farming_Fertilized") .. " : ", 20, y + pady, 1.0, 1.0, 1.0, 1, UIFont.Normal);
-- 	self:drawTextRight(self.plant.fertilizer .. "", self.width - 17, y + pady, fertilizer_rgb["r"], fertilizer_rgb["g"], fertilizer_rgb["b"], 1, UIFont.Normal);
-- 	y = y + lineHgt;
    if ISFarmingMenu.cheat then
        self:drawRect(13, y, self.width - 25, lineHgt, 0.1, 1.0, 1.0, 1.0);
        self:drawText(getText("Farming_Health") .. " : ", 13, y + pady, 1.0, 1.0, 1.0, 1, UIFont.Normal);
--         self:drawText(getText("Farming_Health") .. " : ", 20, y + pady, 1.0, 1.0, 1.0, 1, UIFont.Normal);
        self:drawTextRight(ISFarmingInfo.getHealth(self, farmingLevel), self.width - 17, y + pady, health_rgb["r"], health_rgb["g"], health_rgb["b"], 1, UIFont.Normal);
        y = y + lineHgt;
    end
    local magnifierFactor = 0
    local hasMagnifier = false
    if self.character:getPrimaryHandItem() and self.character:getPrimaryHandItem():hasTag("Magnifier") then hasMagnifier = true
    elseif self.character:getSecondaryHandItem() and self.character:getSecondaryHandItem():hasTag("Magnifier") then hasMagnifier = true end
    if hasMagnifier then magnifierFactor = magnifierFactor + 2 end

    if((farmingLevel + magnifierFactor) >= 3 or ISFarmingMenu.cheat) and ISFarmingInfo.hasDisease(self.plant) then
        self:drawText(getText("Farming_Disease") .. " : ", 13, y + pady, 1, 1, 1, 1);
--         self:drawText(getText("Farming_Disease") .. " : ", 20, y + pady, 1, 1, 1, 1);
--         self:drawTextRight(disease.text, self.width - 17, y + pady, disease_rgb["0r"], disease_rgb["0g"], disease_rgb["0b"], 1);
        y = y + lineHgt;
        local pestCount = 0
        if self.plant.aphidLvl > 0 then
--         if(disease[1]) then
            self:drawRect(13, y, self.width - 25, lineHgt, 0.05, 1.0, 1.0, 1.0);
            self:drawText(getText("Farming_Aphid") .. " :", 40, y + pady, 1, 1, 1, 1)
            self:drawTextRight(ISFarmingInfo.getDiseaseString(self.plant.aphidLvl, farmingLevel), self.width - 17, y + pady, getCore():getBadHighlitedColor():getR(), getCore():getBadHighlitedColor():getG(), getCore():getBadHighlitedColor():getB(), 1);
            y = y + lineHgt;
	        self:drawTextureScaled(getTexture("media/textures/Item_Insect_Aphid.png"), 70 + titleWidth + (pestCount * 25) ,20,25,25,1,1,1,1);
            pestCount = pestCount + 1
        end
        if self.plant.mildewLvl > 0 then
--         if(disease[3]) then
            self:drawRect(13, y, self.width - 25, lineHgt, 0.05, 1.0, 1.0, 1.0);
            self:drawText(getText("Farming_Mildew") .. " :", 40, y + pady, 1, 1, 1, 1)
            self:drawTextRight(ISFarmingInfo.getDiseaseString(self.plant.mildewLvl, farmingLevel), self.width - 17, y + pady, getCore():getBadHighlitedColor():getR(), getCore():getBadHighlitedColor():getG(), getCore():getBadHighlitedColor():getB(), 1);
            y = y + lineHgt;
	        self:drawTextureScaled(getTexture("media/textures/Item_Mildew.png"), 70 + titleWidth + (pestCount * 25) ,20,25,25,1,1,1,1);
            pestCount = pestCount + 1
        end
        if self.plant.fliesLvl > 0 then
--         if(disease[2]) then
            self:drawRect(13, y, self.width - 25, lineHgt, 0.05, 1.0, 1.0, 1.0);
            self:drawText(getText("Farming_Pest_Flies") .. " :", 40, y + pady, 1, 1, 1, 1)
            self:drawTextRight(ISFarmingInfo.getDiseaseString(self.plant.fliesLvl, farmingLevel), self.width - 17, y + pady, getCore():getBadHighlitedColor():getR(), getCore():getBadHighlitedColor():getG(), getCore():getBadHighlitedColor():getB(), 1);
            y = y + lineHgt;
	        self:drawTextureScaled(getTexture("media/textures/Item_Insect_Fly.png"), 70 + titleWidth + (pestCount * 25) ,20,25,25,1,1,1,1);
            pestCount = pestCount + 1
        end
        if self.plant.slugsLvl > 0 then
--         if(disease[4]) then
            self:drawRect(13, y, self.width - 25, lineHgt, 0.05, 1.0, 1.0, 1.0);
            self:drawText(getText("Farming_Slugs") .. " :", 40, y + pady, 1, 1, 1, 1)
            self:drawTextRight(ISFarmingInfo.getDiseaseString(self.plant.slugsLvl, farmingLevel), self.width - 17, y + pady, getCore():getBadHighlitedColor():getR(), getCore():getBadHighlitedColor():getG(), getCore():getBadHighlitedColor():getB(), 1);
            y = y + lineHgt;
	        self:drawTextureScaled(getTexture("media/textures/Item_Snail.png"), 70 + titleWidth + (pestCount * 25) ,20,25,25,1,1,1,1);
            pestCount = pestCount + 1
        end
    end
	-- rect for all info
-- 	self:drawRectBorder(13, top - 1, self.width - 25, y - top + 2, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
	if self.plant:isAlive() then
		y = y + 5;
		self:drawText(getText("Farming_Water_levels") .. " :", 13, y, 1, 1, 1, 1);
		self:drawTextRight(ISFarmingInfo.getWaterLvl(self.plant, farmingLevel), self.width - 12, y, water_rgb["r"], water_rgb["g"], water_rgb["b"], 1, UIFont.normal);
		y = y + fontHgt + 2;
		-- show the water bar with at least 4 farming skill
		if farmingLevel >= 4 then
			self:drawRect(13, y, self.width - 25, 12, 0.05, 1.0, 1.0, 1.0);
			self:drawRectBorder(13, y, self.width - 25, 12, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
			self:drawRect(14, y + 1, ISFarmingInfo.getWaterBarWidth(self), 10, 0.7, waterbar_rgb["r"], waterbar_rgb["g"], waterbar_rgb["b"]);
			y = y + 12
		end
	end
	self:setHeightAndParentHeight(y + 8)
end


function ISFarmingInfo.hasDisease(plant)
    return plant.aphidLvl > 0 or plant.fliesLvl > 0 or plant.mildewLvl > 0 or plant.slugsLvl > 0
end

function ISFarmingInfo.getDiseaseString(diseaseLvl, farmingLevel)
--     if farmingLevel < 6 and not ISFarmingMenu.cheat then return getText("UI_FriendState_Unknown") end
    if diseaseLvl == 0 then return getText("Farming_None") end
    local string
    if diseaseLvl < 10 then string = getText("Farming_Light")
    elseif diseaseLvl < 30 then string = getText("Farming_Moderate")
    else string = getText("Farming_Heavy") end
    if ISFarmingMenu.cheat then
        string = string .. " (" .. tostring(diseaseLvl) .. ")"
    end
    return string
end



function ISFarmingInfo:update()
	if not self.plant:getObject() then
		self.parent:setVisible(false)
		return
	end
	if not self.isEnabled then return end

	ISPanelJoypad.update(self)
	if not self or not self.plant or (self.parent:getIsVisible() and not self:isPlantValid()) then
		if self.joyfocus then
			self.joyfocus.focus = nil
			updateJoypadFocus(self.joyfocus)
		end
		self.parent:setVisible(false)
	end

	if self.plant
	and self.plant:getSquare()
	and self.character:DistTo(self.plant:getSquare():getX(), self.plant:getSquare():getY()) > 6 then
		if self.joyfocus then
			self.joyfocus.focus = nil
			updateJoypadFocus(self.joyfocus)
		end
		self.parent:setVisible(false)
	end
end

function ISFarmingInfo:isPlantValid()
	self.plant:updateFromIsoObject()
	return self.plant ~= nil and self.plant:getIsoObject() ~= nil
end

function ISFarmingInfo:onGainJoypadFocus(joypadData)
	ISPanelJoypad.onGainJoypadFocus(self, joypadData)
	self.parent.drawJoypadFocus = true
end

function ISFarmingInfo:onLoseJoypadFocus(joypadData)
	ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
	self.parent.drawJoypadFocus = false
end

function ISFarmingInfo:onJoypadDown(button, joypadData)
	if button == Joypad.BButton then
		self.parent:setVisible(false)
		joypadData.focus = nil
	end
end

-- show text with <= 4 farming skill
-- else show the right number
function ISFarmingInfo.getHealth(info, farmingLevel)
    if not info.plant:isAlive() then return getText("Farming_Dead") end
-- 	if farmingLevel <= 4 then
	if not ISFarmingMenu.cheat then
-- 	if farmingLevel < 8 and not ISFarmingMenu.cheat then
		if info.plant.health > 80 then
			return getText("Farming_Flourishing");
		elseif info.plant.health > 60 then
			return getText("Farming_Verdant");
		elseif info.plant.health >= 50 then
			return getText("Farming_Healthy");
		elseif info.plant.health >= 25 then
			return getText("Farming_Sickly");
		else
			return getText("Farming_Dying");
		end
	else
		if info.plant.health > 80 then
			return getText("Farming_Flourishing") .. " (" .. round2(info.plant.health, 2) .. ")";
		elseif info.plant.health > 60 then
			return getText("Farming_Verdant") .. " (" .. round2(info.plant.health, 2) .. ")";
		elseif info.plant.health >= 50 then
			return getText("Farming_Healthy") .. " (" .. round2(info.plant.health, 2) .. ")";
		elseif info.plant.health >= 25 then
			return getText("Farming_Sickly") .. " (" .. round2(info.plant.health, 2) .. ")";
		else
			return getText("Farming_Dying") .. " (" .. round2(info.plant.health, 2) .. ")";
		end
-- 		return round2(info.plant.health, 2) .. "";
	end
end

-- show text with <= 2 farming skill
-- else show the right number
function ISFarmingInfo.getWaterLvl(plant, farmingLevel)
-- 	if farmingLevel <= 4 then
	if not ISFarmingMenu.cheat then
-- 	if farmingLevel < 8 and not ISFarmingMenu.cheat then
		if plant.waterLvl > 80 then
			return getText("Farming_Well_watered");
		elseif plant.waterLvl > 60 then
			return getText("Farming_Fine");
		elseif plant.waterLvl > 50 then
			return getText("Farming_Thirsty");
		elseif plant.waterLvl > 25 then
			return getText("Farming_Dry");
		else
			return getText("Farming_Parched");
		end
	else
		if plant.waterLvl > 80 then
			return getText("Farming_Well_watered") .. " (" .. round2(plant.waterLvl, 2) .. ")";
		elseif plant.waterLvl > 60 then
			return getText("Farming_Fine") .. " (" .. round2(plant.waterLvl, 2) .. ")";
		elseif plant.waterLvl > 50 then
			return getText("Farming_Thirsty") .. " (" .. round2(plant.waterLvl, 2) .. ")";
		elseif plant.waterLvl > 25 then
			return getText("Farming_Dry") .. " (" .. round2(plant.waterLvl, 2) .. ")";
		else
			return getText("Farming_Parched") .. " (" .. round2(plant.waterLvl, 2) .. ")";
		end
-- 		return round2(plant.waterLvl, 2) .. " / 100";
	end
end

function ISFarmingInfo.getTitleColor(plant)
    local rgb = {};
	if plant.state == "dead" or plant.state == "rotten" or plant.state == "destroyed" or plant.state == "harvested" then
        rgb = {["r"]=getCore():getBadHighlitedColor():getR(),["g"]=getCore():getBadHighlitedColor():getG(),["b"]=getCore():getBadHighlitedColor():getB()};
--         rgb = {["r"]=1.0,["g"]=0.0,["b"]=0.0};
	else
        rgb = {["r"]=getCore():getGoodHighlitedColor():getR(),["g"]=getCore():getGoodHighlitedColor():getG(),["b"]=getCore():getGoodHighlitedColor():getB()};
--         rgb = {["r"]=1.0,["g"]=1.0,["b"]=1.0};
    end
    title_rgb = rgb;
    return rgb;
end

function ISFarmingInfo.getWaterBarWidth(info)
	local totalWidth = info:getWidth() - 27;
	local per = totalWidth / 100;
	return totalWidth - ((100 - info.plant.waterLvl) * per);
end

-- if we have at least 2 farming, display water lvl in color, to help the player
function ISFarmingInfo.getWaterLvlBarColor(info, farmingLevel)
	ISFarmingInfo:getBlueBar(waterbar_rgb);
	if (farmingLevel >= 4  or ISFarmingMenu.cheat) and info.plant:isAlive() then
		-- first state, you must have the required water lvl, so if it's not : red
		if(info.plant.nbOfGrow == 1) then
			if(info.plant.waterLvl < info.plant.waterNeeded) then
				ISFarmingInfo:getRedBar(waterbar_rgb);
			end
		else
			local water = farming_vegetableconf.calcWater(info.plant.waterNeeded, info.plant.waterLvl);
			local waterMax = farming_vegetableconf.calcWater(info.plant.waterLvl, info.plant.waterNeededMax);
			if(water >= 0 and waterMax >= 0) then -- green
				ISFarmingInfo:getBlueBar(waterbar_rgb);
			elseif(water == -1 or waterMax == -1) then -- orange
				ISFarmingInfo:getOrangeBar(waterbar_rgb);
			else -- red
				ISFarmingInfo:getRedBar(waterbar_rgb);
			end
		end
	end
end

-- if we have at least 1 farming, display red if you don't have water your plant since more than 60hours
function ISFarmingInfo.getNoWateredSinceColor(plant, lastWatedHour, farmingLevel)
	ISFarmingInfo:getGreen(nowateredsince_rgb);
	if((farmingLevel >= 2 or ISFarmingMenu.cheat) and (plant.state ~= "dead" and plant.state ~= "rotten" and plant.state ~= "destroyed" and plant.state ~= "harvested")) then
		if(lastWatedHour < 50) then -- green
			ISFarmingInfo:getGreen(nowateredsince_rgb);
		elseif(lastWatedHour < 60) then -- orange
			ISFarmingInfo:getOrange(nowateredsince_rgb);
		else -- red
			ISFarmingInfo:getRed(nowateredsince_rgb);
		end
    end
    return nowateredsince_rgb;
end

function ISFarmingInfo:getBlueBar(list)
	list["r"] = 0.15;
	list["g"] = 0.3;
	list["b"] = 0.63;
end
function ISFarmingInfo:getOrangeBar(list)
	list["r"] = 0.98;
	list["g"] = 0.55;
	list["b"] = 0.0;
end
function ISFarmingInfo:getRedBar(list)
	list["r"] = 0.70;
	list["g"] = 0.13;
	list["b"] = 0.13;
end

local function maxWidthOfTexts(texts)
	local max = 0
	for _,text in ipairs(texts) do
		local width = getTextManager():MeasureStringX(UIFont.Normal, getText(text))
		max = math.max(max, width)
	end
	return max
end

--************************************************************************--
--** ISPanel:new
--**
--************************************************************************--
function ISFarmingInfo:new (x, y, width, height, character, plant)
	local o = {}
	o = ISPanelJoypad:new(x, y, width, height);
	setmetatable(o, self)
    self.__index = self
	o.plant = plant;
	o.character = character
	o.vegetable = getTexture(farming_vegetableconf.props[plant.typeOfSeed].icon);
-- 	o.vegetable = getTexture(farming_vegetableconf.icons[plant.typeOfSeed]);
   return o
end

function ISFarmingInfo.RequiredWidth()
	local columnWidth1 = maxWidthOfTexts({
		"Farming_Current_growing_phase",
		"Farming_Next_growing_phase",
		"Farming_Last_time_watered",
		"Farming_Fertilized",
		"Farming_Health",
		"Farming_Disease"
	})
	columnWidth1 = columnWidth1 + getTextManager():MeasureStringX(UIFont.Normal, " : ")

	local columnWidth2 = maxWidthOfTexts({
		"Farming_Flourishing",
		"Farming_Verdant",
		"Farming_Healthy",
		"Farming_Sickly",
		"Farming_Stunted",
		"Farming_Dead",
		
		"Farming_Seedling",
		"Farming_Young",
		"Farming_Harvest_Soon",
		"Farming_Ready_to_harvest",
		"Farming_Ready_to_harvest",
		"UI_FriendState_Unknown"
	})

	local width = 20 + columnWidth1 + columnWidth2 + 17

	local disease1 = maxWidthOfTexts({
		"Farming_Mildew",
		"Farming_Aphid",
		"Farming_Pest_Flies",
		"Farming_Slugs",
	})
	disease1 = disease1 + getTextManager():MeasureStringX(UIFont.Normal, " : ")

	local disease2 = getTextManager():MeasureStringX(UIFont.Normal, getText("UI_FriendState_Unknown") .. " / 100")

	width = math.max(width, 40 + disease1 + disease2 + 17)

	return width
end

-- if we have at least 2 farming, display water lvl in color, to help the player
function ISFarmingInfo.getWaterLvlColor(plant, farmingLevel)
	if farmingLevel >= 3 and plant:isAlive() then
		-- first state, you must have the required water lvl, so if it's not : red
		if(plant.nbOfGrow == 1) then
			ISFarmingInfo:getGreen(water_rgb, nil);
			if(plant.waterLvl < plant.waterNeeded) then
				ISFarmingInfo:getRed(water_rgb, nil);
            end
		else
			local water = farming_vegetableconf.calcWater(plant.waterNeeded, plant.waterLvl);
			local waterMax = farming_vegetableconf.calcWater(plant.waterLvl, plant.waterNeededMax);
			if(water >= 0 and waterMax >= 0) then -- green
				ISFarmingInfo:getGreen(water_rgb, nil);
			elseif(water == -1 or waterMax == -1) then -- orange
				ISFarmingInfo:getOrange(water_rgb, nil);
			else -- red
				ISFarmingInfo:getRed(water_rgb, nil);
			end
		end
	else
		ISFarmingInfo:getWhite(water_rgb, nil);
    end
    return water_rgb;
end

-- get the color of health if player have more than 2 farming skill (to see the health)
function ISFarmingInfo.getHealthColor(info, farmingLevel)
	if farmingLevel >= 2 or ISFarmingMenu.cheat then
		if(info.plant.health >= 50) then -- green
			ISFarmingInfo:getGreen(health_rgb, nil);
		elseif(info.plant.health >= 25) then -- orange
			ISFarmingInfo:getOrange(health_rgb, nil);
		else -- red
			ISFarmingInfo:getRed(health_rgb, nil);
		end
	else
		ISFarmingInfo:getWhite(health_rgb, nil);
	end
end

-- show nothing with 0 farming
-- show text with 1 to 2 farming
-- show numbers with > 2
function ISFarmingInfo.getCurrentGrowingPhase(info, farmingLevel)
	if info.plant:isAlive() then
        local prop = farming_vegetableconf.props[info.plant.typeOfSeed]
        if ISFarmingMenu.cheat then
            return farming_vegetableconf.getObjectPhase(info.plant) .. " " .. info.plant.nbOfGrow .. " / " .. farming_vegetableconf.props[info.plant.typeOfSeed].fullGrown+1;
--             if info.plant.hasSeed then
--                 return getText("Farming_Seed_bearing") .. " - " .. info.plant.nbOfGrow .. " / " .. farming_vegetableconf.props[info.plant.typeOfSeed].fullGrown+1;
--             elseif info.plant.hasVegetable then
--                 return getText("Farming_Ready_to_harvest") .. " - " .. info.plant.nbOfGrow .. " / " .. farming_vegetableconf.props[info.plant.typeOfSeed].fullGrown+1;
--             elseif info.plant.nbOfGrow == prop.harvestLevel - 1 then
--                 return getText("Farming_Harvest_Soon") .. " - " .. info.plant.nbOfGrow .. " / " .. farming_vegetableconf.props[info.plant.typeOfSeed].fullGrown+1;
--             elseif info.plant.nbOfGrow <= 2 then
--                 return getText("Farming_Seedling") .. " - " .. info.plant.nbOfGrow .. " / " .. farming_vegetableconf.props[info.plant.typeOfSeed].fullGrown+1;
--             else
--                 return getText("Farming_Young") .. " - " .. info.plant.nbOfGrow .. " / " .. farming_vegetableconf.props[info.plant.typeOfSeed].fullGrown+1;
--             end
        elseif farmingLevel >= 2 then -- and farmingLevel < 6 then
            return farming_vegetableconf.getObjectPhase(info.plant)
--             if info.plant.hasSeed then
--                 return getText("Farming_Seed_bearing");
--             elseif info.plant.hasVegetable then
--                 return getText("Farming_Ready_to_harvest");
--             elseif info.plant.nbOfGrow == prop.harvestLevel - 1 then
--                 return getText("Farming_Harvest_Soon");
--             elseif info.plant.nbOfGrow <= 2 then
--                 return getText("Farming_Seedling");
--             else
--                 return getText("Farming_Young");
--             end
        end
    end
	return getText("UI_FriendState_Unknown");
end

-- display the hour of the next growing phase if with have at least 4 farmings pts
function ISFarmingInfo.getNextGrowingPhase(info)
	if info.plant:isAlive() then
	-- (info.plant.state ~= "dead" and info.plant.state ~= "rotten" and info.plant.state ~= "destroyed") then
-- 	if info.plant and info.plant:isAlive() then
		if ISFarmingMenu.cheat then
			if(info.plant.nextGrowing == 0) then
				return "0 " .. getText("Farming_Hours");
			elseif(info.plant.nextGrowing - CFarmingSystem.instance.hoursElapsed < 0) then
                    return "0 " .. getText("Farming_Hours");
            end
				local hours = round2((info.plant.nextGrowing - CFarmingSystem.instance.hoursElapsed))
				if hours==1 then
					return hours .. " " .. getText("Farming_Hour");
				elseif hours <= 24 then
					return hours .. " " .. getText("Farming_Hours");
				else
					if math.floor(hours/24) == 1 then
						return round2((hours/24)) .. " " .. getText("Farming_Day");
					else
						return round2((hours/24)) .. " " .. getText("Farming_Days");
					end
				end
-- 			end
		elseif CFarmingSystem.instance:getXp(info.character) >= 6 then
            local hours = round2((info.plant.nextGrowing - CFarmingSystem.instance.hoursElapsed))
            if hours <= 24 then
                return getText("Farming_Hours");
            else
                local days = math.floor(hours/24)
                if days <= 7 then
                    return getText("Farming_Days");
                elseif days <= 28 then
                    return getText("Farming_Weeks");
                else
                    return getText("Farming_Months");
                end
            end
-- 			end
		end
		return getText("UI_FriendState_Unknown");
	end
	return getText("UI_No");
end

-- we show color of disease with 3 farming skill
function ISFarmingInfo:getDiseaseColor(diseaseLvl, index, info)
	ISFarmingInfo:getWhite(disease_rgb, index);
	if((CFarmingSystem.instance:getXp(self.character) >= 6  or ISFarmingMenu.cheat) and info.plant:isAlive()) then
		local disease = farming_vegetableconf.calcDisease(diseaseLvl);
		ISFarmingInfo:getGreen(disease_rgb, index);
		if(diseaseLvl > 0) then -- orange
			ISFarmingInfo:getRed(disease_rgb, index);
		elseif(disease == -2) then -- red
			ISFarmingInfo:getRed(disease_rgb, index);
		end
	else
		ISFarmingInfo:getWhite(disease_rgb, index);
	end
end

-- function ISFarmingInfo:getDiseaseString(diseaseLvl)
--     if diseaseLvl == 0 then return end
--     if diseaseLvl < 10 then return getText("Farming_Light")
--     elseif diseaseLvl < 30 then return getText("Farming_Moderate")
--     else return getText("Farming_Heavy") end
-- end

function ISFarmingInfo.getDisease(diseaseLvl, farmingLevel, disease, info, index, string)
	if(diseaseLvl > 0) then
        local result = {};
		disease.text = getText("UI_Yes");
		ISFarmingInfo:getRed(disease_rgb, "0");
		if(farmingLevel >= 4 or ISFarmingMenu.cheat) then
			result.name = getText("Farming_" .. string) .. " : ";
			if ISFarmingMenu.cheat then
				result.value = diseaseLvl .. " / 100";
			elseif farmingLevel >=6  then
				result.value = ISFarmingInfo:getDiseaseString(diseaseLvl);
			else
				result.value = getText("UI_FriendState_Unknown");
			end
			-- we have disease, let's add it to our map
			disease[index] = result;
			ISFarmingInfo:getDiseaseColor(diseaseLvl, "1", info);
		end
	end
-- 	return disease
end

-- we show name of disease with 2 farming skill
-- we show lvl of disease with 3 farming skill
function ISFarmingInfo.getDiseaseName(info)
	local farmingLevel = CFarmingSystem.instance:getXp(info.character)
	local disease = {}
    if(farmingLevel >= 4 or ISFarmingMenu.cheat) then
        ISFarmingInfo.getDisease(info.plant.aphidLvl, farmingLevel, disease, info, 1, "Mildew")
        ISFarmingInfo.getDisease(info.plant.fliesLvl, farmingLevel, disease, info, 2, "Aphid")
        ISFarmingInfo.getDisease(info.plant.mildewLvl, farmingLevel, disease, info, 3, "Flies")
        ISFarmingInfo.getDisease(info.plant.slugsLvl, farmingLevel, disease, info, 4, "Slugs")
    end
-- 	local result = {};
	-- mildew
-- 	if(info.plant.mildewLvl > 0) then
-- 		disease.text = getText("UI_Yes");
-- 		ISFarmingInfo:getOrange(disease_rgb, "0");
-- 		if(farmingLevel >= 4 or ISFarmingMenu.cheat) then
-- 			result.name = getText("Farming_Mildew") .. " : ";
-- 			if ISFarmingMenu.cheat then
-- -- 			if(farmingLevel >= 6 or ISFarmingMenu.cheat) then
-- 				result.value = info.plant.mildewLvl .. " / 100";
-- 			elseif(farmingLevel >=6 or ISFarmingMenu.cheat) then
-- -- 			if(farmingLevel >= 6 or ISFarmingMenu.cheat) then
-- 				result.value = ISFarmingInfo:getDiseaseString(info.plant.mildewLvl);
-- -- 				result.value = info.plant.mildewLvl .. " / 100";
-- 			else
-- 				result.value = getText("UI_FriendState_Unknown");
-- -- 				result.value = getText("UI_FriendState_Unknown") .. " / 100";
-- 			end
-- 			-- we have mildew, let's add it to our map
-- 			disease[1] = result;
-- 			ISFarmingInfo:getDiseaseColor(info.plant.mildewLvl, "1", info);
-- 		end
-- 	end
--
-- 	-- now we test aphid
-- 	if(info.plant.aphidLvl > 0) then
-- 		disease.text = getText("UI_Yes");
-- 		ISFarmingInfo:getOrange(disease_rgb, "0");
-- 		if(farmingLevel >= 4) or ISFarmingMenu.cheat) then
-- 			result = {};
-- 			result.name = getText("Farming_Aphid") .. " : ";
--
-- 			if ISFarmingMenu.cheat then
-- -- 			if(farmingLevel >= 6 or ISFarmingMenu.cheat) then
-- 				result.value = info.plant.aphidLvl .. " / 100";
-- 			elseif(farmingLevel >=6 or ISFarmingMenu.cheat) then
-- -- 			if(farmingLevel >= 6 or ISFarmingMenu.cheat) then
-- 				result.value = ISFarmingInfo:getDiseaseString(info.plant.aphidLvl);
-- -- 				result.value = info.plant.mildewLvl .. " / 100";
-- 			else
-- 				result.value = getText("UI_FriendState_Unknown");
-- -- 				result.value = getText("UI_FriendState_Unknown") .. " / 100";
-- 			end
-- 			-- we have aphid let's add it to our map
-- 			disease[#disease + 1] = result;
-- 			ISFarmingInfo:getDiseaseColor(info.plant.aphidLvl, #disease, info);
-- 		end
-- 	end
--
-- 	-- now we test flies
-- 	if(info.plant.fliesLvl > 0) then
-- 		disease.text = getText("UI_Yes");
-- 		ISFarmingInfo:getOrange(disease_rgb, "0");
-- 		if(farmingLevel >= 4 or ISFarmingMenu.cheat) then
-- 			result = {};
-- 			result.name = getText("Farming_Pest_Flies") .. " : ";
--
-- 			if ISFarmingMenu.cheat then
-- -- 			if(farmingLevel >= 6 or ISFarmingMenu.cheat) then
-- 				result.value = info.plant.fliesLvl .. " / 100";
-- 			elseif(farmingLevel >=6 or ISFarmingMenu.cheat) then
-- -- 			if(farmingLevel >= 6 or ISFarmingMenu.cheat) then
-- 				result.value = ISFarmingInfo:getDiseaseString(info.plant.fliesLvl);
-- -- 				result.value = info.plant.mildewLvl .. " / 100";
-- 			else
-- 				result.value = getText("UI_FriendState_Unknown");
-- -- 				result.value = getText("UI_FriendState_Unknown") .. " / 100";
-- 			end
-- 			-- we have flies let's add it to our map
-- 			disease[#disease + 1] = result;
-- 			ISFarmingInfo:getDiseaseColor(info.plant.fliesLvl, #disease, info);
-- 		end
-- 	end
--
-- 	-- now we test slugs
-- 	if(info.plant.slugsLvl > 0) then
-- 		disease.text = getText("UI_Yes");
-- 		ISFarmingInfo:getOrange(disease_rgb, "0");
-- 		if(farmingLevel >= 4 or ISFarmingMenu.cheat) then
-- 			result = {};
-- 			result.name = getText("Farming_Slugs") .. " : ";
--
-- 			if ISFarmingMenu.cheat then
-- -- 			if(farmingLevel >= 6 or ISFarmingMenu.cheat) then
-- 				result.value = info.plant.slugsLvl .. " / 100";
-- 			elseif(farmingLevel >=6 or ISFarmingMenu.cheat) then
-- -- 			if(farmingLevel >= 6 or ISFarmingMenu.cheat) then
-- 				result.value = ISFarmingInfo:getDiseaseString(info.plant.slugsLvl);
-- -- 				result.value = info.plant.mildewLvl .. " / 100";
-- 			else
-- 				result.value = getText("UI_FriendState_Unknown");
-- -- 				result.value = getText("UI_FriendState_Unknown") .. " / 100";
-- 			end
-- 			-- we have flies let's add it to our map
-- 			disease[#disease + 1] = result;
-- 			ISFarmingInfo:getDiseaseColor(info.plant.fliesLvl, #disease, info);
-- 		end
-- 	end

	-- if we have no disease
	if disease.text == nil then
		disease.text = getText("UI_No");
		ISFarmingInfo:getGreen(disease_rgb, "0");
	end
	return disease;
end

function ISFarmingInfo.getLastWatedHour(plant)
	return CFarmingSystem.instance.hoursElapsed - plant.lastWaterHour;
end

-- display the color danger of the fertilizer lvl (0-2 : green, 2-3 : orange, 4 red)
function ISFarmingInfo.getFertilizerColor(info)
	if info.plant.state ~= "dead" and info.plant.state ~= "rotten" and info.plant.state ~= "destroyed"  and info.plant.state ~= "harvested" then
		if(info.plant.fertilizer < 1) then
			ISFarmingInfo:getWhite(fertilizer_rgb, nil);
		elseif(info.plant.fertilizer < 2) then
			ISFarmingInfo:getGreen(fertilizer_rgb, nil);
		else
			ISFarmingInfo:getRed(fertilizer_rgb, nil);
		end
		if info.plant.compost then
            ISFarmingInfo:getGreen(compost_rgb, nil);
		else
            ISFarmingInfo:getWhite(compost_rgb, nil);
		end
	else
		ISFarmingInfo:getWhite(fertilizer_rgb, nil);
		ISFarmingInfo:getWhite(compost_rgb, nil);
	end
end
function ISFarmingInfo:getGreen(list, index)
	if(index ~= nil) then
		list[index .. "r"] = getCore():getGoodHighlitedColor():getR();
		list[index .. "g"] = getCore():getGoodHighlitedColor():getG();
		list[index .. "b"] = getCore():getGoodHighlitedColor():getB();
	else
		list["r"] = getCore():getGoodHighlitedColor():getR();
		list["g"] = getCore():getGoodHighlitedColor():getG();
		list["b"] = getCore():getGoodHighlitedColor():getB();
	end
end

function ISFarmingInfo:getRed(list, index)
	if(index ~= nil) then
		list[index .. "r"] = getCore():getBadHighlitedColor():getR();
		list[index .. "g"] = getCore():getBadHighlitedColor():getG();
		list[index .. "b"] = getCore():getBadHighlitedColor():getB();
	else
		list["r"] = getCore():getBadHighlitedColor():getR();
		list["g"] = getCore():getBadHighlitedColor():getG();
		list["b"] = getCore():getBadHighlitedColor():getB();
	end
end

-- function ISFarmingInfo:getGreen(list, index)
-- 	if(index ~= nil) then
-- 		list[index .. "r"] = 0.0;
-- 		list[index .. "g"] = 0.8;
-- 		list[index .. "b"] = 0.0;
-- 	else
-- 		list["r"] = 0.0;
-- 		list["g"] = 0.8;
-- 		list["b"] = 0.0;
-- 	end
-- end

function ISFarmingInfo:getOrange(list, index)
	if(index ~= nil) then
		list[index .. "r"] = 1.0;
		list[index .. "g"] = 0.5;
		list[index .. "b"] = 0.0;
	else
		list["r"] = 1.0;
		list["g"] = 0.5;
		list["b"] = 0.0;
	end
end

-- function ISFarmingInfo:getRed(list, index)
-- 	if(index ~= nil) then
-- 		list[index .. "r"] = 1.0;
-- 		list[index .. "g"] = 0.0;
-- 		list[index .. "b"] = 0.0;
-- 	else
-- 		list["r"] = 1.0;
-- 		list["g"] = 0.0;
-- 		list["b"] = 0.0;
-- 	end
-- end

function ISFarmingInfo:getWhite(list, index)
	if(index ~= nil) then
		list[index .. "r"] = 1.0;
		list[index .. "g"] = 1.0;
		list[index .. "b"] = 1.0;
	else
		list["r"] = 1.0;
		list["g"] = 1.0;
		list["b"] = 1.0;
	end
end
