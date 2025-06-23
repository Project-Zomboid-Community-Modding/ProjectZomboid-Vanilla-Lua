require "ISUI/ISPanel"

LuaThreadWindow = ISPanel:derive("LuaThreadWindow");

local FONT_HGT_CODE = getTextManager():getFontHeight(getTextManager():getCurrentCodeFont())
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)


function LuaThreadWindow:onMouseDoubleClickCallframe(item)

    local f = getFilenameOfCallframe(item.call);
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
        src:scrollToLine(item.line+1)
    end
end

function LuaThreadWindow:onMouseDoubleClickObject(item)

    if instanceof (item, "KahluaTableImpl") then
        local src = ObjectViewer:new(getCore():getScreenWidth() / 2, 0, 600, 300, item);

        src:initialise();
        src:addToUIManager();

    elseif instanceof (item, "String") then

    elseif instanceof (item, "Class") then

    elseif instanceof (item, "Method") then

    elseif instanceof (item, "Double") then

    elseif instanceof (item, "Boolean") then
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

    elseif instanceof (item, "Texture") then

        local src = TextureWindow:new(getCore():getScreenWidth() / 2, 0, item:getWidth(), item:getHeight(), item);

        src:initialise();
        src:addToUIManager();

    else
        local src = ObjectViewer:new(getCore():getScreenWidth() / 2, 0, 600, 300, item);

        src:initialise();
        src:addToUIManager();

    end

end

function LuaThreadWindow:onMouseDoubleClickMeta(item)


        local src = ObjectViewer:new(getCore():getScreenWidth() / 2, 0, 600, 300, item.data);

        src:initialise();
        src:addToUIManager();



end

function LuaThreadWindow:fill()
    self.metaNodes:clear();
    self.objectStack:clear();
    self.callframeStack:clear();
    self.locals:clear();
    local coroutine = getCurrentCoroutine();
    local count = getCoroutineTop(coroutine);
    for i= count - 1, 0, -1 do
        local o = getCoroutineObjStack(coroutine,i);
        if o ~= nil then
            local s = KahluaUtil.rawTostring2(o);
            if s ~= nil then
                if #s > 128 then s = s:sub(1, 128) end
                self.objectStack:addItem(s, o);
            end
        end
    end
    count = getCallframeTop(coroutine);
    for i= count - 1, 0, -1 do
        local o = getCoroutineCallframeStack(coroutine,i);
        if o ~= nil then
            local s = KahluaUtil.rawTostring2(o);
            if s ~= nil then
                self.callframeStack:addItem(s, {call = o, line = getLineNumber(o)});
            end
        end
    end
    self:populateLocalVariables()
end

function LuaThreadWindow:populateLocalVariables()
    self.locals:clear()
    local coroutine = getCurrentCoroutine();
    local count = 0
    local callframeItem = self.callframeStack.items[self.callframeStack.selected]
    if callframeItem then
        local callFrame = callframeItem.item.call
        count = getLocalVarCount(callFrame)
        for i= count,1,-1 do
            local s = getLocalVarName(callFrame, i-1)
            if s ~= nil then
                local stack = getLocalVarStackIndex(callFrame, i-1)
                s = tabToX(s, 40)
                local o = getCoroutineObjStack(coroutine, stack)
                local s2 = KahluaUtil.rawTostring2(o)
                if s2 == nil then s2 = "nil" end
                if #s2 > 128 then s2 = s2:sub(1, 128) end
                self.locals:addItem(s..s2, o)
            end
        end
        return
    end

    count = getLocalVarCount(coroutine)
    for i= count - 1, 0, -1 do
        local s = getLocalVarName(coroutine,i)

        if s ~= nil then
            local stack = getLocalVarStack(coroutine, i)
            s = tabToX(s, 40);
            local s2 = KahluaUtil.rawTostring2(getCoroutineObjStack(coroutine,stack))
            if s2 == nil then s2 = "nil" end
            if #s2 > 128 then s2 = s2:sub(1, 128) end
            self.locals:addItem(s..s2, getCoroutineObjStack(coroutine,stack))
        end
    end
end

function LuaThreadWindow:createChildren()

    local oldw = self.width;
    self.width =  self.width * 0.7

    self.objectStack = ISScrollingListBox:new(0, FONT_HGT_MEDIUM+(self.height/3), self.width / 2, (self.height/3)-FONT_HGT_MEDIUM);
    self.objectStack:setFont(getTextManager():getCurrentCodeFont(), 0)
    self.objectStack:initialise();
    self.objectStack.doDrawItem = LuaThreadWindow.doDrawItem;
    self.objectStack:setOnMouseDoubleClick(self, LuaThreadWindow.onMouseDoubleClickObject);

    self.callframeStack = ISScrollingListBox:new(self.width / 2, FONT_HGT_MEDIUM, self.width / 2, (self.height/3)-FONT_HGT_MEDIUM);
    self.callframeStack:setFont(getTextManager():getCurrentCodeFont(), 0)
    self.callframeStack:initialise();
    self.callframeStack.doDrawItem = LuaThreadWindow.doDrawItem;
    self.callframeStack:setOnMouseDoubleClick(self, LuaThreadWindow.onMouseDoubleClickCallframe);

    self.locals = ISScrollingListBox:new(0, FONT_HGT_MEDIUM, self.width / 2, (self.height/3)-FONT_HGT_MEDIUM);
    self.locals:setFont(getTextManager():getCurrentCodeFont(), 0)
    self.locals:initialise();
    self.locals.doDrawItem = LuaThreadWindow.doDrawItem;
    self.locals.doRepaintStencil = true
    self.locals:setOnMouseDoubleClick(self, LuaThreadWindow.onMouseDoubleClickObject);

    self.metaNodes = ISScrollingListBox:new(self.width / 2, FONT_HGT_MEDIUM+(self.height/3), self.width / 2, (self.height/3)-FONT_HGT_MEDIUM);
    self.metaNodes:setFont(getTextManager():getCurrentCodeFont(), 0)
    self.metaNodes:initialise();
    self.metaNodes.doDrawItem = LuaThreadWindow.doDrawItem;
    self.metaNodes:setOnMouseDoubleClick(self, LuaThreadWindow.onMouseDoubleClickMeta);

    self:addChild(self.metaNodes);
    self:addChild(self.locals);
    self:addChild(self.objectStack);
    self:addChild(self.callframeStack);
    self:fill();
    self.width = oldw;
--[[
    -- Do corner x + y widget
    local resizeWidget = ISResizeWidget:new(self.width-10, self.height-10, 10, 10, self);
    resizeWidget:initialise();
    self:addChild(resizeWidget);

    self.resizeWidget = resizeWidget;

    -- Do bottom y widget
    resizeWidget = ISResizeWidget:new(0, self.height-10, self.width-10, 10, self, true);
    resizeWidget.anchorRight = true;
    resizeWidget:initialise();
    self:addChild(resizeWidget);

    self.resizeWidget2 = resizeWidget;
--]]
    end


function LuaThreadWindow:doDrawItem(y, item, alt)
    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight-1, 0.3, 0.7, 0.35, 0.15);

    end
    self:drawRectBorder(0, (y), self:getWidth(), self.itemheight, 0.5, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawText(item.text, 15, y + (self.itemheight - FONT_HGT_CODE) / 2, 0.9, 0.9, 0.9, 0.9, self.font);
    y = y + self.itemheight;
    return y;

end

function LuaThreadWindow:onResize(width, height)
    ISPanel.onResize(self, width, height)
    width = width * 0.7

    self.locals:setWidth(width / 2)
    self.locals:setHeight(height/3-FONT_HGT_MEDIUM)

    self.objectStack:setWidth(width / 2)
    self.objectStack:setHeight(height/3-FONT_HGT_MEDIUM)
    self.objectStack:setY(FONT_HGT_MEDIUM+height/3)
   
    self.callframeStack:setWidth(width / 2)
    self.callframeStack:setHeight(height/3-FONT_HGT_MEDIUM)
    self.callframeStack:setX(width / 2)
    
    self.metaNodes:setWidth(width / 2)
    self.metaNodes:setHeight(height/3-FONT_HGT_MEDIUM)
    self.metaNodes:setX(width / 2)
    self.metaNodes:setY(FONT_HGT_MEDIUM+height/3)
end

function LuaThreadWindow:checkFontSize()
    local font = getTextManager():getCurrentCodeFont()
    if font == self.objectStack.font then return end
    local fontHeight = getTextManager():getFontHeight(font)
    FONT_HGT_CODE = fontHeight
    self.objectStack:setFont(font, 0)
    self.callframeStack:setFont(font, 0)
    self.locals:setFont(font, 0)
    self.metaNodes:setFont(font, 0)
end

function LuaThreadWindow:initialise()
    ISPanel.initialise(self);
end

function LuaThreadWindow:prerender()
    self:checkFontSize()
    if self.callframeStack.selected ~= self.currentCallframeIndex then
        self.currentCallframeIndex = self.callframeStack.selected
        self:populateLocalVariables()
    end
    ISPanel.prerender(self)
end

function LuaThreadWindow:render()
    local oldw = self.width;
    self.width =  self.width * 0.7

   -- self:drawText("META NODES", 8+ (self.width/2), 8+(self.height/3), 0.9, 0.9, 0.9, 0.9, UIFont.Medium);
    self:drawText("OBJECT STACK", 8, (self.height/3), 0.9, 0.9, 0.9, 0.9, UIFont.Medium);
    self:drawText("CALLSTACK", 8 + (self.width/2), 0, 0.9, 0.9, 0.9, 0.9, UIFont.Medium);
    self:drawText("LOCALS", 8, 0, 0.9, 0.9, 0.9, 0.9, UIFont.Medium);
    self.width = oldw;

end

function LuaThreadWindow:new (x, y, width, height)
    local o = {}
    --o.data = {}
    o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.x = x;
    o.y = y;
    o.backgroundColor = {r=0, g=0, b=0, a=1};
    o.borderColor = {r=1, g=1, b=1, a=0.7};

    return o
end


