--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISPanelJoypad"
require "ISUI/ISRadioButtons"
require "ISUI/ISScrollingListBox"

ISWorldMapSharing = ISPanelJoypad:derive("ISWorldMapSharing")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)

-----

local CheckList = ISScrollingListBox:derive("ISWorldMapSharing_CheckList")

function CheckList:doDrawItem(y, item, alt)
	local boxDY = (item.height - self.boxSize) / 2
	local textDY = (item.height - self.fontHgt) / 2
	if item.index == self.selected and self.joyfocus then
		self:drawRect(0, y, self.width, item.height, 0.2, 1, 1, 1, 1)
	elseif item.index == self.mouseoverselected then
		self:drawRect(0, y, self.width, item.height, 0.1, 1, 1, 1, 1)
	end
	self:drawRectBorder(self.leftMargin, y + boxDY, self.boxSize, self.boxSize, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b)
	if item.item.checked then
		self:drawTexture(self.tickTexture, self.leftMargin + 3, y + boxDY + 2, 1, 1, 1, 1)
	end
	self:drawText(item.text, self.leftMargin + self.boxSize + self.textGap, y, 1, 1, 1, 1, self.font)
	return y + item.height
end

function CheckList:onMouseDown(x, y)
	if #self.items == 0 then return end
	local row = self:rowAt(x, y)
	if row > #self.items then
		row = #self.items
	end
	if row < 1 then
		row = 1
	end
	self.selected = row

--	if x < self.leftMargin + self.boxSize then
		self:setChecked(row, not self:isChecked(row))
		getSoundManager():playUISound("UIToggleTickBox")
--	end
end

function CheckList:onMouseDoubleClick(x, y)
	return self:onMouseDown(x, y)
end

function CheckList:setChecked(index, checked)
	self.items[index].item.checked = checked
end

function CheckList:isChecked(index)
	return self.items[index].item.checked == true
end

function CheckList:getCheckedCount()
	local count = 0
	for i=1,self:size() do
		if self:isChecked(i) then
			count = count + 1
		end
	end
	return count
end

function CheckList:onJoypadDown(button, joypadData)
	ISScrollingListBox.onJoypadDown(self, button, joypadData)
	if button == Joypad.AButton then
		if self.items[self.selected] then
			self:setChecked(self.selected, not self:isChecked(self.selected))
			getSoundManager():playUISound("UIToggleTickBox")
		end
	end
end

function CheckList:new(x, y, width, height)
	local o = ISScrollingListBox.new(self, x, y, width, height)
	o.leftMargin = 5
	o.boxSize = 16
	o.textGap = 4
	o.tickTexture = getTexture("media/ui/inventoryPanes/Tickbox_Tick.png")
	return o
end

-----

local PanelMain = ISPanelJoypad:derive("ISWorldMapSharing_PanelMain")

function PanelMain:createChildren()
	local label = ISLabel:new(0, 0, FONT_HGT_MEDIUM, "Sharing", 1, 1, 1, 1, UIFont.Medium, true)
	label.center = true
	self:addChild(label)

	self.labelAuthor = ISLabel:new(0, label:getBottom() + 4, FONT_HGT_SMALL, "Author: XXX", 1, 1, 1, 1, UIFont.Small, true)
	self:addChild(self.labelAuthor)

	local radioBtns = ISRadioButtons:new(0, self.labelAuthor:getBottom() + 4, self.width, self.height, self, self.onRadioButton)
	self:addChild(radioBtns)
	radioBtns:addOption("Private", "private")
	radioBtns:addOption("Everyone", "all")
	radioBtns:addOption("Other", "other")
	radioBtns:setWidthToFit()
	self.radioBtns = radioBtns

	local panel = ISPanelJoypad:new(10, radioBtns:getBottom() + 10, self.width, 100)
	panel:noBackground()
	self:addChild(panel)

	local tickBox = ISTickBox:new(0, 0, panel.width, 20, "", self, self.onTickBoxFaction)
	panel:addChild(tickBox)
	tickBox:addOption("Faction")
	tickBox:addOption("Safehouse")
	tickBox:setWidthToFit()
	self.tickBox = tickBox

	local btnWid = 200
	local btnHgt = math.max(FONT_HGT_SMALL + 3 * 2, 25)
	self.buttonPlayers = ISButton:new(0, tickBox:getBottom() + 10, btnWid, btnHgt, "PLAYERS", self, self.onButtonPlayers)
	panel:addChild(self.buttonPlayers)

	panel:shrinkWrap(0, 0, nil)

	self:shrinkWrap(0, 0, nil)

	label:setX(self.width / 2)

	radioBtns:setWidth(self.width)
	tickBox:setWidth(panel.width)

	self.joypadIndexY = 1
	self.joypadIndex = 1

	self:onRadioButton(radioBtns, 1)
end

function PanelMain:becomeCurrent(joypadData)
	if joypadData then
		joypadData.focus = self
	end
end

function PanelMain:prerender()
	ISPanelJoypad.prerender(self)
	local count = self.parent.panelPlayers.listbox:getCheckedCount()
	self.buttonPlayers:setTitle(string.format("PLAYERS (%d)", count))
end

function PanelMain:onRadioButton(buttons, index)
	if buttons:getOptionData(index) == "private" then
		self.tickBox.enable = false
		self.buttonPlayers:setEnable(false)
	end
	if buttons:getOptionData(index) == "all" then
		self.tickBox.enable = false
		self.buttonPlayers:setEnable(false)
	end
	if buttons:getOptionData(index) == "other" then
		self.tickBox.enable = true
		self.buttonPlayers:setEnable(true)
	end
	self:setJoypadButtons()
end

function PanelMain:onButtonPlayers()
	local joypadData = self.joyfocus
	self.parent:setCurrentPanel(self.parent.panelPlayers)
	self.parent.currentPanel:becomeCurrent(joypadData)
end

function PanelMain:setCurrentSymbol(symbol)
	self.currentSymbol = symbol
	self.labelAuthor:setName("Author: " .. symbol:getAuthor())
	if symbol:isPrivate() then
		self.radioBtns:setSelected(1, true)
		self:onRadioButton(self.radioBtns, 1)
		self.tickBox:setSelected(1, false) -- faction
		self.tickBox:setSelected(2, false) -- safehouse
		return
	end
	if symbol:isVisibleToEveryone() then
		self.radioBtns:setSelected(2, true)
		self:onRadioButton(self.radioBtns, 2)
		self.tickBox:setSelected(1, false) -- faction
		self.tickBox:setSelected(2, false) -- safehouse
		return
	end
	self.radioBtns:setSelected(3, true)
	self:onRadioButton(self.radioBtns, 3)
	self.tickBox:setSelected(1, symbol:isVisibleToFaction())
	self.tickBox:setSelected(2, symbol:isVisibleToSafehouse())
end

function PanelMain:setJoypadButtons()
	local joypadIndexY = self.joypadIndexY
	self:clearJoypadFocus()
	self.joypadButtons = {}
	self.joypadButtonsY = {}
	self:insertNewLineOfButtons(self.radioBtns)
	if self.tickBox.enable then
		self:insertNewLineOfButtons(self.tickBox)
		self:insertNewLineOfButtons(self.buttonPlayers)
	else
		joypadIndexY = 1
	end
	self.joypadIndexY = joypadIndexY
	self.joypadButtons = self.joypadButtonsY[self.joypadIndexY]
	self.joypadButtons[self.joypadIndex]:setJoypadFocused(true)
end

function PanelMain:onGainJoypadFocus(joypadData)
	ISPanelJoypad.onGainJoypadFocus(self, joypadData)
	self:setJoypadButtons()
end

function PanelMain:onJoypadDown(button, joypadData)
	if button == Joypad.BButton then
		self.parent:close()
		return
	end
	ISPanelJoypad.onJoypadDown(self, button, joypadData)
end

function PanelMain:new(x, y, width, height)
	local o = ISPanelJoypad.new(self, x, y, width, height)
	o:noBackground()
	return o
end

-----

ISWorldMapSharing_PanelPlayers = ISPanelJoypad:derive("ISWorldMapSharing_PanelPlayers")
local PanelPlayers = ISWorldMapSharing_PanelPlayers

function PanelPlayers:createChildren()
	local label = ISLabel:new(0, 0, FONT_HGT_MEDIUM, "Players", 1, 1, 1, 1, UIFont.Medium, true)
	label.center = true
	self:addChild(label)
	
	local itemHgt = FONT_HGT_MEDIUM + 2 * 2
	self.listbox = CheckList:new(0, label:getBottom() + 4, 250, itemHgt * 5)
	self.listbox.drawBorder = true
	self.listbox:setFont(UIFont.Medium, 2)
	self.listbox.joypadParent = self
	self:addChild(self.listbox)

	local btnWid = 150
	local btnHgt = math.max(FONT_HGT_SMALL + 3 * 2, 25)

	self.buttonAll = ISButton:new((self.listbox.width - btnWid) / 2, self.listbox:getBottom() + 10, btnWid, btnHgt, "ALL", self, self.onButtonAll)
	self:addChild(self.buttonAll)

	self.buttonNone = ISButton:new((self.listbox.width - btnWid) / 2, self.buttonAll:getBottom() + 10, btnWid, btnHgt, "NONE", self, self.onButtonNone)
	self:addChild(self.buttonNone)

	self.buttonBack = ISButton:new((self.listbox.width - btnWid) / 2, self.buttonNone:getBottom() + 10, btnWid, btnHgt, "BACK", self, self.onButtonBack)
	self:addChild(self.buttonBack)

	self:shrinkWrap(0, 0, nil)

	label:setX(self.width / 2)

	scoreboardUpdate()

	self.joypadIndexY = 1
	self.joypadIndex = 1
	self:insertNewLineOfButtons(self.listbox)
	self:insertNewLineOfButtons(self.buttonAll)
	self:insertNewLineOfButtons(self.buttonNone)
	self:insertNewLineOfButtons(self.buttonBack)
end

function PanelPlayers:becomeCurrent(joypadData)
	if joypadData then
		joypadData.focus = self.listbox
		updateJoypadFocus(joypadData)
		self.listbox:setJoypadFocused(true, joypadData)
	end
end

function PanelPlayers:prerender()
	ISPanelJoypad.prerender(self)
	if self.listbox.joyfocus then
		self.ISButtonB = nil
		self.buttonBack:clearJoypadButton()
	elseif self.joyfocus then
		self:setISButtonForB(self.buttonBack)
	end
end

function PanelPlayers:onButtonAll()
	for i=1,self.listbox:size() do
		self.listbox.items[i].item.checked = true
	end
end

function PanelPlayers:onButtonNone()
	for i=1,self.listbox:size() do
		self.listbox.items[i].item.checked = false
	end
end

function PanelPlayers:onButtonBack()
	local joypadData = self.joyfocus
	self.parent:setCurrentPanel(self.parent.panelMain)
	self.parent.currentPanel:becomeCurrent(joypadData)
end

function PanelPlayers:setCurrentSymbol(symbol)
	self:populateList(symbol)
end

function PanelPlayers:populateList(symbol)
	self.listbox:clear()
	local scoreboard = ISWorldMapSharing_Scoreboard
	if not scoreboard then return end
	local userNameToIndex = {}
	for i=1,scoreboard.usernames:size() do
		local username = scoreboard.usernames:get(i-1)
		local displayName = scoreboard.displayNames:get(i-1)
		self.listbox:addItem(displayName .. " / " .. username, { username = username })
		userNameToIndex[username] = i
	end
	local count = symbol:getVisibleToPlayerCount()
	for i=1,count do
		local username = symbol:getVisibleToPlayerByIndex(i-1)
		if userNameToIndex[username] then
			self.listbox:setChecked(userNameToIndex[username], true)
		else
			-- This user isn't currently connected.
			local displayName = "???"
			self.listbox:addItem(displayName .. " / " .. username, { username = username })
			self.listbox:setChecked(self.listbox:size(), true)
		end
	end
end

function PanelPlayers:onGainJoypadFocus(joypadData)
	ISPanelJoypad.onGainJoypadFocus(self, joypadData)
	if self.joypadIndexY == 1 then
		self:onJoypadDirDown(joypadData)
	end
end

function PanelPlayers:onJoypadDown(button, joypadData)
	if button == Joypad.BButton then
		self:onButtonBack()
		return
	end
	ISPanelJoypad.onJoypadDown(self, button, joypadData)
end

function PanelPlayers:new(x, y, width, height)
	local o = ISPanelJoypad.new(self, x, y, width, height)
	o:noBackground()
	return o
end

function ISWorldMapSharing_PanelPlayers.onMiniScoreboardUpdate()
	scoreboardUpdate() -- send request to the server
end

function ISWorldMapSharing_PanelPlayers.onScoreboardUpdate(usernames, displayNames, steamIDs)
	ISWorldMapSharing_Scoreboard = {}
	ISWorldMapSharing_Scoreboard.usernames = usernames
	ISWorldMapSharing_Scoreboard.displayNames = displayNames
	ISWorldMapSharing_Scoreboard.steamIDs = steamIDs
end

Events.OnMiniScoreboardUpdate.Add(ISWorldMapSharing_PanelPlayers.onMiniScoreboardUpdate)
Events.OnScoreboardUpdate.Add(ISWorldMapSharing_PanelPlayers.onScoreboardUpdate)

-----

function ISWorldMapSharing:createChildren()
	self.panelMain = PanelMain:new(10, 10, 100, 100)
	self:addChild(self.panelMain)

	self.panelPlayers = PanelPlayers:new(10, 10, 100, 100)
	self.panelPlayers:initialise()
	self.panelPlayers:instantiate()

	self.currentPanel = self.panelMain
	self:setWidth(self.panelMain.width + 10 * 2)
	self:setHeight(self.panelMain.height + 10 * 2)
end

function ISWorldMapSharing:onMouseDownOutside(x, y)
	if self:isMouseOver() then return end
	self:close()
end

function ISWorldMapSharing:render()
	ISPanelJoypad.render(self)
	if self.joyfocus then
		self:drawRectBorder(2, 2, self:getWidth()-2*2, self:getHeight()-2*2, 1.0, 1.0, 1.0, 1.0);
		self:drawRectBorder(3, 3, self:getWidth()-3*2, self:getHeight()-3*2, 1.0, 1.0, 1.0, 1.0);
	end
end

function ISWorldMapSharing:setCurrentSymbol(symbol)
	self.currentSymbol = symbol
	self.panelMain:setCurrentSymbol(symbol)
	self.panelPlayers:setCurrentSymbol(symbol)
end

function ISWorldMapSharing:setCurrentPanel(panel)
	self:removeChild(self.currentPanel)
	self.currentPanel = panel
	self:addChild(self.currentPanel)
	self:shrinkWrap(10, 10, nil)
end

function ISWorldMapSharing:applyChanges()
	if not self.currentSymbol then return end
	if not self.currentSymbol:canClientModify() then return end
	if self.panelMain.radioBtns:isSelected(1) then -- private
		self.currentSymbol:setSharing(nil)
		return
	end
	if self.panelMain.radioBtns:isSelected(2) then -- everyone
		local sharing = {}
		sharing.everyone = true
		self.currentSymbol:setSharing(sharing)
		return
	end
	if self.panelMain.radioBtns:isSelected(3) then -- other
		local sharing = {}
		sharing.everyone = false
		sharing.faction = self.panelMain.tickBox:isSelected(1)
		sharing.safehouse = self.panelMain.tickBox:isSelected(2)
		sharing.players = {}
		local listbox = self.panelPlayers.listbox
		for i=1,listbox:size() do
			if listbox:isChecked(i) then
				local item = listbox.items[i].item
				table.insert(sharing.players, item.username)
			end
		end
		self.currentSymbol:setSharing(sharing)
		return
	end
end

function ISWorldMapSharing:close()
	local joypadData = JoypadState.players[self.mapUI.playerNum+1]
	if joypadData then
		joypadData.focus = self.mapUI
	end
	self:applyChanges()
	self:setCurrentPanel(self.panelMain)
	self:setVisible(false)
	self.parent:removeChild(self)
end

function ISWorldMapSharing:onGainJoypadFocus(joypadData)
	ISPanelJoypad.onGainJoypadFocus(self, joypadData)
	joypadData.focus = self.currentPanel
	updateJoypadFocus(joypadData)
end

function ISWorldMapSharing:new(mapUI)
	local o = ISPanelJoypad.new(self, 20, 20, 200, 200)
	o.borderColor = {r=0.4, g=0.4, b=0.4, a=1}
	o.backgroundColor = {r=0, g=0, b=0, a=0.8}
	o.mapUI = mapUI
	return o
end
