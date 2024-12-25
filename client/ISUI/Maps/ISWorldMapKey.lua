--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISPanel"
require "ISUI/Maps/ISMap"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

ISWorldMapKey = ISPanel:derive("ISWorldMapKey")

-----
function ISWorldMapKey:createChildren()
	table.insert(self.key, self.key1)
	table.insert(self.key, self.key2)
	table.insert(self.key, self.key3)
	table.insert(self.key, self.key4)
	table.insert(self.key, self.key5)
	table.insert(self.key, self.key6)
	table.insert(self.key, self.key7)
	table.insert(self.key, self.key8)
end

function ISWorldMapKey:prerender()
	ISPanel.prerender(self)
	self:drawText(getText("IGUI_Map_Key"), self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_Map_Key")) / 2), UI_BORDER_SPACING+1, 1,1,1,1, UIFont.Medium)
end

function ISWorldMapKey:render()
	ISPanel.render(self)
	local y = FONT_HGT_MEDIUM+UI_BORDER_SPACING*2+1
	local x = UI_BORDER_SPACING+1
	local texWidth = math.max(BUTTON_HGT*2, 64)
	local texHeight = math.max(BUTTON_HGT, 32)

	local keyImagePath = self.keyImagePath
	if getCore():getOptionColorblindPatterns() then
		keyImagePath = keyImagePath .. "Colorblind Patterns/"
	end

	for i = 1, 8 do
		self:drawTextureScaled(getTexture(keyImagePath .. "Key_" .. self.key[i] .. (self.iso and "_iso" or "") .. ".png"), x, y, texWidth, texHeight, 1, 1, 1, 1);
		self:drawText(getText("IGUI_Map_" .. self.key[i]), x + texWidth + UI_BORDER_SPACING, y + ((texHeight - FONT_HGT_SMALL)/2), 1,1,1,1, UIFont.Small)
		self:setWidth(math.max(self.width, x*2 + texWidth + getTextManager():MeasureStringX(UIFont.Medium, "IGUI_Map_" .. self.key[i])))
		y = y + texHeight + UI_BORDER_SPACING
	end

	self:setHeight(y + 1)
end

function ISWorldMapKey:onMouseDownMap(x, y)
	return false
end

function ISWorldMapKey:onMouseUpMap(x, y)
	return false
end

function ISWorldMapKey:onMouseMoveMap(x, y)
	return false
end

function ISWorldMapKey:onRightMouseDownMap(x, y)
	return false
end

function ISWorldMapKey:onRightMouseUpMap(x, y)
	return false
end

function ISWorldMapKey:undisplay()
end

function ISWorldMapKey:setIso(bool)
	self.iso = bool
end

function ISWorldMapKey:getIso()
	return self.iso
end

function ISWorldMapKey:new(x, y, width, height, mapUI)
	local o = ISPanel.new(self, x, y, width, height)
	o.borderColor = {r=0.4, g=0.4, b=0.4, a=1}
	o.backgroundColor = {r=0, g=0, b=0, a=0.8}
	o.character = mapUI.character
	o.playerNum = mapUI.playerNum or 0

	o.keyImagePath = "media/textures/worldMap/"
	o.iso = false
	o.key = {}
	o.key1 = "Community"
	o.key2 = "Hospitality"
	o.key3 = "Industrial"
	o.key4 = "Medical"
	o.key5 = "Parks"
	o.key6 = "Residential"
	o.key7 = "RestaurantsEntertainment"
	o.key8 = "RetailCommercial"
	return o
end
