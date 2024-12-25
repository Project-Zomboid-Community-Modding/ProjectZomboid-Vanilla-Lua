--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

ISWorldMenuElements = ISWorldMenuElements or {};

function ISWorldMenuElements.ContextEntity()
    local self 					= ISMenuElement.new();

    function self.init()
    end

    function self.createMenu( _data )
        if getCore():getGameMode() == "Tutorial" then
            return;
        end

        local canAddEntityOption = true;
        for index,object in ipairs(_data.objects) do
            local obj = object:getMasterObject();

            if canAddEntityOption and ISEntityUI.CanOpenWindowFor(_data.player, obj) then
                local displayName = obj:getEntityDisplayName();
                if (not displayName) or (displayName==GameEntity.getDefaultEntityDisplayName()) then
                    displayName = getText("Entity_Open_Window");
                end
                _data.context:addOption(displayName, _data, self.openPanel, obj );
                canAddEntityOption = false;
            end
        end

        if false and getDebug() then
            local parent = _data.context:addOption(getText("Entity Debug Build"), _data, nil );
            local subMenu = ISContextMenu:getNew(_data.context);
            _data.context:addSubMenu(parent, subMenu);
            for i=0,EntityDebugTestType.getValueList():size()-1 do
                local v = EntityDebugTestType.getValueList():get(i);
                subMenu:addOption("TestBuild: "..tostring(v), _data, self.buildTest, v );
            end
        end
    end

    function self.openPanel( _data, _entity )
        if ISEntityUI.CanOpenWindowFor(_data.player, _entity) then
            ISEntityUI.OpenWindow(_data.player, _entity)
        end
    end

    function self.buildTest( _data, _type )
        EntityMetaTest.CreateTest(_type, _data.squares[1]);
    end

    return self;
end