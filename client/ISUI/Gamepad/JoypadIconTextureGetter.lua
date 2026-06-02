require "ISUI/ISUITextureGetter"

JoypadIconTextureGetter = ISUITextureGetter:derive("JoypadIconTextureGetter")
function JoypadIconTextureGetter:new(suffix)
    local newInstance = {}
    setmetatable(newInstance, self)
	self.__index = self
	self.SuperType = ISUITextureGetter

    newInstance.suffix = suffix
    newInstance.fileNamePrefix = getCore():getOptionControllerButtonStyleString()
	return newInstance
end

function JoypadIconTextureGetter:getFileNamePrefix()
    return self.fileNamePrefix
end

function JoypadIconTextureGetter:setFileNamePrefix(newPrefix)
    if (self.fileNamePrefix ~= newPrefix) then
        self.texture = nil
        self.fileNamePrefix = newPrefix
    end
end

function JoypadIconTextureGetter:getTextureFilePath()
    return  "media/ui/controller/".. self:getFileNamePrefix() .. "_" .. self.suffix .. ".png"
end
