require "ISUI/ISCollapsableWindow"

SourceWindow = ISCollapsableWindow:derive("SourceWindow");

local FONT_HGT_CODE = getTextManager():getFontHeight(getTextManager():getCurrentCodeFont())
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)

function SourceWindow:onMouseDoubleClickBreakpointToggle(item)
    local line = self.sourceView.selected;
    local file = self.filename;

    toggleBreakpoint(file, line);
end

SourceWindow.map = {}

function SourceWindow:initialise()
    ISCollapsableWindow.initialise(self);
    self.title = getShortenedFilename(self.filename);
end

function SourceWindow:onSourceMouseWheel(del)
    self:setYScroll(self:getYScroll() - (del*18*6));
    return true;
end

function SourceWindow:reloadFile()
    reloadLuaFile(self.filename);
    triggerEvent("OnSourceWindowFileReload");
    local y = self.sourceView:getYScroll();
    self:fill();
    self.sourceView:setYScroll(y);
    return true;
end

function SourceWindow:fill()
    self.sourceView:clear();
    local br = getGameFilesTextInput(self.filename);
    local count = 1;
    if br ~= nil then
        local str = "test";
        while str ~= nil do
            str = br:readLine();
            if str ~= nil then
                --         print(str);
                str = str:gsub("\t", "    ")
                local lineNumberStr = string.format("%d", count)
                lineNumberStr = string.rep(" ", 5 - #lineNumberStr) .. lineNumberStr
                self.sourceView:addItem(lineNumberStr.."    "..str, str);
                count = count + 1;
            end
        end

    end
    endTextFileInput();
end

function SourceWindow:createChildren()
    local buttonHgt = math.max(24, FONT_HGT_SMALL + 3 * 2)
    local entryHgt = FONT_HGT_CODE + 3 * 2
    local bottomHgt = math.max(buttonHgt, entryHgt)

    ISCollapsableWindow.createChildren(self);

    self.sourceView = ISScrollingListBox:new(0, self:titleBarHeight(), self.width, self.height - self:resizeWidgetHeight() - bottomHgt - self:titleBarHeight());
    self.sourceView:setFont(getTextManager():getCurrentCodeFont(), 0)
    self.sourceView.filename = self.filename;
    self.sourceView.anchorRight = true;
    self.sourceView.anchorBottom = true;
    self.sourceView:initialise();
    self.sourceView.doDrawItem = SourceWindow.doDrawItem;
    self.sourceView.prerender = SourceWindow.renderSrc;
    self.sourceView.backgroundColor = {r=30/255, g=31/255, b=34/255, a=1}
    self.sourceView:setOnMouseDoubleClick(self, SourceWindow.onMouseDoubleClickBreakpointToggle);
    self.sourceView.onMouseWheel = SourceWindow.onSourceMouseWheel;
    self:addChild(self.sourceView);

    self.bottomPanel = ISPanel:new(1, self:getHeight() - self:resizeWidgetHeight() - bottomHgt, self.width - 2, bottomHgt)
    self.bottomPanel:noBackground()
    self.bottomPanel.anchorRight = true
    self.bottomPanel.anchorTop = false
    self.bottomPanel.anchorBottom = true
    self:addChild(self.bottomPanel)

    local entryFont = getTextManager():getCurrentCodeFont()
    local clearButtonSize = FONT_HGT_CODE
    local entryWid = getTextManager():MeasureStringX(entryFont, "123456") + clearButtonSize + 3 * 2
    self.lineNumberEntry = ISTextEntryBox:new("", 0, 0, entryWid, bottomHgt);
    self.lineNumberEntry.font = entryFont
    self.lineNumberEntry:initialise();
    self.lineNumberEntry:instantiate();
    self.lineNumberEntry:setOnlyNumbers(true);
    self.lineNumberEntry.onCommandEntered = function(_entry)
        self:onLineNumberEntered()
    end
    self.lineNumberEntry:setPlaceholderText("line#");
    self.lineNumberEntry.javaObject:setCentreVertically(true);
    self.lineNumberEntry:setClearButton(true);
    self.bottomPanel:addChild(self.lineNumberEntry);

    local buttonX = self.lineNumberEntry:getRight() + 10
    self.reloadBtn = ISButton:new(buttonX, 0, self.bottomPanel.width - buttonX, bottomHgt, "RELOAD", self, SourceWindow.reloadFile);
    self.reloadBtn.anchorRight = true;
    self.reloadBtn:initialise();
    self.bottomPanel:addChild(self.reloadBtn);

    self.resizeWidget2:bringToTop()
    self.resizeWidget:bringToTop()

    self:fill();
end

function SourceWindow:prerender()
    ISCollapsableWindow.prerender(self)
    self:checkFontSize()
end

function SourceWindow:renderSrc()
    self:setStencilRect(0,0,self.width+1, self.height);
    self:drawRect(0, -self:getYScroll(), self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);

    if self.items == nil then
        self:clearStencilRect();
        self:repaintStencilRect(0,0,self.width, self.height)
        return;
    end

    local lineTop = math.floor(-self:getYScroll() / self.itemheight) + 1
    lineTop = math.max(lineTop, 1)
    local linesVisible = math.ceil(self:getHeight() / self.itemheight)
    local lineBottom = math.min(lineTop + linesVisible, #self.items)

    for i = lineTop,lineBottom do
        local y = (i - 1) * self.itemheight
        local v = self.items[i]
        v.index = i
        y = self:doDrawItem(y, v)
    end

    self:setScrollHeight(#self.items * self.itemheight);
    self:clearStencilRect();
    self:repaintStencilRect(0,0,self.width, self.height)
end

function SourceWindow:doDrawItem(y, item)
    if self.selected == item.index then
        self:drawRect(0, y, self:getWidth(), self.itemheight, 0.2, 0.6, 0.7, 0.8);

    end

    if hasBreakpoint(self.filename, item.index) then
        self:drawRect(0, y, self:getWidth(), self.itemheight, 0.3, 0.8, 0.6, 0.4);
    end

    if isCurrentExecutionPoint(self.filename, item.itemindex) then
        self:drawRect(0, y, self:getWidth(), self.itemheight, 0.6, 0.6, 0.8, 0.7);
    end

    self:drawText(item.text, 15, y + (self.itemheight - FONT_HGT_CODE) / 2, 1, 1, 1, 1, self.font);
    y = y + self.itemheight;
    return y;
end

function SourceWindow:scrollToLine(line)
    local p = (line - 1) * self.sourceView.itemheight;
    p = p - (self.sourceView:getHeight() / 2);
    self.sourceView:setScrollHeight(self.sourceView.count * self.sourceView.itemheight);
    self.sourceView:setYScroll(-p);
    self.sourceView.selected = line;
end

function SourceWindow:checkFontSize()
    local font = getTextManager():getCurrentCodeFont()
    if font == self.sourceView.font then return end
    local fontHeight = getTextManager():getFontHeight(font)
    FONT_HGT_CODE = fontHeight
    self.sourceView:setFont(font, 0)
    self:setListBoxItemHeight(self.sourceView)
    local buttonHgt = math.max(24, FONT_HGT_SMALL + 3 * 2)
    local entryHgt = FONT_HGT_CODE + 3 * 2
    local clearButtonSize = FONT_HGT_CODE
    local entryWid = getTextManager():MeasureStringX(font, "123456") + clearButtonSize + 3 * 2
    local bottomHgt = math.max(buttonHgt, entryHgt)
    self.bottomPanel:setHeight(bottomHgt)
    self.bottomPanel:setY(self:getHeight() - self:resizeWidgetHeight() - bottomHgt)
    self.lineNumberEntry:setFont(font)
    self.lineNumberEntry:setWidth(entryWid)
    self.lineNumberEntry:setHeight(bottomHgt)
    self.reloadBtn:setHeight(bottomHgt)
    local buttonX = self.lineNumberEntry:getRight() + 10
    self.reloadBtn:setWidth(self.bottomPanel.width - 1 - buttonX)
    self.reloadBtn:setX(buttonX)
    self.sourceView:setHeight(self.height - self:resizeWidgetHeight() - bottomHgt - self:titleBarHeight())
end

function SourceWindow:onLineNumberEntered()
    local lineNumber = tonumber(self.lineNumberEntry:getInternalText())
    if not lineNumber then
        lineNumber = self.sourceView.selected
    end
    if lineNumber then
        lineNumber = math.min(lineNumber, self.sourceView:size())
        self:scrollToLine(lineNumber)
    end
    self.lineNumberEntry:unfocus()
end

function SourceWindow:setListBoxItemHeight(listBox)
    for i=1,#listBox.items do
        listBox.items[i].height = listBox.itemheight
    end
end

function SourceWindow:new (x, y, width, height, filename)
    log(DebugType.Lua, "sourcewindow: file:///"..filename);

    local o = {}

    local del = getCore():getScreenWidth() / 1920;
    x = getCore():getScreenWidth()-(700*del);
    y = 48;
    width = (700*del);
    height = getCore():getScreenHeight() - (getCore():getScreenHeight()/3) -48
    --o.data = {}
    o = ISCollapsableWindow:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.backgroundColor = {r=0, g=0, b=0, a=1.0};
    o.filename = filename;
    o.keepOnScreen = false
    return o
end
