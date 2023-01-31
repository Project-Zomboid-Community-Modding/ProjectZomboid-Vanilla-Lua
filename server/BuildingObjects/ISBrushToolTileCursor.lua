--***********************************************************
--**                    THE INDIE STONE                    **
--**				    Author: Aiteron				       **
--***********************************************************

ISBrushToolTileCursor = ISBuildingObject:derive("ISBrushToolTileCursor")

function ISBrushToolTileCursor:create(x, y, z, north, sprite)
    local square = getCell():getGridSquare(x, y, z)
    local objs = square:getObjects()

    local tileAlreadyOnSquare = false
    for i=0, objs:size() - 1 do
        if objs:get(i):getSprite() ~= nil and objs:get(i):getSprite():getName() == sprite then
            tileAlreadyOnSquare = true
        end
    end
    if not tileAlreadyOnSquare then
        local props = ISMoveableSpriteProps.new(IsoObject.new(square, sprite):getSprite())
        props.rawWeight = 10
        props:placeMoveableInternal(square, InventoryItemFactory.CreateItem("Base.Plank"), sprite)
    end
end

function ISBrushToolTileCursor:render(x, y, z, square)
    ISBuildingObject.render(self, x, y, z, square)
end

function ISBrushToolTileCursor:new(sprite, northSprite, character)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o:init()
    o:setSprite(sprite)
    o:setNorthSprite(northSprite)
    o.character = character
    o.player = character:getPlayerNum()
    o.isTileCursor = true
    o.spriteName = sprite
    o.noNeedHammer = true
    o.skipBuildAction = true
    o.skipWalk2 = true
    o.canBeAlwaysPlaced = true
    return o
end








