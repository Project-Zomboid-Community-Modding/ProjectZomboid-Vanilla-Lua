--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

--[[
    Displays a fluidcontainer, both inventoryitem or isoobject.
--]]

require "ISUI/ISPanel"

ISFluidContainerPanel = ISPanel:derive("ISFluidContainerPanel");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

function ISFluidContainerPanel:initialise()
    ISPanel.initialise(self)
end

function ISFluidContainerPanel:createChildren()
    local y = UI_BORDER_SPACING+1
    self.innerHeight = BUTTON_HGT*4 + y*2;

    if self.isIso then
        self:getIsoObjectTextures();
    end

    if self.doTitle then
        y = BUTTON_HGT+1;
    end

    self.innerY = y;

    self.fluidBar = ISFluidBar:new (self.width - BUTTON_HGT - UI_BORDER_SPACING - 1, y, BUTTON_HGT, self.innerHeight, self.player);
    self.fluidBar:initialise();
    self.fluidBar:instantiate();
    self:addChild(self.fluidBar);

    self.containerBox = {
        x = UI_BORDER_SPACING+1,
        y = y,
        w = self.width - self.fluidBar.width - UI_BORDER_SPACING*3 - 2,
        h = self.innerHeight,
    }

	--if self.isIso and (#self.textureList > 0) then
	--	self.containerBox.x = UI_BORDER_SPACING+1+64*2 + UI_BORDER_SPACING
	--end

    if self.isItem then
        self.itemDropBox = ISItemDropBox:new (self.containerBox.x + UI_BORDER_SPACING+1, self.containerBox.y+UI_BORDER_SPACING+1, BUTTON_HGT, BUTTON_HGT, true, self, ISFluidContainerPanel.addItem, ISFluidContainerPanel.removeItem, ISFluidContainerPanel.verifyItem, nil );
        self.itemDropBox.allowDropAlways = true;
        self.itemDropBox.onMouseDown = ISFluidContainerPanel.clickedDropBox;
        self.itemDropBox.player = self.player;
        self.itemDropBox:initialise();
        if self.container then
            self.itemDropBox:setStoredItem( self.container:getOwner() );
        end
        self.itemDropBox:setToolTip( true, getText("Fluid_Drag_Container") );
        self.itemDropBox.toolTipTextItem = getText("Fluid_Dropbox_Remove");
        self:addChild(self.itemDropBox);
    end

    --local w = (self.pad*3) + self.fluidBar:getWidth() + self.containerBox.w;
    --self:setWidth(w);

    --local h = self.innerY + self.innerHeight + self.pad;
    --self:setHeight(h);

    --align ui things:
    self:setIsLeft(self.isLeft);

    if self.container and self.container:getFluidContainer() then
        --self.fluidBar:setFromContainer(self.container);
        self.fluidBar:setContainer(self.container:getFluidContainer());
    end
end

function ISFluidContainerPanel:clickedDropBox(x, y)
    local self = self.parent;
    local validItems = self.itemDropBox:getValidItems();
    if #validItems == 0 then return end
    local parent = self.parent;
    local playerNum = self.player:getPlayerNum()
    local oldFocus = JoypadState.players[playerNum+1] and JoypadState.players[playerNum+1].focus or nil
    local x = parent:getAbsoluteX() + parent:getWidth();
    local y = parent:getAbsoluteY() + self:getY();
    local context = ISContextMenu.get(playerNum, x, y)
    local addedItems = {};
    for i,item in ipairs(validItems) do
        local name = item:getName() .. " (" .. round(item:getFluidContainer():getAmount() * 1000, 2) .. " mL)";
        if not addedItems[name] then
            addedItems[name] = item;
        end
    end
    for i,v in pairs(addedItems) do
        context:addOption(i, self.itemDropBox, ISItemDropBox.onDropItem, v);
    end
    if self.isLeft then
        x = parent:getAbsoluteX() - context:getWidth();
        context:setSlideGoalX(x + 20, x);
    end
    context:bringToTop();
    if oldFocus then
        context.origin = oldFocus
        context.mouseOver = 1
        setJoypadFocus(playerNum, context)
    end
end

function ISFluidContainerPanel:drawTextureIso(texture, x, y, a, r, g, b)
    if texture and texture:getWidthOrig() == 64 * 2 and texture:getHeightOrig() == 128 * 2 then
        ISUIElement.drawTexture(self, texture, x, y, a, r, g, b)
    else
        ISUIElement.drawTextureScaledUniform(self, texture, x, y, 2.0, a, r, g, b)
    end
end

function ISFluidContainerPanel:drawTextureOutlines(texture, x, y)
    local c = self.outlineColor;
    self:StartOutline(texture, 0.15, c.r, c.g, c.b, c.a)
    self:drawTextureIso(texture, x, y, 1.0,1.0,1.0,1.0);
    self:EndOutline();
end

function ISFluidContainerPanel:prerender()
    ISPanel.prerender(self);

    if self.isInvalid then
        local c = self.invalidColor;
        self:drawRect(0, 0, self.width, self.height, c.a, c.r, c.g, c.b);
    end

    self:drawRect(self.containerBox.x, self.containerBox.y, self.containerBox.w, self.containerBox.h, 1.0, 0, 0, 0);

    if (not self.isIso) or (not self.owner) or (not instanceof(self.owner, "IsoObject")) then
        return;
    end
    local ownerOffsetY = self.owner:getRenderYOffset() * Core.getTileScale();

--    -- In case the container is IsoObject draw the square tiles, outline the owner object.
--    if self.textureList and #self.textureList > 0 then
--        local x = UI_BORDER_SPACING+1;
--        local y = self:getHeight() - 128*2;
--        for i = 1, #self.textureList do
--            local children = self.textureList[i].children;
--            local texture = self.textureList[i].texture;
--            local offsetY = -self.textureList[i].offsetY;-- / Core.getTileScale()
--            --offsetY = offsetY + 50;
--            if self.textureList[i].texture == self.ownerTexture and self.textureList[i].offsetY == ownerOffsetY then
--                self:drawTextureIso(texture, x, y + offsetY, 1);
--
--                if children and #children>0 then
--                    for j=1, #children do
--                        local childTexture = children[j].texture;
--                        local childOffsetY = -children[j].offsetY;-- / Core.getTileScale()
--                        self:drawTextureIso(childTexture, x, y + childOffsetY);
--                    end
--                end
--
--                if self.doOwnerOutlines then
--                    self:drawTextureOutlines(texture, x, y + offsetY);
--
--                    if children and #children>0 then
--                        for j=1, #children do
--                            local childTexture = children[j].texture;
--                            local childOffsetY = -children[j].offsetY;-- / Core.getTileScale()
--                            self:drawTextureOutlines(childTexture, x, y + childOffsetY);
--                        end
--                    end
--                end
--            else
--                self:drawTextureIso(texture, x, y + offsetY, 0.5);
--            end
--        end
--    end
end

function ISFluidContainerPanel:render()
    ISPanel.render(self);

    local c;

    if self.doTitle and self.title then
        c = self.textColor;
        self:renderText(self.title, self.width/2,(BUTTON_HGT-FONT_HGT_SMALL)/2, c.r,c.g,c.b,c.a,UIFont.Small, self.drawTextCentre);
    end

    local name = false

    local x = self.containerBox.x + UI_BORDER_SPACING+1;
    local y = self.containerBox.y + UI_BORDER_SPACING+1;
	
    c = self.textColor;
    local containerNameRight = x
    if self.containerName then
        self:renderText(self.containerName, x,y+3, c.r,c.g,c.b,c.a,UIFont.Small);
        containerNameRight = x + getTextManager():MeasureStringX(UIFont.Small, self.containerName)
    else
        --try to get containerName automatically.
        if self.container and self.container:getFluidContainer() then
            name = self.container:getFluidContainer():getTranslatedContainerName();
        else
            if self.itemDropBox and self.itemDropBox.storedItem then
                name = self.itemDropBox.storedItem:getFluidContainer():getTranslatedContainerName();
            end
        end

        if name then
            local tx = x
            if self.itemDropBox then
                tx = self.itemDropBox:getRight() + UI_BORDER_SPACING
            end
            self:renderText(name, tx, y+3, c.r,c.g,c.b,c.a,UIFont.Small);
            containerNameRight = tx + getTextManager():MeasureStringX(UIFont.Small, name)
        end
    end

    --local fc = self:getContainer()
    if self:getContainer() then
        local capacity = self:getContainer():getCapacity();
        local stored = self:getContainer():getAmount();
        local free = capacity-stored;
        if self.info then
            if self.info.capacity.cache~=capacity then
                self.info.capacity.cache = capacity;
                self.info.capacity.value = FluidUtil.getAmountFormatted(capacity);
				if self:getContainer():isHiddenAmount() then
					self.info.capacity.value = getText("Fluid_Unknown");
				end
            end
            if self.info.stored.cache~=stored then
                self.info.stored.cache = stored;
                self.info.stored.value = FluidUtil.getAmountFormatted(stored);
				if self:getContainer():isHiddenAmount() then
					self.info.stored.value = getText("Fluid_Unknown");
				end
            end
            if self.info.free.cache~=free then
                self.info.free.cache = free;
                self.info.free.value = FluidUtil.getAmountFormatted(free);
				if self:getContainer():isHiddenAmount() then
					self.info.free.value = getText("Fluid_Unknown");
				end
            end

            local tagWid = math.max(
                    getTextManager():MeasureStringX(UIFont.Small, self.info.capacity.tag),
                    getTextManager():MeasureStringX(UIFont.Small, self.info.stored.tag),
                    getTextManager():MeasureStringX(UIFont.Small, self.info.free.tag)
            )
            local tagx = self.containerBox.x + UI_BORDER_SPACING + 1 + tagWid
            local valx = tagx + UI_BORDER_SPACING;


            y = self.containerBox.y + self.containerBox.h - FONT_HGT_SMALL - UI_BORDER_SPACING - 4;

            c = self.tagColor;
            self:renderText(self.info.free.tag, tagx,y, c.r,c.g,c.b,c.a,UIFont.Small, self.drawTextRight);
            c = self.textColor;
            self:renderText(self.info.free.value, valx,y, c.r,c.g,c.b,c.a,UIFont.Small);

            y = y - BUTTON_HGT;
            c = self.tagColor;
            self:renderText(self.info.stored.tag, tagx,y, c.r,c.g,c.b,c.a,UIFont.Small, self.drawTextRight);
            c = self.textColor;
            self:renderText(self.info.stored.value, valx,y, c.r,c.g,c.b,c.a,UIFont.Small);

            y = y - BUTTON_HGT;
            c = self.tagColor;
			
            self:renderText(self.info.capacity.tag, tagx,y, c.r,c.g,c.b,c.a,UIFont.Small, self.drawTextRight);
            c = self.textColor;
            self:renderText(self.info.capacity.value, valx,y, c.r,c.g,c.b,c.a,UIFont.Small);
        end
    end

    self.fluidBar:setX(self.containerBox.x + self.containerBox.w + UI_BORDER_SPACING);
    self:setWidth( math.max(self.containerBox.x + self.containerBox.w, self.fluidBar:getRight()) + UI_BORDER_SPACING+1 );

    c = self.borderOuterColor;
    self:drawRectBorder(0, 0, self.width, self.height, c.a, c.r, c.g, c.b);

    c = self.borderColor;
    self:drawRectBorder(self.containerBox.x, self.containerBox.y, self.containerBox.w, self.containerBox.h, c.a, c.r, c.g, c.b);
end

function ISFluidContainerPanel:renderText(_s, _x, _y, _r, _g, _b, _a, _font, _func)
    local alpha = 1.0;
    if _func then
        _func(self, _s, _x+1, _y-1, 0, 0, 0, alpha, _font);
        _func(self, _s, _x+1, _y+1, 0, 0, 0, alpha, _font);
        _func(self, _s, _x-1, _y+1, 0, 0, 0, alpha, _font);
        _func(self, _s, _x-1, _y-1, 0, 0, 0, alpha, _font);
        _func(self, _s, _x, _y, _r, _g, _b, _a, _font);
    else
        self:drawText(_s, _x+1, _y-1, 0, 0, 0, alpha, _font);
        self:drawText(_s, _x+1, _y+1, 0, 0, 0, alpha, _font);
        self:drawText(_s, _x-1, _y+1, 0, 0, 0, alpha, _font);
        self:drawText(_s, _x-1, _y-1, 0, 0, 0, alpha, _font);
        self:drawText(_s, _x, _y, _r, _g, _b, _a, _font);
    end
end

function ISFluidContainerPanel:addItem(_items)
    local list = ArrayList.new();
    for _,item in ipairs(_items) do
        if not list:contains(item) then
            list:add(item);
        end
    end
    if list:size()==1 then
        self:addItemAux(_items[1]);
        return;
    end
    local playerNum = self.player:getPlayerNum()
    local context = ISContextMenu.get(playerNum, self.itemDropBox:getAbsoluteX()+16, self.itemDropBox:getAbsoluteY()+16)
    list:clear();
    for _,item in ipairs(_items) do
        if not list:contains(item) then
            local option = context:addColorBoxOption(item:getName(), self, self.addItemAux, item)
            local c = item:getFluidContainer():getColor();
            option.color.r = c:getRedFloat();
            option.color.g = c:getGreenFloat();
            option.color.b = c:getBlueFloat();
            list:add(item);
        end
    end
    context.mouseOver = 1
end

function ISFluidContainerPanel:addItemAux( _item )
    if not (self.funcTarget and self.onContainerAdd) or not self.overrideAddFull then
        self.itemDropBox:setStoredItem( _item )
        self.fluidBar:setContainer(_item:getFluidContainer());
        self.container = ISFluidContainer:new(_item:getFluidContainer());
        self.containerCopy = _item:getFluidContainer():copy();
    end

    if self.funcTarget and self.onContainerAdd then
        self.onContainerAdd(self.funcTarget, _item, self)
    end
end

function ISFluidContainerPanel:removeItem()
    local oldItem = self.itemDropBox.storedItem;

    if not (self.funcTarget and self.onContainerRemove) or not self.overrideRemoveFull then
        self.itemDropBox:setStoredItem( nil )
        self.container = nil;
        self.fluidBar:setContainer(nil);
        if self.containerCopy then
            FluidContainer.DisposeContainer(self.containerCopy);
        end
        self.containerCopy = nil;
    end

    if self.funcTarget and self.onContainerRemove then
        self.onContainerRemove(self.funcTarget, oldItem, self);
    end
end

function ISFluidContainerPanel:verifyItem(_item)
    if self.funcTarget and self.onContainerVerify then
        return self.onContainerVerify(self.funcTarget, _item, self);
    else
        return _item and _item:getFluidContainer();
    end
end

function ISFluidContainerPanel:setIsLeft(_b)
    self.isLeft = _b;
    if not self.customTitle then
        self.title = self.isLeft and getText("Fluid_Source") or getText("Fluid_Target");
    end
--[[ This conflicts with code in render()
    if not self.isLeft then
        local x = UI_BORDER_SPACING+1;
        self.fluidBar:setX(x);
        x = x + self.fluidBar:getWidth() + UI_BORDER_SPACING;
        self.containerBox.x = x;
		if self.itemDropBox then
			self.itemDropBox:setX(self.containerBox.x + UI_BORDER_SPACING+1)
		end
    end
--]]
end

function ISFluidContainerPanel:setInvalid(_b)
    self.isInvalid = _b;
end

function ISFluidContainerPanel:setTitle(_title)
    self.customTitle = _title;
end

function ISFluidContainerPanel:setContainerName(_name)
    self.containerName = _name;
end

function ISFluidContainerPanel:getContainer()
    if self.container and self.container:getFluidContainer() then
        return self.container:getFluidContainer();
    --else
        --return self.itemDropBox and self.itemDropBox.storedItem and self.itemDropBox.storedItem:getFluidContainer();
    end
    return nil;
end

function ISFluidContainerPanel:getContainerOwner()
    if self.container then
        return self.container:getOwner();
    end
    return nil;
end

function ISFluidContainerPanel:getIsoObjectTextures()
    self.textureList = {};

    if (not self.isIso) or (not self.owner) or (not instanceof(self.owner, "IsoObject")) or (not self.owner:getTextureName()) then
        return;
    end
    self.ownerTexture = getTexture( self.owner:getTextureName() );
    if not self.ownerTexture then
        return;
    end
    local square = self.owner:getSquare();
    if not square then return end

    if square then
        if square:getFloor() and square:getFloor():getTextureName() and getTexture(square:getFloor():getTextureName()) then
            local t = { texture = getTexture(square:getFloor():getTextureName()), offsetY = 0 }
            table.insert( self.textureList, t );
        end

        for i = 1, square:getObjects():size()-1 do
            local obj = square:getObjects():get(i);
            if obj and obj:getTextureName() and getTexture(obj:getTextureName()) then
                local t = { texture = getTexture(obj:getTextureName()), offsetY = obj:getRenderYOffset() * Core.getTileScale() }
                table.insert(self.textureList, t);

                local sprList = obj:getChildSprites();
                if sprList and (not instanceof(obj,"IsoBarbecue")) then
                    local list_size 	= sprList:size();
                    if list_size > 0 then
                        t.children = {};
                        for i=list_size-1, 0, -1 do
                            local sprite = sprList:get(i):getParentSprite();
                            if sprite:getName() and getTexture(sprite:getName()) then
                                local child = { texture = getTexture(sprite:getName()), offsetY = obj:getRenderYOffset() * Core.getTileScale() }
                                table.insert(t.children, child);
                            end
                        end
                    end
                end
            end
        end
    end

    return self.textureList;
end

function ISFluidContainerPanel:hasValidContainer()
    if self.container then
        --check if iso still has square, check if item is in inventory
        return ISFluidUtil.validateContainer(self.container);
    --elseif self.itemDropBox and self.itemDropBox.storedItem then
        --if self.itemDropBox.storedItem:getFluidContainer() then
            --return ISFluidUtil.validateContainer(self.itemDropBox.storedItem:getFluidContainer());
        --end
    end
end

function ISFluidContainerPanel:setPanelLocked(_b)
    if self.itemDropBox then
        self.itemDropBox.isLocked = _b;
    end
end

function ISFluidContainerPanel:onClose()
    if self.containerCopy then
        FluidContainer.DisposeContainer(self.containerCopy);
        self.containerCopy = nil;
    end
end

function ISFluidContainerPanel:new (x, y, _player, _container, _doTitle, _isLeft, _isoHeight)
    local width = math.max(140 + (getCore():getOptionFontSizeReal()*40), 200); --160 is the smallest size that fits the smallest font size

    local height = BUTTON_HGT*4 + UI_BORDER_SPACING*3 + 4 + (_doTitle and BUTTON_HGT or UI_BORDER_SPACING);
    local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.x = x;
    o.y = y;
    o.background = false;
    o.backgroundColor = {r=0, g=0, b=0, a=0.0};
    o.borderColor = {r=0.6, g=0.6, b=0.6, a=1};
    o.borderOuterColor = {r=0.6, g=0.6, b=0.6, a=1};
    o.detailInnerColor = {r=0,g=0,b=0,a=1};
    o.textColor = {r=1,g=1,b=1,a=1}
    o.tagColor = {r=0.8,g=0.8,b=0.8,a=1}
    o.invalidColor = {r=0.6,g=0.2,b=0.2,a=1}
    o.width = width;
    o.height = height;
    o.anchorLeft = false;
    o.anchorRight = false;
    o.anchorTop = false;
    o.anchorBottom = false;

    o.player = _player;

    --205, 190, 112
    local col = {r=(205/255),g=(190/255),b=(112/255),a=1}

    -- the associated fluidcontainer
    o.container = _container;
    if o.container then
        o.owner = _container:getOwner();
        o.isIso = _container:isIsoPanel(); --instanceof(o.owner, "IsoObject");
        o.isItem = _container:isItem();
        o.containerCopy = _container:getFluidContainer():copy();
        --o.borderOuterColor = col;
    else
        o.isItem = true;
    end
    --if true draw this panel at IsoObject height even if its container is an item.
    o.isoHeight = _isoHeight;
    -- align as left sided panel
    o.isLeft = _isLeft;
    -- if true add a title.
    o.doTitle = _doTitle;
    o.title = o.isLeft and getText("Fluid_Source") or getText("Fluid_Target");
    o.customTitle = false;

    o.funcTarget = false;
    o.onContainerAdd = false;
    o.overrideAddFull = false;
    o.onContainerRemove = false;
    o.overrideRemoveFull = false;
    o.onContainerVerify = false;

    o.doOwnerOutlines = true;
    o.outlineColor = {r=0.85,g=0.82,b=0.78,a=1};
    o.containerName = false;

    --if set invalid draws invalid background color
    o.isInvalid = false;

    o.info = {
        capacity = { tag = getText("Fluid_Capacity")..": ", value = "0", cache = 0 },
        stored = { tag = getText("Fluid_Stored")..": ", value = "0", cache = 0 },
        free = { tag = getText("Fluid_Free")..": ", value = "0", cache = 0 },
    }
    return o
end