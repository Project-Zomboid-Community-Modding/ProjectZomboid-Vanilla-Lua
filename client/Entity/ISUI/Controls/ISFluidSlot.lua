--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************
require "ISUI/ISPanel"

ISFluidSlot = ISPanel:derive("ISFluidSlot");

function ISFluidSlot:initialise()
    ISPanel.initialise(self)
end

function ISFluidSlot:createChildren()
    ISFluidSlot.initialise(self)

    if self.enableTransfer then
        local style = self.styleBtnTransfer or "S_Button_TransferFluids";
        self.buttonTransfer = ISXuiSkin.build(self.xuiSkin, style, ISButton, 0, 0, 24, 24, "")
        --self.buttonTransfer.image = self.iconTransfer;
        self.buttonTransfer.target = self;
        self.buttonTransfer.onclick = ISFluidSlot.onButtonClick;
        self.buttonTransfer.enable = not self.disableButtons;
        self.buttonTransfer:initialise();
        self.buttonTransfer:instantiate();
        self.buttonTransfer:setVisible(not self.hideButtons);
        self:addChild(self.buttonTransfer);
    end

    if self.enableClear then
        local style = self.styleBtnClear or "S_Button_ClearFluids";
        self.buttonClear = ISXuiSkin.build(self.xuiSkin, style, ISButton, 0, 0, 24, 24, "")
        --self.buttonClear.image = self.iconClear;
        self.buttonClear.target = self;
        self.buttonClear.onclick = ISFluidSlot.onButtonClick;
        self.buttonClear.enable = not self.disableButtons;
        self.buttonClear:initialise();
        self.buttonClear:instantiate();
        self.buttonClear:setVisible(not self.hideButtons);
        self:addChild(self.buttonClear);
    end

    local style = self.styleBar or nil;
    self.fluidBar = ISXuiSkin.build(self.xuiSkin, style, ISFluidBar, 0, 0, 20, 20, self.player, self.resource);
    self.fluidBar:setContainer(self.resource:getFluidContainer());
    self.fluidBar:initialise();
    self.fluidBar:instantiate();
    self:addChild(self.fluidBar);

    self.fluidBorderColorOrig = self.fluidBar.borderColor;
    if self.resource and self.resource:getChannel()~=ResourceChannel.NO_CHANNEL then
        self.fluidBar.borderColor = colorToTable(self.resource:getChannel():getColor());
    end
end

function ISFluidSlot:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(0, _preferredWidth or 0);
    local height = math.max(0, _preferredHeight or 0);

    local requiredHeight = self.margin * 2;

    if self.buttonTransfer then
        width = math.max(width, self.buttonTransfer:getWidth() + (self.margin*2));

        requiredHeight = requiredHeight + self.buttonTransfer:getHeight() + self.margin;
    end

    if self.buttonClear then
        width = math.max(width, self.buttonClear:getWidth() + (self.margin*2));

        requiredHeight = requiredHeight + self.buttonClear:getHeight() + self.margin;
    end

    width = math.max(width, self.fluidBar:getWidth() + (self.margin*2));
    height = math.max(height, requiredHeight + self.minimumBarSize);

    local y = self.margin;
    local x;

    local barHeight = height - (self.margin*2);

    if self.buttonTransfer then
        x = (width/2) - (self.buttonTransfer:getWidth()/2);
        self.buttonTransfer:setX(x);
        self.buttonTransfer:setY(y);

        y = self.buttonTransfer:getY() + self.buttonTransfer:getHeight() + self.margin;
        barHeight = barHeight - (self.buttonTransfer:getHeight() + self.margin);
    end

    if self.buttonClear then
        x = (width/2) - (self.buttonClear:getWidth()/2);
        local y2 = height - self.buttonClear:getHeight() - self.margin;
        self.buttonClear:setX(x);
        self.buttonClear:setY(y2);

        barHeight = barHeight - (self.buttonClear:getHeight() + self.margin)
    end

    x = (width/2) - (self.fluidBar:getWidth()/2);
    barHeight = math.max(self.minimumBarSize, barHeight);

    self.fluidBar:setX(x);
    self.fluidBar:setY(y);
    self.fluidBar:setHeight(barHeight);

    self:setWidth(width);
    self:setHeight(height);
end

function ISFluidSlot:prerender()
    ISPanel.prerender(self);
end

function ISFluidSlot:render()

end

function ISFluidSlot:update()
    if self.buttonClear then
        self.buttonClear.enable = self.resource and (not self.resource:isEmpty());
    end
end

function ISFluidSlot:onButtonClick(_button)
    if self.buttonTransfer and _button==self.buttonTransfer then
        if self.functionTarget and self.onTransferFluids then
            self.onTransferFluids(self.functionTarget, self);
            return;
        end
        --todo open transfer window
        if self.resource then
            local container = ISFluidContainer:new(self.resource);
            --print("owner: "..tostring(container:getOwner()))
            --print("exists: "..tostring(container:getOwner():isExistInTheWorld()))
            ISFluidTransferUI.OpenPanel(self.player, container); --:getFluidContainer());
        else
            print("ISFluidSlot -> Cannot open TransferFluids, no resource attached.");
        end
    elseif self.buttonClear and _button==self.buttonClear then
        if self.functionTarget and self.onClearFluids then
            self.onClearFluids(self.functionTarget, self);
            return;
        end

        if self.resource and not self.resource:isEmpty() then
            --NOTE: cannot do this: (reason resource cannot retrieve fluidcontainer with getComponent(ComponentType.FluidContainer) down the line!)
            --local action = ISFluidEmptyAction:new(self.player, self.resource:getGameEntity());
            local action = ISFluidEmptyAction:new(self.player, self.resource);
            ISTimedActionQueue.add(action);
            --self.resource:clear();
        else
            print("ISFluidSlot -> Cannot clear Fluids, no resource attached.");
        end
    end
end

function ISFluidSlot:setResource(_resource)
    if self.resource~= _resource then
        self.resource = _resource;

        if self.fluidBar then
            if self.resource and self.resource:getChannel()~=ResourceChannel.NO_CHANNEL then
                self.fluidBar.borderColor = colorToTable(self.resource:getChannel():getColor());
            elseif self.fluidBorderColorOrig then
                self.fluidBar.borderColor = self.fluidBorderColorOrig;
            end
        end
    end
end

function ISFluidSlot:new (x, y, width, height, player, resource, _styleBtnTransfer, _styleBtnClear, _styleBar)
    local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.x = x;
    o.y = y;
    o.background = true;

    o.player = player;
    o.resource = resource;

    o.styleBtnTransfer = _styleBtnTransfer;
    o.styleBtnClear = _styleBtnClear;
    o.styleBar = _styleBar;

    o.margin = 5;
    o.minimumBarSize = 100;

    o.disableButtons = false; -- changes the enabled state of buttons
    o.hideButtons = false; -- hide buttons but still factor them in for calculating layout sizes
    o.enableTransfer = true;
    o.enableClear = true;

    o.functionTarget = false;
    o.onTransferFluids = false;
    o.onClearFluids = false;

    return o;
end