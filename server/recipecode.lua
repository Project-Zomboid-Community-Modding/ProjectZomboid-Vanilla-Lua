--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

Recipe = {}
Recipe.GetItemTypes = {}
Recipe.OnCanPerform = {}
Recipe.OnCreate = {}
Recipe.OnGiveXP = {}
Recipe.OnTest = {}
Recipe.WeaponParts = {}

local function predicateNotBroken(item)
	return not item:isBroken()
end

function Recipe.WeaponParts.hasScrewdriver(character, weapon, weaponPart)
	-- canAttach/canDetach for most firearm attachments.
	-- this needs to return true if character is nil for sawing shotguns to properly transfer parts.
	-- see: Recipe.OnCreate.ShotgunSawnoff and tryAttachPart
	return character == nil or character:getInventory():containsTagEval("Screwdriver", predicateNotBroken)
end

function Recipe.OnCreate.OpenAndEat(craftRecipeData, character)
    if craftRecipeData:getEatPercentage() <= 0 then return end
	if character:getMoodles():getMoodleLevel(MoodleType.FoodEaten) >= 3 then return end
	local result = craftRecipeData:getAllCreatedItems():get(0)
	ISTimedActionQueue.add(ISEatFoodAction:new (character, result, craftRecipeData:getEatPercentage()/100))
end

function OnBreak.SpearBone(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.SharpBoneFragment", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.SpearBoneLong(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.SharpBone_Long", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end
