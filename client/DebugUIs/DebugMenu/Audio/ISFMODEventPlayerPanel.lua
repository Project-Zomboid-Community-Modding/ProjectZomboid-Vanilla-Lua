--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "DebugUIs/DebugMenu/Base/ISDebugSubPanelBase"

ISFMODEventPlayerPanel = ISDebugSubPanelBase:derive("ISFMODEventPlayerPanel")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local SCROLL_BAR_WIDTH = 12

-----

local PARAMETERS = {}
table.insert(PARAMETERS, { name = "BroadcastGenre", type = "combo", values = { "Generic", "News", "EntertainmentNews", "Drama", "KidsShow", "Sports", "MiltaryRadio", "AmateurRadio", "Commercial", "MusicDJ", "GenericVoices", "FranticMilitary" } })
table.insert(PARAMETERS, { name = "BroadcastVoiceType", type = "combo", values = { "Male", "Female" } })
table.insert(PARAMETERS, { name = "BulletHitSurface", type = "combo", values = { "Default", "Flesh", "Flesh_Hollow", "Concrete", "Plaster", "Stone", "Wood", "Wood_Solid", "Brick", "Metal", "Metal_Large", "Metal_Light", "Metal_Solid", "Glass", "Glass_Light", "Glass_Solid", "Cinderblock", "Plastic", "Ceramic", "Rubber", "Fabric", "Carpet", "Dirt", "Grass", "Gravel", "Sand", "Snow" } })
table.insert(PARAMETERS, { name = "CharacterMovementSpeed", type = "combo", values = { "SneakWalk", "SneakRun", "Strafe", "Walk", "Run", "Sprint" } })
table.insert(PARAMETERS, { name = "CookingState", type = "combo", values = { "Cooking", "Burning" } })
table.insert(PARAMETERS, { name = "EquippedBaggageContainer", type = "combo", values = { "None", "HikingBag", "DuffleBag", "PlasticBag", "SchoolBag", "ToteBag", "GarbageBag" } })
table.insert(PARAMETERS, { name = "FenceTypeLow", type = "combo", values = { "Wood", "Metal", "Sandbag", "Gravelbag", "Barbwire", "RoadBlock", "MetalGate" } })
table.insert(PARAMETERS, { name = "FireSize", type = "combo", values = { "Small", "Medium", "Large" } })
table.insert(PARAMETERS, { name = "FootstepMaterial", type = "combo", values = { "Upstairs", "BrokenGlass", "Concrete", "Grass", "Gravel", "Puddle", "Snow", "Wood", "Carpet", "Dirt", "Sand", "Ceramic", "Metal" }, defaultValue = 2.0 })
table.insert(PARAMETERS, { name = "FootstepMaterial2", type = "combo", values = { "None", "BrokenGlass", "PuddleShallow", "PuddleDeep" } })
table.insert(PARAMETERS, { name = "MeleeHitSurface", type = "combo", values = { "Default", "Body", "Fabric", "Glass", "Head", "Metal", "Plastic", "Stone", "Wood", "GarageDoor", "MetalDoor", "MetalGate", "PrisonMetalDoor", "SlidingGlassDoor", "WoodDoor", "WoodGate", "Tree" } })
table.insert(PARAMETERS, { name = "RoomType", type = "combo", values = { "Generic", "Barn", "Mall", "Warehouse", "Prison", "Church", "Office", "Factory", "MovieTheater" } })
table.insert(PARAMETERS, { name = "Season", type = "combo", values = { "Spring", "Summer", "Autumn", "Winter" } })
table.insert(PARAMETERS, { name = "Storm", type = "combo", values = { "None", "Thunder", "Tropical", "Blizzard" } })
table.insert(PARAMETERS, { name = "ShoeType", type = "combo", values = { "Barefoot", "Boots", "FlipFlops", "Shoes", "Slippers", "Sneakers" } })
table.insert(PARAMETERS, { name = "TripObstacleType", type = "combo", values = { "Wood", "Metal", "Sandbag", "Gravelbag", "Barbwire", "Tree", "Zombie", "CollideWithWall", "Metal  Bars", "Window" } })
table.insert(PARAMETERS, { name = "VehicleEngineCondition", type = "entry", defaultValue = 100.0 } )
table.insert(PARAMETERS, { name = "VehicleHitLocation", type = "combo", values = { "Front", "Rear", "Side" } } )
table.insert(PARAMETERS, { name = "VehicleRoadMaterial", type = "combo", values = { "Concrete", "Grass", "Gravel", "Puddle", "Snow", "Wood", "Carpet", "Dirt", "Sand" } })
table.insert(PARAMETERS, { name = "VehicleRPM", type = "entry", defaultValue = 800.0 } )
table.insert(PARAMETERS, { name = "ZombieState", type = "combo", values = { "Idle", "Eating", "SearchTarget", "LockTarget", "AttachScratch", "AttackLacerate", "AttackBite", "Hit", "Death", "Reanimate", "Pushed", "GettingUp", "Attack", "RunOver" } } )
--[[
table.insert(PARAMETERS, { name = "", min = 0.0, max = 1.0, type = "" })
table.insert(PARAMETERS, { name = "", min = 0.0, max = 1.0, type = "" })
table.insert(PARAMETERS, { name = "", min = 0.0, max = 1.0, type = "" })
table.insert(PARAMETERS, { name = "", min = 0.0, max = 1.0, type = "" })
table.insert(PARAMETERS, { name = "", min = 0.0, max = 1.0, type = "" })
table.insert(PARAMETERS, { name = "", min = 0.0, max = 1.0, type = "" })
table.insert(PARAMETERS, { name = "", min = 0.0, max = 1.0, type = "" })
table.insert(PARAMETERS, { name = "", min = 0.0, max = 1.0, type = "" })
--]]
local PARAMETER_MAP = {}
for _,v in ipairs(PARAMETERS) do
	PARAMETER_MAP[v.name] = v
end

-----

ISFMODEventPlayerParameterEditor = ISBaseObject:derive("ISFMODEventPlayerParameterEditor")

function ISFMODEventPlayerParameterEditor:setCurrentValue(value)
	if value == self.currentValue then return end
	if self.ui.combo then
		if not value then value = 0 end
		self.ui.combo.selected = value + 1
	end
	if self.ui.entry then
		local entryTxt = self:getEntryText(value)
		self.ui.entry:setText(entryTxt)
	end
	self.currentValue = value
	if not self.isGlobal then
		if value then
			self.eventPlayer:setParameterValue(self.parameterIndex, value)
		else
			self.eventPlayer:clearParameterValue(self.parameterIndex)
		end
	end
end

function ISFMODEventPlayerParameterEditor:getEntryText(value)
	if not value or (not self.isGlobal and value == -666) then
		return ""
	end
	if value == -666 then
		-- Unknown global parameter
		return "???"
	end
	return string.format("%.2f", value)
end

function ISFMODEventPlayerParameterEditor:update()
	local value = self.eventPlayer:getParameterValue(self.parameterIndex)
	if value == -666 and not self.isGlobal then
		local def = PARAMETER_MAP[self.parameterName]
		value = def and def.defaultValue or 0.0
	end
	self:setCurrentValue(value)
	if not self.isGlobal and self.ui.entry then
		if self.ui.entry:getText() == self:getEntryText(value) then
			self.ui.entry:setTextRGBA(1.0, 1.0, 1.0, 1.0)
		else
			self.ui.entry:setTextRGBA(0.0, 1.0, 1.0, 1.0)
		end
	end
end

function ISFMODEventPlayerParameterEditor:setUI(ui)
	self.ui = ui
	if self.isGlobal then
		ui.label:setColor(0.66, 0.66, 0.66)
	end
	if ui.entry and self.isGlobal then
		ui.entry:setEditable(false)
		ui.entry:setTextRGBA(0.66, 0.66, 0.66, 1.0)
	end
end

function ISFMODEventPlayerParameterEditor:onCombo()
	self:setCurrentValue(self.ui.combo.selected - 1)
end

function ISFMODEventPlayerParameterEditor:onCommandEntered()
	local value = tonumber(self.ui.entry:getText())
	self.currentValue = nil
	self:setCurrentValue(value)
end

function ISFMODEventPlayerParameterEditor:new(eventPlayer, eventPath, parameterIndex)
	local o = ISBaseObject.new(self)
	o.eventPlayer = eventPlayer
	o.eventPath = eventPath
	o.parameterIndex = parameterIndex
	o.parameterName = eventPlayer:getParameterName(eventPath, parameterIndex)
	o.isGlobal = eventPlayer:isGlobalParameter(eventPath, parameterIndex)
	return o
end

-----

function ISFMODEventPlayerPanel:createChildren()
	local x, y = UI_BORDER_SPACING + 1, UI_BORDER_SPACING + 1
	y, self.combo = ISDebugUtils.addComboBox(self, "eventCombo", x, y, self.width - SCROLL_BAR_WIDTH - x * 2, UIFont.Small, self.onCombo)
	self.combo:setEditable(true)
	self.combo:setHeight(BUTTON_HGT)
	y = y + (BUTTON_HGT - FONT_HGT_SMALL)

	local eventPathList = getFMODEventPathList()
	for i=1,eventPathList:size() do
		self.combo:addOption(eventPathList:get(i-1))
	end

	local tickOptions = {}
	table.insert(tickOptions, { text = getText("IGUI_FMODEvent_Loop"), ticked = false })
	table.insert(tickOptions, { text = getText("IGUI_FMODEvent_FollowPlayer"), ticked = false })
	y, self.tickBox = ISDebugUtils.addTickBox(self, "tickBoxLoop", x, y + UI_BORDER_SPACING, 150, BUTTON_HGT, "Loop", tickOptions, self.onTickBox)

	local valueWidth = UI_BORDER_SPACING + 1 + SCROLL_BAR_WIDTH + math.max(
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_FMODEvent_Seconds", 999)),
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_FMODEvent_Volume", string.format("%.1f", 99.9))),
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_FMODEvent_Milliseconds", 99999))
	)

	y, self.sliderDuration = ISDebugUtils.addSlider(self, "slider_duration", x, y + UI_BORDER_SPACING, self.width - SCROLL_BAR_WIDTH - x * 2 - 10 - valueWidth, self.combo.height, self.onSliderDuration)
	local y2, label = ISDebugUtils.addLabel(self, "label_duration", self.sliderDuration:getRight() + UI_BORDER_SPACING, self.sliderDuration.y, "", UIFont.Small, true)
	self.sliderDuration.valueLabel = label
	self.sliderDuration:setValues(0, 30, 1, 1)
	self.sliderDuration:setCurrentValue(0)

	y, self.sliderVolume = ISDebugUtils.addSlider(self, "slider_volume", x, y + UI_BORDER_SPACING, self.width - SCROLL_BAR_WIDTH - x * 2 - 10 - valueWidth, self.combo.height, self.onSliderVolume)
	local y2, label = ISDebugUtils.addLabel(self, "label_volume", self.sliderVolume:getRight() + UI_BORDER_SPACING, self.sliderVolume.y, "", UIFont.Small, true)
	self.sliderVolume.valueLabel = label
	self.sliderVolume:setValues(0, 10, 0.1, 0.1)
	self.sliderVolume:setCurrentValue(1)

	y, self.sliderTimeline = ISDebugUtils.addSlider(self, "slider_timeline", x, y + UI_BORDER_SPACING, self.width - SCROLL_BAR_WIDTH - x * 2 - 10 - valueWidth, self.combo.height, self.onSliderTimeline)
	local y2, label = ISDebugUtils.addLabel(self, "label_timeline", self.sliderTimeline:getRight() + UI_BORDER_SPACING, self.sliderTimeline.y, "", UIFont.Small, true)
	self.sliderTimeline.valueLabel = label
	self.sliderTimeline:setValues(0, 10000, 1, 100)
	self.sliderTimeline:setCurrentValue(1)

	local bw = 100
	y, self.buttonPlay = ISDebugUtils.addButton(self, "buttonPlay", x, y + UI_BORDER_SPACING, bw, BUTTON_HGT, getText("IGUI_FMODEvent_Play"), self.onButtonPlay)
	self.buttonPlay:setSound("activate", nil)
	y, self.buttonStop = ISDebugUtils.addButton(self, "buttonStop", self.buttonPlay:getRight() + UI_BORDER_SPACING, self.buttonPlay.y, bw, BUTTON_HGT, getText("IGUI_FMODEvent_Stop"), self.onButtonStop)
	self.buttonStop:setSound("activate", nil)

	self.parameterY = y

	self.parameterEditors = {}
end

function ISFMODEventPlayerPanel:initParameterEditors(eventPath)
	for _,editor in ipairs(self.parameterEditors) do
		self:removeChild(editor.ui)
	end
	table.wipe(self.parameterEditors)
	local y = self.parameterY
	local ui
	local sorted = {}
	local parameterCount = self.javaPlayer:getParameterCount(eventPath)
	for i=1,parameterCount do
		local parameterName = self.javaPlayer:getParameterName(eventPath, i - 1)
		table.insert(sorted, { name = parameterName, index = i - 1 })
	end
	table.sort(sorted, function(a, b) return a.name < b.name end)
	for i=1,parameterCount do
		local index = sorted[i].index
		local editor = ISFMODEventPlayerParameterEditor:new(self.javaPlayer, eventPath, index)
		local parameterName = self.javaPlayer:getParameterName(eventPath, index)
		y, ui = self:createParameterEditorUI(editor, parameterName, y + 10)
		ui.editor = editor
		editor:setUI(ui)
		table.insert(self.parameterEditors, editor)
	end
	self:setScrollHeight(y + UI_BORDER_SPACING+1)
end

function ISFMODEventPlayerPanel:createParameterEditorUI(editor, parameterName, y)
	local entryHgt = BUTTON_HGT
	local panel = ISPanel:new(UI_BORDER_SPACING+1, y, self.width - SCROLL_BAR_WIDTH - (UI_BORDER_SPACING+1)*2, FONT_HGT_SMALL + entryHgt)
	panel.label = ISLabel:new(0, 0, FONT_HGT_SMALL, parameterName, 1, 1, 1, 1, UIFont.Small, true)
	panel:addChild(panel.label)
	local def = PARAMETER_MAP[parameterName]
	if def and def.type == "combo" then
		panel.combo = ISComboBox:new(0, panel.label:getBottom(), panel.width, entryHgt, editor, function() editor:onCombo() end)
		panel:addChild(panel.combo)
		for _,v in ipairs(def.values) do
			panel.combo:addOption(v)
		end
	else
		panel.entry = ISTextEntryBox:new("", 0, panel.label:getBottom(), panel.width, entryHgt)
		panel:addChild(panel.entry)
		panel.entry.onCommandEntered = function() editor:onCommandEntered() end
	end
	self:addChild(panel)
	panel:noBackground()
	return panel:getBottom(), panel
end

function ISFMODEventPlayerPanel:onCombo()
	local eventPath = self.combo:getOptionText(self.combo.selected)
	self.javaPlayer:initParameterValues(eventPath)
	self:initParameterEditors(eventPath)
end

function ISFMODEventPlayerPanel:onTickBox(index, selected)
	if index == 1 then
		self.javaPlayer:setLoop(selected)
	end
	if index == 2 then
		self.javaPlayer:setFollowPlayer(selected)
	end
end

function ISFMODEventPlayerPanel:onSliderDuration(value, slider)
	self.javaPlayer:setDurationMillis(value * 1000)
	self.sliderDuration.valueLabel:setName(getText("IGUI_FMODEvent_Seconds", value))
end

function ISFMODEventPlayerPanel:onSliderVolume(value, slider)
	self.javaPlayer:setVolume(value * value)
	self.sliderVolume.valueLabel:setName(getText("IGUI_FMODEvent_Volume", string.format("%.1f", value)) )
end

function ISFMODEventPlayerPanel:onSliderTimeline(value, slider)
	self.javaPlayer:setTimelinePosition(value)
	self.sliderTimeline.valueLabel:setName(getText("IGUI_FMODEvent_Milliseconds", value))
end

function ISFMODEventPlayerPanel:onButtonPlay()
	local eventPath = self.combo:getOptionText(self.combo.selected)
	self.javaPlayer:play(eventPath)
end

function ISFMODEventPlayerPanel:onButtonStop()
	self.javaPlayer:stop()
end

function ISFMODEventPlayerPanel:prerender()
	ISDebugSubPanelBase.prerender(self)
	self.buttonStop:setEnable(self.javaPlayer:isPlaying())
	for _,editor in ipairs(self.parameterEditors) do
		editor:update()
	end
end

function ISFMODEventPlayerPanel:render()
	ISDebugSubPanelBase.render(self)
	self.javaPlayer:update()
end

function ISFMODEventPlayerPanel:new(x, y, width, height, doStencil)
	local o = ISDebugSubPanelBase.new(self, x, y, width, height, doStencil)
	o.javaPlayer = FMODDebugEventPlayer.new()
	return o
end

