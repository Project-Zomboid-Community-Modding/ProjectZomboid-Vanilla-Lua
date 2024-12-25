--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

--[[
    Generic icon list box that takes a backing List<T> as data provider.
    Callbacks for events such as render must be provided to display the tiles properly depending on the Object type.

    (Also see TiledIconPanel which embeds this ui element but adds search box and page navigation widgets.)
--]]

require "ISUI/ISPanel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small);

ISTiledIconListBox = ISPanel:derive("ISTiledIconListBox");

function ISTiledIconListBox:initialise()
	ISPanel.initialise(self);
end

function ISTiledIconListBox:createChildren()
    ISPanel.createChildren(self);

    --self:setCapture(true);
    self:calculateTiles();
end

function ISTiledIconListBox:calculateLayout(_preferredWidth, _preferredHeight)
    self.minimumWidth = self.tileMarginX + (self.minimumColumns * (self.tileWidth + self.tileMarginX));
    self.minimumHeight = self.tileMarginY + (self.minimumRows * (self.tileHeight + self.tileMarginY));

    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);


    self:setWidth(width);
    self:setHeight(height);

    self:calculateTiles();

    self:focusPageOnSelectedTile();

    self.mouseOverTile = -1;
end

function ISTiledIconListBox:onResize()
    --ISUIElement.onResize(self)
    ISUIElement.onResize(self)
end

function ISTiledIconListBox:prerender()
    ISPanel.prerender(self);

    local dataOffset = self.currentPage * self.tileCount;

    local x, y;
    local index = 0;

    for row=0, self.rows-1 do
        for column=0, self.columns-1 do
            x = (column*self.columnWidth);
            y = (row*self.rowHeight);

            local idx = dataOffset + index;
            local data = self:getDataElement(idx);

            local renderX = x + (self.columnWidth/2) - (self.tileWidth/2);
            local renderY = y + (self.rowHeight/2) - (self.tileHeight/2);

            if self.mouseOverTile==index then
                self:drawRectStatic(renderX, renderY, self.tileWidth, self.tileHeight, 1.0, 0.2, 0.2, 0.2);
            elseif data and self.selectedTileData and data==self.selectedTileData then
                self:drawRectStatic(renderX, renderY, self.tileWidth, self.tileHeight, 1.0, 0.1, 0.1, 0.1);
            end

            self:renderTile(data, renderX+self.tilePadX, renderY+self.tilePadY, self.iconWidth, self.iconHeight, self.mouseOverTile==index);

            if data and self.selectedTileData and data==self.selectedTileData then
                self:drawRectBorderStatic(renderX, renderY, self.tileWidth, self.tileHeight, 1.0, 0.8, 0.8, 0.8);
            end

            index = index + 1;
        end
    end
end

function ISTiledIconListBox:render()
    ISPanel.render(self);
end

function ISTiledIconListBox:update()
    ISPanel.update(self);

end

function ISTiledIconListBox:getTileForCoordinate(_x, _y)
    local index = self:getTileIndexForCoordinate(_x, _y);
    if index>=0 then
        local dataOffset = self.currentPage * self.tileCount;
        return self:getDataElement(dataOffset + index);
    end
    return nil;
end

function ISTiledIconListBox:getTileIndexForCoordinate(_x, _y)
    local x = math.floor(_x / self.columnWidth);
    local y = math.floor(_y / self.rowHeight);
    local index = (y * self.columns) + x;
    if index>=0 and index<self.tileCount then
        return index;
    else
        return -1;
    end
end

function ISTiledIconListBox:getDataElement(_index)
    if _index>=0 and _index<self.dataArrayList:size() then
        return self.dataArrayList:get(_index);
    end
    return nil;
end

function ISTiledIconListBox:calculateTiles()
    local totalTileWidth = self.tileWidth + (self.tileMarginX * 2);
    local totalTileHeight = self.tileHeight + (self.tileMarginY * 2);

    self.columns = PZMath.max(self.minimumColumns, math.floor(self.width / totalTileWidth ));
    self.rows = PZMath.max(self.minimumRows, math.floor( self.height / totalTileHeight ));

    self.columnWidth = self.width / self.columns;
    self.rowHeight = self.height / self.rows;

    self.tileCount = self.columns * self.rows;

    self.pages = 0;

    if self.dataArrayList and self.dataArrayList:size()>0 then
        self.pages = math.ceil(self.dataArrayList:size()/self.tileCount);
    end

    self.currentPage = PZMath.clamp(PZMath.min(self.currentPage, self.pages-1), 0, self.pages-1);
    self:pageChanged();

    self.mouseOverTile = self:getTileIndexForCoordinate(self:getMouseX(), self:getMouseY());
end

function ISTiledIconListBox:renderTile(_tileData, _x, _y, _width, _height, _mouseover)
    if self.onRenderTile then
        self.onRenderTile(self, _tileData, _x, _y, _width, _height, _mouseover);
    else
        self:drawRectBorderStatic(_x, _y, _width, _height, 1.0, 0.5, 0.5, 0.5);
    end
end

function ISTiledIconListBox:onMouseDown(x, y)
    local tileIndex = self:getTileIndexForCoordinate(x, y);

    if tileIndex>=0 then
        local data = self:getTileForCoordinate(x, y);
        if (not data) or self.selectedTileData==data then
            return;
        end

        self.selectedTileData = data;

        getSoundManager():playUISound("UISelectListItem");

        if self.onClickTile then
            self.onClickTile(self.callbackTarget, data);
        end
    end
end

function ISTiledIconListBox:onMouseUp(x, y)
end

local function triggerMouseOver(_self)
    local dataOffset = _self.currentPage * _self.tileCount;
    local data = nil;
    if _self.mouseOverTile>=0 then
        data = _self:getDataElement(dataOffset + _self.mouseOverTile);
    end

    if _self.onHoverTile then
        _self.onHoverTile(_self.callbackTarget, data);
    end
end

function ISTiledIconListBox:onMouseMove(dx, dy)
	self.mouseOverTile = self:getTileIndexForCoordinate(self:getMouseX(), self:getMouseY());

    triggerMouseOver(self);
end

function ISTiledIconListBox:onMouseMoveOutside(x, y)
	self.mouseOverTile = -1;

    triggerMouseOver(self);
end

function ISTiledIconListBox:onMouseWheel(_del)
    self.currentPage = PZMath.clamp(self.currentPage+_del, 0, self.pages-1);
    self:pageChanged();
    if self.onPageScrolled then
        self:onPageScrolled(self.currentPage);
    end
    --print("scrolwheel del = "..tostring(_del)..", page = "..tostring(self.currentPage).."/"..tostring(self.pages));
    return true;
end

function ISTiledIconListBox:onPageScrolled(_newPage)
end

function ISTiledIconListBox:setCurrentPage(_page)
    self.currentPage = PZMath.clamp(_page, 0, self.pages-1);
    self:pageChanged();
end

function ISTiledIconListBox:getCurrentPage()
    return self.currentPage;
end

function ISTiledIconListBox:pageChanged()
    --self.lastMouseOverTile = -1;
    self.lastMouseOverTile = self:getTileIndexForCoordinate(self:getMouseX(), self:getMouseY());
    triggerMouseOver(self);
    if self.onPageChanged then
        self.onPageChanged(self.callbackTarget, self.currentPage);
    end
end

function ISTiledIconListBox:getPages()
    return self.pages;
end

function ISTiledIconListBox:focusPageOnSelectedTile()
    if self.selectedTileData and self.pages>0 then
        if self.dataArrayList and self.dataArrayList:size()>0 then
            for i=0,self.dataArrayList:size()-1 do
                if self.selectedTileData==self.dataArrayList:get(i) then
                    local page = math.floor(i/self.tileCount);
                    if self.currentPage~=page then
                        --print("------ RECALC PAGE: "..tostring(page)..", i="..tostring(i)..", tileCnt="..tostring(self.tileCount));
                        self.currentPage = page;
                        self:pageChanged();
                    end
                    break;
                end
            end
        end
    end
end

--************************************************************************--
--** ISTiledIconListBox:new
--**
--************************************************************************--
function ISTiledIconListBox:new (x, y, width, height, dataList)
	local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self

    --o.background = false;

    --o.fullrecipeList = recipeList;
    o.dataArrayList = dataList;

    o.currentPage = 0;

    o.lastMouseOverTile = -1;
    o.mouseOverTile = -1;
    o.selectedTileData = false;

    o.callbackTarget = false;
    o.onRenderTile = false;
    o.onHoverTile = false;
    o.onClickTile = false;

    o.iconWidth = 64;
    o.iconHeight = 64;

    o.tilePadX = 4;
    o.tilePadY = 4;

    o.tileWidth = o.iconWidth + (o.tilePadX*2);
    o.tileHeight = o.iconHeight + (o.tilePadY*2);

    o.tileMarginX = 8;
    o.tileMarginY = 8;

    o.minimumColumns = 6;
--     o.minimumColumns = 5;
    o.minimumRows = 1;

    o.margin = 5;
    o.minimumWidth = o.tileMarginX + (o.minimumColumns * (o.tileWidth + o.tileMarginX));
    o.minimumHeight = o.tileMarginY + (o.minimumRows * (o.tileHeight + o.tileMarginY));

    o.autoFillContents = false;
    o.isAutoFill = false;
    o.isAutoFillX = false;
    o.isAutoFillY = false;

    return o
end