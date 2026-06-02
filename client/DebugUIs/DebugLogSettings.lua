require "ISUI/ISCollapsableWindow"

DebugLogSettings = ISCollapsableWindow:derive("DebugLogSettings")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local LOG_SEVERITY_UNSPECIFIED = "unspecified"

-----

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

-----

function DebugLogSettings:onComboBox(comboBox, debugType)
	local logSeverity = comboBox:getOptionData(comboBox.selected)
	if logSeverity == LOG_SEVERITY_UNSPECIFIED then
		DebugLog.updateSelectedProfile(debugType, nil)
	else
		debugType:setLogSeverity(logSeverity)
		DebugLog.updateSelectedProfile(debugType, logSeverity)
	end
end

function DebugLogSettings:onSetProfile(comboBox)
	local profileOrAlias = comboBox:getOptionData(comboBox.selected)
	DebugLog.invokeProfile(profileOrAlias)
	self:syncCombos()
end

function DebugLogSettings:onSetAll(comboBox)
	local logSeverity = comboBox:getOptionData(comboBox.selected)
	if logSeverity == LOG_SEVERITY_UNSPECIFIED then
		DebugLog.updateSelectedProfileAll(nil)
	else
		DebugLog.updateSelectedProfileAll(logSeverity)
	end
	DebugLog.invokeSelectedProfile()
	comboBox.selected = 0 -- no selected option
	self:syncCombos()
end

function DebugLogSettings:onSave(button)
	DebugLog.writeConfigFile()
end

function DebugLogSettings:createChildren()
	local debugTypes = DebugLog.getDebugTypes()
	local maxWidth = 0
	for i=1,debugTypes:size() do
		local debugType = debugTypes:get(i-1)
		maxWidth = math.max(maxWidth, getTextManager():MeasureStringX(UIFont.Small, debugType:name()))
	end

	local comboWidth = 100
	local comboHgt = FONT_HGT_SMALL + 3 * 2

	local x = UI_BORDER_SPACING
	local y = self:titleBarHeight() + 6

	local comboBox = ISComboBox:new(x, y, comboWidth, comboHgt, self, self.onSetProfile)
	self:addChild(comboBox)
	comboBox.noSelectionText = "PROFILE"
	local minWidth = getTextManager():MeasureStringX(UIFont.Small, comboBox.noSelectionText)
	local selected = 0
	local profileList = DebugLog.getProfileNames()
	for i=1,profileList:size() do
		local profileName = profileList:get(i-1)
		comboBox:addOptionWithData(profileName, profileName)
		if profileName == DebugLog.getSelectedProfileName() then
			selected = comboBox:getOptionCount()
		end
	end
	local aliasList = DebugLog.getProfileAliases()
	for i=1,aliasList:size() do
		local alias = "$"..aliasList:get(i-1)
		comboBox:addOptionWithData(alias, alias)
		if alias == DebugLog.getSelectedProfileName() then
			selected = comboBox:getOptionCount()
		end
	end
	comboBox.selected = selected
	comboBox:setWidthToOptions(10 + minWidth + 5 + comboBox.image:getWidthOrig() + 3)

	comboBox = ISComboBox:new(comboBox:getRight() + 20, y, comboWidth, comboHgt, self, self.onSetAll)
	self:addChild(comboBox)
	comboBox.noSelectionText = "SET ALL TO"
	local minWidth = getTextManager():MeasureStringX(UIFont.Small, comboBox.noSelectionText)
	comboBox:addOptionWithData("Unspecified", LOG_SEVERITY_UNSPECIFIED)
	local logSeverityList = LogSeverity.getValueList()
	for i=1,logSeverityList:size() do
		local logSeverity = logSeverityList:get(i-1)
		comboBox:addOptionWithData(logSeverity:name(), logSeverity)
	end
	comboBox.selected = 0
	comboBox:setWidthToOptions(10 + minWidth + 5 + comboBox.image:getWidthOrig() + 3)
	self.comboSetAll = comboBox

	local button = ISButton:new(comboBox:getRight() + 20, y, 20, comboHgt, "SAVE", self, self.onSave)
	self:addChild(button)
	y = comboBox:getBottom() + UI_BORDER_SPACING

	local horizontalLine = HorizontalLine:new(x, y, 100)
	self:addChild(horizontalLine)
	y = horizontalLine:getBottom() + UI_BORDER_SPACING

	self.comboLookup = {}
	for i=1,debugTypes:size() do
		local debugType = debugTypes:get(i-1)
		local label = ISLabel:new(x, y, comboHgt, debugType:name(), 1, 1, 1, 1, UIFont.Small, true)
		self:addChild(label)
		local comboBox = ISComboBox:new(x + maxWidth + 8, y, comboWidth, comboHgt, self, self.onComboBox, debugType)
		self:addChild(comboBox)
		comboBox:addOptionWithData("Unspecified", LOG_SEVERITY_UNSPECIFIED)
		local logSeverityList = LogSeverity.getValueList()
		for i=1,logSeverityList:size() do
			local logSeverity = logSeverityList:get(i-1)
			comboBox:addOptionWithData(logSeverity:name(), logSeverity)
		end
		comboBox:setWidthToOptions()
		comboWidth = comboBox:getWidth()
		self.comboLookup[debugType] = comboBox
		y = comboBox:getBottom() + UI_BORDER_SPACING
		if self.y + y + comboHgt + UI_BORDER_SPACING >= getCore():getScreenHeight() then
			x = x + maxWidth + 8 + comboWidth + 20
			y = horizontalLine:getBottom() + UI_BORDER_SPACING
		end
	end

	self:shrinkWrap(UI_BORDER_SPACING, UI_BORDER_SPACING, nil)
	horizontalLine:setWidth(self.width - UI_BORDER_SPACING * 2)
end

function DebugLogSettings:setVisible(bVisible)
	ISCollapsableWindow.setVisible(self, bVisible)
	if bVisible then
		self:syncCombos()
	end
end

function DebugLogSettings:syncCombos()
	local profileOrAlias = DebugLog.getSelectedProfileName()
	local enabled = profileOrAlias ~= nil and profileOrAlias ~= "" and not luautils.stringStarts(profileOrAlias, "$")
	self.comboSetAll:setEnabled(enabled)
	for debugType,comboBox in pairs(self.comboLookup) do
		local logSeverity
		if profileOrAlias == nil then
			logSeverity = debugType:getLogSeverity()
		else
			logSeverity = DebugLog.getLogSeverityForSelectedProfile(debugType)
			if logSeverity == nil then
				logSeverity = LOG_SEVERITY_UNSPECIFIED
			end
		end
		comboBox:selectData(logSeverity)
		comboBox:setEnabled(enabled)
	end
end

function DebugLogSettings:onMouseDownOutside(x, y)
	if self:isMouseOver() then return end
	self:setVisible(false)
	self:removeFromUIManager()
end

function DebugLogSettings:new(x, y, width, height)
	local o = ISCollapsableWindow.new(self, x, y, width, height)
	o.backgroundColor = {r=0, g=0, b=0, a=1.0}
	o.resizable = false
	return o
end

