--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISBaseObject"
require "ISUI/ISUIElement"
require "ISUI/ISPanel"

--[[
    Note: indexes for function params start at 0
--]]

--************************************************************************--
--** ISTableLayout
--************************************************************************--

ISTableLayout = ISPanel:derive("ISTableLayout");

function ISTableLayout:initialise()
	ISPanel.initialise(self);
end

function ISTableLayout:createChildren()
    ISPanel.createChildren(self);
end

function ISTableLayout:row(_index)
	return self.rows[_index+1];
end

function ISTableLayout:rowCount()
	return #self.rows;
end

function ISTableLayout:column(_index)
	return self.columns[_index+1];
end

function ISTableLayout:columnCount()
	return #self.columns;
end

function ISTableLayout:cell(_column, _row)
    local index = _column + (_row * self:columnCount())
	return self.cells[index+1];
end

function ISTableLayout:cellGetFirst(_column, _row)
    local cell = self:cell(_column, _row);
    if cell then
        return cell.children[1];
    end
end

function ISTableLayout:cellCount()
	return #self.cells;
end

function ISTableLayout:cellFor(_element)
    for idx,cell in pairs(self.cells) do
        if cell.element and cell.element==_element then
            return cell;
        end
    end
    return nil;
end

function ISTableLayout:isValidPos(_column, _row)
	return _column>=0 and _column<self:columnCount() and _row>=0 and _row<self:rowCount();
end

function ISTableLayout:setElement(_column, _row, _element)
    if not self:isValidPos(_column, _row) then
        print("cell position invalid col="..tostring(_column)..", row="..tostring(_row));
        return;
    end
    if _element then
        local cell = self:cell(_column, _row); --self:ensureCell(_column, _row);
        if cell then
            if cell.element then
                ISUIElement.removeChild(self, cell.element);
            end
            cell.element = _element;
            ISUIElement.addChild(self, _element);
            cell.minimumWidth = 0;
            cell.minimumHeight = 0;
            --self.dirtyLayout = true;
        end
    else
        local index = _column + (_row*self:columnCount());
        if self.cells[index+1] and self.cells[index+1].element then
            ISUIElement.removeChild(self, self.cells[index+1].element);
            self.cells[index+1].element = nil;
        end
        --self.cells[index+1] = false;
        --self.dirtyLayout = true;
    end
end

function ISTableLayout:addChild(_element)
    print("ISTableLayout -> addChild not allowed, use setElement...");
end

function ISTableLayout:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

	local rows = self:rowCount();
    local columns = self:columnCount();

    if self:cellCount()>0 then
        for i,cell in ipairs(self.cells) do
            cell.minimumWidth = 0;
            cell.minimumHeight = 0;
            cell:calculateLayout(0, 0);
            cell.minimumWidth = cell:getWidth();
            cell.minimumHeight = cell:getHeight();
        end

        local autoFillColumns = 0;
        local autoFillRows = 0;
        local totalWidth = 0;
        local totalHeight = 0;
        local cell, column, row;

        for x=0,columns-1 do
            column = self:column(x);
            column.width = 0;
            if column.visible then
                for y=0,rows-1 do
                    cell = self:cell(x,y);
                    column.width = math.max(column.width, cell.minimumWidth);
                end
                column.width = math.max(column.width, column.minimumWidth);
                totalWidth = totalWidth + column.width;

                if column.isAutoFill then
                    autoFillColumns = autoFillColumns + 1;
                end
            end
        end

        width = math.max(width, totalWidth);
        local distributedWidth = math.max(0, width-totalWidth);
        if autoFillColumns>1 then
            distributedWidth = distributedWidth/autoFillColumns;
        end

        for x=0,columns-1 do
            column = self:column(x);
            if column.isAutoFill and column.visible then
                column.width = column.width + distributedWidth;
            end
        end

        for y=0,rows-1 do
            row = self:row(y);
            row.height = 0;
            if row.visible then
                for x=0,columns-1 do
                    cell = self:cell(x,y);
                    row.height = math.max(row.height, cell.minimumHeight);
                end
                row.height = math.max(row.height, row.minimumHeight);
                totalHeight = totalHeight + row.height;

                if row.isAutoFill then
                    autoFillRows = autoFillRows + 1;
                end
            end
        end

        height = math.max(height, totalHeight);
        local distributedHeight = math.max(0, height-totalHeight);
        if autoFillRows>1 then
            distributedHeight = distributedHeight/autoFillRows;
        end

        for y=0,rows-1 do
            row = self:row(y);
            if row.isAutoFill and row.visible then
                row.height = row.height + distributedHeight;
            end
        end

        local posX = 0;
        local posY = 0;
        for x=0,columns-1 do
            column = self:column(x);

            posY = 0;
            for y=0,rows-1 do
                row = self:row(y);

                cell = self:cell(x,y);

                if column.visible and row.visible then
                    cell:calculateLayout(column.width, row.height);
                    cell:setX(posX);
                    cell:setY(posY);
                    cell:setVisible(true);
                else
                    cell:setVisible(false);
                end

                if row.visible then
                    posY = posY + row.height;
                end
            end

            if column.visible then
                posX = posX + column.width;
            end
        end
    end

    self:setWidth(width);
    self:setHeight(height);
end

function ISTableLayout:onResize()
    --ISUIElement.onResize(self)
    ISUIElement.onResize(self)
end

function ISTableLayout:prerender()
    ISPanel.prerender(self);
end

function ISTableLayout:render()
    ISPanel.render(self);

    if ISEntityUI.drawDebugLines or self.drawDebugLines then
        self:drawRectBorderStatic(0, 0, self.width, self.height, 1.0, 1, 0, 0);

        if self:cellCount()>0 then
            for i,cell in ipairs(self.cells) do
                self:drawRectBorderStatic(cell.x, cell.y, cell.width, cell.height, 1.0, 1, 0, 0);
            end
        end
    end

    --self:drawRectBorderStatic(0, 0, self.width, self.height, 1.0, 0, 0, 1);
end

function ISTableLayout:update()
    ISPanel.update(self);
end

function ISTableLayout:createTable(columns, rows)
    self.columns = {};
    self.rows = {};
    --self.cells = {};
    --o.cellPadding = 0;

    columns = math.max(1, columns or 1);
    rows = math.max(1, rows or 1);

    for i=0,columns-1 do
        table.insert(self.columns, ISXuiSkin.build(self.xuiSkin, self.styleColumn, ISTableLayoutColumn, self, i));
    end

    for i=0,rows-1 do
        table.insert(self.rows, ISXuiSkin.build(self.xuiSkin, self.styleRow, ISTableLayoutRow, self, i));
    end

    self:ensureCells();
end

function ISTableLayout:addColumnFill(_styleColumn)
    return self:addColumn(_styleColumn, true);
end

function ISTableLayout:addColumn(_styleColumn, _autoFill)
    local column = ISXuiSkin.build(self.xuiSkin, _styleColumn or self.styleColumn, ISTableLayoutColumn, self, #self.columns);
    if _autoFill~=nil then
        column.isAutoFill = _autoFill;
    end
    table.insert(self.columns, column);
    self:ensureCells();
    return column;
end

function ISTableLayout:addRowFill(_styleRow)
    return self:addRow(_styleRow, true);
end

function ISTableLayout:addRow(_styleRow, _autoFill)
    local row = ISXuiSkin.build(self.xuiSkin, _styleRow or self.styleRow, ISTableLayoutRow, self, #self.rows);
    if _autoFill~=nil then
        row.isAutoFill = _autoFill;
    end
    table.insert(self.rows, row);
    self:ensureCells();
    return row;
end

function ISTableLayout:ensureCells()
    local cells = {};
    local cell;
    for cy=0,self:rowCount()-1 do
        for cx=0,self:columnCount()-1 do
            cell = self:cell(cx, cy);
            if not cell then
                cell = ISXuiSkin.build(self.xuiSkin, self.styleCell, ISTableLayoutCell, cx, cy, self);
            end
            --cell.padding = self.cellPadding;
            --cell:initialise();
            table.insert(cells, cell);
        end
    end
    self.cells = cells;
end

function ISTableLayout:clearTable()
    for k,childElement in pairs(self.children) do
        ISUIElement.removeChild(self, childElement);
    end
    self.columns = {};
    self.rows = {};
    self.cells = {};
end

--************************************************************************--
--** ISTableLayout:new
--**
--************************************************************************--
function ISTableLayout:new (x, y, width, height, _styleColumn, _styleRow, _styleCell)
	local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.background = false;

    o.drawGrid = false;
    o.gridColor = { r = 0.2, g = 0.2, b = 0.2, a = 1 }

    o.columns = {};
    o.rows = {};
    o.cells = {};

    o.styleColumn = _styleColumn;
    o.styleRow = _styleRow;
    o.styleCell = _styleCell;

    o.minimumWidth = 0;
    o.minimumHeight = 0;

    -- these may or may not be used by a parent control while calculating layout:
    o.isAutoFill = false;
    o.isAutoFillX = false;
    o.isAutoFillY = false;

    return o
end

--************************************************************************--
--** ISTableLayoutColumn
--************************************************************************--

ISTableLayoutColumn = ISBaseObject:derive("ISTableLayoutColumn");

function ISTableLayoutColumn:new(_parentTable, _columnIndex, _isAutoFill)
	local o = ISBaseObject:new();
	setmetatable(o, self);
	self.__index = self;
    o.columnIndex = _columnIndex;
    o.isAutoFill = _isAutoFill;
    o.width = 0;
    o.minimumWidth = 0;
    o.x = 0;
    o.temp = 0;
    o.backgroundColor = { r=0, g=0, b=0, a=0 };
    o.borderColor = { r=0, g=0, b=0, a=0 };
    o.visible = true;
    o.parentTable = _parentTable;

	return o;
end

function ISTableLayoutColumn:index()
    return self.columnIndex;
end

function ISTableLayoutColumn:setVisible(_b, _silent)
    self.visible = _b;
    if (not _silent) and self.parentTable and self.parentTable.xuiRecalculateLayout then
        self.parentTable:xuiRecalculateLayout();
    end
end

--************************************************************************--
--** ISTableLayoutRow
--************************************************************************--

ISTableLayoutRow = ISBaseObject:derive("ISTableLayoutRow");

function ISTableLayoutRow:new(_parentTable, _rowIndex, _isAutoFill)
	local o = ISBaseObject:new();
	setmetatable(o, self);
	self.__index = self;
    o.rowIndex = _rowIndex;
    o.isAutoFill = _isAutoFill;
    o.height = 0;
    o.minimumHeight = 0;
    o.y = 0;
    o.temp = 0;
    o.backgroundColor = { r=0, g=0, b=0, a=0 };
    o.borderColor = { r=0, g=0, b=0, a=0 };
    o.visible = true;
    o.parentTable = _parentTable;

	return o;
end

function ISTableLayoutRow:index()
    return self.rowIndex;
end

function ISTableLayoutRow:setVisible(_b, _silent)
    self.visible = _b;
    if (not _silent) and self.parentTable and self.parentTable.xuiRecalculateLayout then
        self.parentTable:xuiRecalculateLayout();
    end
end

--************************************************************************--
--** ISTableLayoutCell
--************************************************************************--

ISTableLayoutCell = ISBaseObject:derive("ISTableLayoutCell");

function ISTableLayoutCell:new(_columnIndex, _rowIndex, _parent)
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
    o.drawBackground = false;
    o.backgroundColor = { r=0, g=0, b=0, a=0 };
    o.drawBorder = false;
    o.borderColor = { r=0, g=0, b=0, a=0 };
    o.element = nil;
    o.minimumWidth = 0;
    o.minimumHeight = 0;
    o.padding = 0;
    o.visible = true;

    --ISXuiSkin.RegisterXuiSkinFunctions(o, true);

	return o;
end

function ISTableLayoutCell:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    local padding2x = (self.padding*2);
    if self.element then
        if self.element.calculateLayout then
            self.element:calculateLayout(math.max(0, width-padding2x), math.max(0, height-padding2x));
        end
        width = math.max(width, self.element:getWidth()+padding2x);
        height = math.max(height, self.element:getHeight()+padding2x);
    else
        width = math.max(width, padding2x);
        height = math.max(height, padding2x);
    end

    self.width = width;
    self.height = height;
end

function ISTableLayoutCell:setVisible(_b)
	self.visible = _b;
    if self.element then
        self.element:setVisible(_b);
    end
end

function ISTableLayoutCell:setX(_x)
	self.x = _x;
    if self.element then
        local x = self.x + ((self.width/2) - (self.element:getWidth()/2));
        self.element:setX(x);
    end
end

function ISTableLayoutCell:setY(_y)
	self.y = _y;
    if self.element then
        local y = self.y + ((self.height/2) - (self.element:getHeight()/2));
        self.element:setY(y);
    end
end

function ISTableLayoutCell:getAbsoluteX()
	return self.parent:getAbsoluteX() + self.x;
end

function ISTableLayoutCell:getAbsoluteY()
	return self.parent:getAbsoluteY() + self.y;
end

function ISTableLayoutCell:getX()
	return self.x;
end

function ISTableLayoutCell:getY()
	return self.y;
end

function ISTableLayoutCell:getWidth()
	return self.width;
end

function ISTableLayoutCell:getHeight()
	return self.height;
end

function ISTableLayoutCell:addChild(_child)
	self.element = _child;
end