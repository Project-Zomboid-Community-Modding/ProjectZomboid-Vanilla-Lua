--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 20/06/2023
-- Time: 09:18
-- To change this template use File | Settings | File Templates.
--

require "Foraging/forageSystem";
require "ISUI/ISPanel";
require "Foraging/ISBaseIcon";
ISWorldItemIconTrack = ISBaseIcon:derive("ISWorldItemIconTrack");
-------------------------------------------------
-------------------------------------------------
function ISWorldItemIconTrack:onRightMouseUp()
    ISAnimalTracksMenu.doContextMenu(ISContextMenu.get(self.player, getMouseX(), getMouseY()), self.itemObj, getSpecificPlayer(self.player))
--    print("do context yiha", self.itemObj)
--    return self:doContextMenu();
end;

function ISWorldItemIconTrack:doContextMenu()
    local contextMenu = ISContextMenu.get(self.player, getMouseX(), getMouseY());

--    contextMenu:addOption(getText("ContextMenu_InspectTrack"))
end

function ISWorldItemIconTrack:onRightMouseDown()
    return (self:getIsSeen() and self:getAlpha() > 0);
end;
-------------------------------------------------
-------------------------------------------------
function ISWorldItemIconTrack:doPickup(_x, _y, _contextOption, _targetContainer, _items)
    if _contextOption then _contextOption:hideAndChildren(); end;
    self:getGridSquare();
    if not self.square then return; end;
    self.manager:createIconsForWorldItems(self.square);
    --
    --double clicking sends item to currently selected inventory in panel
    local targetContainer = _targetContainer or getPlayerInventory(self.player).inventory or self.character:getInventory();
    if self.square and luautils.walkAdj(self.character, self.square) then
        local items = _items or {self.itemObj};
        local time = ISWorldObjectContextMenu.grabItemTime(self.character, self.itemObj:getWorldItem());
        for _, itemObj in ipairs(items) do
            if self:isValid() and itemObj and itemObj:getWorldItem() then
                if targetContainer:isItemAllowed(itemObj) then
                    local grabAction = ISGrabItemAction:new(self.character, itemObj:getWorldItem(), time);
                    grabAction.destContainer = targetContainer;
                    ISTimedActionQueue.add(grabAction);
                end;
            end;
        end;
    end;
end
-------------------------------------------------
-------------------------------------------------
function ISWorldItemIconTrack:isValidWorldItem()
    return (self.itemObj and self.itemObj:getWorldItem()) and true or false;
end

function ISWorldItemIconTrack:isValid()
    if self:isInRangeOfPlayer(40) then
        if self.iconClass == "worldObject" then
            if self.itemObj and self.itemObj:getWorldItem() then
                return true;
            else
                for _, itemObj in pairs(self.itemObjTable) do
                    if itemObj and itemObj:getWorldItem() then
                        self.itemObj = itemObj;
                    else
                        self.itemObjTable[itemObj] = nil;
                    end;
                end;
                return self:isValidWorldItem();
            end;
        end;
    end;
    return false;
end
-------------------------------------------------
-------------------------------------------------
function ISWorldItemIconTrack:findPinOffset()
    -- IsoWorldInventoryObjects are 3/4 icon height above the world x,y coords.
    -- ISForageIcon icons are below the world x,y coords.
    if self.itemTexture then
        self.pinOffset = -self.itemTexture:getHeight() * 3 / 4
    end
end
-------------------------------------------------
-------------------------------------------------
function ISWorldItemIconTrack:setWorldMarkerPosition()
    self.worldMarker:setX(self.xCoord);
    self.worldMarker:setY(self.yCoord);
    self.worldMarker:setHomeOnOffsetX(IsoUtils.XToScreen(self.xCoord % 1, self.yCoord % 1, 0, 0));
    self.worldMarker:setHomeOnOffsetY(IsoUtils.YToScreen(self.xCoord % 1, self.yCoord % 1, 0, 0));
end
-------------------------------------------------
-------------------------------------------------
function ISWorldItemIconTrack:checkIsForageable()
    self.isForageable = self:isValid();
    return self.isForageable;
end
-------------------------------------------------
-------------------------------------------------
function ISWorldItemIconTrack:new(_manager, _icon)
    local o = {};
    o = ISBaseIcon:new(_manager, _icon);
    setmetatable(o, self)
    self.__index = self;
--    o.onClickContext = ISWorldItemIconTrack.doPickup;
--    o.onMouseDoubleClick = ISWorldItemIconTrack.doPickup;
    o.iconClass = "worldObject";
    o.isValidSquare = true;
    o.itemObjTable = _icon.itemObjTable;
    o.container = _icon.itemObj:getContainer();
    o.isTrack = true;
--    o.onMouseDoubleClick = ISWorldItemIconTrack.doPickup;
    o:initialise();
    return o;
end


