--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/AdminPanel/ZoneEditor/MultiplayerZoneEditorMode"
require('ISUI/Maps/Editor/WorldMapEditorResizer')

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

-- Offset WorldMapEditorResizer bounds by this amount.
local function DXY() return 0 end

MultiplayerZoneEditorMode_Safehouse = MultiplayerZoneEditorMode:derive("MultiplayerZoneEditorMode_Safehouse")

-----

MultiplayerZoneEditorMode_Safehouse_Confirm = ISPanelJoypad:derive("SafehouseConfirm")
local SafehouseConfirm = MultiplayerZoneEditorMode_Safehouse_Confirm

function SafehouseConfirm:createChildren()
	local fontHgt = FONT_HGT_SMALL
	local buttonWid1 = getTextManager():MeasureStringX(UIFont.Small, "Ok") + 12
	local buttonWid2 = getTextManager():MeasureStringX(UIFont.Small, "Cancel") + 12
	local buttonWid = math.max(buttonWid1, buttonWid2, 100)
	local padBottom = UI_BORDER_SPACING + 1

	local inset = 2
	local entryHgt = inset + FONT_HGT_MEDIUM + inset
	local label1,entry1 = self:createLabelPlusEntry(UI_BORDER_SPACING, UI_BORDER_SPACING, entryHgt, getText("IGUI_SafehouseUI_Title"))
	local label2,entry2 = self:createLabelPlusEntry(UI_BORDER_SPACING, entry1:getBottom() + UI_BORDER_SPACING, entryHgt, getText("IGUI_SafehouseUI_Owner"))
	local entryX = math.max(label1:getRight(), label2:getRight()) + UI_BORDER_SPACING
	entry1:setX(entryX)
	entry2:setX(entryX)
	self.entryTitle = entry1
	self.entryOwner = entry2

	self.yes = ISButton:new(UI_BORDER_SPACING, entry2:getBottom() + UI_BORDER_SPACING * 2, buttonWid, BUTTON_HGT, getText("IGUI_PvpZone_AddZone"), self, SafehouseConfirm.onClick)
	self.yes.internal = "OK"
	self.yes:initialise()
	self.yes:instantiate()
    self.yes:enableAcceptColor()
	self:addChild(self.yes)

	self.no = ISButton:new(self.yes:getRight() + UI_BORDER_SPACING, self.yes:getY(), buttonWid, BUTTON_HGT, getText("UI_Cancel"), self, SafehouseConfirm.onClick)
	self.no.internal = "CANCEL"
	self.no:initialise()
	self.no:instantiate()
    self.no:enableCancelColor()
	self:addChild(self.no)

	self:shrinkWrap(UI_BORDER_SPACING, UI_BORDER_SPACING, nil)

	local totalButtonWidth = self.no:getRight() - self.yes:getX()
	self.yes:setX((self.width - totalButtonWidth) / 2)
	self.no:setX(self.yes:getRight() + UI_BORDER_SPACING)
end

function SafehouseConfirm:createLabelPlusEntry(x, y, height, labelText)
	local label = ISLabel:new(x, y, height, labelText, 1.0, 1.0, 1.0, 1.0, UIFont.Medium, true)
	self:addChild(label)

	local entry = ISTextEntryBox:new("", label:getRight() + UI_BORDER_SPACING, y, 200, height)
	entry.font = UIFont.Medium
	self:addChild(entry)

	return label,entry
end

function SafehouseConfirm:onClick(button)
	if self.player and JoypadState.players[self.player+1] then
		setJoypadFocus(self.player, nil)
	elseif self.joyfocus and self.joyfocus.focus == self then
		self.joyfocus.focus = nil
	end
	if self.onclick ~= nil then
		self.onclick(self.target, button)
	end
	if not self.showError then
		self:close()
	end
end

function SafehouseConfirm:titleBarHeight()
	return 16
end

function SafehouseConfirm:prerender()
	self.backgroundColor.a = 0.8
--	self.entryTitle.backgroundColor.a = 0.8
--	self.entryOwner.backgroundColor.a = 0.8

	self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b)

	local th = self:titleBarHeight()
	self:drawTextureScaled(self.titlebarbkg, 2, 1, self:getWidth() - 4, th - 2, 1, 1, 1, 1)

	self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b)

	if self.showError then
		local fontHgt = getTextManager():getFontFromEnum(UIFont.Small):getLineHeight()
		self:drawTextCentre(self.errorMsg, self:getWidth() / 2, self.entry:getY() + 50 - fontHgt, 1, 0, 0, 1, UIFont.Small)
	end

	self:updateButtons()
--[[
	if OnScreenKeyboard.IsVisible() then
		if self:getBottom() > OnScreenKeyboard.instance.y then
			self:setY(OnScreenKeyboard.instance.y - self.height)
		end
	end
--]]
end

function SafehouseConfirm:updateButtons()
	self.yes:setEnable(true)
	self.yes.tooltip = nil
--	local text = self.entryTitle:getText()
	if self.joyfocus and self.entry.joypadFocused then
		self.ISButtonA = nil
		self.ISButtonB = nil
		self.yes:clearJoypadButton()
		self.no:clearJoypadButton()
	elseif self.joyfocus and not self.entry.joypadFocused then
		self:setISButtonForA(self.yes)
		self:setISButtonForB(self.no)
	end
end

function SafehouseConfirm:onGainJoypadFocus(joypadData)
	ISPanelJoypad.onGainJoypadFocus(self, joypadData)
	self:setISButtonForA(self.yes)
	self:setISButtonForB(self.no)
	self.joypadButtonsY = {}
	self.joypadButtons = {}
	self.joypadIndexY = 1
	self.joypadIndex = 1
	self:insertNewLineOfButtons(self.entryTitle)
	self:insertNewLineOfButtons(self.entryOwner)
--	self:insertNewLineOfButtons(self.yes, self.no)
	self.entry:setJoypadFocused(true, joypadData)
end

function SafehouseConfirm:onMouseMove(dx, dy)
	return true
end

function SafehouseConfirm:onMouseMoveOutside(dx, dy)
	return true
end

function SafehouseConfirm:onMouseDownOutside(x, y)
--	self:onClick(self.no)
	return true
end

function SafehouseConfirm:onJoypadDirDown(joypadData)
	self.joypadIndexY = 0
	self.entry:setJoypadFocused(false, joypadData)
end

function SafehouseConfirm:onJoypadDirUp(joypadData)
	self.joypadIndexY = 1
	self.entry:setJoypadFocused(true, joypadData)
end

function SafehouseConfirm:onJoypadDown(button, joypadData)
	if button == Joypad.BButton then
		if self.joypadIndexY == 1 then
			self.joypadIndexY = 0
			self.entry:setJoypadFocused(false, joypadData)
			return
		end
	end
	ISPanelJoypad.onJoypadDown(self, button, joypadData)
end

function SafehouseConfirm:close()
	ISPanelJoypad.close(self)
	if self.player ~= nil and JoypadState.players[self.player+1] then
		setJoypadFocus(self.player, nil)
	end
end

function SafehouseConfirm:new(x, y, width, height, target, onclick, player)
	local o = ISPanelJoypad.new(self, x, y, width, height)
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
	o.name = nil
	o.backgroundColor = {r=0, g=0, b=0, a=0.5}
	o.borderColor = {r=0.4, g=0.4, b=0.4, a=1}
	o.target = target
	o.onclick = onclick
	o.player = player
	o.titlebarbkg = getTexture("media/ui/Panel_TitleBar.png")
	return o
end


-----

MultiplayerZoneEditorMode_Safehouse_Details = ISPanel:derive("MultiplayerZoneEditorMode_Safehouse_Details")
DetailsPanel = MultiplayerZoneEditorMode_Safehouse_Details

function DetailsPanel:createChildren()
	local btnWid = 100

	local nameLbl = ISLabel:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, BUTTON_HGT, getText("IGUI_SafehouseUI_Title"), 1, 1, 1, 1, UIFont.Small, true)
	nameLbl:initialise()
	nameLbl:instantiate()
	self:addChild(nameLbl)

	self.title = ISLabel:new(nameLbl:getRight() + UI_BORDER_SPACING, nameLbl.y, BUTTON_HGT, "", 0.6, 0.6, 0.8, 1.0, UIFont.Small, true)
	self.title:initialise()
	self.title:instantiate()
	self:addChild(self.title)

	self.changeTitle = ISButton:new(UI_BORDER_SPACING+1, nameLbl.y, 70, BUTTON_HGT, getText("IGUI_PlayerStats_Change"), self, function(self, button) self:onClick(button) end)
	self.changeTitle.internal = "CHANGETITLE"
	self.changeTitle:initialise()
	self.changeTitle:instantiate()
	self.changeTitle.borderColor = self.buttonBorderColor
	self:addChild(self.changeTitle)

	local ownerLbl = ISLabel:new(UI_BORDER_SPACING+1, nameLbl:getBottom() + UI_BORDER_SPACING, FONT_HGT_SMALL, getText("IGUI_SafehouseUI_Owner"), 1, 1, 1, 1, UIFont.Small, true)
	ownerLbl:initialise()
	ownerLbl:instantiate()
	self:addChild(ownerLbl)

	self.owner = ISLabel:new(ownerLbl:getRight() + UI_BORDER_SPACING, ownerLbl.y, FONT_HGT_SMALL, "", 0.6, 0.6, 0.8, 1.0, UIFont.Small, true)
	self.owner:initialise()
	self.owner:instantiate()
	self:addChild(self.owner)

	self.releaseSafehouse = ISButton:new(UI_BORDER_SPACING+1, 0, 70, BUTTON_HGT, getText("IGUI_SafehouseUI_Release"), self, function(self, button) self:onClick(button) end)
	self.releaseSafehouse.internal = "RELEASE"
	self.releaseSafehouse:initialise()
	self.releaseSafehouse:instantiate()
	self.releaseSafehouse.borderColor = self.buttonBorderColor
	self:addChild(self.releaseSafehouse)
	self.releaseSafehouse.parent = self
	self.releaseSafehouse:setVisible(false)

	self.changeOwnership = ISButton:new(0, ownerLbl.y, 70, BUTTON_HGT, getText("IGUI_SafehouseUI_ChangeOwnership"), self, function(self, button) self:onClick(button) end)
	self.changeOwnership.internal = "CHANGEOWNERSHIP"
	self.changeOwnership:initialise()
	self.changeOwnership:instantiate()
	self.changeOwnership.borderColor = self.buttonBorderColor
	self:addChild(self.changeOwnership)
	self.changeOwnership.parent = self
	self.changeOwnership:setVisible(false)

	local playersLbl = ISLabel:new(UI_BORDER_SPACING+1, ownerLbl:getBottom() + UI_BORDER_SPACING, BUTTON_HGT, getText("IGUI_SafehouseUI_Players"), 1, 1, 1, 1, UIFont.Small, true)
	playersLbl:initialise()
	playersLbl:instantiate()
	self:addChild(playersLbl)

	self.refreshPlayerList = ISButton:new(playersLbl:getRight() + UI_BORDER_SPACING, playersLbl.y, 70, BUTTON_HGT, getText("UI_servers_refresh"), self, function(self, button) self:onClick(button) end)
	self.refreshPlayerList.internal = "REFRESHLIST"
	self.refreshPlayerList:initialise()
	self.refreshPlayerList:instantiate()
	self.refreshPlayerList.borderColor = self.buttonBorderColor
	self:addChild(self.refreshPlayerList)

	self.playerList = ISScrollingListBox:new(UI_BORDER_SPACING+1, playersLbl:getBottom()+UI_BORDER_SPACING, self.width - (UI_BORDER_SPACING+1)*2, BUTTON_HGT * 8)
	self.playerList:initialise()
	self.playerList:instantiate()
	self.playerList.itemheight = BUTTON_HGT
	self.playerList.selected = 0
	self.playerList.joypadParent = self
	self.playerList.font = UIFont.NewSmall
	self.playerList.doDrawItem = self.drawPlayers
	self.playerList.drawBorder = true
	self:addChild(self.playerList)

	self.removePlayer = ISButton:new(0, self.playerList.y + self.playerList.height + UI_BORDER_SPACING, 70, BUTTON_HGT, getText("ContextMenu_Remove"), self, function(self, button) self:onClick(button) end)
	self.removePlayer.internal = "REMOVEPLAYER"
	self.removePlayer:initialise()
	self.removePlayer:instantiate()
	self.removePlayer.borderColor = self.buttonBorderColor
	self.removePlayer:setWidthToTitle(70)
	self.removePlayer:setX(self.playerList:getRight() - self.removePlayer.width)
	self:addChild(self.removePlayer)
	self.removePlayer.enable = false

	self.quitSafehouse = ISButton:new(0, self.playerList.y + self.playerList.height + UI_BORDER_SPACING, 70, BUTTON_HGT, getText("IGUI_SafehouseUI_QuitSafehouse"), self, function(self, button) self:onClick(button) end)
	self.quitSafehouse.internal = "QUITSAFE"
	self.quitSafehouse:initialise()
	self.quitSafehouse:instantiate()
	self.quitSafehouse.borderColor = self.buttonBorderColor
	self.quitSafehouse:setWidthToTitle(70)
	self.quitSafehouse:setX(self.playerList:getRight() - self.quitSafehouse.width)
	if self:hasPrivilegedAccessLevel() then
		self.quitSafehouse:setY(self.removePlayer.y + BUTTON_HGT + 5)
	end
	self:addChild(self.quitSafehouse)

	self.addPlayer = ISButton:new(self.playerList.x, self.playerList.y + self.playerList.height + UI_BORDER_SPACING, 70, BUTTON_HGT, getText("IGUI_SafehouseUI_AddPlayer"), self, function(self, button) self:onClick(button) end)
	self.addPlayer.internal = "ADDPLAYER"
	self.addPlayer:initialise()
	self.addPlayer:instantiate()
	self.addPlayer.borderColor = self.buttonBorderColor
	self:addChild(self.addPlayer)

	self.respawn = ISTickBox:new(UI_BORDER_SPACING+1, self.addPlayer:getBottom() + UI_BORDER_SPACING, getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_SafehouseUI_Respawn")) + 20, 18, "", self, DetailsPanel.onClickRespawn)
	self.respawn:initialise()
	self.respawn:instantiate()
	self.respawn:addOption(getText("IGUI_SafehouseUI_Respawn"))
	self:addChild(self.respawn)
	self.respawn.safehouseUI = self
	if not getServerOptions():getBoolean("SafehouseAllowRespawn") then
		self.respawn.enable = false
	end

	self.releaseSafehouse:setY(self.respawn:getBottom() + UI_BORDER_SPACING)
	self:setHeight(self.releaseSafehouse:getBottom() + UI_BORDER_SPACING+1)
end

function DetailsPanel:setSafehouse(safehouse)
	self:hideModalUI()
	self.safehouse = safehouse
	if safehouse then
		self.title:setName(safehouse:getTitle())
		self.owner:setName(safehouse:getOwner())
		self.respawn:setSelected(1, safehouse:isRespawnInSafehouse(self.player:getUsername()))
		self.removePlayer:setVisible(self:isOwner() or self:hasPrivilegedAccessLevel())
		self.quitSafehouse:setVisible(not self:isOwner() and safehouse:getPlayers():contains(self.player:getUsername()))
		self:populateList()
	end
end

function DetailsPanel:onClickRespawn(clickedOption, enabled)
	sendSafehouseChangeRespawn(self.safehouse, self.player, enabled)
end

function DetailsPanel:populateList()
	local selected = self.playerList.selected
	self.playerList:clear()
	for i=1,self.safehouse:getPlayers():size() do
		local newPlayer = {}
		newPlayer.name = self.safehouse:getPlayers():get(i-1)
		if newPlayer.name ~= self.safehouse:getOwner() then
			self.playerList:addItem(newPlayer.name, newPlayer)
		end
	end
	self.playerList.selected = math.min(selected, #self.playerList.items)
end

function DetailsPanel:drawPlayers(y, item, alt)
	local a = 0.9
	self:drawRectBorder(0, (y), self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b)
	if self.selected == item.index then
		self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15)
	end
	self:drawText(item.item.name, 10, y + 2, 1, 1, 1, a, self.font)
	return y + self.itemheight
end

function DetailsPanel:render()
	self:updateButtons()
	self.removePlayer.enable = false
	if self.playerList.selected > 0 then
		self.removePlayer.enable = self:isOwner() or self:hasPrivilegedAccessLevel()
		self.selectedPlayer = self.playerList.items[self.playerList.selected].item.name
		if self.selectedPlayer == self.player:getUsername() or self.selectedPlayer == self.safehouse:getOwner() then
			self.removePlayer.enable = false
		end
	else
		self.selectedPlayer = nil
	end
	self:updatePlayerList()
end

function DetailsPanel:prerender()
	local z = 20
	local splitPoint = 100
	local x = 10
	self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b)
	self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b)
	self.title:setName(self.safehouse:getTitle())
	self.changeTitle:setX(self.title:getRight() + UI_BORDER_SPACING)
	z = z + 30
	self.owner:setName(self.safehouse:getOwner())
	if self:isOwner() or self:hasPrivilegedAccessLevel() then
		self.releaseSafehouse:setVisible(true)
		self.changeOwnership:setVisible(true)
		self.changeOwnership:setX(self.owner:getRight() + UI_BORDER_SPACING)
	end
	if self:hasPrivilegedAccessLevel() then
		self.quitSafehouse:setY(self.removePlayer.y + FONT_HGT_SMALL + UI_BORDER_SPACING)
	else
		self.quitSafehouse:setY(self.playerList.y + self.playerList.height + UI_BORDER_SPACING)
	end
end

function DetailsPanel:updatePlayerList()
	self.updateTick = self.updateTick + 1
	if self.updateTick >= self.updateTickMax then
		self:populateList()
		self.updateTick = 0
	end
end

function DetailsPanel:updateButtons()
	local isOwner = self:isOwner()
	local hasPrivilegedAccessLevel = self:hasPrivilegedAccessLevel()
	self.releaseSafehouse:setVisible(isOwner or hasPrivilegedAccessLevel)
	self.changeOwnership:setVisible(isOwner or hasPrivilegedAccessLevel)
	self.removePlayer.enable = isOwner or hasPrivilegedAccessLevel
	self.addPlayer.enable = isOwner or hasPrivilegedAccessLevel
	self.changeTitle.enable = isOwner or hasPrivilegedAccessLevel
	self.quitSafehouse:setVisible(not isOwner and self.safehouse:getPlayers():contains(self.player:getUsername()))
end

function DetailsPanel:hideModalUI()
	if self.modalUI ~= nil then
		self.modalUI:setVisible(false)
		self.modalUI:removeFromUIManager()
		self.modalUI = nil
	end
end

function DetailsPanel:onClick(button)
	self:hideModalUI()
	local dialogX = self:getAbsoluteX() + self:getWidth() + UI_BORDER_SPACING
	local dialogY = self:getAbsoluteY()
	if button.internal == "CHANGETITLE" then
		local modal = ISTextBox:new(dialogX, dialogY, 280, 180, getText("IGUI_SafehouseUI_ChangeTitle"), self.safehouse:getTitle(), nil, DetailsPanel.onChangeTitle)
		modal.safehouse = self.safehouse
		modal:initialise()
		modal:addToUIManager()
		modal:setAlwaysOnTop(true)
		self.modalUI = modal
	end
	if button.internal == "CHANGEOWNERSHIP" then
		local modal = ISSafehouseAddPlayerUI:new(dialogX, dialogY, 400, 350, self.safehouse, self.player)
		modal.changeOwnership = true
		modal:initialise()
		modal:addToUIManager()
		modal.safehouseUI = self
		modal.moveWithMouse = false
		modal:setAlwaysOnTop(true)
		self.modalUI = modal
	end
	if button.internal == "REFRESHLIST" then
		self:populateList()
	end
	if button.internal == "ADDPLAYER" then
		local modal = ISSafehouseAddPlayerUI:new(dialogX, dialogY, 400, 350, self.safehouse, self.player)
		modal:initialise()
		modal:addToUIManager()
		modal.safehouseUI = self
		self.addPlayerUI = safehouseUI
		modal.moveWithMouse = false
		modal:setAlwaysOnTop(true)
		self.modalUI = modal
	end
	if button.internal == "REMOVEPLAYER" then
		local modal = ISModalDialog:new(dialogX, dialogY, 350, 150, getText("IGUI_SafehouseUI_RemoveConfirm", self.selectedPlayer), true, nil, DetailsPanel.onRemovePlayerFromSafehouse)
		modal:initialise()
		modal:addToUIManager()
		modal.ui = self
		modal.moveWithMouse = false
		modal:setAlwaysOnTop(true)
		self.modalUI = modal
	end
	if button.internal == "QUITSAFE" then
		local modal = ISModalDialog:new(dialogX, dialogY, 350, 150, getText("IGUI_SafehouseUI_QuitSafeConfirm", self.selectedPlayer), true, nil, DetailsPanel.onQuitSafehouse)
		modal:initialise()
		modal:addToUIManager()
		modal.ui = self
		modal.moveWithMouse = false
		modal:setAlwaysOnTop(true)
		self.modalUI = modal
	end
	if button.internal == "RELEASE" then
		local modal = ISModalDialog:new(dialogX, dialogY, 350, 150, getText("IGUI_SafehouseUI_ReleaseConfirm", self.selectedPlayer), true, nil, DetailsPanel.onReleaseSafehouse)
		modal:initialise()
		modal:addToUIManager()
		modal.ui = self
		modal.moveWithMouse = false
		modal:setAlwaysOnTop(true)
		self.modalUI = modal
	end
end

function DetailsPanel:onChangeTitle(button)
	if button.internal == "OK" then
		sendSafehouseChangeTitle(button.parent.safehouse, button.parent.entry:getText())
	end
end

function DetailsPanel:onQuitSafehouse(button)
	if button.internal == "YES" then
		sendSafehouseChangeMember(button.parent.ui.safehouse, button.parent.ui.player, true)
	end
--	button.parent.ui:close()
end

function DetailsPanel:onRemovePlayerFromSafehouse(button, player)
	if button.internal == "YES" then
		sendSafehouseChangeMember(button.parent.ui.safehouse, button.parent.ui.player, true)
		button.parent.ui:populateList()
	end
end

function DetailsPanel:onReleaseSafehouse(button, player)
	if button.internal == "YES" then
		if button.parent.ui:isOwner() or button.parent.ui:hasPrivilegedAccessLevel() then
			sendSafehouseRelease(button.parent.ui.safehouse)
		end
	end
--	button.parent.ui:close()
end

function DetailsPanel:isOwner()
	return self.safehouse:isOwner(self.player)
end

function DetailsPanel:hasPrivilegedAccessLevel()
	return self.player:getRole():haveCapability(Capability.CanSetupSafehouses)
end

function DetailsPanel:onSafehousesChanged()
	if not self.safehouse then return end
	if not SafeHouse.getSafehouseList():contains(self.safehouse) then
		self:setSafehouse(nil)
		self:setVisible(false)
		return
	end
	self:populateList()
end

function DetailsPanel:new(x, y, width, height, player)
	local o = ISPanel.new(self, x, y, width, height)
	o.borderColor = {r=0.4, g=0.4, b=0.4, a=1}
	o.backgroundColor = {r=0, g=0, b=0, a=0.8}
	o.width = width
	o.height = height
	o.player = player
	o.updateTick = 0
	o.updateTickMax = 120
	o.buttonBorderColor = {r=0.7, g=0.7, b=0.7, a=0.5}
	return o
end

function DetailsPanel.OnSafehousesChanged()
	local instance = ISMultiplayerZoneEditor_instance
	if not instance then return end
	if not instance:isReallyVisible() then return end
	if not instance.mode then return end
	mode = instance.mode.Safehouse
	if not mode then return end
	local detailsPanel = mode.detailsPanel
	if not detailsPanel then return end
	detailsPanel:onSafehousesChanged()
end

Events.OnSafehousesChanged.Add(DetailsPanel.OnSafehousesChanged)

-----

function MultiplayerZoneEditorMode_Safehouse:createChildren()
	local ROWS = 6
	self.listbox = ISScrollingListBox:new(UI_BORDER_SPACING, self.editor.modeCombo:getBottom() + UI_BORDER_SPACING, 300, (FONT_HGT_SMALL + 3 * 2) * ROWS)
	self.listbox:setFont(UIFont.Small, 3)
	self:addChild(self.listbox)

	local buttonPadding = UI_BORDER_SPACING * 2
	local button = ISButton:new(UI_BORDER_SPACING, self.listbox:getBottom() + UI_BORDER_SPACING, 80, BUTTON_HGT, getText("IGUI_MultiplayerZoneEditor_Button_AddZone"), self, function(self) self:onAddZone() end)
	button:setWidthToTitle()
	self:addChild(button)
	self.addButton = button

	self.detailsPanel = DetailsPanel:new(UI_BORDER_SPACING, self.addButton:getBottom() + UI_BORDER_SPACING, 500, 200, self:getPlayer())
	self:addChild(self.detailsPanel)
end

function MultiplayerZoneEditorMode_Safehouse:prerender()
	self:fillList()
	local zone = self:getSelectedZone()
	local zoneName = zone and zone:getTitle() or nil
	if zoneName ~= self.selectedZone then
		self:selectedZoneChanged() -- another user might remove the zone being edited
		self.selectedZone = zoneName
		if zone then
			self.resizer:setBounds(zone:getX(), zone:getY(), zone:getX2() + DXY(), zone:getY2() + DXY())
			self.mapAPI:centerOn(zone:getX(), zone:getY())
		else
			self.resizer:setBounds(0, 0, 0, 0)
		end
	end
end

function MultiplayerZoneEditorMode_Safehouse:render()
	local r,g,b,a = 0.0, 0.0, 1.0, 0.5
	local zones = SafeHouse.getSafehouseList()
	for i=1,zones:size() do
		local zone = zones:get(i-1)
		self:renderRect(zone:getX(), zone:getY(), zone:getX2(), zone:getY2(), r, g, b, a)
		local uiX = self.mapAPI:worldToUIX(zone:getX(), zone:getY())
		local uiY = self.mapAPI:worldToUIY(zone:getX(), zone:getY())
		self:drawText(zone:getTitle(), uiX + 4, uiY + 2, 0, 0, 0, 1, UIFont.Small)
	end
	self:renderResizer()
	if self.mode == "StartDrawingBounds" then
		local mx = self.mapUI:getMouseX()
		local my = self.mapUI:getMouseY()
		local worldX = self.mapAPI:uiToWorldX(mx, my)
		local worldY = self.mapAPI:uiToWorldY(mx, my)
		worldX = self.resizer:snap(worldX)
		worldY = self.resizer:snap(worldY)
		mx = self.mapAPI:worldToUIX(worldX, worldY)
		my = self.mapAPI:worldToUIY(worldX, worldY)
		self.mapUI:drawRectBorder(mx - 10, my - 10, 20, 20, 1, 0, 0, 1)
		self.mapUI:drawRectBorder(mx - 10 - 1, my - 10 - 1, 20 + 2, 20 + 2, 1, 0, 0, 1)
	end
end

function MultiplayerZoneEditorMode_Safehouse:renderResizer()
	local r,g,b,a = 0,0,0,1
	if self.mode == "DrawBounds" then
		local x1,y1,x2,y2 = self.resizer.x1, self.resizer.y1, self.resizer.x2 - DXY(), self.resizer.y2 - DXY()
		if not self:isNewZoneValid(x1, y1, x2, y2) then
			r = 1
		end
	end
	if self.mode == "Resize" then
		local x1,y1,x2,y2 = self.resizer.x1, self.resizer.y1, self.resizer.x2 - DXY(), self.resizer.y2 - DXY()
		local ignoreZone = self:getSelectedZone()
		if (x1 == x2 or y1 == y2) or (SafeHouse.getSafehouseOverlapping(x1, y1, x2, y2, ignoreZone) ~= nil) then
			r = 1
		end
	end
	self.resizer:render(r, g, b, a)
end

function MultiplayerZoneEditorMode_Safehouse:renderRect(x1, y1, x2, y2, r, g, b, a)
	local worldX1 = x1
	local worldY1 = y1
	local worldX2 = x2
	local worldY2 = y2
	local uiX1 = self.mapAPI:worldToUIX(worldX1, worldY1)
	local uiY1 = self.mapAPI:worldToUIY(worldX1, worldY1)
	local uiX2 = self.mapAPI:worldToUIX(worldX2, worldY1)
	local uiY2 = self.mapAPI:worldToUIY(worldX2, worldY1)
	local uiX3 = self.mapAPI:worldToUIX(worldX2, worldY2)
	local uiY3 = self.mapAPI:worldToUIY(worldX2, worldY2)
	local uiX4 = self.mapAPI:worldToUIX(worldX1, worldY2)
	local uiY4 = self.mapAPI:worldToUIY(worldX1, worldY2)
	local THICK = 1
	self.mapUI.javaObject:DrawLine(Texture:getWhite(), uiX1, uiY1, uiX2, uiY2, THICK, r, g, b, a)
	self.mapUI.javaObject:DrawLine(Texture:getWhite(), uiX2, uiY2, uiX3, uiY3, THICK, r, g, b, a)
	self.mapUI.javaObject:DrawLine(Texture:getWhite(), uiX3, uiY3, uiX4, uiY4, THICK, r, g, b, a)
	self.mapUI.javaObject:DrawLine(Texture:getWhite(), uiX4, uiY4, uiX1, uiY1, THICK, r, g, b, a)
	--[[
	self.mapUI:drawRect(uiX1 - THICK, uiY1 - THICK, uiX2 - uiX1 + THICK * 2, THICK, a, r, g, b)
	self.mapUI:drawRect(uiX2, uiY2 - THICK, THICK, uiY3 - uiY2 + THICK * 2, a, r, g, b)
	self.mapUI:drawRect(uiX4 - THICK, uiY4, uiX3 - uiX4 + THICK * 2, THICK, a, r, g, b)
	self.mapUI:drawRect(uiX1 - THICK, uiY1 - THICK, THICK, uiY4 - uiY1 + THICK * 2, a, r, g, b)
	--]]
end

function MultiplayerZoneEditorMode_Safehouse:fillList()
	local selectedZone = self:getSelectedZone()
	local selectedTitle = selectedZone and selectedZone:getTitle() or nil
	if self.delaySelectTitle then
		selectedTitle = self.delaySelectTitle
		self.delaySelectTitle = nil
	end
	self.listbox:clear()
	local zones = SafeHouse.getSafehouseList()
	for i=1,zones:size() do
		local zone = zones:get(i-1)
		self.listbox:addItem(zone:getTitle() .. " - Owner: " .. zone:getOwner(), zone)
	end
	self.listbox:sort()
	for i=1,zones:size() do
		local zone = self.listbox.items[i].item
		if zone:getTitle() == selectedTitle then
			self.listbox.selected = i
		end
	end
end

function MultiplayerZoneEditorMode_Safehouse:getSelectedZone()
	local selected = self.listbox.selected
	local item = self.listbox.items[selected]
	return item and item.item or nil
end

function MultiplayerZoneEditorMode_Safehouse:undisplay()
	self.detailsPanel:setSafehouse(nil)
	if self.modalUI then
		self.modalUI:close()
		self.modalUI:setVisible(false)
		self.modalUI:removeFromUIManager()
		self.modalUI = nil
	end
	self.selectedZone = nil
	self:cancelResize()
	MultiplayerZoneEditorMode.undisplay(self)
end

function MultiplayerZoneEditorMode_Safehouse:onMouseDown(x, y)
	if self.mode == "StartDrawingBounds" then
		self.mode = "DrawBounds"
		local worldX = self.mapAPI:uiToWorldX(x, y)
		local worldY = self.mapAPI:uiToWorldY(x, y)
		worldX = self.resizer:snap(worldX)
		worldY = self.resizer:snap(worldY)
		self.resizer:setBounds(worldX, worldY, worldX, worldY)
		self.resizer:startResizing()
		return true
	end
	if self:getSelectedZone() then
		local resizeMode = self.resizer:hitTest(x, y)
		if not resizeMode then return false end
		self.resizer:startResizing()
		self.mode = "Resize"
		self.resizeMode = resizeMode
		return true
	end
	return false -- allow clicks in the map
end

function MultiplayerZoneEditorMode_Safehouse:onMouseUp(x, y)
	if self.mode == "DrawBounds" then
		self.mode = nil
		local x1,y1,x2,y2 = self.resizer.x1, self.resizer.y1, self.resizer.x2 - DXY(), self.resizer.y2 - DXY()
		if self:isNewZoneValid(x1, y1, x2, y2) then
			self:createNewZone(x1, y1, x2, y2)
		else
			self.selectedZone = nil -- set resizer bounds
		end
		self.resizer:endResizing()
		return true
	end
	if self.mode == "Resize" then
		self.mode = nil
		self.resizeMode = nil
		local x1,y1,x2,y2 = self.resizer.x1, self.resizer.y1, self.resizer.x2 - DXY(), self.resizer.y2 - DXY()
		local ignoreZone = self:getSelectedZone()
		if SafeHouse.getSafehouseOverlapping(x1, y1, x2, y2, ignoreZone) == nil then
			self:setZoneBounds(x1, y1, x2, y2)
		else
			self.selectedZone = nil -- set resizer bounds
		end
		self.resizer:endResizing()
		return true
	end
	return false -- allow clicks in the map
end

function MultiplayerZoneEditorMode_Safehouse:onMouseUpOutside(x, y)
	return self:onMouseUp(x, y)
end

function MultiplayerZoneEditorMode_Safehouse:onMouseMove(dx, dy)
	if self.mode == "DrawBounds" then
		local mx = self:getMouseX()
		local my = self:getMouseY()
		self.resizer:onMouseMove(mx, my, "BottomRight")
		return true
	end
	if self.mode == "Resize" then
		local mx = self:getMouseX()
		local my = self:getMouseY()
		self.resizer:onMouseMove(mx, my, self.resizeMode)
		return true
	end
	if self.mode then
		return true
	end
	return false -- allow clicks in the map
end

function MultiplayerZoneEditorMode_Safehouse:onRightMouseDown(x, y)
	return self:cancelResize()
end

function MultiplayerZoneEditorMode_Safehouse:onKeyRelease(key)
	if key == Keyboard.KEY_ESCAPE then
		return self:cancelResize()
	end
	return false
end

function MultiplayerZoneEditorMode_Safehouse:selectedZoneChanged()
	if self.modalUI then
		self.modalUI:close()
		self.modalUI:setVisible(false)
		self.modalUI:removeFromUIManager()
		self.modalUI = nil
	end
	self:cancelResize()
	local zone = self:getSelectedZone()
	if zone then
		self.detailsPanel:setSafehouse(zone)
		self.detailsPanel:setVisible(true)
	else
		self.detailsPanel:setSafehouse(nil)
		self.detailsPanel:setVisible(false)
	end
end

function MultiplayerZoneEditorMode_Safehouse:cancelResize()
	if self.mode == "DrawBounds" then
		self.mode = nil
		self.resizer:endResizing()
		self.selectedZone = nil -- set resizer bounds
		return true
	end
	if self.mode == "Resize" then
		self.mode = nil
		self.resizeMode = nil
		self.resizer:cancelResize()
		return true
	end
	if self.mode == "StartDrawingBounds" then
		self.mode = nil
		self.selectedZone = nil -- set resizer bounds
		return true
	end
	return false
end

function MultiplayerZoneEditorMode_Safehouse:getPlayer()
	return getSpecificPlayer(0)
end

function MultiplayerZoneEditorMode_Safehouse:isNewZoneValid(x1, y1, x2, y2)
	if x1 == x2 or y1 == y2 then return false end
	if SafeHouse.getSafehouseOverlapping(x1, y1, x2, y2) ~= nil then return false end
	local character = self:getPlayer()
	if not character:getRole():haveCapability(Capability.CanSetupSafezone) then return false end
	return true
end

function MultiplayerZoneEditorMode_Safehouse:createNewZone(x1, y1, x2, y2)
	local player = nil
	local modal = SafehouseConfirm:new(0, 0, 280, 180, self, self.onNewZoneNameEntered, player)
	modal:initialise()
	modal:addToUIManager()
	modal:setAlwaysOnTop(true)
	self.modalUI = modal
end

function MultiplayerZoneEditorMode_Safehouse:onNewZoneNameEntered(button)
	self.selectedZone = nil
	if button.internal == "OK" then
		local title = button.parent.entryTitle:getInternalText()
		local owner = button.parent.entryOwner:getInternalText()
		if string.trim(title) == "" or string.trim(owner) == "" then return end
		local x1,y1,x2,y2 = self.resizer.x1, self.resizer.y1, self.resizer.x2, self.resizer.y2
		if self:isNewZoneValid(x1, y1, x2, y2) then
			sendSafezoneClaim(owner, x1, y1, x2 - x1 + 1, y2 - y1 + 1, title)
			self.delaySelectTitle = title
		end
	end
end

function MultiplayerZoneEditorMode_Safehouse:setZoneBounds(x1, y1, x2, y2)
	local zone = self:getSelectedZone()
	local title = zone:getTitle()
	-- TODO
	self.selectedZone = nil
end

function MultiplayerZoneEditorMode_Safehouse:onAddZone()
	if self.mode == "StartDrawingBounds" then
		self.mode = nil
		self.selectedZone = nil -- set resizer bounds
		return
	end
	self.mode = "StartDrawingBounds"
	self.resizer:setBounds(0, 0, 0, 0)
end

function MultiplayerZoneEditorMode_Safehouse:new(editor)
	local o = MultiplayerZoneEditorMode.new(self, editor)
	o.snapMode = "square" -- "cell" or "chunk" or "square"
	o.resizer = WorldMapEditorResizer:new(editor)
	o.resizer.snapMode = o.snapMode
	return o
end
