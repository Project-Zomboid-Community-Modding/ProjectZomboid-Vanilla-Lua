--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISPanelJoypad"

ISWidgetCraftLogicControl = ISPanelJoypad:derive("ISWidgetCraftLogicControl");

local debugSpam = true

local FONT_SCALE = getTextManager():getFontHeight(UIFont.Small) / 19; -- normalize to 1080p
local BUTTON_SIZE = getTextManager():getFontHeight(UIFont.Small);-- * 1.5
local ICON_SCALE = math.max(1, (FONT_SCALE - math.floor(FONT_SCALE)) < 0.5 and math.floor(FONT_SCALE) or math.ceil(FONT_SCALE));
local BUTTON_ICON_SIZE = 16 * ICON_SCALE;

--************************************************************************--
--** ISWidgetCraftLogicControl:initialise
--**
--************************************************************************--

function ISWidgetCraftLogicControl:initialise()
    ISPanelJoypad.initialise(self);
end

function ISWidgetCraftLogicControl:createChildren()
    ISPanelJoypad.createChildren(self);

    local fontHeight = -1; -- <=0 sets label initial height to font

    self.quantityLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, "Quantity:", 1, 1, 1, 1, UIFont.Small, true);
    self.quantityLabel:initialise();
    self.quantityLabel:instantiate();
    self:addChild(self.quantityLabel);

    self.entryBox = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISTextEntryBox, "", 0, 0, 70, 20);
    self.entryBox.font = UIFont.Small;
    self.entryBox:initialise();
    self.entryBox:instantiate();
    self.entryBox.onLostFocus = ISWidgetCraftLogicControl.onTextChange;
    self.entryBox.target = self;
    self.entryBox:setClearButton(true);
    self.entryBox:setOnlyNumbers(true);
    self:addChild(self.entryBox);

    local buttonSize = getTextManager():getFontHeight(UIFont.Small) + 2;

    self.buttonMax = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, buttonSize*2, buttonSize, "MAX")
    --self.buttonPrev.image = getTexture("ArrowLeft");
    self.buttonMax.font = UIFont.Small;
    self.buttonMax.target = self;
    self.buttonMax.onclick = ISWidgetCraftLogicControl.onButtonClick;
    self.buttonMax.enable = true;
    self.buttonMax:initialise();
    self.buttonMax:instantiate();
    --self.buttonMax.originalTitle = self.buttonMax.title;
    self:addChild(self.buttonMax);

    self.buttonMore = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, buttonSize, buttonSize, "")
    self.buttonMore.image = getTexture("media/ui/Entity/BTN_Plus_Icon_48x48.png");
    self.buttonMore.target = self;
    self.buttonMore.onclick = ISWidgetCraftLogicControl.onButtonClick;
    self.buttonMore.enable = true;
    self.buttonMore:initialise();
    self.buttonMore:instantiate();
    self:addChild(self.buttonMore);

    self.buttonLess = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, buttonSize, buttonSize, "")
    self.buttonLess.image = getTexture("media/ui/Entity/BTN_Minus_Icon_48x48.png");
    self.buttonLess.target = self;
    self.buttonLess.onclick = ISWidgetCraftLogicControl.onButtonClick;
    self.buttonLess.enable = true;
    self.buttonLess:initialise();
    self.buttonLess:instantiate();
    self:addChild(self.buttonLess);

    self.buttonCraft = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, BUTTON_SIZE * 1.5, BUTTON_SIZE, getText("IGUI_CraftingWindow_Craft"))
    --self.buttonPrev.image = getTexture("ArrowLeft");
    self.buttonCraft.font = UIFont.Small;
    self.buttonCraft.target = self;
    self.buttonCraft.onclick = ISWidgetCraftLogicControl.onButtonClick;
    self.buttonCraft.enable = true;
    self.buttonCraft:initialise();
    self.buttonCraft:instantiate();
    --self.buttonCraft.originalTitle = self.buttonCraft.title;
    self:addChild(self.buttonCraft);

    self.origButtonHeight = self.buttonCraft:getHeight();

    self.boxHeight = self.height;

    self:setCraftQuantity(1);
end

function ISWidgetCraftLogicControl:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    local minHeight = self.margin*3;
    local minWidth = self.margin*2;

    if self.allowBatchCraft then
        minHeight = minHeight + self.quantityLabel:getHeight() + self.margin;
        minHeight = minHeight + self.entryBox:getHeight() + self.margin;
    end
    
    minHeight = minHeight + self.buttonCraft:getHeight();

    if self.allowBatchCraft then
        minWidth = minWidth + self.buttonLess:getWidth() + self.margin;
        minWidth = minWidth + self.entryBox:getWidth() + self.margin;
        minWidth = minWidth + self.buttonMore:getWidth() + self.margin;
        minWidth = minWidth + self.buttonMax:getWidth();
    end

    local heightDiff = (height > minHeight) and (height - minHeight) or 0;
    height = math.max(height, minHeight);
    width = math.max(width, minWidth);

    local x = self.margin;
    local y = self.margin + (heightDiff / 2);
    
    if self.allowBatchCraft then
        if self.quantityLabel then
            self.quantityLabel:setVisible(true);
            self.quantityLabel:setX(x);
            self.quantityLabel:setY(y);
            y = y + self.quantityLabel:getHeight() + self.margin;
        end
    else
        self.quantityLabel:setVisible(false);
    end

    -- qty buttons
    local heightUsed = 0;
    if self.allowBatchCraft then
        if self.buttonLess then
            self.buttonLess:setVisible(true);
            self.buttonLess:setX(x);
            self.buttonLess:setY(y);
            x = x + self.buttonPadding + self.buttonLess:getWidth();
            heightUsed = math.max(heightUsed, self.buttonLess:getHeight())
        end

        if self.entryBox then
            self.entryBox:setVisible(true);
            self.entryBox:setX(x);
            self.entryBox:setY(y);
            x = x + self.buttonPadding + self.entryBox:getWidth();
            heightUsed = math.max(heightUsed, self.entryBox:getHeight())
        end

        if self.buttonMore then
            self.buttonMore:setVisible(true);
            self.buttonMore:setX(x);
            self.buttonMore:setY(y);
            x = x + self.buttonPadding + self.buttonMore:getWidth();
            heightUsed = math.max(heightUsed, self.buttonMore:getHeight())
        end

        if self.buttonMax then
            self.buttonMax:setVisible(true);
            self.buttonMax:setX(x);
            self.buttonMax:setY(y);
            x = x + self.buttonPadding + self.buttonMax:getWidth();
            heightUsed = math.max(heightUsed, self.buttonMax:getHeight())
        end
    else
        if self.entryBox then self.entryBox:setVisible(false); end
        if self.buttonMax then self.buttonMax:setVisible(false); end
        if self.buttonMore then self.buttonMore:setVisible(false); end
        if self.buttonLess then self.buttonLess:setVisible(false); end
    end

    if heightUsed > 0 then
        y = y + heightUsed + self.margin;
    end

    -- craft buttons
    x = self.margin;
    self.buttonCraft:setX(x);
    self.buttonCraft:setWidth(width-(self.margin*2));
    self.buttonCraft:setY(y);

    y = self.buttonCraft:getY() + self.buttonCraft:getHeight() + self.margin;
    
    self.boxHeight = y;

    self:setWidth(width);
    self:setHeight(height);

    self.joypadButtonsY = {}
    self.joypadButtons = {}
    self.joypadIndexY = 1
    self.joypadIndex = 1
    if self.buttonLess:isVisible() then
        self:insertNewLineOfButtons(self.buttonLess, self.buttonMore, self.buttonMax)
    end
    self:insertNewLineOfButtons(self.buttonCraft)
end

function ISWidgetCraftLogicControl:onResize()
    ISUIElement.onResize(self)
end

function ISWidgetCraftLogicControl:prerender()
    if self.background then
        self:drawRectStatic(0, 0, self.width, self.boxHeight, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
        self:drawRectBorderStatic(0, 0, self.width, self.boxHeight, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    end

    if self.logic:getCraftLogic():getStartMode()==StartMode.Manual then
        if self.buttonCraft then
            self.buttonCraft:setVisible(true);
        end
    else
        if self.buttonCraft then
            self.buttonCraft:setVisible(false);
        end
    end

    if self.logic and self.logic:getCraftLogic():isRunning() then
        if self.buttonCraft then
            self.buttonCraft.enable = false;
        end
    else
        if self.buttonCraft then
            self.buttonCraft.enable = self.logic:cachedCanStart(self.player);
        end
    end
end

function ISWidgetCraftLogicControl:render()
    ISPanelJoypad.render(self);
    self:renderJoypadFocus()
end

function ISWidgetCraftLogicControl:update()
    ISPanelJoypad.update(self);
end

function ISWidgetCraftLogicControl:onButtonClick(_button)
    if self.buttonCraft and _button==self.buttonCraft then
        self:startCraft(false);
    end
    if self.buttonMax and _button==self.buttonMax then
        local amount = self.logic:getPossibleCraftCount(false);
        if tostring(amount)~=self.entryBox:getInternalText() then
            self:setCraftQuantity(amount);
        end
    end
    if self.buttonMore and _button==self.buttonMore then
        local amount = tonumber(self.entryBox:getInternalText());
        if not amount then amount = 1; end
        amount = amount + 1;

        if tostring(amount)~=self.entryBox:getInternalText() then
            self:setCraftQuantity(amount);
        end
    end
    if self.buttonLess and _button==self.buttonLess then
        local amount = tonumber(self.entryBox:getInternalText());
        if not amount then amount = 1; end
        amount = amount - 1;

        if tostring(amount)~=self.entryBox:getInternalText() then
            self:setCraftQuantity(amount);
        end
    end
end

function ISWidgetCraftLogicControl:startCraft(force)
    if not self.craftTimes then
        self.craftTimes = tonumber(self.entryBox:getInternalText()) or 1;
        self.craftTimes = math.max(1, self.craftTimes);
    end

    if force then
        if self.logic then
            local monitor = self.logic:debugCanStart(self.player);
            if monitor then
                ISCraftRecipeMonitor.OnOpenPanel(monitor);
            else
                print("No craft recipe monitor returned!");
            end
        end
    else
        local funcCanStart = function(_player, _entity, _component)
            if not _component:getStartMode()==StartMode.Manual then
                return false;
            end
            return _component:canStart(_player);
        end
        local funcStart = function(_player, _entity, _component)
            _component:start(_player);
        end
        ISEntityUI.GenericCraftStart(self.player, self.entity, self.logic:getCraftLogic(), funcCanStart, funcStart);
    end
end

function ISWidgetCraftLogicControl.onTextChange(box)
    if not box then
        return;
    end
    if box==box.target.entryBox then
        box.target:sanitizeCraftQuantity();
    end
end

function ISWidgetCraftLogicControl:onInputsChanged()
    self:sanitizeCraftQuantity();
end

function ISWidgetCraftLogicControl:setCraftQuantity(amount)
    self.entryBox:setText(tostring(amount));
    self:sanitizeCraftQuantity();
end

function ISWidgetCraftLogicControl:sanitizeCraftQuantity()
    local amount = tonumber(self.entryBox:getInternalText());
    if not amount then amount = 1; end

    local max = self.logic:getPossibleCraftCount(false);
    amount = PZMath.clamp(amount, 0, max);

    if amount == 0 and max > 0 then amount = 1; end

    if tostring(amount)~=self.entryBox:getInternalText() then
        self.entryBox:setText(tostring(amount));
    end
end

function ISWidgetCraftLogicControl:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
    self:restoreJoypadFocus()
end

function ISWidgetCraftLogicControl:onLoseJoypadFocus(joypadData)
    ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
    self:clearJoypadFocus()
end

--************************************************************************--
--** ISWidgetCraftLogicControl:new
--**
--************************************************************************--
function ISWidgetCraftLogicControl:new(x, y, width, height, player, logic)
    local o = ISPanelJoypad.new(self, x, y, width, height);

    o.background = false;
    o.backgroundColor = {r=0.2, g=0.2, b=0.2, a=0.5};
    --o.margin = 5;
    o.player = player;
    o.logic = logic;
    o.entity = logic:getEntity();

    o.interactiveMode = false;
    o.allowBatchCraft = true;

    o.buttonPadding = 5;

    o.margin = 5;
    o.minimumWidth = 100;
    o.minimumHeight = 0;

    --o.doToolTip = true;

    o.autoFillContents = false;

    -- these may or may not be used by a parent control while calculating layout:
    o.isAutoFill = false;
    o.isAutoFillX = false;
    o.isAutoFillY = false;
    return o;
end