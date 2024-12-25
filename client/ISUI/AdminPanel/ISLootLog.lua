--***********************************************************
--**              	  ROBERT JOHNSON                       **
--**              	  B L A I RALGOL                       **
--***********************************************************
-- LootLog by Blair/Algol
-- LootLog is activated, all loot that is spawned as normal container loot will be logged to the console.
-- this does not include the items that are spawned for randomized stories, they are spawned by a completely different system.

ISLootLog = ISPanelJoypad:derive("ISLootLog");
ISLootLog.instance = nil
ISLootLog.cheat = false