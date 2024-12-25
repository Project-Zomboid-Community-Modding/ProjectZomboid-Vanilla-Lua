local win = nil

local onKey = function(key)
    if not getDebug() then return; end
    if key == 15 then   -- "TAB"
        --Translator.loadFiles()
        --doNewUIDebug()

        if win then
            UIManager.RemoveElement(win.javaObj)
            reloadLuaFile("media/lua/client/PZAPI/ui/molecules/TabPanel.lua")
            reloadLuaFile("media/lua/client/PZAPI/ui/organisms/TestExample.lua")
        end
        win = PZAPI.UI.TestExample{}
        win:instantiate()
        --win:setAlwaysOnTop(true)
    end
end
-- Events.OnKeyPressed.Add(onKey)

