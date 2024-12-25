--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISPanel"

local ISVendingAnim = ISPanel:derive("ISVendingAnim");

ISVendorVendingLayout = ISPanel:derive("ISVendorVendingLayout");
ISVendorVendingLayout.defaultJoypadMoveInterval = 20;

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small);
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium);

function ISVendorVendingLayout:initialise()
    ISPanel.initialise(self)
end

function ISVendorVendingLayout:createChildren()
    ISPanel.createChildren(self);

    self.width = 410;
    self.height = 450;

    local x = 10;
    local y = 10;

    local w, h = 300, 350;
    self.interiorPanel = IS9Patch:new(10, 10, w, h, self.interiorTextures);
    --self.interiorPanel = ISPanel:new(10, 10, w, h);
    self.interiorPanel.background = true;
    self.interiorPanel:initialise();
    self.interiorPanel:instantiate();
    self:addChild(self.interiorPanel);

    y = 10;
    x = 360;
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

    self.buttons = {};


    x = x - 40;
    local idx = 0;
    for by=0,2 do
        for bx=0,2 do
            --[[
            local txt = "A";
            if by==1 then
                txt = "B";
            elseif by==2 then
                txt = "C";
            end
            txt = txt .. tostring(bx+1);
            --]]
            local DIM = 24;
            local texture = ISEntityUtilUI.GetVendingAlphabeticalButtonTexture(idx);
            local image = ISImage:new(x+(bx*30), y+(by*30), DIM, DIM, texture)
            image.background = true;
            image:initialise();
            image:instantiate();
            self:addChild(image);

            local button = ISButton:new(x+(bx*30), y+(by*30), DIM, DIM, "");
            --button.image = ISEntityUtilUI.GetVendingAlphabeticalButtonTexture(idx);
            button.backgroundColor = {r=0, g=0, b=0, a=0.0};
            button.borderColor = {r=0.0, g=0.0, b=0.0, a=0};
            button.backgroundColorMouseOver.a = 0.5;
            button.productIndex = idx;
            button.target = self;
            button.onclick = ISVendorVendingLayout.onButtonClick;
            button.enable = true;
            button:initialise();
            button:instantiate();
            self:addChild(button);
            table.insert(self.buttons, button);
            idx = idx + 1;
        end
    end

    self.vendingOptions = {};
    self.vendingBars = {};

    x = x-32;


    x = self.interiorPanel:getX();
    y = self.interiorPanel:getY();

    local products = self.resources:getResources(self.arrayList, "Stock");

    local rowCount = round(products:size() / self.productColumns, 0);
    local cellW = self.interiorPanel:getWidth() / self.productColumns;
    local cellH = self.interiorPanel:getHeight() / rowCount;

    local column = 0;
    local row = 0;
    for i=0,products:size()-1 do
        local resource = products:get(i);

        local cellCenterX = x + (cellW/2) + (column * cellW);
        local cellCenterY = y + (cellH/2) + (row * cellH);

        local barImg;
        if column==0 then
            --vendingBarImgs
            barImg = IS9Patch:new(self.interiorPanel:getX(), y, self.interiorPanel:getWidth(), 38, self.vendingBarImgs);
            barImg.background = false;
            barImg.border = false;
            barImg.drawOnPrerender = false;
            --barImg.scaledWidth = barImg.width;
            --barImg.scaledHeight = barImg.height;
            barImg:initialise();
            barImg:instantiate();
            self:addChild(barImg);
            table.insert(self.vendingBars, barImg);
        end

        local option = self:addVendingOption(i, cellCenterX, cellCenterY, resource);

        if column==0 then
            barImg:setY(option.lcd:getY()-2);
        end

        column = column + 1;
        if column >= self.productColumns then
            column = 0;
            row = row + 1;
        end
    end

    --[[
    local products = self.resources:getResources(self.arrayList, "Stock");

    for i=0,products:size()-1 do
        local resource = products:get(i);
        y = self:addVendingOption(i, x, y, resource);
        y = y + 5;
    end
    --]]

    self.arrayList:clear();

    if #self.vendingOptions>0 then
        self.optionArea = {};
        self.optionArea.x1 = self.vendingOptions[1].button:getX();
        self.optionArea.y1 = self.vendingOptions[1].button:getY();
        self.optionArea.x2 = 0;
        self.optionArea.y2 = 0;
        for k,v in ipairs(self.vendingOptions) do
            local x2 = self.vendingOptions[#self.vendingOptions].button:getX() + self.vendingOptions[#self.vendingOptions].button:getWidth();
            local y2 = self.vendingOptions[#self.vendingOptions].button:getY() + self.vendingOptions[#self.vendingOptions].button:getHeight();
            self.optionArea.x2 = math.max(self.optionArea.x2, x2);
            self.optionArea.y2 = math.max(self.optionArea.y2, y2);
        end
    end

    self.trayPanel = IS9Patch:new(10, 370, self.interiorPanel:getWidth(), 70, self.trayImgs);
    self.trayPanel.background = false;
    self.trayPanel.border = false;
    self.trayPanel:initialise();
    self.trayPanel:instantiate();
    --self:addChild(self.trayPanel);

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
    --self:addChild(self.itemSlotOutput);

    local x,y = self.interiorPanel:getX(), self.interiorPanel:getY();
    local w,h = self.interiorPanel:getWidth(), self.interiorPanel:getHeight();

    local terminationY = self.trayPanel:getY() + 15;
    self.anim = ISVendingAnim:new(x,y,w,h, terminationY);
    self.anim:initialise();
    self.anim:instantiate();
    self.anim:setVisible(false);

    self:addChild(self.anim);
    self:addChild(self.trayPanel);
    self:addChild(self.itemSlotOutput);

    local py = self.interiorPanel:getY() + self.interiorPanel:getHeight();
    local ph = self.trayPanel:getY() - py;
    self.hackPane = ISPanel:new(10, py, self.interiorPanel:getWidth(), ph);
    self.hackPane.background = true;
	self.hackPane.backgroundColor = {r=0, g=0, b=0, a=1};
    self.hackPane.borderColor = {r=0, g=0, b=0, a=0};
    self.hackPane:initialise();
    self.hackPane:instantiate();
    self:addChild(self.hackPane);

    self.glassPanel = ISImage:new(x, y, w, h, self.texGlassPane);
    --self.interiorPanel = ISPanel:new(10, 10, w, h);
    self.glassPanel.background = true;
    self.glassPanel:initialise();
    self.glassPanel:instantiate();
    self.glassPanel:setVisible(false); -- Hidden, texture is drawn in self:render()
    self:addChild(self.glassPanel);

    self.glassPanelBorder = ISImage:new(x, y, w, h, self.texGlassBorder);
    --self.interiorPanel = ISPanel:new(10, 10, w, h);
    self.glassPanelBorder.background = true;
    self.glassPanelBorder:initialise();
    self.glassPanelBorder:instantiate();
    self.glassPanelBorder:setVisible(false); -- Hidden, texture is drawn in self:render()
    self:addChild(self.glassPanelBorder);

    self:setWidth(self.width);
    self:setHeight(self.height);
end

function ISVendorVendingLayout:addVendingOption(_index, _x, _y, _resource)
    local spiralBack = ISVendorSpiral:new(_x - 16, 0, 32, 32, self.texSpiralBack)
    spiralBack.texture = self.texSpiralBack;
    spiralBack.renderTarget = self;
    spiralBack.background = true;
    spiralBack:initialise();
    spiralBack:instantiate();
    self:addChild(spiralBack);

    local itemSlot = ISItemSlot:new (_x - 22, 0, 44, 44, _resource);
    itemSlot.renderItemCount = false;
    itemSlot.background = false;
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

    local spiralFront = ISVendorSpiral:new(_x - 16, 0, 32, 32)
    spiralFront.texture = self.texSpiralFront;
    spiralFront.renderTarget = self;
    spiralFront.background = true;
    spiralFront:initialise();
    spiralFront:instantiate();
    spiralFront:setVisible(false);
    self:addChild(spiralFront);

    local y = itemSlot:getY() + itemSlot:getHeight() + 2;

    local x = 52 + 17;
    x = _x - (x/2);
    x = x - 3;

    local texture = ISEntityUtilUI.GetVendingAlphabeticalLabelTexture(_index);
    local labelImage = ISImage:new(x, y-2, 15, 20, texture);
    --self.interiorPanel = ISPanel:new(10, 10, w, h);
    labelImage.background = true;
    labelImage:initialise();
    labelImage:instantiate();
    self:addChild(labelImage);

    local lcd = ISLcdBar:new(x+17, y, 6); --default = 48pix //_x-26
    lcd.priceValue = 1;
    lcd:initialise();
    lcd:instantiate();
    lcd:setText("  1.00");
    self:addChild(lcd);

    local y = lcd:getY() + lcd:getHeight() + 2;

    local y = _y - (y/2);
    itemSlot:setY(y);
    spiralBack:setY(y+12);
    spiralFront:setY(y+12);
    y = itemSlot:getY() + itemSlot:getHeight() + 2;
    labelImage:setY(y-2);
    lcd:setY(y);
    y = lcd:getY() + lcd:getHeight() + 2;
    --button:setY(y);

    local t = {
        itemSlot = itemSlot,
        labelImage = labelImage,
        lcd = lcd,
        resource = _resource,
        index = _index,
        button = self.buttons[_index+1],
        spiralBack = spiralBack,
        spiralFront = spiralFront,
    };

    table.insert(self.vendingOptions, t);
    return t;
end

function ISVendorVendingLayout:getVendingOption(_index)
    return self.vendingOptions[_index+1];
end

function ISVendorVendingLayout:onButtonClick(_button)
    --if not self.itemSlotOutput.resource:isEmpty() then
    --    return;
    --end
    if self:isRunning() and type(_button.productIndex)=="number" then
        local vendingOption = self:getVendingOption(_button.productIndex);

        if vendingOption and self.itemSlotOutput.resource:isEmpty() then
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
                self.anim:start(vendingOption);
            else
                self.anim:start(vendingOption);
            end
        end
    end
end

function ISVendorVendingLayout:getCredits()
    return BlueprintCode.BaseVendorShared.getCredits(self.blueprintLogic);
end

function ISVendorVendingLayout:getProductPrice(_productId)
    return BlueprintCode.BaseVendorShared.getProductPrice(self.blueprintLogic, _productId);
end

function ISVendorVendingLayout:isTurnedOn()
    return BlueprintCode.BaseVendorShared.isTurnedOn(self.blueprintLogic);
end

function ISVendorVendingLayout:isRunning()
    return BlueprintCode.BaseVendorShared.isRunning(self.blueprintLogic);
end

function ISVendorVendingLayout:update()
end

function ISVendorVendingLayout:onMouseMove(dx, dy)
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

function ISVendorVendingLayout:onMouseMoveOutside(dx, dy)
    ISPanel.onMouseMoveOutside(self, dx, dy);
    self.mouseOverButtons = false;
end

function ISVendorVendingLayout:prerender()
    ISPanel.prerender(self);

    if not self.blueprintLogic then
        return;
    end

    if not self:isRunning() then
        self.interiorPanel.img = self.interiorUnlitTextures;

        self.moneyLcd:toggleOn( false );

        for k,v in ipairs(self.vendingOptions) do
            v.button.enable = false;
            v.button.borderColor = self.buttonBorderColorDisabled;
            v.button.backgroundColor.a = 0.25;
            v.lcd:toggleOn( false );
        end
        return;
    end

    if self.mouseOverButtons and (not self.anim.isRunning) then
        if self.itemSlotOutput.resource and (not self.itemSlotOutput.resource:isEmpty()) then
            self.itemSlotOutput.bBlinkBorder = true;
        else
            self.itemSlotOutput.bBlinkBorder = false;
        end
    else
        self.itemSlotOutput.bBlinkBorder = false;
    end

    self.interiorPanel.img = self.interiorTextures;

    if self.anim.isRunning then
        self.itemSlotOutput.hideItem = true;
    else
        self.itemSlotOutput.hideItem = false;
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

        --todo TEST:
        --[[
        local val = v.spiralFront:getValue()-0.01;
        if val<0.25 then val =1 end
        v.spiralFront:setValue(val);
        --]]

        if self.anim.isRunning then --resource:isEmpty() or self.anim.isRunning then
            v.button.enable = false;
            v.button.borderColor = self.buttonBorderColorDisabled;
            v.button.backgroundColor.a = 0.25;
            if self.anim.itemSlot and (self.anim.itemSlot==v.itemSlot) then
                v.itemSlot.hideItem = self.anim.hideItemSlotItem and (self.anim.stage==self.anim.STAGE_DROP);
            end
        else
            v.button.enable = true;
            v.button.borderColor = self.buttonBorderColor;
            v.button.backgroundColor.a = 0.0;
            --if self.anim.itemSlot and (self.anim.itemSlot==v.itemSlot) then
                v.itemSlot.hideItem = false;
            --end
        end

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

function ISVendorVendingLayout:render()
    ISPanel.render(self);

    for k,v in ipairs(self.vendingOptions) do
        if v.spiralFront then
            v.spiralFront:renderToTarget(self);
        end
    end

    local x,y = self.glassPanel:getX(), self.glassPanel:getY();
    local w,h = self.glassPanel:getWidth(), self.glassPanel:getHeight();

    if not self:isRunning() then
        self:drawRect( x, y, w, h, 0.65, 0, 0, 0)
    end

    local c = self.glassPanel.backgroundColor;
    self:drawTexture(self.glassPanel.texture, x, y, c.a, c.r, c.g, c.b);

    x,y = self.glassPanelBorder:getX(), self.glassPanelBorder:getY();
    --w,h = self.glassPanelBorder:getWidth(), self.glassPanelBorder:getHeight();

    c = self.glassPanelBorder.backgroundColor;
    self:drawTexture(self.glassPanelBorder.texture, x, y, c.a, c.r, c.g, c.b);
end

function ISVendorVendingLayout:new (x, y, _parentPanel, _blueprintLogic)
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

    o.buttonBorderColor = {r=0.0, g=0.0, b=0.0, a=0};
    o.buttonBorderColorDisabled = {r=0.5, g=0.2, b=0.2, a=1};
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

    o.productColumns = 3;

    o.arrayList = ArrayList.new();

    o.ledInvalidCol = {r=1.0, g=0.0, b=0.0, a =1.0};
    o.ledValidCol = {r=0.0, g=1.0, b=0.0, a =1.0};

    o.trayImgs = {
        getTexture("media/ui/Entity/Vending/Slot_left.png"),
        getTexture("media/ui/Entity/Vending/Slot_middle.png"),
        getTexture("media/ui/Entity/Vending/Slot_right.png"),
    };

    o.vendingBarImgs = {
        getTexture("media/ui/Entity/Vending/vending_bar_left.png"),
        getTexture("media/ui/Entity/Vending/vending_bar.png"),
        getTexture("media/ui/Entity/Vending/vending_bar_right.png"),
    };

    o.texVendingBar = getTexture("media/ui/Entity/Vending/vending_bar.png");
    o.texGlassPane = getTexture("media/ui/Entity/Vending/vending_glass.png");
    o.texGlassBorder = getTexture("media/ui/Entity/Vending/vending_glass_border.png");

    o.texSpiralBack = getTexture("media/ui/Entity/Vending/vending_spiral_back.png");
    o.texSpiralFront = getTexture("media/ui/Entity/Vending/vending_spiral_front.png");

    o.interiorTextures = ISEntityUtilUI.GetVendingInteriorTextures();
    o.interiorUnlitTextures = ISEntityUtilUI.GetVendingInteriorUnlitTextures();

    o.mouseOverButtons = false;

    o.parentPanel = _parentPanel;
    o.blueprintLogic = _blueprintLogic;
    o.resources = _blueprintLogic:getResources();
    o.parts = _blueprintLogic:getCrafterParts();
    o.player = _parentPanel.player;
    o.playerNum = _parentPanel.player:getPlayerNum();
    o.joypadMoveInterval = ISVendorVendingLayout.defaultJoypadMoveInterval;
    return o
end

function ISVendingAnim:new(_x, _y, _w, _h, _terminationY)
    local o = ISPanel:new(_x, _y, _w, _h);
    setmetatable(o, self);
    self.__index = self;

    o.background = false;
    o.running = false;
    o.option = false;
    o.terminationY = _terminationY;
    o.stage = 0;
    o.STAGE_SPIRAL = 0;
    o.STAGE_DROP = 1;
    o.spiralDelta = 0;
    o.drawY = 0;
    o.drawX = 0;
    o.drawW = 36;
    o.drawH = 36;
    o.speed = 0;
    o.speedMulti = 1.25;
    o.speedMax = 15;
    o.forceItemDraw = false;
    o.angle = 0;
    o.maxAngle = 0;
    o.angleDir = 1;
    o.hideItemSlotItem = false;
    return o;
end

function ISVendingAnim:start(_vendingOption)
    if self.isRunning then
        return
    end
    self.option = _vendingOption;
    self.itemSlot = self.option.itemSlot;
    self.item = self.option.itemSlot.storedItem;
    self.itemTex = self.option.itemSlot.storedItemTex;
    --if not self.itemTex then
    --    return;
    --end
    self.hideItemSlotItem = self.option.itemSlot.resource:getItemAmount()==1;
    self.isRunning = true;
    self.stage = self.STAGE_SPIRAL;
    self.spiralDelta = 0;
    self.speed = 1.5;
    self.drawX = self.option.itemSlot:getX() + 4 - self:getX(); -- + (self.option.itemSlot:getWidth() / 2);
    self.drawY = self.option.itemSlot:getY() + 4 - self:getY();
    if ZombRand(100)>50 then
        self.angleDir = 1;
    else
        self.angleDir = -1;
    end
    self.maxAngle = ZombRand(30,200);-- ZombRand(45,270);
    self:setVisible(true);
end

function ISVendingAnim:stop()
    if self.option.spiralFront then
        self.option.spiralFront:setRotation(0); --:setValue(1);
    end
    if self.option.spiralBack then
        self.option.spiralBack:setRotation(0); --:setValue(1);
    end
    self.isRunning = false;
    self.option = false;
    self.itemSlot = false;
    self.item = false;
    self.itemTex = false;
    self.stage = 0;
    self.forceItemDraw = false;
    self.angle = 0;
    self.maxAngle = 0;
    self.angleDir = 1;
    self:setVisible(false);
end

function ISVendingAnim:prerender() --TODO make progress etc FPS friendly
    if self.isRunning then
        if self.stage==self.STAGE_SPIRAL then
            self.spiralDelta = self.spiralDelta + 0.03;
            if self.spiralDelta>0.5 then
                self.stage = self.STAGE_DROP;
            end
            self.option.spiralFront:setRotation(360-(360*self.spiralDelta)); --:setValue(1 - (0.75*self.spiralDelta));
            self.option.spiralBack:setRotation(360-(360*self.spiralDelta));
        end
        if self.stage==self.STAGE_DROP then
            self.spiralDelta = self.spiralDelta + 0.03;

            if self.spiralDelta > 1 then
                self.option.spiralFront:setRotation(0); --:setValue(1);
                self.option.spiralBack:setRotation(0);
            else
                self.option.spiralFront:setRotation(360-(360*self.spiralDelta)); --:setValue(1 - (0.75*self.spiralDelta));
                self.option.spiralBack:setRotation(360-(360*self.spiralDelta));
            end

            self.drawY = self.drawY + self.speed;
            if self.drawY>self.terminationY then
                self:stop();
            end
            self.speed = self.speed * self.speedMulti;
            if self.speed > self.speedMax then
                self.speed = self.speedMax;
            end
            self.angle = self.angle + self.speed; -- * self.angleDir);
            if self.angle>self.maxAngle then
                self.angle = self.maxAngle;
            end
        end
    end
end

function ISVendingAnim:render()
    if self.isRunning and self.stage==self.STAGE_DROP then
        if self.itemTex and (not self.forceItemDraw) then
            --self:drawTextureScaled(self.itemTex, self.drawX, self.drawY, self.drawW, self.drawH, 1.0, 1.0, 1.0, 1.0);
            local angle = self.angle;
            if self.angleDir<0 then
                angle = 360-angle;
            end
            self:DrawTextureAngle(self.itemTex, self.drawX+(self.drawW/2), self.drawY+(self.drawH/2), angle)
        elseif self.item then
            ISInventoryItem.renderItemIcon(self, self.item, self.drawX, self.drawY, 1.0, self.drawW, self.drawH);
        end
    end
end