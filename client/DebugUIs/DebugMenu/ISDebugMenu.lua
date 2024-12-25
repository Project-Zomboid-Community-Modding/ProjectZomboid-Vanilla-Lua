require "ISUI/ISPanel"
require "PZAPI/ui/organisms/PrintMedia"
require "PZAPI/ui/organisms/Window"
local UI = PZAPI.UI

ISDebugMenu = ISPanel:derive("ISDebugMenu");
ISDebugMenu.instance = nil;
ISDebugMenu.forceEnable = false;
ISDebugMenu.shiftDown = 0;
ISDebugMenu.tab = "MAIN"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

function ISDebugMenu:setupButtons()
    -- MAIN
    local general = self:addButtonInfo(getText("IGUI_DebugMenu_Main_General"), function() ISGeneralDebug.OnOpenPanel() end, "MAIN");
    if not isClient() then
        self:addButtonInfo(getText("IGUI_DebugMenu_Main_Cheats"), function() ISCheatPanelUI.OnOpenPanel() end, "MAIN");
    end
    self:addButtonInfo(getText("IGUI_DebugMenu_Main_Climate"), function() ClimateControlDebug.OnOpenPanel() end, "MAIN");
    self:addButtonInfo(getText("IGUI_DebugMenu_Main_CraftRecipes"), function() ISCraftRecipeDbgWindow.OnOpenPanel() end, "MAIN");
    self:addButtonInfo(getText("IGUI_DebugMenu_Main_Player"), function() ISPlayerStatsUI.OnOpenPanel() end, "MAIN");
    self:addButtonInfo(getText("IGUI_DebugMenu_Main_Items"), function() ISItemsListViewer.OnOpenPanel() end, "MAIN");
    self:addButtonInfo(getText("IGUI_DebugMenu_Main_Fluids"), function() ISFluidDebugWindow.OnOpenPanel() end, "MAIN");
    self:addButtonInfo(getText("IGUI_DebugMenu_Main_Entities"), function() ISEntitiesDebugWindow.OnOpenPanel() end, "MAIN");
    self:addButtonInfo(getText("IGUI_DebugMenu_Main_Scripts"), function() ISScriptsDebugWindow.OnOpenPanel() end, "MAIN");
    self:addButtonInfo(getText("IGUI_DebugMenu_Main_XUI"), function() XuiDebugWindow.OnOpenPanel() end, "MAIN");
    self:addButtonInfo(getText("IGUI_DebugMenu_Main_RecipeMonitor"), function() ISRecipeMonitor.OnOpenPanel() end, "MAIN");
    self:addButtonInfo(getText("IGUI_DebugMenu_Main_Sandbox"), function() ISDebugMenu:onClickSandboxSettings() end, "MAIN");

    -- DEV
    self:addButtonInfo(getText("IGUI_DebugMenu_Dev_Audio"), function() ISAudioDebugPanel.OnOpenPanel() end, "DEV");
    self:addButtonInfo(getText("IGUI_DebugMenu_Dev_IsoRegions"), function() IsoRegionsWindow.OnOpenPanel() end, "DEV");
    self:addButtonInfo(getText("IGUI_DebugMenu_Dev_Population"), function() ZombiePopulationWindow.OnOpenPanel() end, "DEV");
    self:addButtonInfo(getText("IGUI_DebugMenu_Dev_Stash"), function() StashDebug.OnOpenPanel() end, "DEV");
    self:addButtonInfo(getText("IGUI_DebugMenu_Dev_AnimMonitor"), function() ISAnimDebugMonitor.OnOpenPanel() end, "DEV");
    self:addButtonInfo(getText("IGUI_DebugMenu_Dev_Radio"), function() ZomboidRadioDebug.OnOpenPanel() end, "DEV");
    self:addButtonInfo(getText("IGUI_DebugMenu_Dev_AnimViewer"), showAnimationViewer, "DEV");
    self:addButtonInfo(getText("IGUI_DebugMenu_Dev_Attachment"), showAttachmentEditor, "DEV");
    self:addButtonInfo(getText("IGUI_DebugMenu_Dev_ChunkDebug"), showChunkDebugger, "DEV");
    self:addButtonInfo(getText("IGUI_DebugMenu_Dev_GlobalObject"), showGlobalObjectDebugger, "DEV");
    self:addButtonInfo(getText("IGUI_DebugMenu_Dev_MapEdit"), function() showWorldMapEditor(nil) end, "DEV");
    self:addButtonInfo(getText("IGUI_DebugMenu_Dev_VehicleEdit"), function() showVehicleEditor(nil) end, "DEV");
    self:addButtonInfo(getText("IGUI_DebugMenu_Dev_WorldFlares"), function() WorldFlaresDebug.OnOpenPanel() end, "DEV");
	self:addButtonInfo(getText("IGUI_DebugMenu_Dev_Stats"), function() ISGameStatisticPanel.OnOpenPanel() end, "DEV");
    self:addButtonInfo(getText("IGUI_DebugMenu_Dev_GlobalModData"), function() GlobalModDataDebug.OnOpenPanel() end, "DEV");
    self:addButtonInfo(getText("IGUI_DebugMenu_Dev_NewUI"), function() doNewUIDebug() end, "DEV");
    self:addButtonInfo(getText("IGUI_DebugMenu_Dev_UnitTests"), function() UnitTestsDebug:OnOpenPanel() end, "DEV");
    self:addButtonInfo(getText("IGUI_DebugMenu_Dev_CharacterDebug"), function() ISCharacterDebugUI.OnOpenPanel() end, "DEV");
    --self:addButtonInfo(getText("IGUI_DebugMenu_Dev_RagdollSettings"), function() DebugRagdollPanel.OnOpenPanel() end, "DEV");  // @Patrick - DO NOT REMOVE - Commented out to hide Ragdoll information

    --sort buttons alphabetically
    table.sort(self.buttons, function(a, b) return string.sort(b.title, a.title) end);
    self:bringToTop(general);-- reason: muscle memory :D
    --add close buttons after sorting so they're always at the bottom
    self:addButtonInfo(getText("IGUI_DebugMenu_Close"), nil, "MAIN");
    self:addButtonInfo(getText("IGUI_DebugMenu_Close"), nil, "DEV");
end

function ISDebugMenu:addButtonInfo(_title, _func, _tab, _marginTop)
    self.buttons = self.buttons or {};

    local info = { title = _title, func = _func, tab = _tab, marginTop = (_marginTop or 0) }
    table.insert(self.buttons, info)
    return info;
end

function ISDebugMenu:bringToTop(_buttonInfo)
    self.buttons = self.buttons or {};

    local index = false;
    for k,v in pairs(self.buttons) do
        if v==_buttonInfo then
            index = k;
            break;
        end
    end

    if index then
        table.remove(self.buttons, index);
        table.insert(self.buttons, 1, _buttonInfo);
    end
end

function ISDebugMenu.OnOpenPanel()
    if getCore():getDebug() or ISDebugMenu.forceEnable then
        if ISDebugMenu.instance==nil then
            ISDebugMenu.instance = ISDebugMenu:new (100, 100, 200, 20, getPlayer());
            ISDebugMenu.instance:initialise();
            ISDebugMenu.instance:instantiate();
        end

        ISDebugMenu.instance:addToUIManager();
        ISDebugMenu.instance:setVisible(true);

        return ISDebugMenu.instance;
    end
end

function ISDebugMenu:initialise()
    ISPanel.initialise(self);
end

function ISDebugMenu:createChildren()
    ISPanel.createChildren(self);

    self.buttons = {};
    self:setupButtons();

    local maxWidth = 0
    for k,v in ipairs(self.buttons)  do
        local width = getTextManager():MeasureStringX(UIFont.Small, v.title) + UI_BORDER_SPACING*2
        maxWidth = math.max(maxWidth, width)
    end
    self:setWidth(math.max(self.width, maxWidth + (UI_BORDER_SPACING+1)*2))
    self:ignoreWidthChange()

    local x,y = UI_BORDER_SPACING+1,UI_BORDER_SPACING+1;
    local w,h = self.width-(UI_BORDER_SPACING+1)*2, BUTTON_HGT;
    local margin = UI_BORDER_SPACING;

    local y, obj = ISDebugUtils.addLabel(self,"Header",x+(w/2),y,getText("IGUI_DebugMenu_Title"),UIFont.Medium);
    obj.center = true;

    y = y+UI_BORDER_SPACING;

    self.mainButton = ISButton:new(x,y,(w-UI_BORDER_SPACING)/2,h,getText("IGUI_DebugMenu_Main"), self, ISDebugMenu.onClick_Main);
    self.mainButton:initialise();
    self:addChild(self.mainButton);

    self.devButton = ISButton:new(self.width - (w-UI_BORDER_SPACING)/2 - UI_BORDER_SPACING,y,(w-UI_BORDER_SPACING)/2,h,getText("IGUI_DebugMenu_Dev"), self, ISDebugMenu.onClick_Dev);
    self.devButton:initialise();
    self:addChild(self.devButton);

    y = y + h
    self.mainTab = { _y=y, _buttons = {} }
    self.devTab = { _y=y, _buttons = {} }

    for k,v in ipairs(self.buttons) do
        if v.tab == "MAIN" then
            if v.marginTop and v.marginTop > 0 then
                self.mainTab._y = self.mainTab._y + v.marginTop
            end
            self.mainTab._y, obj = ISDebugUtils.addButton(self,v,x,self.mainTab._y+margin,w,h,v.title,ISDebugMenu.onClick);
            table.insert(self.mainTab._buttons, obj)
            if v.title == getText("IGUI_DebugMenu_Close") then
                obj:enableCancelColor()
            end
        else
            if v.marginTop and v.marginTop > 0 then
                self.devTab._y = self.devTab._y + v.marginTop
            end
            self.devTab._y, obj = ISDebugUtils.addButton(self,v,x,self.devTab._y+margin,w,h,v.title,ISDebugMenu.onClick);
            table.insert(self.devTab._buttons, obj)
            if v.title == getText("IGUI_DebugMenu_Close") then
                obj:enableCancelColor()
            end
        end
    end

    if ISDebugMenu.tab == "MAIN" then
        self:onClick_Main()
    else
        self:onClick_Dev()
    end
end

function ISDebugMenu:onClick_Dev()
    ISDebugMenu.tab = "DEV"

    self.devButton.backgroundColor = {r=0.6, g=0.6, b=0.6, a=1.0};
    self.devButton.backgroundColorMouseOver = {r=0.6, g=0.6, b=0.6, a=1.0};
    self.devButton.borderColor = self.mainButton.backgroundColor

    self.mainButton.backgroundColor = {r=0.4, g=0.4, b=0.4, a=1.0};
    self.mainButton.backgroundColorMouseOver = {r=0.6, g=0.6, b=0.6, a=1.0};
    self.mainButton.borderColor = self.devButton.backgroundColor

    for _, b in ipairs(self.mainTab._buttons) do
        b:setVisible(false)
    end
    for _, b in ipairs(self.devTab._buttons) do
        b:setVisible(true)
    end
    self:setHeight(self.devTab._y+UI_BORDER_SPACING+1);
end

function ISDebugMenu:onClick_Main()
    ISDebugMenu.tab = "MAIN"

    self.mainButton.backgroundColor = {r=0.6, g=0.6, b=0.6, a=1.0};
    self.mainButton.backgroundColorMouseOver = {r=0.6, g=0.6, b=0.6, a=1.0};
    self.mainButton.borderColor = self.mainButton.backgroundColor

    self.devButton.backgroundColor = {r=0.4, g=0.4, b=0.4, a=1.0};
    self.devButton.backgroundColorMouseOver = {r=0.6, g=0.6, b=0.6, a=1.0};
    self.devButton.borderColor = self.devButton.backgroundColor

    for _, b in ipairs(self.devTab._buttons) do
        b:setVisible(false)
    end
    for _, b in ipairs(self.mainTab._buttons) do
        b:setVisible(true)
    end
    self:setHeight(self.mainTab._y+UI_BORDER_SPACING+1);
end

function ISDebugMenu:onClick(_button)
    if _button.customData.func then
        _button.customData.func();
    else
        self:close();
    end
end

function ISDebugMenu:onClickSandboxSettings()
    if ISServerSandboxOptionsUI.instance then
        ISServerSandboxOptionsUI.instance:close()
    end
    local ui = ISServerSandboxOptionsUI:new(150, 150,800, 600)
    ui:initialise()
    ui:addToUIManager()
end

function ISDebugMenu:close()
    self:setVisible(false);
    self:removeFromUIManager();
    ISDebugMenu.instance = nil
end

function ISDebugMenu:new(x, y, width, height)
    local o = {};
    o = ISPanel:new(x, y, width, height);
    setmetatable(o, self);
    self.__index = self;
    o.variableColor={r=0.9, g=0.55, b=0.1, a=1};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.buttonBorderColor = {r=0.7, g=0.7, b=0.7, a=0.5};
    o.zOffsetSmallFont = 25;
    o.moveWithMouse = true;
    --ISDebugMenu.instance = o
    ISDebugMenu.RegisterClass(self);
    return o;
end

ISDebugMenu.classes = {}

function ISDebugMenu.RegisterClass(_class)
    table.insert(ISDebugMenu.classes, _class);
end

function ISDebugMenu.OnPlayerDeath(playerObj)
    for _,class in ipairs(ISDebugMenu.classes) do
        if class.instance then
            class.instance:setVisible(false);
            class.instance:removeFromUIManager();
            class.instance = nil;
        end
    end
end

Events.OnPlayerDeath.Add(ISDebugMenu.OnPlayerDeath)

---

local printMediaWindow = nil

local function addButtons(self, data)
    local yy = 0
    for i, val in ipairs(data) do
        self.children["element_" .. i] = UI.TextButton{
            x = 0, y = yy,
            height = 40,
            anchorLeft = 0, anchorRight = 0,
            children = {
                label = UI.TextButton.children.label{
                    text = val
                }
            },
            onLeftClick = function()
                Translator.loadFiles()
                if printMediaWindow then
                    UIManager.RemoveElement(printMediaWindow.javaObj)
                    printMediaWindow = nil
                end

                local win = UI.PrintMedia{
                    x = 675, y = 10,
                }
                win.media_id = val
                win.data = getText("Print_Media_" .. val .. "_info")
                win.children.bar.children.name.text = getText("Print_Media_" .. val .. "_title")
                win.textTitle = getText("Print_Text_" .. val .. "_title")
                win.textData = string.gsub(getText("Print_Text_" .. val .. "_info"), "\\n", "\n")

                win:instantiate()

                printMediaWindow = win
            end
        }
        UI._addChild(self, self.children["element_" .. i])

        yy = yy + 40
    end
    self:setHeight(yy)
    self:onResize()
end

function doNewUIDebug()
    if isServer() then return end

    local window = UI.Window{
        x = 320, y = 100,
        width = 350, height = 600,
        isPin = false,
        children = {
            body = UI.Window.children.body{
                children = {
                    tabPanel = UI.TabPanel{
                        tabs = {"fliers", "brochures", "newspapers"},
                        children = {
                            fliers = UI.Node{
                                name = "Fliers",
                                isStencil = true,
                                children = {
                                    container = UI.Node{
                                        anchorLeft = -1, anchorRight = -10,
                                        children = {},
                                        init = function(self)
                                            local data = {}
                                            for i, book in ipairs(PrintMediaDefinitions.Fliers) do
                                                table.insert(data, book)
                                            end
                                            addButtons(self, data)
                                            self.parent.children.scrollBar.container = self
                                        end,
                                        onScroll = function(self, percent)
                                            self.parent.children.scrollBar:updateBar(percent)
                                        end,
                                        onResize = function(self)
                                            self.parent.children.scrollBar:setBarSize(self.parent.height / (self.height))
                                            self.parent.children.scrollBar:updateBar(0)
                                        end
                                    },
                                    scrollBar = UI.ScrollBarVertical{}
                                }
                            },
                            brochures = UI.Node{
                                name = "Brochures",
                                isStencil = true,
                                children = {
                                    container = UI.Node{
                                        anchorLeft = -1, anchorRight = -10,
                                        children = {},
                                        init = function(self)
                                            local data = {}
                                            for i, book in ipairs(PrintMediaDefinitions.Brochures) do
                                                table.insert(data, book)
                                            end
                                            addButtons(self, data)
                                            self.parent.children.scrollBar.container = self
                                        end,
                                        onScroll = function(self, percent)
                                            self.parent.children.scrollBar:updateBar(percent)
                                        end,
                                        onResize = function(self)
                                            self.parent.children.scrollBar:setBarSize(self.parent.height / (self.height))
                                            self.parent.children.scrollBar:updateBar(0)
                                        end
                                    },
                                    scrollBar = UI.ScrollBarVertical{}
                                }
                            },
                            newspapers = UI.Node{
                                name = "Newspapers",
                                isStencil = true,
                                children = {
                                    container = UI.Node{
                                        anchorLeft = -1, anchorRight = -10,
                                        children = {},
                                        init = function(self)
                                            local data = {}
                                            for i, book in ipairs(PrintMediaDefinitions.Newspapers) do
                                                local details = PrintMediaDefinitions.NewspaperDetails[book]
                                                local issues = details.issues
                                                for j, issue in ipairs(issues) do
                                                    table.insert(data, book .. "_" .. issue)
                                                end
                                            end
                                            addButtons(self, data)
                                            self.parent.children.scrollBar.container = self
                                        end,
                                        onScroll = function(self, percent)
                                            self.parent.children.scrollBar:updateBar(percent)
                                        end,
                                        onResize = function(self)
                                            self.parent.children.scrollBar:setBarSize(self.parent.height / (self.height))
                                            self.parent.children.scrollBar:updateBar(0)
                                        end
                                    },
                                    scrollBar = UI.ScrollBarVertical{}
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    window:instantiate()
end
