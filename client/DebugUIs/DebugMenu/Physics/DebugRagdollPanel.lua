require "DebugUIs/DebugMenu/Base/ISDebugPanelBase";

DebugRagdollPanel = ISDebugPanelBase:derive("DebugRagdollPanel");
DebugRagdollPanel.instance = nil;

function DebugRagdollPanel.OnOpenPanel()
    return ISDebugPanelBase.OnOpenPanel(DebugRagdollPanel, 0, 0, 800+(getCore():getOptionFontSizeReal()*100), 600, getText("IGUI_DebugMenu_Dev_RagdollSettings"));
end

function DebugRagdollPanel:new(x, y, width, height, title)
    x = getCore():getScreenWidth() / 2 - (width / 2);
    y = getCore():getScreenHeight() / 2 - (height / 2);
    local o = ISDebugPanelBase:new(x, y, width, height, title);
    setmetatable(o, self);
    self.__index = self;
    return o;
end

function DebugRagdollPanel:initialise()
    ISPanel.initialise(self);
    self:registerPanel(getText("IGUI_RagdollDebug_RagdollValues"),RagdollSettingsPanel);
    self:registerPanel(getText("IGUI_RagdollDebug_ForceHit"),ForceHitReactionPanel);
    self:registerPanel(getText("IGUI_RagdollDebug_HitReactionValues"),HitReactionSettingsPanel);
end