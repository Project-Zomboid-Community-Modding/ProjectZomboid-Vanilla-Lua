--***********************************************************
--**              	  ROBERT JOHNSON                       **
--**            UI display with a question or text         **
--**          can display a yes/no button or ok btn        **
--***********************************************************

ISCreateFactionTagUI = ISPanel:derive("ISCreateFactionTagUI");
ISCreateFactionTagUI.messages = {};

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

--************************************************************************--
--** ISCreateFactionTagUI:initialise
--**
--************************************************************************--

function ISCreateFactionTagUI:initialise()
    ISPanel.initialise(self);
    local btnWid = 100
    local y = FONT_HGT_MEDIUM + UI_BORDER_SPACING*2 + 1;

    local tagLbl = ISLabel:new(UI_BORDER_SPACING+1, y, BUTTON_HGT, getText("IGUI_FactionUI_Tag"), 1, 1, 1, 1, UIFont.Small, true)
    tagLbl:initialise()
    tagLbl:instantiate()
    self:addChild(tagLbl)

    self.entry = ISTextEntryBox:new(self.faction:getTag() or "", tagLbl:getRight() + UI_BORDER_SPACING, tagLbl.y, self.width - tagLbl:getRight() - UI_BORDER_SPACING*2 - 1, BUTTON_HGT);
    self.entry.font = UIFont.Small;
    self.entry:initialise();
    self.entry:instantiate();
    self:addChild(self.entry);

    self.no = ISButton:new(self:getWidth() - btnWid - UI_BORDER_SPACING - 1, tagLbl:getBottom() + UI_BORDER_SPACING, btnWid, BUTTON_HGT, getText("UI_Cancel"), self, ISCreateFactionTagUI.onClick);
    self.no.internal = "CANCEL";
    self.no:initialise();
    self.no:instantiate();
    self.no.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.no);

    self.ok = ISButton:new(UI_BORDER_SPACING+1, self.no.y, btnWid, BUTTON_HGT, getText("UI_Ok"), self, ISCreateFactionTagUI.onClick);
    self.ok.internal = "OK";
    self.ok:initialise();
    self.ok:instantiate();
    self.ok.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.ok);

    self:setHeight(self.no:getBottom() + UI_BORDER_SPACING+1)
end


function ISCreateFactionTagUI:render()
    self:updateButtons();
end

function ISCreateFactionTagUI:prerender()
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawText(getText("IGUI_FactionUI_ChangeTag"), self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_FactionUI_ChangeTag")) / 2), UI_BORDER_SPACING+1, 1,1,1,1, UIFont.Medium);

--    z = z + 30;
--    self:drawText(getText("IGUI_FactionUI_Tag"), 10, z, 1,1,1,1, UIFont.Small);
--    self.entry:setY(z)
--    self.entry:setX(getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_FactionUI_Tag")) + 15);
end

function ISCreateFactionTagUI:updateButtons()
    self.ok.enable = true;
    self.ok.tooltip = nil;
    local tagName = self.entry:getInternalText();
    if Faction.tagExist(tagName) then
        self.ok.enable = false;
        self.ok.tooltip = getText("IGUI_FactionUI_TagAlreadyExist");
    end
    if tagName:len() < 1 or tagName:len() > 4 then
        self.ok.enable = false;
        self.ok.tooltip = getText("IGUI_FactionUI_TagTooLongShort");
    end
    if not self.faction:canCreateTag() then
        self.ok.enable = false;
        self.ok.tooltip = getText("IGUI_FactionUI_TagMembersIncorrect", getServerOptions():getInteger("FactionPlayersRequiredForTag"));
    end
end

function ISCreateFactionTagUI:onClick(button)
    if button.internal == "CANCEL" then
        self:setVisible(false);
        self:removeFromUIManager();
    end
    if button.internal == "OK" then
        self.faction:setTag(button.parent.entry:getText());
        self.faction:syncFaction();
        self:setVisible(false);
        self:removeFromUIManager();
    end
end

--************************************************************************--
--** ISCreateFactionTagUI:new
--**
--************************************************************************--
function ISCreateFactionTagUI:new(x, y, width, height, player, faction)
    local o = {}
    o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    if y == 0 then
        o.y = o:getMouseY() - (height / 2)
        o:setY(o.y)
    end
    if x == 0 then
        o.x = o:getMouseX() - (width / 2)
        o:setX(o.x)
    end
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.width = width;
    o.height = height;
    o.player = player;
    o.moveWithMouse = true;
    o.faction = faction;
    ISCreateFactionTagUI.instance = o;
    o.buttonBorderColor = {r=0.7, g=0.7, b=0.7, a=0.5};
    return o;
end
