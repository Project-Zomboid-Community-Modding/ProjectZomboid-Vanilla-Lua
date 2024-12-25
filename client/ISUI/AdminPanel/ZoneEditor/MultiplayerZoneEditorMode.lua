--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

MultiplayerZoneEditorMode = ISPanel:derive("MultiplayerZoneEditorMode")

function MultiplayerZoneEditorMode:display()
	self:setVisible(true)
end

function MultiplayerZoneEditorMode:undisplay()
	self:setVisible(false)
end

function MultiplayerZoneEditorMode:onMouseDown(x, y)
	return false -- allow clicks in the map
end

function MultiplayerZoneEditorMode:onMouseUp(x, y)
	return false -- allow clicks in the map
end

function MultiplayerZoneEditorMode:onMouseMove(dx, dy)
	return false -- allow clicks in the map
end

function MultiplayerZoneEditorMode:onMouseWheel(del)
	if self:isMouseOver() then
		local children = self:getChildren()
		for _,child in pairs(children) do
			if child:isMouseOver() then
				return false
			end
		end
		self.mapAPI:zoomAt(self:getMouseX(), self:getMouseY(), del)
	end
	return true
end

function MultiplayerZoneEditorMode:isKeyConsumed(key)
	return false
end

function MultiplayerZoneEditorMode:onKeyPress(key)
	return false
end

function MultiplayerZoneEditorMode:onKeyRelease(key)
	return false
end

function MultiplayerZoneEditorMode:new(editor)
	local o = ISPanel.new(self, 0, 0, editor.width, editor.height)
	o:setAnchorRight(true)
	o:setAnchorBottom(true)
	o:noBackground()
	o.editor = editor
	o.mapUI = editor
	o.mapAPI = editor.mapAPI
	o.styleAPI = editor.styleAPI
	o.symbolsAPI = editor.symbolsAPI
	return o
end

