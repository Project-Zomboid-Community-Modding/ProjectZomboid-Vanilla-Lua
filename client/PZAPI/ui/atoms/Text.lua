require "PZAPI/ui/atoms/Node"
local UI = PZAPI.UI

UI.Text = UI.Node{
    _ATOM_UI_CLASS = AtomUIText,
    font = UIFont.SdfRegular,
    text = "",
    setText = function(self, text)
        self.text = text
        if self.javaObj then
            self.javaObj:setText(text)
        end
    end,
    setFont = function(self, uiFont)
        self.font = uiFont
        if self.javaObj then
            self.javaObj:setFont(uiFont)
        end
    end
}