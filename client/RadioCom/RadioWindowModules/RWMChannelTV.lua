--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************
require "RadioCom/RadioWindowModules/RWMPanel"

RWMChannelTV = RWMPanel:derive("RWMChannelTV");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local BUTTON_HGT = FONT_HGT_SMALL + 6
local UI_BORDER_SPACING = 10

function RWMChannelTV:initialise()
    ISPanel.initialise(self)
end

function RWMChannelTV:createChildren()
    local y = 0;
    self.comboBox = ISComboBox:new (UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, self.width-UI_BORDER_SPACING*2-2, BUTTON_HGT, self, RWMChannelTV.comboChange)
    self.comboBox:initialise();
    self:addChild(self.comboBox);

    y = self.comboBox:getY() + self.comboBox:getHeight();

    self.tuneInButton = ISButton:new(UI_BORDER_SPACING+1, y+UI_BORDER_SPACING, self.width-UI_BORDER_SPACING*2-2, BUTTON_HGT, getText("IGUI_RadioTuneIn"),self, RWMChannelTV.doTuneInButton);
    self.tuneInButton:initialise();
    self.tuneInButton.backgroundColor = {r=0, g=0, b=0, a=0.0};
    self.tuneInButton.backgroundColorMouseOver = {r=1.0, g=1.0, b=1.0, a=0.1};
    self.tuneInButton.borderColor = {r=1.0, g=1.0, b=1.0, a=0.3};
    self.tuneInButton:setSound("activate", nil)
    self:addChild(self.tuneInButton);

    y = self.tuneInButton:getY() + self.tuneInButton:getHeight() + UI_BORDER_SPACING+1;

    self:setHeight( y );
end

function RWMChannelTV:isValidPresets()
    if self.presets and self.comboBox.selected > 0 and self.comboBox.selected-1 < self.presets:size() then
        return true;
    end
end

function RWMChannelTV:comboChange()
    if self:isValidPresets() then
        self.selectedPreset = self.presets:get( self.comboBox.selected-1 );
    end
end

function RWMChannelTV:doTuneInButton()
    if self:isValidPresets() and self.player and self.device then
        local p = self.presets:get( self.comboBox.selected-1 );
        -- this is so players with a remote equipped can interact with televisions
        if (self.player and self.deviceData:canPlayerRemoteInteract(self.player))
        or self:doWalkTo() then
            ISTimedActionQueue.add(ISRadioAction:new("SetChannel",self.player, self.device, p:getFrequency() ));
        end
    end
end

function RWMChannelTV:addComboOption( _freq, _name )
    local s = _name;
    if getTextManager():MeasureStringX(UIFont.Small, s) > self.comboBox:getWidth() then
        local ss = "";
        for i = 1, #s do
            ss = ss .. s:sub(i,i);
            if getTextManager():MeasureStringX(UIFont.Small, ss) > self.comboBox:getWidth() - 45 then
                ss = ss .. "...";
                break;
            end
        end
        s = ss;
    end
    self.comboBox:addOption(s);
end

function RWMChannelTV:readPresets( _selected )
    self.comboBox.options = {};
    self.comboBox.selected = 0;
    if self.deviceData and self.deviceData:getDevicePresets() and self.deviceData:getDevicePresets():getPresets() then
        self.presets = self.deviceData:getDevicePresets():getPresets();
        for i = 0, self.presets:size()-1 do
            local p = self.presets:get(i);
            self:addComboOption(p:getFrequency(), p:getName());
            if not _selected and p:getFrequency() == self.deviceData:getChannel() then
                self.comboBox.selected = i+1;
            end
        end
        if _selected and _selected > 0 and _selected <= self.presets:size() then
            self.comboBox.selected = _selected;
        end
    end
end

function RWMChannelTV:clear()
    RWMPanel.clear(self);
    self.presets = nil;
    self.comboBox.options = {};
    self.comboBox.selected = 0;
end

function RWMChannelTV:readFromObject( _player, _deviceObject, _deviceData, _deviceType )
    if _deviceData:getIsTelevision()==false then
        return false;
    end
    RWMPanel.readFromObject(self, _player, _deviceObject, _deviceData, _deviceType );
    self:readPresets();
    return true;
end

function RWMChannelTV:prerender()
    ISPanel.prerender(self);
end

function RWMChannelTV:update()
    ISPanel.update(self);

    if self.comboBox and self.comboBox.expanded == true and self.lastModeExpanded == false then
        local a,b = self.comboBox:getY()+self.comboBox:getHeight()+UI_BORDER_SPACING+1, self.tuneInButton:getY()+self.tuneInButton:getHeight()+UI_BORDER_SPACING+1;
        self:setHeight( a > b and a or b);
        --self:setHeight(self.comboBox:getY()+self.comboBox:getHeight()+5);
        --print("height: ",( a > b and a or b) );
        if self.parent then
            self.parent:calculateHeights();
        else
            print("no parent")
        end
        self.lastModeExpanded = true;
    elseif self.comboBox and self.comboBox.expanded == false and self.lastModeExpanded == true then
        self:setHeight(self.tuneInButton:getY()+self.tuneInButton:getHeight()+UI_BORDER_SPACING+1);
        if self.parent then
            self.parent:calculateHeights();
        end
        self.lastModeExpanded = false;
    end

    if self.deviceData and self.deviceData:getIsTurnedOn() then
        self.tuneInButton:setEnable(true);
    else
        self.tuneInButton:setEnable(false);
    end
end

function RWMChannelTV:render()
    ISPanel.render(self);
    if self.focusElement then
        local x,y,w,h = self.focusElement:getX(),self.focusElement:getY(),self.focusElement:getWidth(),self.focusElement:getHeight();
        self:drawRectBorder(x, y, w, h, 0.4, 0.2, 1.0, 1.0);
        self:drawRectBorder(x+1, y+1, w-2, h-2, 0.4, 0.2, 1.0, 1.0);
    end
end

function RWMChannelTV:setParent( _parent )
    self.parent = _parent;
end

function RWMChannelTV:getParent()
    return self.parent;
end

function RWMChannelTV:onJoypadDown(button)
    if button == Joypad.AButton then
        if self.focusElement then --and self.focusElement.isCombobox then
            self.focusElement:forceClick();
            self.focusElement:setJoypadFocused(false);
            self.focusElement = nil;
        else
            if self.deviceData:getIsTurnedOn() then
                self:doTuneInButton()
            end
        end
    elseif button == Joypad.RBumper then
        if self.focusElement == self.comboBox then
            self.focusElement:setJoypadFocused(false);
            self.focusElement = nil;
        else
            self.focusElement = self.comboBox;
            self.focusElement.expanded = true;
            self.focusElement:showPopup();
            self.focusElement:setJoypadFocused(true);
        end
    elseif button == Joypad.LBumper then
        if self.focusElement then
            self.focusElement:setJoypadFocused(false);
            self.focusElement = nil;
        end
    end
    return false, true; --overrides RBumper
end

function RWMChannelTV:getAPrompt()
    if self.focusElement then
        return getText("IGUI_RadioSelectChannel");
    else
        if self.deviceData:getIsTurnedOn() then
            return getText("IGUI_RadioTuneIn");
        end
    end
    return nil;
end
function RWMChannelTV:getBPrompt()
    return nil;
end
function RWMChannelTV:getXPrompt()
    return nil;
end
function RWMChannelTV:getYPrompt()
    return nil;
end
function RWMChannelTV:getRBPrompt()
    if self.focusElement == self.comboBox then
        return getText("IGUI_RadioDeselectChannelList");
    else
        return getText("IGUI_RadioSelectChannelList");
    end
end


function RWMChannelTV:new (x, y, width, height )
    local o = RWMPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.x = x;
    o.y = y;
    o.background = true;
    o.backgroundColor = {r=0, g=0, b=0, a=0.0};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.width = width;
    o.height = height;
    o.anchorLeft = true;
    o.anchorRight = false;
    o.anchorTop = true;
    o.anchorBottom = false;
    o.fontheight = getTextManager():MeasureStringY(UIFont.Small, "AbdfghijklpqtyZ")+2;
    o.parent = nil;
    o.lastModeExpanded = false;
    return o
end

