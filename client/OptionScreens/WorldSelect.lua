--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISScrollingListBox"

WorldSelect = ISPanelJoypad:derive("WorldSelect")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_TITLE = getTextManager():getFontHeight(UIFont.Title)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local JOYPAD_TEX_SIZE = 32
local startY = UI_BORDER_SPACING*2+1 + FONT_HGT_TITLE;
local firstGeneration = true

function WorldSelect:initialise()
	ISPanelJoypad.initialise(self)
end

function WorldSelect:hasChoices()
	if isClient() then return false end
	self.mapGroups:createGroups()
	return self.mapGroups:getNumberOfGroups() > 1
end

function WorldSelect:fillList()
	self.listbox:clear()
	for i=1,self.mapGroups:getNumberOfGroups() do
		local ignore = false
		local item = {}
		-- TODO: if only vanilla maps, set item.name = "Kentucky, USA"
		item.name = getText("UI_WorldSelect_WorldN", i)
		item.world = i
		item.mapDirs = self.mapGroups:getMapDirectoriesInGroup(i-1)
		if item.mapDirs:size() == 1 then
			local mapDir = item.mapDirs:get(0)
			local info = getMapInfo(mapDir)
			if info and info.title then
				item.name = info.title
			else
				item.name = mapDir
			end
		end
		if IgnoredMap then
			for i,mapName in ipairs(IgnoredMap) do
				if mapName == item.name then
					print("ignoring", item.name)
					ignore = true;
				end
			end
		end
		if not ignore then
			self.listbox:addItem(item.name, item)
		end

	end
	self:onSelectWorld()
end

function WorldSelect:onSelectWorld()
	self.mapListbox:clear()
	local mapDirs = self.listbox.items[self.listbox.selected].item.mapDirs
	for i=1,mapDirs:size() do
		local ignore = false
		local mapDir = mapDirs:get(i-1)
		local item = {}
		local info = getMapInfo(mapDir)
		if info and info.title then
			item.name = info.title
		else
			item.name = mapDir
		end
		if IgnoredMap then
			for i,mapName in ipairs(IgnoredMap) do
				if mapName == item.name then
					print("ignoring", item.name)
					ignore = true;
				end
			end
		end
		if not ignore then
			self.mapListbox:addItem(item.name, item)
		end
	end
	self.mapListbox:sort()
end

function WorldSelect:onOptionMouseDown(button, x, y)
	if button.internal == "BACK" then
		self:setVisible(false)
		self:clickBack()
	elseif button.internal == "NEXT" then
		self:setVisible(false)
		self:clickNext()
	elseif button.internal == "ADVANCED" then
		self:clickAdvanced()
	end
end

function WorldSelect:onDblClick()
	self:clickNext()
end

function WorldSelect:clickBack()
	if getWorld():getGameMode() == "Multiplayer" then
		backToSinglePlayer()
		getCore():ResetLua("default", "exitJoinServer")
	elseif self.previousScreen == "LoadGameScreen" then
		MainScreen.resetLuaIfNeeded()
		self.previousScreen = nil
		LoadGameScreen.instance:setSaveGamesList()
		MainScreen.instance.loadScreen:setVisible(true, self.joyfocus)
	elseif self.previousScreen == "NewGameScreen" then
		self.previousScreen = nil
		MainScreen.instance.soloScreen:setVisible(true, self.joyfocus)
	end
end

function WorldSelect:clickNext()
	self:setVisible(false)
	self.mapGroups:setWorld(self.listbox.selected-1)
	self:saveGenParams()

	if MainScreen.instance.createWorld or MapSpawnSelect.instance:hasChoices() then
		MapSpawnSelect.instance:fillList()
		MapSpawnSelect.instance.previousScreen = "WorldSelect"
		MapSpawnSelect.instance:setVisible(true, self.joyfocus)
	elseif getWorld():getGameMode() == "Sandbox" then
		MapSpawnSelect.instance:useDefaultSpawnRegion()
		MainScreen.instance.sandOptions:setVisible(true, self.joyfocus)
	else
		MainScreen.instance.charCreationProfession.previousScreen = "WorldSelect"
		MainScreen.instance.charCreationProfession:setVisible(true, self.joyfocus)
	end
end

function WorldSelect:clickAdvanced()
	self.advancedPanel:setVisible(not self.advancedPanel:getIsVisible())
	self:checkSeed()

	if self.advancedPanel:getIsVisible() then
		self.listbox:setHeight(self.listbox:getHeight() - self.advancedPanel:getHeight() - UI_BORDER_SPACING)
	else
		self.listbox:setHeight(self.height-startY - BUTTON_HGT - UI_BORDER_SPACING*2-1)
	end
	self.mapListbox:setHeight(self.listbox.height)
end

function WorldSelect:checkSeed()
	if firstGeneration then
		self:generateNewSeed()
		firstGeneration = false
	end
end

function WorldSelect:generateNewSeed()
	self.seedTextBox:setText(WGUtils.instance:generateSeed())
end

function WorldSelect:saveGenParams()
	self:checkSeed()
	WGParams.instance:setSeedString(self.seedTextBox:getText())
	WGParams.instance:setMinXCell(self.minXSlider:getCurrentValue())
	WGParams.instance:setMinYCell(self.minYSlider:getCurrentValue())
	WGParams.instance:setMaxXCell(self.maxXSlider:getCurrentValue())
	WGParams.instance:setMaxYCell(self.maxYSlider:getCurrentValue())
end

function WorldSelect:onMinXSliderChange(value)
	self.minXValueLabel:setName("" .. value)
end

function WorldSelect:onMinYSliderChange(value)
	self.minYValueLabel:setName("" .. value)
end

function WorldSelect:onMaxXSliderChange(value)
	self.maxXValueLabel:setName("" .. value)
end

function WorldSelect:onMaxYSliderChange(value)
	self.maxYValueLabel:setName("" .. value)
end

function WorldSelect:render()
	ISPanelJoypad.render(self)
	self:drawTextCentre(getText("UI_WorldSelect_title"), self.width / 2, UI_BORDER_SPACING+1, 1, 1, 1, 1, UIFont.Title)
	self:drawRectBorder(self.listbox:getX(), self.listbox:getY(), self.listbox:getWidth(), self.listbox:getHeight(), 0.9, 0.4, 0.4, 0.4)
	self:drawRectBorder(self.mapListbox:getX(), self.mapListbox:getY(), self.mapListbox:getWidth(), self.mapListbox:getHeight(), 0.9, 0.4, 0.4, 0.4)
end

function WorldSelect:doDrawItem(y, item, alt)
	if self.itemsSelectable then
		local isMouseOver = self.mouseoverselected == item.index and not self:isMouseOverScrollBar()
		if self.selected == item.index then
			self:drawRect(0, (y), self:getWidth(), item.height-1, 0.3, 0.7, 0.35, 0.15)
		elseif isMouseOver then
			self:drawRect(1, y + 1, self:getWidth() - 2, item.height - 2, 0.95, 0.05, 0.05, 0.05)
		end
	end
	self:drawRectBorder(0, (y), self:getWidth(), item.height, 0.5, self.borderColor.r, self.borderColor.g, self.borderColor.b)
	local fontHgt = getTextManager():getFontFromEnum(UIFont.Large):getLineHeight()
	local textY = y + (item.height - fontHgt) / 2
	self:drawText(item.text, 15, textY, 0.9, 0.9, 0.9, 0.9, UIFont.Large)
	y = y + item.height
	return y
end

function WorldSelect:onGainJoypadFocus(joypadData)
	ISPanelJoypad.onGainJoypadFocus(self, joypadData)
	self.listbox:setISButtonForA(self.nextButton)
	self.listbox:setISButtonForB(self.backButton)
	self.listbox:setJoypadFocused(true, joypadData)
end

function WorldSelect:onJoypadBeforeDeactivate(joypadData)
	-- focus is on listbox
	self.backButton:clearJoypadButton()
	self.nextButton:clearJoypadButton()
	self.advancedButton:clearJoypadButton()
end

function WorldSelect:onJoypadBeforeDeactivate_listbox(joypadData)
	self.parent:onJoypadBeforeDeactivate(joypadData)
end

function WorldSelect:onResolutionChange(oldw, oldh, neww, newh)
	self.listbox:setWidth((self.width - UI_BORDER_SPACING*3 - 2) / 2)
	self.mapListbox:setX(self.listbox:getRight() + UI_BORDER_SPACING)
	self.mapListbox:setWidth(self.width - self.listbox:getRight() - UI_BORDER_SPACING*2 - 1)

	if self.advancedPanel:getIsVisible() then
		self.advancedPanel:setY(self.listbox:getHeight() + startY + UI_BORDER_SPACING)
	else
		self.advancedPanel:setY(self.listbox:getHeight() - self.advancedPanel:getHeight() + startY)
	end
	self.advancedPanel:setWidth(self.width - (UI_BORDER_SPACING+1)*2)

	local btnPadding = JOYPAD_TEX_SIZE + UI_BORDER_SPACING*2
	local btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_btn_advanced"))
	self.advancedButton:setX((self.width - btnWidth) / 2)
end

function WorldSelect:create()
	self.listbox = ISScrollingListBox:new(UI_BORDER_SPACING+1, startY, (self.width - UI_BORDER_SPACING*3 - 2) / 2, self.height-startY - BUTTON_HGT - UI_BORDER_SPACING*2-1)
	self.listbox:initialise()
	self.listbox:instantiate()
	self.listbox:setAnchorsTBLR(true, true, true, false)
	self.listbox.itemheight = 50
	self.listbox.doDrawItem = WorldSelect.doDrawItem
	self.listbox.itemsSelectable = true
	self.listbox:setOnMouseDownFunction(self, WorldSelect.onSelectWorld)
	self.listbox:setOnMouseDoubleClick(self, WorldSelect.onDblClick)
	self.listbox.onJoypadBeforeDeactivate = self.onJoypadBeforeDeactivate_listbox
	self.listbox.backgroundColor  = {r=0, g=0, b=0, a=0.5}
	self:addChild(self.listbox)

	self.mapListbox = ISScrollingListBox:new(self.listbox:getRight() + UI_BORDER_SPACING, startY, self.width - self.listbox:getRight() - UI_BORDER_SPACING*2 - 1, self.listbox.height)
	self.mapListbox:initialise()
	self.mapListbox:instantiate()
	self.mapListbox:setAnchorsTBLR(true, true, true, false)
	self.mapListbox.itemheight = 50
	self.mapListbox.doDrawItem = WorldSelect.doDrawItem
	self.mapListbox.itemsSelectable = false
	self.mapListbox.backgroundColor  = {r=0, g=0, b=0, a=0.5}
	self:addChild(self.mapListbox)

	local btnPadding = JOYPAD_TEX_SIZE + UI_BORDER_SPACING*2
	local btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_btn_back"))
	self.backButton = ISButton:new(self.listbox.x, self.height - UI_BORDER_SPACING - BUTTON_HGT - 1, btnWidth, BUTTON_HGT, getText("UI_btn_back"), self, WorldSelect.onOptionMouseDown)
	self.backButton.internal = "BACK"
	self.backButton:initialise()
	self.backButton:instantiate()
	self.backButton:setAnchorsTBLR(false, true, true, nil)
	self.backButton:enableCancelColor()
	self:addChild(self.backButton)

	local btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_btn_next"))
	self.nextButton = ISButton:new(self.width - btnWidth - UI_BORDER_SPACING-1, self.backButton.y, btnWidth, BUTTON_HGT, getText("UI_btn_next"), self, WorldSelect.onOptionMouseDown)
	self.nextButton.internal = "NEXT"
	self.nextButton:initialise()
	self.nextButton:instantiate()
	self.nextButton:setAnchorsTBLR(false, true, false, true)
	self.nextButton:enableAcceptColor()
	self.nextButton:setEnable(true) -- sets the hard-coded border color
	self:addChild(self.nextButton)

	--

	local btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_btn_advanced"))
	self.advancedButton = ISButton:new((self.width - btnWidth) / 2, self.backButton.y, btnWidth, BUTTON_HGT, getText("UI_btn_advanced"), self, self.onOptionMouseDown)
	self.advancedButton.internal = "ADVANCED"
	self.advancedButton:initialise()
	self.advancedButton:instantiate()
	self.advancedButton:setAnchorsTBLR(false, true, true, false)
	self.advancedButton:setEnable(true) -- sets the hard-coded border color
	self:addChild(self.advancedButton)

	local advPanelHeight = UI_BORDER_SPACING*4 + BUTTON_HGT*3 + 2
	self.advancedPanel = ISPanel:new(UI_BORDER_SPACING+1,self.listbox:getHeight() + startY - advPanelHeight, self.width - (UI_BORDER_SPACING+1)*2, advPanelHeight)
	self.advancedPanel:initialise()
	self.advancedPanel:instantiate()
	self.advancedPanel:setVisible(false)
	self.advancedPanel:setAnchorsTBLR(true, false, true, false)
	self:addChild(self.advancedPanel)

	self.seedLabel = ISLabel:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, BUTTON_HGT, getText("UI_advWorld_seed_label"), 1.0, 1.0, 1.0, 1.0, UIFont.Medium, true)
	self.seedLabel:initialise()
	self.seedLabel:instantiate()
	self.seedLabel:setAnchorsTBLR(true, false, true, false)
	self.advancedPanel:addChild(self.seedLabel)

	self.XLabel = ISLabel:new(UI_BORDER_SPACING+1, self.seedLabel:getBottom()+UI_BORDER_SPACING, BUTTON_HGT, getText("UI_advWorld_X_label"), 1.0, 1.0, 1.0, 1.0, UIFont.Medium, true)
	self.XLabel:initialise()
	self.XLabel:instantiate()
	self.XLabel:setAnchorsTBLR(true, false, true, false)
	self.advancedPanel:addChild(self.XLabel)

	self.YLabel = ISLabel:new(UI_BORDER_SPACING+1, self.XLabel:getBottom()+UI_BORDER_SPACING, BUTTON_HGT, getText("UI_advWorld_Y_label"), 1.0, 1.0, 1.0, 1.0, UIFont.Medium, true)
	self.YLabel:initialise()
	self.YLabel:instantiate()
	self.YLabel:setAnchorsTBLR(true, false, true, false)
	self.advancedPanel:addChild(self.YLabel)

	local maxWidth = math.max(self.seedLabel:getWidth(), self.XLabel:getWidth(), self.YLabel:getWidth())

	-- seed & random button
	self.seedTextBox = ISTextEntryBox:new("", maxWidth + UI_BORDER_SPACING * 2, self.seedLabel.y, 300, BUTTON_HGT)
	self.seedTextBox.font = UIFont.Small
	self.seedTextBox:initialise()
	self.seedTextBox:instantiate()
	self.seedTextBox:setOnlyText(true)
	self.seedTextBox:setMaxTextLength(16)
	self.seedTextBox:setAnchorsTBLR(true, false, true, false)
	self.advancedPanel:addChild(self.seedTextBox)

	local btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_advWorld_random_btn"))
	self.randomButton = ISButton:new(self.seedTextBox:getRight() + UI_BORDER_SPACING, self.seedLabel.y, btnWidth, BUTTON_HGT, getText("UI_advWorld_random_btn"), self, self.generateNewSeed)
	self.randomButton:initialise()
	self.randomButton:instantiate()
	self.randomButton:setAnchorsTBLR(true, false, true, false)
	self.randomButton:setEnable(true) -- sets the hard-coded border color
	self.advancedPanel:addChild(self.randomButton)

	local cellTextWidthLeft = getTextManager():MeasureStringX(UIFont.Small, "-999     ")
	local cellTextWidthRight = getTextManager():MeasureStringX(UIFont.Small, "999")
	-- Cells X
	self.minXSlider = ISSliderPanel:new(maxWidth + UI_BORDER_SPACING * 2, self.XLabel.y, 200, BUTTON_HGT, self, WorldSelect.onMinXSliderChange)
	self.minXSlider:initialise()
	self.minXSlider:instantiate()
	self.minXSlider:setAnchorsTBLR(true, false, true, false)
	self.minXSlider:setValues(-250, 0, 1, 0, true)
	self.advancedPanel:addChild(self.minXSlider)

	self.minXValueLabel = ISLabel:new(self.minXSlider:getRight() + UI_BORDER_SPACING, self.XLabel.y, BUTTON_HGT, "0", 1.0, 1.0, 1.0, 1.0, UIFont.Medium, true)
	self.minXValueLabel:initialise()
	self.minXValueLabel:instantiate()
	self.minXValueLabel:setAnchorsTBLR(true, false, true, false)
	self.advancedPanel:addChild(self.minXValueLabel)

	self.maxXValueLabel = ISLabel:new(self.minXSlider:getRight() + UI_BORDER_SPACING*2 + cellTextWidthLeft, self.XLabel.y, BUTTON_HGT, "0", 1.0, 1.0, 1.0, 1.0, UIFont.Medium, true)
	self.maxXValueLabel:initialise()
	self.maxXValueLabel:instantiate()
	self.maxXValueLabel:setAnchorsTBLR(true, false, true, false)
	self.advancedPanel:addChild(self.maxXValueLabel)

	self.maxXSlider = ISSliderPanel:new(self.minXSlider:getRight() + cellTextWidthLeft + cellTextWidthRight + UI_BORDER_SPACING*3, self.XLabel.y, 200, BUTTON_HGT, self, WorldSelect.onMaxXSliderChange)
	self.maxXSlider:initialise()
	self.maxXSlider:instantiate()
	self.maxXSlider:setAnchorsTBLR(true, false, true, false)
	self.maxXSlider:setValues(0, 250, 1, 0, true)
	self.advancedPanel:addChild(self.maxXSlider)



	self.minYSlider = ISSliderPanel:new(maxWidth + UI_BORDER_SPACING * 2, self.YLabel.y, 200, BUTTON_HGT, self, WorldSelect.onMinYSliderChange)
	self.minYSlider:initialise()
	self.minYSlider:instantiate()
	self.minYSlider:setAnchorsTBLR(true, false, true, false)
	self.minYSlider:setValues(-250, 0, 1, 0, true)
	self.advancedPanel:addChild(self.minYSlider)

	self.minYValueLabel = ISLabel:new(self.minXSlider:getRight() + UI_BORDER_SPACING, self.YLabel.y, BUTTON_HGT, "0", 1.0, 1.0, 1.0, 1.0, UIFont.Medium, true)
	self.minYValueLabel:initialise()
	self.minYValueLabel:instantiate()
	self.minYValueLabel:setAnchorsTBLR(true, false, true, false)
	self.advancedPanel:addChild(self.minYValueLabel)

	self.maxYValueLabel = ISLabel:new(self.minXSlider:getRight() + UI_BORDER_SPACING*2 + cellTextWidthLeft, self.YLabel.y, BUTTON_HGT, "0", 1.0, 1.0, 1.0, 1.0, UIFont.Medium, true)
	self.maxYValueLabel:initialise()
	self.maxYValueLabel:instantiate()
	self.maxYValueLabel:setAnchorsTBLR(true, false, true, false)
	self.advancedPanel:addChild(self.maxYValueLabel)

	self.maxYSlider = ISSliderPanel:new(self.minXSlider:getRight() + cellTextWidthLeft + cellTextWidthRight + UI_BORDER_SPACING*3, self.YLabel.y, 200, BUTTON_HGT, self, WorldSelect.onMaxYSliderChange)
	self.maxYSlider:initialise()
	self.maxYSlider:instantiate()
	self.maxYSlider:setAnchorsTBLR(true, false, true, false)
	self.maxYSlider:setValues(0, 250, 1, 0, true)
	self.advancedPanel:addChild(self.maxYSlider)

	self.minXSlider:setCurrentValue(-250)
	self.minYSlider:setCurrentValue(-250)
	self.maxXSlider:setCurrentValue(250)
	self.maxYSlider:setCurrentValue(250)
end

function WorldSelect:onKeyRelease(key)
    if key == Keyboard.KEY_ESCAPE then
        self.backButton:forceClick()
        return
    end
    if key == Keyboard.KEY_RETURN then
        self.nextButton:forceClick()
        return
    end
end

function WorldSelect:new(x, y, width, height)
	local o = ISPanelJoypad.new(self, x, y, width, height)
	o.previousScreen = 'NewGameScreen'
	o.mapGroups = MapGroups.new()
	WorldSelect.instance = o
	return o
end

