--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISPanel"

ISBaseStockingLayout = ISPanel:derive("ISBaseStockingLayout");
ISBaseStockingLayout.defaultJoypadMoveInterval = 20;

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small);
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium);

function ISBaseStockingLayout:initialise()
    ISPanel.initialise(self)
end

function ISBaseStockingLayout:createChildren()
    ISPanel.createChildren(self);

    self.width = 350;
    self.height = 450;

    local x = 10;
    local y = 10;

    self.frontPanel = IS9Patch:new(10, 10, self.productPanelWidth, self.productPanelHeight, self.interiorTextures);
    --self.frontPanel = ISPanel:new(10, 10, self.productPanelWidth, self.productPanelHeight);
    self.frontPanel.background = true;
    self.frontPanel:initialise();
    self.frontPanel:instantiate();
    self:addChild(self.frontPanel);

    x = self.frontPanel:getX() + self.frontPanel:getWidth() + 10;
    y = self.frontPanel:getY() + self.frontPanel:getHeight();

    self.resourceMoney = self.resources:getResource("money_storage");
    self.itemSlotMoney = ISItemSlot:new (x, y-10-44, 44, 44, self.resourceMoney)
    self.itemSlotMoney.renderItemCount = true;
    self.itemSlotMoney:initialise();
    self.itemSlotMoney:instantiate();
    self.itemSlotMoney:setCharacter(self.player);
    self.itemSlotMoney:setResource( self.resourceMoney );
    self.itemSlotMoney.functionTarget = self.parentPanel;
    self.itemSlotMoney.onBoxClicked = ISBlueprintLogicPanel.onItemSlotTakeItems;
    self.itemSlotMoney.onItemDropped = ISBlueprintLogicPanel.onItemSlotDroppedItems; --when items dragged under mouse are dropped in box
    --uiSlot.onVerifyItem = ISBlueprintLogicPanel.onItemSlotVerifyItem; --when items are checked to see if box can accept
    self.itemSlotMoney.onItemRemove = ISBlueprintLogicPanel.onItemSlotRemoveItem; --when rightclicking to remove item
    self:addChild(self.itemSlotMoney);

    local keyX, keyY = x, y+10;

    self.buttonPower = ISButton:new(x, self.frontPanel:getY(), 44, 20, "On")
    self.buttonPower.target = self;
    self.buttonPower.onclick = ISBaseStockingLayout.onButtonClick;
    self.buttonPower.enable = true;
    self.buttonPower:initialise();
    self.buttonPower:instantiate();
    self:addChild(self.buttonPower);

    self.vendingOptions = {};

    x = self.frontPanel:getX();
    y = self.frontPanel:getY();

    local products = self.resources:getResources(self.arrayList, "Stock");

    local rowCount = round(products:size() / self.productColumns, 0);
    local cellW = self.frontPanel:getWidth() / self.productColumns;
    local cellH = self.frontPanel:getHeight() / rowCount;

    local column = 0;
    local row = 0;
    for i=0,products:size()-1 do
        local resource = products:get(i);

        local cellCenterX = x + (cellW/2) + (column * cellW);
        local cellCenterY = y + (cellH/2) + (row * cellH);

        self:addVendingOption(i, cellCenterX, cellCenterY, resource);

        column = column + 1;
        if column >= self.productColumns then
            column = 0;
            row = row + 1;
        end
    end

    self.arrayList:clear();

    self.coverPanel = ISPanel:new(0, 0, 10, 10);
    self.coverPanel.background = true;
    self.coverPanel.backgroundColor = {r=0, g=0, b=0, a=1.0};
    self.coverPanel.borderColor = {r=0.6, g=0.6, b=0.6, a=0};
    self.coverPanel:initialise();
    self.coverPanel:instantiate();
    self:addChild(self.coverPanel);

    self.resourceKey = self.resources:getResource("key_input");
    self.itemSlotKey = ISItemSlot:new (keyX, keyY, 44, 44, self.resourceKey)
    self.itemSlotKey.renderItemCount = false;
    self.itemSlotKey:initialise();
    self.itemSlotKey:instantiate();
    self.itemSlotKey:setCharacter(self.player);
    self.itemSlotKey:setResource( self.resourceKey );
    self.itemSlotKey.functionTarget = self.parentPanel;
    self.itemSlotKey.onBoxClicked = ISBlueprintLogicPanel.onItemSlotTakeItems;
    self.itemSlotKey.onItemDropped = ISBlueprintLogicPanel.onItemSlotDroppedItems; --when items dragged under mouse are dropped in box
    --uiSlot.onVerifyItem = ISBlueprintLogicPanel.onItemSlotVerifyItem; --when items are checked to see if box can accept
    self.itemSlotKey.onItemRemove = ISBlueprintLogicPanel.onItemSlotRemoveItem; --when rightclicking to remove item
    self:addChild(self.itemSlotKey);

    y = self.itemSlotKey:getY() + (self.itemSlotKey:getHeight() /2) - (FONT_HGT_SMALL/2);
    x = self.itemSlotKey:getX() - 10;

    self.scriptLabel = ISLabel:new(x, y, FONT_HGT_SMALL, "Operator Key:", 1, 1, 1, 1.0, UIFont.Small, false);
    self.scriptLabel:initialise();
    self.scriptLabel:instantiate();
    self:addChild(self.scriptLabel);

    self.width = self.itemSlotKey:getX() + self.itemSlotKey:getWidth() + 10;
    self.height = self.itemSlotKey:getY() + self.itemSlotKey:getHeight() + 10;
    self.coverPanel:setWidth(self.width);
    self.coverPanel:setHeight(self.height);

    self:setWidth(self.width);
    self:setHeight(self.height);
end

function ISBaseStockingLayout:addVendingOption(_index, _x, _y, _resource)
    local itemSlot = ISItemSlot:new (_x - 22, 0, 44, 44, _resource);
    itemSlot.renderItemCount = true;
    itemSlot:initialise();
    itemSlot:instantiate();
    itemSlot:setCharacter(self.player);
    itemSlot:setResource( _resource );
    itemSlot.functionTarget = self.parentPanel;
    itemSlot.onBoxClicked = ISBlueprintLogicPanel.onItemSlotTakeItems;
    itemSlot.onItemDropped = ISBlueprintLogicPanel.onItemSlotDroppedItems; --when items dragged under mouse are dropped in box
    --uiSlot.onVerifyItem = ISBlueprintLogicPanel.onItemSlotVerifyItem; --when items are checked to see if box can accept
    itemSlot.onItemRemove = ISBlueprintLogicPanel.onItemSlotRemoveItem; --when rightclicking to remove item
    self:addChild(itemSlot);

    local y = itemSlot:getY() + itemSlot:getHeight() + 2;

    local labelImage;
    if self.buttonImg and self.buttonImg[_index+1] then
        labelImage = ISImage:new(itemSlot:getX()+(itemSlot:getWidth()/2)-22, itemSlot:getY()-17, 44, 10, self.buttonImg[_index+1].on);
        labelImage.scaledWidth = 44;
        labelImage.scaledHeight = 10;
        --self.interiorPanel = ISPanel:new(10, 10, w, h);
        labelImage.background = true;
        labelImage:initialise();
        labelImage:instantiate();
        self:addChild(labelImage);
    end

    local lcd = ISLcdBar:new(_x-26, y, 6); --default = 48pix
    lcd.priceValue = 1;
    lcd:initialise();
    lcd:instantiate();
    lcd:setText("  1.00");
    self:addChild(lcd);

    local buttonMinus = ISButton:new(_x-26-18, y, 16, 16, "-")
    buttonMinus.productIndex = _index;
    buttonMinus.increment = false;
    buttonMinus.target = self;
    buttonMinus.onclick = ISBaseStockingLayout.onButtonClick;
    buttonMinus.enable = true;
    buttonMinus:initialise();
    buttonMinus:instantiate();
    self:addChild(buttonMinus);

    local buttonPlus = ISButton:new(_x+26+2, y, 16, 16, "+")
    buttonPlus.productIndex = _index;
    buttonPlus.increment = true;
    buttonPlus.target = self;
    buttonPlus.onclick = ISBaseStockingLayout.onButtonClick;
    buttonPlus.enable = true;
    buttonPlus:initialise();
    buttonPlus:instantiate();
    self:addChild(buttonPlus);

    local y = lcd:getY() + lcd:getHeight() + 2;

    local y = _y - (y/2);
    itemSlot:setY(y);
    if labelImage then
        labelImage:setY(y-11);
    end
    y = itemSlot:getY() + itemSlot:getHeight() + 2;
    lcd:setY(y);
    buttonMinus:setY(y);
    buttonPlus:setY(y);
    y = lcd:getY() + lcd:getHeight() + 2;
    --button:setY(y);

    table.insert(self.vendingOptions, {
        lcd = lcd,
        itemSlot = itemSlot,
        buttonMinus = buttonMinus,
        buttonPlus = buttonPlus,
        resource = _resource,
        index = _index,
        labelImage = labelImage,
    })
end

function ISBaseStockingLayout:getVendingOption(_index)
    return self.vendingOptions[_index+1];
end

function ISBaseStockingLayout:onButtonClick(_button)
    if _button==self.buttonPower then
        --[[
        if self:getCredits()<self:getProductPrice(vendingOption.resource:getId()) then
            return;
        end
        --]]
        if self.parentPanel:doWalkTo() then
            local pp = self.parentPanel;
            local action = ISBaseCrafterAction:new(pp.player, pp.entity, self.blueprintLogic, pp.window.progressBar);
            action.actionAnim = CharacterActionAnims.Craft;
            action.hideHandItems = true;
            action.actionText = "toggle power";
            action.eventName = "event_toggle_power";
            action.blockMovement = true;
            -- isValid override
            action.isValid = function(action)
                return pp:isActionsValid(); -- and action.uiPanel.blueprintLogic:getCrafterParts():isRequiresRepair();
            end
            ISTimedActionQueue.add(action);
        end
    elseif type(_button.productIndex)=="number" then
        local vendingOption = self:getVendingOption(_button.productIndex);

        if not vendingOption then
            return;
        end

        if _button==vendingOption.buttonPlus and vendingOption.resource then
            local resource = vendingOption.resource;
            local price = round(self:getProductPrice(resource:getId()), 0);
            price = price + 1;
            if price<self:getMaxCredits() and resource and resource:getId() then
                self.blueprintLogic:triggerEvent("set_price:"..tostring(resource:getId())..":"..tostring(price));
            end
        elseif _button==vendingOption.buttonMinus and vendingOption.resource then
            local resource = vendingOption.resource;
            local price = round(self:getProductPrice(resource:getId()), 0);
            price = price - 1;
            if price>=0 and resource and resource:getId() then
                self.blueprintLogic:triggerEvent("set_price:"..tostring(resource:getId())..":"..tostring(price));
            end
        end
    end
end

function ISBaseStockingLayout:getMaxCredits()
    return BlueprintCode.BaseVendorShared.getMaxCredits(self.blueprintLogic);
end

function ISBaseStockingLayout:getProductPrice(_productId)
    return BlueprintCode.BaseVendorShared.getProductPrice(self.blueprintLogic, _productId);
end

function ISBaseStockingLayout:isTurnedOn()
    return BlueprintCode.BaseVendorShared.isTurnedOn(self.blueprintLogic);
end

function ISBaseStockingLayout:isRunning()
    return BlueprintCode.BaseVendorShared.isRunning(self.blueprintLogic);
end

function ISBaseStockingLayout:update()
end

function ISBaseStockingLayout:prerender()
    ISPanel.prerender(self);
    if self.blueprintLogic then
        local unlocked = BlueprintCode.BaseVendorShared.isUnlocked(self.blueprintLogic);
        self.coverPanel:setVisible(not unlocked);

        if self:isRunning() then
            self.frontPanel.img = self.interiorTextures;
        else
            self.frontPanel.img = self.interiorUnlitTextures;
        end

        if self:isTurnedOn() then
            self.buttonPower.backgroundColor = self.buttonOnColor;
            self.buttonPower.title = "On";
            self.buttonPower.textColor = self.textColorOn;
        else
            self.buttonPower.backgroundColor = self.buttonOffColor;
            self.buttonPower.title = "Off";
            self.buttonPower.textColor = self.textColorOff;
        end

        -- update vending options
        for k,v in ipairs(self.vendingOptions) do
            local price = self:getProductPrice(v.resource:getId());

            if v.lcd.priceValue~=price then
                v.lcd.priceValue = price;
                local s = string.format("%.2f", price); --round(credits, 2);
                if s:len()<v.lcd.lcdwidth then
                    s = string.rep(" ", v.lcd.lcdwidth-s:len())..s;
                end
                v.lcd:setText(s);
            end
        end
    end
end

function ISBaseStockingLayout:render()
    ISPanel.render(self);
end

function ISBaseStockingLayout:new (x, y, _parentPanel, _blueprintLogic)
    local o = ISPanel:new(x, y, 100, 100);
    setmetatable(o, self)
    self.__index = self
    o.x = x;
    o.y = y;
    o.background = false;
    o.backgroundColor = {r=0, g=0, b=0, a=0.0};
    o.borderColor = {r=0.6, g=0.6, b=0.6, a=1};
    o.anchorLeft = false;
    o.anchorRight = false;
    o.anchorTop = false;
    o.anchorBottom = false;

    o.arrayList = ArrayList.new();

    o.ledInvalidCol = {r=1.0, g=0.0, b=0.0, a =1.0};
    o.ledValidCol = {r=0.0, g=1.0, b=0.0, a =1.0};

    o.buttonOnColor = namedColorToTable("ItemSlotValid");-- {r=0, g=0.85, b=0, a=1.0};
    o.buttonOffColor = namedColorToTable("ItemSlotInvalid"); --{r=0.85, g=0.0, b=0, a=1.0};

    o.interiorTextures = ISEntityUtilUI.GetVendingInteriorTextures();
    o.interiorUnlitTextures = ISEntityUtilUI.GetVendingInteriorUnlitTextures();

    o.textColorOn = {r=0.2, g=0.2, b=0.2, a=1.0};
    o.textColorOff = {r=1.0, g=1.0, b=1.0, a=1.0};

    o.productColumns = 2;
    o.productPanelWidth = 250;
    o.productPanelHeight = 350;

    o.parentPanel = _parentPanel;
    o.blueprintLogic = _blueprintLogic;
    o.resources = _blueprintLogic:getResources();
    o.parts = _blueprintLogic:getCrafterParts();
    o.player = _parentPanel.player;
    o.playerNum = _parentPanel.player:getPlayerNum();
    o.joypadMoveInterval = ISBaseStockingLayout.defaultJoypadMoveInterval;
    return o
end