--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Time: 10:19
-- To change this template use File | Settings | File Templates.
--

require "ISUI/ISPanelJoypad"

ISLootStreetTestUI = ISCollapsableWindow:derive("ISLootStreetTestUI");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local SCROLL_BAR_WIDTH = 13

local TICK_BOX_LABEL_WIDTH = UI_BORDER_SPACING*3 + 1 + BUTTON_HGT + math.max(
		getTextManager():MeasureStringX(UIFont.Small, getText("Sandbox_LootOther")),
		getTextManager():MeasureStringX(UIFont.Small, getText("Sandbox_LootFood")),
		getTextManager():MeasureStringX(UIFont.Small, getText("Sandbox_LootCannedFood")),
		getTextManager():MeasureStringX(UIFont.Small, getText("Sandbox_LootWeapon")),
		getTextManager():MeasureStringX(UIFont.Small, getText("Sandbox_LootRangedWeapon")),
		getTextManager():MeasureStringX(UIFont.Small, getText("Sandbox_LootAmmo")),
		getTextManager():MeasureStringX(UIFont.Small, getText("Sandbox_LootLiterature")),
		getTextManager():MeasureStringX(UIFont.Small, getText("Sandbox_LootMedical"))
)

--************************************************************************--
--** ISLootStreetTestUI:initialise
--**
--************************************************************************--

function ISLootStreetTestUI:createChildren()
	local y = self:titleBarHeight() + UI_BORDER_SPACING+1
	local padBottom = self:resizeWidgetHeight() + UI_BORDER_SPACING-1

	ISCollapsableWindow.createChildren(self)

	local buttonWid = UI_BORDER_SPACING*2 + math.max(
			getTextManager():MeasureStringX(UIFont.Small, "Muldraugh"),
			getTextManager():MeasureStringX(UIFont.Small, "WestPoint"),
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_LootStressTest_HouseS")),
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_LootStressTest_HouseM")),
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_LootStressTest_HouseL"))
	)

	self.town = ISComboBox:new(UI_BORDER_SPACING+1, y, buttonWid, BUTTON_HGT)
	self.town.font = UIFont.Small
	self.town:initialise()
	self.town:instantiate()
	self:addChild(self.town)

	self.town:addOption("Muldraugh")
	self.town:addOption("Westpoint")
	--	self.town:addOption("Rosewood")

	self.houseType = ISComboBox:new(self.town:getRight() + UI_BORDER_SPACING, self.town.y, buttonWid, BUTTON_HGT)
	self.houseType.font = UIFont.Small
	self.houseType:initialise()
	self.houseType:instantiate()
	self:addChild(self.houseType)

	self.houseType:addOption(getText("IGUI_LootStressTest_HouseS"))
	self.houseType:addOption(getText("IGUI_LootStressTest_HouseM"))
	self.houseType:addOption(getText("IGUI_LootStressTest_HouseL"))

	self.houseNbr = ISTextEntryBox:new("1", self.houseType:getRight() + UI_BORDER_SPACING, self.houseType.y, 50, BUTTON_HGT);
	self.houseNbr:initialise();
	self.houseNbr:instantiate();
	self.houseNbr:setOnlyNumbers(true);
	self:addChild(self.houseNbr);

	self.onlyjunk = ISTickBox:new(self.houseNbr:getRight() + UI_BORDER_SPACING, self.town.y, 100, BUTTON_HGT, getText("IGUI_LootStressTest_OnlyJunk"))
	self.onlyjunk:initialise()
	self.onlyjunk:addOption(getText("IGUI_LootStressTest_OnlyJunk"), "onlyjunk")
	self:addChild(self.onlyjunk);

	self.lootType = ISTickBox:new(UI_BORDER_SPACING+1, self.town.y + BUTTON_HGT + UI_BORDER_SPACING, 100, BUTTON_HGT, "")
	--self.lootType.anchorLeft = false
	--self.lootType.anchorRight = true
	self.lootType:initialise()
	self.lootType:addOption(getText("Sandbox_LootOther"), "other")
	self.lootType:addOption(getText("Sandbox_LootFood"), "food")
	self.lootType:addOption(getText("Sandbox_LootCannedFood"), "cannedfood")
	self.lootType:addOption(getText("Sandbox_LootWeapon"), "meleeweapon")
	self.lootType:addOption(getText("Sandbox_LootRangedWeapon"), "rangedweapon")
	self.lootType:addOption(getText("Sandbox_LootAmmo"), "ammo")
	self.lootType:addOption(getText("Sandbox_LootLiterature"), "literature")
	self.lootType:addOption(getText("Sandbox_LootMedical"), "medical")

	for i=1,8 do
		self.lootType:setSelected(i, true);
	end

	self.lootType:setWidthToFit()
	self:addChild(self.lootType)

	self.richtext = ISRichTextPanel:new(TICK_BOX_LABEL_WIDTH, self.lootType.y, self.width - TICK_BOX_LABEL_WIDTH - UI_BORDER_SPACING-1, self.height - BUTTON_HGT - UI_BORDER_SPACING - padBottom - 1 - self.lootType.y);
	self.richtext.anchorLeft = true
	self.richtext.anchorRight = true
	self.richtext.anchorBottom = true
	self.richtext:initialise();
	self.richtext.autosetheight = false;
	self.richtext.clip = true
	self.richtext.background = false;
	self:addChild(self.richtext);
	self.richtext:addScrollBars();

	self.richtext.text = "";
	self.richtext:paginate();

	local bottomButtonWid = UI_BORDER_SPACING*2 + math.max(
			getTextManager():MeasureStringX(UIFont.Small, "IGUI_LootStressTest_Title"),
			getTextManager():MeasureStringX(UIFont.Small, "IGUI_DebugMenu_Close")
	)

	self.start = ISButton:new(UI_BORDER_SPACING, self:getHeight() - padBottom - BUTTON_HGT - 1, bottomButtonWid, BUTTON_HGT, getText("IGUI_LootStressTest_Title"), self, ISLootStreetTestUI.startGenerate);
	self.start.anchorTop = false
	self.start.anchorBottom = true
	self.start:initialise();
	self.start:instantiate();
	self:addChild(self.start);

	self.close = ISButton:new(self:getWidth() - bottomButtonWid - UI_BORDER_SPACING - 1, self.start:getY(), bottomButtonWid, BUTTON_HGT, getText("IGUI_DebugMenu_Close"), self, ISLootStreetTestUI.close);
	self.close.anchorLeft = false
	self.close.anchorRight = true
	self.close.anchorTop = false
	self.close.anchorBottom = true
	self.close:initialise();
	self.close:instantiate();
	self.close:enableCancelColor()
	self:addChild(self.close);
end

function ISLootStreetTestUI:startGenerate()
	self.richtext.text = "";
	self.kitchenProclist = {};
	self.kitchenContainer = ItemContainer.new("kitchen", self.chr:getCurrentSquare(), self.chr);
	self.bathroomContainer = ItemContainer.new("bathroom", self.chr:getCurrentSquare(), self.chr);
	self.bedroomContainer = ItemContainer.new("bedroom", self.chr:getCurrentSquare(), self.chr);
	self.shedContainer = ItemContainer.new("shed", self.chr:getCurrentSquare(), self.chr);
	self.totalList = {};
	self.totalList["food"] = {};
	self.totalList["meleeweapon"] = {};
	self.totalList["rangedweapon"] = {};

	for i=1, tonumber(self.houseNbr:getInternalText()) do
		self:generateBuilding();
	end

	self:doRichTextList(self.kitchenContainer, "Kitchen");
	self:doRichTextList(self.bathroomContainer, "Bathroom");
	self:doRichTextList(self.bedroomContainer, "Bedroom");

	if self.houseType.selected == 3 then
		self:doRichTextList(self.shedContainer, "Shed");
	end

	self.richtext:paginate();
end

function ISLootStreetTestUI:generateBuilding()
	-- kitchen
	self:doRoom(self.kitchenContainer, "kitchen", "counter", "KitchenDishes");
	self:doRoom(self.kitchenContainer, "kitchen", "counter", "KitchenPots");
	self:doRoom(self.kitchenContainer, "kitchen", "counter", "KitchenCannedFood");
	if self.houseType.selected > 1 then
		self:doRoom(self.kitchenContainer, "kitchen", "counter", self:getRandomKitchenCounter());
		self:doRoom(self.kitchenContainer, "kitchen", "shelves", "KitchenDishes");
		if self.houseType.selected == 3 then
			self:doRoom(self.kitchenContainer, "kitchen", "counter", self:getRandomKitchenCounter());
			self:doRoom(self.kitchenContainer, "kitchen", "shelves", "KitchenDryFood");
		end
	end

	-- bathroom
	self:doRoom(self.bathroomContainer, "bathroom", "counter", nil);
	if self.houseType.selected > 1 then
		self:doRoom(self.bathroomContainer, "bathroom", "counter", nil);
	end

	-- bedroom
	if self.houseType.selected == 1 then
		self:doRoom(self.bedroomContainer, "bedroom", "wardrobe", "WardrobeRedneck");
		self:doRoom(self.bedroomContainer, "bedroom", "wardrobe", "WardrobeRedneck");
	elseif self.houseType.selected == 2 then
		self:doRoom(self.bedroomContainer, "bedroom", "wardrobe", "WardrobeMan");
		self:doRoom(self.bedroomContainer, "bedroom", "wardrobe", "WardrobeWoman");
		self:doRoom(self.bedroomContainer, "bedroom", "wardrobe", "WardrobeChild");
	else
		self:doRoom(self.bedroomContainer, "bedroom", "wardrobe", "WardrobeManClassy");
		self:doRoom(self.bedroomContainer, "bedroom", "wardrobe", "WardrobeWomanClassy");
		self:doRoom(self.bedroomContainer, "bedroom", "wardrobe", "WardrobeChild");
		self:doRoom(self.bedroomContainer, "bedroom", "wardrobe", "WardrobeChild");
	end

	-- shed
	if self.houseType.selected == 3 then
		self:doRoom(self.shedContainer, "shed", "other", nil);
		self:doRoom(self.shedContainer, "shed", "other", nil);
	end
end

function ISLootStreetTestUI:concatList(list)
	local newlist = {};
	local nbr = 0;
	local counts = {};
	for i=0, list:getItems():size() - 1 do
		local item = list:getItems():get(i);
		if self:itemValidForList(item) then
			local name = item:getDisplayName();
			-- add if we got magazine in this weapon
			if instanceof(item, "HandWeapon") and item:isContainsClip() then
				name = name .. " (with mag)";
			end
			if counts[name] then
				counts[name] = counts[name] + 1;
			else
				table.insert(newlist, name);
				counts[name] = 1;
			end
			nbr = nbr + 1;
		end
	end
	table.sort(newlist, function(a,b) return not string.sort(a,b) end)
	return newlist, counts, nbr;
end

function ISLootStreetTestUI:itemValidForList(item)
	local type = item:getStringItemType();
	if type == "Other" and self.lootType:isSelected(1) then
		return true;
	elseif type == "Food" and self.lootType:isSelected(2) then
		return true;
	elseif type == "CannedFood" and self.lootType:isSelected(3) then
		return true;
	elseif type == "MeleeWeapon" and self.lootType:isSelected(4) then
		return true;
	elseif type == "RangedWeapon" and self.lootType:isSelected(5) then
		return true;
	elseif type == "Ammo" and self.lootType:isSelected(6) then
		return true;
	elseif type == "Literature" and self.lootType:isSelected(7) then
		return true;
	elseif type == "Medical" and self.lootType:isSelected(8) then
		return true;
	end

	return false;
end

function ISLootStreetTestUI:getRandomKitchenCounter()
	local nbr = ZombRand(4);
	if nbr == 0 then
		return "KitchenDryFood";
	elseif nbr == 1 then
		return "KitchenBreakfast";
	elseif nbr == 2 then
		return "KitchenBottles";
	else
		return "KitchenRandom";
	end
end

function ISLootStreetTestUI:doRichTextList(container, roomName)
	local list, counts, nbr = self:concatList(container);
	self.richtext.text = self.richtext.text .. " " .. roomName .. " ( " .. nbr .. " items): <LINE> ";
	for _,name in pairs(list) do
		self.richtext.text = self.richtext.text .. " <INDENT:10> " .. name .. " x" .. counts[name] .. " <LINE> ";
	end
	self.richtext.text = self.richtext.text .. " <INDENT:0> <LINE> ";
end

function ISLootStreetTestUI:doRoom(container, roomName, contName, procName)
	if not self.onlyjunk:isSelected(1) then
		local contdistrib = ItemPickerJava.getItemContainer(roomName, contName, procName, false);
		if contdistrib then
			ItemPickerJava.doRollItem(contdistrib, container, self:getLootDensity(), self.chr, true, false);
		end
	end
	local contdistrib = ItemPickerJava.getItemContainer(roomName, contName, procName, true);
	if contdistrib then
		ItemPickerJava.doRollItem(contdistrib, container, self:getLootDensity(), self.chr, true, false);
	end
end

function ISLootStreetTestUI:getLootDensity()
	-- Muldraugh
	if self.town.selected == 1 then
		if self.houseType.selected == 1 then
			return 1;
		elseif self.houseType.selected == 2 then
			return 4;
		else
			return 9;
		end
	elseif self.town.selected == 2 then -- WP
		if self.houseType.selected == 1 then
			return 4;
		elseif self.houseType.selected == 2 then
			return 8;
		else
			return 12;
		end
	end
end

function ISLootStreetTestUI:close()
	self:removeFromUIManager();
end

function ISLootStreetTestUI:update()
	ISCollapsableWindow.update(self);
end

function ISLootStreetTestUI:render()
	ISCollapsableWindow.render(self);

	local txt = "Kitchen: Counter x";
	if self.houseType.selected == 1 then
		txt = txt .. "3";
	elseif self.houseType.selected == 2 then
		txt = txt .. "4";
		txt = txt .. ", Shelves x1";
	else
		txt = txt .. "4";
		txt = txt .. ", Shelves x2";
	end

	txt = txt .. ";\nBathroom: Counter x";
	if self.houseType.selected == 1 then
		txt = txt .. "1";
	else
		txt = txt .. "2";
	end

	txt = txt .. ";\nBedroom: Wardrobe x";
	if self.houseType.selected == 1 then
		txt = txt .. "2 (Redneck)";
	elseif self.houseType.selected == 2 then
		txt = txt .. "3 (Normal + Kid)";
	else
		txt = txt .. "4 (Classy + Kid)";
	end

	if self.houseType.selected == 3 then
		txt = txt .. "\nShed: Counter x2";
	end
	self:drawText(txt, TICK_BOX_LABEL_WIDTH, self.town.y + self.town.height + 10, 1,1,1,1, UIFont.Small);
end

--************************************************************************--
--** ISLootStreetTestUI:new
--**
--************************************************************************--
function ISLootStreetTestUI:new(x, y, character)
	local o = {}
	local width = 1000;
	local height = 800;
	o = ISCollapsableWindow:new(x, y, width, height);
	setmetatable(o, self)
	self.__index = self
	o.playerNum = character:getPlayerNum()
	if y == 0 then
		o.y = getPlayerScreenTop(o.playerNum) + (getPlayerScreenHeight(o.playerNum) - height) / 2
		o:setY(o.y)
	end
	if x == 0 then
		o.x = getPlayerScreenLeft(o.playerNum) + (getPlayerScreenWidth(o.playerNum) - width) / 2
		o:setX(o.x)
	end
	o.width = width;
	o.height = height;
	o.title = "Generate Loot"
	o.character = character;
	o.chr = character;
	o.moveWithMouse = true;
	o.anchorLeft = true;
	o.anchorRight = true;
	o.anchorTop = true;
	o.anchorBottom = true;
	return o;
end
