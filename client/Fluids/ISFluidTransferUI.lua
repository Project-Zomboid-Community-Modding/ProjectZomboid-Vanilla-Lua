--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

--[[
    UI that can handle transferring fluids between items/objects that have FluidContainers.
--]]

require "ISUI/ISPanel"

ISFluidTransferUI = ISPanel:derive("ISFluidTransferUI");
ISFluidTransferUI.players = {};
ISFluidTransferUI.cheatSkill = false;
ISFluidTransferUI.cheatTransfer = false;

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)

-- Container = FluidContainer instance
function ISFluidTransferUI.OpenPanel(_player, _container, _source)
    --_container = ISFluidContainer:new(_container);
    if not ISFluidUtil.validateContainer(_container) then
        print("FluidTransferUI not a valid (ISFluidContainer) container?")
        return;
    end

    if not _container:isValid() then -- not _container or ((not _container:getOwner()) and (not _container:isEmbedded())) then
        print("FluidTransferUI container nil or has no owner.")
        return;
    end
    if not _player then
        print("FluidTransferUI no valid player.")
        return;
    end
    --print("Opening Fluid Transfer UI");
    local playerNum = _player:getPlayerNum();

    local x = getMouseX() + 10;
    local y = getMouseY() + 10;
    local adjustPos = true;

    if ISFluidTransferUI.players[playerNum] then
        if ISFluidTransferUI.players[playerNum].instance then
            ISFluidTransferUI.players[playerNum].instance:close();
            if ISFluidTransferUI.players[playerNum].x and ISFluidTransferUI.players[playerNum].y then
                x = ISFluidTransferUI.players[playerNum].x;
                y = ISFluidTransferUI.players[playerNum].y;
                adjustPos = false;
            end
        end
    else
        ISFluidTransferUI.players[playerNum] = {};
    end

    local ui = ISFluidTransferUI:new(x,y,400,600, _player, _container, _source);
    ui:initialise();
    ui:instantiate();
    ui:setVisible(true);
    ui:addToUIManager();

    ISFluidTransferUI.players[playerNum].instance = ui;

    --first time open panel and isoobject then middle of screen.
    if adjustPos and instanceof(_container:getOwner(), "IsoObject") then
        local x = (getCore():getScreenWidth()/2) - (ui:getWidth()/2);
        local y = (getCore():getScreenHeight()/2) - (ui:getHeight()/2);
        ui:setX(x);
        ui:setY(y);
        ISFluidTransferUI.players[playerNum].x = x;
        ISFluidTransferUI.players[playerNum].y = y;
    end
end

-- INIT --
function ISFluidTransferUI:initialise()
    ISPanel.initialise(self);
end

function ISFluidTransferUI:createChildren()
    ISPanel.createChildren(self);

    local btnHgt = FONT_HGT_SMALL + 8;
    local pad = 10;
    local y = 5;
    local c;

    self.titleText = getText("Fluid_Transfer_Fluids");
    self.titleLabel = ISLabel:new (0, y, FONT_HGT_MEDIUM, self.titleText, 1, 1, 1, 1.0, UIFont.Medium, true);
    self.titleLabel.center = true;
    self.titleLabel:initialise();
    self.titleLabel:instantiate();
    self:addChild(self.titleLabel);

    y = y + FONT_HGT_MEDIUM + 5;

    self.errorText = "";
    self.errorLabel = ISLabel:new (0, y, FONT_HGT_SMALL, self.errorText, 0.8, 0, 0, 1.0, UIFont.Small, true);
    self.errorLabel.center = true;
    self.errorLabel:initialise();
    self.errorLabel:instantiate();
    self.errorLabel:setColor(0.8,0.5,0.5);
    self:addChild(self.errorLabel);
    y = y + FONT_HGT_SMALL + 5;

    local panelY = y;
    local containerLeft = self.source or self.container:getFluidContainer():isEmpty();

    self.panelLeftText = getText("Fluid_Source");
    self.panelLeft = ISFluidContainerPanel:new(pad, panelY, self.player, containerLeft and self.container or nil, true, true, self.isIsoPanel);
    self.panelLeft.funcTarget = self;
    self.panelLeft.onContainerAdd = self.onContainerAdd;
    self.panelLeft.onContainerRemove = self.onContainerRemove;
    self.panelLeft.onContainerVerify = self.onContainerVerify;
    self.panelLeft:initialise();
    self.panelLeft:instantiate();
    self:addChild(self.panelLeft);

    self.panelLeftX = self.panelLeft:getX();

    local x = self.panelLeft:getX() + self.panelLeft:getWidth() + pad;
    local midWidth = 200;

    c = self.buttonBorderColor;
    local btnText = getText("Fluid_Swap");
    self.btnSwap = ISButton:new(x, y, midWidth, btnHgt, btnText, self, ISFluidTransferUI.onButton);
    self.btnSwap.internal = "SWAP";
    self.btnSwap:setImage(getTexture("media/ui/Fluids/btn_swap.png"))
    self.btnSwap:initialise();
    self.btnSwap:instantiate();
    self.btnSwap.borderColor = {r=c.r, g=c.g,b=c.b,a=c.a};
    self:addChild(self.btnSwap);

    local sliderHeight = 20;
    y = self.panelLeft:getY() + self.panelLeft.innerY + (self.panelLeft.innerHeight/2);
    y = y - (sliderHeight/2);
    --new Y:
    y = self.btnSwap:getY() + self.btnSwap:getHeight() + pad + FONT_HGT_SMALL + pad;

    local labelY = y - pad - FONT_HGT_SMALL;
    local labelX = x + (midWidth/2)
    self.maxTransferText = getText("Fluid_Max_Transfer") .. ":";
    self.maxTransferLabel = ISLabel:new (labelX, labelY, FONT_HGT_SMALL, self.maxTransferText, 1.0, 1.0, 1.0, 1.0, UIFont.Small, true);
    self.maxTransferLabel.center = true;
    self.maxTransferLabel:initialise();
    self.maxTransferLabel:instantiate();
    self:addChild(self.maxTransferLabel);
	
    self.slider = ISSliderPanel:new(x, y, midWidth, sliderHeight, self, ISFluidTransferUI.onSlider );
    self.slider:initialise();
    self.slider:instantiate();
    self.slider:setValues( 0.0, 1.0, 0.01, 0.1, true);
    self.slider:setCurrentValue(0.0, true)
    self.slider.valueLabel = false;
    self.slider.customData = {};
    self:addChild(self.slider);

    labelY = y + sliderHeight + pad;
    self.transferringText = getText("Fluid_Transferring") .. ":";
    self.transferringLabel = ISLabel:new (labelX, labelY, FONT_HGT_SMALL, self.transferringText, 1.0, 1.0, 1.0, 1.0, UIFont.Small, true);
    self.transferringLabel.center = true;
    self.transferringLabel:initialise();
    self.transferringLabel:instantiate();
    self:addChild(self.transferringLabel);
	
	y = labelY + FONT_HGT_SMALL + pad;
	
	c = self.buttonBorderColor;
    local btnText = getText("Fluid_Transfer");
    self.btnTransfer = ISButton:new(x, y, midWidth, btnHgt, btnText, self, ISFluidTransferUI.onButton);
    self.btnTransfer.internal = "TRANSFER";
    self.btnTransfer:initialise();
    self.btnTransfer:instantiate();
    self.btnTransfer.backgroundColor.a = 0;
    self.btnTransfer.borderColor = {r=c.r, g=c.g,b=c.b,a=c.a};
    self:addChild(self.btnTransfer);

    y = self.panelLeft:getY() + self.panelLeft:getHeight() - btnHgt;

    c = self.buttonBorderColor;
    local btnText = getText("Fluid_Close");
    self.btnClose = ISButton:new(x, y, midWidth, btnHgt, btnText, self, ISFluidTransferUI.onButton);
    self.btnClose.internal = "CLOSE";
    self.btnClose:initialise();
    self.btnClose:instantiate();
    self.btnClose.borderColor = {r=c.r, g=c.g,b=c.b,a=c.a};
    self:addChild(self.btnClose);


    x = x + midWidth + pad;

    self.panelRightText = getText("Fluid_Target");
    self.panelRight = ISFluidContainerPanel:new(x, panelY, self.player, (not containerLeft) and self.container or nil, true, false, self.isIsoPanel);
    self.panelRight.funcTarget = self;
    self.panelRight.onContainerAdd = self.onContainerAdd;
    self.panelRight.onContainerRemove = self.onContainerRemove;
    self.panelRight.onContainerVerify = self.onContainerVerify;
    self.panelRight:initialise();
    self.panelRight:instantiate();
    self:addChild(self.panelRight);

    self.panelRightX = self.panelRight:getX();

    x = x + self.panelRight:getWidth() + pad;
    y = panelY + self.panelRight:getHeight() + pad;

    self.titleLabel:setX(x/2);
    self.errorLabel:setX(x/2);
    self.errorLabel.originalX = x/2;
    self.maxTransferLabel:setX(x/2);
    self.transferringLabel:setX(x/2);

    self:setMaxTransfer(0);
    self:setTransferring(0);

    self:setWidth(x);
    self:setHeight(y);
end

function ISFluidTransferUI:setMaxTransfer(_value)
    self.maxTransferText = getText("Fluid_Max_Transfer") .. ": "..FluidUtil.getAmountFormatted(_value);
    self.maxTransferLabel:setName(self.maxTransferText);
end

function ISFluidTransferUI:setTransferring(_value)
    self.transferringText = getText("Fluid_Transferring") .. ": "..FluidUtil.getAmountFormatted(_value);
    self.transferringLabel:setName(self.transferringText);
end

function ISFluidTransferUI:onContainerAdd( _item, _panel)
    self:validatePanel(true);
end

function ISFluidTransferUI:onContainerRemove( _removedItem, _panel)
    self:validatePanel(true);
end

function ISFluidTransferUI:onContainerVerify( _item, _panel)
    if self.action then
        return false;
    end
    if _item and _item:getFluidContainer() then
        if not _item:isInPlayerInventory() then
            return false;
        end
        if _panel==self.panelLeft and self.panelRight:getContainerOwner() then
            return _item~=self.panelRight:getContainerOwner();
        end
        if _panel==self.panelRight and self.panelLeft:getContainerOwner() then
            return _item~=self.panelLeft:getContainerOwner();
        end
        return true;
    end
    return false;
end

function ISFluidTransferUI:onSlider(_value, _slider)
end

-- Validate panel and containers, action etc
function ISFluidTransferUI:validatePanel(_forceUpdate)
    --range check for isoPanels.
    if self.isIsoPanel then
        if ISFluidUtil.validateContainer(self.container) and self.container:getOwner() and self.container:getOwner():getSquare() and self.player then
            local square = self.container:getOwner():getSquare();
            local dist = ISFluidUtil.isoMaxPanelDist;
            if self.player:getX() < square:getX()-dist or self.player:getX() > square:getX()+dist or self.player:getY() < square:getY()-dist or self.player:getY() > square:getY()+dist then
                self:close();
                return
            end
        else
            self:close();
            return
        end
    end

    self.disableTransfer = false;
    self.disableSwap = false;
    self.panelLeft:setPanelLocked(false);
    self.panelRight:setPanelLocked(false);

    if self.action then
        if ISTimedActionQueue.hasAction(self.action) then
            self.disableTransfer = true;
            self.disableSwap = true;
            self.panelLeft:setPanelLocked(true);
            self.panelRight:setPanelLocked(true);
        else
            self.action = false;
            self.disableTransfer = false;
            self.disableSwap = false;
        end
    end

    local maxTransfer = 0;
    local transferring = 0;

    local from = self.panelLeft:getContainer();
    local to = self.panelRight:getContainer();

    --if items are moved from inventory or isoobject no longer valid, close panel.
    if (from and not ISFluidUtil.validateContainer(self.panelLeft.container)) or (to and not ISFluidUtil.validateContainer(self.panelRight.container)) then
        self:close();
    end

    self.panelLeft.fluidBar:resetRatioNew();
    self.panelLeft.fluidBar:setContainerAdd(nil);
    self.panelLeft.fluidBar:setContainerMixed(nil);

    self.panelRight.fluidBar:resetRatioNew();
    self.panelRight.fluidBar:setContainerAdd(nil);
    self.panelRight.fluidBar:setContainerMixed(nil);

    self.panelLeft:setInvalid(false);
    self.panelRight:setInvalid(false);

    if (not self.disableTransfer) and (from and to) and FluidContainer.CanTransfer(from, to) then

        self.errorLabel:setName(self.errorDefault);

        local fromAmount = from:getAmount();
        local toFree = to:getCapacity() - to:getAmount();
        maxTransfer = PZMath.min(fromAmount, toFree);
        maxTransfer = FluidUtil.roundTransfer(maxTransfer);
        if maxTransfer<=0 then
            self.disableTransfer = true;
        else
            transferring = maxTransfer * self.slider:getCurrentValue();
            transferring = FluidUtil.roundTransfer(transferring);
            if transferring<=0 then
                transferring = 0;
                self.disableTransfer = true;
            end
            local ratio = (from:getAmount() - transferring) / from:getCapacity();
            self.panelLeft.fluidBar:setRatioNew(ratio);

            ratio = (to:getAmount() + transferring) / to:getCapacity();
            self.panelRight.fluidBar:setRatioNew(ratio);
            self.panelRight.fluidBar:setContainerAdd(from);

            if ISFluidTransferUI.cheatSkill then --todo base this on skills
                self.panelRight.fluidBar:setContainerMixed(self.panelRight.containerCopy, true);
            end
        end
    else
        if not self.disableTransfer then
            local error = FluidContainer.GetTransferReason(from, to);
            self.errorLabel:setName(error);
            if not from or from:isEmpty() then
                self.panelLeft:setInvalid(true);
            elseif not to or to:isFull() then
                self.panelRight:setInvalid(true);
            else
                self.panelLeft:setInvalid(true);
                self.panelRight:setInvalid(true);
            end
        else
            self.errorLabel:setName(getText("Fluid_Reason_Transfer"));
            self.panelLeft:setInvalid(true);
            self.panelRight:setInvalid(true);
        end
        self.disableTransfer = true;
    end

    if self.info.maxTransfer~=maxTransfer or _forceUpdate then
        self.info.maxTransfer = maxTransfer;
        self:setMaxTransfer(maxTransfer);
    end

    if self.info.transferring~=transferring or _forceUpdate then
        self.info.transferring = transferring;
        self:setTransferring(transferring);

        if from and self.panelRight.containerCopy and self.panelRight:getContainer() then
            self.panelRight.containerCopy:copyFluidsFrom(self.panelRight:getContainer());
            FluidContainer.Transfer(from, self.panelRight.containerCopy, transferring, true);
        end
    end

    self.btnTransfer:setEnable(not self.disableTransfer);
    self.btnSwap:setEnable(not self.disableSwap);
end

function ISFluidTransferUI:prerender()
    ISPanel.prerender(self);

    --draws a background for transfer button and action progress if action exists.
    if self.btnTransfer then
        local x = self.btnTransfer:getX();
        local y = self.btnTransfer:getY();
        local w = self.btnTransfer:getWidth();
        local h = self.btnTransfer:getHeight();

        self:drawRect(x, y, w, h, 1.0, 0, 0, 0);
        if self.action and self.action.action then
            local c = self.transferColor;
            w = w * self.action:getJobDelta();
            self:drawRect(x, y, w, h, c.a, c.r, c.g, c.b);
        end
    end
end

function ISFluidTransferUI:render()
end

function ISFluidTransferUI:update()
    self:validatePanel();
end

function ISFluidTransferUI:close()
    if self.player then
        local playerNum = self.player:getPlayerNum();
        if ISFluidTransferUI.players[playerNum] then
            ISFluidTransferUI.players[playerNum].x = self:getX();
            ISFluidTransferUI.players[playerNum].y = self:getY();

            ISFluidTransferUI.players[playerNum].instance = nil;
        end
    end

    if self.panelLeft then
        self.panelLeft:onClose();
    end
    if self.panelRight then
        self.panelRight:onClose();
    end
    self:setVisible(false);
    self:removeFromUIManager();
end

function ISFluidTransferUI:onButton(_btn)
    if _btn.internal=="TRANSFER" then
        if getCore():getDebug() and ISFluidTransferUI.cheatTransfer and not isClient() then
            FluidContainer.Transfer(self.panelLeft:getContainer(), self.panelRight:getContainer(), self.info.transferring)
            self.slider:setCurrentValue(0);
            return
        end
        if (not self.isIsoPanel) or ISFluidUtil.doWalkTo(self.player, self.container) then
            if (not self.disableTransfer) and FluidContainer.CanTransfer(self.panelLeft:getContainer(), self.panelRight:getContainer()) then
                --self.action = ISFluidTransferAction:new(self.player, ISFluidUtil.getContainerOwner(self.panelLeft.container), ISFluidUtil.getContainerOwner(self.panelRight.container), self.info.transferring);
                local leftContainer = self.panelLeft.container:copy();
                local rightContainer = self.panelRight.container:copy();
                self.action = ISFluidTransferAction:new(self.player, leftContainer, leftContainer:getFluidObject(), rightContainer, rightContainer:getFluidObject(), self.info.transferring);
                ISTimedActionQueue.add(self.action);
                self.slider:setCurrentValue(0);
                self.disableTransfer = true;
                self.panelLeft:setPanelLocked(true);
                self.panelRight:setPanelLocked(true);
            end
        end
    elseif _btn.internal=="SWAP" then
        local panelLeft = self.panelLeft;
        self.panelLeft = self.panelRight;
        self.panelLeft:setX(self.panelLeftX);
        self.panelLeft:setIsLeft(true);

        self.panelRight = panelLeft;
        self.panelRight:setX(self.panelRightX);
        self.panelRight:setIsLeft(false);

        self:validatePanel();
    elseif _btn.internal=="CLOSE" then
        self:close()
    end
end

function ISFluidTransferUI:toggleCheatSkill(_b)
    if getCore():getDebug() then
        ISFluidTransferUI.cheatSkill = _b;
    else
        ISFluidTransferUI.cheatSkill = false;
    end
end

function ISFluidTransferUI:toggleCheatTransfer(_b)
    if getCore():getDebug() then
        ISFluidTransferUI.cheatTransfer = _b;
    else
        ISFluidTransferUI.cheatTransfer = false;
    end
end

function ISFluidTransferUI:onRightMouseUp(x, y)
    if getCore():getDebug() then
        local playerNum = self.player:getPlayerNum()
        local context = ISContextMenu.get(playerNum, self:getAbsoluteX()+x, self:getAbsoluteY()+y)

        local s = "[Debug] Set Test High Skill To '"..tostring(not ISFluidTransferUI.cheatSkill).."'";
        local option = context:addOption(s, self, self.toggleCheatSkill, (not ISFluidTransferUI.cheatSkill))

        local s = "[Debug] Set Quick Transfer To '"..tostring(not ISFluidTransferUI.cheatTransfer).."'";
        local option = context:addOption(s, self, self.toggleCheatTransfer, (not ISFluidTransferUI.cheatTransfer))

        context.mouseOver = 1
    end
    return false;
end

function ISFluidTransferUI:new(x, y, width, height, _player, _container, source)
    local o = {};
    o = ISPanel:new(x, y, 400, height);
    setmetatable(o, self);
    self.__index = self;
    o.variableColor={r=0.9, g=0.55, b=0.1, a=1};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.buttonBorderColor = {r=0.7, g=0.7, b=0.7, a=0.5};
    o.transferColor = {r=0.0, g=1.0, b=0.0, a=0.5};
    o.zOffsetSmallFont = 25;
    o.moveWithMouse = true;
    o.player = _player;
    o.container = _container;
	o.source = source;
    --o.owner = _container:getOwner();
    o.isIsoPanel = not (o.container:isItem() or o.container:isResource()); --instanceof(_container:getOwner(), "IsoObject");
    --o.tempContainer = FluidContainer.new();
    o.info = {
        maxTransfer = 0;
        transferring = 0;
    }
    o.errorDefault = "";
    return o;
end