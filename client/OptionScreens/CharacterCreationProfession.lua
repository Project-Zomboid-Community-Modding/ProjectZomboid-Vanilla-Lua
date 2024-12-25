--***********************************************************
--**                   ROBERT JOHNSON                      **
--***********************************************************

require"ISUI/ISPanel"
require"ISUI/ISButton"
require"ISUI/ISInventoryPane"
require"ISUI/ISResizeWidget"
require"ISUI/ISRichTextPanel"
require"ISUI/ISMouseDrag"

require"defines"

CharacterCreationProfession = ISPanelJoypad:derive("CharacterCreationProfession");
local CharacterCreationProfessionListBox = ISScrollingListBox:derive("CharacterCreationProfessionListBox")
local CharacterCreationProfessionPresetPanel = ISPanelJoypad:derive("CharacterCreationProfessionPresetPanel")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local FONT_HGT_TITLE = getTextManager():getFontHeight(UIFont.Title)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local JOYPAD_TEX_SIZE = 32

function CharacterCreationProfessionListBox:render()
    ISScrollingListBox.render(self)
    if self.joyfocus then
        self:drawRectBorder(0, -self:getYScroll(), self:getWidth(), self:getHeight(), 0.4, 0.2, 1.0, 1.0);
        self:drawRectBorder(1, 1-self:getYScroll(), self:getWidth()-2, self:getHeight()-2, 0.4, 0.2, 1.0, 1.0);
    end
end

function CharacterCreationProfessionListBox:onJoypadDown(button, joypadData)
    if button == Joypad.BButton then
        joypadData.focus = self.parent
        updateJoypadFocus(joypadData)
    else
        ISScrollingListBox.onJoypadDown(self, button, joypadData)
    end
end

function CharacterCreationProfessionListBox:onJoypadDirLeft(joypadData)
    joypadData.focus = self.joyfocusLeft
    updateJoypadFocus(joypadData)
end

function CharacterCreationProfessionListBox:onJoypadDirRight(joypadData)
    joypadData.focus = self.joyfocusRight
    updateJoypadFocus(joypadData)
end

function CharacterCreationProfessionListBox:onJoypadBeforeDeactivate(joypadData)
	self.parent:onJoypadBeforeDeactivate(joypadData)
end

-- -- -- -- --
-- -- -- -- --
-- -- -- -- --

function CharacterCreationProfessionPresetPanel:render()
    ISPanelJoypad.render(self)
    if self.joyfocus then
        self:drawRectBorder(0 - 4, 0 - 4, self:getWidth() + 4 + 4, self:getHeight() + 4 + 4, 0.4, 0.2, 1.0, 1.0)
        self:drawRectBorder(0 - 3, 0 - 3, self:getWidth() + 3 + 3, self:getHeight() + 3 + 3, 0.4, 0.2, 1.0, 1.0)
    end
end

function CharacterCreationProfessionPresetPanel:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
    if self.joypadButtons[self.joypadIndex] then
        self.joypadButtons[self.joypadIndex]:setJoypadFocused(true, joypadData)
    end
end

function CharacterCreationProfessionPresetPanel:onLoseJoypadFocus(joypadData)
    ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
    self:clearJoypadFocus()
end

function CharacterCreationProfessionPresetPanel:onJoypadDown(button, joypadData)
    if button == Joypad.BButton and not self:isFocusOnControl() then
        joypadData.focus = self.parent
        updateJoypadFocus(joypadData)
    else
        ISPanelJoypad.onJoypadDown(self, button, joypadData)
    end
end

function CharacterCreationProfessionPresetPanel:onJoypadDirUp(joypadData)
    if self:isFocusOnControl() then
        ISPanelJoypad.onJoypadDirUp(self, joypadData)
    else
        joypadData.focus = self.parent.listboxProf
        updateJoypadFocus(joypadData)
    end
end

function CharacterCreationProfessionPresetPanel:onJoypadDirLeft(joypadData)
    if self.joypadIndex == 1 then
        joypadData.focus = self.parent
        updateJoypadFocus(joypadData)
        return
    end
    ISPanelJoypad.onJoypadDirLeft(self, button, joypadData)
end

function CharacterCreationProfessionPresetPanel:onJoypadDirRight(joypadData)
    if self.joypadIndex == 3 then
        joypadData.focus = self.parent
        updateJoypadFocus(joypadData)
        return
    end
    ISPanelJoypad.onJoypadDirRight(self, button, joypadData)
end

-- -- -- -- --
-- -- -- -- --
-- -- -- -- --

function CharacterCreationProfession:initialise()
    ISPanelJoypad.initialise(self);
end

--************************************************************************--
--** ISPanel:instantiate
--**
--************************************************************************--
function CharacterCreationProfession:instantiate()
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

function CharacterCreationProfession:create()
    self.freeTraits = {};

	self.pointToSpend = 0;

	local w = self.width * 0.75;
	local h = self.height * 0.8;
	if (w < 768) then
		w = 768;
	end

	self.tablePadX = UI_BORDER_SPACING
	self.tableWidth = (self:getWidth() - 16 * 2 - self.tablePadX * 2) / 3
	self.topOfLists = UI_BORDER_SPACING*3 + FONT_HGT_MEDIUM + 1 + FONT_HGT_TITLE
	self.tooltipHgt = FONT_HGT_SMALL
	if self.width <= 1980 then
		self.tooltipHgt = FONT_HGT_SMALL * 2
	end
	self.belowLists = UI_BORDER_SPACING*2 + BUTTON_HGT + 1
	self.bottomOfLists = self:getHeight() - self.belowLists
	self.traitButtonHgt = BUTTON_HGT
	self.traitButtonPad = UI_BORDER_SPACING

	local traitButtonGap = self.traitButtonPad * 2 + self.traitButtonHgt
	local halfListHeight = (self.bottomOfLists - self.topOfLists - FONT_HGT_SMALL - traitButtonGap) / 2

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
	self:addChild(self.backButton);

    btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_btn_next"))
	self.playButton = ISButton:new(self.width - UI_BORDER_SPACING - btnWidth - 1, self.backButton.y, btnWidth, BUTTON_HGT, getText("UI_btn_next"), self, self.onOptionMouseDown);
	self.playButton.internal = "NEXT";
	self.playButton:initialise();
	self.playButton:instantiate();
	self.playButton:setAnchorLeft(false);
	self.playButton:setAnchorRight(true);
	self.playButton:setAnchorTop(false);
	self.playButton:setAnchorBottom(true);
	self.playButton:enableAcceptColor()
	self:addChild(self.playButton);

    btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_characreation_random"))
    self.randomButton = ISButton:new(self.playButton:getX() - UI_BORDER_SPACING - btnWidth, self.backButton.y, btnWidth, BUTTON_HGT, getText("UI_characreation_random"), self, self.randomizeTraits);
    self.randomButton:initialise();
    self.randomButton:instantiate();
    self.randomButton:setAnchorLeft(false);
    self.randomButton:setAnchorRight(true);
    self.randomButton:setAnchorTop(false);
    self.randomButton:setAnchorBottom(true);
    self:addChild(self.randomButton);

    btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_characreation_resettraits"))
    self.resetButton = ISButton:new(self.randomButton:getX() - UI_BORDER_SPACING - btnWidth, self.backButton.y, btnWidth, BUTTON_HGT, getText("UI_characreation_resettraits"), self, self.onOptionMouseDown);
    self.resetButton.internal = "RESETTRAITS";
    self.resetButton:initialise();
    self.resetButton:instantiate();
    self.resetButton:setAnchorLeft(false);
    self.resetButton:setAnchorRight(true);
    self.resetButton:setAnchorTop(false);
    self.resetButton:setAnchorBottom(true);
    self:addChild(self.resetButton);

    btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_InfoBtn"))
    self.infoBtn = ISButton:new(self.width - btnWidth - UI_BORDER_SPACING - 1, UI_BORDER_SPACING+1, btnWidth, BUTTON_HGT, getText("UI_InfoBtn"), self, self.onOptionMouseDown);
    self.infoBtn.internal = "INFO";
    self.infoBtn:initialise();
    self.infoBtn:instantiate();
    self.infoBtn:setAnchorLeft(false);
    self.infoBtn:setAnchorRight(true);
    self.infoBtn:setAnchorTop(true);
    self.infoBtn:setAnchorBottom(false);
    self:addChild(self.infoBtn);

	-- the selected trait list
	self.listboxTraitSelected = CharacterCreationProfessionListBox:new(((w / 3) * 2), self.topOfLists + FONT_HGT_SMALL, self.tableWidth, halfListHeight);
	self.listboxTraitSelected:initialise();
	self.listboxTraitSelected:instantiate();
	self.listboxTraitSelected:setAnchorLeft(true);
	self.listboxTraitSelected:setAnchorRight(false);
	self.listboxTraitSelected:setAnchorTop(true);
	self.listboxTraitSelected:setAnchorBottom(true);
	self.listboxTraitSelected.itemheight = BUTTON_HGT;
	self.listboxTraitSelected.selected = -1;
	self.listboxTraitSelected.doDrawItem = CharacterCreationProfession.drawTraitMap;
	self.listboxTraitSelected:setOnMouseDownFunction(self, CharacterCreationProfession.onSelectChosenTrait);
	self.listboxTraitSelected:setOnMouseDoubleClick(self, CharacterCreationProfession.onDblClickSelectedTrait);
    self.listboxTraitSelected.resetSelectionOnChangeFocus = true;
    self.listboxTraitSelected.drawBorder = true
    self.listboxTraitSelected.fontHgt = self.fontHgt
	self:addChild(self.listboxTraitSelected);

    -- the xp boost list (from trait/profession)
    self.listboxXpBoost = ISScrollingListBox:new(((w / 3) * 2), self.listboxTraitSelected:getY() + self.listboxTraitSelected:getHeight() + traitButtonGap, self.tableWidth, halfListHeight);
    self.listboxXpBoost:initialise();
    self.listboxXpBoost:instantiate();
    self.listboxXpBoost:setAnchorLeft(true);
    self.listboxXpBoost:setAnchorRight(false);
    self.listboxXpBoost:setAnchorTop(false);
    self.listboxXpBoost:setAnchorBottom(true);
    self.listboxXpBoost.itemheight = BUTTON_HGT;
    self.listboxXpBoost.selected = -1;
    self.listboxXpBoost.doDrawItem = CharacterCreationProfession.drawXpBoostMap;
    self.listboxXpBoost.resetSelectionOnChangeFocus = true;
    self.listboxXpBoost.drawBorder = true
    self.listboxXpBoost.fontHgt = self.fontHgt
    self:addChild(self.listboxXpBoost);

	-- the traits list choice
	self.listboxTrait = CharacterCreationProfessionListBox:new((w / 3), self.topOfLists + FONT_HGT_SMALL, self.tableWidth, halfListHeight);
	self.listboxTrait:initialise();
	self.listboxTrait:instantiate();
	self.listboxTrait:setAnchorLeft(true);
	self.listboxTrait:setAnchorRight(false);
	self.listboxTrait:setAnchorTop(true);
	self.listboxTrait:setAnchorBottom(true);
	self.listboxTrait.itemheight = BUTTON_HGT;
	self.listboxTrait.selected = -1;
	self:populateTraitList(self.listboxTrait);
	self.listboxTrait.doDrawItem = CharacterCreationProfession.drawTraitMap;
	self.listboxTrait:setOnMouseDownFunction(self, CharacterCreationProfession.onSelectTrait);
	self.listboxTrait:setOnMouseDoubleClick(self, CharacterCreationProfession.onDblClickTrait);
    self.listboxTrait.resetSelectionOnChangeFocus = true;
    self.listboxTrait.drawBorder = true
    self.listboxTrait.fontHgt = self.fontHgt
	self:addChild(self.listboxTrait);

    -- the bad traits list choice
    self.listboxBadTrait = CharacterCreationProfessionListBox:new((w / 3), self.listboxTrait:getY() + self.listboxTrait:getHeight() + traitButtonGap, self.tableWidth, halfListHeight);
    self.listboxBadTrait:initialise();
    self.listboxBadTrait:instantiate();
    self.listboxBadTrait:setAnchorLeft(true);
    self.listboxBadTrait:setAnchorRight(false);
    self.listboxBadTrait:setAnchorTop(false);
    self.listboxBadTrait:setAnchorBottom(true);
    self.listboxBadTrait.itemheight = BUTTON_HGT;
    self.listboxBadTrait.selected = -1;
    self:populateBadTraitList(self.listboxBadTrait);
    self.listboxBadTrait.doDrawItem = CharacterCreationProfession.drawTraitMap;
    self.listboxBadTrait:setOnMouseDownFunction(self, CharacterCreationProfession.onSelectBadTrait);
    self.listboxBadTrait:setOnMouseDoubleClick(self, CharacterCreationProfession.onDblClickBadTrait);
    self.listboxBadTrait.resetSelectionOnChangeFocus = true;
    self.listboxBadTrait.drawBorder = true
    self.listboxBadTrait.fontHgt = self.fontHgt
    self:addChild(self.listboxBadTrait);

    -- button to choose trait
    self.addTraitBtn = ISButton:new(self.listboxBadTrait:getX() + self.listboxBadTrait:getWidth() - 50, (self.listboxTrait:getY() + self.listboxTrait:getHeight()) + self.traitButtonPad, 50, self.traitButtonHgt, getText("UI_characreation_addtrait"), self, self.onOptionMouseDown);
    self.addTraitBtn.internal = "ADDTRAIT";
    self.addTraitBtn:initialise();
    self.addTraitBtn:instantiate();
    self.addTraitBtn:setAnchorLeft(true);
    self.addTraitBtn:setAnchorRight(false);
    self.addTraitBtn:setAnchorTop(false);
    self.addTraitBtn:setAnchorBottom(true);
    self.addTraitBtn:setEnable(false);
    --	self.addTraitBtn.borderColor = { r = 1, g = 1, b = 1, a = 0.1 };
    self:addChild(self.addTraitBtn);

    -- button to remove a selected trait
    self.removeTraitBtn = ISButton:new(self.listboxTrait:getX(), (self.listboxTrait:getY() + self.listboxTrait:getHeight()) + self.traitButtonPad, 50, self.traitButtonHgt, getText("UI_characreation_removetrait"), self, self.onOptionMouseDown);
    self.removeTraitBtn.internal = "REMOVETRAIT";
    self.removeTraitBtn:initialise();
    self.removeTraitBtn:instantiate();
    self.removeTraitBtn:setAnchorLeft(true);
    self.removeTraitBtn:setAnchorRight(false);
    self.removeTraitBtn:setAnchorTop(false);
    self.removeTraitBtn:setAnchorBottom(true);
    self.removeTraitBtn:setEnable(false);
    --	self.removeTraitBtn.borderColor = { r = 1, g = 1, b = 1, a = 0.1 };
    self:addChild(self.removeTraitBtn);

    -- button to choose trait
    self.addBadTraitBtn = ISButton:new(self.listboxBadTrait:getX() + self.listboxBadTrait:getWidth() - 50, (self.listboxBadTrait:getY() + self.listboxBadTrait:getHeight()) + self.traitButtonPad, 50, self.traitButtonHgt, getText("UI_characreation_addtrait"), self, self.onOptionMouseDown);
    self.addBadTraitBtn.internal = "ADDBADTRAIT";
    self.addBadTraitBtn:initialise();
    self.addBadTraitBtn:instantiate();
    self.addBadTraitBtn:setAnchorLeft(true);
    self.addBadTraitBtn:setAnchorRight(false);
    self.addBadTraitBtn:setAnchorTop(false);
    self.addBadTraitBtn:setAnchorBottom(true);
    self.addBadTraitBtn:setEnable(false);
    --	self.addTraitBtn.borderColor = { r = 1, g = 1, b = 1, a = 0.1 };
    self:addChild(self.addBadTraitBtn);

    -- the profession list choice
	self.listboxProf = CharacterCreationProfessionListBox:new(UI_BORDER_SPACING+1, self.topOfLists, self.tableWidth, self.bottomOfLists - self.topOfLists - traitButtonGap + UI_BORDER_SPACING);
	self.listboxProf:initialise();
	self.listboxProf:instantiate();
	self.listboxProf:setAnchorLeft(true);
	self.listboxProf:setAnchorRight(false);
	self.listboxProf:setAnchorTop(true);
	self.listboxProf:setAnchorBottom(true);
	self.listboxProf.itemheight = 70;
	self.listboxProf.selected = 1;
	self.listboxProf:setOnMouseDownFunction(self, CharacterCreationProfession.onSelectProf);
	self.listboxProf:setOnMouseDoubleClick(self, CharacterCreationProfession.onSelectProf);
	self:populateProfessionList(self.listboxProf);
	self.listboxProf.doDrawItem = CharacterCreationProfession.drawProfessionMap;
    self.listboxProf.drawBorder = true
    self.listboxProf.fontHgt = self.fontHgt
	self:addChild(self.listboxProf);

	self.tooltipRichText = ISRichTextPanel:new(UI_BORDER_SPACING+1, self.listboxProf:getBottom() + UI_BORDER_SPACING, self.width - UI_BORDER_SPACING - 200, self.tooltipHgt)
	self.tooltipRichText:setAnchorTop(false)
	self.tooltipRichText:setAnchorBottom(true)
	self.tooltipRichText:setAnchorRight(true)
	self.tooltipRichText:setMargins(0, 0, 0, 0)
	self.tooltipRichText.autosetheight = false
	self.tooltipRichText:setVisible(false) -- only visible using a controller
	self:addChild(self.tooltipRichText)

    self.presetPanel = CharacterCreationProfessionPresetPanel:new(0, self.backButton.y, 100, BUTTON_HGT)
    self.presetPanel:noBackground()
    self.presetPanel:setAnchorTop(false)
    self.presetPanel:setAnchorBottom(true)
    self:addChild(self.presetPanel)

    self.savedBuilds = ISComboBox:new(0, 0, 250, BUTTON_HGT, self, CharacterCreationProfession.loadBuild);
    self.savedBuilds:setAnchorTop(false);
    self.savedBuilds:setAnchorBottom(true);
    self.savedBuilds.openUpwards = true;
    self.presetPanel:addChild(self.savedBuilds)

    self.savedBuilds.noSelectionText = getText("UI_characreation_SelectToLoad")
    local saved_builds = BCRC.readSaveFile();
    for key,val in pairs(saved_builds) do
        self.savedBuilds:addOption(key)
    end
    self.savedBuilds.selected = 0 -- no selection

    self.saveBuildButton = ISButton:new(self.savedBuilds:getRight() + UI_BORDER_SPACING, 0, 50, BUTTON_HGT, getText("UI_characreation_BuildSave"), self, self.saveBuildStep1);
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
    self.presetPanel:setX(self.backButton:getRight() + UI_BORDER_SPACING)

    self.presetPanel:insertNewLineOfButtons(self.savedBuilds, self.saveBuildButton, self.deleteBuildButton)
    self.presetPanel.joypadIndex = 1
    self.presetPanel.joypadIndexY = 1

    self.listboxProf.joyfocusLeft = self.presetPanel
    self.listboxProf.joyfocusRight = self.listboxTrait
    self.listboxTrait.joyfocusLeft = self.listboxProf
    self.listboxTrait.joyfocusRight = self.listboxBadTrait
    self.listboxBadTrait.joyfocusLeft = self.listboxTrait
    self.listboxBadTrait.joyfocusRight = self.listboxTraitSelected
    self.listboxTraitSelected.joyfocusLeft = self.listboxBadTrait
    self.listboxTraitSelected.joyfocusRight = self.presetPanel

	self:onSelectProf(ProfessionFactory.getProfessions():get(0));
end

function CharacterCreationProfession:onSelectChosenTrait(item)
	if item:isFree() then
		self.removeTraitBtn:setEnable(false);
	else
		self.removeTraitBtn:setEnable(true);
	end
end

function CharacterCreationProfession:onSelectTrait(item)
	self.addTraitBtn:setEnable(true);
end

function CharacterCreationProfession:onSelectBadTrait(item)
    self.addBadTraitBtn:setEnable(true);
end

function CharacterCreationProfession:onDblClickSelectedTrait(item)
	self:removeTrait();
    self:checkXPBoost();
end

function CharacterCreationProfession:onDblClickBadTrait(item)
	self:addTrait(true);
    self:checkXPBoost();
end

function CharacterCreationProfession:onDblClickTrait(item)
    self:addTrait(false);
    self:checkXPBoost();
end

function CharacterCreationProfession:checkXPBoost()
    self.listboxXpBoost:clear()
    local levels = {}
    if self.listboxTraitSelected and self.listboxTraitSelected.items then
        for i,v in pairs(self.listboxTraitSelected.items) do
            if v.item:getXPBoostMap() then
                local table = transformIntoKahluaTable(v.item:getXPBoostMap())
                for perk,level in pairs(table) do
                    levels[perk] = (levels[perk] or 0) + level:intValue()
                end
            end
        end
    end
    if self.profession and self.profession:getXPBoostMap() then
        local table = transformIntoKahluaTable(self.profession:getXPBoostMap())
        for perk,level in pairs(table) do
            levels[perk] = (levels[perk] or 0) + level:intValue()
        end
    end
    levels[Perks.Fitness] = (levels[Perks.Fitness] or 0) + 5
    levels[Perks.Strength] = (levels[Perks.Strength] or 0) + 5
    for perk,level in pairs(levels) do
        if level < 0 then level = 0 end
        if level > 10 then level = 10 end
        self.listboxXpBoost:addItem(PerkFactory.getPerkName(perk), { perk = perk, level = level })
    end
    self.listboxXpBoost:sort()
end

function CharacterCreationProfession:onSelectProf(item)
    if self.profession ~= item then
		local removed = {}
		if self.profession then
			-- remove the previous free trait
			for i = 0, self.profession:getFreeTraits():size() - 1 do
				local freeTrait = TraitFactory.getTrait(self.profession:getFreeTraits():get(i));
				local label = freeTrait:getLabel();
				self.listboxTraitSelected:removeItem(label);	
				table.insert(removed, freeTrait);
				for k=#self.freeTraits, 1, -1 do
					if self.freeTraits[k]:getLabel() == label then
						table.remove(self.freeTraits, k);
					end
				end
			end
		end

        -- Remove chosen traits that are excluded by the profession's free traits.
        for i=self.listboxTraitSelected:size(),1,-1 do
            local selectedTrait = self.listboxTraitSelected.items[i].item
            for j=1,item:getFreeTraits():size() do
                local freeTrait = TraitFactory.getTrait(item:getFreeTraits():get(j-1))
                if freeTrait:getMutuallyExclusiveTraits():contains(selectedTrait:getType()) then
                    self.listboxTraitSelected.selected = i
                    self:removeTrait()
                end
            end
        end
		
        -- we add the free trait that our selected profession give us
        for i = 0, item:getFreeTraits():size() - 1 do
            local freeTrait = TraitFactory.getTrait(item:getFreeTraits():get(i));
            local newTrait = self.listboxTraitSelected:addItem(freeTrait:getLabel(), freeTrait);
            newTrait.tooltip = freeTrait:getDescription();
            table.insert(self.freeTraits, freeTrait);
            self:mutualyExclusive(freeTrait, false);
        end
		
        for _,trait in pairs(removed) do
            self:mutualyExclusive(trait, true)
        end

        self.profession = item;

		local desc = MainScreen.instance.desc;
		desc:setProfessionSkills(self.profession);
		desc:setProfession(self.profession:getType());

		self.cost = self.profession:getCost();
        self:changeClothes();
        self:checkXPBoost();
        CharacterCreationMain.sort(self.listboxTrait.items);
        CharacterCreationMain.invertSort(self.listboxBadTrait.items);
        CharacterCreationMain.sort(self.listboxTraitSelected.items);
        CharacterCreationMain.instance:disableBtn()
     end
end

function CharacterCreationMain.sortByCost(a, b)
    if a.item:getCost() == b.item:getCost() then
        return not string.sort(a.text, b.text)
    end
    return a.item:getCost() < b.item:getCost();
end

function CharacterCreationMain.sortByInvertCost(a, b)
    if a.item:getCost() == b.item:getCost() then
        return not string.sort(a.text, b.text)
    end
    return a.item:getCost() > b.item:getCost();
end

function CharacterCreationMain.sort(list)
    table.sort(list, CharacterCreationMain.sortByCost);
end

function CharacterCreationMain.invertSort(list)
    table.sort(list, CharacterCreationMain.sortByInvertCost);
end

---
-- This function loads the clothing values for each
-- profession in the game. If it can't find one for the
-- selected Profession it will initialise it with default
-- values instead (white shirt, black trousers).
--
-- by RoboMat
function CharacterCreationProfession:changeClothes()

end

function CharacterCreationProfession:setVisible(visible, joypadData)
	ISPanelJoypad.setVisible(self, visible, joypadData)
end

function CharacterCreationProfession:onOptionMouseDown(button, x, y)
    local joypadData = JoypadState.getMainMenuJoypad() or CoopCharacterCreation.getJoypad()
    if button.internal == "INFO" then
        if not self.infoRichText then
            self.infoRichText = ISModalRichText:new(getCore():getScreenWidth()/2-300,getCore():getScreenHeight()/2-300,600,600,getText("UI_CharacterCreation"), false);
            self.infoRichText.destroyOnClick = false;
            self.infoRichText:initialise();
            self.infoRichText:addToUIManager();
            self.infoRichText:setAlwaysOnTop(true);
            self.infoRichText.chatText:paginate();
            self.infoRichText.backgroundColor = {r=0, g=0, b=0, a=1};
            self.infoRichText:setHeight(self.infoRichText.chatText:getHeight() + 40);
            self.infoRichText:setY(getCore():getScreenHeight()/2-(self.infoRichText:getHeight()/2));
            if joypadData then
                self.infoRichText.prevFocus = joypadData.focus
            end
            self.infoRichText:setVisible(true, joypadData);
        else
            if joypadData then
                self.infoRichText.prevFocus = joypadData.focus
            end
            self.infoRichText:setVisible(not self.infoRichText:getIsVisible(), joypadData);
            self.infoRichText:bringToTop();
        end
    end
	if button.internal == "BACK" then
		if self.infoRichText then
			self.infoRichText:removeFromUIManager()
			self.infoRichText = nil
		end
		self:setVisible(false)
		if self.previousScreen == "NewGameScreen" then
			self.previousScreen = nil
			NewGameScreen.instance:setVisible(true, joypadData)
			return
		end
		if self.previousScreen == "LoadGameScreen" then
			self.previousScreen = nil
			LoadGameScreen.instance:setSaveGamesList()
			LoadGameScreen.instance:setVisible(true, joypadData)
			return
		end
		if self.previousScreen == "MapSpawnSelect" then
			self.previousScreen = nil
			MapSpawnSelect.instance:setVisible(true, joypadData)
			return
		end
		if self.previousScreen == "WorldSelect" then
			self.previousScreen = nil
			WorldSelect.instance:setVisible(true, joypadData)
			return
		end
		if self.previousScreen == "LastStandPlayerSelect" then
			self.previousScreen = nil
			LastStandPlayerSelect.instance:setVisible(true, joypadData)
			return
		end
		if self.previousScreen == "SandboxOptionsScreen" then
			self.previousScreen = nil
			SandboxOptionsScreen.instance:setVisible(true, joypadData)
			return
		end
		if getWorld():getGameMode() == "Multiplayer" then
			backToSinglePlayer()
			getCore():ResetLua("default", "exitJoinServer")
			return
		end
	end
	if button.internal == "NEXT" then
		if self.infoRichText then
			self.infoRichText:removeFromUIManager()
			self.infoRichText = nil
		end
		MainScreen.instance.charCreationProfession:setVisible(false);
		MainScreen.instance.charCreationMain:setVisible(true, joypadData);
--		-- set the player desc we build
--		self:initPlayer();
--		-- set up the world
--		if not getWorld():getMap() then
--			getWorld():setMap("Muldraugh, KY");
--        end
--		if MainScreen.instance.createWorld then
--			createWorld(getWorld():getWorld())
--		end
--        GameWindow.doRenderEvent(false);
--        -- menu activated via joypad, we disable the joypads and will re-set them automatically when the game is started
--        if self.joyfocus then
--            local joypadData = self.joyfocus
--            joypadData.focus = nil;
--            updateJoypadFocus(joypadData)
--            JoypadState.count = 0
--            JoypadState.players = {};
--            JoypadState.joypads = {};
--            JoypadState.forceActivate = joypadData.id;
--        end
--		forceChangeState(GameLoadingState.new());
	end
	if button.internal == "ADDTRAIT" then
		if self.listboxTrait.selected > 0 then
			self:addTrait(false);
            self:checkXPBoost();
		end
    end
    if button.internal == "ADDBADTRAIT" then
        if self.listboxBadTrait.selected > 0 then
            self:addTrait(true);
            self:checkXPBoost();
        end
    end
	if button.internal == "REMOVETRAIT" then
		if self.listboxTraitSelected.selected > 0 then
			self:removeTrait();
            self:checkXPBoost();
		end
	end
	if button.internal == "RESETTRAITS" then
		self:resetTraits();
	end
end

function CharacterCreationProfession:addTrait(bad)
    local list = self.listboxTrait;
    if bad then
        list = self.listboxBadTrait;
    end
	local selectedTrait = list.items[list.selected].text;
	-- points left calcul
	self.pointToSpend = self.pointToSpend - list.items[list.selected].item:getCost();
	-- remove from the available traits
	local newItem = self.listboxTraitSelected:addItem(selectedTrait, list.items[list.selected].item);
	newItem.tooltip = list.items[list.selected].tooltip;
	
	-- we add the free trait that our selected trait give us
    for i = 0, list.items[list.selected].item:getFreeTraits():size() - 1 do
        local freeTrait = TraitFactory.getTrait(list.items[list.selected].item:getFreeTraits():get(i));
        local newTrait = self.listboxTraitSelected:addItem(freeTrait:getLabel(), freeTrait);
        newTrait.tooltip = freeTrait:getDescription();
        table.insert(self.freeTraits, freeTrait);
        self:mutualyExclusive(freeTrait, false);
    end
	
	-- then we remove the mutualy exclusive traits
	self:mutualyExclusive(list.items[list.selected].item, false);
	-- add into our selected traits
    list:removeItem(selectedTrait);
	-- reset cursor
	self.listboxTraitSelected.selected = -1;
    self.listboxBadTrait.selected = -1;
    self.listboxTrait.selected = -1;
	self.removeTraitBtn:setEnable(false);
	self.addTraitBtn:setEnable(false);
    self.addBadTraitBtn:setEnable(false);
    CharacterCreationMain.sort(self.listboxTraitSelected.items);
end

function CharacterCreationProfession:mutualyExclusive(trait, bAdd)
	for i = 0, trait:getMutuallyExclusiveTraits():size() - 1 do
		local exclusiveTrait = trait:getMutuallyExclusiveTraits():get(i);
        exclusiveTrait = TraitFactory.getTrait(exclusiveTrait);
		if exclusiveTrait:isFree() then
			-- nothing
		elseif not bAdd then
			-- remove from our available traits list the exclusive ones
            if exclusiveTrait:getCost() > 0 then
                self.listboxTrait:removeItem(exclusiveTrait:getLabel());
            else
                self.listboxBadTrait:removeItem(exclusiveTrait:getLabel());
            end
		elseif not self:isTraitExcluded(exclusiveTrait) then
			-- add the previously removed exclusive trait to the available ones
            local newItem = {};
            if exclusiveTrait:getCost() > 0 then
			    newItem = self.listboxTrait:addItem(exclusiveTrait:getLabel(), exclusiveTrait);
            else
                newItem = self.listboxBadTrait:addItem(exclusiveTrait:getLabel(), exclusiveTrait);
            end
			newItem.tooltip = exclusiveTrait:getDescription();
		end
	end
end

function CharacterCreationProfession:isTraitExcluded(trait)
	for i=1,self.listboxTraitSelected:size() do
		local selectedTrait = self.listboxTraitSelected.items[i].item
		local excludedTraits = selectedTrait:getMutuallyExclusiveTraits()
		if excludedTraits:contains(trait:getType()) then
			return true
		end
	end
	return false
end

function CharacterCreationProfession:removeTrait()
	local trait = self.listboxTraitSelected.items[self.listboxTraitSelected.selected].item
	if not trait:isFree() then
		-- remove from the selected traits
		self.listboxTraitSelected:removeItem(trait:getLabel());
		-- points left calcul
		self.pointToSpend = self.pointToSpend + trait:getCost();
		-- add to available traits
        local newItem = {};
        if trait:getCost() > 0 then
    		newItem = self.listboxTrait:addItem(trait:getLabel(), trait);
        else
            newItem = self.listboxBadTrait:addItem(trait:getLabel(), trait);
        end
		
		-- we add the free trait that our selected trait give us
		local removed = {}
		for i = 0, trait:getFreeTraits():size() - 1 do
			local freeTrait = TraitFactory.getTrait(trait:getFreeTraits():get(i));
			local label = freeTrait:getLabel();
			self.listboxTraitSelected:removeItem(label);	
			table.insert(removed, freeTrait);
			for k=#self.freeTraits, 1, -1 do
				if self.freeTraits[k]:getLabel() == label then
					table.remove(self.freeTraits, k);
				end
			end
		end
		
		
		newItem.tooltip = trait:getDescription();
		-- add traits excluded by the removed trait back to the available-traits lists
		self:mutualyExclusive(trait, true);
		-- reset cursor
		self.listboxTraitSelected.selected = -1;
		self.listboxTrait.selected = -1;
        self.listboxBadTrait.selected = -1;
		self.removeTraitBtn:setEnable(false);
		self.addTraitBtn:setEnable(false);
        self.addBadTraitBtn:setEnable(false);
        CharacterCreationMain.sort(self.listboxTrait.items);
        CharacterCreationMain.invertSort(self.listboxBadTrait.items);
	end
end

function CharacterCreationProfession:update()
	ISPanelJoypad.update(self)
	self.deleteBuildButton:setEnable(self.savedBuilds.selected ~= 0)
end

function CharacterCreationProfession:prerender()
    CharacterCreationProfession.instance = self
	ISPanel.prerender(self);
	self:drawTextCentre(getText("UI_characreation_title2"), self.width / 2, UI_BORDER_SPACING+1, 1, 1, 1, 1, UIFont.Title);

	-- resize our stuff
	local listWidth = (self:getWidth() - (UI_BORDER_SPACING+1) * 2 - self.tablePadX * 2) / 3
	self.listboxProf:setWidth(listWidth);
	self.listboxTrait:setX(self.listboxProf:getX() + self.listboxProf:getWidth() + UI_BORDER_SPACING);
	self.listboxTrait:setWidth(listWidth);
    self.listboxBadTrait:setX(self.listboxTrait:getX());
    self.listboxBadTrait:setWidth(listWidth);
	self.listboxTraitSelected:setX(self.listboxTrait:getX() + self.listboxTrait:getWidth() + UI_BORDER_SPACING);
	self.listboxTraitSelected:setWidth(listWidth);
    self.listboxXpBoost:setX(self.listboxTraitSelected:getX());
    self.listboxXpBoost:setWidth(listWidth);
	self.addBadTraitBtn:setX(self.listboxBadTrait:getRight() - self.addBadTraitBtn:getWidth());
    self.addTraitBtn:setX(self.listboxTrait:getRight() - self.addTraitBtn:getWidth());
    self.removeTraitBtn:setX(self.listboxTraitSelected:getRight() - self.removeTraitBtn:getWidth());

	self.bottomOfLists = self:getHeight() - self.belowLists
	local traitButtonGap = self.traitButtonPad * 2 + self.traitButtonHgt
	local heightForHalfLists = self.bottomOfLists - self.topOfLists - FONT_HGT_SMALL - traitButtonGap*2 + UI_BORDER_SPACING
	local halfListHeight1 = math.floor(heightForHalfLists / 2)
	local halfListHeight2 = heightForHalfLists - halfListHeight1

	self.listboxTrait:setHeight(halfListHeight1)
	self.addTraitBtn:setY(self.listboxTrait:getY() + halfListHeight1 + self.traitButtonPad)

	self.listboxTraitSelected:setHeight(halfListHeight1)
	self.removeTraitBtn:setY(self.addTraitBtn:getY())
	
	self.listboxBadTrait:setY(self.listboxTrait:getY() + halfListHeight1 + traitButtonGap)
	self.listboxBadTrait:setHeight(halfListHeight2)
	self.addBadTraitBtn:setY(self.listboxBadTrait:getY() + halfListHeight2 + self.traitButtonPad)

	self.listboxXpBoost:setY(self.listboxBadTrait:getY())
	self.listboxXpBoost:setHeight(halfListHeight2)

	local joypadData = JoypadState.getMainMenuJoypad() or CoopCharacterCreation.getJoypad()
	if not joypadData or not joypadData:isConnected() then
		if not self.addTraitBtn:isVisible() then
			self.addTraitBtn:setVisible(true)
			self.addBadTraitBtn:setVisible(true)
			self.removeTraitBtn:setVisible(true)
			self.tooltipRichText:setVisible(false)

			self.addTraitBtn:setEnable(self.listboxTrait.items[self.listboxTrait.selected] ~= nil)
			self.addBadTraitBtn:setEnable(self.listboxBadTrait.items[self.listboxBadTrait.selected] ~= nil)
			self.removeTraitBtn:setEnable(self.listboxTraitSelected.items[self.listboxTraitSelected.selected] ~= nil)
		end
		return
	end
	if self.addTraitBtn:isVisible() then
		self.addTraitBtn:setVisible(false)
		self.addBadTraitBtn:setVisible(false)
		self.removeTraitBtn:setVisible(false)
		self.tooltipRichText:setVisible(true)
	end

	-- Update controller tooltip
	if self.listboxProf.joyfocus and self.listboxProf.items[self.listboxProf.selected] then
		self.tooltipLabel = self.listboxProf.items[self.listboxProf.selected].tooltip or ""
		self.tooltipLabel = self.tooltipLabel:gsub("\n", " <SPACE> <SPACE> <SPACE> ")
		self.tooltipColor = { r = 1.0, g = 1.0, b = 1.0 }
	elseif self.listboxTrait.joyfocus and self.listboxTrait.items[self.listboxTrait.selected] then
		self.tooltipLabel = self.listboxTrait.items[self.listboxTrait.selected].tooltip or ""
		self.tooltipLabel = self.tooltipLabel:gsub("\n", " <SPACE> <SPACE> <SPACE> ")
		self.tooltipColor = self:getTraitColor(self.listboxTrait.items[self.listboxTrait.selected].item)
	elseif self.listboxBadTrait.joyfocus and self.listboxBadTrait.items[self.listboxBadTrait.selected] then
		self.tooltipLabel = self.listboxBadTrait.items[self.listboxBadTrait.selected].tooltip or ""
		self.tooltipLabel = self.tooltipLabel:gsub("\n", " <SPACE> <SPACE> <SPACE> ")
		self.tooltipColor = self:getTraitColor(self.listboxBadTrait.items[self.listboxBadTrait.selected].item)
	elseif self.listboxTraitSelected.joyfocus and self.listboxTraitSelected.items[self.listboxTraitSelected.selected] then
		self.tooltipLabel = self.listboxTraitSelected.items[self.listboxTraitSelected.selected].tooltip or ""
		self.tooltipLabel = self.tooltipLabel:gsub("\n", " <SPACE> <SPACE> <SPACE> ")
		self.tooltipColor = self:getTraitColor(self.listboxTraitSelected.items[self.listboxTraitSelected.selected].item)
	else
		self.tooltipLabel = nil
	end
end

function CharacterCreationProfession:render()
	-- point to spend text
	local pointsY = self.playButton:getY() - FONT_HGT_MEDIUM - UI_BORDER_SPACING - 5

	local offset = self:negativeTraitOffset()
	local pointsWid = getTextManager():MeasureStringX(UIFont.Medium, tostring(offset))
	local offsetString = offset .. "";
	if getSandboxOptions():getOptionByName("NegativeTraitsPenalty"):getValue() ~= 1 then
        local hc = getCore():getGoodHighlitedColor()
        if offset > 0 then hc = getCore():getBadHighlitedColor() end
        self:drawTextRight(getText("UI_characreation_negativeTraitOffset"), self:getWidth() - pointsWid - 160 - 8, pointsY, 1, 1, 1, 1, UIFont.Medium);
        self:drawTextRight(offsetString, self:getWidth() - 160, pointsY, hc:getR(), hc:getG(), hc:getB(), 1, UIFont.Medium);
    end

	pointsWid = getTextManager():MeasureStringX(UIFont.Medium, tostring(self:PointToSpend()))
	self:drawTextRight(getText("UI_characreation_pointToSpend"), self:getWidth() - pointsWid - UI_BORDER_SPACING*2-1, pointsY, 1, 1, 1, 1, UIFont.Medium);
	if self:PointToSpend() < 0 then
		self.playButton:setEnable(false);
        self.playButton:setTooltip(getText("UI_charactercreation_needpoints"));
        local hc = getCore():getBadHighlitedColor()
        self:drawTextRight(self:PointToSpend() .. "", self:getWidth() - UI_BORDER_SPACING-1, pointsY, hc:getR(), hc:getG(), hc:getB(), 1, UIFont.Medium);
	else
		self.playButton:setEnable(true);
        self.playButton:setTooltip(nil);
        local hc = getCore():getGoodHighlitedColor()
        self:drawTextRight(self:PointToSpend() .. "", self:getWidth() - UI_BORDER_SPACING-1, pointsY, hc:getR(), hc:getG(), hc:getB(), 1, UIFont.Medium);
	end
	-- title over each table
	self:drawText(getText("UI_characreation_occupation"), UI_BORDER_SPACING, self.listboxProf:getY() - FONT_HGT_MEDIUM - 8, 1, 1, 1, 1, UIFont.Medium);
	self:drawText(getText("UI_characreation_availabletraits"), self.listboxTrait:getX(), self.listboxProf:getY() - FONT_HGT_MEDIUM - 8, 1, 1, 1, 1, UIFont.Medium);
	self:drawText(getText("UI_characreation_choosentraits"), self.listboxTraitSelected:getX(), self.listboxProf:getY() - FONT_HGT_MEDIUM - 8, 1, 1, 1, 1, UIFont.Medium);

	self:drawText(getText("UI_characreation_description"), self.listboxTrait:getX(), self.listboxTrait:getY() - FONT_HGT_SMALL, 1, 1, 1, 1, UIFont.Small);
	self:drawTextRight(getText("UI_characreation_cost"), self.listboxTrait:getX() + self.listboxTrait:getWidth() - 11, self.listboxTrait:getY() - FONT_HGT_SMALL, 1, 1, 1, 1, UIFont.Small);
	self:drawText(getText("UI_characreation_description"), self.listboxTraitSelected:getX(), self.listboxTraitSelected:getY() - FONT_HGT_SMALL, 1, 1, 1, 1, UIFont.Small);
	self:drawTextRight(getText("UI_characreation_cost"), self.listboxTraitSelected:getX() + self.listboxTraitSelected:getWidth() - 11, self.listboxTraitSelected:getY() - FONT_HGT_SMALL, 1, 1, 1, 1, UIFont.Small);
    self:drawText(getText("UI_characreation_MajorSkills"), self.listboxTraitSelected:getX(), self.listboxXpBoost:getY() - FONT_HGT_SMALL, 1, 1, 1, 1, UIFont.Small);

	if self.tooltipLabel and self.tooltipLabel ~= "" then
		if self.tooltipRichText.text ~= self.tooltipLabel then
			self.tooltipRichText.text = string.format(" <RGB:%.2f,%.2f,%.2f> %s", self.tooltipColor.r, self.tooltipColor.g, self.tooltipColor.b, self.tooltipLabel)
			self.tooltipRichText:paginate()
		end
	end
end

function CharacterCreationProfession:PointToSpend()
    local offset = 0
	if getSandboxOptions():getOptionByName("NegativeTraitsPenalty"):getValue() ~= 1 then offset = self:negativeTraitOffset() end
	if SandboxVars and SandboxVars.CharacterFreePoints then
		return self.pointToSpend + self.cost + SandboxVars.CharacterFreePoints - offset
	end
	return self.pointToSpend + self.cost - offset;
end

-- fetch all our profession to populate our list box
function CharacterCreationProfession:populateProfessionList(list)
	local professionList = ProfessionFactory.getProfessions();
	for i = 0, professionList:size() - 1 do
		local newitem = list:addItem(i, professionList:get(i));
        newitem.tooltip = professionList:get(i):getDescription();
	end
end

-- fetch all our traits to populate our list box
function CharacterCreationProfession:populateTraitList(list)
	local traitList = TraitFactory.getTraits();
	for i = 0, traitList:size() - 1 do
		local trait = traitList:get(i);
		if not trait:isFree() and trait:getCost() > 0 and not trait:isRemoveInMP() then
			local newItem = list:addItem(trait:getLabel(), trait);
			newItem.tooltip = trait:getDescription();
		end
	end
end

function CharacterCreationProfession:populateBadTraitList(list)
    local traitList = TraitFactory.getTraits();
    for i = 0, traitList:size() - 1 do
        local trait = traitList:get(i);
        if not trait:isFree() and trait:getCost() < 0 and not trait:isRemoveInMP() then
            local newItem = list:addItem(trait:getLabel(), trait);
            newItem.tooltip = trait:getDescription();
        end
    end
end

function CharacterCreationProfession:negativeTraitOffset()
--     local offset = self.possibleNegativeTraitOffset()

    local penalty = getSandboxOptions():getOptionByName("NegativeTraitsPenalty"):getValue()
    if penalty == 1 then return 0 end
    local offset = 0
    local traits = #self.listboxTraitSelected.items
    if traits > 0 then
        for i,v in pairs(self.listboxTraitSelected.items) do
            if v.item:getCost() < 0 then offset = offset + 1 end
        end
    end
    if penalty == 2 and offset > 0 then
        offset = math.floor(offset/3)
    elseif penalty == 3 and offset > 0 then
        offset = math.floor(offset/2)
    elseif penalty == 4 and offset > 0 then
        offset = offset - 1
    end
    return offset
end

function CharacterCreationProfession:drawXpBoostMap(y, item, alt)

    local dy = (self.itemheight - self.fontHgt) / 2
    local hc = getCore():getGoodHighlitedColor()
    local scrollBarWidth = 13
    self:drawText(item.text, UI_BORDER_SPACING, y + dy, hc:getR(), hc:getG(), hc:getB(), 1, UIFont.Small);

    local percentage = "+ 75%";
    if item.item.level == 2 then
        percentage = "+ 100%";
    elseif item.item.level >= 3 then
        percentage = "+ 125%";
    end

    local blitH = FONT_HGT_SMALL
    local blitW = math.floor(blitH / (10/3))
    local blitGap = math.floor(blitW/4)

    local blitXOffset = getTextManager():MeasureStringX(UIFont.Small, "+ 100%")+scrollBarWidth
    local greenBlitsX = self.width - (blitXOffset + 12 * (blitW+blitGap))
    local yy = y

    for i = 1,item.item.level do
        self:drawTextureScaled(CharacterCreationProfession.instance.whiteBar, greenBlitsX+(i * (blitW+blitGap)), (yy) + dy, blitW, blitH, 1, hc:getR(), hc:getG(), hc:getB())
    end
    if item.item.perk ~= Perks.Fitness and item.item.perk ~= Perks.Strength then
        self:drawTextRight(percentage, self.width - UI_BORDER_SPACING-scrollBarWidth, yy + dy, hc:getR(), hc:getG(), hc:getB(), 1, UIFont.Small);
    end

    yy = yy + self.itemheight;

    self:drawRectBorder(0, (y), self:getWidth(), yy - y, 0.5, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    return yy;
end

function CharacterCreationProfession:getTraitColor(trait)
	local color
	if trait:getCost() > 0 then
        local hc = getCore():getGoodHighlitedColor()
        color = {r=hc:getR(), g=hc:getG(), b=hc:getB()}
	elseif trait:getCost() < 0 then
        local hc = getCore():getBadHighlitedColor()
        color = {r=hc:getR(), g=hc:getG(), b=hc:getB()}
	else
		color = {r = 1.0, g = 1.0, b = 1.0}
	end
	return color
end

-- draw the list of available traits
function CharacterCreationProfession:drawTraitMap(y, item, alt)
	-- the rect over our item
	self:drawRectBorder(0, (y), self:getWidth(), self.itemheight - 1, 0.5, self.borderColor.r, self.borderColor.g, self.borderColor.b);

	-- if we selected an item, we display a grey rect over it
    local isMouseOver = self.mouseoverselected == item.index and not self:isMouseOverScrollBar()
	if self.selected == item.index then
		self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15);
    elseif isMouseOver then
        self:drawRect(1, y + 1, self:getWidth() - 2, item.height - 4, 0.95, 0.05, 0.05, 0.05);
	end

	-- icon of the trait
	local tex = item.item:getTexture()
	if tex then
		self:drawTexture(tex, UI_BORDER_SPACING, y + (self.itemheight - tex:getHeight()) / 2, 1, 1, 1, 1);
	end

	-- get the right color (green if it's a good trait, red if not)
    local hc = getCore():getGoodHighlitedColor()
    local r = 1;
    local g = 1;
    local b = 1;
    -- if it cost point, it's a good trait
    if item.item:getCost() > 0 then
        r = hc:getR();
        g = hc:getG();
        b = hc:getB();
	elseif item.item:getCost() < 0 then
        hc = getCore():getBadHighlitedColor()
        r = hc:getR();
        g = hc:getG();
        b = hc:getB();
	end
	-- the name of the trait
	local x = UI_BORDER_SPACING;
	if item.item:getTexture() then
		x = item.item:getTexture():getWidth() + UI_BORDER_SPACING*2;
	end
    local dy = (self.itemheight - self.fontHgt) / 2
	self:drawText(item.item:getLabel(), x, y + dy, r, g, b, 0.9, UIFont.Small);

	-- the cost of the trait
	self:drawTextRight(item.item:getRightLabel(), self:getWidth() - UI_BORDER_SPACING*2, y + dy, r, g, b, 0.9, UIFont.Small);

	self.itemheightoverride[item.item:getLabel()] = self.itemheight;

	y = y + self.itemheightoverride[item.item:getLabel()];

	return y;
end

-- draw the list of profession
function CharacterCreationProfession:drawProfessionMap(y, item, alt)
	-- the rect over our item
	self:drawRectBorder(0, (y), self:getWidth(), self.itemheight - 1, 0.5, self.borderColor.r, self.borderColor.g, self.borderColor.b);

	-- if we selected an item, we display a grey rect over it
    local isMouseOver = self.mouseoverselected == item.index and not self:isMouseOverScrollBar()
	if self.selected == item.index then
		self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15);
    elseif isMouseOver then
        self:drawRect(1, y + 1, self:getWidth() - 2, item.height - 4, 0.95, 0.05, 0.05, 0.05);
	end

	-- icon of the profession
	if item.item:getTexture() then
		self:drawTexture(item.item:getTexture(), 8, y + (item.height - 64) / 2, 1, 1, 1, 1);
	end

	local x = 7;

	-- the name of the profession
	if item.item:getTexture() then
		x = 74;
	end
	self:drawText(item.item:getName(), x, y + (item.height - self.fontHgt) / 2, 0.9, 0.9, 0.9, 0.9, UIFont.Small);

	self.itemheightoverride[item.item:getName()] = self.itemheight;

	y = y + self.itemheightoverride[item.item:getName()];

	return y;
end

function CharacterCreationProfession.initWorld()
	if isDemo() then
		return
	end
	if getCore():getGameMode() == "Tutorial" then
		return
	end
	if MainScreen.instance == nil then
		return
	end

	getWorld():setLuaPlayerDesc(MainScreen.instance.desc);
	getWorld():getLuaTraits():clear()
	for i, v in pairs(CharacterCreationProfession.instance.listboxTraitSelected.items) do
		getWorld():addLuaTrait(v.item:getType());
	end

	local spawnRegion = MapSpawnSelect.instance.selectedRegion
	if not spawnRegion then
		-- possible to skip MapSpawnSelect by going from LoadGameScreen to CharacterCreationMain
		-- i.e., double-clicking an existing savefile with a dead character
		spawnRegion = MapSpawnSelect.instance:useDefaultSpawnRegion()
	end
	if not spawnRegion then
		error "no spawn region was chosen, don't know where to spawn the player"
		return
	end
	print('using spawn region '..tostring(spawnRegion.name))
	-- we generate the spawn point for the profession choose
	local spawn = spawnRegion.points[MainScreen.instance.desc:getProfession()];
	if not spawn then
		spawn = spawnRegion.points["unemployed"];
	end
	if not spawn then
		error "there is no spawn point table for the player's profession, don't know where to spawn the player"
		return
	end
	print(#spawn..' possible spawn points')
	local randSpawnPoint = spawn[(ZombRand(#spawn) + 1)];

    if randSpawnPoint.position then
        if randSpawnPoint.position == "center" then
            local cellSizeInSquares = getCellSizeInSquares()
            local cellX = ((getCellMaxX() - getCellMinX()) / 2) + getCellMinX();
            local cellY = ((getCellMaxY() - getCellMinY()) / 2) + getCellMinY();
            randSpawnPoint.posX = cellX * cellSizeInSquares + cellSizeInSquares / 2;
            randSpawnPoint.posY = cellY * cellSizeInSquares + cellSizeInSquares / 2;
            randSpawnPoint.posZ = 0;
        else
            error "Position is not valid. No spawn point has been set, canceling load"
            return
        end
    end

    if randSpawnPoint.worldX ~= nil then
        -- This is the old format with 300x300 cell coordinates.
        getWorld():setLuaPosX(randSpawnPoint.worldX * 300 + randSpawnPoint.posX);
        getWorld():setLuaPosY(randSpawnPoint.worldY * 300 + randSpawnPoint.posY);
        getWorld():setLuaPosZ(randSpawnPoint.posZ or 0);
    else
        -- This is the new format with square coordinates and no cell coordinates.
        getWorld():setLuaPosX(randSpawnPoint.posX);
        getWorld():setLuaPosY(randSpawnPoint.posY);
        getWorld():setLuaPosZ(randSpawnPoint.posZ or 0);
    end
end

function CharacterCreationProfession:onGainJoypadFocus(joypadData)
--    print("character profession gain focus");
    ISPanelJoypad.onGainJoypadFocus(self, joypadData);
    self:setISButtonForA(self.playButton);
    self:setISButtonForB(self.backButton);
    self:setISButtonForY(self.randomButton);
	self:setISButtonForX(self.resetButton);
	--    self.listboxProf.selected = -1;
end

function CharacterCreationProfession:onLoseJoypadFocus(joypadData)
	self.playButton:clearJoypadButton()
	self.backButton:clearJoypadButton()
	self.randomButton:clearJoypadButton()
	self.resetButton:clearJoypadButton()
	ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
end

function CharacterCreationProfession:onJoypadBeforeDeactivate(joypadData)
	-- Focus could be on one of the lists
	self.joyfocus = nil
end

function CharacterCreationProfession:onJoypadDirUp(joypadData)
    joypadData.focus = self.listboxProf
    updateJoypadFocus(joypadData)
end

function CharacterCreationProfession:onJoypadDirLeft(joypadData)
    joypadData.focus = self.presetPanel
    updateJoypadFocus(joypadData)
end

function CharacterCreationProfession:onJoypadDirRight(joypadData)
    joypadData.focus = self.presetPanel
    updateJoypadFocus(joypadData)
end

function CharacterCreationProfession:onResolutionChange(oldw, oldh, neww, newh)
	local w = neww * 0.75;
	local h = newh * 0.8;
	if (w < 768) then
		w = 768;
	end
	local screenWid = neww;
	local screenHgt = newh;
	self:setWidth(w)
	self:setHeight(h)
	self:setX((screenWid - w) / 2)
	self:setY((screenHgt - h) / 2)
	self:recalcSize()

end

function CharacterCreationProfession:new(x, y, width, height)
	-- using a virtual 100 height res for doing the UI, so it resizes properly on different rez's.

	local o = {}

	--o.data = {}
	o = ISPanelJoypad:new(x, y, width, height);
	setmetatable(o, self)
	self.__index = self
	o.x = x;
	o.y = y;
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.borderColor = {r=1, g=1, b=1, a=0.2};
    o.width = width
    o.height = height
	o.itemheightoverride = {};
	o.anchorLeft = true;
	o.anchorRight = false;
	o.anchorTop = true;
	o.anchorBottom = false;
	o.profession = nil;
    o.whiteBar = getTexture("media/ui/whitebar.png");
	o.cost = 0;
	o.fontHgt = getTextManager():getFontFromEnum(UIFont.Small):getLineHeight()
	CharacterCreationProfession.instance = o;
	return o
end

-- }}}
function CharacterCreationProfession.loadBuild(self, box) -- {{{
    local prof = box.options[box.selected];
    if prof == nil then return end;

    local saved_builds = BCRC.readSaveFile();
    local build = saved_builds[prof];
    if build == nil then return end;

    local traits = luautils.split(build, ";");

    self:resetBuild();
    for i=1,#self.listboxProf.items do
        if self.listboxProf.items[i].item:getType() == traits[1] then
            self.listboxProf.selected = i;
            self:onSelectProf(self.listboxProf.items[self.listboxProf.selected].item);
        end
    end

    for j=1,#traits do
        for i=1,#self.listboxTrait.items do
            if self.listboxTrait.items[i] ~= nil then
                local trait = self.listboxTrait.items[i].item;
                if trait:getType() == traits[j] then
                    self.listboxTrait.selected = i;
                    self:onOptionMouseDown(self.addTraitBtn);
                end
            end
        end
    end

    for j=1,#traits do
        for i=1,#self.listboxBadTrait.items do
            if self.listboxBadTrait.items[i] ~= nil then
                local trait = self.listboxBadTrait.items[i].item;
                if trait:getType() == traits[j] then
                    self.listboxBadTrait.selected = i;
                    self:onOptionMouseDown(self.addBadTraitBtn);
                end
            end
        end
    end
end

function CharacterCreationProfession:saveBuildValidate(text)
    return text ~= "" and not text:contains("/") and not text:contains("\\") and
        not text:contains(":") and not text:contains(";") and not text:contains('"')
end
-- }}}

function CharacterCreationProfession:presetExists(findText)
    return self.savedBuilds:find(function(text, data, findText)
        return text == findText
    end, findText) ~= -1
end

function CharacterCreationProfession:saveBuildStep1() -- {{{
	local text = self.savedBuilds.options[self.savedBuilds.selected] or ""
    if text == "" then
        text = self.listboxProf.items[self.listboxProf.selected].item:getName()
        if self:presetExists(text) then
            local index = 1
            while self:presetExists(string.format("%s %d", text, index)) do
                index = index + 1
            end
            text = string.format("%s %d", text, index)
        end
    end
    self.inputModal = BCRC.inputModal(true, nil, nil, nil, nil, text, CharacterCreationProfession.saveBuildStep2, self);
    self.inputModal.backgroundColor.a = 0.9
    self.inputModal:setValidateFunction(self, self.saveBuildValidate)
    local joypadData = JoypadState.getMainMenuJoypad() or CoopCharacterCreation.getJoypad()
    if joypadData then
        self.inputModal.param1 = joypadData
        joypadData.focus = self.inputModal
        updateJoypadFocus(joypadData)
    end
end
-- }}}
function CharacterCreationProfession:saveBuildStep2(button, joypadData, param2) -- {{{
    if joypadData then
        joypadData.focus = self.presetPanel
        updateJoypadFocus(joypadData)
    end

    if button.internal == "CANCEL" then
        return
    end

    local builds = BCRC.readSaveFile();

    local prof = self.listboxProf.items[self.listboxProf.selected].item:getType();
    local savestring = prof..";";
    for i=1,#self.listboxTraitSelected.items do
        if not self.listboxTraitSelected.items[i].item:isFree() then
            savestring = savestring..self.listboxTraitSelected.items[i].item:getType()..";";
        end
    end

    local savename = button.parent.entry:getText()
    if savename == '' then return end
    builds[savename] = savestring;

    local options = {};
    BCRC.writeSaveFile(builds);
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
--    luautils.okModal("Saved this build!", true);
end
-- }}}

function CharacterCreationProfession:deleteBuildStep1()
	local delBuild = self.savedBuilds.options[self.savedBuilds.selected]
	local screenW = getCore():getScreenWidth()
	local screenH = getCore():getScreenHeight()
	local modal = ISModalDialog:new((screenW - 230) / 2, (screenH - 120) / 2, 230, 120, getText("UI_characreation_BuildDeletePrompt", delBuild), true, self, CharacterCreationProfession.deleteBuildStep2);
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

function CharacterCreationProfession:deleteBuildStep2(button, joypadData) -- {{{
    if joypadData then
        joypadData.focus = self.presetPanel
        updateJoypadFocus(joypadData)
    end

    if button.internal == "NO" then return end
    
    local delBuild = self.savedBuilds.options[self.savedBuilds.selected];

    local builds = BCRC.readSaveFile();
    builds[delBuild] = nil;

    local options = {};
    BCRC.writeSaveFile(builds);
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
    self:loadBuild(self.savedBuilds)
--    luautils.okModal("Deleted build "..delBuild.."!", true);
end

function CharacterCreationProfession:randomizeTraits() -- {{{
    self:resetBuild();

    local size = #self.listboxProf.items;
    local prof = ZombRand(size)+1;
    self.listboxProf.selected = prof;
    self:onSelectProf(self.listboxProf.items[self.listboxProf.selected].item);

    local numTraits = ZombRand(5);
    for i=0,numTraits do
        self.listboxTrait.selected = ZombRand(#self.listboxTrait.items)+1;
        self:onOptionMouseDown(self.addTraitBtn);
    end

    local numBadTraits = ZombRand(5);
    for i=0,numBadTraits do
        self.listboxBadTrait.selected = ZombRand(#self.listboxBadTrait.items)+1;
        self:onOptionMouseDown(self.addBadTraitBtn);
    end

    local rescue = 1000;
    while rescue > 0 do
        rescue = rescue - 1;
        if self:PointToSpend() >= 0 and self:PointToSpend() <= 3 then
            rescue = 0;
        else
            if self:PointToSpend() < 0 then
                -- Points are negative, try to increase
                if ZombRand(2) == 0 then
                    -- remove a good trait
                    local rescue2 = 5;
                    while rescue2 > 0 do
                        local i = ZombRand(#self.listboxTraitSelected.items)+1;
                        if self.listboxTraitSelected.items[i].item:getCost() > 0 and math.abs(self.listboxTraitSelected.items[i].item:getCost()) <= math.abs(self:PointToSpend()) then
                            self.listboxTraitSelected.selected = i;
                            self:onOptionMouseDown(self.removeTraitBtn);
                        end
                        rescue2 = rescue2 - 1;
                    end
                else
                    -- add a bad trait
                    self.listboxBadTrait.selected = ZombRand(#self.listboxBadTrait.items)+1;
                    self:onOptionMouseDown(self.addBadTraitBtn);
                end
            else
                -- Points are too positive, try to decrease
                if ZombRand(2) == 0 then
                    -- remove a bad trait
                    local rescue2 = 5;
                    while rescue2 > 0 do
                        local i = ZombRand(#self.listboxTraitSelected.items)+1;
                        if self.listboxTraitSelected.items[i].item:getCost() < 0 and math.abs(self.listboxTraitSelected.items[i].item:getCost()) <= math.abs(self:PointToSpend()) then
                            self.listboxTraitSelected.selected = i;
                            self:onOptionMouseDown(self.removeTraitBtn);
                        end
                        rescue2 = rescue2 - 1;
                    end
                else
                    -- add a good trait
                    self.listboxTrait.selected = ZombRand(#self.listboxTrait.items)+1;
                    self:onOptionMouseDown(self.addTraitBtn);
                end
            end
        end
    end
end

function CharacterCreationProfession:resetBuild() -- {{{
    self.listboxProf.selected = 1;
    self:onSelectProf(self.listboxProf.items[self.listboxProf.selected].item);

    while #self.listboxTraitSelected.items > 0 do
        self.listboxTraitSelected.selected = 1;
        self:onOptionMouseDown(self.removeTraitBtn);
    end
end

function CharacterCreationProfession:resetTraits()
	self:onSelectProf(self.listboxProf.items[1].item);

	while #self.listboxTraitSelected.items > 0 do
		self.listboxTraitSelected.selected = 1;
		self:onOptionMouseDown(self.removeTraitBtn);
	end

	self:onSelectProf(self.listboxProf.items[self.listboxProf.selected].item);
end

BCRC = {};
BCRC.savefile = "saved_builds.txt";

function BCRC.inputModal(_centered, _width, _height, _posX, _posY, _text, _onclick, target, param1, param2) -- {{{
    -- based on luautils.okModal
    local posX = _posX or 0;
    local posY = _posY or 0;
    local width = _width or 230;
    local height = _height or 120;
    local centered = _centered;
    local txt = _text;
    local core = getCore();

    -- center the modal if necessary
    if centered then
        posX = core:getScreenWidth() * 0.5 - width * 0.5;
        posY = core:getScreenHeight() * 0.5 - height * 0.5;
    end

    -- ISModalDialog:new(x, y, width, height, text, yesno, target, onclick, player, param1, param2)
    local modal = ISTextBox:new(posX, posY, width, height, getText("UI_characreation_BuildSavePrompt"), _text or "", target, _onclick, param1, param2);
    modal:initialise();
    modal:setAlwaysOnTop(true)
    modal:setCapture(true)
    modal:addToUIManager();
    modal.yes:setTitle(getText("UI_btn_save"))
    modal.entry:focus()

    return modal;
end
-- }}}
function BCRC.readSaveFile() -- {{{
    local retVal = {};

    local saveFile = getFileReader(BCRC.savefile, true);
    local line = saveFile:readLine();
    while line ~= nil do
        local s = luautils.split(line, ":");
        retVal[s[1]] = s[2];
        line = saveFile:readLine();
    end
    saveFile:close();

    return retVal;
end
-- }}}
function BCRC.writeSaveFile(options) -- {{{
    local saved_builds = getFileWriter(BCRC.savefile, true, false); -- overwrite
    for key,val in pairs(options) do
        saved_builds:write(key..":"..val.."\n");
    end
    saved_builds:close();
end
-- }}}
BCRC.dump = function(o, lvl) -- {{{ Small function to dump an object.
    if lvl == nil then lvl = 5 end
    if lvl < 0 then return "SO ("..tostring(o)..")" end

    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
            if k == "prev" or k == "next" then
                s = s .. '['..k..'] = '..tostring(v);
            else
                if type(k) ~= 'number' then k = '"'..k..'"' end
                s = s .. '['..k..'] = ' .. BCRC.dump(v, lvl - 1) .. ',\n'
            end
        end
        return s .. '}\n'
    else
        return tostring(o)
    end
end
-- }}}
BCRC.pline = function (text) -- {{{ Print text to logfile
    print(tostring(text));
end

Events.OnInitWorld.Add(CharacterCreationProfession.initWorld);
