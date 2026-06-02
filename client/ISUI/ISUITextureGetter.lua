require "ISBaseObject"

ISUITextureGetter = ISBaseObject:derive("ISUITextureGetter")
function ISUITextureGetter:new(textureFilePath)
    local newInstance = {}
    setmetatable(newInstance, self)
	self.__index = self

    newInstance.texture = nil
    newInstance.textureFilePath = textureFilePath
	return newInstance
end

function ISUITextureGetter:getTexture()
    if (self.texture == nil) then
        self:loadTexture()
    end

    return self.texture
end

function ISUITextureGetter:getHeight()
    return self:getTexture():getHeight()
end

function ISUITextureGetter:getWidth()
    return self:getTexture():getWidth()
end

function ISUITextureGetter:getTextureFilePath()
    assert(self.textureFilePath ~= nil, "ISUITextureGetter:getTextureFilePath must be overridden.")
    return self.textureFilePath
end

function ISUITextureGetter:loadTexture()
    local textureFile = self:getTextureFilePath()
    self.texture = getTexture(textureFile)
    if (self.texture == nil) then
        DebugType.Lua:warn("Failed to load texture: " .. textureFile)
    end
end

function ISUITextureGetter.checkGetTexture(texture)
    if (ISUITextureGetter:instanceof(texture)) then
        return texture:getTexture()
    end
    return texture
end
