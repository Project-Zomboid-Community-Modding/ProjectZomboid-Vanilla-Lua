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

AttachmentEditorUI = ISPanel:derive("AttachmentEditorUI")

AttachmentEditorUI_Scene = ISUI3DScene:derive("AttachmentEditorUI_Scene")
AttachmentEditorUI_SwitchView = ISUI3DScene:derive("AttachmentEditorUI_SwitchView")
local Scene = AttachmentEditorUI_Scene
local SwitchView = AttachmentEditorUI_SwitchView

function SwitchView:prerender()
	if self:isMouseOver() or (self:getView() == self.editor.scene:getView()) then
		self.borderColor.r = 0.8
		self.borderColor.g = 0.8
		self.borderColor.b = 0.8
	else
		self.borderColor.r = 0.4
		self.borderColor.g = 0.4
		self.borderColor.b = 0.4
	end
	ISUI3DScene.prerender(self)
end

function SwitchView:onMouseDown(x, y)
	self.editor.prevView = self:getView()
	self.editor.scene:setView(self:getView())
end

function SwitchView:onMouseMove(dx, dy)
	if self.editor.mouseOverView ~= self then
		if self.editor.mouseOverView then
			self.editor.mouseOverView:onMouseMoveOutside(-1, -1)
		end
		self.editor.mouseOverView = self
		self.editor.prevView = self.editor.scene:getView()
		self.editor.scene:setView(self:getView())
	end
end

function SwitchView:onMouseMoveOutside(dx, dy)
	if self.editor.mouseOverView == self then
		self.editor.mouseOverView = nil
		self.editor.scene:setView(self.editor.prevView)
		self.editor.prevView = nil
	end
end

function SwitchView:onMouseWheel(del)
	return true
end

function SwitchView:new(editor, x, y, width, height)
	local o = ISUI3DScene.new(self, x, y, width, height)
	o.editor = editor
	return o
end

-----

AttachmentEditorUI_WorldAttachmentPanel = ISPanel:derive("AttachmentEditorUI_WorldAttachmentPanel")
local WorldAttachmentPanel = AttachmentEditorUI_WorldAttachmentPanel

function WorldAttachmentPanel:createChildren()
	local tickBoxHeight = FONT_HGT_SMALL + 2 * 2
	self.scene = ISUI3DScene:new(0, 0, self.width, self.height - tickBoxHeight)
	self:addChild(self.scene)
	self.scene:setView("UserDefined")
	self.scene.javaObject:fromLua1("setMaxZoom", 20)
	self.scene.javaObject:fromLua1("setZoom", 14)
	self.scene.javaObject:fromLua3("setViewRotation", 30.0, 45.0 + 90.0, 0.0)
	self.scene.javaObject:fromLua1("setDrawGrid", true)
	self.scene.javaObject:fromLua1("setDrawGridAxes", true)
	self.scene.javaObject:fromLua1("setDrawGridPlane", true)
	self.scene.javaObject:fromLua1("setGridPlane", "XZ")

	self.weaponRotationHack = true

	local tickBox = ISTickBox:new(self.scene.x, self.scene:getBottom() + 2, 100, tickBoxHeight, "", self, self.onTickBox)
	self:addChild(tickBox)
	tickBox:addOption("Apply HandWeapon Rotation Hack", {})
	tickBox:setSelected(1, self.weaponRotationHack)
	tickBox:setWidthToFit()

	self.scene.javaObject:fromLua2("createModel", "worldModel", "Base.FireAxe")
	self.scene.javaObject:fromLua2("setModelUseWorldAttachment", "worldModel", true)
	self.scene.javaObject:fromLua2("setModelWeaponRotationHack", "worldModel", self.weaponRotationHack)
end

function WorldAttachmentPanel:onTickBox(index, selected)
	self.weaponRotationHack = selected
	self.scene.javaObject:fromLua2("setModelWeaponRotationHack", "worldModel", selected)
	self.editor:onSetModelWeaponRotationHackChanged(selected)
end

function WorldAttachmentPanel:setModelScriptName(scriptName)
	self.scene.javaObject:fromLua1("removeModel", "worldModel")
	self.scene.javaObject:fromLua2("createModel", "worldModel", scriptName)
	self.scene.javaObject:fromLua2("setModelUseWorldAttachment", "worldModel", true)
	self.scene.javaObject:fromLua2("setModelWeaponRotationHack", "worldModel", self.weaponRotationHack)
end

function WorldAttachmentPanel:new(x, y, width, height, editor)
	local o = ISPanel.new(self, x, y, width, height)
	o:noBackground()
	o.editor = editor
	return o
end

-----

local function vectorComponentToString(n, scale)
	return tostring(round(n * scale, 3))
end

local function vectorToString(v, scale)
	return vectorComponentToString(v:x(), scale) .. " " .. vectorComponentToString(v:y(), scale) .. " " .. vectorComponentToString(v:z(), scale)
end

local function drawVector(ui, label, x, y, vx, vy, vz)
	ui:drawText(label, x, y, 1, 1, 1, 1, UIFont.Small)
	x = x + getTextManager():MeasureStringX(UIFont.Small, label)

	local dx = getTextManager():MeasureStringX(UIFont.Small, "X: -99.9999")
	local str = vectorComponentToString(vx, 1)
	ui:drawText("X: " .. str, x, y, 1, 0, 0, 1, UIFont.Small)
	x = x + dx + UI_BORDER_SPACING

	str = vectorComponentToString(vy, 1)
	ui:drawText("Y: " .. str, x, y, 0, 1, 0, 1, UIFont.Small)
	x = x + dx + UI_BORDER_SPACING

	str = vectorComponentToString(vz, 1)
	ui:drawText("Z: " .. str, x, y, 0, 0.5, 1, 1, UIFont.Small)
end

local function alignVectorToGrid(v, gridMult)
	local vx = math.floor(v:x() * gridMult + 0.5) / gridMult
	local vy = math.floor(v:y() * gridMult + 0.5) / gridMult
	local vz = math.floor(v:z() * gridMult + 0.5) / gridMult
	v:setComponent(0, vx)
	v:setComponent(1, vy)
	v:setComponent(2, vz)
	return v
end

-----

AttachmentEditorUI_ListBox = ISScrollingListBox:derive("AttachmentEditorUI_ListBox")
local ListBox = AttachmentEditorUI_ListBox

function ListBox:prerender()
	ISScrollingListBox.prerender(self)
	if self:isMouseOver() and isKeyPressed(Keyboard.KEY_A) then
		if self:getSelectedCount() == #self.items then
			self:clearSelection()
		elseif self.selectionMode == "multi" then
			for _,item in ipairs(self.items) do
				item.selected = true
			end
		end
	end
end

function ListBox:onMouseDown(x, y)
	if #self.items == 0 then return end
	local row = self:rowAt(x, y)
	if row == -1 then
		self:clearSelection()
		return
	end
	if self.selectionMode == "single" then
		if not self.items[row].selected then
			self:clearSelection()
		end
	elseif not isShiftKeyDown() then
		self:clearSelection()
	end
	self.items[row].selected = not self.items[row].selected
end

function ListBox:clearSelection()
	for _,item in ipairs(self.items) do
		item.selected = false
	end
end

function ListBox:setSelectedRow(row)
	self:clearSelection()
	if self.items[row] then self.items[row].selected = true end
end

function ListBox:setSelectedRows(rows)
	self:clearSelection()
	for _,row in ipairs(rows) do
		local item = self.items[row]
		if item then item.selected = true end
	end
end

function ListBox:getSelectedItems()
	local selected = {}
	for _,item in ipairs(self.items) do
		if item.selected then
			table.insert(selected, item)
		end
	end
	return selected
end

function ListBox:getSelectedCount()
	local selected = 0
	for _,item in ipairs(self.items) do
		if item.selected then
			selected = selected + 1
		end
	end
	return selected
end

function ListBox:iteratorSelected()
	return ipairs(self:getSelectedItems())
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
	o.selectionMode = "multi"
	return o
end

-----

AttachmentEditorUI_EditPanel = ISPanel:derive("AttachmentEditorUI_EditPanel")
local EditPanel = AttachmentEditorUI_EditPanel

function EditPanel:updateEditor()
end

function EditPanel:prerenderEditor()
end

function EditPanel:toUI()
end

function EditPanel:onSceneMouseDown(x, y)
end

function EditPanel:onGizmoStart()
end

function EditPanel:onGizmoChanged(delta)
end

function EditPanel:onGizmoAccept()
end

function EditPanel:onGizmoCancel()
end

function EditPanel:createList(x, y, w, h)
	local list = ListBox:new(x or 0, y or 0, w or self.width, h or self.height)
	self:addChild(list)
	return list
end

function EditPanel:java0(func)
	return self.parent.scene.javaObject:fromLua0(func)
end

function EditPanel:java1(func, arg0)
	return self.parent.scene.javaObject:fromLua1(func, arg0)
end

function EditPanel:java2(func, arg0, arg1)
	return self.parent.scene.javaObject:fromLua2(func, arg0, arg1)
end

function EditPanel:java3(func, arg0, arg1, arg2)
	return self.parent.scene.javaObject:fromLua3(func, arg0, arg1, arg2)
end

function EditPanel:java4(func, arg0, arg1, arg2, arg3)
	return self.parent.scene.javaObject:fromLua4(func, arg0, arg1, arg2, arg3)
end

function EditPanel:java5(func, arg0, arg1, arg2, arg3, arg4)
	return self.parent.scene.javaObject:fromLua5(func, arg0, arg1, arg2, arg3, arg4)
end

function EditPanel:java6(func, arg0, arg1, arg2, arg3, arg4, arg5)
	return self.parent.scene.javaObject:fromLua6(func, arg0, arg1, arg2, arg3, arg4, arg5)
end

function EditPanel:java9(func, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
	return self.parent.scene.javaObject:fromLua9(func, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
end

function EditPanel:new(x, y, width, height)
	local o = ISPanel.new(self, x, y, width, height)
	return o
end

-----

AttachmentEditorUI_EditAttachment = EditPanel:derive("AttachmentEditorUI_EditAttachment")
local EditAttachment = AttachmentEditorUI_EditAttachment

function EditAttachment:createChildren()
	local buttonHgt = FONT_HGT_MEDIUM

	local comboHeight = FONT_HGT_MEDIUM
	local combo = ISComboBox:new(0, 0, self.width, LABEL_HGT, self, self.onComboAddModel)
	combo.noSelectionText = getText("IGUI_AttachmentEditor_AddModel")
	combo:setEditable(true)
	self:addChild(combo)
	self.comboAddModel = combo

	local scripts = getScriptManager():getAllModelScripts()
	local sorted = {}
	for i=1,scripts:size() do
		local script = scripts:get(i-1)
		table.insert(sorted, script:getFullType())
		if script:getFullType() == "Base.FemaleBody" then
			self.femaleBodyScript = script
		end
		if script:getFullType() == "Base.MaleBody" then
			self.maleBodyScript = script
		end
	end
	table.sort(sorted)
	for _,scriptName in ipairs(sorted) do
		combo:addOption(scriptName)
	end
	combo.selected = 0 -- ADD MODEL

	local itemHeight = BUTTON_HGT
	self.list = self:createList(0, combo:getBottom() + UI_BORDER_SPACING, self.width, itemHeight * 6)
	self.list.itemheight = itemHeight
	self.list.doDrawItem = function(self, y, item, alt) return self.parent.doDrawItem(self, y, item, alt) end
	self.list.onRightMouseDown = function(self, x, y) return self.parent.onRightMouseDownList1(self.parent, x, y) end
	self.list.selectionMode = "single"

	local button0 = ISButton:new(0, self.list:getBottom() + UI_BORDER_SPACING, self.width, LABEL_HGT, getText("IGUI_AttachmentEditor_RemoveFromScene"), self, self.onRemoveModel)
	button0:setEnable(false)
	self:addChild(button0)
	self.buttonRemoveModel = button0

	self.comboPlayer = ISComboBox:new(0, button0:getBottom() + UI_BORDER_SPACING, self.width, LABEL_HGT, self, self.onComboPlayerModel)
	self.comboPlayer.noSelectionText = getText("IGUI_AttachmentEditor_PlayerModel")
	self:addChild(self.comboPlayer)
	self.comboPlayer:addOption(getText("IGUI_None"))
	self.comboPlayer:addOption(getText("IGUI_char_Female"))
	self.comboPlayer:addOption(getText("IGUI_char_Male"))
	self.comboPlayer.selected = 0 -- PLAYER MODEL

	self.comboPlayerAnimation = ISComboBox:new(0, self.comboPlayer:getBottom() + UI_BORDER_SPACING, self.width, LABEL_HGT, self, self.onComboPlayerAnimation)
	self.comboPlayerAnimation.noSelectionText = getText("IGUI_AttachmentEditor_PlayerAnim")
	self.comboPlayerAnimation:setEditable(true)
	self:addChild(self.comboPlayerAnimation)
	self:setPlayerAnimationCombo()

	self:initAnimalModelScripts()

	self.comboAnimal = ISComboBox:new(0, self.comboPlayerAnimation:getBottom() + UI_BORDER_SPACING, self.width, LABEL_HGT, self, self.onComboAnimalModel)
	self.comboAnimal.noSelectionText = getText("IGUI_AnimClipViewer_AnimalModel")
	self.comboAnimal:setEditable(true)
	self:addChild(self.comboAnimal)
	self:fillAnimalCombo()
	self.comboAnimal.selected = 0 -- ANIMAL MODEL

	self.comboVehicle = ISComboBox:new(0, self.comboAnimal:getBottom() + UI_BORDER_SPACING, self.width, LABEL_HGT, self, self.onComboVehicleModel)
	self.comboVehicle.noSelectionText = getText("IGUI_AttachmentEditor_VehicleModel")
	self.comboVehicle:setEditable(true)
	self:addChild(self.comboVehicle)
	self:fillVehicleCombo()
	self.comboVehicle.selected = 0 -- VEHICLE MODEL

	self.list2 = self:createList(0, self.comboVehicle:getBottom() + UI_BORDER_SPACING, self.width, itemHeight * 6)
	self.list2.doDrawItem = self.doDrawItem2
	self.list2.itemheight = itemHeight
	self.list2.selectionMode = "single"

	self.belowList = ISPanel:new(0, self.list2:getBottom() + UI_BORDER_SPACING, self.width, 100)
	self.belowList:noBackground()
	self:addChild(self.belowList);

	self.nameEntry = ISTextEntryBox:new("", 0, UI_BORDER_SPACING, self.width, LABEL_HGT)
	self.nameEntry.font = UIFont.Medium
	self.nameEntry.onCommandEntered = function(self) self.parent.parent:onNameEntered() end
	self.belowList:addChild(self.nameEntry)

	local button1 = ISButton:new(0, self.nameEntry:getBottom() + UI_BORDER_SPACING, (self.width - 10) / 2, LABEL_HGT, getText("IGUI_AttachmentEditor_New"), self, self.onNewAttachment)
	self.belowList:addChild(button1)
	button1:setEnable(false)
	self.buttonNewAttachment = button1

	local button2 = ISButton:new(button1:getRight() + 10, button1:getY(), button1.width, LABEL_HGT, getText("IGUI_AttachmentEditor_Delete"), self, self.onDeleteAttachment)
	button2:setEnable(false)
	self.belowList:addChild(button2)
	self.buttonDeleteAttachment = button2

	self.gizmo = "translate"
	local button3 = ISButton:new(0, button2:getBottom() + UI_BORDER_SPACING, self.width, LABEL_HGT, getText("IGUI_AttachmentEditor_Translate"), self, self.onToggleGizmo)
	self.belowList:addChild(button3)
	self.button3 = button3

	self.transformMode = "Global"
	local button4 = ISButton:new(0, button3:getBottom() + UI_BORDER_SPACING, self.width, LABEL_HGT, getText("IGUI_AttachmentEditor_Global"), self, self.onToggleGlobalLocal)
	self.belowList:addChild(button4)
	self.button4 = button4

	self.belowList:setHeight(self.button4:getBottom())
	self:setHeight(self.belowList:getBottom())
end

function EditAttachment:doLayout()
	local top = self.list2:getY()
	local labelTop = self.parent:getHeight() - self.parent.bottomPanel:getHeight() - 30
	local bottom = labelTop - 20 - self.belowList.height
	self.list2:setHeight(bottom - top)
	self.belowList:setY(self.list2:getBottom())
	self:setHeight(self.belowList:getBottom())
end

function EditAttachment:onComboAddModel()
	local scriptName = self.comboAddModel:getOptionText(self.comboAddModel.selected)
	for _,item in ipairs(self.list.items) do
		local modelScript = item.item
		if self:isVehicleScript(modelScript) then
			--
		elseif modelScript:getFullType() == scriptName then
			return
		end
	end
	self.comboAddModel.selected = 0 -- ADD MODEL
	self:java2("createModel", scriptName, scriptName)
	self:toUI()
end

function EditAttachment:fillAnimalCombo()
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

function EditAttachment:fillVehicleCombo()
	self.comboVehicle:clear()
	self.comboVehicle:addOption(getText("IGUI_None"))
	local scripts = getScriptManager():getAllVehicleScripts()
	local sorted = {}
	for i=1,scripts:size() do
		local script = scripts:get(i-1)
		table.insert(sorted, script:getFullName())
	end
	table.sort(sorted)
	local scriptNameScene = self.editor.scene.javaObject:fromLua1("getVehicleScript", "vehicle"):getFullName()
	for _,scriptName in ipairs(sorted) do
		self.comboVehicle:addOption(scriptName)
		if scriptName == scriptNameScene then
			self.comboVehicle.selected = #self.comboVehicle.options
		end
	end
end

function EditAttachment:initAnimalModelScripts()
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

function EditAttachment:onSceneMouseDown(x, y)
	local boneName = self:pickCharacterBone()
	if boneName == "" then
		boneName = self:pickModelBone()
	end
	if boneName == "" then
		self.selectedBone = nil
	else
		self.selectedBone = boneName
	end
end

function EditAttachment:onRemoveModel(button, x, y)
	for _,item in self.list:iteratorSelected() do
		local modelScript = item.item
		if not self:isCharacterScript(modelScript) and not self:isVehicleScript() then
			if modelScript == self.selectedModelScript then
				self.selectedModelScript = nil
			end
			self:java1("removeModel", modelScript:getFullType())
		end
	end
	self:toUI()
end

function EditAttachment:setPlayerAnimationCombo()
	self.comboPlayerAnimation:clear()
	local clips = getAttachmentEditorState():fromLua0("getClipNames")
	for i=1,clips:size() do
		local clipName = clips:get(i-1)
		self.comboPlayerAnimation:addOption(clipName)
		if clipName == "Bob_Idle" then
			self.comboPlayerAnimation.selected = i
		end
	end
end

function EditAttachment:onComboPlayerModel()
	self:java2("setObjectVisible", "character1", self.comboPlayer.selected > 1)
	self:java2("setCharacterFemale", "character1", self.comboPlayer.selected == 2)
	self:java2("setCharacterState", "character1", "runtime")
	local animation = self.comboPlayerAnimation:getOptionText(self.comboPlayerAnimation.selected)
	self:java2("setCharacterAnimationClip", "character1", animation)
	self.comboPlayer.selected = 0 -- PLAYER MODEL
	self:toUI()
end

function EditAttachment:onComboPlayerAnimation()
	local animation = self.comboPlayerAnimation:getOptionText(self.comboPlayerAnimation.selected)
	self:java2("setCharacterAnimationClip", "character1", animation)
end

function EditAttachment:onComboAnimalModel()
	self:java2("setObjectVisible", "animal1", self.comboAnimal.selected > 1)
	if self.comboAnimal.selected == 1 then
		-- Hidden
	else
		local data = self.comboAnimal:getOptionData(self.comboAnimal.selected)
		self:java3("setAnimalDefinition", "animal1", data.definition, data.breed)
		self.currentAnimalScript = self.animalScriptByName[data.definition:getBodyModelStr()]
	end
	self.comboAnimal.selected = 0 -- ANIMAL MODEL
	self:toUI()
end

function EditAttachment:onComboVehicleModel()
	self:java2("setObjectVisible", "vehicle", self.comboVehicle.selected > 1)
	if self.comboVehicle.selected > 1 then
		local scriptName = self.comboVehicle:getOptionText(self.comboVehicle.selected)
		self:java2("setVehicleScript", "vehicle", scriptName)
	end
	self.comboVehicle.selected = 0 -- VEHICLE MODEL
	self:populateObjectList()
end

function EditAttachment:onNameEntered()
	local attach = self:getSelectedAttachments()[1]
	if not attach then return end
	local text = self.nameEntry:getInternalText():trim()
	if text == "" then
		self.nameEntry:setText(attach:getId())
		return
	end
	local attach2 = self.selectedModelScript:getAttachmentById(text)
	if attach2 then
		self.nameEntry:setText(attach:getId())
		return
	end
	attach:setId(text)
	self.parent.worldAttachmentPanel:setVisible(attach:getId() == "world")
end

function EditAttachment:getUniqueAttachmentId(modelScript)
	for i=1,100 do
		local id = "attachment"..tostring(i)
		if not modelScript:getAttachmentById(id) then
			return id
		end
	end
	error "too many attachments"
end

function EditAttachment:isPlayerScript(modelScript)
	if modelScript == nil then
		return false
	end
	return (modelScript == self.femaleBodyScript) or (modelScript == self.maleBodyScript)
end

function EditAttachment:isAnimalScript(modelScript)
	if modelScript == nil then
		return false
	end
	return self.animalScriptByModelScript[modelScript] ~= nil
end

function EditAttachment:isCharacterScript(modelScript)
	if modelScript == nil then
		return false
	end
	return self:isPlayerScript(modelScript) or self:isAnimalScript(modelScript)
end

function EditAttachment:isVehicleScript(modelScript)
	if modelScript == nil then
		return false
	end
	return instanceof(modelScript, "VehicleScript")
--	return modelScript == self:java1("getVehicleScript", "vehicle")
end

function EditAttachment:getSceneObjectId(modelScript)
	if not modelScript then return nil end
	if self:isPlayerScript(modelScript) then return "character1" end
	if self:isAnimalScript(modelScript) then return "animal1" end
	if self:isVehicleScript(modelScript) then return "vehicle" end
	return modelScript:getFullType()
end

function EditAttachment:onNewAttachment(button, x, y)
	local modelScript = self.selectedModelScript
	local id = self:getUniqueAttachmentId(modelScript)
	local attach = nil
	if self:isCharacterScript(modelScript) then
		if not modelScript:getAttachmentById(self.selectedBone) then
			id = self.selectedBone
		end
		attach = modelScript:addAttachment(ModelAttachment.new(id))
		attach:setBone(self.selectedBone)
	elseif self:isVehicleScript(modelScript) then
		-- Use the vehicle editor to edit vehicle attachments.
	else
		attach = self:java2("addAttachment", modelScript:getFullType(), id)
	end
	self.selectedModelScript = nil
	self:setSelectedModel(modelScript)
	self.list2:clearSelection()
	local index = self.list2:indexOf(id)
	self.list2.items[index].selected = true
	self.list2:ensureVisible(index)
end

function EditAttachment:onDeleteAttachment(button, x, y)
	for _,item in self.list:iteratorSelected() do
		local modelScript = item.item
		for _,item2 in self.list2:iteratorSelected() do
			if self:isCharacterScript(modelScript) then
				modelScript:removeAttachment(item2.item)
			elseif self:isVehicleScript(modelScript) then
				-- Use the vehicle editor to edit vehicle attachments.
			else
				self:java2("removeAttachment", modelScript:getFullType(), item2.item:getId())
			end
		end
	end
	self.selectedModelScript = nil
end

function EditAttachment:onToggleGizmo()
	if self.gizmo == "translate" then
		self.gizmo = "rotate"
		self.button3.title = getText("IGUI_AttachmentEditor_Rotate")
	elseif self.gizmo == "rotate" then
		self.gizmo = "scale"
		self.button3.title = getText("IGUI_AttachmentEditor_Scale")
	else
		self.gizmo = "translate"
		self.button3.title = getText("IGUI_AttachmentEditor_Translate")
	end
end

function EditAttachment:onToggleGlobalLocal()
	if self.transformMode == "Global" then
		self.transformMode = "Local"
		self.button4.title = getText("IGUI_AttachmentEditor_Local")
	else
		self.transformMode = "Global"
		self.button4.title = getText("IGUI_AttachmentEditor_Global")
	end
end

function EditAttachment:doDrawItem(y, item, alt)
	local modelScript = item.item
	
	local x = 4
	local indent = 16

	local isMouseOver = self.mouseoverselected == item.index and not self:isMouseOverScrollBar()
	if item.selected then
		self:drawRect(0, y, self:getWidth(), item.height-1, 0.3, 0.7, 0.35, 0.15)
	elseif isMouseOver then
		self:drawRect(1, y + 1, self:getWidth() - 2, item.height - 2, 0.25, 1.0, 1.0, 1.0)
	end

	self:drawText(modelScript:getName(), x, y, 1, 1, 1, 1, UIFont.Small)
	y = y + FONT_HGT_SMALL

	self:drawRect(x, y, self.width - 4 * 2, 2, 1.0, 0.5, 0.5, 0.5)
	y = y + 2
	return y
end

function EditAttachment:doDrawItem2(y, item, alt)
	local attach = item.item
	
	local x = 4
	local indent = 16

	local isMouseOver = self.mouseoverselected == item.index and not self:isMouseOverScrollBar()
	if item.selected then
		self:drawRect(0, y, self:getWidth(), item.height-1, 0.3, 0.7, 0.35, 0.15)
	elseif isMouseOver then
		self:drawRect(1, y + 1, self:getWidth() - 2, item.height - 2, 0.25, 1.0, 1.0, 1.0)
	end

	local id = attach:getId()
	if attach:getBone() then
		id = id .. " (" .. attach:getBone() .. ")"
	end
	self:drawText(id, x, y, 1, 1, 1, 1, UIFont.Small)
	y = y + FONT_HGT_SMALL

	local offset = attach:getOffset()
	drawVector(self, getText("IGUI_AttachmentEditor_Offset")..":   ", x + indent, y, offset:x(), offset:y(), offset:z())
	y = y + FONT_HGT_SMALL

	local rotate = attach:getRotate()
	drawVector(self, getText("IGUI_AttachmentEditor_Rotate")..":   ", x + indent, y, rotate:x(), rotate:y(), rotate:z())
	y = y + FONT_HGT_SMALL

	local scale = attach:getScale()
	drawVector(self, getText("IGUI_AttachmentEditor_Scale")..":   ", x + indent, y, scale, scale, scale)
	y = y + FONT_HGT_SMALL

	self:drawRect(x, y, self.width - 4 * 2, 2, 1.0, 0.5, 0.5, 0.5)
	y = y + 2
	return y
end

function EditAttachment:onRightMouseDownList1(x, y)
	local row = self.list:rowAt(x, y)
	local item = self.list.items[row]
	if not item then return end
	local child = item.item
	local childName = self:getSceneObjectId(child)
	
	local player = 0
	local context = ISContextMenu.get(player, self.list:getAbsoluteX() + x, self.list:getAbsoluteY() + y)
	context:removeFromUIManager()
	context:addToUIManager()
	local parentMenu = context:getNew(context)
	parentMenu:addOption(getText("IGUI_None"), self, self.onSetObjectParent, childName, nil, nil, nil)
	for _,item in ipairs(self.list.items) do
		local parent = item.item
		if parent ~= child then
			local parentName = self:getSceneObjectId(parent)
			if parent:getAttachmentCount() > 0 then
				local attachmentMenu = context:getNew(parentMenu)
				attachmentMenu:addOption("<no attachment>", self, self.onSetObjectParent, childName, nil, parentName, nil)
				local attachments = {}
				for i=1,parent:getAttachmentCount() do
					local attach = parent:getAttachment(i-1)
					table.insert(attachments, attach)
				end
				table.sort(attachments, function(a,b) return not string.sort(a:getId(), b:getId()) end)
				for _,attach in ipairs(attachments) do
					attachmentMenu:addOption(attach:getId(), self, self.onSetObjectParent, childName, attach:getId(), parentName, attach:getId())
				end
				parentMenu:addSubMenu(parentMenu:addOption(parent:getFullType()), attachmentMenu)
				if self:isVehicleScript(parent) then
					self:addVehiclePartParentMenus(context, parent, child, attachmentMenu)
				end
			else
				parentMenu:addOption(parent:getFullType(), self, self.onSetObjectParent, childName, nil, parentName, nil)
			end
		end
	end
	context:addSubMenu(context:addOption("Set Parent"), parentMenu)
	if self:isCharacterScript(child) then
		local optionAnimate = context:addOption("Animate", self, self.onSetCharacterAnimate, childName)
		context:setOptionChecked(optionAnimate, self:java1("getCharacterAnimate", childName))
		local optionBones = context:addOption("Show Bones", self, self.onSetCharacterShowBones, childName)
		context:setOptionChecked(optionBones, self:java1("getCharacterShowBones", childName))
	elseif self:isVehicleScript(child) then
		--
	else
		local optionIgnoreVehicleScale = context:addOption("Ignore Vehicle Scale", self, self.onSetModelIgnoreVehicleScale, childName)
		context:setOptionChecked(optionIgnoreVehicleScale, self:java1("getModelIgnoreVehicleScale", childName))
	end
	local optionRotate = context:addOption("Auto-Rotate Y", self, self.onSetObjectAutoRotate, childName)
	context:setOptionChecked(optionRotate, self:java1("getObjectAutoRotate", childName))
	local optionVisible = context:addOption("Visible", self, self.onSetObjectVisible, childName)
	context:setOptionChecked(optionVisible, self:java1("isObjectVisible", childName))
end

function EditAttachment:addVehiclePartParentMenus(context, vehicleScript, child, parentMenu)
	for i=1,vehicleScript:getPartCount() do
		local scriptPart = vehicleScript:getPart(i-1)
		for j=1,scriptPart:getModelCount() do	
			local scriptModel = scriptPart:getModel(j-1)
			if scriptModel:getFile() then
				local modelScript = getScriptManager():getModelScript(scriptModel:getFile())
				if modelScript and (modelScript:getAttachmentCount() > 0) then
					local attachmentMenu = context:getNew(parentMenu)
					attachmentMenu:addOption("<no attachment>", self, self.onSetObjectParentToVehiclePart, child:getFullType(), scriptPart:getId(), scriptModel:getId(), nil)
					local attachments = {}
					for i=1,modelScript:getAttachmentCount() do
						local attach = modelScript:getAttachment(i-1)
						table.insert(attachments, attach)
					end
					table.sort(attachments, function(a,b) return not string.sort(a:getId(), b:getId()) end)
					for _,attach in ipairs(attachments) do
						attachmentMenu:addOption(attach:getId(), self, self.onSetObjectParentToVehiclePart, child:getFullType(), scriptPart:getId(), scriptModel:getId(), attach:getId())
					end
					parentMenu:addSubMenu(parentMenu:addOption(scriptPart:getId().."|"..scriptModel:getId()), attachmentMenu)
				end
			end
		end
	end
end

function EditAttachment:onSetObjectParent(child, childAttachment, parent, parentAttachment)
	self:java4("setObjectParent", child, childAttachment, parent, parentAttachment)
end

function EditAttachment:onSetObjectParentToVehiclePart(child, scriptPart, scriptModel, attachment)
	self:java5("setObjectParentToVehiclePart", "vehicle", child, scriptPart, scriptModel, attachment)
end

function EditAttachment:onSetCharacterAnimate(child)
	self:java2("setCharacterAnimate", child, not self:java1("getCharacterAnimate", child))
end

function EditAttachment:onSetCharacterShowBones(child)
	self:java2("setCharacterShowBones", child, not self:java1("getCharacterShowBones", child))
end

function EditAttachment:onSetModelIgnoreVehicleScale(child)
	self:java2("setModelIgnoreVehicleScale", child, not self:java1("getModelIgnoreVehicleScale", child))
end

function EditAttachment:onSetObjectAutoRotate(child)
	self:java2("setObjectAutoRotate", child, not self:java1("getObjectAutoRotate", child))
end

function EditAttachment:onSetObjectVisible(child)
	self:java2("setObjectVisible", child, not self:java1("isObjectVisible", child))
end

function EditAttachment:prerenderEditor()
	self.list2.doDrawItem = self.doDrawItem2
	
	self:pickCharacterBone()
	self:pickModelBone()

	local mouseOver = self.list.items[self.list.mouseoverselected]
	local item = mouseOver or self.list:getSelectedItems()[1]
	if not item then
		self:setSelectedModel(nil)
		self:setSelectedAttachment(nil)
		self.buttonNewAttachment:setEnable(false)
		return
	end

	if mouseOver then
		self.parent.wroteScriptLabel:setName("Right-click for options")
		self.parent.wroteScriptTime = getTimestampMs() - 4950
	end

	local modelScript = item.item
	self:setSelectedModel(modelScript)

	local showGizmo = false

	if self:isCharacterScript(modelScript) then
		local objectName = self:getSceneObjectId(modelScript)
		if self.selectedBone then
			self:java3("setGizmoOrigin", "bone", objectName, self.selectedBone)
			self:java2("addBoneAxis", objectName, self.selectedBone)
			-- can't transform a bone
		else
			local bone = self:pickCharacterBone()
			if bone ~= "" then self:java2("setHighlightBone", objectName, bone) end
			self:java2("setGizmoOrigin", "character", objectName)
			-- Don't transform objects that are parented to others.
			if not self:java1("getObjectParent", objectName) then
				showGizmo = true
			end
		end
	elseif self:isVehicleScript(modelScript) then
		self:java2("setGizmoOrigin", "centerOfMass", "vehicle")
		if not self:java1("getObjectParent", "vehicle") then
			showGizmo = true
		end
	else
		local objectName = self:getSceneObjectId(modelScript)
		if self.selectedBone then
			self:java2("setHighlightBone", objectName, self.selectedBone)
			self:java3("setGizmoOrigin", "bone", objectName, self.selectedBone)
			self:java2("addBoneAxis", objectName, self.selectedBone)
			-- can't transform a bone
		else
			local bone = self:pickModelBone()
			if bone ~= "" then self:java2("setHighlightBone", objectName, bone) end
			self:java2("setGizmoOrigin", "model", objectName)
			-- Don't transform objects that are parented to others.
			if not self:java1("getObjectParent", objectName) and not self:java1("getObjectParentVehiclePart", objectName) then
				showGizmo = true
			end
		end
	end

	local mouseOver2 = self.list2.items[self.list2.mouseoverselected]
	local attach = mouseOver2 and mouseOver2.item or self:getSelectedAttachments()[1]
	self:setSelectedAttachment(attach)

	if attach ~= nil and attach:getId() ~= "world" then
		self:java1("setGizmoPos", attach:getOffset())
		self:java1("setGizmoRotate", attach:getRotate())
		local objectName = self:getSceneObjectId(modelScript)
		if self:isCharacterScript(modelScript) then
			self:java3("setGizmoOrigin", "bone", objectName, attach:getBone())
		elseif self:java1("getObjectParentVehiclePart", objectName) then
			local parentVehicle = self:java1("getObjectParentVehicle", objectName)
			local parentVehiclePart = self:java1("getObjectParentVehiclePart", objectName)
			local parentVehiclePartModel = self:java1("getObjectParentVehiclePartModel", objectName)
			local parentVehiclePartModelAttachment = self:java1("getObjectParentVehiclePartModelAttachment", objectName)
			self:java6("setGizmoOrigin", "vehiclePart", "vehicle", parentVehiclePart, parentVehiclePartModel, parentVehiclePartModelAttachment, false)
		else
			local parentAttachName = self:java1("getObjectParentAttachment", objectName)
			if parentAttachName then
				local parentName = self:java1("getObjectParent", objectName)
				self:java4("setGizmoOrigin", "attachment", objectName, parentName, parentAttachName)
			end
		end
		self:java1("setSelectedAttachment", attach:getId())
		self:java6("addAxis", attach:getOffset():x(), attach:getOffset():y(), attach:getOffset():z(),
			attach:getRotate():x(), attach:getRotate():y(), attach:getRotate():z())
		showGizmo = true
	end

	-- Transform the selected object when no attachment is selected.
	if showGizmo then
		self:java1("setGizmoVisible", self.gizmo)
		self:java1("setTransformMode", self.transformMode)
	end

	if self:isCharacterScript(self.selectedModelScript) then
		self.buttonNewAttachment:setEnable(self.selectedBone ~= nil)
	elseif self:isVehicleScript(self.selectedModelScript) then
		self.buttonNewAttachment:setEnable(false)
	else -- TODO: SceneModel has bones?
		self.buttonNewAttachment:setEnable(true)
	end
end

function EditAttachment:setSelectedModel(modelScript)
	if self.selectedModelScript == modelScript then
		return
	end
	self.selectedModelScript = modelScript
	self.buttonRemoveModel:setEnable(modelScript ~= nil and not self:isCharacterScript(modelScript) and not self:isVehicleScript(modelScript))
	if not modelScript then
		self.list2:clear()
		return
	end
	local attachIds = {}
	for _,item in self.list2:iteratorSelected() do
		attachIds[item.item:getId()] = true
	end
	self.list2:clear()
	self.list2:setScrollHeight(0)
	if self:isVehicleScript(modelScript) then return end
	for i=1,modelScript:getAttachmentCount() do
		local attach = modelScript:getAttachment(i-1)
		self.list2:addItem(attach:getId(), attach)
		if attachIds[attach:getId()] then
			self.list2.items[i].selected = true
		end
	end
	self.list2:sort()
	if self.list2:getSelectedCount() == 0 then
--		self.list2:setSelectedRow(1)
	end
end

function EditAttachment:setSelectedAttachment(attach)
	if self.selectedAttachment == attach then
		return
	end
	local wasWorldAttachment = self.selectedAttachment ~= nil and self.selectedAttachment:getId() == "world"
	local isWorldAttachment = attach ~= nil and attach:getId() == "world"
	if wasWorldAttachment and not isWorldAttachment then
		if self.selectedModelScript then
			local objectName = self:getSceneObjectId(self.selectedModelScript)
			self:java1("getObjectTranslation", objectName):set(0.0)
			self:java1("getObjectRotation", objectName):set(0.0)
		end
	end
	self.selectedAttachment = attach
	if self.selectedModelScript and not self:isVehicleScript(self.selectedModelScript) then
		self.parent.worldAttachmentPanel:setModelScriptName(self.selectedModelScript:getFullType())
	end
	self.parent.worldAttachmentPanel:setVisible(isWorldAttachment)
	self.buttonDeleteAttachment:setEnable(attach ~= nil)
	if not attach then
		self.nameEntry:clear()
		return
	end
	self.nameEntry:setText(attach:getId())
	if isWorldAttachment then
		local objectName = self:getSceneObjectId(self.selectedModelScript)
		self:java3("placeAttachmentAtOrigin", objectName, attach:getId(), self.parent.worldAttachmentPanel.weaponRotationHack)
	end
end

function EditAttachment:pickCharacterBone()
	local objectName = self:getSceneObjectId(self.selectedModelScript)
	if not objectName then
		return ""
	end
	if not self:java1("isObjectVisible", objectName) then
		return ""
	end
	if not self:isCharacterScript(self.selectedModelScript) then
		return ""
	end
	local boneName = self:java3("pickCharacterBone", objectName, self.parent.scene:getMouseX(), self.parent.scene:getMouseY())
	self.parent.wroteScriptTime = getTimestampMs() - 4950
	self.parent.wroteScriptLabel:setName(boneName)
	return boneName
end

function EditAttachment:pickModelBone()
	local objectName = self:getSceneObjectId(self.selectedModelScript)
	if not objectName then
		return ""
	end
	if not self:java1("isObjectVisible", objectName) then
		return ""
	end
	if self:isCharacterScript(self.selectedModelScript) then
		return ""
	end
	local boneName = self:java3("pickModelBone", objectName, self.parent.scene:getMouseX(), self.parent.scene:getMouseY())
	self.parent.wroteScriptTime = getTimestampMs() - 4950
	self.parent.wroteScriptLabel:setName(boneName)
	return boneName
end

function EditAttachment:toUI()
	EditPanel.toUI(self)
	self:populateObjectList()
end

function EditAttachment:populateObjectList()
	self.list:clear()
	if self:java1("isObjectVisible", "character1") then
		self.list:addItem("PLAYER", self:java1("isCharacterFemale", "character1") and self.femaleBodyScript or self.maleBodyScript)
	end
	if self:java1("isObjectVisible", "animal1") then
		self.list:addItem("ANIMAL", self.currentAnimalScript)
	end
	if self:java1("isObjectVisible", "vehicle") then
		self.list:addItem("VEHICLE", self:java1("getVehicleScript", "vehicle"))
	end
	for i=1,self:java0("getModelCount") do
		local modelScript = self:java1("getModelScript", i-1)
		self.list:addItem(modelScript:getName(), modelScript)
	end
	self.list:setSelectedRow(1)
end

function EditAttachment:getSelectedAttachments()
	local selected = {}
	if self.selectedModelScript then
		local modelScript = self.selectedModelScript
		for _,item2 in self.list2:iteratorSelected() do
			local attach = modelScript:getAttachmentById(item2.item:getId())
			if attach then
				table.insert(selected, attach)
			end
		end
	end
	return selected
end

function EditAttachment:getSelectedAttachmentIds()
	local selected = {}
	for _,item2 in self.list2:iteratorSelected() do
		table.insert(selected, item2.item:getId())
	end
	return selected
end

function EditAttachment:onGizmoStart()
	self.originalOffset = {}
	self.originalRotate = {}
	self.originalScale = {}
	self.isWorldAttachment = false
	if not self.selectedModelScript then
		return
	end

	for _,attach in ipairs(self:getSelectedAttachments()) do
		if attach:getId() == "world" then
			self.isWorldAttachment = true
		end
	end

	-- When no attachment is selected, transform the selected object
	if (self.list2:getSelectedCount() == 0) or self.isWorldAttachment then
		local objectName = self:getSceneObjectId(self.selectedModelScript)
		if self.gizmo == "translate" then
			local trans = Vector3f.new(self:java1("getObjectTranslation", objectName))
			self.originalOffset[self.selectedModelScript] = alignVectorToGrid(trans, self:java0("getGridMult"))
		end
		if self.gizmo == "rotate" then
			self.originalRotate[self.selectedModelScript] = Vector3f.new(self:java1("getObjectRotation", objectName))
		end
		if self.gizmo == "scale" then
			self.originalScale[self.selectedModelScript] = Vector3f.new(self:java1("getObjectScale", objectName))
		end
		return
	end
	for _,attach in ipairs(self:getSelectedAttachments()) do
		if self.gizmo == "translate" then
			-- FIXME: Need to consider the scale of the parent to use alignVectorToGrid()
--			self.originalOffset[attach] = alignVectorToGrid(Vector3f.new(attach:getOffset()), self:java0("getGridMult"))
			self.originalOffset[attach] = Vector3f.new(attach:getOffset())
		end
		if self.gizmo == "rotate" then
			self.originalRotate[attach] = Vector3f.new(attach:getRotate())
		end
		if self.gizmo == "scale" then
			self.originalScale[attach] = attach:getScale()
		end
	end
end

function EditAttachment:onGizmoChanged(delta)
	if self.parent.scene.gizmoAxis == "None" then return end
	if not self.selectedModelScript then
		return
	end
	if (self.list2:getSelectedCount() == 0) or self.isWorldAttachment then
		local objectName = self:getSceneObjectId(self.selectedModelScript)
		if self.gizmo == "translate" then
			self:java1("getObjectTranslation", objectName):set(self.originalOffset[self.selectedModelScript]):add(delta)
		end
		if self.gizmo == "rotate" then
			local rotation = self:java1("getObjectRotation", objectName)
			self:java2("applyDeltaRotation", rotation:set(self.originalRotate[self.selectedModelScript]), delta)
		end
		if self.gizmo == "scale" then
			local dxyz = delta:x()
			if math.abs(delta:y()) > math.abs(dxyz) then
				dxyz = delta:y()
			end
			if math.abs(delta:z()) > math.abs(dxyz) then
				dxyz = delta:z()
			end
			local scale = self:java1("getObjectScale", objectName)
			local xyz = self.originalScale[self.selectedModelScript]:x()
			scale:set(math.max(xyz + xyz * (dxyz / 0.2), 0.001))
		end
		if self.isWorldAttachment then
			self:java3("setAttachmentToOrigin", objectName, "world", self.parent.worldAttachmentPanel.weaponRotationHack)
		end
		return
	end
	for _,attach in ipairs(self:getSelectedAttachments()) do
		if self.gizmo == "translate" then
			attach:getOffset():set(self.originalOffset[attach]):add(delta)
		end
		if self.gizmo == "rotate" then
			self:java2("applyDeltaRotation", attach:getRotate():set(self.originalRotate[attach]), delta)
		end
		if self.gizmo == "scale" then
			local dxyz = delta:x()
			if math.abs(delta:y()) > math.abs(dxyz) then
				dxyz = delta:y()
			end
			if math.abs(delta:z()) > math.abs(dxyz) then
				dxyz = delta:z()
			end
			attach:setScale(self.originalScale[attach] + self.originalScale[attach] * (dxyz / 0.2))
		end
	end
end

function EditAttachment:onGizmoCancel()
	if not self.selectedModelScript then
		return
	end
	if (self.list2:getSelectedCount() == 0) or self.isWorldAttachment then
		local objectName = self:getSceneObjectId(self.selectedModelScript)
		if self.gizmo == "translate" then
			self:java1("getObjectTranslation", objectName):set(self.originalOffset[self.selectedModelScript])
		end
		if self.gizmo == "rotate" then
			local rotation = self:java1("getObjectRotation", objectName)
			rotation:set(self.originalRotate[self.selectedModelScript])
		end
		if self.gizmo == "scale" then
			local scale = self:java1("getObjectScale", objectName)
			scale:set(self.originalScale[self.selectedModelScript])
		end
		if self.isWorldAttachment then
			self:java3("setAttachmentToOrigin", objectName, "world", self.parent.worldAttachmentPanel.weaponRotationHack)
		end
		return
	end
	for _,attach in ipairs(self:getSelectedAttachments()) do
		if self.gizmo == "translate" then
			attach:getOffset():set(self.originalOffset[attach])
		end
		if self.gizmo == "rotate" then
			attach:getRotate():set(self.originalRotate[attach])
		end
		if self.gizmo == "scale" then
			attach:setScale(self.originalScale[attach])
		end
	end
end

function EditAttachment:onKeyPress(key)
	if key == Keyboard.KEY_R then
		if self.gizmo ~= "rotate" then
			self.gizmo = "rotate"
			self.button3.title = getText("IGUI_AttachmentEditor_Rotate")
		end
	end
	if key == Keyboard.KEY_S then
		if self.gizmo ~= "scale" then
			self.gizmo = "scale"
			self.button3.title = getText("IGUI_AttachmentEditor_Scale")
		end
	end
	if key == Keyboard.KEY_T then
		if self.gizmo ~= "translate" then
			self.gizmo = "translate"
			self.button3.title = getText("IGUI_AttachmentEditor_Translate")
		end
	end
	if key == Keyboard.KEY_Z then
		local isWorldAttachment = false
		for _,attach in ipairs(self:getSelectedAttachments()) do
			if attach:getId() == "world" then
				isWorldAttachment = true
			end
		end
		if (self.list2:getSelectedCount() == 0) or isWorldAttachment then
			local objectName = self:getSceneObjectId(self.selectedModelScript)
			if self.gizmo == "translate" then
				self:java1("getObjectTranslation", objectName):set(0.0)
			end
			if self.gizmo == "rotate" then
				local rotation = self:java1("getObjectRotation", objectName)
				rotation:set(0.0)
			end
			if self.gizmo == "scale" then
				local scale = self:java1("getObjectScale", objectName)
				scale:set(1.0)
			end
			if isWorldAttachment then
				self:java3("setAttachmentToOrigin", objectName, "world", self.parent.worldAttachmentPanel.weaponRotationHack)
			end
			return
		end
		for _,attach in ipairs(self:getSelectedAttachments()) do
			if self.gizmo == "translate" then
				attach:getOffset():set(0.0)
			end
			if self.gizmo == "rotate" then
				attach:getRotate():set(0.0)
			end
			if self.gizmo == "scale" then
				attach:setScale(1.0)
			end
		end
	end
end

function EditAttachment:new(x, y, width, height, editor)
	local o = EditPanel.new(self, x, y, width, height)
	o:noBackground()
	o.editor = editor
	return o
end

-----

function Scene:prerenderEditor()
	self.javaObject:fromLua1("setGizmoVisible", "none")
	self.javaObject:fromLua1("setGizmoOrigin", "none")
	if not self.zeroVector then self.zeroVector = Vector3f.new() end
	self.javaObject:fromLua1("setGizmoPos", self.zeroVector)
	self.javaObject:fromLua1("setGizmoRotate", self.zeroVector)
	self.javaObject:fromLua1("setRotateGizmoSnap", false)
	self.javaObject:fromLua0("clearAABBs")
	self.javaObject:fromLua0("clearAxes")
	self.javaObject:fromLua0("clearHighlightBone")
	self.javaObject:fromLua1("setSelectedAttachment", nil)
end

function Scene:prerender()
	ISUI3DScene.prerender(self)
end

function Scene:onMouseDown(x, y)
	ISUI3DScene.onMouseDown(self, x, y)
	self.gizmoAxis = self.javaObject:fromLua2("testGizmoAxis", x, y)
	if self.gizmoAxis ~= "None" then
		local scenePos = self.javaObject:fromLua0("getGizmoPos")
		self.gizmoStartScenePos = alignVectorToGrid(Vector3f.new(scenePos), self.javaObject:fromLua0("getGridMult"))
--		self.gizmoClickScenePos = alignVectorToGrid(self.javaObject:uiToScene(x, y, 0, Vector3f.new()), self.javaObject:fromLua0("getGridMult"))
		self.javaObject:fromLua3("startGizmoTracking", x, y, self.gizmoAxis)
		self:onGizmoStart()
	else
		self.parent.editUI.current:onSceneMouseDown(x, y)
	end
end

function Scene:onMouseMove(dx, dy)
	if self.gizmoAxis == "None" then
		ISUI3DScene.onMouseMove(self, dx, dy)
	else
		local x,y = self:getMouseX(),self:getMouseY()
--		local newPos = alignVectorToGrid(self.javaObject:uiToScene(x, y, 0, Vector3f.new()), self.javaObject:fromLua0("getGridMult"))
--		newPos:sub(self.gizmoClickScenePos)
--		newPos:add(self.gizmoStartScenePos)
		self.javaObject:fromLua2("dragGizmo", x, y)
	end
end

function Scene:onMouseUp(x, y)
	ISUI3DScene.onMouseUp(self, x, y)
	if self.gizmoAxis ~= "None" then
		self.gizmoAxis = "None"
		self.javaObject:fromLua0("stopGizmoTracking")
		self:onGizmoAccept()
	end
end

function Scene:onMouseUpOutside(x, y)
	self:onMouseUp()
end

function Scene:onRightMouseDown(x, y)
	if self.gizmoAxis ~= "None" then
		self.gizmoAxis = "None"
		self.javaObject:fromLua0("stopGizmoTracking")
		self.mouseDown = false
		self.javaObject:fromLua1("setGizmoPos", self.gizmoStartScenePos)
		self:onGizmoCancel()
	end
end

function Scene:onGizmoStart()
	self.parent.editUI.current:onGizmoStart()
end

function Scene:onGizmoChanged(delta)
	if self.gizmoAxis == "None" then return end -- cancelled via onRightMouseUp
	self.parent.editUI.current:onGizmoChanged(delta)
end

function Scene:onGizmoAccept()
	self.parent.editUI.current:onGizmoAccept()
end

function Scene:onGizmoCancel()
	self.parent.editUI.current:onGizmoCancel()
end

function Scene:new(x, y, width, height)
	local o = ISUI3DScene.new(self, x, y, width, height)
	o.gizmoAxis = "None"
	return o
end

-----

function AttachmentEditorUI:createChildren()
	self.scene = Scene:new(0, 0, self.width, self.height)
	self.scene:initialise()
	self.scene:instantiate()
	self.scene:setAnchorRight(true)
	self.scene:setAnchorBottom(true)
	self:addChild(self.scene)

	self.scene.javaObject:fromLua1("setMaxZoom", 20)
	self.scene.javaObject:fromLua1("setZoom", 10)
	self.scene.javaObject:fromLua1("setGizmoScale", 1.0 / 5.0)

	self.scene.javaObject:fromLua1("createCharacter", "character1")
	self.scene.javaObject:fromLua2("setCharacterAlpha", "character1", 1.0)
	self.scene.javaObject:fromLua2("setCharacterAnimate", "character1", false)
	self.scene.javaObject:fromLua2("setCharacterAnimSet", "character1", "player-editor")
	self.scene.javaObject:fromLua2("setCharacterState", "character1", "runtime")
	self.scene.javaObject:fromLua2("setCharacterAnimationClip", "character1", "Bob_Idle")
	self.scene.javaObject:fromLua2("setCharacterClearDepthBuffer", "character1", false)
	self.scene.javaObject:fromLua2("setCharacterShowBones", "character1", true)
	self.scene.javaObject:fromLua2("setObjectVisible", "character1", false)

	local animalDefs = getAllAnimalsDefinitions()
	if animalDefs:isEmpty() == false then
		local animalDef = animalDefs:get(0)
		self.scene.javaObject:fromLua3("createAnimal", "animal1", animalDef, animalDef:getBreeds():get(0))
		self.scene.javaObject:fromLua2("setCharacterAlpha", "animal1", 1.0)
		self.scene.javaObject:fromLua2("setCharacterClearDepthBuffer", "animal1", false)
		self.scene.javaObject:fromLua2("setCharacterShowBones", "animal1", true)
		self.scene.javaObject:fromLua2("setObjectVisible", "animal1", false)
	end

	self.scene.javaObject:fromLua1("createVehicle", "vehicle")
	self.scene.javaObject:fromLua2("setObjectVisible", "vehicle", false)

	local viewW = 150
	local viewH = 100
	self.bottomPanel = ISPanel:new(0, self.height - viewH - UI_BORDER_SPACING-1, self.width, viewH)
	self.bottomPanel:setAnchorTop(false)
	self.bottomPanel:setAnchorLeft(true)
	self.bottomPanel:setAnchorRight(true)
	self.bottomPanel:setAnchorBottom(true)
	self.bottomPanel:noBackground()
	self:addChild(self.bottomPanel)

	local viewNames = {'Left', 'Right', 'Top', 'Bottom', 'Front', 'Back'}
	local viewX = self.width / 2 - (#viewNames * viewW + (#viewNames - 1) * UI_BORDER_SPACING) / 2
	local viewY = 0
	self.views = {}
	for _,viewName in ipairs(viewNames) do
		local view = SwitchView:new(self, viewX, viewY, viewW, viewH)
		view:initialise()
		view:instantiate()
		view:setAnchorTop(false)
		view:setAnchorRight(false)
		view:setView(viewName)
		view.javaObject:fromLua1("setMaxZoom", 14)
		view.javaObject:fromLua1("setZoom", 14)
		view.javaObject:fromLua1("setDrawGrid", false)
		view.javaObject:fromLua1("createCharacter", "character1")
		view.javaObject:fromLua2("setCharacterAnimSet", "character1", "player-editor")
		view.javaObject:fromLua2("setCharacterAlpha", "character1", 1.0)
		if viewName ~= "Top" and viewName ~= "Bottom" then
			view.javaObject:fromLua2("dragView", 0, viewH * 2)
		end
		self.bottomPanel:addChild(view)
		table.insert(self.views, view)
		viewX = viewX + viewW + UI_BORDER_SPACING
	end

	self.editUI = {}
	self.editUI.current = nil

	local ui = EditAttachment:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_AttachmentEditor_RemoveFromScene"))+20, self.height - 100, self) --widest button in the panel is "REMOVE FROM SCENE"
	ui:setVisible(false)
	self:addChild(ui)
	self.editUI.attachments = ui

	local button = ISButton:new(UI_BORDER_SPACING+1, self.bottomPanel.height - BUTTON_HGT, 80, BUTTON_HGT, getText("IGUI_DebugMenu_Save"), self, self.onSave)
	self.bottomPanel:addChild(button)
	button:enableAcceptColor()

	local button2 = ISButton:new(button:getRight() + UI_BORDER_SPACING, button.y, 80, BUTTON_HGT, getText("IGUI_DebugMenu_Exit"), self, self.onExit)
	self.bottomPanel:addChild(button2)
	button2:enableCancelColor()

	local label = ISLabel:new(10, self.bottomPanel.y - 30, FONT_HGT_SMALL, "", 1, 1, 1, 1, UIFont.Small, true)
	label:setAnchorTop(false)
	label:setAnchorBottom(true)
	self:addChild(label)
	self.wroteScriptLabel = label

	local buttonWidthPadding = UI_BORDER_SPACING*2
	local btnWidth = buttonWidthPadding + getTextManager():MeasureStringX(UIFont.Small, "0.001")

	local buttonScale1 = ISButton:new(self.width - btnWidth - UI_BORDER_SPACING - 1, button.y, btnWidth, BUTTON_HGT, "0.001", self, self.onGridMult1)
	buttonScale1:setAnchorLeft(false)
	buttonScale1:setAnchorRight(true)
	self.bottomPanel:addChild(buttonScale1)
	self.buttonScale1 = buttonScale1

	local btnWidth = buttonWidthPadding + getTextManager():MeasureStringX(UIFont.Small, "0.005")
	local buttonScale2 = ISButton:new(buttonScale1.x - UI_BORDER_SPACING - btnWidth, button.y, btnWidth, BUTTON_HGT, "0.005", self, self.onGridMult2)
	buttonScale2:setAnchorLeft(false)
	buttonScale2:setAnchorRight(true)
	self.bottomPanel:addChild(buttonScale2)
	self.buttonScale2 = buttonScale2

	local btnWidth = buttonWidthPadding + getTextManager():MeasureStringX(UIFont.Small, "0.01")
	local buttonScale3 = ISButton:new(buttonScale2.x - UI_BORDER_SPACING - btnWidth, button.y, btnWidth, BUTTON_HGT, "0.01", self, self.onGridMult3)
	buttonScale3:setAnchorLeft(false)
	buttonScale3:setAnchorRight(true)
	self.bottomPanel:addChild(buttonScale3)
	self.buttonScale3 = buttonScale3

	self.scene.javaObject:fromLua1("setGridMult", 10)
	self.buttonScale1:setEnable(false)

	self.editUI.attachments:doLayout()
	self:setEditUI(self.editUI.attachments)

	-- This is displayed when editing a "world" attachment to show the model as it would appear in game.
	self.worldAttachmentPanel = WorldAttachmentPanel:new(self.width - 50 - 350, 50, 350, 200, self)
	self:addChild(self.worldAttachmentPanel)
	self.worldAttachmentPanel:setVisible(false)
end

function AttachmentEditorUI:onResolutionChange(oldw, oldh, neww, newh)
	self:setWidth(neww)
	self:setHeight(newh)
	local viewW = 150
	local viewX = self.width / 2 - (#self.views * viewW + (#self.views - 1) * UI_BORDER_SPACING) / 2
	for _,view in ipairs(self.views) do
		view:setX(viewX)
		viewX = viewX + viewW + UI_BORDER_SPACING
	end
	self.editUI.attachments:doLayout()
end

function AttachmentEditorUI:update()
	ISPanel.update(self)
	if self.width ~= getCore():getScreenWidth() or self.height ~= getCore():getScreenHeight() then
		self:onResolutionChange(self.width, self.height, getCore():getScreenWidth(), getCore():getScreenHeight())
	end
end

function AttachmentEditorUI:prerender()
	ISPanel.prerender(self)
	self.scene:prerenderEditor()
	if self.editUI and self.editUI.current then
		self.editUI.current:prerenderEditor()
	end
	if (self.wroteScriptLabel.name ~= "") and (self.wroteScriptTime + 5000 < getTimestampMs()) then
		self.wroteScriptLabel:setName("")
	end
end

function AttachmentEditorUI:setEditUI(ui)
	if self.editUI.current then
		self.editUI.current:setVisible(false)
	end
	self.editUI.current = ui
	if ui then
		ui:toUI()
		ui:setVisible(true)
	end
end

function AttachmentEditorUI:onSetModelWeaponRotationHackChanged(isChecked)
	local editUI = self.editUI.attachments
	if editUI.selectedModelScript == nil then return end
	local objectName = editUI:getSceneObjectId(editUI.selectedModelScript)
	local attach = editUI.selectedAttachment
	if attach == nil or attach:getId() ~= "world" then return end
	self.scene.javaObject:fromLua3("placeAttachmentAtOrigin", objectName, attach:getId(), isChecked)
end

function AttachmentEditorUI:onSave(button, x, y)
	local item = self.editUI.attachments.list:getSelectedItems()[1]
	if item then
		getAttachmentEditorState():fromLua1("writeScript", item.item:getFullType())
	end
end

function AttachmentEditorUI:onExit(button, x, y)
	getAttachmentEditorState():fromLua0("exit")
end

function AttachmentEditorUI:onGridMult1(button, x, y)
	self.buttonScale1:setEnable(false)
	self.buttonScale2:setEnable(true)
	self.buttonScale3:setEnable(true)
	self.scene.javaObject:fromLua1("setGridMult", 10)
end

function AttachmentEditorUI:onGridMult2(button, x, y)
	self.buttonScale1:setEnable(true)
	self.buttonScale2:setEnable(false)
	self.buttonScale3:setEnable(true)
	self.scene.javaObject:fromLua1("setGridMult", 2)
end

function AttachmentEditorUI:onGridMult3(button, x, y)
	self.buttonScale1:setEnable(true)
	self.buttonScale2:setEnable(true)
	self.buttonScale3:setEnable(false)
	self.scene.javaObject:fromLua1("setGridMult", 1)
end

function AttachmentEditorUI:onKeyPress(key)
	self.editUI.current:onKeyPress(key)
	if key == Keyboard.KEY_SPACE then
		local animate = self.scene.javaObject:fromLua1("getCharacterAnimate", "character1")
		self.scene.javaObject:fromLua2("setCharacterAnimate", "character1", not animate)
	end
end

-- Called from Java
function AttachmentEditorUI:showUI()
end

-- Called from Java
function AttachmentEditorUI:wroteScript(fileName)
	self.wroteScriptTime = getTimestampMs()
	self.wroteScriptLabel:setName(fileName)
end

function AttachmentEditorUI:new(x, y, width, height)
	local o = ISPanel.new(self, x, y, width, height)
	o:setAnchorRight(true)
	o:setAnchorBottom(true)
	o:noBackground()
	o:setWantKeyEvents(true)
	getAttachmentEditorState():setTable(o)
	return o
end

function AttachmentEditorState_InitUI()
	local UI = AttachmentEditorUI:new(0, 0, getCore():getScreenWidth(), getCore():getScreenHeight())
	AttachmentEditorState_UI = UI
	UI:setVisible(true)
	UI:addToUIManager()
end

