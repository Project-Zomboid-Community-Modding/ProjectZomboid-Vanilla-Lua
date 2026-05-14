ISWorldMenuElements = ISWorldMenuElements or {};

function ISWorldMenuElements.ContextEntity()
    local self = ISMenuElement.new();

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
