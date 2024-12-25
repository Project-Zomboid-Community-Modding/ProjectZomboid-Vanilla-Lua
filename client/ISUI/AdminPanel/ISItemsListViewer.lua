--***********************************************************
--**              	  ROBERT JOHNSON                       **
--***********************************************************

ISItemsListViewer = ISPanel:derive("ISItemsListViewer");
ISItemsListViewer.messages = {};

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

--************************************************************************--
--** ISItemsListViewer:initialise
--**
--************************************************************************--

function ISItemsListViewer:initialise()
    ISPanel.initialise(self);
    local btnWid = getTextManager():MeasureStringX(UIFont.Small, "Player 1")+50

    self.playerSelect = ISComboBox:new(self.width - UI_BORDER_SPACING - btnWid - 1, UI_BORDER_SPACING + 1, btnWid, BUTTON_HGT, self, self.onSelectPlayer)
    self.playerSelect:initialise()
    self.playerSelect:addOption("Player 1")
    self.playerSelect:addOption("Player 2")
    self.playerSelect:addOption("Player 3")
    self.playerSelect:addOption("Player 4")
    self:addChild(self.playerSelect)

    self.ok = ISButton:new(UI_BORDER_SPACING+1, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT - 1, btnWid, BUTTON_HGT, getText("IGUI_CraftUI_Close"), self, ISItemsListViewer.onClick);
    self.ok.internal = "CLOSE";
    self.ok.anchorTop = false
    self.ok.anchorBottom = true
    self.ok:initialise();
    self.ok:instantiate();
    self.ok:enableCancelColor()
    self:addChild(self.ok);

    local top = UI_BORDER_SPACING*2 + FONT_HGT_MEDIUM+1
    self.panel = ISTabPanel:new(UI_BORDER_SPACING+1, top, self.width - (UI_BORDER_SPACING+1)*2, self.ok.y - UI_BORDER_SPACING - top);
    self.panel:initialise();
    self.panel.borderColor = { r = 0, g = 0, b = 0, a = 0};
    self.panel.target = self;
    self.panel.equalTabWidth = false
    self:addChild(self.panel);
    
    self:initList();
end

function ISItemsListViewer:initList()
    self.items = getAllItems();

    -- we gonna separate items by module
    self.module = {};
    local moduleNames = {}
    local allItems = {}
    for i=0,self.items:size()-1 do
        local item = self.items:get(i);
        --The following code is used to generate a list of all items in the game
        --in a format that allows for easier conversion into an excel / google sheets
        --compatible layout. IN THE OUTPUT, replace <<<>>> with a tab.

        --if (item:getDisplayCategory() ~= nil) then
        --    print("<<<>>>" .. item:getName() .. "<<<>>>" .. item:getDisplayCategory())
        --else
        --    print("<<<>>>" .. item:getName() .. "<<<>>>")
        --end

        --The above code activates as soon as the item list viewer is activated.
        if not item:getObsolete() and not item:isHidden() then
            if not self.module[item:getModuleName()] then
                self.module[item:getModuleName()] = {}
                table.insert(moduleNames, item:getModuleName())
            end
            table.insert(self.module[item:getModuleName()], item);
            table.insert(allItems, item)
        end
    end

    table.sort(moduleNames, function(a,b) return not string.sort(a, b) end)

    local listBox = ISItemsListTable:new(0, 0, self.panel.width, self.panel.height - self.panel.tabHeight, self);
    listBox:initialise();
    self.panel:addView("All", listBox);
--    listBox.parent = self;
    listBox:initList(allItems)

    for _,moduleName in ipairs(moduleNames) do
        -- we ignore the "Moveables" module
        if moduleName ~= "Moveables" then
            local cat1 = ISItemsListTable:new(0, 0, self.panel.width, self.panel.height - self.panel.tabHeight, self);
            cat1:initialise();
            self.panel:addView(moduleName, cat1);
--            cat1.parent = self;
            cat1:initList(self.module[moduleName])
        end
    end
    self.panel:activateView("All");
end

function ISItemsListViewer:prerender()
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawText(getText("IGUI_AdminPanel_ItemList"), self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_AdminPanel_ItemList")) / 2), UI_BORDER_SPACING+1, 1,1,1,1, UIFont.Medium);
end

function ISItemsListViewer:onClick(button)
    if button.internal == "CLOSE" then
        self:close();
    end
end

function ISItemsListViewer:onSelectPlayer()
end

function ISItemsListViewer:setKeyboardFocus()
    local view = self.panel:getActiveView()
    if not view then return end
    Core.UnfocusActiveTextEntryBox()
    view.filterWidgetMap.Type:focus()
end

function ISItemsListViewer:close()
    self:setVisible(false);
    self:removeFromUIManager();
end

function ISItemsListViewer.OnOpenPanel()
    if ISItemsListViewer.instance then
        ISItemsListViewer.instance:setVisible(true)
        ISItemsListViewer.instance:addToUIManager()
        ISItemsListViewer.instance:setKeyboardFocus()
        return
    end
    local modal = ISItemsListViewer:new(50, 200, 1150+(getCore():getOptionFontSizeReal()*50), 650+(getCore():getOptionFontSizeReal()*50))
    modal:initialise();
    modal:addToUIManager();
    modal.instance:setKeyboardFocus()
end

--************************************************************************--
--** ISItemsListViewer:new
--**
--************************************************************************--
function ISItemsListViewer:new(x, y, width, height)
    local o = {}
    x = getCore():getScreenWidth() / 2 - (width / 2);
    y = getCore():getScreenHeight() / 2 - (height / 2);
    o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.width = width;
    o.height = height;
    o.moveWithMouse = true;
    ISItemsListViewer.instance = o;
    ISDebugMenu.RegisterClass(self);
    return o;
end
