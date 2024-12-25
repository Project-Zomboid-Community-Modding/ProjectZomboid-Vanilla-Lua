--***********************************************************
--**                      Aiteron                          **
--***********************************************************

require "ISUI/ISPanelJoypad"
require "OptionScreens/ModSelector/ModSelector"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local BUTTON_HGT = math.max(25, FONT_HGT_SMALL + 3 * 2)

ModSelector.MapOrderUI = ISPanelJoypad:derive("MapOrderUI")
local MapOrderUI = ModSelector.MapOrderUI

function MapOrderUI:new(x, y, width, height, model)
	local o = ISPanelJoypad:new(x, y, width, height)
	setmetatable(o, self)
	self.__index = self
	o.backgroundColor = {r=0, g=0, b=0, a=0.9}
	o.model = model
	o.upTexture = Joypad.Texture.YButton
	o.downTexture = Joypad.Texture.XButton
	return o
end

function MapOrderUI:instantiate()
	ISPanelJoypad.instantiate(self)
	self.modList:clear()
	local mapArray = self.model:getAllMapsInOrder()

	for i = 0, mapArray:size()-1 do
		local mapName = mapArray:get(i)
		local item = self.modList:addItem("", mapName)
		item.color = {r = 0.9, g = 0.9, b = 0.9}
		item.tooltip = self:getTooltip(mapName)
	end
end

function MapOrderUI:getTooltip(mapName)
	local text = getText("UI_modselector_conflictsFor") .. " '" .. mapName .. "':\n"
	local conflictArray = self.model:getMapConflicts(mapName)

	for i = 0, conflictArray:size()-1 do
		local conf = conflictArray:get(i)
		text = text .. conf .. "\n"
	end
	
	return text
end

function MapOrderUI:prerender()
	self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b)
	ISPanelJoypad.prerender(self)
	self:drawTextCentre(getText("UI_modselector_mapLoadOrder"), self.width / 2, 10, 1, 1, 1, 1, UIFont.Title)

	if self.joyfocus then
		self:drawTextureScaled(self.upTexture, self.backButton.x + 150, self.backButton.y+2, 20, 20, 1, 1, 1, 1)
		self:drawText(getText("UI_ServerSettings_ButtonMoveUp"), self.backButton.x + 180, self.backButton.y+4, 1, 1, 1, 1, UIFont.Small)
		self:drawTextureScaled(self.downTexture, self.backButton.x + 300, self.backButton.y+2, 20, 20, 1, 1, 1, 1)
		self:drawText(getText("UI_ServerSettings_ButtonMoveDown"), self.backButton.x + 330, self.backButton.y+4, 1, 1, 1, 1, UIFont.Small)
	end
end

function MapOrderUI:createChildren()
	self.modList = ModSelector.MapOrderListBox:new(20, 80, self.width - 40, self.height - 80 - 60)
	self.modList:initialise()
	self.modList:instantiate()
	self:addChild(self.modList)

	self.backButton = ISButton:new(16, self.height - BUTTON_HGT - 8, 100, BUTTON_HGT, getText("UI_btn_back"), self, MapOrderUI.onOptionMouseDown);
	self.backButton.internal = "BACK";
	self.backButton:initialise();
	self.backButton:instantiate();
	self.backButton:setAnchorLeft(true);
	self.backButton:setAnchorRight(false);
	self.backButton:setAnchorTop(false);
	self.backButton:setAnchorBottom(true);
	self.backButton.borderColor = {r=1, g=1, b=1, a=0.1};
	self.backButton:setFont(UIFont.Small);
	self.backButton:ignoreWidthChange();
	self.backButton:ignoreHeightChange();
	self:addChild(self.backButton);

	self.acceptButton = ISButton:new(self.width - 16, self.height - BUTTON_HGT - 8, 100, BUTTON_HGT, getText("UI_btn_accept"), self, MapOrderUI.onOptionMouseDown);
	self.acceptButton.internal = "ACCEPT";
	self.acceptButton:initialise();
	self.acceptButton:instantiate();
	self.acceptButton:setAnchorLeft(false);
	self.acceptButton:setAnchorRight(true);
	self.acceptButton:setAnchorTop(false);
	self.acceptButton:setAnchorBottom(true);
	self.acceptButton.borderColor = {r=1, g=1, b=1, a=0.1};
	self.acceptButton:setFont(UIFont.Small);
	self.acceptButton:ignoreWidthChange();
	self.acceptButton:ignoreHeightChange();
	self:addChild(self.acceptButton);
	self.acceptButton:setX(self.width - 16 - self.acceptButton.width)

	self.helpButton = ISButton:new(self.width - 16, self.height - BUTTON_HGT - 8, 100, BUTTON_HGT, getText("UI_btn_help"), self, MapOrderUI.onOptionMouseDown);
	self.helpButton.internal = "HELP";
	self.helpButton:initialise();
	self.helpButton:instantiate();
	self.helpButton:setAnchorLeft(false);
	self.helpButton:setAnchorRight(true);
	self.helpButton:setAnchorTop(false);
	self.helpButton:setAnchorBottom(true);
	self.helpButton.borderColor = {r=1, g=1, b=1, a=0.1};
	self.helpButton:setFont(UIFont.Small);
	self.helpButton:ignoreWidthChange();
	self.helpButton:ignoreHeightChange();
	self:addChild(self.helpButton);
	self.helpButton:setX(self.acceptButton.x - 16 - self.helpButton.width)
end

function MapOrderUI:onAccept()
	local activeMods = self.model:getActiveMods()
	activeMods:getMapOrder():clear()
	for i=1, #self.modList.items do
		activeMods:getMapOrder():add(self.modList.items[i].item)
	end
end

function MapOrderUI:onOptionMouseDown(button, x, y)
	if button.internal == "ACCEPT" then
		self:onAccept()
		self:setVisible(false)
		self:removeFromUIManager()
		ModSelector.instance:setVisible(true, self.joyfocus)
	elseif button.internal == "BACK" then
		self:setVisible(false)
		self:removeFromUIManager()
		ModSelector.instance:setVisible(true, self.joyfocus)
	elseif button.internal == "HELP" then
		local modal = ISModalRichText:new(getCore():getScreenWidth() / 2 - 145, getCore():getScreenHeight() / 2 - 60, 400, 200, getText("UI_ModsConflictsInfo"), false)
		modal:initialise();
		modal:addToUIManager();
		modal:setAlwaysOnTop(true);
	end
end

-------

function MapOrderUI:onGainJoypadFocus(joypadData)
	self:setISButtonForB(self.backButton)
	self.joypadIndex = self.acceptButton.ID
	self.children[self.joypadIndex]:setJoypadFocused(true, joypadData)
	ISPanelJoypad.onGainJoypadFocus(self, joypadData)
end


function MapOrderUI:onJoypadDown(button, joypadData)
	local child = self.children[self.joypadIndex]

	if button == Joypad.AButton and child and child.isButton then
		child:forceClick()
		return
	end
	if button == Joypad.XButton then
		self.modList:moveItemDown()
		return
	end
	if button == Joypad.YButton then
		self.modList:moveItemUp()
		return
	end
	if button == Joypad.BButton then
		self.backButton:forceClick()
		return
	end
end


function MapOrderUI:onJoypadDirUp(joypadData)
	self.modList:onJoypadDirUp(joypadData)
end

function MapOrderUI:onJoypadDirDown(joypadData)
	self.modList:onJoypadDirDown(joypadData)
end


function MapOrderUI:onJoypadDirLeft(joypadData)
	if self.joypadIndex == self.acceptButton.ID then
		self.children[self.joypadIndex]:setJoypadFocused(false, joypadData)
		self.joypadIndex = self.helpButton.ID
		self.children[self.joypadIndex]:setJoypadFocused(true, joypadData)
	end
end

function MapOrderUI:onJoypadDirRight(joypadData)
	if self.joypadIndex == self.helpButton.ID then
		self.children[self.joypadIndex]:setJoypadFocused(false, joypadData)
		self.joypadIndex = self.acceptButton.ID
		self.children[self.joypadIndex]:setJoypadFocused(true, joypadData)
	end
end
