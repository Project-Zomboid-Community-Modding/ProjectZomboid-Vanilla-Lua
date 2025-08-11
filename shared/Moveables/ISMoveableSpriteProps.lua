--***********************************************************
--**                    THE INDIE STONE                    **
--**                  Author: turbotutone                  **
--***********************************************************
IsoGridSquare.ignoreBlockingSprites:add("constructedobjects_signs_01_11")
IsoGridSquare.ignoreBlockingSprites:add("constructedobjects_signs_01_27")

local function predicateBlowTorch(item)
	return item:getType() == "BlowTorch" and item:getCurrentUses() >= 1
end

--test
local function lastIndexOf( _string, _needle)
	local i=_string:match(".*".._needle.."()")
	if i==nil then return nil else return i end
end

local function predicateNotBroken(item)
	return not item:isBroken()
end

--cache tables:
InfoPanelFlags = {};
SpriteGridCache = {}; -- a cache of a spritegrid object on world (stores associated sprites, object, squares)

ISMoveableSpriteProps = {};
ISMoveableSpriteProps.debug = false;
ISMoveableSpriteProps.itemInstances = {};
ISMoveableSpriteProps.multiSpriteFloorRadius = 3;
ISMoveableSpriteProps.ghc = getCore():getGoodHighlitedColor();
ISMoveableSpriteProps.bhc = getCore():getBadHighlitedColor();

function ISMoveableSpriteProps.fromObject( _object )
    local s = ISMoveableSpriteProps.new( _object and _object:getSprite() or nil );

    if s and s.sprite and s.spriteProps and _object then
        s.isFromObject = true;
        s.object = _object;
    end

    -- This is for dismantlable IsoThumpables without moveables properties, like stairs and lamp-on-pillar.
    if not s.canScrap and not s.isMoveable and instanceof(_object, "IsoThumpable") and _object:isDismantable() then
        return ISThumpableSpriteProps.new(_object)
    end;

    return s;
end

function ISMoveableSpriteProps.fromObjectForRepair( _object )
    local s = ISMoveableSpriteProps.new( _object and _object:getSprite() or nil );

    if s and s.sprite and s.spriteProps and _object then
        s.isFromObject = true;
        s.object = _object;
    end

    -- This is for dismantlable IsoThumpables without moveables properties, like stairs and lamp-on-pillar.
    if not s.canScrap and instanceof(_object, "IsoThumpable") and _object:isDismantable() then
        s = ISThumpableSpriteProps.new(_object)
        s.object = _object;
    end

    if not s.canScrap and (instanceof(_object, "IsoThumpable") or instanceof(_object, "IsoDoor") or instanceof(_object, "IsoBarricade")) then
        s = ISThumpableSpriteProps.new(_object)
        s.object = _object;
    end

    return s;
end

function ISMoveableSpriteProps.new( _sprite )
	local sprite = _sprite;
	local s = {}
	setmetatable( s, { __index = ISMoveableSpriteProps } );

	if _sprite == nil then return s end
	
	if type(sprite)=="string" then
		sprite = getSprite( sprite );
	end
	
	if sprite then
        s.sprite                        = sprite;
		local props 					= sprite:getProperties();
		if props then
            s.spriteProps               = props;

			s.spriteName 				= sprite:getName();
			s.blocksPlacement			= props:Is("BlocksPlacement");
			s.isHigh 					= props:Is("IsHigh");
			s.isLow 					= props:Is("IsLow");			
			s.isTable 					= props:Is("IsTable");
			s.isTableTop 				= props:Is("IsTableTop");
			s.isStackable				= props:Is("IsStackable");
			s.isWaterCollector			= props:Is("IsWaterCollector");
            s.material 					= props:Is("Material") and props:Val("Material");
            s.material2 				= props:Is("Material2") and props:Val("Material2")~="Undefined" and props:Val("Material2");
            s.material3 				= props:Is("Material3") and props:Val("Material3")~="Undefined" and props:Val("Material3");

            -- values for scrapping, scrapables are not always valid movables.
            s.canScrap                  = props:Is("CanScrap");
            if s.canScrap then
                if s.material and s.material ~= "Undefined" then
                    s.scrapUseTool      = not props:Is("ScrapUseTool");
                    s.scrapUseSkill     = not props:Is("ScrapUseSkill");
                    s.scrapSize			= props:Val("ScrapSize") or "Medium";
                    s.scrapToolUses     = props:Is("ScrapToolUseOverride") and props:Val("ScrapToolUseOverride");
                    if not s.scrapToolUses or s.scrapToolUses < 0 then
                        if s.scrapSize=="Small" then
                            s.scrapToolUses = 3;
                        elseif s.scrapSize=="Large" then
                            s.scrapToolUses = 10;
                        else -- Medium default
                            s.scrapToolUses = 5;
                        end
                    end
                else
                    s.canScrap = false;
                end
            end

            s.surface                   = props:Is("Surface") and tonumber(props:Val("Surface")) or 0;
            s.surfaceIsOffset           = props:Is("IsSurfaceOffset");
            s.yOffsetCursor             = 0; --render offset used in the movable cursor.
			
			s.isMoveable				= s.spriteName and props:Is("IsMoveAble") or false;
			
			s.facing 					= props:Is("Facing") and props:Val("Facing") or nil;
			s.isoType = props:Is("IsoType") and props:Val("IsoType") or "IsoObject";
			s.groupName					= props:Is("GroupName") and props:Val("GroupName") or nil;
			s.name 						= (s.groupName and (s.groupName .. " ") or "") .. (props:Is("CustomName") and props:Val("CustomName") or "Moveable object");

            if not s.isMoveable and s.canScrap and s.name == "Moveable object" then
                s.name                  = "Scrapable object";
            end

			if s.isMoveable then
                s.customItem            = props:Is("CustomItem") and props:Val("CustomItem") or nil;
				s.type 					= props:Is("MoveType") and props:Val("MoveType") or "Object";
				s.pickUpTool			= props:Is("PickUpTool") and props:Val("PickUpTool")~="None" and props:Val("PickUpTool") or nil;
				s.placeTool				= props:Is("PlaceTool") and props:Val("PlaceTool")~="None" and props:Val("PlaceTool") or nil;
                s.canBreak				= s.pickUpTool and props:Is("CanBreak"); --false; --s.pickUpTool and props:Is("CanBreak"); --can only break uppon tool use
				s.pickUpLevel			= props:Is("PickUpLevel") and tonumber(props:Val("PickUpLevel")) or 0; --0; --props:Is("PickUpLevel") and tonumber(props:Val("PickUpLevel")) or 0;
                s.rawWeight				= props:Is("PickUpWeight") and tonumber(props:Val("PickUpWeight")) or 50;
				s.weight				= s.rawWeight / 10; --0.1; -- s.rawWeight / 10; --props:Is("PickUpWeight") and tonumber(props:Val("PickUpWeight"))/10 or 1.0;
				s.isClosedState			= props:Is("IsClosedState") or false;
				s.Noffset				= props:Is("Noffset") and tonumber(props:Val("Noffset")) or 0;
				s.Soffset				= props:Is("Soffset") and tonumber(props:Val("Soffset")) or 0;
				s.Woffset				= props:Is("Woffset") and tonumber(props:Val("Woffset")) or 0;
				s.Eoffset				= props:Is("Eoffset") and tonumber(props:Val("Eoffset")) or 0;
				s.linkedOffset 			= props:Is("LinkedOffset") and tonumber(props:Val("LinkedOffset")) or 0;
				s.linkedLoc				= props:Is("LinkedLocIs") and props:Val("LinkedLocIs") or nil;
				s.wallOverlay			= props:Is(IsoFlagType.WallOverlay);
                s.ignoreSurfaceSnap     = props:Is("IgnoreSurfaceSnap");
                s.isGridExtensionTile   = props:Is("IsGridExtensionTile");
                s.allowDoorFrame        = props:Is("WallObjectAllowDoorframe");
				if s.wallOverlay then
					if s.type=="WallObject" then		-- is this sprite is walloverlay check if the assigned type is wallobject
						s.type = "WallOverlay";
					else
						s.isMoveable = false;			-- otherwise set this moveable to false;
						print("Error in moveables for sprite '"..tostring(s.spriteName).."', assigned type '"..tostring(s.type).."' does not match sprite overlay state '"..tostring(s.wallOverlay).."'")
					end
                end

                -- normally objects dont have a specific item bound to them so they default to the movable generic and read values like weight and name from the worldsprite props.
                -- however radios for example return a subclass of movable, their setWorldSprite function is overriden so the item values like name and weight only have to be set in items.txt
                -- the movables infopanels, when using the cursor, need to display info from the item instead of the spriteprops as well.
                if s.customItem then
                    local itemInstance = nil;
                    if not ISMoveableSpriteProps.itemInstances[s.customItem] then
                        itemInstance = instanceItem(s.customItem);
                        if itemInstance then
                            ISMoveableSpriteProps.itemInstances[s.customItem] = itemInstance;
                        end
                    else
                        itemInstance = ISMoveableSpriteProps.itemInstances[s.customItem];
                    end
                    if itemInstance then -- Override the following variables:
                        s.name = itemInstance:getName();
                        s.weight = itemInstance:getActualWeight();
                        s.rawWeight = s.weight*10;
                    end
                end

                s.isMultiSprite     = s.sprite:getSpriteGrid()~=nil;
                s.isForceSingleItem = props:Is("ForceSingleItem") or false;
			end
			
			if s.spriteName then
				local index				= lastIndexOf(s.spriteName, "_");
				if index then
					s.sheetName 		= s.spriteName:sub(1, index-1);
					s.spriteID 			= tonumber(s.spriteName:sub(index));
				end
				if s.isMoveable and tostring(s.sheetName)..tostring(s.spriteID) ~= s.spriteName then
					s.isMoveable = false;
				end				
			end
		end
	end
	return s;
end

function ISMoveableSpriteProps:getYOffsetCursor()
    return self.yOffsetCursor;
end

function ISMoveableSpriteProps:instanceItem(_spriteNameOverride)
	if self.isMoveable then
		local item;
        if self.customItem then
            item 	= instanceItem(self.customItem);
        else
            if self.isMultiSprite then
                item 	= instanceItem("Moveables.Moveable");
            else
                item 	= instanceItem("Moveables."..self.spriteName);
            end
        end
        local spriteName = _spriteNameOverride or self.spriteName;
        if self.type == "Window" then                                   -- Some corrections
            if not self.spriteProps:Is("SmashedTileOffset") or self.spriteProps:Val("SmashedTileOffset") == 0 then
                return nil; -- cant instance broken windows
            end
        elseif self.type == "WindowObject" and self.isClosedState then
            spriteName = self.sheetName .. tostring(self.spriteID+4);
        end
		if item and instanceof(item, "Moveable") and item:ReadFromWorldSprite(spriteName) then
			item:setActualWeight(self.weight);
			return item;
		end
		if item and not instanceof(item, "Moveable") then
			return item; -- Base.Sheet
		end
	end
end

function ISMoveableSpriteProps:getFaceDirectionFromSpriteName( _face )
    local face;
    if _face and self.isMoveable and self:hasFaces() then
        for k,v in pairs(self:getFaces()) do
            if v==_face then
                return k;
            end
        end
    end
    return face;
end

function ISMoveableSpriteProps:hasFaces()
    local hasFaces = false;
    if self.isMoveable and self.facing ~= nil then
        local ownFace = self.facing;
        if ownFace~="N" and self.Noffset~=0 then hasFaces = true; end
        if ownFace~="W" and self.Woffset~=0 then hasFaces = true; end
        if ownFace~="S" and self.Soffset~=0 then hasFaces = true; end
        if ownFace~="E" and self.Eoffset~=0 then hasFaces = true; end
    end
    return hasFaces;
end

function ISMoveableSpriteProps:getFaces()
	local d = {};
	if self.isMoveable and self.facing ~= nil then
		local ownFace = self.facing;
		d[ownFace] = self.spriteName;
		if ownFace~="N" and self.Noffset~=0 then d.N = self.sheetName .. tostring( self.spriteID + self.Noffset ); end
		if ownFace~="W" and self.Woffset~=0 then d.W = self.sheetName .. tostring( self.spriteID + self.Woffset ); end
		if ownFace~="S" and self.Soffset~=0 then d.S = self.sheetName .. tostring( self.spriteID + self.Soffset ); end
		if ownFace~="E" and self.Eoffset~=0 then d.E = self.sheetName .. tostring( self.spriteID + self.Eoffset ); end
	end
	return d;
end

-- always returns four indexes for N W S E, if a face is missing will try to replace with face from same axis (NS and WE) otherwise replace with own face. (used for rotation business)
function ISMoveableSpriteProps:getIndexedFaces()
    local d = {};
    if self.isMoveable and self:hasFaces() then
        local ownFace = self.facing;
        local faces = self:getFaces();
        table.insert(d, faces.N or faces.S or ownFace ); -- 1
        table.insert(d, faces.W or faces.E or ownFace ); -- 2
        table.insert(d, faces.S or faces.N or ownFace ); -- 3
        table.insert(d, faces.E or faces.W or ownFace ); -- 4
    end
    return d;
end

function ISMoveableSpriteProps:getFaceIndex()
    for i,sprite in ipairs(self:getIndexedFaces()) do
        if sprite == self.spriteName then
            return i;
        end
    end
    return -1;
end

function ISMoveableSpriteProps:getObjectHealth()
    local matHealth = ISMoveableDefinitions:getInstance().getHealthDefinition( self.material ) or 1.0;
    return self.rawWeight * matHealth;
end

function ISMoveableSpriteProps:getBreakChance( _player )
	if ISMoveableDefinitions.cheat then return 0; end
	if _player and self.isMoveable and self.canBreak and self.pickUpTool then
        local toolDef = ISMoveableDefinitions:getInstance().getToolDefinition( self.pickUpTool ); --ISMoveableSpriteProps.toolDefinitions[self.pickUpTool];
        if toolDef then
            local perkLevel = _player:getPerkLevel(toolDef.perk);
            if self.type == "Window" then
                return 5+((10-perkLevel)*5);
			end
			if not toolDef.perk then
				return 25;
			end
            return (10-perkLevel)*7.5;
        else
            print("Missing tool definition for: "..tostring(self.pickUpTool));
        end
	end
	return 0;
end

-- "Great Cliff which instruments do you want us to break?!?"
function ISMoveableSpriteProps:doBreakTest( _player )
	if self.isMoveable then
		local breakChance = self:getBreakChance( _player );
		if breakChance == 0 then 
			return false; 
		else
			local randomNum = ZombRand(1,101);
			if randomNum <= breakChance then
				return true;
			end
		end
	end
	return false;
end

function ISMoveableSpriteProps:playBreakSound( _character, _object )
    if _character and _object and self.isMoveable and self.canBreak and self.material then
        if instanceof( _object, "IsoThumpable" ) then
            _character:playSound( _object:getBreakSound() )
        elseif self.type == "Vegitation" then
            _character:playSound( "BreakPlant" )
        else
            _character:playSound( IsoThumpable.GetBreakFurnitureSound(_object:getSprite()) )
        end
    end
end

function ISMoveableSpriteProps:addBreakDebris( _square )
	if _square and self.isMoveable and self.canBreak and self.material then
        local materialDefinitions = ISMoveableDefinitions:getInstance().getMaterialDefinition( self.material );
        if materialDefinitions then
            for i,v in ipairs(materialDefinitions) do
                self:addInventoryItemToSquare( _square, v.returnItem, v.maxAmount, v.chancePerRoll );
            end
        end
	end
end

function ISMoveableSpriteProps:addInventoryItemToSquare( _square, _item, _max, _chance )
    if _square and _item and _max and _chance then
        local amount = ZombRand(0,_max+1);
        if amount > 0 then
            for i = 1, amount do
                local randNum = ZombRand(0,101);
                if randNum < _chance then
                    local item 	= instanceItem( _item );
                    if item then
                        _square:AddWorldInventoryItem(item, 0.5, 0.5, 0);
                    end
                end
            end
        end
    end
end

--ISMoveableSpriteProps.toolDefinitions[_name] = { items = _items, perk = _perk, baseActionTime = _baseActionTime, sound = _sound, isWav = _isWav };
-- if pickup or place requires a tool then player gets 5% per carpentry (or customPerk) level speedbonus.
function ISMoveableSpriteProps:getActionTime( _player, _mode )
    if self.isMoveable and _player  and _mode then
        local tool = (_mode=="pickup" and self.pickUpTool) or (_mode=="place" and self.placeTool);
        local toolDef = ISMoveableDefinitions:getInstance().getToolDefinition( tool ); --ISMoveableSpriteProps.toolDefinitions[tool];
        if toolDef then
            local perkLevel = _player:getPerkLevel(toolDef.perk);
            local actionTime = toolDef.baseActionTime + (self.rawWeight*2); --FIXME keep *2 mod on rawweight?
            actionTime = actionTime - (actionTime*(perkLevel*0.05));
            if self.type == "Window" then actionTime = actionTime * 3; end --increased time for windows
            --print("time for this action = "..tostring(actionTime));
            return actionTime;
        end
    end
    --print("default action time");
    return 100;
end

function ISMoveableSpriteProps:hasRequiredSkill( _player, _mode )
	if ISMoveableDefinitions.cheat then return true; end
    if _mode == "scrap" then
        if not _player then return false end
        if not self.canScrap then return false end
        if not self.scrapUseSkill then return false end
        local scrapDef = ISMoveableDefinitions:getInstance().getScrapDefinition(self.material)
        if scrapDef and scrapDef.perk then
            local perkLevel = _player:getPerkLevel(scrapDef.perk)
            return true, scrapDef.perkName, scrapDef.perk
        end
        return false
    end
    if _mode == "repair" then
        if not _player then return false end

        local repairDef = ISMoveableDefinitions:getInstance().getRepairDefinition(self.material);
        local repairDef2 = ISMoveableDefinitions:getInstance().getRepairDefinition(self.material2);
        local repairDef3 = ISMoveableDefinitions:getInstance().getRepairDefinition(self.material3);

        local canRepair = false;
        local repairPerk = nil;
        local repairPerkName = nil;

        if repairDef and repairDef ~= "Undefined" and repairDef.perk then
            local perkLevel = _player:getPerkLevel(repairDef.perk)
            canRepair = true;
            repairPerk = repairDef.perk;
            repairPerkName = repairDef.perkName;
        end

        if canRepair and repairDef2 and repairDef2.perk then
            canRepair = true;
        elseif not repairDef2 and repairDef2 ~= "Undefined" then
            canRepair = false;
            repairPerk = nil;
            repairPerkName = nil;
        end

        if canRepair and repairDef3 and repairDef3.perk then
            canRepair = true;
        elseif not repairDef3 and repairDef3 ~= "Undefined" then
            canRepair = false;
            repairPerk = nil;
            repairPerkName = nil;
        end

        return canRepair, repairPerkName, repairPerk;
    end
    if _player and self.isMoveable and _mode then
        local tool = (_mode=="pickup" and self.pickUpTool) or (_mode=="place" and self.placeTool);
        local toolDef = ISMoveableDefinitions:getInstance().getToolDefinition( tool ); -- ISMoveableSpriteProps.toolDefinitions[self.pickUpTool];
        if toolDef then
            local perkLevel = _player:getPerkLevel(toolDef.perk);
            if self.pickUpLevel > 0 then
                return (perkLevel>=self.pickUpLevel), toolDef.perkName, toolDef.perk;
            end
            return true, toolDef.perkName;
        end
    end
    return true;
end

function ISMoveableSpriteProps:hasTool( _player, _mode )
	if ISMoveableDefinitions.cheat then return true; end
    local tool = (_mode == "pickup" and self.pickUpTool) or (_mode == "place" and self.placeTool);
    if tool and _player then
        local inventory = _player:getInventory();
        local toolDef =  ISMoveableDefinitions:getInstance().getToolDefinition( tool ); -- ISMoveableSpriteProps.toolDefinitions[tool];
        if toolDef then
            for _,v in ipairs(toolDef.items) do
                local item = inventory:getFirstTypeRecurse(v);
                if item then
                    return item;
                end
            end
        end
    end
    return nil
end

function ISMoveableSpriteProps.addLineToInfoTable( _table, _lineA, _rA, _gA, _bA, _lineB, _rB, _gB, _bB)
    local line = {};
    table.insert(line, { txt = _lineA, r = _rA, g = _gA, b = _bA} );
    if _lineB then
        table.insert(line, { txt = _lineB, r = _rB, g = _gB, b = _bB} );
    end
    table.insert( _table, line);
    return _table;
end

local function getColorValues( _bool )
    if _bool then
        return ISMoveableSpriteProps.ghc:getR()*255, ISMoveableSpriteProps.ghc:getG()*255, ISMoveableSpriteProps.ghc:getB()*255;
    end
    return ISMoveableSpriteProps.bhc:getR()*255, ISMoveableSpriteProps.bhc:getG()*255, ISMoveableSpriteProps.bhc:getB()*255;
end

local function resetInfoPanelFlags()
    InfoPanelFlags.debug = nil;
    InfoPanelFlags.name = nil;
    InfoPanelFlags.weight = nil;
    InfoPanelFlags.hasItems = nil;
    InfoPanelFlags.canRotate = nil;
    InfoPanelFlags.hasSkill = nil;
    InfoPanelFlags.nameSkill = nil;
    InfoPanelFlags.perk = nil
    InfoPanelFlags.levelSkill = nil
    InfoPanelFlags.tool = nil;
    InfoPanelFlags.hasTool = nil;
    InfoPanelFlags.toolString = {}; --contains tools, possibly multiple lines (note to self: only first line tool had prefix)
    InfoPanelFlags.tool2 = nil;
    InfoPanelFlags.hasTool2 = nil;
    InfoPanelFlags.tool2String = {};
    InfoPanelFlags.hasRepairParts = nil;
    InfoPanelFlags.partsString = {};
    InfoPanelFlags.scrapChance = nil;
    InfoPanelFlags.repairChance = nil;
    InfoPanelFlags.breakChance = nil;
    InfoPanelFlags.hasCompost = nil;
    InfoPanelFlags.tooHeavy = nil;
    InfoPanelFlags.tooHot = nil;
    InfoPanelFlags.itemsOnSurface = nil;
    InfoPanelFlags.hasWater = nil;
    InfoPanelFlags.notEmpty = nil;
    InfoPanelFlags.doorBarricaded = nil;
    InfoPanelFlags.doorInFrame = nil;
    InfoPanelFlags.floorAtTopOfStairs = nil;
    InfoPanelFlags.windowOpen = nil;
    InfoPanelFlags.windowBarricaded = nil;
    InfoPanelFlags.windowInFrame = nil;
    InfoPanelFlags.needStandingInside = nil;
    InfoPanelFlags.mustPlaceRoomRoof = nil;
    InfoPanelFlags.isOperational = nil; -- for stuff that cant be moved due it being operated (like bbq)
    InfoPanelFlags.removePropane = nil;
end

function ISMoveableSpriteProps:getInfoPanelDescription( _square, _object, _player, _mode )
    local infoTable = {};
    local bR,bG,bB = ISMoveableSpriteProps.bhc:getR()*255, ISMoveableSpriteProps.bhc:getG()*255, ISMoveableSpriteProps.bhc:getB()*255
    local gR,gG,gB = ISMoveableSpriteProps.ghc:getR()*255, ISMoveableSpriteProps.ghc:getG()*255, ISMoveableSpriteProps.ghc:getB()*255
    if _mode == "scrap" and not self.canScrap then
        return ISMoveableSpriteProps.addLineToInfoTable( infoTable, getText("IGUI_NoCanScrap"), bR,bG,bB );
    elseif _mode ~= "scrap" and _mode ~= "repair" and not self.isMoveable then
        return ISMoveableSpriteProps.addLineToInfoTable( infoTable, getText("IGUI_NoMovable"), bR,bG,bB );
    else
        -- debug print
        if ISMoveableSpriteProps.debug then
            infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, "DEBUG", 128, 128, 128 );
            for i=0, self.spriteProps:getPropertyNames():size()-1 do
                local name = self.spriteProps:getPropertyNames():get(i);
                infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, name, 255, 255, 255, tostring(self.spriteProps:Val(name)), gR,gG,gB );
            end
            infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, "END DEBUG", 128, 128, 128 );
        end

        resetInfoPanelFlags();
        self:getInfoPanelFlagsGeneral( _square, _object, _player, _mode );
        if self.isMoveable and self.isMultiSprite then
            local sgrid = self:getSpriteGridInfo(_square, _mode == "pickup" or _mode == "scrap");
            if sgrid then
                for _,gridMember in ipairs(sgrid) do
                    self:getInfoPanelFlagsPerTile( gridMember.square, not gridMember.sprInstance and gridMember.object or nil, _player, _mode );
                end
            end
        else
            self:getInfoPanelFlagsPerTile( _square, _object, _player, _mode );
        end

        --##########################################
        if _object and instanceof(_object, "IsoMannequin") and _object:getMannequinScriptName()
        and (_object:getMannequinScriptName():contains("Scarecrow") or _object:getMannequinScriptName():contains("Skeleton"))
        then infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, getText("IGUI_Name")..":", 255, 255, 255, Translator.getMoveableDisplayName(_object:getMannequinScriptName()), 255, 255, 255 );
        elseif InfoPanelFlags.name then infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, getText("IGUI_Name")..":", 255, 255, 255, Translator.getMoveableDisplayName(InfoPanelFlags.name), 255, 255, 255 ); end

		if instanceof(_object, "IsoObject") and isDebugEnabled() then
			infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, "SCRIPT NAME:", 255, 0, 255, _object:getSprite():getName(), 255, 0, 255 );
		end
		
        if _mode == "repair" then
            --check for supported object types
            if not (instanceof(_object, "IsoThumpable") or instanceof(_object, "IsoDoor") or instanceof(_object, "IsoObject") or instanceof(_object, "IsoBarricade")) then
                return ISMoveableSpriteProps.addLineToInfoTable( infoTable, getText("IGUI_NotRepairable"), bR,bG,bB );
            end;
            local healthPercent = 1 - self:getRepairDamageFactor(_object);
            local damageCheck = {
                [0.95] = getText("IGUI_DamagedObject_Undamaged"),
                [0.80] = getText("IGUI_DamagedObject_Superficial"),
                [0.60] = getText("IGUI_DamagedObject_Minor"),
                [0.40] = getText("IGUI_DamagedObject_Moderate"),
                [0.20] = getText("IGUI_DamagedObject_Almost_Broken"),
                [0.00] = getText("IGUI_DamagedObject_Impossible"),
            };
            for k, v in pairs(damageCheck) do
                if healthPercent >= k then
                    local damage = ColorInfo.new(0, 0, 0, 1)
                    getCore():getBadHighlitedColor():interp(getCore():getGoodHighlitedColor(), healthPercent, damage);
                    infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, getText("IGUI_DamagedObject_Damage_String") .. ":", 255, 255, 255, v, damage:getR()*255,damage:getG()*255,damage:getB()*255 );
                    break;
                end;
            end;
            --if it's undamaged or too damaged there's no need to display the rest
            if healthPercent > 0.95 or healthPercent < 0.20 then return infoTable; end;
        end;

        if InfoPanelFlags.weight then infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, getText("Tooltip_item_Weight")..":", 255, 255, 255, tostring(InfoPanelFlags.weight), 255, 255, 255 ); end

        if InfoPanelFlags.nameSkill then
            local skillText = InfoPanelFlags.nameSkill
            if InfoPanelFlags.levelSkill ~= nil and InfoPanelFlags.levelSkill > 0 then
                skillText = skillText .. " " .. _player:getPerkLevel(InfoPanelFlags.perk) .. "/" .. InfoPanelFlags.levelSkill
            end
            infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, getText("IGUI_Skill")..":", 255, 255, 255, skillText, getColorValues(InfoPanelFlags.hasSkill) );
        end
        if #InfoPanelFlags.toolString > 0 then
            local first = true;
            for _,s in ipairs(InfoPanelFlags.toolString) do
                if first then
                    infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, getText("IGUI_Tool")..":", 255, 255, 255, s, getColorValues(InfoPanelFlags.hasTool) );
                else
                    infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, "", 255, 255, 255, s, getColorValues(InfoPanelFlags.hasTool) );
                end
                first = false;
            end
        else
            infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, getText("IGUI_Tool")..":", 255, 255, 255, getText("IGUI_None"), getColorValues(true) );
        end
        if #InfoPanelFlags.tool2String > 0 then
            local first = true;
            for _,s in ipairs(InfoPanelFlags.tool2String) do
                if first then
                    infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, getText("IGUI_Tool")..":", 255, 255, 255, s, getColorValues(InfoPanelFlags.hasTool2) );
                else
                    infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, "", 255, 255, 255, s, getColorValues(InfoPanelFlags.hasTool2) );
                end
                first = false;
            end
        end
        if #InfoPanelFlags.partsString > 0 then
            local first = true;
            for _,s in ipairs(InfoPanelFlags.partsString) do
                if s.part.required then
                    if first then
                        infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, getText("IGUI_CraftUI_RequiredItems"), 255, 255, 255, s.part.displayName .. ": " .. s.part.amount, getColorValues(s.hasItem) );
                    else
                        infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, "", 255, 255, 255, s.part.displayName .. ": " .. s.part.amount, getColorValues(s.hasItem) );
                    end
                    first = false;
                end;
            end;
            first = true;
            for _,s in ipairs(InfoPanelFlags.partsString) do
                if not s.part.required then
                    if first then
                        infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, getText("IGUI_CraftUI_OneOf"), 255, 255, 255, s.part.displayName .. ": " .. s.part.amount, getColorValues(s.hasItem) );
                    else
                        infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, "", 255, 255, 255, s.part.displayName .. ": " .. s.part.amount, getColorValues(s.hasItem) );
                    end;
                    first = false;
                end;
            end;
        end;
        if InfoPanelFlags.scrapChance then
            local chance = ColorInfo.new(0, 0, 0, 1)
            getCore():getBadHighlitedColor():interp(getCore():getGoodHighlitedColor(), InfoPanelFlags.scrapChance/100, chance);
            infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, getText("Tooltip_Chance"), 255, 255, 255, tostring(InfoPanelFlags.scrapChance), chance:getR()*255,chance:getG()*255,chance:getB()*255 );
        end
        if InfoPanelFlags.repairChance then
            local chance = ColorInfo.new(0, 0, 0, 1)
            getCore():getBadHighlitedColor():interp(getCore():getGoodHighlitedColor(), InfoPanelFlags.repairChance/100, chance);
            infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, getText("Tooltip_Chance"), 255, 255, 255, tostring(InfoPanelFlags.repairChance), chance:getR()*255,chance:getG()*255,chance:getB()*255 );
        end
        if InfoPanelFlags.breakChance then
            local chance = ColorInfo.new(0, 0, 0, 1)
            getCore():getGoodHighlitedColor():interp(getCore():getBadHighlitedColor(), InfoPanelFlags.breakChance/100, chance);
            infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, getText("IGUI_ChanceToBreak")..":", 255, 255, 255, tostring(InfoPanelFlags.breakChance), chance:getR()*255,chance:getG()*255,chance:getB()*255 );
        end
        if InfoPanelFlags.hasItems then
            infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, "- "..getText("IGUI_ItemsInContainer"), bR,bG,bB );
        end
        if InfoPanelFlags.canRotate~=nil then
            if InfoPanelFlags.canRotate then infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, getText("IGUI_CanRotate"), gR,gG,gB );
            else infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, getText("IGUI_CanNotRotate"), bR,bG,bB ); end
        end
        if InfoPanelFlags.hasCompost then infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, "- "..getText("IGUI_ComposterHasCompost"), bR,bG,bB ); end
        if InfoPanelFlags.tooHeavy then infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, "- "..getText("IGUI_ToHeavy"), bR,bG,bB ); end
        if InfoPanelFlags.tooHot then infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, "- "..getText("IGUI_TooHot"), bR,bG,bB ); end
        if InfoPanelFlags.itemsOnSurface then infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, "- "..getText("IGUI_ItemsSurface"), bR,bG,bB ); end
        if InfoPanelFlags.hasWater then infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, "- "..getText("IGUI_RainCollectorHasWater"), bR,bG,bB ); end
        if InfoPanelFlags.notEmpty then infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, "- "..getText("IGUI_MovableHasMaterial"), bR,bG,bB ); end
        if InfoPanelFlags.doorBarricaded then infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, "- "..getText("IGUI_Moveables_DoorBarricaded"), bR,bG,bB ); end
        if InfoPanelFlags.doorInFrame then infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, "- "..getText("IGUI_Moveables_DoorInFrame"), bR,bG,bB ); end
        if InfoPanelFlags.floorAtTopOfStairs then infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, "- "..getText("IGUI_Moveables_FloorAtTopOfStairs"), bR,bG,bB ); end
        if InfoPanelFlags.windowOpen then infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, "- "..getText("IGUI_WindowOpen"), bR,bG,bB ); end
        if InfoPanelFlags.windowBarricaded then infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, "- "..getText("IGUI_WindowBarricaded"), bR,bG,bB ); end
        if InfoPanelFlags.windowInFrame then infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, "- "..getText("IGUI_Moveables_WindowInFrame"), bR,bG,bB ); end
        if InfoPanelFlags.needStandingInside then infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, "- "..getText("IGUI_NeedToBeStandingInside"), bR,bG,bB ); end
        if InfoPanelFlags.mustPlaceRoomRoof then infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, "- "..getText("IGUI_MustPlaceRoomRoof"), bR,bG,bB ); end
        if InfoPanelFlags.isOperational then infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, "- "..getText("IGUI_IsOperational"), bR,bG,bB ); end
        if InfoPanelFlags.removePropane then infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, "- "..getText("IGUI_RemovePropane"), bR,bG,bB ); end
        --##########################################
        return infoTable;
    end
end

function ISMoveableSpriteProps:getToolString( _itemTypes, _itemNames )
    local toolString = {}
    local addedNames = {}
    for k,v in ipairs(_itemTypes) do
        if not addedNames[_itemNames[v]] then
            addedNames[_itemNames[v]] = true
            table.insert(toolString, _itemNames[v])
        end
    end
    table.sort(toolString, function(a,b) return not string.sort(a, b) end)
    return toolString
end

function ISMoveableSpriteProps:getPartsString( _inventory, _parts )
    local partsString = {}
    local addedRequired = {}
    local addedOptional = {}
    for _, part in ipairs(_parts) do
        if (part.required and not addedRequired[part.displayName]) or (not part.required and not addedOptional[part.displayName]) then
            --some parts have a threshold in order to be required, such as hinges and knobs
            if part.required then
                addedRequired[part.displayName] = true;
            else
                addedOptional[part.displayName] = true;
            end;
            table.insert(partsString, {part = part, hasItem = self:checkForRepairPart(_inventory, part.itemType, part.amount)});
        end;
    end;
    table.sort(partsString, function(a,b) return not string.sort(a.part.displayName, b.part.displayName) end);
    return partsString;
end

function ISMoveableSpriteProps:getAllRepairParts()
    local partTypes = {};
    local damageFactor, objectCount = self:getRepairDamageFactor(self.object);
    self:getRepairPartsForMaterial(self.material, partTypes, damageFactor, objectCount);
    self:getRepairPartsForMaterial(self.material2, partTypes, damageFactor, objectCount);
    self:getRepairPartsForMaterial(self.material3, partTypes, damageFactor, objectCount);
    --update amount for object count
    for _, part in ipairs(partTypes) do
        part.amount = (part.amount * objectCount);
    end;
    return partTypes;
end

function ISMoveableSpriteProps:getRepairPartsForMaterial( _material, _partTable, _damageFactor, _objectCount )
    if _material and _material ~= "Undefined" then
        local repairDef = ISMoveableDefinitions:getInstance().getRepairDefinition( _material )
        local partTypes = repairDef and repairDef.parts or nil;
        if partTypes and #partTypes > 0 then
            for _, part in ipairs(partTypes) do
                --filter out damage optional parts (doorknobs, hinges) when under threshold value
                if (not part.damageAmount) or _damageFactor >= part.damageAmount  then
                    local updatedEntry = false;
                    --check if it's in the table already, avoid adding multiple times
                    for __, part2 in ipairs(_partTable) do
                        if part.itemType == part2.itemType then
                            --it may match but still be an optional part
                            if part.required == part2.required then
                                --requires different amount based on damage
                                part2.amount = math.floor(part2.amount + (math.max(part.amount * _damageFactor, 1)));
                                updatedEntry = true;
                                break;
                            end;
                        end;
                    end;
                    --not in the table, add the part - use a copy because we may update "amount" for existing entries
                    if not updatedEntry then
                        local partCopy = copyTable(part);
                        --requires different amount based on damage and object count
                        partCopy.amount = math.floor(math.max(partCopy.amount * _damageFactor, 1));
                        table.insert(_partTable, partCopy);
                    end;
                end;
            end;
        end;
    end;
    return _partTable;
end

function ISMoveableSpriteProps:getInfoPanelFlagsGeneral( _square, _object, _player, _mode )
    InfoPanelFlags.name = self.name;
    InfoPanelFlags.weight = self.weight and tostring(round(self.weight, 3)) or nil;
    if _mode and _mode == "rotate" then
        InfoPanelFlags.canRotate = self:canManuallyRotate();
    end
    local hasSkill, nameSkill, perk = self:hasRequiredSkill( _player, _mode );
    if nameSkill then
        InfoPanelFlags.hasSkill = hasSkill;
        InfoPanelFlags.nameSkill = nameSkill;
        InfoPanelFlags.perk = perk
        InfoPanelFlags.levelSkill = self.pickUpLevel
    end
    if _mode == "scrap" then
        InfoPanelFlags.weight = nil
        InfoPanelFlags.levelSkill = nil
        if self.scrapUseTool then
            local scrapDef = ISMoveableDefinitions:getInstance().getScrapDefinition( self.material )
            local toolTypes = scrapDef and scrapDef.tools or nil
            if toolTypes and #toolTypes > 0 then
                InfoPanelFlags.toolString = self:getToolString( toolTypes, scrapDef.toolNames )
                InfoPanelFlags.hasTool = self:hasScrapTool( _player, false )
            end
            toolTypes = scrapDef and scrapDef.tools2 or nil
            if toolTypes and #toolTypes > 0 then
                InfoPanelFlags.tool2String = self:getToolString( toolTypes, scrapDef.toolNames )
                InfoPanelFlags.hasTool2 = self:hasScrapTool( _player, true )
            end
        end
        local result,chance,perkName = self:canScrapObject( _player )
        if chance > 0 then
            InfoPanelFlags.scrapChance = chance
        end
    elseif _mode == "repair" then
        InfoPanelFlags.weight = nil
        InfoPanelFlags.levelSkill = nil
        local repairDef = ISMoveableDefinitions:getInstance().getRepairDefinition( self.material )
        local toolTypes = repairDef and repairDef.tools or nil
        if toolTypes and #toolTypes > 0 then
            InfoPanelFlags.toolString = self:getToolString( toolTypes, repairDef.toolNames )
            InfoPanelFlags.hasTool = self:hasRepairTool( _player, false )
        end
        toolTypes = repairDef and repairDef.tools2 or nil
        if toolTypes and #toolTypes > 0 then
            InfoPanelFlags.tool2String = self:getToolString( toolTypes, repairDef.toolNames )
            InfoPanelFlags.hasTool2 = self:hasRepairTool( _player, true )
        end
        --for repairing, only the primary material defines the tools, but all of the materials parts are required
        local partTypes = self:getAllRepairParts();
        if #partTypes > 0 then
            InfoPanelFlags.partsString = self:getPartsString( _player:getInventory(), partTypes )
            InfoPanelFlags.hasRepairParts = self:hasRepairParts ( _player )
        end
        local result,chance,perkName = self:canRepairObject( _player )
        if chance > 0 then
            InfoPanelFlags.repairChance = chance
        end
    else
        InfoPanelFlags.tool = (_mode == "pickup" and self.pickUpTool) or (_mode == "place" and self.placeTool) or nil;
        InfoPanelFlags.hasTool = self:hasTool( _player, _mode );
        if InfoPanelFlags.tool then
            local toolDef = ISMoveableDefinitions:getInstance().getToolDefinition( InfoPanelFlags.tool )
            if toolDef then
                InfoPanelFlags.toolString = self:getToolString( toolDef.items, toolDef.itemNames )
            else
                table.insert(InfoPanelFlags.toolString, InfoPanelFlags.tool)
            end
        end
    end
    if _mode and _mode =="pickup" then
        local breakChance = self:getBreakChance( _player );
		if breakChance > 0 then
            InfoPanelFlags.breakChance = breakChance;
        end
    end
end

function ISMoveableSpriteProps:getInfoPanelFlagsPerTile( _square, _object, _player, _mode )
    InfoPanelFlags.hasItems = InfoPanelFlags.hasItems or (_object and instanceof(_object,"IsoObject") and not _object:isObjectNoContainerOrEmpty());

    if _mode == "rotate" and self:canRotateDirection() then
        InfoPanelFlags.hasItems = false
    end

    if self.type=="WindowObject" then
        InfoPanelFlags.needStandingInside = _player:getSquare() and _player:getSquare():Is(IsoFlagType.exterior);
    end

    if _mode and _mode =="pickup" then
        --print("pickup test", self:getTopTable(_square), _object)
        InfoPanelFlags.tooHeavy = InfoPanelFlags.tooHeavy or (not _player:getInventory():hasRoomFor(_player, self.weight));
        InfoPanelFlags.itemsOnSurface = InfoPanelFlags.itemsOnSurface or ((self.isTable and _square:Is("IsTableTop")) or (self.isTable and _object and _object ~= self:getTopTable(_square)));
        InfoPanelFlags.hasWater = InfoPanelFlags.hasWater or (self.isWaterCollector and _object and _object:hasFluid());
        
        if self.type == "Window" then
            InfoPanelFlags.windowOpen = InfoPanelFlags.windowOpen or (_object and instanceof(_object,"IsoWindow") and _object:IsOpen());
            InfoPanelFlags.windowBarricaded = InfoPanelFlags.windowBarricaded or (_object and instanceof(_object,"IsoWindow") and _object:isBarricaded());
        end

        if instanceof(_object, "IsoBarbecue") then
            InfoPanelFlags.isOperational = InfoPanelFlags.isOperational or _object:isLit();
            InfoPanelFlags.removePropane = InfoPanelFlags.removePropane or _object:hasPropaneTank();
        end

        if instanceof(_object, "IsoCompost") then
            InfoPanelFlags.hasCompost = InfoPanelFlags.hasCompost or (_object and _object:getCompost() > 0);
        end

        if instanceof(_object, "IsoFireplace") then
            InfoPanelFlags.tooHot = InfoPanelFlags.tooHot or (_object and (_object:isLit() or _object:isSmouldering()));
        end
    end

    if _mode and _mode =="place" then
        if self.type=="WindowObject" then
            InfoPanelFlags.mustPlaceRoomRoof = InfoPanelFlags.mustPlaceRoomRoof or (_square:Is(IsoFlagType.exterior));
        end
    end
    if _mode == "scrap" or _mode == "repair" then
        InfoPanelFlags.itemsOnSurface = InfoPanelFlags.itemsOnSurface or ((self.isTable and _square:Is("IsTableTop")) or (self.isTable and _object and _object ~= self:getTopTable(_square)));
        InfoPanelFlags.hasWater = InfoPanelFlags.hasWater or (self.isWaterCollector and _object and _object:hasFluid());
        InfoPanelFlags.doorBarricaded = InfoPanelFlags.doorBarricaded or (_object and instanceof(_object,"IsoDoor") and _object:isBarricaded());
        InfoPanelFlags.doorBarricaded = InfoPanelFlags.doorBarricaded or (_object and instanceof(_object,"IsoThumpable") and _object:isDoor() and _object:isBarricaded());
        InfoPanelFlags.doorInFrame = InfoPanelFlags.doorInFrame or (_object and instanceof(_object,"IsoThumpable") and _object:isDoorFrame() and _square:getDoor(_object:getNorth()));
        InfoPanelFlags.floorAtTopOfStairs = InfoPanelFlags.floorAtTopOfStairs or self:isFloorAtTopOfStairs(_object);
        InfoPanelFlags.windowInFrame = InfoPanelFlags.windowInFrame or (instanceof(_object,"IsoThumpable") and _object:isWindow() and _square:getWindow(_object:getNorth()))
	end
	
	if ISMoveableDefinitions.cheat then
		InfoPanelFlags.hasItems = false;
		InfoPanelFlags.tooHeavy = false;
	end
end

-- returns the moveable object if found on square, in case of wall overlays returns the wallobject and overlay spriteinstance.
function ISMoveableSpriteProps:findOnSquare( _square, _spriteName )
    if _square and _spriteName then
        for i = _square:getObjects():size(),1,-1 do
            local obj = _square:getObjects():get(i-1);
            if obj:getSprite() then
                local objSprite = obj:getSprite();
                local props = objSprite:getProperties();
                if objSprite:getName() and objSprite:getName() == _spriteName then
                    return obj;
                elseif props and (props:Is("WallNW") or props:Is("WallN") or props:Is("WallW")) then
                    local sprList = obj:getChildSprites();
                    if sprList and sprList:size() > 0 then
                        for j=sprList:size()-1, 0, -1 do
                            local sprite = sprList:get(j):getParentSprite();
                            if sprite and sprite:getName() and sprite:getName() == _spriteName then
                                return obj, sprList:get(j);
                            end
                        end
                    end
                end
            end
        end
    end
end

-- Finds the moveable defined by _spriteName in inventory
function ISMoveableSpriteProps:findInInventory( _character, _spriteName )
    if _character and _spriteName then
        local items 			= _character:getInventory():getItems();
        local items_size 		= items:size();
        for i=0,items_size-1, 1 do
            local item = items:get(i);
            if instanceof(item, "Moveable") and item:getWorldSprite() then
                if _character:getPrimaryHandItem() ~= item and _character:getSecondaryHandItem() ~= item then
                    if (item:getWorldSprite() == _spriteName) then
                        return item;
                    else
                        local worldSprite = getSprite(item:getWorldSprite());
                        if worldSprite and worldSprite:getSpriteGrid() and worldSprite:getSpriteGrid():getAnchorSprite() and worldSprite:getSpriteGrid():getAnchorSprite():getName() == _spriteName then
                            return item;
                        end
                    end
                end
            end
        end
    end
end

function ISMoveableSpriteProps:getObjectMoveProps( _obj )
    if _obj then
        local sprite = _obj:getSprite();
        if sprite then
            local moveProps = ISMoveableSpriteProps.new( sprite );
            if moveProps.isMoveable then
                return moveProps;
            end
        end
    end
end

function ISMoveableSpriteProps:isFreeTile( _square )
    if not _square or (_square:Is("BlocksPlacement") and not _square:Is(IsoFlagType.canBeRemoved)) or _square:Is(IsoFlagType.canBeCut) or _square:Is("tree")
--             or _square:Is(IsoFlagType.doorN) or _square:Is(IsoFlagType.doorW) --prevent placement of objects next to doors
--             or (_square:getTileInDirection(IsoDirections.S) and _square:getTileInDirection(IsoDirections.S):Is(IsoFlagType.doorN))
--             or (_square:getTileInDirection(IsoDirections.E) and _square:getTileInDirection(IsoDirections.E):Is(IsoFlagType.doorW))
             then
        return false;
    end
    return true;
end

-- with verify bool it ONLY checks if the current spritegridcache is correct, otherwise it will update the spritegridcache table
-- returns a bool if spritegrid is correct
-- for pick up actions _getWorldObjects can be set to include worldobjects
function ISMoveableSpriteProps:getSpriteGridCache( _square, _verifyOnly, _getWorldObjects )
    if not _verifyOnly then SpriteGridCache = {}; end

    if self.isMoveable and self.isMultiSprite then
        local spriteGrid = self.sprite:getSpriteGrid();
        if not spriteGrid then return false; end

        local sX = _square:getX() - spriteGrid:getSpriteGridPosX(self.sprite);
        local sY = _square:getY() - spriteGrid:getSpriteGridPosY(self.sprite);
        local sZ = _square:getZ();

        local index = 1;
        for x=0,spriteGrid:getWidth()-1 do
            for y=0,spriteGrid:getHeight()-1 do
                local square = getCell():getGridSquare(sX+x, sY+y, sZ);
                local spriteForPos = spriteGrid:getSprite(x, y);

                if _verifyOnly and not SpriteGridCache[index] then
                    return false;
                end

                local obj = false;
                local sprInstance = nil;
                if _getWorldObjects then
                    obj, sprInstance = self:findOnSquare( square, spriteForPos:getName() );
                    if not obj then
                        createTile(spriteForPos:getName(), square)      -- On map some objects can miss tiles (like tent), so we generate missing tile obj.
                        obj, sprInstance = self:findOnSquare( square, spriteForPos:getName() );
                        if not obj then
                            return false;
                        end
                    end
                end
                if not _verifyOnly then
                    table.insert(SpriteGridCache, { square = square, object = obj, sprInstance = sprInstance, sprite = spriteForPos, x = x, y = y } );
                else
                    if (SpriteGridCache[index].square ~= square
                            or SpriteGridCache[index].sprite ~= spriteForPos
                            or SpriteGridCache[index].x ~= x
                            or SpriteGridCache[index].y ~= y) then
                        return false;                        
                    end
                    if _getWorldObjects and (SpriteGridCache[index].object ~= obj or SpriteGridCache[index].sprInstance ~= sprInstance) then
                        return false;
                    end
                end

                --[[
                local foundObj = false;
                if _getWorldObjects then
                    for i = square:getObjects():size(),1,-1 do
                        local obj = square:getObjects():get(i-1);
                        if obj:getSprite() == spriteForPos then
                            foundObj = obj;
                            break;
                        end
                    end
                end

                if _getWorldObjects and not foundObj then
                    return false;
                else
                    if not _verifyOnly then
                        table.insert(SpriteGridCache, { square = square, object = foundObj, sprite = spriteForPos, x = x, y = y } );
                    else
                        if not SpriteGridCache[index].square == square and SpriteGridCache[index].object == foundObj and SpriteGridCache[index].sprite == spriteForPos and SpriteGridCache[index].x == x and SpriteGridCache[index].y == y then
                            return false;
                        end
                    end
                end
                --]]
                index = index + 1;
            end
        end
        return true;
    end
    return false;
end

-- returns SpriteGridCache, updates cache table only on change.
function ISMoveableSpriteProps:getSpriteGridInfo( _square, _getWorldObjects )
    if self:getSpriteGridCache( _square, true, _getWorldObjects ) or self:getSpriteGridCache( _square, false, _getWorldObjects ) then
        return SpriteGridCache;
    end
end

--in case of wall objects, _object is not passed (nil)
function ISMoveableSpriteProps:canPickUpMoveable( _character, _square, _object )
    --print("MultiSprite movable CanPickUp test")
	if ISMoveableDefinitions.cheat then
		self.yOffsetCursor = _object and _object:getRenderYOffset() or 0;
		return true;
	end
    if self.isMoveable and self.isMultiSprite then
        local sgrid = self:getSpriteGridInfo(_square, true);
        if not sgrid then return false; end
        --print("take 2")
        for _,gridMember in ipairs(sgrid) do
            if not self:canPickUpMoveableInternal( _character, gridMember.square, not gridMember.sprInstance and gridMember.object or nil, true ) then
                return false;
            end
        end
        --print("returning true")
        return true;
    else
        return self:canPickUpMoveableInternal( _character, _square, _object, false );
    end
end

function ISMoveableSpriteProps:canPickUpMoveableInternal( _character, _square, _object, _isMulti )
    local canPickUp = false;
    if self.isMoveable and instanceof(_square,"IsoGridSquare") then
        canPickUp = not _object and true or _object:isObjectNoContainerOrEmpty();
        if not _isMulti and canPickUp then
            canPickUp = _character:getInventory():hasRoomFor(_character, self.weight);
        end
        if canPickUp and self.isTable then
            canPickUp = not _square:Is("IsTableTop") and _object == self:getTopTable(_square);
        end
        self.yOffsetCursor = _object and _object:getRenderYOffset() or 0;

        if canPickUp and self.isWaterCollector then
            if _object and _object:hasFluid() then
                canPickUp = false
            end
        end
        
        if canPickUp and self.type == "Window" then
            if _object and instanceof(_object,"IsoWindow") then
                canPickUp = _object:isDestroyed() or (not _object:IsOpen());        -- only allow pickup when destroyed or closed (destroyed will remove window no return item)
                if _object:isBarricaded() then
                    canPickUp = false
                end
            else
                canPickUp = false;
            end
        end

        if canPickUp and self.type == "WindowObject" then
            if _character:getSquare() and _character:getSquare():Is(IsoFlagType.exterior) then
                canPickUp = false;
            end
        end

        if canPickUp and self.isoType == "IsoMannequin" then
            canPickUp = true;
        end

        if canPickUp and instanceof(_object, "IsoBarbecue") then
            canPickUp = not _object:isLit() and not _object:hasPropaneTank();
        end

        if canPickUp and instanceof(_object, "IsoFireplace") then
            canPickUp = not (_object:isLit() or _object:isSmouldering());
        end

        if canPickUp and _character and instanceof(_character,"IsoGameCharacter") then
            local hasSKill, _ = self:hasRequiredSkill( _character, "pickup" );
            local hasTool = not self.pickUpTool and true or self:hasTool( _character, "pickup" );
            canPickUp = hasSKill and hasTool;
        end
    end
    return canPickUp;
end

function ISMoveableSpriteProps:pickUpMoveableViaCursor( _character, _square, _origSpriteName, _moveCursor )
    self:pickUpMoveable(_character, _square, true);
    if _moveCursor then
        _moveCursor:clearCache()
    end
end

function ISMoveableSpriteProps:pickUpMoveable( _character, _square, _createItem, _forceAllow )
    if self.isMoveable and instanceof(_character,"IsoGameCharacter") and instanceof(_square,"IsoGridSquare") then
        local obj, sprInstance = self:findOnSquare( _square, self.spriteName );
        local items = {};
        if obj and (_forceAllow or _character:isMovablesCheat() or ISMoveableDefinitions.cheat or self:canPickUpMoveable( _character, _square, not sprInstance and obj or nil )) then
            if self.isMultiSprite then
                local sgrid = self:getSpriteGridInfo(_square, true);
                if not sgrid then return false; end

                local createItem = _createItem and not self.isForceSingleItem;
                for _,gridMember in ipairs(sgrid) do
                    table.insert(items, self:pickUpMoveableInternal( _character, gridMember.square, gridMember.object, gridMember.sprInstance, gridMember.sprite:getName(), createItem, _forceAllow ));
                end

                if _createItem and self.isForceSingleItem then
                    local spriteGrid = self.sprite:getSpriteGrid();
                    if not spriteGrid then return false; end

                    local item 	= self:instanceItem(spriteGrid:getAnchorSprite():getName());
                    if instanceof(obj, "IsoThumpable") then
                        self:saveThumpableParameters(item:getModData(), obj);
                    end
                    _character:getInventory():AddItem(item);
                    sendAddItemToContainer(_character:getInventory(), item);
                end
            else
                --local obj, sprInstance = self:findOnSquare( _square, self.spriteName );
                self:pickUpMoveableInternal( _character, _square, obj, sprInstance, self.spriteName, _createItem, _forceAllow );
            end
            return items;
        end
    end
end

function ISMoveableSpriteProps:saveThumpableParameters(_table, _object)
    _table.name = _object:getName() or ""
    _table.health = _object:getHealth()
    _table.maxHealth = _object:getMaxHealth()
    _table.thumpSound = _object:getThumpSound()
    _table.color = _object:getCustomColor()
    if _object:getLightSourceRadius() > 0 then
        _table.lightSource = {
            radius = _object:getLightSourceRadius(),
            xoffset = _object:getLightSourceXOffset(),
            yoffset = _object:getLightSourceYOffset(),
            life = _object:getLifeLeft(),
            fuel = _object:getLightSourceFuel(),
        }
    end
    if _object:hasModData() then
        _table.modData = copyTable(_object:getModData())
    end
end

function ISMoveableSpriteProps:pickUpMoveableInternal( _character, _square, _object, _sprInstance, _spriteName, _createItem, _rotating )
    --if _object and self:canPickUpMoveable( _character, _square, not _sprInstance and _object or nil ) then
    local objIsIsoWindow = self.type == "Window" and instanceof(_object,"IsoWindow");
    local item 	= self:instanceItem(_spriteName);

    if item or (objIsIsoWindow and _object:isDestroyed()) then      -- destroyed windows return nil for instanceItem()
        GameEntityFactory.TransferComponents(_object, item);

        local windowGotSmashed = false;
        if not objIsIsoWindow or not _object:isDestroyed() then     -- when its a destroyed window skip this
            if not _rotating and self:doBreakTest( _character ) then
                if self.type ~= "Window" then
                    self:playBreakSound( _character, _object );
                    self:addBreakDebris( _square );
                elseif objIsIsoWindow then
                    if not _object:isDestroyed() then               -- in case of a window, when it breaks and isnt broken yet smash it, leaves no debris.
                        _object:smashWindow();
                        windowGotSmashed = true;
                    end
                end
            elseif item then
                if instanceof(_object, "IsoThumpable") then
                    self:saveThumpableParameters(item:getModData(), _object);
                else
                    if _object:hasModData() and _object:getModData().movableData then
                        item:getModData().movableData = copyTable(_object:getModData().movableData)
                    end

                    if _object:hasModData() and _object:getModData().itemCondition then
                        item:setConditionMax(_object:getModData().itemCondition.max);
                        item:setCondition(_object:getModData().itemCondition.value);
                    end

                    if instanceof(_object, "IsoStove") and _object:isBroken() then
                        item:setCondition(0);
                    end
                end
                if _createItem then
                    if self.isMultiSprite then
                        _square:AddWorldInventoryItem(item, ZombRandFloat(0.1,0.9), ZombRandFloat(0.1,0.9), 0);
                    else
                        _character:getInventory():AddItem(item);        -- add the item if it aint got broken
                        sendAddItemToContainer(_character:getInventory(), item);
                    end
                end
            end
        end

        -- custom/modified light info (custom bulb, use battery etc) for the various lamps can by copied to movable item and retrieved uppon placing;
        if instanceof(_object,"IsoLightSwitch") and _sprInstance==nil then
            _object:setCustomSettingsToItem(item);
            --item:getLightSettings(obj);
        end

        if instanceof(_object, "IsoMannequin") then
            _object:setCustomSettingsToItem(item)
        end

        -- Remove stuff from the world
        if self.type == "WallOverlay" then
            -- A Mirror on the east or south edge of a square.
            if _object:getSprite() and _spriteName and (_object:getSprite():getName() == _spriteName) then
                triggerEvent("OnObjectAboutToBeRemoved", _object) -- Hack for RainCollectorBarrel, Trap, etc
                _square:transmitRemoveItemFromSquare(_object)
            elseif _sprInstance then
                local sprList = _object:getChildSprites();
                local sprIndex = sprList and sprList:indexOf(_sprInstance) or -1
                if sprIndex == -1 then
                else
                    _object:RemoveAttachedAnim(sprIndex)
                    if isClient() then _object:transmitUpdatedSpriteToServer() end
                end
            end
        elseif self.type == "FloorTile" then
            local moveableDefinitions = ISMoveableDefinitions:getInstance();
            if moveableDefinitions and moveableDefinitions.floorReplaceSprites then
                local repSprs = moveableDefinitions.floorReplaceSprites;
                local floor = _square:getFloor();
                local spr = getSprite( repSprs[ ZombRand(1,#repSprs) ] );
                if floor and spr then
                    floor:setSprite(spr);
                    if isClient() then floor:transmitUpdatedSpriteToServer(); end --:transmitCompleteItemToServer(); end
                end
            end
        elseif self.isoType == "IsoBrokenGlass" then
            -- add random damage to hands if no gloves
            if not _character:getClothingItem_Hands() and ZombRand(3) == 0 then
                local handPart = _character:getBodyDamage():getBodyPart(BodyPartType.FromIndex(ZombRand(BodyPartType.ToIndex(BodyPartType.Hand_L),BodyPartType.ToIndex(BodyPartType.Hand_R) + 1)))
                handPart:setScratched(true, true);
                -- possible glass in hands
                if ZombRand(5) == 0 then
                    handPart:setHaveGlass(true);
                end
            end
            triggerEvent("OnObjectAboutToBeRemoved", _object)
            _square:transmitRemoveItemFromSquare(_object)
        elseif self.isoType == "IsoFeedingTrough" then
            triggerEvent("OnObjectAboutToBeRemoved", _object)
            _square:transmitRemoveItemFromSquare(_object)
        elseif self.type == "Window" then
            if objIsIsoWindow and not windowGotSmashed then
                if isClient() then _square:transmitRemoveItemFromSquare(_object) end
                _square:RemoveTileObject(_object);
            end
        elseif not _sprInstance then --Objects, Vegitation, WallObjects etc
            if self.isoType == "IsoRadio" or self.isoType == "IsoTelevision" then
                if instanceof(_object,"IsoWaveSignal") then
                    local deviceData = _object:getDeviceData();
                    if deviceData then
                        item:setDeviceData(deviceData);
                    else
                        print("Warning: device data missing?>?")
                    end
                end
            end

            if self.spriteProps and self.spriteProps:Is(IsoFlagType.waterPiped) and _spriteName ~= "camping_01_16" then
                -- empty water on pickup
                if item:getFluidContainer() ~= nil then
                    item:getFluidContainer():Empty();
                end
            end

            triggerEvent("OnObjectAboutToBeRemoved", _object) -- Hack for RainCollectorBarrel, Trap, etc
            _square:transmitRemoveItemFromSquare(_object)
        end
        _square:RecalcProperties();
        _square:RecalcAllWithNeighbours(true);

        --ISMoveableCursor.clearCacheForAllPlayers();

        triggerEvent("OnContainerUpdate")

        IsoGenerator.updateGenerator(_square)
        return item;
    end
    --end
end

function ISMoveableSpriteProps:getTopTable( _square )
    if not instanceof(_square, "IsoGridSquare") then return nil end
    for i = _square:getObjects():size(),1,-1 do
        local obj = _square:getObjects():get(i-1)
        local sprite = obj:getSprite()
        if sprite and sprite:getProperties() then
            local props = sprite:getProperties()
--            print("check item ", obj:getSprite():getName(), props:Is("IsTable"), props:Is("Surface"), tonumber(props:Val("Surface")))
            if props:Is("IsTable") and props:Is("Surface") and tonumber(props:Val("Surface")) then
--                print("return ", obj)
                return obj
            end
        end
    end
    return nil
end

function ISMoveableSpriteProps:getTotalTableHeight( _square )
    local obj = self:getTopTable(_square)
    if not obj then return 0 end
    local props = obj:getSprite():getProperties()
    return obj:getRenderYOffset() + tonumber(props:Val("Surface"))
end

-- Finds the moveable defined by _spriteName in inventory
function ISMoveableSpriteProps:findInInventoryMultiSprite( _character, _spriteName )
    if _character and _spriteName then
        local items 			= _character:getInventory():getItems();
        local items_size 		= items:size();
        for i=0,items_size-1, 1 do
            local item = items:get(i);
            if instanceof(item, "Moveable") and self.customItem and (item:getFullType() == self.customItem) and (item:getName() == self.name) then
                return item, _character:getInventory();
            end
            if instanceof(item, "Moveable") and item:getCustomNameFull() then
                if _character:getPrimaryHandItem() ~= item and _character:getSecondaryHandItem() ~= item then
                    if item:getCustomNameFull() == _spriteName then
                        return item, _character:getInventory();
                    end
                end
            end
        end

        local radius = ISMoveableSpriteProps.multiSpriteFloorRadius;
        local square = _character:getSquare();
        if square then
            --print("try find square ".._spriteName);
            local sx,sy,sz = square:getX(), square:getY(), square:getZ();
            for x = sx-radius,sx+radius do
                for y = sy-radius,sy+radius do
                    --print(" test "..tostring(x)..":"..tostring(y)..":"..tostring(sz));
                    local sq = getCell():getGridSquare(x,y,sz);
                    if sq and sq:getWorldObjects() then
                        local items 			= sq:getWorldObjects();
                        local items_size 		= items:size();
                        for i=0,items_size-1, 1 do
                            if instanceof(items:get(i), "IsoWorldInventoryObject") then
                                local item = items:get(i):getItem();
                                if instanceof(item, "Moveable") and self.customItem and (item:getFullType() == self.customItem) and (item:getName() == self.name) then
                                    return item, "floor";
                                end
                                if item and instanceof(item, "Moveable") and item:getCustomNameFull() then
                                    if item:getCustomNameFull() == _spriteName then
                                        return item, "floor";
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

    end
end

function ISMoveableSpriteProps:canPlaceMoveable( _character, _square, _item )
    if _square:Is(IsoFlagType.water) then
        return false;
    end;

    if self.isMoveable and self.isMultiSprite then
        local spriteGrid = self.sprite:getSpriteGrid();
        if not spriteGrid then return false; end

        local sX = _square:getX() - spriteGrid:getSpriteGridPosX(self.sprite);
        local sY = _square:getY() - spriteGrid:getSpriteGridPosY(self.sprite);
        local sZ = _square:getZ();

        local square = getCell():getGridSquare(sX, sY, sZ);


        local sgrid = self:getSpriteGridInfo(square, false);
        if not sgrid then return false; end

        if not self.isForceSingleItem then
            local max = spriteGrid:getSpriteCount();
            for i,gridMember in ipairs(sgrid) do
                local item, container = self:findInInventoryMultiSprite( _character, self.name .. " (" .. i .. "/" .. max .. ")" ); -- gridMember.sprite:getName() );
                --[[
                if not item or not item:getWorldSprite() then
                    return false;
                end
                local elementProps = ISMoveableSpriteProps.new( item:getWorldSprite() );
                print("is extension tile: "..tostring(elementProps.isGridExtensionTile));
                if not elementProps or not self:canPlaceMoveableInternal( _character, gridMember.square, item, elementProps.isGridExtensionTile ) then
                    return false;
                end
                --]]
                if not item or not self:canPlaceMoveableInternal( _character, gridMember.square, item ) then
                    return false;
                end
                if container and container=="floor" then
                    local radius = ISMoveableSpriteProps.multiSpriteFloorRadius-1;
                    if radius < 1 then radius = 1 end;
                    if _square:getX() < _character:getX()-(radius+1) or _square:getX() > _character:getX()+radius then
                        return false;
                    end
                    if _square:getY() < _character:getY()-(radius+1) or _square:getY() > _character:getY()+radius then
                        return false;
                    end
                end
            end
        else
            --if self.sprite ~= spriteGrid:getAnchorSprite() then
                --return false;
            --end
            local item = self:findInInventoryMultiSprite( _character, self.name .. " (1/1)" );--self:findInInventory( _character, spriteGrid:getAnchorSprite():getName() );
            for i,gridMember in ipairs(sgrid) do
                if not item or not self:canPlaceMoveableInternal( _character, gridMember.square, item ) then
                    return false;
                end
            end
        end

        -- Check for wall-like things between squares
        if self:isWallBetweenParts(spriteGrid, sX, sY, sZ) then
            return false
        end

        return true;
    else
        return self:canPlaceMoveableInternal( _character, _square, _item );
    end
end

function ISMoveableSpriteProps:isWallBetweenParts( _spriteGrid, _x, _y, _z )
    for x = 1,_spriteGrid:getWidth() do
        for y = 1,_spriteGrid:getHeight() do
            local square = getCell():getGridSquare(_x + x - 1, _y + y - 1, _z)
            if square and _spriteGrid:getSprite(x - 1, y - 1) then
                if x < _spriteGrid:getWidth() then
                    local sqE = getCell():getGridSquare(square:getX() + 1, square:getY(), square:getZ())
                    if sqE and square:isSomethingTo(sqE) then
                        return true
                    end
                end
                if y < _spriteGrid:getHeight() then
                    local sqS = getCell():getGridSquare(square:getX(), square:getY() + 1, square:getZ())
                    if sqS and square:isSomethingTo(sqS) then
                        return true
                    end
                end
            end
        end
    end
    return false
end

function ISMoveableSpriteProps:isSquareAtTopOfStairs( _square )
    if not _square then return false end
    local x,y,z = _square:getX(),_square:getY(),_square:getZ()
    if z == 0 then return false end

    local belowEast = getCell():getGridSquare(x+1, y, z-1)
    if belowEast and belowEast:Has(IsoObjectType.stairsTW) then return true end

    local belowSouth = getCell():getGridSquare(x, y+1, z-1)
    if belowSouth and belowSouth:Has(IsoObjectType.stairsTN) then return true end

    return false
end

function ISMoveableSpriteProps:canPlaceMoveableInternal( _character, _square, _item, _forceTypeObject )
    local canPlace = false;
    if _square and _square:isVehicleIntersecting() then return false end
    if self.isMoveable then
        local hasTileFloor = _square and _square:getFloor();
        if not hasTileFloor and self.type ~= "Window" then
            return false;
        end

        if self.type == "Object" or _forceTypeObject then
            if self.isTableTop then
                --canPlace = _square:Is("IsTable") and not _square:Is("IsTableTop");			-- if the object is a tabletop then see if sq has table and no tabletop obj
                local currentSurface = self:getTotalTableHeight(_square);
                if _square:Is("IsTable") then
                    canPlace = not _square:Is("IsTableTop") and (currentSurface <= 64);
                else
                    canPlace = self.blocksPlacement and self:isFreeTile( _square ); -- if not a table present and item is tabletop, check if item has blocksplacement flag wich allows placing on floor (ommits stuff like sinks being placed on floors)
                end
                -- incase of table set the yoffset for cursor rendering
                if self.surface and self.surfaceIsOffset then
                    currentSurface = currentSurface - self.surface;
                end
                self.yOffsetCursor = currentSurface;
            elseif self:isFreeTile( _square ) then
                canPlace = true;
                if _square:Is("IsHigh") then
                    canPlace = self.isLow;							-- if theres a high object (on wall or so) then check if item is low
                end
                if _square:Is("IsLow") and not _square:Is(IsoFlagType.canBeRemoved) then
                    canPlace = self.isHigh;						-- if theres a low object then check if item is high (this probably is never or rarely a reality, added just in case)
                end
            elseif self.isStackable and self.isTable and self.surface and _square:Is("IsTable") and not _square:Is("IsTableTop") and not _square:Is("IsHigh") then
                local totalTableHeight = self:getTotalTableHeight(_square)
                if totalTableHeight + self.surface <= 96 then
                    canPlace = true
                end
                self.yOffsetCursor = totalTableHeight
            end
            if self:isSquareAtTopOfStairs(_square) then
                canPlace = false
            end
        elseif self.type == "WallObject" then
            --print("testing wall object");
            if self.allowDoorFrame then --self.name=="Exit Sign" then
                canPlace = self.facing and self:getWallForFacing( _square, self.facing, "WallAndDoor" ); -- self:hasFaces() and self:getWallForFacing( _square, self.facing, "WallAndDoor" );
            else
                --print("has faces: "..tostring(self.facing))
                --print("getwallforface "..tostring(self:getWallForFacing( _square, self.facing ) or "nil"))
                canPlace = self.facing and self:getWallForFacing( _square, self.facing );
            end
            if canPlace then
                --print("canplace")
                for i = 0, _square:getObjects():size()-1 do
                    local obj = _square:getObjects():get(i);
                    local sprite = obj:getSprite();
                    if sprite and sprite:getProperties() then
                        local props = sprite:getProperties();
                        if props then
                            if props:Is("MoveType") and props:Val("MoveType") == "WallObject" then
                                if props:Is("Facing") and props:Val("Facing") == self.facing then
                                    if (not props:Is("IsHigh")) and (not props:Is("IsLow")) then
                                        canPlace = false;
                                    elseif props:Is("IsHigh") and self.isHigh then
                                        canPlace = false;
                                    elseif props:Is("IsLow") and self.isLow then
                                        canPlace = false;
                                    end
                                end
                            elseif props:Is("BlocksPlacement") then
                                if (not props:Is("IsHigh")) and (not props:Is("IsLow")) then
                                    canPlace = false;
                                elseif props:Is("IsHigh") and self.isHigh then
                                    canPlace = false;
                                elseif props:Is("IsLow") and self.isLow then
                                    canPlace = false;
                                end
                            end
                        end
                        -- Some moveable objects such as mirrors are child sprites of a wall.
                        local sprList = obj:getChildSprites()
                        if canPlace and sprList then
                            for j=1,sprList:size() do
                                sprite = sprList:get(j-1):getParentSprite()
                                props = sprite:getProperties()
                                if props then
                                    if props:Is("MoveType") and props:Val("MoveType") == "WallObject" then
                                        if props:Is("Facing") and props:Val("Facing") == self.facing then
                                            if (not props:Is("IsHigh")) and (not props:Is("IsLow")) then
                                                canPlace = false;
                                            elseif props:Is("IsHigh") and self.isHigh then
                                                canPlace = false;
                                            elseif props:Is("IsLow") and self.isLow then
                                                canPlace = false;
                                            end
                                        end
                                    elseif props:Is("BlocksPlacement") then
                                        if (not props:Is("IsHigh")) and (not props:Is("IsLow")) then
                                            canPlace = false;
                                        elseif props:Is("IsHigh") and self.isHigh then
                                            canPlace = false;
                                        elseif props:Is("IsLow") and self.isLow then
                                            canPlace = false;
                                        end
                                    end
                                end
                                if not canPlace then
                                    break
                                end
                            end
                        end
                        if not canPlace then
                            --print("CANNOT PLACE");
                            break;
                        end
                    end
                end
            end
        elseif self.type == "WallOverlay" then
            local wall = self:getWallForFacing( _square, self.facing );
            if wall then
                canPlace =  not self:getMoveableOverlayFromObject( wall );                          --FIXME - check for wall objects? or leave like this (currently allows for weird placement however in certain situations allows you to do cool stuff
            end                                                                                     --FIXME - like placing mirrors above counters then adding a wall counter creates awesome bar look :D)
        elseif self.type == "FloorTile" then
            if hasTileFloor and hasTileFloor:getSprite() and hasTileFloor:getSprite():getName() then
                local fspr = hasTileFloor:getSprite():getName();
                local moveableDefinitions = ISMoveableDefinitions:getInstance();
                if moveableDefinitions.isFloorReplaceSprite( fspr ) then
                    canPlace = true;
                end
            end
        elseif self.type == "FloorRug" then
            canPlace = true;
            if not _square or _square:Is(IsoFlagType.canBeCut) or _square:Is("tree") then
                canPlace = false;
            end
            if canPlace then
                for i = 0, _square:getObjects():size()-1 do
                    local obj = _square:getObjects():get(i);
                    local sprite = obj:getSprite();
                    if sprite and sprite:getProperties() then
                        local props = sprite:getProperties();
                        if props then
                            if props:Is("MoveType") and props:Val("MoveType") == "FloorRug" then
                                canPlace = false;
                                break;
                            end
                        end
                    end
                end
            end
        elseif self.type == "Vegitation" then
            local sqTexName 	= _square:getFloor() and _square:getFloor():getSprite() and _square:getFloor():getSprite():getName() or false;
            if sqTexName and ( string.sub(sqTexName, 1, string.len("blends_natural")) == "blends_natural" ) then
                canPlace = self:isFreeTile( _square );
            end
        elseif self.type == "WindowObject" then
            canPlace = self:hasFaces() and self:getWallForFacing( _square, self.facing, "WindowFrame" );
            if canPlace then
                if _square:Is(IsoFlagType.exterior) or (_character:getSquare() and _character:getSquare():Is(IsoFlagType.exterior)) then
                    canPlace = false;
                end
            end
            if canPlace then
                for i = 0, _square:getObjects():size()-1 do
                    local obj = _square:getObjects():get(i);
                    local sprite = obj:getSprite();
                    if sprite and sprite:getProperties() then
                        local props = sprite:getProperties();
                        if props then
                            if props:Is("MoveType") and props:Val("MoveType") == "WindowObject" then
                                if props:Is("Facing") and props:Val("Facing") == self.facing then
                                    canPlace = false;
                                    break;
                                end
                            end
                        end
                    end
                    -- Forbid placing furniture-curtain on sheet-curtain.
                    if instanceof(obj, "IsoCurtain") then
                        if self.facing == "S" and obj:getType() == IsoObjectType.curtainN then
                            canPlace = false
                            break
                        end
                        if self.facing == "N" and obj:getType() == IsoObjectType.curtainS then
                            canPlace = false
                            break
                        end
                        if self.facing == "E" and obj:getType() == IsoObjectType.curtainW then
                            canPlace = false
                            break
                        end
                        if self.facing == "W" and obj:getType() == IsoObjectType.curtainE then
                            canPlace = false
                            break
                        end
                    end
                end
            end
        elseif self.type == "Window" then
            local isNorth = (self:hasFaces() and self.facing == "N" or self.facing == "S") or false;
            local wallFrame = self:getWallForFacing( _square, isNorth and "S" or "E", "WindowFrame" );
            if wallFrame then
                local window    = _square:getWindow(isNorth);
                canPlace = not window;
--[[
                if window and window:getSprite() and window:getSprite():getName() then
                    if ((not isNorth) and window:getSprite():getName() == "walls_special_01_8") or (isNorth and window:getSprite():getName() == "walls_special_01_9") then
                        canPlace = true;
                    end
                end
--]]
            end
        end

        if canPlace and _character and instanceof(_character, "IsoPlayer") then
			if not ISMoveableDefinitions.cheat and not _character:isMovablesCheat() then
				local hasSKill, _ = self:hasRequiredSkill( _character, "place" );
				local hasTool = not self.placeTool and true or self:hasTool( _character, "place" );
				canPlace = hasSKill and hasTool;
			end
        end
    end
    return canPlace;
end

function ISMoveableSpriteProps:placeMoveableViaCursor( _character, _square, _origSpriteName, _moveCursor )
    self:placeMoveable(_character, _square, _origSpriteName );
    if _moveCursor then
        _moveCursor:clearCache()
    end
end

function ISMoveableSpriteProps:placeMoveable( _character, _square, _origSpriteName )
    if self.isMoveable and instanceof(_character,"IsoGameCharacter") and instanceof(_square,"IsoGridSquare") then
        if self.isMultiSprite then
            local spriteGrid = self.sprite:getSpriteGrid();
            if not spriteGrid then return false; end

            local sgrid = self:getSpriteGridInfo(_square, false);
            if not sgrid then return false; end

            if not self.isForceSingleItem then
                local max = spriteGrid:getSpriteCount();
                local items = {};
                for i,gridMember in ipairs(sgrid) do
                    local item, container = self:findInInventoryMultiSprite( _character, self.name .. " (" .. i .. "/" .. max .. ")" );
                    --[[
                    if not item or not item:getWorldSprite() then
                        return false;
                    end
                    local elementProps = ISMoveableSpriteProps.new( item:getWorldSprite() );
                    if not elementProps or not self:canPlaceMoveableInternal( _character, gridMember.square, item, elementProps.isGridExtensionTile ) then
                        return false;
                    end
                    --]]
                    --local item = self:findInInventory( _character, gridMember.sprite:getName() );
                    if not item or not self:canPlaceMoveableInternal( _character, gridMember.square, item ) then
                        return false;
                    end
                    items[i] = {item, container};
                end
                for i,gridMember in ipairs(sgrid) do
                    local item, inventory = items[i][1], items[i][2];
                    self:placeMoveableInternal(  gridMember.square, item, gridMember.sprite:getName() );

                    if inventory=="floor" then
                        if item:getWorldItem() ~= nil then
                            item:getWorldItem():getSquare():transmitRemoveItemFromSquare(item:getWorldItem());
                            item:getWorldItem():getSquare():removeWorldObject(item:getWorldItem());
                            item:setWorldItem(nil);
                        end
                    else
                        inventory:Remove(item);
                        sendRemoveItemFromContainer(inventory, item);
                    end
                    --items[i][2]:Remove(items[i][1]);
                    --_character:getInventory():Remove(items[i]);
                end
            else
                --if self.sprite == spriteGrid:getAnchorSprite() then
                    local item = self:findInInventoryMultiSprite( _character, self.name .. " (1/1)" ); --self:findInInventory( _character, spriteGrid:getAnchorSprite():getName() );
                    if item then
                        for i,gridMember in ipairs(sgrid) do
                            if not self:canPlaceMoveableInternal( _character, gridMember.square, item ) then
                                return false;
                            end
                        end
                        for i,gridMember in ipairs(sgrid) do
                            local gridItem = self:instanceItem(gridMember.sprite:getName());
                            if gridMember.sprite == spriteGrid:getAnchorSprite() then
                                gridItem = item;
                            end
                            self:placeMoveableInternal(  gridMember.square, gridItem, gridMember.sprite:getName() )
                        end

                        _character:getInventory():Remove(item);
                        sendRemoveItemFromContainer(_character:getInventory(), item);
                    end
                --end
            end

            ISMoveableCursor.clearCacheForAllPlayers();
        else
            local item = self:findInInventory( _character, _origSpriteName );
            if item  and self:canPlaceMoveableInternal( _character, _square, item ) then
                self:placeMoveableInternal( _square, item, self.spriteName )
                _character:getInventory():Remove(item);
                sendRemoveItemFromContainer(_character:getInventory(), item);
                ISMoveableCursor.clearCacheForAllPlayers();
            end
        end
    end
end

local function getNameAndNumFromSpriteName(name)
    local len = string.len(name)
    local num = nil
    local strName = nil
    for i = len, 1, -1 do
        local sub = string.sub(name, i, i)
        if sub == "_" then
            strName = string.sub(name, 1, i-1)
            num = tonumber(string.sub(name, i+1, len))
            break
        end
    end
    return strName, num
end

function ISMoveableSpriteProps:placeMoveableInternal( _square, _item, _spriteName )
    local obj;
    local north         = self.facing and (self.facing=="N" or self.facing=="S");
    --local hasTileFloor  = _square and _square:getFloor();
    local insertIndex   = _square:getObjects() and _square:getObjects():size();
    local removeList    = {}; -- table used to remove objects after place (due to insertIndex)
    local TileIsoObjectType = getSprite( _spriteName ):getType()

    -- Place under IsoWorldInventoryObjects
    if insertIndex and insertIndex > 0 then
        local objects = _square:getObjects()
        for i=objects:size(),1,-1 do
            if not instanceof(objects:get(i-1), "IsoWorldInventoryObject") then
                insertIndex = i
                break
            end
        end
    end

    if self.isoType == "IsoObject" and self.isoType ~= getSprite( _spriteName ):getProperties():Val("IsoType") and getSprite( _spriteName ):getProperties():Val("IsoType") ~= nil then
        self.isoType = getSprite( _spriteName ):getProperties():Val("IsoType")
    end

    self.container = getSprite( _spriteName ):getProperties():Is("container") and getSprite( _spriteName ):getProperties():Val("container") or nil

    if self.type=="WallOverlay" then
        local wall = self:getWallForFacing( _square, self.facing );
        if wall and (self.facing == "W" or self.facing == "N") then
            -- The actual wall is on the adjacent square to the east or south.
            obj = IsoObject.new( getCell(), _square, getSprite(_spriteName) );
        elseif wall then
            wall:AttachExistingAnim(getSprite(_spriteName), 0, 0, false, 0, false, 0)
            --[[
            local overlay = getSprite(self.spriteName):newInstance();
            local sprList = wall:getChildSprites() or ArrayList.new();
            sprList:add( overlay );
            wall:setChildSprites( sprList );
            --]]
            if isClient() then wall:transmitUpdatedSpriteToServer() end
        end
    elseif self.type=="FloorTile" then
        local spr = getSprite( _spriteName ); --item:getWorldSprite() );
        if not _square:Is(IsoFlagType.water) then
            local floor = _square:getFloor();
            if floor and spr then
                floor:setSprite(spr);
                if isClient() then floor:transmitUpdatedSpriteToServer(); end
            end
        end
    elseif TileIsoObjectType == IsoObjectType.tree then
        local temp = IsoTree.new(_square, getSprite(_spriteName))
        _square:AddTileObject(temp)
        if isClient() then temp:transmitCompleteItemToServer(); end
        triggerEvent("OnObjectAdded", temp)
    elseif self.type=="Window" then
        obj = IsoWindow.new( getCell(), _square, getSprite( _spriteName ), north );
        obj:setIsLocked(false)

        local wallFrame = self:getWallForFacing( _square, north and "S" or "E", "WindowFrame" );
        local objects = _square:getObjects();
        for i=0, objects:size()-1 do
            local object 		= objects:get(i);
            local sprite 		= object:getSprite();

            if sprite and sprite:getName() then
                if instanceof(object, "IsoWindow") then
                    if ((not north) and sprite:getName() == "walls_special_01_8") or (north and sprite:getName() == "walls_special_01_9") then
                        table.insert( removeList, object );
                    end
                end
                if object == wallFrame then
                    insertIndex = i+1; --insert window after wallframe
                    if instanceof(object, "IsoThumpable") then
                        if string.sub(sprite:getName(),1,string.len("walls_exterior_wooden"))=="walls_exterior_wooden" then
                            object:setHoppable(false);
                        end
                    end
                end
            end
        end
    elseif _spriteName == "appliances_misc_01_0"
        or _spriteName == "appliances_misc_01_1"
        or _spriteName == "appliances_misc_01_2"
        or _spriteName == "appliances_misc_01_3"
    then
        local genItem = instanceItem("Base.Generator")
        obj = IsoGenerator.new(genItem, getCell(), _square)
    elseif _spriteName == "appliances_misc_01_4"
        or _spriteName == "appliances_misc_01_5"
        or _spriteName == "appliances_misc_01_6"
        or _spriteName == "appliances_misc_01_7"
    then
        local genItem = instanceItem("Base.Generator_Old")
        obj = IsoGenerator.new(genItem, getCell(), _square)
    elseif _spriteName == "appliances_misc_01_8"
        or _spriteName == "appliances_misc_01_9"
        or _spriteName == "appliances_misc_01_10"
        or _spriteName == "appliances_misc_01_11"
    then
        local genItem = instanceItem("Base.Generator_Yellow")
        obj = IsoGenerator.new(genItem, getCell(), _square)
    elseif _spriteName == "appliances_misc_01_12"
        or _spriteName == "appliances_misc_01_13"
        or _spriteName == "appliances_misc_01_14"
        or _spriteName == "appliances_misc_01_15"
    then
        local genItem = instanceItem("Base.Generator_Blue")
        obj = IsoGenerator.new(genItem, getCell(), _square)
    elseif self.type=="WindowObject" then
        obj = IsoCurtain.new( getCell(), _square, _spriteName, north );
        if self:hasFaces() and (self.facing == "S" or self.facing == "E") then          -- If facing south or east, make sure window object is placed directly after window or windowFrame
            local wallFrame = self:getWallForFacing( _square, north and "S" or "E", "WindowFrame" );
            local window    = _square:getWindow(north);

            local objects = _square:getObjects();
            for i=0, objects:size()-1 do
                local object 		= objects:get(i);

                if (window and object == window) or (wallFrame and object == wallFrame) then
                    insertIndex = i+1;
                end
            end
        end
    else
        local itemSprite = _spriteName;
        local sprite = getSprite( itemSprite );
        local props = sprite and sprite:getProperties();
        local currentSurface = self:getTotalTableHeight(_square);
        if self.isMoveable and self.isTableTop and (not self.ignoreSurfaceSnap) then -- and self.facing ~= nil then		-- face correction when possible for items that are supposed to be on tables (like sinks)
            local faces = self:getFaces();

            local objects = _square:getObjects();
            for i=0, objects:size()-1 do
                local object 		= objects:get(i);
                local spr 			= object:getSprite();
                local mprops 		= ISMoveableSpriteProps.new( spr );
                if self.facing ~= nil and mprops.isMoveable and mprops.isTable and mprops:hasFaces() then
                    insertIndex = i+1;
                    local tmpSprite = self:getFaceSpriteFromParentObject( object );
                    if tmpSprite then
                        itemSprite = tmpSprite;
                        break;
                    end
                end
            end
        end

        local doDestroyAble = false;
        if self.isoType == "IsoBarbecue" then
            local bbqSprite = getSprite(itemSprite);
            if bbqSprite then
                obj = IsoBarbecue.new( getCell(), _square, bbqSprite );
                obj:setMovedThumpable(true);
            end
        elseif self.isoType == "IsoBrokenGlass" then
            obj = IsoBrokenGlass.new(getCell())
            obj:setSquare(_square);
        elseif self.isoType == "IsoCombinationWasherDryer" then
            obj = IsoCombinationWasherDryer.new(getCell(), _square, getSprite(itemSprite))
            obj:setMovedThumpable(true);
        elseif self.isoType == "IsoClothingDryer" then
            obj = IsoClothingDryer.new(getCell(), _square, getSprite(itemSprite))
            obj:setMovedThumpable(true);
        elseif self.isoType == "IsoClothingWasher" then
            obj = IsoClothingWasher.new(getCell(), _square, getSprite(itemSprite))
            obj:setMovedThumpable(true);
        elseif self.isoType == "IsoCompost" then
            obj = IsoCompost.new(getCell(), _square, getSprite(itemSprite))
            obj:setMovedThumpable(true);
        elseif self.isoType == "IsoFeedingTrough" then
            local linkedSquare = nil -- constructor will use IsoSpriteGrid
            obj = IsoFeedingTrough.new(_square, itemSprite, linkedSquare)
        elseif self.isoType == "IsoMannequin" then
            obj = IsoMannequin.new(getCell(), _square, getSprite(itemSprite))
            obj:setSquare(_square)
            obj:getCustomSettingsFromItem(_item)
            if self.cursorFacing then
                local facing = { "N", "W", "S", "E" }
                local dir = IsoDirections[facing[self.cursorFacing]]
                obj:setDir(dir)
            end
        elseif self.isoType == "IsoRadio" or self.isoType == "IsoTelevision" then
            local oobj = nil
            if instanceof(_item,"Radio") then
                if self.isoType == "IsoRadio" then
                    obj = IsoRadio.new( getCell(), _square, getSprite(itemSprite) );
                    --oobj:setMovedThumpable(true);
                elseif self.isoType == "IsoTelevision" then
                    obj = IsoTelevision.new( getCell(), _square, getSprite(itemSprite) );
                    --oobj:setMovedThumpable(true);
                end
                local deviceData = _item:getDeviceData();
                if deviceData then
                    if deviceData.setIsTurnedOn ~= nil then
                        deviceData:setIsTurnedOn(deviceData:getIsTurnedOn()); --checks if current placing allows turnedon state (tv cant be turned on outside housing)
                    end
                    obj:setDeviceData(deviceData);
                else
                    print("Warning: device data missing?>?")
                end
                --[[
                if obj ~= nil then
                    _square:AddTileObject(obj)
                    if isClient() then obj:transmitCompleteItemToServer(); end
                    triggerEvent("OnObjectAdded", obj)
                end
                ]]--
            else
                if self.isoType == "IsoRadio" then
                    obj = IsoRadio.new( getCell(), _square, getSprite(itemSprite) );
                    obj:setMovedThumpable(true);
                elseif self.isoType == "IsoTelevision" then
                    obj = IsoTelevision.new( getCell(), _square, getSprite(itemSprite) );
                    obj:setMovedThumpable(true);
                end
                --[[
                if obj ~= nil then
                    _square:AddTileObject(obj)
                    if isClient() then obj:transmitCompleteItemToServer(); end
                    triggerEvent("OnObjectAdded", obj)
                end
                ]]--
            end

        elseif self.isoType == "IsoJukebox" then
            obj = IsoJukebox.new( getCell(), _square, getSprite(itemSprite) );
            obj:setMovedThumpable(true);
        elseif self.isoType == "IsoStove" then
            obj = IsoStove.new( getCell(), _square, getSprite(itemSprite) );
            obj:setMovedThumpable(true);
            if _item:getCondition() == 0 then
                obj:setBroken(true)
            end
            --doDestroyAble = true;
        elseif self.isoType == "IsoFireplace" or self.container == "fireplace" then
            obj = IsoFireplace.new( getCell(), _square, getSprite(itemSprite) );
        elseif self.isoType == "IsoMultiMedia" then
            obj = IsoMultiMedia.new( getCell(), _square, getSprite(itemSprite) );
        else
--             print("ISMoveableSpriteProps:placeMoveableInternal 3 ", obj)
            local blockStyleSolid = props and (props:Is(IsoFlagType.solid) or props:Is(IsoFlagType.solidtrans)) or false;

            if props and TileIsoObjectType == IsoObjectType.lightswitch then
                if props:Is("streetlight") then
                    createTile(_spriteName, _square)
                    getPlayer():setHaloNote("Light tiles will be updated when zone will reloaded")
                else
                    obj = IsoLightSwitch.new( getCell(), _square, getSprite(_spriteName), _square:getRoomID() );
                    obj:addLightSourceFromSprite();
                    obj:getCustomSettingsFromItem(_item);
                end
            elseif not blockStyleSolid or self.type == "FloorRug" or self.type == "WallObject" or self.isTableTop then
                if props then
                    if props:Is(IsoFlagType.doorN) or props:Is(IsoFlagType.doorW) then
                        local tname, tnum = getNameAndNumFromSpriteName(itemSprite)
                        obj = IsoDoor.new(getCell(), _square, tname .. "_" .. tostring(tnum), props:Is(IsoFlagType.doorN));
                    elseif props:Is(IsoFlagType.WallN) or props:Is(IsoFlagType.WallW) then
                        obj = IsoThumpable.new(getCell(), _square, itemSprite, props:Is(IsoFlagType.WallN), {})
                        print(props:Is("GarageDoor"))
                    elseif props:Is(IsoFlagType.windowN) or props:Is(IsoFlagType.windowW) then
                        obj = IsoWindow.new( getCell(), _square, getSprite( _spriteName ), props:Is(IsoFlagType.windowN) );
                        obj:setIsLocked(false)
                    elseif props:Is(IsoFlagType.WindowN) or props:Is(IsoFlagType.WindowW) then
                        obj = IsoWindowFrame.new( getCell(), _square, getSprite( _spriteName ), props:Is(IsoFlagType.WindowN) );
                    else
                        obj = IsoObject.new( getCell(), _square, itemSprite );
                    end
                else
                    obj = IsoObject.new( getCell(), _square, itemSprite );
                    -- FIXME: This was used for the POLICE station sign.  But it interfers with 3D-item placement on shelves.
                end
            else
--                 print("ISMoveableSpriteProps:placeMoveableInternal 6 ", obj)
                if luautils.stringStarts(_spriteName, 'blends_natural_02') then
                    if luautils.stringStarts(_spriteName, 'blends_natural_02_0') or luautils.stringStarts(_spriteName, 'blends_natural_02_5') or luautils.stringStarts(_spriteName, 'blends_natural_02_6') or luautils.stringStarts(_spriteName, 'blends_natural_02_7') then
                        local spr = getSprite( _spriteName );
                        local floor = _square:getFloor();
                        if floor and spr then
                            for i=_square:getObjects():size()-1, 0, -1 do
                                local object = _square:getObjects():get(i)
                                if object ~= floor then
                                    if isClient() then _square:transmitRemoveItemFromSquare(object) end
                                    _square:RemoveTileObject(object);
                                end
                            end
                            floor:clearAttachedAnimSprite()
                            _square:addFloor(itemSprite)
                        end
                        getPlayer():setHaloNote("Tiles around water will improve when zone will reloaded")
                    else
                        getPlayer():setHaloNote("This water tiles not work because need water zone for it")
                        return
                    end
                else
--                     print("ISMoveableSpriteProps:placeMoveableInternal 7 ", itemSprite)
                    obj = IsoThumpable.new(getCell(), _square, itemSprite, false, {}); --IsoObject.new( getCell(), self.square, itemSprite );
--                     print("ISMoveableSpriteProps:placeMoveableInternal 8 ", obj)
                    obj:setMaxHealth(self:getObjectHealth());
                    obj:setHealth(obj:getMaxHealth());
                    obj:setThumpDmg(1); --zeds needed to hurt obj
                    obj:setIsThumpable(true);
                    obj:setBlockAllTheSquare(true);
                    obj:setCanPassThrough(false);
                    obj:setHoppable(false);
                    obj:setBreakSound(IsoThumpable.GetBreakFurnitureSound(itemSprite));
                    if self:isBreakablePlant(obj) then
                        obj:setBreakSound("BreakPlant");
                    end
                    --isGenericThump = true;
                    if _item:hasModData() then
                        local modData = _item:getModData()
                        if type(modData.name) == "string" then
                            obj:setName(modData.name)
                        end
                        if tonumber(modData.health) and tonumber(modData.maxHealth) then
                            obj:setHealth(tonumber(modData.health))
                            obj:setMaxHealth(tonumber(modData.maxHealth))
                        end
                        if type(modData.thumpSound) == "string" then
                            obj:setThumpSound(modData.thumpSound)
                        end
                        if type(modData.modData) == "table" then
                            for key,value in pairs(modData.modData) do
                                obj:getModData()[key] = value
                            end
                        end
                        if type(modData.color) == "userdata" then
                            obj:setCustomColor(modData.color);
                        end
                        if modData.lightSource ~= nil then
                            obj:createLightSource(modData.lightSource.radius, modData.lightSource.xoffset, modData.lightSource.yoffset, 0, 0, modData.lightSource.fuel, nil, nil);
                            obj:setLifeLeft(modData.lightSource.life);
                            obj:setHaveFuel(modData.lightSource.life > 0);
                        end
                    end
                    
                    -- call afterRotated in case object was rotated
                    obj:afterRotated();
                end
            end
        end

--         print("ISMoveableSpriteProps:placeMoveableInternal 10 ", obj)


        -- Remove grass
        for i=_square:getObjects():size(),1,-1 do
            local object = _square:getObjects():get(i-1)
            if object:getProperties() and object:getProperties():Is(IsoFlagType.canBeRemoved) then
                _square:transmitRemoveItemFromSquare(object)
            end
        end


        -- Inform players about some tiles
        if _spriteName == "camping_01_04" or _spriteName == "camping_01_05" or _spriteName == "camping_01_06" then
            getPlayer():setHaloNote("Tile will start work when zone will reloaded")
        end

        if obj and _item and _item:hasModData() and _item:getModData().movableData then
            obj:getModData().movableData = copyTable(_item:getModData().movableData);
        end

        --fix for radio vehicle parts having condition
        if obj and _item and _item:getConditionMax()>0 then
            obj:getModData().itemCondition = { value = _item:getCondition(), max = _item:getConditionMax() };
        end

        if obj and doDestroyAble then
            if instanceof(obj,"IsoThumpable") then
                obj:setMaxHealth(self:getObjectHealth());
                obj:setHealth(obj:getMaxHealth());
                obj:setThumpDmg(1); --zeds needed to hurt obj
                obj:setIsThumpable(true);
                obj:setBreakSound(IsoThumpable.GetBreakFurnitureSound(obj:getSprite()));
                if self:isBreakablePlant(obj) then
                     obj:setBreakSound("BreakPlant");
                end
            end
        end

        if obj and self.isTableTop then             --adjust y render mod if needed.
            --s.surface s.surfaceIsOffset
            if self.surface and self.surfaceIsOffset then
                currentSurface = currentSurface - self.surface;
            end
            obj:setRenderYOffset(currentSurface);
            --print(currentSurface);
        end

        if obj and self.isTable then
            obj:setRenderYOffset(currentSurface);
        end

        --local sprite = getSprite( itemSprite );
        if props and obj then --sprite and obj then
            --local props = sprite:getProperties();
            obj:createContainersFromSpriteProperties()
            for i=1,obj:getContainerCount() do
                obj:getContainerByIndex(i-1):setExplored(true)
            end

            if props:Is(IsoFlagType.waterPiped) then -- the item need to be re-piped inside a house or player's build safehouse
				obj:getModData().canBeWaterPiped = true;
--                obj:setUsesExternalWaterSource(true);
            end

            --if isGenericThump and props:Is("lightR") then
            --obj:createLightSource(10, 5, 5, 0, 0, nil, nil, _character);
            --end
        end
    end

    if self.type == "FloorRug" and _square:getObjects() then
        local objects = _square:getObjects()
        for i=objects:size(),1,-1 do
            local obj2 = objects:get(i-1)
            if obj2:getProperties() and obj2:getProperties():Is(IsoFlagType.solidfloor) then
                insertIndex = i
                break
            end
        end
    end

    if _square:getObjects() and insertIndex > _square:getObjects():size() then
        insertIndex = _square:getObjects():size();
    end

--     print("ISMoveableSpriteProps:placeMoveableInternal 20 ", obj)


    if obj then
        local components = self:removeComponentsBeforePlacing(obj) -- hack for feeding trough's FluidContainer
        -- instancing craft workstation things from brush/placed stuff
        -- probably doesn't work properly and will break something but also brush/item spawned workstation tiles need to work
        if obj and not _item:hasComponents() then
            GameEntityFactory.CreateIsoEntityFromCellLoading(obj)
        end
        GameEntityFactory.TransferComponents(_item, obj);
        self:restoreComponentsAfterPlacing(obj, components)
--         print("ISMoveableSpriteProps:placeMoveableInternal 21 ", obj)
        _square:AddSpecialObject( obj, insertIndex );
        if isClient() then obj:transmitCompleteItemToServer(); end
        if isServer() then obj:transmitCompleteItemToClients(); end
--         print("ISMoveableSpriteProps:placeMoveableInternal 22 ", obj)
        triggerEvent("OnObjectAdded", obj) -- for RainCollectorBarrel in singleplayer
    end

    for _,remObject in ipairs(removeList) do
        --print("removing dummy window");
        if isClient() then _square:transmitRemoveItemFromSquare(remObject) end
        if isServer() then _square:transmitRemoveItemFromSquareOnClients(remObject) end
        _square:RemoveTileObject(remObject);
    end

    getTileOverlays():fixTableTopOverlays(_square);

    _square:RecalcProperties();
    _square:RecalcAllWithNeighbours(true);
    --_character:getInventory():Remove(item);

    --ISMoveableCursor.clearCacheForAllPlayers();

    triggerEvent("OnContainerUpdate")

    IsoGenerator.updateGenerator(_square)

    if obj then return obj end
end

function ISMoveableSpriteProps:removeComponentsBeforePlacing(obj)
    local components = {}
    if instanceof(obj, "IsoFeedingTrough") and obj:hasComponent(ComponentType.FluidContainer) then
        table.insert(components, obj:getFluidContainer())
        obj:removeFluidContainer() -- NOTE: this frees the FluidContainer component
    end
    return components
end

function ISMoveableSpriteProps:restoreComponentsAfterPlacing(obj, components)
    if instanceof(obj, "IsoFeedingTrough") and components[1] then
        obj:createFluidContainer()
    end
end

-- returns index of snapface
function ISMoveableSpriteProps:snapFaceToSquare( _square )
    if self.isMoveable and self:hasFaces() then
        local faces = self:getFaces();
        if (self.type == "Object" or self.type == "Vegitation") and self.isTableTop then
            local tableObject = self:getSpecificMoveableObjectFromSquare( _square, "Table" );
            if tableObject then
                local sprite 		= tableObject:getSprite();
                if sprite then
                    local props = sprite:getProperties();
                    if props then
                        local parentFace = props:Is("Facing") and props:Val("Facing");
                        if not parentFace then
                            return;
                        elseif faces.S and parentFace == "S" then
                            return 3;
                        elseif faces.E and parentFace == "E" then
                            return 4;
                        elseif faces.N and parentFace == "N" then
                            return 1;
                        elseif faces.W and parentFace == "W" then
                            return 2;
                        end
                    end
                end
            end
        end
        if self.type == "WallObject" or self.type == "WallOverlay" or self.type == "WindowObject" then
            local wallSearchMode = (self.type == "WindowObject" and "WindowFrame" or nil);
            if self.allowDoorFrame then --self.name=="Exit Sign" then
                wallSearchMode = "WallAndDoor";
            end
            if faces.S and self:getWallForFacing( _square, "S", wallSearchMode ) then
                return 3;
            elseif faces.E and self:getWallForFacing( _square, "E", wallSearchMode ) then
                return 4;
            elseif faces.N and self:getWallForFacing( _square, "N", wallSearchMode ) then
                return 1;
            elseif faces.W and self:getWallForFacing( _square, "W", wallSearchMode ) then
                return 2;
            end
        end
        if self.type == "Window" then
            if self.facing == "N" or self.facing == "W" then        -- windows only have N and W, but search tile on facing S and E
                if faces.N and self:getWallForFacing( _square, "S", "WindowFrame" ) then
                    return 1;
                elseif faces.W and self:getWallForFacing( _square, "E", "WindowFrame" ) then
                    return 2;
                end
            end
        end
    end
end

local wallModeTable = {
    Wall            = { N = {"WallN", "WallNW"}, W = {"WallW", "WallNW"} },
    WallAndDoor     = { N = {"WallN", "WallNW","DoorWallN"}, W = {"WallW", "WallNW","DoorWallW"} },
    WindowFrame     = { N = {IsoFlagType.WindowN}, W = {IsoFlagType.WindowW} },
    DoorFrame     = { N = {"WallN", "WallNW", "DoorWallN"}, W = {"WallW", "WallNW", "DoorWallW"} },
}
-- gets a Wall for the defined facing (N S E W)
-- optionally can retrieve windowframes
function ISMoveableSpriteProps:getWallForFacing( _square, _dir, _mode )
    if not _dir then return; end
    if _dir == "N" then --object facing north, needs wall on south square
        _square = _square and _square:getTileInDirection(IsoDirections.S);
    elseif _dir == "W" then --object facing west, needs wall on east square
        _square = _square and _square:getTileInDirection(IsoDirections.E);
    end

    local lookup = wallModeTable.Wall;
    if _mode and _mode ~= "Wall" and wallModeTable[_mode] then
        lookup = wallModeTable[_mode];
    end

    local square, tag1, tag2, tag3;
    if _dir == "S" or _dir == "N" then
        square, tag1, tag2, tag3 = _square, lookup.N[1], lookup.N[2], lookup.N[3];
    elseif _dir == "E" or _dir == "W" then
        square, tag1, tag2, tag3 = _square, lookup.W[1], lookup.W[2], lookup.W[3];
    end

    if square and (tag1 or tag2 or tag3) then
        if (tag1 and square:Is(tag1)) or (tag2 and square:Is(tag2)) or (tag3 and square:Is(tag3)) then
            for i = 0, square:getObjects():size()-1 do
                local obj = square:getObjects():get(i);
                local sprite = obj:getSprite();
                if sprite and sprite:getProperties() then
                    local props = sprite:getProperties();
                    if props then
                        if (tag1 and props:Is(tag1)) or (tag2 and props:Is(tag2)) or (tag3 and props:Is(tag3)) then
                            return obj;
                        end
                    end
                end
            end
        end
    end
end

-- retrieve a overlay moveable from a object
function ISMoveableSpriteProps:getMoveableOverlayFromObject( _object )
    if _object then
        local sprList = _object:getChildSprites();
        if sprList then
            local list_size 	= sprList:size();
            if list_size > 0 then
                for i=list_size-1, 0, -1 do
                    local sprite = sprList:get(i):getParentSprite();
                    if sprite and sprite:getProperties() then
                        local props = sprite:getProperties();
                        if props then
                            if props:Is("IsMoveAble") and props:Is("MoveType") and props:Val("MoveType") == "WallObject" and props:Is(IsoFlagType.WallOverlay) then
                                return sprList:get(i), sprite;
                            end
                        end
                    end
                end
            end
        end
    end
end

-- get specific moveables from the square
function ISMoveableSpriteProps:getSpecificMoveableObjectFromSquare( _square, _objectType )
    if _square and _objectType then
        local objects   = _square:getObjects();
        for i=0, objects:size()-1 do
            local object 		= objects:get(i);
            local sprite 		= object:getSprite();
            if sprite then
                local props = sprite:getProperties();
                if props then
                    if _objectType == "Table" and props:Is("IsTable") then
                        return object;
                    elseif _objectType == "TableTop" and props:Is("IsTableTop") then
                        return object;
                    elseif _objectType == "WallObject" and props:Is("MoveType") and props:Val("MoveType") == "WallObject" then
                        return object;
                    end
                end
            end
        end
    end
end

-- returns the face from a table on square if possible
function ISMoveableSpriteProps:getFaceSpriteFromParentObject( _object )
    if _object and self.isMoveable and self:hasFaces() then
        local ownFaces      = self:getFaces();
        local sprite 		= _object:getSprite();
        if sprite then
            local props = sprite:getProperties();
            if props then
                if props:Is("Facing") and props:Val("Facing") then
                    local parentFacing = props:Val("Facing");
                    local newSprite = nil;
                    if parentFacing=="N" and ownFaces.N then
                        newSprite = ownFaces.N;
                    elseif parentFacing=="W" and ownFaces.W then
                        newSprite = ownFaces.W;
                    elseif parentFacing=="S" and ownFaces.S then
                        newSprite = ownFaces.S;
                    elseif parentFacing=="E" and ownFaces.E then
                        newSprite = ownFaces.E;
                    elseif (parentFacing=="N" or parentFacing=="S") and (ownFaces.N or ownFaces.S) then
                        newSprite = ownFaces.N or ownFaces.S;
                    elseif (parentFacing=="W" or parentFacing=="E") and (ownFaces.W or ownFaces.E) then
                        newSprite = ownFaces.W or ownFaces.E;
                    end

                    return newSprite;
                end
            end
        end
    end
end

-- returns of the current object can be rotated with the Rotate mode (some objects can be rotated during placement such as wall objects but cannot be rotated via the Rotate mode)
function ISMoveableSpriteProps:canManuallyRotate()
    if self.isMoveable and self:hasFaces() and (self.type == "Object" or self.type == "Vegitation") then
        return true;
    end
    if self:canRotateDirection() then
        return true;
    end
    return false;
end

-- return if this object's IsoDirection can be changed via rotation (an not by changing sprites)
function ISMoveableSpriteProps:canRotateDirection()
    if self.isMoveable and self.isoType == "IsoMannequin" then
        return true;
    end
    return false;
end

function ISMoveableSpriteProps:findOriginalSquare(_gridInfo, _sprite)
    for i = 1, #_gridInfo do
        if _gridInfo[i].sprite == _sprite then
            return _gridInfo[i].square;
        end
    end
    return _gridInfo[1].square; -- fallback
end

-- the current properties (self) should be the target rotation. _origProps are the properties of the object in the world.
function ISMoveableSpriteProps:canRotateMoveable( _square, _object, _origProps )
    if self.isMoveable then
        if self.isMultiSprite then
            if _origProps and _origProps.isMoveable and _origProps.isMultiSprite and self:canRotateMoveableInternal( _square, nil ) then
                local origGrid = _origProps:getSpriteGridInfo(_square, true); -- get the original's grid with the squares, objects etc retrieved.
                if origGrid and #origGrid>0 then
                    local origSquare = self:findOriginalSquare(origGrid, self.sprite);
                    local sgrid = self:getSpriteGridInfo(origSquare, false); -- get the grid of the target rotation, this will have squares but no objects. Its origin is based on the origGrid anchor [1].
                    if not sgrid then return false; end

                    local square = origGrid[1].square
                    if self:isWallBetweenParts(self.sprite:getSpriteGrid(), square:getX(), square:getY(), square:getZ()) then
                        return false
                    end

                    for _,origMember in ipairs(origGrid) do --check if there are no tabletops on the original grid and if the objects are no containers or empty.
                        if origMember.square:Is("IsTableTop") then
                            return false;
                        end
                        if not origMember.object:isObjectNoContainerOrEmpty() then
                            return false;
                        end
                    end
                    for _,gridMember in ipairs(sgrid) do
                        local coveredByOrig = false;
                        for _,origMember in ipairs(origGrid) do -- check if this position is covered by the original grid, if so it can be assumed that the current object can be placed in its new position.
                            if gridMember.square == origMember.square then
                                coveredByOrig = true;
                            end
                        end
                        if not coveredByOrig then
                            if not self:canPlaceMoveableInternal( nil, gridMember.square, nil ) then --if tile not covered by original then perform a place check.
                                return false;
                            end
                        end
                    end
                    return true;
                end
            end
        else
            return self:canRotateMoveableInternal( _square, _object );
        end
    end
    return false;
end

-- checks if the current rotation can be applied (current rotation should be 'self')
function ISMoveableSpriteProps:canRotateMoveableInternal( _square, _object )
    self.yOffsetCursor = _object and _object:getRenderYOffset() or 0;
    if self.isMoveable and self:hasFaces() then
        if _object and not _object:isObjectNoContainerOrEmpty() then
            return false;
        end
        if self.type == "Object" or self.type == "Vegitation" then
            return true;
        end
    end
    if self:canRotateDirection() then
        return true
    end
    return false;
end

function ISMoveableSpriteProps:rotateMoveableViaCursor( _character, _square, _origSpriteName, _moveCursor )
    self:rotateMoveable(_character, _square, _origSpriteName);
    if _moveCursor then
        _moveCursor:clearCache()
    end
end

function ISMoveableSpriteProps:rotateMoveable( _character, _square, _origSpriteName )
    if self.isMoveable then
        if self.isMultiSprite then
            local origProps = ISMoveableSpriteProps.new( _origSpriteName ); -- get original.
            local origGrid = origProps:getSpriteGridInfo(_square, true);
            if origGrid and #origGrid>0 then
                local anchorSquare = self:findOriginalSquare(origGrid, self.sprite);

                local items = origProps:pickUpMoveable( _character, _square, false, true ); -- pickup orignal. FIXME get a list of temporary items for placeMovable

                -- now place rotation based on anchor square
                local sgrid = self:getSpriteGridInfo(anchorSquare, false); --_square, false);
                for i,gridMember in ipairs(sgrid) do
                    self:placeMoveableInternal(  gridMember.square, items[i], gridMember.sprite:getName() )
                end
                ISMoveableCursor.clearCacheForAllPlayers();
            end
        else
            self:rotateMoveableInternal( _character, _square, _origSpriteName );
        end
    end
end

-- applies the rotation after action.
function ISMoveableSpriteProps:rotateMoveableInternal( _character, _square, _origSpriteName )
    if not self.isMoveable then return end
    if not instanceof(_character, "IsoGameCharacter") then return end
    if not instanceof(_square, "IsoGridSquare") then return end

    if self:hasFaces() then
        local obj, sprInstance = self:findOnSquare( _square, _origSpriteName );
        if obj and not sprInstance and self.sprite and self:canRotateMoveable( _square, obj ) then
            obj:setSprite( self.sprite );
            obj:RemoveAttachedAnims();
            obj:afterRotated();
            if isClient() then obj:transmitUpdatedSpriteToServer(); end
            if isServer() then obj:transmitUpdatedSpriteToClients(); end
            if self.isTable then                                                                                    -- If table then rotate tabletop items (sinks etc) to match table face.
                local tableTopObject = self:getSpecificMoveableObjectFromSquare( _square, "TableTop" );
                if tableTopObject then
                    local sprite 		= tableTopObject:getSprite();
                    local mprops 		= ISMoveableSpriteProps.new( sprite );
                    if mprops.isMoveable and mprops.isTableTop and mprops:hasFaces() then
                        local newSpriteName = mprops:getFaceSpriteFromParentObject( obj );
                        if newSpriteName then
                            local newSprite = getSprite(newSpriteName);
                            if newSprite then
                                tableTopObject:setSprite( newSprite );
                                tableTopObject:RemoveAttachedAnims();
                                tableTopObject:afterRotated();
                                if isClient() then tableTopObject:transmitUpdatedSpriteToServer(); end
                                if isServer() then tableTopObject:transmitUpdatedSpriteToClients(); end
                            end
                        end
                    end
                end
            end
            ISMoveableCursor.clearCacheForAllPlayers();
            obj:flagForHotSave();
        end
    end

    if self.cursorFacing and self:canRotateDirection() then
        local obj, sprInstance = self:findOnSquare( _square, self.spriteName )
        if obj and not sprInstance and self.sprite and self:canRotateMoveable( _square, obj ) then
            local facing = { "N", "W", "S", "E" }
            local dir = IsoDirections[facing[self.cursorFacing]]

            local index = obj:getObjectIndex()
            local args = { x=obj:getX(), y=obj:getY(), z=obj:getZ(), index=index, dir=dir }
            sendClientCommand(_character, 'object', 'rotate', args)

            ISMoveableCursor.clearCacheForAllPlayers()
        end
    end
end

function ISMoveableSpriteProps:walkAdj(character, square, keepActions)
    if luautils.walkAdj(character, square, keepActions) then
        return true
    else
        local sq2
        if square:Is(IsoFlagType.collideW) then
            sq2 = getCell():getGridSquare(square:getX() - 1, square:getY(), square:getZ())
        elseif square:Is(IsoFlagType.collideN) then
            sq2 = getCell():getGridSquare(square:getX(), square:getY() - 1, square:getZ())
        end

        if sq2 and sq2:getFloor() then
            return luautils.walkAdj(character, sq2, keepActions)
        end
    end
    return false
end

function ISMoveableSpriteProps:walkToAndEquip( _character, _square, _mode )
    local dowalk = false;
    if self.type == "Window" or self.type == "WindowObject" then
        local dir = self.facing;
        if self.type == "Window" then
            local isNorth = self.facing and (self.facing == "N" or self.facing == "S") or false;
            dir = isNorth and "S" or "E";
        end
        local windowFrame = self:getWallForFacing( _square, dir, "WindowFrame" );
        dowalk = windowFrame and luautils.walkAdjWindowOrDoor( _character, _square, windowFrame, false);
    elseif instanceof(self.object, "IsoDoor") or (instanceof(self.object, "IsoThumpable") and self.object:isDoor()) then
        dowalk = luautils.walkAdjWindowOrDoor( _character, _square, self.object, false);
    elseif self.object ~= nil and self.object:getType() == IsoObjectType.wall then
        dowalk = luautils.walkAdjWindowOrDoor( _character, _square, self.object, false);
    else
        dowalk = self:walkAdj( _character, _square, false );
    end
    if dowalk and _mode == "scrap" then
        local tool = self:hasScrapTool(_character, false)
        if tool == false or tool == nil then return false end
        if tool ~= true then
            if tool:getType() == "BlowTorch" then
                ISWorldObjectContextMenu.equip(_character, _character:getPrimaryHandItem(), predicateBlowTorch, true)
            else
                ISWorldObjectContextMenu.equip(_character, _character:getPrimaryHandItem(), tool:getType(), true)
            end
        end
        local tool2 = self:hasScrapTool(_character, true)
        if tool2 == false or tool2 == nil then return false end
        if tool2 ~= true then
            if instanceof(tool2, "Clothing") then
                -- WeldingMask
                if not _character:isEquippedClothing(tool2) then
                    ISInventoryPaneContextMenu.wearItem(tool2, _character:getPlayerNum())
                end
            else
                ISWorldObjectContextMenu.equip(_character, _character:getSecondaryHandItem(), tool2:getType(), false)
            end
        end
        return true
    end
    if dowalk and _mode == "repair" then
        local tool = self:hasRepairTool(_character, false)
        if tool == false or tool == nil then return false end
        if tool ~= true then
            if tool:getType() == "BlowTorch" then
                ISWorldObjectContextMenu.equip(_character, _character:getPrimaryHandItem(), predicateBlowTorch, true)
            else
                ISWorldObjectContextMenu.equip(_character, _character:getPrimaryHandItem(), tool:getType(), true)
            end
        end
        local tool2 = self:hasRepairTool(_character, true)
        if tool2 == false or tool2 == nil then return false end
        if tool2 ~= true then
            if instanceof(tool2, "Clothing") then
                -- WeldingMask
                if not _character:isEquippedClothing(tool2) then
                    ISInventoryPaneContextMenu.wearItem(tool2, _character:getPlayerNum())
                end
            else
                ISWorldObjectContextMenu.equip(_character, _character:getSecondaryHandItem(), tool2:getType(), false)
            end
        end
        return true
    end
    if dowalk and _mode ~= "scrap" and _mode ~= "repair" then
        local usesTool = (_mode == "pickup" and self.pickUpTool) or (_mode == "place" and self.placeTool);
        if not usesTool then
            return true;
        else
            local tool = self:hasTool( _character, _mode );

            if tool then
                ISWorldObjectContextMenu.equip(_character, _character:getPrimaryHandItem(), tool:getType(), true);
                return true;
            end
        end
    end
    return false;
end

-- sounds
--ISMoveableSpriteProps.toolDefinitions[_name] = { items = _items, perk = _perk, baseActionTime = _baseActionTime, sound = _sound, isWav = _isWav };
function ISMoveableSpriteProps:getSoundFromTool( _square, _character, _mode )
    if self.isMoveable and _square and _character and _mode then
        local tool = (_mode == "rotate" and "SpecialRotate") or (_mode == "pickup" and self.pickUpTool) or (_mode == "place" and self.placeTool);
        if tool then
            if tool == "SpecialRotate" then
                addSound(_character, _character:getX(), _character:getY(), _character:getZ(), 10, 5);
--                local sound = getSoundManager():PlayWorldSound("RotateObject", _square, 0.2, 20, 1.0, 6, true);
--                return sound;
                return nil -- _character:playSound("RotateObject")
            else
                local toolDef = ISMoveableDefinitions:getInstance().getToolDefinition( tool ); --ISMoveableSpriteProps.toolDefinitions[tool];
                if toolDef then
                    if toolDef.isWav then
--                        return getSoundManager():PlayWorldSoundWav(toolDef.sound, _character:getCurrentSquare(), 0, 15, 2, true);
                        return _character:playSound(toolDef.sound)
                    else
                        addSound(_character, _character:getX(), _character:getY(), _character:getZ(), 10, 5);
--                        local sound = getSoundManager():PlayWorldSound(toolDef.sound, _square, 0.2, 20, 1.0, 3, true);
--                        return sound;
                        return _character:playSound(toolDef.sound)
                    end
                end
            end
		elseif self.customItem then
			if self.customItem == "Base.CampingTentKit2" then
				if _mode == "pickup" then
					return _character:playSound("TentTakeDown")
				end
				if _mode == "place" then
					return _character:playSound("TentPutUp")
				end
			end
        end
    end
    return nil
end

-- ###################################################################################################
-- SCRAP STUFF
-- ###################################################################################################

function ISMoveableSpriteProps:getScrapToolUses()
    return self.scrapToolUses and self.scrapToolUses or 0;
end

function ISMoveableSpriteProps:scrapWalkToAndEquip( _character )
    if self.canScrap and self.isFromObject and self.object:getSquare() then
        local square = self.object:getSquare();
        local dowalk = luautils.walkAdj( _character, square, false );
        if dowalk then
            if not self.scrapUseTool then
                return true;
            else
                local tool = self:hasScrapTool( _character );
                local tool2 = self:hasScrapTool( _character, true );

                if tool and tool2 then
                    ISWorldObjectContextMenu.equip(_character, _character:getPrimaryHandItem(), tool:getType(), true);
                    --print("tool2 = "..tostring(tool2)..", type = "..tostring(type(tool2)));
                    if type(tool2)~="boolean" then --if tool2 is an item
                        --print("attempt to equip");
                        ISWorldObjectContextMenu.equip(_character, _character:getSecondaryHandItem(), tool2:getType(), false);
                    end
                    return true;
                end
            end
        end
    end
end

--[[
function ISMoveableSpriteProps:addScrapItemToSquare( _square, _item, _max, _chance, _skillMod, _doSizeMod )
    local added = 0;
    if _square and _item and _max and _chance then
        if _skillMod and _skillMod > 0 and _skillMod <= 100 then
            _chance = (_chance/100)*_skillMod;
        end
        local amount = _max; --ZombRand(0,_max+1);
        if _doSizeMod then
            if self.scrapSize == "Small" then
                amount = amount/2 >= 1 and amount/2 or 1;
            elseif self.scrapSize == "Large" then
                amount = amount*2;
            end
        end
        if amount > 0 then
            for i = 1, amount do
                local randNum = ZombRandFloat(0,101);
                if randNum < _chance then
                    local item 	= instanceItem( _item );
                    if item then
                        if self.keyId and self.keyId ~= -1 then
                            if item:getType() == "Doorknob" then
                                item:setKeyId(self.keyId)
                            end
                        end
                        _square:AddWorldInventoryItem(item, ZombRandFloat(0.1,0.9), ZombRandFloat(0.1,0.9), 0);
                        added = added +1;
                    end
                end
            end
        end
    end
    return added;
end

function ISMoveableSpriteProps:spawnScrapItems( _square, _scrapDef, _skillChance )
    local added = 0;
    if _square and _scrapDef and _skillChance then
        if _scrapDef.returnItems and #_scrapDef.returnItems > 0 then
            for i,v in ipairs(_scrapDef.returnItems) do
                added = added + self:addScrapItemToSquare( _square, v.returnItem, v.maxAmount, v.chancePerRoll, _skillChance, true );
            end
        end
        if _scrapDef.returnItemsStatic and #_scrapDef.returnItemsStatic > 0 then
            for i,v in ipairs(_scrapDef.returnItemsStatic) do
                added = added + self:addScrapItemToSquare( _square, v.returnItem, v.maxAmount, v.chancePerRoll, _skillChance, false );
            end
        end
    end
    if added == 0 and _scrapDef.unusableItem then
        local rolls = ZombRand(1,3);
        for i = 1,rolls do
           _square:AddWorldInventoryItem(_scrapDef.unusableItem, ZombRandFloat(0.1,0.9), ZombRandFloat(0.1,0.9), 0);
        end
    end
    ISInventoryPage.dirtyUI()
    return added;
end
--]]

function ISMoveableSpriteProps:getScrapItemsList(_character)
    local materials = {};
    local items = { usable = {}, unusable = {} };
    if self.material then table.insert(materials, self.material); end
    if self.material2 then table.insert(materials, self.material2); end
    if self.material3 then table.insert(materials, self.material3); end

    if #materials<=0 then return end

    local scrapDef, chance, addedAmount;
    for k,mat in ipairs(materials) do
        scrapDef = ISMoveableDefinitions:getInstance().getScrapDefinition( mat );
        chance = self:getChanceByDef(scrapDef, _character);
        addedAmount = 0;
        if scrapDef and chance then
            local returnItems = scrapDef.returnItemsStatic or {};
            if (not returnItems) or #returnItems < 1 then
                returnItems = scrapDef.returnItems;
            end

            if returnItems and #returnItems > 0 then
                for i,v in ipairs(returnItems) do
                    addedAmount = addedAmount + self:addScrapItemToList( items.usable, v.returnItem, v.maxAmount, v.chancePerRoll, chance, true );
                end
            end

            if addedAmount == 0 and scrapDef.unusableItem then
                local rolls = ZombRand(1,3);
                for i = 1,rolls do
                    table.insert(items.unusable, scrapDef.unusableItem);
                end
            end
        end		
    end

    return items;
end

function ISMoveableSpriteProps:addScrapItemToList( _list, _item, _max, _chance, _skillMod, _doSizeMod )
    local added = 0;
    if _item and _max and _chance then
        if _skillMod and _skillMod > 0 and _skillMod <= 100 then
            _chance = (_chance/100)*_skillMod;
        end
        local amount = _max; --ZombRand(0,_max+1);
        if _doSizeMod then
            if self.scrapSize == "Small" then
                amount = amount/2 >= 1 and amount/2 or 1;
            elseif self.scrapSize == "Large" then
                amount = amount*2;
            end
        end
		print("_item " .. tostring(_item))
		-- kludge to prevent floors from providing more nails than used to make them
		if _item == "Base.Nails" and self.object and self.object:isFloor() and amount > 1 then
			amount = 1
		end
		-- kludge so sandbag walls can be dismantled and give back the original 3 bags
		if _item == "Base.Sandbag" then
			amount = 3
		end
        if amount > 0 then
            for i = 1, amount do
                -- just in case we need to do some funny stuff for crafting materials
                local newItem = _item;
                local randNum = ZombRandFloat(0,101);
                -- again I just want to give back the 3 sandbags with no funny business
                if randNum < _chance or _item == "Base.Sandbag" then
                    table.insert( _list, newItem );
                    added = added +1;
                end
            end
        end
    end
    return added;
end

function ISMoveableSpriteProps:addOrDropItem( _character, _item )
	local inv = _character:getInventory()
	if not inv:contains(_item) then
		inv:AddItem(_item)
		sendAddItemToContainer(inv, _item);
	end
	if inv:getCapacityWeight() > inv:getEffectiveCapacity(_character) then
		if inv:contains(_item) then
			inv:Remove(_item);
			sendRemoveItemFromContainer(inv, _item);
		end
		_character:getCurrentSquare():AddWorldInventoryItem(_item,
			_character:getX() - math.floor(_character:getX()),
			_character:getY() - math.floor(_character:getY()),
			_character:getZ() - math.floor(_character:getZ()))
	end
end

function ISMoveableSpriteProps:addAllScrapItemsToInventory( _character, _list )
    local added = 0;
    for k,v in ipairs(_list.usable) do
        local item = instanceItem( v );
        if item then
            if self.keyId and self.keyId ~= -1 then
                if item:getType() == "Doorknob" then
                    item:setKeyId(self.keyId)
                end
            end
            if item:getType() == "Wire" then item:setUsedDelta(0.1) end
            self:addOrDropItem(_character, item);
            added = added + 1;
        end
    end
    for k,v in ipairs(_list.unusable) do
        local item = instanceItem( v );
        if item then
            self:addOrDropItem(_character, item);
            --added = added + 1; unusable not counted for this
        end
    end
    ISInventoryPage.dirtyUI();
    return added;
end

function ISMoveableSpriteProps:addAllScrapItemsToSquare( _square, _list )
    local added = 0;
    for k,v in ipairs(_list.usable) do
        local item 	= instanceItem( v );
        if item then
            if self.keyId and self.keyId ~= -1 then
                if item:getType() == "Doorknob" then
                    item:setKeyId(self.keyId)
                end
            end
            if item:getType() == "Wire" then item:setUsedDelta(0.1) end
            _square:AddWorldInventoryItem(item, ZombRandFloat(0.1,0.9), ZombRandFloat(0.1,0.9), 0);
            added = added +1;
        end
    end
    for k,v in ipairs(_list.unusable) do
        local item 	= instanceItem( v );
        if item then
            _square:AddWorldInventoryItem(item, ZombRandFloat(0.1,0.9), ZombRandFloat(0.1,0.9), 0);
            --added = added +1; unusable not counted for this
        end
    end
    if isClient() then ISInventoryPage.dirtyUI(); end
    return added;
end

function ISMoveableSpriteProps:scrapObject(_character)
    local added = 0;
    local scrapResult, chance, perkName = self:canScrapObject(_character);
    local canScrap = scrapResult.canScrap;

    if canScrap then
        local scrapDef = ISMoveableDefinitions:getInstance().getScrapDefinition( self.material );
        local scrapResult, chance, perkName = self:canScrapObject(_character);

        if self.isMultiSprite then
            local grid = self:getSpriteGridInfo(self.object:getSquare(), true);
            if not grid or #grid<=0 then return false; end

            for i,member in ipairs(grid) do
                if scrapDef and member.object and member.square then
                    local isMainTile = self.object == member.object;
                    if isMainTile or scrapDef.fromModData ~= true then
                        -- only generate scrap for the main tile of the object if from modData, otherwise generate for all tiles.
                        added = added + self:scrapObjectInternal(_character, scrapDef, member.square, member.object, scrapResult, chance, perkName);
                    end
                end
            end
        else
            local square = self.object and self.object:getSquare();
            if square and scrapDef then
                added = self:scrapObjectInternal(_character, scrapDef, square, self.object, scrapResult, chance, perkName);
            end
        end
    end
    if _character ~= nil and added == 0 then
        if instanceof(self.object, "IsoThumpable") then
            _character:playSound(self.object:getBreakSound())
        elseif not self.customItem then
            _character:playSound(IsoThumpable.GetBreakFurnitureSound(self.object:getSprite()))
        else
            local scrapDef = ISMoveableDefinitions:getInstance().getScrapDefinition(self.material)
            if scrapDef ~= nil and scrapDef.sound == "Dismantle" then
                _character:playSound("DismantleFailed")
            end
        end
    end
    --[[
    if added == 0 then
        _character:setHaloNote(getText("IGUI_Moveable_Fail"), 255,255,255,300);
    end
    --]]
    self:scrapHaloNoteCheck(_character, added)
end

function ISMoveableSpriteProps:getAdditionalObjects(_object)
    local objects = {};
    local object = _object or self.object;
    if object ~= nil then
        objects = buildUtil.getStairObjects(object, true);
        if #objects > 0 then return objects; end;
        objects = buildUtil.getGarageDoorObjects(object);
        if #objects > 0 then return objects; end;
        objects = buildUtil.getDoubleDoorObjects(object);
    end;
    return objects;
end

function ISMoveableSpriteProps:repairObject(_character)
    local didRepair = false;
    local repairResult, chance, perkName = self:canRepairObject(_character);
    local canRepair = repairResult.canRepair;

    if canRepair then
        self:repairObjectInternal(_character); --consume the items before attempting the repair chance
        if ZombRand(100)+1 <= chance then
            if self.isMultiSprite then
                local grid = self:getSpriteGridInfo(self.object:getSquare(), true);
                if not grid or #grid<=0 then return false; end
                for i,member in ipairs(grid) do
                    if (member.object and member.square) then
                        member.object:setHealth(member.object:getMaxHealth());
                    end;
                end;
            else
                local extraObjs = self:getAdditionalObjects(self.object);
                if #extraObjs > 0 then
                    for _, object in ipairs(extraObjs) do
                        object:setHealth(object:getMaxHealth());
                    end;
                else
                    self.object:setHealth(self.object:getMaxHealth());
                end;
            end;
            self.object:sync()
            didRepair = true;
        end;
    end;

    self:repairHaloNoteCheck(_character, didRepair)
end

function ISMoveableSpriteProps:repairObjectInternal(_character)
    if _character then
        local damageFactor, objectCount = self:getRepairDamageFactor(self.object);
        local inventory = _character:getInventory();
        local repairDef = ISMoveableDefinitions:getInstance().getRepairDefinition( self.material );
        local usedAnOptionalPart = false;
        if repairDef then
            local parts = self:getAllRepairParts();
            if parts then
                if #parts <=0 then return true; end; --in case it requires nothing
                for _, part in ipairs(parts) do
                    --some parts have a threshold in order to be required, such as hinges and knobs
                    if part.required then
                        self:consumeRepairPart(inventory, part.itemType, part.amount);
                    else
                        if not usedAnOptionalPart then
                            usedAnOptionalPart = self:consumeRepairPart(inventory, part.itemType, part.amount);
                        end;
                    end;
                end;
            end;
        end;
    end;
end

function ISMoveableSpriteProps:getRepairDamageFactor(_object)
    local healthPercent = 0;
    local objectCount = 0;
    local testObject = _object or self.object;
    if testObject then
        if self.isMultiSprite then
            local grid = self:getSpriteGridInfo(testObject:getSquare(), true);
            if grid and #grid > 0 then
                objectCount = #grid;
                local objHealthPercent;
                for _, member in ipairs(grid) do
                    if (member.object and member.square) then
                        objHealthPercent = (member.object:getHealth() / member.object:getMaxHealth());
                        if objHealthPercent < 0.20 then
                            --if something is too broken then the entire object is considered too broken
                            healthPercent = objHealthPercent;
                            break;
                        end;
                        healthPercent = healthPercent + objHealthPercent;
                    else
                        --couldn't find all objects, can't fix this.
                        objectCount = objectCount - 1;
                        healthPercent = 0;
                        break;
                    end;
                end;
                --average the damage amount
                healthPercent = healthPercent / math.max(objectCount, 1);
            end;
        else
            --handle additional objects (garage doors, stairs)
            local extraObjs = self:getAdditionalObjects(testObject);
            if #extraObjs > 0 then
                objectCount = #extraObjs;
                local objHealthPercent;
                for _, object in ipairs(extraObjs) do
                    if object then
                        objHealthPercent = (object:getHealth() / object:getMaxHealth());
                        if objHealthPercent < 0.20 then
                            --if something is too broken then the entire object is considered too broken
                            healthPercent = objHealthPercent;
                            break;
                        end;
                        healthPercent = healthPercent + objHealthPercent;
                    else
                        --couldn't find all objects, can't fix this.
                        objectCount = objectCount - 1;
                        healthPercent = 0;
                        break;
                    end;
                end;
                --average the damage amount
                healthPercent = healthPercent / math.max(objectCount, 1);
            else
                objectCount = 1;
                --handle barricades
                if instanceof(self.object, "IsoBarricade") then
                    if not self.object:isMetalBar() and not self.object:isMetal() then
                        objectCount = math.max(self.object:getNumPlanks(), 1);
                    end;
                    healthPercent = testObject:getHealth() / testObject:getMaxHealth();
                else
                    healthPercent = testObject:getHealth() / testObject:getMaxHealth();
                end
            end;
        end;
    end;

    if objectCount <= 0 then return 1, 1; end; --for any reason it can't find get any objects

    return 1 - healthPercent, objectCount;
end

function ISMoveableSpriteProps:repairHaloNoteCheck(_character, _didRepair)
    if _character then
        if not _didRepair then
            _character:setHaloNote(getText("IGUI_Repair_Fail"), 255,255,255,300);
        end
    end
end

-- also used in recipecode.lua
function ISMoveableSpriteProps:scrapHaloNoteCheck(_character, _itemsAdded)
    if _character then
        if _itemsAdded == 0 then
            _character:setHaloNote(getText("IGUI_Moveable_Fail"), 255,255,255,300);
        end
    end
end

function ISMoveableSpriteProps:scrapObjectInternal( _character, _scrapDef, _square, _object, _scrapResult, _chance, _perkName )
    local added = 0;
    local scrapResult, chance, perkName = _scrapResult, _chance, _perkName;
    local scrapDef = _scrapDef;
    local object = _object;
    local square = _square;
    if scrapDef and object and square then
        self.keyId = nil
        if instanceof(object, "IsoDoor") then
            self.keyId = object:checkKeyId()
        elseif instanceof(object, "IsoThumpable") then
            self.keyId = object:getKeyId()
        end

        -- Carpentry objects should return items from modData "need:", not MaterialN tile properties.
        -- i.e., Log Walls should give back sheets/rope/twine used to build it, not nails.
        if instanceof(object, "IsoThumpable") and object:hasModData() then
            --scrapDef = copyTable(_scrapDef)
            scrapDef.returnItems = {}
            scrapDef.returnItemsStatic = {}
            for k,v in pairs(self.object:getModData()) do
                if luautils.stringStarts(k, "need:") then
                    local type = luautils.split(k, ":")[2]
                    local count = tonumber(v)
                    local item = { returnItem = type, maxAmount = count, chancePerRoll = 80 }
                    table.insert(scrapDef.returnItemsStatic, item)
                    scrapDef.fromModData = true;
                end
            end
--            self.scrapSize = nil
            self.material2 = nil
            self.material3 = nil
        end

        local deviceData = object.getDeviceData and object:getDeviceData();

        if (_square:getZ() <= 0) and (object:isFloor() or (object:getSprite() and object:getSprite():getProperties():Is(IsoFlagType.solidfloor))) then
            local floor = _square:getFloor();
            if floor then
                floor:setSpriteFromName("blends_natural_01_64");
                if isClient() then floor:transmitUpdatedSpriteToServer(); end
                if isServer() then floor:transmitUpdatedSpriteToClients(); end
            end
        else
            if isClient() then square:transmitRemoveItemFromSquare(object) end
            if isServer() then square:transmitRemoveItemFromSquareOnClients(object) end
            square:RemoveTileObject(object);
            square:RecalcProperties();
            square:RecalcAllWithNeighbours(true);
        end

        if self.customItem then
            -- if the moveable object returns a custom item, check if the item can be dismantled
            -- if so, use the dismantle recipes/xp so they are similar.
            local recipe = RecipeManager.getDismantleRecipeFor(self.customItem);
            if recipe then
                local item = instanceItem(self.customItem);
                if item then
                    if deviceData and item.setDeviceData then
                        item:setDeviceData(deviceData);
                        --add item to inventory for the makeItem code for function:
                        _character:getInventory():AddItem(item);
                        RecipeManager.PerformMakeItem(recipe, item, _character, nil);
                        sendAddItemToContainer(_character:getInventory(), item);
                        return 1;
                    end
                end
            end
        end

        --added = added + self:spawnScrapItems( square, scrapDef, chance );
        --[[
        -- give XP
        local multiplier = 1;
        if self.scrapSize == "Medium" then
            multiplier = 2;
        elseif self.scrapSize == "Large" then
            multiplier = 3;
        end
        _character:getXp():AddXP(scrapDef.perk, 5 * multiplier)
        --]]
        local items = self:getScrapItemsList(_character);

        if scrapDef.addToInventory then
            added = self:addAllScrapItemsToInventory( _character, items );
        else
            added = self:addAllScrapItemsToSquare( _square, items );
        end

        self:scrapGiveXp(_character, scrapDef);

        if _character:getPrimaryHandType() == "BlowTorch" then
            _character:getPrimaryHandItem():Use()
        end

        --[[
        if self.material2 then
            scrapDef = ISMoveableDefinitions:getInstance().getScrapDefinition( self.material2 );
            chance = self:getChanceByDef(scrapDef, _character);
            if scrapDef then
                added = added + self:spawnScrapItems( square, scrapDef, chance );
            end
        end
        if self.material3 then
            scrapDef = ISMoveableDefinitions:getInstance().getScrapDefinition( self.material3 );
            chance = self:getChanceByDef(scrapDef, _character);
            if scrapDef then
                added = added + self:spawnScrapItems( square, scrapDef, chance );
            end
        end
        --]]
    end
    return added;
end

-- also used in recipecode.lua
function ISMoveableSpriteProps:scrapGiveXp(_character, _scrapDef)
    if not _scrapDef then
        _scrapDef = ISMoveableDefinitions:getInstance().getScrapDefinition( self.material );
    end
    -- print("Perk1 " .. tostring(_scrapDef.perk))
    -- print("Perk2 " .. tostring(_character:getPerkLevel(_scrapDef.perk))
    --SandboxVars.

    if _character and _scrapDef and _scrapDef.perk and (_scrapDef.perk ~= Perks.MAX) 
    and (_character:getPerkLevel(_scrapDef.perk) < (SandboxVars.LevelForDismantleXPCutoff )or _scrapDef.perk == Perks.Electricity )then
    --and (_character:getPerkLevel(_scrapDef.perk) < 3 or _scrapDef.perk == Perks.Electricity )then
        -- give XP
        local multiplier = 1;
        if self.scrapSize == "Medium" then
            multiplier = 2;
        elseif self.scrapSize == "Large" then
            multiplier = 3;
        end
        addXp(_character, _scrapDef.perk, 5 * multiplier);
    end
end

function ISMoveableSpriteProps:getChanceByDef(scrapDef, chr)
	if ISMoveableDefinitions.cheat then
		return 100;
	end
    local chance = 10 + chr:getPerkLevel(scrapDef.perk)*10;
    if scrapDef.baseChance then
        chance = chance + scrapDef.baseChance;
    end
    if chance < 0 then chance = 0 end
    if chance > 100 then chance = 100 end
    return chance;
end

function ISMoveableSpriteProps:canScrapObject(_character)
    local canScrap = false;
    local chance = 0;
    local perkName;
    local result = {};

    if self.canScrap and self.isFromObject and self.object:getSquare() and _character and instanceof(_character,"IsoGameCharacter") then
        if self.isMultiSprite then
            local grid = self:getSpriteGridInfo(self.object:getSquare(), true);
            if not grid or #grid<=0 then
                canScrap = false;
            else
                for i,member in ipairs(grid) do
                    canScrap = self:canScrapObjectInternal(result, member.object);
                    if not canScrap then
                        break;
                    end
                end
            end
        else
            canScrap = self:canScrapObjectInternal(result, self.object);
        end
        if self.material then
            result.craftValid = ISMoveableDefinitions:getInstance().isScrapDefinitionValid( self.material );
            canScrap = canScrap and result.craftValid;
        end

        if self.scrapUseTool then
            result.haveTool = self:hasScrapTool( _character );
            result.haveTool2 = self:hasScrapTool( _character, true );
            canScrap = canScrap and result.haveTool and result.haveTool2;
        end

        if canScrap then
            if self.scrapUseSkill then
                chance, perkName = self:getScrapSkillChance( _character );
            else
                chance = 100;
            end
        end
    end
	if ISMoveableDefinitions.cheat then
		canScrap = true;
		chance = 100;
	end
-- 	print("Result" .. tostring(result))
-- 	print("chance" .. tostring(chance))
-- 	print("perkName" .. tostring(perkName))
    result.canScrap = canScrap;
    return result, chance, perkName;
end

function ISMoveableSpriteProps:canScrapObjectInternal(_result, _object)
    self.yOffsetCursor = _object and _object:getRenderYOffset() or 0;
    if not _result.containerFull then
        _result.containerFull = not self.object:isObjectNoContainerOrEmpty();
    end
    local canScrap = not _object or _object:isObjectNoContainerOrEmpty();
    if canScrap and self.isTable then
        canScrap = not _object:getSquare():Is("IsTableTop") and _object == self:getTopTable(_object:getSquare());
    end
    if canScrap and instanceof(_object, "IsoDoor") and _object:isBarricaded() then
        canScrap = false
    end
    if canScrap and instanceof(_object, "IsoThumpable") and _object:isDoor() and _object:isBarricaded() then
        canScrap = false
    end
    if canScrap and instanceof(_object, "IsoThumpable") and _object:isDoorFrame() and _object:getSquare():getDoor(_object:getNorth()) then
        canScrap = false
    end
    if canScrap and instanceof(_object, "IsoThumpable") and _object:isWindow() and _object:getSquare():getWindow(_object:getNorth()) then
        canScrap = false
    end
    -- As with ISDestroyCursor, the floor at the top of a staircase cannot be destroyed.
    if canScrap and self:isFloorAtTopOfStairs(_object) then
        canScrap = false
    end
    if canScrap and self.isWaterCollector then
        if _object and _object:hasFluid() then
            canScrap = false
        end
    end
    return canScrap;
end

function ISMoveableSpriteProps:isFloorAtTopOfStairs(object)
    if not object then return false end
    if object:getZ() == 0 then return false end
    local props = object:getProperties()
    if not props:Is(IsoFlagType.solidfloor) then return false end
    local square = getCell():getGridSquare(object:getX() + 1, object:getY(), object:getZ() - 1)
    if square and square:Has(IsoObjectType.stairsTW) then return true end
    square = getCell():getGridSquare(object:getX(), object:getY() + 1, object:getZ() - 1)
    if square and square:Has(IsoObjectType.stairsTN) then return true end
    return false
end

function ISMoveableSpriteProps:getScrapSkillChance( _player )
    local chance = 100;
    local perkName;
    if _player and self.canScrap then
        local scrapDef =  ISMoveableDefinitions:getInstance().getScrapDefinition( self.material );
        if scrapDef and scrapDef.perk then
            chance = 10 + _player:getPerkLevel(scrapDef.perk)*10;
            perkName = scrapDef.perkName;
            if scrapDef.baseChance then
                chance = chance + scrapDef.baseChance;
            end
        end
    end
    if chance < 1 then
        chance = 1;
    end
    if chance > 100 then chance = 100; end
    return chance, perkName;
end

-- return tool if found, true if no tools are defined for this material, false on fail.
function ISMoveableSpriteProps:hasScrapTool( _player, _doSecond )
    if _player then
        local inventory = _player:getInventory();
        local scrapDef =  ISMoveableDefinitions:getInstance().getScrapDefinition( self.material );
        if scrapDef then
            local tools = _doSecond and scrapDef.tools2 or scrapDef.tools;
            if tools then
                if #tools <=0 then return true; end --in case secondary toolset has no items.
                for _,v in ipairs(tools) do
                    if v == "Base.BlowTorch" then
                        local item = inventory:getFirstTypeEvalRecurse(v, function(it) return it:getCurrentUsesFloat() >= 0.1 end)
                        if item then
                            return item
                        end
                    else
                        local item = inventory:getFirstTypeRecurse(v);
                        if item then
                            return item;
                        end
                    end
                end
            end
        end
    end
    return false;
end

function ISMoveableSpriteProps:getScrapActionTime( _player )
    --if self.canScrap and self.isFromObject and self.object:getSquare() then
    if self.canScrap and _player then
        local scrapDef =  ISMoveableDefinitions:getInstance().getScrapDefinition( self.material );
        if scrapDef then
            local actionTime = scrapDef.baseActionTime;
            if scrapDef.perk then
                local perkLevel = _player:getPerkLevel(scrapDef.perk);
                actionTime = actionTime - (actionTime*(perkLevel*0.03));
            end
            return actionTime;
        end
    end
    --print("default action time");
    return 100;
end

function ISMoveableSpriteProps:getScrapSound( _character )
    if self.canScrap and self.isFromObject and self.object:getSquare() then
        local scrapDef =  ISMoveableDefinitions:getInstance().getScrapDefinition( self.material );
        if scrapDef then
            if scrapDef.isWav then
--                return getSoundManager():PlayWorldSoundWav(scrapDef.sound, _character:getCurrentSquare(), 0, 15, 2, true);
                return _character:playSound(scrapDef.sound)
            else
                addSound(_character, _character:getX(), _character:getY(), _character:getZ(), 10, 5);
                return _character:playSound(scrapDef.sound)
--                local sound = getSoundManager():PlayWorldSound(scrapDef.sound, self.object:getSquare(), 0.2, 20, 1.0, 3, true);
--                return sound;
            end
        end
    end
end

function ISMoveableSpriteProps:scrapObjectViaCursor( _character, _square, _origSpriteName, _moveCursor )
    self:scrapObject(_character);
    if _moveCursor then
        _moveCursor:clearCache()
    end
end

function ISMoveableSpriteProps:startScrapAction( _action )
    if self.canScrap then
        local scrapDef = ISMoveableDefinitions:getInstance().getScrapDefinition( self.material )
        if scrapDef then
            if scrapDef.recipeAnimNode then
                _action:setActionAnim(scrapDef.recipeAnimNode)
                _action:setOverrideHandModels(scrapDef.recipeProp1, scrapDef.recipeProp2)
                return true
            end
        end
    end
    return false
end


function ISMoveableSpriteProps:canRepairObject(_character)
    local canRepair = false;
    local chance = 0;
    local perkName;
    local result = {};

    if self.isFromObject and self.object:getSquare() and _character and instanceof(_character,"IsoGameCharacter") then
    --if self.isFromObject and self.object:getSquare() and _character and instanceof(_character,"IsoGameCharacter") then
        --if instanceof(self.object, "IsoThumpable") or instanceof(self.object, "IsoDoor") then
            if self.isMultiSprite then
                local grid = self:getSpriteGridInfo(self.object:getSquare(), true);
                if not grid or #grid<=0 then
                    canRepair = false;
                else
                    for _,member in ipairs(grid) do
                        canRepair = self:canRepairObjectInternal(result, member.object);
                        if not canRepair then
                            break;
                        end;
                    end;
                end;
            else
                local extraObjs = self:getAdditionalObjects(self.object);
                if #extraObjs > 0 then
                    for _, object in ipairs(extraObjs) do
                        canRepair = self:canRepairObjectInternal(result, object);
                        if not canRepair then
                            break;
                        end;
                    end;
                else
                    canRepair = self:canRepairObjectInternal(result, self.object);
                end;
            end;

            if canRepair then
                if canRepair and self.material and self.material ~= "Undefined" then
                    canRepair = ISMoveableDefinitions:getInstance().isRepairDefinitionValid( self.material );
                end

                if canRepair and self.material2 and self.material2 ~= "Undefined" then
                    canRepair = ISMoveableDefinitions:getInstance().isRepairDefinitionValid( self.material2 );
                end

                if canRepair and self.material3 and self.material3 ~= "Undefined" then
                    canRepair = ISMoveableDefinitions:getInstance().isRepairDefinitionValid( self.material3 );
                end

                result.craftValid = canRepair;
            end

            if canRepair and self.object then
                local healthPercent = 1 - self:getRepairDamageFactor(self.object);
                local isWorthRepairing = healthPercent <= 0.95 and healthPercent >= 0.20;
                result.haveTool = self:hasRepairTool( _character );
                result.haveTool2 = self:hasRepairTool( _character, true );
                result.hasParts = self:hasRepairParts( _character );
                canRepair = isWorthRepairing and result.haveTool and result.haveTool2 and result.hasParts;
                --all repairs use some level of skill
                chance, perkName = self:getRepairSkillChance( _character );
            else
                canRepair = false;
            end;
        --end;

        if ISMoveableDefinitions.cheat then
            canRepair = true;
            chance = 100;
        end;
    end;
    --print("Result")
    --for k, v in pairs(result) do print(k, v) end;
    --print("chance" .. tostring(chance))
    --print("perkName" .. tostring(perkName))
    result.canRepair = canRepair;
    return result, chance, perkName;
end

function ISMoveableSpriteProps:canRepairObjectInternal(_result, _object)
    self.yOffsetCursor = _object and _object:getRenderYOffset() or 0;
    if not _result.containerFull then
        _result.containerFull = not self.object:isObjectNoContainerOrEmpty();
    end
    local canRepair = not _object or _object:isObjectNoContainerOrEmpty();
    if canRepair and self.isTable then
        canRepair = not _object:getSquare():Is("IsTableTop") and _object == self:getTopTable(_object:getSquare());
    end
    if canRepair and instanceof(_object, "IsoDoor") and _object:isBarricaded() then
        canRepair = false
    end
    if canRepair and instanceof(_object, "IsoThumpable") and _object:isDoor() and _object:isBarricaded() then
        canRepair = false
    end
    if canRepair and instanceof(_object, "IsoThumpable") and _object:isDoorFrame() and _object:getSquare():getDoor(_object:getNorth()) then
        canRepair = false
    end
    if canRepair and instanceof(_object, "IsoThumpable") and _object:isWindow() and _object:getSquare():getWindow(_object:getNorth()) then
        canRepair = false
    end
    -- As with ISDestroyCursor, the floor at the top of a staircase cannot be destroyed.
    if canRepair and self:isFloorAtTopOfStairs(_object) then
        canRepair = false
    end
    if canRepair and self.isWaterCollector then
        if _object and _object:hasFluid() then
            canRepair = false
        end
    end
    --print("internal: " .. tostring(canRepair))
    return canRepair;
end

-- -- -- -- --
-- -- -- -- --
-- -- -- -- --

-- This is a lightweight version of ISMoveableSpriteProps for IsoThumpables that can be dismantled.
-- Possibly this can be removed if the IsoThumpable sprites had the appropriate properties.
ISThumpableSpriteProps = {}
setmetatable(ISThumpableSpriteProps, ISMoveableSpriteProps);

function ISThumpableSpriteProps.new(object)
    local o = {}
    setmetatable(o, { __index = ISThumpableSpriteProps })
    o.sprite = object:getSprite()
    if o.sprite then
        o.spriteName = o.sprite:getName()
        o.isFromObject = true
        o.object = object
        o.name = "Scrapable object"
        o.material = "Undefined"
        o.material2 = "Undefined"
        o.material3 = "Undefined"
        local props = o.sprite:getProperties()
        if props then
            o.groupName = props:Is("GroupName") and props:Val("GroupName") or nil
            o.customName = props:Is("CustomName") and props:Val("CustomName") or nil
            if o.groupName and o.customName then
                o.name = o.groupName .. " " .. o.customName
            elseif o.customName then
                o.name = o.customName
            elseif object:getName() and object:getName() ~= "" then
                o.name = object:getName()
            end
            o.material = props:Is("Material") and props:Val("Material");
            o.material2 = props:Is("Material2") and props:Val("Material2")~="Undefined" and props:Val("Material2");
            o.material3 = props:Is("Material3") and props:Val("Material3")~="Undefined" and props:Val("Material3");
        end
        o.canScrap = ISMoveableDefinitions:getInstance().isScrapDefinitionValid( o.material );
        o.scrapThumpable = o.canScrap;
    end
    return o
end

function ISThumpableSpriteProps:getYOffsetCursor()
    return 0
end

function ISThumpableSpriteProps:getInfoPanelDescription( _square, _object, _player, _mode )
    local infoTable = {};
    local bR,bG,bB = ISMoveableSpriteProps.bhc:getR()*255, ISMoveableSpriteProps.bhc:getG()*255, ISMoveableSpriteProps.bhc:getB()*255
    local gR,gG,gB = ISMoveableSpriteProps.ghc:getR()*255, ISMoveableSpriteProps.ghc:getG()*255, ISMoveableSpriteProps.ghc:getB()*255
    if _mode == "repair" then
        --for stairs and lamp on pillar repair
        return ISMoveableSpriteProps.getInfoPanelDescription( self, _square, _object, _player, _mode );
    end;
    if _mode ~= "scrap" or not self.scrapThumpable then
        return ISMoveableSpriteProps.addLineToInfoTable( infoTable, getText("IGUI_NoCanScrap"), bR,bG,bB )
    end
    infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, getText("IGUI_Name")..":", 255, 255, 255, Translator.getMoveableDisplayName(self.name), gR,gG,gB )

    local skillText = PerkFactory.getPerkName(Perks.Woodwork)
    infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, getText("IGUI_Skill")..":", 255, 255, 255, skillText, getColorValues(true) )

    local hasTool = _player:getInventory():containsTagEvalRecurse("Saw", predicateNotBroken)
    infoTable = self:addToolString(infoTable, "Saw", hasTool)

    hasTool = _player:getInventory():containsTagEvalRecurse("Screwdriver", predicateNotBroken)
    infoTable = self:addToolString(infoTable, "Screwdriver", hasTool)

    return infoTable
end

function ISThumpableSpriteProps:addToolString(infoTable, tag, hasTool)
    local r,g,b = getColorValues(hasTool)
    local items = getScriptManager():getItemsTag(tag)
    if items:isEmpty() then
        infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, getText("IGUI_Tool")..":", 255, 255, 255, tag, r, g, b )
        return
    end
    local first = true
    for i=1,items:size() do
        local scriptItem = items:get(i-1)
        if first then
            infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, getText("IGUI_Tool")..":", 255, 255, 255, scriptItem:getDisplayName(), r, g, b )
        else
            infoTable = ISMoveableSpriteProps.addLineToInfoTable( infoTable, "", 255, 255, 255, scriptItem:getDisplayName(), r, g, b )
        end
        first = false
    end
    return infoTable
end

function ISThumpableSpriteProps:walkToAndEquip( _character, _square, _mode )
    if _mode ~= "scrap" and _mode ~= "repair" then return false end
    if luautils.walkAdj(_character, _square, false) then
        local tool = _character:getInventory():getFirstTagEvalRecurse("Saw", predicateNotBroken)
        if not tool then return false end
        ISWorldObjectContextMenu.equip(_character, _character:getPrimaryHandItem(), tool:getType(), true)

        tool = _character:getInventory():getFirstTagEvalRecurse("Screwdriver", predicateNotBroken)
        if not tool then return false end
        ISWorldObjectContextMenu.equip(_character, _character:getSecondaryHandItem(), tool:getType(), false)
        return true
    end
    return false
end

function ISThumpableSpriteProps:getScrapActionTime( _character )
    return 200 - (_character:getPerkLevel(Perks.Strength) * 10)
end

function ISThumpableSpriteProps:getScrapSound( _character )
    if self.canScrap and self.isFromObject and self.object:getSquare() then
        addSound(_character, _character:getX(), _character:getY(), _character:getZ(), 10, 5)
--        local sound = getSoundManager():PlayWorldSound("PZ_Saw", self.object:getSquare(), 0.2, 20, 1.0, 3, true)
--        return sound
        return _character:playSound("Sawing")
    end
end

function ISThumpableSpriteProps:scrapObjectViaCursor( _character, _square, _origSpriteName, _moveCursor )
    -- This is from the old ISDismantleAction
    
    for k,v in pairs(self.object:getModData()) do
        if luautils.stringStarts(k, "need:") then
            local type = luautils.split(k, ":")[2]
            if type == "Base.Torch" then
                -- Big hack for ISLightSource
                self.object:toggleLightSource(false)
                local item = instanceItem(type)
                if item then
                    item:setUsedDelta(0)
                    self.object:getSquare():AddWorldInventoryItem(item, 0, 0, 0)
                end
                item = self.object:removeCurrentFuel(nil)
                if item then
                    self.object:getSquare():AddWorldInventoryItem(item, 0, 0, 0)
                end
            else
                local count = ZombRand(tonumber(v))+1
                for i=1,count do
                    self.object:getSquare():AddWorldInventoryItem(type, 0, 0, 0)
                end
            end
        end
    end

    if isClient() then
        local sq = self.object:getSquare()
        local args = { x = sq:getX(), y = sq:getY(), z = sq:getZ(), index = self.object:getObjectIndex() }
        sendClientCommand(_character, 'object', 'OnDestroyIsoThumpable', args)
    end

    -- Dismantle all 3 stair objects (and sometimes the floor at the top)
    local stairObjects = buildUtil.getStairObjects(self.object)
    if #stairObjects > 0 then
        for i=1,#stairObjects do
            stairObjects[i]:getSquare():transmitRemoveItemFromSquare(stairObjects[i])
        end
    else
        self.object:getSquare():transmitRemoveItemFromSquare(self.object)
    end

    ISInventoryPage.dirtyUI()

    if _moveCursor then
        _moveCursor:clearCache()
    end
end

function ISThumpableSpriteProps:canScrapObject(playerObj)
    local result = { canScrap = false }
    local chance = 0
    local perkName
    if self.scrapThumpable then
        result.canScrap = true
        chance = 10 + playerObj:getPerkLevel(Perks.Woodwork) * 10
        perkName = "Woodwork"
    end
    return result, chance, perkName
end

function ISThumpableSpriteProps:startScrapAction( _action )
    _action:setActionAnim("SawLog")
    _action:setOverrideHandModels(_action.character:getPrimaryHandItem(), nil)
    return true
end

function ISMoveableSpriteProps:getRepairSkillChance( _player )
    local chance = 100;
    local perkName;
    if _player and self.canScrap then
        local repairDef =  ISMoveableDefinitions:getInstance().getRepairDefinition( self.material );
        if repairDef and repairDef.perk then
            chance = 10 + _player:getPerkLevel(repairDef.perk)*10;
            perkName = repairDef.perkName;
            if repairDef.baseChance then
                chance = chance + repairDef.baseChance;
            end;
        end;
    end;
    if chance < 1 then chance = 1; end;
    if chance > 100 then chance = 100; end;
    return chance, perkName;
end

function ISMoveableSpriteProps:checkForRepairPart( _inventory, _itemType, _amount, _consume)
    local scriptItem = ScriptManager.instance:FindItem(_itemType);
    if instanceof(scriptItem, "DrainableComboItem") then
        return _inventory:getFirstTypeEvalRecurse(_itemType, function(it) return it:getCurrentUses() >= _amount; end) ~= nil;
    else
        return _inventory:getItemCountRecurse(_itemType) >= _amount;
    end;
end

function ISMoveableSpriteProps:consumeRepairPart( _inventory, _itemType, _amount )
    local scriptItem = ScriptManager.instance:FindItem(_itemType);
    local itemObj;
    if instanceof(scriptItem, "DrainableComboItem") then
        itemObj = _inventory:getFirstTypeEvalRecurse(_itemType, function(it) return it:getCurrentUses() >= _amount; end);
        if itemObj then
            for _ = 1, _amount do
                itemObj:Use();
            end;
            return true;
        end;
    else
        if _inventory:getItemCountRecurse(_itemType) >= _amount then
            sendRemoveItemsFromContainer(_inventory, _inventory:RemoveAll(_itemType, _amount));
            return true;
        end;
    end;
    return false;
end

function ISMoveableSpriteProps:hasRepairParts( _player )
    if _player then
        local inventory = _player:getInventory();
        local hasAnOptionalPart = false;
        local needsAnOptionalPart = false;
        local parts = self:getAllRepairParts();
        if parts then
            if #parts <=0 then return true; end; --in case it requires nothing
            local hasItem;
            for _, part in ipairs(parts) do
                hasItem = self:checkForRepairPart(inventory, part.itemType, part.amount);
                if part.required then
                    if not hasItem then return false; end; --missing a required part, return
                else
                    needsAnOptionalPart = true;
                    if hasItem then
                        hasAnOptionalPart = true;
                    end;
                end;
            end;
        end;
        --has all required parts so return the optional, else return true if no optional.
        if needsAnOptionalPart then
            return hasAnOptionalPart;
        else
            return true;
        end;
    end;
    return false;
end

-- return parts if found, true if no tools are defined for this material, false on fail.
function ISMoveableSpriteProps:hasRepairTool( _player, _doSecond )
    if _player then
        local inventory = _player:getInventory();
        local repairDef =  ISMoveableDefinitions:getInstance().getRepairDefinition( self.material );
        if repairDef then
            local tools = _doSecond and repairDef.tools2 or repairDef.tools;
            if tools then
                if #tools <=0 then return true; end --in case secondary toolset has no items.
                for _,v in ipairs(tools) do
                    if v == "Base.BlowTorch" then
                        local item = inventory:getFirstTypeEvalRecurse(v, function(it) return it:getCurrentUsesFloat() >= 0.1 end)
                        if item then
                            return item
                        end
                    else
                        local item = inventory:getFirstTypeRecurse(v);
                        if item then
                            return item;
                        end
                    end
                end
            end
        end
    end
    return false;
end

function ISMoveableSpriteProps:getRepairActionTime( _player )
    if self.canScrap and _player then
        local repairDef =  ISMoveableDefinitions:getInstance().getRepairDefinition( self.material );
        if repairDef then
            local actionTime = repairDef.baseActionTime;
            if repairDef.perk then
                local perkLevel = _player:getPerkLevel(repairDef.perk);
                actionTime = actionTime - (actionTime*(perkLevel*0.03));
            end
            return actionTime;
        end
    end
    --print("default action time");
    return 100;
end

function ISMoveableSpriteProps:getRepairSound( _character )
    if self.canScrap and self.isFromObject and self.object:getSquare() then
        local repairDef =  ISMoveableDefinitions:getInstance().getRepairDefinition( self.material );
        if repairDef then
            if repairDef.isWav then
                return _character:playSound(repairDef.sound)
            else
                addSound(_character, _character:getX(), _character:getY(), _character:getZ(), 10, 5);
                return _character:playSound(repairDef.sound)
            end
        end
    end
end

function ISMoveableSpriteProps:repairObjectViaCursor( _character, _square, _origSpriteName, _moveCursor )
    ISMoveableSpriteProps.repairObject(self, _character);
    if _moveCursor then
        _moveCursor:clearCache()
    end
end

function ISMoveableSpriteProps:isBreakablePlant(_object)
    return false -- TODO
end

--[[
-- Function that hooks to the creation dynamic recipes for movable inventory items
--]]

function ISMoveableSpriteProps.OnDynamicMovableRecipe(_sprite, _recipe, _item, _player)
    local props = ISMoveableSpriteProps.new( _sprite );
    --print("can scrap = "..tostring(props.canScrap))
    --print("item = "..tostring(_item:getFullType()));
    --[[
    props.scrapToolUses
    --]]
    if props.canScrap and (not props.isMultiSprite) and props.material then
        local scrapDef = ISMoveableDefinitions:getInstance().getScrapDefinition( props.material );

        --_recipe:setSource(_item:getFullType());
        _recipe:setTime( props:getScrapActionTime( _player ) );

        local tools = "";
        if scrapDef.tools and #scrapDef.tools>0 then
            for k,v in ipairs(scrapDef.tools) do
                tools = tools..v;
                if k<#scrapDef.tools then
                    tools = tools.."/";
                end
            end
            --print("tools = "..tools);
            _recipe:setTool(tools, true);
        end

        if scrapDef.tools2 and #scrapDef.tools2>0 then
            tools = "";
            for k,v in ipairs(scrapDef.tools2) do
                tools = tools..v;
                if k<#scrapDef.tools2 then
                    tools = tools.."/";
                end
            end
            --print("tools2 = "..tools);
            _recipe:setTool(tools, false);
        end

        _recipe:setSource(_item:getFullType());

        local items = scrapDef.returnItemsStatic or {}; --scrapDef.returnItems; --ISMoveableDefinitions:getInstance().getScrapItems( props.material );
        if (not items) or #items<1 then
            items = scrapDef.returnItems;
        end

        if items and #items>0 and items[1].returnItem then
            --print("return item = "..tostring(items[1].returnItem))
            _recipe:setResult(items[1].returnItem, 1);

            if _recipe:getResult():getModule() then
                local name = getText("IGUI_Scrap") .. " " .. _item:getDisplayName();
                _recipe:setName(name);
                _recipe:setWorldSprite(_item:getWorldSprite());
                if scrapDef.perk then
                    _recipe:setXpPerk(scrapDef.perk);
                end

                _recipe:setOnCreate("Recipe.OnCreate.DynamicMovable");
                _recipe:setOnXP("Recipe.OnGiveXP.DynamicMovable");

                if scrapDef.recipeAnimNode then
                    _recipe:setAnimNode(scrapDef.recipeAnimNode)
                end

                --fixme, currently setting screwdriver as default prop, might leave it like that as there are many variations in tools and objects being dismantled?
                if scrapDef.recipeProp1 then
                    _recipe:setProp1(scrapDef.recipeProp1);
                else
                    _recipe:setProp1("Screwdriver");
                end

                if scrapDef.recipeProp2 then
                    _recipe:setProp2(scrapDef.recipeProp2);
                end
                
                if scrapDef.recipeSound then
                    _recipe:setSound(scrapDef.recipeSound)
                end

                --print("recipe is correct")
                _recipe:setValid(true);
            end
        end
    end
end

Events.OnDynamicMovableRecipe.Add(ISMoveableSpriteProps.OnDynamicMovableRecipe);

