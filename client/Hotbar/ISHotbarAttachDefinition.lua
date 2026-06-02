ISHotbarAttachDefinition = ISHotbarAttachDefinition or {};
ISHotbarAttachDefinition.replacements = {};

local SmallBeltLeft = {
	type = "SmallBeltLeft",
	name = "Belt Left", -- Name shown in the slot icon
	animset = "belt left",
	attachments = { -- list of possible item category and their modelAttachement group, the item category is defined in the item script
		Knife = "Belt Left Upside", -- defined in AttachedLocations.lua
		NotKnife = "Belt Left Upside",
		Hammer = "Belt Left",
		HammerRotated = "Belt Rotated Left",
		Nightstick = "Nightstick Left",
		Screwdriver  = "Belt Left Screwdriver",
		Wrench = "Wrench Left",
		MeatCleaver = "MeatCleaver Belt Left",
		Walkie = "Walkie Belt Left",
		Sword = "Belt Left Upside",
		--KnifeClosed = "Knife Closed Left Leg", -- defined in AttachedLocations.lua
	},
}
table.insert(ISHotbarAttachDefinition, SmallBeltLeft);

local SmallBeltRight = {
	type = "SmallBeltRight",
	name = "Belt Right",
	animset = "belt right",
	attachments = {
		Knife = "Belt Right Upside",
		NotKnife = "Belt Right Upside",
		Hammer = "Belt Right",
		HammerRotated = "Belt Rotated Right",
		Nightstick = "Nightstick Right",
		Screwdriver  = "Belt Right Screwdriver",
		Wrench = "Wrench Right",
		MeatCleaver = "MeatCleaver Belt Right",
		Walkie = "Walkie Belt Right",
		Sword= "Belt Right Upside",
		--KnifeClosed = "Knife Closed Right Leg",
	},
}
table.insert(ISHotbarAttachDefinition, SmallBeltRight);

local HolsterRight = {
	type = "HolsterRight",
	name = "Holster",
	animset = "holster right",
	attachments = {
		Holster = "Holster Right",
		HolsterSmall = "Holster Right",
	},
}
table.insert(ISHotbarAttachDefinition, HolsterRight);

local HolsterLeft = {
	type = "HolsterLeft",
	name = "Holster",
	animset = "holster left",
	attachments = {
		Holster = "Holster Left",
		HolsterSmall = "Holster Left",
	},
}
table.insert(ISHotbarAttachDefinition, HolsterLeft);

local HolsterShoulder = {
	type = "HolsterShoulder",
	name = "Holster",
	animset = "holster left",
	attachments = {
		Holster = "Holster Shoulder",
		HolsterSmall = "Holster Shoulder",
	},
}
table.insert(ISHotbarAttachDefinition, HolsterShoulder);

local Back = {
	type = "Back",
	name = "Back",
	animset = "back",
	attachments = {
		BigWeapon = "Big Weapon On Back",
		BigBlade = "Blade On Back",
		Racket = "Racket On Back",
		Shovel = "Shovel Back",
		Guitar = "Guitar",
		GuitarAcoustic = "Guitar Acoustic",
		Pan = "Pan On Back",
		Rifle = "Rifle On Back",
		Saucepan = "Saucepan Back",
		Sword = "Blade On Back",
	},
}
table.insert(ISHotbarAttachDefinition, Back);

local BackReplacement = {
	type = "Bag",
	name = "Back",
	animset = "back",
	replacement = {
		BigWeapon = "Big Weapon On Back with Bag",
		BigBlade = "Big Blade On Back with Bag",
		Racket = "Racket Back with Bag",
		Shovel = "Shovel Back with Bag",
		Guitar = "null",
		GuitarAcoustic = "null",
		Pan = "Pan On Back with Bag";
		Rifle = "Rifle On Back with Bag",
		Saucepan = "Saucepan Back with Bag",
		Sword ="Big Blade On Back with Bag",
	}
}
table.insert(ISHotbarAttachDefinition.replacements, BackReplacement);

local BedrollBottom = {
	type = "BedrollBottom",
	name = "Bedroll Bottom",
	animset = "back",
	attachments = {
		Bedroll = "Bedroll Bottom",
	},
}
table.insert(ISHotbarAttachDefinition, BedrollBottom);

local BedrollBottomBig = {
	type = "BedrollBottomBig",
	name = "Bedroll Bottom",
	animset = "back",
	attachments = {
		Bedroll = "Bedroll Bottom Big",
	},
}
table.insert(ISHotbarAttachDefinition, BedrollBottomBig);

local BedrollBottomALICE = {
	type = "BedrollBottomALICE",
	name = "Bedroll Bottom",
	animset = "back",
	attachments = {
		Bedroll = "Bedroll Bottom ALICE",
	},
}
table.insert(ISHotbarAttachDefinition, BedrollBottomALICE);

local WebbingRight = {
	type = "WebbingRight",
	name = "Webbing Right",
	animset = "holster right",
	attachments = {
		Knife = "Webbing Right Knife",
		Walkie = "Webbing Right Walkie",
		Webbing = "Webbing Right Walkie",
	},
}
table.insert(ISHotbarAttachDefinition, WebbingRight);

local WebbingLeft = {
	type = "WebbingLeft",
	name = "Webbing Left",
	animset = "holster left",
	attachments = {
		Knife = "Webbing Left Knife",
		Walkie = "Webbing Left Walkie",
		Webbing = "Webbing Left Walkie",
	},
}
table.insert(ISHotbarAttachDefinition, WebbingLeft);

local HolsterAnkle = {
	type = "HolsterAnkle",
	name = "Holster",
	animset = "holster right",
	attachments = {
		HolsterSmall = "Holster Ankle",
	},
}
table.insert(ISHotbarAttachDefinition, HolsterAnkle);