--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISPanel"

ISPartsLayout = ISPanel:derive("ISPartsLayout");
ISPartsLayout.defaultJoypadMoveInterval = 20;

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small);
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium);

function ISPartsLayout:initialise()
    ISPanel.initialise(self)
end

function ISPartsLayout:createChildren()
    ISPanel.createChildren(self);

    self.colorSemiBroken = namedColorToTable("ItemSlotOutput");
    self.textSemiBroken = "parts broken or depleted";
    self.colorOperational = namedColorToTable("ItemSlotValid");
    self.textOperational = "fully operational";
    self.colorBroken = namedColorToTable("ItemSlotInvalid");
    self.textBroken = "broken, requires repairs";

    local minWidth = 300;
    local y = 20;
    local x = minWidth/2;

    self.effBar = ISProgressBar:new (20, y, minWidth-40, 25, "efficiency", UIFont.Small);
    self.effBar.progressColor = namedColorToTable("ProgressYellow"); --{r=1.0, g=0.95, b=0.4, a=1};
    self.effBar.progressTexture = self.horzTexture;
    self.effBar.forceIt = true;
    self.effBar:initialise();
    self.effBar:instantiate();
    self:addChild(self.effBar);

    y = self.effBar:getY() + self.effBar:getHeight();
    y = y + 10;

    self.title = ISLabel:new(x, y, FONT_HGT_SMALL, self.textOperational, 1.0, 1.0, 1.0, 1, UIFont.Small, true)
    self.title.center = true;
    self.title:initialise();
    self.title:instantiate();
    self:addChild(self.title);

    y = self.title:getY() + self.title:getHeight();
    y = y + 10;

    --self.parts = self.blueprintLogic:getParts();
    self.itemSlots = {};
    --local list = self.blueprintLogic:getResources():getParts();
    for i=0,self.parts:getCount()-1 do
        local resource = self.parts:getPart(i);
        local uiTag = resource:getId();
        local uiSlot = ISItemSlot:new (minWidth/4, y, 44, 44, resource)
        uiSlot.renderItemCount = false;
        uiSlot:initialise();
        uiSlot:instantiate();
        self:addChild(uiSlot);

        print("UI slot: "..tostring(uiTag));
        uiSlot:setCharacter(self.player);
        uiSlot:setResource( resource );
        uiSlot.functionTarget = self.parentPanel;
        uiSlot.onBoxClicked = ISBlueprintLogicPanel.onItemSlotTakeItems;
        uiSlot.onItemDropped = ISBlueprintLogicPanel.onItemSlotDroppedItems; --when items dragged under mouse are dropped in box
        --uiSlot.onVerifyItem = ISBlueprintLogicPanel.onItemSlotVerifyItem; --when items are checked to see if box can accept
        uiSlot.onItemRemove = ISBlueprintLogicPanel.onItemSlotRemoveItem; --when rightclicking to remove item

        local bar = ISProgressBar:new ((minWidth/4)-20, y, 10, 44, false, UIFont.Small);
        --self.effBar.progressColor = namedColorToTable("ProgressYellow"); --{r=1.0, g=0.95, b=0.4, a=1};
        bar.progressTexture = self.vertTexture;
        bar.isVertical = true;
        bar:initialise();
        bar:instantiate();
        self:addChild(bar);

        local text = resource:getPartDisplayName();
        local lx = uiSlot:getX() + uiSlot:getWidth() + 10;
        local label = ISLabel:new(lx, y+18, FONT_HGT_SMALL, text, 1.0, 1.0, 1.0, 1, UIFont.Small, true)
        label:initialise();
        label:instantiate();
        self:addChild(label);

        y = uiSlot:getY() + uiSlot:getHeight();
        y = y + 10;

        table.insert(self.itemSlots, {
            slot = uiSlot,
            label = label,
            resource = resource,
            bar = bar,
        });
    end

    self.buttonRepair = ISButton:new(20, y, minWidth-40, 25, "Repair") --todo
    --self.buttonRepair.image = (not self.showInfo) and self.iconInfo or self.iconPanel;
    self.buttonRepair.target = self;
    self.buttonRepair.onclick = ISPartsLayout.onButtonClick;
    self.buttonRepair.enable = false;
    self.buttonRepair:initialise();
    self.buttonRepair:instantiate();
    self:addChild(self.buttonRepair);

    y = self.buttonRepair:getY() + self.buttonRepair:getHeight();
    y = y + 10;

    if getDebug() and getDebugOptions():getBoolean("Entity.DebugUI") then
        self.buttonDbgDecay = ISButton:new(20, y, minWidth-40, 25, "**[Debug] Apply Decay**") --todo
        --self.buttonRepair.image = (not self.showInfo) and self.iconInfo or self.iconPanel;
        self.buttonDbgDecay.target = self;
        self.buttonDbgDecay.onclick = ISPartsLayout.onButtonClick;
        self.buttonDbgDecay.enable = true;
        self.buttonDbgDecay:initialise();
        self.buttonDbgDecay:instantiate();
        self:addChild(self.buttonDbgDecay);

        y = self.buttonDbgDecay:getY() + self.buttonDbgDecay:getHeight();
        y = y + 10;
    end

    y = y + 10;
    self:setHeight(y);
    self:setWidth(minWidth);
end

function ISPartsLayout:onButtonClick(_button)
    if self.buttonRepair and self.buttonRepair==_button then
        if self.parentPanel:doWalkTo() then
            local pp = self.parentPanel;
            local action = ISBaseCrafterAction:new(pp.player, pp.entity, self.blueprintLogic, pp.window.progressBar);
            action.actionAnim = CharacterActionAnims.Craft;
            action.hideHandItems = true;
            action.actionText = "repairing";
            action.eventName = "event_repair";
            action.showProgressBar = true;
            action.blockMovement = true;
            -- isValid override
            action.isValid = function(action)
                return pp:isActionsValid() and pp.blueprintLogic:getCrafterParts():isRequiresRepair();
            end
            ISTimedActionQueue.add(action);
        end
    elseif self.buttonDbgDecay and self.buttonDbgDecay==_button then
        if getDebug() and (not isClient()) then
            self.parts:applyDecay(0.25);
        end
    end
end

function ISPartsLayout:update()
    if self.blueprintLogic and self.parts then
        for k,v in ipairs(self.itemSlots) do
            if v.resource:isEmpty() or v.resource:partGetEfficiency()==0 then
                v.label.r = self.colorBroken.r;
                v.label.g = self.colorBroken.g;
                v.label.b = self.colorBroken.b;
                v.bar:setProgress(0);
            else
                v.label.r = 1;
                v.label.g = 1;
                v.label.b = 1;
                v.bar:setProgress(v.resource:partGetEfficiency());
            end
        end
        local f = self.parts:getEfficiency();
        self:setEfficiency(f);
        if self.parts:isRequiresRepair() then
            self.title:setName(self.textBroken);
            self.title.r = self.colorBroken.r;
            self.title.g = self.colorBroken.g;
            self.title.b = self.colorBroken.b;
        elseif self.parts:isBroken() then
            self.title:setName(self.textSemiBroken);
            self.title.r = self.colorSemiBroken.r;
            self.title.g = self.colorSemiBroken.g;
            self.title.b = self.colorSemiBroken.b;
        else
            self.title:setName(self.textOperational);
            self.title.r = self.colorOperational.r;
            self.title.g = self.colorOperational.g;
            self.title.b = self.colorOperational.b;
        end
        if self.buttonRepair then
            self.buttonRepair.enable = self.parts:isRequiresRepair();
        elseif self.buttonRepair then
            self.buttonRepair.enable = false;
        end
    end
end

function ISPartsLayout:setEfficiency(_efficiency)
    if self.effBar.progress~=_efficiency or self.effBar.forceIt then
        self.effBar:setProgress(_efficiency);
        self.effBar:setText("efficiency: "..tostring(round(_efficiency*100,0)).."%");
        self.effBar.forceIt = true;
    end
end

function ISPartsLayout:prerender()
    ISPanel.prerender(self);
end

function ISPartsLayout:render()
    ISPanel.render(self);
end

function ISPartsLayout:new (x, y, _parentPanel, _blueprintLogic)
    local width = 200;
    local height = 256;
    local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.x = x;
    o.y = y;
    o.background = false;
    o.backgroundColor = {r=0, g=0, b=0, a=0.0};
    o.borderColor = {r=0.6, g=0.6, b=0.6, a=1};
    o.borderOuterColor = {r=0.6, g=0.6, b=0.6, a=1};
    o.detailInnerColor = {r=0,g=0,b=0,a=1};
    o.textColor = {r=1,g=1,b=1,a=1}
    o.tagColor = {r=0.8,g=0.8,b=0.8,a=1}
    o.invalidColor = {r=0.6,g=0.2,b=0.2,a=1}
    o.width = width;
    o.height = height;
    o.anchorLeft = false;
    o.anchorRight = false;
    o.anchorTop = false;
    o.anchorBottom = false;

    o.horzTexture = getTexture("media/ui/Entity/bar_efficiency_horz.png");
    o.vertTexture = getTexture("media/ui/Entity/bar_efficiency_vert.png");

    o.parentPanel = _parentPanel;
    o.blueprintLogic = _blueprintLogic;
    o.parts = _blueprintLogic:getCrafterParts();
    o.player = _parentPanel.player;
    o.playerNum = _parentPanel.player:getPlayerNum();
    o.joypadMoveInterval = ISPartsLayout.defaultJoypadMoveInterval;
    return o
end