--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISMoveablesAction = ISBaseTimedAction:derive("ISMoveablesAction")

function ISMoveablesAction:isReachableObjectType()
    local moveProps = self.moveProps;
    local object = moveProps.object;
    local isWall = moveProps.spriteProps:Is("WallNW") or moveProps.spriteProps:Is("WallN") or moveProps.spriteProps:Is("WallW");
    local isWallTrans = moveProps.spriteProps:Is("WallNWTrans") or moveProps.spriteProps:Is("WallNTrans") or moveProps.spriteProps:Is("WallWTrans");
    local isDoor = instanceof(object, "IsoDoor");
    local isWindow = instanceof(object, "IsoWindow") or moveProps.type == "Window";
    local isFence = (instanceof(object, "IsoObject") or instanceof(object, "IsoThumpable")) and object:isHoppable();
    return isWall or isWallTrans or isDoor or isWindow or isFence;
end

function ISMoveablesAction:isValidObject()
    if (not self.square) then return false; end;
    if (not self.moveProps) then return false; end;
    local objects = self.square:getObjects();
    if objects then
        for i = 0, objects:size() - 1 do
            local object = objects:get(i);
            if object and self.moveProps.object == object then
                return true;
            end;
        end;
    end;
    return false;
end

function ISMoveablesAction:isValid()
    local plSquare = self.character:getSquare();
    if (plSquare and self.square) and (plSquare:getZ() == self.square:getZ()) then
        --ensure we can reach the object from here (wall, door, window or fence)
        if self.square:isSomethingTo(plSquare) then
            if (not self:isReachableObjectType()) then
                self:stop();
                return false;
            end;
        end;
        --ensures another action has not destroyed the object first
        if self.mode == "scrap" and (not self:isValidObject()) then
            self:stop();
            return false;
        end;
    else
        self:stop();
        return false;
    end;
    --ensure the player hasn't moved too far away while the action was in queue
    local diffX = math.abs(self.square:getX() + 0.5 - self.character:getX());
    local diffY = math.abs(self.square:getY() + 0.5 - self.character:getY());
    if diffX > 1.6 or diffY > 1.6 then
        self:stop();
        return false;
    end;
    --prevent actions in safehouse for non-members
    if isClient() and SafeHouse.isSafeHouse(self.square, self.character:getUsername(), true) then
        --SafehouseAllowLoot allows picking, placing, rotating
        if self.mode == "place" or self.mode == "pickup" or self.mode == "rotate" then
            if not getServerOptions():getBoolean("SafehouseAllowLoot") then
                self:stop();
                return false;
            end;
        --dismantle is blocked for non-members
        elseif self.mode == "scrap" then
            self:stop();
            return false;
        end;
    end;
    return true;
end

function ISMoveablesAction:waitToStart()
    if self.mode and self.mode=="scrap" and self.moveProps and self.moveProps.object then
        self.character:faceThisObject(self.moveProps.object)
    else
        self.character:faceLocation(self.square:getX(), self.square:getY())
    end
    return self.character:shouldBeTurning()
end

function ISMoveablesAction:update()
    if self.mode and self.mode=="scrap" and self.moveProps and self.moveProps.object then
        self.character:faceThisObject(self.moveProps.object);
    else
        self.character:faceLocation(self.square:getX(), self.square:getY());
    end
    if self.sound and not self.character:getEmitter():isPlaying(self.sound) then
        self:setActionSound();
    end

    self.character:setMetabolicTarget(Metabolics.UsingTools);
end

function ISMoveablesAction:setActionSound()
    if self.mode == "scrap" then
        self.sound = self.moveProps:getScrapSound( self.character );
    else
        self.sound = self.moveProps:getSoundFromTool( self.square, self.character, self.mode );
    end
end

function ISMoveablesAction:start()
    self:setActionSound();
    if self.sound and self.sound ~= 0 then
        --self.sound = sound;
        self.character:stopOrTriggerSound(self.sound);
    end
    if self.mode and self.mode=="scrap" then
		local hc = getCore():getBadHighlitedColor();
		self.moveProps.object:setHighlightColor(hc);
		self.moveProps.object:setHighlighted(true, false);
        local isFloor = self.moveProps and self.moveProps.object and self.moveProps.object:isFloor()
        if self.moveProps and self.moveProps:startScrapAction(self) then
            -- Hack for scrapping curtains
        elseif self.character:hasEquipped("BlowTorch") then
            self:setActionAnim(isFloor and "BlowTorchFloor" or "BlowTorch")
            self:setOverrideHandModels(self.character:getPrimaryHandItem(), nil)
        elseif self.character:hasEquippedTag("Hammer") then
            self:setActionAnim(isFloor and "BuildLow" or "Build")
            self:setOverrideHandModels(self.character:getPrimaryHandItem(), nil)
        else
            self:setActionAnim(CharacterActionAnims.Disassemble);
            self:setOverrideHandModels("Screwdriver", nil);
        end
    end
end

function ISMoveablesAction:stop()
    if self.mode and self.mode=="scrap" then
		self.moveProps.object:setHighlighted(false);
	end
    if self.sound and self.sound ~= 0 then
        self.character:stopOrTriggerSound(self.sound);
    end
    ISBaseTimedAction.stop(self)
end

--[[
-- The moveprops of the new facing (where applies) are always used to perform the actions, the origSpriteName is passed to retrieve the original object from tile or inventory.
 ]]
function ISMoveablesAction:perform()
    if self.mode and self.mode=="scrap" then
		self.moveProps.object:setHighlighted(false);
	end
    if self.sound and self.sound ~= 0 then
        self.character:stopOrTriggerSound(self.sound);
    end

    if self.moveProps and self.moveProps.isMoveable and self.mode and self.mode ~= "scrap" then
        self.moveProps.cursorFacing = self.cursorFacing
        if self.mode == "pickup" then
            self.moveProps:pickUpMoveableViaCursor( self.character, self.square, self.origSpriteName, self.moveCursor ); --OrigSpriteName currently not used in this one.
        elseif self.mode == "place" then
            self.moveProps:placeMoveableViaCursor( self.character, self.square, self.origSpriteName, self.moveCursor );
            buildUtil.setHaveConstruction(self.square, true);
        elseif self.mode == "rotate" then
            self.moveProps:rotateMoveableViaCursor( self.character, self.square, self.origSpriteName, self.moveCursor );
        end
        self.moveProps.cursorFacing = nil
    elseif self.mode and self.mode=="scrap" then
        self.moveProps:scrapObjectViaCursor( self.character, self.square, self.origSpriteName, self.moveCursor );
    end

    ISBaseTimedAction.perform(self)
end

function ISMoveablesAction:new(character, _sq, _moveProps, _mode, _origSpriteName, _moveCursor )
    local o             = {};
    setmetatable(o, self);
    self.__index        = self;
    o.character         = character;
    o.square            = _sq;
    o.origSpriteName    = _origSpriteName;
    o.stopOnWalk        = true;
    o.stopOnRun         = true;
    o.maxTime           = 50;
    o.spriteFrame       = 0;
    o.mode              = _mode;
    o.moveProps         = _moveProps;
    o.moveCursor        = _moveCursor;

    if _moveCursor and (_mode == "place" or _mode == "rotate") and _moveProps:canRotateDirection() then
        o.cursorFacing = _moveCursor.cursorFacing or _moveCursor.joypadFacing
    end

    if ISMoveableDefinitions.cheat then
        o.maxTime = 10;
    else
        if o.moveProps and o.moveProps.isMoveable and _mode and _mode~="rotate" and _mode~= "scrap" then
            o.maxTime = o.moveProps:getActionTime( character, _mode );
        elseif o.moveProps and _mode == "scrap" then
            o.maxTime = o.moveProps:getScrapActionTime( character );
        end
    end
    return o;
end
