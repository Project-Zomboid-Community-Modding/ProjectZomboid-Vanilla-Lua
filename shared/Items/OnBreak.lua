-- OnBreak stuff by Blair Algol for b42 crafting stuff
-- This is used when an inventory item breaks and has a defined OnBreak field in it's item script.
-- If the lua function referenced in it's OnBreak field exists, the item and character using it, if any, are sent to the function for processing.
-- This is used for the funky procedural item/item part breaking as part of the crafting rework.
-- All 26 flavours of banana milk!

OnBreak = OnBreak or {}

function OnBreak.HandleHandler(item, player, newItemString, breakItem)
    if not item then return end
    local inv
    local cont = item:getContainer()
    local sq
    if item:getWorldItem() and item:getWorldItem():getSquare() then sq = item:getWorldItem():getSquare() end
    local newItem

    if player and cont == player:getInventory() then
        inv = player:getInventory()
        newItem = inv:AddItem(newItemString)
        if newItem then
            local primary = player and player:getPrimaryHandItem() == item
            local secondary = player and player:getSecondaryHandItem() == item
            if primary then
                player:setPrimaryHandItem(newItem)
                if newItem:isTwoHandWeapon() and secondary then player:setSecondaryHandItem(newItem) end
            elseif secondary then player:setSecondaryHandItem(newItem) end
		    player:reportEvent("EventAttachItem");
        end
        if breakItem then
            newItem:setCondition(0)
        else
            newItem:setCondition(ZombRand(newItem:getConditionMax()) + 1)
        end
    elseif sq then
        newItem = sq:AddWorldInventoryItem(newItemString, ZombRand(100)/100, ZombRand(100)/100, 0.0)
    elseif cont then
        cont = item:getContainer()
        newItem = cont:AddItem(newItemString)
    end
    if not newItem then return end
    newItem:copyBloodLevelFrom(item)
    if newItem:hasSharpness() and item:hasSharpness() then
        newItem:setSharpnessFrom(item)
    end
    newItem:SynchSpawn()
    item:Remove()
    triggerEvent("OnContainerUpdate");
end

function OnBreak.HeadHandler(item, player, newItemString, stickIn, forceLocation, bonusCount, fullCondition)
    if not item then return end
    local cont = item:getContainer()
    local sq

    if item:getWorldItem() and item:getWorldItem():getSquare() then sq = item:getWorldItem():getSquare() end
    local newItem
    if sq then
        sq:AddWorldInventoryItem(newItemString, ZombRand(100)/100, ZombRand(100)/100, 0.0)
    elseif player and player:getSquare() and cont == player:getInventory() then
        sq = player:getSquare()
        local hit
        if player:isAttacking() and player:getLastHitCharacter() and instanceof(player:getLastHitCharacter(), "IsoZombie") then  hit = player:getLastHitCharacter() end
        if hit and hit:getSquare() then sq = hit:getSquare() end
        if stickIn and hit and instanceof(hit, "IsoZombie") then
            local part = hit:getLastHitPart()
            newItem = instanceItem(newItemString)
            local location = "Stomach"
            if forceLocation then location = forceLocation end
            if part == "Torso_Upper" then location = "Knife Shoulder"
            elseif part == "Torso_Lower" then location = "Knife Stomach" end
            if location == "Knife Stomach" and hit:getAttachedItem(location) then location = "Knife Shoulder"
            elseif location == "Knife Shoulder" and hit:getAttachedItem(location) then location = "Knife Stomach" end
            if location ~= "Stomach" and hit:getAttachedItem(location) then location = "Stomach" end
            if forceLocation then location = forceLocation end
            if not hit:getAttachedItem(location) then
                hit:setAttachedItem(location, newItem)
                if isServer() then
                    sendAttachedItem(hit, location, newItem)
                end
		        hit:reportEvent("EventAttachItem");
            else
                newItem = sq:AddWorldInventoryItem(newItem, ZombRand(100)/100, ZombRand(100)/100, 0.0)
            end
        elseif sq then
            newItem = sq:AddWorldInventoryItem(newItemString, ZombRand(100)/100, ZombRand(100)/100, 0.0)
        end
    elseif cont then
        newItem = cont:AddItem(newItemString)
        if isServer() and newItem then
            sendAddItemToContainer(cont, newItem);
        end
    end
    if bonusCount and bonusCount > 0 then
        for i = 1, bonusCount do
            local bonusItem
            if cont then
                bonusItem = cont:AddItem(newItemString)
                if isServer() and bonusItem then
                    sendAddItemToContainer(cont, bonusItem);
                end
            else
                bonusItem = sq:AddWorldInventoryItem(newItemString, ZombRand(100)/100, ZombRand(100)/100, 0.0)
            end
            if bonusItem then
                if not fullCondition then
                    if item:hasHeadCondition() then bonusItem:setConditionFromHeadCondition(item)
                    else bonusItem:setConditionFrom(item) end
                end
                bonusItem:copyBloodLevelFrom(item)
            end
        end
    end
    if not newItem then return end

    if player and newItem:getDropSound() then player:playDropItemSound(newItem)
    elseif player and item:getDropSound() then player:playDropItemSound(item) end

    if not fullCondition then
        if item:hasHeadCondition() then newItem:setConditionFromHeadCondition(item)
        else newItem:setConditionFrom(item) end
    end
    newItem:copyBloodLevelFrom(item)
    if isServer() then
        newItem:syncItemFields()
    end
    triggerEvent("OnContainerUpdate")
end


function OnBreak.GroundHandler(item, player, newItemString, bonusCount)
    if not item then return end
    local inv
    local cont = item:getContainer()
    local sq

    if item:getWorldItem() and item:getWorldItem():getSquare() then sq = item:getWorldItem():getSquare() end
    local newItem
    if sq then
        newItem = sq:AddWorldInventoryItem(newItemString, ZombRand(100)/100, ZombRand(100)/100, 0.0)
    elseif player and player:getSquare() and cont == player:getInventory() then
        sq = player:getSquare()
        local hit
        if player:isAttacking() and player:getLastHitCharacter() and instanceof(player:getLastHitCharacter(), "IsoZombie") then  hit = player:getLastHitCharacter() end
        if hit and hit:getSquare() then sq = hit:getSquare() end
        newItem = sq:AddWorldInventoryItem(newItemString, ZombRand(100)/100, ZombRand(100)/100, 0.0)
    elseif cont then
        newItem = cont:AddItem(newItemString)
        if isServer() and newItem then
            sendAddItemToContainer(cont, newItem);
        end
    end
    if bonusCount and bonusCount > 0 then
        for i = 1, bonusCount do
            local bonusItem
            if cont then
                bonusItem = cont:AddItem(newItemString)
                if isServer() and newItem then
                    sendAddItemToContainer(cont, bonusItem);
                end
            else
                bonusItem = sq:AddWorldInventoryItem(newItemString, ZombRand(100)/100, ZombRand(100)/100, 0.0)
            end
            if bonusItem then
                bonusItem:copyBloodLevelFrom(item)
                if isServer() then
                    bonusItem:syncItemFields()
                end
            end
        end
    end
    if not newItem then return end
    if player and newItem:getDropSound() then player:playDropItemSound(newItem)
    elseif player and item:getDropSound() then player:playDropItemSound(item) end
    newItem:copyBloodLevelFrom(item)
    if isServer() then
        newItem:syncItemFields()
    end
    triggerEvent("OnContainerUpdate")
end

function OnBreak.AxeStone(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.SharpedStone")
    OnBreak.HandleHandler(item, player, "Base.Branch_Broken", false)
end

function OnBreak.BallPeenHammer(item, player)
    OnBreak.HeadHandler(item, player, "Base.BallPeenHammerHead")
    OnBreak.HandleHandler(item, player, "Base.Handle", true)
end

function OnBreak.BaseballBat(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HandleHandler(item, player, "Base.BaseballBat_Broken", false)
end

function OnBreak.BaseballBat_Nails(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.GroundHandler(item, player, "Base.Nails")
    OnBreak.HandleHandler(item, player, "Base.BaseballBat_Broken", false)
end

function OnBreak.BaseballBat_Sawblade(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.CircularSawblade", true, "Knife Shoulder")
    OnBreak.HandleHandler(item, player, "Base.BaseballBat_Broken", false)
end

function OnBreak.BaseballBat_RakeHead(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.RakeHead", true)
    OnBreak.HandleHandler(item, player, "Base.BaseballBat_Broken", false)
end

function OnBreak.BaseballBat_RailSpike(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.RailroadSpike", true, nil, 1)
    OnBreak.HandleHandler(item, player, "Base.BaseballBat_Broken", false)
end

function OnBreak.Clawhammer(item, player)
    OnBreak.HeadHandler(item, player, "Base.ClawhammerHead")
    OnBreak.HandleHandler(item, player, "Base.Handle", true)
end

function OnBreak.ClubHammer(item, player)
    OnBreak.HeadHandler(item, player, "Base.ClubHammerHead")
    OnBreak.HandleHandler(item, player, "Base.Handle", true)
end

function OnBreak.HandAxe(item, player)
    OnBreak.HeadHandler(item, player, "Base.HandAxeHead")
    OnBreak.HandleHandler(item, player, "Base.Handle", true)
end

function OnBreak.HandScythe(item, player)
    OnBreak.HeadHandler(item, player, "Base.HandScytheBlade", true)
    OnBreak.HandleHandler(item, player, "Base.SmallHandle", true)
end

function OnBreak.GardenHoe(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.GardenHoeHead")
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.HandleSpade(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.SpadeHead")
    OnBreak.HandleHandler(item, player, "Base.GardenToolHandle_Broken", false)
end

function OnBreak.HuntingKnife(item, player)
    OnBreak.HeadHandler(item, player, "Base.HuntingKnifeBlade", true)
    OnBreak.HandleHandler(item, player, "Base.SmallHandle", true)
end

function OnBreak.KitchenKnife(item, player)
    OnBreak.HeadHandler(item, player, "Base.KitchenKnifeBlade", true)
    OnBreak.HandleHandler(item, player, "Base.SmallHandle", true)
end

function OnBreak.LargeKnife(item, player)
    OnBreak.HeadHandler(item, player, "Base.LargeKnifeBlade", true)
    OnBreak.HandleHandler(item, player, "Base.SmallHandle", true)
end

function OnBreak.LongHandle(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HandleHandler(item, player, "Base.LongHandle_Broken", false)
end

function OnBreak.LongHandle_Nails(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.GroundHandler(item, player, "Base.Nails")
    OnBreak.HandleHandler(item, player, "Base.LongHandle_Broken", false)
end

function OnBreak.LongHandle_RakeHead(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.RakeHead", true)
    OnBreak.HandleHandler(item, player, "Base.LongHandle_Broken", false)
end

function OnBreak.LongStick(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.Machete(item, player)
    OnBreak.HeadHandler(item, player, "Base.MacheteBlade_NoTang", true)
    OnBreak.HandleHandler(item, player, "Base.SmallHandle", true)
end

function OnBreak.MeatCleaver(item, player)
    OnBreak.HeadHandler(item, player, "Base.MeatCleaverBlade", true)
    OnBreak.HandleHandler(item, player, "Base.SmallHandle", true)
end

function OnBreak.PickAxe(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.PickAxeHead")
    OnBreak.HandleHandler(item, player, "Base.LongHandle_Broken", false)
end

function OnBreak.SmallHandle(item, player)
    OnBreak.HandleHandler(item, player, "Base.SmallHandle", true)
end

function OnBreak.Sapling(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HandleHandler(item, player, "Base.TreeBranch2", false)
end

function OnBreak.Sledgehammer(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.SledgehammerHead")
    OnBreak.HandleHandler(item, player, "Base.LongHandle_Broken", false)
end

function OnBreak.Spade(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.SpadeHead_Forged")
    OnBreak.HandleHandler(item, player, "Base.LongHandle_Broken", false)
end

function OnBreak.SledgehammerNoShaft(item, player)
    OnBreak.HeadHandler(item, player, "Base.SledgehammerHead")
end

function OnBreak.SpearBreadKnife(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.BreadKnife", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.SpearButterKnife(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.ButterKnife", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.SpearCrude(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.CrudeBlade", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.SpearCrudeLong(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.LongCrudeBlade", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.SpearFightingKnife(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.FightingKnife", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.SpearFork(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.Fork", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.SpearHandFork(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.HandFork", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.SpearHuntingKnife(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.HuntingKnife", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.SpearIcePick(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.IcePick", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.SpearLargeKnife(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.LargeKnife", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.SpearLetterOpener(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.LetterOpener", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.SpearKitchenKnife(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.KitchenKnife", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.SpearLong(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.SpearLongHead", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.SpearMachete(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.Machete", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.SpearScalpel(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.Scalpel", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.SpearScissors(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.Scissors", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.SpearScrapKnife(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.LargeKnife_Scrap", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.SpearScrewdriver(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.Screwdriver", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.SpearSmallKnife(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.SmallKnife", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.SpearSpoon(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.Spoon", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.SpearSteakKnife(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.SteakKnife", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.SpearShort(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.SpearHead", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.SpearStone(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.StoneBlade", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.SpearStoneLong(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.StoneBladeLong", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken",false)
end

function OnBreak.SpearBone(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.SharpBoneFragment", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.SpearBoneLong(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.SharpBone_Long", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken",false)
end

function OnBreak.Rake(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.RakeHead", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.WoodAxe(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.WoodAxeHead")
    OnBreak.HandleHandler(item, player, "Base.LongHandle_Broken", false)
end

-- change to putting glass tile on the floor
function OnBreak.BrokenGlass(item, player)
    OnBreak.HeadHandler(item, player, "Base.BrokenGlass", false)
    inv = player:getInventory()
    inv:Remove(item)
	if isServer() then
    	sendRemoveItemFromContainer(inv, item);
	end
end

function OnBreak.HammerStone(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.Stone2")
    OnBreak.HandleHandler(item, player, "Base.Branch_Broken", false)
end

function OnBreak.LargeBranch(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HandleHandler(item, player, "Base.Branch_Broken", false)
end

function OnBreak.LargeBranch_Nails(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.GroundHandler(item, player, "Base.Nails")
    OnBreak.HandleHandler(item, player, "Base.Branch_Broken", false)
end

function OnBreak.StoneAxeLarge(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.StoneAxeHead")
    OnBreak.HandleHandler(item, player, "Base.LongHandle_Broken", false)
end

function OnBreak.StoneMaul(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.StoneMaulHead")
    OnBreak.HandleHandler(item, player, "Base.LongHandle_Broken", false)
end

function OnBreak.GuitarElectric(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HandleHandler(item, player, "Base.GuitarElectricNeck_Broken", false)
end

function OnBreak.GuitarElectricBass(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HandleHandler(item, player, "Base.GuitarElectricBassNeck_Broken", false)
end

function OnBreak.GuitarAcoustic(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HandleHandler(item, player, "Base.GuitarAcousticNeck_Broken", false)
end

function OnBreak.Banjo(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HandleHandler(item, player, "Base.BanjoNeck_Broken", false)
end

function OnBreak.GardenFork(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.GardenForkHead", true)
    OnBreak.HandleHandler(item, player, "Base.GardenToolHandle_Broken", false)
end

function OnBreak.GardenFork_Forged(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.GardenForkHead_Forged", true)
    OnBreak.HandleHandler(item, player, "Base.LongStick_Broken", false)
end

function OnBreak.GardenTool(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HandleHandler(item, player, "Base.GardenToolHandle_Broken", false)
end

function OnBreak.Katana(item, player)
    local roll = ZombRand(3)
    if roll == 0 then
        OnBreak.HeadHandler(item, player, "Base.Katana_Shard", true, "Knife Shoulder", 0, true)
        OnBreak.HandleHandler(item, player, "Base.Katana_Broken", false)
    elseif roll == 1 then
        OnBreak.HeadHandler(item, player, "Base.Katana_Blade", true, "Knife Shoulder", 0, true)
        OnBreak.HandleHandler(item, player, "Base.Katana_Handle", false)
    else
        OnBreak.HeadHandler(item, player, "Base.Katana_Shard", true, "Knife Shoulder", 0, true)
        OnBreak.GroundHandler(item, player, "Base.Katana_Blade_Broken")
        OnBreak.HandleHandler(item, player, "Base.Katana_Handle", false)
    end
end

function OnBreak.Katana_Broken(item, player)
    OnBreak.HeadHandler(item, player, "Base.Katana_Blade_Broken", true, "Knife Shoulder", 0, true)
    OnBreak.HandleHandler(item, player, "Base.Katana_Handle", false)
end

function OnBreak.Sword(item, player)
    local roll = ZombRand(3)
    if roll == 0 then
        OnBreak.HeadHandler(item, player, "Base.SwordBlade", true, "Knife Shoulder")
        OnBreak.HandleHandler(item, player, "Base.SmallHandle", true)
    elseif roll == 1 then
        OnBreak.HeadHandler(item, player, "Base.Sword_Shard", true, "Knife Shoulder", 0, true)
        OnBreak.HandleHandler(item, player, "Base.Sword_Broken", false)
    else
        OnBreak.HeadHandler(item, player, "Base.Sword_Shard", true, "Knife Shoulder", 0, true)
        OnBreak.GroundHandler(item, player, "Base.SwordBlade_Broken_NoTang")
        OnBreak.HandleHandler(item, player, "Base.SmallHandle", true)
    end
end

function OnBreak.Sword_Broken(item, player)
    OnBreak.HeadHandler(item, player, "Base.SwordBlade_Broken_NoTang", true, "Knife Shoulder", 0, true)
    OnBreak.HandleHandler(item, player, "Base.SmallHandle", true)
end

function OnBreak.ShortSword(item, player)
    OnBreak.HeadHandler(item, player, "Base.ShortSwordBlade_NoTang", true, "Knife Shoulder", 0, true)
    OnBreak.HandleHandler(item, player, "Base.SmallHandle", true)
end

function OnBreak.CrudeSword(item, player)
    local roll = ZombRand(3)
    if roll == 0 then
        OnBreak.HeadHandler(item, player, "Base.CrudeSwordBlade", true, "Knife Shoulder")
        OnBreak.HandleHandler(item, player, "Base.SmallHandle", true)
    elseif roll == 1 then
        OnBreak.HeadHandler(item, player, "Base.CrudeSword_Shard", true, "Knife Shoulder", 0, true)
        OnBreak.HandleHandler(item, player, "Base.CrudeSword_Broken", false)
    else
        OnBreak.HeadHandler(item, player, "Base.CrudeSword_Shard", true, "Knife Shoulder", 0, true)
        OnBreak.GroundHandler(item, player, "Base.CrudeSwordBlade_Broken_NoTang")
        OnBreak.HandleHandler(item, player, "Base.SmallHandle", true)
    end
end

function OnBreak.CrudeSword_Broken(item, player)
    OnBreak.HeadHandler(item, player, "Base.CrudeSwordBlade_Broken_NoTang", true, "Knife Shoulder", 0, true)
    OnBreak.HandleHandler(item, player, "Base.SmallHandle", true)
end

function OnBreak.CrudeShortSword(item, player)
    OnBreak.HeadHandler(item, player, "Base.CrudeShortSwordBlade_NoTang", true, "Knife Shoulder", 0, true)
    OnBreak.HandleHandler(item, player, "Base.SmallHandle", true)
end

function OnBreak.Sword_Scrap(item, player)
    OnBreak.HeadHandler(item, player, "Base.Sword_Scrap_Shard", true, "Knife Shoulder", 0, true)
    OnBreak.HandleHandler(item, player, "Base.Sword_Scrap_Broken", false)
end

function OnBreak.ShortBat_RakeHead(item, player)
    OnBreak.HandleHandler(item, player, "Base.ShortBat", true)
    OnBreak.HeadHandler(item, player, "Base.RakeHead", true)
end

function OnBreak.JawboneBovide_Axe(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.JawboneBovide")
    OnBreak.HandleHandler(item, player, "Base.Branch_Broken", false)
end

function OnBreak.JawboneBovide_Club(item, player)
    OnBreak.HandleHandler(item, player, "Base.Handle", true)
    OnBreak.HeadHandler(item, player, "Base.JawboneBovide")
end

function OnBreak.FieldHockeyStick(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HandleHandler(item, player, "Base.FieldHockeyStick_Broken", false)
end

function OnBreak.WoodenStick(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HandleHandler(item, player, "Base.WoodenStick_Broken", false)
end

function OnBreak.WoodenStick_Nails(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HandleHandler(item, player, "Base.WoodenStick_Broken", false)
end

function OnBreak.MetalPipe(item, player)
    OnBreak.HandleHandler(item, player, "Base.MetalPipe_Broken", false)
end

function OnBreak.TableLeg(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HandleHandler(item, player, "Base.TableLeg_Broken", false)
end

function OnBreak.TableLeg_Nails(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.GroundHandler(item, player, "Base.Nails")
    OnBreak.HandleHandler(item, player, "Base.TableLeg_Broken", false)
end

function OnBreak.CanoePadelX2(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HandleHandler(item, player, "Base.CanoePadelX2_Broken", false)
end

function OnBreak.Plank(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HandleHandler(item, player, "Base.Plank_Broken", false)
end

function OnBreak.Plank_Nails(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.GroundHandler(item, player, "Base.Nails")
    OnBreak.HandleHandler(item, player, "Base.Plank_Broken", false)
end

function OnBreak.SmithingHammer(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.SmithingHammerHead")
    OnBreak.HandleHandler(item, player, "Base.Handle", true)
end

function OnBreak.FlintNodule(item, player)
    OnBreak.HandleHandler(item, player, "Base.SharpedStone", false)
end

function OnBreak.BrassScrap(item, player)
    OnBreak.GroundHandler(item, player, "Base.BrassScrap")
end

function OnBreak.Hatchet_Bone(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.HatchetHead_Bone")
    OnBreak.HandleHandler(item, player, "Base.Branch_Broken", false)
end

function OnBreak.FireAxe(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.FireAxeHead")
    OnBreak.HandleHandler(item, player, "Base.LongHandle_Broken", false)
end

function OnBreak.OldAxe(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.OldAxeHead")
    OnBreak.HandleHandler(item, player, "Base.LongHandle_Broken", false)
end

function OnBreak.MetalBar(item, player)
    OnBreak.GroundHandler(item, player, "Base.SteelRodHalf")
    OnBreak.HandleHandler(item, player, "Base.SteelRodHalf", false)
end

function OnBreak.SteelRodHalf(item, player)
    OnBreak.GroundHandler(item, player, "Base.SteelRodQuarter")
    OnBreak.HandleHandler(item, player, "Base.SteelRodQuarter", false)
end

function OnBreak.SteelBar(item, player)
    OnBreak.GroundHandler(item, player, "Base.SteelBarHalf")
    OnBreak.HandleHandler(item, player, "Base.SteelBarHalf", false)
end

function OnBreak.SteelBarHalf(item, player)
    OnBreak.GroundHandler(item, player, "Base.SteelBarQuarter")
    OnBreak.HandleHandler(item, player, "Base.SteelBarQuarter", false)
end

function OnBreak.IronRod(item, player)
    OnBreak.GroundHandler(item, player, "Base.IronRodHalf")
    OnBreak.HandleHandler(item, player, "Base.IronRodHalf", false)
end

function OnBreak.IronRodHalf(item, player)
    OnBreak.GroundHandler(item, player, "Base.IronRodQuarter")
    OnBreak.HandleHandler(item, player, "Base.IronRodQuarter", false)
end

function OnBreak.IronBar(item, player)
    OnBreak.GroundHandler(item, player, "Base.IronBarHalf")
    OnBreak.HandleHandler(item, player, "Base.IronBarHalf", false)
end

function OnBreak.IronBarHalf(item, player)
    OnBreak.GroundHandler(item, player, "Base.IronBarQuarter")
    OnBreak.HandleHandler(item, player, "Base.IronBarQuarter", false)
end

function OnBreak.Nails(item, player)
    OnBreak.GroundHandler(item, player, "Base.Nails")
end

function OnBreak.Mace(item, player)
    OnBreak.HeadHandler(item, player, "Base.MaceHead")
    OnBreak.HandleHandler(item, player, "Base.ShortBat", true)
end

function OnBreak.MaceStone(item, player)
    OnBreak.HeadHandler(item, player, "Base.StoneMaceHead")
    OnBreak.HandleHandler(item, player, "Base.ShortBat", true)
end

function OnBreak.LongMace(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.MaceHead")
    OnBreak.HandleHandler(item, player, "Base.LongHandle_Broken", false)
end

function OnBreak.LongMaceStone(item, player)
    OnBreak.GroundHandler(item, player, "Base.Splinters")
    OnBreak.HeadHandler(item, player, "Base.StoneMaceHead")
    OnBreak.HandleHandler(item, player, "Base.LongHandle_Broken", false)
end
