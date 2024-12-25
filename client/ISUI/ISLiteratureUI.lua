--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISCollapsableWindowJoypad"
require "ISUI/ISScrollingListBox"
require "ISUI/ISTabPanel"

ISLiteratureUI = ISCollapsableWindowJoypad:derive("ISLiteratureUI")
ISLiteratureList = ISScrollingListBox:derive("ISListeratureList")
ISLiteratureMediaList = ISScrollingListBox:derive("ISListeratureMediaList")
ISLiteratureGrowingList = ISScrollingListBox:derive("ISListeratureGrowingList")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local LITERATURE_HIDDEN = {}

function ISLiteratureUI.SetItemHidden(fullType, hidden)
	if type(fullType) ~= 'string' or not string.contains(fullType, '.') then return end
	LITERATURE_HIDDEN[fullType] = hidden and true or nil
end

-- ISLiteratureUI.SetItemHidden('Base.BookBlacksmith1', true)
-- ISLiteratureUI.SetItemHidden('Base.BookBlacksmith2', true)
-- ISLiteratureUI.SetItemHidden('Base.BookBlacksmith3', true)
-- ISLiteratureUI.SetItemHidden('Base.BookBlacksmith4', true)
-- ISLiteratureUI.SetItemHidden('Base.BookBlacksmith5', true)
-- ISLiteratureUI.SetItemHidden('Base.SmithingMag1', true)
-- ISLiteratureUI.SetItemHidden('Base.SmithingMag2', true)
-- ISLiteratureUI.SetItemHidden('Base.SmithingMag3', true)
-- ISLiteratureUI.SetItemHidden('Base.SmithingMag4', true)

ISLiteratureUI.SetItemHidden('Base.CarrotBagSeed2_Empty', true)
ISLiteratureUI.SetItemHidden('Base.BroccoliBagSeed2_Empty', true)
ISLiteratureUI.SetItemHidden('Base.RedRadishBagSeed2_Empty', true)
ISLiteratureUI.SetItemHidden('Base.StrewberrieBagSeed2_Empty', true)
ISLiteratureUI.SetItemHidden('Base.TomatoBagSeed2_Empty', true)
ISLiteratureUI.SetItemHidden('Base.PotatoBagSeed2_Empty', true)
ISLiteratureUI.SetItemHidden('Base.CabbageBagSeed2_Empty', true)

ISLiteratureUI.SetItemHidden('Base.BasilBagSeed_Empty', true)
ISLiteratureUI.SetItemHidden('Base.ChivesBagSeed_Empty', true)
ISLiteratureUI.SetItemHidden('Base.CilantroBagSeed_Empty', true)
ISLiteratureUI.SetItemHidden('Base.CornBagSeed_Empty', true)
ISLiteratureUI.SetItemHidden('Base.GarlicBagSeed_Empty', true)
ISLiteratureUI.SetItemHidden('Base.GreenpeasBagSeed_Empty', true)
ISLiteratureUI.SetItemHidden('Base.KaleBagSeed_Empty', true)
ISLiteratureUI.SetItemHidden('Base.OnionBagSeed_Empty', true)
ISLiteratureUI.SetItemHidden('Base.OreganoBagSeed_Empty', true)
ISLiteratureUI.SetItemHidden('Base.ParsleyBagSeed_Empty', true)
ISLiteratureUI.SetItemHidden('Base.RosemaryBagSeed_Empty', true)
ISLiteratureUI.SetItemHidden('Base.SageBagSeed_Empty', true)
ISLiteratureUI.SetItemHidden('Base.SoybeansBagSeed_Empty', true)
ISLiteratureUI.SetItemHidden('Base.SweetPotatoBagSeed_Empty', true)
ISLiteratureUI.SetItemHidden('Base.ThymeBagSeed_Empty', true)
ISLiteratureUI.SetItemHidden('Base.WheatBagSeed_Empty', true)

-----

function ISLiteratureList:doDrawItem(y, item, alt)
	local metaKnowledge = getSandboxOptions():getOptionByName("MetaKnowledge"):getValue()
	if item.height == 0 then
		item.height = BUTTON_HGT -- this is needed, otherwise items don't draw in the list properly
	end
	if y + self:getYScroll() >= self.height then return y + item.height end
	if y + item.height + self:getYScroll() <= 0 then return y + item.height end
--[[
	if self.selected == item.index then
		self:drawRect(0, y, self:getWidth(), item.height-1, 0.3, 0.7, 0.35, 0.15)
	end
--]]

	local r,g,b,a = 0.5,0.5,0.5,1.0
	local itemPadY = (item.height - self.fontHgt) / 2
	local texture
	if type(item.item) ~= "string" then -- not a recipe
		texture = item.item:getNormalTexture()
		local skillBook = SkillBook[item.item:getSkillTrained()]
		if skillBook then
			if (item.item:getNumberOfPages() > 0) and (self.character:getAlreadyReadPages(item.item:getFullName()) == item.item:getNumberOfPages()) then
				r,g,b = 1.0,1.0,1.0
			elseif item.item:getMaxLevelTrained() <= self.character:getPerkLevel(skillBook.perk) + 1 then
				-- The book hasn't been read, but the character has the skill levels.
				r,g,b = 1.0,1.0,1.0
			end
		else
			if self.character:getAlreadyReadBook():contains(item.item:getFullName()) then
				r,g,b = 1.0,1.0,1.0
			elseif (item.item:getTeachedRecipes() ~= nil) and self.character:getKnownRecipes():containsAll(item.item:getTeachedRecipes()) then
				r,g,b = 1.0,1.0,1.0
			end
		end
	else -- recipe, we handle this differently
		if self.character:getKnownRecipes():contains(item.item) then
			r,g,b = 1.0,1.0,1.0
		end
	end
	if r ~= 1 and metaKnowledge == 3 then
		return y
	else
		self:drawRectBorder(0, y, self:getWidth(), item.height, 0.5, self.borderColor.r, self.borderColor.g, self.borderColor.b)
		if texture then
			local texWidth = texture:getWidthOrig()
			local texHeight = texture:getHeightOrig()
			local a = 1
			if texWidth <= 32 and texHeight <= 32 then
				self:drawTexture(texture,6+(32-texWidth)/2,y+(item.height-texHeight)/2,a,1,1,1)
			else
				self:drawTextureScaledAspect(texture,6,y+(item.height-texHeight)/2,32,32,a,1,1,1)
			end
		end
		if r == 1 or metaKnowledge == 1 then
			self:drawText(Translator.getRecipeName(item.text), 6 + 32 + 6, y+itemPadY, r, g, b, a, self.font)
		else
			self:drawText("???", 6 + 32 + 6, y+itemPadY, r, g, b, a, self.font)
		end
	end

	y = y + item.height
	return y;
end

function ISLiteratureList:new(x, y, width, height, character)
	local o = ISScrollingListBox.new(self, x, y, width, height)
	o.character = character
	return o
end

-----

function ISLiteratureMediaList:doDrawItem(y, item, alt)
	local metaKnowledge = getSandboxOptions():getOptionByName("MetaKnowledge"):getValue()
	if not getZomboidRadio():getRecordedMedia():hasListenedToAll(self.character, item.item) and metaKnowledge == 3 then
		return y
	end
	if item.height == 0 then
		item.height = BUTTON_HGT -- this is needed, otherwise items don't draw in the list properly
	end

	if y + self:getYScroll() >= self.height then return y + item.height end
	if y + item.height + self:getYScroll() <= 0 then return y + item.height end

	self:drawRectBorder(0, y, self:getWidth(), item.height, 0.5, self.borderColor.r, self.borderColor.g, self.borderColor.b)

	local texture = self.scriptItem and self.scriptItem:getNormalTexture() or nil
	if texture then
		local texWidth = texture:getWidthOrig()
		local texHeight = texture:getHeightOrig()
		local a = 1
		if texWidth <= 32 and texHeight <= 32 then
			self:drawTexture(texture,6+(32-texWidth)/2,y+(item.height-texHeight)/2,a,1,1,1)
		else
			self:drawTextureScaledAspect(texture,6,y+(item.height-texHeight)/2,32,32,a,1,1,1)
		end
	end

	local r,g,b,a = 0.5,0.5,0.5,1.0
	if getZomboidRadio():getRecordedMedia():hasListenedToAll(self.character, item.item) then
		r,g,b = 1.0,1.0,1.0
	end
	local itemPadY = (item.height - self.fontHgt) / 2
	if r == 1 or metaKnowledge == 1 then
		self:drawText(item.text, 6 + 32 + 6, y+itemPadY, r, g, b, a, self.font)
	else
		self:drawText("???", 6 + 32 + 6, y+itemPadY, r, g, b, a, self.font)
	end

	y = y + item.height
	return y;
end

function ISLiteratureMediaList:new(x, y, width, height, character)
	local o = ISScrollingListBox.new(self, x, y, width, height)
	o.character = character
	o.scriptItem = nil
	return o
end

-----

function ISLiteratureGrowingList:doDrawItem(y, item, alt)
	local itemPadY = (item.height - self.fontHgt) / 2
--     local typeOfSeed = item.text
    local prop = farming_vegetableconf.props[item.text]
    if not prop then return y end
    if prop.seasonRecipe and not self.character:isRecipeActuallyKnown(prop.seasonRecipe) then return y end

    local text = (getText("Farming_" .. item.text));
    text = text .. "<LINE>" .. ISFarmingMenu.plantInfo(prop)

--     text = text .. "<LINE>" ..  getText("Farming_Tooltip_MinWater") .. farming_vegetableconf.props[typeOfSeed].waterLvl .. "";
--     if farming_vegetableconf.props[typeOfSeed].waterLvlMax then
--         text = text .. "<LINE>" .. getText("Farming_Tooltip_MaxWater") ..  farming_vegetableconf.props[typeOfSeed].waterLvlMax;
--     end
--     text = text .. "<LINE>"  .. getText("Farming_Tooltip_TimeOfGrow") .. math.floor((farming_vegetableconf.props[typeOfSeed].timeToGrow * farming_vegetableconf.props[typeOfSeed].harvestLevel) / 24 * calcNextTimeFactor()) .. " " .. getText("IGUI_Gametime_days");
--     --         local waterPlus = "";
--     if farming_vegetableconf.props[typeOfSeed].waterLvlMax then
--        local waterPlus = "-" .. farming_vegetableconf.props[typeOfSeed].waterLvlMax;
--          text = text .. "<LINE>" .. getText("Farming_Tooltip_AverageWater") .. farming_vegetableconf.props[typeOfSeed].waterLvl .. waterPlus;
--     end
--     --              text = text .. " <LINE> " .. getText("Farming_Tooltip_AverageWater") .. farming_vegetableconf.props[typeOfSeed].waterLvl .. waterPlus;
--     if getSandboxOptions():getOptionByName("PlantGrowingSeasons"):getValue() == true and prop.sowMonth then
--         text = text .. "<LINE>" .. getText("Farming_Tooltip_InSeason") .. ": " -- .. "<LINE>";
--         local comma = false
--         for i = 1, #prop.sowMonth do
--             if comma then  text = text .. ", " end
--             text = text .. getText("Farming_Month_" .. prop.sowMonth[i])
--             comma = true
--         end
--         if prop.bestMonth then
--              text = text .. "<LINE>" .. getText("Farming_Tooltip_BestMonth2") .. ": ";
--             local comma = false
--             for i = 1, #prop.bestMonth do
--                 if comma then  text = text .. ", " end
--                 text = text .. getText("Farming_Month_" .. prop.bestMonth[i])
--                 comma = true
--             end
--         end
--         if prop.riskMonth then
--             text = text .. "<LINE>" .. getText("Farming_Tooltip_RiskMonth2") .. ": ";
--             local comma = false
--             for i = 1, #prop.riskMonth do
--                 if comma then  text = text .. ", " end
--                 text = text .. getText("Farming_Month_" .. prop.riskMonth[i])
--                 comma = true
--             end
--         end
--     end

    local lines = nil
    if #text:split("<LINE>")>1 then
        lines = text:split("<LINE>")
        item.height = (#lines * FONT_HGT_SMALL) + (itemPadY/2)
    end

	if y + self:getYScroll() >= self.height then return y + item.height end
	if y + item.height + self:getYScroll() <= 0 then return y + item.height end

	self:drawRectBorder(0, y, self:getWidth(), item.height, 0.5, self.borderColor.r, self.borderColor.g, self.borderColor.b)
	local r,g,b,a = 1.0,1.0,1.0,1.0

	if lines then
        for i=1,#lines do
            local extraHeight = (FONT_HGT_SMALL * (i-1))
            self:drawText(lines[i], 6 + 32 + 6, y + extraHeight + (itemPadY/4), r, g, b, a, self.font)
        end
	else
	    self:drawText(text, 6 + 32 + 6, y+itemPadY, r, g, b, a, self.font)
	end
	y = y + item.height
	return y;
end

function ISLiteratureGrowingList:new(x, y, width, height, character)
	local o = ISScrollingListBox.new(self, x, y, width, height)
	o.character = character
	return o
end

-----

function ISLiteratureUI:createChildren()
	ISCollapsableWindowJoypad.createChildren(self)

	local th = self:titleBarHeight()
	local rh = self:resizeWidgetHeight()

	self.tabs = ISTabPanel:new(0, th, self.width, self.height-th-rh)
	self.tabs:setAnchorRight(true)
	self.tabs:setAnchorBottom(true)
	self.tabs:setEqualTabWidth(false)
	self:addChild(self.tabs)

	-- BOOKS

	local listbox1 = ISLiteratureList:new(0, 0, self.tabs.width, self.tabs.height - self.tabs.tabHeight, self.character)
	listbox1:setAnchorRight(true)
	listbox1:setAnchorBottom(true)
	listbox1:setFont(UIFont.Small, 3)
	listbox1.itemheight = BUTTON_HGT
	self.tabs:addView(getText("IGUI_LiteratureUI_Skills"), listbox1)
	self.listbox1 = listbox1

	-- MAGAZINES

	local listbox2 = ISLiteratureList:new(0, 0, self.width, self.tabs.height - self.tabs.tabHeight, self.character)
	listbox2:setAnchorRight(true)
	listbox2:setAnchorBottom(true)
	listbox2:setFont(UIFont.Small, 3)
	listbox2.itemheight = BUTTON_HGT
	self.tabs:addView(getText("IGUI_LiteratureUI_RecipeBooks"), listbox2)
	self.listbox2 = listbox2

	-- RECIPES

	local listbox3 = ISLiteratureList:new(0, 0, self.width, self.tabs.height - self.tabs.tabHeight, self.character)
	listbox3:setAnchorRight(true)
	listbox3:setAnchorBottom(true)
	listbox3:setFont(UIFont.Small, 3)
	listbox3.itemheight = BUTTON_HGT
	self.tabs:addView(getText("IGUI_LiteratureUI_Recipes"), listbox3)
	self.listbox3 = listbox3

	-- RECORDED MEDIA

	local categories = getZomboidRadio():getRecordedMedia():getCategories()
	self.listboxMedia = {}
	for i=1,categories:size() do
		local category = categories:get(i-1)
		local listbox4 = ISLiteratureMediaList:new(0, 0, self.width, self.tabs.height - self.tabs.tabHeight, self.character)
		listbox4:setAnchorRight(true)
		listbox4:setAnchorBottom(true)
		listbox4:setFont(UIFont.Small, 3)
		listbox4.itemheight = BUTTON_HGT
		self.tabs:addView(getText("IGUI_LiteratureUI_RecordedMedia_"..category), listbox4)
		self.listboxMedia[i] = listbox4
	end

	-- GROWING

	local listbox5 = ISLiteratureGrowingList:new(0, 0, self.width, self.tabs.height - self.tabs.tabHeight, self.character)
	listbox5:setAnchorRight(true)
	listbox5:setAnchorBottom(true)
	listbox5:setFont(UIFont.Small, 3)
	listbox5.itemheight = BUTTON_HGT
	self.tabs:addView(getText("IGUI_LiteratureUI_Growing"), listbox5)
	self.listbox5 = listbox5

	self.resizeWidget2:bringToTop()
	self.resizeWidget:bringToTop()

	self:setLists()
end

function ISLiteratureUI:close()
	self:setLists();
	self:removeFromUIManager()
end

function ISLiteratureUI:setLists()
	local skillBooks = {}
	local other = {}
	local media = {}
	local recipes = {}
	local allItems = getScriptManager():getAllItems()
	for i=1,allItems:size() do
		local item = allItems:get(i-1)
		if item:getType() == Type.Literature then
			if not LITERATURE_HIDDEN[item:getFullName()] then
				if SkillBook[item:getSkillTrained()] then
					table.insert(skillBooks, item)
				elseif item:getTeachedRecipes() ~= nil then
					table.insert(other, item)
					for j=1, item:getTeachedRecipes():size() do
						local recipe = item:getTeachedRecipes():get(j-1)
						table.insert(recipes, recipe)
					end
				end
			end
		end
		local mediaCategory = item:getRecordedMediaCat()
		if mediaCategory then
			media[mediaCategory] = media[mediaCategory] or {}
			table.insert(media[mediaCategory], item)
		end
	end

	local sortFunc = function(a,b)
		return not string.sort(a:getDisplayName(), b:getDisplayName())
	end

	local sortRecipe = function(a,b)
		return string.sort(b, a);
	end

	local prev;

	table.sort(skillBooks, sortFunc)
	self.listbox1:clear()
	for _,item in ipairs(skillBooks) do
		if prev ~= item then
			self.listbox1:addItem(item:getDisplayName(), item)
			prev = item;
		end
	end

	prev = nil;

	table.sort(other, sortFunc)
	self.listbox2:clear()
	for _,item in ipairs(other) do
		if prev ~= item then
			self.listbox2:addItem(item:getDisplayName(), item)
			prev = item;
		end
	end

	prev = nil;

	table.sort(recipes, sortRecipe)
	self.listbox3:clear()
	for _,item in ipairs(recipes) do
		if prev ~= item then
			self.listbox3:addItem(item, item)
			prev = item;
		end
	end

	self:setMediaLists(media)

	prev = nil;

	self.listbox5:clear()

	local typeOfSeedList = {}
	for typeOfSeed,props in pairs(farming_vegetableconf.props) do
		table.insert(typeOfSeedList, { typeOfSeed = typeOfSeed, text = getText("Farming_" .. typeOfSeed) })
	end
	table.sort(typeOfSeedList, function(a,b) return not string.sort(a.text, b.text) end)
	for _,tos in ipairs(typeOfSeedList) do
		local typeOfSeed = tos.typeOfSeed
        self.listbox5:addItem(typeOfSeed, typeOfSeed)
    end
end

function ISLiteratureUI:setMediaLists(scriptItems)
	local categories = getZomboidRadio():getRecordedMedia():getCategories()
	for i=1,categories:size() do
		local category = categories:get(i-1)
		self.listboxMedia[i].scriptItem = scriptItems[category] and scriptItems[category][1] or nil
		local mediaType = RecordedMedia.getMediaTypeForCategory(category)
		local list = getZomboidRadio():getRecordedMedia():getAllMediaForType(mediaType)
		for j=1,list:size() do
			local mediaData = list:get(j-1)
			if mediaData:getCategory() == category then
				local title = nil
				if mediaData:hasTitle() then
					title = mediaData:getTranslatedTitle()
					if mediaData:hasSubTitle() and (mediaData:getSubtitleEN() ~= "Home VHS") then
						title = title .. ' ' .. mediaData:getTranslatedSubTitle()
					end
				elseif mediaData:hasSubTitle() then
					title = mediaData:getTranslatedSubTitle()
				else
					title = mediaData:getTranslatedItemDisplayName()
				end
				self.listboxMedia[i]:addItem(title, mediaData)
			end
		end
		self.listboxMedia[i]:sort()
	end
end

function ISLiteratureUI:prerender()
	ISCollapsableWindowJoypad.prerender(self)
	
	local infoPanel = getPlayerInfoPanel(self.playerNum)
	if not infoPanel or (self.owner ~= infoPanel.charScreen) then
		-- Player UI was destroyed
		self:removeFromUIManager()
	end
end

function ISLiteratureUI:onGainJoypadFocus(joypadData)
	ISCollapsableWindowJoypad.onGainJoypadFocus(self, joypadData)
	self.drawJoypadFocus = true
end

function ISLiteratureUI:onLoseJoypadFocus(joypadData)
	ISCollapsableWindowJoypad.onLoseJoypadFocus(self, joypadData)
	self.drawJoypadFocus = false
end

function ISLiteratureUI:onJoypadDown(button)
	if button == Joypad.BButton then
		self:close()
		setJoypadFocus(self.playerNum, self.owner)
	end
	if button == Joypad.LBumper or button == Joypad.RBumper then
		if #self.tabs.viewList < 2 then return end
		local viewIndex = self.tabs:getActiveViewIndex()
		if button == Joypad.LBumper then
			if viewIndex == 1 then
				viewIndex = #self.tabs.viewList
			else
				viewIndex = viewIndex - 1
			end
		end
		if button == Joypad.RBumper then
			if viewIndex == #self.tabs.viewList then
				viewIndex = 1
			else
				viewIndex = viewIndex + 1
			end
		end
		self.tabs:activateView(self.tabs.viewList[viewIndex].name)
--		setJoypadFocus(self.playerNum, self.tabs:getActiveView())
	end
end

function ISLiteratureUI:onJoypadDirUp(button)
	local listbox = self.tabs:getActiveView()
	local row = listbox:rowAt(5, 5 - listbox:getYScroll())
	row = row - math.floor((listbox.height / 2) / listbox.itemheight)
	row = math.max(row, 1)
	listbox:ensureVisible(row)
end

function ISLiteratureUI:onJoypadDirDown(button)
	local listbox = self.tabs:getActiveView()
	local row = listbox:rowAt(5, listbox.height - 5 - listbox:getYScroll())
	row = row + math.floor((listbox.height / 2) / listbox.itemheight)
	row = math.min(row, listbox:size())
	listbox:ensureVisible(row)
end

function ISLiteratureUI:new(x, y, width, height, character, owner)
	local o = ISCollapsableWindowJoypad.new(self, x, y, width, height)
	o:setTitle(getText("IGUI_LiteratureUI_Title"))
	o.character = character
	o.playerNum = character:getPlayerNum()
	o.owner = owner
	return o
end	
