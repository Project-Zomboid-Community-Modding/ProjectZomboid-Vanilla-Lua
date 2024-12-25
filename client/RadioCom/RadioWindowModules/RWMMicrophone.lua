--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************
require "RadioCom/RadioWindowModules/RWMPanel"

RWMMicrophone = RWMPanel:derive("RWMMicrophone");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local BUTTON_HGT = FONT_HGT_SMALL + 6
local UI_BORDER_SPACING = 10

function RWMMicrophone:initialise()
    ISPanel.initialise(self)
end

function RWMMicrophone:createChildren()
    self.muteButton = ISButton:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, self.width-UI_BORDER_SPACING*2-2,BUTTON_HGT,getText("IGUI_RadioMuteMic"),self, RWMMicrophone.onMuteButton);
    self.muteButton:initialise();
    self.muteButton.backgroundColor = {r=0, g=0, b=0, a=0.0};
    self.muteButton.backgroundColorMouseOver = {r=1.0, g=1.0, b=1.0, a=0.1};
    self.muteButton.borderColor = {r=1.0, g=1.0, b=1.0, a=0.3};
    self:addChild(self.muteButton);

    self:setHeight(UI_BORDER_SPACING*2+self.muteButton:getHeight()+2);
end

function RWMMicrophone:onMuteButton()
    if self.deviceData and self.player and self.device then
        if self:doWalkTo() then
            ISTimedActionQueue.add(ISRadioAction:new("MuteMicrophone",self.player, self.device, not self.deviceData:getMicIsMuted() ));
        end
    end
end

function RWMMicrophone:setMuteButtonText()
    if self.deviceData then
        self.muteState = self.deviceData:getMicIsMuted();
        if self.muteState then
            self.muteButton:setTitle(getText("IGUI_RadioUnmuteMic"));
        else
            self.muteButton:setTitle(getText("IGUI_RadioMuteMic"));
        end
    end
end

function RWMMicrophone:readFromObject( _player, _deviceObject, _deviceData, _deviceType )
    RWMPanel.readFromObject(self, _player, _deviceObject, _deviceData, _deviceType );
    if self.deviceData and self.deviceData:getIsTwoWay() then
        self:setMuteButtonText();
        return true;
    end
    return false;
end

function RWMMicrophone:update()
    ISPanel.update(self);
    if self.deviceData then
        if self.deviceData:getMicIsMuted() ~= self.muteState then
            self:setMuteButtonText();
        end
        if self.deviceData:getIsTurnedOn() then
            self.muteButton:setEnable(true);
        else
            self.muteButton:setEnable(false);
        end
    end
end

function RWMMicrophone:prerender()
    ISPanel.prerender(self);
end


function RWMMicrophone:render()
    ISPanel.render(self);
end

function RWMMicrophone:onJoypadDown(button)
    if button == Joypad.AButton then
        self:onMuteButton()
    end
end

function RWMMicrophone:getAPrompt()
    if self.deviceData:getMicIsMuted() then
        return getText("IGUI_RadioUnmuteMic");
    else
        return getText("IGUI_RadioMuteMic");
    end
end
function RWMMicrophone:getBPrompt()
    return nil;
end
function RWMMicrophone:getXPrompt()
    return nil;
end
function RWMMicrophone:getYPrompt()
    return nil;
end


function RWMMicrophone:new (x, y, width, height)
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
    o.muteState = false;
    return o
end
