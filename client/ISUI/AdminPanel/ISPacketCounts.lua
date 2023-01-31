--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

ISPacketCounts = ISPanel:derive("ISPacketCounts")
ISPacketCountsList = ISPanel:derive("ISPacketCountsPanel")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)

function ISPacketCountsList:prerender()
--	self:drawRect(0, -self:getYScroll(), self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b)
	self:setStencilRect(0, 0, self.width, self.height)

	local fontHgt = FONT_HGT_SMALL

	local packetCounts = getPacketCounts(self.parent.category.selected)
	if not packetCounts then return end
	
	local x = 0
	local y = 0

	i = 0
	for name,count in pairs(packetCounts) do
		i = i + 1
		if self.parent.currentCounts[name] ~= packetCounts[name] then
			self:drawText(name..": ", x, y, 0, 1, 0, 1, UIFont.Small)
			self:drawTextRight(count, x + (self.width - 0) / 4 - 20, y, 0, 1, 0, 1, UIFont.Small)
		else
			self:drawText(name..": ", x, y, 1, 1, 1, 1, UIFont.Small)
			self:drawTextRight(count, x + (self.width - 0) / 4 - 20, y, 1, 1, 1, 1, UIFont.Small)
		end
		y = y + fontHgt
		if i > 0 and i % 64 == 0 then
			y = 0
			x = x + (self.width - 0) / 4
		end
	end

	self:setScrollHeight(fontHgt * 64)
	self:clearStencilRect();
end

function ISPacketCountsList:onMouseWheel(del)
	local fontHgt = getTextManager():getFontFromEnum(UIFont.Small):getLineHeight()
	self:setYScroll(self:getYScroll() - (del * fontHgt * 4))
	return true
end

function ISPacketCountsList:new(x, y, width, height)
	o = ISPanel:new(x, y, width, height)
	setmetatable(o, self)
	self.__index = self
	return o
end

-----

function ISPacketCounts:createChildren()
	local btnWid = 100
	local btnHgt = math.max(25, FONT_HGT_SMALL + 3 * 2)

	self.category = ISComboBox:new(20, 20, 400, FONT_HGT_SMALL + 2 * 2, self, self.onSelectCategory)
	self.category:initialise()
	self.category:addOption("Server: Packets from all clients")
	self.category:addOption("Client: Packets from server")
	self:addChild(self.category)

	local y = self.category:getBottom() + 10
	self.listbox = ISPacketCountsList:new(20, y, self.width - 20 * 2, self.height - 20 - btnHgt - y)
	self.listbox:initialise()
	self.listbox:instantiate()
	self:addChild(self.listbox)
	self.listbox:addScrollBars()

	self.update = ISButton:new(self.width - 20 - btnWid - 20 - btnWid, self.height - 10 - btnHgt,
		btnWid, btnHgt, "UPDATE", self, self.onUpdate)
	self.update.anchorTop = false
	self.update.anchorBottom = true
	self.update:initialise()
	self.update:instantiate()
	self.update.borderColor = {r=0.4, g=0.4, b=0.4, a=0.9}
	self:addChild(self.update)

	self.close = ISButton:new(self.width - 20 - btnWid, self.height - 10 - btnHgt,
		btnWid, btnHgt, getText("UI_btn_close"), self, self.onClose)
	self.close.anchorTop = false
	self.close.anchorBottom = true
	self.close:initialise()
	self.close:instantiate()
	self.close.borderColor = {r=0.4, g=0.4, b=0.4, a=0.9}
	self:addChild(self.close)

	self:onUpdate()
end

function ISPacketCounts:render()
	ISPacketCounts.instance = self -- for script reloading
	ISPanel.render(self)
end

function ISPacketCounts:onSelectCategory()
	self:onUpdate()
end

function ISPacketCounts:onUpdate()
	local packetCounts = getPacketCounts(self.category.selected)
	for name,count in pairs(packetCounts) do
		self.currentCounts[name] = count
	end
	if self.category.selected == 1 then
		requestPacketCounts()
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
	o = ISPanel:new(x, y, width, height)
	setmetatable(o, self)
	self.__index = self
	o.borderColor = {r=0.4, g=0.4, b=0.4, a=1}
	o.backgroundColor = {r=0, g=0, b=0, a=0.8}
	o.moveWithMouse = true
	o.currentCounts = {}
	ISPacketCounts.instance = o
	return o
end

