--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "ISUI/ISPanel"

ISWhitelistTable = ISPanel:derive("ISWhitelistTable");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local FONT_HGT_LARGE = getTextManager():getFontHeight(UIFont.Large)

local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

function ISWhitelistTable:initialise()
    ISPanel.initialise(self);
end


function ISWhitelistTable:render()
    ISPanel.render(self);
--    self:drawText(self.tableName, self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, self.tableName) / 2), z, 1,1,1,1, UIFont.Medium);

    self:drawRectBorder(self.datas.x, self.datas.y - BUTTON_HGT, self.datas:getWidth(), BUTTON_HGT+1, 1, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawRect(self.datas.x, self.datas.y - BUTTON_HGT, self.datas:getWidth(), BUTTON_HGT + 1, self.listHeaderColor.a, self.listHeaderColor.r, self.listHeaderColor.g, self.listHeaderColor.b);
    local x = 0;
    for name, type in pairs(self.columns) do
        if type["name"] ~= "id" then
            self:drawRect(self.datas.x + x, 1 + self.datas.y - BUTTON_HGT, 1, BUTTON_HGT,1,self.borderColor.r, self.borderColor.g, self.borderColor.b);

            self:drawText(type["name"], self.datas.x + x + UI_BORDER_SPACING, self.datas.y - BUTTON_HGT + 3, 1,1,1,1,UIFont.Small);
            if self.columnSize[type["name"]] then
                x = x + self.columnSize[type["name"]];
            else
                x = x + 150;
            end
        end
    end

    local y = self.datas.y + self.datas.height + UI_BORDER_SPACING
    self:drawText(getText("IGUI_DbViewer_TotalResult") .. self.totalResult, 0, y, 1,1,1,1,UIFont.Small)
    y = y + FONT_HGT_SMALL+UI_BORDER_SPACING

    if #self.datas.items > 0 or self.filtered then
        self:drawText(getText("IGUI_DbViewer_Filters"), 0, y+3, 1,1,1,1,UIFont.Large);
        y = y + FONT_HGT_LARGE+6
    end
    x = 0;
    if #self.datas.items > 0 or self.filtered then
        self:drawRectBorder(self.datas.x, y, self.datas:getWidth(), BUTTON_HGT+1, 1, self.borderColor.r, self.borderColor.g, self.borderColor.b);
        self:drawRect(self.datas.x, y, self.datas:getWidth(), BUTTON_HGT, self.listHeaderColor.a, self.listHeaderColor.r, self.listHeaderColor.g, self.listHeaderColor.b);
    end
    local nbr = 1;
    for _, v in ipairs(self.filters) do
        if #self.datas.items > 0 or self.filtered  then
            v:setY(y + BUTTON_HGT)
            v:setVisible(true);
            if self.columnSize[v.columnName] then
                local size = self.columnSize[v.columnName] + 1
                if nbr >= #self.columns then
                    size = self.width - x;
                end
                self:drawText(v.columnName, x + 10, y+3, 1,1,1,1,UIFont.Small);
                self:drawRectBorder(self.datas.x + x, y, 1, self.datas.itemheight + 1, 1, self.borderColor.r, self.borderColor.g, self.borderColor.b);
                v:setWidth(size)
                v:setHeight(FONT_HGT_MEDIUM+6)
                v:setX(x);
                x = x + self.columnSize[v.columnName];
                nbr = nbr + 1;
            else
                x = x + 100;
            end
        else
            v:setVisible(false);
        end
    end
    if self.loading then
        self:drawRect(0, 0, self:getWidth(), self:getHeight(), 0.8, 0.1, 0.1, 0.1);
        self:drawTextCentre(getText("IGUI_DbViewer_Loading"),  self:getWidth()/2,  self:getHeight()/2, 1,1,1,1,UIFont.Large);
    end
    self:setHeight(y)
end

function ISWhitelistTable:new (x, y, width, height, tableName)
    local o = ISPanel:new(x, y, width, height);
    o.tableName = tableName;
    setmetatable(o, self);
    o.schema = {};
    o.pages = {};
    o.fullPages = {};
    o.listHeaderColor = {r=0.4, g=0.4, b=0.4, a=0.3};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=0};
    o.backgroundColor = {r=0, g=0, b=0, a=0};
    o.columnSize = {};
    o.currentPage = 1;
    o.buttonBorderColor = {r=0.7, g=0.7, b=0.7, a=0.5};
    o.filters = {};
    o.filtered = false;
    ISWhitelistTable.instance = o;
    o.totalResult = 0;
    o.entriesPerPages = 500;
--    getTableResult(tableName);
    return o;
end

function ISWhitelistTable:createChildren()
    ISPanel.createChildren(self);

    self.datas = ISScrollingListBox:new(0, BUTTON_HGT, self.width, self.height-BUTTON_HGT*4-UI_BORDER_SPACING*2-FONT_HGT_LARGE-FONT_HGT_MEDIUM-6);
    self.datas:initialise();
    self.datas:instantiate();
    self.datas.itemheight = BUTTON_HGT
    self.datas.selected = 0;
    self.datas.joypadParent = self;
    self.datas.font = UIFont.NewSmall;
    self.datas.doDrawItem = self.drawDatas;
    self.datas.drawBorder = true;
    self.datas.parent = self;
    self:addChild(self.datas);

    self.pagePanel = ISPanel:new(0, self.datas:getBottom() + UI_BORDER_SPACING, 100, BUTTON_HGT)
    self.pagePanel:initialise()
    self.pagePanel:instantiate()
    self.pagePanel:noBackground()
    self:addChild(self.pagePanel)

    self.nbrPerPageLbl = ISLabel:new(0, 0, self.pagePanel.height, getText("IGUI_DbViewer_NbrPerPage"), 1, 1, 1, 1, UIFont.Small, true);
    self.nbrPerPageLbl:initialise();
    self.nbrPerPageLbl:instantiate();
    self.pagePanel:addChild(self.nbrPerPageLbl);

    local textWid = getTextManager():MeasureStringX(UIFont.Medium, "9999")
    self.nbrPerPages = ISTextEntryBox:new("500", self.nbrPerPageLbl:getRight() + UI_BORDER_SPACING, 0, textWid + 2 * 2, BUTTON_HGT);
    self.nbrPerPages.font = UIFont.Small
    self.nbrPerPages:initialise();
    self.nbrPerPages:instantiate();
    self.nbrPerPages:setOnlyNumbers(true);
    self.nbrPerPages.onTextChange = ISWhitelistTable.onNbrPerPageChange;
    self.nbrPerPages.target = self;
    self.nbrPerPages.tableName = self.tableName;
    self.nbrPerPages:setHeight(BUTTON_HGT)
    self.pagePanel:addChild(self.nbrPerPages);

    self.pagesLbl = ISLabel:new(self.nbrPerPages:getRight() + UI_BORDER_SPACING, 0, self.pagePanel.height, getText("IGUI_DbViewer_Page"), 1, 1, 1, 1, UIFont.Small, true);
    self.pagesLbl:initialise();
    self.pagesLbl:instantiate();
    self.pagePanel:addChild(self.pagesLbl);

    self.prePage = ISButton:new(self.pagesLbl:getRight() + UI_BORDER_SPACING, 0, 15, self.pagePanel.height, "<", self, ISWhitelistTable.onOptionPage);
    self.prePage.internal = "PREVIOUS";
    self.prePage:initialise();
    self.prePage:instantiate();
    self.prePage.borderColor = self.buttonBorderColor;
    self.pagePanel:addChild(self.prePage);

    self.pageLbl = ISLabel:new(self.prePage:getRight() + UI_BORDER_SPACING, 0, self.pagePanel.height, "1/1", 1, 1, 1, 1, UIFont.Small, true);
    self.pageLbl:initialise();
    self.pageLbl:instantiate();
    self.pagePanel:addChild(self.pageLbl);

    self.nextPage = ISButton:new(self.pageLbl:getRight() + UI_BORDER_SPACING, 0, 15, self.pagePanel.height, ">", self, ISWhitelistTable.onOptionPage);
    self.nextPage.internal = "NEXT";
    self.nextPage:initialise();
    self.nextPage:instantiate();
    self.nextPage.borderColor = self.buttonBorderColor;
    self.pagePanel:addChild(self.nextPage);

    self.pagePanel:setWidth(self.nextPage:getRight())
    self.pagePanel:setX(self.width - self.pagePanel.width)

    for _, type in pairs(self.columns) do
        local size = 150;
        local entryHgt = FONT_HGT_MEDIUM+6
        if type["name"] ~= "id" then
            if type["type"] == "TEXT" or type["type"] == "INTEGER" then
                self.entry = ISTextEntryBox:new("", UI_BORDER_SPACING,  self.datas.x + self.datas.height + 85, size, entryHgt);
                self.entry.font = UIFont.Medium
                self.entry:initialise();
                self.entry:instantiate();
                self.entry.columnName = type["name"];
                self.entry.type = type["type"];
                self.entry.tableName = self.tableName;
                if type["type"] == "INTEGER" then
                    self.entry:setOnlyNumbers(true);
                end
                self.entry.onTextChange = ISWhitelistTable.onFilterChange;
                self.entry.target = self;
                self:addChild(self.entry);
                table.insert(self.filters, self.entry);
            end
            if type["type"] == "BOOLEAN" then
                self.combo = ISComboBox:new(UI_BORDER_SPACING,  self.datas.x + self.datas.height + 85, size, entryHgt, nil,nil);
                self.combo:initialise();
                self:addChild(self.combo);
                self.combo:addOption("");
                self.combo:addOption("true");
                self.combo:addOption("false");
                self.combo.type = type["type"];
                self.combo.columnName = type["name"];
                self.combo.onChange = ISWhitelistTable.onFilterChange;
                self.combo.target = self;
                self.combo.tableName = self.tableName;
                self.combo.isComboBox = true;
                table.insert(self.filters, self.combo);
            end
        end
    end
end

function ISWhitelistTable.onNbrPerPageChange(entry)
    local view = ISWhitelistViewer.instance.panel:getView(entry.tableName);
    view.entriesPerPages = tonumber(entry:getInternalText());
    if view.entriesPerPages == nil then view.entriesPerPages = 1; end
    if #view.filters > 0 then
        view.onFilterChange(view.filters[1]);
    end
end

function ISWhitelistTable:clearFilters()
    for _,v in ipairs(self.filters) do
        if v.type =="BOOLEAN" then
            v.selected = 0;
        elseif v.type == "INTEGER" or v.type == "TEXT" then
            v:setText("");
        end
    end
end

function ISWhitelistTable.onFilterChange(entry, combo)
    local view = ISWhitelistViewer.instance.panel:getView(entry.tableName)
    local filterTxt = "";
    local columnName = entry.columnName;
    if combo then
        if combo.selected == 2 then
            filterTxt = "true";
        elseif combo.selected == 3 then
            filterTxt = "false";
        end
        columnName = combo.columnName;
    else
        filterTxt = entry:getInternalText();
    end
    view.datas:clear();
    view.columnSize = {};
    view.filtered = string.trim(filterTxt) ~= "";
    local allPagesFilter = {};
    local data = {};
    local newPage = ArrayList.new();
    view.pages = {};
    local size = 0;
    view.totalResult = 0;
    for _,v in ipairs(view.fullPages) do
        for i=0, v:size()-1 do
            local dbResult = v:get(i);
            data.datas = {};
            local add = true;
            for j=0, dbResult:getColumns():size() - 1 do
                local colName = dbResult:getColumns():get(j);
                local value = dbResult:getValues():get(colName);
                if filterTxt and filterTxt ~= "" and (colName == columnName and not luautils.stringStarts(string.lower(value), string.lower(filterTxt))) then
                    add = false;
                end
                data.datas[colName] = value;
                if add then
                    local currentSize = view.columnSize[colName];
                    if not currentSize then currentSize = 0; end
                    if currentSize < getTextManager():MeasureStringX(UIFont.Large, dbResult:getValues():get(colName)) + UI_BORDER_SPACING then
                        currentSize = getTextManager():MeasureStringX(UIFont.Large, dbResult:getValues():get(colName)) + UI_BORDER_SPACING;
                    end
                    if currentSize < getTextManager():MeasureStringX(UIFont.Large, colName) + UI_BORDER_SPACING then
                        currentSize = getTextManager():MeasureStringX(UIFont.Large, colName) + UI_BORDER_SPACING;
                    end
                    if currentSize >= 500 then currentSize = 500; end
                    view.columnSize[colName] = currentSize;
                else
                    local currentSize = view.columnSize[colName];
                    if not currentSize then
                        view.columnSize[colName] = getTextManager():MeasureStringX(UIFont.Large, colName) + UI_BORDER_SPACING;
                    end
                end
            end
            if add then
                size = size + 1;
                view.totalResult = view.totalResult + 1;
                newPage:add(dbResult);
                if #allPagesFilter == 0 then
                    view.datas:addItem(data.datas["username"], data);
                end
            end
            if size >= view.entriesPerPages then
                table.insert(allPagesFilter, newPage);
                newPage = ArrayList.new();
                size = 0;
            end
            data = {};
        end
    end
    if size > 0 then
        table.insert(allPagesFilter, newPage);
    end
    view.pages = allPagesFilter;
    view:doPagesButtons();
end

function ISWhitelistTable:clear()
    self.totalResult = 0;
    self.datas:clear();
    self.columnSize = {};
    self.pages = {};
    self.fullPages = {};
    self.loading = true;
end

function ISWhitelistTable:doPagesButtons()
    local pagesNbr = #self.pages;
    if pagesNbr == 0 then
        pagesNbr = 1;
        self.nextPage.enable = false;
        self.prePage.enable = false;
    end
    if pagesNbr > 1 then
        self.nextPage.enable = true;
        self.prePage.enable = true;
    end
    self.currentPage = 1;
    self.pageLbl.name = "1/" .. pagesNbr;
end

function ISWhitelistTable:onOptionPage(button, x, y)
    if button.internal == "NEXT" then
        self.currentPage = self.currentPage + 1;
        if self.currentPage > #self.pages then
            self.currentPage = #self.pages;
        end
        self.pageLbl.name = self.currentPage .. "/" .. #self.pages;
        self.datas:clear();
        self:computeResult(self.pages[self.currentPage], self);
    end
    if button.internal == "PREVIOUS" then
        self.currentPage = self.currentPage - 1;
        if self.currentPage < 1 then
            self.currentPage = 1;
        end
        self.pageLbl.name = self.currentPage .. "/" .. #self.pages;
        self.datas:clear();
        self:computeResult(self.pages[self.currentPage], self);
    end
end

function ISWhitelistTable:computeResult(datas)
    local data = {};
    self.columnSize = {};
    for i=0, datas:size()-1 do
        local dbResult = datas:get(i);
        data.datas = {};
        for j=0, dbResult:getColumns():size() - 1 do
            local colName = dbResult:getColumns():get(j);
            data.datas[colName] = dbResult:getValues():get(colName);
            local currentSize = self.columnSize[colName];
            if not currentSize then currentSize = 0; end
            if currentSize < getTextManager():MeasureStringX(UIFont.Large, dbResult:getValues():get(colName)) + UI_BORDER_SPACING then
                currentSize = getTextManager():MeasureStringX(UIFont.Large, dbResult:getValues():get(colName)) + UI_BORDER_SPACING;
            end
            if currentSize < getTextManager():MeasureStringX(UIFont.Large, colName) + UI_BORDER_SPACING then
                currentSize = getTextManager():MeasureStringX(UIFont.Large, colName) + UI_BORDER_SPACING;
            end
            if currentSize >= 500 then currentSize = 500; end
            self.columnSize[colName] = currentSize;
        end
        self.datas:addItem(data.datas["username"], data);
        data = {};
    end
end

ISWhitelistTable.getTableResult = function(datas, rowId, tableName)
    local view = ISWhitelistViewer.instance.panel:getView(tableName)
    view.loading = false;
    if datas:size() > 0 then
        if rowId == 0 then
            view.totalResult = 0;
            view.datas:clear();
            view.columnSize = {};
            view.pages = {};
        end
        view.totalResult = view.totalResult + datas:size();
        table.insert(view.pages, datas);
        table.insert(view.fullPages, datas);
        view.pageLbl.name = "1/" .. #view.pages;
        if rowId == 0 then
            view:computeResult(datas);
        end
        view:doPagesButtons();
    end
end

function ISWhitelistTable:drawDatas(y, item, alt)
    local a = 0.9;

    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight, 0.3, 0.7, 0.35, 0.15);
    end

    if alt then
        self:drawRect(0, (y), self:getWidth(), self.itemheight, 0.3, 0.6, 0.5, 0.5);
    end

    self:drawRectBorder(0, (y), self:getWidth(), self.itemheight, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    local x = 10;
    if self.parent and self.parent.columns then
        for name, type in pairs(self.parent.columns) do
            if type["name"] ~= "id" and type["name"] ~= "moderator" then
                self:drawText(item.item.datas[type["name"]], x, y + 3, 1, 1, 1, a, self.font);
                self:drawRect(x - 10, y - 1, 1, self.itemheight,1,self.borderColor.r, self.borderColor.g, self.borderColor.b);
    --            self:drawText(item.text, x, y + 2, 1, 1, 1, a, self.font);
                if self.parent.parent.activeView and self.parent.parent.activeView.columnSize[type["name"]] then
                    x = x + self.parent.parent.activeView.columnSize[type["name"]];
                else
                    x = x + 100;
                end
            end
        end
    end
    return y + self.itemheight;
end

Events.OnGetTableResult.Add(ISWhitelistTable.getTableResult);
