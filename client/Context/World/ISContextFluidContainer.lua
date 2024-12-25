--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

ISWorldMenuElements = ISWorldMenuElements or {};

function ISWorldMenuElements.ContextFluidContainer()
    local self 					= ISMenuElement.new();

    function self.init()
    end

    function self.createMenu( _data )
        if getCore():getGameMode() == "Tutorial" then
            return;
        end

        for index,obj in ipairs(_data.objects) do
            if obj:getFluidContainer() then
                if _data.test then return true; end

                local cont = obj:getFluidContainer();

                if cont then
                    local parent = _data.context:addOption(getText("Fluid_Options"), _data, nil );
                    local subMenu = ISContextMenu:getNew(_data.context);
                    _data.context:addSubMenu(parent, subMenu);

                    local option = subMenu:addOption(getText("Fluid_Transfer_Fluids"), _data, self.transferFluids, cont );
                    local option = subMenu:addOption(getText("Fluid_Show_Info"), _data, self.showInfo, cont );

                    if cont:canPlayerEmpty() and not cont:isEmpty() then
                        local option = subMenu:addOption(getText("Fluid_Empty"), _data, self.emptyFluidContainer, cont );
                    end

                    if getCore():getDebug() then
                        local option = subMenu:addOption("[Debug] Remove FluidContainer", _data, self.removeContainer, obj );
                    end
                end
            elseif getCore():getDebug() and index==#_data.objects then
                local parent = _data.context:addOption(getText("Fluid_Fluid_Options"), _data, nil );
                local subMenu = ISContextMenu:getNew(_data.context);
                _data.context:addSubMenu(parent, subMenu);
                local option = subMenu:addOption("[Debug] Add Water Container", _data, self.addWater, obj );
                local option = subMenu:addOption("[Debug] Add Petrol Container", _data, self.addPetrol, obj );
            end
        end
    end

    function self.transferFluids( _data, _container )
        local c = ISFluidContainer:new(_container);
        if ISFluidUtil.doWalkTo(_data.player, c) then
            ISTimedActionQueue.add(ISFluidPanelAction:new(_data.player, c, ISFluidTransferUI));
        end
    end

    function self.showInfo( _data, _container )
        local c = ISFluidContainer:new(_container);
        if ISFluidUtil.doWalkTo(_data.player, c) then
            ISTimedActionQueue.add(ISFluidPanelAction:new(_data.player, c, ISFluidInfoUI));
        end
    end

    function self.emptyFluidContainer( _data, _container )
        local c = ISFluidContainer:new(_container);
        if ISFluidUtil.doWalkTo(_data.player, c) then
            ISTimedActionQueue.add(ISFluidEmptyAction:new(_data.player, _container)); --:getOwner()));
        end
    end

    function self.addWater( _data, _obj )
        local f = ComponentType.FluidContainer:CreateComponent(); --Component.Create(ComponentType.FluidContainer); --FluidContainer.new();
        f:setCapacity(5.0);
        f:addFluid(FluidType.Water, 5.0);
        GameEntityFactory.AddComponent(_obj, true, f);

        if isClient() then
            local playerObj = getSpecificPlayer(0)
            local args = { x = _obj:getX(), y = _obj:getY(), z = _obj:getZ(), index = _obj:getObjectIndex() }
            sendClientCommand(playerObj, 'object', 'addWaterContainer', args)
        end
    end

    function self.addPetrol( _data, _obj )
        local f = ComponentType.FluidContainer:CreateComponent(); --Component.Create(ComponentType.FluidContainer); --FluidContainer.new();
        f:setCapacity(22000);
        f:addFluid(FluidType.Petrol, 14580);
        f:setInputLocked(true);
        GameEntityFactory.AddComponent(_obj, true, f);
    end

    function self.removeContainer( _data, _obj )
        GameEntityFactory.RemoveComponentType(_obj, ComponentType.FluidContainer);

        if isClient() then
            local playerObj = getSpecificPlayer(0)
            local args = { x = _obj:getX(), y = _obj:getY(), z = _obj:getZ(), index = _obj:getObjectIndex() }
            sendClientCommand(playerObj, 'object', 'removeFluidContainer', args)
        end
    end

    return self;
end