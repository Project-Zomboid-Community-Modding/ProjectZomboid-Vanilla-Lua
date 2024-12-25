--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISCollapsableWindow"
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

XuiDebugWindow = ISCollapsableWindow:derive("XuiDebugWindow");
XuiDebugWindow.instance = false;
XuiDebugWindow.customTestWindow = { instance = false, x = false, y = false };
XuiDebugWindow.testWindow = { instance = false, x = false, y = false };
XuiDebugWindow.viewScriptWindow = { instance = false, x = false, y = false };

function XuiDebugWindow.OnOpenPanel(_player)
    if XuiDebugWindow.instance then
        return XuiDebugWindow.instance;
    end
    _player = _player or getPlayer(0);
    local ui = XuiDebugWindow:new(200,200,850,600, _player);
    ui:initialise();
    ui:instantiate();
    ui:setVisible(true);
    ui:addToUIManager();
    XuiDebugWindow.instance = ui;
end

function XuiDebugWindow:initialise()
	ISCollapsableWindow.initialise(self);
end


function XuiDebugWindow:createChildren()
    ISCollapsableWindow.createChildren(self)

    self:initColors();

    self.th = self:titleBarHeight();
    local rh = self.resizable and self:resizeWidgetHeight() or 0;
    self.rh = rh;

    self.minimumWidth = 820+(getCore():getOptionFontSizeReal()*100);
    self.minimumHeight = 500+(getCore():getOptionFontSizeReal()*40);
    self.width = self.minimumWidth;
    self.height = self.minimumHeight;

    self.heightMod = self.th+rh;

    local x,y = UI_BORDER_SPACING+1, self.th+UI_BORDER_SPACING;

    local sidePanelWidth = 160+(getCore():getOptionFontSizeReal()*35)

    self.list = ISScrollingListBox:new(x, y, sidePanelWidth, self.height - self.heightMod - UI_BORDER_SPACING*2 - 2);
    self.list.backgroundColor = {r=0.0, g=0.0, b=0.0, a=1.0};
    self.list:initialise();
    self.list:instantiate();
    self.list.itemheight = BUTTON_HGT;
    self.list.selected = 0;
    self.list.font = UIFont.Small;
    self.list.doDrawItem = XuiDebugWindow.drawConfigItem;
    self.list.target = self;
    self.list.onmousedown = XuiDebugWindow.onConfigSelected;
    self.list.drawBorder = true;
    self:addChild(self.list);

    self.leftWidth = self.list:getRight() + UI_BORDER_SPACING;

    self.colors = ISScrollingListBox:new(self.width - sidePanelWidth - UI_BORDER_SPACING-1, self.list.y, sidePanelWidth, self.list.height);
    self.colors.backgroundColor = {r=0.0, g=0.0, b=0.0, a=1.0};
    self.colors:initialise();
    self.colors:instantiate();
    self.colors.itemheight = BUTTON_HGT;
    self.colors.selected = 0;
    self.colors.font = UIFont.Small;
    self.colors.doDrawItem = XuiDebugWindow.drawColorItem;
    self.colors.target = self;
    self.colors.onmousedown = XuiDebugWindow.onColorSelected;
    self.colors.drawBorder = true;
    --adding later below
    --self:addChild(self.colors);

    self.rightWidth = self.colors:getX() - UI_BORDER_SPACING;

    x = self.leftWidth;
    self.scriptLabel = ISLabel:new(x, y, FONT_HGT_MEDIUM, getText("IGUI_Entities_ViewPanel_ScriptTitle"), 1, 1, 1, 1.0, UIFont.Medium, true);
    self.scriptLabel:initialise();
    self.scriptLabel:instantiate();
    self:addChild(self.scriptLabel);

    local y = y + self.scriptLabel:getHeight()+2;

    self.subLabel = ISLabel:new(x, y, FONT_HGT_SMALL, getText("IGUI_Entities_ViewPanel_Subtitle"), 1, 1, 1, 1.0, UIFont.Small, true);
    self.subLabel:initialise();
    self.subLabel:instantiate();
    self:addChild(self.subLabel);

    local y = y + self.subLabel:getHeight()+UI_BORDER_SPACING;

    local midWidth = self.width - (self.width - self.rightWidth) - self.leftWidth;

    self.viewScriptButton = ISButton:new(x, y, midWidth, FONT_HGT_SMALL,getText("IGUI_XUI_ViewScript"),self, XuiDebugWindow.onButtonClick);
    self.viewScriptButton:initialise();
    self.viewScriptButton.backgroundColor = {r=0, g=0, b=0, a=1.0};
    self.viewScriptButton.backgroundColorMouseOver = {r=1.0, g=1.0, b=1.0, a=0.1};
    self.viewScriptButton.borderColor = {r=1.0, g=1.0, b=1.0, a=0.3};
    self.viewScriptButton.enable = false;
    self:addChild(self.viewScriptButton);

    local y = y + self.viewScriptButton:getHeight()+UI_BORDER_SPACING;

    self.testWindowButton = ISButton:new(x, y, midWidth, FONT_HGT_SMALL,getText("IGUI_XUI_OpenTestWindow"),self, XuiDebugWindow.onButtonClick);
    self.testWindowButton:initialise();
    self.testWindowButton.backgroundColor = {r=0, g=0, b=0, a=1.0};
    self.testWindowButton.backgroundColorMouseOver = {r=1.0, g=1.0, b=1.0, a=0.1};
    self.testWindowButton.borderColor = {r=1.0, g=1.0, b=1.0, a=0.3};
    self.testWindowButton.enable = false;
    self:addChild(self.testWindowButton);

    local y = y + self.testWindowButton:getHeight()+UI_BORDER_SPACING;

    self.testCustomButton = ISButton:new(x, y, midWidth, FONT_HGT_SMALL,getText("IGUI_XUI_OpenCustomTestWindow"),self, XuiDebugWindow.onButtonClick);
    self.testCustomButton:initialise();
    self.testCustomButton.backgroundColor = {r=0, g=0, b=0, a=1.0};
    self.testCustomButton.backgroundColorMouseOver = {r=1.0, g=1.0, b=1.0, a=0.1};
    self.testCustomButton.borderColor = {r=1.0, g=1.0, b=1.0, a=0.3};
    self.testCustomButton.enable = false;
    self:addChild(self.testCustomButton);

    local y = y + self.testCustomButton:getHeight()+UI_BORDER_SPACING;

    self.reloadButton = ISButton:new(x, y, midWidth, FONT_HGT_SMALL,getText("IGUI_XUI_Reload"),self, XuiDebugWindow.onButtonClick);
    self.reloadButton:initialise();
    self.reloadButton.backgroundColor = {r=0, g=0, b=0, a=1.0};
    self.reloadButton.backgroundColorMouseOver = {r=1.0, g=1.0, b=1.0, a=0.1};
    self.reloadButton.borderColor = {r=1.0, g=1.0, b=1.0, a=0.3};
    self.reloadButton.enable = true;
    self:addChild(self.reloadButton);

    local y = y + self.reloadButton:getHeight()+UI_BORDER_SPACING;
    local labelY = y;

    self.elementsLabel = ISLabel:new(x, y, BUTTON_HGT, getText("IGUI_XUI_Elements"), 1, 1, 1, 1.0, UIFont.Small, true);
    self.elementsLabel:initialise();
    self.elementsLabel:instantiate();
    self:addChild(self.elementsLabel);

    local y = y + self.elementsLabel:getHeight()+UI_BORDER_SPACING;
    local botHeight = self.height - y - rh - UI_BORDER_SPACING - 1;

    self.elements = ISScrollingListBox:new(x, y, ((midWidth-UI_BORDER_SPACING)/2), botHeight);
    self.elements.backgroundColor = {r=0.0, g=0.0, b=0.0, a=1.0};
    self.elements:initialise();
    self.elements:instantiate();
    self.elements.itemheight = BUTTON_HGT;
    self.elements.selected = 0;

    --temporary hack for monospace font, will be replaced when a monospace font with variable sizes is in the game files
    if getCore():getOptionFontSizeReal() > 2 then
        self.elements.font = UIFont.Cred1;
    else
        self.elements.font = UIFont.Code;
    end

    self.elements.doDrawItem = XuiDebugWindow.drawElementItem;
    self.elements.target = self;
    self.elements.onmousedown = XuiDebugWindow.onElementSelected;
    self.elements.drawBorder = true;
    self:addChild(self.elements);

    self.varsLabel = ISLabel:new(self.elements:getRight()+UI_BORDER_SPACING, labelY, BUTTON_HGT, getText("IGUI_XUI_Variables"), 1, 1, 1, 1.0, UIFont.Small, true);
    self.varsLabel:initialise();
    self.varsLabel:instantiate();
    self:addChild(self.varsLabel);

    self.vars = ISScrollingListBox:new(self.varsLabel.x, y, self.elements.width, botHeight);
    self.vars.backgroundColor = {r=0.0, g=0.0, b=0.0, a=1.0};
    self.vars:initialise();
    self.vars:instantiate();
    self.vars.itemheight = BUTTON_HGT;
    self.vars.selected = 0;
    self.vars.font = UIFont.Small;
    self.vars.doDrawItem = XuiDebugWindow.drawVarItem;
    --self.vars.target = self;
    --self.vars.onmousedown = XuiDebugWindow.onVarSelected;
    self.vars.drawBorder = true;
    self:addChild(self.vars);

    --fixme, currently adding colors here.
    --fixme, if colors is added before self.vars the stencil overflow is drawn into colors box.
    self:addChild(self.colors);

    self:setWidth(self.width);
    self:setHeight(self.height);

    self.selectedScriptItem = false;
    self.selectedElementItem = false;

    self:populate();
end

function XuiDebugWindow:initColors()
    local c = Colors.CornFlowerBlue;
    self.styleColor = {
        r = c:getRedFloat(),
        g = c:getGreenFloat(),
        b = c:getBlueFloat(),
        a = 1,
    };
    c = Colors.Aquamarine;
    self.defStyleColor = {
        r = c:getRedFloat(),
        g = c:getGreenFloat(),
        b = c:getBlueFloat(),
        a = 1,
    };
    self.scriptColor = {
        r = 1,
        g = 1,
        b = 1,
        a = 1,
    };
    c = Colors.DarkRed;
    self.disableColor = {
        r = 0.4, --c:getRedFloat(),
        g = 0.4, --c:getGreenFloat(),
        b = 0.4, --c:getBlueFloat(),
        a = 0.8,
    };
    c = Colors.Pink;
    self.nullColor = {
        r = c:getRedFloat(),
        g = c:getGreenFloat(),
        b = c:getBlueFloat(),
        a = 0.8,
    };
    c = Colors.DarkKhaki;
    self.headerColor = {
        r = c:getRedFloat(),
        g = c:getGreenFloat(),
        b = c:getBlueFloat(),
        a = 0.8,
    };
    c = Colors.Goldenrod;
    self.referenceColor = {
        r = c:getRedFloat(),
        g = c:getGreenFloat(),
        b = c:getBlueFloat(),
        a = 0.8,
    };
    c = Colors.DarkGray;
    self.tableColor = {
        r = c:getRedFloat(),
        g = c:getGreenFloat(),
        b = c:getBlueFloat(),
        a = 0.8,
    };
end

function XuiDebugWindow:onResize(_width, _height)
    ISCollapsableWindow.onResize(self, _width, _height);

    local listH = self.height - self.heightMod - UI_BORDER_SPACING*2-1;
    self.list:setHeight(listH);
    self.colors:setHeight(listH);

    local colX = self.width - self.colors:getWidth() - UI_BORDER_SPACING-1;
    self.colors:setX(colX);
    self.rightWidth = self.colors:getX()-UI_BORDER_SPACING;

    local midWidth = self.width - (self.width - self.rightWidth) - self.leftWidth;
    --print("resizing "..tostring(midWidth))
    self.viewScriptButton:setWidth(midWidth);
    self.testWindowButton:setWidth(midWidth);
    self.testCustomButton:setWidth(midWidth);
    self.reloadButton:setWidth(midWidth);

    local y = self.elementsLabel:getY() + self.elementsLabel:getHeight() + UI_BORDER_SPACING;
    local botHeight = self.height - y - self.rh - UI_BORDER_SPACING - 1;

    self.elements:setHeight(botHeight);
    self.elements:setWidth(((midWidth-UI_BORDER_SPACING)/2));

    self.varsLabel:setX(self.elements:getRight()+UI_BORDER_SPACING);
    self.vars:setX(self.varsLabel.x);
    self.vars:setHeight(botHeight);
    self.vars:setWidth(self.elements.width);
end

function XuiDebugWindow:prerender()
    ISCollapsableWindow.prerender(self)
end


function XuiDebugWindow:render()
    ISCollapsableWindow.render(self)
end

function XuiDebugWindow:drawVarItem(y, item, alt)
    local a = 1.0;

    self:drawRectBorder( 1, y+1, self:getWidth()-2, self.itemheight - 2, 0.2, 1.0, 1.0, 1.0)
    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.2, 1.0, 1.0, 1.0);
    end

    local x = 10+item.item.keyLen;
    if item.item.var and item.item.var:getType()==XuiVarType.Color then
        local c = item.item.valueColor;
        if c then
            self:drawRect(x, y+4, 20, self.itemheight - 8, 1.0, c.r, c.g, c.b);
        end
        self:drawRectBorder( x, y+4, 20, self.itemheight - 8, 0.2, 1.0, 1.0, 1.0);
        x = x + 30;
    end


    if item.item.name then
        local drawY = y + (self.itemheight/2) - (FONT_HGT_SMALL /2);
        local c = item.item.color;
        self:drawText( item.item.name, 5, drawY, c.r, c.g, c.b, c.a, self.font);
        c = item.item.valueColor or item.item.color;
        if item.item.var and item.item.var:getType()==XuiVarType.Color then
            c = item.item.color;
        end
        self:drawText( item.item.value, x, drawY, c.r, c.g, c.b, c.a, self.font);
    end

    return y + self.itemheight;
end

function XuiDebugWindow:onVarSelected(_item)
    -- nothing to do here so var
end

local sortAlpha = function (a, b)
    return a.name < b.name
end

local sortVars = function (a, b)
    -- sort by UiOrder
    if a.uiOrder~=b.uiOrder then
        return a.uiOrder>b.uiOrder;
    end
    -- if value set
    if a.enabled~=b.enabled then
        return a.enabled;
    end
    -- sort value by origin type
    if a.type~=b.type then
        if a.type==XuiScriptType.Layout then
            return true;
        elseif a.type == XuiScriptType.Style and b.type==XuiScriptType.DefaultStyle then
            return true;
        else
            return false;
        end
    end
    -- finally sort alphabetically.
    return a.name < b.name
end

function XuiDebugWindow:createVarItem(_name, _value, _order, _var)
    local t = {};
    t.enabled = true;
    t.name = tostring(_name);
    t.keyLen = getTextManager():MeasureStringX( UIFont.Small, t.name );
    t.uiOrder = _order;
    t.value = tostring(_value);
    t.color = self.scriptColor;
    t.valueColor = self.scriptColor;
    if not _var then
        t.type = XuiScriptType.Layout;
        t.isTextOnly = true;
        t.color = self.headerColor;
        t.valueColor = self.headerColor;
    else
        t.var = _var;
        t.type = _var:getValueType();
        --t.value = _var:getValueString();
        if _var:getValueType()==XuiScriptType.Style then
            t.color = self.styleColor;
        elseif _var:getValueType()==XuiScriptType.DefaultStyle then
            t.color = self.defStyleColor;
        end
        if _var:getType()==XuiVarType.Color and _var:value() then
            local c = _var:value();
            t.valueColor = {
                r = c:getRedFloat(),
                g = c:getGreenFloat(),
                b = c:getBlueFloat(),
                a = 0.8,
            };
        end
        if not _var:isValueSet() then
            t.enabled = false;
            t.color = self.disableColor;
            t.valueColor = self.disableColor;
            t.uiOrder = 0;
        end
    end
    if t.value==nil then
        t.value = "null";
    end

    if t.enabled and t.value=="null" then
        t.valueColor = self.nullColor;
    end

    return t;
end

function XuiDebugWindow:populateVars()
    self.vars:clear();
    if self.selectedElementItem and self.selectedElementItem.script then
        local maxKeyLen = 0;
        local script = self.selectedElementItem.script;

        local temp = {};

        local t = self:createVarItem(
                "_config",
                script:getXuiLayoutName() or "null",
                10000
        );
        table.insert(temp, t);

        local style = script:getStyle();
        local t = self:createVarItem(
                "_style",
                style and style:getXuiLayoutName() or "null",
                9999
        );
        table.insert(temp, t);

        local defStyle = script:getDefaultStyle();
        local t = self:createVarItem(
                "_defaultStyle",
                defStyle and defStyle:getXuiLayoutName() or "null",
                9998
        );
        table.insert(temp, t);

        local t = self:createVarItem(
                "_type",
                script:getScriptType() or "null",
                9997
        );
        table.insert(temp, t);

        local t = self:createVarItem(
                "_uuid",
                script:getXuiUUID() or "null",
                9996
        );
        table.insert(temp, t);

        local vars = script:getVars();
        for i=0,vars:size()-1 do
            local var = vars:get(i);
            local t = self:createVarItem(
                    var:getLuaTableKey(),
                    var:getValueString(),
                    var:getUiOrder(),
                    var
            );
            table.insert(temp, t);

        end

        for _, item in ipairs(temp) do
            maxKeyLen = math.max(maxKeyLen, item.keyLen);
        end

        table.sort(temp, sortVars);

        for _, item in ipairs(temp) do
            item.keyLen = maxKeyLen;
            self.vars:addItem(item.name, item);
        end
    end
end

function XuiDebugWindow:drawElementItem(y, item, alt)
    local a = 1.0;

    self:drawRectBorder( 1, y+1, self:getWidth()-2, self.itemheight - 2, 0.2, 1.0, 1.0, 1.0)
    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.2, 1.0, 1.0, 1.0);
    end


    if item.item.name then
        local drawY = y + (self.itemheight/2) - (FONT_HGT_SMALL /2);
        local c = item.item.color;
        self:drawText( item.item.display, 5, drawY, c.r, c.g, c.b, c.a, self.font);
        self:drawText( item.item.display, 5, drawY, c.r, c.g, c.b, c.a, self.font);
    end

    return y + self.itemheight;
end

function XuiDebugWindow:onElementSelected(_item)

    self.selectedElementItem = _item;
    if self.selectedElementItem and self.selectedElementItem.script then
        local script = self.selectedElementItem.script;
        if script and XuiDebugWindow.testWindow.instance then
            local uuid = script:getXuiUUID();
            XuiDebugWindow.testWindow.instance:selectUUID(uuid);
        end
    end
    self:populateVars();
end

function XuiDebugWindow:addScriptElements(_script, _depth, _color)
    local name = tostring(_script:getXuiLuaClass());
    if _script:getScriptType()==XuiScriptType.Reference then
        local reference = _script:getReferenceLayout();
        if reference then
            self:addScriptElements(reference, _depth, self.referenceColor);
            return;
        end
        _color = self.referenceColor;
    end
    if name=="ISXuiTableLayout" then
        self.elements:addItem(name, {
            name = name,
            display = string.rep(" ", _depth).."["..tostring(_depth).."] Table";
            color = _color or self.scriptColor,
            script = _script,
        });
        local nextDepth = _depth + 1;
        for i=0,_script:getRowCount()-1 do
            local e = _script:getRow(i);
            local eName = e:getXuiLuaClass();
            self.elements:addItem(eName, {
                name = eName,
                display = string.rep(" ", nextDepth).."["..tostring(nextDepth).."] Row";
                color = self.tableColor,
                script = e,
            });
        end
        for i=0,_script:getColumnCount()-1 do
            local e = _script:getColumn(i);
            local eName = e:getXuiLuaClass();
            self.elements:addItem(eName, {
                name = eName,
                display = string.rep(" ", nextDepth).."["..tostring(nextDepth).."] Col";
                color = self.tableColor,
                script = e,
            });
        end
        for y=0,_script:getRowCount()-1 do
            for x=0,_script:getColumnCount()-1 do
                local e = _script:getCell(x, y);
                local eName = e:getXuiLuaClass();
                self.elements:addItem(eName, {
                    name = eName,
                    display = string.rep(" ", nextDepth).."["..tostring(nextDepth).."] Cell ["..tostring(x)..","..tostring(y).."]";
                    color = _color or self.scriptColor,
                    script = e,
                });
                local children = e:getChildren();
                for i=0,children:size()-1 do
                    local child = children:get(i);
                    self:addScriptElements(child, nextDepth + 1, _color);
                end
            end
        end
    else
        self.elements:addItem(name, {
            name = name,
            display = string.rep(" ", _depth).."["..tostring(_depth).."] "..name;
            color = _color or self.scriptColor,
            script = _script,
        });
        local children = _script:getChildren();
        for i=0,children:size()-1 do
            local child = children:get(i);
            self:addScriptElements(child, _depth + 1, _color);
        end
    end
end

function XuiDebugWindow:populateElements()
    self.elements:clear();
    self.selectedElementItem = false;
    if self.selectedScriptItem and self.selectedScriptItem.script then
        local script = self.selectedScriptItem.script;
        self:addScriptElements(script, 0);
        if self.elements.items and #self.elements.items>0 then
            --print("SELECTING ELEMENT")
            self.elements.selected = 1;
            self:onElementSelected(self.elements.items[self.elements.selected].item);
        end
    end
    --self:populateVars();
end

function XuiDebugWindow:drawConfigItem(y, item, alt)
    local a = 1.0;

    self:drawRectBorder( 1, y+1, self:getWidth()-2, self.itemheight - 2, 0.2, 1.0, 1.0, 1.0)
    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.2, 1.0, 1.0, 1.0);
    end


    if item.item.name then
        local drawY = y + (self.itemheight/2) - (FONT_HGT_SMALL /2);
        local c = item.item.color;
        self:drawText( item.item.name, 5, drawY, c.r, c.g, c.b, c.a, self.font);
    end

    return y + self.itemheight;
end

function XuiDebugWindow:onConfigSelected(_item)
    self.selectedScriptItem = _item;

    self.viewScriptButton.enable = false;
    self.testWindowButton.enable = false;
    self.testCustomButton.enable = false;

    if self.selectedScriptItem then
        self.scriptLabel:setName(_item.name);
        self.subLabel:setName(_item.type:toString());
        local c = self.scriptColor;
        if _item.type==XuiScriptType.Style then
            c = self.styleColor;
        elseif _item.type==XuiScriptType.DefaultStyle then
            c = self.defStyleColor;
        end
        self.subLabel:setColor(c.r,c.g,c.b);
        if _item.script then
            if _item.script:getXuiLayoutName() then
                self.viewScriptButton.enable = true;
            end
            self.testWindowButton.enable = true;
            if _item.script:getXuiCustomDebug() then
                self.testCustomButton.enable = true;
            end
        end
    else
        --
    end
    self:populateElements();
end

function XuiDebugWindow:drawColorItem(y, item, alt)
    local a = 1.0;

    self:drawRectBorder( 1, y+1, self:getWidth()-2, self.itemheight - 2, 0.2, 1.0, 1.0, 1.0)
    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.2, 1.0, 1.0, 1.0);
    end

    local x = 5;
    if item.item.color then
        local c = item.item.color;
        self:drawRect(x, y+4, 20, self.itemheight - 8, 1.0, c:getRedFloat(), c:getGreenFloat(), c:getBlueFloat());
        self:drawRectBorder( x, y+4, 20, self.itemheight - 8, 0.2, 1.0, 1.0, 1.0);
        x = 30;
    end

    if item.item.name then
        local drawY = y + (self.itemheight/2) - (FONT_HGT_SMALL /2);
        local c = item.item.textColor;
        self:drawText( item.item.name, x, drawY, c.r, c.g, c.b, a, self.font);
    end

    return y + self.itemheight;
end

function XuiDebugWindow:onColorSelected(_item)
end

local sortColors = function (a, b)
    -- sort by index of the color set
    if a.setIndex~=b.setIndex then
        return a.setIndex<b.setIndex;
    end
    -- finally sort alphabetically.
    return a.name < b.name
end

local sortLayouts = function (a, b)
    -- sort value by type (layout, style, default style)
    if a.type~=b.type then
        if a.type==XuiScriptType.Layout then
            return true;
        elseif a.type == XuiScriptType.Style and b.type==XuiScriptType.DefaultStyle then
            return true;
        else
            return false;
        end
    end
    -- finally sort alphabetically.
    return a.name < b.name
end

function XuiDebugWindow:populate()
    self.list:clear()
    local scripts = XuiManager.GetCombinedScripts();
    local temp = {};
    for i=0,scripts:size()-1 do
        local script = scripts:get(i);
        local name = script:getXuiLayoutName();
        local t = {
            script = script,
            name = name,
            type = script:getScriptType(),
        }
        t.color = self.scriptColor;
        if t.type==XuiScriptType.Style then
            t.color = self.styleColor;
        elseif t.type==XuiScriptType.DefaultStyle then
            t.color = self.defStyleColor;
        end
        --self.list:addItem(name, t);
        table.insert(temp, t);
    end

    table.sort(temp, sortLayouts)

    for _,item in ipairs(temp) do
        self.list:addItem(item.name, item);
    end

    if self.list.items and #self.list.items>0 then
        --print("SELECTING ELEMENT")
        self.list.selected = 1;
        self:onConfigSelected(self.list.items[self.list.selected].item);
    end
    local colors = Colors.GetColorNames();
    temp = {};

    for i=0,colors:size()-1 do
        local name = colors:get(i);
        local nfo = Colors.GetColorInfo(name); --GetColorByName(name);

        table.insert(temp, {
            name = name,
            color = nfo:getColor(),
            nfo = nfo,
            setIndex = (nfo:getColorSetIndex()+1)*10,
            textColor = self.scriptColor,
        });
    end

    table.sort(temp, sortColors)

    self.colors:addItem("custom", {
        name = getText("IGUI_XUI_ColorCustom"),
        setIndex = 0,
        textColor = self.headerColor,
    });

    for _,item in ipairs(temp) do
        if item.setIndex==10 then
            self.colors:addItem(item.name, item);
        end
    end

    self.colors:addItem("system", {
        name = getText("IGUI_XUI_ColorSystem"),
        setIndex = 15,
        textColor = self.headerColor,
    });

    for _,item in ipairs(temp) do
        if item.setIndex==20 then
            self.colors:addItem(item.name, item);
        end
    end
end

function XuiDebugWindow:onButtonClick(_button)
    if _button==self.viewScriptButton then
        if self.selectedScriptItem then
            local script = self.selectedScriptItem.script;
            if script then
                local ui = ISScriptViewWindow:new(200,200,600,500);
                ui:initialise();
                ui:instantiate();
                ui:setVisible(true);
                ui:setTitle("XuiScript: "..tostring(script:getXuiLayoutName()));
                if script:getXuiLayoutName() then
                    local config;
                    if script:isAnyStyle() then
                        config = XuiManager.GetStyleScript(script:getXuiLayoutName());
                    else
                        config = XuiManager.GetLayoutScript(script:getXuiLayoutName());
                    end
                    if config then
                        ui:setScript(config);
                    end
                end
                ui:addToUIManager();
                self:onCloseSubWindow(XuiDebugWindow.viewScriptWindow.instance, true);
                XuiDebugWindow.viewScriptWindow.instance = ui;
                self:positionSubWindow(XuiDebugWindow.viewScriptWindow);
            end
        end
    elseif _button==self.testWindowButton then
        if self.selectedScriptItem then
            local script = self.selectedScriptItem.script;
            if script then
                local ui = XuiDebugLayoutWindow:new(200,200,600,500,self.player, script);
                ui:initialise();
                ui:instantiate();
                ui:setVisible(true);
                ui:addToUIManager();
                self:onCloseSubWindow(XuiDebugWindow.testWindow.instance, true);
                XuiDebugWindow.testWindow.instance = ui;
                self:positionSubWindow(XuiDebugWindow.testWindow);
            end
        end
    elseif _button==self.testCustomButton then
        if self.selectedScriptItem then
            local script = self.selectedScriptItem.script;
            if script and script:getXuiCustomDebug() then
                local class = _G[script:getXuiCustomDebug()];
                if class and class.new then
                    local ui = class:new(200,200,600,500,self.player, script);
                    ui:initialise();
                    ui:instantiate();
                    ui:setVisible(true);
                    ui:addToUIManager();
                    --[[if XuiDebugWindow.customTestWindow.instance then
                        XuiDebugWindow.customTestWindow.instance:close();
                    end--]]
                    self:onCloseSubWindow(XuiDebugWindow.customTestWindow.instance, true);
                    XuiDebugWindow.customTestWindow.instance = ui;
                    self:positionSubWindow(XuiDebugWindow.customTestWindow);
                end
            end
        end
    elseif _button==self.reloadButton then
        reloadXui();
        self.selectedScriptItem = false;
        self.selectedElementItem = false;

        self:populate();
    end
end

function XuiDebugWindow:positionSubWindow(_window)
    if _window and _window.instance then
        if _window.x then
            _window.instance:setX(_window.x);
        end
        if _window.y then
            _window.instance:setY(_window.y);
        end
    end
end

function XuiDebugWindow:onCloseSubWindow(_window, _closeIt)
    if XuiDebugWindow.customTestWindow.instance and XuiDebugWindow.customTestWindow.instance==_window then
        XuiDebugWindow.customTestWindow.x = XuiDebugWindow.customTestWindow.instance:getAbsoluteX();
        XuiDebugWindow.customTestWindow.y = XuiDebugWindow.customTestWindow.instance:getAbsoluteY();
        if _closeIt then
            XuiDebugWindow.customTestWindow.instance:close();
        end
        XuiDebugWindow.customTestWindow.instance = nil;
    end
    if XuiDebugWindow.testWindow.instance and XuiDebugWindow.testWindow.instance==_window then
        XuiDebugWindow.testWindow.x = XuiDebugWindow.testWindow.instance:getAbsoluteX();
        XuiDebugWindow.testWindow.y = XuiDebugWindow.testWindow.instance:getAbsoluteY();
        if _closeIt then
            XuiDebugWindow.testWindow.instance:close();
        end
        XuiDebugWindow.testWindow.instance = nil;
    end
    if XuiDebugWindow.viewScriptWindow.instance and XuiDebugWindow.viewScriptWindow.instance==_window then
        XuiDebugWindow.viewScriptWindow.x = XuiDebugWindow.viewScriptWindow.instance:getAbsoluteX();
        XuiDebugWindow.viewScriptWindow.y = XuiDebugWindow.viewScriptWindow.instance:getAbsoluteY();
        if _closeIt then
            XuiDebugWindow.viewScriptWindow.instance:close();
        end
        XuiDebugWindow.viewScriptWindow.instance = nil;
    end
end

function XuiDebugWindow:close()
    ISCollapsableWindow.close(self);
    if JoypadState.players[self.playerNum+1] then
        if getFocusForPlayer(self.playerNum)==self then
            setJoypadFocus(self.playerNum, nil);
        end
    end
    self:removeFromUIManager();
    XuiDebugWindow.instance = nil;
    self:onCloseSubWindow(XuiDebugWindow.customTestWindow.instance, true);
    self:onCloseSubWindow(XuiDebugWindow.testWindow.instance, true);
    self:onCloseSubWindow(XuiDebugWindow.viewScriptWindow.instance, true);
end

function XuiDebugWindow:new (x, y, width, height, player)
	local o = ISCollapsableWindow:new(x, y, width, height);
	setmetatable(o, self)
	self.__index = self
    o.player = player;
    o.playerNum = player:getPlayerNum();
    o.title = getText("IGUI_DebugMenu_Main_XUI");
    ISDebugMenu.RegisterClass(self);
	return o
end