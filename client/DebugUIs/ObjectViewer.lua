require "ISUI/ISCollapsableWindow"

ObjectViewer = ISCollapsableWindow:derive("ObjectViewer");

local FONT_HGT_CODE = getTextManager():getFontHeight(getTextManager():getCurrentCodeFont())

function ObjectViewer:onRightMouseDownObject(x, y)
    if instanceof(self.parent.obj, "KahluaTableImpl") then
        local context = getDebuggerContextMenu()
        context:hideAndChildren();
        context:setVisible(true);
        context:clear();
        context.forceVisible = true;
        context.parent = nil;
        context:setX(x);
        context:setY(y);
        context:bringToTop();
        context:setVisible(true);
        context.visibleCheck = true;
        context.instanceMap = {}
        context.subOptionNums = 0;
        context.subInstance = {}
        context.player = 0;
        context:setX(getMouseX())
        context:setY(getMouseY())

        y = math.floor((y / self.itemheight));

        y = y + 1;

        if y > #self.items then
            y = #self.items;
        end
        if y < 1 then
            y = 1;
        end

        self.selected = y;

        local sel = self.items[self.selected];
        context:addOption("Watch", { obj = self.parent.obj, item = sel.item}, ObjectViewer.onWatch);
        if hasDataBreakpoint(self.parent.obj, sel.item.key) then
            context:addOption("Remove break on change", {obj = self.parent.obj, item = sel.item}, ObjectViewer.onDataWrite);
        else
            context:addOption("Break on change", {obj = self.parent.obj, item = sel.item}, ObjectViewer.onDataWrite);
        end
        if hasDataReadBreakpoint(self.parent.obj, sel.item.key) then
            context:addOption("Remove break on read", {obj = self.parent.obj, item = sel.item}, ObjectViewer.onDataRead);
        else
            context:addOption("Break on read", {obj = self.parent.obj, item = sel.item}, ObjectViewer.onDataRead);
        end
    end
end

function ObjectViewer.onWatch(item)
    WatchWindowInstance.objlist:add(item);
    WatchWindowInstance:fill();
end

function ObjectViewer.onDataWrite(data)
    toggleBreakOnChange(data.obj, data.item.key);
end

function ObjectViewer.onDataRead(data)
    toggleBreakOnRead(data.obj, data.item.key);
end

function ObjectViewer:onMouseDoubleClickListItem(item)
    self:onMouseDoubleClickOpenObject(item.val)
end

function ObjectViewer:onMouseDoubleClickOpenObject(item)
    local bReuse = true;
    -- hold lshift to not reuse.
    if isKeyDown(Keyboard.KEY_LSHIFT) then
        bReuse = false;
    end

    if instanceof(item, "KahluaTableImpl") or instanceof(item, "PZNetKahluaTableImpl") then
        if not bReuse then
            local src = ObjectViewer:new(getCore():getScreenWidth() / 2, 0, 600, 300, item);
            src:initialise();
            src:addToUIManager();
        else
            self:historyPush()
            self.obj = item;
            self.title =  KahluaUtil.rawTostring2(self.obj);
            self:fill();
        end
    elseif instanceof (item, "Class") then
    elseif instanceof (item, "Field") then
        item = getClassFieldVal(self.obj, item);
        self:onMouseDoubleClickOpenObject(item);
    elseif instanceof (item, "Array") then
        item = getClassFieldVal(self.obj, item);
        self:onMouseDoubleClickOpenObject(item);
    elseif instanceof (item, "Texture") then
        local src = TextureWindow:new(getCore():getScreenWidth() / 2, 0, item:getWidth(), item:getHeight(), item);

        src:initialise();
        src:addToUIManager();
    elseif instanceof (item, "LuaClosure") then
        local f = getFilenameOfClosure(item);
        if f ~= nil then
            local src = nil;
            if SourceWindow.map[f] ~= nil then
                src =SourceWindow.map[f];
                src:setVisible(true);
                src:removeFromUIManager();
                src:addToUIManager();
            else

                src = SourceWindow:new(getCore():getScreenWidth() / 2, 0, 600, 600, f);
                SourceWindow.map[f] = src;
                src:initialise();
                src:addToUIManager();
            end
            src:scrollToLine(getFirstLineOfClosure(item)-1)
        end
    else
        if not bReuse then
            local src = ObjectViewer:new(getCore():getScreenWidth() / 2, 0, 600, 300, item);
            src:initialise();
            src:addToUIManager();
        else
            self:historyPush();
            self.obj = item;
            self.title =  KahluaUtil.rawTostring2(self.obj);
            self:fill();
        end
    end
end

function ObjectViewer:storePos()
    self.sc = self.objectView:getYScroll();
end

function ObjectViewer:restorePos()
    self.objectView:setYScroll(self.sc);
end

ObjectViewer.map = {}

function ObjectViewer:initialise()
    ISCollapsableWindow.initialise(self);
    self.title = KahluaUtil.rawTostring2(self.obj);
end

function ObjectViewer:onSourceMouseWheel(del)
    self:setYScroll(self:getYScroll() - (del*18*6));
    return true;
end

function ObjectViewer:fillJavaList(list)
    if not list then return end
    for i=1,list:size() do
        local k = tostring(i-1)
        local elem = list:get(i-1)
        local s = k
        local s2 = KahluaUtil.rawTostring2(elem)
        local hashCode = KahluaUtil.identityHashCode(elem)
        if s2 ~= nil and not string.contains(s2, hashCode) then
            s2 = s2..' '..hashCode
        end
        if s2 ~= nil then
            s = tabToX(s, 10);
            self.objectView:addItem(s..s2, {key=k, val=elem})
        end
    end
end

function ObjectViewer:fill()
    self.objectView:clear();
    self.objectView:setYScroll(0);
    local bSort = true;

    if instanceof(self.obj, "KahluaTableImpl") or instanceof(self.obj, "PZNetKahluaTableImpl") then
        for k, v in pairs(self.obj) do
            local s = KahluaUtil.rawTostring2(k);
            local s2 = KahluaUtil.rawTostring2(v);
            if s ~= nil and s2 ~= nil then
                s = tabToX(s, 40);
                self.objectView:addItem(s..s2, {key=k, val=v});
            end
        end
        self.objectView:sort()
        bSort = false
        local metaTbl = getmetatable(self.obj)
        if metaTbl ~= nil and metaTbl ~= self.obj then
            local k = "<metatable>"
            local v = metaTbl
            local s = tabToX(k, 40)
            local s2 = KahluaUtil.rawTostring2(metaTbl);
            self.objectView:insertItem(1, s..s2, {key=k, val=v});
         end
    elseif instanceof(self.obj, "List") then
         self:fillJavaList(self.obj)
         bSort = false
    elseif self.obj then
        bSort = false;

        local c = getNumClassFields(self.obj);
        for i=0, c-1 do
            local field = getClassField(self.obj, i);
            if field.getType then -- is it exposed?
                local val = KahluaUtil.rawTostring2(getClassFieldVal(self.obj, field));
                if(val == nil) then val = "nil" end
                local k = field:getType():getSimpleName()
                local s = tabToX(k, 18) .. " " .. tabToX(field:getName(), 24) .. " " .. tabToX(val, 24);
                self.objectView:addItem(s, {key=k, val=field});
            end
        end

        c = getNumClassFunctions(self.obj);
        for i=0, c-1 do
            local meth = getClassFunction(self.obj, i);
            if meth.getReturnType and meth:getReturnType().getSimpleName then -- is it exposed?
                local paramNum = getMethodParameterCount(meth);
                local params = "";
                for j=0, paramNum - 1 do
                    params = params .. getMethodParameter(meth, j);
                    if j < paramNum - 2 then
                        params = params .. ", ";
                    end
                end
                local k = meth:getReturnType():getSimpleName()
                local s = tabToX(k, 18) .. " " .. tabToX(meth:getName(), 24) .. "( " .. params .. " )";
                s = tabToX(s, 40);
                self.objectView:addItem(s, {key=k, val=meth});
            end
        end
    end
    if bSort then
        self.objectView:sort();
    end
end

function ObjectViewer:createChildren()
    ISCollapsableWindow.createChildren(self);

    local th = self:titleBarHeight()
    local rh = self:resizeWidgetHeight()

    self.historyPrev = ISButton:new(1, th, 20, FONT_HGT_CODE + 2 * 2, "PREV", self, self.historyPop)
    self:addChild(self.historyPrev)

    local filterX = self.historyPrev:getRight() + 4
    self.filter = ISTextEntryBox:new("", filterX, th, self.width - 1 - filterX, FONT_HGT_CODE + 2 * 2);
    self.filter:setAnchorRight(true)
    self.filter:initialise()
    self.filter:instantiate()
    self.filter:setFont(getTextManager():getCurrentCodeFont())
    self.filter.onTextChange = function() self:onFilterTextChange() end
    self.filter:setClearButton(true)
    self.filter:setPlaceholderText("filter")
    self:addChild(self.filter)

    self.objectView = ISScrollingListBox:new(0, self.filter:getBottom(), self.width, self.height-th-rh-self.filter.height);
    self.objectView:setFont(getTextManager():getCurrentCodeFont(), 0)
    self.objectView:initialise();
    self.objectView.doDrawItem = ObjectViewer.doDrawItem;
    self.objectView.onMouseWheel = ObjectViewer.onSourceMouseWheel;
    self.objectView.anchorRight = true;
    self.objectView.onRightMouseDown = ObjectViewer.onRightMouseDownObject;
    self.objectView.anchorBottom = true;
    self.objectView:setOnMouseDoubleClick(self, ObjectViewer.onMouseDoubleClickListItem);
    self:addChild(self.objectView);

    self:fill();
end

function ObjectViewer:prerender()
    ISCollapsableWindow.prerender(self)
    self:checkFontSize()
    self.historyPrev:setEnable(#self.history > 0)
end

function ObjectViewer:onFilterTextChange()
    local filterText = string.lower(self.filter:getInternalText())
    for i=1,self.objectView:size() do
        local item = self.objectView:getItem(i)
        if filterText == "" or string.contains(string.lower(item.text), filterText) then
            item.height = self.objectView.itemheight
        else
            item.height = 0
        end
    end
end

function ObjectViewer:doDrawItem(y, item, alt)
    if item.height <= 0 then
        return y
    end
    if self.selected == item.index then
        self:drawRect(0, y, self:getWidth(), self.itemheight, 0.2, 0.6, 0.7, 0.8);
    end

    if instanceof(item.item.val, "KahluaTableImpl") or instanceof(item.item.val, "PZNetKahluaTableImpl") then
        if item.item.key ~= nil and hasDataBreakpoint(self.parent.obj, item.item.key) then
            self:drawRect(0, y, self:getWidth(), self.itemheight, 0.3, 0.8, 0.6, 0.4);
        end
        if item.item.key ~= nil and hasDataReadBreakpoint(self.parent.obj, item.item.key) then
            self:drawRect(0, y, self:getWidth(), self.itemheight, 0.3, 0.6, 0.8, 0.4);
        end
    end

    self:drawText(item.text, 15, y + (self.itemheight - FONT_HGT_CODE) / 2, 1, 1, 1, 1, self.font);
    y = y + self.itemheight;
    return y;
end

function ObjectViewer:checkFontSize()
    local font = getTextManager():getCurrentCodeFont()
    local fontHeight = getTextManager():getFontHeight(font)
    if font == self.objectView.font then return end
    FONT_HGT_CODE = fontHeight
    self.historyPrev:setFont(font)
    self.historyPrev:setHeight(FONT_HGT_CODE + 2 * 2)
    self.filter:setX(self.historyPrev:getRight() + 4)
    self.filter:setWidth(self.width - 1 - self.filter.x)
    self.filter:setFont(font)
    self.filter:setHeight(FONT_HGT_CODE + 2 * 2)
    self.objectView:setFont(font, 0)
    self.objectView.itemheight = FONT_HGT_CODE
    self.objectView:setHeight(self.height-self:resizeWidgetHeight()-self.filter:getBottom())
    self.objectView:setY(self.filter:getBottom())
end

function ObjectViewer:historyPush()
    table.insert(self.history, { obj=self.obj, title=self.title })
end

function ObjectViewer:historyPop()
    local hist = table.remove(self.history, #self.history)
    if not hist then return end
    self.obj = hist.obj
    self.title = hist.title
    self:fill()
end

function ObjectViewer:new(x, y, width, height, obj)
    local o = ISCollapsableWindow.new(self, x, y, width, height);
    o.backgroundColor = {r=0, g=0, b=0, a=1.0};
    o.height = getCore():getScreenHeight()/3;
    o.width = (getCore():getScreenWidth()-700)/2;
    o.x = o.width;
    o.y = getCore():getScreenHeight() - (getCore():getScreenHeight()/3);
    o.obj = obj;
    o.history = {}
    ObjectViewer.map[obj] = o;
    return o
end
