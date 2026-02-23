ISFluidContainerMenu = ISFluidContainerMenu or {};

function ISFluidContainerMenu.createMenu(context, item, waterContainer, playerObj)
    if not item and waterContainer then
        item = waterContainer;
    end
    local cont = item and (item:getFluidContainer() or (item:getWorldItem() ~= nil and item:getWorldItem():getFluidContainer()));

    local option = context:addOption(getText("ContextMenu_Fluid"), nil);
    option.iconTexture = getTexture("Item_WaterDrop");
    local subMenu = ISContextMenu:getNew(context);
    context:addSubMenu(option, subMenu);

    if cont and cont:canPlayerEmpty() then
        subMenu:addOption(getText("Fluid_Show_Info"), playerObj, ISFluidContainerMenu.showInfo, cont);
        subMenu:addOption(getText("Fluid_Transfer_Fluids"), playerObj, ISFluidContainerMenu.transferFluids, cont);
        if not cont:isEmpty() then
            subMenu:addOption(getText("Fluid_Empty"), playerObj, ISFluidContainerMenu.emptyFluidContainer, cont);
        end

        if getDebug() then
            local addFluidOption = subMenu:addDebugOption(getText("ContextMenu_AddFluid"), nil, nil);
            local addFluidSubMenu = ISContextMenu:getNew(subMenu);
            subMenu:addSubMenu(addFluidOption, addFluidSubMenu);

            local fluidNames = FluidType.getAllFluidName();
            for i=0, fluidNames:size() -1 do
                addFluidSubMenu:addOption(fluidNames:get(i), cont, ISFluidContainerMenu.addDebugFluid, fluidNames:get(i));
            end
        end
    end

    if waterContainer and not instanceof(waterContainer, "IsoWorldInventoryObject") then
        if getCore():getOptionAutoDrink() and playerObj:getInventory():contains(waterContainer) then
            subMenu:addOption(getText("ContextMenu_DisableAutodrink") , waterContainer, ISInventoryPaneContextMenu.AutoDrinkOff, playerObj);
        elseif playerObj:getInventory():contains(waterContainer) then
            subMenu:addOption(getText("ContextMenu_EnableAutodrink") , waterContainer, ISInventoryPaneContextMenu.AutoDrinkOn, playerObj);
        end
    end
end

function ISFluidContainerMenu.showInfo(playerObj, container)
    ISFluidContainerMenu.showUI(playerObj, container, ISFluidInfoUI);
end

function ISFluidContainerMenu.transferFluids(playerObj, container)
    ISFluidContainerMenu.showUI(playerObj, container, ISFluidTransferUI);
end

function ISFluidContainerMenu.emptyFluidContainer(playerObj, container)
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, container:getOwner(), true)
    ISTimedActionQueue.add(ISFluidEmptyAction:new(playerObj, container));
end

function ISFluidContainerMenu.showUI(playerObj, container, ui)
    ISFluidContainerMenu.joypadHideInventoryAndLoot(playerObj);
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, container:getOwner(), true)
    ISTimedActionQueue.add(ISFluidPanelAction:new(playerObj, ISFluidContainer:new(container), ui));
end

function ISFluidContainerMenu.joypadHideInventoryAndLoot(playerObj)
    local playerNum = playerObj:getPlayerNum();
    if not JoypadState.players[playerNum+1] then
        return
    end
    if getPlayerInventory(playerNum) then
        getPlayerInventory(playerNum):close();
    end
    if getPlayerLoot(playerNum) then
        getPlayerLoot(playerNum):close();
    end
end

function ISFluidContainerMenu.addDebugFluid(cont, fluid)
    cont:removeFluid();
    cont:addFluid(FluidType.FromNameLower(fluid), cont:getCapacity());
end
