require "ISBaseObject"
require "ISUI/ISUIElement"

ISUISpriteBounds = ISBaseObject:derive("ISUISpriteBounds")
function ISUISpriteBounds:new(
    texture,
    textureSize,
    subTextureBounds
)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    o.texture = texture
    o.textureSize = textureSize
    o.subTextureBounds = subTextureBounds

    return o
end

ISUISpriteBoundsGetter = ISBaseObject:derive("ISUISpriteBoundsGetter")

function ISUISpriteBoundsGetter:new()
    local newInstance = {}
    setmetatable(newInstance, self)
	self.__index = self

    newInstance.spriteBounds = nil
	return newInstance
end

function ISUISpriteBoundsGetter:getSpriteBounds()
    if (self.spriteBounds == nil) then
        self.spriteBounds = self:loadSpriteBounds()
    end

    return self.spriteBounds
end

function ISUISpriteBoundsGetter:invalidate()
    self.spriteBounds = nil
end

function ISUISpriteBoundsGetter:loadSpriteBounds()
    assert(false, "ISUISpriteBoundsGetter:loadSpriteBounds must be overridden.")
end

function ISUISpriteBoundsGetter.checkGetSpriteBounds(spriteBounds)
    if (ISUISpriteBoundsGetter:instanceof(spriteBounds)) then
        return spriteBounds:getSpriteBounds()
    end
    return spriteBounds
end

ISUISprite = ISUIElement:derive("ISUISprite")

function ISUISprite:new(texture, x, y, width, height, textureWidth, textureHeight)
    local spriteBounds = ISUISpriteBounds:new(
                                              texture,
                                  { width = textureWidth, height = textureHeight },
                            {
                                                 x = 0,
                                                 y = 0,
                                                 width = textureWidth,
                                                 height = textureHeight
                                              })
	return self:newFromBounds(spriteBounds, x, y, width, height)
end

function ISUISprite:newFromBounds(spriteBounds, x, y, width, height)
    local o = ISUIElement.new(self, x, y, width, height)
    setmetatable(o, self)
    self.__index = self

    o.spriteBounds = spriteBounds
    o.color = { r = 1, g = 1, b = 1, a = 1 }
    return o
end

function ISUISprite:setSpriteBounds(spriteBounds)
    self.spriteBounds = spriteBounds
end

function ISUISprite:getSpriteBounds()
    return ISUISpriteBoundsGetter.checkGetSpriteBounds(self.spriteBounds)
end

function ISUISprite:invalidateSpriteBounds()
    if (ISUISpriteBoundsGetter:instanceof(self.spriteBounds)) then
        self.spriteBounds:invalidate()
    end
end

function ISUISprite:getSpriteAspectRatio()
    local spriteBounds = self:getSpriteBounds()
    return spriteBounds.subTextureBounds.width / spriteBounds.subTextureBounds.height
end

function ISUISprite:setHeightToPreserveAspect()
    self:setHeight(self:getWidth() / self:getSpriteAspectRatio())
end

function ISUISprite:prerender()
    ISUIElement.prerender(self)

    -- function ISUIElement:drawSubTexture(texture, subX, subY, subW, subH, x, y, w, h, a, r, g, b)
    local spriteBounds = self:getSpriteBounds()
    if (spriteBounds == nil) then
        return
    end

    local spriteTex = spriteBounds.texture
    local spriteX = spriteBounds.subTextureBounds.x
    local spriteY = spriteBounds.subTextureBounds.y
    local spriteWidth = spriteBounds.subTextureBounds.width
    local spriteHeight = spriteBounds.subTextureBounds.height
    local spriteColor = self.color
    self:drawSubTexture(spriteTex, spriteX, spriteY, spriteWidth, spriteHeight, 0, 0, self:getWidth(), self:getHeight(), spriteColor.a, spriteColor.r, spriteColor.g, spriteColor.b);
end
