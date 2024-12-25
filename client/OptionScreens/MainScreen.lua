--***********************************************************
--**                LEMMY/ROBERT JOHNSON                   **
--***********************************************************

require "ISUI/ISPanel"
require "ISUI/ISButton"
require "ISUI/ISInventoryPane"
require "ISUI/ISResizeWidget"
require "ISUI/ISMouseDrag"

require "defines"

MainScreen = ISPanelJoypad:derive("MainScreen");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local BUTTON_HGT = FONT_HGT_SMALL + 6
local UI_BORDER_SPACING = 10
local JOYPAD_TEX_SIZE = 32

function MainScreen:initialise()
	ISPanel.initialise(self);
end

function MainScreen:getLatestSave()
    local latestSave = getLatestSave();
    MainScreen.latestSaveWorld = latestSave[1];
    MainScreen.latestSaveGameMode = latestSave[2];
end

--************************************************************************--
--** ISPanel:instantiate
--**
--************************************************************************--
function MainScreen:setBottomPanelVisible(visible)
    self.javaObject:setVisible(visible);
    if self.parent and self.parent.versionDetail then
        self.parent.versionDetail:setVisible(visible);
        if self.parent.resetLua ~= nil then
            self.parent.resetLua:setVisible(visible)
        end
    end
    if self.parent and self.parent.modListDetail then
        self.parent.modListDetail:setVisible(visible)
    end
    if self.parent and self.parent.termsOfService then
        self.parent.termsOfService:setVisible(visible)
    end
end

function MainScreen:instantiate()

	MainScreen.instance = self;
    self:getLatestSave();
	--self:initialise();
	self.javaObject = UIElement.new(self);
	self.javaObject:setX(self.x);
	self.javaObject:setY(self.y);
	self.javaObject:setHeight(self.height);
	self.javaObject:setWidth(self.width);
	self.javaObject:setAnchorLeft(self.anchorLeft);
	self.javaObject:setAnchorRight(self.anchorRight);
	self.javaObject:setAnchorTop(self.anchorTop);
	self.javaObject:setAnchorBottom(self.anchorBottom);

    -- These should be the same as in prerender()
    local logoScale = getCore():getScreenWidth() / 1920
    local tex = self.logoTexture
    local logoX = 50 * logoScale
    local logoY = 50 * logoScale
    local logoWidth = tex:getWidth() * logoScale
    local logoHgt = tex:getHeight() * logoScale

    self.bottomPanel = ISPanel:new(100, logoY + logoHgt + 30, 400, 400);
    self.bottomPanel:initialise();
    self.bottomPanel:setAnchorRight(false);
    self.bottomPanel:setAnchorLeft(true);
    self.bottomPanel:setAnchorBottom(false);
    self.bottomPanel:setAnchorTop(false);
    self:addChild(self.bottomPanel);
    self.bottomPanel.backgroundColor = {r=0, g=0, b=0, a=0.0};
    self.bottomPanel:noBackground()
    MainScreen.instance.bottomPanel.setVisible = MainScreen.setBottomPanelVisible;


    if not self.inGame and not isDemo() then


        self.serverList = ServerList:new(0, 0, self.width, self.height);

        self.serverList:initialise();
        self.serverList:setVisible(false);
        self.serverList:setAnchorRight(true);
        self.serverList:setAnchorLeft(true);
        self.serverList:setAnchorBottom(true);
        self.serverList:setAnchorTop(true);
        self.serverList.backgroundColor = {r=0, g=0, b=0, a=0.8};
        self.serverList.borderColor = {r=1, g=1, b=1, a=0.5};

        self.bootstrapConnectPopup = BootstrapConnectPopup:new(0, 0, self.width, self.height);
        self.bootstrapConnectPopup:initialise();
        self.bootstrapConnectPopup:setVisible(false);
        self.bootstrapConnectPopup:setAnchorRight(true);
        self.bootstrapConnectPopup:setAnchorLeft(true);
        self.bootstrapConnectPopup:setAnchorBottom(true);
        self.bootstrapConnectPopup:setAnchorTop(true);
        self.bootstrapConnectPopup.backgroundColor = {r=0, g=0, b=0, a=0.8};
        self.bootstrapConnectPopup.borderColor = {r=1, g=1, b=1, a=0.5};

        self.connectToServer = ConnectToServer:new(0, 0, self.width, self.height);
        self.connectToServer:initialise();
        self.connectToServer:setVisible(false);
        self.connectToServer:setAnchorRight(true);
        self.connectToServer:setAnchorLeft(true);
        self.connectToServer:setAnchorBottom(true);
        self.connectToServer:setAnchorTop(true);
        self.connectToServer.backgroundColor = {r=0, g=0, b=0, a=0.8};
        self.connectToServer.borderColor = {r=1, g=1, b=1, a=0.5};

        self.serverConnectPopup = ServerConnectPopup:new(0, 0, self.width, self.height);
        self.serverConnectPopup:initialise();
        self.serverConnectPopup:setVisible(false);
        self.serverConnectPopup:setAnchorRight(true);
        self.serverConnectPopup:setAnchorLeft(true);
        self.serverConnectPopup:setAnchorBottom(true);
        self.serverConnectPopup:setAnchorTop(true);
        self.serverConnectPopup.backgroundColor = {r=0, g=0, b=0, a=0.8};
        self.serverConnectPopup.borderColor = {r=1, g=1, b=1, a=0.5};

        self.multiplayer = MultiplayerScreen:new(0, 0, self.width, self.height);

        self.multiplayer:initialise();
        self.multiplayer:setVisible(false);
        self.multiplayer:setAnchorRight(true);
        self.multiplayer:setAnchorLeft(true);
        self.multiplayer:setAnchorBottom(true);
        self.multiplayer:setAnchorTop(true);
        self.multiplayer.backgroundColor = {r=0, g=0, b=0, a=0.8};
        self.multiplayer.borderColor = {r=1, g=1, b=1, a=0.5};

        self.joinPublicServer = PublicServerList:new(0, 0, self.width, self.height);

        self.joinPublicServer:initialise();
        self.joinPublicServer:setVisible(false);
        self.joinPublicServer:setAnchorRight(true);
        self.joinPublicServer:setAnchorLeft(true);
        self.joinPublicServer:setAnchorBottom(true);
        self.joinPublicServer:setAnchorTop(true);
        self.joinPublicServer.backgroundColor = {r=0, g=0, b=0, a=0.8};
        self.joinPublicServer.borderColor = {r=1, g=1, b=1, a=0.5};

        self.soloScreen = NewGameScreen:new(0, 0, self.width, self.height);
        self.soloScreen:initialise();
        self.soloScreen:setVisible(false);
        self.soloScreen:setAnchorRight(true);
        self.soloScreen:setAnchorLeft(true);
        self.soloScreen:setAnchorBottom(true);
        self.soloScreen:setAnchorTop(true);
        self.soloScreen.backgroundColor = {r=0, g=0, b=0, a=0.8};
        self.soloScreen.borderColor = {r=1, g=1, b=1, a=0.5};

        self.loadScreen = LoadGameScreen:new(0, 0, self.width, self.height);
        self.loadScreen:initialise();
        self.loadScreen:setVisible(false);
        self.loadScreen:setAnchorRight(true);
        self.loadScreen:setAnchorLeft(true);
        self.loadScreen:setAnchorBottom(true);
        self.loadScreen:setAnchorTop(true);
        self.loadScreen.backgroundColor = {r=0, g=0, b=0, a=0.8};
        self.loadScreen.borderColor = {r=1, g=1, b=1, a=0.5};

        self.onlineCoopScreen = CoopOptionsScreen:new(0, 0, self.width, self.height);
        self.onlineCoopScreen:initialise();
        self.onlineCoopScreen:setVisible(false);
        self.onlineCoopScreen:setAnchorRight(true);
        self.onlineCoopScreen:setAnchorLeft(true);
        self.onlineCoopScreen:setAnchorTop(true);
        self.onlineCoopScreen:setAnchorBottom(true);
        self.onlineCoopScreen.backgroundColor = { r = 0, g = 0, b = 0, a = 0.8 };
        self.onlineCoopScreen.borderColor = { r = 1, g = 1, b = 1, a = 0.5 };

        if WorkshopSubmitScreen.TEST or getSteamModeActive() then
            self.workshopSubmit = WorkshopSubmitScreen:new(0, 0, self.width, self.height)
            self.workshopSubmit:initialise()
            self.workshopSubmit:setVisible(false)
            self.workshopSubmit:setAnchorRight(true)
            self.workshopSubmit:setAnchorLeft(true)
            self.workshopSubmit:setAnchorBottom(true)
            self.workshopSubmit:setAnchorTop(true)
            self.workshopSubmit.backgroundColor = {r=0, g=0, b=0, a=0.8}
            self.workshopSubmit.borderColor = {r=1, g=1, b=1, a=0.5}
        end

        if getSteamModeActive() then
            self.serverWorkshopItem = ServerWorkshopItemScreen:new(0, 0, self.width, self.height)
            self.serverWorkshopItem:initialise()
            self.serverWorkshopItem:setVisible(false)
            self.serverWorkshopItem:setAnchorRight(true)
            self.serverWorkshopItem:setAnchorLeft(true)
            self.serverWorkshopItem:setAnchorBottom(true)
            self.serverWorkshopItem:setAnchorTop(true)
            self.serverWorkshopItem.backgroundColor = {r=0, g=0, b=0, a=0.8}
            self.serverWorkshopItem.borderColor = {r=1, g=1, b=1, a=0.5}
        end
    end



    self.mainOptions = MainOptions:new(0, 0, self.width, self.height);

    self.mainOptions:initialise();
    self.mainOptions:setVisible(false);
    self.mainOptions:setAnchorRight(true);
    self.mainOptions:setAnchorLeft(true);
    self.mainOptions:setAnchorBottom(true);
    self.mainOptions:setAnchorTop(true);

    self.mainOptions.backgroundColor = {r=0, g=0, b=0, a=0.8};
    self.mainOptions.borderColor = {r=1, g=1, b=1, a=0.5};

    if self.inGame then
        if isClient() then
            self.scoreboard = ISScoreboard:new(0, 0, self.width, self.height);
            self.scoreboard:initialise()
            self.scoreboard:setVisible(false);
            self.scoreboard:setAnchorRight(true)
            self.scoreboard:setAnchorBottom(true)

            self.inviteFriends = InviteFriends:new(0, 0, self.width, self.height)
            self.inviteFriends:initialise();
            self.inviteFriends:setVisible(false);
            self.inviteFriends:setAnchorRight(true);
            self.inviteFriends:setAnchorBottom(true);
        end
    elseif not isDemo() then
        self.sandOptions = SandboxOptionsScreen:new(0, 0, self.width, self.height);

        self.sandOptions:initialise();
        self.sandOptions:setVisible(false);
        self.sandOptions:setAnchorRight(true);
        self.sandOptions:setAnchorLeft(true);
        self.sandOptions:setAnchorBottom(true);
        self.sandOptions:setAnchorTop(true);

        self.sandOptions.backgroundColor = {r=0, g=0, b=0, a=0.8};
        self.sandOptions.borderColor = {r=1, g=1, b=1, a=0.5};

        self.worldSelect = WorldSelect:new(0, 0, self.width, self.height);

        self.worldSelect:initialise();
        self.worldSelect:setVisible(false);
        self.worldSelect:setAnchorRight(true);
        self.worldSelect:setAnchorLeft(true);
        self.worldSelect:setAnchorBottom(true);
        self.worldSelect:setAnchorTop(true);

        self.worldSelect.backgroundColor = {r=0, g=0, b=0, a=0.8};
        self.worldSelect.borderColor = {r=1, g=1, b=1, a=0.5};

        self.mapSpawnSelect = MapSpawnSelect:new(0, 0, self.width, self.height)
        self.mapSpawnSelect:initialise()
        self.mapSpawnSelect:setVisible(false)
        self.mapSpawnSelect:setAnchorRight(true);
        self.mapSpawnSelect:setAnchorLeft(true);
        self.mapSpawnSelect:setAnchorBottom(true);
        self.mapSpawnSelect:setAnchorTop(true);

        self.mapSpawnSelect.backgroundColor = {r=0, g=0, b=0, a=0.8};
        self.mapSpawnSelect.borderColor = {r=1, g=1, b=1, a=0.5};

        self.modSelect = ModSelector:new(0, 0, self.width, self.height);

        self.modSelect:initialise();
        self.modSelect:setVisible(false);
        self.modSelect:setAnchorRight(true);
        self.modSelect:setAnchorLeft(true);
        self.modSelect:setAnchorBottom(true);
        self.modSelect:setAnchorTop(true);

        self.modSelect.backgroundColor = {r=0, g=0, b=0, a=0.8};
        self.modSelect.borderColor = {r=1, g=1, b=1, a=0.5};

        self.charCreationMain = CharacterCreationMain:new(0, 0, self:getWidth(), self:getHeight());

        self.charCreationMain:initialise();
        self.charCreationMain:setVisible(false);
        self.charCreationMain:setAnchorRight(true);
        self.charCreationMain:setAnchorLeft(true);
        self.charCreationMain:setAnchorBottom(true);
        self.charCreationMain:setAnchorTop(true);

        self.charCreationMain.backgroundColor = {r=0, g=0, b=0, a=0.8};
        self.charCreationMain.borderColor = {r=1, g=1, b=1, a=0.5};

        self.charCreationProfession = CharacterCreationProfession:new(0, 0, self:getWidth(), self:getHeight());

        self.charCreationProfession:initialise();
        self.charCreationProfession:setVisible(false);
        self.charCreationProfession:setAnchorRight(true);
        self.charCreationProfession:setAnchorLeft(true);
        self.charCreationProfession:setAnchorBottom(true);
        self.charCreationProfession:setAnchorTop(true);

        self.charCreationProfession.backgroundColor = {r=0, g=0, b=0, a=0.8};
        self.charCreationProfession.borderColor = {r=1, g=1, b=1, a=0.5};

        self.charCreationHeader = CharacterCreationHeader:new(0, 0, 600, 260+UI_BORDER_SPACING+BUTTON_HGT);
        self.charCreationHeader:initialise();
        self.charCreationHeader:setVisible(true);
        self.charCreationHeader:setAnchorRight(true);
        self.charCreationHeader:setAnchorLeft(true);
        self.charCreationHeader:setAnchorBottom(false);
        self.charCreationHeader:setAnchorTop(true);

        self.charCreationHeader.backgroundColor = {r=0, g=0, b=0, a=0.0};
        self.charCreationHeader.borderColor = {r=1, g=1, b=1, a=0};

		self.lastStandPlayerSelect = LastStandPlayerSelect:new(0, 0, self.width, self.height);
        self.lastStandPlayerSelect:initialise();
        self.lastStandPlayerSelect:setVisible(false);
        self.lastStandPlayerSelect:setAnchorRight(true);
        self.lastStandPlayerSelect:setAnchorLeft(true);
        self.lastStandPlayerSelect:setAnchorBottom(true);
        self.lastStandPlayerSelect:setAnchorTop(true);
        self.lastStandPlayerSelect.backgroundColor = {r=0, g=0, b=0, a=0.8};
        self.lastStandPlayerSelect.borderColor = {r=1, g=1, b=1, a=0.5};

        self.serverSettingsScreen = ServerSettingsScreen:new(0, 0, self.width, self.height);
        self.serverSettingsScreen:initialise();
        self.serverSettingsScreen:setVisible(false);
        self.serverSettingsScreen:setAnchorRight(true);
        self.serverSettingsScreen:setAnchorLeft(true);
        self.serverSettingsScreen:setAnchorBottom(true);
        self.serverSettingsScreen:setAnchorTop(true);
        self.serverSettingsScreen.backgroundColor = {r=0, g=0, b=0, a=0.8};
        self.serverSettingsScreen.borderColor = {r=1, g=1, b=1, a=0.5};
    end

    if self.inGame then
        if isClient() then
            self:addChild(self.scoreboard)
            self:addChild(self.inviteFriends);
        end
    elseif not isDemo() then
        self:addChild(self.charCreationMain);

    	self:addChild(self.charCreationProfession);
        self:addChild(self.sandOptions);
        self:addChild(self.onlineCoopScreen);
        self:addChild(self.soloScreen);
        self:addChild(self.loadScreen);
        self:addChild(self.worldSelect);
        self:addChild(self.mapSpawnSelect);
        self:addChild(self.modSelect);
        self:addChild(self.serverList);
        self:addChild(self.bootstrapConnectPopup);
        self:addChild(self.connectToServer);
        self:addChild(self.serverConnectPopup);
        self:addChild(self.multiplayer);
        if isPublicServerListAllowed() then
            self:addChild(self.joinPublicServer);
        end
		self:addChild(self.lastStandPlayerSelect);
        if self.workshopSubmit then
            self:addChild(self.workshopSubmit)
        end
        if self.serverWorkshopItem then
            self:addChild(self.serverWorkshopItem)
        end
		self:addChild(self.serverSettingsScreen);
    end

    self:addChild(self.mainOptions);


	-- resize to screen window / cause resize
	local w = getCore():getScreenWidth();
	local h = getCore():getScreenHeight();
	self:setWidth(w);
	self:setHeight(h);
	self:recalcSize();
    local uis = {
        { self.scoreboard, 0.6, 0.7 },
        { self.serverList, 0.7, 0.8 },
        { self.multiplayer, 1.0, 1.0 },
        { self.joinPublicServer, 0.7, 0.8 },
        { self.connectToServer, 0.7, 0.8 },
        { self.onlineCoopScreen, 0.5, 0.6 },
        { self.soloScreen, 0.7, 0.8 },
        { self.loadScreen, 0.7, 0.8 },
        { self.sandOptions, 0.7, 0.8 },
        { self.worldSelect, 0.7, 0.8 },
        { self.mapSpawnSelect, 1, 1 },
        { self.charCreationProfession, 0.7, 0.8 },
        { self.charCreationMain, 0.7, 0.8 },
        { self.inviteFriends, 0.7, 0.8 },
        { self.modSelect, 0.9, 0.9 },
        { self.lastStandPlayerSelect, 0.9, 0.9 },
        { self.mainOptions, 0.7, 0.8 },
        { self.workshopSubmit, 0.9, 0.9 },
        { self.serverWorkshopItem, 0.9, 0.9 },
        { self.serverSettingsScreen, 0.5, 0.8 },
    }

    for _,ui in ipairs(uis) do
        if ui[1] and ui[1].javaObject and instanceof(ui[1].javaObject, 'UIElement') then
            local width = w * ui[2]
            local height = h * ui[3]
            if w <= 1024 then
                width = w * 0.95
                height = h * 0.95
            end
            ui[1]:setWidth(width)
            ui[1]:setHeight(height)
            ui[1]:setX((w - width) / 2)
            ui[1]:setY((h - height) / 2)
            ui[1]:recalcSize()
        end
    end

    local labelHgt = getTextManager():getFontHeight(UIFont.Large) + 8 * 2
    local labelX = 0
    local labelY = 0
    local labelSeparator = 16

    local btnWidth = UI_BORDER_SPACING*2 + math.max(
        getTextManager():MeasureStringX(UIFont.Small, getText("UI_Details")),
        getTextManager():MeasureStringX(UIFont.Small, getText("UI_NewGame_Mods")),
        getTextManager():MeasureStringX(UIFont.Small, getText("UI_TermsOfService_MainMenu")),
        getTextManager():MeasureStringX(UIFont.Small, getText("UI_ResetLua"))
    )

    if not self.inGame then

        if false and isXBOXController() and JoypadState.joypads[0] == nil then
            self.controllerLabel = ISLabel:new(self.width/2 - 50, 15, 32, "Press", 1, 1, 1, 0.7, UIFont.Small);
            self.controllerLabel:initialise();
            self.bottomPanel:addChild(self.controllerLabel);

            self.abutton = ISImage:new (self.controllerLabel.x + 31, 17, 32, 32, Joypad.Texture.AButton);
            self.abutton:initialise();
            self.bottomPanel:addChild(self.abutton);

            self.controllerLabel2 = ISLabel:new(self.abutton.x + 35, 15, 32, "to activate controller.", 1, 1, 1, 0.7, UIFont.Small, true);
            self.controllerLabel2:initialise();
            self.bottomPanel:addChild(self.controllerLabel2);
        end

        self.debOption = ISLabel:new(labelX, labelY, labelHgt, getText("UI_mainscreen_debug"), 1, 1, 1, 0.7, UIFont.Small);
        self.debOption.internal = "DEBUG";
        self.debOption:initialise();
        --self:addChild(self.debOption);
        self.debOption.onMouseDown = MainScreen.onMenuItemMouseDownMainMenu;
        self.debOption:setVisible(true);

        if getDebug() then
            self.resetLua = ISButton:new(self.width - btnWidth - UI_BORDER_SPACING*4, self.height - BUTTON_HGT, btnWidth, BUTTON_HGT, getText("UI_ResetLua") , self, function() getCore():ResetLua("default", "Force") end);
            self.resetLua:initialise();
            self.resetLua.borderColor = {r=0.2, g=0.8, b=1, a=1};
            self.resetLua.textColor = {r=0.2, g=0.8, b=1, a=1};
            self:addChild(self.resetLua);
            self.resetLua:setAnchorLeft(false)
            self.resetLua:setAnchorTop(false)
            self.resetLua:setAnchorRight(true)
            self.resetLua:setAnchorBottom(true)
        end

        if isDemo() then

            self.survivalOption = ISLabel:new(labelX, labelY, labelHgt, getText("UI_mainscreen_demoBtn"), 1, 1, 1, 1, UIFont.Large, true);
            self.survivalOption.internal = "APOCALYPSE";
            self.survivalOption:initialise();
            self.bottomPanel:addChild(self.survivalOption);
            self.survivalOption.onMouseDown = MainScreen.onMenuItemMouseDownMainMenu;
            labelY = labelY + labelHgt

            self.tutorialOption = ISLabel:new(labelX, labelY, labelHgt, getText("UI_mainscreen_tutorial"), 1, 1, 1, 1, UIFont.Large, true);
            self.tutorialOption.internal = "TUTORIAL";
            self.tutorialOption:initialise();
            self.tutorialOption.onMouseDown = MainScreen.onMenuItemMouseDownMainMenu;
            self.bottomPanel:addChild(self.tutorialOption);
            labelY = labelY + labelHgt

        else
    
            local hasSaveFiles = #getFullSaveDirectoryTable() > 0

            self.latestSaveOption = ISLabel:new(labelX, labelY, labelHgt, getText("UI_mainscreen_continue"), 1, 1, 1, 1, UIFont.Large, true);
            self.latestSaveOption.internal = "LATESTSAVE";
            self.latestSaveOption:initialise();
            self.bottomPanel:addChild(self.latestSaveOption);
            self.latestSaveOption.onMouseDown = MainScreen.onMenuItemMouseDownMainMenu;
            self.latestSaveOption:setVisible(false);
            if (MainScreen.latestSaveGameMode and MainScreen.latestSaveWorld) and hasSaveFiles then
                self.latestSaveOption:setVisible(true);
                labelY = labelY + labelHgt
            end

            self.loadOption = ISLabel:new(labelX, labelY, labelHgt, getText("UI_mainscreen_load"), 1, 1, 1, 1, UIFont.Large, true);
            self.loadOption.internal = "LOAD";
            self.loadOption:initialise();
            self.bottomPanel:addChild(self.loadOption);
            self.loadOption.onMouseDown = MainScreen.onMenuItemMouseDownMainMenu;
            if not hasSaveFiles then
                self.loadOption:setVisible(false)
            else
                labelY = labelY + labelHgt
                labelY = labelY + labelSeparator
            end
    
            self.tutorialOption = ISLabel:new(labelX, labelY, labelHgt, getText("UI_mainscreen_tutorial"), 1, 1, 1, 1, UIFont.Large, true);
            self.tutorialOption.internal = "TUTORIAL";
            self.tutorialOption:initialise();
            self.tutorialOption.onMouseDown = MainScreen.onMenuItemMouseDownMainMenu;
            self.bottomPanel:addChild(self.tutorialOption);
            labelY = labelY + labelHgt

            self.survivalOption = ISLabel:new(labelX, labelY, labelHgt, getText("UI_mainscreen_solo"), 1, 1, 1, 1, UIFont.Large, true);
            self.survivalOption.internal = "SOLO";
            self.survivalOption:initialise();
            self.bottomPanel:addChild(self.survivalOption);
            self.survivalOption.onMouseDown = MainScreen.onMenuItemMouseDownMainMenu;
            labelY = labelY + labelHgt
            --
            --self.onlineOption = ISLabel:new(labelX, labelY, labelHgt, getText("UI_mainscreen_multiplayer"), 1, 1, 1, 1, UIFont.Large, true);
            --self.onlineOption.internal = "MULTIPLAYER";
            --self.onlineOption:initialise();
            --self.bottomPanel:addChild(self.onlineOption);
            --self.onlineOption.onMouseDown = MainScreen.onMenuItemMouseDownMainMenu;
            --self.onlineOption:setVisible(true)
            --labelY = labelY + labelHgt
            --
            --self.onlineCoopOption = ISLabel:new(labelX, labelY, labelHgt, getText("UI_mainscreen_coop"), 1, 1, 1, 1, UIFont.Large, true);
            --self.onlineCoopOption.internal = "COOP";
            --self.onlineCoopOption:initialise();
            --self.bottomPanel:addChild(self.onlineCoopOption);
            --self.onlineCoopOption.onMouseDown = MainScreen.onMenuItemMouseDownMainMenu;
            --self.onlineCoopOption:setVisible(true)
            --labelY = labelY + labelHgt

            labelY = labelY + labelSeparator

            self.optionsOption = ISLabel:new(labelX, labelY, labelHgt, getText("UI_mainscreen_option"), 1, 1, 1, 1, UIFont.Large, true);
            self.optionsOption.internal = "OPTIONS";
            self.optionsOption:initialise();
            self.bottomPanel:addChild(self.optionsOption);
            self.optionsOption.onMouseDown = MainScreen.onMenuItemMouseDownMainMenu;
            labelY = labelY + labelHgt

            self.modsOption = ISLabel:new(labelX, labelY, labelHgt, getText("UI_mainscreen_mods"), 1, 1, 1, 1, UIFont.Large, true);
            self.modsOption.internal = "MODS";
            self.modsOption:initialise();
            self.bottomPanel:addChild(self.modsOption);
            self.modsOption.onMouseDown = MainScreen.onMenuItemMouseDownMainMenu;
            labelY = labelY + labelHgt

            if WorkshopSubmitScreen.TEST or getSteamModeActive() then
                self.workshopOption = ISLabel:new(labelX, labelY, labelHgt, getText("UI_mainscreen_workshop"), 1, 1, 1, 1, UIFont.Large, true)
                self.workshopOption.internal = "WORKSHOP"
                self.workshopOption:initialise()
                self.workshopOption.onMouseDown = MainScreen.onMenuItemMouseDownMainMenu
                self.bottomPanel:addChild(self.workshopOption)
                labelY = labelY + labelHgt
            end
        end
        self.defaultJoypadOption = self.survivalOption
    else
        self.returnOption = ISLabel:new(labelX, labelY, labelHgt, getText("UI_mainscreen_return"), 1, 1, 1, 1, UIFont.Large, true)
        self.returnOption.internal = "RETURN"
        self.returnOption:initialise()
        self.returnOption.onMouseDown = MainScreen.onMenuItemMouseDownMainMenu
        self.bottomPanel:addChild(self.returnOption)
        labelY = labelY + labelHgt

        labelY = labelY + labelSeparator

        if isClient() then
            self.scoreOption = ISLabel:new(labelX, labelY, labelHgt, getText("UI_mainscreen_scoreboard"), 1, 1, 1, 1, UIFont.Large, true);
            self.scoreOption.internal = "SCOREBOARD";
            self.scoreOption:initialise();
            self.bottomPanel:addChild(self.scoreOption);
            self.scoreOption.onMouseDown = MainScreen.onMenuItemMouseDownMainMenu;
            labelY = labelY + labelHgt

--            self.adminPanel = ISLabel:new(labelX, labelY, labelHgt, getText("UI_mainscreen_adminpanel"), 1, 1, 1, 1, UIFont.Large, true);
--            self.adminPanel.internal = "ADMINPANEL";
--            self.adminPanel:initialise();
--            self.bottomPanel:addChild(self.adminPanel);
--            self.adminPanel.onMouseDown = MainScreen.onMenuItemMouseDownMainMenu;
--            self.adminPanel:setVisible(false);
--            if canSeePlayerStats() or isCoopHost() then
--                labelY = labelY + labelHgt
--                self.adminPanel:setVisible(true);
--            end

            if canInviteFriends() then
                self.inviteOption = ISLabel:new(labelX, labelY, labelHgt, getText("UI_mainscreen_invite"), 1, 1, 1, 1, UIFont.Large, true);
                self.inviteOption.internal = "INVITE";
                self.inviteOption:initialise();
                self.bottomPanel:addChild(self.inviteOption);
                self.inviteOption.onMouseDown = MainScreen.onMenuItemMouseDownMainMenu;
                labelY = labelY + labelHgt
            end

--            self.userPanel = ISLabel:new(labelX, labelY, labelHgt, getText("UI_mainscreen_userpanel"), 1, 1, 1, 1, UIFont.Large, true);
--            self.userPanel.internal = "USERPANEL";
--            self.userPanel:initialise();
--            self.bottomPanel:addChild(self.userPanel);
--            self.userPanel.onMouseDown = MainScreen.onMenuItemMouseDownMainMenu;
--            labelY = labelY + labelHgt

            labelY = labelY + labelSeparator
        end

        self.optionsOption = ISLabel:new(labelX, labelY, labelHgt, getText("UI_mainscreen_option"), 1, 1, 1, 1, UIFont.Large, true);
        self.optionsOption.internal = "OPTIONS";
        self.optionsOption:initialise();
        self.bottomPanel:addChild(self.optionsOption);
        self.optionsOption.onMouseDown = MainScreen.onMenuItemMouseDownMainMenu;
        labelY = labelY + labelHgt

        if isClient() then
            self.defaultJoypadOption = self.scoreOption
        else
            self.defaultJoypadOption = self.optionsOption
        end
    end

    labelY = labelY + labelSeparator

    self.exitOption = ISLabel:new(labelX, labelY, labelHgt, getText("UI_mainscreen_exit"), 1, 1, 1, 1, UIFont.Large, true);
	self.exitOption.internal = "EXIT";
	self.exitOption:initialise();
	self.bottomPanel:addChild(self.exitOption);
	self.exitOption.onMouseDown = MainScreen.onMenuItemMouseDownMainMenu;
	labelY = labelY + labelHgt

    if self.inGame then
        labelY = labelY + labelSeparator
        self.quitToDesktop = ISLabel:new(labelX, labelY, labelHgt, getText("IGUI_PostDeath_Quit"), 1, 1, 1, 1, UIFont.Large, true);
        self.quitToDesktop.internal = "QUIT_TO_DESKTOP";
        self.quitToDesktop:initialise();
        self.bottomPanel:addChild(self.quitToDesktop);
        self.quitToDesktop.onMouseDown = MainScreen.onMenuItemMouseDownMainMenu;
        labelY = labelY + labelHgt
    end

    self.maxMenuItemWidth = 0
    for _,child in pairs(self.bottomPanel:getChildren()) do
        if child.Type == "ISLabel" then
            self.maxMenuItemWidth = math.max(self.maxMenuItemWidth, child:getWidth())
        end
    end
    local maxWidth = math.max(logoWidth / 2, self.maxMenuItemWidth)
    for _,child in pairs(self.bottomPanel:getChildren()) do
        if child.Type == "ISLabel" then
            child:setWidth(maxWidth)
        end
    end
    self.bottomPanel:setX(logoX + math.max(0, logoWidth - maxWidth) / 2)
    print(logoX + math.max(0, logoWidth - maxWidth) / 2)
--    self.bottomPanel:setX(logoX)
    self.bottomPanel:setWidth(maxWidth)
    self.bottomPanel:setHeight(labelY)

    self.versionDetail = ISButton:new(self.width - btnWidth - UI_BORDER_SPACING*4, self.height - FONT_HGT_SMALL - UI_BORDER_SPACING*4, btnWidth, BUTTON_HGT, getText("UI_Details") , self, MainScreen.onClickVersionDetail);
    self.versionDetail:initialise();
    self.versionDetail.borderColor = {r=1, g=1, b=1, a=0.7};
    self.versionDetail.textColor =  {r=1, g=1, b=1, a=0.7};
    self:addChild(self.versionDetail);
    self.versionDetail:setAnchorLeft(false)
    self.versionDetail:setAnchorTop(false)
    self.versionDetail:setAnchorRight(true)
    self.versionDetail:setAnchorBottom(true)
    self.versionDetail.internal = "VERSIONDETAIL";

    if self.inGame then
        self.modListDetail = ISButton:new(self.versionDetail.x, self.versionDetail.y - UI_BORDER_SPACING - BUTTON_HGT, btnWidth, BUTTON_HGT, getText("UI_NewGame_Mods") , self, MainScreen.onClickModList);
        self.modListDetail:initialise();
        self.modListDetail.borderColor = {r=1, g=1, b=1, a=0.7};
        self.modListDetail.textColor =  {r=1, g=1, b=1, a=0.7};
        self:addChild(self.modListDetail);
        self.modListDetail:setAnchorLeft(false)
        self.modListDetail:setAnchorTop(false)
        self.modListDetail:setAnchorRight(true)
        self.modListDetail:setAnchorBottom(true)
        self.modListDetail.internal = "MODLISTDETAIL";
    end

    if not self.inGame then
        local termsY = self.modListDetail and self.modListDetail.y or self.versionDetail.y
        termsY = termsY - UI_BORDER_SPACING - BUTTON_HGT
        self.termsOfService = ISButton:new(self.versionDetail.x, termsY, btnWidth, BUTTON_HGT, getText("UI_TermsOfService_MainMenu"), self, MainScreen.onClickTermsOfService);
        self.termsOfService:initialise();
        self.termsOfService.borderColor = {r=1, g=1, b=1, a=0.7};
        self.termsOfService.textColor =  {r=1, g=1, b=1, a=0.7};
        self.termsOfService:setAnchorLeft(false)
        self.termsOfService:setAnchorTop(false)
        self.termsOfService:setAnchorRight(true)
        self.termsOfService:setAnchorBottom(true)
        self:addChild(self.termsOfService);
        if self.resetLua then
            self.resetLua:setY(self.termsOfService.y - UI_BORDER_SPACING - self.resetLua.height)
        end
    end

    --

    local version = getCore():getVersion();
    if getSteamModeActive() then
        version = getText("UI_mainscreen_version_steam", version);
    else
        version = getText("UI_mainscreen_version", version);
    end
	self.versionLabel = ISLabel:new(-12, 0, FONT_HGT_SMALL, version , 1, 1, 1, 0.7, UIFont.Small);
	self.versionLabel:initialise();
	self.versionDetail:addChild(self.versionLabel);

    self.mainOptions:create();

    for _,child in pairs(self.bottomPanel:getChildren()) do
        if child ~= self.controllerLabel and child ~= self.controllerLabel2 and child ~= self.abutton and child ~= self.versionLabel then
            child.fade = UITransition.new()
            child.fade:setFadeIn(false)
            child.prerender = MainScreen.prerenderBottomPanelLabel
        end
    end

    if self.inGame then
        if isClient() then
            self.scoreboard:create()
            self.inviteFriends:create();
        end
    elseif not isDemo() then
        -- Queries all the challenges...
        triggerEvent("OnChallengeQuery");

		self.desc = SurvivorFactory.CreateSurvivor();
	    self.charCreationHeader:create();
        self.charCreationMain:create();
	    self.charCreationProfession:create();
		self.lastStandPlayerSelect:create();
        self.sandOptions:create();
        self.soloScreen:create();
        self.loadScreen:create();
        self.onlineCoopScreen:create();
        self.serverList:create();
        self.joinPublicServer:create();
        self.multiplayer:create();
        self.bootstrapConnectPopup:create();
        self.connectToServer:create();
        self.serverConnectPopup:create();
	    self.worldSelect:create();
	    self.mapSpawnSelect:create();
        self.modSelect:create();
        if self.workshopSubmit then
            self.workshopSubmit:create()
        end
        if self.serverWorkshopItem then
            self.serverWorkshopItem:create()
        end
        self.serverSettingsScreen:create()

        -- do the update news
            -- TODO DISABLED FOR NOW
--        if getGameVersion() ~= getCore():getSeenUpdateText() then
--			self:onClickVersionDetail()
--        end

        if not getCore():isAnimPopupDone() and not (getDebug() and getDebugOptions():getBoolean("UI.DisableWelcomeMessage")) then
            local windowSize = 600+(getCore():getOptionFontSizeReal()*100);
            self.animPopup = ISModalRichText:new((getCore():getScreenWidth()-windowSize)/2,getCore():getScreenHeight()/2-300,windowSize,600, getText("UI_News_Anim3"), false);
            self.animPopup:initialise();
            self.animPopup.backgroundColor = {r=0, g=0, b=0, a=0.9};
            self.animPopup.alwaysOnTop = true;
            self.animPopup.chatText:paginate();
            self.animPopup:setY(getCore():getScreenHeight()/2-(self.animPopup:getHeight()/2));
            self.animPopup:setVisible(true);
            self.animPopup:addToUIManager();
            self.animPopup.prevFocus = self;
            getCore():setAnimPopupDone(true)
        end
    
--        local text = " <SIZE:medium> You're great at this! <LINE> <LINE> Let's have a look at your character information. <LINE> <LINE> <SIZE:large> Hold the <IMAGE:media/ui/backbutton.png> and select <IMAGE:media/ui/Heart2_On.png,32,32> <LINE> ";
--        self.animPopup = ISModalRichText:new(getCore():getScreenWidth()/2-350,getCore():getScreenHeight()/2-300,900,600, text, false);
--        self.animPopup:initialise();
--        self.animPopup.backgroundColor = {r=0, g=0, b=0, a=0.9};
--        self.animPopup.alwaysOnTop = true;
--        self.animPopup.chatText:paginate();
--        self.animPopup:setY(getCore():getScreenHeight()/2-(self.animPopup:getHeight()/2));
--        self.animPopup:setVisible(true);
--        self.animPopup:addToUIManager();
    end
	--MainScreen.instance.bottomPanel:setVisible(false);

--	local teamOverview = TeamOverview:new(200, 200, 300, 200, self.desc);
--	teamOverview:initialise();
--	self:addChild(teamOverview);

--	local teampicker = TeamPicker:new(200, 200, 300, 200, "Choose members to send with "..self.desc:getSurname(), self.desc);

--	teampicker:initialise();
--	self:addChild(teampicker);
    GameWindow.doRenderEvent(true);

	if false then
		self.threeD = ISUI3DModel:new(getCore():getScreenWidth() - 100, (getCore():getScreenHeight() - 400) / 2, 400, 400)
		self.threeD:setAnchorLeft(false)
		self.threeD:setAnchorRight(true)
		self.threeD:setVisible(true)
		self:addChild(self.threeD)
		self.threeD:setOutfitName("Foreman", false, false)
		self.threeD:setState("sprint")
		self.threeD:setDirection(IsoDirections.S)
    end
end

function MainScreen:OnClickNews()
    getCore():setSeenUpdateText(getGameVersion());
    getCore():saveOptions();
end

function MainScreen:render()
  --  local textManager = getTextManager();
--    textManager:DrawString(UIFont.Small, 240+100, getCore():getOffscreenHeight()-38, "TEST RELEASE WARNING: This version of the game is for closed testing only. It may contain serious bugs or missing features. We recommend awaiting an official release.", 1, 0.4, 0.4, 1.0);

--    local fontHgt = getTextManager():getFontFromEnum(UIFont.Small):getLineHeight()
--    self:drawTextRight(getCore():getVersion(), self:getWidth() - 42, self.bottomPanel:getY() - fontHgt, 1, 1, 1, 0.7, UIFont.Small);
    if self.inGame and isClient() then
        local labelSeparator = 16
        local newY = self.scoreOption:getBottom()
--        if canSeePlayerStats() or isCoopHost() then
--            self.adminPanel:setVisible(true);
--            newY = self.adminPanel:getBottom()
--        else
--            self.adminPanel:setVisible(false);
--        end
        if self.inviteOption then
            self.inviteOption:setY(newY)
            newY = self.inviteOption:getBottom()
        end
--        if self.userPanel then
--            self.userPanel:setY(newY)
--            newY = self.userPanel:getBottom()
--        end
        newY = newY + labelSeparator
        self.optionsOption:setY(newY)
        newY = self.optionsOption:getBottom()

        newY = newY + labelSeparator
        self.exitOption:setY(newY)
        newY = self.exitOption:getBottom()

        self.quitToDesktop:setY(newY)

        self.bottomPanel:setHeight(self.quitToDesktop:getBottom())
    end
end

function MainScreen:calcLogoHeight()
    local menuHeight = self.bottomPanel:getHeight()
    local screenWidth = getCore():getScreenWidth()
    local screenHeight = getCore():getScreenHeight()
    local padding = 50 * (screenWidth / 1920)
    return screenHeight - menuHeight - padding * 3
end

function MainScreen:prerender()

	ISPanel.prerender(self);
    if(self.inGame) then
        if isClient() then
            self.scoreOption:setEnabled(getPlayer():getRole():haveCapability(Capability.SeePlayersConnected))
            self.scoreOption:setVisible(getPlayer():getRole():haveCapability(Capability.SeePlayersConnected))
        end
        self:drawRect(0, 0, self.width, self.height, 0.5, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
        if isQuitCooldown() then
            self.exitOption:setColor(0.5, 0.5, 0.5)
            self.quitToDesktop:setColor(0.5, 0.5, 0.5)
        else
            self.exitOption:setColor(1, 1, 1)
            self.quitToDesktop:setColor(1, 1, 1)
        end
    end
    if self.delay > 0 then
        if self.firstFrame then
            self.delay = self.delay - UIManager.getMillisSinceLastRender()
        else
            self.firstFrame = true
        end
    end
    local textManager = getTextManager();

    self.time = self.time + ((1.0 / 60)*getGameTime():getMultiplier());

    local lastIsSameTitle = false;
    local nextIsSameTitle = false;

    if self.time > 11.8 then
        if self.credits:size() > self.creditsIndex then
            if self.creditsIndex > 0 then
                if self.credits:get(self.creditsIndex-1).title == self.credits:get(self.creditsIndex).title then
                    lastIsSameTitle = true;
                end
            end

            if self.credits:size()-1 > self.creditsIndex then
                if self.credits:get(self.creditsIndex+1).title == self.credits:get(self.creditsIndex).title then
                    nextIsSameTitle = true;
                end
            end
        end
        local del = self.creditTime / self.creditTimeMax;
        local credAlpha = self.creditTime / self.creditTimeMax;
        if(credAlpha <= 0.5) then
            credAlpha = credAlpha * 2;
        elseif (credAlpha >= 0.8) then
            credAlpha = 1.0 - ((credAlpha - 0.8) * 5);
        else
            credAlpha = 1;
        end
        local credAlpha2 = self.creditTime / self.creditTimeMax;
        if(credAlpha2 <= 0.1) then
            credAlpha2 = credAlpha2 * 10;
            if lastIsSameTitle then credAlpha2 = 1; end
        elseif (credAlpha2 >= 0.9) then
            credAlpha2 = 1.0 - ((credAlpha2 - 0.9) * 10);
            if nextIsSameTitle then credAlpha2 = 1; end
        else
            credAlpha2 = 1;
        end

        self.creditTime = self.creditTime +  ((1.0 / 60)*getGameTime():getMultiplier());
        if self.creditTime > self.creditTimeMax then
            self.creditTime = 0;
            self.creditsIndex = self.creditsIndex + 1;
        end
        if self.credits:size() > self.creditsIndex and not self.inGame and ISDemoPopup.instance == nil then
            textManager:DrawString(UIFont.Cred1, (getCore():getScreenWidth()*0.75)+50 , getCore():getScreenHeight()*0.1, self.credits:get(self.creditsIndex).title, 1, 1, 1, credAlpha2);

            local x = (getCore():getScreenWidth()*0.75);
            local xwid = textManager:MeasureStringX(UIFont.Cred2, self.credits:get(self.creditsIndex).name);
            if(x + xwid > getCore():getScreenWidth()) then
               x = x - ((x + xwid) - getCore():getScreenWidth()) - 10;
            end
            textManager:DrawString(UIFont.Cred2, x, (getCore():getScreenHeight()*0.1) + 26, self.credits:get(self.creditsIndex).name, 1, 1, 1, credAlpha);
        end

    end

    local mainScreen = MainScreenState.getInstance();
	if mainScreen ~= nil and (ISDemoPopup.instance == nil) then
        local x = 50;
        local y = 50;
        local sw = getCore():getScreenWidth();

        local tex = self.logoTexture
        local w = tex:getWidth();
        local h = tex:getHeight();
        local resdelta = math.min(self:calcLogoHeight() / h, sw / 1920)
        x = x * (sw / 1920);
        y = y * (sw / 1920);
        w = w * resdelta;
        h = h * resdelta;
        self:drawTextureScaled(tex, x, y, w, h, 1-(self.warningFade / self.warningFadeMax), 1, 1, 1.0);
        if getDebug() and getDebugOptions():getBoolean("UI.Render.Outline") then
            self:drawRectBorder(x, y, w, h, 1, 1, 1, 1)
        end

        self.warningFade = self.warningFade - ((1.5 / 60)*getGameTime():getMultiplier());

        if self.warningFade < 0 then self.warningFade = 0; end

        local maxWidth = math.max(w / 2, self.maxMenuItemWidth)
        for _,child in pairs(self.bottomPanel:getChildren()) do
            if child.Type == "ISLabel" then
                child:setWidth(maxWidth)
            end
        end
        self.bottomPanel:setWidth(maxWidth)
        self.bottomPanel:setX(math.max(UI_BORDER_SPACING*2 + JOYPAD_TEX_SIZE + 1, x + (w - self.bottomPanel:getWidth()) / 2))
        self.bottomPanel:setY(x + h + 50 * (sw / 1920))
	end

    if isDemo() and not self.inGame then
        if self.bottomPanel:getIsVisible() then
            if not self.demoMessagePanel then
                local y = self.bottomPanel:getY() - 35 * 3
                self.demoMessagePanel = ISRichTextPanel:new(self.width / 2 - 800 / 2, 0, 800, 35 * 3)
                self.demoMessagePanel:setAnchorTop(false)
                self.demoMessagePanel:setAnchorBottom(true)
                self.demoMessagePanel.font = UIFont.Medium
                self:addChild(self.demoMessagePanel)
                self.demoMessagePanel.text = getText("UI_Demo_Welcome")
                self.demoMessagePanel:paginate()
            end
            self.demoMessagePanel:setX(self.width / 2 - self.demoMessagePanel:getWidth() / 2)
            self.demoMessagePanel:setY(self.bottomPanel:getY() - 24 - self.demoMessagePanel:getHeight())
        end
        if self.demoMessagePanel then
            self.demoMessagePanel:setVisible(self.bottomPanel:getIsVisible())
        end
    end
end

function MainScreen:prerenderBottomPanelLabel()
    self.fade:update()
    local alpha = 0.5 * self.fade:fraction()
    if alpha > 0 then
        local padLeft = 6
        local padRight = 6
        if self.joypadFocused and self.joypadTexture then
--            padLeft = 2 + 20 + 2
        end
        self:drawRect(0 - padLeft, 0, self:getWidth() + padLeft + padRight, self:getHeight(), alpha, 0.3, 0.3, 0.3)
    end
    ISLabel.prerender(self)
end

function MainScreen:onMouseMove(dx, dy)
	ISPanelJoypad.onMouseMove(self, dx, dy)
	-- Do this here also because update() is called less frequently.
	self:updateBottomPanelButtons()
end

function MainScreen:updateBottomPanelButtons()
    local overButton = nil
    for _,child in pairs(self.bottomPanel:getChildren()) do
        if child.fade and (child:isMouseOver() or child.joypadFocused) then
            overButton = child
            break
        end
    end
    if overButton ~= self.overBottomPanelButton then
        if self.overBottomPanelButton then
            self.overBottomPanelButton.fade:setFadeIn(false)
        end
        self.overBottomPanelButton = overButton
        if self.overBottomPanelButton then
            self.overBottomPanelButton.fade:setFadeIn(true)
            local sound = getSoundManager():playUISound("UIHighlightMainMenuItem")
            if self.MouseEnterMainMenuItem then
                getSoundManager():stopUISound(self.MouseEnterMainMenuItem)
            end
            self.MouseEnterMainMenuItem = sound and sound or nil
        end
    end
end

function MainScreen:setDefaultSandboxVars()
    getSandboxOptions():resetToDefault()
    getSandboxOptions():toLua()
end

MainScreen.checkTutorial = function(button)
--	return true;
--    MainScreen.startTutorial();
	
    if not getCore():isTutorialDone() then
        MainScreen.instance.tutorialButton = button
        local modal = ISModalRichText:new(getCore():getScreenWidth() / 2 - 145, getCore():getScreenHeight() / 2 - 60, 290, 120, getText("UI_Tooltip_Popup"), true, nil, MainScreen.onTutorialModalClick);
        modal:initialise();
        modal:addToUIManager();
        modal:setAlwaysOnTop(true);
        local joypadData = JoypadState.getMainMenuJoypad()
        if joypadData then
            joypadData.focus = modal;
            updateJoypadFocus(joypadData)
        end
        return false;
    end
    return true;
end

function MainScreen:onTutorialModalClick(button)
    local tutorialButton = MainScreen.instance.tutorialButton
    MainScreen.instance.tutorialButton = nil

    local joypadData = JoypadState.getMainMenuJoypad()
    if joypadData then
        joypadData.focus = MainScreen.instance
        updateJoypadFocus(joypadData)
        if button.internal == "YES" then
            MainScreen.onTutorialControllerWarn()
            return
        end
    end

    if button.internal == "YES" then
        MainScreen.startTutorial();
    else
        getCore():setTutorialDone(true);
        getCore():saveOptions();
        MainScreen.onMenuItemMouseDownMainMenu(tutorialButton, 0, 0)
    end
end

function MainScreen.onTutorialControllerWarn()
    local modal = ISModalRichText:new(getCore():getScreenWidth() / 2 - 145, getCore():getScreenHeight() / 2 - 60, 290, 120,
        getText("UI_mainscreen_TutorialControllerWarn"), true, nil, MainScreen.onTutorialControllerWarn2)
    modal:initialise()
    modal:addToUIManager()
    modal:setAlwaysOnTop(true)
    local joypadData = JoypadState.getMainMenuJoypad()
    if joypadData then
        joypadData.focus = modal
        updateJoypadFocus(joypadData)
    end
end

function MainScreen:onTutorialControllerWarn2(button)
    local joypadData = JoypadState.getMainMenuJoypad()
    joypadData.focus = MainScreen.instance
    updateJoypadFocus(joypadData)

    if button.internal == "YES" then
        MainScreen.startTutorial()
    end
end

MainScreen.startTutorial = function()
    local currentMods = ActiveMods.getById("currentGame")
    currentMods:clear()
    if ActiveMods.requiresResetLua(currentMods) then
        getCore():ResetLua("currentGame", "startTutorial")
    end

    deleteAllGameModeSaves("Tutorial");
    MainScreen.instance:setDefaultSandboxVars()
    getWorld():setGameMode("Tutorial");
    local worldName = ZombRand(100000)..ZombRand(100000)..ZombRand(100000)..ZombRand(100000);
    getWorld():setWorld(worldName);
    doTutorial(Tutorial1);
    TutorialData = {}
    TutorialData.chosenTutorial = Tutorial1;
    createWorld(worldName);
--[[
    -- menu activated via joypad, we disable the joypads and will re-set them automatically when the game is started
    if MainScreen.instance.joyfocus then
        local joypadData = MainScreen.instance.joyfocus
        joypadData.focus = nil;
        updateJoypadFocus(joypadData)
        JoypadState.count = 0
        JoypadState.players = {};
        JoypadState.joypads = {};
        JoypadState.forceActivate = joypadData.id;
    end
--]]
    GameWindow.doRenderEvent(false);
    forceChangeState(LoadingQueueState.new());
end

function MainScreen.checkMapsAvailable(mapName, activeMods, mapAvailable)
    activeMods = activeMods or ActiveMods.getById("currentGame")

    local mapGroups = MapGroups.new()
    mapGroups:createGroups(activeMods, true, true)
    local lotDirs = mapGroups:getAllMapsInOrder()

    local count = 0
    local mapNames = luautils.split(mapName, ";")
    for i=1,#mapNames do
        local mapName = mapNames[i]:trim()
        if lotDirs:contains(mapName) then
            mapAvailable[mapName] = true
            count = count + 1
        end
    end
    return count == #mapNames
end

function MainScreen.getMissingMods(activeMods)
    local result = {}
    for i=1,activeMods:getMods():size() do
        local modID = activeMods:getMods():get(i-1)
        local modInfo = getModInfoByID(modID)
        if modInfo == nil then
            table.insert(result, modID)
        elseif not modInfo:isAvailable() then
            table.insert(result, modID)
        end
    end
    return result
end

function MainScreen.checkSaveFile()
    local saveInfo = getSaveInfo(getWorld():getWorld())
    if not saveInfo.gameMode then
        local text = " <H1> " .. getText("UI_mainscreen_ErrorLoadingSavefile") .. " <H2> <LINE> <LINE> "
        text = text .. getText("UI_mainscreen_SavefileName", getWorld():getWorld()) .. " <LINE> <H2> "
        local gameMode = getTextOrNull("IGUI_Gametime_" .. getWorld():getGameMode())
        if not gameMode then gameMode = getWorld():getGameMode() end
        text = text .. getText("IGUI_Gametime_GameMode", gameMode) .. " <LINE> <H2> "
        text = text .. " <TEXT> <RED> " .. getText("UI_mainscreen_SavefileNotFound") .. " <RGB:1,1,1> <LINE> "
        MainScreen.displayCheckSavefileModal(text, true, saveInfo.activeMods)
        return
    end
    local worldVersion = tonumber(saveInfo.worldVersion)
    local errorMsg = nil
    local lastPlayed = getLastPlayedDate(saveInfo.gameMode .. "/" .. getWorld():getWorld())
    local mapAvailable = {}

    local versionText = " <LINE> <LINE> " .. getText("UI_worldscreen_SavefileVersion", worldVersion or '???', IsoWorld.getWorldVersion())

    local fatal = true
    if not worldVersion or not saveInfo.mapName then
        worldVersion = worldVersion or '???'
        saveInfo.mapName = saveInfo.mapName or '???'
        errorMsg = getText("UI_mainscreen_SavefileNotFound")
    elseif not MainScreen.checkMapsAvailable(saveInfo.mapName, saveInfo.activeMods, mapAvailable) then
        errorMsg, fatal = getText("UI_worldscreen_MapNotFound"), false
    elseif #MainScreen.getMissingMods(saveInfo.activeMods) > 0 then
        errorMsg, fatal = getText("UI_worldscreen_ModNotFound"), false
    elseif worldVersion == 0 then
        errorMsg = getText("UI_worldscreen_SavefileCorrupt")
--    elseif worldVersion == 175 then
--        errorMsg = getText("UI_worldscreen_SavefileOld") .. " <LINE> " .. getText("UI_worldscreen_SavefileUseBeta41_50") .. versionText
    elseif worldVersion <= 175 then
        errorMsg = getText("UI_worldscreen_SavefileOld") .. versionText
    elseif worldVersion > IsoWorld.getWorldVersion() then
        errorMsg = getText("UI_worldscreen_SavefileNewerThanGame") .. versionText
    end
    if errorMsg then
        local text = " <H1> " .. getText("UI_mainscreen_ErrorLoadingSavefile") .. " <H2> <LINE> <LINE> "
        text = text .. getText("UI_mainscreen_SavefileName", getWorld():getWorld()) .. " <LINE> <H2> "
        local gameMode = getTextOrNull("IGUI_Gametime_" .. getWorld():getGameMode())
        if not gameMode then gameMode = getWorld():getGameMode() end
        text = text .. getText("IGUI_Gametime_GameMode", gameMode) .. " <LINE> <H2> "
        text = text .. lastPlayed .. " <LINE> "

        local mapName = saveInfo.mapName
        local folders = mapName:split(";")
        text = text .. getText("UI_Map") .. " <LINE> <TEXT> <INDENT:20> "
        for _,folder in ipairs(folders) do
            if mapAvailable[folder:trim()] then
                text = text .. " <TEXT> " .. folder .. " <LINE> "
            else
                text = text .. " <RED> " .. folder .. " <LINE> "
            end
        end
        text = text .. " <INDENT:0> <H2> "

        text = text .. getText("UI_LoadGameScreen_Mods") .. " <LINE> <TEXT> <INDENT:20> "
        local activeMods = saveInfo.activeMods
        if activeMods == nil then
            text = text .. getText("UI_LoadGameScreen_NoModsTxt") .. " <LINE> "
        elseif activeMods:getMods():isEmpty() then
            text = text .. getText("UI_LoadGameScreen_NoMods") .. " <LINE> "
        else
            for i=1,activeMods:getMods():size() do
                local modID = activeMods:getMods():get(i-1)
                local modInfo = getModInfoByID(modID)
                if modInfo == nil then
                    text = text .. " <RED> "
                elseif not modInfo:isAvailable() then
                    text = text .. " <RED> "
                    modID = modInfo:getName()
                else
                    text = text .. " <TEXT> "
                    modID = modInfo:getName()
                end
                text = text .. modID .. " <LINE> "
            end
        end
        text = text .. " <INDENT:0> <H2> "

        text = text .. getText("UI_WorldVersion") .. worldVersion .. " <LINE> "
        text = text .. " <TEXT> <RED> " .. errorMsg .. " <RGB:1,1,1> <LINE> "
        MainScreen.displayCheckSavefileModal(text, fatal, activeMods)
        return false
    end
    return true
end

function MainScreen.displayCheckSavefileModal(text, fatal)
    local width = 450
    local modal = ISModalRichText:new(getCore():getScreenWidth() / 2 - 450 / 2,
        getCore():getScreenHeight() / 2 - 60, 450, 120, text, not fatal,
        nil, MainScreen.onCheckSavefileModalClick)
    modal:initialise()
    modal:addToUIManager()
    modal:setAlwaysOnTop(true)
    local joypadData = JoypadState.getMainMenuJoypad()
    if joypadData then
        joypadData.focus = modal
        updateJoypadFocus(joypadData)
    end
    MainScreen.instance.checkSavefileModal = modal
end

function MainScreen.resetLuaIfNeeded()
    local defaultMods = ActiveMods.getById("default")
    if ActiveMods.requiresResetLua(defaultMods) then
        -- Setting 'currentGame' to 'default' in case other places forget to set it
        -- before starting a game (DebugScenarios.lua, etc).
        local currentMods = ActiveMods.getById("currentGame")
        currentMods:copyFrom(defaultMods)
        getCore():ResetLua("default", "modsChanged")
    end
end

function MainScreen.onCheckSavefileModalClick(model, button)
    if button.internal == "YES" then
        local saveInfo = getSaveInfo(getWorld():getWorld())
        local currentMods = ActiveMods.getById("currentGame")
        currentMods:checkMissingMods()
        currentMods:checkMissingMaps()
        manipulateSavefile(saveInfo.saveDir, "WriteModsDotTxt")
        MainScreen.continueLatestSaveAux(true)
        return
    end
    -- Reset mods to the default if the savefile's mods aren't the default ones.
    MainScreen.resetLuaIfNeeded()

    MainScreen.instance.checkSavefileModal = nil
    local joypadData = JoypadState.getMainMenuJoypad()
    if joypadData then
        joypadData.focus = MainScreen.instance
        updateJoypadFocus(joypadData)
    end
end

function MainScreen.continueLatestSaveAux(fromResetLua)
    local defaultMods = ActiveMods.getById("default")
    local currentMods = ActiveMods.getById("currentGame")
    local saveInfo = getSaveInfo(getWorld():getWorld())
    if saveInfo.activeMods then
        currentMods:copyFrom(saveInfo.activeMods)
    else
        -- An old savefile without mods.txt. Use the default mods.
        currentMods:copyFrom(defaultMods)
    end
    if not MainScreen.checkSaveFile() then
        return
    end

    if not fromResetLua and ActiveMods.requiresResetLua(currentMods) then
        -- This will reset the Lua environment and call MainScreen.onResetLua() which
        -- will call this function again with fromResetLua=true.
        -- We rely on getWorld():getWorld() to know which savefile to load.
        getCore():ResetLua("currentGame", "continueSave")
    end

    MainScreen.instance.bottomPanel:setVisible(false)

    local joypadData = JoypadState.getMainMenuJoypad()

	if not checkSavePlayerExists() then
        getSoundManager():playUISound("UIActivateMainMenuItem")
        MainScreen.instance.createWorld = false
        if getCore():isChallenge() then
            if MapSpawnSelect.instance:hasChoices() then
                MapSpawnSelect.instance:fillList()
                MapSpawnSelect.instance.previousScreen = "LoadGameScreen"
                MapSpawnSelect.instance:setVisible(true, joypadData)
            else
                MainScreen.instance.charCreationProfession.previousScreen = "LoadGameScreen"
                MainScreen.instance.charCreationProfession:setVisible(true, joypadData)
            end
            return
        end
        local saveInfo = getSaveInfo(getWorld():getWorld())
        local map = saveInfo.mapName or "DEFAULT"
         -- Needed if map_ver.bin doesn't exist since we aren't showing WorldSelect
        getWorld():setMap(map)
        if getWorld():getGameMode() == "Sandbox" then
            -- Ensure CharacterFreeTraits is available
            getSandboxOptions():loadCurrentGameBinFile()
        end
        if MapSpawnSelect.instance:hasChoices() then
            MapSpawnSelect.instance:fillList()
            MapSpawnSelect.instance.previousScreen = "LoadGameScreen"
            MapSpawnSelect.instance:setVisible(true, joypadData)
        else
            MapSpawnSelect.instance:useDefaultSpawnRegion()
            MainScreen.instance.charCreationProfession.previousScreen = "LoadGameScreen"
            MainScreen.instance.charCreationProfession:setVisible(true, joypadData)
        end
	else
		getSoundManager():playUISound("UIActivatePlayButton")
--[[
		-- menu activated via joypad, we disable the joypads and will re-set them automatically when the game is started
		if MainScreen.instance.joyfocus then
			local joypadData = MainScreen.instance.joyfocus
			joypadData.focus = nil
			updateJoypadFocus(joypadData)
			JoypadState.count = 0
			JoypadState.players = {}
			JoypadState.joypads = {}
			JoypadState.forceActivate = joypadData.id
		end
--]]
		GameWindow.doRenderEvent(false)
		forceChangeState(LoadingQueueState.new())
	end
end

MainScreen.continueLatestSave = function(gameMode, saveName)
	if gameMode == "LastStand" then
		return -- LastStand has no savefiles
	end

    if gameMode == "Multiplayer" then
        return
    end

	if gameMode == "Beginner" then
		getWorld():setGameMode("Beginner")
		getWorld():setWorld(saveName)
		MainScreen.instance:setBeginnerPreset()
		MainScreen.continueLatestSaveAux()
		return
	end

	if gameMode == "Sandbox" then
		getWorld():setGameMode("Sandbox")
		getWorld():setWorld(saveName)
		MainScreen.instance:setDefaultSandboxVars() -- in case map_sand.bin doesn't exist, FIXME: use SandboxOptions.getDefaultPreset()?
		MainScreen.continueLatestSaveAux()
		return
	end

	if gameMode == "Survival" then
		getWorld():setGameMode("Survival")
		getWorld():setWorld(saveName)
		MainScreen.instance:setDefaultSandboxVars()
		MainScreen.continueLatestSaveAux()
		return
	end

	-- None of the above? Must be a challenge.  Ignore obsolete challenges.
	for i,challenge in ipairs(LastStandChallenge) do
		if challenge.gameMode == gameMode then
			LastStandData.chosenChallenge = challenge
			doChallenge(challenge)
			getWorld():setWorld(saveName)
			MainScreen.instance:setDefaultSandboxVars()
			MainScreen.continueLatestSaveAux()
			return
		end
    end

    getWorld():setGameMode(gameMode)
    getWorld():setWorld(saveName)

    if gameMode == "Apocalypse" then
        MainScreen.instance:setSandboxPreset(MainScreen.instance.sandOptions:getApocalypsePreset());
        MainScreen.continueLatestSaveAux();
        return;
    end
    if gameMode == "Survivor" then
        MainScreen.instance:setSandboxPreset(MainScreen.instance.sandOptions:getSurvivorPreset());
        MainScreen.continueLatestSaveAux();
        return;
    end
    if gameMode == "Builder" then
        MainScreen.instance:setSandboxPreset(MainScreen.instance.sandOptions:getBuilderPreset());
        MainScreen.continueLatestSaveAux();
        return;
    end

    if gameMode == "Initial Infection" then
        MainScreen.instance:setSandboxPreset(MainScreen.instance.sandOptions:getBeginnerPreset());
        MainScreen.continueLatestSaveAux();
        return;
    end

    if gameMode == "One Week Later" then
        MainScreen.instance:setSandboxPreset(MainScreen.instance.sandOptions:getNormalPreset());
        MainScreen.continueLatestSaveAux();
        return;
    end

    if gameMode == "Six Months Later" then
        MainScreen.instance:setSandboxPreset(MainScreen.instance.sandOptions:getHardPreset());
        MainScreen.continueLatestSaveAux();
        return;
    end

    if gameMode == "Survival" then
        MainScreen.instance:setSandboxPreset(MainScreen.instance.sandOptions:getDefaultPreset());
        MainScreen.continueLatestSaveAux();
        return;
    end

    MainScreen.instance:setDefaultSandboxVars()
    MainScreen.continueLatestSaveAux()
end

MainScreen.onMenuItemMouseDownMainMenu = function(item, x, y)
    print("EXITDEBUG: onMenuItemMouseDownMainMenu 1 (item="..tostring(item.internal)..")")

    if item.internal ~= "LATESTSAVE" then
        -- "Continue" will either play this or UIActivatePlayButton depending
        -- on whether the player exists.
        getSoundManager():playUISound("UIActivateMainMenuItem")
    end

    if DebugScenarios.instance ~= nil then
        MainScreen.instance:removeChild(DebugScenarios.instance);
        DebugScenarios.instance = nil;
    end

    if MainScreen.instance.animPopup ~= nil then
        MainScreen.instance.animPopup:removeFromUIManager();
    end

    if MainScreen.instance.termsOfServiceDialog ~= nil then
        MainScreen.instance.termsOfServiceDialog:removeFromUIManager()
        MainScreen.instance.termsOfServiceDialog = nil
    end

    if MainScreen.instance.delay > 0 then return; end
    if MainScreen.instance.tutorialButton then return end
    if MainScreen.instance.checkSavefileModal then return end

    if (item.internal == "MULTIPLAYER" or item.internal == "SERVERLIST" or item.internal == "CHALLENGE" or item.internal == "SANDBOX" or item.internal == "BEGINNER" or item.internal == "APOCALYPSE" or item.internal == "SOLO") and not MainScreen.checkTutorial(item) then
        return;
    end

    if item.internal == "LATESTSAVE" then
        MainScreen.continueLatestSave(MainScreen.latestSaveGameMode, MainScreen.latestSaveWorld)
        return
    end

    local joypadData = JoypadState.getMainMenuJoypad()

    if item.internal == "EXIT" then
        if isQuitCooldown() then
            print("EXITDEBUG: pvp quit cooldown")
            return
        end
        print("EXITDEBUG: onMenuItemMouseDownMainMenu 2")
--        if MainScreen.instance.inGame then
--            saveGame();
--            MainScreen.instance:getLatestSave();
--        end
        if MainScreen.instance.inGame == true then
            setGameSpeed(1);
            pauseSoundAndMusic();
            setShowPausedMessage(true);
            getCore():quit();
        else
            MainScreen:quitToDesktopFunc()
        end
        print("EXITDEBUG: onMenuItemMouseDownMainMenu 3")
    end
    if item.internal == "QUIT_TO_DESKTOP" then
        if isQuitCooldown() then
            print("EXITDEBUG: pvp quit cooldown")
            return
        end
        print("EXITDEBUG: onMenuItemMouseDownMainMenu 4")
        MainScreen:quitToDesktopFunc()
        return
    end
    if item.internal == "RETURN" then
        print("EXITDEBUG: onMenuItemMouseDownMainMenu 5")
        ToggleEscapeMenu(getCore():getKey("Main Menu"))
        return
    end

    if item.internal == "MULTIPLAYER" then
        MainScreen.instance.bottomPanel:setVisible(false);
        MainScreen.instance.multiplayer:setVisible(true, joypadData);
    end
    if item.internal == "SERVERLIST" then
        MainScreen.instance.bottomPanel:setVisible(false);
        MainScreen.instance.serverList:pingServers(true);
        MainScreen.instance.serverList:setVisible(true, joypadData);
        if ActiveMods.requiresResetLua(ActiveMods.getById("nomods")) then
            getCore():ResetLua("nomods", "joinServer")
        end
    end
    if item.internal == "COOP" then
        MainScreen.instance.bottomPanel:setVisible(false);
        MainScreen.instance.onlineCoopScreen:aboutToShow()
        MainScreen.instance.onlineCoopScreen:setVisible(true, joypadData);
    end
    if item.internal == "SCOREBOARD" then
        if getPlayer():getRole():haveCapability(Capability.SeePlayersConnected) then
            MainScreen.instance.scoreboard:setVisible(true, joypadData);
            scoreboardUpdate()
        end
    end
    if item.internal == "OPTIONS" then
        MainScreen.instance.mainOptions:toUI()
        MainScreen.instance.mainOptions:setVisible(true, joypadData);
    end
    if item.internal == "SOLO" then
        ActiveMods.getById("currentGame"):copyFrom(ActiveMods.getById("default"))
        MainScreen.instance.soloScreen:setVisible(true, joypadData);
        MainScreen.instance.soloScreen.onMenuItemMouseDown(MainScreen.instance.soloScreen.survival,0,0);
    end
    if item.internal == "LOAD" then
        MainScreen.instance.loadScreen:setSaveGamesList();
        MainScreen.instance.loadScreen:setVisible(true, joypadData);
    end
    if item.internal == "MODS" then
        MainScreen.instance.modSelect.model.isNewGame = false
        MainScreen.instance.modSelect:setVisible(true, joypadData);
        MainScreen.instance.modSelect.model:reloadMods()
        ModSelector.showNagPanel()
        ModSelector.instance.returnToUI = MainScreen.instance
    end
    if item.internal == "ADMINPANEL" then
        print("EXITDEBUG: onMenuItemMouseDownMainMenu 5")
        if ISAdminPanelUI.instance then
            ISAdminPanelUI.instance:close()
        end
        local modal = ISAdminPanelUI:new(200, 200, 350, 400)
        modal:initialise();
        modal:addToUIManager();
        print("EXITDEBUG: onMenuItemMouseDownMainMenu 6")
        ToggleEscapeMenu(getCore():getKey("Main Menu"))
        return
    end
    if item.internal == "USERPANEL" then
        print("EXITDEBUG: onMenuItemMouseDownMainMenu 7")
        if ISUserPanelUI.instance then
            ISUserPanelUI.instance:close()
        end
        local modal = ISUserPanelUI:new(200, 200, 400, 250, getPlayer())
        modal:initialise();
        modal:addToUIManager();
        print("EXITDEBUG: onMenuItemMouseDownMainMenu 8")
        ToggleEscapeMenu(getCore():getKey("Main Menu"))
        return
    end
    if item.internal == "TUTORIAL" then
--        if joypadData then
--            MainScreen.onTutorialControllerWarn()
--            return
--        end
        MainScreen.startTutorial();
    end
    if item.internal == "APOCALYPSE" then
        MainScreen.instance:setDefaultSandboxVars()
            getWorld():setGameMode("Sandbox");
            getWorld():setMap("DEFAULT")
            getWorld():setWorld("demo");
            deleteSave("Sandbox/demo");
            createWorld("demo");
--[[
            -- menu activated via joypad, we disable the joypads and will re-set them automatically when the game is started
            if MainScreen.instance.joyfocus then
                local joypadData = MainScreen.instance.joyfocus
                joypadData.focus = nil;
                updateJoypadFocus(joypadData)
                JoypadState.count = 0
                JoypadState.players = {};
                JoypadState.joypads = {};
                JoypadState.forceActivate = joypadData.id;
            end
--]]
            GameWindow.doRenderEvent(false);
            forceChangeState(LoadingQueueState.new());
    end

    if item.internal == "INVITE" then
        InviteFriends.instance:fillList();
--        InviteFriends.instance:setVisible(true);
        MainScreen.instance.inviteFriends:setVisible(true, joypadData);
    end

    if item.internal == "WORKSHOP" then
        MainScreen.instance.workshopSubmit:fillList()
        MainScreen.instance.workshopSubmit:setVisible(true, joypadData)
    end

    MainScreen.instance.bottomPanel:setVisible(false);
end

function MainScreen:quitToDesktopFunc()
    if self.quitToDesktopDialog then
        self.quitToDesktopDialog:destroy()
    end
    local player = 0
    local width = 380;
    local x = getPlayerScreenLeft(player) + (getPlayerScreenWidth(player) - width) / 2
    local height = 120;
    local y = getPlayerScreenTop(player) + (getPlayerScreenHeight(player) - height) / 2
    if not self.inGame then
        player = nil
    end
    local modal = ISModalDialog:new(x,y, width, height, getText("IGUI_ConfirmQuitToDesktop"), true, self, MainScreen.onConfirmQuitToDesktop, player);
    modal:initialise()
    self.quitToDesktopDialog = modal
    modal:addToUIManager()
    modal:setAlwaysOnTop(true)
    modal:bringToTop()
    MainScreen.instance.bottomPanel:setVisible(false)
    if player and JoypadState.players[player+1] then
        modal.prevFocus = JoypadState.players[player+1].focus
        setJoypadFocus(player, modal)
    else
        local joypadData = JoypadState.getMainMenuJoypad()
        if joypadData then
            modal.prevFocus = joypadData.focus
            joypadData.focus = modal
            updateJoypadFocus(joypadData)
        end
    end
end

function MainScreen:onConfirmQuitToDesktop(button)
    if button.internal == "YES" then
        setGameSpeed(1)
        pauseSoundAndMusic()
        setShowPausedMessage(true)
        getCore():quitToDesktop()
    else
        MainScreen.instance.bottomPanel:setVisible(true)
    end
    self.quitToDesktopDialog = nil
end

function MainScreen:onClickVersionDetail()
    if not self.infoRichText then
        self.infoRichText = ISNewsUpdate:new(0,0,getCore():getScreenWidth() - 300,getCore():getScreenHeight()-150, false, self, MainScreen.OnClickNews);
        self.infoRichText:setX(getCore():getScreenWidth() / 2 - self.infoRichText.width/2);
        self.infoRichText:setY(getCore():getScreenHeight() / 2 - self.infoRichText.height/2);
        self.infoRichText:initialise();
        self.infoRichText:addToUIManager();
        self.infoRichText.backgroundColor = {r=0, g=0, b=0, a=0.9};
        self.infoRichText.alwaysOnTop = true;
        self.infoRichText:setVisible(true);
        self.infoRichText:bringToTop();
    else
        self.infoRichText:setVisible(not self.infoRichText:isVisible());
        self.infoRichText:bringToTop();
    end
    local player = 0
    if player and JoypadState.players[player+1] then
        self.infoRichText.prevFocus = JoypadState.players[player+1].focus
        setJoypadFocus(player, self.infoRichText)
    else
        local joypadData = JoypadState.getMainMenuJoypad()
        if joypadData then
            self.infoRichText.prevFocus = joypadData.focus
            joypadData.focus = self.infoRichText
            updateJoypadFocus(joypadData)
        end
    end
end

function MainScreen:onClickTermsOfService(button)
    local width = 600
    local height = 200
    local player = 0
    local modal = ISTermsOfServiceUI:new(self.width / 2 - width / 2, self.height / 2 - height / 2, width, height)
    modal:initialise()
    modal:addToUIManager()
    modal:setAlwaysOnTop(true)
    if player and JoypadState.players[player+1] then
        modal.prevFocus = JoypadState.players[player+1].focus
        setJoypadFocus(player, modal)
    else
        local joypadData = JoypadState.getMainMenuJoypad()
        if joypadData then
            modal.prevFocus = joypadData.focus
            joypadData.focus = modal
            updateJoypadFocus(joypadData)
        end
    end
    self.termsOfServiceDialog = modal
end

function MainScreen:onTermsOfServiceOK()
    self.termsOfServiceDialog = nil
end

function MainScreen:onClickModList()
    if not self.infoModList then
        local w = 250
        local h = 340
        self.infoModList = ISPauseModListUI:new(self.modListDetail:getRight() - w,self.modListDetail:getY() - 10 - h,w, h);
        self.infoModList:initialise();
        self.infoModList:addToUIManager();
        self.infoModList:setVisible(true);
        self.infoModList:bringToTop();
    else
        self.infoModList:destroy()
        self.infoModList = nil
    end
end

function MainScreen:presentServerConnectPopup ()
    MainScreen.instance.bottomPanel:setVisible(false);
    MainScreen.instance.serverConnectPopup:setVisible(true);
end

function MainScreen:update()

    if MainScreen.instance == nil then MainScreen.instance = MainScreenInstance; end

--	local w = getCore():getScreenWidth();
--	local h = getCore():getScreenHeight();

--	MainScreen.instance:setWidth(w);
--	MainScreen.instance:setHeight(h);

    self:updateBottomPanelButtons()

	if not self.inGame and not JoypadState.getMainMenuJoypad() and isSteamRunningOnSteamDeck() then
		local guid = getControllerGUID(0)
		if not getCore():getOptionActiveController(guid) then return end
		activateJoypadOnSteamDeck()
		local joypadData = JoypadState.joypads[1]
		if joypadData then
			local focus = self:getCurrentFocusForController()
			if focus ~= nil then
				joypadData.inMainMenu = true
				joypadData.focus = focus
				updateJoypadFocus(joypadData)
			end
		end
	end
end

function MainScreen:setSandboxPreset(preset)
    getSandboxOptions():copyValuesFrom(preset.options)
    local waterShut = getSandboxOptions():getOptionByName("WaterShut"):getValue();
    local elecShut = getSandboxOptions():getOptionByName("ElecShut"):getValue();
    if getSandboxOptions():getOptionByName("WaterShutModifier"):getValue() == getSandboxOptions():getOptionByName("WaterShutModifier"):getDefaultValue() then
        getSandboxOptions():set("WaterShutModifier", getSandboxOptions():randomWaterShut(waterShut))
    end
    if getSandboxOptions():getOptionByName("ElecShutModifier"):getValue() == getSandboxOptions():getOptionByName("ElecShutModifier"):getDefaultValue() then
        getSandboxOptions():set("ElecShutModifier", getSandboxOptions():randomElectricityShut(elecShut))
    end
    getSandboxOptions():toLua()
end

function MainScreen:setBeginnerPreset()
    local beginnerPreset = MainScreen.instance.sandOptions:getBeginnerPreset()
    self:setSandboxPreset(beginnerPreset);
end

function MainScreen:setEasyPreset()
    SandboxVars.StatsDecrease = 5;
    SandboxVars.EndRegen = 5;
    SandboxVars.InjurySeverity = 1;
    SandboxVars.CarGasConsumption = 0.7;

    SandboxVars.MultiplierConfig = {
        XPMultiplierGlobal = 2,
        XPMultiplierGlobalToggle = true,
    }
--    SandboxVars.Nutrition = false;
end

function MainScreen:setNormalPreset()
    SandboxVars.StatsDecrease = 4;
    SandboxVars.EndRegen = 4;
    SandboxVars.MultiplierConfig = {
        XPMultiplierGlobal = 1.5,
        XPMultiplierGlobalToggle = true,
    }
--    SandboxVars.Nutrition = false;
end

function MainScreen:setHardPreset()
    SandboxVars.InjurySeverity = 3;
    SandboxVars.CarGasConsumption = 1.2;
    SandboxVars.MultiplierConfig = {
        XPMultiplierGlobal = 1.2,
        XPMultiplierGlobalToggle = true,
    }
end

function MainScreen:setHardcorePreset()
    SandboxVars.InjurySeverity = 3;
    SandboxVars.CarGasConsumption = 1.2;
    SandboxVars.MultiplierConfig = {
        XPMultiplierGlobal = 1,
        XPMultiplierGlobalToggle = true,
    }
end

function MainScreen:onEnterFromGame()
	GameSounds.fix3DListenerPosition(true)
	for _,child in pairs(self:getChildren()) do
		if child.onEnterFromGame then
			child:onEnterFromGame()
		end
	end
end

function MainScreen:onReturnToGame()
	GameSounds.fix3DListenerPosition(false)
	for _,child in pairs(self:getChildren()) do
		if child.onReturnToGame then
			child:onReturnToGame()
		end
	end
end

function MainScreen:addCredit(credit, number)
    if number == 0 then --for the Formosa Interactive title
        self.credits:add({title = getText("UI_credits_header_" .. credit), name = ""});
    end
    for i = 1, number do
        self.credits:add({title = getText("UI_credits_header_" .. credit), name = getText("UI_credits_" .. credit .. i)});
    end
end

function MainScreen:doArtCredits()
    self:addCredit("Art", 4);
    self:addCredit("ArtAndAnimation", 1);
end
function MainScreen:doCodeCredits()
    self:addCredit("Code", 12);
end
function MainScreen:doWritingCredits()
    self:addCredit("WrittenBy", 2);
end
function MainScreen:doScriptingCredits()
    self:addCredit("Mapping", 2);
    self:addCredit("AdditionalMapping", 2);
end

function MainScreen:doCredits()
    local r = ZombRand(5);

    self:addCredit("Music", 1);

    if r == 0 then
        self:doArtCredits();
        self:doCodeCredits();
        self:doWritingCredits();
        self:doScriptingCredits();
    end
    if r == 1 then
        self:doCodeCredits();
        self:doArtCredits();
        self:doWritingCredits();
        self:doScriptingCredits();
    end
    if r == 2 then
        self:doWritingCredits();
        self:doScriptingCredits();
        self:doArtCredits();
        self:doCodeCredits();
    end
    if r == 3 then
        self:doWritingCredits();
        self:doScriptingCredits();
        self:doCodeCredits();
        self:doArtCredits();
    end
    if r == 4 then
        self:doCodeCredits();
        self:doWritingCredits();
        self:doScriptingCredits();
        self:doArtCredits();
    end

    self:addCredit("Design", 1);
    self:addCredit("Tools", 2);
    self:addCredit("AdditionalArt", 4);

    self:addCredit("AdditionalCode", 14);

    self:addCredit("LootArtiste", 1);
    self:addCredit("Contributor", 6);

    self:addCredit("Titles", 1);
    self:addCredit("SysAdmin", 1);
    self:addCredit("SysAdminSupport", 1);
    self:addCredit("OperationsManager", 1);
    self:addCredit("SeniorProducer", 1);
    self:addCredit("LeadQa", 1);
    self:addCredit("Qa", 1);
    self:addCredit("Videography", 1);
    self:addCredit("CommunityManager", 1);
    self:addCredit("TechSupport", 1);
    self:addCredit("Hr", 1);
    self:addCredit("Accounts", 1);
    self:addCredit("OnlineMapCoordinator", 1);
    self:addCredit("Wiki", 6);

    self:addCredit("HeadRaccoon", 1);
    self:addCredit("Localization", 1);

    self:addCredit("VertexBreak", 10);

    self:addCredit("GeneralArcade", 2);

    self:addCredit("TheTeaDivision", 7);

    self:addCredit("FormosaInteractive", 0);
    self:addCredit("SoundSupervisor", 1);
    self:addCredit("TechnicalSoundDesigner", 1);
    self:addCredit("LeadSoundDesigner", 1);
    self:addCredit("SoundDesigner", 5);
    self:addCredit("AssociateSoundDesigner", 2);
    self:addCredit("FormosaSeniorProducer", 1);
    self:addCredit("Producer", 1);
    self:addCredit("InteractiveMusicComposer", 2);

    self:addCredit("DedicatedToTheMemoryOf", 2);

    self:addCredit("SpecialInfected", 63);

    self:addCredit("SpecialThanksTo", 45);

    self:addCredit("AudioEngine", 1);
    self:addCredit("UsesBinkVideo", 1);

end

function MainScreen:new (inGame)
	-- using a virtual 100 height res for doing the UI, so it resizes properly on different rez's.
	MainScreen.StaticHeight = 100;
	MainScreen.StaticWidth = MainScreen.StaticHeight * 1.7777777;
	local o = {}

	--o.data = {}
	o = ISPanelJoypad:new(0, 0, MainScreen.StaticWidth, MainScreen.StaticHeight);
	setmetatable(o, self)
	self.__index = self
	o.x = 0;
	o.y = 0;
	o.backgroundColor = {r=0, g=0, b=0, a=0.0};
	o.borderColor = {r=1, g=1, b=1, a=0.0};

	o.anchorLeft = true;
	o.anchorRight = false;
	o.anchorTop = true;
	o.anchorBottom = false;
    o.warningFadeMax = 10;
    o.warningFade = o.warningFadeMax;
    o.credits = LuaList:new();
    o.creditsIndex = 0;
    o.delay = inGame and -1 or 500 -- milliseconds
    o.firstFrame = false
    o.creditTimeMax = 7;
    o.creditTime = 0;
    o:doCredits();
    o.time = 0;
    o.inGame =inGame;

    useTextureFiltering(true)
    o.logoTexture = getTexture("media/ui/PZ_Logo_New.png")
    useTextureFiltering(false)
 
    MainScreen.instance = o;
    MainScreenInstance = o;
    return o
end

MainScreen.OnTick = function (totalTicks)
	if MainScreen.instance ~= nil then
		MainScreen.instance:update();
	end
end

LoadMainScreenPanel = function ()
    LoadMainScreenPanelInt(false);
end

function isPlayerDoingActionThatCanBeCancelled(playerObj)
	if not playerObj then return false end
	return playerObj:isDoingActionThatCanBeCancelled()
end

function stopDoingActionThatCanBeCancelled(playerObj)
	playerObj:StopAllActionQueue()
end

local function StartPressCancelActionKey(key)
	if not getCore():isKey("CancelAction", key) then return end
	if not MainScreen.instance or not MainScreen.instance.inGame then return end
	if MainScreen.instance:getIsVisible() then return end
	if getCell() and getCell():getDrag(0) then return end
	local playerObj = getSpecificPlayer(0)
	if isPlayerDoingActionThatCanBeCancelled(playerObj) then
		stopDoingActionThatCanBeCancelled(playerObj)
		GameKeyboard.eatKeyPress(key)
	end
end

ToggleEscapeMenu = function (key)
	if (getCore():isKey("Main Menu", key)) or (getCore():getKey("Main Menu") == 0 and key == Keyboard.KEY_ESCAPE) then
        print("EXITDEBUG: ToggleEscapeMenu 1")
		if getCell() and getCell():getDrag(0) then -- if we press escape we first try to remove the dragged item (carpentry for exemple)
            print("EXITDEBUG: ToggleEscapeMenu 2 (getCell.getDrag("..tostring(getCell():getDrag(0)).."))")
            if getCell():getDrag(0).close then
                getCell():getDrag(0):close();
            end
			getCell():setDrag(nil, 0);
		elseif MainScreen.instance ~= nil and MainScreen.instance.inGame == true then
            print("EXITDEBUG: ToggleEscapeMenu 3")
			if MainOptions.instance and MainOptions.instance.modal then return end -- confirm-changes dialog
            print("EXITDEBUG: ToggleEscapeMenu 4")
			ISUIHandler.setVisibleAllUI(MainScreen.instance:isVisible())

			MainScreen.instance:setVisible(not MainScreen.instance:isVisible());

			if MainScreen.instance:isVisible() then
                print("EXITDEBUG: ToggleEscapeMenu 5")
				getSoundManager():playUISound("UIPauseMenuEnter")
				if MainScreen.instance.mainOptions:isVisible() then
					MainScreen.instance.mainOptions:toUI()
				end
				MainScreen.instance:addToUIManager()
				setGameSpeed(0);
				setShowPausedMessage(false);
				JoypadState.saveAllFocus()
				local joypadData = JoypadState.getMainMenuJoypad()
				if joypadData then
					joypadData.inMainMenu = true
					joypadData.focus = MainScreen.instance
				end
				MainScreen.instance:onEnterFromGame()
			else
				getSoundManager():playUISound("UIPauseMenuExit")
                if MainScreen.instance.infoModList then
                    MainScreen.instance.infoModList:destroy()
                    MainScreen.instance.infoModList = nil
                end

                if  MainScreen.instance.infoRichText then
                    MainScreen.instance.infoRichText:setVisible(false);
                end

				MainScreen.instance:removeFromUIManager()
				MainScreen.instance:onReturnToGame()
				setGameSpeed(1);
				setShowPausedMessage(true);
				local joypadData = JoypadState.getMainMenuJoypad()
				if joypadData then
					joypadData.inMainMenu = false
				end
				JoypadState.restoreAllFocus()
			end
		end
   end
end

LoadMainScreenPanelIngame = function ()

    LoadMainScreenPanelInt(true);

end

LoadMainScreenPanelInt = function (ingame)
    local panel2 = MainScreen:new(ingame);
    panel2:initialise();
    panel2:addToUIManager();
    if ingame then
        panel2:setVisible(false);
    end
    panel2:update() -- activate controller on Steam Deck
    local joypadData = JoypadState.getMainMenuJoypad()
    if not ingame and joypadData ~= nil then
        joypadData.focus = MainScreen.instance.animPopup or MainScreen.instance;
        updateJoypadFocus(joypadData);
    end
    if not ingame and not isDemo() then
        local argsServer = getServerAddressFromArgs();
        if argsServer then
			local ss = argsServer:split(":")
			if #ss == 2 then
				local ip = ss[1]
				local port = ss[2]
				MainScreen.instance.bottomPanel:setVisible(false)
				if MainScreen.instance.animPopup ~= nil then
					MainScreen.instance.animPopup:removeFromUIManager()
				end
				if joypadData then
					joypadData.focus = MainScreen.instance
					updateJoypadFocus(joypadData)
				end
				MainScreen.instance.bootstrapConnectPopup:connect(ip, port, getServerPasswordFromArgs())
				return
			end
        end
    end
--CharacterInfoPage.doInfo(SurvivorFactory:CreateSurvivor());


    if getDebug() and not ingame then
        doDebugScenarios();
    end

end



MainScreenPanelJoinSteam = function ()
	if isIngameState() then
		local player = 0
		local modal = ISModalDialog:new(0,0, 250, 150, getText("IGUI_ConfirmLeaveGame"), true, nil, MainScreenPanelJoinSteam_onConfirmLeaveGame, player, player, bed);
		modal:initialise()
		modal:addToUIManager()
		if JoypadState.players[player+1] then
			setJoypadFocus(player, modal)
		end
	else 
		local argsServer = getServerAddressFromArgs();
		if argsServer then
			local ss = argsServer:split(":")
			if #ss == 2 then
				local ip = ss[1]
				local port = ss[2]
				MainScreen.instance.bottomPanel:setVisible(false)
				MainScreen.instance.bootstrapConnectPopup:connect(ip, port, getServerPasswordFromArgs())
			end
		end
	end
end

function MainScreenPanelJoinSteam_onConfirmLeaveGame(this, button, player, bed)
    if button.internal == "YES" then
        setGameSpeed(1);
        pauseSoundAndMusic();
        setShowPausedMessage(true);
        getCore():quit();
    end
end

function MainScreen:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData);
	local uis = {
		{ self.latestSaveOption },
		{ self.loadOption },
        { self.tutorialOption },
		{ self.survivalOption },
		--{ self.onlineOption },
		--{ self.onlineCoopOption },
		{ self.returnOption },
		{ self.scoreOption },
--		{ self.adminPanel },
		{ self.inviteOption },
--		{ self.userPanel },
		{ self.optionsOption },
		{ self.modsOption },
		{ self.workshopOption },
		{ self.exitOption },
		{ self.quitToDesktop },
	}
	for _,ui in ipairs(uis) do
		if ui[1] then
			ui[1]:setJoypadFocused(false)
		end
	end
	table.wipe(self.joypadButtonsY)
	for _,ui in ipairs(uis) do
		if ui[1] and ui[1]:isVisible() then
			table.insert(self.joypadButtonsY, { ui[1] })
		end
	end
    if self.controllerLabel then
        self.controllerLabel:setVisible(false);
        self.abutton:setVisible(false);
        self.controllerLabel2:setVisible(false);
    end
    if self.defaultJoypadOption then
        for k,v in ipairs(self.joypadButtonsY) do
            if v[1] == self.defaultJoypadOption then
                self.joypadIndexY = k
                self.joypadIndex = 1
                self.joypadButtons = self.joypadButtonsY[k]
                self.defaultJoypadOption:setJoypadFocused(true)
                break
            end
        end
    end
    if self.joyfocus and not isIngameState() then
        self.versionDetail:setJoypadButton(Joypad.Texture.XButton)
        self.termsOfService:setJoypadButton(Joypad.Texture.YButton)
    end
end

function MainScreen:onLoseJoypadFocus(joypadData)
	self:clearJoypadFocus(joypadData)
	ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
end

function MainScreen:onJoypadDown(button, joypadData)
    if button == Joypad.AButton and self.joypadButtonsY[self.joypadIndex] then
        MainScreen.onMenuItemMouseDownMainMenu(self.joypadButtons[self.joypadIndex], 0,0);
    end
    if button == Joypad.XButton then
        self.versionDetail:forceClick();
    elseif button == Joypad.YButton then
        self.termsOfService:forceClick();
    end
end

function MainScreen:onJoypadDirUp(joypadData)
	ISPanelJoypad.onJoypadDirUp(self, joypadData)
	self:updateBottomPanelButtons()
end

function MainScreen:onJoypadDirDown(joypadData)
	ISPanelJoypad.onJoypadDirDown(self, joypadData)
	self:updateBottomPanelButtons()
end

function MainScreen.onResetLua(reason)
	local self = MainScreen.instance
	if reason == "joinServer" then
		self.bottomPanel:setVisible(false);
		self.serverList:pingServers(true)
		self.serverList:setVisible(true)
        if DebugScenarios.instance ~= nil then
            MainScreen.instance:removeChild(DebugScenarios.instance)
            DebugScenarios.instance = nil
	    end
	end
	if reason == "continueSave" then
		if DebugScenarios.instance ~= nil then
			MainScreen.instance:removeChild(DebugScenarios.instance)
			DebugScenarios.instance = nil
		end
		MainScreen.continueLatestSaveAux(true)
	end
	if reason == "optionsChangedApplied" then
		self.delay = -1
		MainScreen.onMenuItemMouseDownMainMenu(self.optionsOption, 0, 0)
	end
	if reason == "startTutorial" then
		MainScreen.startTutorial()
	end
end

function MainScreen.onResolutionChange(oldw, oldh, neww, newh)
	print('MainScreen.onResolutionChange '..oldw..'x'..oldh..' -> '..neww..'x'..newh)
	if not MainScreen.instance then return end
	local self = MainScreen.instance
	self:setWidth(neww)
	self:setHeight(newh)
	self:recalcSize()

	local uis = {
        { self.scoreboard, 0.6, 0.7 },
        { self.serverList, 0.7, 0.8 },
        { self.multiplayer, 1.0, 1.0 },
        { self.joinPublicServer, 0.7, 0.8 },
        { self.connectToServer, 0.7, 0.8 },
        { self.onlineCoopScreen, 0.5, 0.6 },
        { self.soloScreen, 0.7, 0.8 },
        { self.loadScreen, 0.7, 0.8 },
        { self.sandOptions, 0.6, 0.8 },
        { self.worldSelect, 0.7, 0.8 },
        { self.mapSpawnSelect, 1, 1 },
        { self.charCreationProfession, 0.7, 0.8 },
        { self.charCreationMain, 0.7, 0.8 },
        { self.inviteFriends, 0.7, 0.8 },
        { self.modSelect, 0.9, 0.9 },
        { self.lastStandPlayerSelect, 0.9, 0.9 },
        { self.mainOptions, 0.7, 0.8 },
        { self.workshopSubmit, 0.9, 0.9 },
        { self.serverWorkshopItem, 0.9, 0.9 },
        { self.serverSettingsScreen, 0.5, 0.8 },
	}

	for _,ui in ipairs(uis) do
		if ui[1] and ui[1].javaObject and instanceof(ui[1].javaObject, 'UIElement') then
			local width = neww * ui[2]
			local height = newh * ui[3]
			if neww <= 1024 then
				width = neww * 0.95
				height = newh * 0.95
			end
			ui[1]:setWidth(width)
			ui[1]:setHeight(height)
			ui[1]:setX((neww - width) / 2)
			ui[1]:setY((newh - height) / 2)
			ui[1]:recalcSize()
		end
	end

	if self.mainOptions then
		self.mainOptions:onResolutionChange(oldw, oldh, neww, newh)
	end
	if self.charCreationMain then
		self.charCreationMain:onResolutionChange(oldw, oldh, neww, newh)
	end
	if self.charCreationProfession then
		self.charCreationProfession:onResolutionChange(oldw, oldh, neww, newh)
	end
	if self.mapSpawnSelect then
		self.mapSpawnSelect:onResolutionChange(oldw, oldh, neww, newh)
	end
	if self.worldSelect then
		self.worldSelect:onResolutionChange(oldw, oldh, neww, newh)
	end
	if self.modSelect then
		self.modSelect:onResolutionChange(oldw, oldh, neww, newh)
	end
	if self.sandOptions then
		self.sandOptions:onResolutionChange(oldw, oldh, neww, newh)
	end
	if self.soloScreen then
		self.soloScreen:onResolutionChange(oldw, oldh, neww, newh)
    end
    if self.loadScreen then
        self.loadScreen:onResolutionChange(oldw, oldh, neww, newh)
    end
	if self.serverSettingsScreen then
		self.serverSettingsScreen:onResolutionChange(oldw, oldh, neww, newh)
	end
    if self.serverList then
        self.serverList:onResolutionChange(oldw, oldh, neww, newh)
    end
    if self.joinPublicServer then
		self.joinPublicServer:onResolutionChange(oldw, oldh, neww, newh)
    end
    if self.multiplayer then
        self.multiplayer:onResolutionChange(oldw, oldh, neww, newh)
    end
    if self.onlineCoopScreen then
        self.onlineCoopScreen:onResolutionChange(oldw, oldh, neww, newh)
    end
	if DebugScenarios.instance ~= nil then
		DebugScenarios.instance:onResolutionChange(oldw, oldh, neww, newh)
	end
	if self.animPopup ~= nil then
		self.animPopup:setX(neww/2-350)
		self.animPopup:setY(newh/2-300)
	end
end

function MainScreen:showInviteFailDialog(message)
	local w,h = 350,120
	local modal = ISModalDialog:new((getCore():getScreenWidth() / 2) - w / 2,
		(getCore():getScreenHeight() / 2) - h / 2, w, h,
		getText(message), false, self, self.onInviteFailDialogButton);
	modal:initialise()
	modal:setCapture(true)
	modal:setAlwaysOnTop(true)
	modal:addToUIManager()
	local joypadData = JoypadState.getMainMenuJoypad()
	if joypadData then
		modal.param1 = joypadData.focus
		joypadData.focus = modal
		updateJoypadFocus(joypadData)
	end
end

function MainScreen:onInviteFailDialogButton(button, focus)
	local joypadData = JoypadState.getMainMenuJoypad()
	if joypadData then
		joypadData.focus = focus
		updateJoypadFocus(joypadData)
	end
end

function MainScreen.onAcceptInvite(connectionString)
	if MainScreen.instance.inGame then
		MainScreen.instance:showInviteFailDialog(getText("UI_mainscreen_InviteInGame"))
		return
	end
	if not MainScreen.instance.bottomPanel:getIsVisible() then
		MainScreen.instance:showInviteFailDialog(getText("UI_mainscreen_InviteMainMenu"))
		return
	end
	local ss = string.gsub(connectionString:gsub('"', ""), "+connect ", ""):split(":")
	if #ss == 2 then
		local ip = ss[1]
		local port = ss[2]
		MainScreen.instance.bottomPanel:setVisible(false)
		BootstrapConnectPopup.instance:connect(ip, port, "")
	else
        MainScreen.instance:showInviteFailDialog(getText("UI_mainscreen_InviteFormat", connectionString))
    end
end

function MainScreen:getAllUIs()
	return {
		self.animPopup,
		self.scoreboard,
		self.serverList,
		self.multiplayer,
		self.joinPublicServer,
		self.onlineCoopScreen,
		self.soloScreen,
		self.loadScreen,
		self.sandOptions,
		self.worldSelect,
		self.mapSpawnSelect,
		self.charCreationProfession,
		self.charCreationMain,
		self.inviteFriends,
		self.modSelect,
		self.lastStandPlayerSelect,
		self.mainOptions,
		self.mainOptions.gameSounds,
		self.workshopSubmit,
		self.serverWorkshopItem,
		self.serverSettingsScreen
	}
end

function MainScreen.OnJoypadBeforeDeactivate(index)
	local self = MainScreen.instance
	if not self then return end
	if self.joyfocus and self.joyfocus.id == index then
		
	end
	if CoopCharacterCreation.instance then
		CoopCharacterCreation.instance:OnJoypadBeforeDeactivate(index)
	end
end

function MainScreen:getCurrentFocusForController()
	if self.animPopup and self.animPopup:isReallyVisible() then
		return self.animPopup
	end
	if self.bottomPanel:isVisible() then
		return self
	end
	local uis = self:getAllUIs()
	for _,ui in pairs(uis) do
		if ui:isReallyVisible() then
			if ui.getCurrentFocusForController then
				return ui:getCurrentFocusForController()
			end
			return ui
		end
	end
	return nil
end

Events.OnResolutionChange.Add(MainScreen.onResolutionChange)

Events.OnMainMenuEnter.Add(LoadMainScreenPanel);

Events.OnGameStart.Add(LoadMainScreenPanelIngame);

--Events.OnTick.Add(MainScreen.OnTick);
print("EXITDEBUG: MainScreen: Events.OnKeyPressed.Add(ToggleEscapeMenu)")
Events.OnKeyPressed.Add(ToggleEscapeMenu);
Events.OnKeyStartPressed.Add(StartPressCancelActionKey);

Events.OnResetLua.Add(MainScreen.onResetLua);

Events.OnAcceptInvite.Add(MainScreen.onAcceptInvite);

Events.OnSteamGameJoin.Add(MainScreenPanelJoinSteam);

Events.OnJoypadBeforeDeactivate.Add(MainScreen.OnJoypadBeforeDeactivate);
