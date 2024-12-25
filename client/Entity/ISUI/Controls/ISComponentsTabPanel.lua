--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************
require "ISUI/ISPanel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small);

ISComponentsTabPanel = ISPanel:derive("ISComponentsTabPanel");

function ISComponentsTabPanel:initialise()
	ISPanel.initialise(self);
end

function ISComponentsTabPanel:createChildren()
    ISPanel.createChildren(self);

    self.panels = ISEntityUI.GetComponentPanels(self.player, self.entity);
    --if theres only one component panel omit the button menu.
    self.multiPanels = #self.panels>1;

    if getDebug() and getDebugOptions():getBoolean("Entity.DebugUI") then
        self.multiPanels = true;
    end

    local styleCell = nil; --self.styleCell or "S_TableLayoutCell_ItemSlot";
    self.tableLayout = ISXuiSkin.build(self.xuiSkin, nil, ISTableLayout, 0, 0, 10, 10, nil, nil, styleCell);
    --self.tableLayout.drawDebugLines = true;
    self.tableLayout:addRowFill(nil);
    self.tableLayout:initialise();
    self.tableLayout:instantiate();
    self:addChild(self.tableLayout);

    local column;

    if self.multiPanels then
        local styleCell = self.styleCell or "S_TableLayoutCell_Component_Tab";
        self.menuLayout = ISXuiSkin.build(self.xuiSkin, nil, ISTableLayout, 0, 0, 10, 10, nil, nil, styleCell);
        --self.menuLayout.drawDebugLines = true;
        self.menuLayout:addColumnFill(nil);
        self.menuLayout:initialise();
        self.menuLayout:instantiate();
        --self:addChild(self.menuLayout);

        column = self.tableLayout:addColumn(nil);
        self.tableLayout:setElement(column:index(), 0, self.menuLayout);
    end

    self.panelColumn = self.tableLayout:addColumnFill(nil);
    --self.tableLayout:setElement(column:index(), 0, self.container);

    --self.panels = ISEntityUI.GetComponentPanels(self.player, self.entity);

    local added = false;
    local row;

    if self.multiPanels then
        row = self.menuLayout:addRow(nil);
        row.minimumHeight = 6;
        local cell = self.menuLayout:cell(0, row:index());
        cell.padding = 0;
        --cell.height = 10;
        for index,v in ipairs(self.panels) do
            --if not added then
            --self.container:addChild(v.panel);
            --self.tableLayout:setElement(self.panelColumn:index(), 0, v.panel);
            --end
            v.panel.minimumWidth = math.max(v.panel.minimumWidth or 0, self.minimumPanelWidth);

            if self.disableHeaders then
                v.panel:removeComponentHeader();
            end

            local name = (v.uiStyle and v.uiStyle:getDisplayName()) or "button";
            if not self.doText then
                name = nil;
            end
            local style = self.styleButton or "S_Button_Component_Tab";
            local tabButton = ISXuiSkin.build(self.xuiSkin, style, ISButton, 0, 0, 20, FONT_HGT_SMALL+8, name);
            --self.buttonRepair.image = (not self.showInfo) and self.iconInfo or self.iconPanel;
            tabButton.data = v;
            if self.doIcons and self.doText then
                tabButton.iconTexture = v.uiStyle and v.uiStyle:getIcon();
            elseif self.doIcons then
                --local size = 20;
                --tabButton.width = size;
                --tabButton.height = size;
                tabButton.width = 40;
                tabButton.image = v.uiStyle and v.uiStyle:getIcon();
                --tabButton:forceImageSize(size, size);
            end
            tabButton.target = self;
            tabButton.onclick = ISComponentsTabPanel.onButtonClick;
            tabButton.enable = true;
            tabButton:initialise();
            tabButton:instantiate();
            --self:addChild(tabButton);

            row = self.menuLayout:addRow(nil);
            self.menuLayout:setElement(0, row:index(), tabButton);

            tabButton:setWidthToTitle(tabButton.width);

            v.button = tabButton;
            v.index = index;

            if not added then
                self.originalColor = tabButton.textColor;
                self:selectPanel(index, false);
                --self.originalColor = tabButton.backgroundColor;
                --tabButton.backgroundColor = self.selectedColor;
            end

            added = true;
        end

        if getDebug() and getDebugOptions():getBoolean("Entity.DebugUI") then
            self.entityDebug = ISXuiSkin.build(self.xuiSkin, "S_WidgetEntityDebug_Std", ISWidgetEntityDebug,0, 0, 10, 10, self.player, self.entity, nil);
            self.entityDebug:initialise();
            self.entityDebug:instantiate();

            row = self.menuLayout:addRow(nil);
            self.menuLayout:setElement(0, row:index(), self.entityDebug);
        end

        row = self.menuLayout:addRowFill(nil);
    else
        local v = self.panels[1];
        v.panel.minimumWidth = math.max(v.panel.minimumWidth or 0, self.minimumPanelWidth);

        self.tableLayout:setElement(self.panelColumn:index(), 0, v.panel);
    end
end

function ISComponentsTabPanel:selectPanel(_index, _recalc)
    if self.panels and self.panels[_index] then
        if self.selectedIndex and self.selectedIndex>=1 then
            local v = self.panels[self.selectedIndex];
            v.button.textColor = self.originalColor;
        end
        self.selectedIndex = _index;
        local v = self.panels[self.selectedIndex];
        v.button.textColor = self.selectedColor;

        self.tableLayout:setElement(self.panelColumn:index(), 0, v.panel);

        if _recalc then
            if self.layoutParent then
                self.layoutParent:calculateLayout(0,0); --(self.layoutParent:getWidth(), self.layoutParent:getHeight());
            else
                self:calculateLayout(0, 0);
            end
        end
    end
end

function ISComponentsTabPanel:onButtonClick(_button)
    if _button.data then
        self:selectPanel(_button.data.index, true);
    end
end

function ISComponentsTabPanel:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    self.tableLayout:calculateLayout(width, height);

    width = math.max(width, self.tableLayout:getWidth());
    height = math.max(height, self.tableLayout:getHeight());

    self:setWidth(width);
    self:setHeight(height);
end

function ISComponentsTabPanel:onResize()
    --ISUIElement.onResize(self)
    ISUIElement.onResize(self)
end

function ISComponentsTabPanel:prerender()
    ISPanel.prerender(self);
end

function ISComponentsTabPanel:render()
    ISPanel.render(self);

    if ISEntityUI.drawDebugLines or self.drawDebugLines then
        self:drawRectBorderStatic(0, 0, self.width, self.height, 1.0, 1, 0, 0);
    end
end

function ISComponentsTabPanel:update()
    ISPanel.update(self);
end

--************************************************************************--
--** ISComponentsTabPanel:new
--**
--************************************************************************--
function ISComponentsTabPanel:new(x, y, width, height, player, entity, entityConfig)
	local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.player = player;
    o.entity = entity;
    o.entityConfig = entityConfig;

    o.background = true;

    o.minimumWidth = 0;
    o.minimumHeight = 0;
    o.maximumWidth = 0;
    o.maximumHeight = 0;

    o.minimumPanelWidth = 0;

    o.padding = 0;
    o.margin = 5;

    o.layoutParent = false;

    o.disableHeaders = false; --disables component headers (only if more than one component)
    --options for buttons:
    o.doIcons = true;
    o.doText = true;
    o.selectedColor = {r=1.00,g=0.95,b=0.45,a=1}; --1.00 : 0.95 : 0.45
    o.originalColor = {r=0.0,g=0.0,b=0.0,a=1}; --gets overridden

    return o
end