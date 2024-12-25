--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISPanelJoypad"
require "ISUI/Maps/ISMap"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local FONT_HGT_HANDWRITTEN = getTextManager():getFontHeight(UIFont.SdfCaveat)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

ISWorldMapSymbols = ISPanelJoypad:derive("ISWorldMapSymbols")

-----

ISWorldMapSymbolTool = ISBaseObject:derive("ISWorldMapSymbolTool")

function ISWorldMapSymbolTool:activate()
end

function ISWorldMapSymbolTool:deactivate()
end

function ISWorldMapSymbolTool:onMouseDown(x, y)
	self.dragging = true
	self.dragMoved = false
	self.dragStartX = x
	self.dragStartY = y
	return false
end

function ISWorldMapSymbolTool:onMouseUp(x, y)
	self.dragging = false
	return false
end

function ISWorldMapSymbolTool:onMouseMove(dx, dy)
	if self.dragging and not self.dragMoved then
		local mouseX = self:getMouseX()
		local mouseY = self:getMouseY()
		if math.abs(mouseX - self.dragStartX) > 4 and math.abs(mouseY - self.dragStartY) > 4 then
			self.dragMoved = true
		end
	end
	return false
end

function ISWorldMapSymbolTool:onRightMouseDown(x, y)
	return false
end

function ISWorldMapSymbolTool:onRightMouseUp(x, y)
	return false
end

function ISWorldMapSymbolTool:isKeyConsumed(key)
	return false
end

function ISWorldMapSymbolTool:onKeyPress(key)
	return false
end

function ISWorldMapSymbolTool:onKeyRelease(key)
	return false
end

function ISWorldMapSymbolTool:render()
end

function ISWorldMapSymbolTool:getMouseX()
	return self.mapUI:getMouseX()
end

function ISWorldMapSymbolTool:getMouseY()
	return self.mapUI:getMouseY()
end

function ISWorldMapSymbolTool:onJoypadDownInMap(button, joypadData)
end

function ISWorldMapSymbolTool:getJoypadAButtonText()
end

function ISWorldMapSymbolTool:new(symbolsUI)
	local o = ISBaseObject.new(self)
	o.symbolsUI = symbolsUI -- ISWorldMapSymbols
	o.mapUI = symbolsUI.mapUI -- UIElement with javaObject=UIWorldMap
	o.mapAPI = symbolsUI.mapAPI
	o.symbolsAPI = symbolsUI.symbolsAPI
	return o
end

-----

ISWorldMapSymbolTool_AddSymbol = ISWorldMapSymbolTool:derive("ISWorldMapSymbolTool_AddSymbol")

function ISWorldMapSymbolTool_AddSymbol:activate()
end

function ISWorldMapSymbolTool_AddSymbol:deactivate()
	self.symbolsUI.selectedSymbol = nil
end

function ISWorldMapSymbolTool_AddSymbol:onMouseUp(x, y)
	local dragging = self.dragging
	local dragMoved = self.dragMoved
	ISWorldMapSymbolTool.onMouseUp(self, x, y)
	if not dragging then return false end
	if dragMoved then return false end
	self:addSymbol(x, y)
	return true
end

function ISWorldMapSymbolTool_AddSymbol:onJoypadDownInMap(button, joypadData)
	if button == Joypad.AButton then
		self:addSymbol(self.mapUI.width / 2, self.mapUI.height / 2)
	end
end

function ISWorldMapSymbolTool_AddSymbol:getJoypadAButtonText()
	return getText("IGUI_Map_PlaceSymbol")
end

function ISWorldMapSymbolTool_AddSymbol:render()
	if (self.symbolsUI.playerNum ~= 0) or (JoypadState.players[self.symbolsUI.playerNum+1] and not wasMouseActiveMoreRecentlyThanJoypad()) then
		self.symbolsUI:renderSymbol(self.symbolsUI.selectedSymbol, self.mapUI.width / 2, self.mapUI.height / 2)
	else
		self.symbolsUI:renderSymbol(self.symbolsUI.selectedSymbol, self:getMouseX(), self:getMouseY())
	end
end

function ISWorldMapSymbolTool_AddSymbol:addSymbol(x, y)
	local newSymbol = {}
	local scale = ISMap.SCALE
	local sym = self.symbolsUI.selectedSymbol
	local symW = 20 / 2 * scale
	local symH = 20 / 2 * scale
	newSymbol.x = self.mapAPI:uiToWorldX(x, y)
	newSymbol.y = self.mapAPI:uiToWorldY(x, y)
	newSymbol.symbol = sym.tex
	newSymbol.r = self.symbolsUI.currentColor:getR()
	newSymbol.g = self.symbolsUI.currentColor:getG()
	newSymbol.b = self.symbolsUI.currentColor:getB()
	local textureSymbol = self.symbolsAPI:addTexture(newSymbol.symbol, newSymbol.x, newSymbol.y)
	textureSymbol:setRGBA(newSymbol.r, newSymbol.g, newSymbol.b, 1.0)
	textureSymbol:setAnchor(0.5, 0.5)
	textureSymbol:setScale(ISMap.SCALE)
	if self.symbolsUI.character then
		self.symbolsUI.character:playSoundLocal("MapAddSymbol")
	end
end

function ISWorldMapSymbolTool_AddSymbol:new(symbolsUI)
	local o = ISWorldMapSymbolTool.new(self, symbolsUI)
	return o
end

-----

ISWorldMapSymbolTool_AddNote = ISWorldMapSymbolTool:derive("ISWorldMapSymbolTool_AddNote")

function ISWorldMapSymbolTool_AddNote:activate()
end

function ISWorldMapSymbolTool_AddNote:deactivate()
	if self.modal then
		self.modal.no:forceClick()
		self.modal = nil
	end
end

function ISWorldMapSymbolTool_AddNote:onMouseUp(x, y)
	local dragging = self.dragging
	local dragMoved = self.dragMoved
	ISWorldMapSymbolTool.onMouseUp(self, x, y)
	if not dragging then return false end
	if dragMoved then return false end
	if self.modal then return false end
	self:addNote(x, y)
	return true
end

function ISWorldMapSymbolTool_AddNote:addNote(x, y)
	self.symbolsUI.noteX = self.mapAPI:uiToWorldX(x, y)
	self.symbolsUI.noteY = self.mapAPI:uiToWorldY(x, y)
	local mx = self.mapUI:getAbsoluteX() + x
	local my = self.mapUI:getAbsoluteY() + y + FONT_HGT_HANDWRITTEN * ISMap.SCALE * self.mapAPI:getWorldScale()
	local playerNum = self.symbolsUI.character and self.symbolsUI.playerNum or nil
	self.modal = ISTextBoxMap:new(mx, my, 350, 180, getText("IGUI_Map_AddNote"), "", self, self.onAddNote, playerNum)
	self.modal:initialise()
	self.modal.noEmpty = true
	self.modal:addToUIManager()
	self.modal:setAlwaysOnTop(true)
	self.modal:selectColor(self.symbolsUI.currentColor:getR(), self.symbolsUI.currentColor:getG(), self.symbolsUI.currentColor:getB())
	if self.symbolsUI.showTranslationOption then
		self.modal:showTranslationTickBox(self.showTranslationOption == true)
	end
	self.modal.entry:focus()
	self.modal.maxChars = 45
	if self.mapUI.joyfocus then
		self.mapUI.joyfocus.focus = self.modal
	end
end

function ISWorldMapSymbolTool_AddNote:render()
	if self.modal and self.modal:isReallyVisible() then
		self.symbolsUI:renderNoteBeingAddedOrEdited(self.modal)
	else
		local color = self.symbolsUI.currentColor
		local r,g,b = color:getR(),color:getG(),color:getB()
		if (self.symbolsUI.playerNum ~= 0) or (JoypadState.players[self.symbolsUI.playerNum+1] and not wasMouseActiveMoreRecentlyThanJoypad()) then
			self.mapUI.javaObject:DrawTextSdf(UIFont.SdfCaveat, getText("IGUI_Map_AddNote"), self.mapUI.width / 2, self.mapUI.height / 2,
					ISMap.SCALE * self.mapAPI:getWorldScale(), r, g, b, 1)
		else
			self.mapUI.javaObject:DrawTextSdf(UIFont.SdfCaveat, getText("IGUI_Map_AddNote"), self:getMouseX(), self:getMouseY(),
					ISMap.SCALE * self.mapAPI:getWorldScale(), r, g, b, 1)
		end
	end
end

function ISWorldMapSymbolTool_AddNote:onAddNote(button, playerNum)
	self.modal = nil
	if button.internal == "OK" then
		local text = string.trim(button.parent.entry:getText())
		if text == "" then return end
		local newNote = {}
		newNote.text = text
		newNote.x = self.symbolsUI.noteX
		newNote.y = self.symbolsUI.noteY
		newNote.r = button.parent.currentColor:getR()
		newNote.g = button.parent.currentColor:getG()
		newNote.b = button.parent.currentColor:getB()
		local textSymbol
		if button.parent:isTranslation() then
			textSymbol = self.symbolsAPI:addUntranslatedText(newNote.text, UIFont.SdfCaveat, newNote.x, newNote.y)
		else
			textSymbol = self.symbolsAPI:addTranslatedText(newNote.text, UIFont.SdfCaveat, newNote.x, newNote.y)
		end
		textSymbol:setRGBA(newNote.r, newNote.g, newNote.b, 1.0)
		textSymbol:setAnchor(0.0, 0.0)
		textSymbol:setScale(ISMap.SCALE)
		if self.symbolsUI.character then
			self.symbolsUI.character:playSoundLocal("MapAddNote")
		end
		-- Center on the edited symbol
		local isJoypad = JoypadState.players[self.symbolsUI.playerNum+1]
		if isJoypad then
			local width = getTextManager():MeasureStringX(UIFont.SdfCaveat, text) * ISMap.SCALE * self.mapAPI:getWorldScale()
			local height = FONT_HGT_HANDWRITTEN * ISMap.SCALE * self.mapAPI:getWorldScale()
			local uiX = self.mapAPI:worldToUIX(newNote.x, newNote.y) + width / 2
			local uiY = self.mapAPI:worldToUIY(newNote.x, newNote.y) + height / 2
			local worldX = self.mapAPI:uiToWorldX(uiX, uiY)
			local worldY = self.mapAPI:uiToWorldY(uiX, uiY)
			self.mapAPI:centerOn(worldX, worldY)
		end
	end
end

function ISWorldMapSymbolTool_AddNote:onJoypadDownInMap(button, joypadData)
	if button == Joypad.AButton then
		if self.mapAPI:getZoomF() > 16.5 then
			self.mapAPI:setZoom(16.5)
		end
		local uiX = self.mapUI.width / 2 + 150
		local uiY = self.mapUI.height / 2 + 200
		local worldX = self.mapAPI:uiToWorldX(uiX, uiY)
		local worldY = self.mapAPI:uiToWorldY(uiX, uiY)
		self.mapAPI:centerOn(worldX, worldY)
		self:addNote(uiX - 150 * 2, uiY - 200 * 2)
		self.modal.entry:onJoypadDown(Joypad.AButton, joypadData)
	end
end

function ISWorldMapSymbolTool_AddNote:getJoypadAButtonText()
	return getText("IGUI_Map_AddNote")
end

function ISWorldMapSymbolTool_AddNote:new(symbolsUI)
	local o = ISWorldMapSymbolTool.new(self, symbolsUI)
	return o
end

-----

ISWorldMapSymbolTool_EditNote = ISWorldMapSymbolTool:derive("ISWorldMapSymbolTool_EditNote")

function ISWorldMapSymbolTool_EditNote:activate()
end

function ISWorldMapSymbolTool_EditNote:deactivate()
	if self.modal then
		self.modal.no:forceClick()
		self.modal = nil
	end
end

function ISWorldMapSymbolTool_EditNote:onMouseDown(x, y)
	if not self.symbolsUI.mouseOverNote then return false end
	if self.modal then return end
	self:editNote(x, y)
	return true
end

function ISWorldMapSymbolTool_EditNote:editNote(x, y)
	local symbol = self.symbolsAPI:getSymbolByIndex(self.symbolsUI.mouseOverNote)
	symbol:setVisible(false) -- HIDE THE SYMBOL BEING EDITED
	local uiX = symbol:getDisplayX()
	local uiY = symbol:getDisplayY()
	self.symbolsUI.noteX = self.mapAPI:uiToWorldX(uiX, uiY)
	self.symbolsUI.noteY = self.mapAPI:uiToWorldY(uiX, uiY)
	local mx = self.mapUI:getAbsoluteX() + uiX
	local my = self.mapUI:getAbsoluteY() + uiY + FONT_HGT_HANDWRITTEN * ISMap.SCALE * self.mapAPI:getWorldScale()
	local playerNum = self.symbolsUI.character and self.symbolsUI.playerNum or nil
	local isTranslation = symbol:getUntranslatedText() ~= nil
	local text = symbol:getUntranslatedText() or symbol:getTranslatedText()
	self.modal = ISTextBoxMap:new(mx, my, 350, 180, getText("IGUI_Map_EditNote"), text, self, self.onEditNote, playerNum, symbol)
	self.modal:initialise()
	self.modal.noEmpty = true
	self.modal:addToUIManager()
	self.modal:setAlwaysOnTop(true)
	self.modal:selectColor(symbol:getRed(), symbol:getGreen(), symbol:getBlue())
	if self.symbolsUI.showTranslationOption then
		self.modal:showTranslationTickBox(isTranslation)
	end
	self.modal.entry:focus()
	self.modal.maxChars = 45
	if self.mapUI.joyfocus then
		self.mapUI.joyfocus.focus = self.modal
	end
end

function ISWorldMapSymbolTool_EditNote:onMouseUp(x, y)
	return false
end

function ISWorldMapSymbolTool_EditNote:render()
	if self.modal == nil then
		self.symbolsUI:checkTextForEditMouse()
		self.symbolsUI:checkTextForEditJoypad()
	end
	self.symbolsUI:renderNoteBeingAddedOrEdited(self.modal)
end

function ISWorldMapSymbolTool_EditNote:onEditNote(button, symbol)
	self.modal = nil
	symbol:setVisible(true) -- SHOW THE SYMBOL BEING EDITED
	if button.internal == "OK" then
		local text = string.trim(button.parent.entry:getText())
		if text == "" then return end
		symbol:setPosition(self.symbolsUI.noteX, self.symbolsUI.noteY)
		local color = button.parent.currentColor
		symbol:setRGBA(color:getR(), color:getG(), color:getB(), 1.0)
		if button.parent:isTranslation() then
			symbol:setUntranslatedText(text)
		else
			symbol:setTranslatedText(text)
		end
		if self.symbolsUI.character then
			self.symbolsUI.character:playSoundLocal("MapAddNote")
		end
		if isClient() then
			self.symbolsUI.symbolsAPI:sendModifySymbol(symbol)
		end
	end
	-- Center on the edited symbol
	local isJoypad = JoypadState.players[self.symbolsUI.playerNum+1]
	if isJoypad then
		local uiX = symbol:getDisplayX() + symbol:getDisplayWidth() / 2
		local uiY = symbol:getDisplayY() + symbol:getDisplayHeight() / 2
		local worldX = self.mapAPI:uiToWorldX(uiX, uiY)
		local worldY = self.mapAPI:uiToWorldY(uiX, uiY)
		self.mapAPI:centerOn(worldX, worldY)
	end
end

function ISWorldMapSymbolTool_EditNote:onJoypadDownInMap(button, joypadData)
	if button == Joypad.AButton then
		if self.symbolsUI.mouseOverNote then
			if self.mapAPI:getZoomF() > 16.5 then
				self.mapAPI:setZoom(16.5)
			end
			local symbol = self.symbolsAPI:getSymbolByIndex(self.symbolsUI.mouseOverNote)
			local uiX = symbol:getDisplayX() + 150
			local uiY = symbol:getDisplayY() + 200
			local worldX = self.mapAPI:uiToWorldX(uiX, uiY)
			local worldY = self.mapAPI:uiToWorldY(uiX, uiY)
			self.mapAPI:centerOn(worldX, worldY)
			self:editNote(self.mapUI.width / 2, self.mapUI.height / 2)
			self.modal.entry:onJoypadDown(Joypad.AButton, joypadData)
		end
	end
end

function ISWorldMapSymbolTool_EditNote:getJoypadAButtonText()
	if self.symbolsUI.mouseOverNote then
		return getText("IGUI_Map_EditNote")
	end
	return nil
end

function ISWorldMapSymbolTool_EditNote:new(symbolsUI)
	local o = ISWorldMapSymbolTool.new(self, symbolsUI)
	return o
end

-----

ISWorldMapSymbolTool_MoveAnnotation = ISWorldMapSymbolTool:derive("ISWorldMapSymbolTool_MoveAnnotation")

function ISWorldMapSymbolTool_MoveAnnotation:activate()
end

function ISWorldMapSymbolTool_MoveAnnotation:deactivate()
	if self.dragging then
		self.dragging:setPosition(self.originalX, self.originalY)
		self.dragging = nil
	end
end

function ISWorldMapSymbolTool_MoveAnnotation:onMouseDown(x, y)
	local index = self.symbolsUI.mouseOverNote or self.symbolsUI.mouseOverSymbol
	if not index then return false end
	self.dragging = self.symbolsAPI:getSymbolByIndex(index)
	self.originalX = self.dragging:getWorldX()
	self.originalY = self.dragging:getWorldY()
	self.deltaX = self.originalX - self.mapAPI:uiToWorldX(x, y)
	self.deltaY = self.originalY - self.mapAPI:uiToWorldY(x, y)
	return true
end

function ISWorldMapSymbolTool_MoveAnnotation:onMouseUp(x, y)
	if self.dragging then
		if isClient() and self.dragging:isShared() then
			self.symbolsAPI:sendModifySymbol(self.dragging)
			self.dragging:setPosition(self.originalX, self.originalY)
		end
		self.dragging = nil
		if self.symbolsUI.character then
			self.symbolsUI.character:playSoundLocal("MapAddSymbol")
		end
		return true
	end
	return false
end

function ISWorldMapSymbolTool_MoveAnnotation:onMouseMove(dx, dy)
	if not self.dragging then return false end
	local x = self.mapAPI:uiToWorldX(self:getMouseX(), self:getMouseY())
	local y = self.mapAPI:uiToWorldY(self:getMouseX(), self:getMouseY())
	self.dragging:setPosition(x + self.deltaX, y + self.deltaY)
	return true
end

function ISWorldMapSymbolTool_MoveAnnotation:onRightMouseDown(x, y)
	return self:cancelDrag()
end

function ISWorldMapSymbolTool_MoveAnnotation:onKeyPress(key)
	if key == Keyboard.KEY_ESCAPE then
		return self:cancelDrag()
	end
	return false
end

function ISWorldMapSymbolTool_MoveAnnotation:onKeyRelease(key)
	if key == Keyboard.KEY_ESCAPE then -- Actually controller 'B' button
		return self:cancelDrag()
	end
	return false
end

function ISWorldMapSymbolTool_MoveAnnotation:cancelDrag()
	if not self.dragging then return false end
	self.dragging:setPosition(self.originalX, self.originalY)
	self.dragging = nil
	return true
end

function ISWorldMapSymbolTool_MoveAnnotation:render()
	self.symbolsUI:checkAnnotationForMoveMouse()
	self.symbolsUI:checkAnnotationForMoveJoypad()

	if self.dragging then
		-- Using a controller.
		if (self.symbolsUI.playerNum == 0) and (not JoypadState.players[self.symbolsUI.playerNum+1] or wasMouseActiveMoreRecentlyThanJoypad()) then return end
		local x = self.mapAPI:uiToWorldX(self.mapUI.width / 2, self.mapUI.height / 2)
		local y = self.mapAPI:uiToWorldY(self.mapUI.width / 2, self.mapUI.height / 2)
		self.dragging:setPosition(x + self.deltaX, y + self.deltaY)
	end
end

function ISWorldMapSymbolTool_MoveAnnotation:onJoypadDownInMap(button, joypadData)
	if button == Joypad.AButton then
		if self.dragging then
			if isClient() and self.dragging:isShared() then
				self.symbolsAPI:sendModifySymbol(self.dragging)
			end
			self.dragging = nil
			if self.symbolsUI.character then
				self.symbolsUI.character:playSoundLocal("MapAddSymbol")
			end
			return
		end
		local index = self.symbolsUI.mouseOverNote or self.symbolsUI.mouseOverSymbol
		if not index then return end
		self.dragging = self.symbolsAPI:getSymbolByIndex(index)
		self.originalX = self.dragging:getWorldX()
		self.originalY = self.dragging:getWorldY()
		local x,y = self.mapUI.width / 2, self.mapUI.height / 2
		self.deltaX = self.originalX - self.mapAPI:uiToWorldX(x, y)
		self.deltaY = self.originalY - self.mapAPI:uiToWorldY(x, y)
	end
end

function ISWorldMapSymbolTool_MoveAnnotation:getJoypadAButtonText()
	if self.dragging then
		return getText("IGUI_Map_PlaceSymbol")
	end
	if self.symbolsUI.mouseOverNote or self.symbolsUI.mouseOverSymbol then
		return getText("IGUI_Map_MoveElement")
	end
	return nil
end

function ISWorldMapSymbolTool_MoveAnnotation:new(symbolsUI)
	local o = ISWorldMapSymbolTool.new(self, symbolsUI)
	return o
end

-----

ISWorldMapSymbolTool_RemoveAnnotation = ISWorldMapSymbolTool:derive("ISWorldMapSymbolTool_RemoveAnnotation")

function ISWorldMapSymbolTool_RemoveAnnotation:activate()
end

function ISWorldMapSymbolTool_RemoveAnnotation:deactivate()
end

function ISWorldMapSymbolTool_RemoveAnnotation:onMouseDown(x, y)
	return self:removeAnnotation()
end

function ISWorldMapSymbolTool_RemoveAnnotation:onMouseUp(x, y)
	return false
end

function ISWorldMapSymbolTool_RemoveAnnotation:render()
	self.symbolsUI:checkAnnotationForRemoveMouse()
	self.symbolsUI:checkAnnotationForRemoveJoypad()
end

function ISWorldMapSymbolTool_RemoveAnnotation:onJoypadDownInMap(button, joypadData)
	if button == Joypad.AButton then
		self:removeAnnotation()
	end
end

function ISWorldMapSymbolTool_RemoveAnnotation:getJoypadAButtonText()
	if self.symbolsUI.mouseOverNote or self.symbolsUI.mouseOverSymbol then
		return getText("IGUI_Map_RemoveElement")
	end
	return nil
end

function ISWorldMapSymbolTool_RemoveAnnotation:removeAnnotation()
	-- TODO: UNDO remove marking
	if self.symbolsUI.mouseOverNote then
		self.symbolsAPI:removeSymbolByIndex(self.symbolsUI.mouseOverNote)
		self.symbolsUI.mouseOverNote = nil
		if self.symbolsUI.character then
			self.symbolsUI.character:playSoundLocal("MapRemoveMarking")
		end
		return true
	end
	if self.symbolsUI.mouseOverSymbol then
		if isClient() then
			local symbol = self.symbolsAPI:getSymbolByIndex(self.symbolsUI.mouseOverSymbol)
			if symbol:isShared() then
				self.symbolsAPI:sendRemoveSymbol(symbol)
				return true
			end
		end
		self.symbolsAPI:removeSymbolByIndex(self.symbolsUI.mouseOverSymbol)
		self.symbolsUI.mouseOverSymbol = nil
		if self.symbolsUI.character then
			self.symbolsUI.character:playSoundLocal("MapRemoveMarking")
		end
		return true
	end
	return false
end

function ISWorldMapSymbolTool_RemoveAnnotation:new(symbolsUI)
	local o = ISWorldMapSymbolTool.new(self, symbolsUI)
	return o
end

-----

ISWorldMapSymbolTool_Sharing = ISWorldMapSymbolTool:derive("ISWorldMapSymbolTool_Sharing")

function ISWorldMapSymbolTool_Sharing:activate()
	self.mapAPI:setBoolean("DimUnsharedSymbols", true)
end

function ISWorldMapSymbolTool_Sharing:deactivate()
	self.mapAPI:setBoolean("DimUnsharedSymbols", false)
	if self.propertiesUI and self.propertiesUI:isVisible() then
		self.propertiesUI:close()
	end
end

function ISWorldMapSymbolTool_Sharing:onMouseDown(x, y)
	local result = self:showPropertiesUI()
	local joypadData = JoypadState.players[self.mapUI.playerNum+1]
	if joypadData and self.propertiesUI and self.propertiesUI:isVisible() then
		joypadData.focus = self.propertiesUI
	end
	return result
end

function ISWorldMapSymbolTool_Sharing:onMouseUp(x, y)
	return false
end

function ISWorldMapSymbolTool_Sharing:render()
	if self.propertiesUI and self.propertiesUI:isVisible() and self.propertiesUI.currentSymbol and self.propertiesUI.currentSymbol then
		self.symbolsUI:renderSymbolOutline(self.propertiesUI.currentSymbol, 0.5, 0.5, 0.5)
	end
	self.symbolsUI:checkAnnotationForSharingMouse()
	self.symbolsUI:checkAnnotationForSharingJoypad()
end

function ISWorldMapSymbolTool_Sharing:showPropertiesUI()
	self.symbolsUI:checkAnnotationForSharingMouse()
	self.symbolsUI:checkAnnotationForSharingJoypad()
	if self.symbolsUI.mouseOverNote or self.symbolsUI.mouseOverSymbol then
		if not self.propertiesUI then
			self.propertiesUI = ISWorldMapSharing:new(self.mapUI)
			self.mapUI:addChild(self.propertiesUI)
		end
		if not self.propertiesUI:isVisible() then
			self.propertiesUI:setVisible(true)
			self.mapUI:addChild(self.propertiesUI)
		end
		if self.symbolsUI.mouseOverNote then
			local symbol = self.symbolsAPI:getSymbolByIndex(self.symbolsUI.mouseOverNote)
			self.propertiesUI:setCurrentSymbol(symbol)
		end
		if self.symbolsUI.mouseOverSymbol then
			local symbol = self.symbolsAPI:getSymbolByIndex(self.symbolsUI.mouseOverSymbol)
			self.propertiesUI:setCurrentSymbol(symbol)
		end
		return true
	end
	return false
end

function ISWorldMapSymbolTool_Sharing:onJoypadDownInMap(button, joypadData)
	if button == Joypad.AButton then
		self:showPropertiesUI()
		if self.propertiesUI and self.propertiesUI:isVisible() then
			setJoypadFocus(joypadData.player, self.propertiesUI)
		end
	end
end

function ISWorldMapSymbolTool_Sharing:getJoypadAButtonText()
	if self.symbolsUI.mouseOverNote or self.symbolsUI.mouseOverSymbol then
		return getText("IGUI_Map_Sharing")
	end
	return nil
end

function ISWorldMapSymbolTool_Sharing:new(symbolsUI)
	local o = ISWorldMapSymbolTool.new(self, symbolsUI)
	return o
end

-----

ISWorldMapSymbolsTabPanel = ISTabPanel:derive("ISWorldMapSymbolsTabPanel")

function ISWorldMapSymbolsTabPanel:render()
	ISTabPanel.render(self)
	if self.joypadFocused then
		self:drawRectBorder(0, -self:getYScroll(), self:getWidth(), self:getHeight(), 0.4, 0.2, 1.0, 1.0)
		self:drawRectBorder(1, 1-self:getYScroll(), self:getWidth()-2, self:getHeight()-2, 0.4, 0.2, 1.0, 1.0)
	end
	local view = self:getActiveView()
	if view.joyfocus then
		self:drawRectBorder(view.x + 0, view.y, view:getWidth(), view:getHeight(), 0.4, 0.2, 1.0, 1.0)
		self:drawRectBorder(view.x + 1, view.y + 1, view:getWidth()-2, view:getHeight()-2, 0.4, 0.2, 1.0, 1.0)
	end
end

function ISWorldMapSymbolsTabPanel:onJoypadDown(button, joypadData)
	if button == Joypad.AButton then
		setJoypadFocus(joypadData.player, self:getActiveView())
	end
	if button == Joypad.LBumper or button == Joypad.RBumper then
		local viewIndex = self:getActiveViewIndex()
		local view = self.viewList[viewIndex].view
		local setFocus = view.joyfocus
		if button == Joypad.LBumper then
			if viewIndex == 1 then
				viewIndex = #self.viewList
			else
				viewIndex = viewIndex - 1
			end
		elseif button == Joypad.RBumper then
			if viewIndex == #self.viewList then
				viewIndex = 1
			else
				viewIndex = viewIndex + 1
			end
		end
		self:activateView(self.viewList[viewIndex].name)
		if setFocus then
			setJoypadFocus(joypadData.player, self:getActiveView())
		end
	end
end

function ISWorldMapSymbolsTabPanel:setJoypadFocused(focused)
	self.joypadFocused = focused;
end

function ISWorldMapSymbolsTabPanel:new(x, y, width, height, symbolsUI)
	local o = ISTabPanel.new(self, x, y, width, height)
	o.symbolsUI = symbolsUI
	return o
end

-----

function ISWorldMapSymbols:createChildren()
	local btnWid = self.width - UI_BORDER_SPACING*2-2
	local btnWidCol = (self.width - UI_BORDER_SPACING*6-2)/5
	local btnHgt = BUTTON_HGT
	local btnPad = UI_BORDER_SPACING
	local columns = 8

	self:populateSymbolList()

	self.colorButtonInfo = {
        { item="Pen", colorInfo=ColorInfo.new(0.129, 0.129, 0.129, 1), tooltip=getText("Tooltip_Map_NeedBlackPen") },
        { item="Pencil", colorInfo=ColorInfo.new(0.2, 0.2, 0.2, 1), tooltip=getText("Tooltip_Map_NeedPencil") },
        { item="RedPen", colorInfo=ColorInfo.new(0.65, 0.054, 0.054, 1), tooltip=getText("Tooltip_Map_NeedRedPen") },
        { item="BluePen", colorInfo=ColorInfo.new(0.156, 0.188, 0.49, 1), tooltip=getText("Tooltip_Map_NeedBluePen") },
		{ item="GreenPen", colorInfo=ColorInfo.new(0.06, 0.39, 0.17, 1), tooltip=getText("Tooltip_Map_NeedGreenPen") },
	}

	self.colorButtons = {}
	local buttonX = UI_BORDER_SPACING+1
	local buttonY = UI_BORDER_SPACING*2 + FONT_HGT_MEDIUM +1
	local column = 0
	local colorButtons = {}
	for _,info in ipairs(self.colorButtonInfo) do
		local colorBtn = ISButton:new(buttonX, buttonY, btnWidCol, btnHgt, "", self, ISWorldMapSymbols.onButtonClick)
		colorBtn:initialise()
		colorBtn.internal = "COLOR"
		colorBtn.backgroundColor = {r=info.colorInfo:getR(), g=info.colorInfo:getG(), b=info.colorInfo:getB(), a=1}
		colorBtn.borderColor = {r=1, g=1, b=1, a=0.4}
		colorBtn.buttonInfo = info
		self:addChild(colorBtn)
		table.insert(self.colorButtons, colorBtn)
		table.insert(colorButtons, colorBtn)
		if #self.colorButtons == #self.colorButtonInfo then
			break
		end
		buttonX = buttonX + btnWidCol + btnPad
		column = column + 1
		if column == columns then
			buttonX = UI_BORDER_SPACING
			buttonY = buttonY + btnHgt + btnPad
			column = 0
			self:insertNewListOfButtons(colorButtons)
			colorButtons = {}
		end
	end

	if #colorButtons > 0 then
		self:insertNewListOfButtons(colorButtons)
	end

	local x = UI_BORDER_SPACING+1
	local y = buttonY + btnHgt + UI_BORDER_SPACING
	self.panel = ISWorldMapSymbolsTabPanel:new(x, y, self.width-x*2, BUTTON_HGT*8+UI_BORDER_SPACING*9+2, self);
	self.panel:initialise();
	self.panel.tabPadX = UI_BORDER_SPACING*2;
	self.panel.equalTabWidth = false;
	self:addChild(self.panel);

	local panelTabs = {}

	--detect all needed tabs
	for i,v in ipairs(self.symbolList) do
		local symbolDef = MapSymbolDefinitions.getInstance():getSymbolById(v)
		found = false
		for _, x in pairs(panelTabs) do
			if x == symbolDef:getTab() then
				found = true
			end
		end
		if not found then
			table.insert(panelTabs, symbolDef:getTab())
		end
	end

	--for each tab needed, fill it with the buttons in that tab
	for i,v in ipairs(panelTabs) do
		local tab = ISPanelJoypad:new(0, 0, self.panel.width, self.panel.height-BUTTON_HGT);
		tab.onJoypadDown = function(self, button, joypadData)
			if button == Joypad.BButton then
				setJoypadFocus(joypadData.player, self.parent.parent)
				return
			end
			if button == Joypad.LBumper or button == Joypad.RBumper then
				self.parent:onJoypadDown(button, joypadData)
				return
			end
			ISPanelJoypad.onJoypadDown(self, button, joypadData)
		end
		tab:initialise()
		tab.ID = panelTabs[i]
		self.panel:addView(getText("IGUI_Map_Tab"..panelTabs[i]), tab)

		local symbolButtons = {}
		column = 0
		x = UI_BORDER_SPACING+1
		y = UI_BORDER_SPACING+1
		for i,w in ipairs(self.symbolList) do
			local symbolDef = MapSymbolDefinitions.getInstance():getSymbolById(w)
			if symbolDef:getTab() == v then
				local symbolBtn = ISButton:new(x, y, btnHgt, btnHgt, "", self, ISWorldMapSymbols.onButtonClick)
				symbolBtn:initialise()
				symbolBtn:instantiate()
				symbolBtn.borderColor = {r=0, g=0, b=0, a=0}
				symbolBtn.backgroundColor = {r = 0.5, g = 0.5, b = 0.5, a = 1}
				symbolBtn.textureColor = {r = 0, g = 0, b = 0, a = 1}
				tab:addChild(symbolBtn)
				symbolBtn.image = getTexture(symbolDef:getTexturePath())
				symbolBtn.tex = w
				symbolBtn.symbol = true
				symbolBtn.tab = symbolDef:getTab()
				table.insert(self.buttonList, symbolBtn)
				table.insert(symbolButtons, self.buttonList[#self.buttonList])
				x = x + btnHgt + btnPad
				column = column + 1
				if column == columns then
					x = UI_BORDER_SPACING+1
					y = y + btnHgt + btnPad
					column = 0
					tab:insertNewListOfButtonsList(symbolButtons)
					symbolButtons = {}
				end
			end
		end

		if #symbolButtons > 0 then
			tab:insertNewListOfButtonsList(symbolButtons)
		end

		tab.joypadIndexY = math.floor(#tab.joypadButtonsY / 2)
		tab.joypadButtons = tab.joypadButtonsY[tab.joypadIndexY]
		tab.joypadIndex = math.ceil(#tab.joypadButtons / 2)
		tab.joypadButtons[tab.joypadIndex]:setJoypadFocused(true)
	end


	y = self.panel:getBottom() + UI_BORDER_SPACING+1

	self.blackColor = ColorInfo.new(0, 0, 0, 1)
	self.currentColor = self.blackColor

	btnPad = UI_BORDER_SPACING

	self.addNoteBtn = ISButton:new(UI_BORDER_SPACING+1, y, btnWid, btnHgt, getText("IGUI_Map_AddNote"), self, ISWorldMapSymbols.onButtonClick)
	self.addNoteBtn.internal = "ADDNOTE"
	self.addNoteBtn:initialise()
	self.addNoteBtn:instantiate()
	self.addNoteBtn.borderColor.a = 0.0
--	self.addNoteBtn.borderColor = {r=1, g=1, b=1, a=0.4}
	self:addChild(self.addNoteBtn)
	y = y + btnHgt + btnPad

	self.editNoteBtn = ISButton:new(UI_BORDER_SPACING+1, y, btnWid, btnHgt, getText("IGUI_Map_EditNote"), self, ISWorldMapSymbols.onButtonClick)
	self.editNoteBtn.internal = "EDITNOTE"
	self.editNoteBtn:initialise()
	self.editNoteBtn:instantiate()
	self.editNoteBtn.borderColor.a = 0.0
--	self.editNoteBtn.borderColor = {r=1, g=1, b=1, a=0.4}
	self:addChild(self.editNoteBtn)
	y = y + btnHgt + btnPad

	self.moveBtn = ISButton:new(UI_BORDER_SPACING+1, y, btnWid, btnHgt, getText("IGUI_Map_MoveElement"), self, ISWorldMapSymbols.onButtonClick)
	self.moveBtn.internal = "MOVE"
	self.moveBtn:initialise()
	self.moveBtn:instantiate()
	self.moveBtn.borderColor.a = 0.0
--	self.moveBtn.borderColor = {r=1, g=1, b=1, a=0.4}
	self:addChild(self.moveBtn)
	y = y + btnHgt + btnPad

	self.removeBtn = ISButton:new(UI_BORDER_SPACING+1, y, btnWid, btnHgt, getText("IGUI_Map_RemoveElement"), self, ISWorldMapSymbols.onButtonClick)
	self.removeBtn.internal = "REMOVE"
	self.removeBtn:initialise()
	self.removeBtn:instantiate()
	self.removeBtn.borderColor.a = 0.0
--	self.removeBtn.borderColor = {r=1, g=1, b=1, a=0.4}
	self:addChild(self.removeBtn)
	y = y + btnHgt + btnPad

	if isClient() then
		self.sharingBtn = ISButton:new(UI_BORDER_SPACING+1, y, btnWid, btnHgt, getText("IGUI_Map_Sharing"), self, ISWorldMapSymbols.onButtonClick)
		self.sharingBtn.internal = "SHARE"
		self.sharingBtn:initialise()
		self.sharingBtn:instantiate()
		self.sharingBtn.borderColor.a = 0.0
	--	self.sharingBtn.borderColor = {r=1, g=1, b=1, a=0.4}
		self:addChild(self.sharingBtn)
	end

	self:insertNewLineOfButtons(self.panel)
	self:insertNewLineOfButtons(self.addNoteBtn)
	self:insertNewLineOfButtons(self.editNoteBtn)
	self:insertNewLineOfButtons(self.moveBtn)
	self:insertNewLineOfButtons(self.removeBtn)
	if self.sharingBtn then
		self:insertNewLineOfButtons(self.sharingBtn)
		self:setHeight(self.sharingBtn:getBottom() + UI_BORDER_SPACING+1)
	else
		self:setHeight(self.removeBtn:getBottom() + UI_BORDER_SPACING+1)
	end

	self:initTools()

	self:checkInventory()
end

function ISWorldMapSymbols:checkInventory()
	local inv = self.character and self.character:getInventory() or nil
	local currentEnabled = nil
	local firstEnabled = nil
	local illiterate =  self.character and  self.character:getTraits():isIlliterate()
	for _,colorBtn in ipairs(self.colorButtons) do
		colorBtn.enable = (inv == nil) or inv:containsTagRecurse(colorBtn.buttonInfo.item) or inv:containsTypeRecurse(colorBtn.buttonInfo.item)
		colorBtn.borderColor.a = 0.4 -- not selected
		if colorBtn.enable then
			firstEnabled = firstEnabled or colorBtn
			if colorBtn.buttonInfo.colorInfo:equals(self.currentColor) then
				currentEnabled = colorBtn
				colorBtn.borderColor.a = 1.0
			end
			colorBtn.tooltip = nil
		else
			colorBtn.tooltip = colorBtn.buttonInfo.tooltip
		end
	end
	if not currentEnabled then
		if firstEnabled ~= nil then
			firstEnabled.borderColor.a = 1.0 -- selected
			self.currentColor = firstEnabled.buttonInfo.colorInfo
		else
			self.currentColor = self.blackColor
		end
	end
	self:updateSymbolColors()
	local canWrite = self:canWrite()
	for _,symbolButton in ipairs(self.buttonList) do
		symbolButton.enable = canWrite
		if canWrite then
			symbolButton.tooltip = nil
		else
			symbolButton.tooltip = getText("Tooltip_Map_CantWrite")
		end
	end
	local canErase = self:canErase()
	self.addNoteBtn.enable = canWrite
	self.editNoteBtn.enable = canWrite and canErase
	self.moveBtn.enable = canWrite and canErase
	self.removeBtn.enable = canErase

	if canWrite then
		self.addNoteBtn.tooltip = nil
	else
		self.addNoteBtn.tooltip = getText("Tooltip_Map_CantWrite")
	end

	if canWrite and canErase then
		self.editNoteBtn.tooltip = nil
		self.moveBtn.tooltip = nil
	else
		self.editNoteBtn.tooltip = getText("Tooltip_Map_CantEdit")
		self.moveBtn.tooltip = getText("Tooltip_Map_CantEdit")
	end
	-- illiterate  characters cannot read or write notes
	if illiterate then
		self.addNoteBtn.tooltip = getText("ContextMenu_Illiterate")
		self.addNoteBtn.enable = false
		self.editNoteBtn.tooltip = getText("ContextMenu_Illiterate")
		self.editNoteBtn.enable= false
	end

	if canErase then
		self.removeBtn.tooltip = nil
	else
		self.removeBtn.tooltip = getText("Tooltip_Map_CantErase")
	end

	if self.currentTool == self.tools.AddSymbol and not canWrite then
		self:setCurrentTool(nil)
	end
	if self.currentTool == self.tools.AddNote and not canWrite then
		self:setCurrentTool(nil)
	end
	if self.currentTool == self.tools.EditNote and not (canWrite and canErase) then
		self:setCurrentTool(nil)
	end
	if self.currentTool == self.tools.MoveAnnotation and not (canWrite and canErase) then
		self:setCurrentTool(nil)
	end
	if self.currentTool == self.tools.RemoveAnnotation and not canErase then
		self:setCurrentTool(nil)
	end
end

function ISWorldMapSymbols:canWrite()
	if not self.character then return true end
	local inv = self.character:getInventory()
	for _,info in ipairs(self.colorButtonInfo) do
		if inv:containsTagRecurse(info.item) or inv:containsTypeRecurse(info.item) then
			return true
		end
	end
	return false
end

function ISWorldMapSymbols:canErase()
	if not self.character then return true end
	local inv = self.character:getInventory()
	return (inv == nil) or inv:containsTypeRecurse("Base.Eraser") or inv:containsTagRecurse("Eraser")
end

function ISWorldMapSymbols:initTools()
	self.tools = {}
	self.tools.AddSymbol = ISWorldMapSymbolTool_AddSymbol:new(self)
	self.tools.AddNote = ISWorldMapSymbolTool_AddNote:new(self)
	self.tools.EditNote = ISWorldMapSymbolTool_EditNote:new(self)
	self.tools.MoveAnnotation = ISWorldMapSymbolTool_MoveAnnotation:new(self)
	self.tools.RemoveAnnotation = ISWorldMapSymbolTool_RemoveAnnotation:new(self)
	if isClient() then
		self.tools.Sharing = ISWorldMapSymbolTool_Sharing:new(self)
	end
end

function ISWorldMapSymbols:setCurrentTool(tool)
	if tool == self.currentTool then return end
	if self.currentTool then
		self.currentTool:deactivate()
	end
	self.currentTool = tool
	if self.currentTool then
		self.currentTool:activate()
	end
end

function ISWorldMapSymbols:toggleTool(tool)
	if self.currentTool == tool then
		self:setCurrentTool(nil)
	else
		self:setCurrentTool(tool)
	end
end

function ISWorldMapSymbols:populateSymbolList()
	local numSymbols = MapSymbolDefinitions.getInstance():getSymbolCount()
	for i=1,numSymbols do
		local symbolDef = MapSymbolDefinitions.getInstance():getSymbolByIndex(i-1)
		table.insert(self.symbolList, symbolDef:getId())
	end
end

function ISWorldMapSymbols:prerenderMap()
	if self.currentTool then
		self.currentTool:render()
	end
end

function ISWorldMapSymbols:prerender()
	ISPanelJoypad.prerender(self)
	self:drawText(getText("IGUI_Map_MapSymbol"), self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_Map_MapSymbol")) / 2), UI_BORDER_SPACING+1, 1,1,1,1, UIFont.Medium)

	if self:canWrite() ~= self.wasCanWrite or self:canErase() ~= self.wasCanErase then
		self.wasCanWrite = self:canWrite()
		self.wasCanErase = self:canErase()
		self:checkInventory()
	end

	self.addNoteBtn.borderColor.a = (self.currentTool == self.tools.AddNote) and 1 or 0
	self.editNoteBtn.borderColor.a = (self.currentTool == self.tools.EditNote) and 1 or 0
	self.moveBtn.borderColor.a = (self.currentTool == self.tools.MoveAnnotation) and 1 or 0
	self.removeBtn.borderColor.a = (self.currentTool == self.tools.RemoveAnnotation) and 1 or 0
	if self.sharingBtn then
		self.sharingBtn.borderColor.a = (self.currentTool == self.tools.Sharing) and 1 or 0
	end
end

function ISWorldMapSymbols:render()
	ISPanelJoypad.render(self)
	if self.selectedSymbol and self.selectedSymbol.tab == self.panel:getActiveView().ID then
		self.panel:getActiveView():drawRectBorder(self.selectedSymbol.x - 1, self.selectedSymbol.y - 1, self.selectedSymbol.width + 1, self.selectedSymbol.height + 1, 1, 1, 1, 1)
	end
	if self.joyfocus then
		self:drawRectBorder(2, 2, self:getWidth()-2*2, self:getHeight()-2*2, 1.0, 1.0, 1.0, 1.0);
		self:drawRectBorder(3, 3, self:getWidth()-3*2, self:getHeight()-3*2, 1.0, 1.0, 1.0, 1.0);
	end
end

function ISWorldMapSymbols:renderSymbol(symbol, x, y)
	if not symbol then return end
	local scale = ISMap.SCALE * self.mapAPI:getWorldScale()
	local sym = symbol
	local symW = 20 / 2 * scale
	local symH = 20 / 2 * scale
	self.mapUI.javaObject:DrawSymbol(sym.image, x-symW, y-symH,
		20 * scale, 20 * scale,
		1, sym.textureColor.r, sym.textureColor.g, sym.textureColor.b)
end

function ISWorldMapSymbols:renderNoteBeingAddedOrEdited(modal)
	if not modal or not modal:isReallyVisible() then
		return
	end
	local mx = modal.x - self.mapUI:getAbsoluteX()
	local my = modal.y - self.mapUI:getAbsoluteY() - FONT_HGT_HANDWRITTEN * ISMap.SCALE * self.mapAPI:getWorldScale()
	self.noteX = self.mapAPI:uiToWorldX(mx, my)
	self.noteY = self.mapAPI:uiToWorldY(mx, my)
	local color = modal.currentColor
	local r,g,b = color:getR(),color:getG(),color:getB()
	local text = modal.entry:getText()
	if OnScreenKeyboard.IsVisible() then
		text = OnScreenKeyboard.GetCurrentText()
	end
	if modal:isTranslation() then
		text = getText(text)
	end
	self.mapUI.javaObject:DrawTextSdf(UIFont.SdfCaveat, text,
			self.mapAPI:worldToUIX(self.noteX, self.noteY), self.mapAPI:worldToUIY(self.noteX, self.noteY),
			ISMap.SCALE * self.mapAPI:getWorldScale(), r, g, b, 1)
end

function ISWorldMapSymbols:onMouseDownMap(x, y)
	if self.currentTool then
		return self.currentTool:onMouseDown(x, y)
	end
	return false
end

function ISWorldMapSymbols:onMouseUpMap(x, y)
	if self.currentTool then
		return self.currentTool:onMouseUp(x, y)
	end
	return false
end

function ISWorldMapSymbols:onMouseMoveMap(x, y)
	if self.currentTool then
		return self.currentTool:onMouseMove(x, y)
	end
	return false
end

function ISWorldMapSymbols:onRightMouseDownMap(x, y)
	self.ignoreRightMouseUp = false
	if self.currentTool then
		self.ignoreRightMouseUp = self.currentTool:onRightMouseDown(x, y)
	end
	return false
end

function ISWorldMapSymbols:onRightMouseUpMap(x, y)
	if self.currentTool then
		return self.currentTool:onRightMouseUp(x, y) or self.ignoreRightMouseUp
	end
	return self.ignoreRightMouseUp
end

function ISWorldMapSymbols:onButtonClick(button)
	if button.symbol then
		if self.selectedSymbol == button then
			self.selectedSymbol = nil
			self:setCurrentTool(nil)
			return
		end
		self.selectedSymbol = button
		self:setCurrentTool(self.tools.AddSymbol)
		if self.panel:getActiveView().joyfocus then
			button:setJoypadFocused(false)
			setJoypadFocus(self.playerNum, self.mapUI)
		end
	end
	if button.internal == "COLOR" then
		for _,colorBtn in ipairs(self.colorButtons) do
			colorBtn.borderColor.a = 0.4
		end
		button.borderColor = {r=1, g=1, b=1, a=1}
		self.currentColor = button.buttonInfo.colorInfo
		self:updateSymbolColors()
	end
	if button.internal == "ADDNOTE" then
		self.selectedSymbol = nil
		self:toggleTool(self.tools.AddNote)
		if self.joyfocus then
			button:setJoypadFocused(false)
			setJoypadFocus(self.playerNum, self.mapUI)
		end
	end
	if button.internal == "EDITNOTE" then
		self.selectedSymbol = nil
		self:toggleTool(self.tools.EditNote)
		if self.joyfocus then
			button:setJoypadFocused(false)
			setJoypadFocus(self.playerNum, self.mapUI)
		end
	end
	if button.internal == "MOVE" then
		self.selectedSymbol = nil
		self:toggleTool(self.tools.MoveAnnotation)
		if self.joyfocus then
			button:setJoypadFocused(false)
			setJoypadFocus(self.playerNum, self.mapUI)
		end
	end
	if button.internal == "REMOVE" then
		self.selectedSymbol = nil
		self:toggleTool(self.tools.RemoveAnnotation)
		if self.joyfocus then
			button:setJoypadFocused(false)
			setJoypadFocus(self.playerNum, self.mapUI)
		end
	end
	if button.internal == "SHARE" then
		self.selectedSymbol = nil
		self:toggleTool(self.tools.Sharing)
		if self.joyfocus then
			button:setJoypadFocused(false)
			setJoypadFocus(self.playerNum, self.mapUI)
		end
	end
end

function ISWorldMapSymbols:isKeyConsumed(key)
	if key == Keyboard.KEY_ESCAPE then
		if self.currentTool then return true end
	end
	return self.currentTool and self.currentTool:isKeyConsumed(key)
end

function ISWorldMapSymbols:onKeyPress(key)
	self.keyPressConsumed = false
	if self.currentTool and self.currentTool:onKeyPress(key) then
		self.keyPressConsumed = true
		return true
	end
	if key == Keyboard.KEY_ESCAPE then
		if self.currentTool then
			self:setCurrentTool(nil)
			self.selectedSymbol = nil
			self.keyPressConsumed = true
			return true
		end
	end
	return false
end

function ISWorldMapSymbols:onKeyRelease(key)
	if self.currentTool and self.currentTool:onKeyRelease(key) then
		return true
	end
	if self.keyPressConsumed == true then
		return true
	end
	if key == Keyboard.KEY_ESCAPE then
		if self.currentTool then
			self:setCurrentTool(nil)
			self.selectedSymbol = nil
			return true
		end
	end
	return false
end

function ISWorldMapSymbols:undisplay()
	if self.currentTool then
		self:setCurrentTool(nil)
		self.selectedSymbol = nil
	end
end

function ISWorldMapSymbols:updateSymbolColors()
	local r = self.currentColor:getR()
	local g = self.currentColor:getG()
	local b = self.currentColor:getB()
	for i,v in ipairs(self.buttonList) do
		v.textureColor = {r = r, g = g, b = b, a = 1}
	end
end

local function filterAny(symbol)
	if isClient() and not symbol:canClientModify() then return false end
	return symbol ~= nil
end

local function filterShare(symbol)
	return symbol ~= nil
end

local function filterText(symbol)
	if isClient() and not symbol:canClientModify() then return false end
	return symbol ~= nil and symbol:isText()
end

local function filterTexture(symbol)
	if isClient() and not symbol:canClientModify() then return false end
	return symbol ~= nil and symbol:isTexture()
end

function ISWorldMapSymbols:checkAnnotationForMoveMouse()
	if (self.playerNum ~= 0) or (JoypadState.players[self.playerNum+1] and not wasMouseActiveMoreRecentlyThanJoypad()) then return end
	self:hitTestAnnotations(self.mapUI:getMouseX(), self.mapUI:getMouseY(), "move", filterAny)
end

function ISWorldMapSymbols:checkAnnotationForMoveJoypad()
	if (self.playerNum == 0) and (JoypadState.players[self.playerNum+1] == nil or wasMouseActiveMoreRecentlyThanJoypad()) then return end
	self:hitTestAnnotations(self.mapUI.width / 2, self.mapUI.height / 2, "move", filterAny)
end

function ISWorldMapSymbols:checkAnnotationForRemoveMouse()
	if (self.playerNum ~= 0) or (JoypadState.players[self.playerNum+1] and not wasMouseActiveMoreRecentlyThanJoypad()) then return end
	self:hitTestAnnotations(self.mapUI:getMouseX(), self.mapUI:getMouseY(), "remove", filterAny)
end

function ISWorldMapSymbols:checkAnnotationForRemoveJoypad()
	if (self.playerNum == 0) and (JoypadState.players[self.playerNum+1] == nil or wasMouseActiveMoreRecentlyThanJoypad()) then return end
	self:hitTestAnnotations(self.mapUI.width / 2, self.mapUI.height / 2, "remove", filterAny)
end

function ISWorldMapSymbols:checkTextForEditMouse()
	if (self.playerNum ~= 0) or (JoypadState.players[self.playerNum+1] and not wasMouseActiveMoreRecentlyThanJoypad()) then return end
	self:hitTestAnnotations(self.mapUI:getMouseX(), self.mapUI:getMouseY(), "edit", filterText)
end

function ISWorldMapSymbols:checkTextForEditJoypad()
	if (self.playerNum == 0) and (JoypadState.players[self.playerNum+1] == nil or wasMouseActiveMoreRecentlyThanJoypad()) then return end
	self:hitTestAnnotations(self.mapUI.width / 2, self.mapUI.height / 2, "edit", filterText)
end

function ISWorldMapSymbols:checkAnnotationForSharingMouse()
	if (self.playerNum ~= 0) or (JoypadState.players[self.playerNum+1] and not wasMouseActiveMoreRecentlyThanJoypad()) then return end
	self:hitTestAnnotations(self.mapUI:getMouseX(), self.mapUI:getMouseY(), "share", filterShare)
end

function ISWorldMapSymbols:checkAnnotationForSharingJoypad()
	if (self.playerNum == 0) and (JoypadState.players[self.playerNum+1] == nil or wasMouseActiveMoreRecentlyThanJoypad()) then return end
	self:hitTestAnnotations(self.mapUI.width / 2, self.mapUI.height / 2, "share", filterShare)
end

function ISWorldMapSymbols:hitTestAnnotations(x, y, mode, filter)
	self.mouseOverNote = nil
	self.mouseOverSymbol = nil
	local hitIndex = self.symbolsAPI:hitTest(x, y)
	if hitIndex == -1 then return end
	local symbol = self.symbolsAPI:getSymbolByIndex(hitIndex)
	if not filter(symbol) then return end
	if symbol:isText() then
		self.mouseOverNote = hitIndex
	elseif symbol:isTexture() then
		self.mouseOverSymbol = hitIndex
	end
	local r,g,b = 0,0,1
	if mode == "remove" then
		r,g,b = 1,0,0
	end
	self:renderSymbolOutline(symbol, r, g, b)
end

function ISWorldMapSymbols:renderSymbolOutline(symbol, r, g, b)
	local x = symbol:getDisplayX()
	local y = symbol:getDisplayY()
	local w = symbol:getDisplayWidth()
	local h = symbol:getDisplayHeight()

	local x1 = math.floor(x)
	local y1 = math.floor(y)
	local x2 = math.ceil(x + w)
	local y2 = math.ceil(y + h)
	x = x1
	y = y1
	w = x2 - x1
	h = y2 - y1

	self.mapUI:drawRectBorder(x - 1, y - 1, w + 2, h + 2, 1, r, g, b)
	self.mapUI:drawRectBorder(x - 2, y - 2, w + 4, h + 4, 1, r, g, b)
end

function ISWorldMapSymbols:onGainJoypadFocus(joypadData)
	ISPanelJoypad.onGainJoypadFocus(self, joypadData)
	self.joypadIndexY = 2
	self.joypadButtons = self.joypadButtonsY[self.joypadIndexY]
	self.joypadIndex = 1
	self.joypadButtons[self.joypadIndex]:setJoypadFocused(true)
--	self.removeBtn:setJoypadButton(Joypad.Texture.XButton)
end

function ISWorldMapSymbols:onLoseJoypadFocus(joypadData)
	ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
	self:clearJoypadFocus(joypadData)
end

function ISWorldMapSymbols:onJoypadDown(button, joypadData)
	ISPanelJoypad.onJoypadDown(self, button)
--[[
	if button == Joypad.XButton then
		self:onButtonClick(self.removeBtn)
	end
--]]
	if button == Joypad.BButton then
		self:undisplay()
		self:setVisible(false)
		setJoypadFocus(joypadData.player, self.mapUI)
		return
	end
	local child = self:getJoypadFocus()
	if child == self.panel then
		self.panel:onJoypadDown(button, joypadData)
		return
	end
end

function ISWorldMapSymbols:onJoypadDownInMap(button, joypadData)
	if self.currentTool then
		self.currentTool:onJoypadDownInMap(button, joypadData)
	end
end

function ISWorldMapSymbols:getJoypadAButtonText()
	if self.currentTool then
		return self.currentTool:getJoypadAButtonText()
	end
	return nil
end

function ISWorldMapSymbols:new(x, y, width, height, mapUI)
	local o = ISPanelJoypad.new(self, x, y, width, height)
	o.borderColor = {r=0.4, g=0.4, b=0.4, a=1}
	o.backgroundColor = {r=0, g=0, b=0, a=0.8}
	o.selectedSymbol = nil
	o.symbolList = {}
	o.mapUI = mapUI -- ISUIElement with javaObject=UIWorldMap
	o.mapAPI = mapUI.javaObject:getAPIv2()
	o.symbolsAPI = o.mapAPI:getSymbolsAPIv2()
	o.buttonList = {}
	o.character = mapUI.character
	o.playerNum = mapUI.playerNum or 0
	o.textCursor = getTexture("media/ui/LootableMaps/textCursor.png")
	o.symbolTexList = {}
	o.showTranslationOption = false
	return o
end

function ISWorldMapSymbols.RequiredWidth()
	return BUTTON_HGT*8+UI_BORDER_SPACING*11+2
end

