--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "BuildingObjects/ISPickCharacterCursor"

ISAnimalPickMateCursor = ISPickCharacterCursor:derive("ISAnimalPickMateCursor")

function ISAnimalPickMateCursor:getAPrompt()
    if self.canBeBuild then
        return getText("ContextMenu_SetFertilized")
    end
    return nil
end

function ISAnimalPickMateCursor:isValidCharacter(chr)
    if chr == self.femaleAnimal then return end
    if not instanceof(chr, "IsoAnimal") then return false end
    if chr:isFemale() then return false end
    return chr:getMate() == self.femaleAnimal:getAnimalType()
end

function ISAnimalPickMateCursor:onPickCharacter(chr)
    AnimalContextMenu.SetFertilized(self.femaleAnimal, self.character, true, chr)
end

function ISAnimalPickMateCursor:new(character, femaleAnimal)
    local o = ISPickCharacterCursor.new(self, character)
    o.femaleAnimal = femaleAnimal
    o.dragNilAfterPlace = true
    return o
end

