require "ISUI/ISPanelJoypad"
require "ISUI/ISButton"
require "ISUI/ISControllerTestPanel"
require "ISUI/ISVolumeControl"

require "defines"

MainOptions = ISPanelJoypad:derive("MainOptions");

MainOptions.keys = {};
MainOptions.keyText = {};
MainOptions.setKeybindDialog = nil;
MainOptions.keyBindingLength = 0;

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local FONT_HGT_TITLE = getTextManager():getFontHeight(UIFont.Title)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local LABEL_HGT = FONT_HGT_MEDIUM + 6
local JOYPAD_TEX_SIZE = 32
local BUTTON_PADDING = JOYPAD_TEX_SIZE + UI_BORDER_SPACING*2
local IMMOVABLE_OBJECTS = {} --objects in this table do not get moved when centring the elements on the page
local INITIAL_Y = UI_BORDER_SPACING + 1

-- -- -- -- --

local GameOption = ISBaseObject:derive("GameOption")
local GameOptions = ISBaseObject:derive("GameOptions")

function GameOption:new(name, control, arg1, arg2)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.name = name
	o.control = control
	o.arg1 = arg1
	o.arg2 = arg2
	if control.isCombobox then
		control.onChange = self.onChangeComboBox
		control.target = o
	end
	if control.isTickBox then
		control.changeOptionMethod = self.onChangeTickBox
		control.changeOptionTarget = o
	end
	if control.isSlider then
		control.targetFunc = self.onChangeVolumeControl
		control.target = o
	end
	if control.Type == "ISTextEntryBox" then
		control.onTextChange = function()
			o.gameOptions:onChange(o)
			if o.onChange then
				o:onChange(control:getInternalText())
			end
		end
	end
	if control.Type == "ISSliderPanel" then
		control.target = o
		control.onValueChange = function(self, val)
			self.gameOptions:onChange(self)
			if self.onChange then
				self:onChange(val)
			end
		end
	end
	return o
end

function GameOption:storeCurrentValue()
end

function GameOption:restoreOriginalValue()
end

function GameOption:toUI()
	print('ERROR: option "'..self.name..'" missing toUI()')
end

function GameOption:apply()
	print('ERROR: option "'..self.name..'" missing apply()')
end

function GameOption:resetLua()
	MainOptions.instance.resetLua = true
end

function GameOption:restartRequired(oldValue, newValue)
	if getCore():getOptionOnStartup(self.name) == nil then
		getCore():setOptionOnStartup(self.name, oldValue)
	end
	if getCore():getOptionOnStartup(self.name) == newValue then
		return
	end
	MainOptions.instance.restartRequired = true
end

function GameOption:onChangeComboBox(box)
	self.gameOptions:onChange(self)
	if self.onChange then
		self:onChange(box)
	end
end

function GameOption:onChangeSlider(value, control)
	self.gameOptions:onChange(self)
	if self.onChange then
		self:onChange(control, value)
	end
end

function GameOption:onChangeTickBox(index, selected)
	self.gameOptions:onChange(self)
	if self.onChange then
		self:onChange(index, selected)
	end
end

function GameOption:onChangeVolumeControl(control, volume)
	self.gameOptions:onChange(self)
	if self.onChange then
		self:onChange(control, volume)
	end
end

-- -- -- -- --

function GameOptions:add(option)
	option.gameOptions = self
	table.insert(self.options, option)
end

function GameOptions:get(optionName)
	for _,option in ipairs(self.options) do
		if option.name == optionName then
			return option
		end
	end
	return nil
end

function GameOptions:apply()
	for _,option in ipairs(self.options) do
		option:apply()
	end
	self.changed = false
end

function GameOptions:storeCurrentValues()
	for _,option in ipairs(self.options) do
		option:storeCurrentValue()
	end
end

function GameOptions:restoreOriginalValues()
	for _,option in ipairs(self.options) do
		option:restoreOriginalValue()
	end
end

function GameOptions:toUI()
	for _,option in ipairs(self.options) do
		option:toUI()
	end
	self.changed = false
end

function GameOptions:onChange(option)
	self.changed = true
end

function GameOptions:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.options = {}
	o.changed = false
	return o
end

-- -- -- -- --

function MainOptions:initialise()
	ISPanelJoypad.initialise(self);
end


--************************************************************************--
--** ISPanel:instantiate
--**
--************************************************************************--
function MainOptions:instantiate()
	self.javaObject = UIElement.new(self);
	self.javaObject:setX(self.x);
	self.javaObject:setY(self.y);
	self.javaObject:setHeight(self.height);
	self.javaObject:setWidth(self.width);
	self.javaObject:setAnchorLeft(self.anchorLeft);
	self.javaObject:setAnchorRight(self.anchorRight);
	self.javaObject:setAnchorTop(self.anchorTop);
	self.javaObject:setAnchorBottom(self.anchorBottom);
end

function MainOptions:setResolutionAndFullScreen()
	local box1 = self.gameOptions:get('displayMode').control
	local box2 = self.gameOptions:get('resolution').control
	if box2.options[box2.selected] then
		local fullscreen = box1.selected == 1
		getCore():setOptionBorderlessWindow(box1.selected == 2)
		-- handle (RECOMMENDED)
		local s = box2.options[box2.selected]
		local w,h = string.match(s, '(%d+) x (%d+)')
		getCore():setResolutionAndFullScreen(tonumber(w), tonumber(h), fullscreen)
	end
end

function MainOptions:ControllerReload(button)
	reloadControllerConfigFiles()
end

function MainOptions:joypadSensitivityM(button)
	self.controllerTestPanel:joypadSensitivityM()
end

function MainOptions:joypadSensitivityP(button)
	self.controllerTestPanel:joypadSensitivityP()
end

function MainOptions:addTextPane(x,y,w,h)
    local panel = ISRichTextPanel:new (x+20, y+self.addY, width, height);
end

function MainOptions:addCombo(x, y, w, h, name, options, selected, target, onchange)
	h = BUTTON_HGT

	local label = ISLabel:new(x, y + self.addY, h, name, 1, 1, 1, 1, UIFont.Small);
	label:initialise();
	self.mainPanel:addChild(label);
	local panel2 = ISComboBox:new(x+20, y + self.addY, w, h, target, onchange);
	panel2:initialise();

	for i, k in ipairs(options) do
		panel2:addOption(k);
	end

	panel2.selected = selected;
	self.mainPanel:addChild(panel2);
	self.mainPanel:insertNewLineOfButtons(panel2)
	self.addY = self.addY + h + UI_BORDER_SPACING;
	return panel2;
end

function MainOptions:addTitle(x, y, name)
	local h = LABEL_HGT

	local label = ISLabel:new(x + 20, y + self.addY, h, name, 1, 1, 1, 1, UIFont.Medium, true)
	label:initialise()
	self.mainPanel:addChild(label)
	self.addY = self.addY + h + UI_BORDER_SPACING;
end

function MainOptions:addDescription(x, y, text)
	local richText = ISRichTextPanel:new(x, y + self.addY, self.width - x - 100, 100)
	richText.background = false
	richText.autosetheight = true
	--richText.clip = true
	richText:initialise()
	self.mainPanel:addChild(richText)
	richText:setText(text)
	richText:paginate()
	self.addY = self.addY + richText:getHeight()
end

function MainOptions:addTextEntry(x, y, name, _text)
	local label = ISLabel:new(x, y + self.addY, 20, name, 1, 1, 1, 1, UIFont.Small)
	label:initialise()
	self.mainPanel:addChild(label)

	local entry = ISTextEntryBox:new(_text, x + 20, y + self.addY, self.width - x - 200, 20)
	entry:initialise()
	entry:instantiate()
	entry:setAnchorLeft(true)
	entry:setAnchorRight(true)
	entry:setAnchorTop(true)
	entry:setAnchorBottom(false)
	self.mainPanel:addChild(entry)
	self.mainPanel:insertNewLineOfButtons(entry)
	self.addY = self.addY + 20 + UI_BORDER_SPACING
	return entry
end

--this entire function isn't being used
--function MainOptions:addSpinBox(x, y, w, h, name, options, selected, target, onchange)
--	local label = ISLabel:new(x, y + self.addY, h, name, 1, 1, 1, 1, UIFont.Small);
--	label:initialise();
--	self.mainPanel:addChild(label);
--	local panel2 = ISSpinBox:new(x+20, y + self.addY + 2, w, h, target, onchange);
--	panel2:initialise();
--
--	for i, k in ipairs(options) do
--		panel2:addOption(k);
--	end
--
--	panel2.selected = selected;
--	panel2.default = selected;
--	self.mainPanel:addChild(panel2);
--	self.mainPanel:insertNewLineOfButtons(panel2.leftButton, panel2.rightButton)
--	self.addY = self.addY + 26;
--	return panel2;
--end

function MainOptions:addVolumeControl(x, y, w, h, name, volume, target, onchange)
	h = BUTTON_HGT
	local label = ISLabel:new(x, y + self.addY, h, name, 1, 1, 1, 1, UIFont.Small);
	label:initialise();
	self.mainPanel:addChild(label);
	local panel2 = ISVolumeControl:new(x+20, y + self.addY, w, h, target, onchange);
	panel2:initialise();
	panel2:setVolume(volume)

	panel2.selected = selected;
	panel2.default = selected;
	self.mainPanel:addChild(panel2);
	self.mainPanel:insertNewLineOfButtons(panel2)
	self.addY = self.addY + h + UI_BORDER_SPACING;
	return panel2;
end

function MainOptions:addTickBox(x, y, w, h)
	local tickBox = ISTickBox:new(x + 20, y + self.addY, w, h, "HELLO?")
	tickBox.choicesColor = {r=1, g=1, b=1, a=1}
	tickBox:initialise()
	self.mainPanel:addChild(tickBox)
	self.mainPanel:insertNewLineOfButtons(tickBox)
--	self.addY = self.addY + tickBox:getHeight() + 6
	return tickBox
end

function MainOptions:addYesNo(x, y, w, h, name)
	h = BUTTON_HGT
	local label = ISLabel:new(x, y + self.addY, h, name, 1, 1, 1, 1, UIFont.Small)
	label:initialise()
	self.mainPanel:addChild(label)

	local tickBox = self:addTickBox(x, y, w, h)
	tickBox:addOption("")

	label:setHeight(tickBox:getHeight())
	
	self.addY = self.addY + h + UI_BORDER_SPACING
	return tickBox
end

function MainOptions:addColorButton(x, y, name, color, onClick)
	local label = ISLabel:new(x, y + self.addY, BUTTON_HGT, name, 1, 1, 1, 1, UIFont.Small, false)
	label:initialise()
	self.mainPanel:addChild(label)

	local button = ISButton:new(x + 20, y + self.addY, BUTTON_HGT*2, BUTTON_HGT, "", self, onClick)
	button:initialise()
	button.backgroundColor = color
	self.mainPanel:addChild(button)
	self.mainPanel:insertNewLineOfButtons(button)
	self.addY = self.addY + BUTTON_HGT + UI_BORDER_SPACING
	return button
end

function MainOptions:addButton(x, y, name)
	local button = ISButton:new(x + 20, y + self.addY, 200, BUTTON_HGT, name)
	button:initialise()
	button:setWidthToTitle()
	self.mainPanel:addChild(button)
	self.mainPanel:insertNewLineOfButtons(button)
	self.addY = self.addY + BUTTON_HGT + UI_BORDER_SPACING
	return button
end

function MainOptions:addSlider(x, y, width, name, min, max, step, value)
	local label = ISLabel:new(x, y + self.addY, BUTTON_HGT, name, 1, 1, 1, 1, UIFont.Small, false)
	label:initialise()
	self.mainPanel:addChild(label)

	local panel = ISPanel:new(x + 20, y + self.addY, width, BUTTON_HGT)
	panel:noBackground()
	self.mainPanel:addChild(panel)

	local valueLabel = ISLabel:new(60, 0, BUTTON_HGT, tostring(value), 1, 1, 1, 1, UIFont.Small, false)
	valueLabel:initialise()
	panel:addChild(valueLabel)

	local slider = ISSliderPanel:new(70, 0, width - 70, BUTTON_HGT)
	slider:initialise()
	slider:setValues(min, max, step, step * 10)
	slider:setCurrentValue(value, true)
	panel:addChild(slider)
	self.mainPanel:insertNewLineOfButtons(slider)
	slider.label = valueLabel

	self.addY = self.addY + BUTTON_HGT + UI_BORDER_SPACING
	return slider
end

function MainOptions:addMegaVolumeControl(x, y, w, h, name, volume, target, onchange)
	h = BUTTON_HGT
	local label = ISLabel:new(x, y + self.addY, h, name, 1, 1, 1, 1, UIFont.Small);
	label:initialise();
	self.mainPanel:addChild(label);
	local panel2 = ISMegaVolumeControl:new(x+20, y + self.addY, w, h, target, onchange);
	panel2:initialise();
	panel2:setVolume(volume)

	panel2.selected = selected;
	panel2.default = selected;
	self.mainPanel:addChild(panel2);
	self.mainPanel:insertNewLineOfButtons(panel2)
	self.addY = self.addY + h + UI_BORDER_SPACING;
	return panel2;
end

function MainOptions:addVolumeIndicator(x, y, w, h, name, volume, target, onchange)
	h = BUTTON_HGT

	local label = ISLabel:new(x, y + self.addY, h, name, 1, 1, 1, 1, UIFont.Small);
	label:initialise();
	self.mainPanel:addChild(label);
	local panel2 = ISVolumeIndicator:new(x+20, y + self.addY, w, h, target, onchange);
	panel2:initialise();

	panel2.selected = selected;
	panel2.default = selected;
	self.mainPanel:addChild(panel2);
--	self.mainPanel:insertNewLineOfButtons(panel2)
	self.addY = self.addY + h + UI_BORDER_SPACING;
	return panel2;
end

function MainOptions:addPage(name)
	self.mainPanel = ISPanelJoypad:new(0, 0, self:getWidth(), self.tabs:getHeight() - self.tabs.tabHeight)
	self.mainPanel:initialise()
	self.mainPanel:instantiate()
	self.mainPanel:setAnchorRight(true)
	self.mainPanel:setAnchorLeft(true)
	self.mainPanel:setAnchorTop(true)
	self.mainPanel:setAnchorBottom(true)
	self.mainPanel:noBackground()
	self.mainPanel.borderColor = {r=0, g=0, b=0, a=0};
	self.mainPanel:setScrollChildren(true)
	self.mainPanel.onMouseWheel = MainOptions.onMouseWheelCurrentTab
	self.mainPanel.onJoypadDown = MainOptions.onJoypadDownCurrentTab
	self.mainPanel.onGainJoypadFocus = MainOptions.onGainJoypadFocusCurrentTab
	self.mainPanel.onLoseJoypadFocus = MainOptions.onLoseJoypadFocusCurrentTab
	self.mainPanel.onJoypadBeforeDeactivate = MainOptions.onJoypadBeforeDeactivateCurrentTab

	-- rerouting the main panel's pre / render functions so we can add in the stencil stuff there...
	self.mainPanel.render = MainOptions.subPanelRender
	self.mainPanel.prerender = MainOptions.subPanelPreRender

	self.mainPanel:addScrollBars();
	self.tabs:addView(name, self.mainPanel)
end

-- THESE TWO ARE ACTUALLY self.mainPanel's new render / prerender functions...
--
function MainOptions:subPanelPreRender()
    self:doRightJoystickScrolling(20, 20)
    self:setStencilRect(0,0,self:getWidth(),self:getHeight());
    ISPanelJoypad.prerender(self);
end

function MainOptions:subPanelRender()
    ISPanelJoypad.render(self);
    self:clearStencilRect();
end

---------------------------------------------------------------------------------------------

local HorizontalLine = ISPanel:derive("HorizontalLine")

function HorizontalLine:prerender()
end

function HorizontalLine:render()
	self:drawRect(0, 0, self.width, 1, 1.0, 0.5, 0.5, 0.5)
end

function HorizontalLine:new(x, y, width)
	local o = ISPanel.new(self, x, y, width, 2)
	return o
end

---------------------------------------------------------------------------------------------

function MainOptions:addHorizontalLine(y, text)
	local sbarWidth = 13
	local hLine = HorizontalLine:new(UI_BORDER_SPACING+1, self.addY + y, self.width - (UI_BORDER_SPACING+1) * 2 - sbarWidth)
	hLine.anchorRight = true
	self.mainPanel:addChild(hLine)
	table.insert(IMMOVABLE_OBJECTS, hLine)

	local label = ISLabel:new(100, self.addY + y + UI_BORDER_SPACING, FONT_HGT_MEDIUM, text, 1, 1, 1, 1, UIFont.Medium)
	label:setX(50)
	label:initialise()
	label:setAnchorRight(true)
	self.mainPanel:addChild(label)
	table.insert(IMMOVABLE_OBJECTS, label)

	self.addY = self.addY + UI_BORDER_SPACING*2 + FONT_HGT_MEDIUM
end

function MainOptions:addHorizontalLineSmall(y)
	local sbarWidth = 13
	local hLine = HorizontalLine:new(UI_BORDER_SPACING*2+1, self.addY + y, self.width - (UI_BORDER_SPACING*2+1) * 2 - sbarWidth)
	hLine.anchorRight = true
	self.mainPanel:addChild(hLine)
	table.insert(IMMOVABLE_OBJECTS, hLine)

	self.addY = self.addY + UI_BORDER_SPACING
end

function MainOptions:create()
	local y = INITIAL_Y;
    -- stay away from statics :)
    MainOptions.keyText = {}
    MainOptions.keyBindingLength = 0;

	local topHgt = FONT_HGT_TITLE + UI_BORDER_SPACING*2 + 1
	local bottomHgt = BUTTON_HGT + UI_BORDER_SPACING*2 + 1

	self.tabs = ISTabPanel:new(0, topHgt, self.width, self.height - topHgt - bottomHgt);
	self.tabs:initialise();
	self.tabs:setAnchorBottom(true);
	self.tabs:setAnchorRight(true);
--	self.tabs.borderColor = { r = 0, g = 0, b = 0, a = 0};
	self.tabs.onActivateView = MainOptions.onTabsActivateView;
	self.tabs.target = self;
	self.tabs:setEqualTabWidth(false)
	self.tabs.tabPadX = 40
	self.tabs:setCenterTabs(true)
--	self.tabs.tabHeight = self.tabs.tabHeight + 12
	self:addChild(self.tabs);

	local btnWidthBack = BUTTON_PADDING + getTextManager():MeasureStringX(UIFont.Small, getText("UI_btn_back"))
	local btnWidthAccept = BUTTON_PADDING + getTextManager():MeasureStringX(UIFont.Small, getText("UI_btn_accept"))
	local btnWidthApply = BUTTON_PADDING + getTextManager():MeasureStringX(UIFont.Small, getText("UI_btn_apply"))
	local buttonOffsetX = (self.width - (btnWidthBack + btnWidthAccept + btnWidthApply + UI_BORDER_SPACING*2))/2

	self.backButton = ISButton:new(buttonOffsetX, self.height - BUTTON_HGT - UI_BORDER_SPACING - 1, btnWidthBack, BUTTON_HGT, getText("UI_btn_back"), self, MainOptions.onOptionMouseDown);
	self.backButton.internal = "BACK";
	self.backButton:initialise();
	self.backButton:instantiate();
	self.backButton:setAnchorLeft(true);
	self.backButton:setAnchorTop(false);
	self.backButton:setAnchorBottom(true);
	self.backButton.borderColor = {r=1, g=1, b=1, a=0.1};
	self.backButton:setFont(UIFont.Small);
	self.backButton:ignoreWidthChange();
	self.backButton:ignoreHeightChange();
	self.backButton:enableCancelColor()
	self:addChild(self.backButton);

	self.acceptButton = ISButton:new(self.backButton:getRight() + UI_BORDER_SPACING, self.backButton.y, btnWidthAccept, BUTTON_HGT, getText("UI_btn_accept"), self, MainOptions.onOptionMouseDown);
	self.acceptButton.internal = "ACCEPT";
	self.acceptButton:initialise();
	self.acceptButton:instantiate();
	self.acceptButton:setAnchorRight(false);
	self.acceptButton:setAnchorLeft(false);
	self.acceptButton:setAnchorTop(false);
	self.acceptButton:setAnchorBottom(true);
	self.acceptButton.borderColor = {r=1, g=1, b=1, a=0.1};
	self.acceptButton:setFont(UIFont.Small);
	self.acceptButton:ignoreWidthChange();
	self.acceptButton:ignoreHeightChange();
	self.acceptButton:enableAcceptColor()
	self:addChild(self.acceptButton);

	self.saveButton = ISButton:new(self.acceptButton:getRight() + UI_BORDER_SPACING, self.backButton.y, btnWidthApply, BUTTON_HGT, getText("UI_btn_apply"), self, MainOptions.onOptionMouseDown);
	self.saveButton.internal = "SAVE";
	self.saveButton:initialise();
	self.saveButton:instantiate();
	self.saveButton:setAnchorRight(false);
	self.saveButton:setAnchorLeft(false);
	self.saveButton:setAnchorTop(false);
	self.saveButton:setAnchorBottom(true);
	self.saveButton.borderColor = {r=1, g=1, b=1, a=0.1};
	self.saveButton:setFont(UIFont.Small);
	self.saveButton:ignoreWidthChange();
	self.saveButton:ignoreHeightChange();
	self.saveButton:enableAcceptColor()
	self:addChild(self.saveButton);

	local splitpoint = self:getWidth() / 2;
	--local comboWidth = self:getWidth()-splitpoint - 100
	local comboWidth = 45 * (getCore():getOptionFontSizeReal() +1) + 60

	self:addDisplayPanel()

	-----------------
	------- UI ------
	-----------------
	self:addUIPanel()

	-----------------
	----- SOUND -----
	-----------------
	self:addSoundPanel()

    --y = y + self.addY;

--    local label = ISLabel:new(splitpoint - 1, y, 20, "Mods folder", 1, 1, 1, 1, UIFont.Small, false);
--    label:initialise();
--    self.mainPanel:addChild(label);
--
--    self.modSaveTxt = ISTextEntryBox:new(getCore():getSaveFolder(), splitpoint + 20, y, self:getWidth()-splitpoint - 240, 20);
--    self.modSaveTxt:initialise();
--    self.modSaveTxt:instantiate();
--    self.modSaveTxt:setAnchorLeft(true);
--    self.modSaveTxt:setAnchorRight(true);
--    self.modSaveTxt:setAnchorTop(true);
--    self.modSaveTxt:setAnchorBottom(false);
--    self.mainPanel:addChild(self.modSaveTxt);

	----- KEY BINDING -----
	local reload = MainOptions.loadKeys();
	SurvivalGuideEntries.addEntry11();
	--
	self:addKeybindingPanel()
	--self.mainPanel:setScrollHeight(self.addY + y + BUTTON_HGT + UI_BORDER_SPACING);
	--
	--y = y + 40;

	--self.mainPanel:setScrollHeight(y + self.addY + 20)

	----- ACCESSIBILITY -----
	self:addAccessibilityPanel()

	----- CONTROLLER -----
	self:addControllerPanel()

	----- MULTIPLAYER -----
	self:addMultiplayerPanel()

	----- MOD OPTIONS -----
	if #PZAPI.ModOptions.Data ~= 0 then
		self:addModOptionsPanel()
	end

	-------------

	self:setVisible(false);

	if reload then
		-- we erase our previous file (by setting the append boolean to false);
		local fileOutput = getFileWriter("keysB42.ini", true, false)
		fileOutput:write("VERSION="..tostring(MainOptions.KEYS_VERSION).."\r\n")
		for i,v in ipairs(MainOptions.keyText) do
			-- if it's a label (like [Player Visual])
			if not v.isModBind then
				if v.value then
					fileOutput:write(v.value .. "\r\n")
				else
					fileOutput:write(v.txt:getName() .. "=" .. v.keyCode .."/"..v.altCode .. "\r\n")
					getCore():addKeyBinding(v.txt:getName(), v.keyCode)
					getCore():addAltKeyBinding(v.txt:getName(), v.altCode)
				end
			end
		end
		fileOutput:close()
	end

	self:centerKeybindings()
	self:centerTabChildrenX(getText("UI_optionscreen_display"))
	self:centerTabChildrenX(getText("UI_optionscreen_UI"))
	self:centerTabChildrenX(getText("UI_optionscreen_audio"))
	self:centerTabChildrenX(getText("UI_optionscreen_accessibility"))
	self:centerTabChildrenX(getText("UI_optionscreen_multiplayer"))
end

function MainOptions:addDisplayPanel()
	local y = INITIAL_Y;
	self.addY = 0
	local splitpoint = self:getWidth() / 2;
	local comboWidth = 45 * (getCore():getOptionFontSizeReal() +1) + 60

	self:addPage(getText("UI_optionscreen_display"))
	self:addHorizontalLine(y, getText("UI_DisplayOptions_Window"))

	if true then
		----- DISPLAY MODE -----
		local displayMode = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_DisplayMode"),
				{ getText("UI_optionscreen_DisplayMode1"), getText("UI_optionscreen_DisplayMode2"), getText("UI_optionscreen_DisplayMode3") })
		--[[
            local map = {}
            map["defaultTooltip"] = getText("UI_optionscreen_DisplayMode_tt")
            displayMode:setToolTipMap(map)
        --]]
		gameOption = GameOption:new('displayMode', displayMode)
		function gameOption.toUI(self)
			local box = self.control
			if getCore():isFullScreen() then
				box.selected = 1
			elseif getCore():getOptionBorderlessWindow() then
				box.selected = 2
			else
				box.selected = 3
			end
		end
		function gameOption.apply(self)
			local box = self.control
			if not box.options[box.selected] then return end
			if box.selected == 1 then
				if not getCore():isFullScreen() then
					MainOptions.instance.monitorSettings.changed = true
				end
			elseif box.selected == 2 then
				if not getCore():getOptionBorderlessWindow() then
					MainOptions.instance.monitorSettings.changed = true
				end
			elseif box.selected == 3 then
				if getCore():getOptionBorderlessWindow() or getCore():isFullScreen() then
					MainOptions.instance.monitorSettings.changed = true
				end
			end
			local resolution = self.gameOptions:get('resolution')
			local s = resolution.control.options[resolution.control.selected]
			local w,h = string.match(s, '(%d+) x (%d+)')
			if tonumber(w) ~= getCore():getScreenWidth() or tonumber(h) ~= getCore():getScreenHeight() then
				MainOptions.instance.monitorSettings.changed = true
			end
			MainOptions.instance:setResolutionAndFullScreen()
		end
		self.gameOptions:add(gameOption)

	else
		----- FULLSCREEN -----
		local full = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_fullscreen"));

		local gameOption = GameOption:new('fullscreen', full)
		function gameOption.toUI(self)
			local box = self.control
			box:setSelected(1, getCore():isFullScreen())
		end
		function gameOption.apply(self)
			if self.control:isSelected(1) ~= getCore():isFullScreen() then
				MainOptions.instance.monitorSettings.changed = true
			end
			local resolution = self.gameOptions:get('resolution')
			local s = resolution.control.options[resolution.control.selected]
			local w,h = string.match(s, '(%d+) x (%d+)')
			if tonumber(w) ~= getCore():getScreenWidth() or tonumber(h) ~= getCore():getScreenHeight() then
				MainOptions.instance.monitorSettings.changed = true
			end
			MainOptions.instance:setResolutionAndFullScreen()
		end
		self.gameOptions:add(gameOption)

		----- BORDERLESS -----
		local combo = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_borderless"));
		combo.tooltip = getText("UI_optionscreen_borderless_tt");

		gameOption = GameOption:new('borderless', combo)
		function gameOption.toUI(self)
			local box = self.control
			box:setSelected(1, getCore():getOptionBorderlessWindow())
		end
		function gameOption.apply(self)
			local box = self.control
			self:restartRequired(getCore():getOptionBorderlessWindow(), box:isSelected(1))
			getCore():setOptionBorderlessWindow(box:isSelected(1))
		end
		self.gameOptions:add(gameOption)
	end
	----- RESOLUTION -----
	local modes = getCore():getScreenModes();
	table.sort(modes, MainOptions.sortModes);
	local invalidSizesRemoved = false;
	while not invalidSizesRemoved do
		if #modes == 0 or modes[1] == nil then
			break
		end
		ax, ay = string.match(modes[1], '(%d+) x (%d+)')
		if tonumber(ax) < 1200 then
			print("Removing undersized resolution mode " .. modes[1] .. " from Resolution option")
			table.remove(modes,1)
		else
			invalidSizesRemoved = true
		end
	end
	table.insert(modes, 1, "CURRENT")
	local res = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_resolution"), modes, 1);

	gameOption = GameOption:new('resolution', res)
	function gameOption.toUI(self)
		local box = self.control
		local w = getCore():getScreenWidth()
		local h = getCore():getScreenHeight()
		box.options[1] = getText("UI_optionscreen_CurrentResolution", w .. " x " .. h)
		box.selected = 1
		--		if w == 1280 and h == 720 then
		--			box:select(w.." x "..h.. " (" .. getText("UI_optionscreen_recommended") .. ")")
		--		else
		box:select(w.." x "..h)
		--		end
	end
	function gameOption.apply(self)
		-- 'fullscreen' option sets both resolution and fullscreen
	end
	self.gameOptions:add(gameOption)

	----- FRAMERATE -----
	local framerate = nil
	if SystemDisabler.getUncappedFPS() then
		framerate = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_framerate"), {getText("UI_optionscreen_Uncapped"), "244", "240", "165", "144", "120", "95", "90", "75", "60", "55", "45", "30", "24"}, 2);
	else
		framerate = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_framerate"), {"244", "240", "165", "144", "120", "95", "90", "75", "60", "55", "45", "30", "24"}, 2);
	end

	gameOption = GameOption:new('framerate', framerate)
	function gameOption.toUI(self)
		local box = self.control
		local fps = getPerformance():getFramerate()
		local isFpsUncapped = getPerformance():isFramerateUncapped()
		if isFpsUncapped then box.selected = 1
		elseif fps == 244 then box.selected = 2
		elseif fps == 240 then box.selected = 3
		elseif fps == 165 then box.selected = 4
		elseif fps == 144 then box.selected = 5
		elseif fps == 120 then box.selected = 6
		elseif fps == 95 then box.selected = 7
		elseif fps == 90 then box.selected = 8
		elseif fps == 75 then box.selected = 9
		elseif fps == 60 then box.selected = 10
		elseif fps == 55 then box.selected = 11
		elseif fps == 45 then box.selected = 12
		elseif fps == 30 then box.selected = 13
		elseif fps == 24 then box.selected = 14
		else box.selected = 10 end
		if not SystemDisabler.getUncappedFPS() then
			box.selected = box.selected - 1
		end
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] then
			if SystemDisabler.getUncappedFPS() then
				getCore():setFramerate(box.selected)
			else
				getCore():setFramerate(box.selected + 1)
			end
		end
	end
	self.gameOptions:add(gameOption)

	----- VSYNC -----
	local vsync = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_vsync"))

	gameOption = GameOption:new('vsync', vsync)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1, getCore():getOptionVSync())
	end
	function gameOption.apply(self)
		local box = self.control
		if box:isSelected(1) ~= getCore():getOptionVSync() then
			MainOptions.instance.monitorSettings.changed = true
		end
		getCore():setOptionVSync(box:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	----- PAUSE ON FOCUS LOSS -----
	local focusloss = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_focusloss"))

	gameOption = GameOption:new('focusloss', focusloss)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1, getCore():getOptionFocusloss())
	end
	function gameOption.apply(self)
		local box = self.control
		if box:isSelected(1) ~= getCore():getOptionFocusloss() then
			MainOptions.instance.monitorSettings.changed = true
		end
		getCore():setOptionFocusloss(box:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	--[[
        ----- MULTICORE -----
        local map = {};

        local multithread;
        multithread = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_multicore"));
        multithread.tooltip = getText("UI_optionscreen_needreboot");

        gameOption = GameOption:new('multicore', multithread)
        function gameOption.toUI(self)
            local box = self.control
            box:setSelected(1, getCore():isMultiThread())
        end
        function gameOption.apply(self)
            local box = self.control
            self:restartRequired(getCore():isMultiThread(), box:isSelected(1))
            getCore():setMultiThread(box:isSelected(1))
        end
        self.gameOptions:add(gameOption)

        ----- SHADERS -----
        --shaders now forced on.
        local shader;
        shader = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_shaders2"), {getText("UI_Yes"), getText("UI_No")}, 1);

        gameOption = GameOption:new('shaders', shader)
        function gameOption.toUI(self)
            local box = self.control
            if getCore():getUseShaders() then
                box.selected = 1;
            else
                box.selected = 2;
            end
        end
        function gameOption.apply(self)
            local box = self.control
            if box.options[box.selected] then
                getCore():setUseShaders(box.selected == 1)
                if MainScreen.instance.inGame then
                    getCore():shadersOptionChanged()
                end
            end
        end
        self.gameOptions:add(gameOption)
    --]]

	self:addHorizontalLine(y, getText("UI_DisplayOptions_Textures"))

	----- TEXTURE COMPRESSION -----
	local texcompress = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_texture_compress"));
	texcompress.tooltip = getText("UI_optionscreen_texture_compress_tt");

	gameOption = GameOption:new('texcompress', texcompress)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1, getCore():getOptionTextureCompression())
	end
	function gameOption.apply(self)
		local box = self.control
		self:restartRequired(getCore():getOptionTextureCompression(), box:isSelected(1))
		getCore():setOptionTextureCompression(box:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	----- DOUBLE SIZED -----
	-- removed as almost no mods use both sizes of tiles, and it generates bug reports

	--     local doubleSize = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_texture2x"));
	--     doubleSize.tooltip = getText("UI_optionscreen_texture2x_tt");
	--
	-- 	gameOption = GameOption:new('doubleSize', doubleSize)
	-- 	function gameOption.toUI(self)
	-- 		local box = self.control
	-- 		box:setSelected(1, getCore():getOptionTexture2x())
	-- 	end
	-- 	function gameOption.apply(self)
	-- 		local box = self.control
	-- 		self:restartRequired(getCore():getOptionTexture2x(), box:isSelected(1))
	-- 		getCore():setOptionTexture2x(box:isSelected(1))
	-- 	end
	-- 	self.gameOptions:add(gameOption)

	----- MAX TEXTURE SIZE -----
	local maxTextureSize = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_MaxTextureSize"),
			{ getText("UI_optionscreen_MaxTextureSize1"), getText("UI_optionscreen_MaxTextureSize2"), getText("UI_optionscreen_MaxTextureSize3"), getText("UI_optionscreen_MaxTextureSize4") });
	local map = {}
	map["defaultTooltip"] = getText("UI_optionscreen_MaxTextureSize_tt"):gsub('\\n', '\n')
	maxTextureSize:setToolTipMap(map)

	gameOption = GameOption:new('maxTextureSize', maxTextureSize)
	function gameOption.toUI(self)
		local box = self.control
		box.selected = getCore():getOptionMaxTextureSize()
	end
	function gameOption.apply(self)
		local box = self.control
		self:restartRequired(getCore():getOptionMaxTextureSize(), box.selected)
		getCore():setOptionMaxTextureSize(box.selected)
	end
	self.gameOptions:add(gameOption)

	----- MAX VEHICLE TEXTURE SIZE -----
	local maxVehicleTextureSize = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_MaxVehicleTextureSize"),
			{ getText("UI_optionscreen_MaxTextureSize1"), getText("UI_optionscreen_MaxTextureSize2"), getText("UI_optionscreen_MaxTextureSize3"), getText("UI_optionscreen_MaxTextureSize4") });
	local map = {}
	map["defaultTooltip"] = getText("UI_optionscreen_MaxVehicleTextureSize_tt"):gsub('\\n', '\n')
	maxVehicleTextureSize:setToolTipMap(map)

	gameOption = GameOption:new('maxVehicleTextureSize', maxVehicleTextureSize)
	function gameOption.toUI(self)
		local box = self.control
		box.selected = getCore():getOptionMaxVehicleTextureSize()
	end
	function gameOption.apply(self)
		local box = self.control
		self:restartRequired(getCore():getOptionMaxVehicleTextureSize(), box.selected)
		getCore():setOptionMaxVehicleTextureSize(box.selected)
	end
	self.gameOptions:add(gameOption)

	----- SIMPLE CLOTHING TEXTURES -----
	local simpleClothingTex = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_SimpleClothingTextures"),
			{ getText("UI_optionscreen_SimpleClothingTextures1"), getText("UI_optionscreen_SimpleClothingTextures2"), getText("UI_optionscreen_SimpleClothingTextures3") },
			1);

	local map = {}
	map["defaultTooltip"] = getText("UI_optionscreen_SimpleClothingTextures_tt")
	simpleClothingTex:setToolTipMap(map)

	gameOption = GameOption:new('simpleClothingTex', simpleClothingTex)
	function gameOption.toUI(self)
		local box = self.control
		box.selected = getCore():getOptionSimpleClothingTextures()
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOptionSimpleClothingTextures(box.selected)
	end
	self.gameOptions:add(gameOption)

	----- SIMPLE WEAPON TEXTURES -----
	local simpleWeaponTex = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_SimpleWeaponTextures"));
	simpleWeaponTex.tooltip = getText("UI_optionscreen_SimpleWeaponTextures_tt");

	gameOption = GameOption:new('simpleWeaponTex', simpleWeaponTex)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1, getCore():getOptionSimpleWeaponTextures())
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOptionSimpleWeaponTextures(box:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	--[[
        -- Disabled because it's too slow to create the mipmaps.
        ----- MODEL TEXTURE MIPMAPS -----
        local modelTextureMipmaps = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_ModelTextureMipmaps"));
        modelTextureMipmaps.tooltip = getText("UI_optionscreen_ModelTextureMipmaps_tt");

        gameOption = GameOption:new('modelTextureMipmaps', modelTextureMipmaps)
        function gameOption.toUI(self)
            local box = self.control
            box:setSelected(1, getCore():getOptionModelTextureMipmaps())
        end
        function gameOption.apply(self)
            local box = self.control
            self:restartRequired(getCore():getOptionModelTextureMipmaps(), box:isSelected(1))
            getCore():setOptionModelTextureMipmaps(box:isSelected(1))
        end
        self.gameOptions:add(gameOption)
    ]]--

	--[[
        ----- NEW ROOF-HIDING -----
        local roofHiding = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_NewRoofHiding"), {getText("UI_Yes"), getText("UI_No")}, 1);
        roofHiding:setToolTipMap({ defaultTooltip = getText("UI_optionscreen_NewRoofHiding_tt") })
        gameOption = GameOption:new('newRoofHiding', roofHiding)
        function gameOption.toUI(self)
            local box = self.control
            if getPerformance():getNewRoofHiding() then
                box.selected = 1
            else
                box.selected = 2
            end
        end
        function gameOption.apply(self)
            local box = self.control
            if box.options[box.selected] then
                getPerformance():setNewRoofHiding(box.selected == 1)
            end
        end
        self.gameOptions:add(gameOption)
    --]]

	self:addHorizontalLine(y, getText("UI_DisplayOptions_RenderingAndPerformance"))

	----- Do bink video effects -----
	local clock24 = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_do_bink_video_effects"))

	gameOption = GameOption:new('doVideoEffects', clock24)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1, getCore():getOptionDoVideoEffects())
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOptionDoVideoEffects(box:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	----- Do Wind sprite effects -----
	local clock24 = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_do_wind_sprite_effects"))

	gameOption = GameOption:new('doWindSpriteEffects', clock24)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1, getCore():getOptionDoWindSpriteEffects())
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOptionDoWindSpriteEffects(box:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	----- Do Door sprite effects -----
	local clock24 = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_do_door_sprite_effects"))

	gameOption = GameOption:new('doDoorSpriteEffects', clock24)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1, getCore():getOptionDoDoorSpriteEffects())
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOptionDoDoorSpriteEffects(box:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	----- Do Container Outline effects -----
	local clock24 = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_do_container_outline"))

	gameOption = GameOption:new('doContainerOutline', clock24)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1, getCore():getOptionDoContainerOutline())
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOptionDoContainerOutline(box:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	----- Render rain when indoors -----
	--[[
    local doRainIndoors = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_render_rain_indoors"))

    gameOption = GameOption:new('renderRainIndoors', doRainIndoors)
    function gameOption.toUI(self)
        local box = self.control
        box:setSelected(1, getCore():isRenderPrecipIndoors())
    end
    function gameOption.apply(self)
        local box = self.control
        getCore():setRenderPrecipIndoors(box:isSelected(1))
    end
    self.gameOptions:add(gameOption)
    --]]

	----- OBJECT HIGHLIGHT COLOR -----
	local ohc = getCore():getObjectHighlitedColor()
	local rgba = {r = ohc:getR(), g = ohc:getG(), b = ohc:getB(), a = 1}
	self.objHighColor = self:addColorButton(splitpoint, y, getText("UI_optionscreen_objHighlightColor"), rgba, MainOptions.onObjHighlightColor)

	self.colorPicker2 = ISColorPicker:new(0, 0)
	self.colorPicker2:initialise()
	self.colorPicker2.pickedTarget = self
	self.colorPicker2.resetFocusTo = self
	self.colorPicker2:setInitialColor(getCore():getObjectHighlitedColor());

	gameOption = GameOption:new('objHighColor', self.objHighColor)
	function gameOption.toUI(self)
		local color = getCore():getObjectHighlitedColor()
		self.control.backgroundColor = {r = color:getR(), g = color:getG(), b = color:getB(), a = 1}
	end
	function gameOption.apply(self)
		local color = self.control.backgroundColor
		local current = getCore():getObjectHighlitedColor()
		if current:getR() == color.r and current:getG() == color.g and current:getB() == color.b then
			return
		end
		getCore():setObjectHighlitedColor(ColorInfo.new(color.r, color.g, color.b, 1))
	end
	self.gameOptions:add(gameOption)
	----- WORKSTATION HIGHLIGHT COLOR -----
	local whc = getCore():getWorkstationHighlitedColor()
	local rgba2 = {r = whc:getR(), g = whc:getG(), b = whc:getB(), a = 1}
	self.workstationHighColor = self:addColorButton(splitpoint, y, getText("UI_optionscreen_workstationHighlightColor"), rgba2, MainOptions.onWorkstationHighlightColor)

	self.colorPicker5 = ISColorPicker:new(0, 0)
	self.colorPicker5:initialise()
	self.colorPicker5.pickedTarget = self
	self.colorPicker5.resetFocusTo = self
	self.colorPicker5:setInitialColor(getCore():getWorkstationHighlitedColor());

	gameOption = GameOption:new('workstationHighColor', self.workstationHighColor)
	function gameOption.toUI(self)
		local color = getCore():getWorkstationHighlitedColor()
		self.control.backgroundColor = {r = color:getR(), g = color:getG(), b = color:getB(), a = 1}
	end
	function gameOption.apply(self)
		local color = self.control.backgroundColor
		local current = getCore():getWorkstationHighlitedColor()
		if current:getR() == color.r and current:getG() == color.g and current:getB() == color.b then
			return
		end
		getCore():setWorkstationHighlitedColor(ColorInfo.new(color.r, color.g, color.b, 1))
	end
	self.gameOptions:add(gameOption)

	----- Zombie update optimization -----
	local zombieUpdateOpt = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_zombie_update_optimization"))
	zombieUpdateOpt.tooltip = getText("UI_optionscreen_zombie_update_optimization_tt")
	gameOption = GameOption:new('zombieUpdateOpt', zombieUpdateOpt)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1, getCore():getOptionTieredZombieUpdates())
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOptionTieredZombieUpdates(box:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	----- BLOOD DECALS -----
	local options = {}
	for i=0,10 do
		table.insert(options, getText("UI_BloodDecals"..i))
	end
	local combo = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_blood_decals"), options, 1)

	gameOption = GameOption:new('bloodDecals', combo)
	function gameOption.toUI(self)
		local box = self.control
		box.selected = getCore():getOptionBloodDecals() + 1
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] then
			getCore():setOptionBloodDecals(box.selected-1)
		end
	end
	self.gameOptions:add(gameOption)

	----- CORPSE SHADOWS -----
	local corpseShadows = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_CorpseShadows"));

	gameOption = GameOption:new('corpseShadows', corpseShadows)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1, getCore():getOptionCorpseShadows())
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOptionCorpseShadows(box:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	----- LIGHTING QUALITY -----
	local lighting = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_lighting"), {getText("UI_High"), getText("UI_Medium"), getText("UI_Low"), getText("UI_Lowest")}, 1);

	gameOption = GameOption:new('lightingQuality', lighting)
	function gameOption.toUI(self)
		local box = self.control
		box.selected = getPerformance():getLightingQuality() + 1
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] then
			getPerformance():setLightingQuality(box.selected-1)
		end
	end
	self.gameOptions:add(gameOption)

	----- LIGHTING FPS -----
	local combo = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_lighting_fps"), {'5', '10', '15 (' .. getText("UI_optionscreen_recommended") .. ')', '20', '25', '30', '45', '60'}, 1)
	map = {}
	map["defaultTooltip"] = getText("UI_optionscreen_lighting_fps_tt")
	combo:setToolTipMap(map)

	gameOption = GameOption:new('lightingFPS', combo)
	function gameOption.toUI(self)
		local box = self.control
		local fps = getPerformance():getLightingFPS()
		local selected = 3
		if fps == 5 then selected = 1 end
		if fps == 10 then selected = 2 end
		if fps == 15 then selected = 3 end
		if fps == 20 then selected = 4 end
		if fps == 25 then selected = 5 end
		if fps == 30 then selected = 6 end
		if fps == 45 then selected = 7 end
		if fps == 60 then selected = 8 end
		box.selected = selected
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] then
			-- handle (RECOMMENDED)
			local s = box.options[box.selected]
			local v = s:split(' ')
			getPerformance():setLightingFPS(tonumber(v[1]))
		end
	end
	self.gameOptions:add(gameOption)

	----- Performance skybox -----
	local perf_skybox;
	perf_skybox = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_perf_skybox"), {getText("UI_High"), getText("UI_Medium"), getText("UI_No")}, 1);

	gameOption = GameOption:new('perf_skybox', perf_skybox)
	function gameOption.toUI(self)
		local box = self.control
		box.selected = getCore():getPerfSkybox() + 1
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] then
			getCore():setPerfSkybox(box.selected-1)
			if getCore():getPerfSkyboxOnLoad() ~= getCore():getPerfSkybox() then
				self:restartRequired(getCore():getPerfSkyboxOnLoad(), getCore():getPerfSkybox())
			end
		end
	end
	self.gameOptions:add(gameOption)

	----- Water QUALITY -----
	local water = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_water"), {getText("UI_High"), getText("UI_Medium"), getText("UI_Low")}, 1);

	gameOption = GameOption:new('waterQuality', water)
	function gameOption.toUI(self)
		local box = self.control
		box.selected = getPerformance():getWaterQuality() + 1
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] then
			getPerformance():setWaterQuality(box.selected-1)
		end
	end
	self.gameOptions:add(gameOption)

	----- Performance Puddles -----
	local perf_puddles;
	perf_puddles = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_perf_puddles"), {getText("UI_All"), getText("UI_GroundWithRuts"), getText("UI_GroundOnly"), getText("UI_None")}, 1);

	gameOption = GameOption:new('perf_puddles', perf_puddles)
	function gameOption.toUI(self)
		local box = self.control
		box.selected = getCore():getPerfPuddles() + 1
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] then
			getCore():setPerfPuddles(box.selected-1)
			if (getCore():getPerfPuddlesOnLoad() ~= getCore():getPerfPuddles()) and (getCore():getPerfPuddlesOnLoad() == 3) then
				self:restartRequired(getCore():getPerfPuddlesOnLoad(), getCore():getPerfPuddles())
			end
		end
	end
	self.gameOptions:add(gameOption)

	----- Puddles QUALITY -----
	local puddles = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_puddles"), {getText("UI_High"), getText("UI_Medium"), getText("UI_Low")}, 1);

	gameOption = GameOption:new('puddlesQuality', puddles)
	function gameOption.toUI(self)
		local box = self.control
		box.selected = getPerformance():getPuddlesQuality() + 1
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] then
			getPerformance():setPuddlesQuality(box.selected-1)
		end
	end
	self.gameOptions:add(gameOption)

	----- Performance reflections -----
	local perf_reflections;
	perf_reflections = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_perf_reflections"));

	gameOption = GameOption:new('perf_reflections', perf_reflections)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1, getCore():getPerfReflections())
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setPerfReflections(box:isSelected(1))
		if getCore():getPerfReflectionsOnLoad() ~= getCore():getPerfReflections() then
			self:restartRequired(getCore():getPerfReflectionsOnLoad(), getCore():getPerfReflections())
		end
	end
	self.gameOptions:add(gameOption)

	----- Display 3D Items -----
	local v3Ditem;
	v3Ditem = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_perf_3Ditems"));

	gameOption = GameOption:new('perf_3Ditems', v3Ditem)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1, getCore():isOption3DGroundItem())
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOption3DGroundItem(box:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	----- High resolution placed items -----
	local highResPlacedItems = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_HighResPlacedItems"));

	gameOption = GameOption:new('highResPlacedItems', highResPlacedItems)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1, getCore():getOptionHighResPlacedItems())
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOptionHighResPlacedItems(box:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	----- Precipitation -----
	local precipOption = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_render_precipitation"), { getText("UI_optionscreen_render_precipAlways"), getText("UI_optionscreen_render_precipOutdoors"), getText("UI_optionscreen_render_precipNever") }, 1)

	gameOption = GameOption:new('precipOption', precipOption)
	function gameOption.toUI(self)
		local box = self.control
		box.selected = getCore():getOptionRenderPrecipitation()
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] then
			getCore():setOptionRenderPrecipitation(box.selected)
		end
	end
	self.gameOptions:add(gameOption)

	----- Precipitation Speed Multiplier -----
	local slider = self:addSlider(splitpoint, y, comboWidth, getText("UI_optionscreen_PrecipitationSpeedMultiplier"), 0.01, 1, 0.01, 0.1)
	gameOption = GameOption:new('precipitationSpeedMultiplier', slider)
	function gameOption.storeCurrentValue(self)
		self.originalValue = getCore():getOptionPrecipitationSpeedMultiplier()
	end
	function gameOption.restoreOriginalValue(self)
		getCore():setOptionPrecipitationSpeedMultiplier(self.originalValue)
	end
	function gameOption.toUI(self)
		local value = getCore():getOptionPrecipitationSpeedMultiplier()
		self.control:setCurrentValue(value)
		self.control.label:setName(string.format("%.2f", value))
	end
	function gameOption.onChange(self, value)
		getCore():setOptionPrecipitationSpeedMultiplier(value)
		self.control.label:setName(string.format("%.2f", value))
	end
	function gameOption.apply(self)
		getCore():setOptionPrecipitationSpeedMultiplier(self.control:getCurrentValue())
	end
	self.gameOptions:add(gameOption)

	----- Fog QUALITY -----
	local newfog = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_fog_quality"), {getText("UI_High"), getText("UI_Medium"), getText("UI_optionscreen_legacy")}, 1);

	gameOption = GameOption:new('fogQuality', newfog)
	function gameOption.toUI(self)
		local box = self.control
		box.selected = getPerformance():getFogQuality() + 1
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] then
			getPerformance():setFogQuality(box.selected-1)
		end
	end
	self.gameOptions:add(gameOption)

	-- SEARCH MODE OVERLAY EFFECT
	local overlayEffect = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_Search_Mode_Overlay_Effect_Label"),
			{
				getText("UI_optionscreen_Search_Mode_Overlay_Effect_Both"),
				getText("UI_optionscreen_Search_Mode_Overlay_Effect_Blur"),
				getText("UI_optionscreen_Search_Mode_Overlay_Effect_Desaturate"),
				getText("UI_optionscreen_Search_Mode_Overlay_Effect_None"),
			},
			1)

	gameOption = GameOption:new('searchModeOverlayEffect', overlayEffect);
	function gameOption.toUI(self)
		local box = self.control
		box.selected = getCore():getOptionSearchModeOverlayEffect();
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] then
			getCore():setOptionSearchModeOverlayEffect(box.selected);
		end
	end
	self.gameOptions:add(gameOption);

	self.mainPanel:setScrollHeight(y + self.addY + 20)
end

function MainOptions:addUIPanel()
	local y = INITIAL_Y;
	self.addY = 0
	local splitpoint = self:getWidth() / 2;
	local comboWidth = 45 * (getCore():getOptionFontSizeReal() +1) + 60

	self:addPage(getText("UI_optionscreen_UI"))

	----- UI -----
	self:addHorizontalLine(y, getText("UI_DisplayOptions_UI"))

	----- UI FBO -----
	local UIFBO = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_UIFBO"))
	UIFBO.tooltip = getText("UI_optionscreen_UIFBO_tt")

	gameOption = GameOption:new('UIFBO', UIFBO)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1, getCore():getOptionUIFBO())
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOptionUIFBO(box:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	----- UI RENDER FPS -----
	local UIRenderFPS = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_UIRenderFPS"), {"30", "25", "20", "15", "10"}, 2)
	local map = {}
	map["defaultTooltip"] = getText("UI_optionscreen_UIRenderFPS_tt")
	UIRenderFPS:setToolTipMap(map)

	gameOption = GameOption:new("UIRenderFPS", UIRenderFPS)
	function gameOption.toUI(self)
		local box = self.control
		local fps = getCore():getOptionUIRenderFPS()
		if fps == 30 then box.selected = 1
		elseif fps == 25 then box.selected = 2
		elseif fps == 20 then box.selected = 3
		elseif fps == 15 then box.selected = 4
		elseif fps == 10 then box.selected = 5
		end
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] then
			local fpsTable = {30, 25, 20, 15, 10}
			getCore():setOptionUIRenderFPS(fpsTable[box.selected])
		end
	end
	self.gameOptions:add(gameOption)

	----- INVENTORY CONTAINER SIZE -----
	local containerSize = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_InventoryContainerSize"), { getText("UI_optionscreen_Small"), getText("UI_optionscreen_Medium"), getText("UI_optionscreen_Large") }, 1)

	gameOption = GameOption:new('inventoryContainerSize', containerSize)
	function gameOption.toUI(self)
		local box = self.control
		box.selected = getCore():getOptionInventoryContainerSize()
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] then
			getCore():setOptionInventoryContainerSize(box.selected)
			if MainScreen.instance.inGame then
				ISInventoryPage.ContainerSizeChanged()
			end
		end
	end
	self.gameOptions:add(gameOption)

	----- Show Item Mod Info -----
	local clock24 = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_Show_Item_Mod_Info"))

	gameOption = GameOption:new('showItemModInfo', clock24)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1, getCore():getOptionShowItemModInfo())
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOptionShowItemModInfo(box:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	----- Show Survival Guide -----
	local survivalGuide = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_ShowSurvivalGuide"))

	gameOption = GameOption:new('showSurvivalGuide', survivalGuide)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1, getCore():getOptionShowSurvivalGuide())
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOptionShowSurvivalGuide(box:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	----- ACTION PROGRESS BAR SIZE -----

	local actionProgressBarSize = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_ActionProgressBarSize"), { getText("UI_optionscreen_ActionProgressBarSize1"), getText("UI_optionscreen_ActionProgressBarSize2"), getText("UI_optionscreen_ActionProgressBarSize3"), getText("UI_optionscreen_ActionProgressBarSize4") }, 1)

	gameOption = GameOption:new('actionProgressBarSize', actionProgressBarSize)
	function gameOption.toUI(self)
		local box = self.control
		box.selected = getCore():getOptionActionProgressBarSize()
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] then
			if getCore():getOptionActionProgressBarSize() ~= box.selected then
				getCore():setOptionActionProgressBarSize(box.selected)
			end
		end
	end
	self.gameOptions:add(gameOption)

	----- MOODLE SIZE -----

	local moodleSize = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_MoodleSize"), { getText("UI_optionscreen_MoodleSize0"), getText("UI_optionscreen_MoodleSize1"), getText("UI_optionscreen_MoodleSize2"), getText("UI_optionscreen_MoodleSize3"), getText("UI_optionscreen_MoodleSize4"), getText("UI_optionscreen_MoodleSize5"), getText("UI_optionscreen_MoodleSize6") }, 1)
	local tooltipMoodleSize = {}
	tooltipMoodleSize["defaultTooltip"] = getText("UI_optionscreen_MoodleSize_tt")
	moodleSize:setToolTipMap(tooltipMoodleSize)

	gameOption = GameOption:new('moodleSize', moodleSize)
	function gameOption.toUI(self)
		local box = self.control
		box.selected = getCore():getOptionMoodleSize()
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] then
			if getCore():getOptionMoodleSize() ~= box.selected then
				getCore():setOptionMoodleSize(box.selected)
			end
		end
	end
	self.gameOptions:add(gameOption)

	self:addHorizontalLine(y, getText("UI_DisplayOptions_Fonts"))

	----- FONT SIZE -----
	local fontSize = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_FontSize"), { getText("UI_optionscreen_FontSize0"), getText("UI_optionscreen_FontSize1"), getText("UI_optionscreen_FontSize2"), getText("UI_optionscreen_FontSize3"), getText("UI_optionscreen_FontSize4"), getText("UI_optionscreen_FontSize5") }, 6)

	if MainScreen.instance.inGame then
		local tooltipMap = {}
		tooltipMap["defaultTooltip"] = getText("UI_optionscreen_needreboot")
		fontSize:setToolTipMap(tooltipMap)
	end

	gameOption = GameOption:new('fontSize', fontSize)
	function gameOption.toUI(self)
		local box = self.control
		box.selected = getCore():getOptionFontSize()
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] then
			if getCore():getOptionFontSize() ~= box.selected then
				getCore():setOptionFontSize(box.selected)
				self:resetLua()
			end
		end
	end
	self.gameOptions:add(gameOption)

	----- CONTEXT-MENU FONT -----
	local menuFont = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_context_menu_font"), { getText("UI_optionscreen_Small"), getText("UI_optionscreen_Medium"), getText("UI_optionscreen_Large") }, 2)

	gameOption = GameOption:new('contextMenuFont', menuFont)
	function gameOption.toUI(self)
		local box = self.control
		if getCore():getOptionContextMenuFont() == "Small" then
			box.selected = 1
		elseif getCore():getOptionContextMenuFont() == "Large" then
			box.selected = 3
		else
			box.selected = 2
		end
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] then
			local choices = { "Small", "Medium", "Large" }
			getCore():setOptionContextMenuFont(choices[box.selected])
		end
	end
	self.gameOptions:add(gameOption)

	----- INVENTORY FONT -----
	local invFont = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_inventory_font"), { getText("UI_optionscreen_Small"), getText("UI_optionscreen_Medium"), getText("UI_optionscreen_Large") }, 2)

	gameOption = GameOption:new('inventoryFont', invFont)
	function gameOption.toUI(self)
		local box = self.control
		if getCore():getOptionInventoryFont() == "Small" then
			box.selected = 1
		elseif getCore():getOptionInventoryFont() == "Large" then
			box.selected = 3
		else
			box.selected = 2
		end
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] then
			local choices = { "Small", "Medium", "Large" }
			getCore():setOptionInventoryFont(choices[box.selected])
			if MainScreen.instance.inGame then
				ISInventoryPage.onInventoryFontChanged()
			end
		end
	end
	self.gameOptions:add(gameOption)

	----- TOOLTIP FONT -----
	local ttFont = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_tooltip_font"), { getText("UI_optionscreen_Small"), getText("UI_optionscreen_Medium"), getText("UI_optionscreen_Large") }, 2)

	gameOption = GameOption:new('tooltipFont', ttFont)
	function gameOption.toUI(self)
		local box = self.control
		if getCore():getOptionTooltipFont() == "Small" then
			box.selected = 1
		elseif getCore():getOptionTooltipFont() == "Large" then
			box.selected = 3
		else
			box.selected = 2
		end
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] then
			local choices = { "Small", "Medium", "Large" }
			getCore():setOptionTooltipFont(choices[box.selected])
		end
	end
	self.gameOptions:add(gameOption)

	self:addHorizontalLine(y, getText("UI_DisplayOptions_Camera"))

	----- ZOOM ON/OFF -----
	local zoom = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_zoom"))

	gameOption = GameOption:new('zoom', zoom)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1, getCore():getOptionZoom())
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOptionZoom(box:isSelected(1))
		getCore():zoomOptionChanged(MainScreen.instance.inGame)
	end
	self.gameOptions:add(gameOption)

	----- ZOOM LEVELS -----
	label = ISLabel:new(splitpoint, y + self.addY, FONT_HGT_SMALL, getText("UI_optionscreen_zoomlevels"), 1, 1, 1, 1, UIFont.Small, false)
	label:initialise()
	self.mainPanel:addChild(label)
	local zoomLevelsTickBox = ISTickBox:new(splitpoint + 20, y + self.addY, BUTTON_HGT, BUTTON_HGT, "HELLO?")
	zoomLevelsTickBox.choicesColor = {r=1, g=1, b=1, a=1}
	zoomLevelsTickBox:initialise()
	self.mainPanel:addChild(zoomLevelsTickBox)
	self.mainPanel:insertNewLineOfButtons(zoomLevelsTickBox)
	-- Must addChild *before* addOption() or ISUIElement:getKeepOnScreen() will restrict y-position to screen height
	local zoomLevels = getCore():getDefaultZoomLevels()
	for i = 1,zoomLevels:size() do
		local percent = zoomLevels:get(i-1)
		if percent ~= 100 then
			zoomLevelsTickBox:addOption(getText("IGUI_BackButton_Zoom", percent), tostring(percent))
		end
	end
	self.addY = self.addY + zoomLevelsTickBox:getHeight() + UI_BORDER_SPACING

	gameOption = GameOption:new('zoomLevels', zoomLevelsTickBox)
	function gameOption.toUI(self)
		local box = self.control
		local percentsStr = (Core.getTileScale() == 2) and
				getCore():getOptionZoomLevels2x() or
				getCore():getOptionZoomLevels1x()
		local percents = luautils.split(percentsStr, ";")
		for i = 1,#box.options do
			box:setSelected(i, (#percents == 0) or self:tableContains(percents, box.optionData[i]))
		end
	end
	function gameOption.apply(self)
		local box = self.control
		local s = ""
		for i = 1,#box.options do
			if box:isSelected(i) then
				if s ~= "" then s = s .. ";" end
				s = s .. box.optionData[i]
			end
		end
		if Core.getTileScale() == 2 and s ~= getCore():getOptionZoomLevels2x() then
			getCore():setOptionZoomLevels2x(s)
			getCore():zoomLevelsChanged()
		elseif Core.getTileScale() == 1 and s ~= getCore():getOptionZoomLevels1x() then
			getCore():setOptionZoomLevels1x(s)
			getCore():zoomLevelsChanged()
		end
	end
	function gameOption.tableContains(self, table, item)
		for _,v in pairs(table) do
			if v == item then return true end
		end
		return false
	end
	self.gameOptions:add(gameOption)

	----- AUTO-ZOOM -----
	label = ISLabel:new(splitpoint, y + self.addY, FONT_HGT_SMALL, getText("UI_optionscreen_autozoom"), 1, 1, 1, 1, UIFont.Small, false)
	label:initialise()
	self.mainPanel:addChild(label)
	local autozoomTickBox = ISTickBox:new(splitpoint + 20, y + self.addY, BUTTON_HGT, BUTTON_HGT, "HELLO?")
	autozoomTickBox.choicesColor = {r=1, g=1, b=1, a=1}
	autozoomTickBox:initialise();
	self.mainPanel:addChild(autozoomTickBox)
	self.mainPanel:insertNewLineOfButtons(autozoomTickBox)
	-- Must addChild *before* addOption() or ISUIElement:getKeepOnScreen() will restrict y-position to screen height
	for i = 1,4 do
		autozoomTickBox:addOption(getText("UI_optionscreen_player"..i), nil)
	end
	self.addY = self.addY + autozoomTickBox:getHeight() + UI_BORDER_SPACING

	gameOption = GameOption:new('autoZoom', autozoomTickBox)
	function gameOption.toUI(self)
		local box = self.control
		for i = 1,4 do
			box:setSelected(i, getCore():getAutoZoom(i-1))
		end
	end
	function gameOption.apply(self)
		local box = self.control
		for i = 1,4 do
			getCore():setAutoZoom(i-1, box:isSelected(i))
		end
	end
	self.gameOptions:add(gameOption)

	----- PAN CAMERA WHILE AIMING -----
	local panCameraWhileAiming = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_panCameraWhileAiming"))

	gameOption = GameOption:new('panCameraWhileAiming', panCameraWhileAiming)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1, getCore():getOptionPanCameraWhileAiming())
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOptionPanCameraWhileAiming(box:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	----- PAN CAMERA WHILE DRIVING -----
	local panCameraWhileDriving = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_panCameraWhileDriving"))

	gameOption = GameOption:new('panCameraWhileDriving', panCameraWhileDriving)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1, getCore():getOptionPanCameraWhileDriving())
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOptionPanCameraWhileDriving(box:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	self:addHorizontalLine(y, getText("UI_DisplayOptions_Cursor"))

	----- ISO CURSOR -----
	options = {}
	table.insert(options, getText("UI_Off"))
	table.insert(options, "5%")
	table.insert(options, "10%")
	table.insert(options, "15%")
	table.insert(options, "30%")
	table.insert(options, "50%")
	table.insert(options, "75%")

	local combo = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_iso_cursor"), options, 3)

	gameOption = GameOption:new('iso_cursor', combo)
	function gameOption.toUI(self)
		self.control.selected = getCore():getIsoCursorVisibility()+1;
	end
	function gameOption.apply(self)
		if self.control.options[self.control.selected] then
			getCore():setIsoCursorVisibility(self.control.selected-1)
		end
	end
	self.gameOptions:add(gameOption)

	----- SHOW CURSOR WHILE AIMING -----
	local showCursorWhileAiming = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_ShowCursorWhileAiming"));
	showCursorWhileAiming.tooltip = getText("UI_optionscreen_ShowCursorWhileAiming_tt");

	gameOption = GameOption:new('showCursorWhileAiming', showCursorWhileAiming)
	function gameOption.toUI(self)
		self.control:setSelected(1, getCore():getOptionShowCursorWhileAiming())
	end
	function gameOption.apply(self)
		getCore():setOptionShowCursorWhileAiming(self.control:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	----- MELEE OUTLINE -----
	local meleeOutline = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_melee_outline"))
	meleeOutline.tooltip = getText("UI_optionscreen_melee_outline_tt")

	gameOption = GameOption:new('meleeOutline', meleeOutline)
	function gameOption.toUI(self)
		self.control:setSelected(1, getCore():getOptionMeleeOutline())
	end
	function gameOption.apply(self)
    	getCore():setOptionMeleeOutline(self.control:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	----- LOCK CURSOR TO WINDOW -----
	local combo = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_LockCursorToWindow"))
	combo.tooltip = getText("UI_optionscreen_LockCursorToWindow_tt")

	gameOption = GameOption:new('lockCursorToWindow', combo)
	function gameOption.toUI(self)
		self.control:setSelected(1, getCore():getOptionLockCursorToWindow())
	end
	function gameOption.apply(self)
		getCore():setOptionLockCursorToWindow(self.control:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	----- RETICLE -----
	self:addHorizontalLine(y, getText("UI_DisplayOptions_Reticle"))

	local combo = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_OptionScreen_ReticleMode"), {getText("UI_OptionScreen_ReticleMode0"), getText("UI_OptionScreen_ReticleMode1")}, 0)
	local map = {}
	--  map["defaultTooltip"] = getText("UI_OtpionScreen_ReticleMode_tt")
	--	reticleMode:setToolTipMap(map)

	gameOption = GameOption:new("reticleMode", combo)
	function gameOption.toUI(self)
		local mode = getCore():getOptionReticleMode()
		if mode == 0 then self.control.selected = 1
		elseif mode == 1 then self.control.selected = 2
		end
	end
	function gameOption.apply(self)
		if self.control.options[self.control.selected] then
			local modeTable = {0, 1}
			getCore():setOptionReticleMode(modeTable[self.control.selected])
		end
	end
	self.gameOptions:add(gameOption)

	--	local showAimTexture = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_OptionScreen_ShowAimTexture"))
	-- showAimTexture.tooltip = getText("UI_OptionScreen_ShowAimTexture_tt");
	gameOption = GameOption:new('showAimTexture', self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_OptionScreen_ShowAimTexture")))
	function gameOption.toUI(self)
		self.control:setSelected(1, getCore():getOptionShowAimTexture())
	end
	function gameOption.apply(self)
		getCore():setOptionShowAimTexture(self.control:isSelected(1))
	end
	self.gameOptions:add(gameOption)

--   local aimTexture = self:addCombo(splitpoint,y,comboWidth,20,"AimTexture", {"0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17"},0)
   gameOption = GameOption:new("aimTexture", self:addCombo(splitpoint,y,comboWidth,20,getText("UI_OptionScreen_AimTexture"), {"0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17"},0))
    function gameOption.toUI(self)
        self.control.selected = getCore():getOptionAimTextureIndex() + 1
    end
    function gameOption.apply(self)
        if self.control.options[self.control.selected] then
            getCore():setOptionAimTextureIndex(self.control.selected - 1)
        end
    end
    self.gameOptions:add(gameOption)

	--	local showReticleTexture = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_OptionScreen_ShowReticleTexture"))
	-- showAimTexture.tooltip = getText("UI_OptionScreen_ShowReticleTexture_tt");
	gameOption = GameOption:new('showReticleTexture', self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_OptionScreen_ShowReticleTexture")))
	function gameOption.toUI(self)
		self.control:setSelected(1, getCore():getOptionShowReticleTexture())
	end
	function gameOption.apply(self)
		getCore():setOptionShowReticleTexture(self.control:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	--    local reticleTexture = self:addCombo(splitpoint,y,comboWidth,20,"ReticleTexture", {"0","1","2","3","4","5","6"},0)
	gameOption = GameOption:new("reticleTexture", self:addCombo(splitpoint,y,comboWidth,20,getText("UI_OptionScreen_ReticleTexture"), {"0","1","2","3","4","5","6"},0))
	function gameOption.toUI(self)
		self.control.selected = getCore():getOptionReticleTextureIndex() + 1
	end
	function gameOption.apply(self)
		if self.control.options[self.control.selected] then
			getCore():setOptionReticleTextureIndex(self.control.selected - 1)
		end
	end
	self.gameOptions:add(gameOption)

	--	local showValidTargetReticleTexture = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_OptionScreen_ShowValidTargetReticleTexture"))
	-- showAimTexture.tooltip = getText("UI_OptionScreen_ShowValidTargetReticleTexture_tt")
	gameOption = GameOption:new('showValidTargetReticleTexture', self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_OptionScreen_ShowValidTargetReticleTexture")))
	function gameOption.toUI(self)
		self.control:setSelected(1, getCore():getOptionShowValidTargetReticleTexture())
	end
	function gameOption.apply(self)
		getCore():setOptionShowValidTargetReticleTexture(self.control:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	--    local validTargetReticleTexture = self:addCombo(splitpoint,y,comboWidth,20,"ValidTargetReticleTexture", {"0","1","2","3","4","5","6"},0)
	gameOption = GameOption:new("validTargetReticleTexture", self:addCombo(splitpoint,y,comboWidth,20,getText("UI_OptionScreen_ValidTargetReticleTexture"), {"0","1","2","3","4","5","6"},0))
	function gameOption.toUI(self)
		self.control.selected = getCore():getOptionValidTargetReticleTextureIndex() + 1
	end
	function gameOption.apply(self)
		if self.control.options[self.control.selected] then
			getCore():setOptionValidTargetReticleTextureIndex(self.control.selected - 1)
		end
	end
	self.gameOptions:add(gameOption)

	local targetColor = getCore():getTargetColor()
	local rgba = {r = targetColor:getR(), g = targetColor:getG(), b = targetColor:getB(), a = 1}
	self.targetColor = self:addColorButton(splitpoint, y, getText("UI_OptionScreen_TargetColor"), rgba, MainOptions.onTargetColor)

	--	if MainScreen.instance.inGame then
	--		self.targetColor.tooltip = getText("UI_OptionScreen_TargetColor_tt")
	--	end

	self.colorPicker5 = ISColorPicker:new(0, 0)
	self.colorPicker5:initialise()
	self.colorPicker5.pickedTarget = self
	self.colorPicker5.resetFocusTo = self
	self.colorPicker5:setInitialColor(getCore():getTargetColor());

	gameOption = GameOption:new('targetColor', self.targetColor)
	function gameOption.toUI(self)
		local color = getCore():getTargetColor()
		self.control.backgroundColor = {r = color:getR(), g = color:getG(), b = color:getB(), a = 1}
	end
	function gameOption.apply(self)
		local color = self.control.backgroundColor
		local current = getCore():getTargetColor()
		if current:getR() == color.r and current:getG() == color.g and current:getB() == color.b then
			return
		end
		getCore():setTargetColor(ColorInfo.new(color.r, color.g, color.b, 1))
	end
	self.gameOptions:add(gameOption)

	local noTargetColor = getCore():getNoTargetColor()
	local rgba = {r = noTargetColor:getR(), g = noTargetColor:getG(), b = noTargetColor:getB(), a = 1}
	self.noTargetColor = self:addColorButton(splitpoint, y, getText("UI_OptionScreen_NoTargetColor"), rgba, MainOptions.onNoTargetColor)

	--	if MainScreen.instance.inGame then
	--		self.noTargetColor.tooltip = getText("UI_OptionScreen_NoTargetColor_tt")
	--	end

	self.colorPicker6 = ISColorPicker:new(0, 0)
	self.colorPicker6:initialise()
	self.colorPicker6.pickedTarget = self
	self.colorPicker6.resetFocusTo = self
	self.colorPicker6:setInitialColor(getCore():getNoTargetColor());

	gameOption = GameOption:new('noTargetColor', self.noTargetColor)
	function gameOption.toUI(self)
		local color = getCore():getNoTargetColor()
		self.control.backgroundColor = {r = color:getR(), g = color:getG(), b = color:getB(), a = 1}
	end
	function gameOption.apply(self)
		local color = self.control.backgroundColor
		local current = getCore():getNoTargetColor()
		if current:getR() == color.r and current:getG() == color.g and current:getB() == color.b then
			return
		end
		getCore():setNoTargetColor(ColorInfo.new(color.r, color.g, color.b, 1))
	end
	self.gameOptions:add(gameOption)

	--    local crosshairTexture = self:addCombo(splitpoint,y,comboWidth,20,"CrosshairTexture", {"0","1","2"},0)
	gameOption = GameOption:new("crosshairTexture", self:addCombo(splitpoint,y,comboWidth,20,getText("UI_OptionScreen_CrosshairTexture"), {"0","1","2"},0))
	function gameOption.toUI(self)
		self.control.selected = getCore():getOptionCrosshairTextureIndex() + 1;
	end
	function gameOption.apply(self)
		if self.control.options[self.control.selected] then
			getCore():setOptionCrosshairTextureIndex(self.control.selected - 1)
		end
	end
	self.gameOptions:add(gameOption)

	--	local maxCrosshairOffset = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_OptionScreen_MaxCrosshairOffset"), {"100%", "90%", "80%", "70%", "60%", "50%", "40%", "30%", "20%", "10%", "05%"}, 11)
	gameOption = GameOption:new('maxCrosshairOffset', self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_OptionScreen_MaxCrosshairOffset"), {"100%", "90%", "80%", "70%", "60%", "50%", "40%", "30%", "20%", "10%", "05%"}, 11))
	function gameOption.toUI(self)
		local crosshairOffset = getCore():getOptionMaxCrosshairOffset()
		if crosshairOffset == 100 then self.control.selected = 1
		elseif crosshairOffset == 90 then self.control.selected = 2
		elseif crosshairOffset == 80 then self.control.selected = 3
		elseif crosshairOffset == 70 then self.control.selected = 4
		elseif crosshairOffset == 60 then self.control.selected = 5
		elseif crosshairOffset == 50 then self.control.selected = 6
		elseif crosshairOffset == 40 then self.control.selected = 7
		elseif crosshairOffset == 30 then self.control.selected = 8
		elseif crosshairOffset == 20 then self.control.selected = 9
		elseif crosshairOffset == 10 then self.control.selected = 10
		elseif crosshairOffset == 5 then self.control.selected = 11
		end
	end
	function gameOption.apply(self)
		if self.control.options[self.control.selected] then
			local crosshairMaxTable = {100,90,80,70,60,50,40,30,20,10,5}
			getCore():setOptionMaxCrosshairOffset(crosshairMaxTable[self.control.selected])
		end
	end
	self.gameOptions:add(gameOption)

	--	local reticleCameraZoom = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_OptionScreen_ReticleCameraZoom"))
	-- showAimTexture.tooltip = getText("UI_OptionScreen_ReticleCameraZoom_tt");
	gameOption = GameOption:new('reticleCameraZoom', self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_OptionScreen_ReticleCameraZoom")))
	function gameOption.toUI(self)
		self.control:setSelected(1, getCore():getOptionReticleCameraZoom())
	end
	function gameOption.apply(self)
		getCore():setOptionReticleCameraZoom(self.control:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	self:addHorizontalLine(y, getText("UI_DisplayOptions_Clock"))

	----- CLOCK FORMAT -----
	local clockFmt = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_clock_format"), { getText("UI_optionscreen_clock_month_day"), getText("UI_optionscreen_clock_day_month") }, 1)
	gameOption = GameOption:new('clockFormat', clockFmt)
	function gameOption.toUI(self)
		local box = self.control
		box.selected = getCore():getOptionClockFormat()
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] then
			getCore():setOptionClockFormat(box.selected)
		end
	end
	self.gameOptions:add(gameOption)

	----- CLOCK SIZE -----
	local clockSize = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_clock_Size"), { getText("UI_optionscreen_clock_small"), getText("UI_optionscreen_clock_large") }, 1)
	if MainScreen.instance.inGame then
		local tooltipMap = {}
		tooltipMap["defaultTooltip"] = getText("UI_optionscreen_needreboot")
		clockSize:setToolTipMap(tooltipMap)
	end
	gameOption = GameOption:new('clockSize', clockSize)
	function gameOption.toUI(self)
		local box = self.control
		box.selected = getCore():getOptionClockSize()
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] then
			getCore():setOptionClockSize(box.selected)
		end
	end
	self.gameOptions:add(gameOption)

	----- CLOCK 24-HOUR -----
	local clock24 = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_clock_24_or_12"), { getText("UI_optionscreen_clock_24_hour"), getText("UI_optionscreen_clock_12_hour") }, 1)
	gameOption = GameOption:new('clock24hour', clock24)
	function gameOption.toUI(self)
		local box = self.control
		box.selected = getCore():getOptionClock24Hour() and 1 or 2
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] then
			getCore():setOptionClock24Hour(box.selected == 1)
		end
	end
	self.gameOptions:add(gameOption)

	----- Temperature display -----
	local clock24 = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_temperature_display"), { getText("UI_optionscreen_temperature_fahrenheit"), getText("UI_optionscreen_temperature_celsius") }, 1)
	gameOption = GameOption:new('temperatureDisplay', clock24)
	function gameOption.toUI(self)
		--		local box = self.control
		self.control.selected = getCore():getOptionDisplayAsCelsius() and 2 or 1
	end
	function gameOption.apply(self)
		--		local box = self.control
		if self.control.options[self.control.selected] then
			getCore():setOptionDisplayAsCelsius(self.control.selected == 2)
		end
	end
	self.gameOptions:add(gameOption)

	----- LANGUAGE -----
	self:addHorizontalLine(y, getText("UI_DisplayOptions_Language"))
	local availableLanguage,currentIndex = MainOptions.getAvailableLanguage();
	local language = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_language"), availableLanguage, currentIndex);
	if MainScreen.instance.inGame == true then
		language:setToolTipMap(MainOptions.doLanguageToolTip(availableLanguage));
	end
	gameOption = GameOption:new('language', language)
	function gameOption.toUI(self)
		local box = self.control
		box:select(Translator.getLanguage():name())
		self:onChange(box);
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] then
			local languages = Translator.getAvailableLanguage()
			for i=1,languages:size() do
				local language = languages:get(i-1)
				if language:text() == box.options[box.selected] then
					if Translator.getLanguage():index() ~= language:index() then
						getCore():setOptionLanguageName(language:name())
						Translator.setLanguage(language)
						self:resetLua()
					end
					break
				end
			end
		end
	end
	function gameOption:onChange(box)
		local panel = MainOptions.instance.tabs:getView(getText("UI_optionscreen_UI"))
		local oldH = panel:getScrollHeight()-MainOptions.instance.translatorPane:getHeight();

		local languages = Translator.getAvailableLanguage()
		local curLang = nil;
		for i=1,languages:size() do
			if languages:get(i-1):text() == box.options[box.selected] then
				curLang = languages:get(i-1);
				break;
			end
		end

		local text = getText("UI_optionscreen_general_content").." "..getText("UI_optionscreen_translatedBy"):lower()..": \n";
		for k,v in ipairs(MainOptions.getGeneralTranslators(curLang)) do
			text = text .. " - " .. v .. "\n";
		end
		local names = curLang and getRadioTranslators(curLang) or nil;
		if names ~= nil and names:size() == 1 and names:get(0) == "unknown" then
			-- "unknown" is the default WordZed name. Nasko asked to display nothing instead of "unknown".
		else
			text = text .. "\n" .. getText("UI_optionscreen_radio_content").." "..getText("UI_optionscreen_translatedBy"):lower()..": \n";
			if names and names:size()>0 then
				for i=1,names:size() do
					if names:get(i-1) ~= "unknown" then
						text = text .." - ".. names:get(i-1).."\n";
					end
				end
			else
				text = text .. " - "..getText("UI_optionscreen_no_translators").." -\n";
			end
		end
		if box.options[box.selected]=="English" then
			text = getText("UI_optionscreen_default_lang");
		end
		MainOptions.instance.translatorPane.text = text;
		MainOptions.instance.translatorPane:paginate();
		panel:setScrollHeight(oldH+MainOptions.instance.translatorPane:getHeight())
	end
	self.gameOptions:add(gameOption)

	--local v3Ditem;
	--v3Ditem = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_perf_3Ditems"));
	--
	--gameOption = GameOption:new('perf_3Ditems', v3Ditem)
	--function gameOption.toUI(self)
	--	local box = self.control
	--	box:setSelected(1, getCore():isOption3DGroundItem())
	--end
	--function gameOption.apply(self)
	--	local box = self.control
	--	getCore():setOption3DGroundItem(box:isSelected(1))
	--end
	--self.gameOptions:add(gameOption)



	--local communityContentTickBox = ISTickBox:new(splitpoint + 20, y + self.addY, 200, BUTTON_HGT, "HELLO?")
	--communityContentTickBox.choicesColor = {r=1, g=1, b=1, a=1}
	--communityContentTickBox:initialise();
	---- Must addChild *before* addOption() or ISUIElement:getKeepOnScreen() will restrict y-position to screen height
	--self.mainPanel:addChild(communityContentTickBox)
	--communityContentTickBox:addOption(getText("UI_optionscreen_tickbox_comlang"), nil)
	--self.mainPanel:insertNewLineOfButtons(communityContentTickBox)
	--self.addY = self.addY + communityContentTickBox:getHeight()

	local communityContentTickBox = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_tickbox_comlang"));

	gameOption = GameOption:new('comlang', communityContentTickBox)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1, getCore():getContentTranslationsEnabled()); -- getCore():getAutoZoom(i-1))
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setContentTranslationsEnabled(box:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	MainOptions.translatorPane = ISRichTextPanel:new (splitpoint+20, self.addY+22, comboWidth, 0);
	MainOptions.translatorPane:initialise();
	self.mainPanel:addChild(MainOptions.translatorPane);
	MainOptions.translatorPane:paginate();

	self.addY = self.addY + MainOptions.translatorPane:getHeight()+22;

	self.mainPanel:setScrollHeight(y + self.addY + 20)
end

function MainOptions:addSoundPanel()
	local y = INITIAL_Y;
	self.addY = 0
	local splitpoint = self:getWidth() / 2;
	local comboWidth = 45 * (getCore():getOptionFontSizeReal() +1) + 60

	self:addPage(getText("UI_optionscreen_audio"))

	----- Sound VOLUME -----
	local control = self:addVolumeControl(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_sound_volume"), 0)
	gameOption = GameOption:new('soundVolume', control)
	function gameOption.storeCurrentValue(self)
		self.originalValue = getCore():getOptionSoundVolume()
	end
	function gameOption.restoreOriginalValue(self)
		getCore():setOptionSoundVolume(self.originalValue)
	end
	function gameOption.toUI(self)
		local volume = getCore():getOptionSoundVolume()
		volume = math.min(10, math.max(0, volume))
		self.control:setVolume(volume)
	end
	function gameOption.onChange(self, control, volume)
		getCore():setOptionSoundVolume(volume)
	end
	function gameOption.apply(self)
		getCore():setOptionSoundVolume(self.control:getVolume())
	end
	self.gameOptions:add(gameOption)

	----- MUSIC VOLUME -----
	local control = self:addVolumeControl(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_music_volume"), 0)
	gameOption = GameOption:new('musicVolume', control)
	function gameOption.storeCurrentValue(self)
		self.originalValue = getCore():getOptionMusicVolume()
	end
	function gameOption.restoreOriginalValue(self)
		getCore():setOptionMusicVolume(self.originalValue)
	end
	function gameOption.toUI(self)
		local volume = getCore():getOptionMusicVolume()
		volume = math.min(10, math.max(0, volume))
		self.control:setVolume(volume)
	end
	function gameOption.onChange(self, control, volume)
		getCore():setOptionMusicVolume(volume)
	end
	function gameOption.apply(self)
		getCore():setOptionMusicVolume(self.control:getVolume())
	end
	self.gameOptions:add(gameOption)

--[[ Removed by request SPIF-1690
	----- AMBIENT VOLUME -----
	local control = self:addVolumeControl(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_ambient_volume"), 0)
	gameOption = GameOption:new('ambientVolume', control)
	function gameOption.storeCurrentValue(self)
		self.originalValue = getCore():getOptionAmbientVolume()
	end
	function gameOption.restoreOriginalValue(self)
		getCore():setOptionAmbientVolume(self.originalValue)
	end
	function gameOption.toUI(self)
		local volume = getCore():getOptionAmbientVolume()
		volume = math.min(10, math.max(0, volume))
		self.control:setVolume(volume)
	end
	function gameOption.onChange(self, control, volume)
		getCore():setOptionAmbientVolume(volume)
	end
	function gameOption.apply(self)
		getCore():setOptionAmbientVolume(self.control:getVolume())
	end
	self.gameOptions:add(gameOption)
--]]

	----- JUMP-SCARE VOLUME -----
	local control = self:addVolumeControl(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_jumpscare_volume"), 0)
	gameOption = GameOption:new('jumpscareVolume', control)
	function gameOption.storeCurrentValue(self)
		self.originalValue = getCore():getOptionJumpScareVolume()
	end
	function gameOption.restoreOriginalValue(self)
		getCore():setOptionJumpScareVolume(self.originalValue)
	end
	function gameOption.toUI(self)
		local volume = getCore():getOptionJumpScareVolume()
		volume = math.min(10, math.max(0, volume))
		self.control:setVolume(volume)
	end
	function gameOption.onChange(self, control, volume)
		getCore():setOptionJumpScareVolume(volume)
	end
	function gameOption.apply(self)
		getCore():setOptionJumpScareVolume(self.control:getVolume())
	end
	self.gameOptions:add(gameOption)

	----- VEHICLE ENGINE VOLUME -----
	local control = self:addVolumeControl(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_vehicle_engine_volume"), 0)
	control.tooltip = getText("UI_optionscreen_vehicle_engine_volume_tt");
	gameOption = GameOption:new('vehicleEngineVolume', control)
	function gameOption.storeCurrentValue(self)
		self.originalValue = getCore():getOptionVehicleEngineVolume()
	end
	function gameOption.restoreOriginalValue(self)
		getCore():setOptionVehicleEngineVolume(self.originalValue)
	end
	function gameOption.toUI(self)
		local volume = getCore():getOptionVehicleEngineVolume()
		volume = math.min(10, math.max(0, volume))
		self.control:setVolume(volume)
	end
	function gameOption.onChange(self, control, volume)
		getCore():setOptionVehicleEngineVolume(volume)
	end
	function gameOption.apply(self)
		getCore():setOptionVehicleEngineVolume(self.control:getVolume())
	end
	self.gameOptions:add(gameOption)

	----- MUSIC LIBRARY -----
	local combo = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_music_library"), { getText("UI_optionscreen_music_library_1"), getText("UI_optionscreen_music_library_2"), getText("UI_optionscreen_music_library_3")}, 1)
	gameOption = GameOption:new('musicLibrary', combo)
	function gameOption.toUI(self)
		local box = self.control
		local library = getCore():getOptionMusicLibrary()
		box.selected = math.min(3, math.max(1, library))
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] then
			getCore():setOptionMusicLibrary(box.selected)
		end
	end
	self.gameOptions:add(gameOption)

	----- MUSIC ACTION STYLE -----
	local combo = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_MusicActionStyle"), { getText("UI_optionscreen_MusicActionStyle_1"), getText("UI_optionscreen_MusicActionStyle_2")}, 1)
	gameOption = GameOption:new('musicActionStyle', combo)
	function gameOption.toUI(self)
		local box = self.control
		local library = getCore():getOptionMusicActionStyle()
		box.selected = math.min(2, math.max(1, library))
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] then
			getCore():setOptionMusicActionStyle(box.selected)
		end
	end
	self.gameOptions:add(gameOption)

	--[[
        ----- CURRENT MUSIC -----
        local musicLbl = ISLabel:new(splitpoint, y + self.addY, FONT_HGT_SMALL, getText("UI_optionscreen_music_track1"), 1, 1, 1, 1, UIFont.Small, false);
    --	musicLbl:setAnchorRight(true)
        musicLbl:initialise();
        self.mainPanel:addChild(musicLbl);

        self.currentMusicLabel = ISLabel:new(splitpoint + 20, y + self.addY, FONT_HGT_SMALL, "", 1, 1, 1, 1, UIFont.Small, true);
        self.currentMusicLabel:initialise();
        self.mainPanel:addChild(self.currentMusicLabel);
        self.addY = self.addY + FONT_HGT_SMALL + 6
    --]]

	----- RakVoice -----
	local voiceEnable = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_voiceEnable"), {getText("UI_Yes"), getText("UI_No")}, 1)
	gameOption = GameOption:new('voiceEnable', voiceEnable)
	function gameOption.toUI(self)
		local box = self.control
		if getCore():getOptionVoiceEnable() then
			box.selected = 1
		else
			box.selected = 2
		end
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] then
			getCore():setOptionVoiceEnable(box.selected == 1)
		end
	end
	self.gameOptions:add(gameOption)

	local listrecorddevices = VoiceManager:RecordDevices();
	local voiceRecordDevice = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_voiceRecordDevice"), listrecorddevices, 0)
	gameOption = GameOption:new('voiceRecordDevice', voiceRecordDevice)
	function gameOption.toUI(self)
		local box = self.control
		box.selected = getCore():getOptionVoiceRecordDevice()
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOptionVoiceRecordDevice(box.selected)
	end
	self.gameOptions:add(gameOption)

	local voiceMode = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_voiceMode"), {getText("UI_PPT"), getText("UI_VAD"), getText("UI_Mute")}, 1)
	gameOption = GameOption:new('voiceMode', voiceMode)
	function gameOption.toUI(self)
		local box = self.control
		box.selected = getCore():getOptionVoiceMode()
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOptionVoiceMode(box.selected)
	end
	self.gameOptions:add(gameOption)

	--    self.voipKey = ISLabel:new(splitpoint + 20, y + self.addY, 20, getText("UI_PPT_Key", getCore():getKey("Enable voice transmit")), 1, 1, 1, 1, UIFont.Small, true);
	--    self.voipKey:initialise();
	--    self.mainPanel:addChild(self.voipKey);
	--    self.addY = self.addY + 26;

	local voiceVADMode = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_voiceVADMode"), {getText("UI_VADMode1_Quality"), getText("UI_VADMode2_LowBitrate"), getText("UI_VADMode3_Aggressive"), getText("UI_VADMode4_VeryAggressive")}, 1)
	gameOption = GameOption:new('voiceVADMode', voiceVADMode)
	function gameOption.toUI(self)
		local box = self.control
		box.selected = getCore():getOptionVoiceVADMode()
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOptionVoiceVADMode(box.selected)
	end
	self.gameOptions:add(gameOption)

	local voiceAGCMode = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_voiceAGCMode"), {getText("UI_AGCMode1_AdaptiveAnalog"), getText("UI_AGCMode2_AdaptiveDigital"), getText("UI_AGCMode3_FixedDigital")}, 1)
	gameOption = GameOption:new('voiceAGCMode', voiceAGCMode)
	function gameOption.toUI(self)
		local box = self.control
		box.selected = getCore():getOptionVoiceAGCMode()
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOptionVoiceAGCMode(box.selected)
	end
	self.gameOptions:add(gameOption)

	local voiceVolumeMic = self:addMegaVolumeControl(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_voiceVolumeMic"), 0)
	voiceVolumeMic.tooltip = getText("UI_optionscreen_voiceVolumeMic_tt");
	gameOption = GameOption:new('voiceVolumeMic', voiceVolumeMic)
	function gameOption.toUI(self)
		local volume = getCore():getOptionVoiceVolumeMic()
		volume = math.min(11, math.max(0, volume))
		self.control:setVolume(volume)
	end
	function gameOption.apply(self)
		getCore():setOptionVoiceVolumeMic(self.control:getVolume())
	end
	self.gameOptions:add(gameOption)


	local voiceVolumeMicIndicator = self:addVolumeIndicator(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_voiceVolumeMicIndicator"), 0)
	voiceVolumeMicIndicator.tooltip = getText("UI_optionscreen_voiceVolumeMicIndicator_tt");

	local voiceVolumePlayers = self:addMegaVolumeControl(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_voiceVolumePlayers"), 0)
	voiceVolumePlayers.tooltip = getText("UI_optionscreen_voiceVolumePlayers_tt");
	gameOption = GameOption:new('voiceVolumePlayers', voiceVolumePlayers)
	function gameOption.toUI(self)
		local volume = getCore():getOptionVoiceVolumePlayers()
		volume = math.min(11, math.max(0, volume))
		self.control:setVolume(volume)
	end
	function gameOption.apply(self)
		getCore():setOptionVoiceVolumePlayers(self.control:getVolume())
	end
	self.gameOptions:add(gameOption)

	----- STREAMER MODE -----
	local streamerMode = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_StreamerMode"))
	streamerMode.tooltip = getText("UI_optionscreen_StreamerMode_tt");

	gameOption = GameOption:new('streamerMode', streamerMode)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1, getCore():getOptionStreamerMode())
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOptionStreamerMode(box:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	if SystemDisabler.getEnableAdvancedSoundOptions() then
		local button = ISButton:new(splitpoint + 20, y + self.addY, 100, BUTTON_HGT, getText("GameSound_ButtonAdvanced"), self, self.onGameSounds)
		button:initialise()
		button:instantiate()
		self.mainPanel:addChild(button)
		self.mainPanel:insertNewLineOfButtons(button)
	elseif getDebug() then
		local button = ISButton:new(splitpoint + 20, y + self.addY, 100, BUTTON_HGT, getText("GameSound_ButtonReload"), self, self.onReloadGameSounds)
		button:initialise()
		button:instantiate()
		button.tooltip = getText("GameSound_ButtonReload_tt")
		self.mainPanel:addChild(button)
		self.mainPanel:insertNewLineOfButtons(button)
	end

	self.mainPanel:setScrollHeight(y + self.addY + 20)
end

function MainOptions:addKeybindingPanel()
	local y = INITIAL_Y;
	self.addY = 0
	local splitpoint = self:getWidth() / 2;
	local comboWidth = 45 * (getCore():getOptionFontSizeReal() +1) + 60

	self:addPage(getText("UI_optionscreen_keybinding"))

	local keyTextElement = nil;
	local x = MainOptions.keyBindingLength + 30;
	self.keyButtonWidth = UI_BORDER_SPACING*2 + getTextManager():MeasureStringX(UIFont.Small, "Mouse Btn 99") --temporary unless button names don't get translated
	self.keyTickBoxes = {}
	local left = true;
	for i,v in ipairs(MainOptions.keys) do
		keyTextElement = {};

		if luautils.stringStarts(v.value, "[") then
			if not left then
				left = true
				y = y + BUTTON_HGT + UI_BORDER_SPACING
			end

			self:addHorizontalLine(y, getText("UI_optionscreen_binding_" .. v.value:gsub("%[", ""):gsub("%]", "")))

			keyTextElement.value = v.value;
			table.insert(MainOptions.keyText, keyTextElement);

			x = MainOptions.keyBindingLength + 30;
			--y = y + fontHgtMedium + 10;
		else

			--            print("UI_optionscreen_binding_" .. v.value .. " = \" " .. v.value .. "\",");
			local splitpoint = self:getWidth() / 2 ;
			local label = ISLabel:new(x, y+self.addY, BUTTON_HGT, v.value, 1, 1, 1, 1, UIFont.Small);
			label:initialise();
			label:setAnchorLeft(false)
			label:setAnchorRight(true);
			label:setTranslation(getText("UI_optionscreen_binding_" .. v.value));
			self.mainPanel:addChild(label);

			local btn = ISButton:new(x + UI_BORDER_SPACING, y+self.addY, self.keyButtonWidth, BUTTON_HGT, getKeyName(tonumber(v.key)), self, MainOptions.onKeyBindingBtnPress);
			btn.internal = v.value;
			btn:initialise();
			btn:instantiate();
			--~ 			btn:setAnchorRight(true);
			self.mainPanel:addChild(btn);

			keyTextElement.txt = label;
			keyTextElement.keyCode = tonumber(v.key) or 0
			keyTextElement.altCode = tonumber(v.alt) or 0
			keyTextElement.btn = btn;
			keyTextElement.left = left
			table.insert(MainOptions.keyText, keyTextElement);

			if v.value == "ManualFloorAtk" then
				-- MANUAL FLOOR ATK TOGGLE
				y = y + BUTTON_HGT + UI_BORDER_SPACING;
				local toggleAutoProneAtk = ISTickBox:new(x + UI_BORDER_SPACING, y+self.addY, BUTTON_HGT, BUTTON_HGT, "HELLO?")
				toggleAutoProneAtk.choicesColor = {r=1, g=1, b=1, a=1}
				toggleAutoProneAtk:initialise()
				toggleAutoProneAtk.tooltip = getText("IGUI_ToggleAutoProneAtkTooltip", getKeyName(getCore():getKey("ManualFloorAtk")), getKeyName(getCore():getKey("Melee"))),
				-- Must addChild *before* addOption() or ISUIElement:getKeepOnScreen() will restrict y-position to screen height
				self.mainPanel:addChild(toggleAutoProneAtk)
				toggleAutoProneAtk:addOption(getText("IGUI_ToggleAutoProneAtk"))
				self.mainPanel:insertNewLineOfButtons(toggleAutoProneAtk)
				self.mainPanel:setScrollHeight(y + 50);

				gameOption = GameOption:new('autoProneAtk', toggleAutoProneAtk)
				function gameOption.toUI(self)
					local box = self.control
					box:setSelected(1, getCore():isOptionAutoProneAtk())
					box.options[1] = getText("IGUI_ToggleAutoProneAtk")
				end
				function gameOption.apply(self)
					local box = self.control
					getCore():setOptionAutoProneAtk(box:isSelected(1))
				end
				self.gameOptions:add(gameOption)

				toggleAutoProneAtk.isLeftColumn = left
				table.insert(self.keyTickBoxes, toggleAutoProneAtk)
			end

			if v.value == "Run" then
				-- RUN KEY TOGGLE
				y = y + BUTTON_HGT + UI_BORDER_SPACING;
				local toggleToRunTickbox = ISTickBox:new(x + UI_BORDER_SPACING, y+self.addY, BUTTON_HGT, BUTTON_HGT, "HELLO?")
				toggleToRunTickbox.choicesColor = {r=1, g=1, b=1, a=1}
				toggleToRunTickbox:initialise()
				-- Must addChild *before* addOption() or ISUIElement:getKeepOnScreen() will restrict y-position to screen height
				self.mainPanel:addChild(toggleToRunTickbox)
				toggleToRunTickbox:addOption(getText("IGUI_ToggleToRun", getKeyName(getCore():getKey("Run"))))
				self.mainPanel:insertNewLineOfButtons(toggleToRunTickbox)
				self.mainPanel:setScrollHeight(y + 50);

				gameOption = GameOption:new('toggleToRun', toggleToRunTickbox)
				function gameOption.toUI(self)
					local box = self.control
					box:setSelected(1,getCore():isToggleToRun())
					local runKeyName = getKeyName(getCore():getKey("Run"))
					box.options[1] = getText("IGUI_ToggleToRun", runKeyName)
					self.gameOptions:get("dblTapRunToSprint").control.options[1] = getText("UI_optionscreen_DblTapRunToSprint", runKeyName)
				end
				function gameOption.apply(self)
					local box = self.control
					getCore():setToggleToRun(box.selected[1])
				end
				self.gameOptions:add(gameOption)

				toggleToRunTickbox.isLeftColumn = left
				table.insert(self.keyTickBoxes, toggleToRunTickbox)
			end

			-- adding touble tab shift option
			if v.value == "Sprint" then
				self.sprintBtn = btn;
				y = y + BUTTON_HGT + UI_BORDER_SPACING;
				local tblTapSprint = ISTickBox:new(x + UI_BORDER_SPACING, y+self.addY, BUTTON_HGT, BUTTON_HGT, "");
				tblTapSprint.selected[1] = getCore():isOptiondblTapJogToSprint();
				self.sprintBtn.enable = not getCore():isOptiondblTapJogToSprint();
				tblTapSprint.choicesColor = {r=1, g=1, b=1, a=1};
				tblTapSprint:initialise();
				local runKeyName = getKeyName(getCore():getKey("Run"))
				tblTapSprint:addOption(getText("UI_optionscreen_DblTapRunToSprint", runKeyName), "");
				tblTapSprint.tooltip = getText("UI_optionscreen_DblTapRunToSprintTooltip", runKeyName, runKeyName):gsub("\\n", "\n");
				self.mainPanel:addChild(tblTapSprint);
				self.mainPanel:insertNewLineOfButtons(tblTapSprint)
				y = y + BUTTON_HGT + UI_BORDER_SPACING;

				gameOption = GameOption:new('dblTapRunToSprint', tblTapSprint)
				function gameOption.toUI(self)
					local box = self.control
					box:setSelected(1,getCore():isOptiondblTapJogToSprint())
				end
				function gameOption.onChange(self, index, selected)
					MainOptions.instance.sprintBtn.enable = not selected
				end
				function gameOption.apply(self)
					local box = self.control
					getCore():setOptiondblTapJogToSprint(box.selected[1])
				end
				self.gameOptions:add(gameOption)

				tblTapSprint.isLeftColumn = left
				table.insert(self.keyTickBoxes, tblTapSprint)

				-- SPRINT KEY TOGGLE
				local toggleToSprintTickbox = ISTickBox:new(x + UI_BORDER_SPACING, y+self.addY, BUTTON_HGT, BUTTON_HGT, "HELLO?")
				toggleToSprintTickbox.choicesColor = {r=1, g=1, b=1, a=1}
				toggleToSprintTickbox:initialise()
				-- Must addChild *before* addOption() or ISUIElement:getKeepOnScreen() will restrict y-position to screen height
				self.mainPanel:addChild(toggleToSprintTickbox)
				toggleToSprintTickbox:addOption(getText("IGUI_ToggleToSprint", getKeyName(getCore():getKey("Sprint"))))
				self.mainPanel:insertNewLineOfButtons(toggleToSprintTickbox)
				self.mainPanel:setScrollHeight(y + 50);

				gameOption = GameOption:new('toggleToSprint', toggleToSprintTickbox)
				function gameOption.toUI(self)
					local box = self.control
					box:setSelected(1,getCore():isToggleToSprint())
					box.options[1] = getText("IGUI_ToggleToSprint", getKeyName(getCore():getKey("Sprint")))
				end
				function gameOption.apply(self)
					local box = self.control
					getCore():setToggleToSprint(box.selected[1])
				end
				self.gameOptions:add(gameOption)

				toggleToSprintTickbox.isLeftColumn = left
				table.insert(self.keyTickBoxes, toggleToSprintTickbox)
			end

			if v.value == "Aim" then
				-- AIM KEY TOGGLE
				y = y + BUTTON_HGT + UI_BORDER_SPACING;
				local toggleAimTickbox = ISTickBox:new(x + UI_BORDER_SPACING, y+self.addY, BUTTON_HGT, BUTTON_HGT, "HELLO?")
				toggleAimTickbox.choicesColor = {r=1, g=1, b=1, a=1}
				toggleAimTickbox:initialise()
				-- Must addChild *before* addOption() or ISUIElement:getKeepOnScreen() will restrict y-position to screen height
				self.mainPanel:addChild(toggleAimTickbox)
				toggleAimTickbox:addOption(getText("UI_optionscreen_ToggleToAim", getKeyName(getCore():getKey("Aim"))))
				self.mainPanel:insertNewLineOfButtons(toggleAimTickbox)
				self.mainPanel:setScrollHeight(y + 50);

				gameOption = GameOption:new('toggleToAim', toggleAimTickbox)
				function gameOption.toUI(self)
					local box = self.control
					box:setSelected(1, getCore():isToggleToAim())
					box.options[1] = getText("UI_optionscreen_ToggleToAim", getKeyName(getCore():getKey("Aim")))
				end
				function gameOption.apply(self)
					local box = self.control
					getCore():setToggleToAim(box:isSelected(1))
				end
				self.gameOptions:add(gameOption)

				toggleAimTickbox.isLeftColumn = left
				table.insert(self.keyTickBoxes, toggleAimTickbox)
			end

			if x > MainOptions.keyBindingLength + 30 then
				x = MainOptions.keyBindingLength + 30;
				y = y + BUTTON_HGT + UI_BORDER_SPACING;
				left = true;
			else
				x = splitpoint + MainOptions.keyBindingLength + 30;
				left = false;
			end
		end
	end

	self.mainPanel:setScrollHeight(y + self.addY + 60)
end

function MainOptions:addAccessibilityPanel()
	local y = INITIAL_Y;
	self.addY = 0
	local splitpoint = self:getWidth() / 2;
	local comboWidth = 45 * (getCore():getOptionFontSizeReal() +1) + 60

	self:addPage(getText("UI_optionscreen_accessibility"))
	local x = splitpoint

	-- SINGLE CONTEXT MENU
	label = ISLabel:new(splitpoint, y + self.addY, FONT_HGT_SMALL, getText("UI_optionscreen_SingleContextMenu"), 1, 1, 1, 1, UIFont.Small, false)
	label:initialise()
	self.mainPanel:addChild(label)
	local singleContextMenu = ISTickBox:new(splitpoint + 20, y + self.addY, BUTTON_HGT, BUTTON_HGT, "HELLO?")
	singleContextMenu.choicesColor = {r=1, g=1, b=1, a=1}
	singleContextMenu:initialise();
	self.mainPanel:addChild(singleContextMenu)
	self.mainPanel:insertNewLineOfButtons(singleContextMenu)
	-- Must addChild *before* addOption() or ISUIElement:getKeepOnScreen() will restrict y-position to screen height
	for i = 1,4 do
		singleContextMenu:addOption(getText("UI_optionscreen_player"..i), nil)
	end
	self.addY = self.addY + singleContextMenu:getHeight() + UI_BORDER_SPACING

	gameOption = GameOption:new('singleContextMenu', singleContextMenu)
	function gameOption.toUI(self)
		local box = self.control
		for i = 1,4 do
			box:setSelected(i, getCore():getOptionSingleContextMenu(i-1))
		end
	end
	function gameOption.apply(self)
		local box = self.control
		for i = 1,4 do
			getCore():setOptionSingleContextMenu(i-1, box:isSelected(i))
		end
	end
	self.gameOptions:add(gameOption)

	-- RADIAL MENU KEY TOGGLE
	local radialMenuToggle = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("IGUI_RadialMenuKeyToggle"))

	gameOption = GameOption:new('radialMenuKeyToggle', radialMenuToggle)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1,getCore():getOptionRadialMenuKeyToggle())
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOptionRadialMenuKeyToggle(box:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	-- RELOAD RADIAL INSTANT
	local reloadRadialInstant = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("IGUI_ReloadRadialInstant"))

	gameOption = GameOption:new('reloadRadialInstant', reloadRadialInstant)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1,getCore():getOptionReloadRadialInstant())
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOptionReloadRadialInstant(box:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	----- CYCLE CONTAINER KEY -----
	local cycleContainerKey = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_CycleContainerKey"),
			{ getText("UI_optionscreen_CycleContainerKey1"), getText("UI_optionscreen_CycleContainerKey2"),
			  getText("UI_optionscreen_CycleContainerKey3") }, 1)
	cycleContainerKey:setToolTipMap({ defaultTooltip = getText("UI_optionscreen_CycleContainerKey_tt") })

	gameOption = GameOption:new('cycleContainerKey', cycleContainerKey)
	function gameOption.toUI(self)
		local box = self.control
		local values = { "control", "shift", "control+shift" }
		box.selected = luautils.indexOf(values, getCore():getOptionCycleContainerKey())
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] then
			local values = { "control", "shift", "control+shift" }
			getCore():setOptionCycleContainerKey(values[box.selected])
		end
	end
	self.gameOptions:add(gameOption)

	-- DROP ITEMS ON SQUARE CENTER
	local dropItemsOnSquareCenter = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("IGUI_DropItemsOnSquareCenter"))

	gameOption = GameOption:new('dropItemsOnSquareCenter', dropItemsOnSquareCenter)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1,getCore():getOptionDropItemsOnSquareCenter())
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOptionDropItemsOnSquareCenter(box:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	-- TIMED ACTION GAME SPEED RESET
	local timedActionSpeedReset = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_TimedActionGameSpeedReset"))

	gameOption = GameOption:new('timedActionGameSpeedReset', timedActionSpeedReset)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1,getCore():getOptionTimedActionGameSpeedReset())
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOptionTimedActionGameSpeedReset(box:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	-- SHOULDER BUTTON CONTAINER SWITCH
	local shoulderButton = self:addCombo(splitpoint, y, comboWidth, 20, getText("UI_optionscreen_ShoulderButtonContainerSwitch"),
			{
				getText("UI_optionscreen_ShoulderButtonContainerSwitch1"),
				getText("UI_optionscreen_ShoulderButtonContainerSwitch2"),
				getText("UI_optionscreen_ShoulderButtonContainerSwitch3")
			},
			1)

	gameOption = GameOption:new('shoulderButtonContainerSwitch', shoulderButton)
	function gameOption.toUI(self)
		local box = self.control
		box.selected = getCore():getOptionShoulderButtonContainerSwitch()
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] then
			getCore():setOptionShoulderButtonContainerSwitch(box.selected)
		end
	end
	self.gameOptions:add(gameOption)

	-- ENABLE LEFT JOYSTICK RADIAL MENU
	local leftJoystickRadial = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_EnableLeftJoystickRadialMenu"))

	gameOption = GameOption:new('enableLeftJoystickRadialMenu', leftJoystickRadial)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1,getCore():getOptionEnableLeftJoystickRadialMenu())
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOptionEnableLeftJoystickRadialMenu(box:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	-- SHOW PROGRESS BAR
	--	local progressBar = self:addTickBox(splitpoint, y, 300, 20)
	--	progressBar:addOption(getText("UI_optionscreen_ShowProgressBar"))
	--	self.addY = self.addY + progressBar:getHeight()
	--
	--	gameOption = GameOption:new('showProgressBar', progressBar)
	--	function gameOption.toUI(self)
	--		local box = self.control
	--		box:setSelected(1, getCore():isOptionProgressBar())
	--	end
	--	function gameOption.apply(self)
	--		local box = self.control
	--		getCore():setOptionProgressBar(box:isSelected(1))
	--	end
	--	self.gameOptions:add(gameOption)

	----- AUTO DRINK -----
	local autoDrink = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_AutoDrink"));

	gameOption = GameOption:new('autoDrink', autoDrink)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1, getCore():getOptionAutoDrink())
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOptionAutoDrink(box:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	----- LEAVE KEY IN IGNITION -----
	local keyInIgnition = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_LeaveKeyInIgnition"));

	gameOption = GameOption:new('keyInIgnition', keyInIgnition)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1, getCore():getOptionLeaveKeyInIgnition())
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOptionLeaveKeyInIgnition(box:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	----- CLICK TO WALK TO NEARBY CONTAINERS -----
	---
	local autoWalkContainer = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_AutoWalkContainer"));
	autoWalkContainer.tooltip = getText("UI_optionscreen_AutoWalkContainer_tt");

	gameOption = GameOption:new('autoWalkContainer', autoWalkContainer)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1, getCore():getOptionAutoWalkContainer())
	end
	function gameOption.apply(self)
		local box = self.control
		getCore():setOptionAutoWalkContainer(box:isSelected(1))
	end
	self.gameOptions:add(gameOption)

	----- SET GOOD HIGHLIGHT COLOR -----

	local ghc = getCore():getGoodHighlitedColor()
	local rgba = {r = ghc:getR(), g = ghc:getG(), b = ghc:getB(), a = 1}
	self.goodHighColor = self:addColorButton(splitpoint, y, getText("UI_optionscreen_goodHighlightColor"), rgba, MainOptions.onGoodHighlightColor)

	if MainScreen.instance.inGame then
		self.goodHighColor.tooltip = getText("UI_optionscreen_needreboot")
	end

	self.colorPicker3 = ISColorPicker:new(0, 0)
	self.colorPicker3:initialise()
	self.colorPicker3.pickedTarget = self
	self.colorPicker3.resetFocusTo = self
	self.colorPicker3:setInitialColor(getCore():getGoodHighlitedColor());

	gameOption = GameOption:new('goodHighColor', self.goodHighColor)
	function gameOption.toUI(self)
		local color = getCore():getGoodHighlitedColor()
		self.control.backgroundColor = {r = color:getR(), g = color:getG(), b = color:getB(), a = 1}
	end
	function gameOption.apply(self)
		local color = self.control.backgroundColor
		local current = getCore():getGoodHighlitedColor()
		if current:getR() == color.r and current:getG() == color.g and current:getB() == color.b then
			return
		end
		getCore():setGoodHighlitedColor(ColorInfo.new(color.r, color.g, color.b, 1))
		self:resetLua()
	end
	self.gameOptions:add(gameOption)

	----- SET BAD HIGHLIGHT COLOR -----

	local bhc = getCore():getBadHighlitedColor()
	local rgba = {r = bhc:getR(), g = bhc:getG(), b = bhc:getB(), a = 1}
	self.badHighColor = self:addColorButton(splitpoint, y, getText("UI_optionscreen_badHighlightColor"), rgba, MainOptions.onBadHighlightColor)

	if MainScreen.instance.inGame then
		self.badHighColor.tooltip = getText("UI_optionscreen_needreboot")
	end

	self.colorPicker4 = ISColorPicker:new(0, 0)
	self.colorPicker4:initialise()
	self.colorPicker4.pickedTarget = self
	self.colorPicker4.resetFocusTo = self
	self.colorPicker4:setInitialColor(getCore():getBadHighlitedColor());

	gameOption = GameOption:new('badHighColor', self.badHighColor)
	function gameOption.toUI(self)
		local color = getCore():getBadHighlitedColor()
		self.control.backgroundColor = {r = color:getR(), g = color:getG(), b = color:getB(), a = 1}
	end
	function gameOption.apply(self)
		local color = self.control.backgroundColor
		local current = getCore():getBadHighlitedColor()
		if current:getR() == color.r and current:getG() == color.g and current:getB() == color.b then
			return
		end
		getCore():setBadHighlitedColor(ColorInfo.new(color.r, color.g, color.b, 1))
		self:resetLua()
	end
	self.gameOptions:add(gameOption)

	----- COLORBLIND PATTERNS -----

	local colorblindPatterns = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_ColorblindPatterns"));
	colorblindPatterns.tooltip = getText("UI_optionscreen_ColorblindPatterns_tt");

	gameOption = GameOption:new('colorblindPatterns', colorblindPatterns)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1, getCore():getOptionColorblindPatterns())
	end
	function gameOption.apply(self)
		local box = self.control
		if getCore():getOptionColorblindPatterns() ~= box:isSelected(1) then
			getCore():setOptionColorblindPatterns(box:isSelected(1))
			self:resetLua()
		end
	end
	self.gameOptions:add(gameOption)

	----- ENABLE DYSLEXIC FONT -----

	local enableDyslexicFont = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_enableDyslexicFont"));
	enableDyslexicFont.tooltip = getText("UI_optionscreen_enableDyslexicFont_tt");

	gameOption = GameOption:new('enableDyslexicFont', enableDyslexicFont)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1, getCore():getOptionEnableDyslexicFont())
	end
	function gameOption.apply(self)
		local box = self.control
		if getCore():getOptionEnableDyslexicFont() ~= box:isSelected(1) then
			getCore():setOptionEnableDyslexicFont(box:isSelected(1))
			self:resetLua()
		end
	end
	self.gameOptions:add(gameOption)

	----- ENABLE LIGHT SENSITIVITY MODE -----

	local enableLightSensitivity = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_enableLightSensitivity"));
	enableLightSensitivity.tooltip = getText("UI_optionscreen_enableLightSensitivity_tt");

	gameOption = GameOption:new('enableLightSensitivity', enableLightSensitivity)
	function gameOption.toUI(self)
		local box = self.control
		box:setSelected(1, getCore():getOptionLightSensitivity())
	end
	function gameOption.apply(self)
		local box = self.control
		if getCore():getOptionLightSensitivity() ~= box:isSelected(1) then
			getCore():setOptionLightSensitivity(box:isSelected(1))
			self:resetLua()
		end
	end
	self.gameOptions:add(gameOption)

	--[[
        ----- IGNORE PRONE ZOMBIE DIST -----
        local ignoreProne = self:addCombo(splitpoint, y, 300, 20, getText("UI_optionscreen_IgnoreProneZombieRange"),
            {
                getText("UI_optionscreen_IgnoreProneZombieRange1"),
                getText("UI_optionscreen_IgnoreProneZombieRange2"),
                getText("UI_optionscreen_IgnoreProneZombieRange3"),
                getText("UI_optionscreen_IgnoreProneZombieRange4"),
                getText("UI_optionscreen_IgnoreProneZombieRange5")
            },
            2)
        ignoreProne:setToolTipMap({ defaultTooltip = getText("UI_optionscreen_IgnoreProneZombieRange_tt") })

        gameOption = GameOption:new('ignoreProneZombieRange', ignoreProne)
        function gameOption.toUI(self)
            local box = self.control
            box.selected = getCore():getOptionIgnoreProneZombieRange()
        end
        function gameOption.apply(self)
            local box = self.control
            if box.options[box.selected] then
                getCore():setOptionIgnoreProneZombieRange(box.selected)
            end
        end --]]
	--	self.gameOptions:add(gameOption)

	-----
	self.mainPanel:setScrollHeight(y + self.addY + 20)
end

function MainOptions:addControllerPanel()
	local y = INITIAL_Y;
	self.addY = 0
	local splitpoint = self:getWidth() / 2;
	local comboWidth = 45 * (getCore():getOptionFontSizeReal() +1) + 60

	self:addPage(getText("UI_optionscreen_controller"))
	local x = UI_BORDER_SPACING+1

	-- CONTROLLER BUTTON STYLE
	local label = ISLabel:new(x, y, BUTTON_HGT, getText("UI_optionscreen_ControllerButtonStyle"), 1, 1, 1, 1, UIFont.Small, true);
	label:initialise();
	self.mainPanel:addChild(label);
	local controllerButtonStyle = ISComboBox:new(label:getRight()+UI_BORDER_SPACING, y, 200, BUTTON_HGT);
	controllerButtonStyle:initialise();
	controllerButtonStyle:addOption(getText("UI_optionscreen_ControllerButtonStyle1"));
	controllerButtonStyle:addOption(getText("UI_optionscreen_ControllerButtonStyle2"));
	controllerButtonStyle.selected = selected;
	self.mainPanel:addChild(controllerButtonStyle);
	self.mainPanel:insertNewLineOfButtons(controllerButtonStyle)

	gameOption = GameOption:new('UI_optionscreen_ControllerButtonStyle', controllerButtonStyle)
	function gameOption.toUI(self)
		local box = self.control
		box.selected = getCore():getOptionControllerButtonStyle()
	end
	function gameOption.apply(self)
		local box = self.control
		if box.options[box.selected] and (getCore():getOptionControllerButtonStyle() ~= box.selected) then
			getCore():setOptionControllerButtonStyle(box.selected)
			self:resetLua()
		end
	end
	self.gameOptions:add(gameOption)
	y = y + BUTTON_HGT + UI_BORDER_SPACING

	--
	label = ISLabel:new(x, y, FONT_HGT_SMALL, getText("UI_optionscreen_controller_tip"), 1, 1, 1, 1, UIFont.Small, true)
	label:initialise()
	self.mainPanel:addChild(label)

	local controllerTickBox = ISTickBox:new(x + UI_BORDER_SPACING, label:getY() + label:getHeight() + UI_BORDER_SPACING, BUTTON_HGT, BUTTON_HGT, "HELLO?")
	controllerTickBox.choicesColor = {r=1, g=1, b=1, a=1}
	controllerTickBox:initialise();
	self.mainPanel:addChild(controllerTickBox)

	for i = 0, getControllerCount()-1 do
		if isControllerConnected(i) then
			local name = getControllerName(i)
			controllerTickBox:addOption(name, nil)
		end
	end

	gameOption = GameOption:new('controllers', controllerTickBox)
	function gameOption.toUI(self)
		local box = self.control
		box:clearOptions()
		for i = 1,getControllerCount() do
			if isControllerConnected(i-1) then
				local name = getControllerName(i-1)
				local guid = getControllerGUID(i-1)
				local index = box:addOption(name, i-1)
				local active = getCore():getOptionActiveController(guid)
				box:setSelected(index, active)
			end
		end
	end
	function gameOption.apply(self)
		local box = self.control
		for i = 1,box:getOptionCount() do
			local controllerIndex = box:getOptionData(i)
			getCore():setOptionActiveController(controllerIndex, box:isSelected(i))
		end
	end
	self.gameOptions:add(gameOption)

	-- If any controller connected, must work at least one
	local haveActiveController = false
	for i = 1,getControllerCount() do
		if isControllerConnected(i-1) then
			local guid = getControllerGUID(i-1)
			local active = getCore():getOptionActiveController(guid)
			if active then
				haveActiveController = true
			end
		end
	end
	if not haveActiveController and getControllerCount() > 0 then
		getCore():setOptionActiveController(0, true)
	end

	y = controllerTickBox:getY() + controllerTickBox:getHeight()

	local panel = ISPanel:new(x, y, self.width / 2 - x, 100)
	panel:noBackground()
	self.mainPanel:addChild(panel)
	self.stuffBelowControllerTickbox = panel

	local btn = ISButton:new(0, UI_BORDER_SPACING, 120, BUTTON_HGT, getText("UI_optionscreen_controller_reload"), self, MainOptions.ControllerReload)
	btn:initialise()
	btn:instantiate()
	self.stuffBelowControllerTickbox:addChild(btn)

	y = btn:getY() + btn:getHeight()

	label = ISLabel:new(0, y + UI_BORDER_SPACING, BUTTON_HGT, getText("UI_optionscreen_gamepad_sensitivity"), 1, 1, 1, 1, UIFont.Medium, true)
	label:initialise()
	self.stuffBelowControllerTickbox:addChild(label)

	y = label:getY() + label:getHeight()

	local buttonSize = BUTTON_HGT
	self.btnJoypadSensitivityM = ISButton:new(0, y + UI_BORDER_SPACING, BUTTON_HGT, BUTTON_HGT, "-", self, MainOptions.joypadSensitivityM)
	self.btnJoypadSensitivityM:initialise()
	self.btnJoypadSensitivityM:instantiate()
	self.btnJoypadSensitivityM:setEnable(false)
	self.stuffBelowControllerTickbox:addChild(self.btnJoypadSensitivityM)
	self.labelJoypadSensitivity = ISLabel:new(self.btnJoypadSensitivityM:getX()+self.btnJoypadSensitivityM:getWidth()+UI_BORDER_SPACING, y + UI_BORDER_SPACING, BUTTON_HGT, getText("UI_optionscreen_select_gamepad"), 1, 1, 1, 1, UIFont.Small, true)
	self.labelJoypadSensitivity:initialise()
	self.stuffBelowControllerTickbox:addChild(self.labelJoypadSensitivity)
	self.btnJoypadSensitivityP = ISButton:new(self.labelJoypadSensitivity:getX()+self.labelJoypadSensitivity:getWidth()+UI_BORDER_SPACING, y + UI_BORDER_SPACING, BUTTON_HGT, BUTTON_HGT, "+", self, MainOptions.joypadSensitivityP)
	self.btnJoypadSensitivityP:initialise()
	self.btnJoypadSensitivityP:instantiate()
	self.btnJoypadSensitivityP:setEnable(false)
	self.stuffBelowControllerTickbox:addChild(self.btnJoypadSensitivityP)


	local panel = ISControllerTestPanel:new(self.width / 2, UI_BORDER_SPACING+1, self.width - UI_BORDER_SPACING+1 - (self.width / 2), self.mainPanel.height - (UI_BORDER_SPACING+1)*2)
	panel:setAnchorRight(true)
	panel:setAnchorBottom(true)
	panel.drawBorder = true
	panel.mainOptions = self
	panel:initialise()
	self.mainPanel:addChild(panel)
	self.controllerTestPanel = panel

	self.mainPanel:insertNewLineOfButtons(controllerTickBox, self.controllerTestPanel.combo)
	self.mainPanel:insertNewLineOfButtons(btn)
	self.mainPanel:insertNewLineOfButtons(self.btnJoypadSensitivityM, self.btnJoypadSensitivityP)

end

function MainOptions:addMultiplayerPanel()
	local y = INITIAL_Y;
	self.addY = 0
	local splitpoint = self:getWidth() / 2;
	local comboWidth = 45 * (getCore():getOptionFontSizeReal() +1) + 60

	self:addPage(getText("UI_optionscreen_multiplayer"))

	local showUsernameTickbox = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText("UI_optionscreen_showUsername"));
	showUsernameTickbox.tooltip = getText("UI_optionscreen_showUsernameTooltip");

	gameOption = GameOption:new('showUsername', showUsernameTickbox)
	function gameOption.toUI(self)
		local box = self.control;
		local selected = true;
		box:setSelected(1, getCore():isShowYourUsername());
	end
	function gameOption.apply(self)
		local box = self.control;
		getCore():setShowYourUsername(box:isSelected(1));
	end
	self.gameOptions:add(gameOption)

	local mpc = getCore():getMpTextColor()
	local rgba = {r = mpc:getR(), g = mpc:getG(), b = mpc:getB(), a = 1}
	self.mpColor = self:addColorButton(splitpoint, y, getText("UI_optionscreen_personalTextColor"), rgba, MainOptions.onMPColor);

	self.colorPicker = ISColorPicker:new(0, 0)
	self.colorPicker:initialise()
	self.colorPicker.pickedTarget = self
	self.colorPicker.resetFocusTo = self
	self.colorPicker:setInitialColor(getCore():getMpTextColor());

	gameOption = GameOption:new('mpTextColor', self.mpColor)
	function gameOption.toUI(self)
		local color = getCore():getMpTextColor()
		self.control.backgroundColor = {r = color:getR(), g = color:getG(), b = color:getB(), a = 1}
	end
	function gameOption.apply(self)
		local color = self.control.backgroundColor
		local current = getCore():getMpTextColor()
		if current:getR() == color.r and current:getG() == color.g and current:getB() == color.b then
			return
		end
		getCore():setMpTextColor(ColorInfo.new(color.r, color.g, color.b, 1))
		if isClient() and MainScreen.instance.inGame then
			getPlayer():setSpeakColourInfo(getCore():getMpTextColor())
			sendPersonalColor(getPlayer())
		end
	end
	self.gameOptions:add(gameOption)

end

function MainOptions:addModOptionsPanel()
	PZAPI.ModOptions:load()

	self:addPage(getText("UI_mainscreen_mods"))

	local comboWidth = 45 * (getCore():getOptionFontSizeReal() +1) + 60
	local splitpoint = self:getWidth() / 3
	local y = INITIAL_Y
	self.addY = 0

	for _, options in ipairs(PZAPI.ModOptions.Data) do
		self:addHorizontalLine(y, getText(options.name))
		for _, option in ipairs(options.data) do
			if option.type == "title" then
				self:addTitle(splitpoint, y, getText(option.name))
			elseif option.type == "separator" then
				self:addHorizontalLineSmall(y)
			elseif option.type == "description" then
				self:addDescription(splitpoint, y, option.text)
			elseif option.type == "tickbox" then
				local tickbox = self:addYesNo(splitpoint, y, BUTTON_HGT, BUTTON_HGT, getText(option.name))
				if option.tooltip then
					tickbox.tooltip = getText(option.tooltip)
				end
				option.element = tickbox
				if not option.isEnabled then
					tickbox:disableOption("", true)
				end

				local gameOption = GameOption:new(options.modOptionsID .. "." .. option.id, tickbox)
				function gameOption.toUI(self)
					local box = self.control
					box:setSelected(1, option.value)
				end
				function gameOption.apply(self)
					local box = self.control
					if option.onChangeApply and option.value ~= box:isSelected(1) then
						option:onChangeApply(box:isSelected(1))
					end
					option.value = box:isSelected(1)
				end
				function gameOption.onChange(self, index, selected)
					if option.onChange then
						option:onChange(selected)
					end
				end
				self.gameOptions:add(gameOption)
			elseif option.type == "multipletickbox" then
				local label = ISLabel:new(splitpoint, y + self.addY, FONT_HGT_SMALL, getText(option.name), 1, 1, 1, 1, UIFont.Small, false)
				label:initialise()
				self.mainPanel:addChild(label)

				local multipleTickBox = ISTickBox:new(splitpoint + 20, y + self.addY, BUTTON_HGT, BUTTON_HGT, "")
				if option.tooltip then
					multipleTickBox.tooltip = getText(option.tooltip)
				end
				option.element = multipleTickBox
				multipleTickBox:initialise()
				self.mainPanel:addChild(multipleTickBox)
				self.mainPanel:insertNewLineOfButtons(multipleTickBox)
				-- Must addChild *before* addOption() or ISUIElement:getKeepOnScreen() will restrict y-position to screen height
				for _, value in ipairs(option.values) do
					multipleTickBox:addOption(getText(value.name), value.name)
				end
				self.addY = self.addY + multipleTickBox:getHeight() + 4
				for k, v in pairs(option.values) do
					multipleTickBox:disableOption(v.name, not v.isEnabled)
				end

				local gameOption = GameOption:new(options.modOptionsID .. "." .. option.id, multipleTickBox)
				function gameOption.toUI(self)
					local box = self.control
					for i = 1, #box.options do
						box:setSelected(i, option.values[i].value)
					end
				end
				function gameOption.apply(self)
					local box = self.control
					for i = 1, #box.options do
						if option.onChangeApply and option.values[i].value ~= box:isSelected(i) then
							option:onChangeApply(i, box:isSelected(i))
						end
						option.values[i].value = box:isSelected(i)
					end
				end
				function gameOption.onChange(self, index, selected)
					if option.onChange then
						option:onChange(index, selected)
					end
				end
				self.gameOptions:add(gameOption)
			elseif option.type == "textentry" then
				local textEntry = self:addTextEntry(splitpoint, y, getText(option.name), option.value)
				if option.tooltip then
					textEntry.tooltip = getText(option.tooltip)
				end
				option.element = textEntry
				if not option.isEnabled then
					textEntry:setEditable(false)
				end

				local gameOption = GameOption:new(options.modOptionsID .. "." .. option.id, textEntry)
				function gameOption.toUI(self)
					local box = self.control
					box:setText(option.value)
				end
				function gameOption.apply(self)
					local text = self.control:getInternalText()
					if option.onChangeApply and option.value ~= text then
						option:onChangeApply(text)
					end
					option.value = text
				end
				function gameOption.onChange(self, text)
					if option.onChange then
						option:onChange(text)
					end
				end
				self.gameOptions:add(gameOption)
			elseif option.type == "combobox" then
				local combo = self:addCombo(splitpoint, y, comboWidth, 20, getText(option.name), option.values, option.selected)
				option.element = combo
				if not option.isEnabled then
					combo.disabled = true
				end
				local gameOption = GameOption:new(options.modOptionsID .. "." .. option.id, combo)
				function gameOption.toUI(self)
					local box = self.control
					box.selected = option.selected
				end
				function gameOption.apply(self)
					local box = self.control
					if option.onChangeApply and option.selected ~= box.selected then
						option:onChangeApply(box.selected)
					end
					option.selected = box.selected
				end
				function gameOption.onChange(self, box)
					if option.onChange then
						option:onChange(box.selected)
					end
				end
				self.gameOptions:add(gameOption)
			elseif option.type == "colorpicker" then
				local button = self:addColorButton(splitpoint, y, getText(option.name), option.color, MainOptions.onModColorPick)
				option.element = button
				if not option.isEnabled then
					button:setEnable(false)
				end
				if option.tooltip then
					button:setTooltip(getText(option.tooltip))
				end

				button.colorPicker = ISColorPicker:new(0, 0)
				button.colorPicker:initialise()
				button.colorPicker.pickedTarget = self
				button.colorPicker.resetFocusTo = self
				button.colorPicker:setInitialColor(ColorInfo.new(option.color.r, option.color.g, option.color.b, option.color.a))

				button.optionID = options.modOptionsID .. "." .. option.id
				local gameOption = GameOption:new(options.modOptionsID .. "." .. option.id, button)
				function gameOption.toUI(self)
					self.control.backgroundColor = option.color
				end
				function gameOption.apply(self)
					local optCol = option.color
					local conCol = self.control.backgroundColor
					if option.onChangeApply and (optCol.r ~= conCol.r or optCol.g ~= conCol.g or optCol.b ~= conCol.b or optCol.a ~= conCol.a)  then
						option:onChangeApply(conCol)
					end
					option.color = self.control.backgroundColor
				end
				function gameOption.onChange(self, color)
					if option.onChange then
						option:onChange(color)
					end
				end
				self.gameOptions:add(gameOption)
			elseif option.type == "button" then
				local button = self:addButton(splitpoint, y, getText(option.name))
				option.element = button
				button.id = options.modOptionsID .. "." .. option.id
				button.target = option.target
				button:setOnClick(option.onclick, option.args[1], option.args[2], option.args[3], option.args[4])
				if option.tooltip then
					button:setTooltip(getText(option.tooltip))
				end
				if not option.isEnabled then
					button:setEnable(false)
				end
			elseif option.type == "keybind" then
				local keyTextElement = {}

				local label = ISLabel:new(splitpoint, y + self.addY, FONT_HGT_SMALL + 2, getText(option.name), 1, 1, 1, 1, UIFont.Small)
				label:initialise()
				label:setAnchorLeft(false)
				label:setAnchorRight(true)
				self.mainPanel:addChild(label)

				local btn = ISButton:new(splitpoint + 20, y + self.addY, self.keyButtonWidth, FONT_HGT_SMALL + 2, getKeyName(tonumber(option.key)), self, MainOptions.onKeyBindingBtnPress);
				btn.internal = option.name;
				btn.isModBind = true
				btn:initialise();
				btn:instantiate();
				if option.tooltip then
					btn:setTooltip(getText(option.tooltip))
				end
				self.mainPanel:addChild(btn);

				option.element = btn
				if not option.isEnabled then
					btn:setEnable(false)
				end

				keyTextElement.txt = label
				keyTextElement.keyCode = tonumber(option.key) or 0
				keyTextElement.defaultKeyCode = tonumber(option.defaultkey) or 0
				keyTextElement.altCode = 0
				keyTextElement.btn = btn
				keyTextElement.left = true
				keyTextElement.isModBind = true
				table.insert(MainOptions.keyText, keyTextElement)
				option.element = keyTextElement

				self.addY = self.addY + FONT_HGT_SMALL + 2 + 6
			elseif option.type == "slider" then
				local slider = self:addSlider(splitpoint, y, comboWidth, getText(option.name), option.min, option.max, option.step, option.value)
				option.element = slider
				if not option.isEnabled then
					slider.disabled = true
				end

				local gameOption = GameOption:new(options.modOptionsID .. "." .. option.id, slider)
				function gameOption.toUI(self)
					self.control.label:setName(tostring(option.value))
					self.control:setCurrentValue(option.value, true)
				end
				function gameOption.apply(self)
					if option.onChangeApply and option.value ~= self.control:getCurrentValue() then
						option:onChangeApply(self.control:getCurrentValue())
					end
					option.value = self.control:getCurrentValue()
				end
				function gameOption.onChange(self, value)
					self.control.label:setName(tostring(value))
					if option.onChange then
						option:onChange(value)
					end
				end
				self.gameOptions:add(gameOption)
			end
		end
	end

	self.mainPanel:setScrollHeight(y + self.addY + 20)
end

function MainOptions:onObjHighlightColor(button)
    local x = button.parent.parent.x + button.parent.x + button.parent:getXScroll() + button.x
    local y = button.parent.parent.y + button.parent.y + button.parent:getYScroll() + button.y + button.height + 1
    if y + self.colorPicker2.height > self.height then
        y = y - button.height - self.colorPicker2.height - 1
    end
    self.colorPicker2:setX(x)
    self.colorPicker2:setY(y)
    self.colorPicker2.pickedFunc = MainOptions.pickedObjHighlightColor;
    local color = self.objHighColor.backgroundColor
    local colorInfo = ColorInfo.new(color.r, color.g, color.b, 1)
    self.colorPicker2:setInitialColor(colorInfo);
    self:addChild(self.colorPicker2)
    self.colorPicker2:setVisible(true);
    self.colorPicker2:bringToTop();
    local joypadData = JoypadState.getMainMenuJoypad()
    if joypadData then
        joypadData.focus = self.colorPicker2
    end
end

function MainOptions:onWorkstationHighlightColor(button)
    local x = button.parent.parent.x + button.parent.x + button.parent:getXScroll() + button.x
    local y = button.parent.parent.y + button.parent.y + button.parent:getYScroll() + button.y + button.height + 1
    if y + self.colorPicker5.height > self.height then
        y = y - button.height - self.colorPicker5.height - 1
    end
    self.colorPicker5:setX(x)
    self.colorPicker5:setY(y)
    self.colorPicker5.pickedFunc = MainOptions.pickedWorkstationHighlightColor;
    local color = self.workstationHighColor.backgroundColor
    local colorInfo = ColorInfo.new(color.r, color.g, color.b, 1)
    self.colorPicker5:setInitialColor(colorInfo);
    self:addChild(self.colorPicker5)
    self.colorPicker5:setVisible(true);
    self.colorPicker5:bringToTop();
    local joypadData = JoypadState.getMainMenuJoypad()
    if joypadData then
        joypadData.focus = self.colorPicker5
    end
end

function MainOptions:onModColorPick(button)
	local x = button.parent.parent.x + button.parent.x + button.parent:getXScroll() + button.x
	local y = button.parent.parent.y + button.parent.y + button.parent:getYScroll() + button.y + button.height + 1
	if y + button.colorPicker.height > self.height then
		y = y - button.height - button.colorPicker.height - 1
	end
	button.colorPicker:setX(x)
	button.colorPicker:setY(y)
	button.colorPicker.pickedFunc = MainOptions.pickedModColor
	button.colorPicker.pickedTarget = button
	local color = button.backgroundColor
	local colorInfo = ColorInfo.new(color.r, color.g, color.b, 1)
	button.colorPicker:setInitialColor(colorInfo);
	self:addChild(button.colorPicker)
	button.colorPicker:setVisible(true);
	button.colorPicker:bringToTop();
	local joypadData = JoypadState.getMainMenuJoypad()
	if joypadData then
		joypadData.focus = button.colorPicker
	end
end

function MainOptions:onMPColor(button)
    local x = button.parent.parent.x + button.parent.x + button.parent:getXScroll() + button.x
    local y = button.parent.parent.y + button.parent.y + button.parent:getYScroll() + button.y + button.height + 1
    if y + self.colorPicker.height > self.height then
        y = y - button.height - self.colorPicker.height - 1
    end
    self.colorPicker:setX(x)
    self.colorPicker:setY(y)
    self.colorPicker.pickedFunc = MainOptions.pickedMPTextColor;
    local color = self.mpColor.backgroundColor
    local colorInfo = ColorInfo.new(color.r, color.g, color.b, 1)
    self.colorPicker:setInitialColor(colorInfo);
    self:addChild(self.colorPicker)
    self.colorPicker:bringToTop();
    local joypadData = JoypadState.getMainMenuJoypad()
    if joypadData then
        joypadData.focus = self.colorPicker
    end
end

function MainOptions:onGoodHighlightColor(button)
	local x = button.parent.parent.x + button.parent.x + button.parent:getXScroll() + button.x
	local y = button.parent.parent.y + button.parent.y + button.parent:getYScroll() + button.y + button.height + 1
	if y + self.colorPicker3.height > self.height then
		y = y - button.height - self.colorPicker3.height - 1
	end
	self.colorPicker3:setX(x)
	self.colorPicker3:setY(y)
	self.colorPicker3.pickedFunc = MainOptions.pickedGoodHighlightColor;
	local color = self.goodHighColor.backgroundColor
	local colorInfo = ColorInfo.new(color.r, color.g, color.b, 1)
	self.colorPicker3:setInitialColor(colorInfo);
	self:addChild(self.colorPicker3)
	self.colorPicker3:setVisible(true);
	self.colorPicker3:bringToTop();
	local joypadData = JoypadState.getMainMenuJoypad()
	if joypadData then
		joypadData.focus = self.colorPicker3
	end
end

function MainOptions:onBadHighlightColor(button)
	local x = button.parent.parent.x + button.parent.x + button.parent:getXScroll() + button.x
	local y = button.parent.parent.y + button.parent.y + button.parent:getYScroll() + button.y + button.height + 1
	if y + self.colorPicker4.height > self.height then
		y = y - button.height - self.colorPicker4.height - 1
	end
	self.colorPicker4:setX(x)
	self.colorPicker4:setY(y)
	self.colorPicker4.pickedFunc = MainOptions.pickedBadHighlightColor;
	local color = self.badHighColor.backgroundColor
	local colorInfo = ColorInfo.new(color.r, color.g, color.b, 1)
	self.colorPicker4:setInitialColor(colorInfo);
	self:addChild(self.colorPicker4)
	self.colorPicker4:setVisible(true);
	self.colorPicker4:bringToTop();
	local joypadData = JoypadState.getMainMenuJoypad()
	if joypadData then
		joypadData.focus = self.colorPicker4
	end
end

function MainOptions:onTargetColor(button)
	local x = button.parent.parent.x + button.parent.x + button.parent:getXScroll() + button.x
	local y = button.parent.parent.y + button.parent.y + button.parent:getYScroll() + button.y + button.height + 1
	if y + self.colorPicker5.height > self.height then
		y = y - button.height - self.colorPicker5.height - 1
	end
	self.colorPicker5:setX(x)
	self.colorPicker5:setY(y)
	self.colorPicker5.pickedFunc = MainOptions.pickedTargetColor;
	local color = self.targetColor.backgroundColor
	local colorInfo = ColorInfo.new(color.r, color.g, color.b, 1)
	self.colorPicker5:setInitialColor(colorInfo);
	self:addChild(self.colorPicker5)
	self.colorPicker5:setVisible(true);
	self.colorPicker5:bringToTop();
	local joypadData = JoypadState.getMainMenuJoypad()
	if joypadData then
		joypadData.focus = self.colorPicker5
	end
end

function MainOptions:onNoTargetColor(button)
	local x = button.parent.parent.x + button.parent.x + button.parent:getXScroll() + button.x
	local y = button.parent.parent.y + button.parent.y + button.parent:getYScroll() + button.y + button.height + 1
	if y + self.colorPicker5.height > self.height then
		y = y - button.height - self.colorPicker5.height - 1
	end
	self.colorPicker5:setX(x)
	self.colorPicker5:setY(y)
	self.colorPicker5.pickedFunc = MainOptions.pickedNoTargetColor;
	local color = self.noTargetColor.backgroundColor
	local colorInfo = ColorInfo.new(color.r, color.g, color.b, 1)
	self.colorPicker5:setInitialColor(colorInfo);
	self:addChild(self.colorPicker5)
	self.colorPicker5:setVisible(true);
	self.colorPicker5:bringToTop();
	local joypadData = JoypadState.getMainMenuJoypad()
	if joypadData then
		joypadData.focus = self.colorPicker5
	end
end

function MainOptions:pickedObjHighlightColor(color, mouseUp)
    MainOptions.instance.objHighColor.backgroundColor = { r=color.r, g=color.g, b=color.b, a = 1 }
    local gameOptions = MainOptions.instance.gameOptions
    gameOptions:onChange(gameOptions:get('objHighColor'))
    getCore():setObjectHighlitedColor(ColorInfo.new(color.r,color.g,color.b,1))
end

function MainOptions:pickedWorkstationHighlightColor(color, mouseUp)
    MainOptions.instance.workstationHighColor.backgroundColor = { r=color.r, g=color.g, b=color.b, a = 1 }
    local gameOptions = MainOptions.instance.gameOptions
    gameOptions:onChange(gameOptions:get('workstationHighColor'))
    getCore():setWorkstationHighlitedColor(ColorInfo.new(color.r,color.g,color.b,1))
end

function MainOptions:pickedModColor(color, mouseUp)
	self.backgroundColor = { r=color.r, g=color.g, b=color.b, a = 1 }
	local gameOptions = MainOptions.instance.gameOptions
	local gameOption = gameOptions:get(self.optionID)
	gameOptions:onChange(gameOption)
	if gameOption.onChange then
		gameOption:onChange(self.backgroundColor)
	end
end

function MainOptions:pickedMPTextColor(color, mouseUp)
    MainOptions.instance.mpColor.backgroundColor = { r=color.r, g=color.g, b=color.b, a = 1 }
    local gameOptions = MainOptions.instance.gameOptions
    gameOptions:onChange(gameOptions:get('mpTextColor'))
end

function MainOptions:pickedGoodHighlightColor(color, mouseUp)
	MainOptions.instance.goodHighColor.backgroundColor = { r=color.r, g=color.g, b=color.b, a = 1 }
	local gameOptions = MainOptions.instance.gameOptions
	gameOptions:onChange(gameOptions:get('goodHighColor'))
end

function MainOptions:pickedBadHighlightColor(color, mouseUp)
	MainOptions.instance.badHighColor.backgroundColor = { r=color.r, g=color.g, b=color.b, a = 1 }
	local gameOptions = MainOptions.instance.gameOptions
	gameOptions:onChange(gameOptions:get('badHighColor'))
end

function MainOptions:pickedTargetColor(color, mouseUp)
	MainOptions.instance.targetColor.backgroundColor = { r=color.r, g=color.g, b=color.b, a = 1 }
	local gameOptions = MainOptions.instance.gameOptions
	gameOptions:onChange(gameOptions:get('targetColor'))
end

function MainOptions:pickedNoTargetColor(color, mouseUp)
	MainOptions.instance.noTargetColor.backgroundColor = { r=color.r, g=color.g, b=color.b, a = 1 }
	local gameOptions = MainOptions.instance.gameOptions
	gameOptions:onChange(gameOptions:get('noTargetColor'))
end

function MainOptions:onReloadGameSounds()
	reloadSoundFiles()
end

function MainOptions:onGameSounds()
	self:setVisible(false)

	-- Needed when returning to the main menu after death.
	if not MainScreen.instance.inGame then
		GameSounds.fix3DListenerPosition(true)
	end

	local ui = ISGameSounds:new(self.x, self.y, self.width, self.height)
	ui:initialise()
	ui:instantiate()
	MainScreen.instance:addChild(ui)
	ui:setVisible(true, self.joyfocus)
	self.gameSounds = ui
end

function MainOptions:toUI()
	-- Hack to handle the user switching between QWERTY and AZERTY keyboard layouts.
	-- Hopefully GLFW will generate an event for this eventually.
	self:onKeyboardLayoutChanged()

	self.gameOptions:storeCurrentValues()
	self.gameOptions:toUI()
end

function MainOptions:onKeyboardLayoutChanged()
	Keyboard.initKeyNames()
	for k,v in ipairs(MainOptions.keyText) do
		if not v.value then
			v.btn:setTitle(getKeyName(v.keyCode));
		end
	end
end

function MainOptions:showConfirmDialog()
	if not self.gameOptions.changed then return false end

	self.tabs:setVisible(false)
	self.backButton:setVisible(false)
	self.acceptButton:setVisible(false)
	self.saveButton:setVisible(false)

	local w,h = 350,120
	self.modal = ISModalDialog:new((getCore():getScreenWidth() / 2) - w / 2,
		(getCore():getScreenHeight() / 2) - h / 2, w, h,
		getText("UI_optionscreen_ConfirmPrompt"), true, self, MainOptions.onConfirmModalClick);
	self.modal:initialise()
	self.modal:setCapture(true)
	self.modal:setAlwaysOnTop(true)
	self.modal:addToUIManager()
	if self.joyfocus then
		self.joyfocus.focus = self.modal
		updateJoypadFocus(self.joyfocus)
	end
	return true
end

function MainOptions:onConfirmModalClick(button)
	self.tabs:setVisible(true)
	self.backButton:setVisible(true)
	self.acceptButton:setVisible(true)
	self.saveButton:setVisible(true)
	self.modal = nil
	if button.internal == "YES" then
		self:apply(true)
	else
		self.gameOptions:restoreOriginalValues()
		self.gameOptions.changed = false
		self:onOptionMouseDown(self.backButton, 0, 0)
	end
end

function MainOptions:showConfirmMonitorSettingsDialog(closeAfter)
	self.tabs:setVisible(false)
	self.backButton:setVisible(false)
	self.acceptButton:setVisible(false)
	self.saveButton:setVisible(false)

	local w,h = 350,140
	self.modal = ISConfirmMonitorSettingsDialog:new((getCore():getScreenWidth() / 2) - w / 2,
		(getCore():getScreenHeight() / 2) - h / 2, w, h, MainOptions.onConfirmMonitorSettingsClick, self, closeAfter)
	self.modal:initialise()
	self.modal:setCapture(true)
	self.modal:setAlwaysOnTop(true)
	self.modal:addToUIManager()
	local joypadData = JoypadState.getMainMenuJoypad()
	if joypadData then
		self.modal.prevFocus = joypadData.focus
		joypadData.focus = self.modal
		updateJoypadFocus(self.joyfocus)
	end
	return true
end

function MainOptions:onConfirmMonitorSettingsClick(button, closeAfter)
	self.tabs:setVisible(true)
	self.backButton:setVisible(true)
	self.acceptButton:setVisible(true)
	self.saveButton:setVisible(true)
	self.modal = nil
	if button.internal == "YES" then
	else
		getCore():setOptionBorderlessWindow(self.monitorSettings.borderless)
		getCore():setResolutionAndFullScreen(self.monitorSettings.width, self.monitorSettings.height,
			self.monitorSettings.fullscreen)
		getCore():setOptionVSync(self.monitorSettings.vsync)
		self:toUI()
		getCore():saveOptions()
	end
	if closeAfter then
		self:close()
	end
end

function MainOptions:showRestartRequiredDialog(closeAfter)
	local player = 0
	local modal = ISModalDialog:new(getCore():getScreenWidth() / 2 - 175, getCore():getScreenHeight() / 2 - 75, 350, 150,
		getText("UI_restart_game_to_apply"), false, self, MainOptions.onRestartRequiredClick, player, closeAfter)
	modal:initialise()
	modal:setCapture(true)
	modal:setAlwaysOnTop(true)
	modal:addToUIManager()
	local joypadData = JoypadState.getMainMenuJoypad()
	if joypadData then
		modal.prevFocus = joypadData.focus
		joypadData.focus = modal
		updateJoypadFocus(joypadData)
	end
end

function MainOptions:onRestartRequiredClick(button, closeAfter)
	if closeAfter then
		self:close()
	end

	if self.resetLua and not MainScreen.instance.inGame then
		getCore():DelayResetLua("default", closeAfter and "optionsChangedAccepted" or "optionsChangedApplied")
	end
end

function MainOptions.sortModes(a, b)
	-- Need to handle the (RECOMMENED) string here
	local ax, ay = string.match(a, '(%d+) x (%d+)')
	local bx, by = string.match(b, '(%d+) x (%d+)')
	ax = tonumber(ax)
	ay = tonumber(ay)
	bx = tonumber(bx)
	by = tonumber(by)
	if ax < bx then return true end
	if ax > bx then return false end
	return ay < by
end

function MainOptions:onMouseWheel(del)
	if self.tabs:onMouseWheel(del) then
		return true;
	end
--	local panel = self.tabs:getActiveView()
--	panel:onMouseWheel(del)
	return true;
end

function MainOptions:onMouseWheelCurrentTab(del)
	self:setYScroll(self:getYScroll() - (del * 40));
	return true
end

MainOptions.KEYS_VERSION1 = 1 -- Build 41
MainOptions.KEYS_VERSION = MainOptions.KEYS_VERSION1

function MainOptions.upgradeKeysIni(name, key, defaultKey, version)
	if (version < MainOptions.KEYS_VERSION1) and (key ~= defaultKey) then
		if name == "Toggle Skill Panel" then
			-- C -> L
			print('reset keybind', name, 'from', key, 'to', defaultKey)
			key = defaultKey
		end
	end
	return key
end

function MainOptions.loadKeys()
	getCore():reinitKeyMaps()
	MainOptions.keys = {}
	MainOptions.keyBindingLength = 0
	local knownKeys = {}
	-- keyBinding comes from keyBinding.lua
	for i=1, #keyBinding do
		bind = {}
		bind.key = keyBinding[i].key
		bind.alt = keyBinding[i].alt
		bind.value = keyBinding[i].value
		-- if we have a alternate key but no main then make the alt the main.
		-- this will help parts of the code that use getCore():getKey() to see if a binding exists.
		if bind.alt and not bind.key then
			bind.key = bind.alt
			bind.alt = nil
		end
		
		if not luautils.stringStarts(keyBinding[i].value, "[") then
			-- we add the key binding to the core (java side), so the game will know the key
            local bindNbr = tonumber(bind.key);
            if getCore():isAzerty() then -- doing azerty special keyboard, a=q, etc...
                if  bind.value == "Left" then
                    bindNbr = 16;
                elseif bind.value == "Forward" then
                    bindNbr = 44;
                elseif bind.value == "Shout" then
                    bindNbr = 30;
				elseif bind.value == "VehicleHorn" then
					bindNbr = 30;
				end
            end
            getCore():addKeyBinding(bind.value, bindNbr)
            bind.key = bindNbr;
            table.insert(MainOptions.keys, bind)
            if getTextManager():MeasureStringX(UIFont.Small, bind.value) > MainOptions.keyBindingLength then
				MainOptions.keyBindingLength = getTextManager():MeasureStringX(UIFont.Small, bind.value)
			end
			knownKeys[bind.value] = bind

			-- add the alt key binding
			if bind.alt then
				getCore():addAltKeyBinding(bind.value, tonumber(bind.alt))
				bind.alt = tonumber(bind.alt);
			end
        else
            table.insert(MainOptions.keys, bind)
        end
	end

	-- TODO: remove this later. b42 key file compat. 
	--  If 42 file doesnt exist then we need to check if the old 41 file does.
	local readfile = "keysB42.ini"
	if cacheFileExists("keys.ini") and not cacheFileExists("keysB42.ini") then
		readfile = "keys.ini"
	end
	-- the true boolean is to create the file is it doesn't exist
	local keyFile = getFileReader(readfile, true);
	-- we fetch our file to bind our keys (load the file)
	local line = nil;
	local version = 0
	-- we read each line of our file
	while true do
		line = keyFile:readLine();
		if line == nil then
			keyFile:close();
			break;
		end
		if not luautils.stringStarts(line, "[") then
			local splitedLine = string.split(line, "=")
			local name = splitedLine[1]
			--local key = tonumber(splitedLine[2])
			local key, alt = unpack(string.split(splitedLine[2], "/"))
			key = tonumber(key)
			alt = alt and tonumber(alt) or nil
			if name == "VERSION" then
				version = key or 0
			elseif knownKeys[name] then
				key = MainOptions.upgradeKeysIni(name, key, knownKeys[name].key, version)
				-- ignore obsolete bindings, override the default key
				knownKeys[name].key = key
				getCore():addKeyBinding(name, key)
				if alt then
					knownKeys[name].alt = alt
					getCore():addAltKeyBinding(name, alt)
				end
			end
		end
	end
	
	local reload = false;
	
	-- update keys for new clothing panel
--	if getCore():getOptionUpdateSafetyButton() then
--		getCore():addKeyBinding("Toggle Clothing Protection Panel", Keyboard.KEY_P);
--		getCore():addKeyBinding("Aim", Keyboard.KEY_LCONTROL);
--		for i,v in ipairs(MainOptions.keys) do
--			if v.value == "Crouch" then
--				print("found crouch")
--				v.key = getCore():getKey("Crouch");
--			end
--			if v.value == "Aim" then
--				print("found aim")
--				v.key = getCore():getKey("Aim");
--			end
--		end
--		reload = true;
--		getCore():setOptionUpdateSneakButton(false);
--		getCore():saveOptions();
--	end
	-- update keys for new sneak anim & clothing panel
	if getCore():getOptionUpdateSneakButton() then
		getCore():addKeyBinding("Toggle Clothing Protection Panel", Keyboard.KEY_P);
		getCore():addKeyBinding("Toggle Safety", Keyboard.KEY_G);
		getCore():addKeyBinding("Crouch", Keyboard.KEY_C);
		getCore():addKeyBinding("Aim", Keyboard.KEY_LCONTROL);
		for i,v in ipairs(MainOptions.keys) do
			if v.value == "Toggle Safety" then
				v.key = getCore():getKey("Toggle Safety");
			end
			if v.value == "Toggle Clothing Protection Panel" then
				v.key = getCore():getKey("Toggle Clothing Protection Panel");
			end
			if v.value == "Crouch" then
				v.key = getCore():getKey("Crouch");
			end
			if v.value == "Aim" then
				v.key = getCore():getKey("Aim");
			end
		end
		reload = true;
		getCore():setOptionUpdateSneakButton(false);
		getCore():saveOptions();
	end

	-- force the change of vehicle horn if it's equal to Toggle Health Panel
	if getCore():getKey("Toggle Health Panel") == getCore():getKey("VehicleHorn") then
		getCore():addKeyBinding("VehicleHorn", getCore():getKey("Shout"));
		for i,v in ipairs(MainOptions.keys) do
			if v.value == "VehicleHorn" then
				v.key = getCore():getKey("VehicleHorn");
				break;
			end
		end
		reload = true;
	end
	
	if reload then return true; end
end

function MainOptions:prerender()
	ISPanelJoypad.prerender(self);
	self:drawTextCentre(getText("UI_optionscreen_gameoption"), self.width / 2, 10, 1, 1, 1, 1, UIFont.Title);
	MainOptions.instance = self;

	self.saveButton:setEnable(self.gameOptions.changed)
end

function MainOptions:render()
--[[
	local currentMusic = getSoundManager():getCurrentMusicName()
	if currentMusic then
		local track = getTextOrNull("GameSound_"..currentMusic) or currentMusic
		self.currentMusicLabel.name = track
	else
		self.currentMusicLabel.name = ''
	end
--]]
end

function MainOptions:onKeyBindingBtnPress(button, x, y)
	local keybindName = button.internal
	-- This panel blocks mouse-clicks.
	if not MainOptions.instance.cover then
		local self = MainOptions.instance
		local cover = ISPanel:new(0, 0, self:getWidth(), self:getHeight())
		cover.borderColor.a = 0
		cover:setAnchorRight(true)
		cover:setAnchorBottom(true)
		cover:initialise()
		cover:instantiate()
		cover.javaObject:setConsumeMouseEvents(true)
		self.cover = cover
		self:addChild(cover)
	end
	MainOptions.instance.cover:setVisible(true)
	local modal = ISSetKeybindDialog:new(keybindName, button.isModBind)
	modal:initialise()
	modal:instantiate()
	modal:setCapture(true)
	modal:setAlwaysOnTop(true)
	modal:addToUIManager()
	GameKeyboard.setDoLuaKeyPressed(false)
	MainOptions.setKeybindDialog = modal
end

function MainOptions:onOptionMouseDown(button, x, y)
	-- if we back we gonna reinit all our key binding
	if button.internal == "BACK" then
		if self:showConfirmDialog() then
			return
		end
		MainOptions.loadKeys();
		for o,l in ipairs(MainOptions.keyText) do
			-- text
			if not l.value then
				l.btn:setTitle(getKeyName(l.keyCode));
			end
		end
		self:close()
	elseif button.internal == "ACCEPT" then
		self:apply(true)
	elseif button.internal == "SAVE" then
		self:apply(false)
	end
end

MainOptions.saveKeys = function()
	getCore():reinitKeyMaps()
	-- we erase our previous file (by setting the append boolean to false);
	local fileOutput = getFileWriter("keysB42.ini", true, false)
	fileOutput:write("VERSION="..tostring(MainOptions.KEYS_VERSION).."\r\n")
	for i,v in ipairs(MainOptions.keyText) do
		-- if it's a label (like [Player Visual])
		if v.value then
			fileOutput:write(v.value .. "\r\n")
		else
			fileOutput:write(v.txt:getName() .. "=" .. v.keyCode .."/"..v.altCode .. "\r\n")
			getCore():addKeyBinding(v.txt:getName(), v.keyCode)
			getCore():addAltKeyBinding(v.txt:getName(), v.altCode)
		end
	end
	fileOutput:close()
end

function MainOptions:apply(closeAfter)
	MainOptions.saveKeys();

	self.monitorSettings = {}
	self.monitorSettings.changed = false
	self.monitorSettings.fullscreen = getCore():isFullScreen()
	self.monitorSettings.borderless = getCore():getOptionBorderlessWindow()
	self.monitorSettings.width = getCore():getScreenWidth()
	self.monitorSettings.height = getCore():getScreenHeight()
	self.monitorSettings.vsync = getCore():getOptionVSync()

	self.resetLua = false
	self.restartRequired = false

	self.gameOptions:apply()
	for _, options in ipairs(PZAPI.ModOptions.Data) do
		options:apply()
	end

	getCore():saveOptions()
	PZAPI.ModOptions:save()

	self.gameOptions:toUI()

	if self.monitorSettings.changed then
		self:showConfirmMonitorSettingsDialog(closeAfter)
		return false
	end

	if self.restartRequired then
		self:showRestartRequiredDialog(closeAfter)
		return false
	end

	if closeAfter then
		self:close()
	end

	if self.resetLua and not MainScreen.instance.inGame then
		getCore():DelayResetLua("default", closeAfter and "optionsChangedAccepted" or "optionsChangedApplied")
	end
end

function MainOptions:close()
	JoypadState.controllerTest = nil
	self:setVisible(false)
	MainScreen.instance.bottomPanel:setVisible(true)
	if self.joyfocus then
		self.joyfocus.focus = MainScreen.instance
		updateJoypadFocus(self.joyfocus)
	end
end

function MainOptions.keyPressHandler(key)
	if MainOptions.setKeybindDialog and key > 0 then
		local keybindName = MainOptions.setKeybindDialog.keybindName
		MainOptions.setKeybindDialog:destroy()
		MainOptions.setKeybindDialog = nil;
		local keyBinded = nil;
		local error = false;
		for i,v in ipairs(MainOptions.keyText) do
			-- we ignore label (like [Player Control])
			if not v.value then
				if v.txt:getName() == keybindName then -- get our current btn pressed
					keyBinded = v;
				elseif key == v.keyCode then -- if the key you pressed is the same as another
					local modal = ISDuplicateKeybindDialog:new(key, keybindName, v.txt:getName())
					modal:initialise();
					modal:addToUIManager();
					modal:setAlwaysOnTop(true)
					MainOptions.instance.cover:setVisible(true)
					error = true;
					break;
				end
			end
		end
		if not error then
			keyBinded.keyCode = key;
			keyBinded.btn:setTitle(getKeyName(key));
			MainOptions.instance:onKeybindChanged(keybindName, key)
			MainOptions.instance.gameOptions.changed = true
		end
	end
end

function MainOptions:onKeybindChanged(name, key)
	local gameOptions = self.gameOptions
	if name == "Aim" then
		local gameOption = gameOptions:get("toggleToAim")
		gameOption.control.options[1] = getText("UI_optionscreen_ToggleToAim", getKeyName(key))
	end
	if name == "Run" then
		local gameOption = gameOptions:get("toggleToRun")
		gameOption.control.options[1] = getText("IGUI_ToggleToRun", getKeyName(key))
		gameOption = gameOptions:get("dblTapRunToSprint")
		gameOption.control.options[1] = getText("UI_optionscreen_DblTapRunToSprint", getKeyName(key))
	end
	if name == "ManualFloorAtk" then
		local gameOption = gameOptions:get("autoProneAtk")
		gameOption.control.options[1] = getText("IGUI_ToggleAutoProneAtk")
	end
	if name == "Sprint" then
		local gameOption = gameOptions:get("toggleToSprint")
		gameOption.control.options[1] = getText("IGUI_ToggleToSprint", getKeyName(key))
	end
end

function MainOptions.doLanguageToolTip(languages)
    local tooltipLanguages = {};
    tooltipLanguages["defaultTooltip"] = getText("UI_optionscreen_needreboot");
    return tooltipLanguages;
end
--MainOptions.getGeneralTranslators(box.options[box.selected])
function MainOptions.getGeneralTranslators(_language)
    if not _language then
        return {"???"}
    end
    local credits = getTranslatorCredits(_language)
    if credits then
        local result = {}
        for i=1,credits:size() do
            table.insert(result, credits:get(i-1))
        end
        return result
    end
--[[
    _language = _language:text()
    if _language == "Francais" then
        return {"Bret","Legumanigo","Peanuts","Marmotte971","Nyoshi","CareBearCorpse","Teesee","Furthick"};
    elseif _language == "Deutsch" then
        return {"RoboMat","Lakorta","Dahugo","Addy","Tuto","Houy Gaming"};
    elseif _language == "Russian" then
        return {"Lev Ivanov","lordixi","Adapt","ArionWT","Konrad Knox"};
    elseif _language == "Norsk" then
        return {"Hans Morgenstierne"};
    elseif _language == "Espanol (ES)" then
        return {"ditoseadio"}; -- removed "RetardedUser","Kalamar","Danny-Dynamita","Pagoru"
    elseif _language == "Italiano" then
        return {"Simone \"fox\" Volpini","Mattia \"d00de\" Geretti"};
    elseif _language == "Polish" then
        return {"Geras","Lord_Venom","adios_1984","Szary_Optymista","Th3FatPanda","Siarczek","pdjakow","voythas","Zorak","Spazmatic","welniok","Svarog","Insers"};
    elseif _language == "Nederlands" then
        return {"Massivekills (Kevin Heuvink)","Raymundo46", "Shinyshark"};
    elseif _language == "Afrikaans" then
        return {"PsychoEliteNZ (Adrian Jansen)","Viceroy (Stephanus Siebrits Cilliers van Zyl)"};
    elseif _language == "Czech" then
        return {"Jiri \"Rsa Viper\" Prochazka"};
    elseif _language == "Danish" then
        return {"A. Gade"};
    elseif _language == "Portuguese" then
        return {"Penedus", "ZonaryQuasar"};
    elseif _language == "Turkish" then
        return {"DemirHerif"};
    elseif _language == "Hungarian" then
        return {"sandor.baliko"};
    elseif _language == "Japanese" then
        return {"UENO \"Katzengarten\" Masahiro","Koichi \"Falcon33jp\" Takebe"};
    elseif _language == "Korean" then
        return {"clarke","daden","djcide(tannoy)","ingyer","yoongoon","zepaedori "};
    elseif _language == "Brazilian Portuguese" then
        return {"HiveFuse"};
    elseif _language == "Simplified Chinese" then
        return {"Sky_Orc_Mm"};
    elseif _language == "Thai" then
        return {"Artdekdok"};
    end
--]]
    return {getText("UI_optionscreen_no_translators")};
end

function MainOptions.getAvailableLanguage()
	local result = {};
	for i=0, Translator.getAvailableLanguage():size()-1 do
		table.insert(result, Translator.getAvailableLanguage():get(i):text());
	end
	table.sort(result, function(a,b) return not string.sort(a,b) end);

	local currentIndex = -1;
	local currentLanguage = Translator.getLanguage()
	for i,id in ipairs(result) do
		if id == currentLanguage:text() then
			currentIndex = i;
			break;
		end
	end

	return result,currentIndex;
end

function MainOptions:onResolutionChange(oldw, oldh, neww, newh)
	self:centerKeybindings()
	
	local gameOption = self.gameOptions:get('resolution')
	gameOption.control.options[1] = getText("UI_optionscreen_CurrentResolution", neww .. " x " .. newh)

	local buttonOffsetX = (self.width - (self.backButton.width + self.acceptButton.width + self.saveButton.width + UI_BORDER_SPACING*2))/2
	self.backButton:setX(buttonOffsetX)
	self.acceptButton:setX(self.backButton:getRight()+UI_BORDER_SPACING)
	self.saveButton:setX(self.acceptButton:getRight()+UI_BORDER_SPACING)

	self.controllerTestPanel:setX(self.width / 2)
	self.controllerTestPanel:setWidth(self.width - UI_BORDER_SPACING+1 - (self.width / 2))
	self.controllerTestPanel:onResolutionChange(oldw, oldh, neww, newh)

	self:centerTabChildrenX(getText("UI_optionscreen_display"))
	self:centerTabChildrenX(getText("UI_optionscreen_UI"))
	self:centerTabChildrenX(getText("UI_optionscreen_audio"))
	self:centerTabChildrenX(getText("UI_optionscreen_accessibility"))
	self:centerTabChildrenX(getText("UI_optionscreen_multiplayer"))
end

function MainOptions:centerKeybindings()
	local columnWidth = MainOptions.keyBindingLength + UI_BORDER_SPACING + self.keyButtonWidth + 100
	local column1x = (self.width - (columnWidth * 2)) / 2
	local column2x = column1x + columnWidth
	for _,keyTextElement in ipairs(MainOptions.keyText) do
		if keyTextElement.txt and not keyTextElement.isModBind then
			local x = keyTextElement.left and column1x or column2x
			x = x + MainOptions.keyBindingLength
			keyTextElement.txt:setX(x - keyTextElement.txt.width)
			keyTextElement.btn:setX(x + UI_BORDER_SPACING)
		end
	end
	for _,keyTickBox in ipairs(self.keyTickBoxes) do
		local x = keyTickBox.isLeftColumn and column1x or column2x
		local x2 = x + columnWidth
		x = x + MainOptions.keyBindingLength
		a = x + UI_BORDER_SPACING
		b = x2 + keyTickBox.width
		if a + keyTickBox.width > b then
			keyTickBox:setX(b - keyTickBox.width)
		else
			keyTickBox:setX(a)
		end
	end
end

function MainOptions:centerTabChildrenX(tabTitle)
	local panel = self.tabs:getView(tabTitle)
	if panel then
		self:centerChildrenX(panel)
	end
end

function MainOptions:centerChildrenX(panel)
	local xMin = 100000
	local xMax = -100000
	for _,child in pairs(panel:getChildren()) do
		if child ~= panel.vscroll and self:tableContains(IMMOVABLE_OBJECTS, child) == false then --DISPLAY screen doesn't centre properly because horizontal bars and labels. fix somehow.
			xMin = math.min(xMin, child:getX())
			xMax = math.max(xMax, child:getRight())
		end
	end
	local width = xMax - xMin
	local dx = 0
	if width < panel:getWidth() then
		dx = (panel:getWidth() - width) / 2 - xMin
	else
		dx = 0 - xMin
	end
	for _,child in pairs(panel:getChildren()) do
		if child ~= panel.vscroll and self:tableContains(IMMOVABLE_OBJECTS, child) == false then
			child:setX(child:getX() + dx)
		end
	end
end

function MainOptions:tableContains(tbl, x)
	found = false
	for _, v in pairs(tbl) do
		if v == x then
			found = true
		end
	end
	return found
end

function MainOptions:onTabsActivateView(tabs)
	-- Handle clicking in a tab when a controller is active
	local joypadData = JoypadState.getMainMenuJoypad()
	if joypadData then
		joypadData.focus = tabs:getActiveView()
	end
end

function MainOptions:onGainJoypadFocus(joypadData)
	ISPanelJoypad.onGainJoypadFocus(self, joypadData)
	local panel = self.tabs:getActiveView()
	joypadData.focus = panel
	updateJoypadFocus(joypadData)
MainOptions.instance = self
end

function MainOptions:onGainJoypadFocusCurrentTab(joypadData)
	ISPanelJoypad.onGainJoypadFocus(self, joypadData)
	self:setISButtonForX(MainOptions.instance.acceptButton)
	self:setISButtonForY(MainOptions.instance.saveButton)
	self:setISButtonForB(MainOptions.instance.backButton)
	if self.joypadIndexY == 0 then
		if #self.joypadButtonsY > 0 then
			self.joypadIndex = 1
			self.joypadIndexY = 1
			self.joypadButtons = self.joypadButtonsY[self.joypadIndexY]
			if self.joypadIndex > #self.joypadButtons then
				self.joypadIndex = #self.joypadButtons
			end
		end
	end
	if self.joypadButtons and self.joypadButtons[self.joypadIndex] then
		self.joypadButtons[self.joypadIndex]:setJoypadFocused(true, joypadData)
	end
end

function MainOptions:onLoseJoypadFocusCurrentTab(joypadData)
	self:clearJoypadFocus()
	ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
end

function MainOptions:onJoypadBeforeDeactivateCurrentTab(joypadData)
	self.parent.parent:onJoypadBeforeDeactivate(joypadData)
end

function MainOptions:onJoypadDownCurrentTab(button, joypadData)
	if button == Joypad.LBumper or button == Joypad.RBumper then
		if ISComboBox.SharedPopup and UIManager.getUI():contains(ISComboBox.SharedPopup.javaObject) then return end -- hack
		local viewIndex = self.parent:getActiveViewIndex()
		if button == Joypad.LBumper then
			if viewIndex == 1 then
				viewIndex = #self.parent.viewList
			else
				viewIndex = viewIndex - 1
			end
		elseif button == Joypad.RBumper then
			if viewIndex == #self.parent.viewList then
				viewIndex = 1
			else
				viewIndex = viewIndex + 1
			end
		end
		getSoundManager():playUISound("UIActivateTab")
		self.parent:activateView(self.parent.viewList[viewIndex].name)
--		self.parent:getActiveView().joypadData = joypadData
		joypadData.focus = self.parent:getActiveView()
		updateJoypadFocus(joypadData)
	else
		ISPanelJoypad.onJoypadDown(self, button, joypadData)
	end
end

function MainOptions.OnGamepadConnect(index)
	if not MainOptions.instance then return end
	local gameOption = MainOptions.instance.gameOptions:get("controllers")
	if gameOption then
		gameOption:toUI()
		if MainOptions.instance.stuffBelowControllerTickbox then
			MainOptions.instance.stuffBelowControllerTickbox:setY(gameOption.control:getBottom())
		end
	end
	if MainOptions.instance.controllerTestPanel then
		MainOptions.instance.controllerTestPanel:OnGamepadConnect(index)
	end
end

function MainOptions.OnGamepadDisconnect(index)
	if not MainOptions.instance then return end
	local gameOption = MainOptions.instance.gameOptions:get("controllers")
	if gameOption then
		gameOption:toUI()
		gameOption:toUI()
		if MainOptions.instance.stuffBelowControllerTickbox then
			MainOptions.instance.stuffBelowControllerTickbox:setY(gameOption.control:getBottom())
		end
	end
	if MainOptions.instance.controllerTestPanel then
		MainOptions.instance.controllerTestPanel:OnGamepadDisconnect(index)
	end
end

function MainOptions:onJoypadBeforeDeactivate(joypadData)
	self.acceptButton:clearJoypadButton()
	self.backButton:clearJoypadButton()
	self.saveButton:clearJoypadButton()
	self.joyfocus = nil
end

function MainOptions:new (x, y, width, height)
	local o = {}
	--o.data = {}
	o = ISPanelJoypad:new(x, y, width, height);
	setmetatable(o, self)
	self.__index = self
	o.x = x;
	o.y = y;
	o.backgroundColor = {r=0, g=0, b=0, a=0.3};
	o.borderColor = {r=1, g=1, b=1, a=0.2};
	o.width = width;
	o.height = height;
	o.anchorLeft = true;
	o.anchorRight = false;
	o.anchorTop = true;
	o.anchorBottom = false;
	o.addY = 0;
	o.gameOptions = GameOptions:new()
	MainOptions.instance = o;
	return o
end

--Events.OnCustomUIKey.Add(MainOptions.keyPressHandler);

--Events.OnMainMenuEnter.Add(testWorldPanel);

Events.OnGamepadConnect.Add(MainOptions.OnGamepadConnect)
Events.OnGamepadDisconnect.Add(MainOptions.OnGamepadDisconnect)
