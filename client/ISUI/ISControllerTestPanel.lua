--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISPanel"

ISControllerTestPanel = ISPanel:derive("ControllerTest")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local JOYPAD_TEX_SIZE = 32

local axisTextures = {
	Joypad.Texture.LStickLR,
	Joypad.Texture.LStickUD,
	Joypad.Texture.RStickLR,
	Joypad.Texture.RStickUD,
	Joypad.Texture.LTrigger,
	Joypad.Texture.RTrigger
}

local buttonTextures =
{
	Joypad.Texture.AButton,
	Joypad.Texture.BButton,
	Joypad.Texture.XButton,
	Joypad.Texture.YButton,
	Joypad.Texture.LBumper,
	Joypad.Texture.RBumper,
	Joypad.Texture.View,
	Joypad.Texture.Menu,
	getTexture("media/ui/inventoryPanes/Tickbox_Cross.png"), --placeholder image for unused button
	Joypad.Texture.LStick,
	Joypad.Texture.RStick,
	Joypad.Texture.DPadUp,
	Joypad.Texture.DPadRight,
	Joypad.Texture.DPadDown,
	Joypad.Texture.DPadLeft
}

function ISControllerTestPanel:onControllerSelected()
	JoypadState.controllerTest = false
	self.selectedController = nil
	local controller = self.combo:getOptionData(self.combo.selected)
	if controller < 0 or controller >= getControllerCount() then
		if self.mainOptions then
			self.mainOptions.labelJoypadSensitivity.name = getText("UI_optionscreen_select_gamepad")
			self.mainOptions.btnJoypadSensitivityP:setEnable(false)
			self.mainOptions.btnJoypadSensitivityM:setEnable(false)
		end
		return
	end
	self.selectedController = controller
	JoypadState.controllerTest = true

	self.axisLabelWid = getTextManager():MeasureStringX(UIFont.Small, getText("UI_ControllerTest_Axis", 9))
	self.buttonX = UI_BORDER_SPACING*2+1
	
	if self.mainOptions then
		local controller = self.selectedController
		if not controller then 
			self.mainOptions.btnJoypadSensitivityP:setEnable(false)
			self.mainOptions.btnJoypadSensitivityM:setEnable(false)
			return 
		end
		self.mainOptions.btnJoypadSensitivityP:setEnable(true)
		self.mainOptions.btnJoypadSensitivityM:setEnable(true)
		if getControllerAxisCount(controller)>0 then
			self.mainOptions.labelJoypadSensitivity.name=string.format("%.2f",getControllerDeadZone(controller, 0))
		end
	end
end

function ISControllerTestPanel:joypadSensitivityM()
	local controller = self.selectedController
	if not controller then return end
	local axisCount = getControllerAxisCount(controller)
	for i=1,axisCount do
		local deadZone = getControllerDeadZone(controller, i-1) - 0.05
		if deadZone<0 then
			deadZone = 0;
		end
		if deadZone>1 then
			deadZone = 1;
		end
		setControllerDeadZone(controller, i-1, deadZone)
	end
	self.mainOptions.labelJoypadSensitivity.name=string.format("%.2f",getControllerDeadZone(controller, 0))
	saveControllerSettings(controller)
end

function ISControllerTestPanel:joypadSensitivityP()
	local controller = self.selectedController
	if not controller then return end
	local axisCount = getControllerAxisCount(controller)
	for i=1,axisCount do
		local deadZone = getControllerDeadZone(controller, i-1) + 0.05
		if deadZone<0 then
			deadZone = 0;
		end
		if deadZone>1 then
			deadZone = 1;
		end
		setControllerDeadZone(controller, i-1, deadZone)
	end
	self.mainOptions.labelJoypadSensitivity.name=string.format("%.2f",getControllerDeadZone(controller, 0))
	saveControllerSettings(controller)
end

function ISControllerTestPanel:render()
	self.backgroundColor.a = 0.8

	local controller = self.selectedController
	if not controller then return end

	local barX = getTextManager():MeasureStringX(UIFont.Small, getText("UI_ControllerTest_Axis", 9)) + UI_BORDER_SPACING*2+1
	local axisY = self.combo:getBottom() + UI_BORDER_SPACING
	local barWid = 200
	local barHeight = math.max(JOYPAD_TEX_SIZE+UI_BORDER_SPACING, BUTTON_HGT)
	local axisCount = getControllerAxisCount(controller)
	for i=1,axisCount do
			self:drawText(getText("UI_ControllerTest_Axis", i-1), UI_BORDER_SPACING+1, axisY + (barHeight-FONT_HGT_SMALL)/2, 1, 1, 1, 1, UIFont.Small)
			local f = (1 + getControllerAxisValue(controller, i-1)) / 2
			self:drawProgressBar(barX, axisY, barWid, barHeight, f, { r=0.9,g=0.9,b=0.9,a=1 })
			local deadZone = getControllerDeadZone(controller, i-1)
			self:drawRect(barX + barWid / 2 - barWid / 2 * deadZone, axisY, barWid * deadZone, barHeight, 0.5, 0, 0, 1)
			self:drawTextureScaled(axisTextures[i], barX+barWid+UI_BORDER_SPACING, axisY + (barHeight-JOYPAD_TEX_SIZE)/2, JOYPAD_TEX_SIZE, JOYPAD_TEX_SIZE, 1)
			axisY = axisY + barHeight + UI_BORDER_SPACING
	end

	local isAY = 0
	local buttonX = self.buttonX
	local buttonY = axisY + UI_BORDER_SPACING
	local buttonWidth = JOYPAD_TEX_SIZE + UI_BORDER_SPACING*2 + BUTTON_HGT
	local buttonHeight = math.max(JOYPAD_TEX_SIZE+UI_BORDER_SPACING, BUTTON_HGT)
	local buttonCount = getControllerButtonCount(controller)
	buttonCount = math.min(buttonCount, 40)
	if buttonCount > 0 then
		self:drawText(getText("UI_ControllerTest_Buttons"), UI_BORDER_SPACING+1, buttonY, 1, 1, 1, 1, UIFont.Small)
	end
	buttonY = buttonY + self.smallFontHgt + UI_BORDER_SPACING
	local buttonsBottom = buttonY
	for i=1,buttonCount do
		if i ~= 9 then --hide the home button
			local r,g,b = 0.5,0.5,0.5
			if isJoypadPressed(controller,i-1) then
				self:drawRect(buttonX, buttonY, buttonWidth, buttonHeight, 1.0, 0.2, 0.2, 0.2)
				r,g,b = 0.9,0.9,0.9
				if i-1 == Joypad.AButton then
					isAY = isAY + 1
				end
				if i-1 == Joypad.YButton then
					isAY = isAY + 1
				end
			end
			self:drawRectBorder(buttonX, buttonY, buttonWidth, buttonHeight, 1.0, r, g, b)
			self:drawTextureScaled(buttonTextures[i], buttonX+UI_BORDER_SPACING, buttonY + (buttonHeight-JOYPAD_TEX_SIZE)/2, JOYPAD_TEX_SIZE, JOYPAD_TEX_SIZE, 1)
			self:drawTextCentre(tostring(i-1), buttonX+buttonWidth - BUTTON_HGT/2 - UI_BORDER_SPACING,
					buttonY - getTextManager():CentreStringYOffset(UIFont.Small, tostring(i-1)) + (buttonHeight-FONT_HGT_SMALL)/2, 1, 1, 1, 1, UIFont.Small)
			buttonsBottom = buttonY + buttonHeight
			buttonX = buttonX + buttonWidth + UI_BORDER_SPACING
			if buttonX > self.width - UI_BORDER_SPACING*2+1 - buttonWidth then
				buttonX = self.buttonX
				buttonY = buttonY + buttonHeight + UI_BORDER_SPACING
			end
		end
	end
	if isAY == 2 then
		JoypadState.controllerTest = false
	end

	if buttonCount > 0 then
		self:drawText(getText("UI_ControllerTest_Pov"), UI_BORDER_SPACING+1, buttonsBottom + 12, 1, 1, 1, 1, UIFont.Small)
		local povY = buttonsBottom + 12 + self.smallFontHgt + 8
		-----
		self:drawText(getText("UI_ControllerTest_PovX"), UI_BORDER_SPACING+1, povY, 1, 1, 1, 1, UIFont.Small)
		local f = (1 + getControllerPovX(controller)) / 2
		self:drawProgressBar(barX, povY, 200, BUTTON_HGT, f, { r=0.9,g=0.9,b=0.9,a=1 })
		povY = povY + BUTTON_HGT + UI_BORDER_SPACING
		-----
		self:drawText(getText("UI_ControllerTest_PovY"), UI_BORDER_SPACING+1, povY, 1, 1, 1, 1, UIFont.Small)
		local f = (1 + getControllerPovY(controller)) / 2
		self:drawProgressBar(barX, povY, 200, BUTTON_HGT, f, { r=0.9,g=0.9,b=0.9,a=1 })
		povY = povY + BUTTON_HGT + UI_BORDER_SPACING
		-----
		if JoypadState.controllerTest then
			self:drawText(getText("UI_ControllerTest_AY4exit"), UI_BORDER_SPACING+1, povY, 1, 0.2, 0.2, 1, UIFont.Small)
		end
	end
end

function ISControllerTestPanel:createChildren()
	local label = ISLabel:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, BUTTON_HGT, getText("UI_ControllerTest_Combo"), 1, 1, 1, 1, UIFont.Small, true)
	label:initialise()
	self:addChild(label)
	self.label = label

	local combo = ISComboBox:new(label:getRight() + UI_BORDER_SPACING, label.y, self.width - UI_BORDER_SPACING*2-1 - label:getRight(), BUTTON_HGT, self, self.onControllerSelected)
	combo:initialise()
	combo:setAnchorLeft(true)
	self:addChild(combo)
	self.combo = combo

	self:setControllerCombo()
end

function ISControllerTestPanel:setControllerCombo()
	self.combo:clear()
	self.combo:addOptionWithData(getText("UI_ControllerTest_None"), -1)
	for i=1,getControllerCount() do
		if isControllerConnected(i-1) then
			self.combo:addOptionWithData(getControllerName(i-1), i-1)
		end
	end
end

function ISControllerTestPanel:OnGamepadConnect(index)
	self:setControllerCombo()
end

function ISControllerTestPanel:OnGamepadDisconnect(index)
	JoypadState.controllerTest = false
	self:setControllerCombo()
end

function ISControllerTestPanel:onResolutionChange(oldw, oldh, neww, newh)
	self.combo:setWidth(self:getWidth() - UI_BORDER_SPACING*2-1 - self.label:getRight())
end

function ISControllerTestPanel:new(x, y, width, height)
	local o = ISPanel:new(x, y, width, height)
	setmetatable(o, self)
	self.__index = self
	o.axisY = {}
	o.smallFontHgt = getTextManager():getFontFromEnum(UIFont.Small):getLineHeight()
	return o
end

