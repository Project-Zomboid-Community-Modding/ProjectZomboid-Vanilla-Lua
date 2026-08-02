require "ISUI/ISPanel"

ISItemsListTable = ISPanel:derive("ISItemsListTable");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local LABEL_HGT = FONT_HGT_MEDIUM + 6

local GHC = getCore():getGoodHighlitedColor()
local BHC = getCore():getBadHighlitedColor()

ISItemsListTable.COLUMN_WEAPON_TYPE = "WeaponType"
ISItemsListTable.COLUMN_NAME = "Name"
ISItemsListTable.COLUMN_CATEGORY = "Category"
ISItemsListTable.COLUMN_DISPLAY_CATEGORY = "DisplayCategory"
ISItemsListTable.COLUMN_LOOT_CATEGORY = "LootCategory"
ISItemsListTable.COLUMN_CRAFT = "Craft"
ISItemsListTable.COLUMN_FORAGE = "Forage"
ISItemsListTable.COLUMN_LOOT = "Loot"
ISItemsListTable.COLUMN_SPAWN_NUMBER = "SpawnNumber"

function ISItemsListTable:initialise()
    ISPanel.initialise(self);
end

function ISItemsListTable:render()
    ISPanel.render(self);

    local y = self.datas.y + self.datas.height + UI_BORDER_SPACING + 3
    self:drawText(getText("IGUI_DbViewer_TotalResult") .. self.totalResult, 0, y, 1,1,1,1,UIFont.Small)
    self:drawText(getText("IGUI_ItemList_Info"), 0, y + BUTTON_HGT, 1,1,1,1,UIFont.Small)
    self:drawText(getText("IGUI_ItemList_Info2"), 0, y + BUTTON_HGT*2, 1,1,1,1,UIFont.Small)

    y = self.filters:getBottom()

    self:drawRectBorder(self.datas.x, y, self.datas:getWidth(), BUTTON_HGT, 1, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawRect(self.datas.x, y, self.datas:getWidth(), BUTTON_HGT, self.listHeaderColor.a, self.listHeaderColor.r, self.listHeaderColor.g, self.listHeaderColor.b);

    local x = 0;
    for i,v in ipairs(self.datas.columns) do
        local size;
        if i == #self.datas.columns then
            size = self.datas.width - x
        else
            size = self.datas.columns[i+1].size - self.datas.columns[i].size
        end
        self:drawText(v.name, x+UI_BORDER_SPACING+1, y+3, 1,1,1,1,UIFont.Small);
        self:drawRectBorder(self.datas.x + x, y, 1, BUTTON_HGT, 1, self.borderColor.r, self.borderColor.g, self.borderColor.b);
        x = x + size;
    end
end

function ISItemsListTable:new (x, y, width, height, viewer)
    local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self);
    o.listHeaderColor = {r=0.4, g=0.4, b=0.4, a=0.3};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=0};
    o.backgroundColor = {r=0, g=0, b=0, a=1};
    o.buttonBorderColor = {r=0.7, g=0.7, b=0.7, a=0.5};
    o.totalResult = 0;
    o.filterWidgets = {};
    o.filterWidgetMap = {}
    o.viewer = viewer
    ISItemsListTable.instance = o;
    return o;
end

function ISItemsListTable:createChildren()
    ISPanel.createChildren(self);

    local btnWid = 100
    local bottomHgt = BUTTON_HGT*6 + UI_BORDER_SPACING*3 + LABEL_HGT -2

    self.datas = ISScrollingListBox:new(0, BUTTON_HGT, self.width, self.height - bottomHgt - LABEL_HGT);
    self.datas:initialise();
    self.datas:instantiate();
    self.datas.itemheight = BUTTON_HGT
    self.datas.selected = 0;
    self.datas.joypadParent = self;
    self.datas.font = UIFont.NewSmall;
    self.datas.doDrawItem = self.drawDatas;
    self.datas.drawBorder = true;

    self.datas:addColumn(getText("Tooltip_weapon_Type"), 0, ISItemsListTable.COLUMN_WEAPON_TYPE);
    self.datas:addColumn(getText("IGUI_Name"), 200+(getCore():getOptionFontSizeReal()*20), ISItemsListTable.COLUMN_NAME);
    self.datas:addColumn(getText("IGUI_invpanel_Category"), 450+(getCore():getOptionFontSizeReal()*40), ISItemsListTable.COLUMN_CATEGORY);
    self.datas:addColumn(getText("IGUI_DisplayCategory"), 625+(getCore():getOptionFontSizeReal()*40), ISItemsListTable.COLUMN_DISPLAY_CATEGORY)
    self.datas:addColumn(getText("IGUI_LootCategory"), 800+(getCore():getOptionFontSizeReal()*50), ISItemsListTable.COLUMN_LOOT_CATEGORY)
    self.datas:addColumn(getText("IGUI_CraftingWindow_Craft"), 920+(getCore():getOptionFontSizeReal()*50), ISItemsListTable.COLUMN_CRAFT)
    self.datas:addColumn(getText("ContextMenu_Forage"), 980+(getCore():getOptionFontSizeReal()*50), ISItemsListTable.COLUMN_FORAGE)
    self.datas:addColumn(getText("Sandbox_Loot"), 1040+(getCore():getOptionFontSizeReal()*50), ISItemsListTable.COLUMN_LOOT)
    self.datas:addColumn(getText("IGUI_SpawnNumber"), 1090+(getCore():getOptionFontSizeReal()*50), ISItemsListTable.COLUMN_SPAWN_NUMBER)

    self.datas:setOnMouseDoubleClick(self, ISItemsListTable.addItem);
    self:addChild(self.datas);

    local btnY = self.datas.y + self.datas.height + UI_BORDER_SPACING*2 + BUTTON_HGT*3

    self.buttonAdd1 = ISButton:new(0, btnY, btnWid, BUTTON_HGT, getText("IGUI_AdminPanel_ItemList_Add1"), self, ISItemsListTable.onOptionMouseDown);
    self.buttonAdd1.internal = "ADDITEM1";
    self.buttonAdd1.enable = false;
    self.buttonAdd1.borderColor = self.buttonBorderColor;
    self:addChild(self.buttonAdd1);

    self.buttonAdd2 = ISButton:new(self.buttonAdd1:getRight() + UI_BORDER_SPACING, btnY, btnWid, BUTTON_HGT, getText("IGUI_AdminPanel_ItemList_Add2"), self, ISItemsListTable.onOptionMouseDown);
    self.buttonAdd2.internal = "ADDITEM2";
    self.buttonAdd2.enable = false;
    self.buttonAdd2.borderColor = self.buttonBorderColor;
    self:addChild(self.buttonAdd2);

    self.buttonAdd5 = ISButton:new(self.buttonAdd2:getRight() + UI_BORDER_SPACING, btnY, btnWid, BUTTON_HGT, getText("IGUI_AdminPanel_ItemList_Add5"), self, ISItemsListTable.onOptionMouseDown);
    self.buttonAdd5.internal = "ADDITEM5";
    self.buttonAdd5.enable = false;
    self.buttonAdd5.borderColor = self.buttonBorderColor;
    self:addChild(self.buttonAdd5);

    self.buttonAddMultiple = ISButton:new(self.buttonAdd5:getRight() + UI_BORDER_SPACING, btnY, btnWid, BUTTON_HGT, getText("IGUI_AdminPanel_ItemList_AddX"), self, ISItemsListTable.onOptionMouseDown);
    self.buttonAddMultiple.internal = "ADDITEM";
    self.buttonAddMultiple:initialise();
    self.buttonAddMultiple:instantiate();
    self.buttonAddMultiple.enable = false;
    self.buttonAddMultiple.borderColor = self.buttonBorderColor;
    self:addChild(self.buttonAddMultiple);

    self.filters = ISLabel:new(0, self.buttonAddMultiple:getBottom() + UI_BORDER_SPACING, LABEL_HGT, getText("IGUI_DbViewer_Filters"), 1, 1, 1, 1, UIFont.Large, true)
    self.filters:initialise()
    self.filters:instantiate()
    self:addChild(self.filters)

    local x = 0;
    local entryY = self.filters:getBottom() + BUTTON_HGT
    for i,column in ipairs(self.datas.columns) do
        local size;
        if i == #self.datas.columns then -- last column take all the remaining width
            size = self.datas:getWidth() - x;
        else
            size = self.datas.columns[i+1].size - self.datas.columns[i].size
        end
        if column.id == ISItemsListTable.COLUMN_CATEGORY then
            self:addFilterCombo(column, x, entryY, size, self.filterCategory)
        elseif column.id == ISItemsListTable.COLUMN_DISPLAY_CATEGORY then
            self:addFilterCombo(column, x, entryY, size, self.filterDisplayCategory)
        elseif column.id == ISItemsListTable.COLUMN_LOOT_CATEGORY then
            self:addFilterCombo(column, x, entryY, size, self.filterLootCategory)
        elseif column.id == ISItemsListTable.COLUMN_CRAFT then
            self:addFilterCombo(column, x, entryY, size, self.filterCraft)
        elseif column.id == ISItemsListTable.COLUMN_FORAGE then
            self:addFilterCombo(column, x, entryY, size, self.filterForage)
        elseif column.id == ISItemsListTable.COLUMN_LOOT then
            self:addFilterCombo(column, x, entryY, size, self.filterLoot)
        elseif column.id == ISItemsListTable.COLUMN_SPAWN_NUMBER then
            -- can't be filtered
        else
            local entry = ISTextEntryBox:new("", x, entryY, size, BUTTON_HGT);
            entry.font = UIFont.NewSmall
            entry:initialise();
            entry:instantiate();
            entry.columnName = column.name;
            entry.itemsListFilter = self['filter'..column.id]
            entry.onTextChange = ISItemsListTable.onFilterChange;
            entry.onOtherKey = function(entry, key) ISItemsListTable.onOtherKey(entry, key) end
            entry.target = self;
            entry:setClearButton(true)
            self:addChild(entry);
            table.insert(self.filterWidgets, entry);
            self.filterWidgetMap[column.id] = entry
        end
        x = x + size;
    end
end

function ISItemsListTable:addFilterCombo(column, x, entryY, size, filterFunction)
    local combo = ISComboBox:new(x, entryY, size, BUTTON_HGT)
    combo.font = UIFont.NewSmall
    combo:initialise()
    combo:instantiate()
    combo.columnName = column.name
    combo.target = combo
    combo.onChange = self.onFilterChange
    combo.itemsListFilter = filterFunction
    self:addChild(combo)
    table.insert(self.filterWidgets, combo)
    self.filterWidgetMap[column.id] = combo
end

function ISItemsListTable:addItem(item)
    local playerNum = self.viewer.playerSelect.selected - 1
    local playerObj = getSpecificPlayer(playerNum)
    if not playerObj or playerObj:isDead() then return end
    if isClient() then
        SendCommandToServer("/additem \"" .. playerObj:getUsername() .. "\" \"" .. luautils.trim(item:getFullName()) .. "\"")
    else
        local item = instanceItem(item:getFullName())
        if item:getType() == "CorpseAnimal" then
            item:createAndStoreDefaultDeadBody(nil)
        end
        playerObj:getInventory():AddItem(item);
    end
end

function ISItemsListTable:onOptionMouseDown(button, x, y)
    if button.internal == "ADDITEM1" then
        local item = button.parent.datas.items[button.parent.datas.selected].item
        self:addItem(item)
    end
    if button.internal == "ADDITEM2" then
        local item = button.parent.datas.items[button.parent.datas.selected].item
        for i=1,2 do self:addItem(item) end
    end
    if button.internal == "ADDITEM5" then
        local item = button.parent.datas.items[button.parent.datas.selected].item
        for i=1,5 do self:addItem(item) end
    end
    if button.internal == "ADDITEM" then
        local item = button.parent.datas.items[button.parent.datas.selected].item;
        local modal = ISTextBox:new(0, 0, 280, 180, getText("IGUI_AdminPanel_ItemList_AddXTitle", item:getDisplayName()), "1", self, ISItemsListTable.onAddItem, nil, item);
        modal:initialise();
        modal:addToUIManager();
        modal:setOnlyNumbers(true);
    end
end

function ISItemsListTable:onAddItem(button, item)
    if button.internal == "OK" then
        local number = math.min(tonumber(button.parent.entry:getText()),100)
        for i=0, number - 1 do
            self:addItem(item);
        end
    end
end

function ISItemsListTable:initList(module)
    self.totalResult = 0;
    local categoryNames = {}
    local displayCategoryNames = {}
    local lootCategoryNames = {}
    local categoryMap = {}
    local displayCategoryMap = {}
    local lootCategoryMap = {}
    for x,v in ipairs(module) do
        self.datas:addItem(v:getDisplayName(), v);
        if not categoryMap[v:getItemType():toString()] then
            categoryMap[v:getItemType():toString()] = true
            table.insert(categoryNames, v:getItemType())
        end
        if not displayCategoryMap[v:getDisplayCategory()] then
            displayCategoryMap[v:getDisplayCategory()] = true
            table.insert(displayCategoryNames, v:getDisplayCategory())
        end
        if not lootCategoryMap[v:getLootType()] then
            lootCategoryMap[v:getLootType()] = true
            table.insert(lootCategoryNames, v:getLootType())
        end
        self.totalResult = self.totalResult + 1;
    end
    table.sort(self.datas.items, function(a,b) return not string.sort(a.item:getDisplayName(), b.item:getDisplayName()); end);

    local combo = self.filterWidgetMap[ISItemsListTable.COLUMN_CATEGORY]
    table.sort(categoryNames, function(a,b) return not string.sort(getText(a:getTranslationName()), getText(b:getTranslationName())) end)
    combo:addOption(getText("IGUI_Any"))
    for _,categoryName in ipairs(categoryNames) do
        combo:addOptionWithData(getText(categoryName:getTranslationName()), categoryName)
    end

    combo = self.filterWidgetMap[ISItemsListTable.COLUMN_DISPLAY_CATEGORY]
    table.sort(displayCategoryNames, function(a,b) return not string.sort(getText("IGUI_ItemCat_" .. a), getText("IGUI_ItemCat_" .. b)) end)
    combo:addOption(getText("IGUI_Any"))
    combo:addOption(getText("IGUI_NoCategorySet"))
    for _,displayCategoryName in ipairs(displayCategoryNames) do
        combo:addOptionWithData(getText("IGUI_ItemCat_" .. displayCategoryName), displayCategoryName)
    end

    combo = self.filterWidgetMap[ISItemsListTable.COLUMN_LOOT_CATEGORY]
    table.sort(lootCategoryNames, function(a,b) return not string.sort(a, b) end)
    combo:addOption(getText("IGUI_Any"))
    for _,lootCategoryName in ipairs(lootCategoryNames) do
        combo:addOptionWithData(getText("Sandbox_" .. lootCategoryName .. "LootNew"), lootCategoryName)
    end

    combo = self.filterWidgetMap[ISItemsListTable.COLUMN_CRAFT]
    combo:addOption(getText("IGUI_Any"))
    combo:addOptionWithData(getText("IGUI_False"), false)
    combo:addOptionWithData(getText("IGUI_True"), true)

    combo = self.filterWidgetMap[ISItemsListTable.COLUMN_FORAGE]
    combo:addOption(getText("IGUI_Any"))
    combo:addOptionWithData(getText("IGUI_False"), false)
    combo:addOptionWithData(getText("IGUI_True"), true)

    combo = self.filterWidgetMap[ISItemsListTable.COLUMN_LOOT]
    combo:addOption(getText("IGUI_Any"))
    combo:addOptionWithData(getText("IGUI_False"), false)
    combo:addOptionWithData(getText("IGUI_True"), true)
end

function ISItemsListTable:update()
    local playerNum = self.viewer.playerSelect.selected - 1
    local playerObj = getSpecificPlayer(playerNum)
    local hasPlayer = playerObj ~= nil

    self.buttonAdd1.enable = self.datas.selected > 0 and hasPlayer;
    self.buttonAdd2.enable = self.datas.selected > 0 and hasPlayer;
    self.buttonAdd5.enable = self.datas.selected > 0 and hasPlayer;
    self.buttonAddMultiple.enable = self.datas.selected > 0 and hasPlayer;
    self.datas.doDrawItem = self.drawDatas;
end

function ISItemsListTable:filterDisplayCategory(widget, scriptItem)
    if widget.selected == 1 then return true end -- Any category
    if widget.selected == 2 then return scriptItem:getDisplayCategory() == nil end
    return scriptItem:getDisplayCategory() == widget:getOptionData(widget.selected)
end

function ISItemsListTable:filterCategory(widget, scriptItem)
    if widget.selected == 1 then return true end -- Any category
    return scriptItem:getItemType() == widget:getOptionData(widget.selected)
end

function ISItemsListTable:filterName(widget, scriptItem)
    local txtToCheck = string.lower(scriptItem:getDisplayName())
    local filterTxt = string.lower(widget:getInternalText())
    return checkStringPattern(filterTxt) and string.match(txtToCheck, filterTxt)
end

function ISItemsListTable:filterWeaponType(widget, scriptItem)
    local txtToCheck = string.lower(scriptItem:getName())
    local filterTxt = string.lower(widget:getInternalText())
    return checkStringPattern(filterTxt) and string.match(txtToCheck, filterTxt)
end

function ISItemsListTable:filterLootCategory(widget, scriptItem)
    if widget.selected == 1 then return true end -- Any category
    return getText("Sandbox_" .. scriptItem:getLootType() .. "LootNew") == widget:getOptionText(widget.selected)
end

function ISItemsListTable:filterCraft(widget, scriptItem)
    if widget.selected == 1 then return true end -- Any category
    return scriptItem:isCraftRecipeProduct() == widget:getOptionData(widget.selected)
end

function ISItemsListTable:filterForage(widget, scriptItem)
    if widget.selected == 1 then return true end -- Any category
    return scriptItem:canBeForaged() == widget:getOptionData(widget.selected)
end

function ISItemsListTable:filterLoot(widget, scriptItem)
    if widget.selected == 1 then return true end -- Any category
    return scriptItem:canSpawnAsLoot() == widget:getOptionData(widget.selected)
end

function ISItemsListTable.onFilterChange(widget)
    local datas = widget.parent.datas;
    if not datas.fullList then datas.fullList = datas.items; end
    widget.parent.totalResult = 0;
    datas:clear();
    for i,v in ipairs(datas.fullList) do -- check every items
        local add = true;
        for j,widget in ipairs(widget.parent.filterWidgets) do -- check every filters
            if widget and widget.itemsListFilter and not widget.itemsListFilter(nil, widget, v.item) then
                add = false
                break
            end
        end
        if add then
            datas:addItem(i, v.item);
            widget.parent.totalResult = widget.parent.totalResult + 1;
        end
    end
end

function ISItemsListTable:onOtherKey(key)
    if key == Keyboard.KEY_TAB then
        Core.UnfocusActiveTextEntryBox()
        if self.columnName == "Type" then
            self.parent.filterWidgetMap[ISItemsListTable.COLUMN_NAME]:focus()
        else
            self.parent.filterWidgetMap[ISItemsListTable.COLUMN_WEAPON_TYPE]:focus()
        end
    end
end

function ISItemsListTable:drawDatas(y, item, alt)
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
    local xoffset = UI_BORDER_SPACING;

    local column = 1
    local clipY = math.max(0, y + self:getYScroll())
    local clipY2 = math.min(self.height, y + self:getYScroll() + self.itemheight)

    self:setStencilRect(self.columns[column].size, clipY, self.columns[column+1].size - self.columns[column].size, clipY2 - clipY)
    self:drawText(item.item:getName(), xoffset, y + 3, 1, 1, 1, a, self.font);
    self:clearStencilRect()

    column = column+1
    self:setStencilRect(self.columns[column].size, clipY, self.columns[column+1].size - self.columns[column].size, clipY2 - clipY)
    self:drawText(item.item:getDisplayName(), self.columns[2].size + iconX + iconSize + 4, y + 3, 1, 1, 1, a, self.font);
    self:clearStencilRect()

    column = column+1
    self:setStencilRect(self.columns[column].size, clipY, self.columns[column+1].size - self.columns[column].size, clipY2 - clipY)
    self:drawText(getText(item.item:getItemType():getTranslationName()), self.columns[3].size + xoffset, y + 3, 1, 1, 1, a, self.font);
    self:clearStencilRect()

    column = column+1
    self:setStencilRect(self.columns[column].size, clipY, self.columns[column+1].size - self.columns[column].size, clipY2 - clipY)
    if item.item:getDisplayCategory() ~= nil then
        self:drawText(getText("IGUI_ItemCat_" .. item.item:getDisplayCategory()), self.columns[4].size + xoffset, y + 4, 1, 1, 1, a, self.font);
    else
        self:drawText("Error: No category set", self.columns[4].size + xoffset, y + 3, 1, 1, 1, a, self.font);
    end
    self:clearStencilRect()

    column = column+1
    self:setStencilRect(self.columns[column].size, clipY, self.columns[column+1].size - self.columns[column].size, clipY2 - clipY)
    if item.item:getLootType() ~= nil then
        self:drawText(getText("Sandbox_" .. item.item:getLootType() .. "LootNew"), self.columns[5].size + xoffset, y + 3, 1, 1, 1, a, self.font);
    end
    self:clearStencilRect()

    column = column+1
    self:setStencilRect(self.columns[column].size, clipY, self.columns[column+1].size - self.columns[column].size, clipY2 - clipY)
    self.parent:drawTrueOrFalseColumn(6, item.item:isCraftRecipeProduct(), xoffset, y, a)
    self:clearStencilRect()

    column = column+1
    self:setStencilRect(self.columns[column].size, clipY, self.columns[column+1].size - self.columns[column].size, clipY2 - clipY)
    self.parent:drawTrueOrFalseColumn(7, item.item:canBeForaged(), xoffset, y, a)
    self:clearStencilRect()

    column = column+1
    self:setStencilRect(self.columns[column].size, clipY, self.columns[column+1].size - self.columns[column].size, clipY2 - clipY)
    self.parent:drawTrueOrFalseColumn(8, item.item:canSpawnAsLoot(), xoffset, y, a)
    self:clearStencilRect()

    if item.item:getNumSpawned() > 0 then
        self:drawText(tostring(item.item:getNumSpawned()), self.columns[9].size + xoffset, y + 3, GHC:getR(), GHC:getG(), GHC:getB(), a, self.font);
    else
        self:drawText(tostring(item.item:getNumSpawned()), self.columns[9].size + xoffset, y + 3, BHC:getR(), BHC:getG(), BHC:getB(), a, self.font);
    end


    self:repaintStencilRect(0, clipY, self.width, clipY2 - clipY)

    local icon = item.item:getIcon()
    if item.item:getIconsForTexture() and not item.item:getIconsForTexture():isEmpty() then
        icon = item.item:getIconsForTexture():get(0)
    end
    if icon then
        local texture = tryGetTexture("Item_" .. icon)
        if texture then
            self:drawTextureScaledAspect2(texture, self.columns[2].size + iconX, y + (self.itemheight - iconSize) / 2, iconSize, iconSize,  1, 1, 1, 1);
        end
    end

    return y + self.itemheight;
end

function ISItemsListTable:drawTrueOrFalseColumn(columnIndex, testBool, xoffset, y, a)
    local text = getText("IGUI_True")
    local color = GHC
    if not testBool then
        text = getText("IGUI_False")
        color = BHC
    end
    self.datas:drawText(text, self.datas.columns[columnIndex].size + xoffset, y + 3, color:getR(), color:getG(), color:getB(), a, self.datas.font);
end
