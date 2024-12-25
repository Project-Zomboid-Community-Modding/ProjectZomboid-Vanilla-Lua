--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISCollapsableWindow"

ISRecipeMonitor = ISCollapsableWindow:derive("ISRecipeMonitor");
ISRecipeMonitor.instance = nil;
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

function ISRecipeMonitor.OnOpenPanel()
    if ISRecipeMonitor.instance==nil then
        ISRecipeMonitor.instance = ISRecipeMonitor:new (100, 100, 1000, 600, getText("IGUI_DebugMenu_Main_RecipeMonitor"));
        ISRecipeMonitor.instance:initialise();
        ISRecipeMonitor.instance:instantiate();
    end

    ISRecipeMonitor.instance:addToUIManager();
    ISRecipeMonitor.instance:setVisible(true);

    return ISRecipeMonitor.instance;
end

function ISRecipeMonitor:initialise()
    ISCollapsableWindow.initialise(self);
end

function ISRecipeMonitor:createChildren()
    ISCollapsableWindow.createChildren(self);

    RecipeMonitor.Enable(true);

    local x,y = UI_BORDER_SPACING+1, self:titleBarHeight()+UI_BORDER_SPACING;

    local obj;
    local topY = y;

    y,obj = ISDebugUtils.addLabel(self,{}, x, y,getText("IGUI_RecipeMonitor_Usage"), UIFont.Small, true);

    local btnWidth = UI_BORDER_SPACING*2+getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_RecipeMonitor_ShowRecipe"))
    local yy, btn = ISDebugUtils.addButton(self, {}, self.width-btnWidth-UI_BORDER_SPACING-1, topY, btnWidth, BUTTON_HGT, getText("IGUI_RecipeMonitor_ShowRecipe"), ISRecipeMonitor.onBtnClick)
    self.btnRecipe = btn;
    y = y+UI_BORDER_SPACING;

    local tickOptions = {};
    table.insert(tickOptions, { text = getText("IGUI_RecipeMonitor_EnableMonitor"), ticked = RecipeMonitor.IsEnabled() });
    y,obj = ISDebugUtils.addTickBox(self, {}, x, y, BUTTON_HGT, BUTTON_HGT, "Monitor", tickOptions, ISRecipeMonitor.onTicked);
    y = y+UI_BORDER_SPACING;

    local tickOptions = {};
    table.insert(tickOptions, { text = getText("IGUI_RecipeMonitor_OptionsTooltipsAttributes"), ticked = getDebugOptions():getBoolean("Tooltip.Attributes") });
    y,obj = ISDebugUtils.addTickBox(self, {}, x, y, BUTTON_HGT, BUTTON_HGT, "Tooltip", tickOptions, ISRecipeMonitor.onTickedTooltip);
    y = y+UI_BORDER_SPACING;

    btnWidth = UI_BORDER_SPACING*2+getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_RecipeMonitor_SaveToFile"))
    y, obj = ISDebugUtils.addButton(self, {}, x, y, btnWidth, BUTTON_HGT, getText("IGUI_RecipeMonitor_SaveToFile"), ISRecipeMonitor.onSaveFile);
    y = y+UI_BORDER_SPACING;

    y,obj = ISDebugUtils.addLabel(self,{}, x, y,getText("IGUI_RecipeMonitor_SaveLocation")..tostring(RecipeMonitor.GetSaveDir()), UIFont.Small, true);
    y = y+UI_BORDER_SPACING;

    self.infoListY = y;

    self.infoList = ISScrollingListBox:new(x, y, self:getWidth()-(x*2), self.height - y - UI_BORDER_SPACING*2+1);
    self.infoList.backgroundColor = {r=0.9, g=0.9, b=0.9, a=1.0};
    self.infoList:initialise();
    self.infoList:instantiate();
    self.infoList.itemheight = ISDebugUtils.FONT_HGT_SMALL;
    self.infoList.selected = 0;
    self.infoList.joypadParent = self;
    self.infoList.font = UIFont.Code;
    self.infoList.doDrawItem = self.drawInfoList;
    self.infoList.drawBorder = true;
    self:addChild(self.infoList);

end

function ISRecipeMonitor:onSaveFile()
    RecipeMonitor.SaveToFile();
end

function ISRecipeMonitor:onResize()
    ISUIElement.onResize(self);
    local th = self:titleBarHeight();
    self.infoList:setWidth(self.width - UI_BORDER_SPACING*2-2);
    self.infoList:setHeight(self.height-self.infoListY-UI_BORDER_SPACING*2+1);
    self.btnRecipe:setX(self.width-self.btnRecipe.width-UI_BORDER_SPACING-1);
end

function ISRecipeMonitor:drawInfoList(y, item, alt)
    local a = 1.0;

    --self:drawRectBorder(0, (y), self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15);
    end

    --Drawing text twice is intentional, makes this font a little better readable.
    local c = item.item.color;
    self:drawText( item.text, 10, y + 2, c:getRedFloat(), c:getGreenFloat(), c:getBlueFloat(), a, self.font);
    self:drawText( item.text, 10, y + 2, c:getRedFloat(), c:getGreenFloat(), c:getBlueFloat(), a, self.font);

    return y + self.itemheight;
end

function ISRecipeMonitor:onBtnClick(_button)
    ISScriptViewWindow.OnOpenPanel(RecipeMonitor.getRecipe());
end

function ISRecipeMonitor:onTicked(_index, _selected, _arg1, _arg2, _tickbox)
    RecipeMonitor.Enable(_selected);
end

function ISRecipeMonitor:onTickedTooltip(_index, _selected, _arg1, _arg2, _tickbox)
    getDebugOptions():setBoolean("Tooltip.Attributes", _selected);
end

function ISRecipeMonitor:update()
    ISCollapsableWindow.update(self);

    if RecipeMonitor.IsEnabled() and (RecipeMonitor.getMonitorID() ~= self.monitorID) then
        self.monitorID = RecipeMonitor.getMonitorID();
        local lines = RecipeMonitor.GetLines();
        self.infoList:clear();

        for i=0,lines:size()-1 do
            local c = RecipeMonitor.GetColorForLine(i);
            self.infoList:addItem(lines:get(i), { color = c, });
        end
    end
end

function ISRecipeMonitor:prerender()
    ISCollapsableWindow.prerender(self);
end


function ISRecipeMonitor:render()
    ISCollapsableWindow.render(self);

end

function ISRecipeMonitor:close()
    ISCollapsableWindow.close(self)
    if JoypadState.players[self.playerNum+1] then
        setJoypadFocus(self.playerNum, nil)
    end
    ISRecipeMonitor.instance = nil;
    self:removeFromUIManager();
    RecipeMonitor.Enable(false);
end

function ISRecipeMonitor:new (x, y, width, height, title)
    local o = {}
    --o.data = {}
    o = ISCollapsableWindow:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.x = x;
    o.y = y;
    o.player = getPlayer();
    o.playerNum = getPlayer():getPlayerNum();
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=1.0};
    o.greyCol = { r=0.4,g=0.4,b=0.4,a=1};
    o.width = width;
    o.height = height;
    o.anchorLeft = true;
    o.anchorRight = false;
    o.anchorTop = true;
    o.anchorBottom = false;
    o.pin = true;
    o.isCollapsed = false;
    o.collapseCounter = 0;
    o.title = title;
    --o.viewList = {}
    o.resizable = true;
    o.drawFrame = true;

    o.currentTile = nil;
    o.richtext = nil;
    o.overrideBPrompt = true;
    o.subFocus = nil;
    o.hotKeyPanels = {};
    o.isJoypadWindow = false;

    o.monitorID = -1;

    ISDebugMenu.RegisterClass(self);
    return o
end