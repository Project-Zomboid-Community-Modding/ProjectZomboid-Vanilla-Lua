--***********************************************************
--**                   ROBERT JOHNSON                      **
--***********************************************************

require "ISUI/ISPanel"
require "ISUI/ISButton"
require "ISUI/ISInventoryPane"
require "ISUI/ISResizeWidget"
require "ISUI/ISMouseDrag"

require "defines"

CharacterCreationMain = ISPanelJoypad:derive("CharacterCreationMain");
CharacterCreationMain.savefile = "saved_outfits.txt";

CharacterCreationMainCharacterPanel = ISPanelJoypad:derive("CharacterCreationMainCharacterPanel")
CharacterCreationMainPresetPanel = ISPanelJoypad:derive("CharacterCreationMainPresetPanel")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local FONT_HGT_TITLE = getTextManager():getFontHeight(UIFont.Title)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local JOYPAD_TEX_SIZE = 32

-- -- -- -- --
-- -- -- -- --
-- -- -- -- --

function CharacterCreationMainCharacterPanel:prerender()
	ISPanelJoypad.prerender(self)
	self:setStencilRect(0, 0, self.width, self.height)
end

function CharacterCreationMainCharacterPanel:render()
	ISPanelJoypad.render(self)
	self:clearStencilRect()
	self:renderJoypadFocus(-3, -3, self.width + 6, self.height + 6)
end

function CharacterCreationMainCharacterPanel:positionRelativeToScrollBar()
	if self.scrollBar ~= self:isVScrollBarVisible() then
		self.scrollBar = self:isVScrollBarVisible()
	end

	local multiplier = (self.scrollBar and 1 or 0) * (UI_BORDER_SPACING + 13) --13 is scroll bar width
	local maxWidth = self.columnWidth + 300 + UI_BORDER_SPACING
	local xOffset = math.max(self.width - maxWidth, 0)

	for _,v in pairs(self.reposTable) do ---section headers
		v:setX(xOffset)
	end

	for _,v in pairs(self.repos2Table) do ---control titles
		v:setX(xOffset + self.columnWidth - v:getWidth())
	end

	for _,v in pairs(self.repos3Table) do ---controls
		v:setX(xOffset + self.columnWidth + UI_BORDER_SPACING)
	end

	for _,v in pairs(self.dividerResizeTable) do ---dividers
		v:setWidth(math.min(self.width, maxWidth) - multiplier)
		v:setX(xOffset)
	end

	for _,v in pairs(self.comboResizeTable) do ---combo boxes and slider bar
		v:setWidth(math.min(300, self.width - self.columnWidth - UI_BORDER_SPACING) - multiplier)
	end
end

function CharacterCreationMainCharacterPanel:onGainJoypadFocus(joypadData)
	ISPanelJoypad.onGainJoypadFocus(self, joypadData)
	self.joypadIndex = 1
	if self.prevJoypadIndexY ~= -1 then
		self.joypadIndexY = math.min(self.prevJoypadIndexY, #self.joypadButtonsY)
	else
		self.joypadIndexY = 1
	end
	self.joypadButtons = self.joypadButtonsY[self.joypadIndexY]
	self.joypadButtons[self.joypadIndex]:setJoypadFocused(true)
end

function CharacterCreationMainCharacterPanel:onLoseJoypadFocus(joypadData)
	self.prevJoypadIndexY = self.joypadIndexY
	self:clearJoypadFocus(joypadData)
	ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
end

function CharacterCreationMainCharacterPanel:onJoypadDown(button, joypadData)
	if button == Joypad.BButton and not self:isFocusOnControl() then
		joypadData.focus = self.parent
		updateJoypadFocus(joypadData)
	else
		ISPanelJoypad.onJoypadDown(self, button, joypadData)
	end
end

function CharacterCreationMainCharacterPanel:onJoypadDirRight(joypadData)
	local children = self:getVisibleChildren(self.joypadIndexY)
	local child = children[self.joypadIndex]
	if child and child.isSlider then
		ISPanelJoypad.onJoypadDirRight(self, joypadData)
	end
end

function CharacterCreationMainCharacterPanel:onMouseWheel(del)
	self:setYScroll(self:getYScroll() - del * 40)
end

function CharacterCreationMainCharacterPanel:new(x, y, width, height)
	local o = ISPanelJoypad.new(self, x, y, width, height)
	self.prevJoypadIndexY = -1
	o.scrollBar = false;
	o.columnWidth = 10
	o.reposTable = {}
	o.repos2Table = {}
	o.repos3Table = {}
	o.comboResizeTable = {}
	o.dividerResizeTable = {}
	o.columnWidth = 0
	return o
end

-- -- -- -- --
-- -- -- -- --
-- -- -- -- --

function CharacterCreationMainPresetPanel:render()
	ISPanelJoypad.render(self)
	if self.joyfocus then
		self:drawRectBorder(0 - 4, 0 - 4, self:getWidth() + 4 + 4, self:getHeight() + 4 + 4, 0.4, 0.2, 1.0, 1.0)
		self:drawRectBorder(0 - 3, 0 - 3, self:getWidth() + 3 + 3, self:getHeight() + 3 + 3, 0.4, 0.2, 1.0, 1.0)
	end
end

function CharacterCreationMainPresetPanel:onGainJoypadFocus(joypadData)
	ISPanelJoypad.onGainJoypadFocus(self, joypadData)
	if self.joypadButtons[self.joypadIndex] then
		self.joypadButtons[self.joypadIndex]:setJoypadFocused(true, joypadData)
	end
end

function CharacterCreationMainPresetPanel:onLoseJoypadFocus(joypadData)
	ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
	self:clearJoypadFocus(joypadData)
end

function CharacterCreationMainPresetPanel:onJoypadDown(button, joypadData)
	if button == Joypad.BButton and not self:isFocusOnControl() then
		self:clearJoypadFocus(joypadData)
		joypadData.focus = self.parent
		updateJoypadFocus(joypadData)
	else
		ISPanelJoypad.onJoypadDown(self, button, joypadData)
	end
end

function CharacterCreationMainPresetPanel:onJoypadDirUp(joypadData)
	if self:isFocusOnControl() then
		ISPanelJoypad.onJoypadDirUp(self, joypadData)
	else
		joypadData.focus = self.parent.characterPanel
		updateJoypadFocus(joypadData)
	end
end

-- -- -- -- --
-- -- -- -- --
-- -- -- -- --

function CharacterCreationMain:initialise()
	ISPanelJoypad.initialise(self);
end

--************************************************************************--
--** ISPanel:instantiate
--**
--************************************************************************--
function CharacterCreationMain:instantiate()
	
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
	self:createChildren();
end

function CharacterCreationMain:create()
	local x = UI_BORDER_SPACING + 1
	local y = UI_BORDER_SPACING + FONT_HGT_TITLE + x
	local w = self.width - x*2
	local h = self.height - y - BUTTON_HGT - UI_BORDER_SPACING - x

	self.avatarPanel = CharacterCreationAvatar:new(0, 0, 128, 260)
	self.avatarPanel:noBackground()
	self:addChild(self.avatarPanel)
	if MainScreen.instance.avatar == nil then
		self:createAvatar();
    end
	self:rescaleAvatarViewer()

	self.characterPanel = CharacterCreationMainCharacterPanel:new(x, y, self.avatarPanel:getX() - x - UI_BORDER_SPACING, h)
	self.characterPanel:noBackground()
	self.characterPanel:setAnchorBottom(true);
	self.characterPanel:setAnchorTop(true);
	self.characterPanel:addScrollBars()
	self.characterPanel:setScrollChildren(true)
	self:addChild(self.characterPanel)

	self.columnWidth = math.max(
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
	self.characterPanel.columnWidth = self.columnWidth
	self.yOffset = 0;
	self.clothingTextureComboWidth = UI_BORDER_SPACING*4 + getTextManager():MeasureStringX(UIFont.Small, getText("UI_characreation_Type").." " .. (9))

	self.characterPanel.columnWidth = self.columnWidth
	self:createNameAndGender();

	-- BODY TYPE SELECTION
	self:createBodyTypeBtn();

	-- VOICE TYPE SELECTION
	self:createVoiceTypeBtn();

	-- HAIR TYPE SELECTION
	self:createHairTypeBtn();
	self:createBeardTypeBtn();

	-- CLOTHING
	self.yOffset = y
	self:createClothingBtn();

	-- BOTTOM BUTTON
	local btnPadding = JOYPAD_TEX_SIZE + UI_BORDER_SPACING*2
	local btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_btn_back"))
	self.backButton = ISButton:new(UI_BORDER_SPACING+1, self.height - UI_BORDER_SPACING - BUTTON_HGT - 1, btnWidth, BUTTON_HGT, getText("UI_btn_back"), self, self.onOptionMouseDown);
	self.backButton.internal = "BACK";
	self.backButton:initialise();
	self.backButton:instantiate();
	self.backButton:setAnchorLeft(true);
	self.backButton:setAnchorTop(false);
	self.backButton:setAnchorBottom(true);
	self.backButton:enableCancelColor()
--	self.backButton.setJoypadFocused = self.setJoypadFocusedBButton
	self:addChild(self.backButton);

	self.presetPanel = CharacterCreationMainPresetPanel:new(self.backButton:getRight() + UI_BORDER_SPACING, self.backButton.y, 100, BUTTON_HGT)
	self.presetPanel:noBackground()
	self.presetPanel:setAnchorTop(false)
	self.presetPanel:setAnchorBottom(true)
	self:addChild(self.presetPanel)

	self.savedBuilds = ISComboBox:new(0, 0, 250, BUTTON_HGT, self, CharacterCreationMain.loadOutfit);
	self.savedBuilds:setAnchorTop(false);
	self.savedBuilds:setAnchorBottom(true);
	self.savedBuilds.openUpwards = true;
	self.presetPanel:addChild(self.savedBuilds)

	self.savedBuilds.noSelectionText = getText("UI_characreation_SelectToLoad")
	local saved_builds = CharacterCreationMain.readSavedOutfitFile();
	for key,val in pairs(saved_builds) do
		self.savedBuilds:addOption(key)
	end
    self.savedBuilds.selected = 0 -- no selection

	self.saveBuildButton = ISButton:new(self.savedBuilds:getRight() + UI_BORDER_SPACING, self.savedBuilds.y, 50, BUTTON_HGT, getText("UI_characreation_BuildSave"), self, self.saveBuildStep1);
	self.saveBuildButton:initialise();
	self.saveBuildButton:instantiate();
	self.saveBuildButton:setAnchorLeft(true);
	self.saveBuildButton:setAnchorRight(false);
	self.saveBuildButton:setAnchorTop(false);
	self.saveBuildButton:setAnchorBottom(true);
	self.saveBuildButton:enableAcceptColor()
	self.presetPanel:addChild(self.saveBuildButton);

	self.deleteBuildButton = ISButton:new(self.saveBuildButton:getRight() + UI_BORDER_SPACING, self.saveBuildButton:getY(), 50, BUTTON_HGT, getText("UI_characreation_BuildDel"), self, self.deleteBuildStep1);
	self.deleteBuildButton:initialise();
	self.deleteBuildButton:instantiate();
	self.deleteBuildButton:setAnchorLeft(true);
	self.deleteBuildButton:setAnchorRight(false);
	self.deleteBuildButton:setAnchorTop(false);
	self.deleteBuildButton:setAnchorBottom(true);
	self.deleteBuildButton:enableCancelColor()
	self.presetPanel:addChild(self.deleteBuildButton);

	self.presetPanel:setWidth(self.deleteBuildButton:getRight())
	self.presetPanel:insertNewLineOfButtons(self.savedBuilds, self.saveBuildButton, self.deleteBuildButton)
	self.presetPanel.joypadIndex = 1
	self.presetPanel.joypadIndexY = 1

	btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_btn_play"))
	self.playButton = ISButton:new(self.width - btnWidth - UI_BORDER_SPACING - 1, self.backButton.y, btnWidth, BUTTON_HGT, getText("UI_btn_play"), self, self.onOptionMouseDown);
	self.playButton.internal = "NEXT";
	self.playButton:initialise();
	self.playButton:instantiate();
	self.playButton:setAnchorLeft(false);
	self.playButton:setAnchorRight(true);
	self.playButton:setAnchorTop(false);
	self.playButton:setAnchorBottom(true);
	self.playButton:setEnable(true); -- sets the hard-coded border color
--	self.playButton.setJoypadFocused = self.setJoypadFocusedAButton
	self.playButton:setSound("activate", "UIActivatePlayButton")
	self.playButton:enableAcceptColor()
	self:addChild(self.playButton);

	btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_characreation_random"))
	self.randomButton = ISButton:new(self.playButton:getX() - UI_BORDER_SPACING - btnWidth, self.backButton.y, btnWidth, BUTTON_HGT, getText("UI_characreation_random"), self, self.onOptionMouseDown);
	self.randomButton.internal = "RANDOM";
	self.randomButton:initialise();
	self.randomButton:instantiate();
	self.randomButton:setAnchorLeft(false);
	self.randomButton:setAnchorRight(true);
	self.randomButton:setAnchorTop(false);
	self.randomButton:setAnchorBottom(true);
--	self.backButton.setJoypadFocused = self.setJoypadFocusedYButton
	self:addChild(self.randomButton);

	-- DISABLE BUTTON
	self:disableBtn();
end

function CharacterCreationMain:deleteBuildStep1()
	local delBuild = self.savedBuilds.options[self.savedBuilds.selected]
	local screenW = getCore():getScreenWidth()
	local screenH = getCore():getScreenHeight()
	local modal = ISModalDialog:new((screenW - 230) / 2, (screenH - 120) / 2, 230, 120, getText("UI_characreation_BuildDeletePrompt", delBuild), true, self, CharacterCreationMain.deleteBuildStep2);
	modal.backgroundColor.a = 0.9
	modal:initialise()
	modal:setCapture(true)
	modal:addToUIManager()
	modal:setAlwaysOnTop(true)
	if self.presetPanel.joyfocus then
		modal.param1 = self.presetPanel.joyfocus
		self.presetPanel.joyfocus.focus = modal
		updateJoypadFocus(self.presetPanel.joyfocus)
	end
end

function CharacterCreationMain:deleteBuildStep2(button, joypadData) -- {{{
	if joypadData then
		joypadData.focus = self.presetPanel
		updateJoypadFocus(joypadData)
	end
	
	if button.internal == "NO" then return end
	
	local delBuild = self.savedBuilds.options[self.savedBuilds.selected];
	
	local builds = CharacterCreationMain.readSavedOutfitFile();
	builds[delBuild] = nil;
	
	local options = {};
	CharacterCreationMain.writeSaveFile(builds);
	for key,val in pairs(builds) do
		if key ~= nil and val ~= nil then
			options[key] = 1;
		end
	end
	
	self.savedBuilds.options = {};
	for key,val in pairs(options) do
		table.insert(self.savedBuilds.options, key);
	end
	if self.savedBuilds.selected > #self.savedBuilds.options then
		self.savedBuilds.selected = #self.savedBuilds.options
	end
	self:loadOutfit(self.savedBuilds)
	--    luautils.okModal("Deleted build "..delBuild.."!", true);
end

function CharacterCreationMain:saveBuildValidate(text)
    return text ~= "" and not text:contains("/") and not text:contains("\\") and
        not text:contains(":") and not text:contains(";") and not text:contains('"')
end

function CharacterCreationMain:saveBuildStep1()
	local firstName = self.forenameEntry:getText()
	local lastName = self.surnameEntry:getText()
	local text = firstName:trim() .. " " .. lastName:trim()
	if text == " " then
		text = "Preset"
	end
	self.inputModal = BCRC.inputModal(true, nil, nil, nil, nil, text, CharacterCreationMain.saveBuildStep2, self);
	self.inputModal.backgroundColor.a = 0.9
	self.inputModal:setValidateFunction(self, self.saveBuildValidate)
	local joypadData = JoypadState.getMainMenuJoypad() or CoopCharacterCreation.getJoypad()
	if joypadData then
		self.inputModal.param1 = joypadData
		joypadData.focus = self.inputModal
		updateJoypadFocus(joypadData)
	end
end

function CharacterCreationMain:saveBuildStep2(button, joypadData, param2)
	if joypadData then
		joypadData.focus = self.presetPanel
		updateJoypadFocus(joypadData)
	end
	
	if button.internal == "CANCEL" then
		return
	end
	
	local savename = button.parent.entry:getText()
	if savename == '' then return end
	
	local desc = MainScreen.instance.desc;
	
	local builds = CharacterCreationMain.readSavedOutfitFile();
	local savestring = "gender=" .. self.genderCombo.selected .. ";";
	savestring = savestring .. "skincolor=" .. self.skinColorButton.backgroundColor.r .. "," .. self.skinColorButton.backgroundColor.g .. "," .. self.skinColorButton.backgroundColor.b .. ";";
	savestring = savestring .. "name=" .. self.forenameEntry:getText() .. "|" .. self.surnameEntry:getText() .. ";";
	local hairStyle = self.hairTypeCombo:getOptionData(self.hairTypeCombo.selected)
	savestring = savestring .. "hair=" .. hairStyle .. "|" .. self.hairColorButton.backgroundColor.r .. "," .. self.hairColorButton.backgroundColor.g .. "," .. self.hairColorButton.backgroundColor.b .. ";";
    savestring = savestring .. "stubble=" .. (self.hairStubbleTickBox:isSelected(1) and "1" or "2") .. ";";
	if not desc:isFemale() then
		savestring = savestring .. "chesthair=" .. (self.chestHairTickBox:isSelected(1) and "1" or "2") .. ";";
		local beardStyle = self.beardTypeCombo:getOptionData(self.beardTypeCombo.selected)
		savestring = savestring .. "beard=" .. beardStyle .. ";";
        savestring = savestring .. "beardstubble=" .. (self.beardStubbleTickBox:isSelected(1) and "1" or "2") .. ";";
	end
	savestring = savestring .. "voiceStyle=" .. self.voiceTypeCombo:getOptionData(self.voiceTypeCombo.selected):getName() .. ";";
	savestring = savestring .. "voicePitch=" .. self:getVoicePitch() .. ";";
	for i,v in pairs(self.clothingCombo) do
		if v:getOptionData(v.selected) ~= nil then
			savestring = savestring ..  i .. "=" .. v:getOptionData(v.selected);
			if self.clothingColorBtn[i] and self.clothingColorBtn[i]:isVisible() then
				savestring = savestring .. "|" .. self.clothingColorBtn[i].backgroundColor.r .. "," .. self.clothingColorBtn[i].backgroundColor.g  .. "," .. self.clothingColorBtn[i].backgroundColor.b;
			end
			if self.clothingTextureCombo[i] and self.clothingTextureCombo[i]:isVisible() then
				savestring = savestring .. "|" .. self.clothingTextureCombo[i].selected;
			end
			savestring = savestring .. ";";
		end
	end
	builds[savename] = savestring;
	
	local options = {};
	CharacterCreationMain.writeSaveFile(builds);
	for key,val in pairs(builds) do
		options[key] = 1;
	end
	
	self.savedBuilds.options = {};
	local i = 1;
	for key,val in pairs(options) do
		table.insert(self.savedBuilds.options, key);
		if key == savename then
			self.savedBuilds.selected = i;
		end
		i = i + 1;
	end
end

function CharacterCreationMain.loadOutfit(self, box)
	self:loadOutfit(box);
end

local OUTFITS_VERSION = 1

function CharacterCreationMain:loadOutfit(box)
	local name = box.options[box.selected];
	if name == nil then return end;

	local desc = MainScreen.instance.desc;
	
	local saved_builds = CharacterCreationMain.readSavedOutfitFile();
	local build = saved_builds[name];
	if build == nil then return end;
	
	desc:getWornItems():clear();

	local items = luautils.split(build, ";");
	for i,v in pairs(items) do
		local location = luautils.split(v, "=");
		local options = nil;
		if location[2] then
			options = luautils.split(location[2], "|");
		end
		if location[1] == "gender" then
			self.genderCombo.selected = tonumber(options[1]);
			self:onGenderSelected(self.genderCombo);
			desc:getWornItems():clear();
		elseif location[1] == "skincolor" then
			local color = luautils.split(options[1], ",");
			local colorRGB = {};
			colorRGB.r = tonumber(color[1]);
			colorRGB.g = tonumber(color[2]);
			colorRGB.b = tonumber(color[3]);
			self.colorPickerSkin:setInitialColor(ColorInfo.new(colorRGB.r, colorRGB.g, colorRGB.b, 1.0));
			self:onSkinColorPicked(colorRGB, true);
		elseif location[1] == "name" then
			desc:setForename(options[1]);
			self.forenameEntry:setText(options[1]);
			desc:setSurname(options[2]);
			self.surnameEntry:setText(options[2]);
		elseif location[1] == "hair" then
			local color = luautils.split(options[2], ",");
			local colorRGB = {};
			colorRGB.r = tonumber(color[1]);
			colorRGB.g = tonumber(color[2]);
			colorRGB.b = tonumber(color[3]);
			self:onHairColorPicked(colorRGB, true);
			self.hairTypeCombo.selected = 1;
			self.hairTypeCombo:selectData(options[1]);
			self:onHairTypeSelected(self.hairTypeCombo);
		elseif location[1] == "stubble" then
			local stubble = tonumber(options[1]) == 1
			self.hairStubbleTickBox:setSelected(1, stubble);
			self:onShavedHairSelected(1, stubble);
		elseif location[1] == "chesthair" then
			local chestHair = tonumber(options[1]) == 1
			self.chestHairTickBox:setSelected(1, chestHair);
			self:onChestHairSelected(1, chestHair);
		elseif location[1] == "beard" then
			self.beardTypeCombo.selected = 1;
			self.beardTypeCombo:selectData(options and options[1] or "");
			self:onBeardTypeSelected(self.beardTypeCombo);
		elseif location[1] == "beardstubble" then
			local stubble = tonumber(options[1]) == 1
			self.beardStubbleTickBox:setSelected(1, stubble);
			self:onBeardStubbleSelected(1, stubble);
		elseif location[1] == "voiceStyle" then
			local foundVoice = false;
			for i in ipairs(self.voiceTypeCombo.options) do
				local voiceOption = self.voiceTypeCombo:getOptionData(i);
				if (voiceOption ~= nil) and (voiceOption:getName() == options[1]) then
					self.voiceTypeCombo:selectData(voiceOption);
					foundVoice = true;
					break;
				end;
			end;
			if (not foundVoice) then self:randomVoice(); end;
			self:onVoiceTypeSelected();
		elseif location[1] == "voicePitch" then
			self.voicePitchSlider:setCurrentValue(options and tonumber(options[1]) or 0.0, true);
			self:onVoiceTypeSelected();
		elseif self.clothingCombo[location[1]]  then
			--			print("dress on ", location[1], "with", options[1])
			local bodyLocation = location[1];
			local itemType = options[1];
			self.clothingCombo[bodyLocation].selected = 1;
			self.clothingCombo[bodyLocation]:selectData(itemType);
			self:onClothingComboSelected(self.clothingCombo[bodyLocation], bodyLocation);
			if options[2] then
				local comboTexture = self.clothingTextureCombo[bodyLocation]
				local color = luautils.split(options[2], ",");
				-- is it a color or a texture choice
				if (#color == 3) and self.clothingColorBtn[bodyLocation] then -- it's a color
					local colorRGB = {};
					colorRGB.r = tonumber(color[1]);
					colorRGB.g = tonumber(color[2]);
					colorRGB.b = tonumber(color[3]);
					self:onClothingColorPicked(colorRGB, true, bodyLocation);
				elseif comboTexture and comboTexture.options[tonumber(color[1])] then -- texture
					comboTexture.selected = tonumber(color[1]);
					self:onClothingTextureComboSelected(comboTexture, bodyLocation);
				end
			end
		end
	end

	self:updateSelectedClothingCombo();
	self:arrangeClothingUI()
end

function CharacterCreationMain.readSavedOutfitFile()
	local retVal = {};
	
	local saveFile = getFileReader(CharacterCreationMain.savefile, true);
	local version = 0
	local line = saveFile:readLine();
	while line ~= nil do
		if luautils.stringStarts(line, "VERSION=") then
			version = tonumber(string.split(line, "=")[2])
		elseif version == OUTFITS_VERSION then
			local s = luautils.split(line, ":");
			retVal[s[1]] = s[2];
		end
		line = saveFile:readLine();
	end
	saveFile:close();
	
	return retVal;
end

function CharacterCreationMain.writeSaveFile(options)
	local saved_builds = getFileWriter(CharacterCreationMain.savefile, true, false); -- overwrite
	saved_builds:write("VERSION="..tostring(OUTFITS_VERSION).."\n")
	for key,val in pairs(options) do
		saved_builds:write(key..":"..val.."\n");
	end
	saved_builds:close();
end

function CharacterCreationMain:createNameAndGender()
	local lbl = ISLabel:new(0, self.yOffset, FONT_HGT_MEDIUM, getText("UI_characreation_forename"), 1, 1, 1, 1, UIFont.Medium, false);
	lbl:initialise();
	lbl:instantiate();
	self.characterPanel:addChild(lbl);
	table.insert(self.characterPanel.repos2Table, lbl)

	self.forenameEntry = ISTextEntryBox:new(MainScreen.instance.desc:getForename(), 0, self.yOffset, 0, BUTTON_HGT);
	self.forenameEntry:initialise();
	self.forenameEntry:instantiate();
	self.characterPanel:addChild(self.forenameEntry);
	table.insert(self.characterPanel.comboResizeTable, self.forenameEntry)
	table.insert(self.characterPanel.repos3Table, self.forenameEntry)

	lbl = ISLabel:new(0, self.forenameEntry:getBottom() + UI_BORDER_SPACING, FONT_HGT_MEDIUM, getText("UI_characreation_surname"), 1, 1, 1, 1, UIFont.Medium, false);
	lbl:initialise();
	lbl:instantiate();
	self.characterPanel:addChild(lbl);
	table.insert(self.characterPanel.repos2Table, lbl)

	self.surnameEntry = ISTextEntryBox:new(MainScreen.instance.desc:getSurname(), 0, self.forenameEntry:getBottom() + UI_BORDER_SPACING, 0, BUTTON_HGT);
	self.surnameEntry:initialise();
	self.surnameEntry:instantiate();
	self.characterPanel:addChild(self.surnameEntry);
	table.insert(self.characterPanel.comboResizeTable, self.surnameEntry)
	table.insert(self.characterPanel.repos3Table, self.surnameEntry)

	self.genderCombo = ISComboBox:new(0, self.surnameEntry:getBottom() + UI_BORDER_SPACING, 0, BUTTON_HGT, self, CharacterCreationMain.onGenderSelected);
	self.genderCombo:initialise();
	self.genderCombo:addOption(getText("IGUI_char_Female"))
	self.genderCombo:addOption(getText("IGUI_char_Male"))
	self.genderCombo.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
	self.characterPanel:addChild(self.genderCombo)
	table.insert(self.characterPanel.comboResizeTable, self.genderCombo)
	table.insert(self.characterPanel.repos3Table, self.genderCombo)

	self.yOffset = self.genderCombo:getBottom() + UI_BORDER_SPACING;
end

function CharacterCreationMain:createBodyTypeBtn()
	local lbl = ISLabel:new(0, self.yOffset, FONT_HGT_MEDIUM, getText("UI_characreation_body"), 1, 1, 1, 1, UIFont.Medium, true);
	lbl:initialise();
	lbl:instantiate();
	self.characterPanel:addChild(lbl);
	table.insert(self.characterPanel.reposTable, lbl)
	
	local rect = ISRect:new(0, self.yOffset + FONT_HGT_MEDIUM + 5, 0, 1, 1, 0.3, 0.3, 0.3);
	rect:initialise();
	rect:instantiate();
	self.characterPanel:addChild(rect);
	table.insert(self.characterPanel.dividerResizeTable, rect)
	
	self.yOffset = self.yOffset + FONT_HGT_MEDIUM + 15;

	-------------
	-- SKIN COLOR 
	-------------
	self.skinColorLbl = ISLabel:new(0, self.yOffset, BUTTON_HGT, getText("UI_SkinColor"), 1, 1, 1, 1, UIFont.Small);
	self.skinColorLbl:initialise();
	self.skinColorLbl:instantiate();
	self.characterPanel:addChild(self.skinColorLbl);
	table.insert(self.characterPanel.repos2Table, self.skinColorLbl)

	self.skinColors = { {r=1,g=0.91,b=0.72},
		{r=0.98,g=0.79,b=0.49},
		{r=0.8,g=0.65,b=0.45},
		{r=0.54,g=0.38,b=0.25},
		{r=0.36,g=0.25,b=0.14} }
	--	for _,color in ipairs(skinColors) do
	--		color:desaturate(0.5)
	--	end
	local skinColorBtn = ISButton:new(0, self.yOffset, BUTTON_HGT, BUTTON_HGT, "", self, CharacterCreationMain.onSkinColorSelected)
	skinColorBtn:initialise()
	skinColorBtn:instantiate()
	local color = self.skinColors[1]
	skinColorBtn.backgroundColor = {r = color.r, g = color.g, b = color.b, a = 1}
	self.characterPanel:addChild(skinColorBtn)
	self.skinColorButton = skinColorBtn
	table.insert(self.characterPanel.repos3Table, self.skinColorButton)
	
	self.colorPickerSkin = ISColorPicker:new(0, 0, nil)
	self.colorPickerSkin:initialise()
	self.colorPickerSkin.keepOnScreen = true
	self.colorPickerSkin.pickedTarget = self
	self.colorPickerSkin.resetFocusTo = self.characterPanel
	self.colorPickerSkin:setColors(self.skinColors, #self.skinColors, 1)
	
	self.yOffset = self.yOffset + UI_BORDER_SPACING+BUTTON_HGT;
	
	-------------
	-- CHEST HAIR
	-------------
	self.chestHairLbl = ISLabel:new(0, self.yOffset, BUTTON_HGT, getText("UI_ChestHair"), 1, 1, 1, 1, UIFont.Small);
	self.chestHairLbl:initialise();
	self.chestHairLbl:instantiate();
	self.characterPanel:addChild(self.chestHairLbl);
	table.insert(self.characterPanel.repos2Table, self.chestHairLbl)

	local tickBox = ISTickBox:new(0, self.yOffset, 0, BUTTON_HGT, "", self, CharacterCreationMain.onChestHairSelected)
	tickBox:initialise()
	tickBox.autoWidth = true
	self.characterPanel:addChild(tickBox)
	tickBox:addOption("")
	self.chestHairLbl:setHeight(tickBox.height)
	self.chestHairTickBox = tickBox
	table.insert(self.characterPanel.repos3Table, self.chestHairTickBox)

	self.yOffset = self.yOffset + UI_BORDER_SPACING+BUTTON_HGT;
end


function CharacterCreationMain:createHairTypeBtn()
	local lbl = ISLabel:new(0, self.yOffset, FONT_HGT_MEDIUM, getText("UI_characreation_hair"), 1, 1, 1, 1, UIFont.Medium, true);
	lbl:initialise();
	lbl:instantiate();
	self.characterPanel:addChild(lbl);
	table.insert(self.characterPanel.reposTable, lbl)
	
	local rect = ISRect:new(0, self.yOffset + FONT_HGT_MEDIUM + 5, 0, 1, 1, 0.3, 0.3, 0.3);
	rect:setAnchorRight(false);
	rect:initialise();
	rect:instantiate();
	self.characterPanel:addChild(rect);
	table.insert(self.characterPanel.dividerResizeTable, rect)
	
	self.yOffset = self.yOffset + FONT_HGT_MEDIUM + 15;
	
	self.hairTypeLbl = ISLabel:new(0, self.yOffset, BUTTON_HGT, getText("UI_characreation_hairtype"), 1, 1, 1, 1, UIFont.Small);
	self.hairTypeLbl:initialise();
	self.hairTypeLbl:instantiate();
	self.characterPanel:addChild(self.hairTypeLbl);
	table.insert(self.characterPanel.repos2Table, self.hairTypeLbl)
	
	self.hairTypeCombo = ISComboBox:new(0, self.yOffset, 0, BUTTON_HGT, self, CharacterCreationMain.onHairTypeSelected);
	self.hairTypeCombo:initialise();
	self.hairTypeCombo.pointOnItem = function(_self, _index)
		if _self.lastIndex ~= _index then
			MainScreen.instance.desc:getHumanVisual():setHairModel(_self:getOptionData(_index))
			_self.parent.parent.avatarPanel:setSurvivorDesc(MainScreen.instance.desc)
			_self.lastIndex = _index
		end
	end
	self.hairTypeCombo.onMouseMoveOutside = function(_self, _x, _y)
		MainScreen.instance.desc:getHumanVisual():setHairModel(_self:getOptionData(_self:getSelected()))
		_self.parent.parent.avatarPanel:setSurvivorDesc(MainScreen.instance.desc)
	end
	self.characterPanel:addChild(self.hairTypeCombo)
	table.insert(self.characterPanel.comboResizeTable, self.hairTypeCombo)
	table.insert(self.characterPanel.repos3Table, self.hairTypeCombo)
	
	self.hairType = 0
	
	self.yOffset = self.yOffset + BUTTON_HGT + UI_BORDER_SPACING;
	
	self.hairColorLbl = ISLabel:new(0, self.yOffset, BUTTON_HGT, getText("UI_characreation_color"), 1, 1, 1, 1, UIFont.Small);
	self.hairColorLbl:initialise();
	self.hairColorLbl:instantiate();
	self.characterPanel:addChild(self.hairColorLbl);
	table.insert(self.characterPanel.repos2Table, self.hairColorLbl)


	local hairColors = MainScreen.instance.desc:getCommonHairColor();
	local hairColors1 = {}
	local info = ColorInfo.new()
	for i=1,hairColors:size() do
		local color = hairColors:get(i-1)
		-- we create a new info color to desaturate it (like in the game)
		info:set(color:getRedFloat(), color:getGreenFloat(), color:getBlueFloat(), 1)
		--		info:desaturate(0.5)
		table.insert(hairColors1, { r=info:getR(), g=info:getG(), b=info:getB() })
	end
	local hairColorBtn = ISButton:new(0, self.yOffset, BUTTON_HGT, BUTTON_HGT, "", self, CharacterCreationMain.onHairColorMouseDown)
	hairColorBtn:initialise()
	hairColorBtn:instantiate()
	local color = hairColors1[1]
	hairColorBtn.backgroundColor = {r=color.r, g=color.g, b=color.b, a=1}
	self.characterPanel:addChild(hairColorBtn)
	self.hairColorButton = hairColorBtn
	self.yOffset = self.yOffset + BUTTON_HGT + UI_BORDER_SPACING;

	self.colorPickerHair = ISColorPicker:new(0, 0, nil)
	self.colorPickerHair:initialise()
	self.colorPickerHair.keepOnScreen = true
	self.colorPickerHair.pickedTarget = self
	self.colorPickerHair.resetFocusTo = self.characterPanel
	self.colorPickerHair:setColors(hairColors1, math.min(#hairColors1, 10), math.ceil(#hairColors1 / 10))
	table.insert(self.characterPanel.repos3Table, self.hairColorButton)

	----------------------
	-- STUBBLE
	----------------------
	self.hairStubbleLbl = ISLabel:new(0, self.yOffset, BUTTON_HGT, getText("UI_Stubble"), 1, 1, 1, 1, UIFont.Small);
	self.hairStubbleLbl:initialise();
	self.hairStubbleLbl:instantiate();
	self.characterPanel:addChild(self.hairStubbleLbl);
	table.insert(self.characterPanel.repos2Table, self.hairStubbleLbl)
	
	self.hairStubbleTickBox = ISTickBox:new(0, self.yOffset, 0, BUTTON_HGT, "", self, CharacterCreationMain.onShavedHairSelected);
	self.hairStubbleTickBox:initialise();
	self.hairStubbleTickBox.autoWidth = true
	self.characterPanel:addChild(self.hairStubbleTickBox)
	self.hairStubbleTickBox:addOption("")
	self.hairStubbleLbl:setHeight(self.hairStubbleTickBox.height)
	table.insert(self.characterPanel.repos3Table, self.hairStubbleTickBox)

	self.yOffset = self.yOffset + BUTTON_HGT + UI_BORDER_SPACING;
end

function CharacterCreationMain:createVoiceTypeBtn()
	self.voiceLbl = ISLabel:new(0, self.yOffset, FONT_HGT_MEDIUM, getText("UI_characreation_voice"), 1, 1, 1, 1, UIFont.Medium, true);
	self.voiceLbl:initialise();
	self.voiceLbl:instantiate();
	self.characterPanel:addChild(self.voiceLbl);
	table.insert(self.characterPanel.reposTable, self.voiceLbl)

	self.voiceRect = ISRect:new(0, self.yOffset + FONT_HGT_MEDIUM + 5, 0, 1, 1, 0.3, 0.3, 0.3);
	self.voiceRect:setAnchorRight(false);
	self.voiceRect:initialise();
	self.voiceRect:instantiate();
	self.characterPanel:addChild(self.voiceRect);
	table.insert(self.characterPanel.dividerResizeTable, self.voiceRect)

	self.yOffset = self.yOffset + FONT_HGT_MEDIUM + 15;

	self.voiceTypeLbl = ISLabel:new(0, self.yOffset, BUTTON_HGT, getText("UI_characreation_voicetype"), 1, 1, 1, 1, UIFont.Small);
	self.voiceTypeLbl:initialise();
	self.voiceTypeLbl:instantiate();
	self.characterPanel:addChild(self.voiceTypeLbl);
	table.insert(self.characterPanel.repos2Table, self.voiceTypeLbl)

	self.voiceTypeCombo = ISComboBox:new(0, self.yOffset, 0, BUTTON_HGT, self, CharacterCreationMain.onVoiceTypeSelected);
	self.voiceTypeCombo:initialise();
	self.characterPanel:addChild(self.voiceTypeCombo);
	table.insert(self.characterPanel.comboResizeTable, self.voiceTypeCombo)
	table.insert(self.characterPanel.repos3Table, self.voiceTypeCombo)

	local voiceStyles = getAllVoiceStyles();

	for i = 0, voiceStyles:size() - 1 do
		local option = voiceStyles:get(i);
		if option then
			self.voiceTypeCombo:addOptionWithData(getText("IGUI_Voice_" .. option:getName()), option);
		end;
	end;

	self:randomVoice();

	self.yOffset = self.yOffset + BUTTON_HGT + UI_BORDER_SPACING;

	self.voicePitchLbl = ISLabel:new(0, self.yOffset, BUTTON_HGT, getText("UI_characreation_voicepitch"), 1, 1, 1, 1, UIFont.Small);
	self.voicePitchLbl:initialise();
	self.voicePitchLbl:instantiate();
	self.characterPanel:addChild(self.voicePitchLbl);
	table.insert(self.characterPanel.repos2Table, self.voicePitchLbl)

	self.voicePitchSlider = ISSliderPanel:new(0, self.yOffset, 0, BUTTON_HGT);
	self.voicePitchSlider:initialise();
	self.voicePitchSlider:instantiate();
	self.voicePitchSlider:setValues(-100.0, 100.0, 1.0, 5.0);
	self.voicePitchSlider:setCurrentValue(0.0, true);
	self.characterPanel:addChild(self.voicePitchSlider);
	table.insert(self.characterPanel.comboResizeTable, self.voicePitchSlider)
	table.insert(self.characterPanel.repos3Table, self.voicePitchSlider)

	self.yOffset = self.yOffset + BUTTON_HGT + UI_BORDER_SPACING;

	self.voiceDemoButton = ISButton:new(0, self.yOffset, 0, BUTTON_HGT, getText("UI_characreation_playdemovoice"), self, self.onOptionMouseDown);
	self.voiceDemoButton.internal = "PLAYDEMOVOICE";
	self.voiceDemoButton:initialise();
	self.voiceDemoButton:instantiate();
	self.voiceDemoButton:setEnable(true);
	self.voiceDemoButton:setSound("activate", nil);
	self.characterPanel:addChild(self.voiceDemoButton);
	table.insert(self.characterPanel.comboResizeTable, self.voiceDemoButton)
	table.insert(self.characterPanel.repos3Table, self.voiceDemoButton)

    if not instanceof(getSoundManager(), "DummySoundManager") then
	    self.soundPlayer = getSoundManager():getUIEmitter();
	end
	self.soundRef = 0;

	self.yOffset = self.yOffset + BUTTON_HGT + UI_BORDER_SPACING;
end

function CharacterCreationMain:createBeardTypeBtn()
	self.beardLbl = ISLabel:new(0, self.yOffset, FONT_HGT_MEDIUM, getText("UI_characreation_beard"), 1, 1, 1, 1, UIFont.Medium, true);
	self.beardLbl:initialise();
	self.beardLbl:instantiate();
	self.characterPanel:addChild(self.beardLbl);
	table.insert(self.characterPanel.reposTable, self.beardLbl)
	
	self.beardRect = ISRect:new(0, self.yOffset + FONT_HGT_MEDIUM + 5, 0, 1, 1, 0.3, 0.3, 0.3);
	self.beardRect:setAnchorRight(false);
	self.beardRect:initialise();
	self.beardRect:instantiate();
	self.characterPanel:addChild(self.beardRect);
	table.insert(self.characterPanel.dividerResizeTable, self.beardRect)
	
	self.yOffset = self.yOffset + FONT_HGT_MEDIUM + 15;
	
	self.beardTypeLbl = ISLabel:new(0, self.yOffset, BUTTON_HGT, getText("UI_characreation_beardtype"), 1, 1, 1, 1, UIFont.Small);
	self.beardTypeLbl:initialise();
	self.beardTypeLbl:instantiate();
	self.characterPanel:addChild(self.beardTypeLbl);
	table.insert(self.characterPanel.repos2Table, self.beardTypeLbl)
	
	self.beardTypeCombo = ISComboBox:new(0, self.yOffset, 0, BUTTON_HGT, self, CharacterCreationMain.onBeardTypeSelected);
	self.beardTypeCombo:initialise();
	self.beardTypeCombo.pointOnItem = function(_self, _index)
		if _self.lastIndex ~= _index then
			MainScreen.instance.desc:getHumanVisual():setBeardModel(_self:getOptionData(_index))
			_self.parent.parent.avatarPanel:setSurvivorDesc(MainScreen.instance.desc)
			_self.lastIndex = _index
		end
	end
	self.beardTypeCombo.onMouseMoveOutside = function(_self, _x, _y)
		MainScreen.instance.desc:getHumanVisual():setBeardModel(_self:getOptionData(_self:getSelected()))
		_self.parent.parent.avatarPanel:setSurvivorDesc(MainScreen.instance.desc)
	end
	self.characterPanel:addChild(self.beardTypeCombo)
	table.insert(self.characterPanel.comboResizeTable, self.beardTypeCombo)
	table.insert(self.characterPanel.repos3Table, self.beardTypeCombo)
	self.yOffset = self.yOffset + BUTTON_HGT + UI_BORDER_SPACING;

	----------------------
	-- STUBBLE
	----------------------
	self.beardStubbleLbl = ISLabel:new(0, self.yOffset, BUTTON_HGT, getText("UI_Stubble"), 1, 1, 1, 1, UIFont.Small);
	self.beardStubbleLbl:initialise();
	self.beardStubbleLbl:instantiate();
	self.characterPanel:addChild(self.beardStubbleLbl);
	table.insert(self.characterPanel.repos2Table, self.beardStubbleLbl)
	
	self.beardStubbleTickBox = ISTickBox:new(0, self.yOffset, 0, BUTTON_HGT, "", self, CharacterCreationMain.onBeardStubbleSelected);
	self.beardStubbleTickBox:initialise();
	self.beardStubbleTickBox.autoWidth = true;
	self.characterPanel:addChild(self.beardStubbleTickBox)
	self.beardStubbleTickBox:addOption("")
	self.beardStubbleLbl:setHeight(self.beardStubbleTickBox.height)
	table.insert(self.characterPanel.repos3Table, self.beardStubbleTickBox)

	self.yOffset = self.yOffset + BUTTON_HGT + UI_BORDER_SPACING;
end

function CharacterCreationMain:createClothingComboDebug(bodyLocation)
	local label = ISLabel:new(0, self.yOffset, BUTTON_HGT, getText("UI_ClothingType_" .. bodyLocation), 1, 1, 1, 1, UIFont.Small)
	label:initialise()
	self.clothingPanel:addChild(label)
	
	local combo = ISComboBox:new(UI_BORDER_SPACING, self.yOffset, 0, BUTTON_HGT, self, self.onClothingComboSelected, bodyLocation)
	combo:initialise()
	combo.pointOnItem = function(_self, _index)
		if _self.lastIndex == nil then
			_self.lastIndex = _index
		end
		if _self.lastIndex ~= _index then
			local desc = MainScreen.instance.desc
			desc:setWornItem(bodyLocation, nil)
			local itemType = combo:getOptionData(_index)
			if itemType then
				local item = instanceItem(itemType)
				if item then
					desc:setWornItem(bodyLocation, item)
				end
			end
			self:updateSelectedClothingCombo()
			_self.parent.parent.avatarPanel:setSurvivorDesc(desc)
			_self.lastIndex = _index
		end
	end
	combo.onMouseMoveOutside = function(_self, _x, _y)
		local itemType = _self:getOptionData(_self:getSelected())
		if itemType then
			-- check to see if character model is already wearing the same piece of clothing
			local item = instanceItem(itemType)
			local wornItem = MainScreen.instance.desc:getWornItem(bodyLocation)
			if (item == nil) ~= (wornItem == nil) or (item ~= nil and wornItem ~= nil and item:getName() ~= wornItem:getName()) then
				-- either item or wornItem is nil
				-- or both are not nil and have matching names
				MainScreen.instance.desc:setWornItem(bodyLocation, item)
			end
		end
		_self.parent.parent.avatarPanel:setSurvivorDesc(MainScreen.instance.desc)
	end
	combo.bodyLocation = bodyLocation;
	self.clothingPanel:addChild(combo)
	
	local button = ISButton:new(combo:getRight() + UI_BORDER_SPACING, self.yOffset, BUTTON_HGT, BUTTON_HGT, "", self)
	button:setOnClick(CharacterCreationMain.onClothingColorClicked, bodyLocation)
	button.internal = color
	button:initialise()
	button.backgroundColor = {r = 1, g = 1, b = 1, a = 1}
	self.clothingPanel:addChild(button)
	
	local comboDecal = ISComboBox:new(button:getRight() + UI_BORDER_SPACING, self.yOffset, 300, BUTTON_HGT, self, self.onClothingDecalComboSelected, bodyLocation)
	comboDecal:initialise()
	self.clothingPanel:addChild(comboDecal)
	
	local comboTexture = ISComboBox:new(combo:getRight() + UI_BORDER_SPACING, self.yOffset, self.clothingTextureComboWidth, BUTTON_HGT, self, self.onClothingTextureComboSelected, bodyLocation)
	comboTexture:initialise()
	comboTexture.pointOnItem = function(_self, _index)
        if _self.lastIndex ~= _index then
            local textureName = _self:getOptionData(_index)
            local bodyLocation = _self.onChangeArgs[1]
            local item = MainScreen.instance.desc:getWornItem(bodyLocation)
            if textureName and item then
                if item:getClothingItem():hasModel() then
                    item:getVisual():setTextureChoice(_index - 1)
                else
                    item:getVisual():setBaseTexture(_index - 1)
                end
            end
            _self.parent.parent.avatarPanel:setSurvivorDesc(MainScreen.instance.desc)
            _self.lastIndex = _index
        end
    end
	self.clothingPanel:addChild(comboTexture)
	
	self.clothingComboLabel = self.clothingComboLabel or {};
	self.clothingCombo = self.clothingCombo or {}
	self.clothingColorBtn = self.clothingColorBtn or {}
	self.clothingTextureCombo = self.clothingTextureCombo or {}
	self.clothingDecalCombo = self.clothingDecalCombo or {}

	self.clothingComboLabel[bodyLocation] = label
	self.clothingCombo[bodyLocation] = combo
	self.clothingColorBtn[bodyLocation] = button
	self.clothingTextureCombo[bodyLocation] = comboTexture
	self.clothingDecalCombo[bodyLocation] = comboDecal
	
	table.insert(self.clothingWidgets, { combo, button, comboDecal, comboTexture })
	
	self.yOffset = self.yOffset + BUTTON_HGT + UI_BORDER_SPACING
	
	return
end

-- -- -- -- --
-- -- -- -- --
-- -- -- -- --

local ClothingPanel = ISPanelJoypad:derive("CharacterCreationClothingPanel")

function ClothingPanel:prerender()
	self:doRightJoystickScrolling(20, 20)
	ISPanelJoypad.prerender(self)
	self:setStencilRect(0, 0, self.width, self.height)
end

function ClothingPanel:render()
	ISPanelJoypad.render(self)
	self:clearStencilRect()
	self:renderJoypadFocus(-3, -3, self.width + 6, self.height + 6)
end

function ClothingPanel:tryRemoveChild(child)
	if not child then return end
	self:removeChild(child)
end

function ClothingPanel:onMouseWheel(del)
	self:setYScroll(self:getYScroll() - del * 40)
end

function ClothingPanel:onGainJoypadFocus(joypadData)
	ISPanelJoypad.onGainJoypadFocus(self, joypadData)
	self.joypadButtonsY = {}
	for _,table1 in ipairs(self.parent.clothingWidgets) do
		self:insertNewLineOfButtons(table1[1], table1[2], table1[3], table1[4])
	end
	self.joypadIndex = 1
	if self.prevJoypadIndexY ~= -1 then
		self.joypadIndexY = self.prevJoypadIndexY
	else
		self.joypadIndexY = 1
	end
	self.joypadButtons = self.joypadButtonsY[self.joypadIndexY]
	self.joypadButtons[self.joypadIndex]:setJoypadFocused(true)
end

function ClothingPanel:onLoseJoypadFocus(joypadData)
	self.prevJoypadIndexY = self.joypadIndexY
	self:clearJoypadFocus(joypadData)
	ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
end

function ClothingPanel:onJoypadDown(button, joypadData)
	if button == Joypad.BButton and not self:isFocusOnControl() then
		joypadData.focus = self.parent
		updateJoypadFocus(joypadData)
	else
		ISPanelJoypad.onJoypadDown(self, button, joypadData)
	end
end

function ClothingPanel:new(x, y, width, height)
	local o = ISPanelJoypad:new(x, y, width, height)
	setmetatable(o, self)
	self.__index = self
	self.prevJoypadIndexY = -1
	return o
end

-- -- -- -- --
-- -- -- -- --
-- -- -- -- --

-- In debug you'll have access to all clothes
-- In normal mode, you'll have access to basic clothes + some specific to your profession (RP option can be enabled in MP to have access to a full outfit)
function CharacterCreationMain:createClothingBtn()
	local x = self.avatarPanel:getRight() + UI_BORDER_SPACING

	self.clothingPanel = ClothingPanel:new(x, self.yOffset, self.width - x - UI_BORDER_SPACING - 1, self.avatarPanel:getHeight())
	self.clothingPanel:initialise()
	self.clothingPanel:setAnchorBottom(true);
	self.clothingPanel:setAnchorTop(true);
	self.clothingPanel:noBackground();
	self:addChild(self.clothingPanel)

	x = 0
	self.clothingLbl = ISLabel:new(x, 0, FONT_HGT_MEDIUM, getText("UI_characreation_clothing"), 1, 1, 1, 1, UIFont.Medium, true);
	self.clothingLbl:initialise();
	self.clothingPanel:addChild(self.clothingLbl);

	self.clothingPanel:addScrollBars()

	self.clothingRect = ISRect:new(x, 0 + FONT_HGT_MEDIUM + 5, self.clothingPanel.width, 1, 1, 0.3, 0.3, 0.3);
	self.clothingRect:initialise();
	self.clothingRect:instantiate();
	self.clothingPanel:addChild(self.clothingRect);

	self.originalYOffset = self.yOffset;
	self.yOffset = UI_BORDER_SPACING+FONT_HGT_MEDIUM+6;
	
	self.colorPicker = ISColorPickerHSB:new(0, 0, ColorInfo.new());
	self.colorPicker:initialise()
	self.colorPicker.keepOnScreen = true
	self.colorPicker.pickedTarget = self
	self.colorPicker.resetFocusTo = self.clothingPanel
end

function CharacterCreationMain:createClothingCombo(bodyLocation)
	if not self.clothingPanel then return; end
	
	local label = ISLabel:new(0, self.yOffset, BUTTON_HGT, getText("UI_ClothingType_" .. bodyLocation), 1, 1, 1, 1, UIFont.Small)
	label:initialise()
	self.clothingPanel:addChild(label)
	
	local combo = ISComboBox:new(0 + UI_BORDER_SPACING, self.yOffset, 0, BUTTON_HGT, self, self.onClothingComboSelected, bodyLocation)
	combo:initialise()
	combo.pointOnItem = function(_self, _index)
		if _self.lastIndex == nil then
			_self.lastIndex = _index
		end
		if _self.lastIndex ~= _index then
			local desc = MainScreen.instance.desc
			desc:setWornItem(bodyLocation, nil)
			local itemType = combo:getOptionData(_index)
			if itemType then
				local item = instanceItem(itemType)
				if item then
					desc:setWornItem(bodyLocation, item)
				end
			end
			self:updateSelectedClothingCombo()
			_self.parent.parent.avatarPanel:setSurvivorDesc(desc)
			_self.lastIndex = _index
		end
	end
	combo.onMouseMoveOutside = function(_self, _x, _y)
		local itemType = _self:getOptionData(_self:getSelected())
		if itemType then
			-- check to see if character model is already wearing the same piece of clothing
			local item = instanceItem(itemType)
			local wornItem = MainScreen.instance.desc:getWornItem(bodyLocation)
			if (item == nil) ~= (wornItem == nil) or (item ~= nil and wornItem ~= nil and item:getName() ~= wornItem:getName()) then
				-- either item or wornItem is nil
				-- or both are not nil and have matching names
				MainScreen.instance.desc:setWornItem(bodyLocation, item)
			end
		end
		_self.parent.parent.avatarPanel:setSurvivorDesc(MainScreen.instance.desc)
	end
	combo.bodyLocation = bodyLocation;
	self.clothingPanel:addChild(combo)

	local button = ISButton:new(combo:getRight() + UI_BORDER_SPACING, self.yOffset, BUTTON_HGT, BUTTON_HGT, "", self)
	button:setOnClick(CharacterCreationMain.onClothingColorClicked, bodyLocation)
	button.internal = color
	button:initialise()
	button.backgroundColor = {r = 1, g = 1, b = 1, a = 1}
	self.clothingPanel:addChild(button)
	
	local comboTexture = ISComboBox:new(combo:getRight() + UI_BORDER_SPACING, self.yOffset, self.clothingTextureComboWidth, BUTTON_HGT, self, self.onClothingTextureComboSelected, bodyLocation)
	comboTexture:initialise()
	comboTexture.pointOnItem = function(_self, _index)
        if _self.lastIndex ~= _index then
            local textureName = _self:getOptionData(_index)
            local bodyLocation = _self.onChangeArgs[1]
            local item = MainScreen.instance.desc:getWornItem(bodyLocation)
            if textureName and item then
                if item:getClothingItem():hasModel() then
                    item:getVisual():setTextureChoice(_index - 1)
                else
                    item:getVisual():setBaseTexture(_index - 1)
                end
            end
            _self.parent.parent.avatarPanel:setSurvivorDesc(MainScreen.instance.desc)
            _self.lastIndex = _index
        end
    end
	self.clothingPanel:addChild(comboTexture)
	
	self.clothingCombo = self.clothingCombo or {}
	self.clothingColorBtn = self.clothingColorBtn or {}
	self.clothingTextureCombo = self.clothingTextureCombo or {}
	self.clothingComboLabel = self.clothingComboLabel or {}
	
	self.clothingCombo[bodyLocation] = combo
	self.clothingColorBtn[bodyLocation] = button
	self.clothingTextureCombo[bodyLocation] = comboTexture
	self.clothingComboLabel[bodyLocation] = label;
	
	table.insert(self.clothingWidgets, { combo, button, comboTexture })

	self.yOffset = self.yOffset + BUTTON_HGT + UI_BORDER_SPACING
	
	return
end

function CharacterCreationMain:arrangeClothingUI()
	if self.clothingCombo == nil then return end
	local scrollBarOffset = self.clothingPanel:isVScrollBarVisible() and UI_BORDER_SPACING + 13 or 0
	self.clothingRect:setWidth(self.clothingPanel.width - scrollBarOffset)
	local maxLabelWidth = 0
	if self.outfitLbl then
		maxLabelWidth = getTextManager():MeasureStringX(UIFont.Small, self.outfitLbl:getName())
	end
	for bodyLocation,combo in pairs(self.clothingCombo) do
		local label = self.clothingComboLabel[bodyLocation]
		local labelWidth = getTextManager():MeasureStringX(UIFont.Small, label:getName())
		maxLabelWidth = math.max(maxLabelWidth, labelWidth)
	end
	local scrollBarW = self.clothingPanel:isVScrollBarVisible() and (UI_BORDER_SPACING + 13) or 0
	self.comboWid = math.min(300, self.clothingPanel.width - (maxLabelWidth + UI_BORDER_SPACING + UI_BORDER_SPACING + self.clothingTextureComboWidth + scrollBarW))
	self.comboWid = math.max(self.comboWid, 50)
	local totalWidth = maxLabelWidth + UI_BORDER_SPACING + self.comboWid + UI_BORDER_SPACING + self.clothingTextureComboWidth
	local labelRight = maxLabelWidth

	local nonComboWidth = self.clothingPanel.width - labelRight - UI_BORDER_SPACING - scrollBarOffset

	if self.outfitLbl then
		self.outfitLbl:setX(labelRight - self.outfitLbl.width)
		self.outfitCombo:setWidth(math.min(300, nonComboWidth - self.randomizeOutfitBtn:getWidth() - UI_BORDER_SPACING))
		self.outfitCombo:setX(labelRight + UI_BORDER_SPACING)
		self.randomizeOutfitBtn:setX(self.outfitCombo:getRight() + UI_BORDER_SPACING)
	end

    self.labelRight = labelRight
    self.nonComboWidth = nonComboWidth
	for bodyLocation,combo in pairs(self.clothingCombo) do
        self:arrangeClothingRightSideElements(bodyLocation)
	end
end

function CharacterCreationMain:arrangeClothingRightSideElements(bodyLocation)
    if not self.labelRight then return end
    local label = self.clothingComboLabel[bodyLocation]
    local combo = self.clothingCombo[bodyLocation]
    local labelRight = self.labelRight
    local nonComboWidth = self.nonComboWidth
    label:setX(labelRight - label.width)
    combo:setWidth(self.comboWid)
    combo:setX(labelRight + UI_BORDER_SPACING)

    local rightSideElements = 0
    if self.clothingColorBtn[bodyLocation]:isVisible() then
        rightSideElements = self.clothingColorBtn[bodyLocation]:getWidth() + UI_BORDER_SPACING
    end
    if self.clothingTextureCombo[bodyLocation]:isVisible() then
        rightSideElements = rightSideElements + self.clothingTextureCombo[bodyLocation]:getWidth() + UI_BORDER_SPACING
    elseif self.outfitLbl == label and self.randomizeOutfitBtn then
        rightSideElements = self.randomizeOutfitBtn:getWidth() + UI_BORDER_SPACING
    end

    combo:setWidth(math.min(300, nonComboWidth - rightSideElements))
    local rightOf = combo
    if self.clothingColorBtn[bodyLocation]:isVisible() then
        self.clothingColorBtn[bodyLocation]:setX(rightOf:getRight() + UI_BORDER_SPACING)
        rightOf = self.clothingColorBtn[bodyLocation]
    end
    if self.clothingTextureCombo[bodyLocation]:isVisible() then
        self.clothingTextureCombo[bodyLocation]:setX(rightOf:getRight() + UI_BORDER_SPACING)
        rightOf = self.clothingTextureCombo[bodyLocation]
    end
    if self.clothingDecalCombo and self.clothingDecalCombo[bodyLocation] then
        self.clothingDecalCombo[bodyLocation]:setX(rightOf:getRight() + UI_BORDER_SPACING)
    end
end

function CharacterCreationMain:debugClothingDefinitions()
	local bodyLocationGroup = BodyLocations.getGroup("Human")
	for k1,v1 in pairs(ClothingSelectionDefinitions) do
		-- Female, Male
		for k2,v2 in pairs(v1) do
			if k2 ~= "Female" and k2 ~= "Male" then
				error("expected Female or Male in ClothingSelectionDefinitions." .. tostring(k1))
			end
			for locationId,v3 in pairs(v2) do
				if bodyLocationGroup:indexOf(locationId) == -1 then
					error("unknown BodyLocation \"" .. tostring(locationId) .. "\" in ClothingSelectionDefinitions." .. tostring(k1) .. "." .. tostring(k2))
				end
				for _,fullType in ipairs(v3.items) do
					if not ScriptManager.instance:FindItem(fullType) then
						error("unknown item type \"" .. tostring(fullType) .. "\" in ClothingSelectionDefinitions." .. tostring(k1) .. "." .. tostring(k2))
					end
				end
			end
		end
	end
	for k1,v1 in pairs(TraitClothingSelectionDefinitions) do
		-- Female, Male
		for k2,v2 in pairs(v1) do
			if k2 ~= "Female" and k2 ~= "Male" then
				error("expected Female or Male in TraitClothingSelectionDefinitions." .. tostring(k1))
			end
			for locationId,v3 in pairs(v2) do
				if bodyLocationGroup:indexOf(locationId) == -1 then
					error("unknown BodyLocation \"" .. tostring(locationId) .. "\" in TraitClothingSelectionDefinitions." .. tostring(k1) .. "." .. tostring(k2))
				end
				for _,fullType in ipairs(v3.items) do
					if not ScriptManager.instance:FindItem(fullType) then
						error("unknown item type \"" .. tostring(fullType) .. "\" in TraitClothingSelectionDefinitions." .. tostring(k1) .. "." .. tostring(k2))
					end
				end
			end
		end
	end
end

function CharacterCreationMain:shouldShowAllOutfits()
	if getDebug() and getDebugOptions():getBoolean("Character.Create.AllOutfits") then return true end
	return getSandboxOptions():getAllClothesUnlocked()
end

function CharacterCreationMain:checkAllClothingOptions()
	if self:shouldShowAllOutfits() then
		if not self.clothingDebugCreated then
			self:initClothingDebug()
			CharacterCreationMain.forceUpdateCombo = true
			self:disableBtn()
		end
	else
		if self.clothingDebugCreated then
			self.clothingDebugCreated = false
			self:initClothing()
			CharacterCreationMain.forceUpdateCombo = true
			self:disableBtn()
		end
	end
end

function CharacterCreationMain:initClothing()
	if getDebug() then
		self:debugClothingDefinitions()
	end

	self.clothingWidgets = {}
	
	local desc = MainScreen.instance.desc;
	local default = ClothingSelectionDefinitions.default;
	if MainScreen.instance.desc:isFemale() then
		self:doClothingCombo(default.Female, true);
	else
		self:doClothingCombo(default.Male, true);
	end
	
	local profession = ClothingSelectionDefinitions[desc:getProfession()];
	if profession then
		if MainScreen.instance.desc:isFemale() then
			self:doClothingCombo(profession.Female, false);
		else
			if profession.Male then -- most of the time there's no diff between male/female outfit, so i didn't created them both
				self:doClothingCombo(profession.Male, false);
			else
				self:doClothingCombo(profession.Female, false);
			end
		end
	end

	-- now we apply clothing options from traits (new to b42)
    if not CharacterCreationProfession.instance.listboxTraitSelected or not CharacterCreationProfession.instance.listboxTraitSelected.items then
        return
    end
--     print("CharacterCreationProfession.instance.listboxTraitSelected.items - " .. tostring(CharacterCreationProfession.instance.listboxTraitSelected.items))
--     if not CharacterCreationProfession.instance.listboxTraitSelected.items then
--         print("No CharacterCreationProfession.instance.listboxTraitSelected.items")
--         return
--     end
	local traits = CharacterCreationProfession.instance.listboxTraitSelected.items
--     local traits = getWorld():getLuaTraits()

	for i, v in pairs(traits) do
	    if v then
-- 	        local trait = v.item
	        local trait = v.item:getType()
            print("TraitZ " .. tostring(trait))
            if TraitClothingSelectionDefinitions[trait] then
                local definition = TraitClothingSelectionDefinitions[trait]
                if MainScreen.instance.desc:isFemale() then
                    self:doClothingCombo(definition.Female, false);
                else
                    if definition.Male then -- most of the time there's no diff between male/female outfit, so i didn't created them both
                        self:doClothingCombo(definition.Male, false);
                    else
                        self:doClothingCombo(definition.Female, false);
                    end
                end
            end
        end
	end

	self:arrangeClothingUI()
end

function CharacterCreationMain:removeAllClothingWidgets()
	self.clothingPanel:tryRemoveChild(self.outfitLbl)
	self.clothingPanel:tryRemoveChild(self.outfitCombo)
	self.clothingPanel:tryRemoveChild(self.randomizeOutfitBtn)
	self.outfitLbl = nil
	self.outfitCombo = nil
	self.randomizeOutfitBtn = nil
	if self.clothingCombo then
		for i,v in pairs(self.clothingCombo) do
			self.clothingPanel:tryRemoveChild(self.clothingColorBtn[v.bodyLocation]);
			self.clothingPanel:tryRemoveChild(self.clothingComboLabel[v.bodyLocation]);
			self.clothingPanel:tryRemoveChild(self.clothingDecalCombo[v.bodyLocation]);
			self.clothingPanel:tryRemoveChild(self.clothingTextureCombo[v.bodyLocation]);
			self.clothingPanel:tryRemoveChild(v);
		end
	end
	self.clothingCombo = {};
	self.clothingColorBtn = {};
	self.clothingDecalCombo = {};
	self.clothingTextureCombo = {};
	self.clothingComboLabel = {};
	self.yOffset = UI_BORDER_SPACING+FONT_HGT_MEDIUM+6;
end

function CharacterCreationMain:doClothingCombo(definition, erasePrevious)
	if not self.clothingPanel then return; end
	
	-- reinit all combos
	if erasePrevious then
		self:removeAllClothingWidgets()
	end
	
	-- create new combo or populate existing one (for when having specific profession clothing)
	local desc = MainScreen.instance.desc;
	for bodyLocation, profTable in pairs(definition) do
		local combo = nil;
		if self.clothingCombo then
			combo = self.clothingCombo[bodyLocation]
		end
		if not combo then
			self:createClothingCombo(bodyLocation);
			combo = self.clothingCombo[bodyLocation];
			combo:addOptionWithData(getText("UI_characreation_clothing_none"), nil)
		end
		if erasePrevious then
			combo.options = {}
			combo:addOptionWithData(getText("UI_characreation_clothing_none"), nil)
		end
		
		for j,clothing in ipairs(profTable.items) do
			local item = ScriptManager.instance:FindItem(clothing)
			local displayName = item:getDisplayName()
			-- some clothing are president in default list AND profession list, so we can force a specific clothing in profession we already have
			if not combo:contains(displayName) then
				combo:addOptionWithData(displayName, clothing)
			end
		end
	end

	self:updateSelectedClothingCombo();
	
	self.clothingPanel:setScrollChildren(true)
	self.clothingPanel:setScrollHeight(self.yOffset)
end

function CharacterCreationMain:updateSelectedClothingCombo()
	if self.clothingDebugCreated then return; end
	local desc = MainScreen.instance.desc;
	if self.clothingCombo then
		for i,combo in pairs(self.clothingCombo) do
			combo.selected = 1;
			self.clothingColorBtn[combo.bodyLocation]:setVisible(false);
			self.clothingTextureCombo[combo.bodyLocation]:setVisible(false);
			-- we select the current clothing we have at this location in the combo
			local currentItem = desc:getWornItem(combo.bodyLocation);
			if currentItem then
				for j,v in ipairs(combo.options) do
					if v.text == currentItem:getDisplayName() then
						combo.selected = j;
						break
					end
				end
				self:updateColorButton(combo.bodyLocation, currentItem);
				self:updateClothingTextureCombo(combo.bodyLocation, currentItem);
			end
		end
	end
end

function CharacterCreationMain:updateColorButton(bodyLocation, clothing)
	self.clothingColorBtn[bodyLocation]:setVisible(false);
	-- if the item can be colored we add the colorpicker button
	if clothing and clothing:getClothingItem():getAllowRandomTint() then
		self.clothingColorBtn[bodyLocation]:setVisible(true);
		-- update color of button
		local color = clothing:getVisual():getTint(clothing:getClothingItem())
		self.clothingColorBtn[bodyLocation].backgroundColor = {r = color:getRedFloat(), g = color:getGreenFloat(), b = color:getBlueFloat(), a = 1}
	end
    self:arrangeClothingRightSideElements(bodyLocation)
end

function CharacterCreationMain:updateClothingTextureCombo(bodyLocation, clothing)
	self.clothingTextureCombo[bodyLocation]:setVisible(false);
	if not clothing then return end
	local clothingItem = clothing:getClothingItem()
	local textureChoices = clothingItem:hasModel() and clothingItem:getTextureChoices() or clothingItem:getBaseTextures()
	if textureChoices and (textureChoices:size() > 1) then
		local textureChoice = clothingItem:hasModel() and clothing:getVisual():getTextureChoice() or clothing:getVisual():getBaseTexture()
		local combo = self.clothingTextureCombo[bodyLocation];
		combo:setVisible(true);
		combo.options = {}
		for i=0,textureChoices:size() - 1 do
			local text = getText("UI_ClothingTextureType", i + 1)
			combo:addOptionWithData(text, textureChoices:get(i))
			if i == textureChoice then
				combo.selected = i + 1;
			end
		end
	end
    self:arrangeClothingRightSideElements(bodyLocation)
end

function CharacterCreationMain:initClothingDebug()
	if self.clothingDebugCreated then
		return;
	end

	-- May be called during creation
	if not self.chestHairLbl then return end

	self:removeAllClothingWidgets()

	self.outfitLbl = ISLabel:new(0, self.yOffset, BUTTON_HGT, getText("UI_ClothingType_Outfit"), 1, 1, 1, 1, UIFont.Small)
	self.outfitLbl:initialise()
	self.clothingPanel:addChild(self.outfitLbl)

	self.outfitCombo = ISComboBox:new(UI_BORDER_SPACING, self.yOffset, 0, BUTTON_HGT, self, CharacterCreationMain.onOutfitSelected);
	self.outfitCombo:initialise()
	self.clothingPanel:addChild(self.outfitCombo)

	local button = ISButton:new(self.outfitCombo:getRight() + UI_BORDER_SPACING, self.yOffset, 15, BUTTON_HGT, getText("UI_mapspawn_random"), self)
	button:setOnClick(CharacterCreationMain.onRandomizeOutfitClicked)
	button:initialise()
	self.clothingPanel:addChild(button)
	self.randomizeOutfitBtn = button

	self.clothingWidgets = {}
	table.insert(self.clothingWidgets, { self.outfitCombo, button })

	self.yOffset = self.yOffset + BUTTON_HGT + UI_BORDER_SPACING;

	local group = BodyLocations.getGroup("Human")
	local allLoc = group:getAllLocations();

--	print("CREATE CLOTHING DEBUG?")
	-- sort the list of clothing groups alphabetically based on translation text
	local sorted = {}
	for i=0, allLoc:size()-1 do
		local id = allLoc:get(i):getId()
		sorted[i+1] = {id, getText("UI_ClothingType_" .. id)}
	end
	table.sort(sorted, function(a,b) return a[2] < b[2] end)
	for _, v in ipairs(sorted) do
		self:createClothingComboDebug(v[1])
	end

	self:arrangeClothingUI()

	self.clothingDebugCreated = true;

	self.clothingPanel:setScrollChildren(true)
	self.clothingPanel:setScrollHeight(self.yOffset)
end

function CharacterCreationMain:setVisible(bVisible, joypadData)
	if self.javaObject == nil then
		self:instantiate();
	end
	
	ISPanelJoypad.setVisible(self, bVisible, joypadData)
	
	if bVisible and MainScreen.instance.desc then
		self:randomGenericOutfit();
		self:checkAllClothingOptions()
		self:onResolutionChange(self.width, self.height, self.width, self.height)
	end
end

function CharacterCreationMain:disableBtn()
	-- May be called during creation
	if not self.chestHairLbl then return end
	local desc = MainScreen.instance.desc
	if MainScreen.instance.desc:isFemale() then
		self.genderCombo.selected = 1
	else
		self.genderCombo.selected = 2
	end
	local visible = not desc:isFemale()
	self.chestHairLbl:setVisible(visible)
	self.chestHairTickBox:setVisible(visible)
	self.beardTypeLbl:setVisible(visible)
	self.beardTypeCombo:setVisible(visible)
	self.beardRect:setVisible(visible)
	self.beardLbl:setVisible(visible)
	self.beardStubbleLbl:setVisible(visible)
	self.beardStubbleTickBox:setVisible(visible)
	if visible then
		self.characterPanel:setScrollHeight(self.beardStubbleTickBox:getBottom() + UI_BORDER_SPACING)
	else
		self.characterPanel:setScrollHeight(self.hairStubbleTickBox:getBottom() + UI_BORDER_SPACING)
	end
	self.characterPanel:positionRelativeToScrollBar()
	
	-- Changing male <-> female, update combobox choices.
	if self.female ~= desc:isFemale() or CharacterCreationMain.forceUpdateCombo then
		CharacterCreationMain.forceUpdateCombo = false;
		self.female = desc:isFemale()
		
		self.hairTypeCombo.options = {}
		local hairStyles = getAllHairStyles(desc:isFemale())
		for i=1,hairStyles:size() do
			local styleId = hairStyles:get(i-1)
			local hairStyle = self.female and getHairStylesInstance():FindFemaleStyle(styleId) or getHairStylesInstance():FindMaleStyle(styleId)
			local label = styleId
			if label == "" then
				label = getText("IGUI_Hair_Bald")
			else
				label = getText("IGUI_Hair_" .. label);
			end
			if not hairStyle:isNoChoose() then
				self.hairTypeCombo:addOptionWithData(label, hairStyles:get(i-1))
			end
		end
		
		self.beardTypeCombo.options = {}
		if desc:isFemale() then
			-- no bearded ladies
		else
			local beardStyles = getAllBeardStyles()
			for i=1,beardStyles:size() do
				local label = beardStyles:get(i-1)
				if label == "" then
					label = getText("IGUI_Beard_None")
				else
					label = getText("IGUI_Beard_" .. label);
				end
				self.beardTypeCombo:addOptionWithData(label, beardStyles:get(i-1))
			end
		end
		
		if self.outfitCombo then
			self.outfitCombo.options = {}
			self.outfitCombo:addOptionWithData(getText("UI_characreation_clothing_none"), nil)
			local outfits = getAllOutfits(desc:isFemale())
			for i=1,outfits:size() do
				self.outfitCombo:addOptionWithData(outfits:get(i-1), outfits:get(i-1))
			end
		end
		
		local fillCombo = function(bodyLocation)
			local combo = self.clothingCombo[bodyLocation]
			combo.options = {}
			combo:addOptionWithData(getText("UI_characreation_clothing_none"), nil)
			local items = getAllItemsForBodyLocation(bodyLocation)
			table.sort(items, function(a,b)
				local itemA = ScriptManager.instance:FindItem(a)
				local itemB = ScriptManager.instance:FindItem(b)
				return not string.sort(itemA:getDisplayName(), itemB:getDisplayName())
			end)
			for _,fullType in ipairs(items) do
				local item = ScriptManager.instance:FindItem(fullType)
				local displayName = item:getDisplayName()
				combo:addOptionWithData(displayName, fullType)
			end
		end
		
		if self.clothingDebugCreated then
			for bodyLocation,combo in pairs(self.clothingCombo) do
				fillCombo(bodyLocation)
			end
		end
	end
	
	self:syncUIWithTorso()
	self.hairTypeCombo.selected = self.hairType + 1
	
	if self.skinColors and self.skinColor then
		local color = self.skinColors[self.skinColor]
		self.skinColorButton.backgroundColor.r = color.r
		self.skinColorButton.backgroundColor.g = color.g
		self.skinColorButton.backgroundColor.b = color.b
	end
	
	local color = desc:getHumanVisual():getHairColor()
	self.hairColorButton.backgroundColor.r = color:getRedFloat()
	self.hairColorButton.backgroundColor.g = color:getGreenFloat()
	self.hairColorButton.backgroundColor.b = color:getBlueFloat()
	
	if MainScreen.instance.avatar then
		self.hairTypeCombo.selected = 1
		local hairModel = desc:getHumanVisual():getHairModel()
		for i=1,#self.hairTypeCombo.options do
			local name = self.hairTypeCombo:getOptionData(i):lower()
			if name:lower() == hairModel:lower() then
				self.hairTypeCombo.selected = i
				break
			end
		end
		
		self.beardTypeCombo.selected = 1
		local beardModel = desc:getHumanVisual():getBeardModel()
		for i=1,#self.beardTypeCombo.options do
			local name = self.beardTypeCombo:getOptionData(i):lower()
			if name:lower() == beardModel:lower() then
				self.beardTypeCombo.selected = i
				break
			end
		end
		
		if self.clothingDebugCreated then
			for bodyLocation,combo in pairs(self.clothingCombo) do
				local selected = combo.selected
				combo.selected = 1 -- None
				local item = desc:getWornItem(bodyLocation)
				local clothingItem = nil
				if item and item:getVisual() then
					combo.selected = combo:find(function(text, data, fullType)
						return data == fullType
					end, item:getFullType())
					if combo.selected == -1 then
                        combo.selected = 1
                    end
					clothingItem = item:getVisual():getClothingItem()
				end
				local textureChoices = clothingItem and (clothingItem:hasModel() and clothingItem:getTextureChoices() or clothingItem:getBaseTextures())
				if textureChoices and (textureChoices:size() > 1) then
					local textureChoice = clothingItem:hasModel() and item:getVisual():getTextureChoice() or item:getVisual():getBaseTexture()
					local combo = self.clothingTextureCombo[bodyLocation];
					combo:setVisible(true);
					combo.options = {}
					for i=0,textureChoices:size() - 1 do
						combo:addOptionWithData(getText("UI_characreation_Type").." " .. (i + 1), textureChoices:get(i))
						if i == textureChoice then
							combo:select(getText("UI_characreation_Type").." " .. (i + 1));
						end
					end
				else
					self.clothingTextureCombo[bodyLocation].options = {};
					self.clothingTextureCombo[bodyLocation]:setVisible(false);
				end
				if clothingItem and clothingItem:getAllowRandomTint() then
					local color = item:getVisual():getTint(clothingItem)
					self.clothingColorBtn[bodyLocation].backgroundColor = { r=color:getRedFloat(), g=color:getGreenFloat(), b=color:getBlueFloat(), a = 1 }
					self.clothingColorBtn[bodyLocation]:setVisible(true)
				else
					self.clothingColorBtn[bodyLocation].backgroundColor = { r=1, g=1, b=1, a = 1 }
					self.clothingColorBtn[bodyLocation]:setVisible(false)
				end
				if clothingItem and clothingItem:getDecalGroup() then
					-- Fill the decal combo if a different clothing item is now selected.
					if self.decalItem ~= item then
						self.decalItem = item
						local decalCombo = self.clothingDecalCombo[bodyLocation]
						decalCombo.options = {}
						local items = getAllDecalNamesForItem(item)
						for i=1,items:size() do
							decalCombo:addOptionWithData(items:get(i-1), items:get(i-1))
						end
					end
					local decalName = item:getVisual():getDecal(clothingItem)
					self.clothingDecalCombo[bodyLocation]:select(decalName)
					self.clothingDecalCombo[bodyLocation]:setVisible(true)
				elseif self.clothingDecalCombo[bodyLocation] then
					self.clothingDecalCombo[bodyLocation]:setVisible(false)
				end
			end
		end
	end
end

function CharacterCreationMain:onHairColorMouseDown(button, x, y)
	self.colorPickerHair:setX(button:getAbsoluteX())
	self.colorPickerHair:setY(button:getAbsoluteY() + button:getHeight())
	self.colorPickerHair:setPickedFunc(CharacterCreationMain.onHairColorPicked)
	local color = button.backgroundColor
	self.colorPickerHair:setInitialColor(ColorInfo.new(color.r, color.g, color.b, 1))
	self:showColorPicker(self.colorPickerHair)
	if self.characterPanel.joyfocus then
		self.characterPanel.joyfocus.focus = self.colorPickerHair
	end
	--[[
		local desc = MainScreen.instance.desc
		self.hairColor = button.internal;
		desc:getHumanVisual():setHairColor(button.internal)
		desc:getHumanVisual():setBeardColor(button.internal)
		CharacterCreationHeader.instance.avatarPanel:setSurvivorDesc(desc)
		self:disableBtn();
	--]]
end

function CharacterCreationMain:onHairColorPicked(color, mouseUp)
	self.hairColorButton.backgroundColor = { r=color.r, g=color.g, b=color.b, a = 1 }
	local desc = MainScreen.instance.desc
	local immutableColor = ImmutableColor.new(color.r, color.g, color.b, 1)
	desc:getHumanVisual():setHairColor(immutableColor)
	desc:getHumanVisual():setBeardColor(immutableColor)
	desc:getHumanVisual():setNaturalHairColor(immutableColor)
	desc:getHumanVisual():setNaturalBeardColor(immutableColor)
	self.avatarPanel:setSurvivorDesc(desc)
	self:disableBtn()
end

function CharacterCreationMain:syncTorsoWithUI()
	--[[
		local torsoNum = self.skinColor - 1
		if not MainScreen.instance.desc:isFemale() then
			-- white white+chest white+stubble white+chest+stubble
			-- black black+chest black+stubble black+chest+stubble
			torsoNum = torsoNum * 4
			if self.shavedHairCombo.selected == 1 then
				torsoNum = torsoNum + 2
			end
			if self.chestHairCombo.selected == 1 then
				torsoNum = torsoNum + 1
			end
		end
		MainScreen.instance.desc:setTorsoNumber(torsoNum)
		SurvivorFactory.setTorso(MainScreen.instance.desc)
		MainScreen.instance.avatar:reloadSpritePart()
	--]]
	self:disableBtn()
end

function CharacterCreationMain:syncUIWithTorso()
	local desc = MainScreen.instance.desc
	if not desc then return end
	self.skinColor = desc:getHumanVisual():getSkinTextureIndex() + 1
	if MainScreen.instance.desc:isFemale() then
		self.chestHairTickBox:setSelected(1, false)
		self.hairStubbleTickBox:setSelected(1, desc:getHumanVisual():hasBodyVisualFromItemType("Base.F_Hair_Stubble"))
	else
		self.chestHairTickBox:setSelected(1, desc:getHumanVisual():getBodyHairIndex() == 0)
		self.hairStubbleTickBox:setSelected(1, desc:getHumanVisual():hasBodyVisualFromItemType("Base.M_Hair_Stubble"))
		self.beardStubbleTickBox:setSelected(1, desc:getHumanVisual():hasBodyVisualFromItemType("Base.M_Beard_Stubble"))
	end
end

function CharacterCreationMain:onGenderSelected(combo)
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
	self:loadJoypadButtons();
end

function CharacterCreationMain:randomVoice()
	local bodyType = 2;
	if MainScreen.instance.desc:isFemale() then
		bodyType = 1;
	end;
	local voiceStyle;
	local choices = {};
	local voiceTypeCombo = self.voiceTypeCombo;
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

function CharacterCreationMain:randomGenericOutfit()
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
	if self:shouldShowAllOutfits() then
		self:initClothingDebug()
	else
		self:initClothing()
	end
	self:disableBtn()
end

-- dress randomly according to the table definition given
function CharacterCreationMain:dressWithDefinitions(definition, resetWornItems)
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
                    if self.clothingDebugCreated then
                        local location = item:IsClothing() and item:getBodyLocation() or item:canBeEquipped()
					    desc:setWornItem(location, item)
                    else
					    desc:setWornItem(bodyLocation, item)
					end
				end
			end
		end
	end
end

function CharacterCreationMain:onRandomCharacter()
	-- remove the beard
	MainScreen.instance.desc:getExtras():clear()

	local female = ZombRand(2) == 0
	MainScreen.instance.avatar:setFemale(female)
	MainScreen.instance.desc:setFemale(female)
	MainScreen.instance.desc:getHumanVisual():clear()
	self:setAvatarFromUI()
--		CharacterCreationProfession.instance:changeClothes();
	self:randomGenericOutfit();
	self:randomVoice();

	-- we random the name
	SurvivorFactory.randomName(MainScreen.instance.desc);

	self.forenameEntry:setText(MainScreen.instance.desc:getForename());
	self.surnameEntry:setText(MainScreen.instance.desc:getSurname());

	self:loadJoypadButtons();

	self:disableBtn();
end

function CharacterCreationMain:onChestHairSelected(index, selected)
	local desc = MainScreen.instance.desc
	desc:getHumanVisual():setBodyHairIndex(selected and 0 or -1)
	self.avatarPanel:setSurvivorDesc(desc)
end

function CharacterCreationMain:onShavedHairSelected(index, selected)
	local desc = MainScreen.instance.desc
	if selected then
		desc:getHumanVisual():addBodyVisualFromItemType(desc:isFemale() and "Base.F_Hair_Stubble" or "Base.M_Hair_Stubble")
	else
		desc:getHumanVisual():removeBodyVisualFromItemType(desc:isFemale() and "Base.F_Hair_Stubble" or "Base.M_Hair_Stubble")
	end
	self.avatarPanel:setSurvivorDesc(desc)
end

function CharacterCreationMain:onBeardStubbleSelected(index, selected)
	local desc = MainScreen.instance.desc
	if selected and not desc:isFemale() then
		desc:getHumanVisual():addBodyVisualFromItemType("Base.M_Beard_Stubble")
	else
		desc:getHumanVisual():removeBodyVisualFromItemType("Base.M_Beard_Stubble")
	end
	self.avatarPanel:setSurvivorDesc(desc)
end

function CharacterCreationMain:onSkinColorSelected(button, x, y)
	self.colorPickerSkin:setX(button:getAbsoluteX())
	self.colorPickerSkin:setY(button:getAbsoluteY() + button:getHeight())
	self.colorPickerSkin:setPickedFunc(CharacterCreationMain.onSkinColorPicked)
	local color = button.backgroundColor
	self.colorPickerSkin:setInitialColor(ColorInfo.new(color.r, color.g, color.b, 1))
	self:showColorPicker(self.colorPickerSkin)
	if self.characterPanel.joyfocus then
		self.characterPanel.joyfocus.focus = self.colorPickerSkin
	end
end

function CharacterCreationMain:onSkinColorPicked(color, mouseUp)
	self.skinColorButton.backgroundColor = { r=color.r, g=color.g, b=color.b, a = 1 }
	local desc = MainScreen.instance.desc
	desc:getHumanVisual():setSkinTextureIndex(self.colorPickerSkin.index - 1)
	self.avatarPanel:setSurvivorDesc(desc)
	self:disableBtn()
end

function CharacterCreationMain:onHairTypeSelected(combo)
	local desc = MainScreen.instance.desc
	self.hairType = combo.selected - 1
	local hair = combo:getOptionData(combo.selected)
	desc:getHumanVisual():setHairModel(hair) -- may be nil
	self.avatarPanel:setSurvivorDesc(desc)
	self:disableBtn()
end

function CharacterCreationMain:onBeardTypeSelected(combo)
	local desc = MainScreen.instance.desc
	local beard = combo:getOptionData(combo.selected)
	desc:getHumanVisual():setBeardModel(beard) -- may be nil
	self.avatarPanel:setSurvivorDesc(desc)
	self:disableBtn()
end

function CharacterCreationMain:onVoiceTypeSelected()
	local desc = MainScreen.instance.desc
	desc:setVoicePrefix(self:getVoicePrefix());
	desc:setVoiceType(self:getVoiceType());
	desc:setVoicePitch(self:getVoicePitch());
	self:disableBtn()
end

function CharacterCreationMain:onOutfitSelected(combo)
	local desc = MainScreen.instance.desc
	local outfitName = combo:getOptionData(combo.selected)
	desc:dressInNamedOutfit(outfitName)
	self.avatarPanel:setSurvivorDesc(desc)
	self:disableBtn()
	self:arrangeClothingUI()
end

function CharacterCreationMain:onRandomizeOutfitClicked()
	self:onOutfitSelected(self.outfitCombo)
end

function CharacterCreationMain:onClothingComboSelected(combo, bodyLocation)
	local desc = MainScreen.instance.desc
	desc:setWornItem(bodyLocation, nil)
	local itemType = combo:getOptionData(combo.selected)
	if itemType then
		local item = instanceItem(itemType)
		if item then
			desc:setWornItem(bodyLocation, item)
		end
	end
	self:updateSelectedClothingCombo();
	
	self.avatarPanel:setSurvivorDesc(desc)
	self:disableBtn()
	self:arrangeClothingUI()
end

function CharacterCreationMain:onClothingColorClicked(button, bodyLocation)
	self.colorPicker:setX(self.clothingPanel:getAbsoluteX() + self.clothingPanel:getXScroll() + button:getX() - self.colorPicker:getWidth())
	self.colorPicker:setY(self.clothingPanel:getAbsoluteY() + self.clothingPanel:getYScroll() + button:getY() + button:getHeight())
	self.colorPicker:setPickedFunc(CharacterCreationMain.onClothingColorPicked, bodyLocation)
	local color = button.backgroundColor
	self.colorPicker:setInitialColor(ColorInfo.new(color.r, color.g, color.b, 1))
	self:showColorPicker(self.colorPicker)
	if self.clothingPanel.joyfocus then
		button:setJoypadFocused(false)
		self.clothingPanel.joyfocus.focus = self.colorPicker
	end
end

function CharacterCreationMain:onClothingColorPicked(color, mouseUp, bodyLocation)
	self.clothingColorBtn[bodyLocation].backgroundColor = { r=color.r, g=color.g, b=color.b, a = 1 }
	local desc = MainScreen.instance.desc
	local item = desc:getWornItem(bodyLocation)
	if item then
		local color2 = ImmutableColor.new(color.r, color.g, color.b, 1)
		item:getVisual():setTint(color2)
		self.avatarPanel:setSurvivorDesc(desc)
	end
end

function CharacterCreationMain:onClothingTextureComboSelected(combo, bodyLocation)
	local desc = MainScreen.instance.desc
	local textureName = combo:getOptionData(combo.selected)
	local item = desc:getWornItem(bodyLocation)
	if textureName and item then
		if item:getClothingItem():hasModel() then
			item:getVisual():setTextureChoice(combo.selected - 1)
		else
			item:getVisual():setBaseTexture(combo.selected - 1)
		end
	end
	self.avatarPanel:setSurvivorDesc(desc)
	self:disableBtn()
	self:arrangeClothingUI()
end

function CharacterCreationMain:onClothingDecalComboSelected(combo, bodyLocation)
	local desc = MainScreen.instance.desc
	local decalName = combo:getOptionData(combo.selected)
	local item = desc:getWornItem(bodyLocation)
	if decalName and item then
		item:getVisual():setDecal(decalName)
	end
	self.avatarPanel:setSurvivorDesc(desc)
	self:disableBtn()
	self:arrangeClothingUI()
end

function CharacterCreationMain:createAvatar()
	if not MainScreen.instance.desc then
		MainScreen.instance.desc = SurvivorFactory.CreateSurvivor();
	end
	MainScreen.instance.avatar = IsoSurvivor.new(MainScreen.instance.desc, nil, 0, 0, 0);
	self:setAvatarFromUI()
end

function CharacterCreationMain:setAvatarFromUI()
	self.avatarPanel.avatarPanel:setSurvivorDesc(MainScreen.instance.desc)
end

function CharacterCreationMain:rescaleAvatarViewer()
	local x1 = UI_BORDER_SPACING + 1
	local y1 = UI_BORDER_SPACING + FONT_HGT_TITLE + x1
	local w1 = self.width - x1 * 2
	local h1 = self.height - y1 - BUTTON_HGT - UI_BORDER_SPACING - x1

	local w = math.floor(h1 - UI_BORDER_SPACING - BUTTON_HGT) / 2 --floor to remove rounding errors
	local h = h1
	self.avatarPanel:setHeight(h);
	self.avatarPanel:setWidth(w);
	self.avatarPanel:rescaleAvatarViewer()
	local offsetDivisor = getSandboxOptions():getAllClothesUnlocked() and 0.4 or 0.5
	self.avatarPanel:setX((w1-w)*offsetDivisor)
	self.avatarPanel:setY(y1)
end

function CharacterCreationMain:onOptionMouseDown(button, x, y)
	local joypadData = JoypadState.getMainMenuJoypad() or CoopCharacterCreation.getJoypad()
	if button.internal == "BACK" then
		self:setVisible(false)
		MainScreen.instance.charCreationProfession:setVisible(true, joypadData);
	end
	if button.internal == "RANDOM" then
		self:onRandomCharacter()
		self:arrangeClothingUI()
	end
	if button.internal == "NEXT" then
		--		MainScreen.instance.charCreationMain:setVisible(false);
		--		MainScreen.instance.charCreationMain:removeChild(MainScreen.instance.charCreationHeader);
		--		MainScreen.instance.charCreationProfession:addChild(MainScreen.instance.charCreationHeader);
		--		MainScreen.instance.charCreationProfession:setVisible(true, self.joyfocus);

		MainScreen.instance.charCreationMain:setVisible(false);
		-- set the player desc we build
		self:initPlayer();
		-- update the DB with first & last name
		if isClient() and getCore():getAccountUsed() then
			getCore():getAccountUsed():setPlayerFirstAndLastName(self.forenameEntry:getText() .. " " .. self.surnameEntry:getText())
			updateAccountToAccountList(getCore():getAccountUsed());
			getCore():setAccountUsed(nil);
		end
		-- set up the world
		if not getWorld():getMap() then
			getWorld():setMap("Muldraugh, KY");
		end
		if MainScreen.instance.createWorld then
			createWorld(getWorld():getWorld())
		end
		GameWindow.doRenderEvent(false);
--[[
		-- menu activated via joypad, we disable the joypads and will re-set them automatically when the game is started
		if self.joyfocus then
			local joypadData = self.joyfocus
			joypadData.focus = nil;
			updateJoypadFocus(joypadData)
			JoypadState.count = 0
			JoypadState.players = {};
			JoypadState.joypads = {};
			JoypadState.forceActivate = joypadData.id;
		end
--]]
		forceChangeState(LoadingQueueState.new());
	end
	if button.internal == "PLAYDEMOVOICE" then
		--FIXME: main menu music stops when this is set
		getSoundManager():setMusicState("InGame");
		getSoundManager():resumeSoundAndMusic();
		--stop the previous sound
		if self.soundRef ~= nil then
			if self.soundPlayer:isPlaying(self.soundRef) then
				self.soundPlayer:stopSound(self.soundRef);
				self.soundRef = 0;
			end
		end;
		self.soundRef = getSoundManager():playUISound(self:getVoicePrefix() .. "ShoutHey");
		if self.soundRef ~= 0 then
			--fix for position after quitting from the escape menu, this needs to be reset for the emitter
			if MainScreen.instance and (not MainScreen.instance.inGame) then
				self.soundPlayer:setPos(0, 0, 0);
			end;
			self.soundPlayer:setParameterValueByName(self.soundRef, "CharacterVoicePitch", self:getVoicePitch());
			self.soundPlayer:setParameterValueByName(self.soundRef, "CharacterVoiceType", self:getVoiceType());
			self.soundPlayer:tick();
		end;
	end;
	self:disableBtn();
end

function CharacterCreationMain:initPlayer()
	MainScreen.instance.desc:setForename(self.forenameEntry:getText());
	MainScreen.instance.desc:setSurname(self.surnameEntry:getText());
	MainScreen.instance.desc:setVoicePrefix(self:getVoicePrefix());
	MainScreen.instance.desc:setVoiceType(self:getVoiceType());
	MainScreen.instance.desc:setVoicePitch(self:getVoicePitch());
	--	if MainScreen.instance.charCreationProfession.listboxProf.selected > -1 then
	--		MainScreen.instance.desc:setProfession(MainScreen.instance.charCreationProfession.listboxProf.items[MainScreen.instance.charCreationProfession.listboxProf.selected].item:getType());
	--	else
	--		MainScreen.instance.desc:setProfession(MainScreen.instance.charCreationProfession.listboxProf.items[0].item:getType());
	--	end
end

--[[
-- draw the avatar of the player
function CharacterCreationMain:drawAvatar()
	if MainScreen.instance.avatar == nil then
		return;
	end
	local x = self:getAbsoluteX();
	local y = self:getAbsoluteY();
	x = x + 96/2;
	y = y + 165;

	MainScreen.instance.avatar:drawAt(x,y);
end
--]]

function CharacterCreationMain:update()
	ISPanel.update(self)
	self:checkAllClothingOptions()
end

function CharacterCreationMain:prerender()
	CharacterCreationMain.instance = self
	ISPanel.prerender(self);
	self:drawTextCentre(getText("UI_characreation_title"), self.width / 2, UI_BORDER_SPACING+1, 1, 1, 1, 1, UIFont.Title);
	--[[
		local avatar = MainScreen.instance.avatar
		if avatar ~= nil then
			avatar:getSprite():update(avatar:getSpriteDef())
		end
	--]]
	local facePreview = self.hairTypeCombo.expanded or self.beardTypeCombo.expanded
	self.avatarPanel:setFacePreview(facePreview)
	self.deleteBuildButton:setEnable(self.savedBuilds.options[self.savedBuilds.selected] ~= nil)
end

function CharacterCreationMain:render()
	ISPanel.render(self)
	local playerNum = 0
	self:renderJoypadNavigateOverlay(playerNum)
end

function CharacterCreationMain:onGainJoypadFocus(joypadData)
    if self:isDescendant(joypadData.switchingFocusFrom) then
        ISPanelJoypad.onGainJoypadFocus(self, joypadData);
        self:setISButtonForA(self.playButton);
        self:setISButtonForB(self.backButton);
        self:setISButtonForY(self.randomButton);
        self:loadJoypadButtons(joypadData);
    else
        self:loadJoypadButtons(joypadData);
        joypadData.focus = self.characterPanel
        updateJoypadFocus(joypadData)
	end
end

function CharacterCreationMain:onLoseJoypadFocus(joypadData)
	self.playButton:clearJoypadButton()
	self.backButton:clearJoypadButton()
	self.randomButton:clearJoypadButton()
--	self:clearJoypadFocus(joypadData)
	ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
end

--[[
function CharacterCreationMain:setJoypadFocusedAButton(focused)
	ISButton.setJoypadFocused(self, focused)
	self.ISButtonA = focused and self or nil
	self.isJoypad = focused
end

function CharacterCreationMain:setJoypadFocusedBButton(focused)
	ISButton.setJoypadFocused(self, focused)
	self.ISButtonB = focused and self or nil
	self.isJoypad = focused
end

function CharacterCreationMain:setJoypadFocusedYButton(focused)
	ISButton.setJoypadFocused(self, focused)
	CharacterCreationMain.instance.ISButtonY = focused and self or nil
	self.isJoypad = focused
end
--]]

function CharacterCreationMain:onJoypadNavigateStart(joypadData)
	self:onJoypadNavigateStart_Descendant(nil, joypadData)
end

function CharacterCreationMain:onJoypadNavigateStart_Descendant(descendant, joypadData)
	self.joypadNavigate = { left = self.presetPanel, up = self.characterPanel }
	local avatar = self.avatarPanel
	avatar.joypadNavigate = { left = self.characterPanel, right = self.clothingPanel, parent = self }
	self.characterPanel.joypadNavigate = { right = avatar, down = self.presetPanel, parent = self }
	self.clothingPanel.joypadNavigate = { left = avatar, parent = self }
	self.presetPanel.joypadNavigate = { up = self.characterPanel, parent = self }
end

function CharacterCreationMain:loadJoypadButtons(joypadData)
	self.characterPanel:loadJoypadButtons(joypadData)
end

function CharacterCreationMainCharacterPanel:loadJoypadButtons(joypadData)
	joypadData = joypadData or self.joyfocus
--[[
	if joypadData and #self.joypadButtonsY > 0 then
		return
	end
--]]
	local oldFocus = nil
	if joypadData then
		oldFocus = self:getJoypadFocus()
		self:clearJoypadFocus(joypadData)
	end
	self.joypadButtonsY = {};
	local charCreationMain = self.parent
	self:insertNewLineOfButtons(charCreationMain.forenameEntry)
	self:insertNewLineOfButtons(charCreationMain.surnameEntry)
	self:insertNewLineOfButtons(charCreationMain.genderCombo)
	local buttons = {}
	table.insert(buttons, charCreationMain.skinColorButton)
	table.insert(buttons, charCreationMain.clothingOutfitCombo)
	self:insertNewListOfButtons(buttons)
	if not MainScreen.instance.desc:isFemale() then
		self:insertNewLineOfButtons(charCreationMain.chestHairTickBox)
	end
	-- voice options
	self:insertNewLineOfButtons(charCreationMain.voiceTypeCombo);
	self:insertNewLineOfButtons(charCreationMain.voicePitchSlider);
	self:insertNewLineOfButtons(charCreationMain.voiceDemoButton);
	self:insertNewLineOfButtons(charCreationMain.hairTypeCombo);
	self:insertNewLineOfButtons(charCreationMain.hairColorButton);
	self:insertNewLineOfButtons(charCreationMain.hairStubbleTickBox)
	if not MainScreen.instance.desc:isFemale() then
		self:insertNewLineOfButtons(charCreationMain.beardTypeCombo);
		self:insertNewLineOfButtons(charCreationMain.beardStubbleTickBox)
	end
	self.joypadIndex = 1
	self.joypadIndexY = 1
	self.joypadButtons = self.joypadButtonsY[self.joypadIndexY];
--    self.joypadButtons[self.joypadIndex]:setJoypadFocused(true, joypadData)
	if oldFocus and oldFocus:isVisible() and joypadData.focus == self then
		self:setJoypadFocus(oldFocus, joypadData)
	end
end

function CharacterCreationMain:requiredSize(panel)
	local xMax = 0
	local yMax = 0
	local children = panel:getChildren()
	for _,child in pairs(children) do
	if child.Type ~= "ISRect" and child.Type ~= "ISScrollBar" then
--	if child:getRight() > xMax then print(child.x, child.width, child.x + child.width, child.Type) end
		xMax = math.max(xMax, child:getRight())
		yMax = math.max(yMax, child:getBottom())
--		child:setVisible(true)
	end
	end
	return xMax,yMax
end

function CharacterCreationMain:onResolutionChange(oldw, oldh, neww, newh)
	self:rescaleAvatarViewer()
	local x = self.avatarPanel:getRight() + UI_BORDER_SPACING
	self.characterPanel:setWidth(self.avatarPanel:getX() - UI_BORDER_SPACING*2 - 1)
	self.characterPanel:positionRelativeToScrollBar()
	self.clothingPanel:setX(x)
	self.clothingPanel:setWidth(self:getWidth() - x - UI_BORDER_SPACING - 1)

	self:arrangeClothingUI()

end

function CharacterCreationMain:getVoicePrefix()
	local voicePrefix = "VoiceFemale";
	local voiceStyle = self.voiceTypeCombo:getOptionData(self.voiceTypeCombo.selected);
	if voiceStyle and voiceStyle:getPrefix() ~= nil then
		voicePrefix = voiceStyle:getPrefix();
	end;
	return voicePrefix;
end

function CharacterCreationMain:getVoiceType()
	local voiceType = "0";
	local voiceStyle = self.voiceTypeCombo:getOptionData(self.voiceTypeCombo.selected);
	if voiceStyle and voiceStyle:getVoiceType() ~= nil then
		voiceType = voiceStyle:getVoiceType();
	end;
	return voiceType;
end

function CharacterCreationMain:getVoicePitch()
	return self.voicePitchSlider:getCurrentValue();
end

function CharacterCreationMain:showColorPicker(picker)
	if MainScreen.instance:isReallyVisible() then
		MainScreen.instance:removeChild(picker)
		MainScreen.instance:addChild(picker)
		picker:setCapture(true)
	else
		picker:removeFromUIManager()
		picker:addToUIManager()
		picker:setCapture(false)
	end
end

function CharacterCreationMain:onKeyRelease(key)
    if key == Keyboard.KEY_ESCAPE then
        self.backButton:forceClick()
        return
    end
    if key == Keyboard.KEY_RETURN then
        self.playButton:forceClick()
        return
    end
end

function CharacterCreationMain:new (x, y, width, height)
	local o = {};
	o = ISPanelJoypad:new(x, y, width, height);
	setmetatable(o, self);
	self.__index = self;
	o.x = x;
	o.y = y;
	o.backgroundColor = {r=0, g=0, b=0, a=0.8};
	o.borderColor = {r=1, g=1, b=1, a=0.5};
	o.itemheightoverride = {};
	o.anchorLeft = true;
	o.anchorRight = false;
	o.anchorTop = true;
	o.anchorBottom = false;
	o.colorPanel = {};
	o.rArrow = getTexture("media/ui/ArrowRight.png");
	o.disabledRArrow = getTexture("media/ui/ArrowRight_Disabled.png");
	o.lArrow = getTexture("media/ui/ArrowLeft.png");
	o.disabledLArrow = getTexture("media/ui/ArrowLeft_Disabled.png");
	CharacterCreationMain.instance = o;
	return o;
end
