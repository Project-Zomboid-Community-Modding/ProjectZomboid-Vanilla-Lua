--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISScrollingListBox"
require "RadioCom/ISUIRadio/ISSliderPanel"
require "DebugUIs/DebugChunkState/ISSectionedPanel"
require "DebugUIs/DebugChunkState/DebugChunkState_SquarePanel"
require "DebugUIs/DebugChunkState/DebugChunkState_ObjectProperties"
require "DebugUIs/DebugChunkState/DebugChunkState_ObjectPickerPanel"
require "DebugUIs/DebugChunkState/DebugChunkState_VehicleStoryPanel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

DebugChunkStateUI = ISPanel:derive("DebugChunkStateUI")

-----

require "DebugUIs/DebugChunkState/DebugChunkState_Tools"

-----

DebugChunkStateUI_OptionsPanel = ISPanel:derive("DebugChunkStateUI_OptionsPanel")
local OptionsPanel = DebugChunkStateUI_OptionsPanel

function OptionsPanel:createChildren()
	local tickBox = ISTickBox:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, BUTTON_HGT, BUTTON_HGT, "", self, self.onTickBox)
	tickBox:initialise()
	self:addChild(tickBox)
	for i=1,self.gameState:getOptionCount() do
		local option = self.gameState:getOptionByIndex(i-1)
		tickBox:addOption(option:getName(), option)
		tickBox:setSelected(i, option:getValue())
	end
	tickBox:setWidthToFit()
	self:setWidth(tickBox:getRight() + UI_BORDER_SPACING+1)
	self:setHeight(tickBox:getBottom() + UI_BORDER_SPACING+1)
	self.tickBox = tickBox
end

function OptionsPanel:onTickBox(index, selected)
	local option = self.tickBox.optionData[index]
	option:setValue(selected)
end

function OptionsPanel:onMouseDownOutside(x, y)
	if self:isMouseOver() then return end
	self:setVisible(false)
--	self:removeFromUIManager()
end

function OptionsPanel:new(x, y, width, height, gameState)
	local o = ISPanel.new(self, x, y, width, height)
	o.backgroundColor.a = 0.8
	o.gameState = gameState
	return o
end

-----

DebugChunkStateUI_SpritePopupPanel = ISPanel:derive("DebugChunkStateUI_SpritePopupPanel")
local SpritePopupPanel = DebugChunkStateUI_SpritePopupPanel

function SpritePopupPanel:render()
	if self.sprite then
		local tex = self.sprite:getTextureForCurrentFrame(IsoDirections.N)
		if not tex then return end -- IsoDeadBody
		local texW, texH = tex:getWidthOrig(), tex:getHeightOrig()
		if texW > self.width or texH > self.height then
			 -- jumbo tree
			texW = math.min(texW, self.width)
			texH = math.min(texH, self.height)
			self:drawTextureScaledAspect(tex, (self.width - texW) / 2, (self.height - texH) / 2, texW, texH, 1, 1, 1, 1)
		else
			self:drawTexture(tex, (self.width - texW) / 2, (self.height - texH) / 2, texW, texH, 1, 1, 1, 1)
		end
	end
end

function SpritePopupPanel:new(x, y, w, h)
	local o = ISPanel.new(self, x, y, w, h)
	o.backgroundColor = { r = 1, g = 1, b = 1, a = 1 }
	o.sprite = nil
	return o
end

-----

function DebugChunkStateUI:createChildren()
	local panelWidth = 200+(getCore():getOptionFontSizeReal()*50);

	self.buttonPlayer0 = ISButton:new(UI_BORDER_SPACING, UI_BORDER_SPACING, BUTTON_HGT, BUTTON_HGT, "PLR 0", self, self.onChangePlayer)
	self.buttonPlayer0.playerIndex = 0
	self:addChild(self.buttonPlayer0)

	self.buttonPlayer1 = ISButton:new(self.buttonPlayer0:getRight() + UI_BORDER_SPACING, UI_BORDER_SPACING, BUTTON_HGT, BUTTON_HGT, "PLR 1", self, self.onChangePlayer)
	self:addChild(self.buttonPlayer1)
	self.buttonPlayer1.playerIndex = 1

	self.buttonPlayer2 = ISButton:new(self.buttonPlayer1:getRight() + UI_BORDER_SPACING, UI_BORDER_SPACING, BUTTON_HGT, BUTTON_HGT, "PLR 2", self, self.onChangePlayer)
	self:addChild(self.buttonPlayer2)
	self.buttonPlayer2.playerIndex = 2

	self.buttonPlayer3 = ISButton:new(self.buttonPlayer2:getRight() + UI_BORDER_SPACING, UI_BORDER_SPACING, BUTTON_HGT, BUTTON_HGT, "PLR 3", self, self.onChangePlayer)
	self:addChild(self.buttonPlayer3)
	self.buttonPlayer3.playerIndex = 3

	self.zLevelSlider = ISSliderPanel:new(UI_BORDER_SPACING, self.buttonPlayer0:getBottom() + UI_BORDER_SPACING, panelWidth, BUTTON_HGT, self, self.onChangeZLevel)
	self.zLevelSlider:initialise()
	self.zLevelSlider:setValues(-31, 31, 1, 1, true)
	self.zLevelSlider:setCurrentValue(self.gameState:fromLua0("getZ"), true)
	self:addChild(self.zLevelSlider)

	local top = self.zLevelSlider:getBottom() + UI_BORDER_SPACING
	self.objectSections = ISSectionedPanel:new(UI_BORDER_SPACING, top, panelWidth, self.height - UI_BORDER_SPACING - top)
	self.objectSections.anchorBottom = true
	self.objectSections.maintainHeight = false
	self:addChild(self.objectSections)
	self.objectSections:setScrollChildren(true)
	self.objectSections:addScrollBars()

	self.objectList = ISScrollingListBox:new(0, 0, panelWidth, 100)
	self.objectList.debugChunkState = self
	self.objectList.doDrawItem = function(self, y, item, alt) return self.debugChunkState.doDrawObjectListItem(self, y, item, alt) end
	self.objectList:setFont(UIFont.Small, 6)
	self.objectList.itemheight = self.objectList.fontHgt * 3
	self.objectList:setHeight(self.objectList.fontHgt * 15)
	self.objectSections:addSection(self.objectList, getText("IGUI_ChunkState_ObjectsOnSquare"))

	self.objPropsPanel = DebugChunkStateUI_ObjPropsPanel:new(0, self.objectList:getBottom() + UI_BORDER_SPACING, self.objectList.width, 100, self)
	self.objectSections:addSection(self.objPropsPanel, getText("IGUI_ChunkState_ObjectDetails"))

	self.spritePopupPanel = SpritePopupPanel:new(0, 0, 64 * Core.getTileScale(), 128 * Core.getTileScale())
	self.spritePopupPanel.keepOnScreen = true
	self.spritePopupPanel:setVisible(false)
	self:addChild(self.spritePopupPanel)

	self.toolBar = ISPanel:new(self.width / 2 - 300 / 2, 10, 300, BUTTON_HGT)
	self.toolBar:noBackground()
	self:addChild(self.toolBar)
--[[
	local button1 = ISButton:new(0, 0, 60, toolHgt, "CAMERA", self, self.onCamera)
	self.toolBar:addChild(button1)
--]]
	local button2 = ISButton:new(0, 0, 60, BUTTON_HGT, getText("IGUI_DebugMenu_Options"), self, self.onOptions)
	self.toolBar:addChild(button2)
	self.buttonOptions = button2
	
	local button3 = ISButton:new(button2:getRight() + UI_BORDER_SPACING, 0, 60, BUTTON_HGT, getText("IGUI_DebugMenu_Exit"), self, self.onExit)
	button3:enableCancelColor()
	self.toolBar:addChild(button3)
	self.buttonExit = button3

	self.toolBar:setWidth(button3:getRight())
	self.toolBar:setX(self.width / 2)

	self.squarePanel = DebugChunkStateUI_SquarePanel:new(self.width - panelWidth - 10, 10, panelWidth, self.height - UI_BORDER_SPACING*2, self)
	self.squarePanel.anchorBottom = true
	self.squarePanel.maintainHeight = false
	self:addChild(self.squarePanel)
	self.squarePanel:setScrollChildren(true)
	self.squarePanel:addScrollBars()
	self.squarePanel:createSections()

	self.objectPickerPanel = DebugChunkState_ObjectPickerPanel:new((self.width - panelWidth*2) / 2, self.height - 100, panelWidth*2, 80, self)
	self.objectPickerPanel:setY(self.height - self.objectPickerPanel.height - UI_BORDER_SPACING)
	self:addChild(self.objectPickerPanel)

	self.optionsPanel = DebugChunkStateUI_OptionsPanel:new(0, 0, 300, 400, self.gameState)
	self.optionsPanel:setVisible(false)
	self:addChild(self.optionsPanel)

	local vehicleStoryWidth = 300
	self.vehicleStoryPanel = DebugChunkState_VehicleStoryPanel:new(self.toolBar.x - UI_BORDER_SPACING - vehicleStoryWidth, self.toolBar.y, vehicleStoryWidth, 80, self)
	self:addChild(self.vehicleStoryPanel)

	self.objectAtCursorPanel = DebugChunkState_ObjectAtCursorPanel:new(self.vehicleStoryPanel.x - UI_BORDER_SPACING - panelWidth, self.toolBar.y, panelWidth, 0, self)
	self:addChild(self.objectAtCursorPanel)
	self.objectAtCursorPanel:setX(self.vehicleStoryPanel.x - 10 - self.objectAtCursorPanel.width)
end

function DebugChunkStateUI:onChangePlayer(button, x, y)
	local playerIndex = button.playerIndex
	if getSpecificPlayer(playerIndex) then
		self.gameState:fromLua1("setPlayerIndex", playerIndex)
	end
end

function DebugChunkStateUI:onChangeZLevel(value, slider)
	self.gameState:fromLua1("setZ", value)
end

function DebugChunkStateUI:onCamera()
	self.currentTool = self.dragCameraTool
end

function DebugChunkStateUI:onOptions()
	self.optionsPanel:setX(self.buttonOptions:getAbsoluteX())
	self.optionsPanel:setY(self.buttonOptions:getAbsoluteY() + self.buttonOptions:getHeight())
	self.optionsPanel:setVisible(true)
end

function DebugChunkStateUI:onExit()
	self.gameState:fromLua0("exit")
end

function DebugChunkStateUI:doDrawObjectListItem(y, item, alt)
	local object = item.item

	local x = 4

	local isMouseOver = self.mouseoverselected == item.index and not self:isMouseOverScrollBar()
	if self.selected == item.index then
		self:drawRect(0, y, self:getWidth(), item.height-1, 0.3, 0.7, 0.35, 0.15)
	elseif isMouseOver then
		self:drawRect(1, y + 1, self:getWidth() - 2, item.height - 2, 0.25, 1.0, 1.0, 1.0)
	end

	self:drawText(item.text, x, y, 1, 1, 1, 1, self.font)
	y = y + self.fontHgt

	self:drawText("name=" .. tostring(object:getName()), x, y, 1, 1, 1, 1, self.font)
	y = y + self.fontHgt

	local spriteName = object:getSprite() and object:getSprite():getName() or "<no sprite>"
	self:drawText(spriteName, x, y, 1, 1, 1, 1, self.font)
	y = y + self.fontHgt

	if (object:getClass():getSimpleName() == "BaseVehicle") then
		self:drawText("sqlid ="..tostring(object:getSqlId()), x, y, 1, 1, 1, 1, self.font)
		y = y + self.fontHgt
	end

	self:drawRect(x, y, self.width - 4 * 2, 2, 1.0, 0.5, 0.5, 0.5)
	y = y + 2
	return y
end

function DebugChunkStateUI:onMouseDown(x, y)
	ISPanel.onMouseDown(self, x, y)

	self.mouseDown = true
	self.mouseMoved = false
	self.mouseDownX = x
	self.mouseDownY = y

	if self.currentTool then
		self.currentTool:onMouseDown(x, y)
	end
	return false
end

function DebugChunkStateUI:onMouseMove(dx, dy)
	ISPanel.onMouseMove(self, dx, dy)
	if self.mouseDown then
		if not self.mouseMoved then
			if math.abs(self.mouseDownX - self:getMouseX()) > 50 or math.abs(self.mouseDownY - self:getMouseY()) > 50 then
				self.mouseMoved = true
			end
		end
	elseif not self:isMouseOverChild() then
		self:updateObjectList()
	end
	if self.currentTool then
		self.currentTool:onMouseMove(dx, dy)
	end
	return false
end

function DebugChunkStateUI:isMouseOverChild()
	local children = self.javaObject:getControls()
	for i=children:size(),1,-1 do
		if children:get(i-1):getTable():isMouseOver() then
			return true
		end
	end
	return false
end

function DebugChunkStateUI:onMouseUp(x, y)
	ISPanel.onMouseUp(self, x, y)
	self.mouseDown = false
	if not self.mouseMoved then
		local square,sqx,sqy,sqz = self:pickSquare(x, y)
		if square and square == self.selectedSquare then
			self.selectedSquare = nil
		elseif square ~= self.selectedSquare then
			self.selectedSquare = square
			self.squarePanel:setSquare(square, sqx, sqy, sqz)
			self:setObjectList(square, sqx, sqy, sqz)
		end
	end
	if self.currentTool then
		self.currentTool:onMouseUp(x, y)
	end
	return false
end

function DebugChunkStateUI:onMouseUpOutside(x, y)
	ISPanel.onMouseUpOutside(self, x, y)
	self.mouseDown = false
	if self.currentTool then
		self.currentTool:onMouseUp(x, y)
	end
	return false
end

function DebugChunkStateUI:onMouseWheel(del)
	local playerIndex = self.gameState:fromLua0("getPlayerIndex")
	if playerIndex == 0 then return false end -- UIManager already does this
	getCore():doZoomScroll(playerIndex, del)
	return false
end

function DebugChunkStateUI:onResolutionChange(oldw, oldh, neww, newh)
	self:setWidth(neww)
	self:setHeight(newh)
	self.toolBar:setX(self.width / 2 - self.toolBar.width / 2)
	self.squarePanel:setX(self.width - 10 - self.squarePanel.width)
	self.objectAtCursorPanel:setX(self.toolBar.x - 10 - self.objectAtCursorPanel.width)
end

function DebugChunkStateUI:prerender()
	ISPanel.prerender(self)
	self.buttonPlayer0:setEnable(getSpecificPlayer(0) ~= nil)
	self.buttonPlayer1:setEnable(getSpecificPlayer(1) ~= nil)
	self.buttonPlayer2:setEnable(getSpecificPlayer(2) ~= nil)
	self.buttonPlayer3:setEnable(getSpecificPlayer(3) ~= nil)
	self.spritePopupPanel.sprite = nil
	local item = self.objectList.items[self.objectList.mouseoverselected]
	if not item then return end
	local object = item.item
	if not object then return end
	if not object:getSprite() then return end
	local tex = object:getSprite():getTextureForCurrentFrame(IsoDirections.N)
	if not tex then return end
--	if instanceof(object, "IsoDeadBody") then return end
--	if instanceof(object, "IsoGameCharacter") then return end
	local spritePopupPanel = self.spritePopupPanel
	spritePopupPanel.sprite = object:getSprite()
	spritePopupPanel:setX(self.objectSections:getRight())
	spritePopupPanel:setY(self.objectList:getAbsoluteY())
end

function DebugChunkStateUI:render()
	ISPanel.render(self)
	if self.spritePopupPanel.sprite == nil then
		if self.spritePopupPanel:isVisible() then
			self.spritePopupPanel:setVisible(false)
		end
	else
		if not self.spritePopupPanel:isVisible() then
			self.spritePopupPanel:setVisible(true)
		end
	end
end

function DebugChunkStateUI:update()
	ISPanel.update(self)
	if self.width ~= getCore():getScreenWidth() or self.height ~= getCore():getScreenHeight() then
		self:onResolutionChange(self.width, self.height, getCore():getScreenWidth(), getCore():getScreenHeight())
	end
	self:updateObjectProps()
	self.objectPickerPanel:setVisible(self.gameState:getBoolean("ObjectPicker"))
	self.objectAtCursorPanel:setVisible(self.gameState:getBoolean("ObjectAtCursor"))
	self.vehicleStoryPanel:setVisible(self.gameState:getBoolean("VehicleStory"))
end

function DebugChunkStateUI:pickSquare(x, y)
	local playerIndex = self.gameState:fromLua0("getPlayerIndex")
	local z = self.gameState:fromLua0("getZ")
	local worldX = screenToIsoX(playerIndex, self:getMouseX(), self:getMouseY(), z)
	local worldY = screenToIsoY(playerIndex, self:getMouseX(), self:getMouseY(), z)
	return getCell():getGridSquare(worldX, worldY, z), worldX, worldY, z
end

function DebugChunkStateUI:updateObjectList()
	if self.selectedSquare then return end
	local square,x,y,z = self:pickSquare(self:getMouseX(), self:getMouseY())
	self.squarePanel:setSquare(square, x, y, z)
	self:setObjectList(square, x, y, z)
end

function DebugChunkStateUI:setObjectList(square, x, y, z)
	if square == self.objectListSquare then return end
	self.objectListSquare = square
	self.objectList:clear()
	if not square then
		return
	end
	for i=1,square:getObjects():size() do
		local object = square:getObjects():get(i-1)
		local line1 = object:getClass():getSimpleName()
--		local line1 = line1 .. "  name=" .. tostring(object:getName())
		local line1 = line1 .. "  type=" .. tostring(object:getType())
		self.objectList:addItem(line1, object)
	end
	for i=1,square:getStaticMovingObjects():size() do
		local object = square:getStaticMovingObjects():get(i-1)
		local line1 = object:getClass():getSimpleName()
--		local line1 = line1 .. "  name=" .. tostring(object:getName())
		local line1 = line1 .. "  type=" .. tostring(object:getType())
		self.objectList:addItem(line1, object)
	end
	for i=1,square:getMovingObjects():size() do
		local object = square:getMovingObjects():get(i-1)
		local line1 = object:getClass():getSimpleName()
--		local line1 = line1 .. "  name=" .. tostring(object:getName())
		local line1 = line1 .. "  type=" .. tostring(object:getType())
		self.objectList:addItem(line1, object)
	end
end

function DebugChunkStateUI:updateObjectProps()
	local item = self.objectList.items[self.objectList.mouseoverselected] or self.objectList.items[self.objectList.selected]
	local object = item and item.item or nil
	self.objPropsPanel:setObject(object)
end

-- Called from Java
function DebugChunkStateUI:showUI()
end

function DebugChunkStateUI:new(x, y, width, height, gameState)
	local o = ISPanel.new(self, x, y, width, height)
	o.gameState = gameState
	gameState:setTable(o)
	o:setAnchorRight(true)
	o:setAnchorBottom(true)
	o:noBackground()
	o.dragCameraTool = DebugChunkStateUI_DragCameraTool:new(o)
	o.currentTool = o.dragCameraTool
	return o
end

function DebugChunkState_InitUI(gameState)
	local UI = DebugChunkStateUI:new(0, 0, getCore():getScreenWidth(), getCore():getScreenHeight(), gameState)
	DebugChunkState_UI = UI
	UI:setVisible(true)
	UI:addToUIManager()
end

