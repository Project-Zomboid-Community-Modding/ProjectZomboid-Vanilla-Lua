--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 25/01/2022
-- Time: 10:08
-- To change this template use File | Settings | File Templates.
--

AnimalAvatarDefinition = {};

AnimalAvatarDefinition["cow"] = {};
AnimalAvatarDefinition["cow"].zoom = 0; -- this is used for ISAnimal.UI
AnimalAvatarDefinition["cow"].xoffset = 0.1; -- this is used for ISAnimal.UI
AnimalAvatarDefinition["cow"].yoffset = 0; -- this is used for ISAnimal.UI
AnimalAvatarDefinition["cow"].avatarWidth = 200; -- this is used for ISAnimal.UI
AnimalAvatarDefinition["cow"].avatarDir = IsoDirections.SE; -- this is used for ISAnimal.UI
--
AnimalAvatarDefinition["cow"].trailerDir = IsoDirections.SW; -- this is used for ISVehicleAnimal.UI
AnimalAvatarDefinition["cow"].trailerZoom = 0; -- this is used for ISVehicleAnimal.UI
AnimalAvatarDefinition["cow"].trailerXoffset = 0.6; -- this is used for ISVehicleAnimal.UI
AnimalAvatarDefinition["cow"].trailerYoffset = -0.6; -- this is used for ISVehicleAnimal.UI

-- butchering hook stuff
AnimalAvatarDefinition["cow"].hook = true;
AnimalAvatarDefinition["cow"].butcherHookZoom = -3; -- for avatar
AnimalAvatarDefinition["cow"].butcherHookXoffset = 0; -- for avatar
AnimalAvatarDefinition["cow"].butcherHookYoffset = 0.55; -- for avatar
AnimalAvatarDefinition["cow"].animalPositionSize = 0.6; -- i'm forcing a size when displaying the animal on the hook as cows can be quite huge!
AnimalAvatarDefinition["cow"].animalPositionX = 0.1; -- the 3D animal on the hook
AnimalAvatarDefinition["cow"].animalPositionY = 0.5; -- the 3D animal on the hook
AnimalAvatarDefinition["cow"].animalPositionZ = 0.66; -- the 3D animal on the hook

AnimalAvatarDefinition["bull"] = {};
AnimalAvatarDefinition["bull"].zoom = AnimalAvatarDefinition["cow"].zoom;
AnimalAvatarDefinition["bull"].xoffset = AnimalAvatarDefinition["cow"].xoffset;
AnimalAvatarDefinition["bull"].yoffset = AnimalAvatarDefinition["cow"].yoffset;
AnimalAvatarDefinition["bull"].avatarWidth = 200;
AnimalAvatarDefinition["bull"].avatarDir = IsoDirections.SE;
AnimalAvatarDefinition["bull"].trailerDir = AnimalAvatarDefinition["cow"].trailerDir;
AnimalAvatarDefinition["bull"].trailerZoom = AnimalAvatarDefinition["cow"].trailerZoom;
AnimalAvatarDefinition["bull"].trailerXoffset = AnimalAvatarDefinition["cow"].trailerXoffset;
AnimalAvatarDefinition["bull"].trailerYoffset = AnimalAvatarDefinition["cow"].trailerYoffset;
-- butchering hook stuff
AnimalAvatarDefinition["bull"].hook = true;
AnimalAvatarDefinition["bull"].butcherHookZoom = -3; -- for avatar
AnimalAvatarDefinition["bull"].butcherHookXoffset = 0; -- for avatar
AnimalAvatarDefinition["bull"].butcherHookYoffset = 0.55; -- for avatar
AnimalAvatarDefinition["bull"].animalPositionSize = 0.6; -- i'm forcing a size when displaying the animal on the hook as cows can be quite huge!
AnimalAvatarDefinition["bull"].animalPositionX = 0.1; -- the 3D animal on the hook
AnimalAvatarDefinition["bull"].animalPositionY = 0.5; -- the 3D animal on the hook
AnimalAvatarDefinition["bull"].animalPositionZ = 0.66; -- the 3D animal on the hook

AnimalAvatarDefinition["ewe"] = {};
AnimalAvatarDefinition["ewe"].zoom = 8;
AnimalAvatarDefinition["ewe"].xoffset = -0.1;
AnimalAvatarDefinition["ewe"].yoffset = -0.2;
AnimalAvatarDefinition["ewe"].avatarWidth = 200;
AnimalAvatarDefinition["ewe"].avatarDir = IsoDirections.SE;
AnimalAvatarDefinition["ewe"].trailerDir = IsoDirections.SW;
AnimalAvatarDefinition["ewe"].trailerZoom = 8.5;
AnimalAvatarDefinition["ewe"].trailerXoffset = 0.2;
AnimalAvatarDefinition["ewe"].trailerYoffset = -0.3;
-- butchering hook stuff
AnimalAvatarDefinition["ewe"].hook = true;
AnimalAvatarDefinition["ewe"].butcherHookZoom = 1;
AnimalAvatarDefinition["ewe"].butcherHookXoffset = 0;
AnimalAvatarDefinition["ewe"].butcherHookYoffset = 0.45;
AnimalAvatarDefinition["ewe"].animalPositionSize = 0.6;
AnimalAvatarDefinition["ewe"].animalPositionX = 0.1;
AnimalAvatarDefinition["ewe"].animalPositionY = 0.5;
AnimalAvatarDefinition["ewe"].animalPositionZ = 0.7;

AnimalAvatarDefinition["ram"] = {};
AnimalAvatarDefinition["ram"].zoom = 6;
AnimalAvatarDefinition["ram"].xoffset = AnimalAvatarDefinition["ewe"].xoffset;
AnimalAvatarDefinition["ram"].yoffset = AnimalAvatarDefinition["ewe"].yoffset;
AnimalAvatarDefinition["ram"].avatarWidth = 200;
AnimalAvatarDefinition["ram"].avatarDir = IsoDirections.SE;
AnimalAvatarDefinition["ram"].trailerZoom = 0;
AnimalAvatarDefinition["ram"].trailerXoffset = 0;
AnimalAvatarDefinition["ram"].trailerYoffset = -0.25;
-- butchering hook stuff
AnimalAvatarDefinition["ram"].hook = true;
AnimalAvatarDefinition["ram"].butcherHookZoom = 1;
AnimalAvatarDefinition["ram"].butcherHookXoffset = 0;
AnimalAvatarDefinition["ram"].butcherHookYoffset = 0.45;
AnimalAvatarDefinition["ram"].animalPositionSize = 0.6;
AnimalAvatarDefinition["ram"].animalPositionX = 0.1;
AnimalAvatarDefinition["ram"].animalPositionY = 0.5;
AnimalAvatarDefinition["ram"].animalPositionZ = 0.7;

AnimalAvatarDefinition["turkeyhen"] = {};
AnimalAvatarDefinition["turkeyhen"].zoom = 10;
AnimalAvatarDefinition["turkeyhen"].xoffset = -0.1;
AnimalAvatarDefinition["turkeyhen"].yoffset = -0.2;
AnimalAvatarDefinition["turkeyhen"].avatarWidth = 200;
AnimalAvatarDefinition["turkeyhen"].avatarDir = IsoDirections.SE;
AnimalAvatarDefinition["turkeyhen"].trailerDir = IsoDirections.SW;
AnimalAvatarDefinition["turkeyhen"].trailerZoom = 8.5;
AnimalAvatarDefinition["turkeyhen"].trailerXoffset = 0.2;
AnimalAvatarDefinition["turkeyhen"].trailerYoffset = -0.3;

AnimalAvatarDefinition["gobblers"] = {};
AnimalAvatarDefinition["gobblers"].zoom = AnimalAvatarDefinition["turkeyhen"].zoom;
AnimalAvatarDefinition["gobblers"].xoffset = AnimalAvatarDefinition["turkeyhen"].xoffset;
AnimalAvatarDefinition["gobblers"].yoffset = AnimalAvatarDefinition["turkeyhen"].yoffset;
AnimalAvatarDefinition["gobblers"].avatarWidth = 200;
AnimalAvatarDefinition["gobblers"].avatarDir = IsoDirections.SE;
AnimalAvatarDefinition["gobblers"].trailerZoom = 0;
AnimalAvatarDefinition["gobblers"].trailerXoffset = 0;
AnimalAvatarDefinition["gobblers"].trailerYoffset = -0.25;

AnimalAvatarDefinition["hen"] = {};
AnimalAvatarDefinition["hen"].zoom = 15;
AnimalAvatarDefinition["hen"].xoffset = 0;
AnimalAvatarDefinition["hen"].yoffset = -0.1;
AnimalAvatarDefinition["hen"].avatarWidth = 200;
AnimalAvatarDefinition["hen"].avatarDir = IsoDirections.SE;
AnimalAvatarDefinition["hen"].trailerDir = IsoDirections.SW;
AnimalAvatarDefinition["hen"].trailerZoom = 12;
AnimalAvatarDefinition["hen"].trailerXoffset = 0;
AnimalAvatarDefinition["hen"].trailerYoffset = -0.2;

AnimalAvatarDefinition["cockerel"] = {};
AnimalAvatarDefinition["cockerel"].zoom = 14;
AnimalAvatarDefinition["cockerel"].xoffset = 0;
AnimalAvatarDefinition["cockerel"].yoffset = -0.16;
AnimalAvatarDefinition["cockerel"].avatarWidth = 200;
AnimalAvatarDefinition["cockerel"].avatarDir = IsoDirections.SE;
AnimalAvatarDefinition["cockerel"].trailerDir = AnimalAvatarDefinition["hen"].trailerDir;
AnimalAvatarDefinition["cockerel"].trailerZoom = AnimalAvatarDefinition["hen"].trailerZoom;
AnimalAvatarDefinition["cockerel"].trailerXoffset = AnimalAvatarDefinition["hen"].trailerXoffset;
AnimalAvatarDefinition["cockerel"].trailerYoffset = AnimalAvatarDefinition["hen"].trailerYoffset;

AnimalAvatarDefinition["chick"] = {};
AnimalAvatarDefinition["chick"].zoom = 20;
AnimalAvatarDefinition["chick"].xoffset = -0.02;
AnimalAvatarDefinition["chick"].yoffset = -0.05;
AnimalAvatarDefinition["chick"].avatarWidth = 200;
AnimalAvatarDefinition["chick"].avatarDir = IsoDirections.SE;
AnimalAvatarDefinition["chick"].trailerDir = AnimalAvatarDefinition["hen"].trailerDir;
AnimalAvatarDefinition["chick"].trailerZoom = AnimalAvatarDefinition["hen"].trailerZoom;
AnimalAvatarDefinition["chick"].trailerXoffset = AnimalAvatarDefinition["hen"].trailerXoffset;
AnimalAvatarDefinition["chick"].trailerYoffset = -0.10;

AnimalAvatarDefinition["sow"] = {};
AnimalAvatarDefinition["sow"].zoom = 4;
AnimalAvatarDefinition["sow"].xoffset = -0.1;
AnimalAvatarDefinition["sow"].yoffset = -0.23;
AnimalAvatarDefinition["sow"].avatarWidth = 200;
AnimalAvatarDefinition["sow"].avatarDir = IsoDirections.SE;
AnimalAvatarDefinition["sow"].trailerDir = IsoDirections.SW;
AnimalAvatarDefinition["sow"].trailerZoom = 8;
AnimalAvatarDefinition["sow"].trailerXoffset = 0.3;
AnimalAvatarDefinition["sow"].trailerYoffset = -0.4;
-- butchering hook stuff
AnimalAvatarDefinition["sow"].hook = true;
AnimalAvatarDefinition["sow"].butcherHookZoom = -1;
AnimalAvatarDefinition["sow"].butcherHookXoffset = 0;
AnimalAvatarDefinition["sow"].butcherHookYoffset = 0.47;
AnimalAvatarDefinition["sow"].animalPositionSize = 0.6;
AnimalAvatarDefinition["sow"].animalPositionX = 0.1;
AnimalAvatarDefinition["sow"].animalPositionY = 0.5;
AnimalAvatarDefinition["sow"].animalPositionZ = 0.69;

AnimalAvatarDefinition["boar"] = {};
AnimalAvatarDefinition["boar"].zoom = AnimalAvatarDefinition["sow"].zoom;
AnimalAvatarDefinition["boar"].xoffset = AnimalAvatarDefinition["sow"].xoffset;
AnimalAvatarDefinition["boar"].yoffset = AnimalAvatarDefinition["sow"].yoffset;
AnimalAvatarDefinition["boar"].avatarWidth = 200;
AnimalAvatarDefinition["boar"].avatarDir = IsoDirections.SE;
AnimalAvatarDefinition["boar"].trailerDir = AnimalAvatarDefinition["sow"].trailerDir;
AnimalAvatarDefinition["boar"].trailerZoom = AnimalAvatarDefinition["sow"].trailerZoom;
AnimalAvatarDefinition["boar"].trailerXoffset = AnimalAvatarDefinition["sow"].trailerXoffset;
AnimalAvatarDefinition["boar"].trailerYoffset = AnimalAvatarDefinition["sow"].trailerYoffset;
-- butchering hook stuff
AnimalAvatarDefinition["boar"].hook = true;
AnimalAvatarDefinition["boar"].butcherHookZoom = -1;
AnimalAvatarDefinition["boar"].butcherHookXoffset = 0;
AnimalAvatarDefinition["boar"].butcherHookYoffset = 0.47;
AnimalAvatarDefinition["boar"].animalPositionSize = 0.6;
AnimalAvatarDefinition["boar"].animalPositionX = 0.1;
AnimalAvatarDefinition["boar"].animalPositionY = 0.5;
AnimalAvatarDefinition["boar"].animalPositionZ = 0.66;

AnimalAvatarDefinition["cowcalf"] = {};
AnimalAvatarDefinition["cowcalf"].zoom = 10;
AnimalAvatarDefinition["cowcalf"].xoffset = 0.008;
AnimalAvatarDefinition["cowcalf"].yoffset = -0.2;
AnimalAvatarDefinition["cowcalf"].avatarWidth = 200;
AnimalAvatarDefinition["cowcalf"].avatarDir = IsoDirections.SE;
AnimalAvatarDefinition["cowcalf"].trailerDir = IsoDirections.SW;
AnimalAvatarDefinition["cowcalf"].trailerZoom = 7;
AnimalAvatarDefinition["cowcalf"].trailerXoffset = 0.1;
AnimalAvatarDefinition["cowcalf"].trailerYoffset = -0.4;
-- butchering hook stuff
AnimalAvatarDefinition["cowcalf"].hook = true;
AnimalAvatarDefinition["cowcalf"].butcherHookZoom = 2;
AnimalAvatarDefinition["cowcalf"].butcherHookXoffset = 0;
AnimalAvatarDefinition["cowcalf"].butcherHookYoffset = 0.42;
AnimalAvatarDefinition["cowcalf"].animalPositionSize = 0.6;
AnimalAvatarDefinition["cowcalf"].animalPositionX = 0.1;
AnimalAvatarDefinition["cowcalf"].animalPositionY = 0.5;
AnimalAvatarDefinition["cowcalf"].animalPositionZ = 0.7;

AnimalAvatarDefinition["lamb"] = {};
AnimalAvatarDefinition["lamb"].zoom = 14;
AnimalAvatarDefinition["lamb"].xoffset = -0.02;
AnimalAvatarDefinition["lamb"].yoffset = -0.1;
AnimalAvatarDefinition["lamb"].avatarWidth = 200;
AnimalAvatarDefinition["lamb"].avatarDir = IsoDirections.SE;
AnimalAvatarDefinition["lamb"].trailerDir = IsoDirections.SW;
AnimalAvatarDefinition["lamb"].trailerZoom = 10;
AnimalAvatarDefinition["lamb"].trailerXoffset = 0;
AnimalAvatarDefinition["lamb"].trailerYoffset = -0.2;

AnimalAvatarDefinition["turkeypoult"] = {};
AnimalAvatarDefinition["turkeypoult"].zoom = 18;
AnimalAvatarDefinition["turkeypoult"].xoffset = -0.02;
AnimalAvatarDefinition["turkeypoult"].yoffset = -0.1;
AnimalAvatarDefinition["turkeypoult"].avatarWidth = 200;
AnimalAvatarDefinition["turkeypoult"].avatarDir = IsoDirections.SE;
AnimalAvatarDefinition["turkeypoult"].trailerDir = IsoDirections.SW;
AnimalAvatarDefinition["turkeypoult"].trailerZoom = 10;
AnimalAvatarDefinition["turkeypoult"].trailerXoffset = 0;
AnimalAvatarDefinition["turkeypoult"].trailerYoffset = -0.2;

AnimalAvatarDefinition["piglet"] = {};
AnimalAvatarDefinition["piglet"].zoom = 20;
AnimalAvatarDefinition["piglet"].xoffset = 0;
AnimalAvatarDefinition["piglet"].yoffset = -0.08;
AnimalAvatarDefinition["piglet"].avatarWidth = 200;
AnimalAvatarDefinition["piglet"].avatarDir = IsoDirections.SE;
AnimalAvatarDefinition["piglet"].trailerDir = IsoDirections.SW;
AnimalAvatarDefinition["piglet"].trailerZoom = 20;
AnimalAvatarDefinition["piglet"].trailerXoffset = 0;
AnimalAvatarDefinition["piglet"].trailerYoffset = -0.1;

AnimalAvatarDefinition["buck"] = {};
AnimalAvatarDefinition["buck"].zoom = 0;
AnimalAvatarDefinition["buck"].xoffset = 0.1;
AnimalAvatarDefinition["buck"].yoffset = 0;
AnimalAvatarDefinition["buck"].avatarWidth = 200;
AnimalAvatarDefinition["buck"].avatarDir = IsoDirections.SE;
AnimalAvatarDefinition["buck"].trailerDir = IsoDirections.SW;
AnimalAvatarDefinition["buck"].trailerZoom = 8.5;
AnimalAvatarDefinition["buck"].trailerXoffset = 0.2;
AnimalAvatarDefinition["buck"].trailerYoffset = -0.3;
-- butchering hook stuff
AnimalAvatarDefinition["buck"].hook = true;
AnimalAvatarDefinition["buck"].butcherHookZoom = -8;
AnimalAvatarDefinition["buck"].butcherHookXoffset = 0;
AnimalAvatarDefinition["buck"].butcherHookYoffset = 0.62;
AnimalAvatarDefinition["buck"].animalPositionSize = 0.6;
AnimalAvatarDefinition["buck"].animalPositionX = 0.1;
AnimalAvatarDefinition["buck"].animalPositionY = 0.5;
AnimalAvatarDefinition["buck"].animalPositionZ = 0.7;

AnimalAvatarDefinition["doe"] = {};
AnimalAvatarDefinition["doe"].zoom = 0;
AnimalAvatarDefinition["doe"].xoffset = 0.1;
AnimalAvatarDefinition["doe"].yoffset = 0;
AnimalAvatarDefinition["doe"].avatarWidth = 200;
AnimalAvatarDefinition["doe"].avatarDir = IsoDirections.SE;
AnimalAvatarDefinition["doe"].trailerDir = IsoDirections.SW;
AnimalAvatarDefinition["doe"].trailerZoom = 8.5;
AnimalAvatarDefinition["doe"].trailerXoffset = 0.2;
AnimalAvatarDefinition["doe"].trailerYoffset = -0.3;
-- butchering hook stuff
AnimalAvatarDefinition["doe"].hook = true;
AnimalAvatarDefinition["doe"].butcherHookZoom = -4;
AnimalAvatarDefinition["doe"].butcherHookXoffset = 0;
AnimalAvatarDefinition["doe"].butcherHookYoffset = 0.55;
AnimalAvatarDefinition["doe"].animalPositionSize = 0.6;
AnimalAvatarDefinition["doe"].animalPositionX = 0.1;
AnimalAvatarDefinition["doe"].animalPositionY = 0.5;
AnimalAvatarDefinition["doe"].animalPositionZ = 0.7;

AnimalAvatarDefinition["fawn"] = {};
AnimalAvatarDefinition["fawn"].zoom = 0;
AnimalAvatarDefinition["fawn"].xoffset = 0.1;
AnimalAvatarDefinition["fawn"].yoffset = 0;
AnimalAvatarDefinition["fawn"].avatarWidth = 200;
AnimalAvatarDefinition["fawn"].avatarDir = IsoDirections.SE;
AnimalAvatarDefinition["fawn"].trailerDir = IsoDirections.SW;
AnimalAvatarDefinition["fawn"].trailerZoom = 8.5;
AnimalAvatarDefinition["fawn"].trailerXoffset = 0.2;
AnimalAvatarDefinition["fawn"].trailerYoffset = -0.3;
-- butchering hook stuff
AnimalAvatarDefinition["fawn"].hook = true;
AnimalAvatarDefinition["fawn"].butcherHookZoom = 2;
AnimalAvatarDefinition["fawn"].butcherHookXoffset = 0;
AnimalAvatarDefinition["fawn"].butcherHookYoffset = 0.45;
AnimalAvatarDefinition["fawn"].animalPositionSize = 0.6;
AnimalAvatarDefinition["fawn"].animalPositionX = 0.1;
AnimalAvatarDefinition["fawn"].animalPositionY = 0.5;
AnimalAvatarDefinition["fawn"].animalPositionZ = 0.7;

AnimalAvatarDefinition["rabdoe"] = {};
AnimalAvatarDefinition["rabdoe"].zoom = 15;
AnimalAvatarDefinition["rabdoe"].xoffset = 0;
AnimalAvatarDefinition["rabdoe"].yoffset = -0.1;
AnimalAvatarDefinition["rabdoe"].avatarWidth = 200;
AnimalAvatarDefinition["rabdoe"].avatarDir = IsoDirections.SE;
AnimalAvatarDefinition["rabdoe"].trailerDir = IsoDirections.SW;
AnimalAvatarDefinition["rabdoe"].trailerZoom = 12;
AnimalAvatarDefinition["rabdoe"].trailerXoffset = 0;
AnimalAvatarDefinition["rabdoe"].trailerYoffset = -0.2;

AnimalAvatarDefinition["rabbuck"] = {};
AnimalAvatarDefinition["rabbuck"].zoom = 14;
AnimalAvatarDefinition["rabbuck"].xoffset = 0;
AnimalAvatarDefinition["rabbuck"].yoffset = -0.16;
AnimalAvatarDefinition["rabbuck"].avatarWidth = 200;
AnimalAvatarDefinition["rabbuck"].avatarDir = IsoDirections.SE;
AnimalAvatarDefinition["rabbuck"].trailerDir = AnimalAvatarDefinition["hen"].trailerDir;
AnimalAvatarDefinition["rabbuck"].trailerZoom = AnimalAvatarDefinition["hen"].trailerZoom;
AnimalAvatarDefinition["rabbuck"].trailerXoffset = AnimalAvatarDefinition["hen"].trailerXoffset;
AnimalAvatarDefinition["rabbuck"].trailerYoffset = AnimalAvatarDefinition["hen"].trailerYoffset;

AnimalAvatarDefinition["rabkitten"] = {};
AnimalAvatarDefinition["rabkitten"].zoom = 20;
AnimalAvatarDefinition["rabkitten"].xoffset = -0.02;
AnimalAvatarDefinition["rabkitten"].yoffset = -0.05;
AnimalAvatarDefinition["rabkitten"].avatarWidth = 200;
AnimalAvatarDefinition["rabkitten"].avatarDir = IsoDirections.SE;
AnimalAvatarDefinition["rabkitten"].trailerDir = AnimalAvatarDefinition["hen"].trailerDir;
AnimalAvatarDefinition["rabkitten"].trailerZoom = AnimalAvatarDefinition["hen"].trailerZoom;
AnimalAvatarDefinition["rabkitten"].trailerXoffset = AnimalAvatarDefinition["hen"].trailerXoffset;
AnimalAvatarDefinition["rabkitten"].trailerYoffset = -0.10;

AnimalAvatarDefinition["rat"] = {};
AnimalAvatarDefinition["rat"].zoom = 21;
AnimalAvatarDefinition["rat"].xoffset = 0.008;
AnimalAvatarDefinition["rat"].yoffset = -0.03;
AnimalAvatarDefinition["rat"].avatarWidth = 200;
AnimalAvatarDefinition["rat"].avatarDir = IsoDirections.SE;
AnimalAvatarDefinition["rat"].trailerDir = AnimalAvatarDefinition["hen"].trailerDir;
AnimalAvatarDefinition["rat"].trailerZoom = AnimalAvatarDefinition["hen"].trailerZoom;
AnimalAvatarDefinition["rat"].trailerXoffset = AnimalAvatarDefinition["hen"].trailerXoffset;
AnimalAvatarDefinition["rat"].trailerYoffset = -0.10;

AnimalAvatarDefinition["ratfemale"] = {};
AnimalAvatarDefinition["ratfemale"].zoom = 21;
AnimalAvatarDefinition["ratfemale"].xoffset = 0.008;
AnimalAvatarDefinition["ratfemale"].yoffset = -0.03;
AnimalAvatarDefinition["ratfemale"].avatarWidth = 200;
AnimalAvatarDefinition["ratfemale"].avatarDir = IsoDirections.SE;
AnimalAvatarDefinition["ratfemale"].trailerDir = AnimalAvatarDefinition["hen"].trailerDir;
AnimalAvatarDefinition["ratfemale"].trailerZoom = AnimalAvatarDefinition["hen"].trailerZoom;
AnimalAvatarDefinition["ratfemale"].trailerXoffset = AnimalAvatarDefinition["hen"].trailerXoffset;
AnimalAvatarDefinition["ratfemale"].trailerYoffset = -0.10;

AnimalAvatarDefinition["ratbaby"] = {};
AnimalAvatarDefinition["ratbaby"].zoom = 21;
AnimalAvatarDefinition["ratbaby"].xoffset = 0.008;
AnimalAvatarDefinition["ratbaby"].yoffset = -0.03;
AnimalAvatarDefinition["ratbaby"].avatarWidth = 200;
AnimalAvatarDefinition["ratbaby"].avatarDir = IsoDirections.SE;
AnimalAvatarDefinition["ratbaby"].trailerDir = AnimalAvatarDefinition["hen"].trailerDir;
AnimalAvatarDefinition["ratbaby"].trailerZoom = AnimalAvatarDefinition["hen"].trailerZoom;
AnimalAvatarDefinition["ratbaby"].trailerXoffset = AnimalAvatarDefinition["hen"].trailerXoffset;
AnimalAvatarDefinition["ratbaby"].trailerYoffset = -0.10;

AnimalAvatarDefinition["mouse"] = {};
AnimalAvatarDefinition["mouse"].zoom = 21;
AnimalAvatarDefinition["mouse"].xoffset = 0.008;
AnimalAvatarDefinition["mouse"].yoffset = -0.03;
AnimalAvatarDefinition["mouse"].avatarWidth = 200;
AnimalAvatarDefinition["mouse"].avatarDir = IsoDirections.SE;
AnimalAvatarDefinition["mouse"].trailerDir = AnimalAvatarDefinition["hen"].trailerDir;
AnimalAvatarDefinition["mouse"].trailerZoom = AnimalAvatarDefinition["hen"].trailerZoom;
AnimalAvatarDefinition["mouse"].trailerXoffset = AnimalAvatarDefinition["hen"].trailerXoffset;
AnimalAvatarDefinition["mouse"].trailerYoffset = -0.10;

AnimalAvatarDefinition["mousefemale"] = {};
AnimalAvatarDefinition["mousefemale"].zoom = 21;
AnimalAvatarDefinition["mousefemale"].xoffset = 0.008;
AnimalAvatarDefinition["mousefemale"].yoffset = -0.03;
AnimalAvatarDefinition["mousefemale"].avatarWidth = 200;
AnimalAvatarDefinition["mousefemale"].avatarDir = IsoDirections.SE;
AnimalAvatarDefinition["mousefemale"].trailerDir = AnimalAvatarDefinition["hen"].trailerDir;
AnimalAvatarDefinition["mousefemale"].trailerZoom = AnimalAvatarDefinition["hen"].trailerZoom;
AnimalAvatarDefinition["mousefemale"].trailerXoffset = AnimalAvatarDefinition["hen"].trailerXoffset;
AnimalAvatarDefinition["mousefemale"].trailerYoffset = -0.10;

AnimalAvatarDefinition["mousepups"] = {};
AnimalAvatarDefinition["mousepups"].zoom = 21;
AnimalAvatarDefinition["mousepups"].xoffset = 0.008;
AnimalAvatarDefinition["mousepups"].yoffset = -0.03;
AnimalAvatarDefinition["mousepups"].avatarWidth = 200;
AnimalAvatarDefinition["mousepups"].avatarDir = IsoDirections.SE;
AnimalAvatarDefinition["mousepups"].trailerDir = AnimalAvatarDefinition["hen"].trailerDir;
AnimalAvatarDefinition["mousepups"].trailerZoom = AnimalAvatarDefinition["hen"].trailerZoom;
AnimalAvatarDefinition["mousepups"].trailerXoffset = AnimalAvatarDefinition["hen"].trailerXoffset;
AnimalAvatarDefinition["mousepups"].trailerYoffset = -0.10;