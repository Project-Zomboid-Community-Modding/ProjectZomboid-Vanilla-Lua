--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

ISInventoryMenuElements = ISInventoryMenuElements or {};

function ISInventoryMenuElements.ContextFluidContainer()
    local self 					= ISMenuElement.new();
    self.invMenu			    = ISContextManager.getInstance().getInventoryMenu();

    function self.init()
    end

    function self.createMenu( _item )
        if _item:getFluidContainer() then
            local cont = _item:getFluidContainer();

            if cont then
                local parent = self.invMenu.context:addOption(getText("Fluid_Options"), self.invMenu, nil );
                local subMenu = ISContextMenu:getNew(self.invMenu.context);
                self.invMenu.context:addSubMenu(parent, subMenu);

                local option = subMenu:addOption(getText("Fluid_Show_Info"), self.invMenu, self.showInfo, cont );
                if cont:canPlayerEmpty() then
					local option = subMenu:addOption(getText("Fluid_Transfer_Fluids"), self.invMenu, self.transferFluids, cont );
					if not cont:isEmpty() then
						local option = subMenu:addOption(getText("Fluid_Empty"), self.invMenu, self.emptyFluidContainer, cont );
					end
                end

                if getDebug() then
                    local addFluidOption = subMenu:addDebugOption("Add Fluid", nil, nil);
                    local addFluidSubMenu = ISContextMenu:getNew(subMenu);
                    subMenu:addSubMenu(addFluidOption, addFluidSubMenu);

                    local fluidNames = FluidType.getAllFluidName();
                    for i=0, fluidNames:size() -1 do
                        addFluidSubMenu:addOption(fluidNames:get(i), self.invMenu, self.addDebugFluid, cont, fluidNames:get(i));
                    end
                end
            end
        end
    end

    function self.addDebugFluid( _p, cont, fluid )
        cont:removeFluid();
        cont:addFluid(FluidType.FromNameLower(fluid), cont:getCapacity());
    end

    function self.transferFluids( _p, _container )
        local c = ISFluidContainer:new(_container);
        ISInventoryPaneContextMenu.transferIfNeeded(_p.player, _container:getOwner())
        --ISFluidTransferUI.OpenPanel(_p.player, c)
        ISTimedActionQueue.add(ISFluidPanelAction:new(_p.player, c, ISFluidTransferUI));
    end

    function self.showInfo( _p, _container )
        local c = ISFluidContainer:new(_container);
        ISInventoryPaneContextMenu.transferIfNeeded(_p.player, _container:getOwner())
        --ISFluidInfoUI.OpenPanel(_p.player, c)
        ISTimedActionQueue.add(ISFluidPanelAction:new(_p.player, c, ISFluidInfoUI));
    end

    function self.emptyFluidContainer( _p, _container )
        ISInventoryPaneContextMenu.transferIfNeeded(_p.player, _container:getOwner())
        ISTimedActionQueue.add(ISFluidEmptyAction:new(_p.player, _container)); --:getOwner()));
    end

    return self;
end