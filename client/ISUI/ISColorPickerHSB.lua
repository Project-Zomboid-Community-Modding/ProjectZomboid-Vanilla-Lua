require"ISUI/ISPanelJoypad"

ISColorPickerHSB = ISPanelJoypad:derive("ISColorPickerHSB");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local COLORBOX_HGT = 206
local CURRENTCOLOR_WID = UI_BORDER_SPACING*2
local SCROLL_BAR_WID = 150
local SCROLL_BAR_LABEL_WID = math.max(
		getTextManager():MeasureStringX(UIFont.Small, getText("UI_characreation_colorpicker_hue")),
		getTextManager():MeasureStringX(UIFont.Small, getText("UI_characreation_colorpicker_saturation")),
		getTextManager():MeasureStringX(UIFont.Small, getText("UI_characreation_colorpicker_brightness"))
	)
local BTN_WIDTH = UI_BORDER_SPACING*2 +	getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_Keyboard_Accept"))


function ISColorPickerHSB:createChildren()
	local x = UI_BORDER_SPACING + 1;
	local x2 = SCROLL_BAR_LABEL_WID + UI_BORDER_SPACING + x;
	self.colorBlockX = x2 + UI_BORDER_SPACING + SCROLL_BAR_WID;
	local y = UI_BORDER_SPACING + 1;
	self.colorBlockY = y

		
    local label = ISLabel:new(x, y, FONT_HGT_SMALL, getText("UI_characreation_colorpicker_hue"), 1, 1, 1, 1.0, UIFont.Small, true);
    label:initialise();
    label:instantiate();
	self:addChild(label);
	
	self.hueSlider = ISSliderPanel:new(x2, y, SCROLL_BAR_WID, BUTTON_HGT, self, ISColorPickerHSB.onSliderChange);
	self.hueSlider:initialise();
    self.hueSlider:instantiate();
	self.hueSlider:setValues( 0.0, 1.0, 0.01 )
	self.hueSlider:setCurrentValue( self.h, true )
    self.hueSlider.valueLabel = false;
    self:addChild(self.hueSlider);
	
	local y = y + BUTTON_HGT + UI_BORDER_SPACING;
	
    local label = ISLabel:new(x, y, FONT_HGT_SMALL, getText("UI_characreation_colorpicker_saturation"), 1, 1, 1, 1.0, UIFont.Small, true);
    label:initialise();
    label:instantiate();
	self:addChild(label);	
	
	self.satSlider = ISSliderPanel:new(x2, y, SCROLL_BAR_WID, BUTTON_HGT, self, ISColorPickerHSB.onSliderChange);
	self.satSlider:initialise();
    self.satSlider:instantiate();
	self.satSlider:setValues( 0.0, 1.0, 0.01 )
	self.satSlider:setCurrentValue( self.s, true )
    self.satSlider.valueLabel = false;
    self:addChild(self.satSlider);
	
	y = y + BUTTON_HGT + UI_BORDER_SPACING;
	
	local label = ISLabel:new(x, y, FONT_HGT_SMALL, getText("UI_characreation_colorpicker_brightness"), 1, 1, 1, 1.0, UIFont.Small, true);
    label:initialise();
    label:instantiate();
	self:addChild(label);

	self.valSlider = ISSliderPanel:new(x2, y, SCROLL_BAR_WID, BUTTON_HGT, self, ISColorPickerHSB.onSliderChange);
	self.valSlider:initialise();
    self.valSlider:instantiate();
	self.valSlider:setValues( 0.0, 1.0, 0.01 )
	self.valSlider:setCurrentValue( self.b, true )
    self.valSlider.valueLabel = false;
    self:addChild(self.valSlider);

	local buttonAccept = ISButton:new(x, self.height - UI_BORDER_SPACING - BUTTON_HGT - 1, BTN_WIDTH, BUTTON_HGT, getText("IGUI_Keyboard_Accept"), self, self.onSave)
	buttonAccept:enableAcceptColor()
	self:addChild(buttonAccept)
end

function ISColorPickerHSB:toHSB(Color)
	local r1 = Color:getR();
	local g1 = Color:getG();
	local b1 = Color:getB();
	
	local cMax = math.max(r1, g1, b1);
	local cMin = math.min(r1, g1, b1);
	local delta = cMax - cMin;
	
	local hue;
	if delta == 0 then
		hue = 0;
	elseif cMax == r1 then
		hue = 60 * ((g1 - b1) / delta);
	elseif cMax == g1 then
		hue = 60 * (((b1 - r1) / delta) + 2)	
	elseif cMax == b1 then
		hue = 60 * (((r1 - g1) / delta) + 4)
	end
	hue = math.fmod(1 + hue / 360, 1)
	local lightness = cMax;
	local saturation;
	if delta == 0 then
		saturation = 0;
	else
		saturation = delta / cMax;
	end
	
	return hue, saturation, lightness;
end

function ISColorPickerHSB:render()
	local r, g, b = self.currentColor:getRedFloat(), self.currentColor:getGreenFloat(), self.currentColor:getBlueFloat();
	local r2, g2, b2 = self.initialColor:getRedFloat(), self.initialColor:getGreenFloat(), self.initialColor:getBlueFloat();
	ISPanelJoypad.render(self)

	self:drawRectBorder(self.colorBlockX, UI_BORDER_SPACING + 1, COLORBOX_HGT, COLORBOX_HGT, 1, 1, 1, 1) --color box outline
	local hueRGB = Color.HSBtoRGB(self.h, 1, 1);
	self:drawTextureScaled(self.HueImage, self.colorBlockX+1, UI_BORDER_SPACING + 2, COLORBOX_HGT-2, COLORBOX_HGT-2, 1, hueRGB:getRedFloat(), hueRGB:getGreenFloat(), hueRGB:getBlueFloat());
	self:drawTextureScaled(self.SatImage, self.colorBlockX+1, UI_BORDER_SPACING + 2, COLORBOX_HGT-2, COLORBOX_HGT-2, 1, 1, 1, 1);

	self:drawRect(self.colorBlockX + COLORBOX_HGT + UI_BORDER_SPACING, UI_BORDER_SPACING + 1, CURRENTCOLOR_WID, COLORBOX_HGT, 1, r, g, b) --selected color box inside
	self:drawRectBorder(self.colorBlockX + COLORBOX_HGT + UI_BORDER_SPACING, UI_BORDER_SPACING + 1, CURRENTCOLOR_WID, COLORBOX_HGT, 1, 1, 1, 1) --selected color box outline

	--color cursor - shows where the selected color is in the HSL slice
	local cursorWH = 15 --make sure this is ODD
	local cursorX = self.colorBlockX + 1 +(COLORBOX_HGT-3)*self.s
	local cursorY = UI_BORDER_SPACING + 2 + (COLORBOX_HGT-3)*(1-self.b)
	self:drawRectBorder(cursorX-(cursorWH-1)/2, cursorY-(cursorWH-1)/2, cursorWH, cursorWH, 1, 1, 1, 1)
	self:drawRectBorder(cursorX-(cursorWH-3)/2, cursorY-(cursorWH-3)/2, cursorWH-2, cursorWH-2, 1, 0, 0, 0)
	self:drawRect(cursorX-(cursorWH-5)/2, cursorY-(cursorWH-5)/2, cursorWH-4, cursorWH-4, 1, r, g, b)
		
	if self.joyfocus then
		self:drawRectBorder(0, -self:getYScroll(), self:getWidth(), self:getHeight(), 0.4, 0.2, 1.0, 1.0);
		self:drawRectBorder(1, 1-self:getYScroll(), self:getWidth()-2, self:getHeight()-2, 0.4, 0.2, 1.0, 1.0);

		local s,b = self.s, self.b
		local rate = 0.1 * UIManager.getMillisSinceLastRender() * (1 / 180)
		local axisX = getJoypadAimingAxisX(self.joyfocus.id)
		local axisY = getJoypadAimingAxisY(self.joyfocus.id)
		if axisX < -0.5 then
			s = math.max(0, s - rate)
		elseif axisX > 0.5 then
			s = math.min(1, s + rate)
		end
		if axisY < -0.5 then
			b = math.min(1, b + rate)
		elseif axisY > 0.5 then
			b = math.max(0, b - rate)
		end
		if s ~= self.s or b ~= self.b then
			self:setCurrentColor(self.h, s, b)
		end
	end
end

function ISColorPickerHSB:onSliderChange(value, slider)
	if self.hueSlider == slider then
		self.h = value;
	elseif self.satSlider == slider then
		self.s = value;		
	else
		self.b = value;
	end
	self.currentColor = Color.HSBtoRGB(self.h, self.s, self.b);
	self.pickedRGB.r = self.currentColor:getRedFloat();
	self.pickedRGB.g = self.currentColor:getGreenFloat();	
	self.pickedRGB.b = self.currentColor:getBlueFloat();
end

function ISColorPickerHSB:onMouseDown(x, y)
    if self:isCapture() and not self:isMouseOver() then
        self:onMouseDownOutside(x, y)
        return
    end
	if x > self.colorBlockX and x < (self.colorBlockX + COLORBOX_HGT) and y > UI_BORDER_SPACING + 1 and y < (UI_BORDER_SPACING + COLORBOX_HGT) then
		self.mouseDownInColorBox = true;
		self:onMouseDownColorBox(x, y)
	end
	self.mouseDown = true
	self:onMouseMove(0, 0)
	return true
end

function ISColorPickerHSB:onMouseDownOutside(x, y)
	if x < 0 or y < 0 or x > self.width or y > self.height then
		self:removeSelf()
	end
	return true
end

function ISColorPickerHSB:onSave()
	if self.pickedFunc then
		self.pickedFunc(self.pickedTarget, self.pickedRGB, false, self.pickedArgs[1], self.pickedArgs[2], self.pickedArgs[3], self.pickedArgs[4])
	end
	return true
end

function ISColorPickerHSB:onMouseMove(dx, dy)
	if self.mouseDownInColorBox then
		self:onMouseDownColorBox(self:getMouseX() + dx, self:getMouseY() + dy)
	end

    --if self.otherFct then return true; end
	if not self.mouseDown then return true end
	--[[
	local x = self:getMouseX()
	local y = self:getMouseY()

	local col = math.floor((x - self.borderSize) / self.buttonSize)
	local row = math.floor((y - self.borderSize) / self.buttonSize)
	if col < 0 then col = 0 end
	if col >= self.columns then col = self.columns - 1 end
	if row < 0 then row = 0 end
	if row >= self.rows then row = self.rows - 1 end
	local index = col + row * self.columns + 1
	if index == self.index then return true end
	self.index = index
		]]--
end

function ISColorPickerHSB:onMouseDownColorBox(x, y)
	x = math.max(x, self.colorBlockX + 1)
	x = math.min(x, self.colorBlockX + COLORBOX_HGT - 1)
	y = math.max(y, UI_BORDER_SPACING + 2)
	y = math.min(y, UI_BORDER_SPACING + COLORBOX_HGT - 1)

	local s = (x - self.colorBlockX) / (COLORBOX_HGT-2);
	local b = 1 - (y - self.colorBlockY) / (COLORBOX_HGT-2);
	self:setCurrentColor(self.h, s, b);
end


function ISColorPickerHSB:onMouseUp(x, y)
	if self.mouseDown then
		self.mouseDown = false
		self.mouseDownInColorBox = false
		--[[
        if self.otherFct then
		    self:picked2(true)
        else
            self:picked(true)
        end
		]]--
	end
	return true
end

function ISColorPickerHSB:picked2(hide)
--[[
    if hide then
        self:removeSelf()
    end
    local x = self:getMouseX()
    local y = self:getMouseY()
    local col = math.floor((x - self.borderSize) / self.buttonSize)
    local row = math.floor((y - self.borderSize) / self.buttonSize)
    if col < 0 then col = 0 end
    if col >= self.columns then col = self.columns - 1 end
    if row < 0 then row = 0 end
    if row >= self.rows then row = self.rows - 1 end
    self.index = col + row * self.columns + 1
		]]--
    if self.pickedFunc then
        self.pickedFunc(self.pickedTarget, self.pickedRGB, false, self.pickedArgs[1], self.pickedArgs[2], self.pickedArgs[3], self.pickedArgs[4])
    end

end

function ISColorPickerHSB:onMouseUpOutside(x, y)
	return self:onMouseUp(x, y)
end

function ISColorPickerHSB:onGainJoypadFocus(joypadData)
	ISPanelJoypad.onGainJoypadFocus(self, joypadData)
	self.joypadIndexY = 1
	self.joypadIndex = 1
	self.joypadButtonsY = {}
	self.joypadButtons = {}
	self:insertNewLineOfButtons(self.hueSlider)
	self:insertNewLineOfButtons(self.satSlider)
	self:insertNewLineOfButtons(self.valSlider)
	self:restoreJoypadFocus(joypadData)
end

function ISColorPickerHSB:onLoseJoypadFocus(joypadData)
	ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
	self:clearJoypadFocus(joypadData)
end

function ISColorPickerHSB:onJoypadDown(button)
	if button == Joypad.AButton then
		self:picked(true)
	end
	if button == Joypad.BButton then
		self:removeSelf()
	end
end

function ISColorPickerHSB:removeSelf()
	if self.parent then
		self.parent:removeChild(self)
	else
		self:removeFromUIManager()
	end
	if self.joyfocus then
		self.joyfocus.focus = self.resetFocusTo
	end
end

function ISColorPickerHSB:picked(hide)
	if hide then
		self:removeSelf()
	end
	if self.pickedFunc then
		self.pickedFunc(self.pickedTarget, self.pickedRGB, mouseUp, self.pickedArgs[1], self.pickedArgs[2], self.pickedArgs[3], self.pickedArgs[4])
	end
end

function ISColorPickerHSB:setInitialColor(initial)
	self.initialColor = initial:toColor();
	self.currentColor = initial:toColor();
	self.pickedRGB.r = self.currentColor:getRedFloat();
	self.pickedRGB.g = self.currentColor:getGreenFloat();
	self.pickedRGB.b = self.currentColor:getBlueFloat();
	self.h, self.s, self.b = ISColorPickerHSB:toHSB(initial:toColor());
	if self.valSlider then
		self.hueSlider:setCurrentValue( self.h, true )
		self.satSlider:setCurrentValue( self.s, true )
		self.valSlider:setCurrentValue( self.b, true )
	end
end

function ISColorPickerHSB:setCurrentColor(h, s ,b)
	self.h, self.s, self.b = h, s, b;
	self.hueSlider:setCurrentValue( self.h, true )
	self.satSlider:setCurrentValue( self.s, true )
	self.valSlider:setCurrentValue( self.b, true )
	self.currentColor = Color.HSBtoRGB(self.h, self.s, self.b);
	self.pickedRGB.r = self.currentColor:getRedFloat();
	self.pickedRGB.g = self.currentColor:getGreenFloat();
	self.pickedRGB.b = self.currentColor:getBlueFloat();
end

function ISColorPickerHSB:setPickedFunc(func, arg1, arg2, arg3, arg4)
	self.pickedFunc = func
	self.pickedArgs = { arg1, arg2, arg3, arg3 }
end

function ISColorPickerHSB:new(x, y, initial)
	local buttonSize = BUTTON_HGT
	local borderSize = UI_BORDER_SPACING+1
	local width = SCROLL_BAR_WID + SCROLL_BAR_LABEL_WID + COLORBOX_HGT + CURRENTCOLOR_WID + UI_BORDER_SPACING*5 + 2
	local height = COLORBOX_HGT + UI_BORDER_SPACING*2 + 2
	local o = ISPanelJoypad.new(self, x, y, width, height)
	o.pickedRGB = { r = 0, g = 0, b = 0 };
	o.backgroundColor.a = 1
	o.borderSize = borderSize
	o.buttonSize = buttonSize
	o.pickedArgs = {}
	o.initialColor = initial;
	o.currentColor = initial;
	o.pickedRGB = { r = 0, g = 0, b = 0 };
	o.h = 0.0;
	o.s = 0.0;
	o.b = 0.0;
		if initial then
		o.initialColor = initial:toColor();
		o.currentColor = initial:toColor();
		o.pickedRGB.r = initial:getR();
		o.pickedRGB.g = initial:getG();	
		o.pickedRGB.b = initial:getB();
		o.h, o.s, o.b = ISColorPickerHSB:toHSB(initial:toColor());
	end
	o.HueImage = getTexture("media/ui/ColorPicker/ColorPicker_Hue.png");
	o.SatImage = getTexture("media/ui/ColorPicker/ColorPicker_Sat.png");

	return o
end
