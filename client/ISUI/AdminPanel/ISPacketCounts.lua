--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

ISPacketCounts = ISPanel:derive("ISPacketCounts")
ISPacketCountsList = ISPanel:derive("ISPacketCountsPanel")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

function ISPacketCountsList:prerender()
	self:setStencilRect(0, 0, self.width, self.height)

	local fontHgt = BUTTON_HGT

	local packetCounts = getPacketCounts(self.parent.category.selected, self.parent.type.selected, tonumber(self.parent.period:getInternalText()), self.parent.ordering, self.parent.priority, self.parent.reliability)
	if not packetCounts then return end

	local y = 0
	for name,count in pairs(packetCounts) do
		self:drawText(name.." ", 0, y, 1, 1, 1, 1, UIFont.Small)
		self:drawTextRight(count, self.width - UI_BORDER_SPACING*2, y, 1, 1, 1, 1, UIFont.Small)
		y = y + fontHgt
	end

	self:setScrollHeight(y)
	self:clearStencilRect();
end

function ISPacketCountsList:onMouseWheel(del)
	local fontHgt = getTextManager():getFontFromEnum(UIFont.Small):getLineHeight()
	self:setYScroll(self:getYScroll() - (del * fontHgt * 4))
	return true
end

function ISPacketCountsList:new(x, y, width, height)
	local o = ISPanel:new(x, y, width, height)
	setmetatable(o, self)
	self.__index = self
	return o
end

-----

function ISPacketCounts:createChildren()
	local btnWid = (self.width - UI_BORDER_SPACING*4) / 3
	local y = UI_BORDER_SPACING
	local x = UI_BORDER_SPACING

	self.category = ISComboBox:new(x, y, btnWid + 40, BUTTON_HGT, self, self.onSelectCategory)
	self.category:initialise()
	self.category:addOption("Server (packets from all clients)")
	self.category:addOption("Client (packets from the server)")
	self:addChild(self.category)

	self.type = ISComboBox:new(btnWid+40+UI_BORDER_SPACING*2, y, btnWid-40, BUTTON_HGT, self, self.onSelectType)
	self.type:initialise()
	self.type:addOption("Income packets")
	self.type:addOption("Outcome packets")
	self.type:addOption("Income bytes")
	self.type:addOption("Outcome bytes")
	self.type:addOption("Income time")
	self.type:addOption("Outcome time")
	self:addChild(self.type)

	y = self.category:getBottom() + UI_BORDER_SPACING
	self.listbox = ISPacketCountsList:new(x, y, btnWid*2+UI_BORDER_SPACING, self.height - UI_BORDER_SPACING*2 - BUTTON_HGT - y - 1)
	self.listbox:initialise()
	self.listbox:instantiate()
	self:addChild(self.listbox)
	self.listbox:addScrollBars()

	y = self.type:getBottom() + UI_BORDER_SPACING
	x = (self.width-UI_BORDER_SPACING*3)*2/3 + UI_BORDER_SPACING*2

	self.tickBoxOrdering = ISTickBox:new(x, y, btnWid, getTextManager():getFontHeight(UIFont.Small), "Ordering", self, self.onTicked)
	self.tickBoxOrdering.choicesColor = {r=1, g=1, b=1, a=1}
	self.tickBoxOrdering:setFont(UIFont.Small)
	self:addChild(self.tickBoxOrdering)
	self.tickBoxOrdering:addOption(getText("General"));
	self.tickBoxOrdering:setSelected(1, true)
	self.tickBoxOrdering:addOption(getText("Item"));
	self.tickBoxOrdering:setSelected(2, true)
	self.tickBoxOrdering:addOption(getText("Customization"));
	self.tickBoxOrdering:setSelected(3, true)
	self.tickBoxOrdering:addOption(getText("Object"));
	self.tickBoxOrdering:setSelected(4, true)
	self.tickBoxOrdering:addOption(getText("Map"));
	self.tickBoxOrdering:setSelected(5, true)
	self.tickBoxOrdering:addOption(getText("Player"));
	self.tickBoxOrdering:setSelected(6, true)
	self.tickBoxOrdering:addOption(getText("Zombie"));
	self.tickBoxOrdering:setSelected(7, true)
	self.tickBoxOrdering:addOption(getText("Animal"));
	self.tickBoxOrdering:setSelected(8, true)
	self.tickBoxOrdering:addOption(getText("Vehicle"));
	self.tickBoxOrdering:setSelected(9, true)

	y = self.tickBoxOrdering:getBottom() + BUTTON_HGT

	self.tickBoxPriority = ISTickBox:new(x, y, btnWid, getTextManager():getFontHeight(UIFont.Small), "Priority", self, self.onTicked)
	self.tickBoxPriority.choicesColor = {r=1, g=1, b=1, a=1}
	self.tickBoxPriority:setFont(UIFont.Small)
	self:addChild(self.tickBoxPriority)
	self.tickBoxPriority:addOption(getText("IMMEDIATE"));
	self.tickBoxPriority:setSelected(1, true)
	self.tickBoxPriority:addOption(getText("HIGH"));
	self.tickBoxPriority:setSelected(2, true)
	self.tickBoxPriority:addOption(getText("MEDIUM"));
	self.tickBoxPriority:setSelected(3, true)
	self.tickBoxPriority:addOption(getText("LOW"));
	self.tickBoxPriority:setSelected(4, true)

	y = self.tickBoxPriority:getBottom() + BUTTON_HGT

	self.tickBoxReliability = ISTickBox:new(x, y, btnWid, getTextManager():getFontHeight(UIFont.Small), "Reliability", self, self.onTicked)
	self.tickBoxReliability.choicesColor = {r=1, g=1, b=1, a=1}
	self.tickBoxReliability:setFont(UIFont.Small)
	self:addChild(self.tickBoxReliability)
	self.tickBoxReliability:addOption(getText("UNRELIABLE"));
	self.tickBoxReliability:setSelected(1, true)
	self.tickBoxReliability:addOption(getText("UNRELIABLE_SEQUENCED"));
	self.tickBoxReliability:setSelected(2, true)
	self.tickBoxReliability:addOption(getText("RELIABLE"));
	self.tickBoxReliability:setSelected(3, true)
	self.tickBoxReliability:addOption(getText("RELIABLE_ORDERED"));
	self.tickBoxReliability:setSelected(4, true)
	self.tickBoxReliability:addOption(getText("RELIABLE_SEQUENCED"));
	self.tickBoxReliability:setSelected(5, true)

	x = self.width-UI_BORDER_SPACING-btnWid/2-BUTTON_HGT/2
	y = UI_BORDER_SPACING

	self.plusBtn = ISButton:new(x - BUTTON_HGT - UI_BORDER_SPACING, y, BUTTON_HGT, BUTTON_HGT, "+", self, self.onClickPlus)
	self.plusBtn:initialise();
	self.plusBtn:instantiate();
	self:addChild(self.plusBtn)

	self.period = ISTextEntryBox:new("1", x, y, BUTTON_HGT, BUTTON_HGT)
	self.period:initialise();
	self.period:instantiate();
	self.period.font = UIFont.Medium
	self.period:setOnlyNumbers(true);
	self.period:setEditable(false);
	self:addChild(self.period)

	self.minusBtn = ISButton:new(x + BUTTON_HGT + UI_BORDER_SPACING, y, BUTTON_HGT, BUTTON_HGT, "-", self, self.onClickMinus)
	self.minusBtn:initialise();
	self.minusBtn:instantiate();
	self:addChild(self.minusBtn)

	self.clear = ISButton:new(UI_BORDER_SPACING, self.height - UI_BORDER_SPACING - BUTTON_HGT, btnWid, BUTTON_HGT, "CLEAR", self, self.onClear)
	self.clear.anchorTop = false
	self.clear.anchorBottom = true
	self.clear:initialise()
	self.clear:instantiate()
	self.clear.borderColor = {r=0.4, g=0.4, b=0.4, a=0.8}
	self:addChild(self.clear)

	self.close = ISButton:new(self.width - UI_BORDER_SPACING - btnWid, self.height - UI_BORDER_SPACING - BUTTON_HGT, btnWid, BUTTON_HGT, "CLOSE", self, self.onClose)
	self.close.anchorTop = false
	self.close.anchorBottom = true
	self.close:initialise()
	self.close:instantiate()
	self.close.borderColor = {r=0.4, g=0.4, b=0.4, a=0.8}
	self:addChild(self.close)
end

function ISPacketCounts:render()
	ISPacketCounts.instance = self -- for script reloading
	ISPanel.render(self)
end

function ISPacketCounts:onSelectCategory()
end

function ISPacketCounts:onSelectType()
end

function ISPacketCounts:onClear()
	clearPacketCounts(self.category.selected, self.type.selected, tonumber(self.period:getInternalText()))
end

function ISPacketCounts:onClickMinus()
	local currentTime = tonumber(self.period:getInternalText());
	if currentTime > 1 then
		currentTime = currentTime - 1;
	end
	self.period:setText(currentTime .. "");
	self:onClear()
end

function ISPacketCounts:onClickPlus()
	local currentTime = tonumber(self.period:getInternalText());
	if currentTime < 10 then
		currentTime = currentTime + 1;
	end
	self.period:setText(currentTime .. "");
	self:onClear()
end

function ISPacketCounts:onTicked(index, selected)

	self.ordering = 0
	if self.tickBoxOrdering.selected[1] then
		self.ordering = self.ordering + 1
	end
	if self.tickBoxOrdering.selected[2] then
		self.ordering = self.ordering + 2
	end
	if self.tickBoxOrdering.selected[3] then
		self.ordering = self.ordering + 4
	end
	if self.tickBoxOrdering.selected[4] then
		self.ordering = self.ordering + 8
	end
	if self.tickBoxOrdering.selected[5] then
		self.ordering = self.ordering + 16
	end
	if self.tickBoxOrdering.selected[6] then
		self.ordering = self.ordering + 32
	end
	if self.tickBoxOrdering.selected[7] then
		self.ordering = self.ordering + 64
	end
	if self.tickBoxOrdering.selected[8] then
		self.ordering = self.ordering + 128
	end
	if self.tickBoxOrdering.selected[9] then
		self.ordering = self.ordering + 256
	end

	self.priority = 0
	if self.tickBoxPriority.selected[1] then
		self.priority = self.priority + 1
	end
	if self.tickBoxPriority.selected[2] then
		self.priority = self.priority + 2
	end
	if self.tickBoxPriority.selected[3] then
		self.priority = self.priority + 4
	end
	if self.tickBoxPriority.selected[4] then
		self.priority = self.priority + 8
	end

	self.reliability = 0
	if self.tickBoxReliability.selected[1] then
		self.reliability = self.reliability + 1
	end
	if self.tickBoxReliability.selected[2] then
		self.reliability = self.reliability + 2
	end
	if self.tickBoxReliability.selected[3] then
		self.reliability = self.reliability + 4
	end
	if self.tickBoxReliability.selected[4] then
		self.reliability = self.reliability + 8
	end
	if self.tickBoxReliability.selected[5] then
		self.reliability = self.reliability + 16
	end
end

function ISPacketCounts:onClose()
	self:closeSelf()
end

function ISPacketCounts:closeSelf()
	self:setVisible(false)
	self:removeFromUIManager()
end

function ISPacketCounts:new(x, y, width, height)
	local o = ISPanel:new(x, y, width, height)
	setmetatable(o, self)
	self.__index = self
	o.borderColor = {r=0.4, g=0.4, b=0.4, a=1}
	o.backgroundColor = {r=0, g=0, b=0, a=0.8}
	o.moveWithMouse = true
	o.ordering = 511
	o.priority = 15
	o.reliability = 31
	ISPacketCounts.instance = o
	return o
end

