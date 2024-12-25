--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISPanel"

ISBaseVendingLayout = ISPanel:derive("ISBaseVendingLayout");
ISBaseVendingLayout.defaultJoypadMoveInterval = 20;

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small);
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium);

function ISBaseVendingLayout:initialise()
    ISPanel.initialise(self)
end

function ISBaseVendingLayout:createChildren()
    ISPanel.createChildren(self);

    self.width = 350;
    self.height = 450;

    local x = 10;
    local y = 10;

    local w, h = 250, 350;
    if self.frontImageOn then
        w = self.frontImageOn:getWidthOrig();
        h = self.frontImageOn:getHeightOrig();
    end
    self.frontPanel = ISImage:new(10, 10, w, h, self.frontImageOn);
    self.frontPanel.background = true;
    self.frontPanel:initialise();
    self.frontPanel:instantiate();
    self:addChild(self.frontPanel);

    self.trayPanel = IS9Patch:new(10, 370, self.frontPanel:getWidth(), 70, self.trayImgs);
    self.trayPanel.background = false;
    self.trayPanel.border = false;
    self.trayPanel:initialise();
    self.trayPanel:instantiate();
    self:addChild(self.trayPanel);

    x = self.trayPanel:getX() + (self.trayPanel:getWidth() / 2);
    y = self.trayPanel:getY() + (self.trayPanel:getHeight() / 2);

    self.resourceOutput = self.resources:getResource("output_tray");
    self.itemSlotOutput = ISItemSlot:new (x-22, y-22, 44, 44, self.resourceOutput)
    self.itemSlotOutput.renderItemCount = false;
    self.itemSlotOutput.borderInvalid = namedColorToTable("ItemSlotInvalid");
    self.itemSlotOutput:initialise();
    self.itemSlotOutput:instantiate();
    self.itemSlotOutput:setCharacter(self.player);
    self.itemSlotOutput:setResource( self.resourceOutput );
    self.itemSlotOutput.functionTarget = self.parentPanel;
    self.itemSlotOutput.onBoxClicked = ISBlueprintLogicPanel.onItemSlotTakeItems;
    self.itemSlotOutput.onItemDropped = ISBlueprintLogicPanel.onItemSlotDroppedItems; --when items dragged under mouse are dropped in box
    --uiSlot.onVerifyItem = ISBlueprintLogicPanel.onItemSlotVerifyItem; --when items are checked to see if box can accept
    self.itemSlotOutput.onItemRemove = ISBlueprintLogicPanel.onItemSlotRemoveItem; --when rightclicking to remove item
    self:addChild(self.itemSlotOutput);

    y = 10;
    x = 300;
    self.moneyLcd = ISLcdBar:new(x-16, y, 6); --default = 48pix
    self.moneyLcd.creditsValue = 0;
    self.moneyLcd.ledColor = { r=0.4, g=1, b=0.4 , a=1};
    --self.moneyLcd.ledTextColor = { r=1, g=1, b=1, a=1 };
    self.moneyLcd:initialise();
    self.moneyLcd:instantiate();
    self.moneyLcd:setText("  0.00");
    self:addChild(self.moneyLcd);

    y = self.moneyLcd:getY() + self.moneyLcd:getHeight() + 5;


    local midX = self.moneyLcd:getX() + (self.moneyLcd:getWidth()/2);
    self.resourceMoney = self.resources:getResource("money_input");
    self.itemSlotMoney = ISItemSlot:new (midX-22, y, 44, 44, self.resourceMoney)
    self.itemSlotMoney.renderItemCount = false;
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

    y = self.itemSlotMoney:getY() + self.itemSlotMoney:getHeight() + 20;

    self.vendingOptions = {};

    x = x-32;

    local products = self.resources:getResources(self.arrayList, "Stock");

    for i=0,products:size()-1 do
        local resource = products:get(i);
        y = self:addVendingOption(i, x, y, resource);
        y = y + 5;
    end

    self.arrayList:clear();

    if #self.vendingOptions>0 then
        self.optionArea = {};
        self.optionArea.x1 = self.vendingOptions[1].button:getX();
        self.optionArea.y1 = self.vendingOptions[1].button:getY();
        self.optionArea.x2 = self.vendingOptions[#self.vendingOptions].button:getX() + self.vendingOptions[#self.vendingOptions].button:getWidth();
        self.optionArea.y2 = self.vendingOptions[#self.vendingOptions].button:getY() + self.vendingOptions[#self.vendingOptions].button:getHeight();
    end

    self:setWidth(self.width);
    self:setHeight(self.height);
end

function ISBaseVendingLayout:addVendingOption(_index, _x, _y, _resource)
    local lcd = ISLcdBar:new(_x+16, _y, 6); --default = 48pix
    lcd.priceValue = 1;
    lcd:initialise();
    lcd:instantiate();
    lcd:setText("  1.00");
    self:addChild(lcd);

    local y = lcd:getY() + lcd:getHeight() + 4;

    local image = ISImage:new(_x+16, y, lcd:getWidth(), 20, "")
    image.imageInfo = self.buttonImg[_index+1];
    image.texture = image.imageInfo and image.imageInfo.on;
    image.background = true;
    image:initialise();
    image:instantiate();
    self:addChild(image);

    --local button = ISButton:new(_x+16, y, lcd:getWidth(), 20, "")
    local button = ISButton:new(image:getX(), image:getY(), image:getWidth(), image:getHeight(), "")
    --button.imageInfo = self.buttonImg[_index+1];
    --button.image = button.imageInfo and button.imageInfo.on;
    --button.displayBackground = false;
    button.backgroundColor = {r=0, g=0, b=0, a=0.0};
    button.backgroundColorMouseOver.a = 0.5;
    button.productIndex = _index;
    button.target = self;
    button.onclick = ISBaseVendingLayout.onButtonClick;
    button.enable = true;
    button:initialise();
    button:instantiate();
    self:addChild(button);

    local y = button:getY() + (button:getHeight()/2);

    local led = ISLedLight:new(_x, y-6, 12, 12);
    led.ledCol = {r=0.0, g=1.0, b=0.0, a =1.0};
    led.ledColOff = {r=0.3, g=0.0, b=0.0, a =1.0};
    led:initialise();
    led:instantiate();
    self:addChild(led);

    table.insert(self.vendingOptions, {
        lcd = lcd,
        image = image,
        button = button,
        led = led,
        resource = _resource,
        index = _index,
    })

    return button:getY() + button:getHeight();
end

function ISBaseVendingLayout:getVendingOption(_index)
    return self.vendingOptions[_index+1];
end

function ISBaseVendingLayout:onButtonClick(_button)
    if not self.itemSlotOutput.resource:isEmpty() then
        return;
    end
    if self:isRunning() and type(_button.productIndex)=="number" then
        local vendingOption = self:getVendingOption(_button.productIndex);

        if vendingOption then
            if self:getCredits()<self:getProductPrice(vendingOption.resource:getId()) then
                return;
            end
            if self.parentPanel:doWalkTo() then
                local pp = self.parentPanel;
                local action = ISBaseCrafterAction:new(pp.player, pp.entity, self.blueprintLogic, pp.window.progressBar);
                action.actionAnim = CharacterActionAnims.Craft;
                action.hideHandItems = true;
                action.actionText = "buying";
                action.eventName = "event_buy:"..tostring(vendingOption.resource:getId());
                action.blockMovement = true;
                -- isValid override
                action.isValid = function(action)
                    return pp:isActionsValid(); -- and action.uiPanel.blueprintLogic:getCrafterParts():isRequiresRepair();
                end
                ISTimedActionQueue.add(action);
            end
        end
    end
end

function ISBaseVendingLayout:getCredits()
    return BlueprintCode.BaseVendorShared.getCredits(self.blueprintLogic);
end

function ISBaseVendingLayout:getProductPrice(_productId)
    return BlueprintCode.BaseVendorShared.getProductPrice(self.blueprintLogic, _productId);
end

function ISBaseVendingLayout:isTurnedOn()
    return BlueprintCode.BaseVendorShared.isTurnedOn(self.blueprintLogic);
end

function ISBaseVendingLayout:isRunning()
    return BlueprintCode.BaseVendorShared.isRunning(self.blueprintLogic);
end

function ISBaseVendingLayout:update()
end

function ISBaseVendingLayout:onMouseMove(dx, dy)
    ISPanel.onMouseMove(self, dx, dy);
    if not self.optionArea then
        return;
    end
    local x = self:getMouseX();
    local y = self:getMouseY();
    if x>self.optionArea.x1 and x<self.optionArea.x2 and y>self.optionArea.y1 and y<self.optionArea.y2 then
        self.mouseOverButtons = true;
    else
        self.mouseOverButtons = false;
    end
end

function ISBaseVendingLayout:onMouseMoveOutside(dx, dy)
    ISPanel.onMouseMoveOutside(self, dx, dy);
    self.mouseOverButtons = false;
end

function ISBaseVendingLayout:prerender()
    ISPanel.prerender(self);

    if not self.blueprintLogic then
        return;
    end

    if not self:isRunning() then
        if self.frontImageOff then
            self.frontPanel.texture = self.frontImageOff;
        end
        self.moneyLcd:toggleOn( false );

        for k,v in ipairs(self.vendingOptions) do
            v.led:setLedIsOn( false );
            v.led.ledCol = self.ledInvalidCol;
            v.button.enable = false;
            v.button.borderColor = self.buttonBorderColorDisabled;
            v.button.backgroundColor.a = 0.25;
            if v.image.imageInfo then
                v.image.texture = v.image.imageInfo.off;
            end
            v.lcd:toggleOn( false );
        end
        return;
    end

    if self.mouseOverButtons then
        if self.itemSlotOutput.resource and (not self.itemSlotOutput.resource:isEmpty()) then
            self.itemSlotOutput.bBlinkBorder = true;
        else
            self.itemSlotOutput.bBlinkBorder = false;
        end
    else
        self.itemSlotOutput.bBlinkBorder = false;
    end

    if self.frontImageOn then
        self.frontPanel.texture = self.frontImageOn;
    end
    -- update credits
    self.moneyLcd:toggleOn( true );
    local credits = self:getCredits();
    if self.moneyLcd.creditsValue~=credits then
        self.moneyLcd.creditsValue = credits;
        local s = string.format("%.2f", credits); --round(credits, 2);
        if s:len()<self.moneyLcd.lcdwidth then
            s = string.rep(" ", self.moneyLcd.lcdwidth-s:len())..s;
        end
        self.moneyLcd:setText(s);
    end

    -- update vending options
    for k,v in ipairs(self.vendingOptions) do
        local resource = v.resource;
        local productId = resource:getId();
        local price = self:getProductPrice(productId);

        v.led:setLedIsOn( true );
        if resource:isEmpty() then
            v.led.ledCol = self.ledInvalidCol;
            v.button.enable = false;
            v.button.borderColor = self.buttonBorderColorDisabled;
            v.button.backgroundColor.a = 0.25;
            if v.image.imageInfo then
                v.image.texture = v.image.imageInfo.off;
            end
        else
            v.led.ledCol = self.ledValidCol;
            v.button.enable = true;
            v.button.borderColor = self.buttonBorderColor;
            v.button.backgroundColor.a = 0.0;
            if v.image.imageInfo then
                v.image.texture = v.image.imageInfo.on;
            end
        end
        --v.led:setLedIsOn( not resource:isEmpty() )

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

function ISBaseVendingLayout:render()
    ISPanel.render(self);
end

function ISBaseVendingLayout:new (x, y, _parentPanel, _blueprintLogic)
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

    o.frontImageOn = false; --getTexture("media/ui/Blueprint/Vending/Screen_on.png");
    o.frontImageOff = false; --getTexture("media/ui/Blueprint/Vending/Screen_off.png");

    o.buttonBorderColor = {r=0.7, g=0.7, b=0.7, a=1};
    o.buttonBorderColorDisabled = {r=0.2, g=0.2, b=0.2, a=1};
    o.buttonImg = {};

    --[[ Example of setting buttonImg table:

    o.btnNames = {"cola", "dietcola", "ginger", "orange", "water" };

    for k,v in ipairs(o.btnNames) do
        table.insert(o.buttonImg, {
            name = v;
            on = getTexture("media/ui/Blueprint/Vending/Button_"..v.."_on.png");
            off = getTexture("media/ui/Blueprint/Vending/Button_"..v.."_off.png");
        })
    end
    --]]

    o.arrayList = ArrayList.new();

    o.ledInvalidCol = {r=1.0, g=0.0, b=0.0, a =1.0};
    o.ledValidCol = {r=0.0, g=1.0, b=0.0, a =1.0};

    o.trayImgs = {
        getTexture("media/ui/Entity/Vending/Slot_left.png"),
        getTexture("media/ui/Entity/Vending/Slot_middle.png"),
        getTexture("media/ui/Entity/Vending/Slot_right.png"),
    };

    o.mouseOverButtons = false;

    o.parentPanel = _parentPanel;
    o.blueprintLogic = _blueprintLogic;
    o.resources = _blueprintLogic:getResources();
    o.parts = _blueprintLogic:getCrafterParts();
    o.player = _parentPanel.player;
    o.playerNum = _parentPanel.player:getPlayerNum();
    o.joypadMoveInterval = ISBaseVendingLayout.defaultJoypadMoveInterval;
    return o
end