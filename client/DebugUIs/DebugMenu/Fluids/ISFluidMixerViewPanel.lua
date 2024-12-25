--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISPanel"
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

ISFluidMixerViewPanel = ISPanel:derive("ISFluidMixerViewPanel");

function ISFluidMixerViewPanel:initialise()
	ISPanel.initialise(self);
end


function ISFluidMixerViewPanel:createChildren()
    ISPanel.createChildren(self);

    local x,y = UI_BORDER_SPACING+1, UI_BORDER_SPACING+1;

    local LEFT_BAR_WIDTH = 100+(getCore():getOptionFontSizeReal()*50);

    self.listLabel = ISLabel:new(x, y, BUTTON_HGT, getText("IGUI_DebugMenu_Search"), 1, 1, 1, 1.0, UIFont.Small, true);
    self.listLabel:initialise();
    self.listLabel:instantiate();
    self:addChild(self.listLabel);

    self.entryBox = ISTextEntryBox:new("", x+self.listLabel.width+UI_BORDER_SPACING, y, LEFT_BAR_WIDTH-self.listLabel.width-UI_BORDER_SPACING, BUTTON_HGT);
    self.entryBox.font = UIFont.Small;
    self.entryBox:initialise();
    self.entryBox:instantiate();
    self.entryBox.onTextChange = ISFluidMixerViewPanel.onTextChange;
    self.entryBox.target = self;
    self.entryBox:setClearButton(true);
    self:addChild(self.entryBox);

    y = self.entryBox:getBottom()+UI_BORDER_SPACING;

    self.list = ISScrollingListBox:new(UI_BORDER_SPACING+1, y, LEFT_BAR_WIDTH, self.height - y - UI_BORDER_SPACING*2-2);
    self.list.backgroundColor = {r=0.0, g=0.0, b=0.0, a=1.0};
    self.list:initialise();
    self.list:instantiate();
    self.list.itemheight = BUTTON_HGT*2;
    self.list.selected = 0;
    self.list.font = UIFont.Small;
    self.list.doDrawItem = ISFluidMixerViewPanel.drawFluidListItem;
    self.list.target = self;
    self.list.onmousedown = ISFluidMixerViewPanel.onFluidListSelected;
    self.list.drawBorder = true;
    self.list.modColor = namedColorToTable("CornFlowerBlue");
    self:addChild(self.list);

    y = self.listLabel:getY();
    x = self.list:getX() + self.list:getWidth() + UI_BORDER_SPACING;

    self.fluidContainer = FluidContainer.CreateContainer();
    self.fluidContainer:setCapacity(100);

    local fluidBarWidth = BUTTON_HGT*2

    self.fluidBar = ISFluidBar:new (self.width-UI_BORDER_SPACING-1-fluidBarWidth, y, fluidBarWidth, self.height - UI_BORDER_SPACING*2-2, self.player);
    self.fluidBar:initialise();
    self.fluidBar:instantiate();
    self.fluidBar:setContainer(self.fluidContainer);
    self:addChild(self.fluidBar);

    local midWidth = self.fluidBar:getX() - x - UI_BORDER_SPACING;

    self.addFluidLabel = ISLabel:new(x, y, FONT_HGT_MEDIUM, "<Fluid>", 1, 1, 1, 1.0, UIFont.Medium, true);
    self.addFluidLabel:initialise();
    self.addFluidLabel:instantiate();
    self:addChild(self.addFluidLabel);

    y = self:incY(y, self.addFluidLabel, 5);

    self.warningLabel = ISLabel:new(x, y, FONT_HGT_SMALL, "", 0.8, 0.2, 0.2, 1.0, UIFont.Small, true);
    self.warningLabel:initialise();
    self.warningLabel:instantiate();
    self:addChild(self.warningLabel);

    y = self:incY(y, self.warningLabel, UI_BORDER_SPACING);

    self.slider = ISSliderPanel:new(x, y, midWidth, BUTTON_HGT, self, ISFluidMixerViewPanel.onSliderChange );
    self.slider:initialise();
    self.slider:instantiate();
    self.slider.valueLabel = false;
    self.slider:setCurrentValue( 0, true );
    --self.slider.customData = _data;
    self:addChild(self.slider);

    y = self:incY(y, self.slider, UI_BORDER_SPACING);

    self.amountBox = ISTextEntryBox:new("0", x, y, midWidth, BUTTON_HGT);
    self.amountBox.font = UIFont.Small;
    self.amountBox:initialise();
    self.amountBox:instantiate();
    self.amountBox.onTextChange = ISFluidMixerViewPanel.onTextChange;
    self.amountBox.target = self;
    self.amountBox:setClearButton(true);
    self.amountBox:setOnlyNumbers(true);
    self:addChild(self.amountBox);

    y = self:incY(y, self.amountBox, UI_BORDER_SPACING);

    self.addFluidButton = ISButton:new(x, y, midWidth,BUTTON_HGT,getText("IGUI_Fluids_Mixer_Add"),self, ISFluidMixerViewPanel.onButtonClick);
    self.addFluidButton:initialise();
    self.addFluidButton:instantiate();
    self.addFluidButton.enable = true;
    self:addChild(self.addFluidButton);

    y = self:incY(y, self.addFluidButton, UI_BORDER_SPACING);

    self.clearFluidButton = ISButton:new(x, y, midWidth,BUTTON_HGT,getText("IGUI_Fluids_Mixer_Clear"),self, ISFluidMixerViewPanel.onButtonClick);
    self.clearFluidButton:initialise();
    self.clearFluidButton:instantiate();
    self.clearFluidButton.enable = true;
    self:addChild(self.clearFluidButton);

    y = self:incY(y, self.clearFluidButton, UI_BORDER_SPACING);

    self.createItemButton = ISButton:new(x, y, midWidth,BUTTON_HGT,getText("IGUI_Fluids_Items_Create"),self, ISFluidMixerViewPanel.onButtonClick);
    self.createItemButton:initialise();
    self.createItemButton:instantiate();
    self.createItemButton.enable = true;
    self:addChild(self.createItemButton);

    y = self:incY(y, self.createItemButton, UI_BORDER_SPACING);

    self:populate();
end

function ISFluidMixerViewPanel:onResize(_width, _height)
    ISPanel.onResize(self, _width, _height);

    self.list:setHeight(self.height - self.list:getY() - UI_BORDER_SPACING - 1);

    local x = self.list:getX() + self.list:getWidth() + UI_BORDER_SPACING;
    local midWidth = self.fluidBar:getX() - x - UI_BORDER_SPACING;

    self.fluidBar:setX(self.width-self.fluidBar:getWidth() - UI_BORDER_SPACING-1);
    self.fluidBar:setHeight(self.height - UI_BORDER_SPACING*2-2);

    --local midWidth = self.width - x - 10;
    self.slider:setWidth(midWidth);
    self.slider:paginate();
    self.amountBox:setWidth(midWidth);
    self.addFluidButton:setWidth(midWidth);
    self.clearFluidButton:setWidth(midWidth);
    self.createItemButton:setWidth(midWidth);
end

function ISFluidMixerViewPanel:incY(_y, _obj, _margin)
    return _obj:getY() + _obj:getHeight() + (_margin or 0);
end

function ISFluidMixerViewPanel:onSliderChange(_newval, _slider)
    if _slider==self.slider then
        self.amountBox:setText(tostring(_newval));
    end
end

function ISFluidMixerViewPanel.onTextChange(box)
    if not box then
        return;
    end
    if box==box.target.entryBox then
        if box:getInternalText()~=box.target.searchText then
            box.target.searchText = box:getInternalText();
            box.target:populate();
        end
    elseif box==box.target.amountBox then
        local amount = tonumber(box.target.amountBox:getInternalText());
        if not amount then amount = 0; end
        amount = PZMath.clamp(amount, 0, 100);
        if tostring(amount)~=box.target.amountBox:getInternalText() then
            box.target.amountBox:setText(tostring(amount));
        end

        box.target.slider:setCurrentValue( amount, true );
    end
end

function ISFluidMixerViewPanel:onButtonClick(_button)
    if _button==self.clearFluidButton then
        self.fluidContainer:Empty();
        self:onFluidListSelected(self.selectedFluidItem);
    elseif _button==self.addFluidButton then
        local amount = self.slider:getCurrentValue();
        if self.selectedFluidItem and self.selectedFluidItem.fluid and amount>0 then
            local fluid = self.selectedFluidItem.fluid;

            self.fluidContainer:addFluid(fluid, amount);
        end
    elseif _button==self.createItemButton then
        self:addItem("Base.DebugFluid");
    end
end

function ISFluidMixerViewPanel:addItem(item)
    local playerObj = self.player;
    if not playerObj or playerObj:isDead() then return end
    if isClient() then
        print("cannot perform this function on client atm");
        --SendCommandToServer("/additem \"" .. playerObj:getDisplayName() .. "\" \"" .. luautils.trim(item:getFullName()) .. "\"")
    else
        local item = instanceItem(item)
        local fc = item:getFluidContainer();
        if fc then
            fc:Empty();
            FluidContainer.Transfer(self.fluidContainer, fc, self.fluidContainer:getAmount(), true);
        end
        playerObj:getInventory():AddItem(item);
    end
end

local sortFluids = function (a, b)
    -- sort alphabetically.
    return a.name < b.name
end

function ISFluidMixerViewPanel:populate()
    self.list:clear()

    local needle = self.searchText;
    if (not self.searchText) or self.searchText=="" then
        needle = false;
    end

    local fluids = Fluid.getAllFluids();
    if not fluids then
        return;
    end

    local temp = {};
    for i=0,fluids:size()-1 do
        local fluid = fluids:get(i);

        local found = true;
        if needle then
            found = string.find( string.lower(fluid:getFluidTypeString()), string.lower(self.searchText) ) and true or false;
            if not found then
                found = string.find( string.lower(fluid:getDisplayName()), string.lower(self.searchText) ) and true or false;
            end
        end
        if found then
            local t = {
                fluid = fluid,
                fulltype = fluid:getFluidTypeString(),
                name = fluid:getDisplayName(),
                vanilla = fluid:isVanilla(),
                color = fluid:getColor(),
                poison = fluid:isPoisonous(),
            }
            table.insert(temp, t);
        end
    end

    table.sort(temp, sortFluids);

    for _,item in ipairs(temp) do
        self.list:addItem(item.name, item);
    end

    if self.list.items and #self.list.items>0 then
        --print("SELECTING ELEMENT")
        self.list.selected = 1;
        self:onFluidListSelected(self.list.items[self.list.selected].item);
    end
end

function ISFluidMixerViewPanel:drawFluidListItem(y, item, alt)
    local a = 1.0;

    self:drawRectBorder( 1, y+1, self:getWidth()-2, self.itemheight - 2, 0.2, 1.0, 1.0, 1.0)
    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.2, 1.0, 1.0, 1.0);
    end

    local x = 5;
    local r,g,b = item.item.color:getRedFloat(), item.item.color:getGreenFloat(), item.item.color:getBlueFloat();

    local cy = y+(self.itemheight/2);
    self:drawRect(x+1, cy-10, 20, 20, 1.0, r, g, b);
    self:drawRectBorder( x-1, cy-12, 24, 24, 0.2, 1.0, 1.0, 1.0)

    x = 34;

    if item.item.name then
        local drawY = y + (self.itemheight/4) - (FONT_HGT_SMALL /2) + 2;
        --local c = item.item.color;
        if item.item.fluid:getFluidType()==FluidType.Modded then
            --r,g,b = Colors.CornFlowerBlue:getRedFloat(), Colors.CornFlowerBlue:getGreenFloat(), Colors.CornFlowerBlue:getBlueFloat();
            self:drawText( "[M] "..item.item.name, x, drawY, self.modColor.r, self.modColor.g, self.modColor.b, 1.0, self.font);
        else
            self:drawText( item.item.name, x, drawY, 1, 1, 1, 1.0, self.font);
        end
        --[[
        if item.item.vanilla then
            self:drawText( item.item.name, x, drawY, 1, 1, 1, 1.0, self.font);
        else
            self:drawText( "[MODDED] "..item.item.name, x, drawY, 0.8, 0.8, 1, 1.0, self.font);
        end
        --]]
    end
    if item.item.fulltype then
        local drawY = y + ((self.itemheight/4)*3) - (FONT_HGT_SMALL /2) - 1;
        self:drawText( "<"..item.item.fulltype..">", x, drawY, 0.3, 0.3, 0.3, 1.0, self.font);
    end

    return y + self.itemheight;
end

function ISFluidMixerViewPanel:onFluidListSelected(_item)
    self.selectedFluidItem = _item;

    if self.selectedFluidItem then
        self.addFluidLabel:setName(tostring(self.selectedFluidItem.name));
        self.addFluidButton:setTitle(getText("IGUI_Fluids_Mixer_Add",tostring(self.selectedFluidItem.name)));
        self.canMix = self.fluidContainer:canAddFluid(self.selectedFluidItem.fluid);
        if not self.canMix then
            self.warningLabel:setName(getText("IGUI_Fluids_Mixer_CannotMixExisting"));
        else
            self.warningLabel:setName("");
        end
        self.addFluidButton.enable = self.canMix;
        if isClient() then
            self.addFluidButton:setTitle(getText("IGUI_Fluids_Mixer_Disabled"));
            self.createItemButton:setTitle(getText("IGUI_Fluids_Mixer_Disabled"));
            self.warningLabel:setName(getText("IGUI_Fluids_Mixer_CannotMixClient"));
        end
        --self.fluidPanel:setFluid(self.selectedFluidItem.fluid);
    else
        --self.fluidPanel:setFluid(nil);
    end
end

function ISFluidMixerViewPanel:prerender()
    ISPanel.prerender(self);

    self.clearFluidButton.enable = self.fluidContainer and (not self.fluidContainer:isEmpty());
    self.createItemButton.enable = (not isClient()) and self.fluidContainer and (not self.fluidContainer:isEmpty());
end


function ISFluidMixerViewPanel:render()
    ISPanel.render(self)
end

function ISFluidMixerViewPanel:close()
end

function ISFluidMixerViewPanel:new (x, y, width, height, player)
	local o = ISPanel:new(x, y, width, height);
	setmetatable(o, self)
	self.__index = self
    o.player = player;
    o.playerNum = player:getPlayerNum();
    o.searchText = "";
    o.canMix = true;
    --o.modColor = namedColorToTable("CornFlowerBlue");
	return o
end