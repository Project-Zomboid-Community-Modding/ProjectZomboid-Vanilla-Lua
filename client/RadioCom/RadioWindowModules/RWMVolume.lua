--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "RadioCom/RadioWindowModules/RWMPanel"

RWMVolume = RWMPanel:derive("RWMVolume");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local BUTTON_HGT = FONT_HGT_SMALL + 6
local UI_BORDER_SPACING = 10

function RWMVolume:initialise()
    ISPanel.initialise(self)
end

function RWMVolume:createChildren()
    self:setHeight(UI_BORDER_SPACING*2 + BUTTON_HGT + 2);

    self.speakerButton = ISSpeakerButton:new (UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, BUTTON_HGT, BUTTON_HGT, RWMVolume.onSpeakerButton, self);
    self.speakerButton:initialise();
    self:addChild(self.speakerButton);

    local xoffset = UI_BORDER_SPACING*2 + BUTTON_HGT + 1;
    local remWidth = self:getWidth() - xoffset - UI_BORDER_SPACING-1;

    self.volumeBar = ISVolumeBar:new(xoffset, UI_BORDER_SPACING+1, remWidth, BUTTON_HGT, RWMVolume.onVolumeChange, self);
    self.volumeBar:initialise();
    self:addChild(self.volumeBar);

    self.itemDropBox = ISItemDropBox:new (self.width - BUTTON_HGT - UI_BORDER_SPACING - 1, UI_BORDER_SPACING+1, BUTTON_HGT, BUTTON_HGT, false, self, RWMVolume.addHeadphone, RWMVolume.removeHeadphone, RWMVolume.verifyItem, nil );
    self.itemDropBox:initialise();
    self.itemDropBox:setBackDropTex( getTexture("Item_Headphones"), 0.4, 1,1,1 );
    self.itemDropBox:setDoBackDropTex( true );
    self.itemDropBox:setToolTip( true, getText("IGUI_RadioDragHeadphones") );

    self.hasEnabledHeadphones = false;
    --self:addChild(self.itemDropBox);
end

function RWMVolume:toggleHeaphoneSupport(enable)
    if self.hasEnabledHeadphones ~= enable then
        if not enable then
            self.volumeBar:setWidth(self.width - BUTTON_HGT - UI_BORDER_SPACING*3 - 2);
            self:removeChild(self.itemDropBox);
        else
            self.volumeBar:setWidth(self.width - BUTTON_HGT*2 - UI_BORDER_SPACING*4 - 2);
            self:addChild(self.itemDropBox);
        end
    end
    self.hasEnabledHeadphones = enable;
end

function RWMVolume:addHeadphone( _items )
    local item;
    local pbuff = 0;

    for _,i in ipairs(_items) do
        --if i:getDelta() > pbuff then
            item = i;
        break;
            --pbuff = i:getDelta()
        --end
    end

    if item then
        if self:doWalkTo() then
            ISTimedActionQueue.add(ISRadioAction:new("AddHeadphones",self.player, self.device, item ));
        end
    end
end

function RWMVolume:removeHeadphone()
    if self:doWalkTo() then
        ISTimedActionQueue.add(ISRadioAction:new("RemoveHeadphones",self.player, self.device ));
    end
end

function RWMVolume:verifyItem(_item)
    if _item:getFullType() == "Base.Headphones" or _item:getFullType() == "Base.Earbuds" then
        return true;
    end
end

function RWMVolume:round(num, idp)
    local mult = 10^(idp or 0);
    return math.floor(num * mult + 0.5) / mult;
end

function RWMVolume:onVolumeChange( _newVol )
    self.volume = _newVol/self.volumeBar:getVolumeSteps(); --self:round((_newVol/self.volumeBar:getVolumeSteps())*10,0)/10;
    --print("onvolumeChange", self.volume);
    if self.deviceData then
        if self:doWalkTo() then
            ISTimedActionQueue.add(ISRadioAction:new("SetVolume",self.player, self.device, self.volume ));
        end
        --self.deviceData:setDeviceVolume(self.volume);
    end
end

function RWMVolume:onSpeakerButton( _ismute )
    self.isMute = _ismute;
    if self.isMute == true then
        if self.deviceData then
            if self:doWalkTo() then
                ISTimedActionQueue.add(ISRadioAction:new("MuteVolume",self.player, self.device, true ));
            end
        end
        self.volumeBar:setEnableControls(false);
    else
        if self.deviceData then
            if self:doWalkTo() then
                ISTimedActionQueue.add(ISRadioAction:new("UnMuteVolume",self.player, self.device, self.volume~=0 and self.volume or 0.1 ));
            end
        end
        self.volumeBar:setEnableControls(true);
    end
end

function RWMVolume:clear()
    RWMPanel.clear(self);
end

function RWMVolume:readFromObject( _player, _deviceObject, _deviceData, _deviceType )
    RWMPanel.readFromObject(self, _player, _deviceObject, _deviceData, _deviceType );
    self.volume = self.deviceData:getDeviceVolume();
    self.volumeBar:setVolume(math.floor(self.volume*self.volumeBar:getVolumeSteps()));
    if self.deviceData:getIsPortable() and self.deviceData:getIsTelevision()==false then
        self:toggleHeaphoneSupport(true);
    else
        self:toggleHeaphoneSupport(false);
    end

    if self.player then
        self.itemDropBox.mouseEnabled = true;
        self.volumeBar.mouseEnabled = true;
        if JoypadState.players[self.player:getPlayerNum()+1] then
            self.itemDropBox.mouseEnabled = false;
            self.volumeBar.mouseEnabled = false;
        end
    end

    return true;
end

function RWMVolume:update()
    ISPanel.update(self);

    if self.deviceData then
        self.speakerButton:setEnableControls(self.deviceData:getIsTurnedOn());
        self.speakerButton.isMute = self.deviceData:getDeviceVolume()<=0;
        self.volumeBar:setEnableControls(self.deviceData:getIsTurnedOn() and not self.speakerButton.isMute);
        local devVol = self.deviceData:getDeviceVolume()+0.05; --hack for decimal/float precision thingy
        self.volumeBar:setVolume(math.floor(devVol*self.volumeBar:getVolumeSteps()));

        if self.deviceData:getHeadphoneType() >= 0 then
            if self.deviceData:getHeadphoneType() == 0 then
                self.itemDropBox:setStoredItemFake( self.headphonesTex );
            elseif self.deviceData:getHeadphoneType() == 1 then
                self.itemDropBox:setStoredItemFake( self.earbudsTex );
            end
        else
            self.itemDropBox:setStoredItemFake( nil );
        end
    end
end

function RWMVolume:prerender()
    ISPanel.prerender(self);
end


function RWMVolume:render()
    ISPanel.render(self);
end

function RWMVolume:onJoypadDown(button)
    if button == Joypad.AButton then
        --if self.volumeBar:getVolume() < self.volumeBar:getVolumeSteps() then
            self.volumeBar:setVolumeJoypad(true)
        --end
    elseif button == Joypad.BButton then
        --if self.volumeBar:getVolume() > 1 then
            self.volumeBar:setVolumeJoypad(false)
        --end
    elseif button == Joypad.XButton then
        if self.deviceData:getHeadphoneType() >= 0 then
            self:removeHeadphone();
        else
            local tab = {};
            local inventory = self.player:getInventory();
            local list = inventory:FindAll("Base.Headphones");
            if list and list:size()>0 then
                for i=0,list:size()-1 do
                    table.insert(tab, list:get(i));
                end
            end
            list = inventory:FindAll("Base.Earbuds");
            if list and list:size()>0 then
                for i=0,list:size()-1 do
                    table.insert(tab, list:get(i));
                end
            end
            self:addHeadphone( tab );
        end
    elseif button == Joypad.YButton then
        self:onSpeakerButton( not self.speakerButton.isMute );
    end
end

function RWMVolume:getAPrompt()
    return getText("IGUI_RadioVolUp");
end
function RWMVolume:getBPrompt()
    return getText("IGUI_RadioVolDown");
end
function RWMVolume:getXPrompt()
    if self.deviceData:getHeadphoneType() >= 0 then
        return getText("IGUI_RadioRemoveHeadphones");
    else
        local has = false;
        local inventory = self.player:getInventory();
        local list = inventory:FindAll("Base.Headphones");
        if list and list:size()>0 then has = true; end
        if not has then
            list = inventory:FindAll("Base.Earbuds");
            if list and list:size()>0 then has = true; end
        end
        if has then
            return getText("IGUI_RadioAddHeadphones");
        end
    end
    return nil
end
function RWMVolume:getYPrompt()
    if self.speakerButton.isMute then
        return getText("IGUI_RadioUnmuteSpeaker");
    else
        return getText("IGUI_RadioMuteSpeaker");
    end
end


function RWMVolume:new (x, y, width, height)
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
    o.isMute = false;
    o.volume = 6;
    o.headphonesTex = getTexture("Item_Headphones");
    o.earbudsTex = getTexture("Item_Earbuds");
    return o
end


