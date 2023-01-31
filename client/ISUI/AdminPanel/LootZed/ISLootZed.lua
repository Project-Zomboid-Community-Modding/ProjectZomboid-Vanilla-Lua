--***********************************************************
--**              	  ROBERT JOHNSON                       **
--***********************************************************

ISLootZed = ISPanelJoypad:derive("ISLootZed");
ISLootZed.instance = nil
ISLootZed.cheat = false

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local FONT_HGT_LARGE = getTextManager():getFontHeight(UIFont.Large)
local HEADER_HGT = FONT_HGT_MEDIUM + 2 * 2

function ISLootZed:initialise()
	ISPanelJoypad.initialise(self);
	
	local fontHgt = FONT_HGT_SMALL
	local buttonWid1 = getTextManager():MeasureStringX(UIFont.Small, "Ok") + 12
	local buttonWid2 = getTextManager():MeasureStringX(UIFont.Small, "Cancel") + 12
	local buttonWid = math.max(math.max(buttonWid1, buttonWid2), 100)
	local buttonHgt = math.max(fontHgt + 6, 25)
	local padBottom = 10

    local btnHgt = math.max(25, FONT_HGT_SMALL + 3 * 2)
    local entryHgt = FONT_HGT_MEDIUM + 2 * 2
    local bottomHgt = 5 + FONT_HGT_SMALL * 2 + 5 + btnHgt + 20 + FONT_HGT_LARGE + HEADER_HGT + entryHgt
	
	self.no = ISButton:new((self:getWidth() / 2) - buttonWid/2, self:getHeight() - padBottom - buttonHgt, buttonWid, buttonHgt, getText("UI_Close"), self, ISLootZed.onClick);
	self.no.internal = "CANCEL";
	self.no:initialise();
	self.no:instantiate();
	self.no.borderColor = {r=1, g=1, b=1, a=0.1};
	self:addChild(self.no);

    self.datas = ISScrollingListBox:new(0, HEADER_HGT, self.width, self.height - bottomHgt - HEADER_HGT);
    self.datas:initialise();
    self.datas:instantiate();
    self.datas.itemheight = FONT_HGT_SMALL + 4 * 2
    self.datas.selected = 0;
    self.datas.joypadParent = self;
    self.datas.font = UIFont.NewSmall;
    self.datas.doDrawItem = self.drawDatas;
    self.datas.drawBorder = true;
    self.datas:addColumn("Type", 0);
    self.datas:addColumn("Name", 250);
    self.datas:addColumn("Chance", 500);
    self:addChild(self.datas);

	self.searchEntryBox = ISTextEntryBox:new('', self.width - 260 - 250, self.height - 146, 200, 20)
	self.searchEntryBox.font = UIFont.Small
	self.searchEntryBox.onTextChange = ISLootZed.onTextChange
	self:addChild(self.searchEntryBox)

	self.playerSelect = ISComboBox:new(self.width - 260, self.height - 150, 250, math.max(25, FONT_HGT_SMALL + 3 * 2), self, self.onSelectContainerType)
    self.playerSelect:initialise()
	for name, _ in pairs(LootZedTool.SpawnItemCheckerList) do
		self.playerSelect:addOption(name)	
	end
    self:addChild(self.playerSelect)
end

function ISLootZed:onTextChange()
	ISLootZed.instance:onSelectContainerType()
end

function ISLootZed:onSelectContainerType()
	self.datas:clear()
	local contType = self.playerSelect.options[self.playerSelect.selected]
	local searchText = self.searchEntryBox:getInternalText()

	if LootZedTool.SpawnItemCheckerList[contType] ~= nil then
		for name, chance in pairs(LootZedTool.SpawnItemCheckerList[contType]) do
			local scriptItem = getScriptManager():FindItem(name)
			if searchText == "" or (string.contains(string.lower(name), string.lower(searchText)) or (scriptItem ~= nil and string.contains(string.lower(scriptItem:getDisplayName()), string.lower(searchText)))) then
				self.datas:addItem(name, chance)
			end
		end
		table.sort(self.datas.items, function(a,b) 
			if a.item > b.item then
				return true
			end
			return false
		end);
	end
end

function ISLootZed:update()
    self.datas.doDrawItem = self.drawDatas;
end

function ISLootZed:drawDatas(y, item, alt)
    if y + self:getYScroll() + self.itemheight < 0 or y + self:getYScroll() >= self.height then
        return y + self.itemheight
    end
    
    local a = 0.9;

    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight, 0.3, 0.7, 0.35, 0.15);
    end

    if alt then
        self:drawRect(0, (y), self:getWidth(), self.itemheight, 0.3, 0.6, 0.5, 0.5);
    end

    self:drawRectBorder(0, (y), self:getWidth(), self.itemheight, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    local iconX = 4
    local iconSize = FONT_HGT_SMALL;
    local xoffset = 10;

    local clipX = self.columns[1].size
    local clipX2 = self.columns[2].size
    local clipY = math.max(0, y + self:getYScroll())
    local clipY2 = math.min(self.height, y + self:getYScroll() + self.itemheight)
    
    self:setStencilRect(clipX, clipY, clipX2 - clipX, clipY2 - clipY)
    self:drawText(item.text, xoffset, y + 4, 1, 1, 1, a, self.font);
    self:clearStencilRect()

    clipX = self.columns[2].size
    clipX2 = self.columns[3].size
    self:setStencilRect(clipX, clipY, clipX2 - clipX, clipY2 - clipY)
	local scriptItem = getScriptManager():FindItem(item.text)
	if scriptItem ~= nil then
	    self:drawText(scriptItem:getDisplayName(), self.columns[2].size + iconX + iconSize + 4, y + 4, 1, 1, 1, a, self.font);
	end
    self:clearStencilRect()

    clipX = self.columns[3].size
    clipX2 = 750
    self:setStencilRect(clipX, clipY, clipX2 - clipX, clipY2 - clipY)
    self:drawText((item.item*100) .. "%", self.columns[3].size + xoffset, y + 4, 1, 1, 1, a, self.font);
    self:clearStencilRect()

    self:repaintStencilRect(0, clipY, self.width, clipY2 - clipY)

	if scriptItem ~= nil then
		local icon = scriptItem:getIcon()
		if scriptItem:getIconsForTexture() and not scriptItem:getIconsForTexture():isEmpty() then
			icon = scriptItem:getIconsForTexture():get(0)
		end
		if icon then
			local texture = getTexture("Item_" .. icon)
			if texture then
				self:drawTextureScaledAspect2(texture, self.columns[2].size + iconX, y + (self.itemheight - iconSize) / 2, iconSize, iconSize,  1, 1, 1, 1);
			end
		end
	end

    return y + self.itemheight;
end

function ISLootZed:destroy()
	self:setVisible(false);
end

function ISLootZed:onClick(button)
	if button.internal == "CANCEL" then
		self:destroy();
		return;
	end
end

function ISLootZed:titleBarHeight()
	return 16
end

function ISLootZed:prerender()
	self.backgroundColor.a = 0.8
	
	self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
	
	local th = self:titleBarHeight()
	self:drawTextureScaled(self.titlebarbkg, 2, 1, self:getWidth() - 4, th - 2, 1, 1, 1, 1);
	
	self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
	
    self:drawText("Room name: " .. LootZedTool.SpawnItemChecker.roomName, 10, self.height - 130, 1, 1, 1, 1, UIFont.Medium);
    self:drawText("Force for Items: " .. LootZedTool.SpawnItemChecker.forceForItems, 10, self.height - 110, 1, 1, 1, 1, UIFont.Medium);
    self:drawText("Force for Zones: " .. LootZedTool.SpawnItemChecker.forceForZones, 10, self.height - 90, 1, 1, 1, 1, UIFont.Medium);
    self:drawText("Force for Tiles: " .. LootZedTool.SpawnItemChecker.forceForTiles, 10, self.height - 70, 1, 1, 1, 1, UIFont.Medium);
    self:drawText("Force for Rooms: " .. LootZedTool.SpawnItemChecker.forceForRooms, 10, self.height - 50, 1, 1, 1, 1, UIFont.Medium);

	self:updateButtons();
end

function ISLootZed:updateButtons()
end

function ISLootZed:render()
end

function ISLootZed:onMouseMove(dx, dy)
	self.mouseOver = true
	if self.moving then
		self:setX(self.x + dx)
		self:setY(self.y + dy)
		self:bringToTop()
	end
end

function ISLootZed:onMouseMoveOutside(dx, dy)
	self.mouseOver = false
	if self.moving then
		self:setX(self.x + dx)
		self:setY(self.y + dy)
		self:bringToTop()
	end
end

function ISLootZed:onMouseDown(x, y)
	if not self:getIsVisible() then
		return
	end
	self.downX = x
	self.downY = y
	self.moving = true
	self:bringToTop()
end

function ISLootZed:onMouseUp(x, y)
	if not self:getIsVisible() then
		return;
	end
	self.moving = false
	if ISMouseDrag.tabPanel then
		ISMouseDrag.tabPanel:onMouseUp(x,y)
	end
	ISMouseDrag.dragView = nil
end

function ISLootZed:onMouseUpOutside(x, y)
	if not self:getIsVisible() then
		return
	end
	self.moving = false
	ISMouseDrag.dragView = nil
end

function ISLootZed:updateContent()
	self.playerSelect:clear()
	for name, _ in pairs(LootZedTool.SpawnItemCheckerList) do
		self.playerSelect:addOption(name)	
	end
	self.playerSelect.selected = 1
	
	self.datas:clear()
	local contType = self.playerSelect.options[self.playerSelect.selected]

	if LootZedTool.SpawnItemCheckerList[contType] ~= nil then
		for name, chance in pairs(LootZedTool.SpawnItemCheckerList[contType]) do
			self.datas:addItem(name, chance)
		end
		table.sort(self.datas.items, function(a,b) 
			if a.item > b.item then
				return true
			end
			return false
		end);
	end
end

function ISLootZed:new(width, height, player)
	local o = {}
	o = ISPanelJoypad:new(0, 0, width, height);
	setmetatable(o, self)
	self.__index = self

	o.x = getCore():getScreenWidth() / 2 - (width / 2);
	o.y = getCore():getScreenHeight() / 2 - (height / 2);
	o:setX(o.x)
	o:setY(o.y)

	o.name = nil;
	o.backgroundColor = {r=0, g=0, b=0, a=0.5};
	o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
	o.width = width;
	o.height = height;
	o.anchorLeft = true;
	o.anchorRight = true;
	o.anchorTop = true;
	o.anchorBottom = true;

	o.player = player;
	o.titlebarbkg = getTexture("media/ui/Panel_TitleBar.png");

    ISLootZed.instance = o

	return o;
end
