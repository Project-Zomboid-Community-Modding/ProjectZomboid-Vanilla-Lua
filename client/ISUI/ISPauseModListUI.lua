
PauseBuggedModList = {}

ISPauseModListUI = ISPanelJoypad:derive("ISPauseModListUI");

function ISPauseModListUI:initialise()
    ISPanelJoypad.initialise(self);

    self.chatText = ISRichTextPanel:new(0, 0, self.width, self.height);
    self.chatText.marginRight = self.chatText.marginLeft;
    self.chatText:initialise();
    self:addChild(self.chatText);
    self.chatText.background = false;
    self.chatText.autosetheight = false;
    self.chatText.clip = true
    self.chatText:addScrollBars();

    local text = ""
    local modItems = {}

    if isClient() then
        local modString = getServerOptions():getOptionByName("Mods"):getValue()
        modItems = string.split(modString, ";")
    else
        local saveInfo = getSaveInfo(getWorld():getWorld())
        local activeMods = saveInfo.activeMods
        if activeMods == nil then
        elseif activeMods:getMods():isEmpty() then
        else
            for i=1,activeMods:getMods():size() do
                table.insert(modItems, activeMods:getMods():get(i-1))
            end
        end
    end

    for i, modID in ipairs(modItems) do
        local modInfo = getModInfoByID(modID)
        if modInfo == nil then
            text = text .. " <LINE> <RGB:1,1,0> " .. modID .. " [Not found]"
        elseif not modInfo:isAvailable() then
            modID = modInfo:getName()
            text = text .. " <LINE> <RGB:1,1,0> " .. modID .. " [Not available]"
        else
            modID = modInfo:getName()
            if PauseBuggedModList[modID] then
                text = text .. " <LINE> <RED> [ERRORS] " .. modID
            else
                text = text .. " <LINE> <RGB:1,1,1> " .. modID
            end
        end
    end

    self.chatText.text = string.sub(text, 9)
    self.chatText:paginate()
end

function ISPauseModListUI:destroy()
    self:setVisible(false);
    self:removeFromUIManager();
end

function ISPauseModListUI:new(x, y, width, height)
    local o = {}
    o = ISPanelJoypad:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.name = nil;
    o.backgroundColor = {r=0, g=0, b=0, a=0.2};
    o.borderColor = {r=0, g=0, b=0, a=0};
    o.width = width;
    o.height = height;
    o.anchorLeft = true;
    o.anchorRight = true;
    o.anchorTop = true;
    o.anchorBottom = true;
    o.destroyOnClick = false;
    return o;
end

