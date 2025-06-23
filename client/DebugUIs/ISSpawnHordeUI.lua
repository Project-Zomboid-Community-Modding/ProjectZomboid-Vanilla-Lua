require "ISUI/ISPanelJoypad"

ISSpawnHordeUI = ISCollapsableWindow:derive("ISSpawnHordeUI");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local FONT_HGT_LARGE = getTextManager():getFontHeight(UIFont.NewLarge)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

function ISSpawnHordeUI:createChildren()
	local x = UI_BORDER_SPACING+1
	local btnWid = 100
	local y = self:titleBarHeight() + UI_BORDER_SPACING
	
	ISCollapsableWindow.createChildren(self)

	local pickedSquareText = getText("IGUI_SpawnHorde_PickedSquare") .. ": " .. self.selectX .. ", " .. self.selectY .. ", " .. self.selectZ

	self.pickedSquareLabel = ISLabel:new(x, y, BUTTON_HGT, pickedSquareText ,1,1,1,1,UIFont.Small, true);
	self:addChild(self.pickedSquareLabel);

	self.pickNewSq = ISButton:new(self.pickedSquareLabel:getRight() + UI_BORDER_SPACING, y, btnWid, BUTTON_HGT, getText("IGUI_SpawnHorde_PickNewSquare"), self, ISSpawnHordeUI.onSelectNewSquare);
	self.pickNewSq:initialise();
	self.pickNewSq:instantiate();
	self.pickNewSq.borderColor = {r=1, g=1, b=1, a=0.1};
	self:addChild(self.pickNewSq);

	local farX = self.pickNewSq:getRight()
	y = y + BUTTON_HGT + UI_BORDER_SPACING
	
	self.zombiesNbrLabel = ISLabel:new(x, y, BUTTON_HGT, getText("IGUI_SpawnHorde_ZombieNumber")..": " ,1,1,1,1,UIFont.Small, true);
	self:addChild(self.zombiesNbrLabel);

	self.zombiesNbr = ISTextEntryBox:new("1", self.zombiesNbrLabel:getRight() + UI_BORDER_SPACING, y, 100, BUTTON_HGT);
	self.zombiesNbr:initialise();
	self.zombiesNbr:instantiate();
	self.zombiesNbr:setOnlyNumbers(true);
	self:addChild(self.zombiesNbr);
	farX = math.max(farX, self.zombiesNbr:getRight())
	y = y + BUTTON_HGT + UI_BORDER_SPACING
	
	self.radiusLbl = ISLabel:new(x, y, BUTTON_HGT, getText("IGUI_SpawnHorde_Radius")..": " ,1,1,1,1,UIFont.Small, true);
	self:addChild(self.radiusLbl);
	
	self.radius = ISTextEntryBox:new("1", self.radiusLbl:getRight()+UI_BORDER_SPACING, y, 100, BUTTON_HGT);
	self.radius:initialise();
	self.radius:instantiate();
	self.radius:setOnlyNumbers(true);
	self:addChild(self.radius);

	farX = math.max(farX, self.radius:getRight())
	y = y + BUTTON_HGT + UI_BORDER_SPACING
	
	self.outfitLbl = ISLabel:new(x, y, BUTTON_HGT, getText("IGUI_SpawnHorde_ZombieOutfit")..": " ,1,1,1,1,UIFont.Small, true);
	self:addChild(self.outfitLbl);

--	self.outfit = ISTextEntryBox:new("", self.outfitLbl.x, self.outfitLbl.y + 15, 100, 20);
--	self.outfit:initialise();
--	self.outfit:instantiate();
--	self.outfit:setClearButton(true);
--	self:addChild(self.outfit);
	
	self.outfit = ISComboBox:new(self.outfitLbl:getRight() + UI_BORDER_SPACING, y, 200, BUTTON_HGT)
	self.outfit:initialise()
	self:addChild(self.outfit)
	self.outfit:setEditable(true)
	self.maleOutfits = getAllOutfits(false);
	self.femaleOutfits = getAllOutfits(true);
	self.outfit:addOptionWithData(getText("IGUI_None"), nil);
	for i=0, self.maleOutfits:size()-1 do
		local text = "";
		if not self.femaleOutfits:contains(self.maleOutfits:get(i)) then
			text = " - " .. getText("IGUI_SpawnHorde_MaleOnly");
		end
		self.outfit:addOptionWithData(self.maleOutfits:get(i) .. text, self.maleOutfits:get(i));
	end
	for i=0, self.femaleOutfits:size()-1 do
		if not self.maleOutfits:contains(self.femaleOutfits:get(i)) then
			self.outfit:addOptionWithData(self.femaleOutfits:get(i) .. " - " .. getText("IGUI_SpawnHorde_FemaleOnly"), self.femaleOutfits:get(i));
		end
	end

	farX = math.max(farX, self.outfit:getRight())
	y = y + BUTTON_HGT + UI_BORDER_SPACING
	
	--self.crawlerLbl = ISLabel:new(10, y, 10, "Crawler" ,1,1,1,1,UIFont.Small, true);
	--self:addChild(self.crawlerLbl);
	
	self.boolOptions = ISTickBox:new(x, y, 200, BUTTON_HGT, "", self, ISSpawnHordeUI.onBoolOptionsChange);
	self.boolOptions:initialise()
	self:addChild(self.boolOptions)
	self.boolOptions:addOption(getText("IGUI_SpawnHorde_KnockedDown"));
	self.boolOptions:addOption(getText("IGUI_SpawnHorde_Crawler"));
	self.boolOptions:addOption(getText("IGUI_SpawnHorde_FakeDead"));
	self.boolOptions:addOption(getText("IGUI_SpawnHorde_FallOnFront"));
	self.boolOptions:addOption(getText("IGUI_SpawnHorde_Invulnerable"));
	self.boolOptions:addOption(getText("IGUI_SpawnHorde_Sitting"));
	self.boolOptions:addOption(getText("IGUI_SpawnHorde_Recording"));

	y=y+self.boolOptions:getHeight()+UI_BORDER_SPACING

	self.healthSliderTitle = ISDebugUtils.addLabelNoReturnOffset(self,"Health",x,y,getText("IGUI_SpawnHorde_Health")..": ", UIFont.Small, true);
	self.healthSliderLabel = ISDebugUtils.addLabelNoReturnOffset(self,"Health",self.healthSliderTitle:getRight() + UI_BORDER_SPACING + BUTTON_HGT,y,"1", UIFont.Small, false);
	self.healthSlider = ISDebugUtils.addSliderNoReturnOffset(self, "health", self.healthSliderLabel:getRight() + UI_BORDER_SPACING, y, 200, BUTTON_HGT, ISSpawnHordeUI.onSliderChange);
	self.healthSlider.pretext = "Health: ";
	self.healthSlider.valueLabel = self.healthSliderLabel;
	self.healthSlider:setValues(0, 2, 0.1, 0.1, true);
	self.healthSlider.currentValue = 1.0;

	farX = math.max(farX, self.healthSlider:getRight())
	y = y + BUTTON_HGT + UI_BORDER_SPACING

	local buttonWid = UI_BORDER_SPACING*2 + math.max(
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_StashDebug_Spawn")),
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_DebugMenu_Close")),
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_SpawnHorde_RemoveZombies")),
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_SpawnHorde_RemoveBodies"))
	)

	farX = math.max(farX, buttonWid*2 + UI_BORDER_SPACING*2)
	self:setWidth(farX + x)
	y = self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT - 1

	self.add = ISButton:new(x, y, buttonWid, BUTTON_HGT, getText("IGUI_StashDebug_Spawn"), self, ISSpawnHordeUI.onSpawn);
	self.add.anchorTop = false
	self.add.anchorBottom = true
	self.add:initialise();
	self.add:instantiate();
	self.add.borderColor = {r=1, g=1, b=1, a=0.1};
	self:addChild(self.add);

	self.closeButton2 = ISButton:new(self.width - buttonWid - x, self.add.y, buttonWid, BUTTON_HGT, getText("IGUI_DebugMenu_Close"), self, ISSpawnHordeUI.close);
	self.closeButton2.anchorTop = false
	self.closeButton2.anchorBottom = true
	self.closeButton2:initialise();
	self.closeButton2:instantiate();
	self.closeButton2:enableCancelColor()
	self:addChild(self.closeButton2);

	self.removezombies = ISButton:new(self.add.x, self.add.y - BUTTON_HGT - UI_BORDER_SPACING, buttonWid, BUTTON_HGT, getText("IGUI_SpawnHorde_RemoveZombies"), self, ISSpawnHordeUI.onRemoveZombies);
	self.removezombies.anchorTop = false
	self.removezombies.anchorBottom = true
	self.removezombies:initialise();
	self.removezombies:instantiate();
	self.removezombies.borderColor = {r=1, g=1, b=1, a=0.1};
	self:addChild(self.removezombies);

	self.clearbodies = ISButton:new(self.closeButton2.x, self.removezombies.y, buttonWid, BUTTON_HGT, getText("IGUI_SpawnHorde_RemoveBodies"), self, ISSpawnHordeUI.onRemoveBodies);
	self.clearbodies.anchorTop = false
	self.clearbodies.anchorBottom = true
	self.clearbodies:initialise();
	self.clearbodies:instantiate();
	self.clearbodies.borderColor = {r=1, g=1, b=1, a=0.1};
	self:addChild(self.clearbodies);

	self:setHeight(self.healthSlider:getBottom() + BUTTON_HGT*2 + UI_BORDER_SPACING*3+1)
end

function ISSpawnHordeUI:onBoolOptionsChange(index, selected)
	if index == 1 then
		if not selected then
			self.boolOptions.selected[2] = false
			self.boolOptions.selected[3] = false
		end
	end
	if index == 2 then
		self.boolOptions.selected[1] = selected
		if selected then
			self.boolOptions.selected[4] = true
		end
	end
	if index == 3 then
		self.boolOptions.selected[1] = selected
	end
	if index == 4 then
		if not selected then
			self.boolOptions.selected[2] = false
		end
	end
end

function ISSpawnHordeUI:onSliderChange(_newval, _slider)
	if _slider.valueLabel then
		_slider.valueLabel:setName(ISDebugUtils.printval(_newval,3));
	end
end

--function ISSpawnHordeUI:update()
--	ISCollapsableWindow.update(self);
--end

function ISSpawnHordeUI:getRadius()
	local radius = self.radius:getInternalText();
	return (tonumber(radius) or 1) - 1;
end

function ISSpawnHordeUI:onSpawn()
	local count = self:getZombiesNumber()
	local radius = self:getRadius();
	local outfit = self:getOutfit();
	-- force female or male chance if you've selected a outfit that's only for male or female
	local femaleChance = nil;
	local knockedDown = false;
	local crawler = false;
	local isFallOnFront = false;
	local isFakeDead = false;
	local isInvulnerable = false;
	local isSitting = false;
	local isRecordingAnims = false;
	if self.maleOutfits:contains(outfit) and not self.femaleOutfits:contains(outfit) then
		femaleChance = 0;
	end
	if self.femaleOutfits:contains(outfit) and not self.maleOutfits:contains(outfit) then
		femaleChance = 100;
	end
	if self.boolOptions.selected[1] then
		knockedDown = true;
	end
	if self.boolOptions.selected[2] then
		crawler = true;
	end
	if self.boolOptions.selected[3] then
		isFakeDead = true;
	end
	if self.boolOptions.selected[4] then
		isFallOnFront = true;
	end
	if self.boolOptions.selected[5] then
		isInvulnerable = true;
	end
	if self.boolOptions.selected[6] then
		isSitting = true;
	end
	if self.boolOptions.selected[7] then
		isRecordingAnims = true;
	end

	local health = self.healthSlider:getCurrentValue()
	if isClient() then
		SendCommandToServer(string.format("/createhorde2 -x %d -y %d -z %d -count %d -radius %d -crawler %s -isFallOnFront %s -isFakeDead %s -knockedDown %s -isInvulnerable %s -health %s -outfit %s ", self.selectX, self.selectY, self.selectZ, count, radius, tostring(crawler), tostring(isFallOnFront), tostring(isFakeDead), tostring(knockedDown), tostring(isInvulnerable), tostring(health), outfit or ""))
		return
	end
	for i=1,count do
		local x = ZombRand(self.selectX-radius, self.selectX+radius+1);
		local y = ZombRand(self.selectY-radius, self.selectY+radius+1);
		addZombiesInOutfit(x, y, self.selectZ, 1, outfit, femaleChance, crawler, isFallOnFront, isFakeDead, knockedDown, isInvulnerable, isSitting, health, isRecordingAnims);
	end
end

function ISSpawnHordeUI:getZombiesNumber()
	local nbr = self.zombiesNbr:getInternalText();
	nbr = tonumber(nbr);

	if not nbr then
		return 1;
	end

	if nbr < 1 then
		return 1;
	end

	if nbr > 500 then
	    print("No more than 500 zombies can be spawned at a time to prevent crashing servers etc.")
	    nbr = 500;
	end

	return nbr;
end

function ISSpawnHordeUI:getOutfit()
	return self.outfit.options[self.outfit.selected].data;
end

function ISSpawnHordeUI:onRemoveZombies()
	local radius = self:getRadius() + 1;
	if isClient() then
		SendCommandToServer(string.format("/removezombies -x %d -y %d -z %d -radius %d", self.selectX, self.selectY, self.selectZ, radius))
		return
	end
	for x=self.selectX-radius, self.selectX + radius do
		for y=self.selectY-radius, self.selectY + radius do
			local sq = getCell():getGridSquare(x,y,self.selectZ);
			if sq then
				for i=sq:getMovingObjects():size(),1,-1 do
					local testZed = sq:getMovingObjects():get(i-1);
					if instanceof(testZed, "IsoZombie") then
						testZed:removeFromWorld();
						testZed:removeFromSquare();
					end
				end
			end
		end
	end
end

function ISSpawnHordeUI:onRemoveBodies()
	local radius = self:getRadius() + 1;
	if isClient() then
		SendCommandToServer(string.format("/removezombies -x %d -y %d -z %d -radius %d -clear true", self.selectX, self.selectY, self.selectZ, radius))
	else
		local cell = getCell()
		for x = self.selectX - radius, self.selectX + radius+1 do
			for y = self.selectY - radius, self.selectY + radius+1 do
				if IsoUtils.DistanceTo(self.selectX, self.selectY, x+0.5, y+0.5) <= radius then
					local sq = cell:getGridSquare(x, y, self.selectZ)
					local bodies = {}
					for i=0, sq:getStaticMovingObjects():size()-1 do
						if instanceof(sq:getStaticMovingObjects():get(i), "IsoDeadBody") then
							table.insert(bodies, sq:getStaticMovingObjects():get(i))
						end
					end
					for i, body in ipairs(bodies) do
						sq:removeCorpse(body, false);
					end
				end
			end
		end
	end
end

function ISSpawnHordeUI:onSelectNewSquare()
	self.cursor = ISSelectCursor:new(self.chr, self, self.onSquareSelected)
	getCell():setDrag(self.cursor, self.chr:getPlayerNum())
end

function ISSpawnHordeUI:onSquareSelected(square)
	self.cursor = nil;
	self:removeMarker();
	self.selectX = square:getX();
	self.selectY = square:getY();
	self.selectZ = square:getZ();
	self:addMarker(square, self:getRadius() + 1);
end

function ISSpawnHordeUI:prerender()
	ISCollapsableWindow.prerender(self);
	local radius = (self:getRadius() + 1);
	if self.marker and (self.marker:getSize() ~= radius) then
		self.marker:setSize(radius)
	end
end

function ISSpawnHordeUI:render()
	ISCollapsableWindow.render(self);
end

function ISSpawnHordeUI:addMarker(square, radius)
	self.marker = getWorldMarkers():addGridSquareMarker(square, 0.8, 0.8, 0.0, true, radius);
	self.marker:setScaleCircleTexture(true);
	local texName = nil; -- use default
	self.arrow = getWorldMarkers():addDirectionArrow(self.chr, self.selectX, self.selectY, self.selectZ, texName, 1.0, 1.0, 1.0, 1.0);
end

function ISSpawnHordeUI:removeMarker()
	if self.marker then
		self.marker:remove();
		self.marker = nil;
	end
	if self.arrow then
		self.arrow:remove();
		self.arrow = nil;
	end
end

function ISSpawnHordeUI:close()
	self:removeMarker();
	self:setVisible(false);
	self:removeFromUIManager();
end

--************************************************************************--
--** ISSpawnHordeUI:new
--**
--************************************************************************--
function ISSpawnHordeUI:new(x, y, character, square)
	local width = 1000;
	local height = 1000;
	local o = ISCollapsableWindow.new(self, x, y, width, height);
	o.playerNum = character:getPlayerNum()
	if y == 0 then
		o.y = getPlayerScreenTop(o.playerNum) + (getPlayerScreenHeight(o.playerNum) - height) / 2
		o:setY(o.y)
	end
	if x == 0 then
		o.x = getPlayerScreenLeft(o.playerNum) + (getPlayerScreenWidth(o.playerNum) - width) / 2
		o:setX(o.x)
	end
	o.width = width;
	o.height = height;
	o.title = getText("IGUI_DebugContext_HordeManager");
	o.chr = character;
	o.moveWithMouse = true;
	o:setResizable(false);
	o.selectX = square:getX();
	o.selectY = square:getY();
	o.selectZ = square:getZ();
	o.anchorLeft = true;
	o.anchorRight = true;
	o.anchorTop = true;
	o.anchorBottom = true;
	o:addMarker(square, 1);
	return o;
end
