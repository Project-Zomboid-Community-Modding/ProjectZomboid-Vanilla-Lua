--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISButton"
require "ISUI/ISComboBox"
require "ISUI/ISPanel"
require "ISUI/ISUI3DModel"

CharacterCreationAvatar = ISPanel:derive("CharacterCreationAvatar")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

function CharacterCreationAvatar:createChildren()
	self.avatarBackgroundTexture = getTexture("media/ui/avatarBackgroundWhite.png")

	self.avatarPanel = ISUI3DModel:new(0, 0, self.width, self.height - UI_BORDER_SPACING - BUTTON_HGT)
	self.avatarPanel.backgroundColor = {r=0, g=0, b=0, a=0.0}
	self.avatarPanel.borderColor = {r=1, g=1, b=1, a=0.0}
	self:addChild(self.avatarPanel)
--	CharacterCreationHeader.instance:randomGenericOutfit()
	self.avatarPanel:setState("idle")
	self.avatarPanel:setDirection(IsoDirections.S)
	self.avatarPanel:setIsometric(false)
	self.avatarPanel:setDoRandomExtAnimations(true)
	self:setFacePreview(false)

	self.turnLeftButton = ISButton:new(self.avatarPanel.x, self.avatarPanel:getBottom()-BUTTON_HGT, BUTTON_HGT, BUTTON_HGT, "", self, self.onTurnChar)
	self.turnLeftButton.internal = "TURNCHARACTERLEFT"
	self.turnLeftButton:initialise()
	self.turnLeftButton:instantiate()
	self.turnLeftButton:setImage(getTexture("media/ui/ArrowLeft.png"))
	self:addChild(self.turnLeftButton)

	self.turnRightButton = ISButton:new(self.avatarPanel:getRight()-BUTTON_HGT, self.avatarPanel:getBottom()-BUTTON_HGT, BUTTON_HGT, BUTTON_HGT, "", self, self.onTurnChar)
	self.turnRightButton.internal = "TURNCHARACTERRIGHT"
	self.turnRightButton:initialise()
	self.turnRightButton:instantiate()
	self.turnRightButton:setImage(getTexture("media/ui/ArrowRight.png"))
	self:addChild(self.turnRightButton)

	self.animCombo = ISComboBox:new(0, self.avatarPanel:getBottom() + UI_BORDER_SPACING, self.width, BUTTON_HGT, self, self.onAnimSelected)
	self.animCombo:initialise()
	self:addChild(self.animCombo)
	self.animCombo:addOptionWithData(getText("IGUI_anim_Idle"), "EventIdle")
	self.animCombo:addOptionWithData(getText("IGUI_anim_Walk"), "EventWalk")
	self.animCombo:addOptionWithData(getText("IGUI_anim_Run"), "EventRun")
	self.animCombo.selected = 1
end

function CharacterCreationAvatar:prerender()
	ISPanel.prerender(self)
	self:drawRectBorder(self.avatarPanel.x - 2, self.avatarPanel.y - 2, self.avatarPanel.width + 4, self.avatarPanel.height + 4, 1, 0.3, 0.3, 0.3);
	self:drawTextureScaled(self.avatarBackgroundTexture, self.avatarPanel.x, self.avatarPanel.y, self.avatarPanel.width, self.avatarPanel.height, 1, 0.4, 0.4, 0.4);
end

function CharacterCreationAvatar:onTurnChar(button, x, y)
	local direction = self.avatarPanel:getDirection()
	if button.internal == "TURNCHARACTERLEFT" then
		direction = IsoDirections.RotLeft(direction)
		self.avatarPanel:setDirection(direction)
	elseif button.internal == "TURNCHARACTERRIGHT" then
		direction = IsoDirections.RotRight(direction)
		self.avatarPanel:setDirection(direction)
	end
end

function CharacterCreationAvatar:onAnimSelected(combo)
	self.avatarPanel:setState(nil)
	self.avatarPanel:reportEvent(combo:getOptionData(combo.selected))
end

function CharacterCreationAvatar:setCharacter(character)
	self.avatarPanel:setCharacter(character)
end

function CharacterCreationAvatar:setSurvivorDesc(survivorDesc)
	self.avatarPanel:setSurvivorDesc(survivorDesc)
end

function CharacterCreationAvatar:setFacePreview(val)
	if val then
		self.avatarPanel:setZoom(14)
		self.avatarPanel:setYOffset(-0.85)
	else
		self.avatarPanel:setZoom(-3)
		self.avatarPanel:setYOffset(0)
	end
end

function CharacterCreationAvatar:rescaleAvatarViewer()
	local h = math.floor(self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT) --floor to remove rounding errors
	self.avatarPanel:setHeight(h-4)
	self.avatarPanel:setWidth(h/2-4)
	self.avatarPanel:setX((self.width - h/2)/2+2)
	self.avatarPanel:setY(2)

	self.turnLeftButton:setX(self.avatarPanel:getX())
	self.turnLeftButton:setY(self.avatarPanel:getBottom() - BUTTON_HGT)
	self.turnRightButton:setX(self.avatarPanel:getRight() - BUTTON_HGT)
	self.turnRightButton:setY(self.turnLeftButton:getY())

	self.animCombo:setWidth(self.avatarPanel:getWidth()+4)
	self.animCombo:setX(self.avatarPanel:getX()-2)
	self.animCombo:setY(self.avatarPanel:getBottom() + UI_BORDER_SPACING+2)
end

function CharacterCreationAvatar:new(x, y, width, height)
	local o = ISPanel.new(self, x, y, width, height)
	o.direction = IsoDirections.E
	return o
end
