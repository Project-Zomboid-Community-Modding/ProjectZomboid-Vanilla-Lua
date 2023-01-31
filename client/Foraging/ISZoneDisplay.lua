-------------------------------------------------
-------------------------------------------------
--
-- ISZoneDisplay
--
-- eris
--
-------------------------------------------------
-------------------------------------------------
local zdImage = ISPanel:derive("zdImage");
ISZoneDisplay = ISPanel:derive("ISZoneDisplay");
-------------------------------------------------
-------------------------------------------------
local zdTex = {
	eyeconOn			= getTexture("media/textures/Foraging/eyeconOn_Shade.png"),
	--
	infoBtn				= getTexture("media/textures/Foraging/question_mark.png"),
	prevBtn				= getTexture("media/ui/sGuidePrevBtn.png"),
	nextBtn				= getTexture("media/ui/sGuideNextBtn.png"),
	closeBtn			= getTexture("media/ui/sGuideCloseBtn.png"),
	--
	frame = {
		stars			= getTexture("media/textures/Foraging/ISZoneDisplay/zd_stars.png"),
		clouds			= getTexture("media/textures/Foraging/ISZoneDisplay/zd_clouds.png"),
		fog1			= getTexture("media/textures/Foraging/ISZoneDisplay/zd_fog1.png"),
		fog2			= getTexture("media/textures/Foraging/ISZoneDisplay/zd_fog2.png"),
		fog3			= getTexture("media/textures/Foraging/ISZoneDisplay/zd_fog3.png"),
		frame			= getTexture("media/textures/Foraging/ISZoneDisplay/zd_frame.png"),
	},
	moons = {
		moon0			= getTexture("media/textures/Foraging/ISZoneDisplay/moon/zd_moon0.png"),
		moon1			= getTexture("media/textures/Foraging/ISZoneDisplay/moon/zd_moon1.png"),
		moon2			= getTexture("media/textures/Foraging/ISZoneDisplay/moon/zd_moon2.png"),
		moon3			= getTexture("media/textures/Foraging/ISZoneDisplay/moon/zd_moon3.png"),
		moon4			= getTexture("media/textures/Foraging/ISZoneDisplay/moon/zd_moon4.png"),
		moon5			= getTexture("media/textures/Foraging/ISZoneDisplay/moon/zd_moon5.png"),
		moon6			= getTexture("media/textures/Foraging/ISZoneDisplay/moon/zd_moon6.png"),
		moon7			= getTexture("media/textures/Foraging/ISZoneDisplay/moon/zd_moon7.png"),
	},
	world = {
		sun				= getTexture("media/textures/Foraging/ISZoneDisplay/zd_sun.png"),
		moon			= getTexture("media/textures/Foraging/ISZoneDisplay/zd_moon.png"),
	},
	zone = {
		Forest          = getTexture("media/textures/Foraging/ISZoneDisplay/zones/Forest.png"),
		DeepForest      = getTexture("media/textures/Foraging/ISZoneDisplay/zones/DeepForest.png"),
		Farm            = getTexture("media/textures/Foraging/ISZoneDisplay/zones/Farm.png"),
		FarmLand        = getTexture("media/textures/Foraging/ISZoneDisplay/zones/FarmLand.png"),
		Nav             = getTexture("media/textures/Foraging/ISZoneDisplay/zones/Nav.png"),
		TownZone        = getTexture("media/textures/Foraging/ISZoneDisplay/zones/TownZone.png"),
		TrailerPark     = getTexture("media/textures/Foraging/ISZoneDisplay/zones/TrailerPark.png"),
		Unknown         = getTexture("media/textures/Foraging/ISZoneDisplay/zones/Unknown.png"),
		Vegitation      = getTexture("media/textures/Foraging/ISZoneDisplay/zones/Vegitation.png"),
	},
};
-------------------------------------------------
-------------------------------------------------
ISZoneDisplay.tips = {
	{ --unlocking new tips
		level           = 0,
		title           = getText("IGUI_SearchMode_Tip_Tips_Title"),
		text            = getText("IGUI_SearchMode_Tip_Tips_Text"),
		shown           = false,
	},
	{ --skill requirements
		level           = 0,
		title           = getText("IGUI_SearchMode_Tip_Skill_Title"),
		text            = getText("IGUI_SearchMode_Tip_Skill_Text"),
		shown           = false,
	},
	{ --search focus
		level           = 0,
		title           = getText("IGUI_SearchMode_Tip_SearchFocus_Title"),
		text            = getText("IGUI_SearchMode_Tip_SearchFocus_Text"),
		shown           = false,
	},
	{ --situational awareness
		level           = 1,
		title           = getText("IGUI_SearchMode_Tip_Situational_Title"),
		text            = getText("IGUI_SearchMode_Tip_Situational_Text"),
		shown           = false,
	},
	{ --firewood and stones
		level           = 1,
		title           = getText("IGUI_SearchMode_Tip_FirewoodStones_Title"),
		text            = getText("IGUI_SearchMode_Tip_FirewoodStones_Text"),
		shown           = false,
	},
	{ --search open areas
		level           = 2,
		title           = getText("IGUI_SearchMode_Tip_Finding_Title"),
		text            = getText("IGUI_SearchMode_Tip_Finding_Text"),
		shown           = false,
	},
	{ --visibility requirement
		level           = 3,
		title           = getText("IGUI_SearchMode_Tip_Visibility_Title"),
		text            = getText("IGUI_SearchMode_Tip_Visibility_Text"),
		shown           = false,
	},
	{ --berries
		level           = 3,
		title           = getText("IGUI_SearchMode_Tip_Berries_Title"),
		text            = getText("IGUI_SearchMode_Tip_Berries_Text"),
		shown           = false,
	},
	{ --darkness effect
		level           = 4,
		title           = getText("IGUI_SearchMode_Tip_Darkness_Title"),
		text            = getText("IGUI_SearchMode_Tip_Darkness_Text"),
		shown           = false,
	},
	{ --mushrooms
		level           = 4,
		title           = getText("IGUI_SearchMode_Tip_Mushrooms_Title"),
		text            = getText("IGUI_SearchMode_Tip_Mushrooms_Text"),
		shown           = false,
	},
	{ --weather effect
		level           = 5,
		title           = getText("IGUI_SearchMode_Tip_Weather_Title"),
		text            = getText("IGUI_SearchMode_Tip_Weather_Text"),
		shown           = false,
	},
	{ --insects
		level           = 5,
		title           = getText("IGUI_SearchMode_Tip_Insects_Title"),
		text            = getText("IGUI_SearchMode_Tip_Insects_Text"),
		shown           = false,
	},
	{ --medicinal herbs
		level           = 6,
		title           = getText("IGUI_SearchMode_Tip_Herbs_Title"),
		text            = getText("IGUI_SearchMode_Tip_Herbs_Text"),
		shown           = false,
	},
	{ --categories tooltip
		level           = 7,
		title           = getText("IGUI_SearchMode_Tip_Categories_Title"),
		text            = getText("IGUI_SearchMode_Tip_Categories_Text"),
		shown           = false,
	},
	{ --crops
		level           = 8,
		title           = getText("IGUI_SearchMode_Tip_Crops_Title"),
		text            = getText("IGUI_SearchMode_Tip_Crops_Text"),
		shown           = false,
	},
	{ --seasons
		level           = 9,
		title           = getText("IGUI_SearchMode_Tip_Seasons_Title"),
		text            = getText("IGUI_SearchMode_Tip_Seasons_Text"),
		shown           = false,
	},
	{ --wild plants
		level           = 10,
		title           = getText("IGUI_SearchMode_Tip_WildPlants_Title"),
		text            = getText("IGUI_SearchMode_Tip_WildPlants_Text"),
		shown           = false,
	},
};
-------------------------------------------------
-------------------------------------------------
local sin, antiPi = math.sin, 0-math.pi;
-------------------------------------------------
-------------------------------------------------
function ISZoneDisplay:toggleTips()
	self.tipPanel:setVisible(not self.tipPanel:getIsVisible());
	self:showTip(ISZoneDisplay.tips[self.currentTip]);
end

function ISZoneDisplay:showNextTip()
	local perkLevel = self.character:getPerkLevel(Perks.PlantScavenging);
	self.currentTip = self.currentTip + 1;
	if self.currentTip > #self.tips then self.currentTip = 1; end;
	if ISZoneDisplay.tips[self.currentTip].level > perkLevel then self.currentTip = 1; end;
	self:showTip(ISZoneDisplay.tips[self.currentTip]);
end

function ISZoneDisplay:showPrevTip()
	local perkLevel = self.character:getPerkLevel(Perks.PlantScavenging);
	self.currentTip = self.currentTip - 1;
	if self.currentTip < 1 then
		for i = #self.tips, 1, -1 do
			self.currentTip = i;
			if ISZoneDisplay.tips[i].level <= perkLevel then
				break;
			end;
		end;
	end;
	self:showTip(ISZoneDisplay.tips[self.currentTip]);
end

function ISZoneDisplay:showTip(_tip, _force)
	if _force then self.tipPanel:setVisible(true); end;
	--
	self.infoBtn:setTextureRGBA(1, 1, 1, 1);
	--
	self.flashTipButton		= false;
	self.flashNumber		= 0;
	--
	self.tipPanel.tip = _tip;
	--
	self.tipPanel:setText(
		" <CENTRE> " ..
		"<H1> " ..
		_tip.title ..
		" <TEXT> " ..
		" <LINE> " ..
		" <LINE> " ..
		" <CENTRE> " ..
		" <SIZE:small> " ..
		_tip.text
	);
	--
	self.tipPanel:paginate();
end

function ISZoneDisplay:updateTips()
	local perkLevel = self.character:getPerkLevel(Perks.PlantScavenging);
	if perkLevel ~= self.perkLevel then
		for _, tip in pairs(ISZoneDisplay.tips) do
			if tip.level == perkLevel then
				self:showTip(tip);
				if (not self.tipPanel:getIsVisible()) then self.flashTipButton = true; end;
				break;
			end;
		end;
		self.perkLevel = perkLevel;
	end;
	--
	if self.flashTipButton then
		local step = self.blinkStep / 10;
		self.infoBtn:setTextureRGBA(step, step, step, 1);
		--
		self.blinkStep = self.blinkStep - 1;
		if self.blinkStep < 0 then
			self.blinkStep = 10;
			self.flashNumber = self.flashNumber + 1;
			if self.flashNumber > self.flashNumberMax then
				self.flashTipButton = false;
			end;
		end;
	end;
end

-------------------------------------------------
-------------------------------------------------
function ISZoneDisplay:updateMoonPosition(_dawn, _dusk, _timeOfDay)
	local nightLength = (24 - _dusk) + _dawn;
	local nightRemaining;
	local beforeMidnight = false;
	if _timeOfDay > _dusk then
		nightRemaining = (24 - _timeOfDay) + _dawn;
		beforeMidnight = true;
	else
		nightRemaining = _dawn - _timeOfDay;
	end;
	local nightRatio = (nightRemaining / nightLength);
	if nightRatio > 0.5 then
		self.stars:setAlpha(1 - nightRatio);
	else
		self.stars:setAlpha(nightRatio);
	end;
	local height = self.height * 0.33;
	self.moon:setX(math.max(self.width - self.moon:getWidth() - (self.width * nightRatio), 0));
	self.moon:setY(math.max( height + (height * sin(nightRatio * antiPi)), 0));
end
-------------------------------------------------
-------------------------------------------------
function ISZoneDisplay:updateSunPosition(_dawn, _dusk, _timeOfDay)
	local dayLength = _dusk - _dawn;
	local dayRemaining = _dusk - _timeOfDay;
	local dayRatio = (dayRemaining / dayLength);
	local height = self.height * 0.33;
	self.sun:setX(math.max(self.width - self.sun:getWidth() - (self.width * dayRatio), 0));
	self.sun:setY(math.max( height + (height * sin(dayRatio * antiPi)), 0));
end
-------------------------------------------------
-------------------------------------------------
local function getZoneType(_x, _y)
	local zones = getWorld():getMetaGrid():getZonesAt(_x, _y, 0);
	if zones then
		for i = zones:size(),1,-1 do
			local zone = zones:get(i-1);
			if zone then
				if forageSystem.zoneDefs[zone:getType()] then
					return zone:getType();
				end;
			end;
		end;
	end;
	return "Unknown";
end
-------------------------------------------------
-------------------------------------------------
function ISZoneDisplay:doFadeStep()
	for target, element in pairs(self.fadeElements) do
		if self.fadeTarget == target then
			element:setAlphaTarget(1);
		else
			element:setAlphaTarget(0);
		end;
	end;
end
-------------------------------------------------
-------------------------------------------------
function ISZoneDisplay:canSeeThroughObject(_object)
	if (not _object) or _object:getObjectIndex() == -1 then return false; end;
	local object = _object;
	if instanceof(object, "IsoWindow") then
		local curtains = object:HasCurtains();
		if curtains then
			if curtains:IsOpen() then
				return true;
			end;
		else
			return true;
		end;
	end;
	if instanceof(object, "IsoDoor") then
		if object:getProperties() and object:getProperties():Is("doorTrans") then
			if not object:getProperties():Is("GarageDoor") then
				local curtains = object:HasCurtains();
				if curtains then
					if curtains:IsOpen() then
						return true;
					end;
				else
					return true;
				end;
			end;
		end;
	end;
	return false;
end

function ISZoneDisplay:canSeeOutside()
	if self.character:isOutside() then return true; end;
	local plSquare = self.character:getCurrentSquare();
	if not plSquare then return; end;

	local playerDirection = self.character:getDir();
	if playerDirection then
		local plX, plY, plZ = self.character:getX(), self.character:getY(), self.character:getZ();

		local squareTable = {};
		for x = -1, 1 do
			for y = -1, 1 do
				table.insert(squareTable, getCell():getGridSquare(plX + x, plY + y, plZ));
			end;
		end;

		local directionTable = {};
		directionTable[IsoDirections.N]      = {squareTable[1], squareTable[4], squareTable[7]};
		directionTable[IsoDirections.S]      = {squareTable[3], squareTable[6], squareTable[9]};
		directionTable[IsoDirections.E]      = {squareTable[7], squareTable[8], squareTable[9]};
		directionTable[IsoDirections.W]      = {squareTable[1], squareTable[2], squareTable[3]};
		directionTable[IsoDirections.NE]     = {squareTable[4], squareTable[7], squareTable[8]};
		directionTable[IsoDirections.NW]     = {squareTable[1], squareTable[2], squareTable[4]};
		directionTable[IsoDirections.SE]     = {squareTable[6], squareTable[8], squareTable[9]};
		directionTable[IsoDirections.SW]     = {squareTable[2], squareTable[3], squareTable[6]};

		if directionTable[playerDirection] then
			for _, square in ipairs(directionTable[playerDirection]) do
				if square and square:isOutside() then
					if not plSquare:isBlockedTo(square) then return true; end;
					if square:isCanSee(self.player) then return true; end;
					if plSquare:isWindowTo(square) or plSquare:isDoorTo(square) then
						local object;
						local sqObjects = square:getObjects();
						for i = 0, sqObjects:size() - 1 do
							object = sqObjects:get(i);
							if object and self:canSeeThroughObject(object) then
								return true;
							end;
						end;
						local plObjects = plSquare:getObjects();
						for i = 0, plObjects:size() - 1 do
							object = plObjects:get(i);
							if object and self:canSeeThroughObject(object) then
								return true;
							end;
						end;
					end;
				end;
			end;
		end;
	end;
	return false;
end
-------------------------------------------------
-------------------------------------------------
function ISZoneDisplay:updateLocation()
	if (not self.canSeeSky) then
		self.sun:setAlphaTarget(0);
		self.moon:setAlphaTarget(0);
		self.stars:setAlphaTarget(0);
		self.clouds:setAlphaTarget(0);
		self.fog1:setAlphaTarget(0);
		self.fog2:setAlphaTarget(0);
		self.fog3:setAlphaTarget(0);
	end;
	local zoneType = getZoneType(self.character:getX(), self.character:getY());
	self.currentZone = zoneType;
	if self.fadeTarget ~= zoneType then
		self.fadeTarget = zoneType;
	end;
end
-------------------------------------------------
-------------------------------------------------
local function formatPercent(_float)
	return string.format("%+.2f", _float * 100);
end

local function getRGBForTooltip(_isGreen)
	if _isGreen then return " <RGB:0,1,0> "; end;
	return " <RGB:1,0.5,0> ";
end

local function getToolTipText(_text, _value, _isBonus)
	if _value == 0 then return ""; end;
	local rgbWhite = " <RGB:1,1,1> ";
	local text = _text .. ": <SPACE> ";
	if _isBonus then
		return " " .. rgbWhite .. text .. getRGBForTooltip(_value > 0) .. formatPercent(_value) .. " \% <LINE> ";
	else
		return " " .. rgbWhite .. text .. getRGBForTooltip(_value < 0) .. formatPercent(_value) .. " \% <LINE> ";
	end;
end

function ISZoneDisplay:getVisionTooltipText()
	local rgbWhite = " <RGB:1,1,1> ";
	local text = "";
	--
	local visionRadius	= self.manager:getOverlayRadius();
	local modifiers		= self.manager.modifiers;
	text = text .. rgbWhite .. getText("IGUI_SearchMode_Vision_Effect_Radius") .. ": " .. string.format("%.2f", visionRadius) .. " <LINE> ";
	text = text .. getToolTipText(getText("IGUI_SearchMode_Vision_Effect_Aiming"), modifiers.aimBonus - 1, true);
	text = text .. getToolTipText(getText("IGUI_SearchMode_Vision_Effect_Crouching"), modifiers.sneakBonus - 1, true);
	text = text .. getToolTipText(getText("IGUI_SearchMode_Vision_Effect_Weather"), modifiers.weatherPenalty - 1, true);
	text = text .. getToolTipText(getText("IGUI_SearchMode_Vision_Effect_Darkness"), modifiers.lightPenalty - 1, true);
	text = text .. getToolTipText(getText("IGUI_SearchMode_Vision_Effect_Movement"), modifiers.movementPenalty - 1, true);
	text = text .. getToolTipText(getText("IGUI_SearchMode_Vision_Effect_Clothing"), modifiers.clothingPenalty - 1, true);
	text = text .. " <LINE> " .. rgbWhite .. getText("IGUI_SearchMode_Vision_Effect_Trait_Profession_Bonuses") .. " <LINE> ";
	text = text .. rgbWhite .. getText("IGUI_SearchMode_Vision_Effect_Bonus_Radius") .. ": <SPACE> " .. getRGBForTooltip(modifiers.professionBonus + modifiers.traitBonus > 0) .. string.format("%+.2f", modifiers.professionBonus + modifiers.traitBonus) .. " <LINE> ";
	text = text .. getToolTipText(getText("IGUI_SearchMode_Vision_Effect_Weather"), forageSystem.getWeatherEffectReduction(self.character) - 1, false);
	text = text .. getToolTipText(getText("IGUI_SearchMode_Vision_Effect_Darkness"), forageSystem.getDarknessEffectReduction(self.character) - 1, false);
	for _, catDef in pairs(forageSystem.catDefs) do
		local catVisionEffect = forageSystem.getCategoryBonus(self.character, catDef) - 1;
		local categoryText = getTextOrNull("IGUI_SearchMode_Categories_"..catDef.name);
		if categoryText then
			text = text .. getToolTipText(categoryText, catVisionEffect, true);
		end;
	end;
	return text;
end
-------------------------------------------------
-------------------------------------------------
function ISZoneDisplay:getZoneTooltipText()
	local fuzzyChanceTable = {
		[1] = {text = getText"Sandbox_Rarity_option1", chance = 0},
		[2] = {text = getText"Sandbox_Rarity_option2", chance = 1},
		[3] = {text = getText"Sandbox_Rarity_option3", chance = 5},
		[4] = {text = getText"Sandbox_Rarity_option4", chance = 10},
		[5] = {text = getText"Sandbox_Rarity_option5", chance = 25},
		[6] = {text = getText"Sandbox_Rarity_option6", chance = 50},
		[7] = {text = getText"Sandbox_Rarity_option7", chance = 1000},
	};
	local text = "";
	if self.currentZone == "Unknown" then
		text = text .. " <LINE> " .. getText("IGUI_SearchMode_Window_Tooltip_Nothing_In_Area");
	else
		local catDefs = forageSystem.catDefs;
		local chanceTable = {};
		local totalChance = 0;
		local zoneChance;
		local categoryName;
		local exactCategory;
		local perkLevel;
		for catName, catDef in pairs(catDefs) do
			perkLevel = self.character:getPerkLevel(Perks.FromString(catDef.identifyCategoryPerk));
			--some categories are deliberately hidden (ammunition, forest rarities)
			if not catDef.categoryHidden then
				exactCategory = getTextOrNull("IGUI_SearchMode_Categories_"..catDef.name);
			else
				exactCategory = nil;
			end;
			zoneChance = catDef.zoneChance[self.currentZone] * forageSystem.getWeatherBonus(catDef);
			if zoneChance and zoneChance > 0 then
				zoneChance = zoneChance * forageSystem.getTimeOfDayBonus(catDef);
				--show exact categories in forage debug mode
				if ISSearchWindow.showDebug then
					categoryName = catName;
				elseif exactCategory and (perkLevel >= catDef.identifyCategoryLevel) then
					categoryName = exactCategory;
				else
					categoryName = getText("IGUI_SearchMode_Categories_"..catDef.typeCategory);
				end;
				if not chanceTable[categoryName] then
					chanceTable[categoryName] = 0;
				end;
				totalChance = totalChance + zoneChance;
				chanceTable[categoryName] = chanceTable[categoryName] + zoneChance;
			end;
		end;
		--
		text = text .. " <LINE> " .. getText("IGUI_SearchMode_Window_Tooltip_Categories_In_Area") .. " <LINE> ";
		--
		local fuzzyChance = "Unknown";
		local chanceTableSorted = {};
		for k, v in pairs(chanceTable) do
			table.insert(chanceTableSorted, {name = k, chance = v});
		end;
		table.sort(chanceTableSorted, function (a, b)return a.chance > b.chance; end);
		for _, chanceCategory in ipairs(chanceTableSorted) do
			local exactChance = (chanceCategory.chance / totalChance);
			for _, fuzzyTable in ipairs(fuzzyChanceTable) do
				if (exactChance * 100) <= fuzzyTable.chance then
					fuzzyChance = fuzzyTable.text;
					break;
				end;
			end;
			text = text .. " <LINE> <RGB:1,1,1> <TEXT> ".. chanceCategory.name ..": <SPACE> <RGB:"..0.5-exactChance..","..0.5+exactChance..",0> ";
			if ISSearchWindow.showDebug then
				text = text .. string.format("%.2f", exactChance * 100) .. "%";
			else
				text = text .. fuzzyChance;
			end;
		end;
	end;
	return text;
end
-------------------------------------------------
-------------------------------------------------
local function isMouseOverElement(_element)
	--prevent tooltips appearing above the world map when the foraging info ui is open underneath
	if (ISWorldMap_instance and ISWorldMap_instance:isVisible()) then return false; end;
	--
	local mX, mY = getMouseX(), getMouseY();
	if mX >= _element:getAbsoluteX() and mY >= _element:getAbsoluteY() then
		return mX <= _element:getAbsoluteX() + _element:getWidth() and mY <= _element:getAbsoluteY() + _element:getHeight();
	end;
	return false;
end

function ISZoneDisplay:updateTooltip()
	if (not self.tooltip) then
		self.tooltip = ISToolTip:new();
		self.tooltip:setOwner(self);
		self.tooltip:setVisible(false);
		self.tooltip:setAlwaysOnTop(true);
	end;
	if self.tooltip and self:isReallyVisible() then
		if (not self.tooltip:getIsVisible()) then
			self.tooltip:addToUIManager();
			self.tooltip:setVisible(true);
		end;
		--
		local tooltipForced = self.parent.tooltipForced;
		--
		self.tooltip.followMouse = not tooltipForced
		if tooltipForced then
			local ui = self.parent and self.parent or self
			self.tooltip:setX(ui:getAbsoluteX() + self:getWidth());
			self.tooltip:setY(ui:getAbsoluteY());
		else
			self.tooltip:setX(self:getMouseX() + 23);
			self.tooltip:setY(self:getMouseY() + 23);
		end;
		--
		if isMouseOverElement(self) or tooltipForced ~= nil then
			if isMouseOverElement(self.visionBonuses) or tooltipForced == "Vision" then
				self.tooltip:setName(getText("IGUI_SearchMode_Vision_Effect_Title"));
				self.tooltip.description = self:getVisionTooltipText();
			elseif isMouseOverElement(self.infoBtn) then
				self.tooltip:setName(getText("IGUI_SearchMode_Tip_Tips_Tooltip_Title"));
				self.tooltip.description = getText("IGUI_SearchMode_Tip_Tips_Tooltip_Text");
			else
				if self.tipPanel:getIsVisible() then
					self.tooltip:setName(self.tipPanel.tip.title);
					self.tooltip.description = self.tipPanel.tip.text;
				else
					self.tooltip:setName(getText("IGUI_SearchMode_Zone_Names_"..self.currentZone));
					self.tooltip.description = self:getZoneTooltipText();
				end;
			end
		else
			if self.tooltip and self.tooltip:getIsVisible() then
				self.tooltip:setVisible(false);
				self.tooltip:removeFromUIManager();
			end;
		end;
	end;
end
-------------------------------------------------
-------------------------------------------------
function ISZoneDisplay:update()
	if (not self:getIsVisible()) then return; end;
	self:updateData();
	if self.timeOfDay < self.dawn or self.timeOfDay > self.dusk then
		local moonColor = math.max(self.moonBright, 0.5);
		self.moon:setColor(moonColor, moonColor, moonColor);
		self.sun:setAlphaTarget(0);
		self.moon:setAlphaTarget(1);
		self.stars:setAlphaTarget(0);
		self:updateMoonPosition(self.dawn, self.dusk, self.timeOfDay);
	else
		local sunColor = math.max(self.sunBright, 0.5);
		self.sun:setColor(1, 1, sunColor);
		self.sun:setAlphaTarget(1);
		self.moon:setAlphaTarget(0);
		self.stars:setAlphaTarget(0);
		self:updateSunPosition(self.dawn, self.dusk, self.timeOfDay);
	end;
	self:doFadeStep();
	self:updateLocation();
	self:updateTooltip();
	self:updateTips();
	self.updateTick = self.updateTick + 1;
	if self.updateTick % 5 == 0 then self.canSeeSky = self:canSeeOutside(); end;
	if self.updateTick % 30 == 0 then self.fogStep = ZombRand(3) + 1; end;
	if self.updateTick >= self.updateTickMax then self.updateTick = 0; end;
end
-------------------------------------------------
-------------------------------------------------
function ISZoneDisplay:isLeapYear(_yearNum)
	return (_yearNum % 4 == 0) and ((_yearNum % 400 == 0) or (_yearNum % 100 ~= 0));
end

function ISZoneDisplay:updateMoonPhase()
	local currentPhase = self.climateMoon:getCurrentMoonPhase() or 0;
	self.moon.texture = zdTex.moons["moon"..currentPhase];
end
-------------------------------------------------
-------------------------------------------------
function ISZoneDisplay:updateData()
	local gameTime = self.gameTime;
	local climateManager = self.climateManager;
	local season = climateManager:getSeason();
	self.timeOfDay = gameTime:getTimeOfDay();
	self.dawn = season:getDawn();
	self.noon = season:getDayHighNoon();
	self.dusk = season:getDusk();
	self.cloudIntensity = climateManager:getCloudIntensity();
	self.fogIntensity = climateManager:getFogIntensity() * 3;
	self.sunBright = climateManager:getDayLightStrength();
	self.moonBright = climateManager:getNightStrength();
	local globalLight = climateManager:getGlobalLight();
	local extLight = globalLight:getExterior();
	self.backgroundColor = {
		r = extLight:getRedFloat(),
		g = extLight:getGreenFloat(),
		b = extLight:getBlueFloat(),
		a = 1,
	};

	if self.fogStep == 1 then
		self.fog1:setAlphaTarget(math.min(self.fogIntensity, 0.75));
		self.fog2:setAlphaTarget(0);
		self.fog3:setAlphaTarget(0);
	elseif self.fogStep == 2 then
		self.fog1:setAlphaTarget(0);
		self.fog2:setAlphaTarget(math.min(self.fogIntensity, 0.75));
		self.fog3:setAlphaTarget(0);
	elseif self.fogStep == 3 then
		self.fog1:setAlphaTarget(0);
		self.fog2:setAlphaTarget(0);
		self.fog3:setAlphaTarget(math.min(self.fogIntensity, 0.75));
	end;
	self.clouds:setAlphaTarget(math.min(self.cloudIntensity * 3, 0.95));
	self.clouds:setGreyscale( math.max(1 - self.cloudIntensity, 0.1));
	self:updateMoonPhase();
	end
-------------------------------------------------
-------------------------------------------------
function ISZoneDisplay:initialise()
	ISPanel.initialise(self);
	for imageName, imageTex in pairs(zdTex.zone) do
		self[imageName] = zdImage:new(self,0, 0, self.width, self.height, imageTex);
		self[imageName]:initialise();
		self[imageName]:setAlpha(0);
		self[imageName]:setAlphaTarget(0);
		self:addChild(self[imageName]);
		self.zdImages[imageName] = self[imageName];
		self.fadeElements[imageName] = self[imageName];
	end;
	for imageName, imageTex in pairs(zdTex.world) do
		self[imageName] = zdImage:new(self,0, 0, 24, 24, imageTex);
		self[imageName]:initialise();
		self[imageName]:setAlpha(0);
		self[imageName]:setAlphaTarget(0);
		self:addChild(self[imageName]);
		self.zdImages[imageName] = self[imageName];
	end;
	for imageName, imageTex in pairs(zdTex.frame) do
		self[imageName] = zdImage:new(self,0, 0, self.width, self.height, imageTex);
		self[imageName]:initialise();
		self[imageName]:setAlpha(0);
		self[imageName]:setAlphaTarget(0);
		self:addChild(self[imageName]);
		self.zdImages[imageName] = self[imageName];
	end;
	self.frame:setAlpha(1);
	self.frame:setAlphaTarget(1);
	self.frame:setColor(0.4, 0.4, 0.4);
	--
	self.tipPanel = ISRichTextPanel:new(0, 0, self.width, self.height);
	self.tipPanel:initialise();
	self.tipPanel:instantiate();
	self.tipPanel.autosetheight = false;
	self.tipPanel:paginate();
	self.tipPanel.backgroundColor = {r = 0, g = 0, b = 0, a = 0.8}
	self.tipPanel:setVisible(false);
	self.tipPanel:setMargins(30, 10, 30, 10);
	self.tipPanel.clip = true;
	self:addChild(self.tipPanel);
	--
	self.prevBtn = ISButton:new(0, self:getHeight() - 20, 20, 20, "", self, self.showPrevTip);
	self.prevBtn:initialise();
	self.prevBtn:setImage(zdTex.prevBtn);
	self.tipPanel:addChild(self.prevBtn);
	--
	self.nextBtn = ISButton:new(self:getWidth() - 20, self:getHeight() - 20, 20, 20, "", self, self.showNextTip);
	self.nextBtn:initialise();
	self.nextBtn:setImage(zdTex.nextBtn);
	self.tipPanel:addChild(self.nextBtn);
	--
	local infoWidth = zdTex.infoBtn:getWidth() / 2;
	local infoHeight = zdTex.infoBtn:getHeight() / 2;
	self.infoBtn = ISButton:new(7, 10, infoWidth, infoHeight, "", self, self.toggleTips);
	self.infoBtn.displayBackground = false;
	self.infoBtn:setImage(zdTex.infoBtn);
	self.infoBtn:setTextureRGBA(0, 0, 0, 1);
	self:addChild(self.infoBtn);
	self.tipPanel:addChild(self.infoBtn);
	--
	local eyeWidth = zdTex.eyeconOn:getWidth() / 2;
	local eyeHeight = zdTex.eyeconOn:getHeight() / 2;
	self.visionBonuses = zdImage:new(self, self.width - eyeWidth - 7, 10, eyeWidth, eyeHeight, zdTex.eyeconOn);
	self.visionBonuses:setAlpha(0.7);
	self.visionBonuses:setAlphaTarget(0.7);
	self:addChild(self.visionBonuses);
	self.zdImages.visionBonuses = self.visionBonuses;
	--
	self.canSeeSky = self:canSeeOutside();
end
-------------------------------------------------
-------------------------------------------------
function ISZoneDisplay:close()    self:setVisible(false); self:removeFromUIManager();     end;

function ISZoneDisplay:new(_parent)
	local yPos			= _parent and _parent:titleBarHeight() + 2 or 20;
	--
	local o				= ISPanel:new(0, yPos, 100, 40);
	setmetatable(o, self);
	self.__index		= self;
	--

	o.x					= 0;
	o.y					= yPos;
	o.width				= 300;
	o.height			= 120;
	o.moveWithMouse		= false;

	o.showBackground	= true;
	o.showBorder		= true;
	o.backgroundColor	= {r=0.5, g=0.5, b=0.5, a=0.7};
	o.borderColor		= {r=0.4, g=0.4, b=0.4, a=0};
	o.alpha				= 1;

	o.zdImages			= {};
	o.fadeTarget		= "Unknown";
	o.fadeElements		= {};

	o.timeOfDay			= 0;
	o.dawn				= 0;
	o.noon				= 0;
	o.dusk				= 0;

	o.timeString		= "";
	o.moonPhase			= "";

	o.cloudIntensity	= 0;
	o.fogIntensity		= 0;
	o.sunBright			= 0;
	o.moonBright		= 0;

	o.canSeeSky			= false;
	o.updateTick		= 0;
	o.updateTickMax		= 100;
	o.fogStep			= 1;

	o.player			= _parent.player;
	o.character			= _parent.character;
	o.manager			= _parent.manager;
	o.gameTime			= getGameTime();
	o.climateManager	= getClimateManager();
	o.climateMoon		= getClimateMoon();

	o.currentZone		= "Unknown";

	o.currentTip		= 1;
	o.flashTipButton	= false;
	o.blinkStep			= 0;
	o.flashNumber		= 0;
	o.flashNumberMax	= 10;
	o.perkLevel			= o.character:getPerkLevel(Perks.PlantScavenging);

	o:initialise();

	return o;
end
-------------------------------------------------
-------------------------------------------------
function zdImage:initialise()         ISPanel.initialise(self);   end;
function zdImage:getAlpha()           return self.backgroundColor.a;    end;
function zdImage:getAlphaTarget()     return self.alphaTarget;          end;
function zdImage:setAlpha(_a)         self.backgroundColor.a = _a;      end;
function zdImage:setAlphaTarget(_a)   self.alphaTarget = _a;            end;
-------------------------------------------------
-------------------------------------------------
function zdImage:setGreyscale(_rgb)
	self.backgroundColor.r = _rgb;
	self.backgroundColor.g = _rgb;
	self.backgroundColor.b = _rgb;
end

function zdImage:setColor(_r,_g,_b)
	self.backgroundColor.r = _r;
	self.backgroundColor.g = _g;
	self.backgroundColor.b = _b;
end
-------------------------------------------------
-------------------------------------------------
function zdImage:update()
	if self:getAlpha() <= self.alphaTarget then self:setAlpha(math.min(self:getAlpha() + self.alphaStep, 1)); end;
	if self:getAlpha() >= self.alphaTarget then self:setAlpha(math.max(self:getAlpha() - self.alphaStep, 0)); end;
end

function zdImage:prerender() end;
function zdImage:render()
	local bgc = self.backgroundColor;
	self:drawTextureScaled(self.texture, 0, 0, self.width, self.height, bgc.a, bgc.r, bgc.g, bgc.b);
end
-------------------------------------------------
-------------------------------------------------
function zdImage:new(zoneDisplay, x, y, width, height, texture)
	local o = {};
	o = ISPanel:new(x, y, width, height);
	setmetatable(o, self);
	self.__index = self
	o:noBackground();
	o.x = x;
	o.y = y;
	o.zoneDisplay = zoneDisplay;
	o.texture = texture;
	o.backgroundColor = {r=1, g=1, b=1, a=1};
	o.borderColor = {r=1, g=1, b=1, a=0};
	o.width = width;
	o.height = height;
	o.alphaTarget = 1;
	o.alphaStep = 0.05;
	return o;
end
-------------------------------------------------
-------------------------------------------------
