ISTradingUI = ISPanelJoypad:derive("ISTradingUI");
ISTradingUI.windows = {};
ISTradingUI.CoolDownMessage = 300;
ISTradingUI.States = {};
ISTradingUI.States.PlayerClosedWindow = 0;
ISTradingUI.States.SealOffer = 1;
ISTradingUI.States.UnSealOffer = 2;
ISTradingUI.States.FinalizeDeal = 3;
ISTradingUI.MaxItems = 20;

function ISTradingUI.GetUIForPlayer(playerObj)
    return (playerObj ~= nil and playerObj:isLocal()) and ISTradingUI.windows[playerObj:getIndex()+1] or nil
end

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local FONT_HGT_LARGE = getTextManager():getFontHeight(UIFont.Large)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local LIST_WIDTH = 250

local InventoryList = ISScrollingListBox:derive("ISTradingUI_InventoryList")

function InventoryList:onMouseUp(x, y)
    if self.tradingUI:isOfferSealed() then
        return;
    end
    if self.vscroll then
        self.vscroll.scrolling = false;
    end
    if x > 2 + self:expandCollapseSize() + 2 + self:iconSize() then return end
    local row = self:rowAt(x, y)
    if not self.items[row] then return end
    local data = self.items[row].item
    if #data.itemTable.items == 1 then return end
    self.collapsed[data.itemTable.name] = not self.collapsed[data.itemTable.name]
    self:updateLater()
end

function InventoryList:expandCollapseSize()
    return math.min(15, 8 + getCore():getOptionFontSizeReal() * 2)
end

function InventoryList:iconSize()
    return self.itemheight - 4
end

function InventoryList:doDrawItem(y, item, alt)
    local data = item.item
    local a = 1.0
    self:drawRectBorder(0, y, self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b)
    if self.selected == item.index and not self.tradingUI.sealOffer.selected[1] then
        self:drawRect(0, y, self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15)
    end
    local size = self:expandCollapseSize()
    local isGroup = #data.itemTable.items > 1
    local isCollapsed = self.collapsed[data.itemTable.name]
    if data.isGroupHeader then
        local icon = isCollapsed and self.treeColIcon or self.treeExpIcon
        self:drawTextureScaled(icon, 2, y + (self.itemheight - size) / 2, size, size, 1.0, 1.0, 1.0, 1.0)
    end
    local iconSize = self:iconSize()
    local inset = (isGroup and not data.isGroupHeader) and 10 or 0
    self:drawTextureScaledAspect(data.item:getTex(), inset + 2 + size + 2, y + (self.itemheight - iconSize) / 2, iconSize, iconSize, 1, data.item:getR(), data.item:getG(), data.item:getB())
    local text = item.text
    if data.isGroupHeader then
        text = text .. " (" .. #data.itemTable.items .. ")"
    end
    local r,g,b = 1.0,1.0,1.0
    if isGroup and not data.isGroupHeader then
        r,g,b = 0.66,0.66,0.66
    end
    self:drawText(text, inset + 2 + size + 2 + iconSize + 2, y + (self.itemheight - self.fontHgt) / 2, r, g, b, a, self.font)
    return y + self.itemheight
end

function InventoryList:updateYourInventory()
    if not self:wasInventoryUpdated() then return end
    local playerObj = self.tradingUI.player
    self:groupInventoryItemsByName()
    local selected = math.max(self.selected, 1)
    self:clear()
    for _,itemTable in ipairs(self.itemTableList) do
        local data = {}
        data.itemTable = itemTable
        data.item = itemTable.items[1]
        data.isGroupHeader = #itemTable.items > 1
        self:addItem(data.item:getName(playerObj), data)
        if not self.collapsed[itemTable.name] and #itemTable.items > 1 then
            for _,item in ipairs(itemTable.items) do
                data = {}
                data.itemTable = itemTable
                data.item = item
                self:addItem(data.item:getName(playerObj), data)
            end
        end
    end
    self.selected = math.min(selected, self:size())
end

function InventoryList:updateLater()
    self.inventoryContainerCount = -1
end

function InventoryList:wasInventoryUpdated()
    local playerObj = self.tradingUI.player
    local inventoryWindow = getPlayerInventory(playerObj:getIndex())
    if inventoryWindow.inventoryPane.refreshContainerCount ~= self.inventoryContainerCount then
        self.inventoryContainerCount = inventoryWindow.inventoryPane.refreshContainerCount or 0
        return true
    end
    return false
end

InventoryList.itemSortByNameInc = function(a,b)
    if a.equipped and not b.equipped then return false end
    if b.equipped and not a.equipped then return true end
    if a.inHotbar and not b.inHotbar then return true end
    if b.inHotbar and not a.inHotbar then return false end
    return not string.sort(a.name, b.name);
end

function InventoryList:groupInventoryItemsByName()
    local playerObj = self.tradingUI.player

    local isEquipped = {}
    local isInHotbar = {}
    self:getEquippedAndHotbarItems(isEquipped, isInHotbar)

    self.itemTables = {}
    local it = playerObj:getInventory():getItems()
    for i=1,it:size() do
        local item = it:get(i-1)
        self:addInventoryItemToGroup(item, isEquipped, isInHotbar)
    end

    self.itemTableList = {}
    for k,v in pairs(self.itemTables) do
        table.insert(self.itemTableList, v)
        local weight = 0
        for k2,v2 in ipairs(v.items) do
            weight = weight + v2:getUnequippedWeight()
        end
        v.name = k
        v.cat = v.items[1]:getDisplayCategory() or v.items[1]:getCategory()
        v.weight = weight
        if self.collapsed[v.name] == nil then
            self.collapsed[v.name] = true
        end
    end

    table.sort(self.itemTableList, InventoryList.itemSortByNameInc)
end

function InventoryList:getEquippedAndHotbarItems(isEquipped, isInHotbar)
    local playerObj = self.tradingUI.player
    local hotbar = getPlayerHotbar(playerObj:getIndex())
    local wornItems = playerObj:getWornItems()
    for i=1,wornItems:size() do
        local wornItem = wornItems:get(i-1)
        isEquipped[wornItem:getItem()] = true
    end
    local item = playerObj:getPrimaryHandItem()
    if item then
        isEquipped[item] = true
    end
    item = playerObj:getSecondaryHandItem()
    if item then
        isEquipped[item] = true
    end
    if hotbar and hotbar.attachedItems then
        for _,item in pairs(hotbar.attachedItems) do
            isInHotbar[item] = true
        end
    end
end

function InventoryList:addInventoryItemToGroup(item, isEquipped, isInHotbar)
    local playerObj = self.tradingUI.player
    if playerObj:isEquipped(item) or playerObj:isEquippedClothing(item) then
        return
    end
    if item:isFavorite() then
        return
    end
    if item:isHidden() then
        return
    end
    if self.tradingUI:isItemOffered(item) then
        return
    end
    local itemName = item:getName(playerObj)
    if item:IsFood() and item:getHerbalistType() and item:getHerbalistType() ~= "" then
        if playerObj:isRecipeActuallyKnown("Herbalist") then
            if item:getHerbalistType() == "Berry" then
                itemName = (item:getPoisonPower() > 0) and getText("IGUI_PoisonousBerry") or getText("IGUI_Berry")
            end
            if item:getHerbalistType() == "Mushroom" then
                itemName = (item:getPoisonPower() > 0) and getText("IGUI_PoisonousMushroom") or getText("IGUI_Mushroom")
            end
        else
            if item:getHerbalistType() == "Berry"  then
                itemName = getText("IGUI_UnknownBerry")
            end
            if item:getHerbalistType() == "Mushroom" then
                itemName = getText("IGUI_UnknownMushroom")
            end
        end
        if itemName ~= item:getDisplayName() then
            item:setName(itemName)
        end
        itemName = item:getName(playerObj)
    end
    local equipped = false
    if isEquipped[item] then
        itemName = "equipped:"..itemName
        equipped = true
    elseif item:isItemType(ItemType.KEY_RING) or item:hasTag(ItemTag.KEY_RING) then
        itemName = "keyring:"..itemName
        equipped = true
    end
    local inHotbar = isInHotbar[item]
    if inHotbar and not equipped then
        itemName = "hotbar:"..itemName
    end
    if self.itemTables[itemName] == nil then
        self.itemTables[itemName] = {}
        self.itemTables[itemName].items = {}
    end
    local itemTable = self.itemTables[itemName]
    if #itemTable.items >= ISTradingUI.MaxItems then
        return
    end
    itemTable.equipped = equipped
    itemTable.inHotbar = inHotbar
    table.insert(itemTable.items, item)
end

function InventoryList:onJoypadDirRight(joypadData)
    setJoypadFocus(joypadData.player, self.tradingUI.yourOfferDatas)
end

function InventoryList:new(x, y, width, height, tradingUI)
    local o = ISScrollingListBox.new(self, x, y, width, height)
    o.tradingUI = tradingUI
    o.treeExpIcon = getTexture("media/ui/inventoryPanes/Button_TreeExpanded.png")
    o.treeColIcon = getTexture("media/ui/inventoryPanes/Button_TreeCollapsed.png")
    o.collapsed = {}
    o.inventoryContainerCount = -1
    return o
end

function ISTradingUI:initialise()
    ISPanelJoypad.initialise(self);
    local btnWid = 100
    local btnHgt = BUTTON_HGT
    local padBottom = 10
    local listY = UI_BORDER_SPACING + btnHgt + FONT_HGT_SMALL * 2
    local listWid = LIST_WIDTH;
    local listHeight = 250;

    self.infoBtn = ISButton:new(UI_BORDER_SPACING, UI_BORDER_SPACING, 70, btnHgt, getText("UI_InfoBtn"), self, ISTradingUI.onClick);
    self.infoBtn.internal = "INFO";
    self.infoBtn:initialise();
    self.infoBtn:instantiate();
    self.infoBtn.borderColor = { r = 1, g = 1, b = 1, a = 0.4 };
    self:addChild(self.infoBtn);

    self.inventoryList = InventoryList:new(UI_BORDER_SPACING, listY, listWid, listHeight, self)
    self.inventoryList:initialise()
    self.inventoryList:instantiate()
    self.inventoryList.joypadParent = self
    self.inventoryList:setFont(UIFont.Small)
    self.inventoryList:setOnMouseDoubleClick(self, self.onInvokeListItem_Inventory)
    self.inventoryList.drawBorder = true
    self.inventoryList.stealJoypadFocusFromParent = false
    self:addChild(self.inventoryList)

    self.addBtn = ISButton:new(self.inventoryList:getRight() - btnWid, self.inventoryList:getBottom() + 5, btnWid, btnHgt, getText("IGUI_TradingUI_AddItem"), self, ISTradingUI.onClick)
    self.addBtn.internal = "ADD"
    self.addBtn:initialise()
    self.addBtn:instantiate()
    self.addBtn.borderColor = {r=1, g=1, b=1, a=0.4}
    self:addChild(self.addBtn)

    self.yourOfferDatas = ISScrollingListBox:new(self.inventoryList:getRight() + 10, listY, listWid, listHeight);
    self.yourOfferDatas:initialise();
    self.yourOfferDatas:instantiate();
    self.yourOfferDatas.joypadParent = self;
    self.yourOfferDatas:setFont(UIFont.Small);
    self.yourOfferDatas:setOnMouseDoubleClick(self, self.onInvokeListItem_YourOffer)
    self.yourOfferDatas.doDrawItem = self.drawOffer;
    self.yourOfferDatas.drawBorder = true;
    self.yourOfferDatas.stealJoypadFocusFromParent = false;
    self.yourOfferDatas.onJoypadDirLeft = function(_self, _joypadData)
        setJoypadFocus(_joypadData.player, _self.parent.inventoryList)
    end
    self.yourOfferDatas.onJoypadDirRight = function(_self, _joypadData)
        setJoypadFocus(_joypadData.player, _self.parent.hisOfferDatas)
    end
    self:addChild(self.yourOfferDatas);

    self.remove = ISButton:new(self.yourOfferDatas:getRight() - btnWid, self.yourOfferDatas:getBottom() + 5, btnWid, btnHgt, getText("IGUI_TradingUI_RemoveItem"), self, ISTradingUI.onClick);
    self.remove.internal = "REMOVE";
    self.remove:initialise();
    self.remove:instantiate();
    self.remove.borderColor = {r=1, g=1, b=1, a=0.4};
    self:addChild(self.remove);

    self.hisOfferDatas = ISScrollingListBox:new(self.yourOfferDatas:getRight() + 10, self.yourOfferDatas.y, listWid, listHeight);
    self.hisOfferDatas:initialise();
    self.hisOfferDatas:instantiate();
    self.hisOfferDatas.joypadParent = self;
    self.hisOfferDatas:setFont(UIFont.Small);
    self.hisOfferDatas.doDrawItem = self.drawOffer;
    self.hisOfferDatas.drawBorder = true;
    self.hisOfferDatas.stealJoypadFocusFromParent = false;
    self.hisOfferDatas.onJoypadDirLeft = function(_self, _joypadData)
        setJoypadFocus(_joypadData.player, _self.parent.yourOfferDatas)
    end
    self:addChild(self.hisOfferDatas);

    self.sealOffer = ISTickBox:new(self.yourOfferDatas.x, self.remove:getBottom() + 5, getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_TradingUI_MaxItemReached", "")) + 20, 18, "", self, ISTradingUI.onSealOffer);
    self.sealOffer:initialise();
    self.sealOffer:instantiate();
    self.sealOffer.selected[1] = false;
    self.sealOffer:addOption(getText("IGUI_TradingUI_SealOffer"));
    self:addChild(self.sealOffer);
    self.sealOffer.tooltip = getText("IGUI_TradingUI_SealOfferTooltip");

    self.no = ISButton:new(UI_BORDER_SPACING, self.sealOffer:getBottom() + 5 + FONT_HGT_SMALL * 2 + 5, btnWid, btnHgt, getText("UI_Cancel"), self, ISTradingUI.onClick);
    self.no.internal = "CANCEL";
    self.no:initialise();
    self.no:instantiate();
    self.no:enableCancelColor();
    self:addChild(self.no);

    self.historic = ISButton:new(self.hisOfferDatas.x + self.hisOfferDatas.width - (math.max(btnWid, getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_TradingUI_Historical")) + 10)), self.hisOfferDatas:getBottom() + 5, btnWid, btnHgt, getText("IGUI_TradingUI_Historical"), self, ISTradingUI.onClick);
    self.historic.internal = "HISTORIC";
    self.historic:initialise();
    self.historic:instantiate();
    self.historic.borderColor = {r=1, g=1, b=1, a=0.4};
    self:addChild(self.historic);

    self.acceptDeal = ISButton:new(self.hisOfferDatas.x + self.hisOfferDatas.width - (math.max(btnWid, getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_TradingUI_AcceptDeal")) + 10)), self.no.y, btnWid, btnHgt, getText("IGUI_TradingUI_AcceptDeal"), self, ISTradingUI.onClick);
    self.acceptDeal.internal = "ACCEPTDEAL";
    self.acceptDeal:initialise();
    self.acceptDeal:instantiate();
    self.acceptDeal.tooltip = getText("IGUI_TradingUI_AcceptDealTooltip");
    self.acceptDeal:enableAcceptColor();
    self:addChild(self.acceptDeal);

    self:setWidth(self.hisOfferDatas:getRight() + UI_BORDER_SPACING)
    self:setHeight(self.no:getBottom() + UI_BORDER_SPACING)
    self:centerOnScreen(self.player:getIndex())
end

function ISTradingUI:onSealOffer(clickedOption, enabled)
    if enabled then
        tradingUISendUpdateState(self.player, self.otherPlayer, ISTradingUI.States.SealOffer);
    else
        tradingUISendUpdateState(self.player, self.otherPlayer, ISTradingUI.States.UnSealOffer);
    end
end

function ISTradingUI:isOfferSealed()
    return self.sealOffer.selected[1] == true
end

function ISTradingUI:addItemToYourOffer(item)
    if #self.yourOfferDatas.items + 1 > ISTradingUI.MaxItems then
        self:setHistoryMessage(getText("IGUI_TradingUI_MaxItemReached", ISTradingUI.MaxItems), false, false, false);
        return;
    end
    if luautils.haveToBeTransfered(self.player, item) then
        self:setHistoryMessage(getText("IGUI_TradingUI_ItemNeedTransfer", item:getName()), false, false, false);
        return;
    end
    if self.player:isEquipped(item) or self.player:isEquippedClothing(item) then
        self:setHistoryMessage(getText("IGUI_TradingUI_ItemNeedUnequip", item:getName()), false, false, false);
        return;
    end
    if item:isFavorite() then
        self:setHistoryMessage(getText("IGUI_TradingUI_CantAddFavorite"), false, false, false);
        return;
    end
    local add = true;
    for i,v in ipairs(self.yourOfferDatas.items) do
        if v.item == item then
            add = false;
            break;
        end
    end
    if add then
        self.yourOfferDatas:addItem(item:getName(), item);
        self.inventoryList:updateLater();
        tradingUISendAddItem(self.player, self.otherPlayer, item);
        self.otherSealedOffer = false;
        if #self.yourOfferDatas.items == 1 then
            self.yourOfferDatas.selected = 1;
        end
    end
end

function ISTradingUI:isItemOffered(item)
    for _,listItem in ipairs(self.yourOfferDatas.items) do
        if listItem.item == item then
            return true
        end
    end
    return false
end

function ISTradingUI:update()
    local otherPlayer = getPlayerByOnlineID(self.otherPlayer:getOnlineID())
    if not otherPlayer then
        self.blockingMessage = getText("IGUI_TradingUI_ClosedTrade", self.otherPlayer:getDisguisedDisplayName())
    end
    if not self.blockingMessage and (math.abs(otherPlayer:getX() - self.player:getX()) > 2 or
            math.abs(otherPlayer:getY() - self.player:getY()) > 2) then
        self.blockingMessage2 = getText("IGUI_TradingUI_TooFarAway", self.otherPlayer:getDisguisedDisplayName())
    else
        self.blockingMessage2 =nil;
    end
    self.inventoryList:updateYourInventory()
    -- check if an item isn't in player's inventory, then we remove it
    for i,v in ipairs(self.yourOfferDatas.items) do
       if luautils.haveToBeTransferedWhileTrading(self.player, v.item) then
           self:removeItem(v);
           break;
        end
    end
    if not self:isVisible() then
        if self.historicalUI and self.historicalUI:isVisible() then
            self.historicalUI:close();
        end
        if self.infoRichText and self.infoRichText:isVisible() then
            self.infoRichText:destroy();
        end
    end
    local joypadData = getJoypadData(self.player:getIndex())
    if joypadData then
        local reInit = self.joypadButtonsBlocked ~= self:isInputBlocked()
        reInit = reInit or (self.joypadButtonsSealed ~= self:isOfferSealed())
        if reInit then
            self:initJoypadButtons(joypadData)
        end
    end
end

function ISTradingUI:removeItem(item)
    tradingUISendRemoveItem(self.player, self.otherPlayer, item.item);
    self.yourOfferDatas:removeItemByIndex(item.index);
    self.otherSealedOffer = false;
    self.inventoryList:updateLater();
end

function ISTradingUI:onInvokeListItem_Inventory(data)
    if self:isOfferSealed() then return end
    if data.isGroupHeader then
        for _,item in ipairs(data.itemTable.items) do
            self:addItemToYourOffer(item)
        end
    else
        self:addItemToYourOffer(data.item)
    end
end

function ISTradingUI:onInvokeListItem_YourOffer(data)
    if self:isOfferSealed() then return end
    self:removeItem(self.yourOfferDatas.items[self.yourOfferDatas.selected])
end

function ISTradingUI:drawOffer(y, item, alt)
    local a = 0.9;
    self:drawRectBorder(0, y, self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    if self.selected == item.index and not self.parent:isOfferSealed() then
        self:drawRect(0, y, self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15);
        if self == self.parent.yourOfferDatas then
            self.parent.selectedItem = item;
        end
    end
    self:drawTextureScaledAspect(item.item:getTex(), 5, y + 2, 18, 18, 1, item.item:getR(), item.item:getG(), item.item:getB());
    self:drawText(item.text, 25, y, 1, 1, 1, a, self.font);
    return y + self.itemheight;
end

function ISTradingUI:prerender()
    local z = 5;
    local splitPoint = 100;
    local x = UI_BORDER_SPACING;
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawText(getText("IGUI_TradingUI_Title"), self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_TradingUI_Title")) / 2), z, 1,1,1,1, UIFont.Medium);
    self:drawText(getText("IGUI_TradingUI_YourOffer"), self.yourOfferDatas.x, self.yourOfferDatas.y - FONT_HGT_SMALL * 2, 1,1,1,1, UIFont.Small);
    self:drawText(getText("IGUI_TradingUI_HisOffer", self.otherPlayer:getDisguisedDisplayName()), self.hisOfferDatas.x, self.hisOfferDatas.y - FONT_HGT_SMALL * 2, 1,1,1,1, UIFont.Small);

    local yourItems = getText("IGUI_TradingUI_Items", #self.yourOfferDatas.items, ISTradingUI.MaxItems);
    self:drawText(yourItems, self.yourOfferDatas.x, self.yourOfferDatas.y - FONT_HGT_SMALL, 1,1,1,1, UIFont.Small);
    local hisItems = getText("IGUI_TradingUI_Items", #self.hisOfferDatas.items, ISTradingUI.MaxItems);
    self:drawText(hisItems, self.hisOfferDatas.x, self.hisOfferDatas.y - FONT_HGT_SMALL, 1,1,1,1, UIFont.Small);

    if self.otherSealedOffer then
        self:drawText(getText("IGUI_TradingUI_OtherPlayerSealedOffer", self.otherPlayer:getDisguisedDisplayName()), self.sealOffer.x, self.sealOffer:getBottom() + 5, 0.2,1,0.2,1, UIFont.Small);
    end
    z = z + 30;
end

function ISTradingUI:getTooltipItem()
    local joypadData = getJoypadData(self.player:getIndex())
    if joypadData ~= nil then
        if joypadData.focus == self.inventoryList then
            local row = self.inventoryList.selected
            if self.inventoryList.items[row] then
                return self.inventoryList.items[row].item.item
            end
        end
        if joypadData.focus == self.yourOfferDatas then
            local row = self.yourOfferDatas.selected
            if self.yourOfferDatas.items[row] then
                return self.yourOfferDatas.items[row].item
            end
        end
        if joypadData.focus == self.hisOfferDatas then
            local row = self.hisOfferDatas.selected
            if self.hisOfferDatas.items[row] then
                return self.hisOfferDatas.items[row].item
            end
        end
        return nil
    end
    if self.inventoryList:isMouseOver() then
        local row = self.inventoryList:rowAt(self.inventoryList:getMouseX(), self.inventoryList:getMouseY())
        if self.inventoryList.items[row] then
            return self.inventoryList.items[row].item.item
        end
    end
    if self.yourOfferDatas:isMouseOver() then
        local row = self.yourOfferDatas:rowAt(self.yourOfferDatas:getMouseX(), self.yourOfferDatas:getMouseY())
        if self.yourOfferDatas.items[row] then
            return self.yourOfferDatas.items[row].item
        end
    end
    if self.hisOfferDatas:isMouseOver() then
        local row = self.hisOfferDatas:rowAt(self.hisOfferDatas:getMouseX(), self.hisOfferDatas:getMouseY())
        if self.hisOfferDatas.items[row] then
            return self.hisOfferDatas.items[row].item
        end
    end
    return nil
end

function ISTradingUI:updateTooltip()
    local item = self:getTooltipItem();
    if item then
        if self.toolRender then
            self.toolRender:setItem(item);
            if not self:getIsVisible() then
                self.toolRender:setVisible(false);
            else
                self.toolRender:setVisible(true);
                self.toolRender:addToUIManager();
                self.toolRender:bringToTop();
            end
        else
            self.toolRender = ISToolTipInv:new(item);
            self.toolRender:initialise();
            self.toolRender:addToUIManager();
            if not self:getIsVisible() then
                self.toolRender:setVisible(true);
            end
            self.toolRender:setOwner(self);
            self.toolRender:setCharacter(self.player);
            local joypadData = getJoypadData(self.player:getIndex())
            if joypadData then
                self.toolRender.anchorBottomLeft = { x=self.x+20, y=self.y }
                self.toolRender.followMouse = false
            else
                self.toolRender:setX(self:getMouseX())
                self.toolRender:setY(self:getMouseY())
                self.toolRender.anchorBottomLeft = nil
                self.toolRender.followMouse = true
            end
        end
    else
        if self.toolRender then
            self.toolRender:setVisible(false)
        end
    end
end

function ISTradingUI:updateButtons()
    self.addBtn.enable = false;
    self.remove.enable = false;
    self.sealOffer.enable = false;
    self.acceptDeal.enable = false;
    self.acceptDeal:enableDisabledColor();
    self.historic.enable = false;
    self.infoBtn.enable = false;
    self.acceptDeal.tooltip = nil;
    if self.blockingMessage or self.blockingMessage2 then
        return;
    end
    self.infoBtn.enable = true;
    if not self:isOfferSealed() and self.inventoryList.items[self.inventoryList.selected] and self.yourOfferDatas:size() < ISTradingUI.MaxItems then
        self.addBtn.enable = true;
    end
    if #self.yourOfferDatas.items > 0 and self.selectedItem and not self:isOfferSealed() then
        self.remove.enable = true;
    end
    self.sealOffer.enable = true;
    self.historic.enable = true;
    if self:isOfferSealed() and self.otherSealedOffer then
        if #self.yourOfferDatas.items > 0 or #self.hisOfferDatas.items > 0 then
            self.acceptDeal.enable = true;
            self.acceptDeal:enableAcceptColor();
        else
            self.acceptDeal.tooltip = getText("IGUI_TradingUI_TradeAtLeastOne");
        end
    elseif not self.blockingMessage then
        self.acceptDeal.tooltip = getText("IGUI_TradingUI_AcceptDealTooltip");
    end
end

function ISTradingUI:render()
    self:updateButtons();
    self:updateTooltip();
    if self:isOfferSealed() then
        self:drawRect(self.yourOfferDatas.x + 1, self.yourOfferDatas.y + 1, self.yourOfferDatas.width - 2, self.yourOfferDatas.height - 2, 0.8, 0, 0, 0);
        self:drawTextCentre(getText("IGUI_TradingUI_OfferSealed"), self.yourOfferDatas.x + self.yourOfferDatas.width / 2, self.yourOfferDatas.y + self.yourOfferDatas.height / 2 - FONT_HGT_SMALL / 2, 1,1,1,1, UIFont.Small);
    end
    if self.blockingMessage or self.blockingMessage2 then
        self:drawRect(1, 1, self.width-2, self.no.y - 5, 0.8, 0, 0, 0);
        self:drawTextCentre(self.blockingMessage or self.blockingMessage2, self.width / 2, self.height / 2 - FONT_HGT_MEDIUM / 2, 1,1,1,1, UIFont.Medium);
        self.no:setTitle(getText("IGUI_CraftUI_Close"))
    end

    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    if self.historyMessageCD > 0 then
       self.historyMessageCD = self.historyMessageCD - 1;
       self:drawText(self.historyMessage, self.width/2 - (getTextManager():MeasureStringX(UIFont.Small, self.historyMessage) / 2), self.no.y - 5 - FONT_HGT_SMALL, 1,1,1,1, UIFont.Small);
    end

    if not (self.blockingMessage or self.blockingMessage2) and getJoypadData(self.player:getIndex()) then
        local iconSize = self.sealOffer.height
        self:drawTextureScaledAspect(Joypad.Texture.YButton, self.sealOffer.x - 5 - iconSize, self.sealOffer.y, iconSize, iconSize, 1.0, 1.0, 1.0, 1.0)
    end
end

function ISTradingUI:onClick(button)
    if button.internal == "INFO" then
        self:showInfoWindow();
    end
    if button.internal == "CANCEL" then
        if self.historicalUI and self.historicalUI:isVisible() then
            self.historicalUI:close();
        end
        self:close();
        tradingUISendUpdateState(self.player, self.otherPlayer, ISTradingUI.States.PlayerClosedWindow);
    end
    if button.internal == "ADD" then
        self:addSelectedInventoryItem()
    end
    if button.internal == "REMOVE" then
        self:removeItem(self.selectedItem)
    end
    if button.internal == "HISTORIC" then
        if not self.historicalUI or not self.historicalUI:isVisible() then
            local ui = ISTradingUIHistorical:new(self.x + self.width + 5, self.y + self.height / 2 - 150, 300, 300, self.historical, self.otherPlayer)
            ui:initialise();
            ui:addToUIManager();
            self.historicalUI = ui;
        else
            self.historicalUI:bringToTop();
        end
        local joypadData = getJoypadData(self.player:getIndex())
        if joypadData then
            self.historicalUI.prevFocus = self
            setJoypadFocus(self.player:getIndex(), self.historicalUI)
            self.historicalUI:centerOnScreen(self.player:getIndex())
        end
    end
    if button.internal == "ACCEPTDEAL" then
        tradingUISendUpdateState(self.player, self.otherPlayer, ISTradingUI.States.FinalizeDeal);
        self:finalizeDeal();
    end
end

function ISTradingUI:showInfoWindow()
    if not self.infoRichText then
        self.infoRichText = ISModalRichText:new(200,200,600,600,getText("UI_TradingUIHelp"), false);
        self.infoRichText.destroyOnClick = false;
        self.infoRichText:initialise();
        self.infoRichText:addToUIManager();
        self.infoRichText.chatText:paginate();
        self.infoRichText.backgroundColor = {r=0, g=0, b=0, a=1};
        self.infoRichText:setHeight(self.infoRichText.chatText:getHeight() + 40);
        self.infoRichText:centerOnScreen(self.player:getIndex())
        self.infoRichText:setVisible(true);
    else
        self.infoRichText:setVisible(not self.infoRichText:getIsVisible());
        self.infoRichText:bringToTop();
    end
    local joypadData = self.joyfocus
    if joypadData then
        self.infoRichText.prevFocus = self
        setJoypadFocus(self.player:getIndex(), self.infoRichText)
    end
end

function ISTradingUI:addSelectedInventoryItem()
    if self:isOfferSealed() then return end
    local listItem = self.inventoryList.items[self.inventoryList.selected]
    if not listItem then return end
    local data = listItem.item
    if data.isGroupHeader then
        for _,item in ipairs(data.itemTable.items) do
            self:addItemToYourOffer(item)
        end
    else
        self:addItemToYourOffer(data.item)
    end
    self.inventoryList:updateLater()
end

function ISTradingUI:close()
    self:setVisible(false)
    self:removeFromUIManager()
    local playerNum = self.player:getIndex()
    if isJoypadFocusOnElementOrDescendant(playerNum, self) then
        local joypadData = getJoypadData(playerNum)
        joypadData.focus = self.prevFocus
        updateJoypadFocus(joypadData)
    end
end

function ISTradingUI:finalizeDeal()
    self:close();
end

function ISTradingUI:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
    if self:isDescendant(joypadData.switchingFocusFrom) then
        self:restoreJoypadFocus(joypadData)
        self:setISButtonForB(self.no)
    else
        self.joypadIndexY = 2
        self.joypadIndex = 1
        self:initJoypadButtons(joypadData)
        if self.joypadButtonsSealed or self.joypadButtonsBlocked then
            self:setISButtonForB(self.no)
        else
            setJoypadFocus(joypadData.player, self.inventoryList)
            if joypadData.focus == self.inventoryList then
                self.inventoryList.joyfocus = joypadData
            end
        end
    end
end

function ISTradingUI:onLoseJoypadFocus(joypadData)
    ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
    self:clearJoypadFocus()
    self.no:clearJoypadButton()
end

function ISTradingUI:onJoypadDown(button, joypadData)
    if button == Joypad.YButton then
        self.sealOffer.joypadIndex = 1
        self.sealOffer:forceClick()
        return
    end
    ISPanelJoypad.onJoypadDown(self, button, joypadData)
end

function ISTradingUI:onJoypadDown_Descendant(descendant, button, joypadData)
    if button == Joypad.YButton then
        self:onJoypadDown(button, joypadData)
    end
end

function ISTradingUI:isInputBlocked()
    return self.blockingMessage ~= nil or self.blockingMessage2 ~= nil
end

function ISTradingUI:initJoypadButtons(joypadData)
    if joypadData.focus == self.inventoryList or joypadData.focus == self.yourOfferDatas or joypadData.focus == self.hisOfferDatas then
        joypadData.focus = self
    end
    self:clearJoypadFocus(joypadData)
    local wasSealedOrBlocked = self.joypadButtonsSealed or self.joypadButtonsBlocked
    self.joypadButtonsSealed = self:isOfferSealed()
    self.joypadButtonsBlocked = self:isInputBlocked()
    self:clearJoypadButtonsList()
    if self.joypadButtonsBlocked then
        self:insertNewLineOfButtons(self.no)
        self.joypadIndexY = 1
        self.joypadIndex = 1
    else
        self:insertNewLineOfButtons(self.infoBtn)
        if not self.joypadButtonsSealed then
            self:insertNewLineOfButtons(self.inventoryList, self.yourOfferDatas, self.hisOfferDatas)
        end
        self:insertNewLineOfButtons(self.addBtn, self.remove, self.historic)
        self:insertNewLineOfButtons(self.sealOffer)
        self:insertNewLineOfButtons(self.no, self.acceptDeal)
        self.joypadIndexY = self.joypadButtonsSealed and 3 or 2
        self.joypadIndex = 1
    end
    if isJoypadFocusOnElementOrDescendant(self.player:getIndex(), self) then
        self:restoreJoypadFocus(joypadData)
        if wasSealedOrBlocked and not (self.joypadButtonsSealed or self.joypadButtonsBlocked) then
            self:setJoypadFocus(self.inventoryList, joypadData)
            joypadData.focus = self.inventoryList
        end
    end
end

function ISTradingUI:new(x, y, width, height, player, otherPlayer)
    x = getCore():getScreenWidth() / 2 - (width / 2);
    y = getCore():getScreenHeight() / 2 - (height / 2);
    width = UI_BORDER_SPACING * 3 + LIST_WIDTH * 2;
    height = 450;
    local o = ISPanelJoypad.new(self, x, y, width, height);
    player:StopAllActionQueue();
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.listHeaderColor = {r=0.4, g=0.4, b=0.4, a=0.3};
    o.width = width;
    o.height = height;
    o.player = player;
    o.otherPlayer = otherPlayer;
    o.moveWithMouse = true;
    o.yourOffer = nil;
    o.hisOffer = nil;
    o.selectedItem = nil;
    o.pendingRequest = false;
    o.historyMessage = nil;
    o.historyMessageCD = 0;
    o.blockingMessage = nil;
    o.otherSealedOffer = false;
    o.historical = {};
    ISTradingUI.windows[player:getIndex()+1] = o;
    return o;
end

function ISTradingUI:onAnswerTradeRequest(button)
    local player = button.parent.playerObj
    local otherPlayer = button.parent.requester
    if button.internal == "YES" then
        local tradingUI = ISTradingUI.GetUIForPlayer(player)
        if tradingUI and tradingUI:isVisible() then
            tradingUISendUpdateState(tradingUI.player, tradingUI.otherPlayer, ISTradingUI.States.PlayerClosedWindow);
            tradingUI:close();
        end
        ISTradingUI.tradeQuestionUI = nil;
        local ui = ISTradingUI:new(50,50,500,550, player, otherPlayer)
        ui:initialise();
        ui:addToUIManager();
        local joypadData = getJoypadData(player:getIndex())
        if joypadData then
            ui.prevFocus = button.parent.prevFocus
            setJoypadFocus(player:getIndex(), ui)
        end
    end
    acceptTrading(player, otherPlayer, button.internal == "YES");
end

-- someone ask us to trade
ISTradingUI.ReceiveTradeRequest = function(otherPlayer, player)
    local modal = ISModalDialog:new(getCore():getScreenWidth() / 2 - 175,getCore():getScreenHeight() / 2 - 75, 350, 150, getText("IGUI_TradingUI_RequestTrade", otherPlayer:getDisplayName()), true, nil, ISTradingUI.onAnswerTradeRequest);
    modal:initialise()
    modal:addToUIManager()
    modal.playerObj = player
    modal.requester = otherPlayer;
    modal.moveWithMouse = true;
    modal:centerOnScreen(player:getIndex())
    ISTradingUI.tradeQuestionUI = modal;
    local joypadData = getJoypadData(player:getIndex())
    if joypadData then
        modal.prevFocus = joypadData.focus
        setJoypadFocus(player:getIndex(), modal)
    end
end

-- the other player accepted the trade!
ISTradingUI.AcceptedTrade = function(otherPlayer, player, accepted)
    local tradingUI = ISTradingUI.GetUIForPlayer(player)
    if tradingUI and tradingUI:isVisible() then
        tradingUI.pendingRequest = false;
        tradingUI.blockingMessage = nil;
        if not accepted then
            tradingUI.blockingMessage = getText("IGUI_TradingUI_RefusedTrade", otherPlayer:getDisguisedDisplayName());
        end
    end
end

-- other player has added a new item to his offer
ISTradingUI.OtherAddNewItem = function(otherPlayer, player, item)
    local tradingUI = ISTradingUI.GetUIForPlayer(player)
    if tradingUI and tradingUI:isVisible() then
        local index = tradingUI:getIndexFromItemId(item:getID());
        if index ~= -1 then return end;
        tradingUI.hisOfferDatas:addItem(item:getName(), item);
        if #tradingUI.hisOfferDatas.items == 1 then
            tradingUI.hisOfferDatas.selected = 1;
        end
        tradingUI:setHistoryMessage(getText("IGUI_TradingUI_AddedItem", otherPlayer:getDisplayName(), item:getName()), true, true, false);
        tradingUI.sealOffer.selected[1] = false;
        tradingUI.otherSealedOffer = false;
    end
end

function ISTradingUI:getIndexFromItemId(itemId)
    for i,v in ipairs(self.hisOfferDatas.items) do
        if v.item:getID() == itemId then
            return i;
        end
    end
print('error: item with ID '..itemId.. ' not found')
    return -1;
end

-- other player removed an item from his offer
ISTradingUI.RemoveItem = function(otherPlayer, player, itemId)
    local tradingUI = ISTradingUI.GetUIForPlayer(player)
    if tradingUI and tradingUI:isVisible() then
        local index = tradingUI:getIndexFromItemId(itemId);
        if index == -1 then return; end
        local itemRemoved = tradingUI.hisOfferDatas.items[index];
        tradingUI.hisOfferDatas:removeItemByIndex(index);
        tradingUI:setHistoryMessage(getText("IGUI_TradingUI_RemovedItem", otherPlayer :getDisplayName(), itemRemoved.item:getName()), true, false, true);
        tradingUI.sealOffer.selected[1] = false;
        tradingUI.otherSealedOffer = false;
    end
end

function ISTradingUI:setHistoryMessage(message, publishInHistorical, add, remove)
    if self and self:isVisible() then
        self.historyMessage = message;
        local hMessage = {};
        hMessage.message = message;
        hMessage.add = add;
        hMessage.remove = remove;
        self.historyMessageCD = ISTradingUI.CoolDownMessage;
        if publishInHistorical then
            table.insert(self.historical, hMessage);
            if self.historicalUI and self.historicalUI:isVisible() then
                self.historicalUI:populateList(self.historical);
            end
        end
    end
end

-- other player did something on his tradeUI (closed, seal his offer, finalize deal...)
ISTradingUI.UpdateState = function(otherPlayer, player, state)
    local tradingUI = ISTradingUI.GetUIForPlayer(player)
    if state == ISTradingUI.States.PlayerClosedWindow then
        if ISTradingUI.tradeQuestionUI and ISTradingUI.tradeQuestionUI:isVisible() then
            ISTradingUI.tradeQuestionUI:setVisible(false);
            ISTradingUI.tradeQuestionUI:removeFromUIManager();
        elseif tradingUI and tradingUI:isVisible() and tradingUI.otherPlayer == otherPlayer then
            tradingUI.blockingMessage = getText("IGUI_TradingUI_ClosedTrade", otherPlayer:getDisplayName());
        end
    end
    if tradingUI and tradingUI:isVisible() then
        if state == ISTradingUI.States.SealOffer then
            tradingUI.otherSealedOffer = true;
            tradingUI:setHistoryMessage(getText("IGUI_TradingUI_OtherPlayerSealedOffer", tradingUI.otherPlayer:getDisguisedDisplayName()), true, false, false);
        end
        if state == ISTradingUI.States.UnSealOffer then
            tradingUI.otherSealedOffer = false;
            tradingUI:setHistoryMessage(getText("IGUI_TradingUI_OtherPlayerUnSealedOffer", tradingUI.otherPlayer:getDisguisedDisplayName()), true, false, false);
        end
        if state == ISTradingUI.States.FinalizeDeal then
            tradingUI:finalizeDeal();
        end
    end
end

Events.RequestTrade.Add(ISTradingUI.ReceiveTradeRequest)
Events.AcceptedTrade.Add(ISTradingUI.AcceptedTrade)
Events.TradingUIAddItem.Add(ISTradingUI.OtherAddNewItem)
Events.TradingUIRemoveItem.Add(ISTradingUI.RemoveItem)
Events.TradingUIUpdateState.Add(ISTradingUI.UpdateState)
