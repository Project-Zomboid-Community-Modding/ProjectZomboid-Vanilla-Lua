--***********************************************************
--**                    THE INDIE STONE                    **
--**                      Author: Yuri                     **
--***********************************************************

if isClient() then return end

local TransactionProcessor = {}
local Transactions = {}

Transactions.pickUpMoveable = function(character, item, source, destination, args)
    if item ~= nil or source:getContainerType() ~= ContainerType.IsoObject then
        print('Transactions.pickUpMoveable ERROR item:'..tostring(item)..' character:'..tostring(character)..' source:'..tostring(source)..' destination:'..tostring(destination))
        return;
    end
    local object = source:getObject()
    local moveProps = ISMoveableSpriteProps.fromObject( object );
    moveProps:pickUpMoveableViaCursor( character, object:getSquare(), nil, nil );
end

Transactions.rotateMoveable = function(character, item, source, destination, args)
    if item ~= nil or source:getContainerType() ~= ContainerType.IsoObject then
        print('Transactions.scrapMoveable ERROR character:'..tostring(character)..' source:'..tostring(source)..' destination:'..tostring(destination)..' '..argStr)
        return;
    end
    local object = source:getObject()
    local moveProps = ISMoveableSpriteProps.new( object:getSprite():getName() );
    local faces = moveProps:getFaces();
    moveProps = ISMoveableSpriteProps.new( faces[args.direction] );
    moveProps:rotateMoveableViaCursor( character, object:getSquare(), object:getSprite():getName(), nil );
end

Transactions.scrapMoveable = function(character, item, source, destination, args)
    if item ~= nil or source:getContainerType() ~= ContainerType.IsoObject then
        print('Transactions.scrapMoveable ERROR character:'..tostring(character)..' source:'..tostring(source)..' destination:'..tostring(destination)..' '..argStr)
        return;
    end
    local object = source:getObject()
    local moveProps = ISMoveableSpriteProps.fromObject( object );
    moveProps:scrapObjectViaCursor( character, nil, nil, nil );
end

Transactions.placeMoveable = function(character, item, source, destination, args)
    local object = destination:getObject()
    if instanceof(item, "Moveable") then
        object:setSprite(item:getWorldSprite());
        object:getSprite():setName(item:getWorldSprite())
    end
    local moveProps = ISMoveableSpriteProps.new( item:getWorldSprite() );
    local faces = moveProps:getFaces();
    if faces[args.direction] then
        moveProps = ISMoveableSpriteProps.new( faces[args.direction] );
    end
    moveProps:placeMoveableViaCursor( character, destination:getObject():getSquare(), item:getWorldSprite(), nil );
    buildUtil.setHaveConstruction(destination:getObject():getSquare(), true);
end

Transactions.dropOnFloor = function(character, item, source, destination, args)
    ISTransferAction:transferItem(character, item, source:getContainer(), destination:getContainer(), args.square)
end

TransactionProcessor.OnProcessTransaction = function(action, character, item, source, destination, args)
    if Transactions[action] then
        local argStr = ''
        if args then
            for k,v in pairs(args) do argStr = argStr..' '..k..'='..tostring(v) end
        else
            argStr = '[no args]'
        end
        if getDebug() then
            print('ProcessTransaction action:'..action..' Character:'..tostring(character)..' From:'..tostring(source)..' To:'..tostring(destination)..argStr)
        end
        Transactions[action](character, item, source, destination, args)
    else
        print('OnProcessTransaction ERROR action:'..action..' Character:'..tostring(character)..' From:'..tostring(source)..' To:'..tostring(destination)..argStr)
    end
end

Events.OnProcessTransaction.Add(TransactionProcessor.OnProcessTransaction)
