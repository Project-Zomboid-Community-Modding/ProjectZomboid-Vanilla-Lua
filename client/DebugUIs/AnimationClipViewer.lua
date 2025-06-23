--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require('ISUI/ISScrollingListBox')
require('Vehicles/ISUI/ISUI3DScene')

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local LABEL_HGT = FONT_HGT_MEDIUM + 6

AnimationClipViewer = ISPanel:derive("AnimationClipViewer")

-----

AnimationClipViewer_ListBox = ISScrollingListBox:derive("AnimationClipViewer_ListBox")
local ListBox = AnimationClipViewer_ListBox

function ListBox:prerender()
	ISScrollingListBox.prerender(self)
	local clipName = self.items[self.selected] and self.items[self.selected].text
	if clipName and (clipName ~= self.selectedClipName) then
		self.selectedClipName = clipName
		self.parent.scene.javaObject:fromLua2("setCharacterAnimationClip", self.parent.currentObjectName, clipName)
	end
end

function ListBox:doDrawItem(y, item, alt)
    if y + self:getYScroll() + self.itemheight < 0 or y + self:getYScroll() >= self.height then
        return y + self.itemheight
    end
    return ISScrollingListBox.doDrawItem(self, y, item, alt)
end

function ListBox:onMouseDown(x, y)
	ISScrollingListBox.onMouseDown(self, x, y)
end

function ListBox:indexOf(text)
	for i,item in ipairs(self.items) do
		if item.text == text then
			return i
		end
	end
	return -1
end

function ListBox:new(x, y, width, height)
	local o = ISScrollingListBox.new(self, x, y, width, height)
	return o
end

-----

AnimationClipViewer_SoundBar = ISPanel:derive("AnimationClipViewer_SoundBar")
local SoundBar = AnimationClipViewer_SoundBar

function SoundBar:render()
	for index,sound in ipairs(self.soundList) do
		if sound.enabled and sound.soundName ~= nil then
			self:renderSound(index, sound)
		end
	end
	self:playSounds()
end

function SoundBar:renderSound(index, sound)
	local text = string.format("%d", index)
	local textW = getTextManager():MeasureStringX(UIFont.Medium, text)
	local posX = self.width * sound.fraction
	self:drawText(text, posX - 10 - textW, (self.height - FONT_HGT_MEDIUM) / 2, 1.0, 1.0, 1.0, 1.0, UIFont.Medium)
	self:drawRect(posX - 1, 0, 2, self.height, 1.0, 0.0, 162 / 255, 232 / 255)
	self:drawText(string.format("%.2f", sound.fraction), posX + 10, (self.height - FONT_HGT_MEDIUM) / 2, 1.0, 1.0, 1.0, 1.0, UIFont.Medium)
end

function SoundBar:onMouseDown(x, y)
	self.mouseDown = true
	self.dragIndex = self:hitTest(x, y)
	self:setCapture(true)
	return true
end

function SoundBar:onMouseMove(dx, dy)
	if not self.mouseDown then return end
	if self.dragIndex == -1 then return end
	local x = math.min(self:getMouseX(), self.width)
	x = math.max(x, 0)
	self.soundList[self.dragIndex].fraction = x / self.width
end

function SoundBar:onMouseUp(x, y)
	if not self.mouseDown then return end
	self.mouseDown = false
	self:setCapture(false)
end

function SoundBar:onMouseMoveOutside(dx, dy)
	self:onMouseMove(dx, dy)
end

function SoundBar:onMouseUpOutside(x, y)
	self:onMouseUp(x, y)
end

function SoundBar:getSoundBounds(sound)
	local posX = self.width * sound.fraction
	return posX,posX-15,posX+15
end

function SoundBar:hitTest(x, y)
	local minDist = 10000
	local closest = -1
	for index,sound in ipairs(self.soundList) do
		if sound.enabled and sound.soundName ~= nil then
			local posX,minX,maxX = self:getSoundBounds(sound)
			if x >= minX and x < maxX then
				local dist = math.abs(x - posX)
				if dist < minDist then
					minDist = dist
					closest = index
				end
			end
		end
	end
	return closest
end

function SoundBar:playSounds()
	local scene = self.parent.parent.scene
	local time = scene.javaObject:fromLua1("getCharacterAnimationTime", self.parent.parent.currentObjectName)
	if time == nil then return end
	local duration = scene.javaObject:fromLua1("getCharacterAnimationDuration", self.parent.parent.currentObjectName)
	local fraction = time / duration
	for index,sound in ipairs(self.soundList) do
		if self.prevFraction > fraction then
			if sound.enabled and (sound.soundName ~= nil) and (self.prevFraction - 1 < sound.fraction) and (fraction >= sound.fraction) then
				self:playSound(index, sound.soundName)
			end
		else
			if sound.enabled and (sound.soundName ~= nil) and (self.prevFraction < sound.fraction) and (fraction >= sound.fraction) then
				self:playSound(index, sound.soundName)
			end
		end
	end
	self.prevFraction = fraction
end

function SoundBar:playSound(index, soundName)
	self:stopSound(index)
	local sound = self.soundList[index]
	sound.eventInstance = getSoundManager():playUISound(soundName)
end

function SoundBar:stopSound(index)
	local sound = self.soundList[index]
	if sound.eventInstance ~= nil and sound.eventInstance ~= 0 then
		getSoundManager():stopUISound(sound.eventInstance)
		sound.eventInstance = nil
	end
end

function SoundBar:new(x, y, width, height)
	local o = ISPanel.new(self, x, y, width, height)
	o.soundList = {}
	table.insert(o.soundList, { fraction = 0.16, enabled = true })
	table.insert(o.soundList, { fraction = 0.32, enabled = true })
	table.insert(o.soundList, { fraction = 0.5, enabled = true })
	table.insert(o.soundList, { fraction = 0.66, enabled = true })
	table.insert(o.soundList, { fraction = 0.83, enabled = true })
	o.prevFraction = 0
	return o
end

-----

AnimationClipViewer_SoundPanel = ISPanel:derive("AnimationClipViewer_SoundPanel")
local SoundPanel = AnimationClipViewer_SoundPanel

function SoundPanel:createChildren()
	self.comboHgt = LABEL_HGT
	local combo = self:createSoundCombo(1, 0)
	combo = self:createSoundCombo(2, combo:getBottom() + UI_BORDER_SPACING)
	combo = self:createSoundCombo(3, combo:getBottom() + UI_BORDER_SPACING)
	combo = self:createSoundCombo(4, combo:getBottom() + UI_BORDER_SPACING)
	self:shrinkWrap(0, 0, nil)
end

function SoundPanel:createSoundCombo(index, y)
	local tickBox = ISTickBox:new(0, y, BUTTON_HGT, BUTTON_HGT, "", self, self.onTickBox, index)
	self:addChild(tickBox)
	tickBox:addOption("", nil)
	tickBox:setSelected(1, true)
	tickBox:setWidthToFit()
	tickBox:setY(y)
	self.soundTickBoxes[index] = tickBox

	local combo = ISComboBox:new(tickBox:getRight(), y, self.width - tickBox.width, BUTTON_HGT, self, self.onSoundComboSelected)
	combo.noSelectionText = string.format("SOUND #%d", index)
	self:addChild(combo)
	combo:setEditable(true)
	combo.selected = 0
	combo.comboIndex = index
	self.soundCombos[index] = combo
	self:fillSoundCombo(combo)
	return combo
end

function SoundPanel:onTickBox(index, selected, soundIndex)
	local sound = self.parent.soundBar.soundList[soundIndex]
	sound.enabled = selected
end

function SoundPanel:fillSoundCombo(combo)
	combo:addOptionWithData("None", {})
	local categories = GameSounds.getCategories()
	for i=1,categories:size() do
		local category = categories:get(i-1)
		local sounds = GameSounds.getSoundsInCategory(category)
		for j=1,sounds:size() do
			combo:addOptionWithData(sounds:get(j-1):getName(), {})
		end
	end
	local option = combo.options[1] -- None
	table.remove(combo.options, 1)
	table.sort(combo.options, function(a,b) return not string.sort(a.text, b.text) end)
	table.insert(combo.options, 1, option)
end

function SoundPanel:onSoundComboSelected(combo)
	local sound = self.parent.soundBar.soundList[combo.comboIndex]
	if combo.selected == 1 then -- None
		self.parent.soundBar:stopSound(combo.comboIndex)
		sound.soundName = nil
		return
	end
	sound.soundName = combo:getOptionText(combo.selected)
end

function SoundPanel:new(x, y, width, height)
	local o = ISPanel.new(self, x, y, width, height)
	o:noBackground()
	o.soundTickBoxes = {}
	o.soundCombos = {}
	return o
end

-----

AnimationClipViewer_OptionsPanel = ISPanel:derive("AnimationClipViewer_OptionsPanel")
local OptionsPanel = AnimationClipViewer_OptionsPanel

function OptionsPanel:createChildren()
	local tickBox = ISTickBox:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, BUTTON_HGT, BUTTON_HGT, "", self, self.onTickBox)
	tickBox:initialise()
	self:addChild(tickBox)
	local gameState = getAnimationViewerState()
	for i=1,gameState:getOptionCount() do
		local option = gameState:getOptionByIndex(i-1)
		tickBox:addOption(option:getName(), option)
		tickBox:setSelected(i, option:getValue())
	end
	tickBox:setWidthToFit()
	self.tickBox = tickBox
	self:shrinkWrap(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, nil)
end

function OptionsPanel:onTickBox(index, selected)
	local option = self.tickBox.optionData[index]
	option:setValue(selected)
	if option:getName() == "DrawGrid" then
		self.parent.scene.javaObject:fromLua1("setDrawGrid", selected)
	end
	if option:getName() == "Isometric" then
		self.parent:resetView()
	end
	if option:getName() == "ShowBones" then
		self.parent.scene.javaObject:fromLua2("setCharacterShowBones", "animal1", selected)
		self.parent.scene.javaObject:fromLua2("setCharacterShowBones", "character1", selected)
	end
	if option:getName() == "UseDeferredMovement" then
		self.parent.scene.javaObject:fromLua2("setCharacterUseDeferredMovement", "animal1", selected)
		self.parent.scene.javaObject:fromLua2("setCharacterUseDeferredMovement", "character1", selected)
	end
end

function OptionsPanel:onMouseDownOutside(x, y)
	if self:isMouseOver() then return end
	self:setVisible(false)
--	self:removeFromUIManager()
end

function OptionsPanel:new(x, y, width, height)
	local o = ISPanel.new(self, x, y, width, height)
	o.backgroundColor.a = 0.8
	return o
end

-----

AnimationClipViewer_Scene = ISUI3DScene:derive("AnimationClipViewer_Scene")
local Scene = AnimationClipViewer_Scene

function Scene:prerenderEditor()
	self.javaObject:fromLua1("setGizmoVisible", "none")
	self.javaObject:fromLua1("setGizmoOrigin", "none")
	if not self.zeroVector then self.zeroVector = Vector3f.new() end
	self.javaObject:fromLua1("setGizmoPos", self.zeroVector)
	self.javaObject:fromLua1("setGizmoRotate", self.zeroVector)
	self.javaObject:fromLua0("clearAABBs")
	self.javaObject:fromLua0("clearAxes")
	self.javaObject:fromLua1("setSelectedAttachment", nil)
end

function Scene:prerender()
	ISUI3DScene.prerender(self)
end

function Scene:onMouseDown(x, y)
	ISUI3DScene.onMouseDown(self, x, y)
	local gameState = getAnimationViewerState()
	self.rotate = not isKeyDown(Keyboard.KEY_LSHIFT)
end

function Scene:onMouseMove(dx, dy)
	if self.rotate then
		local current = self.javaObject:fromLua0("getViewRotation")
		local rx = current:x() + 0
		local ry = current:y() + dx / 2
		local rz = current:z() + 0
		if getAnimationViewerState():getBoolean("Isometric") then
			rx = 30
			rz = 0
		end
		self.javaObject:fromLua3("setViewRotation", rx, ry, rz)
		return
	end
	ISUI3DScene.onMouseMove(self, dx, dy)
end

function Scene:onMouseUp(x, y)
	ISUI3DScene.onMouseUp(self, x, y)
	self.rotate = false
end

function Scene:onMouseUpOutside(x, y)
	self:onMouseUp()
end

function Scene:onRightMouseDown(x, y)
end

function Scene:new(x, y, width, height)
	local o = ISUI3DScene.new(self, x, y, width, height)
	return o
end

-----

AnimationClipViewer_Timeline = ISPanel:derive("AnimationClipViewer_Timeline")
local Timeline = AnimationClipViewer_Timeline

function Timeline:render()
	ISPanel.render(self)
	local scene = self.parent.parent.scene
	local time = scene.javaObject:fromLua1("getCharacterAnimationTime", self.parent.parent.currentObjectName)
	local duration = scene.javaObject:fromLua1("getCharacterAnimationDuration", self.parent.parent.currentObjectName)
	if not time or not duration then return end

	if self.parent.parent.listBox.selectedClipName ~= self.selectedClipName then
		self.selectedClipName = self.parent.parent.listBox.selectedClipName
		self.keyframeTimes = scene.javaObject:fromLua2("getCharacterAnimationKeyframeTimes", self.parent.parent.currentObjectName, self.keyframeTimes)
	end
	local times = self.keyframeTimes
	for i=1,times:size() do
		self:drawRect(self.width * times:get(i-1) / duration, 0, 1, self.height, 1.0, 0.5, 0.5, 0.5)
	end

	self:drawRect(self.width * time / duration, 0, 1, self.height, 1.0, 1.0, 1.0, 1.0)
end

function Timeline:onMouseDown(x, y)
	local scene = self.parent.parent.scene
	local duration = scene.javaObject:fromLua1("getCharacterAnimationDuration", self.parent.parent.currentObjectName)
	if not duration then return end
	local xFraction = x / self.width
	self.parent.parent.animate = false
	scene.javaObject:fromLua2("setCharacterAnimate", "animal1", false)
	scene.javaObject:fromLua2("setCharacterAnimate", "character1", false)
	scene.javaObject:fromLua2("setCharacterAnimationTime", self.parent.parent.currentObjectName, duration * xFraction)
	self.dragging = true
	self:setCapture(true)
end

function Timeline:onMouseMove(dx, dy)
	if not self.dragging then return end
	local scene = self.parent.parent.scene
	local duration = scene.javaObject:fromLua1("getCharacterAnimationDuration", self.parent.parent.currentObjectName)
	if not duration then return end
	local xFraction = self:getMouseX() / self.width
	xFraction = math.max(xFraction, 0.0)
	xFraction = math.min(xFraction, 1.0)
	scene.javaObject:fromLua2("setCharacterAnimationTime", self.parent.parent.currentObjectName, duration * xFraction)
end

function Timeline:onMouseMoveOutside(dx, dy)
	self:onMouseMove(dx, dy)
end

function Timeline:onMouseUp(x, y)
	self.dragging = false
	self:setCapture(false)
end

function Timeline:onMouseUpOutside(x, y)
	self.dragging = false
	self:setCapture(false)
end

function Timeline:new(x, y, width, height)
	local o = ISPanel.new(self, x, y, width, height)
	o.borderColor.a = 0.0
	return o
end

-----

function AnimationClipViewer:createChildren()
	local gameState = getAnimationViewerState()

	self.scene = Scene:new(0, 0, self.width, self.height)
	self.scene:initialise()
	self.scene:instantiate()
	self.scene:setAnchorRight(true)
	self.scene:setAnchorBottom(true)
	self:addChild(self.scene)

	self:resetView()

	if gameState:getBoolean("Isometric") then
		self.scene.javaObject:fromLua2("dragView", 0, self.height / 4)
	else
		self.scene.javaObject:fromLua2("dragView", 0, self.height / 3)
	end

	self.scene.javaObject:fromLua1("setMaxZoom", 20)
	self.scene.javaObject:fromLua1("setZoom", 7)
	self.scene.javaObject:fromLua1("setGizmoScale", 1.0 / 5.0)

	self.scene.javaObject:fromLua1("setDrawGrid", gameState:getBoolean("DrawGrid"))
	self.scene.javaObject:fromLua1("setDrawGridAxes", true)
	self.scene.javaObject:fromLua1("setGridPlane", "XZ")
	
	self.scene.javaObject:fromLua1("createCharacter", "character1")
	self.scene.javaObject:fromLua2("setCharacterAlpha", "character1", 1.0)
	self.scene.javaObject:fromLua2("setCharacterAnimate", "character1", self.animate)
	self.scene.javaObject:fromLua2("setCharacterAnimSet", "character1", "player-editor")
	self.scene.javaObject:fromLua2("setCharacterState", "character1", "runtime")
	self.scene.javaObject:fromLua2("setCharacterClearDepthBuffer", "character1", false)
	self.scene.javaObject:fromLua2("setCharacterShowBones", "character1", gameState:getBoolean("ShowBones"))
	self.scene.javaObject:fromLua2("setCharacterUseDeferredMovement", "character1", gameState:getBoolean("UseDeferredMovement"))
	self.scene.javaObject:fromLua2("setObjectVisible", "character1", true)

	local animalDefs = getAllAnimalsDefinitions()
	if animalDefs:isEmpty() == false then
		local animalDef = animalDefs:get(0)
		self.scene.javaObject:fromLua3("createAnimal", "animal1", animalDef, animalDef:getBreeds():get(0))
		self.scene.javaObject:fromLua2("setCharacterAlpha", "animal1", 1.0)
		self.scene.javaObject:fromLua2("setCharacterAnimate", "animal1", self.animate)
		self.scene.javaObject:fromLua2("setCharacterAnimSet", "animal1", "animal-editor")
		self.scene.javaObject:fromLua2("setCharacterState", "animal1", "runtime")
		self.scene.javaObject:fromLua2("setCharacterClearDepthBuffer", "animal1", false)
		self.scene.javaObject:fromLua2("setCharacterShowBones", "animal1", gameState:getBoolean("ShowBones"))
		self.scene.javaObject:fromLua2("setObjectVisible", "animal1", false)
	end

	self.currentObjectName = "character1"

	self:createToolbar()

	local timelineHeight = 50
	local soundBarHeight = 40
	local bottomH = soundBarHeight + timelineHeight + BUTTON_HGT + UI_BORDER_SPACING*3 + 1

	self:initAnimalModelScripts()

	self.comboAnimal = ISComboBox:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, 250+(getCore():getOptionFontSizeReal()*30), LABEL_HGT, self, self.onComboAnimalModel)
	self.comboAnimal.noSelectionText = getText("IGUI_AnimClipViewer_AnimalModel")
	self:addChild(self.comboAnimal)
	self.comboAnimal:setEditable(true)
	self:fillAnimalCombo()
	self.comboAnimal.selected = 0 -- ANIMAL MODEL

	self.filter = ISTextEntryBox:new("", UI_BORDER_SPACING+1, self.comboAnimal:getBottom() + UI_BORDER_SPACING, self.comboAnimal.width, LABEL_HGT)
	self.filter.font = UIFont.Medium
	self:addChild(self.filter)
	self.filter:setClearButton(true)

	local listY = self.filter:getBottom() + UI_BORDER_SPACING
	local listBox = ListBox:new(UI_BORDER_SPACING+1, listY, self.comboAnimal.width, self.height - bottomH - UI_BORDER_SPACING - listY)
	listBox:setAnchorBottom(true)
	self:addChild(listBox)
	listBox:setFont(UIFont.Small, 2)
	self.listBox = listBox

	self:setClipList()

	self.soundPanel = SoundPanel:new(self.width - UI_BORDER_SPACING - self.comboAnimal.width - 1, UI_BORDER_SPACING+1, self.comboAnimal.width, 100)
	self.soundPanel:setAnchorTop(true)
	self.soundPanel:setAnchorLeft(false)
	self.soundPanel:setAnchorRight(true)
	self.soundPanel:setAnchorBottom(false)
	self:addChild(self.soundPanel)

	self.bottomPanel = ISPanel:new(0, self.height - bottomH, self.width, bottomH)
	self.bottomPanel:setAnchorTop(false)
	self.bottomPanel:setAnchorLeft(true)
	self.bottomPanel:setAnchorRight(true)
	self.bottomPanel:setAnchorBottom(true)
	self.bottomPanel:noBackground()
	self:addChild(self.bottomPanel)

	local fullWidth = self.width - (UI_BORDER_SPACING+1)*2

	self.soundBar = SoundBar:new(UI_BORDER_SPACING+1, 0, fullWidth, soundBarHeight)
	self.soundBar:setAnchorTop(true)
	self.soundBar:setAnchorLeft(true)
	self.soundBar:setAnchorRight(true)
	self.soundBar:setAnchorBottom(false)
	self.bottomPanel:addChild(self.soundBar)

	local timeline = Timeline:new(UI_BORDER_SPACING+1, soundBarHeight + UI_BORDER_SPACING, fullWidth, timelineHeight)
	timeline:setAnchorTop(true)
	timeline:setAnchorLeft(true)
	timeline:setAnchorRight(true)
	timeline:setAnchorBottom(false)
	self.bottomPanel:addChild(timeline)
	self.timeline = timeline

	self.speedScale = ISSliderPanel:new(self.width - 310, self.bottomPanel.y - 30, 300, 20, self, self.onSpeedScaleChanged)
	self.speedScale.anchorLeft = false
	self.speedScale.anchorRight = true
	self.speedScale.anchorTop = false
	self.speedScale.anchorBottom = true
	self.speedScale:setValues(0.0, 5.0, 0.1, 1.0)
	self.speedScale:setCurrentValue(1.0, true)
	self:addChild(self.speedScale)

	local button2 = ISButton:new(UI_BORDER_SPACING+1, self.bottomPanel.height - BUTTON_HGT - UI_BORDER_SPACING - 1, 80, BUTTON_HGT, getText("IGUI_DebugMenu_Exit"), self, self.onExit)
	self.bottomPanel:addChild(button2)
	button2:enableCancelColor()
end

function AnimationClipViewer:createToolbar()
	local toolHgt = BUTTON_HGT
	self.toolBar = ISPanel:new(0, 10, 300, toolHgt)
	self.toolBar:noBackground()
	self:addChild(self.toolBar)

	local button = ISButton:new(0, 0, 60, toolHgt, getText("IGUI_DebugMenu_Options"), self, self.onOptions)
	self.toolBar:addChild(button)
	self.buttonOptions = button

	self.toolBar:setWidth(button:getRight())
	self.toolBar:setX(self.width / 2 - self.toolBar.width / 2)

	self.optionsPanel = OptionsPanel:new(0, 0, getTextManager():MeasureStringX(UIFont.Medium, "setCharacterUseDeferredMovement")+20, 400)
	self.optionsPanel:setVisible(false)
	self:addChild(self.optionsPanel)
end

function AnimationClipViewer:onSpeedScaleChanged(speed, slider)
end

function AnimationClipViewer:resetView()
	self.scene:setView("UserDefined")
	local gameState = getAnimationViewerState()
	if gameState:getBoolean("Isometric") then
		self.scene.javaObject:fromLua3("setViewRotation", 30.0, 45.0, 0.0)
		self.scene.javaObject:fromLua1("setGridPlane", "XZ")
	else
		self.scene.javaObject:fromLua3("setViewRotation", 0.0, 0.0, 0.0)
		self.scene.javaObject:fromLua1("setGridPlane", "XY")
	end
end

function AnimationClipViewer:setClipList()
	self.listBox:clear()
	local filterText = string.trim(self.filter:getInternalText())
	local modelScriptName = "MaleBody"
	if self:java1("isObjectVisible", "animal1") then
		local data = self.comboAnimal:getOptionData(self.comboAnimal.selected)
		modelScriptName = data.definition:getBodyModelStr()
	end
	local clips = getAnimationViewerState():fromLua1("getClipNames", modelScriptName)
	for i=1,clips:size() do
		local clipName = clips:get(i-1)
		if string.contains(string.lower(clipName), filterText) then
			self.listBox:addItem(clipName, clipName)
		end
	end
end

function AnimationClipViewer:initAnimalModelScripts()
	self.animalScriptByName = {}
	self.animalScriptByModelScript = {}
	local defs = getAllAnimalsDefinitions()
	for i=1,defs:size() do
		local def = defs:get(i-1)
		local modelScript = getScriptManager():getModelScript(def:getBodyModelStr())
		if modelScript then
			self.animalScriptByName[def:getBodyModelStr()] = modelScript
			self.animalScriptByModelScript[modelScript] = modelScript
		end
		local breeds = def:getBreeds()
		for j=1,breeds:size() do
			local breed = breeds:get(j-1)
		end
	end
end

function AnimationClipViewer:fillAnimalCombo()
	self.comboAnimal:clear()
	self.comboAnimal:addOption(getText("IGUI_None"))
	local defs = getAllAnimalsDefinitions()
	for i=1,defs:size() do
		local def = defs:get(i-1)
		if self.animalScriptByName[def:getBodyModelStr()] then
			local breeds = def:getBreeds()
			for j=1,breeds:size() do
				local breed = breeds:get(j-1)
				local data = { definition = def, breed = breed }
				self.comboAnimal:addOptionWithData(getText("IGUI_Animal_Group_" .. def:getGroup()) .. ' / ' .. getText("IGUI_AnimalType_" .. def:getAnimalType()) .. ' / ' .. getText("IGUI_Breed_" .. breed:getName()), data)
			end
		end
	end
	local option = self.comboAnimal.options[1] -- None
	table.remove(self.comboAnimal.options, 1)
	table.sort(self.comboAnimal.options, function(a,b) return not string.sort(a.text, b.text) end)
	table.insert(self.comboAnimal.options, 1, option)
end

function AnimationClipViewer:onComboAnimalModel()
	self:java2("setObjectVisible", "animal1", self.comboAnimal.selected > 1)
	self:java2("setObjectVisible", "character1", self.comboAnimal.selected == 1)
	if self.comboAnimal.selected == 1 then
		-- Hidden
		self.currentObjectName = "character1"
	else
		self.currentObjectName = "animal1"
		local data = self.comboAnimal:getOptionData(self.comboAnimal.selected)
		self:java3("setAnimalDefinition", "animal1", data.definition, data.breed)
		self.currentAnimalScript = self.animalScriptByName[data.definition:getBodyModelStr()]
	end
	self:setClipList()
	if self.comboAnimal.selected == 1 then
		self.comboAnimal.selected = 0 -- ANIMAL MODEL
	end
end

function AnimationClipViewer:onResolutionChange(oldw, oldh, neww, newh)
	self:setWidth(neww)
	self:setHeight(newh)
	self.toolBar:setX(self.width / 2 - self.toolBar.width / 2)
end

function AnimationClipViewer:update()
	ISPanel.update(self)
	if self.width ~= getCore():getScreenWidth() or self.height ~= getCore():getScreenHeight() then
		self:onResolutionChange(self.width, self.height, getCore():getScreenWidth(), getCore():getScreenHeight())
	end

	local filterText = string.trim(self.filter:getInternalText())
	if self.filterText ~= filterText then
		self.filterText = filterText
		self:setClipList()
	end

	local speed = self.speedScale:getCurrentValue()
	self.scene.javaObject:fromLua2("setCharacterAnimationSpeed", "animal1", speed)
	self.scene.javaObject:fromLua2("setCharacterAnimationSpeed", "character1", speed)
end

function AnimationClipViewer:prerender()
	ISPanel.prerender(self)
	self.scene:prerenderEditor()

	if getAnimationViewerState():getBoolean("DrawGrid") then
		self.scene.javaObject:fromLua6("addAxis", 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
	end
end

function AnimationClipViewer:render()
	ISPanel.render(self)
	local time = self:getCurrentTime()
	local duration = self:getDuration()
	
	local text = getText("IGUI_AnimClipViewer_Seconds", string.format("%.2f", time), string.format("%.2f", duration))
	self:drawText(text, (self.width-getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_AnimClipViewer_Seconds", 100.00, 100.00)))/4, self.height-FONT_HGT_MEDIUM-10, 1.0, 1.0, 1.0, 1.0, UIFont.Medium)

	local text = getText("IGUI_AnimClipViewer_Fraction", string.format("%.2f", time / duration))
	self:drawText(text, (self.width-getTextManager():MeasureStringX(UIFont.Medium, "FRACTION:   1.00f")) / 2, self.height-FONT_HGT_MEDIUM-10, 1.0, 1.0, 1.0, 1.0, UIFont.Medium)

	local frame = self:getCurrentFrame()
	local lastFrame = self:getLastFrame()
	local text = getText("IGUI_AnimClipViewer_Frame", math.min(frame, lastFrame), lastFrame)
	self:drawText(text, ((self.width-getTextManager():MeasureStringX(UIFont.Medium, "FRAME:   9999 / 9999"))/4)*3, self.height-FONT_HGT_MEDIUM-10, 1.0, 1.0, 1.0, 1.0, UIFont.Medium)

	local text = getText("IGUI_AnimClipViewer_SpeedScale", string.format("%.2f", self.speedScale:getCurrentValue()))
	self:drawText(text, self.speedScale.x, self.speedScale.y - 8 - FONT_HGT_MEDIUM, 1.0, 1.0, 1.0, 1.0, UIFont.Medium)
end

function AnimationClipViewer:onKeyPress(key)
	local fps = self:getFPS()
	if key == Keyboard.KEY_LEFT then
		local time = self:getCurrentTime()
		local frame = self:getCurrentFrame() - 1
		if time * fps - frame > 0.1 then frame = frame + 1 end
		self.scene.javaObject:fromLua2("setCharacterAnimationTime", self.currentObjectName, math.max(frame - 1, 0) / fps)
	end
	if key == Keyboard.KEY_RIGHT then
		local time = self:getCurrentTime()
		local frame = self:getCurrentFrame() - 1
		local lastFrame = self:getLastFrame()
		self.scene.javaObject:fromLua2("setCharacterAnimationTime", self.currentObjectName, math.min(frame + 1, lastFrame - 1) / fps)
	end
	if key == Keyboard.KEY_SPACE then
		self.animate = not self.animate
		self.scene.javaObject:fromLua2("setCharacterAnimate", "animal1", self.animate)
		self.scene.javaObject:fromLua2("setCharacterAnimate", "character1", self.animate)
	end
end

function AnimationClipViewer:getFPS()
	return 30
end

function AnimationClipViewer:getDuration()
	return self.scene.javaObject:fromLua1("getCharacterAnimationDuration", self.currentObjectName) or 1.0
end

function AnimationClipViewer:getCurrentTime()
	return self.scene.javaObject:fromLua1("getCharacterAnimationTime", self.currentObjectName) or 0.0
end

function AnimationClipViewer:getCurrentFrame()
	local fps = self:getFPS()
	local time = self:getCurrentTime()
	return math.floor(time * fps + 0.01) + 1
end

function AnimationClipViewer:getLastFrame()
	local fps = self:getFPS()
	local duration = self:getDuration()
	return luautils.round(duration * fps) + 1
end

function AnimationClipViewer:onOptions()
	self.optionsPanel:setX(self.buttonOptions:getAbsoluteX())
	self.optionsPanel:setY(self.buttonOptions:getAbsoluteY() + self.buttonOptions:getHeight())
	self.optionsPanel:setVisible(true)
end

function AnimationClipViewer:onExit(button, x, y)
	getAnimationViewerState():fromLua0("exit")
end

-- Called from Java
function AnimationClipViewer:showUI()
end

function AnimationClipViewer:java0(func)
	return self.scene.javaObject:fromLua0(func)
end

function AnimationClipViewer:java1(func, arg0)
	return self.scene.javaObject:fromLua1(func, arg0)
end

function AnimationClipViewer:java2(func, arg0, arg1)
	return self.scene.javaObject:fromLua2(func, arg0, arg1)
end

function AnimationClipViewer:java3(func, arg0, arg1, arg2)
	return self.scene.javaObject:fromLua3(func, arg0, arg1, arg2)
end

function AnimationClipViewer:java4(func, arg0, arg1, arg2, arg3)
	return self.scene.javaObject:fromLua4(func, arg0, arg1, arg2, arg3)
end

function AnimationClipViewer:java5(func, arg0, arg1, arg2, arg3, arg4)
	return self.scene.javaObject:fromLua5(func, arg0, arg1, arg2, arg3, arg4)
end

function AnimationClipViewer:java6(func, arg0, arg1, arg2, arg3, arg4, arg5)
	return self.scene.javaObject:fromLua6(func, arg0, arg1, arg2, arg3, arg4, arg5)
end

function AnimationClipViewer:java9(func, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
	return self.scene.javaObject:fromLua9(func, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
end

function AnimationClipViewer:new(x, y, width, height)
	local o = ISPanel.new(self, x, y, width, height)
	o:setAnchorRight(true)
	o:setAnchorBottom(true)
	o:noBackground()
	o:setWantKeyEvents(true)
	o.animate = true
	getAnimationViewerState():setTable(o)
	return o
end

-- Called from Java
function AnimationViewerState_InitUI()
	local UI = AnimationClipViewer:new(0, 0, getCore():getScreenWidth(), getCore():getScreenHeight())
	AnimationViewerState_UI = UI
	UI:setVisible(true)
	UI:addToUIManager()
end

