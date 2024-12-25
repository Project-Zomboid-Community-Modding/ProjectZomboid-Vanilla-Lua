--***********************************************************
--**                   ROBERT JOHNSON                      **
--***********************************************************

require "ISUI/ISPanel"
require "ISUI/ISButton"
require "ISUI/ISInventoryPane"
require "ISUI/ISResizeWidget"
require "ISUI/ISMouseDrag"

require "defines"

CharacterCreationHeader = ISPanel:derive("CharacterCreationHeader");
local AvatarPanel = ISPanel:derive("CharacterCreationAvatar")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

function AvatarPanel:createChildren()
	self.avatarBackgroundTexture = getTexture("media/ui/avatarBackgroundWhite.png")

	self.avatarPanel = ISUI3DModel:new(0, 0, self.width, self.height - UI_BORDER_SPACING - BUTTON_HGT - 4)
	self.avatarPanel.backgroundColor = {r=0, g=0, b=0, a=0.0}
	self.avatarPanel.borderColor = {r=1, g=1, b=1, a=0.0}
	self:addChild(self.avatarPanel)
	CharacterCreationHeader.instance:randomGenericOutfit()
	self.avatarPanel:setState("idle")
	self.avatarPanel:setDirection(IsoDirections.S)
	self.avatarPanel:setIsometric(false)
	self.avatarPanel:setDoRandomExtAnimations(true)

	self.turnLeftButton = ISButton:new(self.avatarPanel.x, self.avatarPanel:getBottom()-15, 15, 15, "", self, self.onTurnChar)
	self.turnLeftButton.internal = "TURNCHARACTERLEFT"
	self.turnLeftButton:initialise()
	self.turnLeftButton:instantiate()
	self.turnLeftButton:setImage(getTexture("media/ui/ArrowLeft.png"))
	self:addChild(self.turnLeftButton)

	self.turnRightButton = ISButton:new(self.avatarPanel:getRight()-15, self.avatarPanel:getBottom()-15, 15, 15, "", self, self.onTurnChar)
	self.turnRightButton.internal = "TURNCHARACTERRIGHT"
	self.turnRightButton:initialise()
	self.turnRightButton:instantiate()
	self.turnRightButton:setImage(getTexture("media/ui/ArrowRight.png"))
	self:addChild(self.turnRightButton)

	self.animCombo = ISComboBox:new(-2, self.avatarPanel:getBottom() + UI_BORDER_SPACING+2, self.width+4, BUTTON_HGT, self, self.onAnimSelected)
	self.animCombo:initialise()
	self:addChild(self.animCombo)
	self.animCombo.pointOnItem = function(_self, _index)
		CharacterCreationHeader.instance.avatarPanel:setFacePreview(false)
	end
	self.animCombo:addOptionWithData(getText("IGUI_anim_Idle"), "EventIdle")
	self.animCombo:addOptionWithData(getText("IGUI_anim_Walk"), "EventWalk")
	self.animCombo:addOptionWithData(getText("IGUI_anim_Run"), "EventRun")
	self.animCombo.selected = 1
end

function AvatarPanel:prerender()
	ISPanel.prerender(self)
	self:drawRectBorder(self.avatarPanel.x - 2, self.avatarPanel.y - 2, self.avatarPanel.width + 4, self.avatarPanel.height + 4, 1, 0.3, 0.3, 0.3);
	self:drawTextureScaled(self.avatarBackgroundTexture, self.avatarPanel.x, self.avatarPanel.y, self.avatarPanel.width, self.avatarPanel.height, 1, 0.4, 0.4, 0.4);
end

function AvatarPanel:onTurnChar(button, x, y)
	local direction = self.avatarPanel:getDirection()
	if button.internal == "TURNCHARACTERLEFT" then
		direction = IsoDirections.RotLeft(direction)
		self.avatarPanel:setDirection(direction)
	elseif button.internal == "TURNCHARACTERRIGHT" then
		direction = IsoDirections.RotRight(direction)
		self.avatarPanel:setDirection(direction)
	end
end

function AvatarPanel:onAnimSelected(combo)
--	self.avatarPanel:setState(combo:getOptionData(combo.selected))
	self.avatarPanel:reportEvent(combo:getOptionData(combo.selected))
end

function AvatarPanel:setCharacter(character)
	self.avatarPanel:setCharacter(character)
end

function AvatarPanel:setSurvivorDesc(survivorDesc)
	self.avatarPanel:setSurvivorDesc(survivorDesc)
end

function AvatarPanel:setFacePreview(val)
	if val then
		self.avatarPanel:setZoom(14)
		self.avatarPanel:setYOffset(-0.85)
	else
		self.avatarPanel:setZoom(1)
		self.avatarPanel:setYOffset(0)
	end
end

function AvatarPanel:new(x, y, width, height)
	local o = ISPanel:new(x, y, width, height)
	setmetatable(o, self)
	self.__index = self
	o.direction = IsoDirections.E
	return o
end

-----

function CharacterCreationHeader:initialise()
	ISPanel.initialise(self);
end
--************************************************************************--
--** ISPanel:instantiate
--**
--************************************************************************--
function CharacterCreationHeader:instantiate()
	self.javaObject = UIElement.new(self);
	self.javaObject:setX(self.x);
	self.javaObject:setY(self.y);
	self.javaObject:setHeight(self.height);
	self.javaObject:setWidth(self.width);
	self.javaObject:setAnchorLeft(self.anchorLeft);
	self.javaObject:setAnchorRight(self.anchorRight);
	self.javaObject:setAnchorTop(self.anchorTop);
	self.javaObject:setAnchorBottom(self.anchorBottom);
end

function CharacterCreationHeader:create()
	self.avatarPanel = AvatarPanel:new(0, 0, 128, 260 + UI_BORDER_SPACING + BUTTON_HGT)
	self.avatarPanel:noBackground()
	self:addChild(self.avatarPanel)

	-- all of these are to ensure that no text ends up behind the character portrait
	local labelMaxWid = math.max(
			getTextManager():MeasureStringX(UIFont.Medium, getText("UI_characreation_forename")),
			getTextManager():MeasureStringX(UIFont.Medium, getText("UI_characreation_surname")),
			getTextManager():MeasureStringX(UIFont.Small, getText("UI_SkinColor")),
			getTextManager():MeasureStringX(UIFont.Small, getText("UI_ChestHair")),
			getTextManager():MeasureStringX(UIFont.Small, getText("UI_characreation_voicetype")),
			getTextManager():MeasureStringX(UIFont.Small, getText("UI_characreation_voicepitch")),
			getTextManager():MeasureStringX(UIFont.Small, getText("UI_characreation_hairtype")),
			getTextManager():MeasureStringX(UIFont.Small, getText("UI_characreation_color")),
			getTextManager():MeasureStringX(UIFont.Small, getText("UI_Stubble")),
			getTextManager():MeasureStringX(UIFont.Small, getText("UI_characreation_beardtype"))
	)
	local entryX = self.avatarPanel:getRight() + UI_BORDER_SPACING*2 + labelMaxWid+2

	-- name/surname/sex btn
	self.forenameEntry = ISTextEntryBox:new(MainScreen.instance.desc:getForename(), entryX, 0, 200, BUTTON_HGT);
	self.forenameEntry:initialise();
	self.forenameEntry:instantiate();

--	self.forenameEntry:setAnchorRight(true);
	self:addChild(self.forenameEntry);

	self.surnameEntry = ISTextEntryBox:new(MainScreen.instance.desc:getSurname(), entryX, self.forenameEntry:getBottom() + UI_BORDER_SPACING, 200, BUTTON_HGT);
	self.surnameEntry:initialise();
	self.surnameEntry:instantiate();

--	self.surnameEntry:setAnchorRight(true);
	self:addChild(self.surnameEntry);
	
	self.genderCombo = ISComboBox:new(entryX, self.surnameEntry:getBottom() + UI_BORDER_SPACING, 200, BUTTON_HGT, self, CharacterCreationHeader.onGenderSelected);
	self.genderCombo:initialise();
	self.genderCombo.pointOnItem = function(_self, _index)
		CharacterCreationHeader.instance.avatarPanel:setFacePreview(false)
	end
	--	self.chestHairCombo:instantiate();
	self.genderCombo:addOption(getText("IGUI_char_Female"))
	self.genderCombo:addOption(getText("IGUI_char_Male"))
	self.genderCombo.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
	self:addChild(self.genderCombo)

--	self.femaleButton = ISButton:new(entryX, self.surnameEntry:getBottom() + 8 + (entryHgt - 18) / 2, 18, 18, "F", self, CharacterCreationHeader.onOptionMouseDown);
--	self.femaleButton.internal = "FEMALE";
--	self.femaleButton:initialise();
--	self.femaleButton:instantiate();
--
--	self.femaleButton.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
--	self:addChild(self.femaleButton);
--	self.femaleButton.image = self.femaletex;

--	self.maleButton = ISButton:new(entryX + 22, self.femaleButton:getY(), 18, 18, "M", self, CharacterCreationHeader.onOptionMouseDown);
--	self.maleButton.internal = "MALE";
--	self.maleButton:initialise();
--	self.maleButton:instantiate();
--
--	self.maleButton.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
--	self:addChild(self.maleButton);
--	self.maleButton.image = self.maletex;

	if MainScreen.instance.avatar == nil then
		self:createAvatar();
		CharacterCreationProfession.instance:changeClothes();
	end

	self:disableBtn();
end

function CharacterCreationHeader:onGenderSelected(combo)
	if combo.selected == 1 then
		MainScreen.instance.avatar:setFemale(true);
		MainScreen.instance.desc:setFemale(true);
		MainScreen.instance.desc:getHumanVisual():removeBodyVisualFromItemType("Base.M_Hair_Stubble")
		MainScreen.instance.desc:getHumanVisual():removeBodyVisualFromItemType("Base.M_Beard_Stubble")
	else
		MainScreen.instance.avatar:setFemale(false);
		MainScreen.instance.desc:setFemale(false);
		MainScreen.instance.desc:getHumanVisual():removeBodyVisualFromItemType("Base.F_Hair_Stubble")
	end
	self:randomGenericOutfit()
	self:setAvatarFromUI()
	CharacterCreationProfession.instance:changeClothes();

	-- we random the name
	SurvivorFactory.randomName(MainScreen.instance.desc);

	self.forenameEntry:setText(MainScreen.instance.desc:getForename());
	self.surnameEntry:setText(MainScreen.instance.desc:getSurname());

	self:randomVoice();

	CharacterCreationMain.instance:loadJoypadButtons();
end

function CharacterCreationHeader:randomVoice()
	local bodyType = 2;
	if MainScreen.instance.desc:isFemale() then
		bodyType = 1;
	end;
	local voiceStyle;
	local choices = {};
	local voiceTypeCombo = CharacterCreationMain.instance.voiceTypeCombo;
	if voiceTypeCombo then
		for i in ipairs(voiceTypeCombo.options) do
			voiceStyle = voiceTypeCombo:getOptionData(i);
			if voiceStyle and (voiceStyle:getBodyTypeDefault() == bodyType) then
				table.insert(choices, i);
			end;
		end;
		voiceTypeCombo.selected = choices[ZombRand(#choices) + 1];
	end;
end

function CharacterCreationHeader:randomGenericOutfit()
	local desc = MainScreen.instance.desc;
--	local randomOutfit = "Generic0" .. ZombRand(5) + 1;
--	if ZombRand(6) == 0 and MainScreen.instance.desc:isFemale() then
--		randomOutfit = "Generic_Skirt";
--	end
--	desc:dressInNamedOutfit(randomOutfit)
--	self.avatarPanel:setSurvivorDesc(desc)

	local default = ClothingSelectionDefinitions.default;
	if MainScreen.instance.desc:isFemale() then
		self:dressWithDefinitions(default.Female, true);
	else
		self:dressWithDefinitions(default.Male, true);
	end
	
	local profession = ClothingSelectionDefinitions[desc:getProfession()];
	if profession then
		if MainScreen.instance.desc:isFemale() then
			self:dressWithDefinitions(profession.Female, false);
		else
			if profession.Male then -- most of the time there's no diff between male/female outfit, so i didn't created them both
				self:dressWithDefinitions(profession.Male, false);
			else
				self:dressWithDefinitions(profession.Female, false);
			end
		end
	end

    if CharacterCreationProfession.instance.listboxTraitSelected and CharacterCreationProfession.instance.listboxTraitSelected.items then
        local traits = CharacterCreationProfession.instance.listboxTraitSelected.items
        for i, v in pairs(traits) do
            if v then
                local trait = v.item:getType()
                if TraitClothingSelectionDefinitions[trait] then
                    local definition = TraitClothingSelectionDefinitions[trait]
                    if MainScreen.instance.desc:isFemale() then
                        self:dressWithDefinitions(definition.Female, false);
                    else
                        if definition.Male then -- most of the time there's no diff between male/female outfit, so i didn't created them both
                            self:dressWithDefinitions(definition.Male, false);
                        else
                            self:dressWithDefinitions(definition.Female, false);
                        end
                    end
                end
            end
        end
    end

	self.avatarPanel:setSurvivorDesc(desc)
	CharacterCreationHeader.instance.avatarPanel:setSurvivorDesc(desc)
	if CharacterCreationMain.instance:shouldShowAllOutfits() then
		CharacterCreationMain.instance:initClothingDebug()
	else
		CharacterCreationMain.instance:initClothing()
	end
	CharacterCreationMain.instance:disableBtn()
end

-- dress randomly according to the table definition given
function CharacterCreationHeader:dressWithDefinitions(definition, resetWornItems)
	local desc = MainScreen.instance.desc;
	if resetWornItems then
		desc:getWornItems():clear();
	end
	for bodyLocation, profTable in pairs(definition) do
		local chance = profTable.chance;
		if not chance or ZombRand(100) < chance then
			desc:setWornItem(bodyLocation, nil);
			local items = profTable.items;
			local itemType = items[ZombRand(0, #items)+1];
			if itemType then
				local item = instanceItem(itemType)
				if item then
					desc:setWornItem(bodyLocation, item)
				end
			end
		end
	end
end

function CharacterCreationHeader:onOptionMouseDown(button, x, y)
	-- remove the beard
	MainScreen.instance.desc:getExtras():clear()
	if button.internal == "RANDOM" then
		local female = ZombRand(2) == 0
		MainScreen.instance.avatar:setFemale(female)
		MainScreen.instance.desc:setFemale(female)
		MainScreen.instance.desc:getHumanVisual():clear()
		self:setAvatarFromUI()
--		CharacterCreationProfession.instance:changeClothes();
		self:randomGenericOutfit();
		self:randomVoice();
	end

	-- we random the name
	SurvivorFactory.randomName(MainScreen.instance.desc);

	self.forenameEntry:setText(MainScreen.instance.desc:getForename());
	self.surnameEntry:setText(MainScreen.instance.desc:getSurname());

    CharacterCreationMain.instance:loadJoypadButtons();

	self:disableBtn();
end

function CharacterCreationHeader:disableBtn()
--    self.femaleButton:setEnable(true);
--    self.maleButton:setEnable(true);
    -- sex btn disable
	if MainScreen.instance.desc:isFemale() then
		self.genderCombo.selected = 1;
--        self.femaleButton:setEnable(false);
--        self.femaleButton.textureColor.r = 1;
--        self.femaleButton.textureColor.g = 1;
--        self.femaleButton.textureColor.b = 1;
--        self.maleButton.textureColor.r = 0.3;
--        self.maleButton.textureColor.g = 0.3;
--        self.maleButton.textureColor.b = 0.3;
--        self.femaleButton.borderColor.a = 0.7;
--        self.femaleButton.borderColor.r = 0.1;
--        self.femaleButton.borderColor.g = 0.1;
--        self.femaleButton.borderColor.b = 0.1;
--        self.maleButton.borderColor.a = 1;
--        self.maleButton.borderColor.r = 1;
--        self.maleButton.borderColor.g = 1;
--        self.maleButton.borderColor.b = 1;
	else
		self.genderCombo.selected = 2;
--        self.maleButton:setEnable(false);
----        self.maleButton.textureColor.r = 1;
----        self.maleButton.textureColor.g = 1;
----        self.maleButton.textureColor.b = 1;
----        self.femaleButton.textureColor.r = 0.3;
----        self.femaleButton.textureColor.g = 0.3;
----        self.femaleButton.textureColor.b = 0.3;
--        self.maleButton.borderColor.a = 0.7;
--        self.maleButton.borderColor.r = 0.1;
--        self.maleButton.borderColor.g = 0.1;
--        self.maleButton.borderColor.b = 0.1;
--        self.femaleButton.borderColor.a = 1;
--        self.femaleButton.borderColor.r = 1;
--        self.femaleButton.borderColor.g = 1;
--        self.femaleButton.borderColor.b = 1;
	end

	CharacterCreationMain.instance:disableBtn();
end

function CharacterCreationHeader:createAvatar()
	if not MainScreen.instance.desc then
		MainScreen.instance.desc = SurvivorFactory.CreateSurvivor();
	end
	MainScreen.instance.avatar = IsoSurvivor.new(MainScreen.instance.desc, nil, 0, 0, 0);

	self:setAvatarFromUI()
end

function CharacterCreationHeader:setAvatarFromUI()
	self.avatarPanel.avatarPanel:setSurvivorDesc(MainScreen.instance.desc)
end

function CharacterCreationHeader:initPlayer()
	MainScreen.instance.desc:setForename(self.forenameEntry:getText());
	MainScreen.instance.desc:setSurname(self.surnameEntry:getText());
end

function CharacterCreationHeader:prerender()
	ISPanel.prerender(self);
end

function CharacterCreationHeader:render()
	local textX = self.forenameEntry:getX() - UI_BORDER_SPACING
	self:drawTextRight(getText("UI_characreation_forename"), textX, self.forenameEntry:getY(), 1, 1, 1, 1, UIFont.Medium);
	self:drawTextRight(getText("UI_characreation_surname"), textX, self.surnameEntry:getY(), 1, 1, 1, 1, UIFont.Medium);
--	self:drawTextRight(getText("UI_characreation_gender"), textX, self.surnameEntry:getBottom() + 8, 1, 1, 1, 1, UIFont.Medium);
end

function CharacterCreationHeader:new (x, y, width, height)
	local o = {};
	o = ISPanel:new(x, y, width, height);
	setmetatable(o, self)
	self.__index = self
	o.x = x;
	o.y = y;
	o.backgroundColor = {r=0, g=0, b=0, a=0.0};
	o.borderColor = {r=1, g=1, b=1, a=0.0};
	o.itemheightoverride = {};
	o.anchorLeft = true;
	o.anchorRight = false;
	o.anchorTop = true;
	o.anchorBottom = false;
	CharacterCreationHeader.instance = o;
	return o
end
