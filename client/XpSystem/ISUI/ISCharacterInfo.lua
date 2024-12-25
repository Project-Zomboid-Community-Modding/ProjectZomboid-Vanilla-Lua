--***********************************************************
--**                    ROBERT JOHNSON                     **
--**              Panel wich display all our skills        **
--***********************************************************

require "ISUI/ISPanelJoypad"

ISCharacterInfo = ISPanelJoypad:derive("ISCharacterInfo");
ISCharacterInfo.timerMultiplierAnim = 0;
local UI_BORDER_SPACING = 10;
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local BUTTON_HGT = FONT_HGT_SMALL + 6
local SCROLL_BAR_WIDTH = 13

--************************************************************************--
--** ISPanel:initialise
--**
--************************************************************************--

function ISCharacterInfo:initialise()
	ISPanelJoypad.initialise(self);
end

function ISCharacterInfo:createChildren()
	self:setScrollChildren(true)
	self:addScrollBars()

	self.sorted = {}
	self.nameToPerk = {}
	self.buttonList = {}
	self.collapse = {}
	for k,v in pairs(self.perks) do
		local parentPerk = PerkFactory.getPerk(k)
		table.insert(self.sorted, parentPerk)
		self.nameToPerk[parentPerk:getName()] = k
	end

	table.sort(self.sorted, function(a,b)
		if a:isPassiv() then
			local dbg = 1
		end
		if a:isPassiv() and not b:isPassiv() then
			return true
		end
		if b:isPassiv() and not a:isPassiv() then
			return false
		end
		return not string.sort(a:getName(), b:getName())
	end)

	for i,_ in ipairs(self.sorted) do
		table.insert(self.collapse, false)
		local collapseButton = ISButton:new(UI_BORDER_SPACING+1, 0, BUTTON_HGT, BUTTON_HGT, "", self, ISCharacterInfo.collapseSection);
		collapseButton.internal = "COLLAPSE"..i
		collapseButton:setImage(getTexture("media/ui/inventoryPanes/Button_TreeExpanded.png"))
		table.insert(self.buttonList, collapseButton)
		collapseButton:initialise();
		self:addChild(collapseButton);
	end

	--for i,parentPerk in ipairs(self.sorted) do
	--	local perkList = self.perks[parentPerk:getType()]
	--	for ind, perk in ipairs(perkList) do
	--
	--	end
	--end

end

function ISCharacterInfo:setVisible(visible)
--    self.parent:setVisible(visible);
    self.javaObject:setVisible(visible);
    for i,v in pairs(self.progressBars) do
        if v.tooltip then
            v.tooltip:setVisible(false);
            v.tooltip:removeFromUIManager();
            v.tooltip = nil;
        end
    end
end

function ISCharacterInfo:prerender()
	ISPanelJoypad.prerender(self)
	self:setStencilRect(0, 0, self.width, self.height)
end

function ISCharacterInfo:render()
	local y = UI_BORDER_SPACING

	if self.lastLevelUpTime > 0 then
		self.lastLevelUpTime = self.lastLevelUpTime - 0.0025
	elseif self.lastLevelUpTime < 0 then
		self.lastLevelUpTime = 0
	end

	ISSkillProgressBar.updateAlpha() -- FIXME: do this once per frame, not for each player
	-- how much skills pts we got ?
	if self.reloadSkillBar then
		self.progressBarLoaded = false;
		self.reloadSkillBar = false;
		for i,v in pairs(self.progressBars) do
			self:removeChild(v);
		end
		self.progressBars = {}

	end

	local top = y

	-- if we got a multiplier, we gonna anim that with ">, >>, >>>"
	 -- FIXME: do this once per frame, not for each player
	local ms = UIManager.getMillisSinceLastRender()
	ISCharacterInfo.timerMultiplierAnim = ISCharacterInfo.timerMultiplierAnim + ms;
	if ISCharacterInfo.timerMultiplierAnim <= 500 then
        ISCharacterInfo.animOffset = -1;
	elseif ISCharacterInfo.timerMultiplierAnim <= 1000 then
        ISCharacterInfo.animOffset = 0;
	elseif ISCharacterInfo.timerMultiplierAnim <= 1500 then
        ISCharacterInfo.animOffset = 15;
	elseif ISCharacterInfo.timerMultiplierAnim <= 2000 then
        ISCharacterInfo.animOffset = 30;
	else
		ISCharacterInfo.timerMultiplierAnim = 0;
	end

	local left = UI_BORDER_SPACING*2+BUTTON_HGT+1
	local maxY = y
	local fontOffset = (BUTTON_HGT-FONT_HGT_SMALL)/2
	local rowHgt = BUTTON_HGT
	for i,parentPerk in ipairs(self.sorted) do
		local perkList = self.perks[parentPerk:getType()]
		-- we first draw our parent name
		self:drawText(parentPerk:getName(), left, y+fontOffset, 1, 1, 1, 1, UIFont.Small);
		self.buttonList[i]:setY(y)
		y = y + math.max(BUTTON_HGT);
		-- then all the skills with their progress bar
		if not self.collapse[i] then
			self:drawTexture(self.SkillBarSeparator, 0, y + UI_BORDER_SPACING, 1,1,1,1);
			y = y + UI_BORDER_SPACING
			for ind, perk in ipairs(perkList) do
				local xpBoost = self.char:getXp():getPerkBoost(perk:getType());
				local r = 1;
				local g = 1;
				local b = 1;
				if xpBoost == 0 then
					r = 0.54;
					g = 0.54;
					b = 0.54;
				elseif xpBoost == 1 then
					r = 0.8;
					g = 0.8;
					b = 0.8;
				elseif xpBoost == 3 then
					r = 1;
					g = 0.83;
					b = 0;
				end
				self:drawText(perk:getName(), left + UI_BORDER_SPACING*2, y+fontOffset, r, g, b, 1, UIFont.Small);
				--todo add tooltips to the skill titles
				-- if we got a multiplier, we gonna anim that with ">, >>, >>>"
				if self.char:getXp():getMultiplier(perk:getType()) > 0 then
					--for some reason, the experience boost arrows are offset in X and Y by +2 pixels. I have no explanation why. ~Fox
					local arrowPixelOffset = 2

					local arrowHeight = self.arrow:getHeight()
					local arrowOffset = math.floor((BUTTON_HGT-arrowHeight)/2)-arrowPixelOffset
					self:drawTexture(self.disabledArrow, UI_BORDER_SPACING+1-arrowPixelOffset, y+arrowOffset, 1, 1, 1, 1);
					self:drawTexture(self.disabledArrow, UI_BORDER_SPACING+1+15-arrowPixelOffset, y+arrowOffset, 1, 1, 1, 1);
					self:drawTexture(self.disabledArrow, UI_BORDER_SPACING+1+30-arrowPixelOffset, y+arrowOffset, 1, 1, 1, 1);

					if ISCharacterInfo.animOffset > -1 then
						self:drawTexture(self.arrow, UI_BORDER_SPACING+1 + ISCharacterInfo.animOffset - arrowPixelOffset, y+arrowOffset, 1, 1, 1, 1);
					end
				end
				if not self.progressBarLoaded then
					local skillPointSize = math.floor((FONT_HGT_SMALL + 6)/2)
					local skillPointOffset = (BUTTON_HGT-skillPointSize)/2
					local progressBar = ISSkillProgressBar:new(left + UI_BORDER_SPACING*3 + self.txtLen, y+skillPointOffset, 0, 0, self.playerNum, perk, self);
					progressBar:initialise();

					self:addChild(progressBar);
					table.insert(self.progressBars, progressBar);
				end
				y = y + rowHgt;
			end
		end
		y = y + UI_BORDER_SPACING;
		maxY = math.max(maxY, y)
	end
	y = y + 1;

--~ 	self:drawText("Strong : " .. getPlayer():getPerkLevel(Perks.Strength), self.x + 8, y, 1, 1, 1, 1, UIFont.Small);
--~ 	for i = 0, getPlayer():getTraits():size() - 1 do
--~ 		local v = getPlayer():getTraits():get(i);
--~ 		self:drawText("Trait : " .. v, self.x + 8, y, 1, 1, 1, 1, UIFont.Small);
--~ 		y = y + 20;
--~ 	end
--~ 	self:drawText("Hauling : " .. getPlayer():getXp():getXP(Perks.Hauling), self.x + 8, y, 1, 1, 1, 1, UIFont.Small);

	local skillPointSize = math.floor((FONT_HGT_SMALL + 6)/2)
	local skillPointSpacing = getCore():getOptionFontSizeReal()

	self:setWidthAndParentWidth(math.max(self.width, left + UI_BORDER_SPACING*4 + self.txtLen + skillPointSize*10 + skillPointSpacing*9 + SCROLL_BAR_WIDTH + 1));
	self:setHeightAndParentHeight(math.min(y, 800));

	self:setScrollHeight(y)

	self.progressBarLoaded = true;

	if self.joyfocus then
		if self.joypadIndex and self.joypadIndex >= 1 and self.joypadIndex <= #self.progressBars then
			local bar = self.progressBars[self.joypadIndex]
			local left = bar:getX() - (self.txtLen + 45)
			local right = bar:getX() + bar:getWidth()
			self:drawRectBorder(left-2, bar:getY()-2, (right - left) + 2, bar:getHeight() + 3, 0.4, 0.2, 1.0, 1.0);
			if bar.tooltip then
				bar.tooltip.followMouse = false
				bar.tooltip:setX(bar:getAbsoluteX())
				local tty = bar:getAbsoluteY() + bar:getHeight() + 1
				if tty + bar.tooltip:getHeight() > getCore():getScreenHeight() then
					tty = bar:getAbsoluteY() - bar.tooltip:getHeight() - 1
				end
				bar.tooltip:setY(tty)
			end
		end
	end

	self:clearStencilRect()
end

function ISCharacterInfo:onMouseWheel(del)
	self:setYScroll(self:getYScroll() - del * 30)
	return true
end

function ISCharacterInfo:collapseSection(button)
	local section
	if string.contains(button.internal, "COLLAPSE") then
		section = tonumber(string.sub(button.internal, 9))
	end

	self.collapse[section] = not self.collapse[section]
	if self.collapse[section] then
		self.buttonList[section]:setImage(getTexture("media/ui/inventoryPanes/Button_TreeCollapsed.png"))
	else
		self.buttonList[section]:setImage(getTexture("media/ui/inventoryPanes/Button_TreeExpanded.png"))
	end
	self.reloadSkillBar = true
end

function ISCharacterInfo:new (x, y, width, height, playerNum)
	local o = {};
	o = ISPanelJoypad:new(x, y, width, height);
	setmetatable(o, self);
    self.__index = self;
    o.progressBars = {}
	o.progressBarLoaded = false;
	o.playerNum = playerNum
	o.char = getSpecificPlayer(playerNum);
	o:noBackground();
	o.txtLen = 0;
	o.perks = ISCharacterInfo.loadPerk(o);
	o.lastLeveledUpPerk = nil;
	o.lastLevelUpTime = 0;
    o.arrow = getTexture("media/ui/ArrowRight.png");
    o.arrowLeft = getTexture("media/ui/ArrowLeft.png");
    o.yButton = Joypad.Texture.YButton;
    o.disabledArrow = getTexture("media/ui/ArrowRight_Disabled.png");
    o.SkillPtsProgressBarEmpty = getTexture("media/ui/XpSystemUI/SkillPtsProgressBarEmpty.png")
    o.SkillPtsProgressBarStart = getTexture("media/ui/XpSystemUI/SkillPtsProgressBarStart.png")
    o.SkillPtsProgressBar = getTexture("media/ui/XpSystemUI/SkillPtsProgressBar.png")
    o.SkillBarSeparator = getTexture("media/ui/XpSystemUI/SkillBarSeparator.png")
    o.ProgressSkilMultiplier = getTexture("media/ui/XpSystemUI/ProgressSkilMultiplier.png")
    o.showingPassive = false
    ISCharacterInfo.instance = o;
   return o;
end

ISCharacterInfo.loadPerk = function(self)
	local perks = {};
	-- we start to fetch all our perks
	for i = 0, PerkFactory.PerkList:size() - 1 do
		local perk = PerkFactory.PerkList:get(i);
		-- we only add in our list the child perk
		-- here we just display the active skill, not the passive ones (they are in another tab)
		if perk:getParent() ~= Perks.None then
			-- we take the longest skill's name as width reference
			local pixLen = getTextManager():MeasureStringX(UIFont.Small, perk:getName());
			if pixLen > self.txtLen then
				self.txtLen = pixLen;
			end
			if not perks[perk:getParent()] then
				perks[perk:getParent()] = {};
			end
			table.insert(perks[perk:getParent()], perk);
		end
	end
	return perks
end

function ISCharacterInfo:ensureVisible()
	if not self.joyfocus then return end
	local child = self.progressBars[self.joypadIndex]
	if not child then return end
	local y = child:getY()
	if y - 40 < 0 - self:getYScroll() then
		self:setYScroll(0 - y + 40)
	elseif y + child:getHeight() + 40 > 0 - self:getYScroll() + self:getHeight() then
		self:setYScroll(0 - (y + child:getHeight() + 40 - self:getHeight()))
	end
end

function ISCharacterInfo:updateTooltipForJoypad()
	if self.joypadIndex and self.joypadIndex >= 1 and self.joypadIndex <= #self.progressBars then
		if self.barWithTooltip then
			self.barWithTooltip:onMouseMoveOutside()
		end
		self.barWithTooltip = self.progressBars[self.joypadIndex]
		self.barWithTooltip:updateTooltip(self.barWithTooltip.level)
	elseif self.barWithTooltip then
		self.barWithTooltip:onMouseMoveOutside()
		self.barWithTooltip = nil
	end
end

function ISCharacterInfo:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData);
	self.joypadIndex = nil
	self.barWithTooltip = nil
end

function ISCharacterInfo:onLoseJoypadFocus(joypadData)
    ISPanelJoypad.onLoseJoypadFocus(self, joypadData);
end

function ISCharacterInfo:onJoypadDown(button)
	if button == Joypad.AButton then
		if self.joypadIndex and self.joypadIndex >= 1 and self.joypadIndex <= #self.progressBars then
			self.progressBars[self.joypadIndex]:activate()
		end
	end
	if button == Joypad.YButton then
	end
	if button == Joypad.BButton then
		getPlayerInfoPanel(self.playerNum):toggleView(xpSystemText.skills)
		setJoypadFocus(self.playerNum, nil)
	end
	if button == Joypad.LBumper then
		getPlayerInfoPanel(self.playerNum):onJoypadDown(button)
	end
	if button == Joypad.RBumper then
		getPlayerInfoPanel(self.playerNum):onJoypadDown(button)
	end
end

function ISCharacterInfo:onJoypadDirUp()
	if not self.joypadIndex or self.joypadIndex == 1 then
		self.joypadIndex = #self.progressBars
	else
		self.joypadIndex = self.joypadIndex - 1
	end
	self:ensureVisible()
	self:updateTooltipForJoypad()
end

function ISCharacterInfo:onJoypadDirDown()
	if not self.joypadIndex or self.joypadIndex == #self.progressBars then
		self.joypadIndex = 1
	else
		self.joypadIndex = self.joypadIndex + 1
	end
	self:ensureVisible()
	self:updateTooltipForJoypad()
end

function ISCharacterInfo:onJoypadDirLeft()
end

function ISCharacterInfo:onJoypadDirRight()
end

function ISCharacterInfo.onResolutionChange(oldw, oldh, neww, newh)
	if getPlayer() == nil then return end -- back in main menu
	for pn=0,getNumActivePlayers()-1 do
		if getPlayerData(pn) then
			local charInfo = getPlayerInfoPanel(pn).characterView
			if charInfo and charInfo.progressBarLoaded then
				charInfo.progressBarLoaded = false;
				for i,v in pairs(charInfo.progressBars) do
					charInfo:removeChild(v);
				end
				charInfo.progressBars = {};
			end
		end
	end
end

Events.OnResolutionChange.Add(ISCharacterInfo.onResolutionChange)

