--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

-- This is a table of functions to make PZAPI widgets work with a controller.
-- Possibly this would be better implemented in AtomExtensions.lua.

ISAtomUIJoypad = {}

function ISAtomUIJoypad:getUIName(name)
	if self.javaObj == nil then
		self:instantiate()
	end
	return self.javaObj:getUIName()
end

function ISAtomUIJoypad:toString()
	local name = self:getUIName()
	if name == "" then return self._ATOM_UI_CLASS.class:getSimpleName()..'('..tostring(self)..')' end
	return name
end

function ISAtomUIJoypad:isVisible()
	return self.javaObj ~= nil and self.javaObj:isVisible()
end

function ISAtomUIJoypad:onGainJoypadFocus(joypadData)
	self.joyfocus = joypadData
end

function ISAtomUIJoypad:onLoseJoypadFocus(joypadData)
	self:setJoypadFocused(false, joypadData)
	self.joyfocus = nil
end

function ISAtomUIJoypad:setJoypadFocused(focused, joypadData)
	self.joypadFocused = focused;
end

function ISAtomUIJoypad:onJoypadDown(button, joypadData)
	if self.parent then
		self.parent:onJoypadDown_Descendant(self, button, joypadData)
	end
end

function ISAtomUIJoypad:onJoypadButtonReleased(button, joypadData)
	if self.parent then
		self.parent:onJoypadButtonReleased_Descendant(self, button, joypadData)
	end
end


function ISAtomUIJoypad:onJoypadDirUp(joypadData)
	if self.parent then
		self.parent:onJoypadDirUp_Descendant(self, joypadData)
	end
end

function ISAtomUIJoypad:onJoypadDirDown(joypadData)
	if self.parent then
		self.parent:onJoypadDirDown_Descendant(self, joypadData)
	end
end

function ISAtomUIJoypad:onJoypadDirLeft(joypadData)
	if self.parent then
		self.parent:onJoypadDirLeft_Descendant(self, joypadData)
	end
end

function ISAtomUIJoypad:onJoypadDirRight(joypadData)
	if self.parent then
		self.parent:onJoypadDirRight_Descendant(self, joypadData)
	end
end

function ISAtomUIJoypad:onJoypadDown_Descendant(descendant, button, joypadData)
	if self.parent then
		self.parent:onJoypadDown_Descendant(descendant, button, joypadData)
	end
end

function ISAtomUIJoypad:onJoypadButtonReleased_Descendant(descendant, button, joypadData)
	if self.parent then
		self.parent:onJoypadButtonReleased_Descendant(self, button, joypadData)
	end
end

function ISAtomUIJoypad:onJoypadDirUp_Descendant(descendant, joypadData)
	if self.parent then
		self.parent:onJoypadDirUp_Descendant(descendant, joypadData)
	end
end

function ISAtomUIJoypad:onJoypadDirDown_Descendant(descendant, joypadData)
	if self.parent then
		self.parent:onJoypadDirDown_Descendant(descendant, joypadData)
	end
end

function ISAtomUIJoypad:onJoypadDirLeft_Descendant(descendant, joypadData)
	if self.parent then
		self.parent:onJoypadDirLeft_Descendant(descendant, joypadData)
	end
end

function ISAtomUIJoypad:onJoypadDirRight_Descendant(descendant, joypadData)
	if self.parent then
		self.parent:onJoypadDirRight_Descendant(descendant, joypadData)
	end
end

function ISAtomUIJoypad:onJoypadBeforeDeactivate(joypadData)
	if self.parent then
		self.parent:onJoypadBeforeDeactivate_Descendant(self, joypadData)
	end
end

function ISAtomUIJoypad:onJoypadBeforeDeactivate_Descendant(descendant, joypadData)
	if self.parent then
		self.parent:onJoypadBeforeDeactivate_Descendant(descendant, joypadData)
	end
end

function ISAtomUIJoypad:hasConflictWithJoypadNavigateStart()
	return false
end

function ISAtomUIJoypad:getJoypadNavigateStartDelay()
	if self:hasConflictWithJoypadNavigateStart() then
		-- This UIElement supports joypad navigation, but uses the same button as the one used to
		-- initiate joypad navigation (currently RBumper).  In these cases, releasing RBumper before
		-- this many milliseconds should initiate some action, such as switching tabs.
		return 250
	end
	return 0
end

function ISAtomUIJoypad:onJoypadNavigateStart(joypadData)
	if self.parent then
		self.parent:onJoypadNavigateStart_Descendant(self, joypadData)
	end
end

function ISAtomUIJoypad:onJoypadNavigateEnd(joypadData)
	if joypadData.focus and joypadData.focus.joypadFocused then
		joypadData.focus:setJoypadFocused(false, joypadData)
	end
	self:setJoypadFocused(true, joypadData)
	if joypadData.focus ~= self then
		joypadData.focus = self
	end
end

function ISAtomUIJoypad:onJoypadNavigateUp(joypadData)
	if self.joypadNavigate and self.joypadNavigate.up then
		joypadData.currentNavigateUI = self.joypadNavigate.up
	end
end

function ISAtomUIJoypad:onJoypadNavigateDown(joypadData)
	if self.joypadNavigate and self.joypadNavigate.down then
		joypadData.currentNavigateUI = self.joypadNavigate.down
	end
end

function ISAtomUIJoypad:onJoypadNavigateLeft(joypadData)
	if self.joypadNavigate and self.joypadNavigate.left then
		joypadData.currentNavigateUI = self.joypadNavigate.left
	end
end

function ISAtomUIJoypad:onJoypadNavigateRight(joypadData)
	if self.joypadNavigate and self.joypadNavigate.right then
		joypadData.currentNavigateUI = self.joypadNavigate.right
	end
end

function ISAtomUIJoypad:onJoypadNavigateParent(joypadData)
	if self.joypadNavigate and self.joypadNavigate.parent then
		joypadData.currentNavigateUI = self.joypadNavigate.parent
	end
end

function ISAtomUIJoypad:onJoypadNavigateStart_Descendant(descendant, joypadData)
	if self.parent then
		self.parent:onJoypadNavigateStart_Descendant(descendant, joypadData)
	end
end

function ISAtomUIJoypad.Apply(ui)
	for k,v in pairs(ISAtomUIJoypad) do
		if v ~= ISAtomUIJoypad.Apply then
			ui[k] = v
		end
	end
end