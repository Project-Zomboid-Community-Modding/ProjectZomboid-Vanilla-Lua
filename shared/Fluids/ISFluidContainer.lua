--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

--[[
    Wrapper for FluidContainer java objects for ui purposes.

    FluidObject may be FluidContainer.java or ResourceFluid.java instances.
--]]

require "ISBaseObject"

ISFluidContainer = ISBaseObject:derive("ISFluidContainer");

function ISFluidContainer:new(_fluidObject)
    local o = ISBaseObject:new();
    setmetatable(o, self)
    self.__index = self
    o:initFromObject(_fluidObject);
    return o
end

function ISFluidContainer:initFromObject(_fluidObject)

    if _fluidObject and instanceof(_fluidObject, "FluidContainer") then
        self.fluidContainer = _fluidObject;
        self.isFluidResource = false;
        self.isoPanel = instanceof(self:getOwner(), "IsoObject");
        self.isInventoryItem = instanceof(self:getOwner(), "InventoryItem");
    elseif _fluidObject and instanceof(_fluidObject, "ResourceFluid") then
        self.fluidContainer = _fluidObject:getFluidContainer();
        self.fluidResource = _fluidObject;
        self.isFluidResource = true;
        self.isInventoryItem = false;
        self.isoPanel = false;
    else
        print("ISFluidContainer:initFromObject object nil or invalid")
        self.isFluidResource = false;
        self.fluidContainer = nil;
        self.fluidResource = nil;
        self.isInventoryItem = false;
        self.isoPanel = false;
    end
end

function ISFluidContainer:copy()
    if self.isFluidResource then
        return ISFluidContainer:new(self.fluidResource);
    else
        return ISFluidContainer:new(self.fluidContainer);
    end
end

function ISFluidContainer:isItem()
    return self.isInventoryItem;
end

function ISFluidContainer:isResource()
    return self.isFluidResource;
end

function ISFluidContainer:getFluidResource()
    return self.fluidResource;
end

function ISFluidContainer:isIsoPanel()
    return self.isoPanel;
end

function ISFluidContainer:resetObject()
    self.fluidContainer = nil;
    self.fluidResource = nil;
end

function ISFluidContainer:isValid()
    if self:isResource() and self.fluidResource and self.fluidContainer then
        return true;
    elseif (not self:isResource()) and self.fluidContainer then
        return true;
    end
    return false;
end

function ISFluidContainer:getFluidContainer()
    return self.fluidContainer;
end

function ISFluidContainer:getOwner()
    if self:isResource() and self.fluidResource then
        return self.fluidResource:getGameEntity();
    elseif (not self:isResource()) and self.fluidContainer then
        return self.fluidContainer:getOwner();
    end
    return nil;
end

function ISFluidContainer:getFluidObject()
    if self:isResource() and self.fluidResource then
        return self.fluidResource;
    elseif (not self:isResource()) and self.fluidContainer then
        return self.fluidContainer;
    end
    return nil;
end

function ISFluidContainer:sync()
    if not isServer() then
        return
    end

    if self.isoPanel then
        self:getOwner():sync()
    elseif self.isInventoryItem then
        self:getOwner():syncItemFields()
    elseif self.isFluidResource then
        print("not implemented");
    end
end