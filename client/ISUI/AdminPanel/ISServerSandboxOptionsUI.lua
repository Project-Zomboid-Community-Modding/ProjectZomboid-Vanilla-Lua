--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISPanelJoypad"
require "ISUI/ISScrollingListBox"

ISServerSandboxOptionsUI = ISPanelJoypad:derive("ISServerSandboxOptionsUI")
local SandboxOptionsScreenListBox = ISScrollingListBox:derive("SandboxOptionsScreenListBox")
local SandboxOptionsScreenPanel = ISPanelJoypad:derive("SandboxOptionsScreenPanel")
local SandboxOptionsScreenPresetPanel = ISPanelJoypad:derive("SandboxOptionsScreenPresetPanel")
local SandboxOptionsScreenGroupBox = SandboxOptionsScreenPanel:derive("SandboxOptionsScreenGroupBox")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local FONT_HGT_LARGE = getTextManager():getFontHeight(UIFont.Large)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

local  preset

local function getTooltipText(name)
	local tooltip = getTextOrNull(name)
	if tooltip then
		tooltip = tooltip:gsub("\\n", "\n")
		tooltip = tooltip:gsub("\\\"", "\"")
	end
	return tooltip
end

function SandboxOptionsScreenListBox:doDrawItem(y, item, alt)
	self:drawRectBorder(0, y, self:getWidth(), self.itemheight - 1, 0.5, self.borderColor.r, self.borderColor.g, self.borderColor.b)

	if item.item.category then
		self:drawRect(0, y, self:getWidth(), self.itemheight - 1, 0.3, 0.5, 0.5, 0.5)
		local tex = getTexture("media/ui/ArrowDown.png")
		self:drawTexture(tex, 4, y + (item.height - tex:getHeight()) / 2, 1, 1, 1, 1)
	elseif self.selected == item.index then
		self:drawRect(0, y, self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15)
	elseif self.mouseoverselected == item.index and not self:isMouseOverScrollBar() then
		self:drawRect(1, y + 1, self:getWidth() - 2, item.height - 4, 0.95, 0.05, 0.05, 0.05)
	end

	local dx = 16
	local dy = (self.itemheight - getTextManager():getFontHeight(self.font)) / 2
	if item.searchFound then
		self:drawText(item.text, dx, y + dy, 0.0, 0.9, 0.0, 0.9, self.font)
	else
		self:drawText(item.text, dx, y + dy, 0.9, 0.9, 0.9, 0.9, self.font)
	end

	return y + item.height
end

function SandboxOptionsScreenListBox:onLoseJoypadFocus(joypadData)
	ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
end

function SandboxOptionsScreenListBox:onJoypadDown(button, joypadData)
	if button == Joypad.BButton then
		joypadData.focus = self.parent
		updateJoypadFocus(joypadData)
	end
end

function SandboxOptionsScreenListBox:onJoypadDirLeft(joypadData)
	joypadData.focus = self.parent.presetPanel
	updateJoypadFocus(joypadData)
end

function SandboxOptionsScreenListBox:onJoypadDirRight(joypadData)
	joypadData.focus = self.parent.currentPanel
	updateJoypadFocus(joypadData)
end

-- -- -- -- --
-- -- -- -- --
-- -- -- -- --

function SandboxOptionsScreenPanel:prerender()
	ISPanelJoypad.prerender(self)
	if not self.entryText then
		self.entryText = {}
	end
	for _,settingName in ipairs(self.settingNames) do
		local label = self.labels[settingName]
		local control = self.controls[settingName]
		if label and control then
			label:setColor(1, 1, 1)
			if label.searchFound then
				label:setColor(0, 1, 0)
			end
		end
		if control and control.Type == "ISTextEntryBox" then
			local text = control:getText()
			if text ~= self.entryText[settingName] then
				self.entryText[settingName] = text
				local option = getSandboxOptions():getOptionByName(settingName)
				if option then
					if option:isValidString(text) then
						control.borderColor.a = 1
						control.borderColor.g = 0.4
						control.borderColor.b = 0.4
					else
						control.borderColor.a = 0.9
						control.borderColor.g = 0.0
						control.borderColor.b = 0.0
					end
				end
			end
		end
	end
	local x1,y1,x2,y2 = 1,1,self.width-1,self.height-1
	if self.isGroupBoxContentsPanel then
		y1 = self.parent.tickBox:getHeight() / 2
		y2 = self.height-6
	end
	self:setStencilRect(x1, y1, x2 - x1 + 1, y2 - y1 + 1)
end

function SandboxOptionsScreenPanel:render()
	self:drawRectBorderStatic(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b)
	ISPanelJoypad.render(self)
	self:clearStencilRect()
	if self.isGroupBoxContentsPanel then
		self:repaintStencilRect(0, 0, self.width, self.height)
	end
end

function SandboxOptionsScreenPanel:onMouseWheel(del)
	if self:getScrollHeight() > 0 then
		self:setYScroll(self:getYScroll() - (del * 40))
		return true
	end
end

function SandboxOptionsScreenPanel:onGainJoypadFocus(joypadData)
	ISPanelJoypad.onGainJoypadFocus(self, joypadData)
	if self.joypadButtons[self.joypadIndex] then
		self.joypadButtons[self.joypadIndex]:setJoypadFocused(true, joypadData)
	end
end

function SandboxOptionsScreenPanel:onLoseJoypadFocus(joypadData)
	ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
	self:clearJoypadFocus()
end

function SandboxOptionsScreenPanel:onJoypadDown(button, joypadData)
	if button == Joypad.BButton and not self:isFocusOnControl() then
		joypadData.focus = self.parent
		updateJoypadFocus(joypadData)
	else
		ISPanelJoypad.onJoypadDown(self, button, joypadData)
	end
end

function SandboxOptionsScreenPanel:onJoypadDirLeft(joypadData)
	if not self:isFocusOnControl() then
		joypadData.focus = self.parent.listbox
		updateJoypadFocus(joypadData)
	end
end

function SandboxOptionsScreenPanel:onJoypadDirRight(joypadData)
	if not self:isFocusOnControl() then
		joypadData.focus = self.parent.presetPanel
		updateJoypadFocus(joypadData)
	end
end

-- -- -- -- --
-- -- -- -- --
-- -- -- -- --

function SandboxOptionsScreenGroupBox:new(x, y, width, height, tickBoxLabel)
	local o = ISPanelJoypad:new(x, y, width, height)
	setmetatable(o, self)
	self.__index = self
	o.tickBoxLabel = tickBoxLabel
	o.settings = nil
	return o
end

function SandboxOptionsScreenGroupBox:createChildren()
	local tickBox = ISTickBox:new(20, 4, 100, entryHgt, "", self, self.onTicked)
	tickBox.backgroundColor.a = 1
	tickBox.background = true
	tickBox.choicesColor = {r=1, g=1, b=1, a=1}
	tickBox.leftMargin = 2
	tickBox:setFont(UIFont.Small)
	tickBox:addOption(self.tickBoxLabel)
	tickBox:setWidthToFit()
	tickBox.selected[1] = true
	self.tickBox = tickBox

	local scrollBarWidth = 17
	local cover = ISPanel:new(13, tickBox:getBottom(), self:getWidth() - 13 * 2 - scrollBarWidth, self:getHeight() - 13 - tickBox:getBottom())
	cover.borderColor.a = 0
	cover:setAnchorRight(true)
	cover:setAnchorBottom(true)
	cover:initialise()
	cover:instantiate()
	cover.javaObject:setConsumeMouseEvents(true)
	self.cover = cover

	local groupY = tickBox:getY() + tickBox:getHeight() / 2
	local contents = SandboxOptionsScreenPanel:new(12, groupY, self:getWidth() - 12 * 2, self:getHeight() - 12 - groupY)
	contents.borderColor.a = 0.6
	contents:setAnchorRight(true)
	contents:setAnchorBottom(true)
	contents.settingNames = {}
	contents.isGroupBoxContentsPanel = true
	self.contents = contents

	self:addChild(contents)
	self:addChild(cover)
	self:addChild(tickBox)
end

function SandboxOptionsScreenGroupBox:onTicked(index, selected)
	if selected then
		local options = self.settings
		for _,settingName in ipairs(self.settingNames) do
			local option = options:getOptionByName(settingName)
			local control = self.controls[settingName]
			if control.Type == "ISComboBox" then
				control.selected = option:getDefaultValue()
			elseif control.Type == "ISTickBox" then
				control.selected[1] = option:getDefaultValue()
			else
				error "unhandled control type"
			end
		end
		self.cover:setVisible(true)
	else
		self.cover:setVisible(false)
	end
	self:setJoypadButtons()
end

function SandboxOptionsScreenGroupBox:settingsToUI(settings)
	self.settings = settings
	local options = settings
	local allDefault = true
	for _,settingName in ipairs(self.settingNames) do
		local option = options:getOptionByName(settingName)
		local control = self.controls[settingName]
		if control.Type == "ISComboBox" then
			if control.selected ~= option:getDefaultValue() then
				allDefault = false
				break
			end
		elseif control.Type == "ISTickBox" then
			if control.selected[1] ~= option:getDefaultValue() then
				allDefault = false
				break
			end
		else
-- 			error "unhandled control type"
		end
	end
	self.cover:setVisible(allDefault)
	self.tickBox.selected[1] = allDefault
	self:setJoypadButtons()
end

function SandboxOptionsScreenGroupBox:setJoypadButtons()
	if self.joypadIndexY > 1 then
		self:clearJoypadFocus()
	end
	self.joypadButtonsY = {}
	self:insertNewLineOfButtons(self.tickBox)
	if not self.tickBox.selected[1] then
		for _,control in pairs(self.controls) do
			self:insertNewLineOfButtons(control)
		end
	end
	self.joypadIndex = 1
	self.joypadIndexY = 1
	self.joypadButtons = self.joypadButtonsY[1]
end

function SandboxOptionsScreenGroupBox:ensureVisible()
	if not self.joyfocus then return end
	local child = self.joypadButtons[self.joypadIndex]
	if not child or child == self.tickBox then return end
	local y = child:getY()
	if y - 40 < 0 - self.contents:getYScroll() then
		self.contents:setYScroll(0 - y + 40)
	elseif y + child:getHeight() + 40 > 0 - self.contents:getYScroll() + self.contents:getHeight() then
		self.contents:setYScroll(0 - (y + child:getHeight() + 40 - self.contents:getHeight()))
	end
end

-- -- -- -- --
-- -- -- -- --
-- -- -- -- --

function SandboxOptionsScreenPresetPanel:createChildren()
	
	local label = ISLabel:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, BUTTON_HGT, getText("UI_ServerSettings_ListOfPresets"), 1, 1, 1, 1, UIFont.Small, true)
	self:addChild(label)

	self.listbox = ISScrollingListBox:new(UI_BORDER_SPACING+1, label:getBottom() + UI_BORDER_SPACING, math.min(self.width - UI_BORDER_SPACING * 2, self.width/3), math.min(self.height-label:getBottom() - UI_BORDER_SPACING*2 - 1, BUTTON_HGT * 12))
	self.listbox:initialise()
	self.listbox:instantiate()
	self.listbox:setAnchorLeft(true)
	self.listbox:setAnchorRight(false)
	self.listbox:setAnchorTop(true)
	self.listbox:setAnchorBottom(false)
	self.listbox:setFont(UIFont.Small, 3)
	self.listbox.drawBorder = true
	self.listbox.vscroll:setHeight(self.listbox.height)
	self.listbox.disableRemove = true
	self:addChild(self.listbox)

	local buttonX = self.listbox:getRight() + UI_BORDER_SPACING
	local buttonY = self.listbox:getY()
	local buttonWid = getTextManager():MeasureStringX(UIFont.Small, getText("UI_ServerSettings_ButtonApplyPreset")) + UI_BORDER_SPACING*2

	local button = ISButton:new(buttonX, buttonY, buttonWid, BUTTON_HGT, getText("UI_ServerSettings_ButtonApplyPreset"), self, self.onButtonApplyPreset)
	button:initialise()
	button:setAnchorLeft(true)
	button:setAnchorTop(false)
	button:setAnchorRight(false)
	button:setAnchorBottom(false)
	button.borderColor = {r=1, g=1, b=1, a=0.2}
	button.tooltip = getTooltipText("UI_ServerSettings_ButtonApplyPreset_tooltip")
	self:addChild(button)
	self.buttonApplyPreset = button
end

function SandboxOptionsScreenPresetPanel:prerender()
	ISPanelJoypad.prerender(self)
	self.buttonApplyPreset:setEnable(self.listbox.items[self.listbox.selected] ~= nil)
end

function SandboxOptionsScreenPresetPanel:onButtonApplyPreset()
	local options = self.options
	options:resetToDefault()
	local data = self.listbox.items[self.listbox.selected].item
	local name = data.fileName
	if data.userDefined then
		options:loadPresetFile(data.fileName)
	else
		options:loadGameFile(data.fileName)
	end
	self.parent:settingsToUI(options)
    getWorld():setPreset(name);
end

local index
local presets = {}

function SandboxOptionsScreenPresetPanel:addPresetToList(fileName, text, userDefined)
    index = index + 1
-- 	local mode = getCore():getGameMode()
	local preset = getWorld():getPreset()
	local item = {}
	item.fileName = fileName
	item.userDefined = userDefined
	self.listbox:addItem(text, item)

-- 	if mode == fileName then
	if preset == fileName then
        self.listbox.selected = index
    end

end

function SandboxOptionsScreenPresetPanel:settingsToUI(options)
    index = 0
	self.options = options
	self.listbox:clear()
	self:addPresetToList("Apocalypse", getText("UI_NewGame_Apocalypse"), false)
	self:addPresetToList("Survivor", getText("UI_NewGame_Survivor"), false)
	self:addPresetToList("Builder", getText("UI_NewGame_Builder"), false)
	self:addPresetToList("Beginner", getText("UI_NewGame_InitialInfection"), false)
	self:addPresetToList("FirstWeek", getText("UI_NewGame_OneWeekLater"), false)
	self:addPresetToList("Survival", getText("UI_NewGame_Survival"), false)
	self:addPresetToList("SixMonthsLater", getText("UI_NewGame_SixMonths"), false)
	local presets = getSandboxPresets()
	if presets then
	    local mode = getCore():getGameMode()
		for i=1,presets:size() do
			local fileName = presets:get(i-1)
			self:addPresetToList(fileName, fileName, true)
		end
	end
	index = 0

-- 	getPlayer():Say(tostring(getCore():getGameMode()))
-- 	self.listbox:setSelectedIndex(index - 1)
end

-- -- -- -- --
-- -- -- -- --
-- -- -- -- --

function ISServerSandboxOptionsUI:doSearch()
	local searchWord = string.lower(self.searchEntry:getInternalText())
	for i, item in ipairs(self.listbox.items) do
		item.searchFound = false
		for name, label in pairs(item.item.panel.labels) do
			if searchWord ~= "" and string.find(string.lower(label:getName()), searchWord) then
				label.searchFound = true
				item.searchFound = true
			else
				label.searchFound = false
			end
		end
	end
end

function ISServerSandboxOptionsUI.searchPrerender(self)
	ISTextEntryBox.prerender(self)
	if not self.javaObject:isFocused() and self:getInternalText() == "" then
		self:drawText(getText("UI_sandbox_searchEntryBoxWord"), 2, 2, 0.9, 0.9, 0.9, 0.5, UIFont.Small)
	end
end

function ISServerSandboxOptionsUI:createChildren()
	local titleHgt = FONT_HGT_LARGE
	local btnWid = 100

	local SettingsTable = ServerSettingsScreen.getSandboxSettingsTable()
	SettingsTable[1] = {
		name = getText("UI_ServerSettingsGroup_SandboxPresets"),
		settings = {},
		customui = SandboxOptionsScreenPresetPanel,
	}

	local maxWid = 0
	for _,page in ipairs(SettingsTable) do
		local textWid = getTextManager():MeasureStringX(UIFont.Small, page.name)
		maxWid = math.max(maxWid, textWid)
	end

	local scrollBarWid = 17

	local searchHeight = FONT_HGT_SMALL + 4 * 2
	self.searchEntry = ISTextEntryBox:new("", UI_BORDER_SPACING+1, UI_BORDER_SPACING*2 + titleHgt + 1, UI_BORDER_SPACING*2 + maxWid + scrollBarWid, searchHeight)
	self.searchEntry.font = UIFont.Small
	self.searchEntry.onTextChange = function() self:doSearch() end
	self.searchEntry.setText = function(_self, str)
		if not str then
			str = "";
		end
		_self.javaObject:SetText(str);
		_self.title = str;

		if OnScreenKeyboard.IsVisible() then
			_self:onTextChange()
		end
	end
	self.searchEntry.prerender = self.searchPrerender
	self.searchEntry:initialise()
	self.searchEntry:instantiate()
	self:addChild(self.searchEntry)

	self.listbox = SandboxOptionsScreenListBox:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING*3 + searchHeight + titleHgt + 1, UI_BORDER_SPACING*2 + maxWid + scrollBarWid, self.height - BUTTON_HGT*2 - titleHgt - UI_BORDER_SPACING*5-2)
	self.listbox:initialise()
	self.listbox:setAnchorLeft(true)
	self.listbox:setAnchorRight(false)
	self.listbox:setAnchorTop(true)
	self.listbox:setAnchorBottom(true)
	self.listbox:setFont(UIFont.Small, 4)
	self.listbox.drawBorder = true
	self.listbox:setOnMouseDownFunction(self, self.onMouseDownListbox)
	self:addChild(self.listbox)

	local MAX_WIDTH = 0
	self.controls = {}
	self.groupBox = {}
	self.customui = {}
	for _,page in ipairs(SettingsTable) do
		local item = {}
		item.page = page
		item.panel = self:createPanel(page)
		if page.customui then
			table.insert(self.customui, item.panel)
		end
		self.listbox:addItem(page.name, item)
		MAX_WIDTH = math.max(MAX_WIDTH, item.panel.MAX_WIDTH)
	end

	self:setWidth(self.listbox:getRight() + MAX_WIDTH + scrollBarWid + UI_BORDER_SPACING*2)
	self:ignoreWidthChange()

	local titleWid = getTextManager():MeasureStringX(UIFont.Large, getText("UI_optionscreen_SandboxOptions"))
	local title = ISLabel:new(self.width / 2 - titleWid / 2, UI_BORDER_SPACING+1, FONT_HGT_LARGE, getText("UI_optionscreen_SandboxOptions"), 1, 1, 1, 1, UIFont.Large, true)
	title:initialise()
	title:instantiate()
	self:addChild(title)

	self.closeButton = ISButton:new(self.width - UI_BORDER_SPACING - btnWid - 1, self.height - UI_BORDER_SPACING - BUTTON_HGT - 1, btnWid, BUTTON_HGT, getText("IGUI_CraftUI_Close"), self, self.onButtonClose)
	self.closeButton.internal = "CLOSE"
	self.closeButton:initialise()
	self.closeButton:instantiate()
	self.closeButton:setAnchorLeft(false)
	self.closeButton:setAnchorTop(false)
	self.closeButton:setAnchorRight(false)
	self.closeButton:setAnchorBottom(true)
	self.closeButton:enableCancelColor()
	self:addChild(self.closeButton)

	self.applyButton = ISButton:new(0, self.closeButton.y, btnWid, BUTTON_HGT, getText("IGUI_PlayerStats_ReloadOptions"), self, self.onButtonApply)
	self.applyButton.internal = "APPLY"
	self.applyButton:initialise()
	self.applyButton:instantiate()
	self.applyButton:setAnchorLeft(false)
	self.applyButton:setAnchorTop(false)
	self.applyButton:setAnchorRight(false)
	self.applyButton:setAnchorBottom(true)
	self.applyButton:enableAcceptColor()
	self.applyButton:setWidthToTitle(100)
	self.applyButton:setX(self.closeButton.x - UI_BORDER_SPACING - self.applyButton.width)
	self:addChild(self.applyButton)

	self:settingsToUI(self.options)
	for _,panel in ipairs(self.customui) do
		panel:settingsToUI(self.options)
	end

	self:onMouseDownListbox(self.listbox.items[1].item)
end

function ISServerSandboxOptionsUI:createPanel(page)
	local panelX = self.listbox:getRight() + UI_BORDER_SPACING
	local panelY = self.searchEntry:getY()
	local panelW = self.width - self.listbox:getRight() - UI_BORDER_SPACING*2-1
	local panelH = self.listbox:getHeight() + self.searchEntry:getHeight() + UI_BORDER_SPACING
	if page.customui then
		local panel = page.customui:new(panelX, panelY, panelW, panelH)
		panel:initialise()
		panel:instantiate()
		panel.backgroundColor.a = panel.backgroundColor.a
		panel:setAnchorRight(true)
		panel:setAnchorBottom(true)
		panel.parent = self
		panel.MAX_WIDTH = 0
		for _,child in pairs(self:getChildren()) do
			panel.MAX_WIDTH = math.max(panel.MAX_WIDTH, child:getRight() + UI_BORDER_SPACING)
		end
		panel.labels = {}
		return panel
	end

	local panel
	local bgAlpha = 0.8
	if page.groupBox then
		panel = SandboxOptionsScreenGroupBox:new(panelX, panelY, panelW, panelH, getText("Sandbox_" .. page.groupBox))
		self.groupBox[page.groupBox] = panel
		bgAlpha = 1.0
	else
		panel = SandboxOptionsScreenPanel:new(panelX, panelY, panelW, panelH)
	end
	panel:initialise()
	panel:instantiate()
	panel.backgroundColor.a = panel.backgroundColor.a
--	if page.groupBox then panel.contents.backgroundColor.a = panel.contents.backgroundColor.a end
	panel:setAnchorRight(true)
	panel:setAnchorBottom(true)
	panel.settingNames = {}
	panel.controls = {}
	panel.labels = {}

	local fontHgt = FONT_HGT_SMALL
	local entryHgt = BUTTON_HGT

	local labels = {}
	local controls = {}
	for _,setting in ipairs(page.settings) do
		local settingName = setting.translatedName
		local tooltip = setting.tooltip
		if tooltip then
			tooltip = tooltip:gsub("\\n", "\n")
			tooltip = tooltip:gsub("\\\"", "\"")
		end
		local label = nil
		local control = nil
		local ignore = false
		if not getDebug() and (setting.name == "WaterShutModifier" or setting.name == "ElecShutModifier") then
			ignore = true
-- 		elseif setting.singlePlayerOnly then
			-- ignore
		elseif setting.type == "checkbox" then
			label = ISLabel:new(0, 0, entryHgt, settingName, 1, 1, 1, 1, UIFont.Small)
			control = ISTickBox:new(0, 0, 100, entryHgt, "", self, self.onTickBoxSelected, setting.name)
			control:addOption("")
			control.selected[1] = setting.default
			if setting.tooltip then
				control.tooltip = setting.tooltip
			end
		elseif setting.type == "entry" or setting.type == "string" then
			if getDebug() and (setting.name == "WaterShutModifier" or setting.name == "ElecShutModifier") then
				settingName = "*DEV* " .. setting.name
			end
			label = ISLabel:new(0, 0, entryHgt, settingName, 1, 1, 1, 1, UIFont.Small)
			control = ISTextEntryBox:new(setting.text, 0, 0, 200, entryHgt)
			control.font = UIFont.Small
			control.tooltip = tooltip
			control:initialise()
			control:instantiate()
			control.backgroundColor.a = control.backgroundColor.a
			control.backgroundColor.a = control.backgroundColor.a
			control:setOnlyNumbers(setting.onlyNumbers or false)
		elseif setting.type == "enum" then
			label = ISLabel:new(0, 0, entryHgt, settingName, 1, 1, 1, 1, UIFont.Small)
			control = ISComboBox:new(0, 0, 200, entryHgt, self, self.onComboBoxSelected, setting.name)
			if tooltip then
				control.tooltip = { defaultTooltip = tooltip }
			end
			control:initialise()
			for index,value in ipairs(setting.values) do
				control:addOption(value)
				if index == setting.default then
					control.selected = index
				end
			end
		elseif setting.type == "spinbox" then
			label = ISLabel:new(0, 0, entryHgt, settingName, 1, 1, 1, 1, UIFont.Small)
			control = ISSpinBox:new(0, 0, 200, entryHgt, nil, nil)
			control:initialise()
			control:instantiate()
			if setting.name == "StartYear" then
				local firstYear = getSandboxOptions():getFirstYear()
				for i=1,100 do
					control:addOption(tostring(firstYear + i - 1))
				end
			elseif setting.name == "StartDay" then
			end
		elseif setting.type == "text" then
			label = ISLabel:new(0, 0, entryHgt, settingName, 1, 1, 1, 1, UIFont.Smal)
			control = ISTextEntryBox:new(setting.text, 0, 0, 200,  BUTTON_HGT*4)
			control.font = UIFont.Small
			control:initialise()
			control:instantiate()
			control.backgroundColor.a = control.backgroundColor.a
			control:setMultipleLine(true)
			control:setMaxLines(64)
			control:addScrollBars()
		end
		if label and control then
			label.tooltip = tooltip
			table.insert(labels, label)
			table.insert(controls, control)
			self.controls[setting.name] = control
			table.insert(panel.settingNames, setting.name)
			panel.controls[setting.name] = control
			panel.labels[setting.name] = label
		else
			if not ignore then
				error "no label or control"
			end
		end
	end

	local labelWidth = 0
	for _,label in ipairs(labels) do
		labelWidth = math.max(labelWidth, label:getWidth())
	end
	local x = UI_BORDER_SPACING+1
	local y = UI_BORDER_SPACING+1
	local addControlsTo = panel
	if page.groupBox then
		addControlsTo = panel.contents
		y = math.max(UI_BORDER_SPACING+1, panel.tickBox.height / 2)
	end
	addControlsTo:setScrollChildren(true)
	addControlsTo:addScrollBars()
	addControlsTo.vscroll.doSetStencil = true
	for i=1,#labels do
		local label = labels[i]
		addControlsTo:addChild(label)
		label:setX(x + labelWidth - label:getWidth())
		label:setY(y)
		y = y + math.max(label:getHeight(), controls[i]:getHeight()) + UI_BORDER_SPACING
	end
	y = UI_BORDER_SPACING+1
	if page.groupBox then
		y = math.max(UI_BORDER_SPACING+1, panel.tickBox.height / 2)
	end
	panel.MAX_WIDTH = 0
	for i=1,#controls do
		local label = labels[i]
		local control = controls[i]
		addControlsTo:addChild(control)
		control:setX(x + labelWidth + UI_BORDER_SPACING)
		control:setY(y)
		y = y + math.max(label:getHeight(), control:getHeight()) + UI_BORDER_SPACING
		if control.isCombobox or control.isTickBox then
			panel:insertNewLineOfButtons(control)
		end
		addControlsTo:setScrollHeight(y+1)
		panel.MAX_WIDTH = math.max(panel.MAX_WIDTH, control:getRight() + UI_BORDER_SPACING)
	end
	if #panel.joypadButtonsY > 0 then
		panel.joypadIndex = 1
		panel.joypadIndexY = 1
		panel.joypadButtons = panel.joypadButtonsY[1]
	end
	return panel
end

function ISServerSandboxOptionsUI:onTickBoxSelected(_, value, optionName)
	if optionName == "ZombieMigrate" then
		if value then
			self.controls["ZombieConfig.RedistributeHours"]:setText("12.0")
		else
			self.controls["ZombieConfig.RedistributeHours"]:setText("0.0")
		end
	end
end

function ISServerSandboxOptionsUI:onComboBoxSelected(combo, optionName)
	if optionName == "Zombies" then
		local Zombies = combo.selected
		local popMult = ZombiePopulationMultiplierTable
		self.controls["ZombieConfig.PopulationMultiplier"]:setText(popMult[Zombies])
	end
	if optionName == "ZombieRespawn" then
		local respawn = combo.selected
		local respawnHours = { "16.0", "72.0", "216.0", "0.0" }
		self.controls["ZombieConfig.RespawnHours"]:setText(respawnHours[respawn])
		local respawnUnseenHours = { "6.0", "16.0", "48.0", "0.0" }
		self.controls["ZombieConfig.RespawnUnseenHours"]:setText(respawnUnseenHours[respawn])
		local respawnMultipler = { "0.5", "0.1", "0.05", "0.0" }
		self.controls["ZombieConfig.RespawnMultiplier"]:setText(respawnMultipler[respawn])
	end
end

function ISServerSandboxOptionsUI:settingsToUI(options)
	for i=1,options:getNumOptions() do
		local option = options:getOptionByIndex(i-1)
		local control = self.controls[option:getName()]
		if control then
			if option:getType() == "boolean" then
				control.selected[1] = option:getValue()
			elseif option:getType() == "double" then
				control:setText(option:getValueAsString())
			elseif option:getType() == "enum" then
				control.selected = option:getValue()
			elseif option:getType() == "integer" then
				control:setText(option:getValueAsString())
			elseif option:getType() == "string" then
				control:setText(option:getValue())
			elseif option:getType() == "text" then
				control:setText(option:getValue())
			end
		end
	end
	for _,groupBox in pairs(self.groupBox) do
		groupBox:settingsToUI(options)
	end
end

function ISServerSandboxOptionsUI:settingsFromUI(options)
	for i=1,options:getNumOptions() do
		local option = options:getOptionByIndex(i-1)
		local control = self.controls[option:getName()]
		if control then
			if option:getType() == "boolean" then
				option:setValue(control.selected[1] == true)
			elseif option:getType() == "double" then
				option:parse(control:getText())
			elseif option:getType() == "enum" then
				option:setValue(control.selected)
			elseif option:getType() == "integer" then
				option:parse(control:getText())
			elseif option:getType() == "string" then
				option:setValue(control:getText())
			elseif option:getType() == "text" then
				option:setValue(control:getText())
			end
		end
	    if not isClient() then
		    getSandboxOptions():set(option:getName(),option:getValue())
		end
	end
end

function ISServerSandboxOptionsUI:onMouseDownListbox(item)
	if item.page then
		if self.currentPanel then
			self:removeChild(self.currentPanel)
			self.currentPanel = nil
		end
		if item.panel then
			self:addChild(item.panel)
			item.panel:setWidth(self.width - self.listbox:getRight() - UI_BORDER_SPACING*2-1)
			item.panel:setHeight(self.listbox:getHeight() + self.searchEntry:getHeight() + UI_BORDER_SPACING)
			self.currentPanel = item.panel
		end
	end
end

function ISServerSandboxOptionsUI:destroy()
	self:removeFromUIManager()
end

function ISServerSandboxOptionsUI:onButtonApply()
	self:settingsFromUI(self.options)
	if isClient() then
	    self.options:sendToServer()
	end
	-- this is so mod stuff distribution stuff can get applied
    IsoWorld.parseDistributions()
    -- this is to apply any changes to the clutter pools on account of blacklist changes
    StoryClutter.Init()
	self:destroy()
end

function ISServerSandboxOptionsUI:onButtonClose()
	self:destroy()
end

function ISServerSandboxOptionsUI:new(x, y, width, height)
	local o = ISPanelJoypad:new(x, y, width, height)
	setmetatable(o, self)
	self.__index = self
	o.x = x
	o.y = y
	o.borderColor = {r=0.4, g=0.4, b=0.4, a=1}
	o.backgroundColor = {r=0, g=0, b=0, a=0.8}
	o.width = width
	o.height = height
	o.anchorLeft = true
	o.anchorRight = false
	o.anchorTop = true
	o.anchorBottom = false
	o.moveWithMouse = true
	o.options = SandboxOptions.new()
	o.options:copyValuesFrom(getSandboxOptions())
	ISServerSandboxOptionsUI.instance = o
	return o
end

