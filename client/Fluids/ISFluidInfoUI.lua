--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

--[[
    UI that can handle transferring fluids between items/objects that have FluidContainers.
--]]

require "ISUI/ISPanel"

ISFluidInfoUI = ISPanel:derive("ISFluidInfoUI");
ISFluidInfoUI.players = {};
ISFluidInfoUI.cheatSkill = false;
ISFluidInfoUI.cheatTransfer = false;

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

-- Container = FluidContainer instance
function ISFluidInfoUI.OpenPanel(_player, _container)
   -- _container = ISFluidContainer:new(_container);

    if not ISFluidUtil.validateContainer(_container) then
        print("FluidInfoUI not a valid (ISFluidContainer) container?")
        return;
    end

    if not _container:isValid() then
        print("FluidInfoUI container nil or has no owner.")
        return;
    end
    if not _player then
        print("FluidInfoUI no valid player.")
        return;
    end
    --print("Opening Fluid Transfer UI");
    local playerNum = _player:getPlayerNum();

    local x = getMouseX() + 10;
    local y = getMouseY() + 10;
    local adjustPos = true;

    if ISFluidInfoUI.players[playerNum] then
        if ISFluidInfoUI.players[playerNum].instance then
            ISFluidInfoUI.players[playerNum].instance:close();
            if ISFluidInfoUI.players[playerNum].x and ISFluidInfoUI.players[playerNum].y then
                x = ISFluidInfoUI.players[playerNum].x;
                y = ISFluidInfoUI.players[playerNum].y;
                adjustPos = false;
            end
        end
    else
        ISFluidInfoUI.players[playerNum] = {};
    end

    local ui = ISFluidInfoUI:new(x,y,400,600, _player, _container);
    ui:initialise();
    ui:instantiate();
    ui:setVisible(true);
    ui:addToUIManager();

    ISFluidInfoUI.players[playerNum].instance = ui;

    --first time open panel and isoobject then middle of screen.
    if adjustPos and ui.isIsoPanel then
        local x = (getCore():getScreenWidth()/2) - (ui:getWidth()/2);
        local y = (getCore():getScreenHeight()/2) - (ui:getHeight()/2);
        ui:setX(x);
        ui:setY(y);
        ISFluidInfoUI.players[playerNum].x = x;
        ISFluidInfoUI.players[playerNum].y = y;
    end
end

-- INIT --
function ISFluidInfoUI:initialise()
    ISPanel.initialise(self);
end

function ISFluidInfoUI:createChildren()
    ISPanel.createChildren(self);

    self.panelText = getText("Fluid_Info_Panel");
    self.panel = ISFluidContainerPanel:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, self.player, self.container, true, true, self.isIsoPanel);
    self.panel.customTitle = self.panelText;
    self.panel:initialise();
    self.panel:instantiate();
    self:addChild(self.panel);

    if self.panel.itemDropBox then
        self.panel.itemDropBox.isLocked = true;
        self.panel.itemDropBox.doInvalidHighlight = false;
        if self.owner then
            self.panel.itemDropBox:setStoredItem( self.owner )
        end
    end

    self.panelX = self.panel:getX();

    local w = self.panel:getWidth();

    local btnText = getText("Fluid_Close");
    self.btnClose = ISButton:new(UI_BORDER_SPACING+1, self.panel:getBottom() + UI_BORDER_SPACING, w, BUTTON_HGT, btnText, self, ISFluidInfoUI.onButton);
    self.btnClose.internal = "CLOSE";
    self.btnClose:initialise();
    self.btnClose:instantiate();
    self.btnClose:enableCancelColor()
    self:addChild(self.btnClose);

    self:setWidth(self.panel:getRight() + UI_BORDER_SPACING + 1);
    self:setHeight(self.btnClose:getBottom() + UI_BORDER_SPACING+1);
    if self.panel:getIsoObjectTextures() then
        self:setHeight(self:getHeight() + 180);
    end
end

function ISFluidInfoUI:prerender()
    ISPanel.prerender(self);
end

function ISFluidInfoUI:render()
end

function ISFluidInfoUI:update()
    --range check for isoPanels.
    if self.isIsoPanel then
        if ISFluidUtil.validateContainer(self.container) and self.owner and self.owner:getSquare() and self.player then
            local square = self.owner:getSquare();
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
    self:setWidth(self.panel.width + UI_BORDER_SPACING*2+2);
    self.btnClose:setWidth(self.panel.width)
end

function ISFluidInfoUI:close()
    if self.player then
        local playerNum = self.player:getPlayerNum();
        if ISFluidInfoUI.players[playerNum] then
            ISFluidInfoUI.players[playerNum].x = self:getX();
            ISFluidInfoUI.players[playerNum].y = self:getY();
        end
    end
    self:setVisible(false);
    self:removeFromUIManager();
end

function ISFluidInfoUI:onButton(_btn)
    if _btn.internal=="CLOSE" then
        self:close()
    end
end

function ISFluidInfoUI:new(x, y, width, height, _player, _container)
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
    o.owner = _container:getOwner();
    o.isIsoPanel = _container:isIsoPanel(); -- instanceof(_container:getOwner(), "IsoObject");
    return o;
end