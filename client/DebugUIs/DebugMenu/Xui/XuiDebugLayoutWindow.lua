--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

--[[
    Used by XuiDebugWindow to display a layout.
    This window allows to have selected elements in the XuiDebugWindow to be highlighted.
--]]

require "ISUI/ISCollapsableWindow"

XuiDebugLayoutWindow = ISCollapsableWindow:derive("XuiDebugLayoutWindow");

function XuiDebugLayoutWindow:initialise()
	ISCollapsableWindow.initialise(self);
end


function XuiDebugLayoutWindow:createChildren()
    ISCollapsableWindow.createChildren(self)
    self.th = self:titleBarHeight();
    self.rh = self.resizable and self:resizeWidgetHeight() or 0;
    self.heightMod = self.th+self.rh;

    ISXuiBuilder.setDrawRectangle(self, 0, self.th, self.width, self.height-self.heightMod);

    self.xuiPanel = ISXuiBuilder.build(self.xuiScript, self);
    self:addChild(self.xuiPanel);

    local v = self.xuiScript:getVector();
    if (not v:iswPercent()) and self.xuiPanel:getWidth()>0 then
        self:setWidth(self.xuiPanel:getWidth());
    end
    if (not v:ishPercent()) and self.xuiPanel:getHeight()>0 then
        self:setHeight(self.xuiPanel:getHeight()+self.heightMod);
    end
end

function XuiDebugLayoutWindow:onResize(_width, _height)
    ISXuiBuilder.setDrawRectangle(self, 0, self.th, self.width, self.height-self.heightMod);
end

function XuiDebugLayoutWindow:close()
	ISCollapsableWindow.close(self);

    self:removeFromUIManager();
    if self.parent and self.parent.onCloseSubWindow then
        self.parent:onCloseSubWindow(self, false);
    end
end


-- collects all elements with script uuid in the hierarchy
-- modified for debug to grab cells
function XuiDebugLayoutWindow:debugXuiFindAllUUID(_self, _uuid, _list)
    local list = _list or {};
    if (not _uuid) or (not _self.xuiGetUUID) then
        return list;
    end

    local uuid = _self:xuiGetUUID();
    if uuid and uuid==_uuid then
        table.insert(list, _self);
    end
    if _self.__xui and _self.__xui.script and _self.cells then
        local script = _self.__xui.script;
        if script:getXuiLuaClass()=="ISXuiTableLayout" then
            for _,cell in ipairs(_self.cells) do
                if cell and cell.__xui and cell.__xui.script then
                    local uuid = cell.__xui.script:getXuiUUID();
                    if uuid==_uuid then
                        table.insert(list, cell);
                    end
                end
            end
        end
    end
    if _self.__xui and _self.__xui.children then
        for _,v in ipairs(_self.__xui.children) do
            list = XuiDebugLayoutWindow.debugXuiFindAllUUID(self, v.element, _uuid, list);
        end
    end
    return list;
end


function XuiDebugLayoutWindow:selectUUID(_uuid)
    --self.selectedUUID = _uuid;
    self.selections = {};
    if _uuid then
        if self.selectedUUID and self.selectedUUID==_uuid then
            self.toggle = not self.toggle;
        else
            self.toggle = true;
        end
        self.selectedUUID = _uuid;
    else
        self.toggle = false;
        self.selectedUUID = nil;
    end
    if self.selectedUUID and self.toggle then
        if self.xuiPanel then
            --local elements = self:xuiFindAllUUID(self.selectedUUID, {});
            --print("uuid = "..tostring(self.selectedUUID))
            local elements = self:debugXuiFindAllUUID(self, self.selectedUUID, {});

            for _,elem in ipairs(elements) do
                local x = elem.getAbsoluteX and elem:getAbsoluteX() or -10000;
                local y = elem.getAbsoluteY and elem:getAbsoluteY() or -10000;
                local w = elem.getWidth and elem:getWidth() or elem.width or -1000;
                local h = elem.getHeight and elem:getHeight() or elem.height or -1000;

                --print("x="..tostring(x)..", y="..tostring(y)..", w="..tostring(w)..", h="..tostring(h))
                if x~=-10000 and y~=-10000 and w>0 and h>0 then
                    table.insert(self.selections, {
                        e = elem,
                        w = w,
                        h = h,
                    })
                end
            end
        end
    else
        --clear
    end
end

function XuiDebugLayoutWindow:prerender()
    ISCollapsableWindow.prerender(self)
end


function XuiDebugLayoutWindow:render()
    ISCollapsableWindow.render(self);

    self.selectColor.g = self.selectColor.g + self.colMod;
    if self.selectColor.g>1 then
        self.selectColor.g = 1;
        self.colMod = self.colMod * -1;
    elseif self.selectColor.g<0.5 then
        self.selectColor.g = 0.5;
        self.colMod = self.colMod * -1;
    end
    --self.selectColor.r = self.selectColor.g;
    --self.selectColor.b = self.selectColor.g;

    local nums = #self.selections;
    if nums>0 then
        local c = self.selectColor;
        for i=1,nums do
            local e = self.selections[i];
            local x = e.e:getAbsoluteX()-self:getAbsoluteX();
            local y = e.e:getAbsoluteY()-self:getAbsoluteY();

            if nums==1 then
                --ISXuiBuilder.setDrawRectangle(self, 0, self.th, self.width, self.height-self.heightMod);
                --self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.5, 0.0, 0.0, 0.0);
                local dy = self.th;
                local dh = self.height-self.heightMod;
                if x>0 then
                    self:drawRect(0, math.floor(dy), math.floor(x), math.floor(dh), self.dAplha, 0.0, 0.0, 0.0);
                end
                if x+e.w<self.width then
                    self:drawRect(math.floor(x+e.w), math.floor(dy), math.floor(self.width-(x+e.w)), dh, self.dAplha, 0.0, 0.0, 0.0);
                end
                if y>0 then
                    self:drawRect(math.floor(x), math.floor(dy), math.floor(e.w), math.floor(y-dy), self.dAplha, 0.0, 0.0, 0.0);
                end
                if y+e.h<self.height-self.rh then
                    self:drawRect(math.floor(x), math.floor(y+e.h), math.floor(e.w), math.floor(dh-(y+e.h-dy)), self.dAplha, 0.0, 0.0, 0.0);
                end
            end

            self:drawRectBorder( x, y, e.w, e.h, 1.0, c.r, c.g, c.b);
            self:drawRectBorder( x-1, y-1, e.w+1, e.h+1, 1.0, c.r, c.g, c.b);
        end
    end
end

function XuiDebugLayoutWindow:new (x, y, width, height, player, script)
	local o = ISCollapsableWindow:new(x, y, width, height, player, script);
	setmetatable(o, self)
	self.__index = self
    o.player = player;
    o.xuiScript = script;
    o.minimumWidth = 0;
    o.minimumHeight = 0;
    o.selectedUUID = false;
    o.selections = {};
    o.selectColor = { r=0,g=1,b=0,a=1}
    o.colMod = 0.02;
    o.toggle = true;
    o.dAplha = 0.6;
    ISDebugMenu.RegisterClass(self);
	return o
end
