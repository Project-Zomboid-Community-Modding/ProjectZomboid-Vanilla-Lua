--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

ISPacketCounts = ISPanel:derive("ISPacketCounts")
ISPacketCountsList = ISPanel:derive("ISPacketCountsPanel")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

function ISPacketCountsList:prerender()
	--	self:drawRect(0, -self:getYScroll(), self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b)
	self:setStencilRect(0, 0, self.width, self.height)

	local fontHgt = BUTTON_HGT

	local packetCounts = getPacketCounts(self.parent.category.selected)
	if not packetCounts then return end


	local columnAmount = 3
	local colSize = {0, 0, 0}
	local temp = 0, 0, 0, 0
	i = 0
	for name,_ in pairs(packetCounts) do
		i = i + 1
		temp = getTextManager():MeasureStringX(UIFont.Small, name)
		colSize[(i % columnAmount) + 1] = math.max(colSize[(i % columnAmount) + 1], temp + UI_BORDER_SPACING*3 + getTextManager():MeasureStringX(UIFont.Small, "9999"))
	end

	local x = 0
	local y = 0
	i = 0
	for name,count in pairs(packetCounts) do
		i = i + 1
		if self.parent.currentCounts[name] ~= packetCounts[name] then
			self:drawText(name..": ", x, y, 0, 1, 0, 1, UIFont.Small)
			self:drawTextRight(count, x + colSize[(i % columnAmount) + 1] - UI_BORDER_SPACING*2, y, 0, 1, 0, 1, UIFont.Small)
		else
			self:drawText(name..": ", x, y, 1, 1, 1, 1, UIFont.Small)
			self:drawTextRight(count, x + colSize[(i % columnAmount) + 1] - UI_BORDER_SPACING*2, y, 1, 1, 1, 1, UIFont.Small)
		end
		x = x + colSize[(i % columnAmount) + 1]
		if i > 0 and i % columnAmount == 0 then
			x = 0
			y = y + fontHgt
		end
	end

	self:setScrollHeight(y)
	self:setWidth(colSize[1]+colSize[2]+colSize[3])
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
	local btnWid = 150

	self.category = ISComboBox:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, 400, BUTTON_HGT, self, self.onSelectCategory)
	self.category:initialise()
	self.category:addOption("Server: Packets from all clients")
	self.category:addOption("Client: Packets from server")
	self:addChild(self.category)

	local y = self.category:getBottom() + UI_BORDER_SPACING
	self.listbox = ISPacketCountsList:new(UI_BORDER_SPACING+1, y, self.width - (UI_BORDER_SPACING+1)*2, self.height - UI_BORDER_SPACING*2 - BUTTON_HGT - y - 1)
	self.listbox:initialise()
	self.listbox:instantiate()
	self:addChild(self.listbox)
	self.listbox:addScrollBars()

	self.close = ISButton:new(self.width - UI_BORDER_SPACING - btnWid - 1, self.height - UI_BORDER_SPACING - BUTTON_HGT-1,
		btnWid, BUTTON_HGT, getText("UI_btn_close"), self, self.onClose)
	self.close.anchorTop = false
	self.close.anchorBottom = true
	self.close:initialise()
	self.close:instantiate()
	self.close.borderColor = {r=0.4, g=0.4, b=0.4, a=0.8}
	self:addChild(self.close)

	self.update = ISButton:new(self.width - UI_BORDER_SPACING - btnWid - self.close.x, self.close.y, btnWid, BUTTON_HGT, "UPDATE", self, self.onUpdate)
	self.update.anchorTop = false
	self.update.anchorBottom = true
	self.update:initialise()
	self.update:instantiate()
	self.update.borderColor = {r=0.4, g=0.4, b=0.4, a=0.8}
	self:addChild(self.update)

	self:onUpdate()
end

function ISPacketCounts:render()
	ISPacketCounts.instance = self -- for script reloading
	ISPanel.render(self)
	self:setWidth(self.listbox.width + (UI_BORDER_SPACING+1)*2)
	self.close:setX(self.width - UI_BORDER_SPACING - 150 - 1)
	self.update:setX(self.close.x - UI_BORDER_SPACING - 150)
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

