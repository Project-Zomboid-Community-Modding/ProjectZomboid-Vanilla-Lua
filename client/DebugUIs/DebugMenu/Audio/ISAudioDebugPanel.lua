--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "DebugUIs/DebugMenu/Base/ISDebugPanelBase";

ISAudioDebugPanel = ISDebugPanelBase:derive("ISAudioDebugPanel");
ISAudioDebugPanel.instance = nil;

function ISAudioDebugPanel:initialise()
	ISPanel.initialise(self);
	self:registerPanel(getText("IGUI_AudioDebug_IntensityEvents"), ISMusicIntensityEventsPanel)
	self:registerPanel(getText("IGUI_AudioDebug_ThreatStatus"), ISMusicThreatStatusPanel)
	self:registerPanel(getText("IGUI_AudioDebug_FMOD"), ISFMODEventPlayerPanel)
end

function ISAudioDebugPanel:new(x, y, width, height, title)
	x = getCore():getScreenWidth() / 2 - (width / 2)
	y = getCore():getScreenHeight() / 2 - (height / 2)
	local o = ISDebugPanelBase.new(self, x, y, width, height, title)
	return o
end

function ISAudioDebugPanel.OnOpenPanel()
	return ISDebugPanelBase.OnOpenPanel(ISAudioDebugPanel, 100, 100, 800+(getCore():getOptionFontSizeReal()*100), 600, getText("IGUI_AudioDebug_Title"))
end

