--***********************************************************
--**              	  ROBERT JOHNSON                       **
--***********************************************************

ISTeleportDebugUI = ISPanelJoypad:derive("ISTeleportDebugUI");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local FONT_HGT_LARGE = getTextManager():getFontHeight(UIFont.NewLarge)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

--************************************************************************--
--** ISTeleportDebugUI:initialise
--**
--************************************************************************--

function ISTeleportDebugUI:onCommandEntered()
	self.parent:onClick(self.parent.yes);
end

function ISTeleportDebugUI:onOtherKey(key)
	if key == Keyboard.KEY_ESCAPE then
		Core.UnfocusActiveTextEntryBox();
		self.parent:onClick(self.parent.no);
		return;
	end;
	if key == Keyboard.KEY_TAB then
		local targetEntry;
		if self.parent.entryX:isFocused() then
			targetEntry = self.parent.entryY;
		elseif self.parent.entryY:isFocused() then
			targetEntry = self.parent.entryZ;
		elseif self.parent.entryZ:isFocused() then
			targetEntry = self.parent.entryX;
		end;
		if targetEntry then
			Core.UnfocusActiveTextEntryBox();
			targetEntry:focus();
			targetEntry:selectAll();
		end;
	end;
end

function ISTeleportDebugUI:initialise()
	ISPanelJoypad.initialise(self);

	local th = self:titleBarHeight()
	local y = th + UI_BORDER_SPACING*2+FONT_HGT_LARGE+1

	local buttonWid = UI_BORDER_SPACING*2 + math.max(
			getTextManager():MeasureStringX(UIFont.Small, getText("UI_Ok")),
			getTextManager():MeasureStringX(UIFont.Small, getText("UI_Close"))
	)

	local label = ISLabel:new((self:getWidth() / 3) - 15, y, BUTTON_HGT, "X:", 1, 1, 1, 1, UIFont.Small)
	label:initialise()
	self:addChild(label)

	self.entryX = ISTextEntryBox:new(round(self.player:getX(), 0) .. "", (self:getWidth() / 3), y, (self:getWidth() / 2) - 20, BUTTON_HGT);
	self.entryX.font = UIFont.Small
	self.entryX:initialise();
	self.entryX:instantiate();
	self.entryX:setOnlyNumbers(true);
	self.entryX.onOtherKey = ISTeleportDebugUI.onOtherKey;
	self.entryX.onCommandEntered = ISTeleportDebugUI.onCommandEntered;
	self.entryX:focus();
	self:addChild(self.entryX);

	y = y + BUTTON_HGT + UI_BORDER_SPACING

	local label = ISLabel:new((self:getWidth() / 3) - 15, y, BUTTON_HGT, "Y:", 1, 1, 1, 1, UIFont.Small)
	label:initialise()
	self:addChild(label)
	
	self.entryY = ISTextEntryBox:new(round(self.player:getY(), 0) .. "", (self:getWidth() / 3), y, (self:getWidth() / 2) - 20, BUTTON_HGT);
	self.entryY.font = UIFont.Small
	self.entryY:initialise();
	self.entryY:instantiate();
	self.entryY:setOnlyNumbers(true);
	self.entryY.onOtherKey = ISTeleportDebugUI.onOtherKey;
	self.entryY.onCommandEntered = ISTeleportDebugUI.onCommandEntered;
	self:addChild(self.entryY);

	y = y + BUTTON_HGT + UI_BORDER_SPACING

	local label = ISLabel:new((self:getWidth() / 3) - 15, y, BUTTON_HGT, "Z:", 1, 1, 1, 1, UIFont.Small)
	label:initialise()
	self:addChild(label)

	self.entryZ = ISTextEntryBox:new(round(self.player:getZ(), 0) .. "", (self:getWidth() / 3), y, (self:getWidth() / 2) - 20, BUTTON_HGT);
	self.entryZ.font = UIFont.Small
	self.entryZ.tooltip = getText("IGUI_GameStats_Teleport_ZTooltip")
	self.entryZ:initialise();
	self.entryZ:instantiate();
	self.entryZ:setOnlyNumbers(true);
	self.entryZ.onOtherKey = ISTeleportDebugUI.onOtherKey;
	self.entryZ.onCommandEntered = ISTeleportDebugUI.onCommandEntered;
	self:addChild(self.entryZ);

	y = y + BUTTON_HGT + UI_BORDER_SPACING

	self.yes = ISButton:new((self:getWidth()-UI_BORDER_SPACING)/2 - buttonWid, y, buttonWid, BUTTON_HGT, getText("UI_Ok"), self, ISTeleportDebugUI.onClick);
	self.yes.internal = "OK";
	self.yes:initialise();
	self.yes:instantiate();
	self.yes:enableAcceptColor()
	self:addChild(self.yes);

	self.no = ISButton:new((self:getWidth()+UI_BORDER_SPACING)/2, y, buttonWid, BUTTON_HGT, getText("UI_Close"), self, ISTeleportDebugUI.onClick);
	self.no.internal = "CANCEL";
	self.no:initialise();
	self.no:instantiate();
	self.no:enableCancelColor()
	self:addChild(self.no);

	self:setHeight(self.no:getBottom()+UI_BORDER_SPACING+1)
end

function ISTeleportDebugUI:destroy()
	UIManager.setShowPausedMessage(true);
	self:setVisible(false);
	self:removeFromUIManager();
end

function ISTeleportDebugUI:onClick(button)
	if button.internal == "CANCEL" then
		self:destroy();
		return;
	end
	if self.onclick ~= nil then
		self.onclick(self.target, self.entryX:getInternalText(), self.entryY:getInternalText(), self.entryZ:getInternalText());
	end
end

function ISTeleportDebugUI:titleBarHeight()
	return 16
end

function ISTeleportDebugUI:prerender()
	self.backgroundColor.a = 0.8
	self.entryX.backgroundColor.a = 0.8
	self.entryY.backgroundColor.a = 0.8
	self.entryZ.backgroundColor.a = 0.8
	
	self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
	
	local th = self:titleBarHeight()
	self:drawTextureScaled(self.titlebarbkg, 2, 1, self:getWidth() - 4, th - 2, 1, 1, 1, 1);
	
	self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
	
	self:drawTextCentre(getText("IGUI_GameStats_Teleport"), self:getWidth() / 2, UI_BORDER_SPACING+th+1, 1, 1, 1, 1, UIFont.NewLarge);
	
	self:updateButtons();
end

function ISTeleportDebugUI:updateButtons()
	self.yes:setEnable(true);
	self.yes.tooltip = nil;
	if string.trim(self.entryX:getInternalText()) == "" or string.trim(self.entryY:getInternalText()) == "" or string.trim(self.entryZ:getInternalText()) == "" then
		self.yes:setEnable(false);
		self.yes.tooltip = getText("IGUI_TextBox_CantBeEmpty");
	end
end

--************************************************************************--
--** ISTeleportDebugUI:render
--**
--************************************************************************--
function ISTeleportDebugUI:render()

end

function ISTeleportDebugUI:onMouseMove(dx, dy)
	self.mouseOver = true
	if self.moving then
		self:setX(self.x + dx)
		self:setY(self.y + dy)
		self:bringToTop()
	end
end

function ISTeleportDebugUI:onMouseMoveOutside(dx, dy)
	self.mouseOver = false
	if self.moving then
		self:setX(self.x + dx)
		self:setY(self.y + dy)
		self:bringToTop()
	end
end

function ISTeleportDebugUI:onMouseDown(x, y)
	if not self:getIsVisible() then
		return
	end
	self.downX = x
	self.downY = y
	self.moving = true
	self:bringToTop()
end

function ISTeleportDebugUI:onMouseUp(x, y)
	if not self:getIsVisible() then
		return;
	end
	self.moving = false
	if ISMouseDrag.tabPanel then
		ISMouseDrag.tabPanel:onMouseUp(x,y)
	end
	ISMouseDrag.dragView = nil
end

function ISTeleportDebugUI:onMouseUpOutside(x, y)
	if not self:getIsVisible() then
		return
	end
	self.moving = false
	ISMouseDrag.dragView = nil
end

--************************************************************************--
--** ISTeleportDebugUI:new
--**
--************************************************************************--
function ISTeleportDebugUI:new(x, y, width, height, player, target, onclick)
	local o = {}
	o = ISPanelJoypad:new(x, y, width, height);
	setmetatable(o, self)
	self.__index = self
	if y == 0 then
		o.y = o:getMouseY() - (height / 2)
		o:setY(o.y)
	end
	if x == 0 then
		o.x = o:getMouseX() - (width / 2)
		o:setX(o.x)
	end
	o.name = nil;
	o.backgroundColor = {r=0, g=0, b=0, a=0.5};
	o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
	o.width = width;
	o.height = height;
	o.anchorLeft = true;
	o.anchorRight = true;
	o.anchorTop = true;
	o.anchorBottom = true;
	o.target = target;
	o.onclick = onclick;
	o.player = player;
	o.titlebarbkg = getTexture("media/ui/Panel_TitleBar.png");
	o.numLines = 1
	o.maxLines = 1
	o.multipleLine = false
	return o;
end
