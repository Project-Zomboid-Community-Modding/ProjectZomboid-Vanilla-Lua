--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISCollapsableWindow"

ISBaseEntityWindow = ISCollapsableWindow:derive("ISBaseEntityWindow");


function ISBaseEntityWindow:initialise()
    ISCollapsableWindow.initialise(self);

    if self.maximumHeightPercent>0 then
        local maxPercent = math.min(self.maximumHeightPercent, 1);
        self.maximumHeight = getCore():getScreenHeight() * maxPercent;
    end
end

function ISBaseEntityWindow:createChildren()
    ISCollapsableWindow.createChildren(self);
end

function ISBaseEntityWindow:createEntityHeader(_xuiSkin, _styleName, _force, _styleIcon, _styleLabel, _styleButton)
    if self.enableHeader or _force then
        self.entityHeader = ISXuiSkin.build(_xuiSkin, _styleName, ISWidgetEntityHeader, 0, 0, 200, 20, self.player, self.entity, self.entityUiStyle, _styleIcon, _styleLabel, _styleButton);
        self.entityHeader:initialise();
        self.entityHeader:instantiate();
        self:addChild(self.entityHeader);
    end
    --return self.entityHeader:getY() + self.entityHeader:getHeight();
end

--[[
function ISBaseEntityWindow:recalculateLayout()
    self.dirtyLayout = false;
end
--]]

function ISBaseEntityWindow:xuiRecalculateLayout(_preferredWidth, _preferredHeight, _force, _anchorRight)
    if self.calculateLayout and ((not self.dirtyLayout) or _force) then
        --print("xuiRecalculateLayout setting dirty state")
        self.xuiPreferredResizeWidth = self.width;
        self.xuiPreferredResizeHeight = self.height;
        self.xuiResizeAnchorRight = _anchorRight;
        if _preferredWidth then
            self.xuiPreferredResizeWidth = _preferredWidth<0 and self.width+_preferredWidth or _preferredWidth;
        end
        if _preferredHeight then
            self.xuiPreferredResizeHeight = _preferredHeight<0 and self.height+_preferredHeight or _preferredHeight;
        end
        self.dirtyLayout = true;
        --self:calculateLayout(self.width, self.height);
    end
end

function ISBaseEntityWindow:prerender()
    self:stayOnSplitScreen();

    if self.dirtyLayout then
        local oldX = self:getX();
        local oldWidth = self:getWidth();
        if self.calculateLayout then self:calculateLayout(self.xuiPreferredResizeWidth, self.xuiPreferredResizeHeight); end
        self.dirtyLayout = false;

        if self.xuiResizeAnchorRight then
            self:setX(oldX - (self:getWidth()-oldWidth))
            self.xuiResizeAnchorRight = false;
        end
    end

    ISCollapsableWindow.prerender(self);
end

--[[
function ISBaseEntityWindow:onResize()

end
--]]

function ISBaseEntityWindow:stayOnSplitScreen()
    ISUIElement.stayOnSplitScreen(self, self.playerNum)
end


function ISBaseEntityWindow:render()
    ISCollapsableWindow.render(self);
end

function ISBaseEntityWindow:update()
    ISCollapsableWindow.update(self);

    local valid = false;

    if self.entity and self.player then
        local dist = self.panelCloseDistance or 10;
        -- in case of IsoObject check distance.
        if self.entity:getGameEntityType()==GameEntityType.IsoObject or self.entity:getGameEntityType()==GameEntityType.VehiclePart then
            --local ex, ey, ez = self.entity:getX(), self.entity:getY(), self.entity:getZ();
            --local px, py, pz = self.player:getX(), self.player:getY(), self.player:getZ();

            if self.player:DistToProper(self.entity) <= dist then
                valid = true;
            end
            --if self.entity:getSquare() and px > ex-dist and px < ex+dist and py > ey-dist and py < ey+dist and ez == pz then
            --    valid = true;
            --end
        else
            valid = true;
        end
        -- check if this player is the using player of the entity.
        -- only one player can access an entity's UI at a time.
        if (not self.entity:getUsingPlayer()) or (self.entity:getUsingPlayer()~=self.player) then
            valid = false;
        end
        -- check to prevent players in vehicles from using this stuff
        if self.player and self.player:getVehicle() then
            valid = false
        end
    else
        valid = false;
    end

    if not valid then
       self:close();
    end
    return valid;
end

function ISBaseEntityWindow:close()
    if self.hasClosedWindowInstance then --to prevent occasional double calling of close due to a call in self.update.
        return;
    end
    self.hasClosedWindowInstance = true;
    ISCollapsableWindow.close(self);
    ISEntityUI.OnCloseWindow(self);
    if JoypadState.players[self.playerNum+1] then
        if self.unfocusRecursive then
            self:unfocusRecursive(getFocusForPlayer(self.playerNum), self.playerNum);
        elseif getFocusForPlayer(self.playerNum)==self then
            setJoypadFocus(self.playerNum, nil);
        end
    end
    if self.entity then
        self.entity:setUsingPlayer(nil);
    end
    self:removeFromUIManager();
end

function ISBaseEntityWindow:validateSizeBounds()
    if (not self.minimumWidth) or self.minimumWidth<0 then self.minimumWidth = 0; end
    if (not self.minimumHeight) or self.minimumHeight<0 then self.minimumHeight = 0; end

    if (not self.maximumWidth) or self.maximumWidth<0 then self.maximumWidth = 0; end
    if (not self.maximumHeight) or self.maximumHeight<0 then self.maximumHeight = 0; end

    if self.maximumWidth>0 and self.maximumWidth<self.minimumWidth then
        self.maximumWidth = self.minimumWidth;
    end
    if self.maximumHeight>0 and self.maximumHeight<self.minimumHeight then
        self.maximumHeight = self.minimumHeight;
    end
end

function ISBaseEntityWindow:isKeyConsumed(key)
    return key == Keyboard.KEY_ESCAPE
end

function ISBaseEntityWindow:onKeyRelease(key)
    if self:isVisible() and (key == Keyboard.KEY_ESCAPE or getCore():isKey("Crafting UI", key)) then
        self:close()
        self:removeFromUIManager();
        return
    end
end

function ISBaseEntityWindow:new(x, y, width, height, player, entity, entityUiStyle)
    local o = ISCollapsableWindow:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self

    o.x = x;
    o.y = y;
    o.player = player;
    o.playerNum = player:getPlayerNum();
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.width = width;
    o.height = height;
    o.anchorLeft = true;
    o.anchorRight = false;
    o.anchorTop = true;
    o.anchorBottom = false;
    o.pin = true;
    o.isCollapsed = false;
    o.collapseCounter = 0;
    o.title = nil;
    --o.resizable = false;
    o.drawFrame = true;

    o.panelCloseDistance = 4;
--     o.panelCloseDistance = 8;
    o.entity = entity;
    o.entityUiStyle = entityUiStyle;

    o.resizable = true;
    o.enableHeader = true;

    o.minimumWidth = 0;
    o.minimumHeight = 0;

    o.maximumWidth = 0;
    o.maximumHeight = 0;

    o.maximumHeightPercent = -1;
    o:setWantKeyEvents(true);

    o.overrideBPrompt = true;
    if o.entity and o.player then
        o.entity:setUsingPlayer(o.player);
    end

    return o
end
