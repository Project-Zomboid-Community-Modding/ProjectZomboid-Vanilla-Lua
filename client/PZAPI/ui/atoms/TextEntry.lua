require "PZAPI/ui/atoms/Node"
local UI = PZAPI.UI

UI.TextEntry = UI.Node{
    _ATOM_UI_CLASS = AtomUITextEntry,
    font = UIFont.SdfRegular,
    text = "",
    setText = function(self, text)
        self.text = text
        if self.javaObj then
            self.javaObj:setText(text)
        end
    end,
    getText = function(self)
        if self.javaObj then
            return self.javaObj:getText()
        end
        return self.text
    end,
    setFont = function(self, uiFont)
        self.font = uiFont
        if self.javaObj then
            self.javaObj:setFont(uiFont)
        end
    end,
    focus = function(self)
        if self.javaObj then
            self.javaObj:focus()
        end
    end,
    unfocus = function(self)
        if self.javaObj then
            self.javaObj:unfocus()
        end
    end
}