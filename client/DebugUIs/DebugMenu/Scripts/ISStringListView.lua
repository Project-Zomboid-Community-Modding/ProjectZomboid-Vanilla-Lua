--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISCollapsableWindow"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

ISStringListView = ISPanel:derive("ISStringListView");

function ISStringListView:initialise()
    ISPanel.initialise(self);
end

function ISStringListView:createChildren()
    ISPanel.createChildren(self);

    local x,y = UI_BORDER_SPACING+1, UI_BORDER_SPACING+1;

    local width = self.width - x*2;

    self.listLabel = ISLabel:new(x, y, BUTTON_HGT, getText("IGUI_DebugMenu_Search"), 1, 1, 1, 1.0, UIFont.Small, true);
    self.listLabel:initialise();
    self.listLabel:instantiate();
    self:addChild(self.listLabel);

    self.labelWidth = getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_DebugMenu_Search")) + UI_BORDER_SPACING;

    self.entryBox = ISTextEntryBox:new("", x+self.listLabel.width+UI_BORDER_SPACING, y, width-self.listLabel.width+UI_BORDER_SPACING, BUTTON_HGT);
    self.entryBox.font = UIFont.Small;
    self.entryBox:initialise();
    self.entryBox:instantiate();
    self.entryBox.onTextChange = ISStringListView.onTextChange;
    self.entryBox.target = self;
    self.entryBox:setClearButton(true);
    self:addChild(self.entryBox);

    y = self.entryBox:getY() + self.entryBox:getHeight() + UI_BORDER_SPACING;

    --self.infoListY = y;

    self.infoList = ISScrollingListBox:new(x, y, width, self.height - y - UI_BORDER_SPACING-1);
    self.infoList.backgroundColor = {r=0.9, g=0.9, b=0.9, a=1.0};
    self.infoList.iconExpand = self.iconExpand;
    self.infoList.iconCollapse = self.iconCollapse;
    self.infoList:initialise();
    self.infoList:instantiate();
    self.infoList.itemheight = 22;
    self.infoList.selected = 0;
    self.infoList.joypadParent = self;
    self.infoList.font = UIFont.Code;
    self.infoList.doDrawItem = ISStringListView.drawInfoList;
    self.infoList.target = self;
    self.infoList.onmousedown = ISStringListView.onInfoListSelected;
    self.infoList.drawBorder = true;
    self:addChild(self.infoList);

    self:populate();
end

function ISStringListView:onResize()
    self.entryBox:setWidth(self.width - self.labelWidth - (UI_BORDER_SPACING+1)*2);
    self.infoList:setWidth(self.width - (UI_BORDER_SPACING+1)*2);
    self.infoList:setHeight(self.height- self.infoList:getY() - UI_BORDER_SPACING-1);
end

function ISStringListView.onTextChange(box)
    if not box then
        return;
    end
    if box:getInternalText()~=box.target.searchText then
        box.target.searchText = box:getInternalText();
        box.target:parseSearchText();
    end
end

function ISStringListView:parseSearchText()
    local needle = self.searchText;
    if (not self.searchText) or self.searchText=="" then
        needle = false;
    end

    self.rootNode:resetHighlights();

    if needle then
        self.rootNode:search(needle, Colors.LemonChiffon); --Colors.Khaki , Colors.LemonChiffon
    end

    --[[
    local target = -1;
    if target>0 and self.infoList.items and #self.infoList.items>0 and target<=#self.infoList.items then
        self.infoList.selected = target;
        self.infoList:ensureVisible(target);
    end
    --]]
end

function ISStringListView:clear()
    self.infoList:clear();
end

function ISStringListView:buildNodes(_lines)
    --self.rootNode = ISStringListViewNode:new(nil);
    self.rootNode:reset();

    local charLength = getTextManager():MeasureStringX(UIFont.Code, "=");
    local tabLength = charLength * 3; --getTextManager():MeasureStringX(UIFont.Code, "  ");
    local lastNode = false;
    local currentNode = self.rootNode;
    local tabs = 0;
    for i=0,_lines:size()-1 do
        local line = _lines:get(i):trim();

        if line=="{" then
            if lastNode then
                if currentNode==lastNode then
                    print("ISStringListView -> parsing error. currentNode=lastNode.")
                    self.rootNode:reset();
                    return;
                end
                lastNode.container = true;
                currentNode = lastNode;
            end
            tabs = tabs + 1;
        elseif line=="}" then
            if (not currentNode) or tabs==0 then
                print("ISStringListView -> parsing error. out of bounds.")
                self.rootNode:reset();
                return
            end
            currentNode = currentNode.parent;
            tabs = tabs - 1;
        else
            local node = ISStringListViewNode:new(currentNode, line);
            node.key = line;
            node.keyCol = Colors.Black;
            node.keyX = tabs * tabLength;

            local equalsIndex = line:find("=");
            if equalsIndex and equalsIndex<line:len() then
                node.key = line:sub(1, equalsIndex-1):trim();
                node.keyW = getTextManager():MeasureStringX(UIFont.Code, node.key);

                if luautils.stringStarts(node.key, "[") then
                    node.keyCol = Colors.DarkOrange;
                end

                node.equalsX = node.keyX + node.keyW + charLength;

                node.val = line:sub(equalsIndex+1):trim();
                node.valCol = Colors.Black;
                node.valX = (charLength*2); --node.equalsX + (charLength*2);
                node.valW = getTextManager():MeasureStringX(UIFont.Code, node.val);

                -- this line is replicated in: ISStringListViewNode:preBuild()
                node.width = (node.equalsX - node.keyX) + node.valX + node.valW;

                if luautils.stringStarts(node.val, "\"") then
                    node.valCol = Colors.DarkGreen;
                elseif luautils.stringStarts(node.val, "[") then
                    node.valCol = Colors.Purple;
                elseif luautils.stringStarts(node.val, "zombie.") then
                    node.valCol = Colors.DimGray;
                elseif string.lower(node.val)=="null" or string.lower(node.val)=="nil" then
                    node.valCol = Colors.Violet;
                elseif string.lower(node.val)=="true" or string.lower(node.val)=="false" then
                    node.valCol = Colors.Magenta;
                elseif luautils.stringStarts(node.val, "<EMPTY>") or luautils.stringStarts(node.val, "<WARNING>") then
                    node.valCol = Colors.Crimson;
                elseif luautils.stringStarts(node.val, "(") then
                    if luautils.stringStarts(node.val, "(float)") or luautils.stringStarts(node.val, "(double)") then
                        node.valCol = Colors.MediumBlue;
                    elseif luautils.stringStarts(node.val, "(byte)")
                            or luautils.stringStarts(node.val, "(short)")
                            or luautils.stringStarts(node.val, "(int)")
                            or luautils.stringStarts(node.val, "(long)") then
                        node.valCol = Colors.MediumBlue; --Colors.DarkBlue;
                    end
                end
            else
                node.keyW = getTextManager():MeasureStringX(UIFont.Code, node.key);
                node.width = node.keyW;
                if luautils.stringStarts(node.key, "[") then
                    node.keyCol = Colors.Purple;
                elseif luautils.stringStarts(node.key, "<WARNING>") then
                    node.keyCol = Colors.Crimson;
                elseif luautils.stringStarts(node.key, "<SUCCESS>") then
                    node.keyCol = Colors.ForestGreen;
                end
            end

            if currentNode and currentNode.children then
                table.insert(currentNode.children, node);
            else
                print("ISStringListView -> parsing error. currentNode nil or not a node.")
                self.rootNode:reset();
                return
            end
            lastNode = node;
        end
    end
end

function ISStringListView:buildList()
    self.infoList:clear();
    if self.rootNode then
        self.rootNode:preBuild();
        self.rootNode:build(self.infoList);
    end
end

-- requires ArrayList<String> of lines with formatting similar to zomboid .txt scripts
-- i.e. key values separated by "=" and blocks defined with "{" and "}"
function ISStringListView:populate(_lines)
    self.infoList:clear();

    if _lines then
        self:buildNodes(_lines);
    end
    self:buildList();

    self:parseSearchText();
end

function ISStringListView:drawInfoList(y, item, alt)
    local a = 1.0;

    local node = item.item.node;
    local c;

    if node.highlight or node.isNeedle then
        if node.highlight then
            local c = node.highlight;
            self:drawRect(0, y, self:getWidth(), self.itemheight - 1, a, c:getRedFloat(), c:getGreenFloat(), c:getBlueFloat());
        end

        if node.isNeedle then
            c = Colors.Khaki; -- Colors.White;
            local x = node.keyX;
            local w = node.width;
            self:drawRect(x-2, y+2, w+6, self.itemheight - 5, a, c:getRedFloat(), c:getGreenFloat(), c:getBlueFloat());
            c = Colors.Black;
            self:drawRectBorder(x-2, y+2, w+6, self.itemheight - 5, a, c:getRedFloat(), c:getGreenFloat(), c:getBlueFloat());
        end
    end

    if node.isBracket then
        c = Colors.Black;
        self:drawText( item.text, node.keyX, y + 2, c:getRedFloat(), c:getGreenFloat(), c:getBlueFloat(), a, self.font);
        self:drawText( item.text, node.keyX, y + 2, c:getRedFloat(), c:getGreenFloat(), c:getBlueFloat(), a, self.font);
    else
        if node.val then
            c = node.keyCol;
            self:drawText( node.key, node.keyX, y + 2, c:getRedFloat(), c:getGreenFloat(), c:getBlueFloat(), a, self.font);
            self:drawText( node.key, node.keyX, y + 2, c:getRedFloat(), c:getGreenFloat(), c:getBlueFloat(), a, self.font);

            c = Colors.Black;
            self:drawText( "=", node.equalsX, y + 2, c:getRedFloat(), c:getGreenFloat(), c:getBlueFloat(), a, self.font);
            self:drawText( "=", node.equalsX, y + 2, c:getRedFloat(), c:getGreenFloat(), c:getBlueFloat(), a, self.font);

            c = node.valCol;
            self:drawText( node.val, node.equalsX + node.valX, y + 2, c:getRedFloat(), c:getGreenFloat(), c:getBlueFloat(), a, self.font);
            self:drawText( node.val, node.equalsX + node.valX, y + 2, c:getRedFloat(), c:getGreenFloat(), c:getBlueFloat(), a, self.font);
        else
            c = node.keyCol;
            self:drawText( node.key, node.keyX, y + 2, c:getRedFloat(), c:getGreenFloat(), c:getBlueFloat(), a, self.font);
            self:drawText( node.key, node.keyX, y + 2, c:getRedFloat(), c:getGreenFloat(), c:getBlueFloat(), a, self.font);
        end

        if node.isDrawIcon and node:isDrawIcon() then
            local offset = (self.itemheight/2) - 6;
            self:drawTexture(node.expanded and self.iconCollapse or self.iconExpand, node.keyX-16, y + offset, 0.5, 1, 1, 1);
        end
    end

    return y + self.itemheight;
end

function ISStringListView:onInfoListSelected(_item)
    if _item.node and _item.node.toggleExpand then
        _item.node:toggleExpand();
        self:buildList();
    end
end

function ISStringListView:update()
    ISPanel.update(self);
end

function ISStringListView:prerender()
    ISPanel.prerender(self);
end


function ISStringListView:render()
    ISPanel.render(self);
end

function ISStringListView:setExpandedAll()
    if self.rootNode then
        self.rootNode:setExpandedAll();
        self:buildList();
    end
end

function ISStringListView:new (x, y, width, height)
    local o = {}
    --o.data = {}
    o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.x = x;
    o.y = y;
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=1.0};
    o.greyCol = { r=0.4,g=0.4,b=0.4,a=1};
    o.width = width;
    o.height = height;
    o.anchorLeft = true;
    o.anchorRight = false;
    o.anchorTop = true;
    o.anchorBottom = false;
    o.searchText = "";
    o.iconExpand = getTexture("media/ui/Entity/icon_debug_expand.png");
    o.iconCollapse = getTexture("media/ui/Entity/icon_debug_collapse.png");
    o.rootNode = ISStringListViewNode:new(nil, "", true);
    return o
end

--[[
    ISStringListViewNode
--]]

ISStringListViewNode = {};

function ISStringListViewNode:new(_parent, _text, _isRoot)
    local o = {};
    setmetatable(o, self);
    self.__index = self;
    o.parent = _parent;
    o.text = _text;
    o.isRoot = _isRoot;
    o.key = "";
    o.keyCol = Colors.Black;
    o.keyX = 0;
    o.keyW = 1;
    o.val = nil;
    o.valCol = Colors.Black;
    o.valX = 0;
    o.valW = 1;
    o.width = 1;
    o.highlight = false;
    o.isNeedle = false;
    o.expanded = false;
    o.container = false;
    o.children = {};
    return o
end

function ISStringListViewNode:reset()
    self.highlight = false;
    self.children = {};
end

function ISStringListViewNode:resetHighlights()
    self.highlight = false;
    self.isNeedle = false;
    for k,v in ipairs(self.children) do
        v:resetHighlights();
    end
end

function ISStringListViewNode:setHighlight(_col)
    self.highlight = _col;
    if self.parent then
        self.parent:setHighlight(_col);
    end
end

function ISStringListViewNode:search(_text, _col)
    local found = string.find( string.lower(self.text), string.lower(_text) ) and true or false;
    if found then
        if self.parent then
            self.parent:setHighlight(_col);
        end
        self.isNeedle = true;
    end
    if self:isContainer() then
        for k,v in ipairs(self.children) do
            v:search(_text, _col);
        end
    end
end

function ISStringListViewNode:isDrawIcon()
    return (not self.isRoot) and self:isContainer();
end

function ISStringListViewNode:isContainer()
    return #self.children>0 or self.container;
end

function ISStringListViewNode:toggleExpand()
    self:setExpanded(not self.expanded);
end

function ISStringListViewNode:setExpanded(_b, _noChildren)
    if self:isContainer() and self.expanded~=_b then
        self.expanded = _b;

        if #self.children>0 and (not _noChildren) and (not self.expanded) then
            for k,v in ipairs(self.children) do
                v:setExpanded(_b);
            end
        end
    end
end

function ISStringListViewNode:setExpandedAll()
    if self:isContainer() or self.isRoot then
        self.expanded = true;

        if #self.children>0 then
            for k,v in ipairs(self.children) do
                v:setExpandedAll();
            end
        end
    end
end

function ISStringListViewNode:preBuild()
    if self:isContainer() or self.isRoot then
        if self.isRoot then
            self:setExpanded(true, true);
        end
        local maxX = 0;
        for k,v in ipairs(self.children) do
            if v.val then
                maxX = math.max(maxX, v.equalsX);
            end
            if self.isRoot then
                v:setExpanded(true, true);
            end
            v:preBuild();
        end

        for k,v in ipairs(self.children) do
            if v.val then
                v.equalsX = maxX;
                -- this line is replicated in: ISStringListView:buildNodes(_lines)
                v.width = (v.equalsX - v.keyX) + v.valX + v.valW;
            end
        end
    end
end

function ISStringListViewNode:build(_list)
    if not self.isRoot then
        _list:addItem(self.text, {
            node = self,
        });
    end
    if self:isContainer() and (self.expanded or self.isRoot) then
        if not self.isRoot then
            _list:addItem("{", {
                node = {
                    keyX = self.keyX,
                    isBracket = true,
                },
            });
        end

        for k,v in ipairs(self.children) do
            v:build(_list);
        end

        if not self.isRoot then
            _list:addItem("}", {
                node = {
                    keyX = self.keyX,
                    isBracket = true,
                },
            });
        end
    end
end