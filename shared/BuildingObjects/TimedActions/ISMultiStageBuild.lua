--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 12/05/16
-- Time: 11:01
-- To change this template use File | Settings | File Templates.
--

require "TimedActions/ISBaseTimedAction"

ISMultiStageBuild = ISBaseTimedAction:derive("ISMultiStageBuild");

function ISMultiStageBuild:isValid()
    return true;
end

function ISMultiStageBuild:waitToStart()
    self.character:faceThisObject(self.item)
    return self.character:shouldBeTurning()
end

function ISMultiStageBuild:update()
    self.character:setMetabolicTarget(Metabolics.HeavyWork);
end

function ISMultiStageBuild:start()
    self.character:faceThisObject(self.item)
    if self.character:isPrimaryEquipped("Base.BlowTorch") then
        self:setActionAnim("BlowTorch")
        self:setOverrideHandModels(self.character:getPrimaryHandItem():getStaticModel(), nil)
    else
        self:setActionAnim(CharacterActionAnims.Build);
        if self.character:getPrimaryHandItem() then
            self:setOverrideHandModels(self.character:getPrimaryHandItem():getStaticModel(), getItemStaticModel("Base.Plank"))
        else
            self:setOverrideHandModels(nil, getItemStaticModel("Base.Plank"))
        end
    end
    if not ISBuildMenu.canDoStage(self.character, self.stage) then
        self:forceStop();
    end
    if self.stage:getCraftingSound() then
        self.sound = self.character:playSound(self.stage:getCraftingSound());
        -- FIXME: apply getHammerSoundMod() / getWeldingSoundMod()
        addSound(self.character, self.character:getX(), self.character:getY(), self.character:getZ(), 20, 1)
    end
end

function ISMultiStageBuild:stop()
    if self.sound then
        self.character:getEmitter():stopSound(self.sound)
        self.sound = nil
    end
    ISBaseTimedAction.stop(self);
end

function ISMultiStageBuild:perform()
    if self.sound then
        self.character:getEmitter():stopSound(self.sound)
        self.sound = nil
    end

    self.stage:playCompletionSound(self.character);

    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISMultiStageBuild:complete()
    self.stage:doStage(self.character, self.item, false);
    self:consumeMaterial();

    return true;
end

-- Similar to buildUtil.consumeMaterial()
function ISMultiStageBuild:consumeMaterial()
    if ISBuildMenu.cheat then return end
    local playerObj = self.character
    local playerInv = playerObj:getInventory()
    local removedFromGround = false
    local consumedItems = {}
    local stageItems = self.stage:getItemsLua()
    for itemFullType,itemCountStr in pairs(stageItems) do
        local itemCount = tonumber(itemCountStr)
        if ScriptManager.instance:isDrainableItemType(itemFullType) then
            local uses = itemCount
            local remaining = uses
            local items = playerInv:getAllTypeRecurse(itemFullType)
            for i=1,items:size() do
                local item = items:get(i-1)
                if item:getCurrentUses() > 0 then
                    remaining = remaining - buildUtil.useDrainable(item, remaining)
                    table.insert(consumedItems, item)
                    if remaining <= 0 then
                        break
                    end
                end
            end
            if remaining > 0 then
                local groundItems = buildUtil.getMaterialOnGround(self.item:getSquare())
                local items = groundItems[itemFullType]
                if items then
                    for _,item in ipairs(items) do
                        if item:getCurrentUses() > 0 then
                            remaining = remaining - buildUtil.useDrainable(item, remaining)
                            table.insert(consumedItems, item)
                            removedFromGround = true
                            if remaining <= 0 then
                                break
                            end
                        end
                    end
                end
            end
        else
            local items = playerInv:getSomeTypeEvalRecurse(itemFullType, buildUtil.predicateMaterial, itemCount)
            for i=1,items:size() do
                local item = items:get(i-1)
                playerObj:removeFromHands(item)
                if item:getContainer() then
                    sendRemoveItemFromContainer(item:getContainer(), item)
                    item:getContainer():Remove(item)
                else
                    playerInv:Remove(item)
                    sendRemoveItemFromContainer(playerInv, item)
                end
                itemCount = itemCount - 1
                table.insert(consumedItems, item)
            end
            -- if we didn't have all the required material inside our inventory, it's because the missing materials are on the ground, we gonna check them
            -- for each missing material in inventory
            if itemCount > 0 then
                -- check a 3x3 square around the building
                local groundItems = buildUtil.getMaterialOnGround(self.item:getSquare())
                local items = groundItems[itemFullType]
                if items then
                    local count = math.min(itemCount, #items)
                    for i=1,count do
                        local item = items[i]
                        local worldObj = item:getWorldItem()
                        table.insert(consumedItems, item)
                        worldObj:getSquare():transmitRemoveItemFromSquare(worldObj)
                    end
                    itemCount = itemCount - count
                    removedFromGround = true
                end
            end
            if itemCount > 0 and itemFullType == "Base.Nails" then
                local character = self.character;
                if isClient() then
                    character = self.character:getPlayerNum();
                end
                local ISItem = { player = character, square = self.item:getSquare() }
                buildUtil.openNailsBox(ISItem)
                items = playerInv:getSomeTypeEvalRecurse(itemFullType, buildUtil.predicateMaterial, itemCount)
                for i=1,items:size() do
                    local item = items:get(i-1)
                    playerObj:removeFromHands(item)
                    if item:getContainer() then
                        sendRemoveItemFromContainer(item:getContainer(), item)
                        item:getContainer():Remove(item);
                    else
                        playerInv:Remove(item)
                        sendRemoveItemFromContainer(playerInv, item)
                    end
                    itemCount = itemCount - 1
                    table.insert(consumedItems, item)
                end
            end
            if itemCount > 0 then
                print('ERROR: consumeMaterial() did not find all required materials!')
            end
        end
    end
    if removedFromGround then
        sendServerCommand(self.character, 'ui', 'dirtyUI', { });
    end
end

function ISMultiStageBuild:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end

    return self.stage:getTimeNeeded(self.character);
end

function ISMultiStageBuild:new(character, stage, item)
    local o = ISBaseTimedAction.new(self, character)
    o.character = character;
    o.stage = stage;
    o.item = item;
    o.maxTime = o:getDuration();
    o.caloriesModifier = 4;
    return o;
end


