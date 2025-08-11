--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

ISSetKeybindDialog = ISPanel:derive("ISSetKeybindDialog")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local LABEL_HGT = FONT_HGT_MEDIUM + 6

function ISSetKeybindDialog:createChildren()
	local btnWid = UI_BORDER_SPACING*2 + math.max(
			getTextManager():MeasureStringX(UIFont.Small, getText("UI_optionscreen_KeybindClear")),
			getTextManager():MeasureStringX(UIFont.Small, getText("UI_optionscreen_KeybindDefault")),
			getTextManager():MeasureStringX(UIFont.Small, getText("UI_Cancel"))
	)

	local actionName = getText("UI_optionscreen_binding_" .. self.keybindName):trim()
	if self.isModBind then actionName = getText(self.keybindName) end
	local text = getText("UI_optionscreen_pressKeyToBind", actionName)
	local label = ISLabel:new(0,UI_BORDER_SPACING+1, LABEL_HGT*2, text:gsub("\\n", "\n"):gsub("\\\"", "\""), 1, 1, 1, 1, UIFont.Medium, true)
	label.center = true
	label:initialise()
	self:addChild(label)

	self:setWidth(label:getWidth()+UI_BORDER_SPACING*2)
	label:setX(self.width / 2)
	self:setX((getCore():getScreenWidth() - self.width)/2)

	self.cancel = ISButton:new((self:getWidth() - btnWid) / 2, self.height - BUTTON_HGT - UI_BORDER_SPACING - 1,	btnWid, BUTTON_HGT, getText("UI_Cancel"), self, self.onCancel)
	self.cancel:initialise()
	self.cancel:instantiate()
	self.cancel.borderColor = {r=1, g=1, b=1, a=0.1}
	self:addChild(self.cancel)

	self.default = ISButton:new((self:getWidth() - btnWid) / 2, self.cancel.y - BUTTON_HGT - UI_BORDER_SPACING, btnWid, BUTTON_HGT, getText("UI_optionscreen_KeybindDefault"), self, self.onDefault)
	self.default:initialise()
	self.default:instantiate()
	self.default.borderColor = {r=1, g=1, b=1, a=0.1}
	self:addChild(self.default)
	
	self.clear = ISButton:new((self:getWidth() - btnWid) / 2, self.default.y - BUTTON_HGT - UI_BORDER_SPACING, btnWid, BUTTON_HGT, getText("UI_optionscreen_KeybindClear"), self, self.onClear)
	self.clear:initialise()
	self.clear:instantiate()
	self.clear.borderColor = {r=1, g=1, b=1, a=0.1}
	self:addChild(self.clear)
end

function ISSetKeybindDialog:destroy()
	MainOptions.setKeybindDialog = nil
	MainOptions.instance.cover:setVisible(false)
	self:setVisible(false)
	self:removeFromUIManager()
	GameKeyboard.setDoLuaKeyPressed(true)
end

function ISSetKeybindDialog:onCancel()
	self:destroy()
end

function ISSetKeybindDialog:onDefault()
	if self.isModBind then
		for i, v in ipairs(MainOptions.keyText) do
			if not v.value and (v.txt:getName() == getText(self.keybindName)) then
				if v.defaultKeyCode == 0 then -- no default keybind
					self:onClear()
				else
					MainOptions.keyPressHandler(v.defaultKeyCode)
				end
				break
			end
		end
	else
		for i,v in ipairs(keyBinding) do
			if v.value == self.keybindName then
				if v.key == 0 then -- no default keybind
					self:onClear()
				else
					MainOptions.keyPressHandler(v.key)
				end
				break
			end
		end
	end
end

function ISSetKeybindDialog:onClear()
	for i,v in ipairs(MainOptions.keyText) do
		if not v.value and (v.txt:getName() == self.keybindName) then
			v.keyCode = 0
			v.btn:setTitle(getKeyName(0))
			MainOptions.instance:onKeybindChanged(self.keybindName, 0)
			MainOptions.instance.gameOptions.changed = true
			self:destroy()
			break
		end
	end
end

function ISSetKeybindDialog:isKeyConsumed(key)
	return true
end

-- Extra mouse events, all buttons and not consumed by UIElements.
function ISSetKeybindDialog:onMouseButtonDown(btn)
	MainOptions.keyPressHandler(Mouse.BTN_OFFSET + btn)
end

function ISSetKeybindDialog:onKeyRelease(key)
	local isShiftDown = Keyboard.isKeyDown(Keyboard.KEY_LSHIFT) or Keyboard.isKeyDown(Keyboard.KEY_RSHIFT);
	local isCtrlDown = Keyboard.isKeyDown(Keyboard.KEY_LCONTROL) or Keyboard.isKeyDown(Keyboard.KEY_RCONTROL);
	local isAltDown = Keyboard.isKeyDown(Keyboard.KEY_LMENU) or Keyboard.isKeyDown(Keyboard.KEY_RMENU);
	-- only allow one modifier
	if isShiftDown and (isCtrlDown or isAltDown) then
		isCtrlDown = false;
		isAltDown = false;
	end
	if isCtrlDown and isAltDown then
		isAltDown = false;
	end
	MainOptions.keyPressHandler(key, isShiftDown, isCtrlDown, isAltDown)
end

function ISSetKeybindDialog:new(keybindName, isModBind)
	local width = 500
	local height = LABEL_HGT*2+BUTTON_HGT*3+UI_BORDER_SPACING*5+2
	local x = (getCore():getScreenWidth() - width) / 2
	local y = (getCore():getScreenHeight() - height) / 2
	local o = ISPanel:new(x, y, width, height)
	o.backgroundColor.a = 0.8
	setmetatable(o, self)
	self.__index = self
	o.keybindName = keybindName
	o.isModBind = isModBind
	o:setWantKeyEvents(true)
	o:setWantExtraMouseEvents(true) -- required to detect all mouse button clicks in a non-consumed way.
	return o
end

