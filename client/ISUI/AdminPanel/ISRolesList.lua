---
--- Created by Iurii.
--- DateTime: 3/6/2024 3:46 AM
---

ISRolesList = ISPanel:derive("ISRolesList");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6


--************************************************************************--
--** ISRolesList:initialise
--**
--************************************************************************--

function ISRolesList:initialise()
    ISPanel.initialise(self);
    local btnWid = 100

    self.add = ISButton:new(UI_BORDER_SPACING+1, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT - 1, btnWid, BUTTON_HGT, getText("IGUI_RolesList_Add"), self, ISRolesList.onClick);
    self.add.internal = "ADD";
    self.add.anchorTop = false
    self.add.anchorBottom = true
    self.add:initialise();
    self.add:instantiate();
    self.add.borderColor = {r=1, g=1, b=1, a=0.1};
    self.add.enable = false;
    if ISRolesList.instance.player:getRole():hasCapability(Capability.RolesWrite) then
        self.add.enable = true;
    end
    self:addChild(self.add);

    self.edit = ISButton:new((UI_BORDER_SPACING+1)*2 + btnWid, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT - 1, btnWid, BUTTON_HGT, getText("IGUI_RolesList_Edit"), self, ISRolesList.onClick);
    self.edit.internal = "EDIT";
    self.edit.anchorTop = false
    self.edit.anchorBottom = true
    self.edit:initialise();
    self.edit:instantiate();
    self.edit.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.edit);
    self.edit.enable = false;

    self.delete = ISButton:new((UI_BORDER_SPACING+1)*3 + btnWid*2, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT - 1, btnWid, BUTTON_HGT, getText("IGUI_RolesList_Delete"), self, ISRolesList.onClick);
    self.delete.internal = "DELETE";
    self.delete.anchorTop = false
    self.delete.anchorBottom = true
    self.delete:initialise();
    self.delete:instantiate();
    self.delete.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.delete);
    self.delete.enable = false;

    self.close = ISButton:new(self.width - btnWid - (UI_BORDER_SPACING+1)*2, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT - 1, btnWid, BUTTON_HGT, getText("IGUI_RolesList_Close"), self, ISRolesList.onClick);
    self.close.internal = "CLOSE";
    self.close.anchorTop = false
    self.close.anchorBottom = true
    self.close:initialise();
    self.close:instantiate();
    self.close.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.close);

    local listY = UI_BORDER_SPACING*2 + FONT_HGT_MEDIUM+1
    self.datas = ISScrollingListBox:new(UI_BORDER_SPACING+1, FONT_HGT_MEDIUM+(UI_BORDER_SPACING+1)*2, self.width - (UI_BORDER_SPACING+1)*2, self:getHeight() - BUTTON_HGT - (UI_BORDER_SPACING + 1)*4 - FONT_HGT_MEDIUM);
    self.datas:initialise();
    self.datas:instantiate();
    self.datas.itemheight = FONT_HGT_SMALL + 6 + 2 * (FONT_HGT_SMALL + 3)
    self.datas.selected = 0;
    self.datas.joypadParent = self;
    self.datas.font = UIFont.NewSmall;
    self.datas.doDrawItem = self.drawDatas;
    self.datas.onmousedown = self.onSelectRole
    self.datas.onRightMouseUp = ISRolesList.onRightMouse;
    self.datas.drawBorder = true;
    self.datas.parent = self;
    self:addChild(self.datas);

    self:populateList();
end

function ISRolesList:populateList()
    self.datas:clear();
    local roles = getRoles()
    for i=0,roles:size()-1 do
        local role = roles:get(i);
        self.datas:addItem(role:getName(), role);
    end
    table.sort(self.datas.items, function(a, b) return a.item:getPosition()>b.item:getPosition() end)
end

function ISRolesList:drawDatas(y, item, alt)
    local a = 0.9;

    --    self.parent.selectedFaction = nil;
    self:drawRectBorder(0, (y), self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15);
    end

    local readOnlyTxt = "";
    if item.item:isReadOnly() then
        readOnlyTxt = "[Read Only]";
    end
    local defaultsTxt = "";
    local defaults = item.item:getDefaults()
    for i=0,defaults:size()-1 do
        defaultsTxt = defaultsTxt .. defaults:get(i) .. " "
    end
    local color = item.item:getColor()
    self:drawText(item.item:getName(), 10, y + 2, color:getR(), color:getG(), color:getB(), a, UIFont.Medium);

    self:drawText(item.item:getDescription(), 10, y + 2 + (FONT_HGT_SMALL + 3), 1, 1, 1, a, self.font);
    self:drawText(readOnlyTxt .. " " .. defaultsTxt, 10, y + 2 + (FONT_HGT_SMALL + 3) * 2, 1, 1, 1, a, self.font);

    return y + self.itemheight;
end

function ISRolesList:onSelectRole(_item)
    if ISRolesList.instance.player:getRole():hasCapability(Capability.RolesWrite) then
        ISRolesList.instance.delete.enable = true;
        ISRolesList.instance.edit.enable = true;
    end
    ISRolesList.instance.selectedItem = _item;
end

function ISRolesList:prerender()
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawText(getText("IGUI_AdminPanel_SeeRoles"), self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_AdminPanel_SeeRoles")) / 2), UI_BORDER_SPACING+1, 1,1,1,1, UIFont.Medium);
end

function ISRolesList:onMouseMove(dx, dy)
    local x = Mouse.getXA()
    local y = Mouse.getYA()
    if (self.tooltipUI ~= nil) and
            ( (x < self.datas.x+self.x) or
                    (x > self.datas.x+self.x+self.datas.width) or
                    (y < self.datas.y+self.y) or
                    (y > self.y+self.datas.height) ) then
        self.tooltipUI:setVisible(false);
    end
    for i,item in ipairs(self.datas.items) do
        if (y < self.y + self.datas.y + self.datas.height) and
                (x > self.x + self.datas.x) and
                (x < self.x + self.datas.x + self.datas.width) and
                (y > self.y + self.datas.y + self.datas.itemheight*(i-1) + self.datas:getYScroll()) and
                (y < self.y + self.datas.y + self.datas.itemheight*i + self.datas:getYScroll()) then
            if not self.tooltipUI then
                self.tooltipUI = ISToolTip:new()
                self.tooltipUI:setOwner(self)
                self.tooltipUI:setVisible(false)
                self.tooltipUI:setAlwaysOnTop(true)
            end
            if (item.item:getDescription() == "") then
                if self.tooltipUI:getIsVisible() then
                    self.tooltipUI:setVisible(false)
                end
            else
                if not self.tooltipUI:getIsVisible() then
                    self.tooltipUI:addToUIManager()
                    self.tooltipUI:setVisible(true)
                end
            end
            self.tooltipUI.description = item.item:getDescription()
            self.tooltipUI:setX(x)
            self.tooltipUI:setY(y)
        end
    end
end

function ISRolesList:onMouseMoveOutside(dx, dy)
    if (self.tooltipUI ~= null) then
        self.tooltipUI:setVisible(false)
        self.tooltipUI = null
    end
end

function ISRolesList:onClick(button)
    if button.internal == "ADD" then
        local modal = ISTextBox:new(0, 0, 280, 180, getText("IGUI_RolesList_AddRole"), "", nil, ISRolesList.onAddRoleClick, self.player:getPlayerNum());
        modal:initialise();
        modal:addToUIManager();
        return;
    end
    if button.internal == "EDIT" then
        if ISModalEditRole.instance then
            ISModalEditRole.instance:closeModal()
        end
        local ui = ISModalEditRole:new(50,50,400,800, self.datas.items[self.datas.selected].item);
        ui:initialise();
        ui:addToUIManager();
        return;
    end


    if button.internal == "DELETE" then
        local modal = ISModalDialog:new((getCore():getScreenWidth() / 2) - 130, (getCore():getScreenHeight() / 2) - 60, 260, 120, getText("IGUI_RolesList_DeleteRole"), true, self, ISRolesList.onDeleteModalClick);
        modal:initialise();
        modal:addToUIManager();
        return;
    end
    if button.internal == "CLOSE" then
        ISRolesList.instance:closeModal()
        return;
    end
end

function ISRolesList:onClickOption(item, action)
    if action == "DEFAULTFORBANNED" then
        setDefaultRoleFor("defaultForBanned", item:getName());
        return;
    end
    if action == "DEFAULTFORNEWUSER" then
        setDefaultRoleFor("defaultForNewUser", item:getName());
        return;
    end
    if action == "DEFAULTFORUSER" then
        setDefaultRoleFor("defaultForUser", item:getName());
        return;
    end
    if action == "DEFAULTFORPRIORITYUSER" then
        setDefaultRoleFor("defaultForPriorityUser", item:getName());
        return;
    end
    if action == "DEFAULTFOROBSERVER" then
        setDefaultRoleFor("defaultForObserver", item:getName());
        return;
    end
    if action == "DEFAULTFORGM" then
        setDefaultRoleFor("defaultForGM", item:getName());
        return;
    end
    if action == "DEFAULTFOROVERSEER" then
        setDefaultRoleFor("defaultForOverseer", item:getName());
        return;
    end
    if action == "DEFAULTFORMODERATOR" then
        setDefaultRoleFor("defaultForModerator", item:getName());
        return;
    end

    if action == "UP" then
        moveRole(1, item:getName());
        return;
    end

    if action == "DOWN" then
        moveRole(-1, item:getName());
        return;
    end

    if action == "EDIT" then
        if ISModalEditRole.instance then
            ISModalEditRole.instance:closeModal()
        end
        local ui = ISModalEditRole:new(50,50,400,800, item);
        ui:initialise();
        ui:addToUIManager();
        return;
    end
    if action == "DELETE" then
        local modal = ISModalDialog:new((getCore():getScreenWidth() / 2) - 130, (getCore():getScreenHeight() / 2) - 60, 260, 120, getText("IGUI_RolesList_DeleteRole"), true, ISRolesList.instance, ISRolesList.onDeleteModalClick);
        modal:initialise();
        modal:addToUIManager();
        return;
    end
end

function ISRolesList:onDeleteModalClick(button)
    if ISRolesList.instance.joyfocus then
        ISRolesList.instance.joyfocus.focus = ISRolesList.instance.listbox
    end
    if button.internal == "YES" then
        deleteRole(self.datas.items[self.datas.selected].item:getName());
        ISRolesList.instance:populateList()
    end
end

function ISRolesList:onAddRoleClick(button)
    if button.internal == "OK" then
        if button.parent.entry:getText() and button.parent.entry:getText() ~= "" then
            addRole(button.parent.entry:getInternalText());
            ISRolesList.instance:populateList()
        end
    end
end

function ISRolesList:onRightMouse(x, y)
    ISRolesList.instance.datas:onMouseDown(x, y)
    ISRolesList.instance:doContextMenu(ISRolesList.instance.datas.items[ISRolesList.instance.datas.selected].item, x, y)
end

function ISRolesList:doContextMenu(item, x, y)
    local playerNum = self.player:getPlayerNum()
    local context = ISContextMenu.get(playerNum, x + self:getAbsoluteX(), y + self:getAbsoluteY());
    if ISRolesList.instance.player:getRole():hasCapability(Capability.RolesWrite) then
        context:addOption(getText("IGUI_RolesList_SetDefaultForBanned"), ISRolesList.instance, ISRolesList.onClickOption, item, "DEFAULTFORBANNED");
        context:addOption(getText("IGUI_RolesList_SetDefaultForNewUser"), ISRolesList.instance, ISRolesList.onClickOption, item, "DEFAULTFORNEWUSER");
        context:addOption(getText("IGUI_RolesList_SetDefaultForUser"), ISRolesList.instance, ISRolesList.onClickOption, item, "DEFAULTFORUSER");
        context:addOption(getText("IGUI_RolesList_SetDefaultForPriorityUser"), ISRolesList.instance, ISRolesList.onClickOption, item, "DEFAULTFORPRIORITYUSER");
        context:addOption(getText("IGUI_RolesList_SetDefaultForObserver"), ISRolesList.instance, ISRolesList.onClickOption, item, "DEFAULTFOROBSERVER");
        context:addOption(getText("IGUI_RolesList_SetDefaultForGM"), ISRolesList.instance, ISRolesList.onClickOption, item, "DEFAULTFORGM");
        context:addOption(getText("IGUI_RolesList_SetDefaultForOverseer"), ISRolesList.instance, ISRolesList.onClickOption, item, "DEFAULTFOROVERSEER");
        context:addOption(getText("IGUI_RolesList_SetDefaultForModerator"), ISRolesList.instance, ISRolesList.onClickOption, item, "DEFAULTFORMODERATOR");
        context:addOption(getText("IGUI_RolesList_Edit"), ISRolesList.instance, ISRolesList.onClickOption, item, "EDIT");
        context:addOption(getText("IGUI_RolesList_Delete"), ISRolesList.instance, ISRolesList.onClickOption, item, "DELETE");
        if not item:isReadOnly() then
            context:addOption(getText("IGUI_RolesList_Up"), ISRolesList.instance, ISRolesList.onClickOption, item, "UP");
            context:addOption(getText("IGUI_RolesList_Down"), ISRolesList.instance, ISRolesList.onClickOption, item, "DOWN");
        end
    end
end

function ISRolesList:closeModal()
    self:setVisible(false);
    self:removeFromUIManager();
    ISRolesList.instance = nil
end

--************************************************************************--
--** ISFactionsList:new
--**
--************************************************************************--
function ISRolesList:new(x, y, width, height, player)
    local o = {}
    x = getCore():getScreenWidth() / 2 - (width / 2);
    y = getCore():getScreenHeight() / 2 - (height / 2);
    o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.width = width;
    o.height = height;
    o.player = player;
    o.moveWithMouse = true;
    ISRolesList.instance = o;
    return o;
end