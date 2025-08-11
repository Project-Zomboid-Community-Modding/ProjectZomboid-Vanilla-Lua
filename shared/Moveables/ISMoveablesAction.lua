--***********************************************************
--**                    THE INDIE STONE                    **
--**                  Author: turbotutone                  **
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
            if self.square:isDoorTo(plSquare) and self.square:isDoorBlockedTo(plSquare) then
                if (not self:isReachableObjectType()) then
                    self:stop();
                    return false;
                end
            end
        end;
        --ensures another action has not destroyed the object first
        if (self.mode == "scrap" or self.mode == "repair") and (not self:isValidObject()) then
            self:stop();
            return false;
        end;
    else
        self:stop();
        return false;
    end;
    if not ISMoveableDefinitions.cheat then
        --ensure the player hasn't moved too far away while the action was in queue
        local diffX = math.abs(self.square:getX() + 0.5 - self.character:getX());
        local diffY = math.abs(self.square:getY() + 0.5 - self.character:getY());
        if diffX > 1.6 or diffY > 1.6 then
            self:stop();
            return false;
        end;
    end
    --prevent actions in safehouse for non-members
    if isClient() and SafeHouse.isSafeHouse(self.square, self.character:getUsername(), true) then
        --SafehouseAllowLoot allows picking, placing, rotating
        if self.mode == "place" or self.mode == "pickup" or self.mode == "rotate" or self.mode == "repair" then
            if not SafeHouse.isSafehouseAllowLoot(self.square, self.character) then
                self:stop();
                return false;
            end;
        --dismantle is blocked for non-members, but enabled during a war
        elseif self.mode == "scrap" then
            if not SafeHouse.isSafehouseAllowInteract(self.square, self.character) then
                self:stop();
                return false;
            end
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
    if self.mode and (self.mode=="scrap" or self.mode=="repair") and self.moveProps and self.moveProps.object then
        self.character:faceThisObject(self.moveProps.object);
        --[[ Commented out as part of the fix for disassembling TVs -Soul Filcher
		if self.deviceData then
			-- Turn off TV. Fix for SPIF-3373. Also probably good safety practice lol
			local tv = self.deviceData
			if tv:getIsTurnedOn() then
				print("DEBUG: Turning the TV Off.")
				tv:setIsTurnedOn(false)
			end
			local ui = UIManager.getUI()
			for i=0, ui:size()-1 do
				local element = ui:get(i)
				if element:getUIName() == "ISRadioWindow" then
					print("DEBUG: ISRadioWindow element removed.")
					UIManager.RemoveElement(element)
				end
			end
		end ]]--
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
    elseif self.mode == "repair" then
        self.sound = self.moveProps:getRepairSound( self.character );
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
    if self.mode and (self.mode=="scrap" or self.mode=="repair") then
        if self.mode == "scrap" then
            local hc = getCore():getBadHighlitedColor();
            self.moveProps.object:setHighlightColor(self.playerNum, hc);
            self.moveProps.object:setHighlighted(self.playerNum, true, false);
            ISInventoryPage.OnObjectHighlighted(self.playerNum, self.moveProps.object, true)
        end
        local isFloor = self.moveProps and self.moveProps.object and self.moveProps.object:isFloor()
        if self.moveProps and self.mode=="scrap" and self.moveProps:startScrapAction(self) then
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
    if self.moveCursor then
        self.moveCursor:clearCache()
    end
end

function ISMoveablesAction:stop()
    if self.mode and self.mode=="scrap" then
		self.moveProps.object:setHighlighted(self.playerNum, false);
		ISInventoryPage.OnObjectHighlighted(self.playerNum, self.moveProps.object, false)
		if self.deviceData then
            local device = self.deviceData;
            if device:getIsTurnedOn() then
                device:setIsTurnedOn(false);
            end
        end
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
    if self.mode then
        if self.mode=="scrap" then
		    self.moveProps.object:setHighlighted(self.playerNum, false);
		    ISInventoryPage.OnObjectHighlighted(self.playerNum, self.moveProps.object, false)
		end
		if self.mode == "pickup" then
            getSoundManager():playUISound("UIObjectMenuObjectPickup")
        elseif self.mode == "place" then
            getSoundManager():playUISound("UIObjectMenuObjectPlace")
        elseif self.mode == "rotate" then
            getSoundManager():playUISound("UIObjectMenuObjectRotate")
        end
	end

    if self.sound and self.sound ~= 0 then
        self.character:stopOrTriggerSound(self.sound);
    end
    ISMoveableCursor.clearCacheForAllPlayers();
    ISBaseTimedAction.perform(self)
end

function ISMoveablesAction:complete()
    if self.moveProps and self.moveProps.isMoveable and self.mode and self.mode ~= "scrap" and self.mode ~= "repair" then
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
    elseif self.mode and self.mode=="repair" then
        self.moveProps:repairObjectViaCursor( self.character, self.square, self.origSpriteName, self.moveCursor );
    end

    return true;
end

function ISMoveablesAction:getDuration()
    if self.character:isTimedActionInstant() or ISMoveableDefinitions.cheat then
        return 1;
    end
    if self.moveProps and self.moveProps.isMoveable and self.mode and self.mode~="rotate" and self.mode~= "scrap" and self.mode~="repair" then
        return self.moveProps:getActionTime( self.character, self.mode );
    elseif self.moveProps and self.mode == "scrap" then
        return self.moveProps:getScrapActionTime( self.character );
    elseif self.moveProps and self.mode == "repair" then
        return self.moveProps:getRepairActionTime ( self.character );
    end
    return 50
end

function ISMoveablesAction:new(character, square, mode, origSpriteName, object, direction, item, moveCursor )
    local o = ISBaseTimedAction.new(self, character)
    o.playerNum = character:getPlayerNum()
    o.square            = square;
    o.origSpriteName    = origSpriteName;
    o.spriteFrame       = 0;
    o.mode              = mode;
    o.object            = object;
    o.direction         = direction;
    o.item              = item;
    if (o.mode == "pickup") or (o.mode == "scrap") then
        o.moveProps = ISMoveableSpriteProps.fromObject( object );
        if o.moveProps.spriteName ~= origSpriteName then
            --check for attached sprites
            if o.moveProps.spriteProps ~= nil and (o.moveProps.spriteProps:Is("WallNW") or o.moveProps.spriteProps:Is("WallN") or o.moveProps.spriteProps:Is("WallW")) then
                local sprList = object:getChildSprites();
                if sprList then
                    local list_size 	= sprList:size();
                    if list_size > 0 then
                        for i=list_size-1, 0, -1 do
                            local sprite = sprList:get(i):getParentSprite();
                            if sprite:getName() == origSpriteName then
                                o.moveProps = ISMoveableSpriteProps.new( sprite );
                            end;
                        end;
                    end;
                end;
            end;
			if instanceof(o.moveProps.object, "WaveSignalDevice") and o.moveProps.object:getDeviceData() then
				o.deviceData = o.moveProps.object:getDeviceData()
			end
        end
    end
    if (o.mode == "repair") then
        o.moveProps = ISMoveableSpriteProps.fromObjectForRepair( object );
    end
    if o.mode == "place" then
        local worldSpriteName = item:getWorldSprite();
        local worldSprite = getSprite(worldSpriteName); -- this may be any sprite in a sprite grid, we want the sprite at 0,0 in the grid
        if worldSprite ~= nil and worldSprite:getSpriteGrid() ~= nil then
            worldSprite = worldSprite:getSpriteGrid():getSprite(0, 0)
            if worldSprite ~= nil then
                worldSpriteName = worldSprite:getName()
            end
        end
        local _moveProps = ISMoveableSpriteProps.new( worldSpriteName );
        local faces = _moveProps:getFaces();
        if faces[direction] then
            _moveProps = ISMoveableSpriteProps.new( faces[direction] );
        end
        o.moveProps = _moveProps
    end
    if o.mode == "rotate" then
        local _moveProps = ISMoveableSpriteProps.new( object:getSprite():getName() );
        local faces = _moveProps:getFaces();
        if faces[direction] then
            _moveProps = ISMoveableSpriteProps.new( faces[direction] );
        end
        o.moveProps = _moveProps
    end

    o.moveCursor        = moveCursor;
    if isServer() then
        o.moveCursor        = nil;
    end
    o.maxTime           = o:getDuration()

    if moveCursor and (mode == "place" or mode == "rotate") and o.moveProps:canRotateDirection() then
        o.cursorFacing = moveCursor.cursorFacing or moveCursor.joypadFacing
    end
    return o;
end
