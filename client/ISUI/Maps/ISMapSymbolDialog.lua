--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require('ISUI/ISCollapsableWindowJoypad')
require('ISUI/Maps/ISMapSymbolZoomPanel')

ISMapSymbolDialog = ISCollapsableWindowJoypad:derive("ISMapSymbolDialog");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10

function ISMapSymbolDialog:createChildren()
	local fontHgt = FONT_HGT_SMALL
	local buttonWid1 = getTextManager():MeasureStringX(UIFont.Small, "Ok") + 12
	local buttonWid2 = getTextManager():MeasureStringX(UIFont.Small, "Cancel") + 12
	local buttonWid = math.max(math.max(buttonWid1, buttonWid2), 100)
	local buttonHgt = math.max(fontHgt + 6, 25)
	local padBottom = 10
    local btnHgt2 = 20
    local btnPad = 5

    local inv = self.character and self.character:getInventory() or nil

    self.colorButtonInfo = {
        { item="Pen", colorInfo=ColorInfo.new(0.129, 0.129, 0.129, 1), tooltip=getText("Tooltip_Map_NeedBlackPen") },
        { item="Pencil", colorInfo=ColorInfo.new(0.2, 0.2, 0.2, 1), tooltip=getText("Tooltip_Map_NeedPencil") },
        { item="RedPen", colorInfo=ColorInfo.new(0.65, 0.054, 0.054, 1), tooltip=getText("Tooltip_Map_NeedRedPen") },
        { item="BluePen", colorInfo=ColorInfo.new(0.156, 0.188, 0.49, 1), tooltip=getText("Tooltip_Map_NeedBluePen") },
		{ item="GreenPen", colorInfo=ColorInfo.new(0.06, 0.39, 0.17, 1), tooltip=getText("Tooltip_Map_NeedGreenPen") },
    }

    if self.mapUI.javaObject:isMapEditor() then
        table.insert(self.colorButtonInfo, { item="White", colorInfo=ColorInfo.new(1.0, 1.0, 1.0, 1.0), tooltip="Editor Color" })
    end

    self.colorButtons = {}
    local buttonX = UI_BORDER_SPACING
    local buttonY = self:titleBarHeight() + UI_BORDER_SPACING
    local column = 0
    local columns = math.floor((self.width - UI_BORDER_SPACING * 2) / (btnHgt2 + btnPad))
    local colorButtons = {}
    for _,info in ipairs(self.colorButtonInfo) do
        local colorBtn = ISButton:new(buttonX, buttonY, btnHgt2, btnHgt2, "", self, ISMapSymbolDialog.onClick)
        colorBtn:initialise()
        colorBtn.internal = "COLOR"
        colorBtn.backgroundColor = {r=info.colorInfo:getR(), g=info.colorInfo:getG(), b=info.colorInfo:getB(), a=1}
        colorBtn.borderColor = {r=1, g=1, b=1, a=0.4}
        colorBtn.enable = (inv == nil) or inv:containsTagRecurse(info.item) or inv:containsTypeRecurse(info.item)
        if not colorBtn.enable then colorBtn.tooltip = info.tooltip end
        colorBtn.buttonInfo = info
        self:addChild(colorBtn)
        table.insert(self.colorButtons, colorBtn)
        table.insert(colorButtons, colorBtn)
        if #self.colorButtons == #self.colorButtonInfo then
            break
        end
        buttonX = buttonX + btnHgt2 + btnPad
        column = column + 1
        if column == columns then
            buttonX = UI_BORDER_SPACING
            buttonY = buttonY + btnHgt2 + btnPad
            column = 0
            self:insertNewListOfButtons(colorButtons)
            colorButtons = {}
        end
    end
    if #colorButtons then
        self:insertNewListOfButtons(colorButtons)
    end
    
    self.blackColor = ColorInfo.new(0, 0, 0, 1)
    self.currentColor = self.blackColor
    for _,colorBtn in ipairs(self.colorButtons) do
        if colorBtn.enable then
            colorBtn.borderColor.a = 1
            self.currentColor = colorBtn.buttonInfo.colorInfo
            break
        end
    end

    local tickBox = ISTickBox:new(UI_BORDER_SPACING, self.colorButtons[1]:getBottom() + UI_BORDER_SPACING, 20, FONT_HGT_SMALL + 4, "", nil, nil)
    tickBox.choicesColor = { r = 1, g = 1, b = 1, a = 1 }
    self:addChild(tickBox)
    tickBox:addOption(getText("IGUI_TextBoxMap_MatchPerspective"))
    tickBox:setWidthToFit()
    tickBox:setVisible(false)
    self.tickBoxPerspective = tickBox
    self:insertNewLineOfButtons(tickBox)

    local childWidth = self:getWidth() - UI_BORDER_SPACING * 2

    local sliderIconWidth = FONT_HGT_SMALL
    local rotationTextWidth = getTextManager():MeasureStringX(UIFont.Small, "999")
    self.sliderScale = ISSliderPanel:new(UI_BORDER_SPACING + sliderIconWidth + 5, self.colorButtons[1]:getBottom() + UI_BORDER_SPACING, childWidth - rotationTextWidth - UI_BORDER_SPACING - sliderIconWidth - 5, FONT_HGT_SMALL, self, self.onScaleChange);
    self.sliderScale:initialise()
    self.sliderScale:instantiate()
	self.sliderScale:setValues(20, 1000.0, 1, 10)
    self.sliderScale:setCurrentValue(0, true)
    self:addChild(self.sliderScale)
    self.sliderScale:setVisible(false)
    self:insertNewLineOfButtons(self.sliderScale)

    self.sliderRotation = ISSliderPanel:new(UI_BORDER_SPACING + sliderIconWidth + 5, self.colorButtons[1]:getBottom() + UI_BORDER_SPACING, childWidth - rotationTextWidth - UI_BORDER_SPACING - sliderIconWidth - 5, FONT_HGT_SMALL, self, self.onRotationChange);
    self.sliderRotation:initialise()
    self.sliderRotation:instantiate()
	self.sliderRotation:setValues(0.0, 360.0, 1.0, 5.0)
    self.sliderRotation:setCurrentValue(0, true)
    self:addChild(self.sliderRotation)
    self.sliderRotation:setVisible(false)
    self:insertNewLineOfButtons(self.sliderRotation)

    self.zoomPanel = ISMapSymbolZoomPanel:new(0, 0, childWidth, FONT_HGT_SMALL + 2 * 2)
    self:addChild(self.zoomPanel)
    self.zoomPanel:setVisible(false)

    self.yes = ISButton:new((self:getWidth() / 2)  - 5 - buttonWid, self.colorButtons[1]:getBottom() + UI_BORDER_SPACING, buttonWid, buttonHgt, getText("UI_Ok"), self, ISMapSymbolDialog.onClick);
    self.yes.internal = "OK";
    self.yes:initialise();
    self.yes:instantiate();
    self.yes.borderColor = {r=1, g=1, b=1, a=0.1};
    self.yes:enableAcceptColor()
    self:addChild(self.yes);

    self.no = ISButton:new((self:getWidth() / 2) + 5, self.colorButtons[1]:getBottom() + UI_BORDER_SPACING, buttonWid, buttonHgt, getText("UI_Cancel"), self, ISMapSymbolDialog.onClick);
    self.no.internal = "CANCEL";
    self.no:initialise();
    self.no:instantiate();
    self.no.borderColor = {r=1, g=1, b=1, a=0.1};
    self.no:enableCancelColor()
    self:addChild(self.no);

    self:setHeight(self.yes:getBottom() + padBottom)
end

function ISMapSymbolDialog:destroy()
	self:setVisible(false);
	self:removeFromUIManager();
	if self.player and JoypadState.players[self.player+1] then
		setJoypadFocus(self.player, self.mapUI)
	end
end

function ISMapSymbolDialog:onScaleChange(value, slider)
    self.scale = value / 100
end

function ISMapSymbolDialog:onRotationChange(value, slider)
    self.rotation = value
end

function ISMapSymbolDialog:onClick(button)
    if button.internal == "COLOR" then
        for _,colorBtn in ipairs(self.colorButtons) do
            colorBtn.borderColor.a = 0.4
        end
        button.borderColor.a = 1.0
        self.currentColor = button.buttonInfo.colorInfo;
    else
        self:destroy();
        if self.onclick ~= nil then
            self.onclick(self.target, button, self.param1, self.param2, self.param3, self.param4);
        end
    end
end

function ISMapSymbolDialog:prerender()
	self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
	self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
	self:drawTextCentre(self.text, self:getWidth() / 2, 1, 1, 1, 1, 1, UIFont.Small);

	if self.joyfocus then
		local dy = math.max(FONT_HGT_SMALL, 20) + 2 * 2
		self:drawRect(0, self.height, self.width, dy, 1, 0.25, 0.25, 0.25);
		self:drawTextureScaled(Joypad.Texture.DPad, 20, self.height + 2, dy - 4, dy - 4, 1, 1, 1, 1)
		self:drawText(getText("IGUI_TextBox_Navigate"), 20 + 24, self.height + (dy - FONT_HGT_SMALL) / 2, 1, 1, 1, 1)
	end

    self:updateButtons();
end

function ISMapSymbolDialog:updateButtons()
    local inv = self.character and self.character:getInventory() or nil
    for _,colorBtn in ipairs(self.colorButtons) do
        colorBtn.enable = (inv == nil) or inv:containsTagRecurse(colorBtn.buttonInfo.item) or inv:containsTypeRecurse(colorBtn.buttonInfo.item)
    end
    
    self.yes:setEnable(true);
    self.yes.tooltip = nil;

    if self.joyfocus and self.joypadIndexY >= 1 and self.joypadIndexY <= #self.joypadButtonsY then
        self.ISButtonA = nil
        self.ISButtonB = nil
        self.yes:clearJoypadButton()
        self.no:clearJoypadButton()
    elseif self.joyfocus and self.joypadIndexY == 0 then
        self:setISButtonForA(self.yes)
        self:setISButtonForB(self.no)
    end
end

function ISMapSymbolDialog:selectColor(r, g, b)
	local r = math.floor(r * 100 + 0.5)
	local g = math.floor(g * 100 + 0.5)
	local b = math.floor(b * 100 + 0.5)
	for _,colorBtn in ipairs(self.colorButtons) do
		local colorInfo = colorBtn.buttonInfo.colorInfo
		local r2 = math.floor(colorInfo:getR() * 100 + 0.5)
		local g2 = math.floor(colorInfo:getG() * 100 + 0.5)
		local b2 = math.floor(colorInfo:getB() * 100 + 0.5)
		if r == r2 and g == g2 and b == b2 then
			colorBtn:forceClick()
			break
		end
	end
end

function ISMapSymbolDialog:showMatchPerspectiveTickBox(matchPerspective)
	self.tickBoxPerspective:setVisible(true)
	self.tickBoxPerspective:setSelected(1, matchPerspective == true)
	self:layoutWidgets()
end

function ISMapSymbolDialog:showScaleSlider(scale)
	self.sliderScale:setVisible(true)
	self.sliderScale:setCurrentValue(scale * 100, true)
	self.scale = scale
	self:layoutWidgets()
end

function ISMapSymbolDialog:showRotationSlider(degrees)
	self.sliderRotation:setVisible(true)
	self.sliderRotation:setCurrentValue(degrees, true)
	self.rotation = degrees
	self:layoutWidgets()
end

function ISMapSymbolDialog:showZoomPanel(minZoomF, maxZoomF)
	self.zoomPanel:setVisible(true)
	self.zoomPanel:setMinMaxZoom(minZoomF, maxZoomF)
	self:layoutWidgets()
end

function ISMapSymbolDialog:layoutWidgets()
    local y = self.colorButtons[1]:getBottom() + UI_BORDER_SPACING
    if self.tickBoxPerspective:isVisible() then
        self.tickBoxPerspective:setY(y)
        y = self.tickBoxPerspective:getBottom() + UI_BORDER_SPACING
    end
    if self.sliderScale:isVisible() then
        self.sliderScale:setY(y)
        y = self.sliderScale:getBottom() + UI_BORDER_SPACING
    end
    if self.sliderRotation:isVisible() then
        self.sliderRotation:setY(y)
        y = self.sliderRotation:getBottom() + UI_BORDER_SPACING
    end
    if self.zoomPanel:isVisible() then
        self.zoomPanel:setY(y)
        y = self.zoomPanel:getBottom() + UI_BORDER_SPACING
    end
	self.yes:setY(y)
	self.no:setY(y)
	self:setHeight(self.yes:getBottom() + UI_BORDER_SPACING)
end

function ISMapSymbolDialog:isMatchPerspective()
	return self.tickBoxPerspective:isSelected(1)
end

function ISMapSymbolDialog:render()
    if self.sliderScale:isVisible() then
        self:drawTextureScaled(getTexture("media/textures/worldMap/Tool_Scale.png"), UI_BORDER_SPACING, self.sliderScale.y, FONT_HGT_SMALL, FONT_HGT_SMALL, 1, 1, 1, 1)
        self:drawText(string.format("%.2f", self.sliderScale:getCurrentValue() / 100), self.sliderScale:getRight() + UI_BORDER_SPACING, self.sliderScale.y, 1, 1, 1, 1)
    end
    if self.sliderRotation:isVisible() then
        self:drawTextureScaled(getTexture("media/textures/worldMap/Tool_Rotate.png"), UI_BORDER_SPACING, self.sliderRotation.y, FONT_HGT_SMALL, FONT_HGT_SMALL, 1, 1, 1, 1)
        self:drawText(string.format("%d", self.sliderRotation:getCurrentValue()), self.sliderRotation:getRight() + UI_BORDER_SPACING, self.sliderRotation.y, 1, 1, 1, 1)
    end
end

function ISMapSymbolDialog:onGainJoypadFocus(joypadData)
	ISCollapsableWindowJoypad.onGainJoypadFocus(self, joypadData)
    self.joypadIndexY = 1
	self.joypadIndex = 1
	self:restoreJoypadFocus(joypadData)
end

function ISMapSymbolDialog:onJoypadDown(button, joypadData)
	ISCollapsableWindowJoypad.onJoypadDown(self, button, joypadData)
end

function ISMapSymbolDialog:onJoypadDirDown(joypadData)
	if self.joypadIndexY == 0 then return end
	if self.joypadIndexY == #self.joypadButtonsY then
		self.joypadIndexY = 0
		return
	end
	ISCollapsableWindowJoypad.onJoypadDirDown(self, joypadData)
end

function ISMapSymbolDialog:onJoypadDirUp(joypadData)
	if self.joypadIndexY == 0 then
		self.joypadIndexY = #self.joypadButtonsY
		return
	end
	ISCollapsableWindowJoypad.onJoypadDirUp(self, joypadData)
end

function ISMapSymbolDialog:new(x, y, width, height, title, target, onclick, player, param1, param2, param3, param4)
	x = math.min(x, getCore():getScreenWidth() - width)
	y = math.min(y, getCore():getScreenHeight() - height)
	local o = ISCollapsableWindowJoypad.new(self, x, y, width, height);
	local playerObj = player and getSpecificPlayer(player) or nil
	if y == 0 then
		if playerObj and playerObj:getJoypadBind() ~= -1 then
			o.y = getPlayerScreenTop(player) + (getPlayerScreenHeight(player) - height) / 2
		else
			o.y = o:getMouseY() - (height / 2)
		end
		o:setY(o.y)
	end
	if x == 0 then
		if playerObj and playerObj:getJoypadBind() ~= -1 then
			o.x = getPlayerScreenLeft(player) + (getPlayerScreenWidth(player) - width) / 2
		else
			o.x = o:getMouseX() - (width / 2)
		end
		o:setX(o.x)
    end
    o.character = playerObj;
	o.name = nil;
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
	o.width = width;
    local txtWidth = getTextManager():MeasureStringX(UIFont.Small, title) + 10;
    if width < txtWidth then
        o.width = txtWidth;
    end
	o.height = height;
	o.anchorLeft = true;
	o.anchorRight = true;
	o.anchorTop = true;
	o.anchorBottom = true;
	o.text = title;
	o.target = target;
	o.mapUI = target.mapUI;
	o.symbolsUI = target.symbolsUI;
	o.onclick = onclick;
	o.player = player
    o.param1 = param1;
    o.param2 = param2;
    o.param3 = param3;
    o.param4 = param4;
    o:setResizable(false)
    return o;
end

function ISMapSymbolDialog:close()
	self.no.player = self.player
	self.no.onclick(self.no.target, self.no)
	self:destroy()
end

