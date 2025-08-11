--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "Map/CGlobalObject"

CPlantGlobalObject = CGlobalObject:derive("CPlantGlobalObject")

function CPlantGlobalObject:new(luaSystem, globalObject)
	local o = CGlobalObject.new(self, luaSystem, globalObject)
	return o
end

function CPlantGlobalObject:getObject()
	return self:getIsoObject()
end

function CPlantGlobalObject:isAlive()
	return self.state ~= "destroyed" and self.state ~= "dead" and self.state ~= "rotten" and self.state ~= "harvested"
end

function CPlantGlobalObject:isBadMonth()
    if getSandboxOptions():getOptionByName("PlantGrowingSeasons"):getValue() == false then return false end
	local prop = farming_vegetableconf.props[self.typeOfSeed]
	if not prop.badMonth then return false end
    for i = 1, #props.badMonth do
        if getGameTime():getMonth()+1 == tos.props.badMonth[i] then
            return true
        end
    end
    return false
end

function CPlantGlobalObject:canHarvest()
	return self:isAlive() and self.hasVegetable
end

