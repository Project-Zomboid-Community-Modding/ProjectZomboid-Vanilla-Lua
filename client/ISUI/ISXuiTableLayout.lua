--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISBaseObject"
require "ISUI/ISUIElement"

--[[
    A simple table layout for Xui
--]]

--************************************************************************--
--** ISXuiTableLayoutColumn
--************************************************************************--

ISXuiTableLayoutColumn = ISBaseObject:derive("ISXuiTableLayoutColumn");

function ISXuiTableLayoutColumn:new(_columnIndex, _width, _isPercent)
	local o = ISBaseObject:new();
	setmetatable(o, self);
	self.__index = self;
    o.columnIndex = _columnIndex;
    o.configWidth = _width or 1;
    o.isPercent = _isPercent;
    o.width = o.configWidth;
    o.minimumWidth = not _isPercent and o.width or 0;
    o.x = 0;
    o.temp = 0;
    o.backgroundColor = { r=0, g=0, b=0, a=0 };
    o.borderColor = { r=0, g=0, b=0, a=0 };

	return o;
end

--************************************************************************--
--** ISXuiTableLayoutRow
--************************************************************************--

ISXuiTableLayoutRow = ISBaseObject:derive("ISXuiTableLayoutRow");

function ISXuiTableLayoutRow:new(_rowIndex, _height, _isPercent)
	local o = ISBaseObject:new();
	setmetatable(o, self);
	self.__index = self;
    o.rowIndex = _rowIndex;
    o.configHeight = _height or 20;
    o.isPercent = _isPercent;
    o.height = o.configHeight;
    o.minimumHeight = not _isPercent and o.height or 0;
    o.y = 0;
    o.temp = 0;
    o.backgroundColor = { r=0, g=0, b=0, a=0 };
    o.borderColor = { r=0, g=0, b=0, a=0 };

	return o;
end

--************************************************************************--
--** ISXuiTableLayoutCell
--************************************************************************--

ISXuiTableLayoutCell = ISBaseObject:derive("ISXuiTableLayoutCell");

function ISXuiTableLayoutCell:new(_columnIndex, _rowIndex, _parent)
	local o = ISBaseObject:new();
	setmetatable(o, self);
	self.__index = self;
    o.parent = _parent;
    o.columnIndex = _columnIndex;
    o.rowIndex = _rowIndex;
    o.x = 0;
    o.y = 0;
    o.width = 0;
    o.height = 0;
    o.drawBackground = true;
    o.backgroundColor = { r=0, g=0, b=0, a=0 };
    o.drawBorder = false;
    o.borderColor = { r=0, g=0, b=0, a=0 };
    o.children = {};

	return o;
end

function ISXuiTableLayoutCell:getAbsoluteX()
	return self.parent:getAbsoluteX() + self.x;
end

function ISXuiTableLayoutCell:getAbsoluteY()
	return self.parent:getAbsoluteY() + self.y;
end

function ISXuiTableLayoutCell:getX()
	return self.x;
end

function ISXuiTableLayoutCell:getY()
	return self.y;
end

function ISXuiTableLayoutCell:getWidth()
	return self.width;
end

function ISXuiTableLayoutCell:getHeight()
	return self.height;
end

function ISXuiTableLayoutCell:addChild(_child)
	table.insert(self.children, _child);
    self.parent:addChild(_child);
    self.parent.dirtyLayout = true;
    ISXuiBuilder.setCellRectangle(_child, self.x, self.y, self.width, self.height);
end

function ISXuiTableLayoutCell:setRectangle(_x, _y, _w, _h)
    if self.__xui and self.__xui.script then
        local padding = self.__xui.script:getPadding();
        local margin = self.__xui.script:getMargin();

        self.x, self.y, self.width, self.height = ISXuiBuilder.applySpacing(padding, _x, _y, _w, _h);

        local x, y, w, h = ISXuiBuilder.applySpacing(margin, self.x, self.y, self.width, self.height);
        for i=1,#self.children do
            ISXuiBuilder.setCellRectangle(self.children[i], x, y, w, h);
        end
    else
        self.x = _x;
        self.y = _y;
        self.width = _w;
        self.height = _h;
        for i=1,#self.children do
            ISXuiBuilder.setCellRectangle(self.children[i], self.x, self.y, self.width, self.height);
        end
    end
end

--************************************************************************--
--** ISXuiTableLayout
--************************************************************************--

ISXuiTableLayout = ISUIElement:derive("ISXuiTableLayout");

function ISXuiTableLayout:initialise()
	ISUIElement.initialise(self);
end


function ISXuiTableLayout:createChildren()
    ISUIElement.createChildren(self);

    self.dirtyLayout = true;
end

function ISXuiTableLayout:onResize(_width, _height)
    --ISCollapsableWindow.onResize(self)
    self:calculateLayout();
end

function ISXuiTableLayout:row(_index)
	return self.rows[_index+1];
end

function ISXuiTableLayout:rowCount()
	return #self.rows;
end

function ISXuiTableLayout:column(_index)
	return self.columns[_index+1];
end

function ISXuiTableLayout:columnCount()
	return #self.columns;
end

function ISXuiTableLayout:cell(_column, _row)
    local index = _column + (_row * self:columnCount())
	return self.cells[index+1];
end

function ISXuiTableLayout:cellGetFirst(_column, _row)
    local cell = self:cell(_column, _row);
    if cell then
        return cell.children[1];
    end
end

function ISXuiTableLayout:cellCount()
	return #self.cells;
end

function ISXuiTableLayout:isValidPos(_column, _row)
	return _column>=0 and _column<self:columnCount() and _row>=0 and _row<self:rowCount();
end

function ISXuiTableLayout:ensureCell(_column, _row)
    if not self:isValidPos(_column, _row) then
        print("cell position invalid col="..tostring(_column)..", row="..tostring(_row));
        return;
    end
	local cell = self:cell(_column, _row);
    if not cell then
        local index = _column + (_row*self:columnCount());
        cell = ISXuiTableLayoutCell:new(_column, _row, self);
        self.cells[index+1] = cell;
    end
    self.dirtyLayout = true;
    return cell;
end

function ISXuiTableLayout:addElement(_column, _row, _element)
	local cell = self:ensureCell(_column, _row);
    if cell then
        cell:addChild( _element);
        self.dirtyLayout = true;
    end
end

function ISXuiTableLayout:calculateLayout()
    self.dirtyLayout = false;

	local rows = self:rowCount();
    local columns = self:columnCount();

    if rows<0 or columns<0 then
        return;
    end

    -- calculate percentage columns
    local totalColWidth = 0;
    local totalColWidthPerc = 0;
    for i=1,#self.columns do
        local column = self.columns[i];
        if column.isPercent then
            totalColWidthPerc = totalColWidthPerc + column.configWidth;
        else
            totalColWidth = totalColWidth + column.configWidth;
        end
    end

    local widthAvail = math.max(self.width - totalColWidth, 0);

    local tx = 0;
    for i=1,#self.columns do
        local column = self.columns[i];
        column.x = tx;
        --adjust percent
        local cfgWidth = 0;
        if column.isPercent and totalColWidthPerc>0 then
            cfgWidth = column.configWidth / totalColWidthPerc;
        end
        column.width = column.isPercent and (widthAvail * cfgWidth) or column.configWidth;
        tx = tx + column.width;
    end

    -- calculate percentage rows
    local totalRowHeight = 0;
    local totalRowHeightPerc = 0;
    for i=1,#self.rows do
        local row = self.rows[i];
        if row.isPercent then
            totalRowHeightPerc = totalRowHeightPerc + row.configHeight;
        else
            totalRowHeight = totalRowHeight + row.configHeight;
        end
    end

    local heightAvail = math.max(self.height - totalRowHeight, 0);

    local ty = 0;
    for i=1,#self.rows do
        local row = self.rows[i];
        row.y = ty;
        local cfgHeight = 0;
        if row.isPercent and totalRowHeightPerc>0 then
            cfgHeight = row.configHeight / totalRowHeightPerc;
        end
        row.height = row.isPercent and (heightAvail * cfgHeight) or row.configHeight;
        ty = ty + row.height;
    end

    -- setting cells
    local colCount = self:columnCount();
    for y=1,#self.rows do
        local row = self.rows[y];
        for x=1,#self.columns do
            local column = self.columns[x];

            local index = (x-1) + ((y-1) * colCount);
            local cell = self.cells[index+1];

            if cell then
                cell:setRectangle(column.x, row.y, column.width, row.height);
            end
        end
    end
end

function ISXuiTableLayout:prerender()
    ISUIElement.prerender(self);
	if self.drawBackground then
		self:drawRectStatic(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
	end
    if self.drawBorder then
        self:drawRectBorderStatic(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    end

    if self.dirtyLayout then
        self:calculateLayout();
    end

    local colCount = self:columnCount();
    local dx, dy, dw, dh = 0,0,0,0;
    for y=1,#self.rows do
        local row = self.rows[y];
        for x=1,#self.columns do
            local column = self.columns[x];

            local index = (x-1) + ((y-1) * colCount);
            local cell = self.cells[index+1];

            dw = column.width;
            dh = row.height;

            local bg,bo;

            if column.drawBackground then
                bg = column.backgroundColor;
            elseif row.drawBackground then
                bg = row.backgroundColor;
            end
            if bg and bg.a>0 then
		        self:drawRect(dx, dy, dw, dh, bg.a, bg.r, bg.g, bg.b);
            end

            if cell and cell.drawBackground then
                bg = cell.backgroundColor;
                if bg and bg.a>0 and cell.width>0 and cell.height>0 then
                    self:drawRect(cell.x, cell.y, cell.width, cell.height, bg.a, bg.r, bg.g, bg.b);
                end
            end

            --[[
            if self.drawGrid then
                bo = self.gridColor;
                if bo and bo.a>0 then
                    self:drawRectBorder(dx, dy, dw, dh, bo.a, bo.r, bo.g, bo.b);
                end
            end
            --]]

            if column.drawBorder then
                bo = column.borderColor;
            elseif row.drawBorder then
                bo = row.borderColor;
            end
            if (not bo) and self.drawGrid then
                bo = self.gridColor;
            end

            if bo and bo.a>0 then
                self:drawRectBorder(dx, dy, dw, dh, bo.a, bo.r, bo.g, bo.b);
            end

            if cell and cell.drawBorder then
                bo = cell.borderColor;
                if bo and bo.a>0 and cell.width>0 and cell.height>0 then
                    self:drawRectBorder(cell.x, cell.y, cell.width, cell.height, bo.a, bo.r, bo.g, bo.b);
                end
            end

            dx = dx + column.width;
        end
        dx = 0;
        dy = dy + row.height;
    end
end


function ISXuiTableLayout:render()
    ISUIElement.render(self);
end

function ISXuiTableLayout:new(x, y, width, height, columns, rows)
	local o = ISUIElement:new(x, y, width, height);
	setmetatable(o, self)
	self.__index = self

	o.x = x;
	o.y = y;
	o.drawBackground = true;
    o.drawBorder = true;
	o.backgroundColor = {r=0, g=0, b=0, a=0.5};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.width = width;
	o.height = height;
	o.anchorLeft = false;
	o.anchorRight = false;
	o.anchorTop = false;
	o.anchorBottom = false;

    o.dirtyLayout = true;
    o.drawGrid = true;
    o.gridColor = { r = 0.2, g = 0.2, b = 0.2, a = 1 }

    o.columns = {};
    o.rows = {};
    o.cells = {};

    if columns and columns>0 then
        for i=0,columns-1 do
            table.insert(o.columns, ISXuiTableLayoutColumn:new(i, o.width/columns, true));
        end
    end

    if rows and rows>0 then
        for i=0,rows-1 do
            table.insert(o.rows, ISXuiTableLayoutRow:new(i, o.height/rows, true));
        end
    end

    if rows and columns and rows>0 and columns>0 then
        for y=0,rows-1 do
            for x=0,columns-1 do
                --local index = x + (y*columns);
                table.insert(o.cells, false);
            end
        end
    end

	return o
end