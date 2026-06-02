ISInventoryMenuElements = ISInventoryMenuElements or {};

function ISInventoryMenuElements.ContextMedia()
    local self 					= ISMenuElement.new();
    self.invMenu			    = ISContextManager.getInstance().getInventoryMenu();

    function self.init()
    end

    function self.createMenu( _item )
        if (getCore():getDebug() or isAdmin()) and _item:getScriptItem():getRecordedMediaCat() then
            if _item:getContainer() ~= self.invMenu.inventory then
                return;
            end
            local prefix = isAdmin() and "ADMIN" or "DBG"
            local parent = self.invMenu.context:addOption(prefix .. ": Change recording", self.invMenu, nil );
            local subMenu = ISContextMenu:getNew(self.invMenu.context);
            self.invMenu.context:addSubMenu(parent, subMenu);
            local list = getZomboidRadio():getRecordedMedia():getAllMediaForCategory(_item:getScriptItem():getRecordedMediaCat());
            subMenu:addOption("<NONE>", self.invMenu, self.changeRecording, _item, nil );
            for i=0, list:size()-1 do
                local other = list:get(i);
                subMenu:addOption(other:getTranslatedItemDisplayName(), self.invMenu, self.changeRecording, _item, other );
            end
        end
    end

    function self.openMediaInfo( _p, _item, _text )
        ISMediaInfo.openPanel(self.invMenu.playerNum ,_text);
    end

    function self.changeRecording( _p, _item, _other )
        if isClient() then
            local playerObj = getSpecificPlayer(self.invMenu.playerNum)
            local mediaIndex = _other and _other:getIndexForLua() or -1
            sendClientCommand(playerObj, "item", "changeRecording", { itemID=_item:getID(), mediaIndex=mediaIndex })
            return
        end
        if _other == nil then
            _item:setRecordedMediaIndexInteger(-1)
            _item:getContainer():setDrawDirty(true);
            return
        end
        _item:setRecordedMediaData(_other);
        _item:getContainer():setDrawDirty(true);
    end

    return self;
end
