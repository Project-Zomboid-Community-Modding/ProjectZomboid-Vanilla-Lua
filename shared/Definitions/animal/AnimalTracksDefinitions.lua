--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 22/05/2023
-- Time: 08:39
-- To change this template use File | Settings | File Templates.
--

AnimalTracksDefinitions = AnimalTracksDefinitions or {};

-------- [TRACKS] ---------

-- list of track type, as they're often the same per animal
AnimalTracksDefinitions.trackType = {};
AnimalTracksDefinitions.trackType["footstep"] = {};
AnimalTracksDefinitions.trackType["footstep"].name = "footstep"; -- name for translation
AnimalTracksDefinitions.trackType["footstep"].needDir = true; -- the direction will be added to this track, default is false
AnimalTracksDefinitions.trackType["footstep"].sprites = {NE = "animaltracks_large_01_16", SW = "animaltracks_large_01_17", NW = "animaltracks_large_01_18", SE = "animaltracks_large_01_19", S = "animaltracks_large_01_20", N = "animaltracks_large_01_21", E = "animaltracks_large_01_22", W = "animaltracks_large_01_23"}; -- sprites is used as a list when we have directions, otherwise use simple "sprite"
AnimalTracksDefinitions.trackType["footstep"].actionType = "walk"; -- can be walk, sleep or eat
AnimalTracksDefinitions.trackType["footstep"].chanceToFindTrack = 100; -- this is added to the chance required by animal, this become a chance per tick (Rand(300) == 0 -> find the track)
AnimalTracksDefinitions.trackType["footstep"].minskill = 0; -- min tracking skill required to find this track
AnimalTracksDefinitions.trackType["footstep"].chanceToSpawn = 50; -- weight value, we can have multiple tracks for an action (walk can have poop & footstep for ex.), this weight value will decide which tracks will spawn.

AnimalTracksDefinitions.trackType["poop"] = {};
AnimalTracksDefinitions.trackType["poop"].name = "poop";
AnimalTracksDefinitions.trackType["poop"].actionType = "walk";
AnimalTracksDefinitions.trackType["poop"].chanceToFindTrack = 50;
AnimalTracksDefinitions.trackType["poop"].minskill = 0;
AnimalTracksDefinitions.trackType["poop"].chanceToSpawn = 20;

AnimalTracksDefinitions.trackType["brokentwigs"] = {};
AnimalTracksDefinitions.trackType["brokentwigs"].name = "brokentwigs";
AnimalTracksDefinitions.trackType["brokentwigs"].actionType = "walk";
AnimalTracksDefinitions.trackType["brokentwigs"].chanceToFindTrack = 150;
AnimalTracksDefinitions.trackType["brokentwigs"].minskill = 2;
AnimalTracksDefinitions.trackType["brokentwigs"].chanceToSpawn = 70;

AnimalTracksDefinitions.trackType["herbgraze"] = {};
AnimalTracksDefinitions.trackType["herbgraze"].name = "herbgraze";
AnimalTracksDefinitions.trackType["herbgraze"].sprite = "bends_natural_01_85";
AnimalTracksDefinitions.trackType["herbgraze"].actionType = "eat";
AnimalTracksDefinitions.trackType["herbgraze"].chanceToFindTrack = 100;
AnimalTracksDefinitions.trackType["herbgraze"].minskill = 1;

AnimalTracksDefinitions.trackType["flattenedherb"] = {};
AnimalTracksDefinitions.trackType["flattenedherb"].name = "herbgraze";
AnimalTracksDefinitions.trackType["flattenedherb"].sprite = "bends_natural_01_69";
AnimalTracksDefinitions.trackType["flattenedherb"].actionType = "sleep";
AnimalTracksDefinitions.trackType["flattenedherb"].chanceToFindTrack = 100;
AnimalTracksDefinitions.trackType["flattenedherb"].minskill = 1;
AnimalTracksDefinitions.trackType["flattenedherb"].chanceToSpawn = 50;

AnimalTracksDefinitions.trackType["fur"] = {};
AnimalTracksDefinitions.trackType["fur"].name = "fur";
AnimalTracksDefinitions.trackType["fur"].actionType = "sleep";
AnimalTracksDefinitions.trackType["fur"].chanceToFindTrack = 180;
AnimalTracksDefinitions.trackType["fur"].minskill = 2;
AnimalTracksDefinitions.trackType["fur"].chanceToSpawn = 50;


-------- [ANIMALS] ---------
AnimalTracksDefinitions.animallist = {};

AnimalTracksDefinitions.animallist["deer"] = {}; -- "deer" should correspond to the migration group (see MigrationGroupDefinitions.lua)
AnimalTracksDefinitions.animallist["deer"].tracks = {}; -- define all tracks this animal can leave
AnimalTracksDefinitions.animallist["deer"].tracks["footstep"] = copyTable(AnimalTracksDefinitions.trackType["footstep"]);
--AnimalTracksDefinitions.animallist["deer"].tracks["footstep"].sprites = {NE = "animaltracks_large_01_16", SW = "animaltracks_large_01_17", NW = "animaltracks_large_01_18", SE = "animaltracks_large_01_19", S = "animaltracks_large_01_20", N = "animaltracks_large_01_21", E = "animaltracks_large_01_22", W = "animaltracks_large_01_23"};
AnimalTracksDefinitions.animallist["deer"].tracks["poop"] = copyTable(AnimalTracksDefinitions.trackType["poop"]);
AnimalTracksDefinitions.animallist["deer"].tracks["poop"].item = "Base.Dung_Deer";
AnimalTracksDefinitions.animallist["deer"].tracks["brokentwigs"] = copyTable(AnimalTracksDefinitions.trackType["brokentwigs"]);
AnimalTracksDefinitions.animallist["deer"].tracks["brokentwigs"].item = "Base.Twigs";
AnimalTracksDefinitions.animallist["deer"].tracks["herbgraze"] = copyTable(AnimalTracksDefinitions.trackType["herbgraze"]);
AnimalTracksDefinitions.animallist["deer"].tracks["flattenedherb"] = copyTable(AnimalTracksDefinitions.trackType["flattenedherb"]);
AnimalTracksDefinitions.animallist["deer"].tracks["fur"] = copyTable(AnimalTracksDefinitions.trackType["fur"]);
AnimalTracksDefinitions.animallist["deer"].tracks["fur"].item = "Base.FurTuft_Brownlight";
AnimalTracksDefinitions.animallist["deer"].skillToIdentify = 4; -- min tracking skill required to know exactly what the animal left that track, if under this skill, check "trackType"
AnimalTracksDefinitions.animallist["deer"].trackType = "large"; -- if you don't have min tracking skill to properly identify this track, it'll say "large animal footstep" or "large animal poop" etc. can be large, medium or small.
AnimalTracksDefinitions.animallist["deer"].trackChance = {}; -- during each action we have a chance to drop a track
AnimalTracksDefinitions.animallist["deer"].trackChance["walk"] = 800; -- per tick
AnimalTracksDefinitions.animallist["deer"].trackChance["eat"] = 200;
AnimalTracksDefinitions.animallist["deer"].trackChance["sleep"] = 100;
AnimalTracksDefinitions.animallist["deer"].chanceToFindTrack = 100; -- this is added to the trackType.chance, it's done each tick, the higher number the harder is it to find a track, this is lowered by tracking skill.

AnimalTracksDefinitions.animallist["rabbit"] = {};
AnimalTracksDefinitions.animallist["rabbit"].tracks = {};
AnimalTracksDefinitions.animallist["rabbit"].tracks["footstep"] = copyTable(AnimalTracksDefinitions.trackType["footstep"]);
--AnimalTracksDefinitions.animallist["rabbit"].tracks["footstep"].sprites = {NE = "animaltracks_large_01_32", SW = "animaltracks_large_01_33", NW = "animaltracks_large_01_34", SE = "animaltracks_large_01_35", S = "animaltracks_large_01_36", N = "animaltracks_large_01_37", E = "animaltracks_large_01_38", W = "animaltracks_large_01_39"};
AnimalTracksDefinitions.animallist["rabbit"].tracks["poop"] = copyTable(AnimalTracksDefinitions.trackType["poop"]);
AnimalTracksDefinitions.animallist["rabbit"].tracks["poop"].item = "Base.Dung_Rabbit";
AnimalTracksDefinitions.animallist["rabbit"].tracks["brokentwigs"] = copyTable(AnimalTracksDefinitions.trackType["brokentwigs"]);
AnimalTracksDefinitions.animallist["rabbit"].tracks["brokentwigs"].item = "Base.Twigs";
AnimalTracksDefinitions.animallist["rabbit"].tracks["herbgraze"] = copyTable(AnimalTracksDefinitions.trackType["herbgraze"]);
AnimalTracksDefinitions.animallist["rabbit"].tracks["flattenedherb"] = copyTable(AnimalTracksDefinitions.trackType["flattenedherb"]);
AnimalTracksDefinitions.animallist["rabbit"].tracks["fur"] = copyTable(AnimalTracksDefinitions.trackType["fur"]);
AnimalTracksDefinitions.animallist["rabbit"].tracks["fur"].item = "Base.FurTuft_Grey";
AnimalTracksDefinitions.animallist["rabbit"].skillToIdentify = 1;
AnimalTracksDefinitions.animallist["rabbit"].trackType = "small";
AnimalTracksDefinitions.animallist["rabbit"].trackChance = {};
AnimalTracksDefinitions.animallist["rabbit"].trackChance["walk"] = 800;
AnimalTracksDefinitions.animallist["rabbit"].trackChance["eat"] = 200;
AnimalTracksDefinitions.animallist["rabbit"].trackChance["sleep"] = 100;
AnimalTracksDefinitions.animallist["rabbit"].chanceToFindTrack = 100;