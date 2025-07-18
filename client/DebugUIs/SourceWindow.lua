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

    --print("instance");
    ISCollapsableWindow.createChildren(self);

    self.sourceView = ISScrollingListBox:new(0, self:titleBarHeight(), self.width, self.height - self:resizeWidgetHeight() - buttonHgt - self:titleBarHeight());
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

    self.reloadBtn = ISButton:new(0, self:getHeight() - self:resizeWidgetHeight() - buttonHgt, self:getWidth(), buttonHgt, "reload file", self, SourceWindow.reloadFile);
    self.reloadBtn.anchorTop = false;
    self.reloadBtn.anchorRight = true;
    self.reloadBtn.anchorBottom = true;
    self.reloadBtn:initialise();
    self:addChild(self.reloadBtn);

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
    --self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    local y = 0;
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

  --  self:drawRectBorder(0, (y), self:getWidth(), self.itemheight, 0.5, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawText(item.text, 15, y + (self.itemheight - FONT_HGT_CODE) / 2, 1, 1, 1, 1, self.font);
    y = y + self.itemheight;
    return y;

end

function SourceWindow:scrollToLine(line)
    local p = (line - 1) * self.sourceView.itemheight;
    p = p - (self:getHeight() / 2);
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
