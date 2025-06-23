 Distributions = Distributions or {};

local distributionTable = {
	
	-- =====================
	--	Room List (A-Z)
	-- =====================
	
	aesthetic = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="SalonCounter", min=0, max=99, forceForTiles="fixtures_counters_01_32;fixtures_counters_01_33;fixtures_counters_01_34;fixtures_counters_01_35;fixtures_counters_01_36;fixtures_counters_01_37;fixtures_counters_01_38;fixtures_counters_01_39"},
				{name="SalonShelfHaircare", min=0, max=99, weightChance=100},
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="SalonShelfTowels", min=0, max=99, weightChance=20},
				{name="CrateSalonSupplies", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="SalonShelfTowels", min=0, max=99, weightChance=20},
				{name="CrateSalonSupplies", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateSalonSupplies", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="SalonShelfTowels", min=0, max=99, weightChance=20},
				{name="CrateSalonSupplies", min=0, max=99, weightChance=100},
			}
		},
	},
	
	aestheticstorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="SalonShelfTowels", min=0, max=99, weightChance=20},
				{name="CrateSalonSupplies", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="SalonShelfTowels", min=0, max=99, weightChance=20},
				{name="CrateSalonSupplies", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="SalonShelfHaircare", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="SalonShelfTowels", min=0, max=99, weightChance=20},
				{name="CrateSalonSupplies", min=0, max=99, weightChance=100},
			}
		},
	},
	
	all = {
		barbecue = {
			procedural = true,
			procList = {
				{name="BBQCharcoalRich", min=0, max=99, forceForZones="Rich"},
				{name="BBQCharcoal", min=0, max=99, weightChance=100},
			}
		},
		barbecuepropane = {
			procedural = true,
			procList = {
				{name="BBQPropaneRich", min=0, max=99, forceForZones="Rich"},
				{name="BBQPropane", min=0, max=99, weightChance=100},
			}
		},
		bin = {
			rolls = 4,
			ignoreZombieDensity = true,
			isTrash = true,
			items = {
				"Bag_TrashBag", 20,
				"BandageDirty", 2,
				"BeerCanEmpty", 8,
				"BeerEmpty", 2,
				"Brochure", 1,
				"BrokenGlass", 0.4,
				"Cockroach", 8,
				"CopperScrap", 1,
				"DeadMouse", 2,
				"DeadRat", 2,
				"ElectronicsScrap", 2,
				"EmptyJar", 0.5,
				"Flier", 1,
				"FountainCup", 4,
				"JarLid", 0.5,
				"Maggots", 4,
				"PaintbucketEmpty", 1,
				"PaperNapkins2", 4,
				"PlasticCup", 4,
				"Pop2Empty", 8,
				"Pop3Empty", 8,
				"PopBottleEmpty", 1,
				"PopEmpty", 8,
				"Receipt", 10,
				"RippedSheetsDirty", 4,
				"ScrapMetal", 2,
				"SmashedBottle", 1,
				"Straw2", 8,
				"TinCanEmpty", 10,
				"TinCanEmpty", 10,
				"UnusableMetal", 2,
				"UnusableWood", 2,
				"WaterBottleEmpty", 1,
				"WhiskeyEmpty", 0.5,
				"WineOpenEmpty", 0.5,
				"Wine2OpenEmpty", 0.5,
			},
			junk = ClutterTables.BinJunk,
		},
		campfire = {
			rolls = 4,
			items = {
				"BrokenGlass", 1,
				"Log", 4,
				"SmashedBottle", 4,
				"TinCanEmpty", 10,
				"TreeBranch2", 6,
				"Twigs", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateRandomJunk", min=0, max=99, weightChance=10},
				{name="CrateNewspapers", min=0, max=99, weightChance=40},
				{name="CrateEmptyBottles1", min=0, max=99, weightChance=40},
				{name="CrateEmptyBottles2", min=0, max=99, weightChance=40},
				{name="CrateEmptyTinCans", min=0, max=99, weightChance=40},
				{name="CrateEmptyMixed", min=0, max=99, weightChance=100},
			}
		},
		cashregister = {
			rolls = 4,
			items = {
				-- Keys/Keyrings
				"CarKey", 2,
				"KeyRing", 0.1,
				"Key1", 1,
				"Key1", 1,
				"Key1", 1,
				-- Stationery
				"Calculator", 1,
				"Notepad", 2,
				"Pencil", 4,
				-- Cash
				"Money", 100,
				"Money", 50,
				"Money", 20,
				"Money", 10,
				"Money", 10,
				-- Misc.
				"Note", 10,
				"Receipt", 20,
			},
			junk = {
				rolls = 1,
				items = {
					"BluePen", 1,
					"Eraser", 1,
					"MarkerBlack", 0.1,
					"MarkerBlue", 0.1,
					"MarkerGreen", 0.1,
					"MarkerRed", 0.1,
					"Pen", 1,
					"RedPen", 1,
				}
			}
		},
		clothingdryer = {
			rolls = 1,
			items = {
				"DryerLint", 50,
				"DryerLint", 20,
				"DryerLint", 10,
				"Money", 10,
				"Socks_Ankle", 10,
				"Socks_Ankle_White", 10,
				"Socks_Heavy", 4,
				"Socks_Long", 10,
				"Socks_Long_White", 10,
			},
			junk = {
				rolls = 1,
				items = {
					"Bracelet_LeftFriendshipTINT", 0.001,
				}
			}
		},
		--Wheeled laundry bin, unpowered.
		clothingdryerbasic = {
			rolls = 1,
			items = {
				
			},
			junk = {
				rolls = 1,
				items = {
					"Bracelet_LeftFriendshipTINT", 0.001,
				}
			}
		},
		clothingrack = {
			procedural = true,
			procList = {
				{name="ClothingStoresDress", min=0, max=99, weightChance=100},
				{name="ClothingStoresShirts", min=0, max=99, weightChance=100},
				{name="ClothingStoresShirtsFormal", min=0, max=99, weightChance=100},
				{name="ClothingStoresJumpers", min=0, max=99, weightChance=100},
				{name="ClothingStoresJackets", min=0, max=99, weightChance=100},
				{name="ClothingStoresJacketsFormal", min=0, max=99, weightChance=100},
				{name="ClothingStoresJumpers", min=0, max=99, weightChance=100},
				{name="ClothingStoresPantsFormal", min=0, max=99, weightChance=100},
			}
		},
		clothingwasher = {
			rolls = 1,
			items = {
				
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		-- Empty Coffin
		coffin = {
			rolls = 1,
			items = {
				
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		counter = {
			rolls = 4,
			items = {
				"Battery", 8,
				"BluePen", 8,
				"Book", 10,
				"Brochure", 1,
				"Eraser", 6,
				"Flier", 1,
				"Glue", 2,
				"HandTorch", 4,
				"Magazine", 5,
				"Magazine_Popular", 5,
				"Notebook", 10,
				"Paperback", 2,
				"Paperclip", 10,
				"PaperclipBox", 0.1,
				"Pen", 8,
				"Pencil", 20,
				"Phonebook", 10,
				"RadioBlack", 2,
				"RadioRed", 1,
				"RedPen", 8,
				"RubberBand", 6,
				"Scissors", 2,
				"Scotchtape", 2,
				"SheetPaper2", 10,
				"Torch", 2,
				"TVMagazine", 4,
				"WalkieTalkie2", 1,
				"WalkieTalkie3", 0.5,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateTools", min=0, max=99, weightChance=1},
				{name="CrateSheetMetal", min=0, max=99, weightChance=20},
				{name="CrateLumber", min=0, max=99, weightChance=100},
			}
		},
		desk = {
			procedural = true,
			procList = {
				{name="DeskGeneric", min=0, max=99},
			}
		},
		dishescabinet = {
			procedural = true,
			procList = {
				{name="DishCabinetGeneric", min=0, max=99, weightChance=100},
				{name="DishCabinetLiquor", min=0, max=99, weightChance=40},
				{name="FoodGourmet", min=0, max=1, weightChance=10},
			}
		},
		displaycasebakery = {
			procedural = true,
			procList = {
				{name="BakeryBread", min=1, max=99, weightChance=100},
				{name="BakeryPie", min=1, max=99, weightChance=40},
				{name="BakeryCake", min=1, max=99, weightChance=100},
				{name="BakeryMisc", min=1, max=99, weightChance=40},
			}
		},
		doghouse = {
			rolls = 1,
			items = {
				"DogChew", 20,
				"DogTag_Pet", 10,
				"Leash", 10,
				"Pillow", 20,
				"Rubberducky", 10,
				"WaterDish", 50,
			},
			junk = {
				rolls = 1,
				items = {
				}
			}
		},
		dresser = {
			procedural = true,
			procList = {
				{name="DresserGeneric", min=0, max=99},
			}
		},
		dumpster = {
			rolls = 4,
			ignoreZombieDensity = true,
			isTrash = true,
			items = {
				"Bag_TrashBag", 20,
				"Bag_TrashBag", 20,
				"Bag_TrashBag", 10,
				"Bag_TrashBag", 10,
				"Mov_PalletEmpty", 4,
			},
			junk = ClutterTables.BinJunk,
		},
		filingcabinet = {
			procedural = true,
			procList = {
				{name="FilingCabinetGeneric", min=0, max=99, weightChance=100},
			}
		},
		fireplace = {
			rolls = 1,
			items = {
				"Bellows", 20,
				"FireplacePoker", 20,
				"Tongs", 20,
			},
			junk = {
				rolls = 4,
				items = {
					"Firewood", 8,
					"Newspaper", 4,
					"TreeBranch2", 6,
					"Twigs", 10,
				}
			}
		},
		freezer = {
			rolls = 4,
			items = {
				"Creamocle", 8,
				"FudgeePop", 8,
				"Icecream", 20,
				"Icecream", 20,
				"Icecream", 10,
				"Icecream", 10,
				"IcecreamSandwich", 8,
				"Popsicle", 8,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeGeneric", min=0, max=99, weightChance=100},
				{name="FridgeRich", min=0, max=99, forceForZones="Rich"},
				{name="FridgeTrailerPark", min=0, max=99, forceForZones="TrailerPark"},
			}
		},
		grocerstand = {
			rolls = 4,
			items = {
				"Apple", 8,
				"Apple", 8,
				"Banana", 8,
				"Banana", 8,
				"Cherry", 8,
				"Grapes", 8,
				"Orange", 8,
				"Orange", 8,
				"Peach", 8,
				"Pear", 8,
				"Strewberrie", 8,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		inventoryfemale = {
			rolls = 1,
			items = {
				"Base.LouisvilleMap1", 0.01,
				"Base.LouisvilleMap2", 0.01,
				"Base.LouisvilleMap3", 0.01,
				"Base.LouisvilleMap4", 0.01,
				"Base.LouisvilleMap5", 0.01,
				"Base.LouisvilleMap6", 0.01,
				"Base.LouisvilleMap7", 0.01,
				"Base.LouisvilleMap8", 0.01,
				"Base.LouisvilleMap9", 0.01,
				"Base.MarchRidgeMap", 0.01,
				"Base.MuldraughMap", 0.01,
				"Base.RiversideMap", 0.01,
				"Base.RosewoodMap", 0.01,
				"Base.WestpointMap", 0.01,
				"BluePen", 1,
				"Camera", 0.03,
				"CameraDisposable", 0.05,
				"CameraExpensive", 0.001,
				"CigarettePack", 0.1,
				"Comb", 1,
				"CreditCard", 1,
				"Doll", 0.5,
				"Diary1", 1,
				"Earbuds", 1,
				"IDcard_Female", 20,
				"LetterHandwritten", 1,
				"LighterDisposable", 0.5,
				"Lipstick", 1,
				"Locket", 1,
				"Magazine", 1,
				"MakeupEyeshadow", 1,
				"MakeupFoundation", 1,
				"Matches", 0.5,
				"Newspaper_Recent", 1,
				"Note", 1,
				"Notebook", 1,
				"Pen", 1,
				"Pencil", 1,
				"Perfume", 0.5,
				"Photo", 1,
				"Pills", 0.1,
				"PillsAntiDep", 0.1,
				"PillsBeta", 0.1,
				"PillsVitamins", 0.1,
				"Receipt", 1,
				"RedPen", 1,
				"ScratchTicket", 0.1,
				"ScratchTicket_Winner", 0.1,
				"WalkieTalkie1", 0.05,
				"WalkieTalkie2", 0.03,
				"WalkieTalkie3", 0.001,
				"Wallet_Female", 50,
			},
			junk = {
				rolls= 1,
				items = {
					
				}
			}
		},
		inventorymale = {
			rolls = 1,
			items = {
				"Base.LouisvilleMap1", 0.01,
				"Base.LouisvilleMap2", 0.01,
				"Base.LouisvilleMap3", 0.01,
				"Base.LouisvilleMap4", 0.01,
				"Base.LouisvilleMap5", 0.01,
				"Base.LouisvilleMap6", 0.01,
				"Base.LouisvilleMap7", 0.01,
				"Base.LouisvilleMap8", 0.01,
				"Base.LouisvilleMap9", 0.01,
				"Base.MarchRidgeMap", 0.01,
				"Base.MuldraughMap", 0.01,
				"Base.RiversideMap", 0.01,
				"Base.RosewoodMap", 0.01,
				"Base.WestpointMap", 0.01,
				"BluePen", 1,
				"Camera", 0.03,
				"CameraDisposable", 0.05,
				"CameraExpensive", 0.001,
				"Cigar", 0.01,
				"CigarettePack", 0.1,
				"Cigarillo", 0.1,
				"Cologne", 0.5,
				"Comb", 1,
				"CreditCard", 1,
				"Diary2", 1,
				"Earbuds", 1,
				"IDcard_Male", 20,
				"LetterHandwritten", 1,
				"LighterDisposable", 0.5,
				"Locket", 1,
				"Magazine", 1,
				"Matches", 0.5,
				"Newspaper_Recent", 1,
				"Note", 1,
				"Notebook", 1,
				"Pen", 1,
				"Pencil", 1,
				"Photo", 1,
				"Pills", 0.1,
				"PillsAntiDep", 0.1,
				"PillsBeta", 0.1,
				"PillsVitamins", 0.1,
				"Receipt", 1,
				"RedPen", 1,
				"ScratchTicket", 0.1,
				"ScratchTicket_Winner", 0.1,
				"WalkieTalkie1", 0.05,
				"WalkieTalkie2", 0.03,
				"WalkieTalkie3", 0.001,
				"Wallet_Male", 50,
			},
			junk = {
				rolls= 1,
				items = {
					
				}
			}
		},
		locker = {
			rolls = 1,
			items = {
				
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		logs = {
			rolls = 4,
			items = {
				-- Branches
				"Branch_Broken", 10,
				"LargeBranch", 8,
				"TreeBranch2", 10,
				-- Firewood
				"Firewood", 10,
				-- Detritus
				"Sapling", 4,
				"Splinters", 20,
				"Pillbug", 8,
				-- Logs
				"Log", 50,
				"Log", 20,
				"Log", 20,
				"Log", 10,

			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		medicine = {
			rolls = 4,
			items = {
				"Antibiotics", 0.25,
				"Bandage", 6,
				"Bandaid", 10,
				"Bandaid", 10,
				"BookFirstAid1", 1,
				"Pills", 4,
				"PillsAntiDep", 1,
				"PillsBeta", 1,
				"PillsSleepingTablets", 1,
				"PillsVitamins", 0.1,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		metal_shelves = {
			rolls = 4,
			items = {
				"BallPeenHammer", 0.6,
				"Battery", 4,
				"Bucket", 0.4,
				"ClubHammer", 0.4,
				"Crowbar", 0.4,
				"DuctTape", 0.8,
				"ElectricWire", 0.5,
				"Funnel", 1,
				"Glasses_SafetyGoggles", 0.2,
				"Hammer", 0.6,
				"HandAxe", 0.1,
				"HandDrill", 1,
				"Handle", 4,
				"HandTorch", 0.4,
				"Hat_DustMask", 0.2,
				"Hat_HardHat", 0.1,
				"LeadPipe", 0.4,
				"LeadPipe", 0.4,
				"LongHandle", 2,
				"LongStick", 2,
				"MeasuringTape", 1,
				"MetalBar", 1,
				"MetalPipe", 2,
				"Nails", 4,
				"NailsBox", 1,
				"NutsBolts", 1,
				"PipeWrench", 0.4,
				"Pliers", 1,
				"RadioBlack", 2,
				"RadioRed", 1,
				"Ratchet", 1,
				"Rope", 0.8,
				"RubberHose", 1,
				"Saw", 0.4,
				"Screwdriver", 1,
				"ScrewsBox", 0.4,
				"SheetMetal", 2,
				"Shovel", 0.4,
				"Shovel2", 0.4,
				"SmallHandle", 4,
				"SmallSheetMetal", 1,
				"Tarp", 1,
				"Toolbox", 0.5,
				"ToolRoll_Leather", 0.1,
				"Torch", 0.2,
				"Twine", 1,
				"ViseGrips", 4,
				"WalkieTalkie1", 0.05,
				"WalkieTalkie2", 0.03,
				"WalkieTalkie3", 0.01,
				"WeldingMask", 0.2,
				"WeldingRods", 1,
				"Wire", 0.8,
				"WoodenMallet", 0.4,
				"WoodenStick2", 2,
				"Woodglue", 0.4,
				"Wrench", 0.6,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		microwave = {
			rolls = 1,
			cookFood = true,
			onlyOne = true,
			items = {
				"Bacon", 4,
				"Oatmeal", 4,
				"TVDinner", 4,
			},
			junk = {
				rolls = 1,
				cookFood = true,
				items = {
					
				}
			}
		},
		militarycrate = {
			procedural = true,
			procList = {
				{name="CrateHumanitarian", min=0, max=99},
			}
		},
		militarylocker = {
			procedural = true,
			procList = {
				{name="ArmyStorageGuns", min=0, max=99, weightChance=100},
				{name="ArmyStorageOutfit", min=0, max=99, weightChance=100},
				{name="ArmyStorageAmmunition", min=0, max=99, weightChance=100},
			}
		},
		newspaper_dispatch = {
			rolls = 4,
			items = {
				"Newspaper_Dispatch_New", 100,
				"Newspaper_Dispatch_New", 50,
				"Newspaper_Dispatch_New", 20,
				"Newspaper_Dispatch_New", 20,
				"Newspaper_Dispatch_New", 10,
				"Newspaper_Dispatch_New", 10,
			},
			junk = {
				rolls = 1,
				items = {
				}
			}
		},
		newspaper_herald = {
			rolls = 4,
			items = {
				"Newspaper_Herald_New", 100,
				"Newspaper_Herald_New", 50,
				"Newspaper_Herald_New", 20,
				"Newspaper_Herald_New", 20,
				"Newspaper_Herald_New", 10,
				"Newspaper_Herald_New", 10,
			},
			junk = {
				rolls = 1,
				items = {
				}
			}
		},
		newspaper_knews = {
			rolls = 4,
			items = {
				"Newspaper_Knews_New", 100,
				"Newspaper_Knews_New", 50,
				"Newspaper_Knews_New", 20,
				"Newspaper_Knews_New", 20,
				"Newspaper_Knews_New", 10,
				"Newspaper_Knews_New", 10,
			},
			junk = {
				rolls = 1,
				items = {
				}
			}
		},
		newspaper_times = {
			rolls = 4,
			items = {
				"Newspaper_Times_New", 100,
				"Newspaper_Times_New", 50,
				"Newspaper_Times_New", 20,
				"Newspaper_Times_New", 20,
				"Newspaper_Times_New", 10,
				"Newspaper_Times_New", 10,
			},
			junk = {
				rolls = 1,
				items = {
				}
			}
		},
		officedrawers = {
			procedural = true,
			procList = {
				{name="OfficeDrawers", min=0, max=99},
			}
		},
		other = {
			procedural = true,
			procList = {
				{name="OtherGeneric", min=0, max=99},
			}
		},
		plankstash = {
			procedural = true,
			procList = {
				{name="PlankStashMisc", min=0, max=99, weightChance=60},
				{name="PlankStashMoney", min=0, max=99, weightChance=20},
				{name="PlankStashGold", min=0, max=99, weightChance=1},
				{name="PlankStashGun", min=0, max=99, weightChance=100},
			}
		},
		postbox = {
			ignoreZombieDensity = true,
			rolls = 2,
			items = {
				-- Temporary: Testing Fliers
				"Flier", 50,
				"Flier", 20,
				-- Literature (Generic)
				"Brochure", 8,
				"Card_Birthday", 1,
				"Card_Sympathy", 1,
				"ComicBook_Retail", 0.2,
				"Flier", 8,
				"GenericMail", 8,
				"LetterHandwritten", 2,
				"Magazine_New", 4,
				"Newspaper_Recent", 10,
				"ParkingTicket", 2,
				"SpeedingTicket", 2,
				-- Parcels
				"Parcel_ExtraSmall", 1,
				"Parcel_Medium", 0.5,
				-- Literature (Skills)
				"CookingMag1", 0.1,
				"CookingMag2", 0.1,
				"CookingMag3", 0.1,
				"CookingMag4", 0.1,
				"CookingMag5", 0.1,
				"CookingMag6", 0.1,
				"ElectronicsMag1", 0.1,
				"ElectronicsMag2", 0.1,
				"ElectronicsMag3", 0.1,
				"ElectronicsMag4", 0.1,
				"ElectronicsMag5", 0.1,
				"EngineerMagazine1", 0.1,
				"EngineerMagazine2", 0.1,
				"FarmingMag1", 0.1,
				"FarmingMag2", 0.1,
				"FarmingMag3", 0.1,
				"FarmingMag4", 0.1,
				"FarmingMag5", 0.1,
				"FarmingMag6", 0.1,
				"FarmingMag7", 0.1,
				"FarmingMag8", 0.1,
				"FishingMag1", 0.1,
				"FishingMag2", 0.1,
				"GlassmakingMag1", 0.1,
				"GlassmakingMag2", 0.1,
				"GlassmakingMag3", 0.1,
				"HerbalistMag", 0.1,
				"HuntingMag1", 0.1,
				"HuntingMag2", 0.1,
				"HuntingMag3", 0.1,
				"KnittingMag1", 0.1,
				"KnittingMag2", 0.1,
				"MechanicMag1", 0.1,
				"MechanicMag2", 0.1,
				"MechanicMag3", 0.1,
				"MetalworkMag1", 0.1,
				"MetalworkMag2", 0.1,
				"MetalworkMag3", 0.1,
				"MetalworkMag4", 0.1,
				"SmithingMag1", 0.01,
				"SmithingMag2", 0.01,
				"SmithingMag3", 0.01,
				"SmithingMag4", 0.01,
				"SmithingMag5", 0.01,
				"SmithingMag6", 0.01,
				"SmithingMag7", 0.01,
				"SmithingMag8", 0.01,
				"SmithingMag9", 0.01,
				"SmithingMag10", 0.01,
				"SmithingMag11", 0.01,
			},
			junk = {
				rolls = 1,
				items = {
					-- Temporary: For testing purposes.
					"Flier", 20,
				}
			}
		},
		restaurantdisplay = {
			rolls = 1,
			items = {

			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		shelter = {
			isWorn = true,
			rolls = 1,
			items = {
				"Aluminum", 8,
				"Bag_DuffelBagTINT", 0.5,
				"Bag_FannyPackFront", 2,
				"Bag_Schoolbag", 1,
				"BandageDirty", 8,
				"BaseballBat_Nails", 0.1,
				"BeerCanEmpty", 10,
				"BeerEmpty", 10,
				"Belt2", 4,
				"BoltCutters", 0.1,
				"Bucket", 4,
				"CanteenCowboy", 2,
				"CanteenMilitary", 1,
				"Cooler", 0.5,
				"CopperScrap", 10,
				"Crowbar", 0.1,
				"Garbagebag", 10,
				"Hammer", 0.5,
				"HandAxe", 0.1,
				"HandTorch", 1,
				"Handle", 1,
				"HuntingKnife", 0.5,
				"LargeKnife", 0.5,
				"LighterDisposable", 8,
				"LongHandle", 0.5,
				"LongStick", 0.5,
				"LongHandle_Nails", 0.5,
				"KnifeButterfly", 2,
				"KnifeFillet", 1,
				"KnifeParing", 1,
				"KnifePocket", 0.1,
				"KnifeShiv", 4,
				"Lantern_Hurricane", 0.1,
				"Lantern_Propane", 0.5,
				"Machete", 0.01,
				"MagnesiumFirestarter", 1,
				"Matchbox", 1,
				"Matches", 4,
				"MetalBar", 0.5,
				"Newspaper", 10,
				"P38", 1,
				"PaintbucketEmpty", 8,
				"PanForged", 0.5,
				"Pliers", 1,
				"Pop2Empty", 10,
				"Pop3Empty", 10,
				"PopBottleEmpty", 10,
				"PotForged", 0.1,
				"RailroadSpike", 1,
				"RailroadSpikeKnife", 0.1,
				"RippedSheetsDirty", 20,
				"RubberBand", 10,
				"RubberHose", 8,
				"Saw", 1,
				"ScrapMetal", 10,
				"Screwdriver", 2,
				"SleepingBag_Cheap_Blue", 1,
				"SleepingBag_Cheap_Green", 1,
				"SleepingBag_Cheap_Green2", 1,
				"SmallHandle", 2,
				"SmallKnife", 0.5,
				"Spoon", 10,
				"SteelWool", 10,
				"SwitchKnife", 1,
				"Tarp", 10,
				"TinOpener", 0.5,
				"Torch", 0.5,
				"TwigsBundle", 10,
				"WaterBottleEmpty", 10,
				"WhiskeyEmpty", 10,
				"WoodenStick2", 2,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="ShelfGeneric", min=0, max=99},
			}
		},
		shelvesmag = {
			procedural = true,
			procList = {
				{name="MagazineRackMixed", min=0, max=99},
			}
		},
		sidetable = {
			rolls = 4,
			items = {
				"BluePen", 8,
				"Brochure", 2,
				"Calculator", 0.1,
				"Camera", 0.03,
				"CameraDisposable", 0.05,
				"CameraExpensive", 0.001,
				"Clipboard", 2,
				"ComicBook", 4,
				"CookingMag1", 0.1,
				"CookingMag2", 0.1,
				"CookingMag3", 0.1,
				"CookingMag4", 0.1,
				"CookingMag5", 0.1,
				"CookingMag6", 0.1,
				"CordlessPhone", 1,
				"Disc_Retail", 2,
				"Doodle", 1,
				"Earbuds", 1,
				"ElectronicsMag1", 0.1,
				"ElectronicsMag2", 0.1,
				"ElectronicsMag3", 0.1,
				"ElectronicsMag4", 0.1,
				"ElectronicsMag5", 0.1,
				"EngineerMagazine1", 0.1,
				"EngineerMagazine2", 0.1,
				"Eraser", 8,
				"FishingMag1", 0.1,
				"FishingMag2", 0.1,
				"Flier", 2,
				"GlassmakingMag1", 0.1,
				"GlassmakingMag2", 0.1,
				"GlassmakingMag3", 0.1,
				"Glue", 2,
				"GreenPen", 4,
				"Headphones", 1,
				"HerbalistMag", 0.1,
				"HuntingMag1", 0.1,
				"HuntingMag2", 0.1,
				"HuntingMag3", 0.1,
				"KnifePocket", 0.1,
				"KnittingMag1", 0.1,
				"KnittingMag2", 0.1,
				"Magazine", 5,
				"Magazine_Popular", 5,
				"MagazineCrossword", 2,
				"MagazineWordsearch", 2,
				"MarkerBlack", 2,
				"MarkerBlue", 2,
				"MarkerGreen", 1,
				"MarkerRed", 2,
				"MechanicMag1", 0.1,
				"MechanicMag2", 0.1,
				"MechanicMag3", 0.1,
				"MetalworkMag1", 0.1,
				"MetalworkMag2", 0.1,
				"MetalworkMag3", 0.1,
				"MetalworkMag4", 0.1,
				"Newspaper", 8,
				"Newspaper_Recent", 2,
				"Notebook", 10,
				"Notepad", 8,
				"Pen", 8,
				"Pencil", 10,
				"PenFancy", 0.5,
				"PowerBar", 4,
				"RedPen", 8,
				"Remote", 20,
				"RubberBand", 6,
				"Scissors", 2,
				"ScissorsBlunt", 2,
				"Scotchtape", 4,
				"SheetPaper2", 10,
				"SmithingMag1", 0.01,
				"SmithingMag2", 0.01,
				"SmithingMag3", 0.01,
				"SmithingMag4", 0.01,
				"SmithingMag5", 0.01,
				"SmithingMag6", 0.01,
				"SmithingMag7", 0.01,
				"SmithingMag8", 0.01,
				"SmithingMag9", 0.01,
				"SmithingMag10", 0.01,
				"SmithingMag11", 0.01,
				"TissueBox", 4,
				"Twine", 1,
				"TVMagazine", 4,
				"WalkieTalkie1", 0.05,
				"WalkieTalkie2", 0.03,
				"WalkieTalkie3", 0.01,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateRandomJunk", min=0, max=99, weightChance=10},
				{name="CrateNewspapers", min=0, max=99, weightChance=40},
				{name="CrateEmptyBottles1", min=0, max=99, weightChance=40},
				{name="CrateEmptyBottles2", min=0, max=99, weightChance=40},
				{name="CrateEmptyTinCans", min=0, max=99, weightChance=40},
				{name="CrateEmptyMixed", min=0, max=99, weightChance=100},
			}
		},
		stove = {
			rolls = 1,
			items = {
				
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		tent = {
			rolls = 1,
			items = {
				"Bag_ALICEpack", 0.01,
				"Bag_BigHikingBag", 0.5,
				"Bag_FannyPackFront", 2,
				"Bag_LeatherWaterBag", 0.5,
				"Bag_NormalHikingBag", 1,
				"Book", 4,
				"Book_Nature", 4,
				"CanteenCowboy", 2,
				"CanteenMilitary", 1,
				"CompassDirectional", 8,
				"Cooler", 1,
				"DryFirestarterBlock", 2,
				"FirstAidKit_Camping", 0.5,
				"Handiknife", 0.5,
				"IceAxe", 0.1,
				"InsectRepellent", 4,
				"KnifePocket", 0.5,
				"Lantern_Hurricane", 0.1,
				"Lantern_Propane", 0.5,
				"Magazine_Outdoors", 8,
				"MagnesiumFirestarter", 2,
				"Matchbox", 4,
				"Multitool", 0.01,
				"P38", 1,
				"Paperback", 8,
				"Paperback_Nature", 8,
				"PonchoGreenDOWN", 1,
				"Propane_Refill", 0.5,
				"Shoes_Wellies", 0.1,
				"SleepingBag_BluePlaid", 1,
				"SleepingBag_Camo", 0.5,
				"SleepingBag_Cheap_Blue", 2,
				"SleepingBag_Cheap_Green", 2,
				"SleepingBag_Cheap_Green2", 2,
				"SleepingBag_Green", 1,
				"SleepingBag_GreenPlaid", 1,
				"SleepingBag_HighQuality_Brown", 0.5,
				"SleepingBag_Spiffo", 0.1,
				"SleepingBag_RedPlaid", 1,
				"Spork", 1,
				"WaterPurificationTablets", 1,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		toolcabinet = {
			procedural = true,
			procList = {
				{name="ToolCabinetMechanics", min=0, max=99, weightChance=100},
				{name="CrateTools", min=0, max=99, weightChance=20},
			}
		},
		-- Empty for testing purposes.
		trough = {
			rolls = 1,
			items = {
				
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		vendingpop = {
			ignoreZombieDensity = true,
			rolls = 4,
			items = {
				"Pop", 10,
				"Pop2", 10,
				"Pop3", 10,
				"PopBottle", 10,
				"PopBottleRare", 1,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		vendingsnack = {
			ignoreZombieDensity = true,
			rolls = 4,
			items = {
				"CandyGummyfish", 0.1,
				"Chocolate", 0.1,
				"Chocolate_Butterchunkers", 0.1,
				"Chocolate_Candy", 0.1,
				"Chocolate_Crackle", 0.1,
				"Chocolate_Deux", 0.1,
				"Chocolate_GalacticDairy", 0.1,
				"Chocolate_RoysPBPucks", 0.1,
				"Chocolate_Smirkers", 0.1,
				"Chocolate_SnikSnak", 0.1,
				"Crisps", 6,
				"Crisps2", 6,
				"Crisps3", 6,
				"Crisps4", 6,
				"GummyBears", 0.1,
				"GummyWorms", 0.1,
				"JellyBeans", 0.1,
				"LicoriceBlack", 0.05,
				"LicoriceRed", 0.1,
				"Peanuts", 2,
				"PorkRinds", 4,
				"Pretzel", 4,
				"SunflowerSeeds", 2,
				"TortillaChips", 2,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		wardrobe = {
			procedural = true,
			procList = {
				{name="WardrobeGeneric", min=98, max=99, weightChance=100},
				{name="WardrobeClassy", min=98, max=99, weightChance=100, forceForZones="Rich"},
				{name="WardrobeRedneck", min=98, max=99, weightChance=100, forceForZones="Poor"},
			}
		},
		woodstove = {
			rolls = 1,
			items = {
				"Bellows", 4,
				"FireplacePoker", 10,
				"PanForged", 20,
				"PotForged", 10,
				"Tongs", 10,
			},
			junk = {
				rolls = 4,
				items = {
					"Firewood", 8,
					"Newspaper", 4,
					"TreeBranch2", 6,
					"Twigs", 10,
				}
			}
		},
		-- Outfits found here will spawn these items instead of the ones in 'inventorymale' and 'inventoryfemale'.
		Outfit_AirportSecurityTarmac = {
			rolls = 1,
			items = {
				"Badge", 200,
				"LighterDisposable", 4,
				"Notepad", 10,
				"Pen", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Agent = {
			rolls = 1,
			items = {
				"Badge", 200,
				"CigarettePack", 1,
				"LighterDisposable", 4,
				"Notepad", 10,
				"Pen", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_AmbulanceDriver = {
			rolls = 1,
			items = {
				"FirstAidKit", 2,
				"Gloves_Surgical", 10,
				"HandTorch", 8,
				"Hat_SurgicalMask", 10,
				"Notepad", 10,
				"Pager", 4,
				"PenLight", 10,
				"Pencil", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_ArmyCamoDesert = {
			rolls = 1,
			items = {
				"556Box", 1,
				"556Bullets", 10,
				"556Clip", 8,
				"BeefJerky", 8,
				"P38", 10,
				"CompassDirectional", 10,
				"DehydratedMeatStick", 10,
				"Handiknife", 0.1,
				"HottieZ", 0.1,
				"KnifePocket", 0.1,
				"Notepad", 10,
				"Pencil", 10,
				"Spork", 1,
				"TobaccoChewing", 1,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_ArmyCamoGreen = {
			rolls = 1,
			items = {
				"556Box", 1,
				"556Bullets", 10,
				"556Clip", 8,
				"BeefJerky", 8,
				"P38", 10,
				"CompassDirectional", 10,
				"DehydratedMeatStick", 10,
				"Handiknife", 0.1,
				"HottieZ", 0.1,
				"KnifePocket", 0.1,
				"Notepad", 10,
				"Pencil", 10,
				"Spork", 1,
				"TobaccoChewing", 1,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Backpacker = {
			rolls = 1,
			items = {
				"Base.HempBagSeed", 1,
			    "CameraDisposable", 1,
				"CigaretteRolled", 8,
				"CigaretteRollingPapers", 4,
	            "CompassDirectional", 1,
				"Handiknife", 0.1,
				"HempMag1", 2,
				"LetterHandwritten", 1,
				"LighterDisposable", 8,
				"Passport", 20,
		        "Photo", 1,
			    "Postcard", 1,
			    "SmokingPipe", 0.1,
				"Spork", 10,
				"Sportsbottle", 4,
				"TobaccoLoose", 1,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Bandit = {
			rolls = 1,
			items = {
				"CigaretteRolled", 8,
				"CigaretteRollingPapers", 4,
				"Firecracker", 4,
				"Flask", 1,
				"Handiknife", 0.1,
				"HuntingKnife", 8,
				"KnifePocket", 0.1,
				"SwitchKnife", 8,
				"TobaccoChewing", 1,
				"TobaccoLoose", 1,
				"Whetstone", 1,
			},
			bags = BagsAndContainers.BanditBag,
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_Bandit_Early = {
			rolls = 1,
			items = {
				"CigaretteRolled", 8,
				"CigaretteRollingPapers", 4,
				"Firecracker", 4,
				"Flask", 1,
				"Handiknife", 0.1,
				"HuntingKnife", 8,
				"KnifePocket", 0.1,
				"SwitchKnife", 8,
				"TobaccoChewing", 1,
				"TobaccoLoose", 1,
				"Whetstone", 1,
			},
			bags = BagsAndContainers.BanditBag_Early,
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_Bandit_Mid = {
			rolls = 1,
			items = {
				"CigaretteRolled", 8,
				"CigaretteRollingPapers", 4,
				"Firecracker", 4,
				"Flask", 1,
				"Handiknife", 0.1,
				"HuntingKnife", 8,
				"KnifePocket", 0.1,
				"SwitchKnife", 8,
				"TobaccoChewing", 1,
				"TobaccoLoose", 1,
				"Whetstone", 1,
			},
			bags = BagsAndContainers.BanditBag_Mid,
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_Bandit_Late = {
			rolls = 1,
			items = {
				"CigaretteRolled", 8,
				"CigaretteRollingPapers", 4,
				"Firecracker", 4,
				"Flask", 1,
				"Handiknife", 0.1,
				"HuntingKnife", 8,
				"KnifePocket", 0.1,
				"SwitchKnife", 8,
				"TobaccoChewing", 1,
				"TobaccoLoose", 1,
				"Whetstone", 1,
			},
			bags = BagsAndContainers.BanditBag_Late,
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_BaseballPlayer_KY = {
			rolls = 1,
			items = {
				"Gum", 20,
				"TobaccoChewing", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_BaseballPlayer_Rangers = {
			rolls = 1,
			items = {
				"Gum", 20,
				"TobaccoChewing", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_BaseballPlayer_Z = {
			rolls = 1,
			items = {
				"Gum", 20,
				"TobaccoChewing", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Bathrobe = {
			defaultInventoryLoot = false,
			rolls = 1,
			items = {
			},
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_Biker = {
			rolls = 1,
			items = {
				"BeerCan", 10,
				"CigarettePack", 1,
				"CigaretteRolled", 4,
				"CigaretteRollingPapers", 1,
				"Cigarillo", 4,
				"Flask", 1,
	            "Harmonica", 0.1,
				"HuntingKnife", 8,
				"Pistol", 1,
				"Revolver_Short", 4,
				"SwitchKnife", 8,
				"TobaccoChewing", 1,
				"TobaccoLoose", 1,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Bob = {
			defaultInventoryLoot = false,
			rolls = 1,
			items = {
			},
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_BountyHunter = {
			rolls = 1,
			items = {
				"Badge", 200,
				"CigarettePack", 1,
				"LighterDisposable", 4,
				"Magazine_Crime", 8,
				"Magazine_Police", 8,
				"Notepad", 10,
				"Revolver_Short", 1,
				"Zipties", 20,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Camper = {
			rolls = 1,
			items = {
				"CompassDirectional", 10,
				"DehydratedMeatStick", 4,
				"GranolaBar", 4,
				"InsectRepellent", 10,
				"Handiknife", 0.1,
				"KnifePocket", 0.1,
				"MagnesiumFirestarter", 1,
				"Spork", 10,
				"WaterPurificationTablets", 1,
				"Whistle", 2,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Classy = {
			rolls = 1,
			items = {
				"BusinessCard", 10,
				"Cigar", 2,
				"CreditCard", 50,
				"CreditCard", 20,
				"Lighter", 4,
				"Magazine_Rich", 1,
				"Money", 100,
				"Money", 50,
				"Money", 50,
				"Money", 20,
				"Money", 20,
				"Passport", 1,
				"PenFancy", 8,
				"Pocketwatch", 4,
				"StockCertificate", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_ClubGoer = {
			rolls = 1,
			items = {
				"CandyGummyfish", 10,
				"Gum", 20,
				"GummyBears", 10,
				"GummyWorms", 10,
				"Lollipop", 10,
				"Paperback_NewAge", 4,
				"PillsVitamins", 20,
				"Whistle", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_ConstructionWorker = {
			rolls = 1,
			items = {
				"Cigar", 0.5,
				"CigarettePack", 1,
				"DuctTape", 10,
				"Flask", 1,
				"Handiknife", 0.1,
				"KnifePocket", 0.1,
				"LighterDisposable", 4,
				"Nails", 20,
				"Notepad", 10,
				"Pencil", 10,
				"Screws", 20,
				"TobaccoChewing", 1,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Cook_Generic = {
			rolls = 1,
			items = {
				"CigarettePack", 1,
				"DishCloth", 20,
				"LighterDisposable", 4,
				"Notepad", 10,
				"Pencil", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Cook_Spiffos = {
			rolls = 1,
			items = {
				"CigarettePack", 1,
				"DishCloth", 20,
				"LighterDisposable", 4,
				"Notepad", 10,
				"Pencil", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_CostumeWildWestBoss = {
			rolls = 1,
			items = {
				"ToyBadge", 100,
			},
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_CostumeWildWestLawman = {
			rolls = 1,
			items = {
				"ToyBadge", 100,
			},
			bags = BagsAndContainers.Empty,
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_CostumeWildWestOutlaw = {
			rolls = 1,
			items = {
			},
			bags = BagsAndContainers.Empty,
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_CostumeWildWestMayor = {
			rolls = 1,
			items = {
				"ToyBadge", 100,
			},
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_Cultist = {
			defaultInventoryLoot = false,
			rolls = 1,
			items = {
				
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Detective = {
			rolls = 1,
			items = {
				"Badge", 200,
				"CigarettePack", 1,
				"LighterDisposable", 4,
				"Notepad", 10,
				"Pager", 10,
				"Pencil", 10,
				"Revolver_Short", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Doctor = {
			rolls = 1,
			items = {
				"FirstAidKit", 2,
				"Gloves_Surgical", 10,
				"Hat_SurgicalMask", 10,
				"Pager", 50,
				"PenLight", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Evacuee = {
			rolls = 1,
			items = {
				"BorisBadger", 0.01,
				"CatToy", 1,
				"Diary1", 1,
				"Diary2", 1,
				"DogChew", 1,
				"Doll", 1,
				"Doodle", 1,
				"FluffyfootBunny", 0.01,
				"FreddyFox", 0.01,
				"FurbertSquirrel", 0.01,
				"Glasses_Reading", 1,
				"JacquesBeaver", 0.01,
				"Leash", 1,
				"LetterHandwritten", 1,
				"MoleyMole", 0.01,
				"Necklace_Crucifix", 1,
				"PancakeHedgehog", 0.01,
				"PanchoDog", 0.01,
				"Passport", 0.5,
				"Photo", 10,
				"Plushabug", 0.01,
				"Pocketwatch", 0.5,
				"Spiffo", 0.01,
				"ToiletPaper", 1,
				"Toothbrush", 1,
				"ToyBear", 1,
				-- Story Photos
				"BobPic", 0.01,
				"CaseyPic", 0.01,
				"ChrisPic", 0.01,
				"CortmanPic", 0.01,
				"HankPic", 0.01,
				"JamesPic", 0.01,
				"KatePic", 0.01,
				"MariannePic", 0.01,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_ExterminatorSuited = {
			rolls = 1,
			items = {
				"CigarettePack", 1,
				"DuctTape", 10,
				"Garbagebag", 10,
				"Gloves_Dish", 10,
				"LighterDisposable", 4,
				"RatPoison", 10,
				"RespiratorFilters", 1,
				"TrapMouse", 20,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Farmer = {
			rolls = 1,
			items = {
				"Base.BasilBagSeed", 1,
				"Base.BroccoliBagSeed2", 1,
				"Base.CabbageBagSeed2", 1,
				"Base.CarrotBagSeed2", 1,
				"Base.ChivesBagSeed", 1,
				"Base.CilantroBagSeed", 1,
				"Base.CornBagSeed", 1,
				"Base.GarlicBagSeed", 1,
				"Base.GreenpeasBagSeed", 1,
				"Base.KaleBagSeed", 1,
				"Base.OnionBagSeed", 1,
				"Base.OreganoBagSeed", 1,
				"Base.ParsleyBagSeed", 1,
				"Base.PotatoBagSeed2", 1,
				"Base.RedRadishBagSeed2", 1,
				"Base.RosemaryBagSeed", 1,
				"Base.SageBagSeed", 1,
				"Base.StrewberrieBagSeed2", 1,
				"Base.SweetPotatoBagSeed", 1,
				"Base.ThymeBagSeed", 1,
				"Base.TomatoBagSeed2", 1,
				"FarmingMag1", 1,
				"FarmingMag2", 1,
				"FarmingMag3", 1,
				"FarmingMag4", 1,
				"FarmingMag5", 1,
				"FarmingMag6", 1,
				"FarmingMag7", 1,
				"FarmingMag8", 1,
				"KnifePocket", 0.1,
				"SeedBag", 1,
				"TobaccoChewing", 8,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_FiremanFullSuit = {
			rolls = 1,
			items = {
				"Badge", 20,
				"FirstAidKit", 2,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_FiremanStripper = {
			rolls = 1,
			items = {
				"Money", 20,
				"Money", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Fisherman = {
			rolls = 1,
			items = {
				"FishingHook", 10,
				"FishingHookBox", 1,
				"FishingLine", 10,
				"FishingMag1", 2,
				"FishingMag2", 2,
				"InsectRepellent", 10,
				"JigLure", 10,
				"KnifeFillet", 8,
				"KnifePocket", 0.1,
				"MinnowLure", 10,
				"Pliers", 10,
				"PremiumFishingLine", 4,
				"TobaccoChewing", 8,
				"WaterPurificationTablets", 1,
				"Whetstone", 1,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Foreman = {
			rolls = 1,
			items = {
				"BluePen", 8,
				"Calculator", 10,
				"Cigar", 0.5,
				"CigarettePack", 1,
				"Clipboard", 10,
				"GraphPaper", 10,
				"LighterDisposable", 4,
				"Notepad", 10,
				"Pencil", 10,
				"TobaccoChewing", 1,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Fossoil = {
			rolls = 1,
			items = {
				"CigarettePack", 1,
				"LighterDisposable", 4,
				"RippedSheets", 10,
				"RippedSheetsDirty", 10,
				"TobaccoChewing", 1,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Gas2Go = {
			rolls = 1,
			items = {
				"CigarettePack", 1,
				"LighterDisposable", 4,
				"RippedSheets", 20,
				"RippedSheetsDirty", 20,
				"TobaccoChewing", 1,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Gaudy = {
			rolls = 1,
			items = {
				"BusinessCard", 10,
				"Cigar", 2,
				"CreditCard", 100,
				"CreditCard", 50,
				"CreditCard", 20,
				"CreditCard", 20,
				"Lighter", 2,
				"Money", 50,
				"Money", 20,
				"Money", 20,
				"Paperback_Poor", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Ghillie = {
			rolls = 1,
			items = {
				"556Box", 1,
				"556Bullets", 10,
				"556Clip", 8,
				"BeefJerky", 8,
				"P38", 10,
				"CompassDirectional", 10,
				"DehydratedMeatStick", 10,
				"Handiknife", 1,
				"HottieZ", 0.1,
				"KnifePocket", 0.1,
				"Notepad", 10,
				"Pencil", 10,
				"TobaccoChewing", 1,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Golfer = {
			rolls = 1,
			items = {
				"GolfBall", 10,
				"GolfTee", 10,
				"Magazine_Golf", 1,
				"Notepad", 10,
				"Pager", 4,
				"Paperback_Golf", 1,
				"Pencil", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Goth = {
			rolls = 1,
			items = {
				"CandyCaramels", 10,
				"CandyCorn", 10,
				"CigarettePack", 1,
				"Diary2", 4,
				"LighterDisposable", 4,
				"Lipstick", 10,
				"Lollipop", 10,
				"MakeupEyeshadow", 10,
				"MakeupFoundation", 10,
				"Paperback_Occult", 1,
				"PenFancy", 4,
				"Pocketwatch", 1,
				"RubberSpider", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Groucho = {
			rolls = 1,
			items = {
				"Cigar", 20,
				"Magazine_Humor", 10,
			},
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_Grunge = {
			rolls = 1,
			items = {
				"BeerCan", 10,
				"CigaretteRolled", 8,
				"CigaretteRollingPapers", 4,
				"Firecracker", 0.1,
				"Flask", 1,
				"HottieZ", 0.1,
				"LighterDisposable", 4,
				"Pills", 10,
				"TobaccoLoose", 4,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_GuitarGuy = {
			rolls = 1,
			items = {
				"BeerCan", 10,
				"CigarettePack", 1,
				"Flask", 1,
				"GuitarPick", 100,
				"LighterDisposable", 4,
				"Magazine_Music", 1,
				"Paperback_Music", 1,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Hobbo = {
			rolls = 1,
			items = {
				"CigaretteRolled", 10,
				"CigaretteRollingPapers", 10,
				"KnifePocket", 0.1,
				"Flask", 4,
				"TobaccoLoose", 1,
				"ToiletPaper", 10,
				"WhiskeyEmpty", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Hobbyist = {
			rolls = 1,
			items = {
				"DiceBag", 10,
			},
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_HonorStudent = {
			rolls = 1,
			items = {
				"BluePen", 10,
				"Calculator", 8,
				"CompassGeometry", 4,
				"PenFancy", 1,
				"RedPen", 10,
				"Tissue", 10,
			},
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_HospitalPatient = {
			defaultInventoryLoot = false,
			rolls = 1,
			items = {
			},
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_HospitalPatientBathrobe = {
			defaultInventoryLoot = false,
			rolls = 1,
			items = {
			},
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_Hunter = {
			rolls = 1,
			items = {
				"223Bullets", 10,
				"308Bullets", 10,
				"BeefJerky", 8,
				"CompassDirectional", 10,
				"DehydratedMeatStick", 10,
				"InsectRepellent", 10,
				"Handiknife", 0.1,
				"KnifePocket", 0.1,
				"ShotgunShells", 10,
				"TobaccoChewing", 10,
				"WaterPurificationTablets", 1,
				"Whetstone", 1,
				"Whistle", 2,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Inmate = {
			defaultInventoryLoot = false,
			rolls = 1,
			items = {
				"CigaretteRolled", 10,
				"CrudeKnife", 1,
				"GlassShiv", 1,
				"KnifeShiv", 1,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_InmateKhaki = {
			defaultInventoryLoot = false,
			rolls = 1,
			items = {
				"CigaretteRolled", 10,
				"CrudeKnife", 1,
				"GlassShiv", 1,
				"KnifeShiv", 1,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_McCoys = {
			rolls = 1,
			items = {
				"CigarettePack", 1,
				"DuctTape", 8,
				"Handiknife", 0.1,
				"KnifePocket", 0.1,
				"Nails", 10,
				"Notepad", 10,
				"Pencil", 10,
				"Screws", 8,
				"TobaccoChewing", 1,
                "Whetstone", 1,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Mechanic = {
			rolls = 1,
			items = {
				"CigarettePack", 1,
				"Handiknife", 0.1,
				"KnifePocket", 0.1,
				"Magazine_Car", 1,
				"Notepad", 10,
				"Pencil", 10,
				"RippedSheets", 10,
				"RippedSheetsDirty", 10,
				"Screws", 10,
				"TobaccoChewing", 1,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_MetalWorker = {
			rolls = 1,
			items = {
				"CigarettePack", 1,
				"Handiknife", 0.1,
				"KnifePocket", 0.1,
				"Notepad", 10,
				"Pencil", 10,
				"RippedSheets", 10,
				"RippedSheetsDirty", 10,
				"Screws", 8,
				"TobaccoChewing", 1,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Mob = {
			rolls = 1,
			items = {
				"IcePick", 1,
				"MoneyBundle", 1,
				"SuspiciousPackage", 1,
			},
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_Naked = {
			defaultInventoryLoot = false,
			rolls = 1,
			items = {
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_NakedVeil = {
			defaultInventoryLoot = false,
			rolls = 1,
			items = {
			},
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_Nurse = {
			rolls = 1,
			items = {
				"FirstAidKit", 2,
				"Gloves_Surgical", 10,
				"HandTorch", 8,
				"Hat_SurgicalMask", 10,
				"Pager", 4,
				"PenLight", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_OfficeWorker = {
			rolls = 1,
			items = {
				"BluePen", 8,
				"BusinessCard", 10,
				"Calculator", 1,
				"Clipboard", 1,
				"CreditCard", 20,
				"Eraser", 8,
				"Magazine_Business", 1,
				"Pager", 1,
				"Paperwork", 1,
				"Pen", 8,
				"Pencil", 10,
				"RedPen", 8,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_OfficeWorkerSkirt = {
			rolls = 1,
			items = {
				"BluePen", 8,
				"BusinessCard", 10,
				"Calculator", 1,
				"Clipboard", 1,
				"CreditCard", 20,
				"Eraser", 8,
				"Magazine_Business", 1,
				"Pager", 1,
				"Paperwork", 1,
				"Pen", 8,
				"Pencil", 10,
				"RedPen", 8,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Pharmacist = {
			rolls = 1,
			items = {
				"FirstAidKit", 2,
				"Gloves_Surgical", 10,
				"Hat_SurgicalMask", 10,
				"Pager", 4,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_PokerDealer = {
			rolls = 1,
			items = {
				"CardDeck", 10,
				"Money", 10,
				"PokerChips", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Police = {
			rolls = 1,
			items = {
				"Badge", 50,
				"9mmClip", 8,
				"Bullets9mm", 10,
				"Bullets9mmBox", 1,
				"KnifePocket", 0.1,
				"Notepad", 10,
				"Pen", 8,
				"Whistle", 2,
				"Zipties", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_PoliceState = {
			rolls = 1,
			items = {
				"Badge", 50,
				"Bullets38", 10,
				"Bullets38Box", 1,
				"Bullets44", 6,
				"Bullets44Box", 0.5,
				"Bullets45", 4,
				"Bullets45Box", 0.25,
				"KnifePocket", 0.1,
				"Notepad", 10,
				"Pen", 8,
				"Whistle", 2,
				"Zipties", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_PoliceStripper = {
			rolls = 1,
			items = {
				"Money", 20,
				"Money", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Priest = {
			rolls = 1,
			items = {
				"Necklace_Crucifix", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_PrisonGuard = {
			rolls = 1,
			items = {
				"Badge", 50,
				"Notepad", 10,
				"Pen", 8,
				"Whistle", 2,
				"Zipties", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_PrivateMilitia = {
			rolls = 1,
			items = {
				"223Bullets", 10,
				"308Bullets", 10,
				"BeefJerky", 8,
				"DehydratedMeatStick", 10,
				"KnifeButterfly", 8,
				"ShotgunShells", 10,
				"SwitchKnife", 8,
				"TobaccoChewing", 1,
				"Whistle", 2,
				"Zipties", 10,
			},
			bags = BagsAndContainers.BanditBag,
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Punk = {
			rolls = 1,
			items = {
				"BeerBottle", 10,
				"BeerCan", 10,
				"CigarettePack", 1,
				"CigaretteRollingPapers", 1,
				"Cigarillo", 4,
				"Comb", 4,
				"Firecracker", 0.1,
				"HairDyeUncommon", 6,
				"Hairgel", 2,
				"Hairspray2", 6,
				"RubberSpider", 0.1,
				"SwitchKnife", 8,
				"Whiskey", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Raider = {
			rolls = 1,
			items = {
				"CigaretteRolled", 10,
				"HuntingKnife", 6,
				"Whiskey", 0.1,
				"SwitchKnife", 6,
				"Whistle", 2,
				"TobaccoChewing", 1,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Ranger = {
			rolls = 1,
			items = {
				"Badge", 200,
				"CompassDirectional", 10,
				"Handiknife", 0.1,
				"KnifePocket", 0.1,
				"ShotgunShells", 10,
				"ShotgunShellsBox", 1,
				"Notebook", 10,
				"Pen", 8,
				"Whistle", 2,
				"TobaccoChewing", 1,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Redneck = {
			rolls = 1,
			items = {
				"BeefJerky", 8,
				"BeerCan", 10,
				"CigarettePack", 1,
				"DehydratedMeatStick", 10,
				"Handiknife", 0.1,
				"HottieZ", 0.1,
				"KnifePocket", 0.1,
				"KnifeButterfly", 0.1,
				"ScratchTicket_Winner", 0.1,
				"Whiskey", 0.1,
				"TobaccoChewing", 10,
			},
			junk = {
				rolls = 1,
				items = {
				}
			}
		},
		Outfit_Rocker = {
			rolls = 1,
			items = {
				"BeerCan", 10,
				"CigarettePack", 1,
				"CigaretteRollingPapers", 1,
				"Firecracker", 0.1,
				"Flask", 1,
				"HottieZ", 0.1,
				"LighterDisposable", 4,
				"TobaccoLoose", 1,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Sanitation = {
			rolls = 1,
			items = {
				"CigarettePack", 1,
				"Flask", 1,
				"Garbagebag", 20,
				"Gloves_Dish", 10,
				"Hat_DustMask", 10,
				"LighterDisposable", 4,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Stripper = {
			rolls = 1,
			items = {
				"Money", 20,
				"Money", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_StripperBlack = {
			rolls = 1,
			items = {
				"Money", 20,
				"Money", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_StripperNaked = {
			rolls = 1,
			items = {
				"Money", 20,
				"Money", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_StripperPink = {
			rolls = 1,
			items = {
				"Money", 20,
				"Money", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Student = {
			rolls = 1,
			items = {
				"Calculator", 10,
				"CDplayer", 2,
				"ComicBook_Retail", 4,
				"Disc_Retail", 4,
				"Earbuds", 2,
				"Firecracker", 0.1,
				"Headphones", 1,
				"Notebook", 10,
				"Pencil", 10,
				"RPGmanual", 0.1,
				"VideoGame", 4,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Survivalist = {
			rolls = 1,
			items = {
				"BeefJerky", 8,
				"CompassDirectional", 10,
				"DehydratedMeatStick", 10,
				"Diary2", 10,
				"Firecracker", 1,
				"Handiknife", 10,
				"HerbalistMag", 2,
				"Journal", 10,
				"KnifeButterfly", 10,
				"Photo", 20,
				"Photo", 10,
				"Spork", 10,
				"TobaccoChewing", 10,
				"WaterBottle", 10,
				"WaterPurificationTablets", 1,
				"Whetstone", 1,
				"Whistle", 2,
			},
			bags = BagsAndContainers.SurvivorBag,
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Survivalist02 = {
			rolls = 1,
			items = {
				"BeefJerky", 8,
				"CompassDirectional", 10,
				"DehydratedMeatStick", 10,
				"Diary2", 10,
				"Firecracker", 1,
				"Handiknife", 10,
				"HerbalistMag", 2,
				"Journal", 10,
				"KnifeButterfly", 10,
				"Photo", 20,
				"Photo", 10,
				"Spork", 10,
				"TobaccoChewing", 10,
				"WaterBottle", 10,
				"WaterPurificationTablets", 1,
				"Whetstone", 1,
				"Whistle", 2,
			},
			bags = BagsAndContainers.SurvivorBag,
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_Survivalist03 = {
			rolls = 1,
			items = {
				"BeefJerky", 8,
				"CompassDirectional", 10,
				"DehydratedMeatStick", 10,
				"Diary2", 10,
				"Firecracker", 1,
				"Handiknife", 10,
				"HerbalistMag", 2,
				"Journal", 10,
				"KnifeButterfly", 10,
				"Photo", 20,
				"Photo", 10,
				"Spork", 10,
				"TobaccoChewing", 10,
				"WaterBottle", 10,
				"WaterPurificationTablets", 1,
				"Whetstone", 1,
				"Whistle", 2,
			},
			bags = BagsAndContainers.SurvivorBag,
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_Survivalist04 = {
			rolls = 1,
			items = {
				"BeefJerky", 8,
				"CompassDirectional", 10,
				"DehydratedMeatStick", 10,
				"Diary2", 10,
				"Firecracker", 1,
				"Handiknife", 10,
				"HerbalistMag", 2,
				"Journal", 10,
				"KnifeButterfly", 10,
				"Photo", 20,
				"Photo", 10,
				"Spork", 10,
				"TobaccoChewing", 10,
				"WaterBottle", 10,
				"WaterPurificationTablets", 1,
				"Whetstone", 1,
				"Whistle", 2,
			},
			bags = BagsAndContainers.SurvivorBag,
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_Survivalist05 = {
			rolls = 1,
			items = {
				"BeefJerky", 8,
				"CompassDirectional", 10,
				"DehydratedMeatStick", 10,
				"Diary2", 10,
				"Firecracker", 1,
				"Handiknife", 10,
				"HerbalistMag", 2,
				"Journal", 10,
				"KnifeButterfly", 10,
				"Photo", 20,
				"Photo", 10,
				"Spork", 10,
				"TobaccoChewing", 10,
				"WaterBottle", 10,
				"WaterPurificationTablets", 1,
				"Whetstone", 1,
				"Whistle", 2,
			},
			bags = BagsAndContainers.SurvivorBag,
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_Survivalist_Mid = {
			rolls = 1,
			items = {
				"BeefJerky", 8,
				"CompassDirectional", 10,
				"DehydratedMeatStick", 10,
				"Diary2", 10,
				"Firecracker", 1,
				"Handiknife", 10,
				"HerbalistMag", 2,
				"Journal", 10,
				"KnifeButterfly", 10,
				"Photo", 20,
				"Photo", 10,
				"Spork", 10,
				"TobaccoChewing", 10,
				"WaterBottle", 10,
				"WaterPurificationTablets", 1,
				"Whetstone", 1,
				"Whistle", 2,
			},
			bags = BagsAndContainers.SurvivorBag_Mid,
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_Survivalist02_Mid = {
			rolls = 1,
			items = {
				"BeefJerky", 8,
				"CompassDirectional", 10,
				"DehydratedMeatStick", 10,
				"Diary2", 10,
				"Firecracker", 1,
				"Handiknife", 10,
				"HerbalistMag", 2,
				"Journal", 10,
				"KnifeButterfly", 10,
				"Photo", 20,
				"Photo", 10,
				"Spork", 10,
				"TobaccoChewing", 10,
				"WaterBottle", 10,
				"WaterPurificationTablets", 1,
				"Whetstone", 1,
				"Whistle", 2,
			},
			bags = BagsAndContainers.SurvivorBag_Mid,
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_Survivalist03_Mid = {
			rolls = 1,
			items = {
				"BeefJerky", 8,
				"CompassDirectional", 10,
				"DehydratedMeatStick", 10,
				"Diary2", 10,
				"Firecracker", 1,
				"Handiknife", 10,
				"HerbalistMag", 2,
				"Journal", 10,
				"KnifeButterfly", 10,
				"Photo", 20,
				"Photo", 10,
				"Spork", 10,
				"TobaccoChewing", 10,
				"WaterBottle", 10,
				"WaterPurificationTablets", 1,
				"Whetstone", 1,
				"Whistle", 2,
			},
			bags = BagsAndContainers.SurvivorBag_Mid,
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_Survivalist04_Mid = {
			rolls = 1,
			items = {
				"BeefJerky", 8,
				"CompassDirectional", 10,
				"DehydratedMeatStick", 10,
				"Diary2", 10,
				"Firecracker", 1,
				"Handiknife", 10,
				"HerbalistMag", 2,
				"Journal", 10,
				"KnifeButterfly", 10,
				"Photo", 20,
				"Photo", 10,
				"Spork", 10,
				"TobaccoChewing", 10,
				"WaterBottle", 10,
				"WaterPurificationTablets", 1,
				"Whetstone", 1,
				"Whistle", 2,
			},
			bags = BagsAndContainers.SurvivorBag_Mid,
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_Survivalist05_Mid = {
			rolls = 1,
			items = {
				"BeefJerky", 8,
				"CompassDirectional", 10,
				"DehydratedMeatStick", 10,
				"Diary2", 10,
				"Firecracker", 1,
				"Handiknife", 10,
				"HerbalistMag", 2,
				"Journal", 10,
				"KnifeButterfly", 10,
				"Photo", 20,
				"Photo", 10,
				"Spork", 10,
				"TobaccoChewing", 10,
				"WaterBottle", 10,
				"WaterPurificationTablets", 1,
				"Whetstone", 1,
				"Whistle", 2,
			},
			bags = BagsAndContainers.SurvivorBag_Mid,
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_Survivalist_Late = {
			rolls = 1,
			items = {
				"BeefJerky", 8,
				"CompassDirectional", 10,
				"DehydratedMeatStick", 10,
				"Diary2", 10,
				"Firecracker", 1,
				"Handiknife", 10,
				"HerbalistMag", 2,
				"Journal", 10,
				"KnifeButterfly", 10,
				"Photo", 20,
				"Photo", 10,
				"Spork", 10,
				"TobaccoChewing", 10,
				"WaterBottle", 10,
				"WaterPurificationTablets", 1,
				"Whetstone", 1,
				"Whistle", 2,
			},
			bags = BagsAndContainers.SurvivorBag_Late,
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_Survivalist02_Late = {
			rolls = 1,
			items = {
				"BeefJerky", 8,
				"CompassDirectional", 10,
				"DehydratedMeatStick", 10,
				"Diary2", 10,
				"Firecracker", 1,
				"Handiknife", 10,
				"HerbalistMag", 2,
				"Journal", 10,
				"KnifeButterfly", 10,
				"Photo", 20,
				"Photo", 10,
				"Spork", 10,
				"TobaccoChewing", 10,
				"WaterBottle", 10,
				"WaterPurificationTablets", 1,
				"Whetstone", 1,
				"Whistle", 2,
			},
			bags = BagsAndContainers.SurvivorBag_Late,
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_Survivalist03_Late = {
			rolls = 1,
			items = {
				"BeefJerky", 8,
				"CompassDirectional", 10,
				"DehydratedMeatStick", 10,
				"Diary2", 10,
				"Firecracker", 1,
				"Handiknife", 10,
				"HerbalistMag", 2,
				"Journal", 10,
				"KnifeButterfly", 10,
				"Photo", 20,
				"Photo", 10,
				"Spork", 10,
				"TobaccoChewing", 10,
				"WaterBottle", 10,
				"WaterPurificationTablets", 1,
				"Whetstone", 1,
				"Whistle", 2,
			},
			bags = BagsAndContainers.SurvivorBag_Late,
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_Survivalist04_Late = {
			rolls = 1,
			items = {
				"BeefJerky", 8,
				"CompassDirectional", 10,
				"DehydratedMeatStick", 10,
				"Diary2", 10,
				"Firecracker", 1,
				"Handiknife", 10,
				"HerbalistMag", 2,
				"Journal", 10,
				"KnifeButterfly", 10,
				"Photo", 20,
				"Photo", 10,
				"Spork", 10,
				"TobaccoChewing", 10,
				"WaterBottle", 10,
				"WaterPurificationTablets", 1,
				"Whetstone", 1,
				"Whistle", 2,
			},
			bags = BagsAndContainers.SurvivorBag_Late,
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_Survivalist05_Late = {
			rolls = 1,
			items = {
				"BeefJerky", 8,
				"CompassDirectional", 10,
				"DehydratedMeatStick", 10,
				"Diary2", 10,
				"Firecracker", 1,
				"Handiknife", 10,
				"HerbalistMag", 2,
				"Journal", 10,
				"KnifeButterfly", 10,
				"Photo", 20,
				"Photo", 10,
				"Spork", 10,
				"TobaccoChewing", 10,
				"WaterBottle", 10,
				"WaterPurificationTablets", 1,
				"Whetstone", 1,
				"Whistle", 2,
			},
			bags = BagsAndContainers.SurvivorBag_Late,
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_Teacher = {
			rolls = 1,
			items = {
				"BluePen", 8,
				"Calculator", 10,
				"CigarettePack", 1,
				"Notebook", 10,
				"Pencil", 10,
				"RedPen", 8,
				"Whiskey", 0.1,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_ThunderGas = {
			rolls = 1,
			items = {
				"CigarettePack", 1,
				"RippedSheets", 10,
				"RippedSheetsDirty", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Tourist = {
			rolls = 1,
			items = {
				"Brochure", 10,
				"CameraDisposable", 20,
				"Camera", 10,
				"CameraExpensive", 4,
				"CocktailUmbrella", 0.1,
				"Handiknife", 0.1,
				"Money", 20,
				"Passport", 10,
			},
			bags = BagsAndContainers.Tourist,
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Trader = {
			rolls = 1,
			items = {
				"BluePen", 8,
				"BusinessCard", 10,
				"Calculator", 1,
				"Cigar", 2,
				"Clipboard", 1,
				"CordlessPhone", 1,
				"CreditCard", 50,
				"CreditCard", 20,
				"Eraser", 8,
				"IndexCard", 10,
				"Magazine_Business", 1,
				"Magazine_Rich", 1,
				"Money", 100,
				"Money", 50,
				"Money", 50,
				"Money", 20,
				"Money", 20,
				"Pager", 50,
				"Paperwork", 1,
				"Pen", 8,
				"PenFancy", 1,
				"Pencil", 10,
				"RedPen", 8,
				"StockCertificate", 50,
				"StockCertificate", 20,
				"StockCertificate", 10,
				"StockCertificate", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Trucker = {
			rolls = 1,
			items = {
				"CigarettePack", 1,
				"CigaretteRollingPapers", 1,
		        "Cigarillo", 1,
				"Flask", 1,
	            "Harmonica", 1,
				"HottieZ", 4,
			    "KeyRing_EagleFlag", 1,
				"LighterDisposable", 4,
				"PillsVitamins", 20,
				"TobaccoChewing", 10,
				"TobaccoLoose", 1,
			},
			junk = {
				rolls = 1,
				items = {
				    "Pistol2", 0.01,
				    "Revolver_Short", 0.01,
			        "SuspiciousPackage", 0.0001,
				}
			}
		},
		Outfit_Varsity = {
			rolls = 1,
			items = {
				"CDplayer", 2,
				"CigarettePack", 1,
				"ComicBook_Retail", 4,
				"Disc_Retail", 4,
				"Earbuds", 2,
				"Headphones", 1,
				"HottieZ", 0.1,
				"RubberSpider", 0.1,
				"Whiskey", 0.1,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Waiter_Classy = {
			rolls = 1,
			items = {
				"BluePen", 8,
				"Corkscrew", 4,
				"DishCloth", 10,
				"KnifePocket", 0.1,
				"Money", 100,
				"Money", 50,
				"Money", 50,
				"Money", 20,
				"Money", 20,
				"Notepad", 10,
				"Receipt", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Waiter_Diner = {
			rolls = 1,
			items = {
				"CigarettePack", 1,
				"DishCloth", 10,
				"Notepad", 10,
				"Pencil", 10,
				"Receipt", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Waiter_Market = {
			rolls = 1,
			items = {
				"CigarettePack", 1,
				"DishCloth", 10,
				"Notepad", 10,
				"Pencil", 10,
				"Receipt", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Waiter_PileOCrepe = {
			rolls = 1,
			items = {
				"CigarettePack", 1,
				"DishCloth", 10,
				"Notepad", 10,
				"Pencil", 10,
				"Receipt", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Waiter_PizzaWhirled = {
			rolls = 1,
			items = {
				"CigarettePack", 1,
				"DishCloth", 10,
				"Notepad", 10,
				"Pencil", 10,
				"Receipt", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Waiter_Restaurant = {
			rolls = 1,
			items = {
				"CigarettePack", 1,
				"DishCloth", 10,
				"Money", 20,
				"Money", 10,
				"Notepad", 10,
				"Pencil", 10,
				"Receipt", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Waiter_Spiffo = {
			rolls = 1,
			items = {
				"CigarettePack", 1,
				"DishCloth", 10,
				"Notepad", 10,
				"Pencil", 10,
				"Receipt", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Waiter_TacoDelPancho = {
			rolls = 1,
			items = {
				"CigarettePack", 1,
				"DishCloth", 10,
				"Notepad", 10,
				"Pencil", 10,
				"Receipt", 10,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		-- Story NPCS
		Outfit_Dean = {
			-- we don't want random stuff from the general inventory pool in Nolans inventory because something will be reported as a bug so we use defaultInventoryLoot = false
			defaultInventoryLoot = false,
			rolls = 1,
			items = {
				"IDcard", 200,
				"CompassDirectional", 50,
				"InsectRepellent", 50,
				"MagnesiumFirestarter", 50,
				"P38", 50,
				"WaterPurificationTablets", 50,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Duke = {
			defaultInventoryLoot = false,
			rolls = 1,
			items = {
				"Battery", 20,
				"CameraFilm", 100,
				"CameraFilm", 50,
				"CameraFilm", 50,
				"CameraFilm", 20,
				"CreditCard", 200,
				"ElectricWire", 200,
				"IDcard", 200,
				"Pager", 200,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Frank_Hemingway = {
			defaultInventoryLoot = false,
			rolls = 1,
			items = {
				"CreditCard", 200,
				"IDcard", 200,
				"Pager", 200,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Jackie_Jaye = {
			defaultInventoryLoot = false,
			rolls = 1,
			items = {
				"CreditCard", 200,
				"IDcard", 200,
				"Lipstick", 200,
				"Pager", 200,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Joan = {
			defaultInventoryLoot = false,
			rolls = 1,
			items = {
				"CreditCard", 200,
				"IDcard", 200,
				"Pager", 200,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_John = {
			defaultInventoryLoot = false,
			rolls = 1,
			items = {
				"IDcard", 200,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Judge_Matt_Hass = {
			defaultInventoryLoot = false,
			rolls = 1,
			items = {
				"KeyRing_SecurityPass", 200,
				"IDcard", 200,
				"Photo_Hass", 200,
				"Photo_Hass", 100,
				"Photo_Hass", 50,
				"Photo_Hass", 50,
				"Photo_Hass", 50,
				"Photo_Hass", 50,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Kate = {
			defaultInventoryLoot = false,
			rolls = 1,
			items = {
			},
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_Kirsty_Kormick = {
			defaultInventoryLoot = false,
			rolls = 1,
			items = {
				"CreditCard", 200,
				"IDcard", 200,
				"Pager", 200,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Mayor_West_point = {
			defaultInventoryLoot = false,
			rolls = 1,
			items = {
				"BusinessCard_Personal", 200,
				"CreditCard", 200,
				"Cigar", 50,
				"IDcard", 200,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Nolan = {
			defaultInventoryLoot = false,
			rolls = 1,
			items = {
				"BusinessCard_Nolans", 200,
				"BusinessCard_Nolans", 100,
				"BusinessCard_Nolans", 50,
				"BusinessCard_Nolans", 20,
				"BusinessCard_Nolans", 10,
				"Flier_Nolans", 200,
				"IDcard", 200,
				"KeyRing_Nolans", 200,
				"Pager", 200,
			},
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		Outfit_Rev_Peter_Watts = {
			defaultInventoryLoot = false,
			rolls = 1,
			items = {
				"IDcard", 200,
				"KeyRing_PrayingHands", 200,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Sir_Twiggy = {
			defaultInventoryLoot = false,
			rolls = 1,
			items = {
				"IDcard", 200,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		Outfit_Woodcut = {
			defaultInventoryLoot = false,
			rolls = 1,
			items = {
				"IDcard", 200,
				"KeyRing_Sexy", 200,
				"Nails", 100,
				"Nails", 50,
				"Nails", 50,
				"Nails", 20,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
	},
	
	arenakitchen = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="BeerGardenCounter", min=0, max=99, forceForTiles="location_restaurant_bar_01_32;location_restaurant_bar_01_33;location_restaurant_bar_01_34;location_restaurant_bar_01_35"},
				{name="BurgerKitchenSauce", min=0, max=4, weightChance=40},
				{name="BurgerKitchenCutlery", min=0, max=4, weightChance=60},
				{name="CrateBunsBurger", min=0, max=2, weightChance=20},
				{name="CrateBunsHotdog", min=0, max=99, forceForTiles="location_shop_fossoil_01_10;location_shop_fossoil_01_11"},
				{name="CratePopcorn", min=0, max=99, forceForTiles="location_entertainment_theatre_01_17"},
				{name="TheatreDrinks", min=0, max=99, forceForTiles="location_shop_accessories_01_8;location_shop_accessories_01_9;location_shop_accessories_01_12;location_shop_accessories_01_13"},
				{name="TheatreSnacks", min=0, max=99, forceForTiles="location_entertainment_theatre_01_4;location_entertainment_theatre_01_5;location_entertainment_theatre_01_6;location_entertainment_theatre_01_7"},
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateBunsBurger", min=0, max=2, weightChance=40},
				{name="CrateBunsHotdog", min=0, max=2, weightChance=40},
				{name="CrateCondiments", min=0, max=2, weightChance=60},
				{name="CrateOilVegetable", min=0, max=1, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateBunsBurger", min=0, max=2, weightChance=40},
				{name="CrateBunsHotdog", min=0, max=2, weightChance=40},
				{name="CrateCondiments", min=0, max=2, weightChance=60},
				{name="CrateOilVegetable", min=0, max=1, weightChance=100},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="ArenaKitchenFreezer", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeBeer", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateBunsBurger", min=0, max=2, weightChance=40},
				{name="CrateBunsHotdog", min=0, max=2, weightChance=40},
				{name="CrateCondiments", min=0, max=2, weightChance=60},
				{name="CrateOilVegetable", min=0, max=1, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateBunsBurger", min=0, max=2, weightChance=40},
				{name="CrateBunsHotdog", min=0, max=2, weightChance=40},
				{name="CrateCondiments", min=0, max=2, weightChance=60},
				{name="CrateOilVegetable", min=0, max=1, weightChance=100},
			}
		},
		stove = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="StoveSpiffos", min=1, max=99, forceForTiles="appliances_cooking_20;appliances_cooking_21;appliances_cooking_22;appliances_cooking_23;appliances_cooking_24"},
			}
		},
	},
	
	arenakitchenstorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateBunsBurger", min=0, max=2, weightChance=40},
				{name="CrateBunsHotdog", min=0, max=2, weightChance=40},
				{name="CrateCondiments", min=0, max=2, weightChance=60},
				{name="CrateOilVegetable", min=0, max=1, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="BurgerKitchenCutlery", min=0, max=4, weightChance=60},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateBunsBurger", min=0, max=2, weightChance=40},
				{name="CrateBunsHotdog", min=0, max=2, weightChance=40},
				{name="CrateCondiments", min=0, max=2, weightChance=60},
				{name="CrateOilVegetable", min=0, max=1, weightChance=100},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="ArenaKitchenFreezer", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeBeer", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateBunsBurger", min=0, max=2, weightChance=40},
				{name="CrateBunsHotdog", min=0, max=2, weightChance=40},
				{name="CrateCondiments", min=0, max=2, weightChance=60},
				{name="CrateOilVegetable", min=0, max=1, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateBunsBurger", min=0, max=2, weightChance=40},
				{name="CrateBunsHotdog", min=0, max=2, weightChance=40},
				{name="CrateCondiments", min=0, max=2, weightChance=60},
				{name="CrateOilVegetable", min=0, max=1, weightChance=100},
			}
		},
	},
	
	armyhanger = {
		counter = {
			procedural = true,
			procList = {
				{name="ArmyHangarTools", min=0, max=99},
			}
		},
		locker = {
			procedural = true,
			procList = {
				{name="ArmyHangarOutfit", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="ArmyHangarTools", min=0, max=99},
			}
		},
		militarycrate = {
			procedural = true,
			procList = {
				{name="ArmyStorageAmmunition", min=0, max=99, weightChance=100},
				{name="ArmyStorageElectronics", min=0, max=99, weightChance=100},
				{name="ArmyStorageGuns", min=0, max=99, weightChance=100},
				{name="ArmyStorageMedical", min=0, max=99, weightChance=100},
				{name="ArmyStorageOutfit", min=0, max=99, weightChance=100},
			},
			dontSpawnAmmo = true,
		},
	},
	
	armystorage = {
		locker = {
			procedural = true,
			procList = {
				{name="ArmyStorageGuns", min=0, max=99, forceForTiles="furniture_storage_02_8;furniture_storage_02_9;furniture_storage_02_10;furniture_storage_02_11"},
				{name="ArmyStorageOutfit", min=0, max=99, forceForTiles="furniture_storage_02_4;furniture_storage_02_5;furniture_storage_02_6;furniture_storage_02_7"},
			},
			dontSpawnAmmo = true,
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="ArmyStorageGuns", min=0, max=1, weightChance=5},
				{name="ArmyStorageAmmunition", min=0, max=1, weightChance=10},
				{name="ArmyStorageMedical", min=0, max=99, weightChance=40},
				{name="ArmyStorageOutfit", min=0, max=99, weightChance=60},
				{name="ArmyStorageElectronics", min=0, max=99, weightChance=100},
			},
			dontSpawnAmmo = true,
		},
		militarycrate = {
			procedural = true,
			procList = {
				{name="ArmyStorageGuns", min=0, max=99, weightChance=10},
				{name="ArmyStorageAmmunition", min=0, max=99, weightChance=20},
				{name="ArmyStorageMedical", min=0, max=99, weightChance=40},
				{name="ArmyStorageOutfit", min=0, max=99, weightChance=60},
				{name="ArmyStorageElectronics", min=0, max=99, weightChance=100},
			},
			dontSpawnAmmo = true,
		},
		militarylocker = {
			procedural = true,
			procList = {
				{name="ArmyStorageGuns", min=0, max=99},
			}
		},
	},
	
	armysurplus = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="ArmySurplusAmmoBoxes", min=0, max=1, weightChance=20},
				{name="ArmySurplusBackpacks", min=0, max=1, weightChance=60},
				{name="ArmySurplusCases", min=0, max=1, weightChance=20},
				{name="ArmySurplusCots", min=0, max=1, weightChance=10},
				{name="ArmySurplusFootwear", min=0, max=1, weightChance=60},
				{name="ArmySurplusHeadwear", min=0, max=1, weightChance=40},
				{name="ArmySurplusLiterature", min=0, max=1, weightChance=100},
				{name="ArmySurplusMisc", min=0, max=1, weightChance=100},
				{name="ArmySurplusOutfit", min=0, max=1, weightChance=80},
				{name="ArmySurplusWater", min=0, max=1, weightChance=100},
			}
		},
		clothingrack = {
			procedural = true,
			procList = {
				{name="ArmySurplusOutfit", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="ArmySurplusHeadwear", min=0, max=4, weightChance=100},
				{name="ArmySurplusMisc", min=0, max=99, weightChance=20},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="ArmySurplusAmmoBoxes", min=0, max=1, weightChance=20},
				{name="ArmySurplusBackpacks", min=0, max=1, weightChance=60},
				{name="ArmySurplusCases", min=0, max=1, weightChance=20},
				{name="ArmySurplusCots", min=0, max=1, weightChance=40},
				{name="ArmySurplusFootwear", min=0, max=1, weightChance=60},
				{name="ArmySurplusHeadwear", min=0, max=1, weightChance=40},
				{name="ArmySurplusMisc", min=0, max=1, weightChance=100},
				{name="ArmySurplusOutfit", min=0, max=1, weightChance=80},
				{name="ArmySurplusWater", min=0, max=1, weightChance=100},
			}
		},
		displaycase = {
			procedural = true,
			procList = {
				{name="GunStoreRifles", min=1, max=1, weightChance=100},
				{name="GunStoreShotguns", min=1, max=1, weightChance=100},
				{name="GunStoreKnives", min=0, max=1, weightChance=80},
				{name="GunStoreAccessories", min=0, max=99, weightChance=20},
			},
			dontSpawnAmmo = true,
		},
		locker = {
			procedural = true,
			procList = {
				{name="ArmySurplusCases", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="ArmySurplusAmmoBoxes", min=0, max=1, weightChance=20},
				{name="ArmySurplusBackpacks", min=0, max=99, weightChance=100},
				{name="ArmySurplusCases", min=0, max=1, weightChance=20},
				{name="ArmySurplusCots", min=0, max=1, weightChance=40},
				{name="ArmySurplusFootwear", min=0, max=99, weightChance=100},
				{name="ArmySurplusOutfit", min=0, max=99, weightChance=100},
				{name="ArmySurplusMisc", min=0, max=99, weightChance=100},
				{name="ArmySurplusTools", min=0, max=99, weightChance=100},
				{name="ArmySurplusWater", min=0, max=1, weightChance=100},
				{name="CampingStoreGear", min=0, max=2, weightChance=60},
				{name="ClothingStorageWinter", min=0, max=2, weightChance=60},
			}
		},
		militarycrate = {
			procedural = true,
			procList = {
				{name="ArmySurplusAmmoBoxes", min=0, max=99},
			}
		},
		militarylocker = {
			procedural = true,
			procList = {
				{name="ArmySurplusCases", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="ArmySurplusAmmoBoxes", min=0, max=1, weightChance=20},
				{name="ArmySurplusBackpacks", min=0, max=99, weightChance=100},
				{name="ArmySurplusCases", min=0, max=1, weightChance=20},
				{name="ArmySurplusCots", min=0, max=1, weightChance=40},
				{name="ArmySurplusFootwear", min=0, max=99, weightChance=100},
				{name="ArmySurplusLiterature", min=0, max=99, weightChance=100},
				{name="ArmySurplusOutfit", min=0, max=99, weightChance=100},
				{name="ArmySurplusMisc", min=0, max=99, weightChance=100},
				{name="ArmySurplusSnacks", min=0, max=99, forceForTiles="location_shop_generic_01_0;location_shop_generic_01_1"},
				{name="ArmySurplusTools", min=0, max=99, weightChance=100},
				{name="ArmySurplusWater", min=0, max=1, weightChance=100},
				{name="CampingStoreGear", min=0, max=2, weightChance=60},
				{name="ClothingStorageWinter", min=0, max=2, weightChance=60},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="ArmySurplusBackpacks", min=0, max=1, weightChance=60},
				{name="ArmySurplusFootwear", min=0, max=1, weightChance=60},
				{name="ArmySurplusHeadwear", min=0, max=1, weightChance=40},
				{name="ArmySurplusLiterature", min=0, max=1, weightChance=100},
				{name="ArmySurplusMisc", min=0, max=1, weightChance=100},
				{name="ArmySurplusOutfit", min=0, max=1, weightChance=80},
				{name="ArmySurplusWater", min=0, max=1, weightChance=100},
			}
		},
		tent = {
			rolls = 1,
			items = {
				
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
	},
	
	armytent = {
		locker = {
			procedural = true,
			procList = {
				{name="LockerArmyBedroom", min=0, max=99},
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="ArmyStorageOutfit", min=0, max=1, weightChance=10},
				{name="ArmyStorageElectronics", min=0, max=1, weightChance=10},
				{name="CrateHumanitarian", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="ArmyStorageOutfit", min=0, max=1, weightChance=10},
				{name="ArmyStorageElectronics", min=0, max=1, weightChance=10},
				{name="CrateHumanitarian", min=0, max=99, weightChance=100},
			}
		},
		militarycrate = {
			procedural = true,
			procList = {
				{name="ArmyStorageGuns", min=0, max=99, weightChance=10},
				{name="ArmyStorageAmmunition", min=0, max=99, weightChance=20},
				{name="ArmyStorageMedical", min=0, max=99, weightChance=40},
				{name="ArmyStorageOutfit", min=0, max=99, weightChance=60},
				{name="ArmyStorageElectronics", min=0, max=99, weightChance=100},
			}
		},
		militarylocker = {
			procedural = true,
			procList = {
				{name="ArmyStorageGuns", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="ArmyStorageOutfit", min=0, max=1, weightChance=10},
				{name="ArmyStorageElectronics", min=0, max=1, weightChance=10},
				{name="CrateHumanitarian", min=0, max=99, weightChance=100},
			}
		},
	},
	
	artstore = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="ArtStoreLiterature", min=1, max=2, weightChance=100},
				{name="ArtStoreOther", min=0, max=99, weightChance=20},
				{name="StoreCounterBagsFancy", min=0, max=1, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="ArtStoreLiterature", min=1, max=99, weightChance=40},
				{name="ArtStoreOther", min=0, max=99, weightChance=20},
				{name="ArtStorePaper", min=1, max=99, weightChance=60},
				{name="ArtStorePottery", min=1, max=99, weightChance=20},
				{name="ArtStorePen", min=1, max=99, weightChance=80},
				{name="StoreShelfCombo", min=0, max=99, forceForTiles="location_shop_generic_01_0;location_shop_generic_01_1"},
			}
		},
	},
	
	backstage = {
		clothingrack = {
			procedural = true,
			procList = {
				{name="BackstageClothingRack", min=0, max=99},
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="BackstageLockers", min=0, max=99, weightChance=20},
				{name="BackstageRigging", min=0, max=99, weightChance=100},
				{name="CrateSalonSupplies", min=0, max=2, weightChance=40},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="BackstageCounter", min=0, max=99},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="BackstageFridge", min=0, max=99},
			}
		},
		dresser = {
			procedural = true,
			procList = {
				{name="BackstageDresser", min=0, max=99},
			}
		},
		locker = {
			procedural = true,
			procList = {
				{name="BackstageLockers", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="BackstageRigging", min=0, max=99},
			}
		},
	},
	
	bakery = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="StoreCounterBagsFancy", min=0, max=1, weightChance=100},
			}
		},
		displaycasebakery = {
			procedural = true,
			procList = {
				{name="BakeryBread", min=1, max=99, weightChance=40},
				{name="BakeryCake", min=1, max=99, weightChance=60},
				{name="BakeryDoughnuts", min=1, max=99, weightChance=80},
				{name="BakeryMisc", min=1, max=99, weightChance=100},
				{name="BakeryPie", min=1, max=99, weightChance=80},
			}
		},
		grocerstand = {
			procedural = true,
			procList = {
				{name="BakeryBread", min=1, max=99, weightChance=40},
				{name="BakeryCake", min=1, max=99, weightChance=60},
				{name="BakeryDoughnuts", min=1, max=99, weightChance=80},
				{name="BakeryMisc", min=1, max=99, weightChance=100},
				{name="BakeryPie", min=1, max=99, weightChance=80},
			}
		},
		restaurantdisplay = {
			procedural = true,
			procList = {
				{name="BakeryBread", min=1, max=99, weightChance=40},
				{name="BakeryCake", min=1, max=99, weightChance=60},
				{name="BakeryDoughnuts", min=1, max=99, weightChance=80},
				{name="BakeryMisc", min=1, max=99, weightChance=100},
				{name="BakeryPie", min=1, max=99, weightChance=80},
			}
		},
	},
	
	bakerykitchen = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="BakeryKitchenBaking", min=0, max=4, weightChance=100},
				{name="BakeryKitchenCutlery", min=0, max=99, weightChance=20},
				{name="BakeryKitchenTrays", min=0, max=99, weightChance=20},
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="BakeryKitchenStorage", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="BakeryKitchenStorage", min=0, max=99},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="BakeryKitchenFreezer", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="BakeryKitchenFridge", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="BakeryKitchenStorage", min=0, max=99},
			}
		},
		restaurantdisplay = {
			procedural = true,
			procList = {
				{name="BakeryBread", min=1, max=99, weightChance=40},
				{name="BakeryCake", min=1, max=99, weightChance=60},
				{name="BakeryDoughnuts", min=1, max=99, weightChance=80},
				{name="BakeryMisc", min=1, max=99, weightChance=100},
				{name="BakeryPie", min=1, max=99, weightChance=80},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="BakeryKitchenStorage", min=0, max=99},
			}
		},
	},
	
	bandkitchen = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="BarShelfLiquor", min=0, max=99, weightChance=100},
				{name="StoreShelfSnacks", min=0, max=99, weightChance=100},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="BandPracticeFridge", min=0, max=99, weightChance=100},
			}
		},
		overhead = {
			procedural = true,
			procList = {
				{name="BarShelfLiquor", min=0, max=99, weightChance=100},
				{name="StoreShelfSnacks", min=0, max=99, weightChance=100},
			}
		}
	},
	
	bandlivingroom = {
		isShop = true,
		locker = {
			procedural = true,
			procList = {
				{name="BandPracticeClothing", min=0, max=99, weightChance=100},
			}
		},
	},
	
	bandmerch = {
		isShop = true,
		clothingrack = {
			procedural = true,
			procList = {
				{name="BandMerchClothes", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="BandMerchClothes", min=0, max=99, weightChance=100},
				{name="BandMerchShelves", min=0, max=99, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="BandMerchShelves", min=0, max=99},
			}
		},
	},
	
	bar = {
		isShop = true,
		bin = {
			isTrash = true,
			procedural = true,
			procList = {
				{name="BinBar", min=0, max=99},
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateCigarettes", min=0, max=1, weightChance=1},
				{name="BarCrateDarts", min=0, max=1, weightChance=10},
				{name="BarCratePool", min=0, max=1, weightChance=10},
				{name="CrateChips", min=0, max=1, weightChance=40},
				{name="CratePeanuts", min=0, max=1, weightChance=40},
				{name="BarShelfLiquor", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="BarCounterWeapon", min=0, max=1, weightChance=20},
				{name="BarCounterLiquor", min=0, max=2, weightChance=40},
				{name="BarCounterMisc", min=0, max=2, weightChance=60},
				{name="BarCounterGlasses", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateCigarettes", min=0, max=1, weightChance=1},
				{name="BarCrateDarts", min=0, max=1, weightChance=10},
				{name="BarCratePool", min=0, max=1, weightChance=10},
				{name="CrateChips", min=0, max=1, weightChance=40},
				{name="CratePeanuts", min=0, max=1, weightChance=40},
				{name="BarShelfLiquor", min=0, max=99, weightChance=100},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeBeer", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="BarShelfLiquor", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="BarShelfLiquor", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateCigarettes", min=0, max=1, weightChance=1},
				{name="BarCrateDarts", min=0, max=1, weightChance=10},
				{name="BarCratePool", min=0, max=1, weightChance=10},
				{name="CrateChips", min=0, max=1, weightChance=40},
				{name="CratePeanuts", min=0, max=1, weightChance=40},
				{name="BarShelfLiquor", min=0, max=99, weightChance=100},
			}
		},
	},
	
	barbecuestore = {
		isShop = true,
		barbecue = {
			rolls = 1,
			items = {
				
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateCharcoal", min=0, max=99, weightChance=40},
				{name="CratePropane", min=0, max=99, weightChance=40},
				{name="GrillStoreBlackBBQ", min=0, max=99, weightChance=100},
				{name="GrillStoreRedBBQ", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="GrillAcessories", min=0, max=99, weightChance=20},
				{name="StoreCounterBags", min=0, max=1, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateCharcoal", min=0, max=99, weightChance=40},
				{name="CratePropane", min=0, max=99, weightChance=40},
				{name="GrillStoreBlackBBQ", min=0, max=99, weightChance=100},
				{name="GrillStoreRedBBQ", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateCharcoal", min=0, max=99, weightChance=100},
				{name="CratePropane", min=0, max=99, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="GrillAcessories", min=0, max=99, weightChance=100},
				{name="CrateCharcoal", min=0, max=99, weightChance=40},
				{name="CratePropane", min=0, max=99, weightChance=40},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateCharcoal", min=0, max=99, weightChance=100},
				{name="GrillAcessories", min=0, max=99, weightChance=100},
			}
		},
	},
	
	barcounter = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="BarCounterWeapon", min=0, max=1, weightChance=20},
				{name="BarCounterLiquor", min=0, max=2, weightChance=40},
				{name="BarCounterMisc", min=0, max=2, weightChance=60},
				{name="BarCounterGlasses", min=0, max=99, weightChance=100},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeBeer", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="BarShelfLiquor", min=0, max=99},
			}
		},
	},
	
	barcountertwiggy = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="BarCounterWeapon", min=0, max=1, weightChance=20},
				{name="BarCounterLiquor", min=0, max=2, weightChance=40},
				{name="BarCounterMisc", min=0, max=2, weightChance=60},
				{name="BarCounterGlasses", min=0, max=99, weightChance=100},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeBeer", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="BarShelfLiquor", min=0, max=99},
			}
		},
	},
	
	barkitchen = {
		isShop = true,
		bin = {
			isTrash = true,
			procedural = true,
			procList = {
				{name="BinBar", min=0, max=99},
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateCigarettes", min=0, max=1, weightChance=1},
				{name="BarCrateDarts", min=0, max=1, weightChance=10},
				{name="BarCratePool", min=0, max=1, weightChance=10},
				{name="CrateChips", min=0, max=1, weightChance=40},
				{name="CratePeanuts", min=0, max=1, weightChance=40},
				{name="BarShelfLiquor", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="BarCounterWeapon", min=0, max=1, weightChance=20},
				{name="BarCounterLiquor", min=0, max=2, weightChance=40},
				{name="BarCounterMisc", min=0, max=2, weightChance=60},
				{name="BarCounterGlasses", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateCigarettes", min=0, max=1, weightChance=1},
				{name="BarCrateDarts", min=0, max=1, weightChance=10},
				{name="BarCratePool", min=0, max=1, weightChance=10},
				{name="CrateChips", min=0, max=1, weightChance=40},
				{name="CratePeanuts", min=0, max=1, weightChance=40},
				{name="BarShelfLiquor", min=0, max=99, weightChance=100},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeBeer", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="BarShelfLiquor", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="BarShelfLiquor", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateCigarettes", min=0, max=1, weightChance=1},
				{name="BarCrateDarts", min=0, max=1, weightChance=10},
				{name="BarCratePool", min=0, max=1, weightChance=10},
				{name="CrateChips", min=0, max=1, weightChance=40},
				{name="CratePeanuts", min=0, max=1, weightChance=40},
				{name="BarShelfLiquor", min=0, max=99, weightChance=100},
			}
		},
	},
	
	barstorage = {
		isShop = true,
		bin = {
			isTrash = true,
			procedural = true,
			procList = {
				{name="BinBar", min=0, max=99},
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateCigarettes", min=0, max=1, weightChance=1},
				{name="BarCrateDarts", min=0, max=1, weightChance=10},
				{name="BarCratePool", min=0, max=1, weightChance=10},
				{name="CrateChips", min=0, max=1, weightChance=40},
				{name="CratePeanuts", min=0, max=1, weightChance=40},
				{name="BarShelfLiquor", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="BarCounterMisc", min=0, max=99, weightChance=50},
				{name="BarCounterWeapon", min=0, max=1, weightChance=20},
				{name="BarCounterLiquor", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateCigarettes", min=0, max=1, weightChance=1},
				{name="BarCrateDarts", min=0, max=1, weightChance=10},
				{name="BarCratePool", min=0, max=1, weightChance=10},
				{name="CrateChips", min=0, max=1, weightChance=40},
				{name="CratePeanuts", min=0, max=1, weightChance=40},
				{name="BarShelfLiquor", min=0, max=99, weightChance=100},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeBeer", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="BarShelfLiquor", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="BarShelfLiquor", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateCigarettes", min=0, max=1, weightChance=1},
				{name="BarCrateDarts", min=0, max=1, weightChance=10},
				{name="BarCratePool", min=0, max=1, weightChance=10},
				{name="CrateChips", min=0, max=1, weightChance=40},
				{name="CratePeanuts", min=0, max=1, weightChance=40},
				{name="BarShelfLiquor", min=0, max=99, weightChance=100},
			}
		},
	},
	
	barn = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="BarnTools", min=0, max=99, weightChance=40},
				{name="CrateAnimalFeed", min=0, max=99, weightChance=100},
				{name="CrateFarming", min=0, max=1, weightChance=10},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="BarnTools", min=0, max=99, weightChance=40},
				{name="CrateAnimalFeed", min=0, max=99, weightChance=100},
				{name="CrateFarming", min=0, max=1, weightChance=10},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="BarnTools", min=0, max=99, weightChance=40},
				{name="CrateAnimalFeed", min=0, max=99, weightChance=100},
				{name="CrateFarming", min=0, max=1, weightChance=10},
			}
		},
	},
	
	baseballstore = {
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreCounterBagsFancy", min=0, max=1, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="BaseballStoreShelves", min=0, max=99, weightChance=100},
			}
		}
	},
	
	baseballstorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateBaseballs", min=0, max=99, weightChance=100},
				{name="SportStorageBats", min=0, max=1, weightChance=20},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateBaseballs", min=0, max=99, weightChance=100},
				{name="SportStorageBats", min=0, max=1, weightChance=20},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="SportStorageBats", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateBaseballs", min=0, max=99, weightChance=100},
				{name="SportStorageBats", min=0, max=1, weightChance=20},
			}
		},
	},
	
	baseballgiftstorage = {
		crate = {
			procedural = true,
			procList = {
				{name="CrateBaseballs", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="BaseballStoreShelves", min=0, max=99},
			}
		},
	},
	
	batfactory = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="BatFactoryBats", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="BatFactoryBats", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="BatFactoryBats", min=0, max=99, weightChance=100},
				{name="CrateCarpentry", min=0, max=99, weightChance=40},
			}
		},
	},
	
	bathroom = {
		bin = {
			procedural = true,
			procList = {
				{name="BinBathroom", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="BathroomCounter", min=0, max=99},
				{name="BathroomCounterEmpty", min=0, max=99, forceForRooms="armysurplus;bank;bar;breakroom;church;classroom;daycare;factory;fitness;firestorage;grocery;gym;meetingroom;metalshop;policestorage;spiffoskitchen;restaurant;restaurantkitchen"},
				{name="BathroomCounterMotel", min=0, max=99, forceForRooms="motelroom"},
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateBooks", min=0, max=1, weightChance=40},
				{name="CrateLinens", min=0, max=1, weightChance=40},
				{name="CrateMagazines", min=0, max=1, weightChance=100},
				{name="CrateNewspapers", min=0, max=1, weightChance=40},
				{name="CrateToiletPaper", min=0, max=1, weightChance=10},
				{name="GymTowels", min=0, max=1, weightChance=60},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateBooks", min=0, max=1, weightChance=40},
				{name="CrateLinens", min=0, max=1, weightChance=40},
				{name="CrateMagazines", min=0, max=1, weightChance=100},
				{name="CrateNewspapers", min=0, max=1, weightChance=40},
				{name="CrateToiletPaper", min=0, max=1, weightChance=10},
				{name="GymTowels", min=0, max=1, weightChance=60},
			}
		},
		locker = {
			procedural = true,
			procList = {
				{name="FactoryLockers", min=0, max=99, forceForRooms="batteryfactory;brewery;cabinetfactory;dogfoodfactory;factory;fryshipping;metalshop;radiofactory;warehouse;wirefactory;whiskeybottling"},
				{name="FireDeptLockers", min=0, max=99, forceForRooms="firestorage"},
				{name="GymLockers", min=0, max=99, forceForRooms="fitness;gym"},
				{name="HospitalLockers", min=0, max=99, forceForRooms="hospitalroom;hospitalhallway;hospitalstorage"},
				{name="PoliceLockers", min=0, max=99, forceForRooms="policestorage"},
				{name="PrisonGuardLockers", min=0, max=99, forceForRooms="cells"},
			}
		},
		medicine = {
			procedural = true,
			procList = {
				{name="BathroomCabinet", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="JanitorTools", min=1, max=1, weightChance=100},
				{name="JanitorCleaning", min=1, max=1, weightChance=100},
				{name="JanitorChemicals", min=0, max=99, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="BathroomShelf", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateBooks", min=0, max=1, weightChance=40},
				{name="CrateLinens", min=0, max=1, weightChance=40},
				{name="CrateMagazines", min=0, max=1, weightChance=100},
				{name="CrateNewspapers", min=0, max=1, weightChance=40},
				{name="CrateToiletPaper", min=0, max=1, weightChance=10},
				{name="GymTowels", min=0, max=1, weightChance=60},
			}
		},
	},
	
	batstorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="BatFactoryBats", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="BatFactoryBats", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="BatFactoryBats", min=0, max=99},
			}
		},
	},
	
	batteryfactory = {
		isShop = true,
		counter = {
			rolls = 1,
			items = {
				
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateBatteries", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateBatteries", min=0, max=99},
			}
		},
		metal_shelves= {
			procedural = true,
			procList = {
				{name="CrateBatteries", min=0, max=99},
			}
		},
	},
	
	batterystorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateBatteries", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateBatteries", min=0, max=99},
			}
		},
	},
	
	bedroom = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateTools", min=0, max=1, weightChance=1},
				{name="CrateToolsOld", min=0, max=1, weightChance=1},
				{name="CrateCanning", min=0, max=1, weightChance=5},
				{name="CrateFitnessWeights", min=0, max=1, weightChance=5},
				{name="CrateVHSTapes", min=0, max=1, weightChance=10},
				{name="CrateCompactDiscs", min=0, max=1, weightChance=10},
				{name="CrateElectronics", min=0, max=1, weightChance=80},
				{name="CrateInstruments", min=0, max=1, weightChance=20},
				{name="CratePhotos", min=0, max=1, weightChance=20},
				{name="CrateTailoring", min=0, max=1, weightChance=10},
				{name="ClothingStorageWinter", min=0, max=1, weightChance=10},
				{name="CrateFootwearRandom", min=0, max=1, weightChance=10},
				{name="CrateClothesRandom", min=0, max=1, weightChance=10},
				{name="CrateLinens", min=0, max=1, weightChance=40},
				{name="CrateComics", min=0, max=1, weightChance=40},
				{name="CrateBooks", min=0, max=1, weightChance=80},
				{name="CrateMagazines", min=0, max=1, weightChance=80},
				{name="CrateNewspapers", min=0, max=1, weightChance=80},
				{name="CrateRandomJunk", min=0, max=1, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="ClothingStorageWinter", min=0, max=1, weightChance=40},
				{name="CrateBooks", min=0, max=1, weightChance=60},
				{name="CrateCanning", min=0, max=1, weightChance=20},
				{name="CrateClothesRandom", min=0, max=1, weightChance=40},
				{name="CrateComics", min=0, max=1, weightChance=60},
				{name="CrateCompactDiscs", min=0, max=1, weightChance=40},
				{name="CrateElectronics", min=0, max=1, weightChance=80},
				{name="CrateFitnessWeights", min=0, max=1, weightChance=10},
				{name="CrateFootwearRandom", min=0, max=1, weightChance=40},
				{name="CrateInstruments", min=0, max=1, weightChance=20},
				{name="CrateLinens", min=0, max=1, weightChance=40},
				{name="CrateMagazines", min=0, max=1, weightChance=60},
				{name="CrateNewspapers", min=0, max=1, weightChance=60},
				{name="CrateRandomJunk", min=0, max=1, weightChance=20},
				{name="CrateTailoring", min=0, max=1, weightChance=80},
				{name="CrateTools", min=0, max=1, weightChance=40},
				{name="CrateToolsOld", min=0, max=1, weightChance=100},
				{name="CrateVHSTapes", min=0, max=1, weightChance=60},
			}
		},
		desk = {
			procedural = true,
			procList = {
				{name="OfficeDeskHome", min=0, max=99, weightChance=100},
				{name="OfficeDeskHomeClassy", min=0, max=99, forceForZones="Rich"},
			}
		},
		dresser = {
			procedural = true,
			procList = {
				{name="BedroomDresser", min=98, max=99, weightChance=100},
				{name="BedroomDresserChild", min=98, max=99, forceForItems="furniture_bedding_01_36;furniture_bedding_01_38"},
				{name="BedroomDresserClassy", min=98, max=99, forceForZones="Rich"},
				{name="BedroomDresserRedneck", min=98, max=99, forceForZones="TrailerPark"},
			}
		},
		locker = {
			procedural = true,
			procList = {
				{name="CultistClothing", min=0, max=99, forceForZones="Cultists"},
			}
		},
		plankstash = {
			procedural = true,
			procList = {
				{name="PlankStashMagazine", min=0, max=99, weightChance=80},
				{name="PlankStashMisc", min=0, max=99, weightChance=20},
				{name="PlankStashMoney", min=0, max=99, weightChance=10},
				{name="PlankStashGold", min=0, max=99, weightChance=1},
				{name="PlankStashGun", min=0, max=99, weightChance=100},
			}
		},
		sidetable = {
			procedural = true,
			procList = {
				{name="BedroomSidetable", min=98, max=99, weightChance=100},
				{name="BedroomSidetableChild", min=98, max=99, forceForItems="furniture_bedding_01_36;furniture_bedding_01_38"},
				{name="BedroomSidetableClassy", min=98, max=99, forceForZones="Rich"},
				{name="BedroomSidetableRedneck", min=98, max=99, forceForZones="TrailerPark"},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateBooks", min=0, max=1, weightChance=100},
				{name="CrateClothesRandom", min=0, max=1, weightChance=20},
				{name="CrateComics", min=0, max=1, weightChance=80},
				{name="CrateCompactDiscs", min=0, max=1, weightChance=80},
				{name="CrateElectronics", min=0, max=1, weightChance=20},
				{name="CrateFootwearRandom", min=0, max=1, weightChance=20},
				{name="CrateLinens", min=0, max=1, weightChance=40},
				{name="CrateMagazines", min=0, max=1, weightChance=100},
				{name="CrateNewspapers", min=0, max=1, weightChance=80},
				{name="CratePhotos", min=0, max=1, weightChance=20},
				{name="CrateTailoring", min=0, max=1, weightChance=40},
				{name="CrateVHSTapes", min=0, max=1, weightChance=100},
			}
		},
		wardrobe = {
			procedural = true,
			procList = {
				-- Search entire room for listed sprites. If found, force container to spawn.
				{name="WardrobeChild", min=98, max=99, forceForItems="furniture_bedding_01_36;furniture_bedding_01_38;furniture_seating_indoor_02_12;furniture_seating_indoor_02_13;furniture_seating_indoor_02_14;furniture_seating_indoor_02_15;walls_decoration_01_50;walls_decoration_01_51;location_community_school_01_62;location_community_school_01_63;floors_rugs_01_63;floors_rugs_01_64;floors_rugs_01_65;floors_rugs_01_66;floors_rugs_01_67;floors_rugs_01_68;floors_rugs_01_69;floors_rugs_01_70;floors_rugs_01_71"},
				{name="WardrobeClassy", min=98, max=99, forceForZones="Rich"},
				{name="WardrobeGeneric", min=98, max=99, weightChance=100},
				{name="WardrobeRedneck", min=98, max=99, forceForZones="TrailerPark"},
			}
		}
	},
	
	beergarden = {
		isShop = true,
		bin = {
			isTrash = true,
			rolls = 4,
			items = {
				"BeerEmpty", 20,
				"BeerEmpty", 10,
				"BeerCanEmpty", 20,
				"BeerCanEmpty", 10,
				"PlasticCup", 50,
				"PlasticCup", 20,
			},
			junk = ClutterTables.BinJunk,
		},
		counter = {
			procedural = true,
			procList = {
				{name="BeerGardenCounter", min=0, max=99},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeBeer", min=0, max=99},
			}
		},
	},
	
	bookstore = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="BookstoreBooks", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="BookStoreCounter", min=1, max=1, weightChance=100},
				{name="BookstoreBags", min=0, max=1, weightChance=100},
				{name="BookstoreStationery", min=0, max=99, weightChance=20},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="BookstoreBooks", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="BookstoreArt", min=0, max=1, weightChance=40},
				{name="BookstoreAutomotive", min=1, max=1, weightChance=100}, -- set up for skill books, recipe magazines and subject magazines to spawn together
				{name="BookstoreBiography", min=0, max=1, weightChance=60},
				{name="BookstoreBlueCollar", min=1, max=1, weightChance=100}, -- set up for skill books, recipe magazines and subject magazines to spawn together
-- 				{name="BookstoreBooks", min=1, max=99, weightChance=20}, -- not sure what to do re this, in that they are in thematic containers now as well, but I don't hate having it as a backup for now :D
				{name="BookstoreBusiness", min=0, max=1, weightChance=40},
				{name="BookstoreChilds", min=0, max=1, weightChance=80},
				{name="BookstoreCinema", min=0, max=1, weightChance=40},
				{name="BookstoreComputer", min=0, max=1, weightChance=40},
				{name="BookstoreCooking", min=1, max=1, weightChance=100}, -- set up for skill books, recipe magazines and subject magazines to spawn together
				{name="BookstoreCrafts", min=1, max=1, weightChance=100}, -- set up for skill books, recipe magazines and subject magazines to spawn together
				{name="BookstoreCrimeFiction", min=0, max=1, weightChance=60},
				{name="BookstoreFantasySciFi", min=1, max=1, weightChance=100},
				{name="BookstoreFashion", min=1, max=1, weightChance=100}, -- set up for skill books, recipe magazines and subject magazines to spawn together
				{name="BookstoreFarming", min=1, max=1, weightChance=100}, -- set up for skill books, recipe magazines and subject magazines to spawn together; changed so outdoors can serve hunting/fishing type concerns
				{name="BookstoreGeneralReference", min=0, max=1, weightChance=60},
				{name="BookstoreHistory", min=0, max=1, weightChance=60},
				{name="BookstoreHobbies", min=0, max=1, weightChance=40},
				{name="BookstoreHorror", min=0, max=1, weightChance=80},
				{name="BookstoreLegal", min=0, max=1, weightChance=40},
				{name="BookstoreLiteraryFiction", min=1, max=1, weightChance=100},
				{name="BookstoreMedical", min=1, max=1, weightChance=100},
				{name="BookstoreMilitaryHistory", min=0, max=1, weightChance=40},
				{name="BookstoreMusic", min=0, max=1, weightChance=60},
				{name="BookstoreNewAge", min=0, max=1, weightChance=40},
				{name="BookstoreNonFiction", min=1, max=1, weightChance=100},
				{name="BookstoreOccult", min=0, max=1, weightChance=10},
				{name="BookstoreOutdoors", min=1, max=1, weightChance=100}, -- set up for skill books, recipe magazines and subject magazines to spawn together; changed for a hunting/farming focus vs a farming specific one
				{name="BookstorePhilosophy", min=0, max=1, weightChance=40},
				{name="BookstorePolitics", min=0, max=1, weightChance=40},
				{name="BookstoreReligion", min=0, max=1, weightChance=40},
				{name="BookstoreRomance", min=0, max=1, weightChance=80},
				{name="BookstoreSchoolTextbook", min=0, max=1, weightChance=20},
				{name="BookstoreScience", min=0, max=1, weightChance=40},
				{name="BookstorePersonal", min=0, max=1, weightChance=100},
				{name="BookstoreSports", min=0, max=1, weightChance=60},
				{name="BookstoreThriller", min=0, max=1, weightChance=80},
				{name="BookstoreTravel", min=0, max=1, weightChance=40},
				{name="BookstoreWestern", min=0, max=1, weightChance=40},
				{name="BookstoreMisc", min=0, max=2, weightChance=10},
				{name="StoreShelfCombo", min=0, max=99, forceForTiles="location_shop_generic_01_0;location_shop_generic_01_1"},
			}
		},
		sidetable = { -- this is needed as bookstore on the map have sidetables on them as decor
			rolls = 1,
			items = {
			},
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="BookstoreBooks", min=0, max=99},
			}
		},
	},
	
	bowlingalley = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="BowlingAlleyPins", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="BowlingAlleyLockers", min=0, max=99, weightChance=100},
				{name="BowlingAlleyShoes", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="BowlingAlleyPins", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="BowlingAlleyShoes", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="BowlingAlleyPins", min=0, max=99},
			}
		},
	},
	
	boxing = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateBasketballs", min=1, max=2, weightChance=40},
				{name="CrateFoldingChairs", min=0, max=1, weightChance=20},
			}
		},
		displaycase = {
			procedural = true,
			procList = {
				{name="BoxingMemorabilia", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="BoxingStorageGloves", min=0, max=99, weightChance=100},
				{name="BoxingStorageHelmets", min=0, max=99, weightChance=100},
			}
		},
	},
	
	breakroom = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateOfficeSupplies", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="BreakRoomCounter", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateOfficeSupplies", min=0, max=99},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeBreakRoom", min=0, max=99},
			}
		},
		overhead = {
			procedural = true,
			procList = {
				{name="BreakRoomCounter", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="BreakRoomShelves", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateOfficeSupplies", min=0, max=99},
			}
		},
	},
	
	brewery = {
		isShop = true,
		counter = {
			rolls = 1,
			items = {
				
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="BreweryBottles", min=0, max=99, weightChance=20},
				{name="BreweryCans", min=0, max=99, weightChance=20},
				{name="BreweryHops", min=0, max=99, weightChance=60},
				{name="BreweryEmptyBottles", min=0, max=99, weightChance=80},
				{name="BreweryEmptyCans", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="BreweryBottles", min=0, max=99, weightChance=20},
				{name="BreweryCans", min=0, max=99, weightChance=20},
				{name="BreweryHops", min=0, max=99, weightChance=60},
				{name="BreweryEmptyBottles", min=0, max=99, weightChance=80},
				{name="BreweryEmptyCans", min=0, max=99, weightChance=100},
			}
		},
		clothingdryerbasic = {
			procedural = true,
			procList = {
				{name="BreweryEmptyBottles", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="BreweryBottles", min=0, max=99, weightChance=100},
				{name="BreweryCans", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="BreweryBottles", min=0, max=99, weightChance=20},
				{name="BreweryCans", min=0, max=99, weightChance=20},
				{name="BreweryHops", min=0, max=99, weightChance=60},
				{name="BreweryEmptyBottles", min=0, max=99, weightChance=80},
				{name="BreweryEmptyCans", min=0, max=99, weightChance=100},
			}
		},
	},
	
	brewerystorage = {
		isShop = true,
		counter = {
			rolls = 1,
			items = {
				
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="BreweryBottles", min=0, max=99, weightChance=100},
				{name="BreweryCans", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="BreweryBottles", min=0, max=99, weightChance=100},
				{name="BreweryCans", min=0, max=99, weightChance=100},
			}
		},
		clothingdryerbasic = {
			procedural = true,
			procList = {
				{name="BreweryEmptyBottles", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="BreweryBottles", min=0, max=99, weightChance=100},
				{name="BreweryCans", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="BreweryBottles", min=0, max=99, weightChance=100},
				{name="BreweryCans", min=0, max=99, weightChance=100},
			}
		},
	},
	
	burgerkitchen = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="BurgerKitchenButcher", min=1, max=2, weightChance=80},
				{name="BurgerKitchenSauce", min=0, max=4, weightChance=40},
				{name="BurgerKitchenCutlery", min=0, max=99, weightChance=10},
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateBunsBurger", min=0, max=2, weightChance=100},
				{name="CrateCondiments", min=0, max=1, weightChance=100},
				{name="CrateOilVegetable", min=0, max=1, weightChance=20},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateBunsBurger", min=0, max=2, weightChance=100},
				{name="CrateCondiments", min=0, max=1, weightChance=100},
				{name="CrateOilVegetable", min=0, max=1, weightChance=20},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="BurgerKitchenFreezer", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="BurgerKitchenFridge", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateBunsBurger", min=0, max=2, weightChance=100},
				{name="CrateCondiments", min=0, max=1, weightChance=100},
				{name="CrateOilVegetable", min=0, max=1, weightChance=20},
			}
		},
		restaurantdisplay = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="ServingTrayBurgers", min=1, max=99, weightChance=80},
				{name="ServingTrayFries", min=1, max=99, weightChance=100},
				{name="ServingTrayOnionRings", min=1, max=99, weightChance=40},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateBunsBurger", min=0, max=2, weightChance=100},
				{name="CrateCondiments", min=0, max=1, weightChance=100},
				{name="CrateOilVegetable", min=0, max=1, weightChance=20},
			}
		},
		stove = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="StoveSpiffos", min=1, max=99, forceForTiles="appliances_cooking_20;appliances_cooking_21;appliances_cooking_22;appliances_cooking_23;appliances_cooking_24"},
			}
		},
	},
	
	burgerkitchenstorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateBunsBurger", min=0, max=2, weightChance=100},
				{name="CrateCondiments", min=0, max=1, weightChance=100},
				{name="CrateOilVegetable", min=0, max=1, weightChance=20},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateBunsBurger", min=0, max=2, weightChance=100},
				{name="CrateCondiments", min=0, max=1, weightChance=100},
				{name="CrateOilVegetable", min=0, max=1, weightChance=20},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="BurgerKitchenFreezer", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="BurgerKitchenFridge", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateBunsBurger", min=0, max=2, weightChance=100},
				{name="CrateCondiments", min=0, max=1, weightChance=100},
				{name="CrateOilVegetable", min=0, max=1, weightChance=20},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateBunsBurger", min=0, max=2, weightChance=100},
				{name="CrateCondiments", min=0, max=1, weightChance=100},
				{name="CrateOilVegetable", min=0, max=1, weightChance=20},
			}
		},
	},
	
	butcher = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="ButcherSnacks", min=0, max=99, weightChance=40},
				{name="ButcherSpices", min=0, max=99, weightChance=40},
				{name="ButcherTools", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="ButcherTools", min=0, max=99, weightChance=100},
				{name="StoreCounterBags", min=0, max=1, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="ButcherSnacks", min=0, max=99, weightChance=40},
				{name="ButcherSpices", min=0, max=99, weightChance=40},
				{name="ButcherTools", min=0, max=99, weightChance=100},
			}
		},
		displaycasebutcher = {
			procedural = true,
			procList = {
				{name="ButcherChops", min=1, max=99, weightChance=100},
				{name="ButcherGround", min=1, max=99, weightChance=60},
				{name="ButcherChicken", min=1, max=99, weightChance=80},
				{name="ButcherSmoked", min=1, max=99, weightChance=40},
				{name="ButcherFish", min=1, max=99, weightChance=20},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="ButcherFreezer", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="ButcherFreezer", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="ButcherTools", min=0, max=99, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="ButcherLiterature", min=0, max=99, weightChance=80},
				{name="ButcherSnacks", min=0, max=99, weightChance=40},
				{name="ButcherSpices", min=0, max=99, weightChance=40},
				{name="GrillAcessories", min=0, max=99, weightChance=100},
				{name="StoreShelfCombo", min=0, max=99, forceForTiles="location_shop_generic_01_0;location_shop_generic_01_1"},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="ButcherSnacks", min=0, max=99, weightChance=40},
				{name="ButcherSpices", min=0, max=99, weightChance=40},
				{name="ButcherTools", min=0, max=99, weightChance=100},
			}
		},
	},
	
	cabinetfactory = {
		counter = {
			rolls = 1,
			items = {
				
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CabinetFactoryTools", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CabinetFactoryTools", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CabinetFactoryTools", min=0, max=4, weightChance=60},
				{name="CrateLumber", min=0, max=99, weightChance=100},
			}
		},
		overhead = {
			rolls = 1,
			items = {
				
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CabinetFactoryTools", min=0, max=99},
			}
		},
	},
	
	cabinetshipping = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CabinetFactoryTools", min=0, max=99},
			}
		},
		counter = {
			rolls = 1,
			items = {
				
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CabinetFactoryTools", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CabinetFactoryTools", min=0, max=99},
			}
		},
		overhead = {
			rolls = 1,
			items = {
				
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CabinetFactoryTools", min=0, max=99},
			}
		},
	},
	
	cafe = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateCoffee", min=0, max=1, weightChance=100},
				{name="CrateTea", min=0, max=1, weightChance=100},
				{name="CrateSugar", min=0, max=1, weightChance=80},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="CafeKitchenMugs", min=0, max=99, forceForTiles="appliances_cooking_01_56;appliances_cooking_01_57;appliances_cooking_01_58;appliances_cooking_01_59;appliances_cooking_01_60;appliances_cooking_01_61;appliances_cooking_01_62;appliances_cooking_01_63"},
				{name="CafeKitchenSupplies", min=0, max=1, weightChance=10},
				{name="CafeCounterMix", min=0, max=4, weightChance=20},
				{name="CafeKitchenMugs", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateEspressoMachine", min=0, max=1, weightChance=1},
				{name="CafeKitchenSupplies", min=1, max=4, weightChance=40},
				{name="CafeKitchenMugs", min=0, max=99, weightChance=100},
			}
		},
		displaycasebakery = {
			procedural = true,
			procList = {
				{name="BakeryDoughnuts", min=1, max=4, weightChance=20},
				{name="BakeryMisc", min=0, max=99, weightChance=100},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="FreezerIceCream", min=0, max=99, forceForTiles="appliances_refrigeration_01_20;appliances_refrigeration_01_21;appliances_refrigeration_01_38;appliances_refrigeration_01_39"},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="CafeDiningFridge", min=0, max=99},
			}
		},
		grocerstand = {
			procedural = true,
			procList = {
				{name="BakeryMisc", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CafeKitchenSupplies", min=0, max=2, weightChance=20},sa
			}
		},
		restaurantdisplay = {
			procedural = true,
			procList = {
				{name="BakeryDoughnuts", min=1, max=4, weightChance=20},
				{name="BakeryMisc", min=0, max=99, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="CafeShelfBooks", min=0, max=99, forceForTiles="furniture_shelving_01_40;furniture_shelving_01_41;furniture_shelving_01_42;furniture_shelving_01_43;furniture_shelving_01_44;furniture_shelving_01_45;furniture_shelving_01_46;furniture_shelving_01_47"},
				{name="BakeryMisc", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CafeKitchenSupplies", min=1, max=4, weightChance=40},
				{name="CafeKitchenMugs", min=0, max=99, weightChance=100},
			}
		},
	},
	
	cafekitchen = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateEspressoMachine", min=0, max=1, weightChance=1},
				{name="CafeKitchenSupplies", min=1, max=4, weightChance=40},
				{name="CafeKitchenMugs", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="CafeKitchenMugs", min=0, max=99, forceForTiles="appliances_cooking_01_56;appliances_cooking_01_57;appliances_cooking_01_58;appliances_cooking_01_59;appliances_cooking_01_60;appliances_cooking_01_61;appliances_cooking_01_62;appliances_cooking_01_63"},
				{name="CafeKitchenTea", min=0, max=2, weightChance=60},
				{name="CafeKitchenCoffee", min=0, max=4, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateEspressoMachine", min=0, max=1, weightChance=1},
				{name="CafeKitchenSupplies", min=1, max=4, weightChance=40},
				{name="CafeKitchenMugs", min=0, max=99, weightChance=100},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="FreezerIceCream", min=0, max=99, forceForTiles="appliances_refrigeration_01_20;appliances_refrigeration_01_21;appliances_refrigeration_01_38;appliances_refrigeration_01_39"},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="CafeKitchenFridge", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CafeKitchenSupplies", min=0, max=2, weightChance=20},
			}
		},
		restaurantdisplay = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="BakeryDoughnuts", min=1, max=2, weightChance=20},
				{name="BakeryMisc", min=0, max=99, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="CafeKitchenSupplies", min=0, max=2, weightChance=20},
				{name="CafeKitchenMugs", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CafeKitchenSupplies", min=1, max=4, weightChance=40},
				{name="CafeKitchenMugs", min=0, max=99, weightChance=100},
			}
		},
	},
	
	cafeteria = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="CafeteriaTrays", min=0, max=99, weightChance=100},
			}
		},
		displaycasebakery = {
			procedural = true,
			procList = {
				{name="CafeteriaSandwiches", min=1, max=99, weightChance=40},
				{name="CafeteriaSnacks", min=1, max=99, weightChance=100},
				{name="CafeteriaDrinks", min=1, max=99, weightChance=80},
				{name="CafeteriaFruit", min=1, max=99, weightChance=60},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateButter", min=0, max=1, weightChance=100},
				{name="CrateCereal", min=0, max=1, weightChance=100},
				{name="CrateCrackers", min=0, max=1, weightChance=100},
				{name="CrateFlour", min=0, max=1, weightChance=100},
				{name="CrateGravyMix", min=0, max=1, weightChance=100},
				{name="CrateMapleSyrup", min=0, max=1, weightChance=100},
				{name="CrateMarinara", min=0, max=1, weightChance=100},
				{name="CrateOilVegetable", min=0, max=1, weightChance=100},
				{name="CratePancakeMix", min=0, max=1, weightChance=100},
				{name="CratePasta", min=0, max=1, weightChance=100},
				{name="CrateRice", min=0, max=1, weightChance=100},
				{name="CrateSugar", min=0, max=1, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="StoreShelfDrinks", min=0, max=99, weightChance=100},
				{name="StoreShelfSnacks", min=0, max=99, weightChance=100},
			}
		},
		restaurantdisplay = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="ServingTrayBurgers", min=0, max=1, weightChance=100},
				{name="ServingTrayBurritos", min=0, max=1, weightChance=100},
				{name="ServingTrayChickenNuggets", min=0, max=1, weightChance=100},
				{name="ServingTrayChickenWings", min=0, max=1, weightChance=100},
				{name="ServingTrayFishFingers", min=0, max=1, weightChance=100},
				{name="ServingTrayFries", min=0, max=1, weightChance=60},
				{name="ServingTrayHotdogs", min=0, max=1, weightChance=60},
				{name="ServingTrayOnionRings", min=0, max=1, weightChance=100},
				{name="ServingTrayPizza", min=0, max=1, weightChance=100},
				{name="ServingTrayTatoDots", min=0, max=1, weightChance=100},
			}
		},
	},
	
	cafeteriakitchen = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="StoreKitchenBaking", min=0, max=1, weightChance=100},
				{name="StoreKitchenButcher", min=1, max=1, weightChance=100},
				{name="StoreKitchenCutlery", min=0, max=1, weightChance=20},
				{name="StoreKitchenDishes", min=0, max=1, weightChance=20},
				{name="StoreKitchenGlasses", min=0, max=1, weightChance=20},
				{name="StoreKitchenPotatoes", min=0, max=1, weightChance=100},
				{name="StoreKitchenPots", min=0, max=1, weightChance=20},
				{name="StoreKitchenSauce", min=0, max=1, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="CafeteriaKitchenFreezer", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="CafeteriaKitchenFridge", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				
			}
		},
		restaurantdisplay = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="ServingTrayBurgers", min=0, max=1, weightChance=100},
				{name="ServingTrayBurritos", min=0, max=1, weightChance=100},
				{name="ServingTrayChickenNuggets", min=0, max=1, weightChance=100},
				{name="ServingTrayChickenWings", min=0, max=1, weightChance=100},
				{name="ServingTrayFishFingers", min=0, max=1, weightChance=100},
				{name="ServingTrayFries", min=0, max=1, weightChance=60},
				{name="ServingTrayHotdogs", min=0, max=1, weightChance=60},
				{name="ServingTrayOnionRings", min=0, max=1, weightChance=100},
				{name="ServingTrayPizza", min=0, max=1, weightChance=100},
				{name="ServingTrayTatoDots", min=0, max=1, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				
			}
		},
	},
	
	camerastore = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateCameraFilm", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreCounterBags", min=0, max=1, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateCameraFilm", min=0, max=99},
			}
		},
		displaycase = {
			procedural = true,
			procList = {
				{name="CameraStoreDisplayCase", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateCameraFilm", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="CameraStoreShelves", min=0, max=99},
				{name="StoreShelfCombo", min=0, max=99, weightChance=100, forceForTiles="location_shop_generic_01_0;location_shop_generic_01_1"},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateCameraFilm", min=0, max=99},
			}
		},
	},
	
	camping = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CampingStoreSleepingBags", min=0, max=1, weightChance=60},
				{name="CampingStoreTents", min=0, max=1, weightChance=40},
				{name="CampingStoreBackpacks", min=0, max=1, weightChance=60},
				{name="CampingStoreLighting", min=0, max=1, weightChance=60},
				{name="CampingStoreCases", min=0, max=1, weightChance=20},
				{name="CampingStoreClothes", min=0, max=1, weightChance=20},
				{name="CampingStoreLegwear", min=0, max=1, weightChance=20},
				{name="CampingStoreTools", min=0, max=1, weightChance=5},
				{name="FishingStoreGear", min=0, max=1, weightChance=5},
				{name="CampingStoreGear", min=0, max=99, weightChance=100},
			}
		},
		clothingrack = {
			procedural = true,
			procList = {
				{name="CampingStoreClothes", min=0, max=99, weightChance=100},
				{name="CampingStoreLegwear", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CampingStoreSleepingBags", min=0, max=1, weightChance=60},
				{name="CampingStoreTents", min=0, max=1, weightChance=40},
				{name="CampingStoreBackpacks", min=0, max=1, weightChance=60},
				{name="CampingStoreLighting", min=0, max=1, weightChance=60},
				{name="CampingStoreCases", min=0, max=1, weightChance=20},
				{name="CampingStoreClothes", min=0, max=1, weightChance=20},
				{name="CampingStoreLegwear", min=0, max=1, weightChance=20},
				{name="CampingStoreTools", min=0, max=1, weightChance=5},
				{name="FishingStoreGear", min=0, max=1, weightChance=5},
				{name="CampingStoreGear", min=0, max=99, weightChance=100},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeWater", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreCounterBags", min=0, max=1, weightChance=100},
				{name="CampingStoreBackpacks", min=0, max=1, weightChance=40},
				{name="CampingStoreBooks", min=0, max=1, weightChance=80},
				{name="FishingStoreGear", min=0, max=1, weightChance=5},
				{name="CampingStoreGear", min=0, max=99, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="CampingStoreSleepingBags", min=1, max=4, weightChance=60},
				{name="CampingStoreTents", min=1, max=4, weightChance=40},
				{name="CampingStoreBackpacks", min=1, max=4, weightChance=60},
				{name="CampingStoreLighting", min=1, max=2, weightChance=60},
				{name="CampingStoreCases", min=1, max=2, weightChance=20},
				{name="CampingStoreClothes", min=1, max=2, weightChance=20},
				{name="CampingStoreLegwear", min=1, max=2, weightChance=20},
				{name="CampingStoreTools", min=1, max=2, weightChance=10},
				{name="FishingStoreGear", min=0, max=2, weightChance=5},
				{name="CampingStoreGear", min=1, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CampingStoreBackpacks", min=0, max=1, weightChance=10},
				{name="CampingStoreClothes", min=0, max=1, weightChance=10},
				{name="CampingStoreLegwear", min=0, max=1, weightChance=10},
				{name="CampingStoreTools", min=0, max=1, weightChance=5},
				{name="CampingStoreBooks", min=0, max=99, weightChance=80},
				{name="CampingStoreGear", min=0, max=99, weightChance=100},
			}
		},
		tent = {
			rolls = 1,
			items = {
				
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
	},
	
	campingstorage = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CampingStoreSleepingBags", min=0, max=1, weightChance=60},
				{name="CampingStoreTents", min=0, max=1, weightChance=40},
				{name="CampingStoreBackpacks", min=0, max=1, weightChance=60},
				{name="CampingStoreLighting", min=0, max=1, weightChance=60},
				{name="CampingStoreClothes", min=0, max=1, weightChance=20},
				{name="CampingStoreLegwear", min=0, max=1, weightChance=20},
				{name="CampingStoreTools", min=0, max=1, weightChance=5},
				{name="FishingStoreGear", min=0, max=1, weightChance=5},
				{name="CampingStoreGear", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CampingStoreSleepingBags", min=0, max=1, weightChance=60},
				{name="CampingStoreTents", min=0, max=1, weightChance=40},
				{name="CampingStoreBackpacks", min=0, max=1, weightChance=60},
				{name="CampingStoreLighting", min=0, max=1, weightChance=60},
				{name="CampingStoreClothes", min=0, max=1, weightChance=20},
				{name="CampingStoreLegwear", min=0, max=1, weightChance=20},
				{name="CampingStoreTools", min=0, max=1, weightChance=5},
				{name="FishingStoreGear", min=0, max=1, weightChance=5},
				{name="CampingStoreGear", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CampingStoreBackpacks", min=0, max=1, weightChance=10},
				{name="CampingStoreClothes", min=0, max=1, weightChance=10},
				{name="CampingStoreLegwear", min=0, max=1, weightChance=10},
				{name="CampingStoreTools", min=0, max=1, weightChance=10},
				{name="CampingStoreBooks", min=0, max=99, weightChance=80},
				{name="CampingStoreGear", min=0, max=99, weightChance=100},
			}
		},
		tent = {
			rolls = 1,
			items = {
				
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
	},
	
	candystorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CandyStoreSnacks", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CandyStoreSnacks", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CandyStoreSnacks", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CandyStoreSnacks", min=0, max=99},
			}
		},
	},
	
	candystore = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="CandyStoreSnacks", min=0, max=99, weightChance=40},
				{name="StoreCounterBags", min=0, max=1, weightChance=100},
			}
		},
		displaycase = {
			procedural = true,
			procList = {
				{name="CandyStoreSnacks", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="CandyStoreSnacks", min=0, max=99},
				{name="StoreShelfCombo", min=0, max=99, forceForTiles="location_shop_generic_01_0;location_shop_generic_01_1"},
			}
		},
	},
	
	captainoffice = {
		counter = {
			procedural = true,
			procList = {
				{name="OfficeCounter", min=0, max=99},
			}
		},
		desk = {
			procedural = true,
			procList = {
				{name="PoliceCaptainDesk", min=0, max=99},
			}
		},
		dishescabinet = {
			procedural = true,
			procList = {
				{name="PoliceCaptainCabinet", min=0, max=99},
			}
		},
		filingcabinet = {
			procedural = true,
			procList = {
				{name="PoliceFilingCabinet", min=0, max=99},
			}
		},
		locker = {
			procedural = true,
			procList = {
				{name="PoliceStorageGuns", min=0, max=99},
			}
		},
	},
	
	cardealershipoffice = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateWaterDispenserBottle", min=0, max=1, weightChance=5},
				{name="CrateOfficeSupplies", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateWaterDispenserBottle", min=0, max=1, weightChance=5},
				{name="CrateOfficeSupplies", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="OfficeCounter", min=0, max=99},
			}
		},
		desk = {
			procedural = true,
			procList = {
				{name="CarDealerDesk", min=0, max=99},
			}
		},
		filingcabinet = {
			procedural = true,
			procList = {
				{name="CarDealerFilingCabinet", min=0, max=99},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeOffice", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="OfficeShelfSupplies", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="ShelfGeneric", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateOfficeSupplies", min=0, max=99},
			}
		},
	},
	
	carsupply = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="MechanicSpecial", min=0, max=1, weightChance=5},
				{name="CarLightbars", min=0, max=1, weightChance=5},
				{name="CarTiresModern1", min=0, max=1, weightChance=10},
				{name="CarTiresModern2", min=0, max=1, weightChance=5},
				{name="CarTiresModern3", min=0, max=1, weightChance=1},
				{name="CarTiresNormal1", min=0, max=1, weightChance=20},
				{name="CarTiresNormal2", min=0, max=1, weightChance=10},
				{name="CarTiresNormal3", min=0, max=1, weightChance=5},
				{name="CarMufflerModern1", min=0, max=1, weightChance=10},
				{name="CarMufflerModern2", min=0, max=1, weightChance=5},
				{name="CarMufflerModern3", min=0, max=1, weightChance=1},
				{name="CarMufflerNormal1", min=0, max=1, weightChance=20},
				{name="CarMufflerNormal2", min=0, max=1, weightChance=10},
				{name="CarMufflerNormal3", min=0, max=1, weightChance=5},
				{name="CarBrakesModern1", min=0, max=1, weightChance=10},
				{name="CarBrakesModern2", min=0, max=1, weightChance=5},
				{name="CarBrakesModern3", min=0, max=1, weightChance=1},
				{name="CarBrakesNormal1", min=0, max=1, weightChance=20},
				{name="CarBrakesNormal2", min=0, max=1, weightChance=10},
				{name="CarBrakesNormal3", min=0, max=1, weightChance=5},
				{name="CarSuspensionModern1", min=0, max=1, weightChance=10},
				{name="CarSuspensionModern2", min=0, max=1, weightChance=5},
				{name="CarSuspensionModern3", min=0, max=1, weightChance=1},
				{name="CarSuspensionNormal1", min=0, max=1, weightChance=20},
				{name="CarSuspensionNormal2", min=0, max=1, weightChance=10},
				{name="CarSuspensionNormal3", min=0, max=1, weightChance=5},
				{name="CarWindows1", min=0, max=1, weightChance=20},
				{name="CarWindows2", min=0, max=1, weightChance=10},
				{name="CarWindows3", min=0, max=1, weightChance=5},
				{name="ToolCabinetMechanics", min=0, max=99, weightChance=100},
			}
		},
		clothingrack = {
			procedural = true,
			procList = {
				{name="MechanicShelfOutfit", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreCounterBags", min=0, max=1, weightChance=100},
				{name="CarSupplyGasCans", min=1, max=99, weightChance=10},
				{name="CarSupplyTools", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="MechanicSpecial", min=0, max=1, weightChance=5},
				{name="CarLightbars", min=0, max=1, weightChance=5},
				{name="CarTiresModern1", min=0, max=1, weightChance=10},
				{name="CarTiresModern2", min=0, max=1, weightChance=5},
				{name="CarTiresModern3", min=0, max=1, weightChance=1},
				{name="CarTiresNormal1", min=0, max=1, weightChance=20},
				{name="CarTiresNormal2", min=0, max=1, weightChance=10},
				{name="CarTiresNormal3", min=0, max=1, weightChance=5},
				{name="CarMufflerModern1", min=0, max=1, weightChance=10},
				{name="CarMufflerModern2", min=0, max=1, weightChance=5},
				{name="CarMufflerModern3", min=0, max=1, weightChance=1},
				{name="CarMufflerNormal1", min=0, max=1, weightChance=20},
				{name="CarMufflerNormal2", min=0, max=1, weightChance=10},
				{name="CarMufflerNormal3", min=0, max=1, weightChance=5},
				{name="CarBrakesModern1", min=0, max=1, weightChance=10},
				{name="CarBrakesModern2", min=0, max=1, weightChance=5},
				{name="CarBrakesModern3", min=0, max=1, weightChance=1},
				{name="CarBrakesNormal1", min=0, max=1, weightChance=20},
				{name="CarBrakesNormal2", min=0, max=1, weightChance=10},
				{name="CarBrakesNormal3", min=0, max=1, weightChance=5},
				{name="CarSuspensionModern1", min=0, max=1, weightChance=10},
				{name="CarSuspensionModern2", min=0, max=1, weightChance=5},
				{name="CarSuspensionModern3", min=0, max=1, weightChance=1},
				{name="CarSuspensionNormal1", min=0, max=1, weightChance=20},
				{name="CarSuspensionNormal2", min=0, max=1, weightChance=10},
				{name="CarSuspensionNormal3", min=0, max=1, weightChance=5},
				{name="CarWindows1", min=0, max=1, weightChance=20},
				{name="CarWindows2", min=0, max=1, weightChance=10},
				{name="CarWindows3", min=0, max=1, weightChance=5},
				{name="ToolCabinetMechanics", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CarSupplyBatteries", min=1, max=99, weightChance=20},
				{name="CarSupplyGasCans", min=0, max=2, weightChance=10},
				{name="CarSupplyTools", min=0, max=4, weightChance=100},
				{name="CarLightbars", min=0, max=1, weightChance=5},
				{name="CarMufflerModern1", min=0, max=1, weightChance=60},
				{name="CarMufflerModern2", min=0, max=1, weightChance=40},
				{name="CarMufflerModern3", min=0, max=1, weightChance=20},
				{name="CarMufflerNormal1", min=0, max=1, weightChance=100},
				{name="CarMufflerNormal2", min=0, max=1, weightChance=80},
				{name="CarMufflerNormal3", min=0, max=1, weightChance=60},
				{name="CarTiresModern1", min=0, max=1, weightChance=40},
				{name="CarTiresModern2", min=0, max=1, weightChance=20},
				{name="CarTiresModern3", min=0, max=1, weightChance=10},
				{name="CarTiresNormal1", min=0, max=1, weightChance=80},
				{name="CarTiresNormal2", min=0, max=1, weightChance=60},
				{name="CarTiresNormal3", min=0, max=1, weightChance=40},
				{name="GasStoreEmergency", min=1, max=2, weightChance=10},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="CarSupplyBatteries", min=1, max=99, weightChance=20},
				{name="CarSupplyGasCans", min=1, max=99, weightChance=10},
				{name="CarSupplyLiterature", min=1, max=99, weightChance=40},
				{name="CarSupplyTools", min=0, max=99, weightChance=100},
				{name="GasStoreEmergency", min=1, max=2, weightChance=10},
			}
		},
		shelvesmag = {
			procedural = true,
			procList = {
				{name="CarSupplyMagazines", min=0, max=99, weightChance=100},
				{name="MagazineRackMaps", min=1, max=1, weightChance=100},
			}
		},
		toolcabinet = {
			procedural = true,
			procList = {
				{name="ToolCabinetMechanics", min=0, max=99},
			}
		},
	},
	
	catfish_dining = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="Empty", min=0, max=99, forceForTiles="location_shop_accessories_01_8;location_shop_accessories_01_9;location_shop_accessories_01_10;location_shop_accessories_01_11;location_shop_accessories_01_11;location_shop_accessories_01_12"},
			}
		},
		fireplace = {
			rolls = 1,
			items = {
				
			}
		},
		restaurantdisplay = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="ServingTrayFishFried", min=0, max=99},
			}
		},
	},
	
	catfish_kitchen = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="CatfishKitchenButcher", min=1, max=1, weightChance=80},
				{name="FishChipsKitchenSauce", min=0, max=1, weightChance=80},
				{name="StoreKitchenCutlery", min=0, max=1, weightChance=20},
				{name="StoreKitchenDishes", min=0, max=1, weightChance=20},
				{name="StoreKitchenGlasses", min=0, max=1, weightChance=20},
				{name="StoreKitchenPots", min=0, max=1, weightChance=20},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="CatfishKitchenFreezer", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="CatfishKitchenFridge", min=0, max=99},
			}
		},
		restaurantdisplay = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="ServingTrayFishFried", min=0, max=99},
			}
		},
	},
	
	catwalk = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateTools", min=0, max=99, weightChance=100},
				{name="RailYardTools", min=0, max=99, forceForRooms="railroadrepair;railroadstorage"},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateTools", min=0, max=99, weightChance=100},
				{name="RailYardTools", min=0, max=99, forceForRooms="railroadrepair;railroadstorage"},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateTools", min=0, max=99, weightChance=100},
				{name="RailYardTools", min=0, max=99, forceForRooms="railroadrepair;railroadstorage"},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateTools", min=0, max=99, weightChance=100},
				{name="RailYardTools", min=0, max=99, forceForRooms="railroadrepair;railroadstorage"},
			}
		},
	},
	
	changeroom = {
		locker = {
			procedural = true,
			procList = {
				{name="BoxingLockers", min=0, max=99, forceForRooms="boxing"},
				{name="BowlingAlleyLockers", min=0, max=99, forceForRooms="bowlingalley"},
				{name="FactoryLockers", min=0, max=99, forceForRooms="batteryfactory;brewery;dogfoodfactory;factory;fryshipping;mannequinfactory;metalshop;radiofactory;warehouse;wirefactory;whiskeybottling"},
				{name="FireDeptLockers", min=0, max=99, forceForRooms="firestorage"},
				{name="GymLockers", min=0, max=99, forceForRooms="fitness;gym"},
				{name="HospitalLockers", min=0, max=99, forceForRooms="hospitalroom;hospitalhallway;hospitalstorage;laboratory"},
				{name="HuntingLockers", min=0, max=99, forceForRooms="hunting"},
				{name="Locker", min=0, max=99, weightChance=100},
				{name="PrisonGuardLockers", min=0, max=99, forceForRooms="prisoncells"},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="ChangeroomCounters", min=0, max=99},
			}
		}
	},
	
	changeroomjockey = {
		locker = {
			procedural = true,
			procList = {
				{name="JockeyLockers", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="ChangeroomCounters", min=0, max=99},
			}
		}
	},
	
	chinesekitchen = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateFlour", min=0, max=1, weightChance=20},
				{name="CrateOilVegetable", min=0, max=1, weightChance=60},
				{name="CrateRice", min=0, max=2, weightChance=100},
				{name="CrateSoysauce", min=0, max=1, weightChance=80},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="ChineseKitchenCutlery", min=0, max=1, weightChance=20},
				{name="ChineseKitchenBaking", min=0, max=1, weightChance=100},
				{name="ChineseKitchenButcher", min=1, max=1, weightChance=100},
				{name="ChineseKitchenSauce", min=0, max=1, weightChance=100},
				{name="StoreKitchenDishes", min=0, max=1, weightChance=20},
				{name="StoreKitchenGlasses", min=0, max=1, weightChance=20},
				{name="StoreKitchenPots", min=0, max=1, weightChance=20},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateFlour", min=0, max=1, weightChance=20},
				{name="CrateOilVegetable", min=0, max=1, weightChance=60},
				{name="CrateRice", min=0, max=2, weightChance=100},
				{name="CrateSoysauce", min=0, max=1, weightChance=80},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="ChineseKitchenFreezer", min=0, max=99, weightChance=100},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="ChineseKitchenFridge", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateFlour", min=0, max=1, weightChance=20},
				{name="CrateOilVegetable", min=0, max=1, weightChance=60},
				{name="CrateRice", min=0, max=2, weightChance=100},
				{name="CrateSoysauce", min=0, max=1, weightChance=80},
			}
		},
		restaurantdisplay = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="ServingTrayMeatDumplings", min=1, max=2, weightChance=100},
				{name="ServingTraySpringRolls", min=1, max=2, weightChance=60},
				{name="ServingTrayMeatSteamBuns", min=1, max=2, weightChance=100},
				{name="ServingTrayTofuFried", min=1, max=2, weightChance=60},
				{name="ServingTrayNoodleSoup", min=1, max=2, weightChance=20},
				{name="ServingTrayShrimpDumplings", min=1, max=2, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateFlour", min=0, max=1, weightChance=20},
				{name="CrateOilVegetable", min=0, max=1, weightChance=60},
				{name="CrateRice", min=0, max=2, weightChance=100},
				{name="CrateSoysauce", min=0, max=1, weightChance=80},
			}
		},
	},
	
	chineserestaurant = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
			}
		},
		restaurantdisplay = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="ServingTrayMeatDumplings", min=1, max=2, weightChance=100},
				{name="ServingTraySpringRolls", min=1, max=2, weightChance=60},
				{name="ServingTrayMeatSteamBuns", min=1, max=2, weightChance=100},
				{name="ServingTrayTofuFried", min=1, max=2, weightChance=60},
				{name="ServingTrayNoodleSoup", min=1, max=2, weightChance=20},
				{name="ServingTrayShrimpDumplings", min=1, max=2, weightChance=100},
			}
		},
	},
	
	classroom = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateSkeletonDisplay", min=0, max=1, weightChance=1},
				{name="CrateBooksSchool", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="ClassroomMisc", min=0, max=99},
			}
		},
		desk = {
			procedural = true,
			procList = {
				{name="ClassroomDesk", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="ClassroomShelves", min=0, max=99, weightChance=100},
				{name="ScienceMisc", min=0, max=1, weightChance=10},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="ClassroomShelves", min=0, max=99},
			}
		}
	},
	
	classroom_anthro = {
		counter = {
			procedural = true,
			procList = {
				{name="AnthropologyCounter", min=0, max=99},
			}
		},
		desk = {
			procedural = true,
			procList = {
				{name="AnthropologyDesk", min=0, max=99},
			}
		},
		displaycase = {
			procedural = true,
			procList = {
				{name="AnthropologyDisplayClothing", min=1, max=1, weightChance=100},
				{name="AnthropologyDisplayTools", min=1, max=1, weightChance=100},
				{name="AnthropologyDisplayWeapons", min=1, max=1, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="AnthropologyBooks", min=0, max=99},
			}
		},
	},
	
	closet = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="Antiques", min=0, max=1, weightChance=10},
				{name="ArtSupplies", min=0, max=1, weightChance=20},
				{name="BurglarTools", min=0, max=1, weightChance=10},
				{name="Chemistry", min=0, max=1, weightChance=10},
				{name="ClothingStorageWinter", min=0, max=1, weightChance=40},
				{name="CrateBooks", min=0, max=1, weightChance=100},
				{name="CrateCamping", min=0, max=1, weightChance=100},
				{name="CrateCanning", min=0, max=1, weightChance=100},
				{name="CrateCarpentry", min=0, max=1, weightChance=100},
				{name="CrateClothesRandom", min=0, max=1, weightChance=100},
				{name="CrateComics", min=0, max=1, weightChance=100},
				{name="CrateCompactDiscs", min=0, max=1, weightChance=100},
				{name="CrateCostume", min=0, max=1, weightChance=10},
				{name="CrateElectronics", min=0, max=1, weightChance=100},
				{name="CrateFarming", min=0, max=1, weightChance=100},
				{name="CrateFishing", min=0, max=1, weightChance=100},
				{name="CrateFitnessWeights", min=0, max=1, weightChance=5},
				{name="CrateFootwearRandom", min=0, max=1, weightChance=100},
				{name="CrateInstruments", min=0, max=1, weightChance=100},
				{name="CrateLinens", min=0, max=1, weightChance=100},
				{name="CrateMagazines", min=0, max=1, weightChance=100},
				{name="CrateMechanics", min=0, max=1, weightChance=100},
				{name="CrateNewspapers", min=0, max=1, weightChance=100},
				{name="CratePaint", min=0, max=1, weightChance=100},
				{name="CratePetSupplies", min=0, max=1, weightChance=100},
				{name="CratePhotos", min=0, max=1, weightChance=20},
				{name="CrateRandomJunk", min=0, max=1, weightChance=100},
				{name="CrateSports", min=0, max=1, weightChance=100},
				{name="CrateTailoring", min=0, max=1, weightChance=100},
				{name="CrateTools", min=0, max=1, weightChance=60},
				{name="CrateToolsOld", min=0, max=1, weightChance=100},
				{name="CrateVHSTapes", min=0, max=1, weightChance=100},
				{name="EngineerTools", min=0, max=1, weightChance=10},
				{name="FitnessTrainer", min=0, max=1, weightChance=10},
				{name="Gifts", min=0, max=1, weightChance=10},
				{name="Hiker", min=0, max=1, weightChance=10},
				{name="Hobbies", min=0, max=1, weightChance=10},
				{name="HolidayStuff", min=0, max=1, weightChance=10},
				{name="Homesteading", min=0, max=1, weightChance=10},
				{name="Hunter", min=0, max=1, weightChance=10},
				{name="ImprovisedCrafts", min=0, max=1, weightChance=10},
				{name="JunkHoard", min=0, max=1, weightChance=10},
				{name="MechanicSpecial", min=0, max=1, weightChance=10},
				{name="Photographer", min=0, max=1, weightChance=10},
				{name="PlumbingSupplies", min=0, max=1, weightChance=10},
				{name="ScienceMisc", min=0, max=1, weightChance=10},
				{name="SurvivalGear", min=0, max=1, weightChance=10},
				{name="Trapper", min=0, max=1, weightChance=10},
				{name="VacationStuff", min=0, max=1, weightChance=10},
				{name="WallDecor", min=0, max=1, weightChance=10},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateCarpentry", min=0, max=1, weightChance=100},
				{name="CrateElectronics", min=0, max=1, weightChance=100},
				{name="CrateFarming", min=0, max=1, weightChance=100},
				{name="CrateFishing", min=0, max=1, weightChance=100},
				{name="CrateMechanics", min=0, max=1, weightChance=100},
				{name="CratePaint", min=0, max=1, weightChance=100},
				{name="CrateTailoring", min=0, max=1, weightChance=100},
				{name="CrateTools", min=0, max=1, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="ClosetShelfGeneric", min=0, max=99, weightChance=100},
				{name="ClosetInstruments", min=0, max=1, weightChance=10},
				{name="ClosetSportsEquipment", min=0, max=1, weightChance=10},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="Antiques", min=0, max=1, weightChance=10},
				{name="ArtSupplies", min=0, max=1, weightChance=20},
				{name="BurglarTools", min=0, max=1, weightChance=10},
				{name="Chemistry", min=0, max=1, weightChance=10},
				{name="ClothingStorageWinter", min=0, max=1, weightChance=40},
				{name="CrateBooks", min=0, max=1, weightChance=40},
				{name="CrateCanning", min=0, max=1, weightChance=20},
				{name="CrateClothesRandom", min=0, max=1, weightChance=40},
				{name="CrateComics", min=0, max=1, weightChance=40},
				{name="CrateCompactDiscs", min=0, max=1, weightChance=10},
				{name="CrateCostume", min=0, max=1, weightChance=10},
				{name="CrateDishes", min=0, max=1, weightChance=10},
				{name="CrateFootwearRandom", min=0, max=1, weightChance=40},
				{name="CrateInstruments", min=0, max=1, weightChance=10},
				{name="CrateLinens", min=0, max=1, weightChance=10},
				{name="CrateMagazines", min=0, max=1, weightChance=40},
				{name="CrateNewspapers", min=0, max=1, weightChance=40},
				{name="CratePetSupplies", min=0, max=1, weightChance=10},
				{name="CratePhotos", min=0, max=1, weightChance=20},
				{name="CrateTailoring", min=0, max=1, weightChance=10},
				{name="CrateToys", min=0, max=1, weightChance=10},
				{name="CrateVHSTapes", min=0, max=1, weightChance=10},
				{name="EngineerTools", min=0, max=1, weightChance=20},
				{name="FitnessTrainer", min=0, max=1, weightChance=20},
				{name="Gifts", min=0, max=1, weightChance=10},
				{name="Hiker", min=0, max=1, weightChance=20},
				{name="Hobbies", min=0, max=1, weightChance=20},
				{name="HolidayStuff", min=0, max=1, weightChance=20},
				{name="Homesteading", min=0, max=1, weightChance=20},
				{name="Hunter", min=0, max=1, weightChance=20},
				{name="ImprovisedCrafts", min=0, max=1, weightChance=20},
				{name="JunkHoard", min=0, max=1, weightChance=40},
				{name="MechanicSpecial", min=0, max=1, weightChance=20},
				{name="Photographer", min=0, max=1, weightChance=20},
				{name="PlumbingSupplies", min=0, max=1, weightChance=20},
				{name="ScienceMisc", min=0, max=1, weightChance=20},
				{name="SurvivalGear", min=0, max=1, weightChance=20},
				{name="Trapper", min=0, max=1, weightChance=20},
				{name="VacationStuff", min=0, max=1, weightChance=20},
			}
		},
	},
	
	clothingstorage = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="ClothingStorageAllJackets", min=0, max=99, weightChance=40},
				{name="ClothingStorageAllShirts", min=0, max=99, weightChance=80},
				{name="ClothingStorageFootwear", min=0, max=99, weightChance=40},
				{name="ClothingStorageHeadwear", min=0, max=99, weightChance=20},
				{name="ClothingStorageLegwear", min=0, max=99, weightChance=80},
				{name="ClothingStorageWinter", min=0, max=99, weightChance=100},
			}
		},
		clothingrack = {
			procedural = true,
			procList = {
				{name="ClothingStorageAllJackets", min=0, max=99, weightChance=100},
				{name="ClothingStorageAllShirts", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="ClothingStorageAllJackets", min=0, max=99, weightChance=40},
				{name="ClothingStorageAllShirts", min=0, max=99, weightChance=80},
				{name="ClothingStorageFootwear", min=0, max=99, weightChance=40},
				{name="ClothingStorageHeadwear", min=0, max=99, weightChance=20},
				{name="ClothingStorageLegwear", min=0, max=99, weightChance=80},
				{name="ClothingStorageWinter", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="ClothingStorageFootwear", min=0, max=99, weightChance=40},
				{name="ClothingStorageHeadwear", min=0, max=99, weightChance=20},
				{name="ClothingStorageLegwear", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="ClothingStorageAllJackets", min=0, max=99, weightChance=40},
				{name="ClothingStorageAllShirts", min=0, max=99, weightChance=80},
				{name="ClothingStorageFootwear", min=0, max=99, weightChance=40},
				{name="ClothingStorageHeadwear", min=0, max=99, weightChance=20},
				{name="ClothingStorageLegwear", min=0, max=99, weightChance=80},
				{name="ClothingStorageWinter", min=0, max=99, weightChance=100},
			}
		},
	},
	
	clothingstore = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="ClothingStorageAllJackets", min=0, max=99, weightChance=40},
				{name="ClothingStorageAllShirts", min=0, max=99, weightChance=80},
				{name="ClothingStorageFootwear", min=0, max=99, weightChance=40},
				{name="ClothingStorageHeadwear", min=0, max=99, weightChance=20},
				{name="ClothingStorageLegwear", min=0, max=99, weightChance=80},
				{name="ClothingStorageWinter", min=0, max=99, weightChance=20},
			}
		},
		clothingrack = {
			procedural = true,
			procList = {
				{name="ClothingStoresDress", min=0, max=99, weightChance=20},
				{name="ClothingStoresJackets", min=0, max=99, weightChance=40},
				{name="ClothingStoresJacketsFormal", min=0, max=99, weightChance=10},
				{name="ClothingStoresJumpers", min=0, max=99, weightChance=60},
				{name="ClothingStoresOvershirts", min=0, max=99, weightChance=80},
				{name="ClothingStoresPants", min=0, max=99, weightChance=100},
				{name="ClothingStoresPantsFormal", min=0, max=99, weightChance=10},
				{name="ClothingStoresShirts", min=0, max=99, weightChance=100},
				{name="ClothingStoresShirtsFormal", min=0, max=99, weightChance=10},
				{name="ClothingStoresSport", min=0, max=99, weightChance=40},
				{name="ClothingStoresSummer", min=0, max=99, weightChance=40},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreCounterBagsFancy", min=0, max=1, weightChance=100},
				{name="ClothingStoresGloves", min=0, max=99, weightChance=40},
				{name="ClothingStoresEyewear", min=0, max=99, weightChance=100},
				{name="ClothingStoresHeadwear", min=0, max=99, weightChance=60},
				{name="ClothingStoresSocks", min=0, max=99, weightChance=20},
				{name="ClothingStoresUnderwearWoman", min=0, max=99, weightChance=20},
				{name="ClothingStoresUnderwearMan", min=0, max=99, weightChance=20},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="ClothingStorageAllJackets", min=0, max=99, weightChance=40},
				{name="ClothingStorageAllShirts", min=0, max=99, weightChance=80},
				{name="ClothingStorageFootwear", min=0, max=99, weightChance=40},
				{name="ClothingStorageHeadwear", min=0, max=99, weightChance=20},
				{name="ClothingStorageLegwear", min=0, max=99, weightChance=80},
				{name="ClothingStorageWinter", min=0, max=99, weightChance=20},
			}
		},
		displaycase = {
			procedural = true,
			procList = {
				{name="StoreDisplayWatches", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="ClothingStorageFootwear", min=0, max=99, weightChance=40},
				{name="ClothingStorageHeadwear", min=0, max=99, weightChance=20},
				{name="ClothingStorageLegwear", min=0, max=99, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="ClothingStoresBoots", min=0, max=99, weightChance=50},
				{name="ClothingStoresShoes", min=0, max=99, weightChance=100},
				{name="StoreShelfCombo", min=0, max=99, forceForTiles="location_shop_generic_01_0;location_shop_generic_01_1"},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="ClothingStorageAllJackets", min=0, max=99, weightChance=40},
				{name="ClothingStorageAllShirts", min=0, max=99, weightChance=80},
				{name="ClothingStorageFootwear", min=0, max=99, weightChance=40},
				{name="ClothingStorageHeadwear", min=0, max=99, weightChance=20},
				{name="ClothingStorageLegwear", min=0, max=99, weightChance=80},
				{name="ClothingStorageWinter", min=0, max=99, weightChance=20},
			}
		},
	},
	
	comicstore = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="ComicStoreDisplayComics", min=0, max=1, weightChance=10},
				{name="ComicStoreShelfComics", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="ComicStoreCounter", min=1, max=1, weightChance=100},
				{name="StoreCounterBags", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="ComicStoreDisplayComics", min=0, max=1, weightChance=10},
				{name="ComicStoreShelfComics", min=0, max=99, weightChance=100},
			}
		},
		displaycase = {
			procedural = true,
			procList = {
				{name="ComicStoreDisplayBooks", min=0, max=1, weightChance=80},
				{name="ComicStoreDisplayDice", min=1, max=1, weightChance=100},
				{name="ComicStoreDisplayComics", min=1, max=99, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="ComicStoreDisplayComics", min=0, max=99, weightChance=10},
				{name="ComicStoreShelfFantasy", min=1, max=99, weightChance=20},
				{name="ComicStoreShelfSciFi", min=1, max=99, weightChance=20},
				{name="ComicStoreShelfGames", min=1, max=99, weightChance=20},
				{name="ComicStoreShelfComics", min=1, max=99, weightChance=100},
			}
		},
		shelvesmag = {
			procedural = true,
			procList = {
				{name="ComicStoreShelfFantasy", min=1, max=99, weightChance=20},
				{name="ComicStoreShelfSciFi", min=1, max=99, weightChance=20},
				{name="ComicStoreShelfGames", min=1, max=99, weightChance=20},
				{name="ComicStoreMagazines", min=1, max=99, weightChance=40},
				{name="ComicStoreShelfComics", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="ComicStoreDisplayComics", min=0, max=1, weightChance=10},
				{name="ComicStoreShelfComics", min=0, max=99, weightChance=100},
			}
		},
	},
	
	comicstorage = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="ComicStoreDisplayComics", min=0, max=1, weightChance=40},
				{name="ComicStoreShelfComics", min=1, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="ComicStoreDisplayComics", min=0, max=1, weightChance=40},
				{name="ComicStoreShelfComics", min=1, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="ComicStoreDisplayComics", min=0, max=1, weightChance=40},
				{name="ComicStoreShelfComics", min=1, max=99, weightChance=100},
			}
		},
	},
	
	construction = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateClayBricks", min=0, max=1, weightChance=20},
				{name="CrateConcrete", min=0, max=99, weightChance=10},
				{name="CrateLumber", min=0, max=99, weightChance=80},
				{name="CratePaint", min=0, max=99, weightChance=60},
				{name="CratePlaster", min=0, max=99, weightChance=40},
				{name="CrateTools", min=0, max=99, weightChance=60},
				{name="CrateToolsOld", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			rolls = 1,
			items = {
				
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateClayBricks", min=0, max=1, weightChance=20},
				{name="CrateConcrete", min=0, max=99, weightChance=10},
				{name="CrateLumber", min=0, max=99, weightChance=80},
				{name="CratePaint", min=0, max=99, weightChance=60},
				{name="CratePlaster", min=0, max=99, weightChance=40},
				{name="CrateTools", min=0, max=99, weightChance=60},
				{name="CrateToolsOld", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CratePaint", min=0, max=99, weightChance=60},
				{name="CrateTools", min=0, max=99, weightChance=80},
				{name="CrateToolsOld", min=0, max=99, weightChance=100},
			}
		},
	},
	
	controlroom = {
		counter = {
			procedural = true,
			procList = {
				{name="ControlRoomCounter", min=0, max=99, weightChance=100},
			}
		},
	},
	
	conveniencestore = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="Empty", min=0, max=99, forceForTiles="location_shop_accessories_01_8;location_shop_accessories_01_9;location_shop_accessories_01_12;location_shop_fossoil_01_10;location_shop_fossoil_01_11"},
				{name="StoreCounterBags", min=0, max=2, weightChance=100},
				{name="StoreCounterStrawsNapkins", min=0, max=99, forceForTiles="location_shop_accessories_01_10;location_shop_accessories_01_11"},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="FreezerIceCream", min=0, max=99, forceForTiles="appliances_refrigeration_01_20;appliances_refrigeration_01_21;appliances_refrigeration_01_38;appliances_refrigeration_01_39"},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeOther", min=0, max=99, weightChance=20},
				{name="FridgeSnacks", min=1, max=99, weightChance=100},
				{name="FridgeSoda", min=1, max=99, weightChance=100},
				{name="FridgeWater", min=0, max=99, weightChance=60},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="MovieRentalShelves", min=0, max=99, forceForTiles="location_entertainment_theatre_01_120;location_entertainment_theatre_01_121;location_entertainment_theatre_01_122;location_entertainment_theatre_01_123;location_entertainment_theatre_01_124;location_entertainment_theatre_01_125;location_entertainment_theatre_01_126;location_entertainment_theatre_01_127;location_entertainment_theatre_01_128;location_entertainment_theatre_01_129;location_entertainment_theatre_01_130;location_entertainment_theatre_01_131;location_entertainment_theatre_01_132;location_entertainment_theatre_01_133;location_entertainment_theatre_01_134;location_entertainment_theatre_01_135"},
				{name="StoreCounterTobacco", min=0, max=99, forceForTiles="location_shop_generic_01_28;location_shop_generic_01_29;location_shop_generic_01_30;location_shop_generic_01_31"},
				{name="StoreShelfCombo", min=0, max=99, forceForTiles="location_shop_generic_01_0;location_shop_generic_01_1"},
				{name="StoreShelfDrinks", min=0, max=99, weightChance=100},
				{name="StoreShelfMechanics", min=0, max=99, forceForTiles="location_shop_generic_01_3;location_shop_generic_01_4"},
				{name="StoreShelfMedical", min=0, max=1, weightChance=20},
				{name="StoreShelfSnacks", min=0, max=99, weightChance=100},
			}
		},
		shelvesmag = {
			procedural = true,
			procList = {
				{name="MagazineRackMaps", min=1, max=4, weightChance=40},
				{name="MagazineRackMixed", min=1, max=99, weightChance=100},
				{name="MagazineRackNewspaper", min=1, max=4, weightChance=40},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99},
			}
		},
	},
	
	cornerstore = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="Empty", min=0, max=99, forceForTiles="location_shop_accessories_01_8;location_shop_accessories_01_9;location_shop_accessories_01_10;location_shop_accessories_01_11;location_shop_accessories_01_11;location_shop_accessories_01_12;location_shop_fossoil_01_10;location_shop_fossoil_01_11;"},
				{name="StoreCounterBags", min=0, max=2, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99},
			}
		},
		displaycasebakery = {
			procedural = true,
			procList = {
				{name="BakeryBread", min=0, max=99, weightChance=20},
				{name="BakeryCake", min=0, max=99, weightChance=20},
				{name="BakeryDoughnuts", min=1, max=99, weightChance=80},
				{name="BakeryMisc", min=1, max=99, weightChance=100},
				{name="BakeryPie", min=0, max=99, weightChance=20},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="FreezerIceCream", min=0, max=99, forceForTiles="appliances_refrigeration_01_20;appliances_refrigeration_01_21;appliances_refrigeration_01_38;appliances_refrigeration_01_39"},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeOther", min=1, max=99, weightChance=40},
				{name="FridgeSnacks", min=1, max=99, weightChance=100},
				{name="FridgeSoda", min=1, max=99, weightChance=100},
				{name="FridgeWater", min=1, max=99, weightChance=60},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="MovieRentalShelves", min=0, max=99, forceForTiles="location_entertainment_theatre_01_120;location_entertainment_theatre_01_121;location_entertainment_theatre_01_122;location_entertainment_theatre_01_123;location_entertainment_theatre_01_124;location_entertainment_theatre_01_125;location_entertainment_theatre_01_126;location_entertainment_theatre_01_127;location_entertainment_theatre_01_128;location_entertainment_theatre_01_129;location_entertainment_theatre_01_130;location_entertainment_theatre_01_131;location_entertainment_theatre_01_132;location_entertainment_theatre_01_133;location_entertainment_theatre_01_134;location_entertainment_theatre_01_135"},
				{name="StoreCounterTobacco", min=0, max=99, forceForTiles="location_shop_generic_01_28;location_shop_generic_01_29;location_shop_generic_01_30;location_shop_generic_01_31"},
				{name="StoreShelfCombo", min=0, max=99, forceForTiles="location_shop_generic_01_0;location_shop_generic_01_1"},
				{name="StoreShelfDrinks", min=0, max=99, weightChance=100},
				{name="StoreShelfMechanics", min=0, max=99, forceForTiles="location_shop_generic_01_3;location_shop_generic_01_4"},
				{name="StoreShelfMedical", min=0, max=1, weightChance=20},
				{name="StoreShelfSnacks", min=0, max=99, weightChance=100},
			}
		},
		shelvesmag = {
			procedural = true,
			procList = {
				{name="MagazineRackMaps", min=1, max=4, weightChance=40},
				{name="MagazineRackMixed", min=1, max=99, weightChance=100},
				{name="MagazineRackNewspaper", min=1, max=4, weightChance=40},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99},
			}
		},
	},
	
	cornerstorecounter = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreCounterBags", min=0, max=2, weightChance=100},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeSoda", min=1, max=99, weightChance=100},
				{name="FridgeWater", min=1, max=99, weightChance=60},
			}
		},
		shelvesmag = {
			procedural = true,
			procList = {
				{name="MagazineRackNewspaper", min=1, max=2, weightChance=80},
				{name="MagazineRackMixed", min=1, max=99, weightChance=100},
			}
		},
	},
	
	cornerstorestorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="JanitorChemicals", min=0, max=99, weightChance=100},
				{name="JanitorCleaning", min=0, max=1, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="JanitorMisc", min=1, max=1, weightChance=100},
				{name="JanitorTools", min=0, max=1, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99},
			}
		},
	},
	
	coroneroffice = {
		counter = {
			procedural = true,
			procList = {
				{name="MorgueTools", min=0, max=99},
			}
		},
		desk = {
			procedural = true,
			procList = {
				{name="MedicalOfficeDesk", min=0, max=99},
			}
		},
		dresser = {
			procedural = true,
			procList = {
				{name="MorgueTools", min=0, max=99},
			}
		},
		medicine = {
			procedural = true,
			procList = {
				{name="MorgueTools", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="MorgueChemicals", min=1, max=99, weightChance=100},
				{name="MorgueOutfit", min=1, max=99, weightChance=100},
			}
		},
	},
	
	cortmanmedroom = {
		counter = {
			procedural = true,
			procList = {
				{name="MedicalOfficeCounter", min=0, max=99}
			}
		},
		woodstove = {
			procedural = true,
			procList = {
				{name="Empty", min=0, max=99},
			}
		},
	},
	
	cortmanoffice = {
		counter = {
			procedural = true,
			procList = {
				{name="MedicalOfficeCounter", min=0, max=99}
			}
		},
		desk = {
			procedural = true,
			procList = {
				{name="MedicalOfficeDesk", min=0, max=99},
			}
		},
		medicine = {
			procedural = true,
			procList = {
				{name="MedicalStorageDrugs", min=1, max=1, weightChance=100},
				{name="MedicalStorageTools", min=1, max=1, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="MedicalOfficeBooks", min=0, max=99},
			}
		},
	},
	
	cybercafe = {
		isShop = true,
		desk = {
			procedural = true,
			procList = {
				{name="CyberCafeDesk", min=0, max=99},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeSoda", min=0, max=99},
			}
		},
		filingcabinet = {
			procedural = true,
			procList = {
				{name="CyberCafeFilingCabinet", min=0, max=99},
			}
		},
	},
	
	dartgame = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="CarnivalPrizes", min=0, max=4, weightChance=100},
			}
		}
	},
	
	daycare = {
		counter = {
			procedural = true,
			procList = {
				{name="DaycareCounter", min=0, max=99},
			}
		},
		desk = {
			procedural = true,
			procList = {
				{name="DaycareDesk", min=0, max=99},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeBreakRoom", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="DaycareShelves", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="DaycareShelves", min=0, max=99},
			}
		},
		wardrobe = {
			procedural = true,
			procList = {
				{name="WardrobeChild", min=0, max=99},
			}
		},
	},
	
	deepfry_kitchen = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateCondiments", min=0, max=1, weightChance=60},
				{name="CrateCornflour", min=0, max=1, weightChance=20},
				{name="CrateFlour", min=0, max=1, weightChance=80},
				{name="CrateGravyMix", min=0, max=1, weightChance=40},
				{name="CrateOilVegetable", min=0, max=1, weightChance=100},
				{name="FryFactoryPotatoes", min=0, max=2, weightChance=80},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="BurgerKitchenButcher", min=1, max=1, weightChance=80},
				{name="BurgerKitchenSauce", min=0, max=1, weightChance=80},
				{name="FishChipsKitchenButcher", min=0, max=1, weightChance=80},
				{name="FishChipsKitchenSauce", min=0, max=1, weightChance=80},
				{name="JaysKitchenBaking", min=0, max=1, weightChance=80},
				{name="JaysKitchenButcher", min=0, max=1, weightChance=80},
				{name="StoreKitchenBaking", min=0, max=1, weightChance=100},
				{name="StoreKitchenCutlery", min=0, max=1, weightChance=20},
				{name="StoreKitchenDishes", min=0, max=1, weightChance=20},
				{name="StoreKitchenGlasses", min=0, max=1, weightChance=20},
				{name="StoreKitchenPotatoes", min=0, max=1, weightChance=20},
				{name="StoreKitchenPots", min=0, max=1, weightChance=20},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateCondiments", min=0, max=1, weightChance=60},
				{name="CrateCornflour", min=0, max=1, weightChance=20},
				{name="CrateFlour", min=0, max=1, weightChance=80},
				{name="CrateGravyMix", min=0, max=1, weightChance=40},
				{name="CrateOilVegetable", min=0, max=1, weightChance=100},
				{name="FryFactoryPotatoes", min=0, max=2, weightChance=80},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="DeepFryKitchenFreezer", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="DeepFryKitchenFridge", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateCondiments", min=0, max=1, weightChance=60},
				{name="CrateCornflour", min=0, max=1, weightChance=20},
				{name="CrateFlour", min=0, max=1, weightChance=80},
				{name="CrateGravyMix", min=0, max=1, weightChance=40},
				{name="CrateOilVegetable", min=0, max=1, weightChance=100},
				{name="FryFactoryPotatoes", min=0, max=2, weightChance=80},
			}
		},
		restaurantdisplay = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="ServingTrayBiscuits", min=0, max=1, weightChance=10},
				{name="ServingTrayChickenNuggets", min=0, max=1, weightChance=100},
				{name="ServingTrayChickenWings", min=0, max=1, weightChance=100},
				{name="ServingTrayCornbread", min=0, max=1, weightChance=10},
				{name="ServingTrayFishFingers", min=0, max=1, weightChance=100},
				{name="ServingTrayFishFried", min=0, max=1, weightChance=100},
				{name="ServingTrayFries", min=0, max=1, weightChance=100},
				{name="ServingTrayOnionRings", min=0, max=1, weightChance=100},
				{name="ServingTrayOystersFried", min=0, max=1, weightChance=100},
				{name="ServingTrayShrimpFried", min=0, max=1, weightChance=100},
				{name="ServingTrayTatoDots", min=0, max=2, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateCondiments", min=0, max=1, weightChance=60},
				{name="CrateCornflour", min=0, max=1, weightChance=20},
				{name="CrateFlour", min=0, max=1, weightChance=80},
				{name="CrateGravyMix", min=0, max=1, weightChance=40},
				{name="CrateOilVegetable", min=0, max=1, weightChance=100},
				{name="FryFactoryPotatoes", min=0, max=2, weightChance=80},
			}
		},
	},
	
	dentist = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="MedicalClinicTools", min=0, max=99, weightChance=40},
				{name="MedicalClinicDrugs", min=0, max=99, weightChance=100},
			}
		},
		dresser = {
			procedural = true,
			procList = {
				{name="MedicalClinicTools", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="MedicalStorageTools", min=0, max=99, weightChance=20},
				{name="MedicalStorageDrugs", min=0, max=99, weightChance=100},
			}
		},
	},
	
	dentiststorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="MedicalStorageDrugs", min=0, max=6, weightChance=100},
				{name="MedicalStorageTools", min=0, max=4, weightChance=80},
				{name="MedicalStorageOutfit", min=0, max=2, weightChance=40},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="MedicalStorageDrugs", min=0, max=6, weightChance=100},
				{name="MedicalStorageTools", min=0, max=4, weightChance=80},
				{name="MedicalStorageOutfit", min=0, max=2, weightChance=40},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="MedicalStorageDrugs", min=0, max=6, weightChance=100},
				{name="MedicalStorageTools", min=0, max=4, weightChance=80},
				{name="MedicalStorageOutfit", min=0, max=2, weightChance=40},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="MedicalStorageDrugs", min=0, max=6, weightChance=100},
				{name="MedicalStorageTools", min=0, max=4, weightChance=80},
				{name="MedicalStorageOutfit", min=0, max=2, weightChance=40},
			}
		},
	},
	
	departmentstorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateTV", min=0, max=2, weightChance=10},
				{name="CrateTVWide", min=0, max=2, weightChance=10},
				{name="ClothingStorageWinter", min=0, max=4, weightChance=100},
				{name="ClothingStorageHeadwear", min=0, max=2, weightChance=20},
				{name="ClothingStorageFootwear", min=0, max=2, weightChance=20},
				{name="ClothingStorageAllJackets", min=0, max=2, weightChance=80},
				{name="ClothingStorageAllShirts", min=0, max=2, weightChance=80},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateTV", min=0, max=2, weightChance=10},
				{name="CrateTVWide", min=0, max=2, weightChance=10},
				{name="ClothingStorageWinter", min=0, max=4, weightChance=100},
				{name="ClothingStorageHeadwear", min=0, max=2, weightChance=20},
				{name="ClothingStorageFootwear", min=0, max=2, weightChance=20},
				{name="ClothingStorageAllJackets", min=0, max=2, weightChance=80},
				{name="ClothingStorageAllShirts", min=0, max=2, weightChance=80},
			}
		},
		dresser = {
			rolls = 1,
			items = {
				
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="ClothingStorageFootwear", min=0, max=2, weightChance=20},
				{name="ClothingStorageHeadwear", min=0, max=2, weightChance=20},
				{name="ClothingStorageLegwear", min=0, max=4, weightChance=80},
				{name="GigamartHousewares", min=0, max=2, weightChance=60},
				{name="GigamartBedding", min=0, max=2, weightChance=60},
				{name="GigamartPots", min=0, max=2, weightChance=60},
				{name="GigamartLightbulb", min=0, max=2, weightChance=60},
				{name="GigamartHouseElectronics", min=0, max=4, weightChance=100},
			}
		},
		wardrobe = {
			rolls = 1,
			items = {
				
			}
		},
		sidetable = {
			rolls = 1,
			items = {
				
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="ClothingStorageWinter", min=0, max=4, weightChance=100},
				{name="ClothingStorageHeadwear", min=0, max=2, weightChance=20},
				{name="ClothingStorageFootwear", min=0, max=2, weightChance=20},
				{name="ClothingStorageAllJackets", min=0, max=2, weightChance=80},
				{name="ClothingStorageAllShirts", min=0, max=2, weightChance=80},
			}
		},
	},
	
	departmentstore = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateTV", min=0, max=2, weightChance=10},
				{name="CrateTVWide", min=0, max=2, weightChance=10},
				{name="ClothingStorageWinter", min=0, max=4, weightChance=100},
				{name="ClothingStorageHeadwear", min=0, max=2, weightChance=20},
				{name="ClothingStorageFootwear", min=0, max=2, weightChance=20},
				{name="ClothingStorageAllJackets", min=0, max=2, weightChance=80},
				{name="ClothingStorageAllShirts", min=0, max=2, weightChance=80},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreCounterBags", min=0, max=1, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateTV", min=0, max=2, weightChance=10},
				{name="CrateTVWide", min=0, max=2, weightChance=10},
				{name="ClothingStorageWinter", min=0, max=4, weightChance=100},
				{name="ClothingStorageHeadwear", min=0, max=2, weightChance=20},
				{name="ClothingStorageFootwear", min=0, max=2, weightChance=20},
				{name="ClothingStorageAllJackets", min=0, max=2, weightChance=80},
				{name="ClothingStorageAllShirts", min=0, max=2, weightChance=80},
			}
		},
		displaycase = {
			procedural = true,
			procList = {
				{name="JewelrySilver", min=0, max=4, weightChance=80},
				{name="JewelryGold", min=0, max=4, weightChance=40},
				{name="JewelryGems", min=0, max=2, weightChance=10},
				{name="JewelryWeddingRings", min=0, max=8, weightChance=100},
				{name="JewelryWrist", min=0, max=2, weightChance=80},
				{name="JewelryOthers", min=0, max=99, weightChance=10},
			}
		},
		dresser = {
			rolls = 1,
			items = {
				
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="ClothingStoresBoots", min=0, max=12, weightChance=50},
				{name="ClothingStoresShoes", min=0, max=24, weightChance=100},
				{name="StoreShelfCombo", min=0, max=99, forceForTiles="location_shop_generic_01_0;location_shop_generic_01_1"},
			}
		},
		wardrobe = {
			rolls = 1,
			items = {
				
			}
		},
		sidetable = {
			rolls = 1,
			items = {
				
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="ClothingStorageWinter", min=0, max=4, weightChance=100},
				{name="ClothingStorageHeadwear", min=0, max=2, weightChance=20},
				{name="ClothingStorageFootwear", min=0, max=2, weightChance=20},
				{name="ClothingStorageAllJackets", min=0, max=2, weightChance=80},
				{name="ClothingStorageAllShirts", min=0, max=2, weightChance=80},
			}
		},
	},
	
	derelict = {
		freezer = {
			rolls = 1,
			items = {
				"Cockroach", 8,
				"DeadMouse", 2,
				"DeadRat", 1,
				"Dung_Mouse", 1,
				"Dung_Rat", 1,
			}
		},
		fridge = {
			rolls = 1,
			items = {
				"Cockroach", 8,
				"DeadMouse", 2,
				"DeadRat", 1,
				"Dung_Mouse", 1,
				"Dung_Rat", 1,
			}
		},
		stove = {
			procedural = true,
			procList = {
				{name="DerelictHouseStove", min=0, max=99},
			}
		},
		other = {
			procedural = true,
			procList = {
				{name="DerelictHouseParty", min=0, max=1, weightChance=5},
				{name="DerelictHouseDrugs", min=0, max=1, weightChance=5},
				{name="DerelictHouseCrime", min=0, max=1, weightChance=5},
				{name="DerelictHouseSquatter", min=0, max=1, weightChance=5},
				{name="DerelictHouseJunk", min=0, max=99, weightChance=100},
			}
		},
	},
	
	detectiveoffice = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="PoliceFileBox", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="BreakRoomCounter", min=0, max=99},
			}
		},
		desk = {
			procedural = true,
			procList = {
				{name="PoliceDesk", min=0, max=99},
			}
		},
		filingcabinet = {
			procedural = true,
			procList = {
				{name="PoliceFilingCabinet", min=0, max=99},
			}
		},
	},
	
	dinerbackroom = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="DinerBackRoomCounter", min=0, max=1, weightChance=100},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="DinerKitchenFreezer", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="DinerKitchenFridge", min=0, max=99},
			}
		},
	},
	
	dinercounter = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="StoreKitchenGlasses", min=0, max=99, forceForTiles="location_shop_accessories_01_8;location_shop_accessories_01_9;location_shop_accessories_01_12;location_shop_accessories_01_13"},
				{name="CafeKitchenMugs", min=0, max=99, forceForTiles="appliances_cooking_01_56;appliances_cooking_01_57;appliances_cooking_01_58;appliances_cooking_01_59;appliances_cooking_01_60;appliances_cooking_01_61;appliances_cooking_01_62;appliances_cooking_01_63"},
				{name="StoreKitchenCutlery", min=0, max=4, weightChance=40},
				{name="StoreKitchenDishes", min=0, max=2, weightChance=80},
				{name="StoreKitchenTrays", min=0, max=2, weightChance=100},
				
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="DinerKitchenFreezer", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="DinerKitchenFridge", min=0, max=99},
			}
		},
	},
	
	dinerkitchen = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateBunsBurger", min=0, max=1, weightChance=40},
				{name="CrateBunsHotdog", min=0, max=1, weightChance=40},
				{name="CrateCondiments", min=0, max=1, weightChance=80},
				{name="CrateFlour", min=0, max=1, weightChance=60},
				{name="CrateGravyMix", min=0, max=1, weightChance=20},
				{name="CrateOilVegetable", min=0, max=1, weightChance=60},
				{name="FryFactoryPotatoes", min=0, max=2, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="StoreKitchenBaking", min=0, max=1, weightChance=100},
				{name="StoreKitchenButcher", min=1, max=1, weightChance=80},
				{name="StoreKitchenCafe", min=0, max=1, weightChance=100},
				{name="StoreKitchenCutlery", min=0, max=1, weightChance=20},
				{name="StoreKitchenDishes", min=0, max=1, weightChance=20},
				{name="StoreKitchenGlasses", min=0, max=1, weightChance=20},
				{name="StoreKitchenPotatoes", min=0, max=1, weightChance=20},
				{name="StoreKitchenPots", min=0, max=1, weightChance=20},
				{name="StoreKitchenSauce", min=0, max=1, weightChance=20},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateBunsBurger", min=0, max=1, weightChance=40},
				{name="CrateBunsHotdog", min=0, max=1, weightChance=40},
				{name="CrateCondiments", min=0, max=1, weightChance=80},
				{name="CrateFlour", min=0, max=1, weightChance=60},
				{name="CrateGravyMix", min=0, max=1, weightChance=20},
				{name="CrateOilVegetable", min=0, max=1, weightChance=60},
				{name="FryFactoryPotatoes", min=0, max=2, weightChance=100},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="DinerKitchenFreezer", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="DinerKitchenFridge", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateBunsBurger", min=0, max=1, weightChance=40},
				{name="CrateBunsHotdog", min=0, max=1, weightChance=40},
				{name="CrateCondiments", min=0, max=1, weightChance=80},
				{name="CrateFlour", min=0, max=1, weightChance=60},
				{name="CrateGravyMix", min=0, max=1, weightChance=20},
				{name="CrateOilVegetable", min=0, max=1, weightChance=60},
				{name="FryFactoryPotatoes", min=0, max=2, weightChance=100},
			}
		},
		restaurantdisplay = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="ServingTrayBurgers", min=0, max=1, weightChance=80},
				{name="ServingTrayChicken", min=0, max=1, weightChance=80},
				{name="ServingTrayChickenFried", min=0, max=1, weightChance=100},
				{name="ServingTrayChickenNuggets", min=0, max=1, weightChance=100},
				{name="ServingTrayChickenWings", min=0, max=1, weightChance=100},
				{name="ServingTrayFishFingers", min=0, max=1, weightChance=100},
				{name="ServingTrayFries", min=0, max=1, weightChance=100},
				{name="ServingTrayHam", min=0, max=1, weightChance=80},
				{name="ServingTrayHotdogs", min=0, max=1, weightChance=80},
				{name="ServingTrayOnionRings", min=0, max=1, weightChance=100},
				{name="ServingTrayPorkChops", min=0, max=1, weightChance=80},
				{name="ServingTraySausage", min=0, max=1, weightChance=80},
				{name="ServingTraySteak", min=0, max=1, weightChance=60},
				{name="ServingTrayTatoDots", min=0, max=1, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateBunsBurger", min=0, max=1, weightChance=40},
				{name="CrateBunsHotdog", min=0, max=1, weightChance=40},
				{name="CrateCondiments", min=0, max=1, weightChance=80},
				{name="CrateFlour", min=0, max=1, weightChance=60},
				{name="CrateGravyMix", min=0, max=1, weightChance=20},
				{name="CrateOilVegetable", min=0, max=1, weightChance=60},
				{name="FryFactoryPotatoes", min=0, max=2, weightChance=100},
			}
		},
	},
	
	dining = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="BarCounterLiquor", min=0, max=99, forceForTiles="location_restaurant_bar_01_0;location_restaurant_bar_01_1;location_restaurant_bar_01_2;location_restaurant_bar_01_3;location_restaurant_bar_01_4;location_restaurant_bar_01_5;location_restaurant_bar_01_6;location_restaurant_bar_01_7;location_restaurant_bar_01_16;location_restaurant_bar_01_17;location_restaurant_bar_01_18;location_restaurant_bar_01_19;location_restaurant_bar_01_20;location_restaurant_bar_01_21;location_restaurant_bar_01_22;location_restaurant_bar_01_23;location_restaurant_bar_01_56;location_restaurant_bar_01_57;location_restaurant_bar_01_58;location_restaurant_bar_01_59;location_restaurant_bar_01_60;location_restaurant_bar_01_61;location_restaurant_bar_01_62;location_restaurant_bar_01_63"},
				{name="RestaurantMenus", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
			}
		},
		restaurantdisplay = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="BakeryDoughnuts", min=0, max=1, weightChance=20},
				{name="ServingTrayBurgers", min=1, max=2, weightChance=100},
				{name="ServingTrayBurritos", min=0, max=1, weightChance=20},
				{name="ServingTrayChickenNuggets", min=0, max=1, weightChance=80},
				{name="ServingTrayChickenWings", min=0, max=1, weightChance=80},
				{name="ServingTrayFries", min=1, max=2, weightChance=60},
				{name="ServingTrayGravy", min=1, max=2, weightChance=20},
				{name="ServingTrayHotdogs", min=0, max=1, weightChance=40},
				{name="ServingTrayOmelettes", min=0, max=1, weightChance=20},
				{name="ServingTrayOnionRings", min=0, max=1, weightChance=40},
				{name="ServingTrayPancakes", min=0, max=1, weightChance=20},
				{name="ServingTrayPotatoPancakes", min=0, max=1, weightChance=20},
				{name="ServingTrayPie", min=0, max=1, weightChance=40},
				{name="ServingTrayPizza", min=0, max=1, weightChance=40},
				{name="ServingTrayScrambledEggs", min=0, max=1, weightChance=20},
				{name="ServingTrayWaffles", min=0, max=1, weightChance=20},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="BarShelfLiquor", min=0, max=99, forceForTiles="location_restaurant_bar_01_29;location_restaurant_bar_01_30;location_restaurant_bar_01_31;location_restaurant_bar_01_37;location_restaurant_bar_01_38;location_restaurant_bar_01_39;location_restaurant_bar_01_64;location_restaurant_bar_01_65;location_restaurant_bar_01_66;location_restaurant_bar_01_72;location_restaurant_bar_01_73;location_restaurant_bar_01_74"},
			}
		}
	},
	
	dogfoodfactory = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="DogFoodFactoryBones", min=0, max=4, weightChance=40},
				{name="DogFoodFactoryBags", min=0, max=99, weightChance=100},
				{name="DogFoodFactoryCans", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="DogFoodFactoryEquipment", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="DogFoodFactoryBones", min=0, max=4, weightChance=40},
				{name="DogFoodFactoryBags", min=0, max=99, weightChance=100},
				{name="DogFoodFactoryCans", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="DogFoodFactoryBags", min=0, max=99, weightChance=100},
				{name="DogFoodFactoryCans", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="DogFoodFactoryBones", min=0, max=4, weightChance=40},
				{name="DogFoodFactoryBags", min=0, max=99, weightChance=100},
				{name="DogFoodFactoryCans", min=0, max=99, weightChance=100},
			}
		},
	},
	
	dogfoodshipping = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="DogFoodFactoryBags", min=0, max=99, weightChance=100},
				{name="DogFoodFactoryCans", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="DogFoodFactoryBags", min=0, max=99, weightChance=100},
				{name="DogFoodFactoryCans", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="DogFoodFactoryBags", min=0, max=99, weightChance=100},
				{name="DogFoodFactoryCans", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="DogFoodFactoryBags", min=0, max=99, weightChance=100},
				{name="DogFoodFactoryCans", min=0, max=99, weightChance=100},
			}
		},
	},
	
	dogfoodstorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="DogFoodFactoryBags", min=0, max=99, weightChance=100},
				{name="DogFoodFactoryCans", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="DogFoodFactoryBags", min=0, max=99, weightChance=100},
				{name="DogFoodFactoryCans", min=0, max=99, weightChance=100},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			rolls = 1,
			items = {
				
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="DogFoodFactoryBags", min=0, max=99, weightChance=100},
				{name="DogFoodFactoryCans", min=0, max=99, weightChance=100},
			}
		},
	},
	
	donut_dining = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="CafeKitchenMugs", min=0, max=99, forceForTiles="appliances_cooking_01_56;appliances_cooking_01_57;appliances_cooking_01_58;appliances_cooking_01_59;appliances_cooking_01_60;appliances_cooking_01_61;appliances_cooking_01_62;appliances_cooking_01_63"},
				{name="StoreKitchenCafe", min=1, max=2, weightChance=100},
			}
		},
		displaycasebakery = {
			procedural = true,
			procList = {
				{name="BakeryDoughnuts", min=1, max=99},
			}
		},
	},
	
	donut_kitchen = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="BakeryKitchenStorage", min=0, max=1, weightChance=100},
				{name="CrateFlour", min=0, max=1, weightChance=80},
				{name="CrateOilVegetable", min=0, max=1, weightChance=80},
				{name="CrateSugar", min=0, max=1, weightChance=80},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="BakeryKitchenBaking", min=0, max=4, weightChance=100},
				{name="StoreKitchenCafe", min=0, max=2, weightChance=100},
				{name="StoreKitchenCutlery", min=0, max=1, weightChance=20},
				{name="StoreKitchenDishes", min=0, max=1, weightChance=20},
				{name="StoreKitchenPots", min=0, max=1, weightChance=20},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="BakeryKitchenStorage", min=0, max=1, weightChance=100},
				{name="CrateFlour", min=0, max=1, weightChance=80},
				{name="CrateOilVegetable", min=0, max=1, weightChance=80},
				{name="CrateSugar", min=0, max=1, weightChance=80},
			}
		},
		displaycasebakery = {
			procedural = true,
			procList = {
				{name="BakeryDoughnuts", min=1, max=99, weightChance=100},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="BakeryKitchenFreezer", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="BakeryKitchenFridge", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="BakeryKitchenStorage", min=0, max=1, weightChance=100},
				{name="CrateFlour", min=0, max=1, weightChance=80},
				{name="CrateOilVegetable", min=0, max=1, weightChance=80},
				{name="CrateSugar", min=0, max=1, weightChance=80},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="BakeryKitchenStorage", min=0, max=1, weightChance=100},
				{name="CrateFlour", min=0, max=1, weightChance=80},
				{name="CrateOilVegetable", min=0, max=1, weightChance=80},
				{name="CrateSugar", min=0, max=1, weightChance=80},
			}
		},
	},
	
	donut_kitchenstorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="BakeryKitchenStorage", min=0, max=1, weightChance=100},
				{name="CrateFlour", min=0, max=1, weightChance=80},
				{name="CrateOilVegetable", min=0, max=1, weightChance=80},
				{name="CrateSugar", min=0, max=1, weightChance=80},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="BakeryKitchenStorage", min=0, max=1, weightChance=100},
				{name="CrateFlour", min=0, max=1, weightChance=80},
				{name="CrateOilVegetable", min=0, max=1, weightChance=80},
				{name="CrateSugar", min=0, max=1, weightChance=80},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="BakeryKitchenFreezer", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="BakeryKitchenFridge", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="BakeryKitchenStorage", min=0, max=1, weightChance=100},
				{name="CrateFlour", min=0, max=1, weightChance=80},
				{name="CrateOilVegetable", min=0, max=1, weightChance=80},
				{name="CrateSugar", min=0, max=1, weightChance=80},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="BakeryKitchenStorage", min=0, max=1, weightChance=100},
				{name="CrateFlour", min=0, max=1, weightChance=80},
				{name="CrateOilVegetable", min=0, max=1, weightChance=80},
				{name="CrateSugar", min=0, max=1, weightChance=80},
			}
		},
	},
	
	druglab = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="DrugLabSupplies", min=1, max=99, weightChance=100},
				{name="DrugLabMoney", min=0, max=1, weightChance=40},
				{name="DrugLabGuns", min=0, max=1, weightChance=20},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="DrugLabOutfit", min=1, max=99, weightChance=100},
				{name="DrugLabSupplies", min=1, max=99, weightChance=40},
				{name="DrugLabMoney", min=0, max=1, weightChance=10},
				{name="DrugShackDrugs", min=0, max=1, weightChance=20},
				{name="DrugShackTools", min=0, max=1, weightChance=20},
				{name="DrugShackWeapons", min=0, max=1, weightChance=20},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="DrugLabSupplies", min=1, max=99, weightChance=100},
				{name="DrugLabMoney", min=0, max=1, weightChance=40},
				{name="DrugLabGuns", min=0, max=1, weightChance=20},
			}
		},
		desk = {
			procedural = true,
			procList = {
				{name="DrugLabSupplies", min=1, max=99, weightChance=100},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="FreezerDrugLab", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeDrugLab", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="DrugLabGuns", min=1, max=99, weightChance=100},
				{name="DrugLabMoney", min=0, max=1, weightChance=20},
			}
		},
		overhead = {
			procedural = true,
			procList = {
				{name="DrugLabOutfit", min=1, max=99, weightChance=100},
				{name="DrugLabSupplies", min=1, max=99, weightChance=40},
				{name="DrugLabMoney", min=0, max=1, weightChance=10},
				{name="DrugShackDrugs", min=0, max=1, weightChance=20},
				{name="DrugShackTools", min=0, max=1, weightChance=20},
				{name="DrugShackWeapons", min=0, max=1, weightChance=20},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="DrugLabSupplies", min=1, max=99, weightChance=100},
				{name="DrugLabMoney", min=0, max=1, weightChance=40},
				{name="DrugLabGuns", min=0, max=1, weightChance=20},
			}
		},
	},
	
	drugshack = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="DrugShackDrugs", min=0, max=1, weightChance=60},
				{name="DrugShackTools", min=0, max=1, weightChance=40},
				{name="DrugShackWeapons", min=0, max=1, weightChance=20},
				{name="DrugShackMisc", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="DrugShackDrugs", min=1, max=99, weightChance=40},
				{name="DrugShackTools", min=1, max=99, weightChance=100},
				{name="DrugShackMisc", min=1, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="DrugShackDrugs", min=0, max=1, weightChance=60},
				{name="DrugShackTools", min=0, max=1, weightChance=40},
				{name="DrugShackWeapons", min=0, max=1, weightChance=20},
				{name="DrugShackMisc", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="DrugShackDrugs", min=0, max=1, weightChance=60},
				{name="DrugShackTools", min=0, max=1, weightChance=40},
				{name="DrugShackWeapons", min=0, max=1, weightChance=20},
				{name="DrugShackMisc", min=0, max=99, weightChance=100},
			}
		},
		stove = ClutterTables.BinJunk,
	},
	
	duckshootgame = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="CarnivalPrizes", min=0, max=4, weightChance=100},
			}
		}
	},
	
	eggstorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateEggs", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateEggs", min=0, max=99},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="CrateEggs", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateEggs", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateEggs", min=0, max=99},
			}
		},
	},
	
	electronicsstorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateGenerator", min=0, max=1, weightChance=1},
				{name="CrateTV", min=0, max=1, weightChance=5},
				{name="CrateTVWide", min=0, max=1, weightChance=5},
				{name="ElectronicStoreCases", min=0, max=2, weightChance=20},
				{name="ElectronicStoreAppliances", min=0, max=4, weightChance=60},
				{name="ElectronicStoreComputers", min=0, max=4, weightChance=80},
				{name="ElectronicStorePhones", min=0, max=4, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateGenerator", min=0, max=1, weightChance=1},
				{name="CrateTV", min=0, max=1, weightChance=5},
				{name="CrateTVWide", min=0, max=1, weightChance=5},
				{name="ElectronicStoreCases", min=0, max=2, weightChance=20},
				{name="ElectronicStoreAppliances", min=0, max=4, weightChance=60},
				{name="ElectronicStoreComputers", min=0, max=4, weightChance=80},
				{name="ElectronicStorePhones", min=0, max=4, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="ElectronicStoreCases", min=0, max=2, weightChance=20},
				{name="ElectronicStoreAppliances", min=0, max=4, weightChance=60},
				{name="ElectronicStoreComputers", min=0, max=4, weightChance=80},
				{name="ElectronicStorePhones", min=0, max=4, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="ElectronicStoreMisc", min=0, max=99}
			}
		},
	},
	
	electronicstore = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateGenerator", min=0, max=1, weightChance=1},
				{name="CrateTV", min=0, max=1, weightChance=5},
				{name="CrateTVWide", min=0, max=1, weightChance=5},
				{name="ElectronicStoreCases", min=0, max=2, weightChance=20},
				{name="ElectronicStoreAppliances", min=0, max=4, weightChance=60},
				{name="ElectronicStoreComputers", min=0, max=4, weightChance=80},
				{name="ElectronicStorePhones", min=0, max=4, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23;fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="StoreCounterBags", min=0, max=1, weightChance=100},
				{name="ElectronicStoreLights", min=0, max=1, weightChance=10},
				{name="ElectronicStoreMusic", min=0, max=1, weightChance=10},
				{name="ElectronicStorePhones", min=0, max=2, weightChance=20},
				{name="ElectronicStoreMagazines", min=0, max=99, weightChance=80},
				{name="ElectronicStoreMisc", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateGenerator", min=0, max=1, weightChance=1},
				{name="CrateTV", min=0, max=1, weightChance=5},
				{name="CrateTVWide", min=0, max=1, weightChance=5},
				{name="ElectronicStoreCases", min=0, max=2, weightChance=20},
				{name="ElectronicStoreAppliances", min=0, max=4, weightChance=60},
				{name="ElectronicStoreComputers", min=0, max=4, weightChance=80},
				{name="ElectronicStorePhones", min=0, max=4, weightChance=100},
			}
		},
		displaycase = {
			procedural = true,
			procList = {
				{name="StoreDisplayWatches", min=0, max=99},
			}
		},
		locker = {
			procedural = true,
			procList = {
				{name="GeneratorRoom", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="ElectronicStoreCases", min=0, max=1, weightChance=10},
				{name="ElectronicStoreHAMRadio", min=0, max=1, weightChance=10},
				{name="ElectronicStoreLights", min=1, max=2, weightChance=20},
				{name="ElectronicStoreMusic", min=1, max=2, weightChance=20},
				{name="ElectronicStoreAppliances", min=1, max=4, weightChance=40},
				{name="ElectronicStoreComputers", min=1, max=4, weightChance=40},
				{name="ElectronicStorePhones", min=1, max=4, weightChance=40},
				{name="ElectronicStoreMagazines", min=0, max=99, weightChance=60},
				{name="ElectronicStoreMisc", min=0, max=99, weightChance=100},
				{name="StoreShelfCombo", min=0, max=99, forceForTiles="location_shop_generic_01_0;location_shop_generic_01_1"},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="ElectronicStoreMisc", min=0, max=99},
			}
		},
	},
	
	-- TODO: Set up specific containers for these.
	elementaryclassroom = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateSkeletonDisplay", min=0, max=1, weightChance=1},
				{name="CrateBooksSchool", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="ClassroomMisc", min=0, max=99},
			}
		},
		desk = {
			procedural = true,
			procList = {
				{name="ClassroomDesk", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="ClassroomShelves", min=0, max=99, weightChance=100},
				{name="ScienceMisc", min=0, max=1, weightChance=10},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="ClassroomShelves", min=0, max=99},
			}
		},
		wardrobe = {
			procedural = true,
			procList = {
				{name="ClassroomShelves", min=0, max=99, weightChance=100},
				{name="ScienceMisc", min=0, max=1, weightChance=10},
			}
		},
	},
	
	-- TODO: Set up specific containers for these.
	elementaryschool = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateSkeletonDisplay", min=0, max=1, weightChance=1},
				{name="CrateBooksSchool", min=0, max=99, weightChance=100},
			}
		},
		locker = {
			procedural = true,
			procList = {
				{name="SchoolLockersBad", min=0, max=1, weightChance=10},
				{name="SchoolLockers", min=0, max=99},
			}
		}
	},
	
	empty = {
		other = {
			rolls = 1,
			items = {
				
			}
		},
	},
	
	evidenceroom = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="PoliceEvidence", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="PoliceEvidence", min=0, max=99},
			}
		},
	},
	
	factory = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="ToolFactoryBarStock", min=0, max=99, weightChance=40},
				{name="ToolFactoryHandles", min=0, max=99, weightChance=40},
				{name="ToolFactoryIngots", min=0, max=99, weightChance=20},
				{name="ToolFactorySawBlades", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="ToolFactoryTools", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="ToolFactoryBarStock", min=0, max=99, weightChance=40},
				{name="ToolFactoryHandles", min=0, max=99, weightChance=40},
				{name="ToolFactoryIngots", min=0, max=99, weightChance=20},
				{name="ToolFactorySawBlades", min=0, max=99, weightChance=100},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeOffice", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="ToolFactoryBarStock", min=0, max=99, weightChance=100},
				{name="ToolFactoryHandles", min=0, max=99, weightChance=100},
				{name="ToolFactoryIngots", min=0, max=99, weightChance=20},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="ToolFactorySawBlades", min=0, max=99},
			}
		},
	},
	
	factorystorage = {
		locker = {
			procedural = true,
			procList = {
				{name="FactoryLockers", min=0, max=99, weightChance=100},
				{name="MechanicShelfOutfit", min=0, max=99, forceForRooms="mechanic"},
			}
		}
	},
	
	farmstorage = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateAnimalFeed", min=0, max=1, weightChance=100},
				{name="CrateFarming", min=0, max=99, weightChance=20},
				{name="CrateFertilizer", min=0, max=1, weightChance=60},
				{name="ForestFireTools", min=0, max=1, weightChance=5},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateAnimalFeed", min=0, max=1, weightChance=100},
				{name="CrateFarming", min=0, max=99, weightChance=20},
				{name="CrateFertilizer", min=0, max=1, weightChance=60},
				{name="ForestFireTools", min=0, max=1, weightChance=5},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="FreezerFarmStorage", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeFarmStorage", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateFarming", min=0, max=99, weightChance=100},
				{name="CrateTools", min=0, max=1, weightChance=10},
				{name="ForestFireTools", min=0, max=1, weightChance=5},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateFarming", min=0, max=99, weightChance=100},
				{name="ForestFireTools", min=0, max=1, weightChance=5},
			}
		},
	},

	firegarage = {
		bin = {
			procedural = true,
			procList = {
				{name="BinFireStation", min=0, max=99, weightChance=100},
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="FireStorageTools", min=0, max=99, weightChance=40},
				{name="FireStorageOutfit", min=0, max=99, weightChance=20},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="FireStorageMechanics", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="FireStorageTools", min=0, max=99, weightChance=40},
				{name="FireStorageOutfit", min=0, max=99, weightChance=20},
			}
		},
		locker = {
			procedural = true,
			procList = {
				{name="FireDeptLockers", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="FireStorageTools", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="FireStorageOutfit", min=0, max=99, weightChance=20},
				{name="CrateBootsOld", min=0, max=99, weightChance=100},
			}
		},
		toolcabinet = {
			procedural = true,
			procList = {
				{name="FireStorageMechanics", min=0, max=99},
			}
		},
	},

	firestorage = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="FireStorageTools", min=0, max=99, weightChance=100},
				{name="FireStorageOutfit", min=0, max=99, weightChance=40},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="FireStorageTools", min=0, max=99, weightChance=100},
				{name="FireStorageOutfit", min=0, max=99, weightChance=40},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="FireStorageTools", min=0, max=99, weightChance=100},
				{name="FireStorageOutfit", min=0, max=99, weightChance=40},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="FireStorageOutfit", min=0, max=99},
			}
		},
	},
	
	fishchipskitchen = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateCondiments", min=0, max=1, weightChance=60},
				{name="CrateCornflour", min=0, max=1, weightChance=20},
				{name="CrateFlour", min=0, max=1, weightChance=80},
				{name="CrateGravyMix", min=0, max=1, weightChance=40},
				{name="CrateOilVegetable", min=0, max=1, weightChance=100},
				{name="FryFactoryPotatoes", min=0, max=2, weightChance=80},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="FishChipsKitchenButcher", min=0, max=1, weightChance=100},
				{name="FishChipsKitchenSauce", min=0, max=1, weightChance=100},
				{name="JaysKitchenBaking", min=0, max=1, weightChance=100},
				{name="StoreKitchenCutlery", min=0, max=1, weightChance=20},
				{name="StoreKitchenDishes", min=0, max=1, weightChance=20},
				{name="StoreKitchenGlasses", min=0, max=1, weightChance=20},
				{name="StoreKitchenPotatoes", min=0, max=1, weightChance=100},
				{name="StoreKitchenPots", min=0, max=1, weightChance=20},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateCondiments", min=0, max=1, weightChance=60},
				{name="CrateCornflour", min=0, max=1, weightChance=20},
				{name="CrateFlour", min=0, max=1, weightChance=80},
				{name="CrateGravyMix", min=0, max=1, weightChance=40},
				{name="CrateOilVegetable", min=0, max=1, weightChance=100},
				{name="FryFactoryPotatoes", min=0, max=2, weightChance=80},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="FishChipsKitchenFreezer", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FishChipsKitchenFreezer", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateCornflour", min=0, max=1, weightChance=100},
				{name="CrateFlour", min=0, max=1, weightChance=100},
				{name="CrateGravyMix", min=0, max=1, weightChance=100},
				{name="CrateOilVegetable", min=0, max=1, weightChance=100},
				{name="CrateYeast", min=0, max=1, weightChance=100},
				{name="FryFactoryPotatoes", min=0, max=2, weightChance=100},
			}
		},
		restaurantdisplay = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="ServingTrayBiscuits", min=1, max=2, weightChance=60},
				{name="ServingTrayFish", min=1, max=4, weightChance=100},
				{name="ServingTrayFries", min=1, max=4, weightChance=100},
				{name="ServingTrayGravy", min=1, max=2, weightChance=20},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateCondiments", min=0, max=1, weightChance=60},
				{name="CrateCornflour", min=0, max=1, weightChance=20},
				{name="CrateFlour", min=0, max=1, weightChance=80},
				{name="CrateGravyMix", min=0, max=1, weightChance=40},
				{name="CrateOilVegetable", min=0, max=1, weightChance=100},
				{name="FryFactoryPotatoes", min=0, max=2, weightChance=80},
			}
		},
	},
	
	fishingstorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="FishingStoreGear", min=0, max=99},
			}
		},
		clothingrack = {
			procedural = true,
			procList = {
				{name="CampingStoreClothes", min=0, max=99, weightChance=100},
				{name="CampingStoreLegwear", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreCounterBags", min=0, max=1, weightChance=100},
				{name="CampingStoreBooks", min=0, max=2, weightChance=80},
				{name="CampingStoreLegwear", min=0, max=2, weightChance=40},
				{name="CampingStoreBackpacks", min=0, max=2, weightChance=20},
				{name="CampingStoreGear", min=0, max=2, weightChance=60},
				{name="FishingStoreGear", min=0, max=12, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CampingStoreGear", min=0, max=99, weightChance=40},
				{name="FishingStoreGear", min=0, max=99, weightChance=100},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="FishingStoreBait", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FishingStoreBait", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CampingStoreGear", min=0, max=99, weightChance=40},
				{name="FishingStoreGear", min=0, max=99, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="CampingStoreTents", min=1, max=2, weightChance=10},
				{name="CampingStoreGear", min=0, max=99, weightChance=40},
				{name="FishingStoreGear", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="FishingStoreGear", min=0, max=99},
			}
		},
	},
	
	fossoil = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99, weightChance=80},
				{name="GasStorageMechanics", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_fossoil_01_10;location_shop_fossoil_01_11;location_shop_accessories_01_10;location_shop_accessories_01_11;location_shop_accessories_01_8;location_shop_accessories_01_9;location_shop_accessories_01_12;location_shop_accessories_01_13"},
				{name="FossoilCounterCleaning", min=0, max=1, weightChance=100},
				{name="StoreCounterBags", min=0, max=4, weightChance=20},
				{name="StoreCounterTobacco", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99, weightChance=80},
				{name="GasStorageMechanics", min=0, max=99, weightChance=100},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="FreezerIceCream", min=0, max=99, forceForTiles="appliances_refrigeration_01_20;appliances_refrigeration_01_21;appliances_refrigeration_01_38;appliances_refrigeration_01_39"},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeOther", min=1, max=99, weightChance=40},
				{name="FridgeSnacks", min=1, max=99, weightChance=100},
				{name="FridgeSoda", min=1, max=99, weightChance=100},
				{name="FridgeWater", min=1, max=99, weightChance=60},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99, weightChance=80},
				{name="GasStorageMechanics", min=0, max=99, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="GasStoreEmergency", min=1, max=1, weightChance=20},
				{name="GasStoreToiletries", min=0, max=1, weightChance=40},
				{name="GigamartCleaning", min=0, max=1, weightChance=20},
				{name="MovieRentalShelves", min=0, max=99, forceForTiles="location_entertainment_theatre_01_120;location_entertainment_theatre_01_121;location_entertainment_theatre_01_122;location_entertainment_theatre_01_123;location_entertainment_theatre_01_124;location_entertainment_theatre_01_125;location_entertainment_theatre_01_126;location_entertainment_theatre_01_127;location_entertainment_theatre_01_128;location_entertainment_theatre_01_129;location_entertainment_theatre_01_130;location_entertainment_theatre_01_131;location_entertainment_theatre_01_132;location_entertainment_theatre_01_133;location_entertainment_theatre_01_134;location_entertainment_theatre_01_135"},
				{name="StoreCounterTobacco", min=0, max=99, forceForTiles="location_shop_generic_01_28;location_shop_generic_01_29;location_shop_generic_01_30;location_shop_generic_01_31"},
				{name="StoreShelfCombo", min=0, max=99, forceForTiles="location_shop_generic_01_0;location_shop_generic_01_1"},
				{name="StoreShelfDrinks", min=0, max=99, weightChance=100},
				{name="StoreShelfMechanics", min=0, max=99, forceForTiles="location_shop_generic_01_3;location_shop_generic_01_4"},
				{name="StoreShelfMedical", min=0, max=1, weightChance=20},
				{name="StoreShelfSnacks", min=0, max=99, weightChance=100},
			}
		},
		shelvesmag = {
			procedural = true,
			procList = {
				{name="MagazineRackMaps", min=1, max=4, weightChance=40},
				{name="MagazineRackMixed", min=1, max=99, weightChance=100},
				{name="MagazineRackNewspaper", min=1, max=4, weightChance=40},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99, weightChance=80},
				{name="GasStorageMechanics", min=0, max=99, weightChance=100},
			}
		},
	},
	
	fryshipping = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="FryFactoryPotatoes", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="FryFactoryPotatoes", min=0, max=99},
			}
		},
	},
	
	furniturestorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateBlueComfyChair", min=0, max=1, weightChance=20},
				{name="CrateBlueRattanChair", min=0, max=1, weightChance=20},
				{name="CrateBrownComfyChair", min=0, max=1, weightChance=20},
				{name="CrateBrownLowTables", min=0, max=1, weightChance=20},
				{name="CrateChestFreezer", min=0, max=1, weightChance=80},
				{name="CrateDarkBlueChairs", min=0, max=1, weightChance=20},
				{name="CrateDarkWoodenChairs", min=0, max=1, weightChance=20},
				{name="CrateFancyBlackChairs", min=0, max=1, weightChance=20},
				{name="CrateFancyDarkTables", min=0, max=1, weightChance=20},
				{name="CrateFancyLowTables", min=0, max=1, weightChance=20},
				{name="CrateFancyToilets", min=0, max=1, weightChance=40},
				{name="CrateFancyWhiteChairs", min=0, max=1, weightChance=60},
				{name="CrateGreenChairs", min=0, max=1, weightChance=40},
				{name="CrateGreenComfyChair", min=0, max=1, weightChance=20},
				{name="CrateGreenOven", min=0, max=1, weightChance=40},
				{name="CrateGreyChairs", min=0, max=1, weightChance=20},
				{name="CrateGreyComfyChair", min=0, max=1, weightChance=20},
				{name="CrateGreyOven", min=0, max=1, weightChance=40},
				{name="CrateIndustrialSinks", min=0, max=1, weightChance=40},
				{name="CrateLightRoundTable", min=0, max=1, weightChance=20},
				{name="CrateMetalLockers", min=0, max=1, weightChance=20},
				{name="CrateModernOven", min=0, max=1, weightChance=40},
				{name="CrateOakRoundTable", min=0, max=1, weightChance=20},
				{name="CrateOfficeChairs", min=0, max=1, weightChance=40},
				{name="CrateOrangeModernChair", min=0, max=1, weightChance=20},
				{name="CratePurpleRattanChair", min=0, max=1, weightChance=20},
				{name="CratePurpleWoodenChairs", min=0, max=1, weightChance=20},
				{name="CrateRedChairs", min=0, max=1, weightChance=20},
				{name="CrateRedOven", min=0, max=1, weightChance=40},
				{name="CrateRedWoodenChairs", min=0, max=1, weightChance=20},
				{name="CrateRoundTable", min=0, max=1, weightChance=20},
				{name="CrateWhiteComfyChair", min=0, max=1, weightChance=20},
				{name="CrateWhiteSimpleChairs", min=0, max=1, weightChance=20},
				{name="CrateWhiteSinks", min=0, max=1, weightChance=40},
				{name="CrateWhiteWoodenChairs", min=0, max=1, weightChance=20},
				{name="CrateWoodenChairs", min=0, max=1, weightChance=20},
				{name="CrateWoodenStools", min=0, max=1, weightChance=20},
				{name="CrateYellowModernChair", min=0, max=1, weightChance=20},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateBlueComfyChair", min=0, max=1, weightChance=20},
				{name="CrateBlueRattanChair", min=0, max=1, weightChance=20},
				{name="CrateBrownComfyChair", min=0, max=1, weightChance=20},
				{name="CrateBrownLowTables", min=0, max=1, weightChance=20},
				{name="CrateChestFreezer", min=0, max=1, weightChance=80},
				{name="CrateDarkBlueChairs", min=0, max=1, weightChance=20},
				{name="CrateDarkWoodenChairs", min=0, max=1, weightChance=20},
				{name="CrateFancyBlackChairs", min=0, max=1, weightChance=20},
				{name="CrateFancyDarkTables", min=0, max=1, weightChance=20},
				{name="CrateFancyLowTables", min=0, max=1, weightChance=20},
				{name="CrateFancyToilets", min=0, max=1, weightChance=40},
				{name="CrateFancyWhiteChairs", min=0, max=1, weightChance=60},
				{name="CrateGreenChairs", min=0, max=1, weightChance=40},
				{name="CrateGreenComfyChair", min=0, max=1, weightChance=20},
				{name="CrateGreenOven", min=0, max=1, weightChance=40},
				{name="CrateGreyChairs", min=0, max=1, weightChance=20},
				{name="CrateGreyComfyChair", min=0, max=1, weightChance=20},
				{name="CrateGreyOven", min=0, max=1, weightChance=40},
				{name="CrateIndustrialSinks", min=0, max=1, weightChance=40},
				{name="CrateLightRoundTable", min=0, max=1, weightChance=20},
				{name="CrateMetalLockers", min=0, max=1, weightChance=20},
				{name="CrateModernOven", min=0, max=1, weightChance=40},
				{name="CrateOakRoundTable", min=0, max=1, weightChance=20},
				{name="CrateOfficeChairs", min=0, max=1, weightChance=40},
				{name="CrateOrangeModernChair", min=0, max=1, weightChance=20},
				{name="CratePurpleRattanChair", min=0, max=1, weightChance=20},
				{name="CratePurpleWoodenChairs", min=0, max=1, weightChance=20},
				{name="CrateRedChairs", min=0, max=1, weightChance=20},
				{name="CrateRedOven", min=0, max=1, weightChance=40},
				{name="CrateRedWoodenChairs", min=0, max=1, weightChance=20},
				{name="CrateRoundTable", min=0, max=1, weightChance=20},
				{name="CrateWhiteComfyChair", min=0, max=1, weightChance=20},
				{name="CrateWhiteSimpleChairs", min=0, max=1, weightChance=20},
				{name="CrateWhiteSinks", min=0, max=1, weightChance=40},
				{name="CrateWhiteWoodenChairs", min=0, max=1, weightChance=20},
				{name="CrateWoodenChairs", min=0, max=1, weightChance=20},
				{name="CrateWoodenStools", min=0, max=1, weightChance=20},
				{name="CrateYellowModernChair", min=0, max=1, weightChance=20},
			}
		},
		other = {
			rolls = 1,
			items = {
				
			}
		},
	},
	
	furniturestore = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateBlueComfyChair", min=0, max=1, weightChance=60},
				{name="CrateBluePlasticChairs", min=0, max=1, weightChance=100},
				{name="CrateBlueRattanChair", min=0, max=1, weightChance=40},
				{name="CrateBrownComfyChair", min=0, max=1, weightChance=60},
				{name="CrateBrownLowTables", min=0, max=1, weightChance=40},
				{name="CrateDarkBlueChairs", min=0, max=1, weightChance=80},
				{name="CrateDarkWoodenChairs", min=0, max=1, weightChance=80},
				{name="CrateFancyBlackChairs", min=0, max=1, weightChance=60},
				{name="CrateFancyDarkTables", min=0, max=1, weightChance=40},
				{name="CrateFancyLowTables", min=0, max=1, weightChance=40},
				{name="CrateFancyWhiteChairs", min=0, max=1, weightChance=60},
				{name="CrateFoldingChairs", min=0, max=1, weightChance=100},
				{name="CrateGreenChairs", min=0, max=1, weightChance=80},
				{name="CrateGreenComfyChair", min=0, max=1, weightChance=60},
				{name="CrateGreyChairs", min=0, max=1, weightChance=80},
				{name="CrateGreyComfyChair", min=0, max=1, weightChance=60},
				{name="CrateLightRoundTable", min=0, max=1, weightChance=60},
				{name="CrateOakRoundTable", min=0, max=1, weightChance=60},
				{name="CrateOfficeChairs", min=0, max=1, weightChance=100},
				{name="CrateOrangeModernChair", min=0, max=1, weightChance=60},
				{name="CratePlasticChairs", min=0, max=1, weightChance=100},
				{name="CratePurpleRattanChair", min=0, max=1, weightChance=40},
				{name="CratePurpleWoodenChairs", min=0, max=1, weightChance=80},
				{name="CrateRedChairs", min=0, max=1, weightChance=80},
				{name="CrateRedWoodenChairs", min=0, max=1, weightChance=80},
				{name="CrateRoundTable", min=0, max=1, weightChance=40},
				{name="CrateWhiteComfyChair", min=0, max=1, weightChance=60},
				{name="CrateWhiteSimpleChairs", min=0, max=1, weightChance=80},
				{name="CrateWhiteWoodenChairs", min=0, max=1, weightChance=80},
				{name="CrateWoodenChairs", min=0, max=1, weightChance=80},
				{name="CrateWoodenStools", min=0, max=1, weightChance=80},
				{name="CrateYellowModernChair", min=0, max=1, weightChance=60},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateBlueComfyChair", min=0, max=1, weightChance=60},
				{name="CrateBluePlasticChairs", min=0, max=1, weightChance=100},
				{name="CrateBlueRattanChair", min=0, max=1, weightChance=40},
				{name="CrateBrownComfyChair", min=0, max=1, weightChance=60},
				{name="CrateBrownLowTables", min=0, max=1, weightChance=40},
				{name="CrateChromeSinks", min=0, max=1, weightChance=20},
				{name="CrateDarkBlueChairs", min=0, max=1, weightChance=80},
				{name="CrateDarkWoodenChairs", min=0, max=1, weightChance=80},
				{name="CrateFancyBlackChairs", min=0, max=1, weightChance=60},
				{name="CrateFancyDarkTables", min=0, max=1, weightChance=40},
				{name="CrateFancyLowTables", min=0, max=1, weightChance=40},
				{name="CrateFancyToilets", min=0, max=1, weightChance=20},
				{name="CrateFancyWhiteChairs", min=0, max=1, weightChance=60},
				{name="CrateFoldingChairs", min=0, max=1, weightChance=100},
				{name="CrateGreenChairs", min=0, max=1, weightChance=80},
				{name="CrateGreenComfyChair", min=0, max=1, weightChance=60},
				{name="CrateGreenOven", min=0, max=1, weightChance=20},
				{name="CrateGreyChairs", min=0, max=1, weightChance=80},
				{name="CrateGreyComfyChair", min=0, max=1, weightChance=60},
				{name="CrateGreyOven", min=0, max=1, weightChance=20},
				{name="CrateIndustrialSinks", min=0, max=1, weightChance=20},
				{name="CrateLightRoundTable", min=0, max=1, weightChance=60},
				{name="CrateMetalLockers", min=0, max=1, weightChance=40},
				{name="CrateModernOven", min=0, max=1, weightChance=20},
				{name="CrateOakRoundTable", min=0, max=1, weightChance=60},
				{name="CrateOfficeChairs", min=0, max=1, weightChance=100},
				{name="CrateOrangeModernChair", min=0, max=1, weightChance=60},
				{name="CratePlasticChairs", min=0, max=1, weightChance=100},
				{name="CratePurpleRattanChair", min=0, max=1, weightChance=40},
				{name="CratePurpleWoodenChairs", min=0, max=1, weightChance=80},
				{name="CrateRedChairs", min=0, max=1, weightChance=80},
				{name="CrateRedOven", min=0, max=1, weightChance=20},
				{name="CrateRedWoodenChairs", min=0, max=1, weightChance=80},
				{name="CrateRoundTable", min=0, max=1, weightChance=40},
				{name="CrateWhiteComfyChair", min=0, max=1, weightChance=60},
				{name="CrateWhiteSimpleChairs", min=0, max=1, weightChance=80},
				{name="CrateWhiteSinks", min=0, max=1, weightChance=20},
				{name="CrateWhiteWoodenChairs", min=0, max=1, weightChance=80},
				{name="CrateWoodenChairs", min=0, max=1, weightChance=80},
				{name="CrateWoodenStools", min=0, max=1, weightChance=80},
				{name="CrateYellowModernChair", min=0, max=1, weightChance=60},
			}
		},
		other = {
			rolls = 1,
			items = {
				
			}
		},
	},
	
	garagestorage = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="Antiques", min=0, max=1, weightChance=10},
				{name="ArtSupplies", min=0, max=1, weightChance=10},
				{name="BurglarTools", min=0, max=1, weightChance=10},
				{name="Chemistry", min=0, max=1, weightChance=10},
				{name="ClothingStorageWinter", min=0, max=1, weightChance=40},
				{name="CrateBlackBBQ", min=0, max=1, weightChance=20},
				{name="CrateBlacksmithing", min=0, max=1, weightChance=5},
				{name="CrateBluePlasticChairs", min=0, max=1, weightChance=20},
				{name="CrateBooks", min=0, max=1, weightChance=10},
				{name="CrateCamping", min=0, max=1, weightChance=80},
				{name="CrateCannedFood", min=0, max=1, weightChance=20},
				{name="CrateCannedFoodSpoiled", min=0, max=1, weightChance=20},
				{name="CrateCanning", min=0, max=1, weightChance=20},
				{name="CrateChestFreezer", min=0, max=1, weightChance=10},
				{name="CrateClayBricks", min=0, max=1, weightChance=10},
				{name="CrateClothesRandom", min=0, max=1, weightChance=80},
				{name="CrateComics", min=0, max=1, weightChance=10},
				{name="CrateCompactDiscs", min=0, max=1, weightChance=10},
				{name="CrateComputer", min=0, max=1, weightChance=10},
				{name="CrateConcrete", min=0, max=1, weightChance=10},
				{name="CrateCostume", min=0, max=1, weightChance=10},
				{name="CrateDishes", min=0, max=1, weightChance=20},
				{name="CrateElectronics", min=0, max=1, weightChance=80},
				{name="CrateFarming", min=0, max=1, weightChance=40},
				{name="CrateFertilizer", min=0, max=1, weightChance=40},
				{name="CrateFishing", min=0, max=1, weightChance=80},
				{name="CrateFitnessWeights", min=0, max=1, weightChance=40},
				{name="CrateFoldingChairs", min=0, max=1, weightChance=20},
				{name="CrateFootwearRandom", min=0, max=1, weightChance=40},
				{name="CrateGardening", min=0, max=1, weightChance=80},
				{name="CrateGravelBags", min=0, max=1, weightChance=40},
				{name="CrateInstruments", min=0, max=1, weightChance=10},
				{name="CrateLimestoneCrushed", min=0, max=1, weightChance=5},
				{name="CrateLinens", min=0, max=1, weightChance=10},
				{name="CrateLumber", min=0, max=1, weightChance=60},
				{name="CrateMagazines", min=0, max=1, weightChance=10},
				{name="CrateMasonry", min=0, max=1, weightChance=40},
				{name="CrateMechanics", min=0, max=1, weightChance=80},
				{name="CrateMetalwork", min=0, max=1, weightChance=80},
				{name="CrateNewspapers", min=0, max=1, weightChance=10},
				{name="CrateOfficeSupplies", min=0, max=1, weightChance=10},
				{name="CratePaint", min=0, max=1, weightChance=80},
				{name="CratePetSupplies", min=0, max=1, weightChance=10},
				{name="CratePhotos", min=0, max=1, weightChance=10},
				{name="CratePlaster", min=0, max=1, weightChance=40},
				{name="CratePlasticChairs", min=0, max=1, weightChance=20},
				{name="CrateRandomJunk", min=0, max=1, weightChance=100},
				{name="CrateRedBBQ", min=0, max=1, weightChance=20},
				{name="CrateSandBags", min=0, max=1, weightChance=60},
				{name="CrateSheetMetal", min=0, max=1, weightChance=40},
				{name="CrateSports", min=0, max=1, weightChance=10},
				{name="CrateTailoring", min=0, max=1, weightChance=80},
				{name="CrateTools", min=0, max=1, weightChance=60},
				{name="CrateToolsOld", min=0, max=1, weightChance=100},
				{name="CrateToys", min=0, max=1, weightChance=10},
				{name="CrateTV", min=0, max=1, weightChance=20},
				{name="CrateVHSTapes", min=0, max=1, weightChance=10},
				{name="CrateWallFinish", min=0, max=1, weightChance=100},
				{name="CrateWhiteWoodenChairs", min=0, max=1, weightChance=20},
				{name="CrateWoodenChairs", min=0, max=1, weightChance=20},
				{name="CrateWoodenStools", min=0, max=1, weightChance=20},
				{name="EngineerTools", min=0, max=1, weightChance=10},
				{name="FitnessTrainer", min=0, max=1, weightChance=10},
				{name="Gifts", min=0, max=1, weightChance=10},
				{name="Hiker", min=0, max=1, weightChance=10},
				{name="Hobbies", min=0, max=1, weightChance=10},
				{name="HolidayStuff", min=0, max=1, weightChance=10},
				{name="Homesteading", min=0, max=1, weightChance=10},
				{name="Hunter", min=0, max=1, weightChance=10},
				{name="ImprovisedCrafts", min=0, max=1, weightChance=10},
				{name="JunkHoard", min=0, max=1, weightChance=10},
				{name="MechanicSpecial", min=0, max=1, weightChance=10},
				{name="Photographer", min=0, max=1, weightChance=10},
				{name="PlumbingSupplies", min=0, max=1, weightChance=10},
				{name="ScienceMisc", min=0, max=1, weightChance=10},
				{name="SurvivalGear", min=0, max=1, weightChance=10},
				{name="Trapper", min=0, max=1, weightChance=10},
				{name="VacationStuff", min=0, max=1, weightChance=10},
				{name="WallDecor", min=0, max=1, weightChance=10},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="GarageCarpentry", min=0, max=1, weightChance=100},
				{name="GarageMechanics", min=0, max=1, weightChance=100},
				{name="GarageMetalwork", min=0, max=1, weightChance=100},
				{name="GarageTools", min=0, max=99, weightChance=20},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateAntiqueStove", min=0, max=1, weightChance=5},
				{name="CrateBlackBBQ", min=0, max=1, weightChance=20},
				{name="CrateBlacksmithing", min=0, max=1, weightChance=5},
				{name="CrateBluePlasticChairs", min=0, max=1, weightChance=20},
				{name="CrateCamping", min=0, max=1, weightChance=80},
				{name="CrateClayBricks", min=0, max=1, weightChance=10},
				{name="CrateConcrete", min=0, max=1, weightChance=10},
				{name="CrateElectronics", min=0, max=1, weightChance=80},
				{name="CrateFarming", min=0, max=1, weightChance=40},
				{name="CrateFertilizer", min=0, max=1, weightChance=40},
				{name="CrateFishing", min=0, max=1, weightChance=80},
				{name="CrateFitnessWeights", min=0, max=1, weightChance=40},
				{name="CrateFoldingChairs", min=0, max=1, weightChance=20},
				{name="CrateGardening", min=0, max=1, weightChance=80},
				{name="CrateGravelBags", min=0, max=1, weightChance=80},
				{name="CrateLimestoneCrushed", min=0, max=1, weightChance=5},
				{name="CrateLumber", min=0, max=1, weightChance=60},
				{name="CrateMasonry", min=0, max=1, weightChance=40},
				{name="CrateMechanics", min=0, max=1, weightChance=80},
				{name="CrateMetalwork", min=0, max=1, weightChance=80},
				{name="CratePaint", min=0, max=1, weightChance=80},
				{name="CratePlaster", min=0, max=1, weightChance=60},
				{name="CratePlasticChairs", min=0, max=1, weightChance=40},
				{name="CrateRandomJunk", min=0, max=1, weightChance=100},
				{name="CrateRedBBQ", min=0, max=1, weightChance=20},
				{name="CrateSandBags", min=0, max=1, weightChance=60},
				{name="CrateSheetMetal", min=0, max=1, weightChance=60},
				{name="CrateTools", min=0, max=1, weightChance=80},
				{name="CrateTV", min=0, max=1, weightChance=40},
				{name="CrateWhiteWoodenChairs", min=0, max=1, weightChance=20},
				{name="CrateWoodenChairs", min=0, max=1, weightChance=20},
				{name="CrateWoodenStools", min=0, max=1, weightChance=20},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="FreezerGarage", min=0, max=99, weightChance=100},
				{name="Empty", min=0, max=99, weightChance=20},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeGarage", min=0, max=99, weightChance=100},
				{name="Empty", min=0, max=99, weightChance=20},
			}
		},
		locker = {
			procedural = true,
			procList = {
				{name="FireDeptLockers", min=0, max=99, forceForRooms="firestorage"},
				{name="GarageFirearms", min=0, max=99, weightChance=20},
				{name="GarageTools", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="GarageCarpentry", min=0, max=1, weightChance=100},
				{name="GarageMechanics", min=0, max=1, weightChance=100},
				{name="GarageMetalwork", min=0, max=1, weightChance=100},
				{name="GarageTools", min=0, max=99, weightChance=20},
				{name="ToolStoreBooks", min=0, max=1, weightChance=5},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="Antiques", min=0, max=1, weightChance=10},
				{name="ArtSupplies", min=0, max=1, weightChance=20},
				{name="BurglarTools", min=0, max=1, weightChance=10},
				{name="Chemistry", min=0, max=1, weightChance=10},
				{name="ClothingStorageWinter", min=0, max=1, weightChance=40},
				{name="CrateBooks", min=0, max=1, weightChance=40},
				{name="CrateCanning", min=0, max=1, weightChance=20},
				{name="CrateClothesRandom", min=0, max=1, weightChance=40},
				{name="CrateComics", min=0, max=1, weightChance=40},
				{name="CrateCompactDiscs", min=0, max=1, weightChance=10},
				{name="CrateCostume", min=0, max=1, weightChance=10},
				{name="CrateDishes", min=0, max=1, weightChance=10},
				{name="CrateEmptyBottles1", min=0, max=1, weightChance=100},
				{name="CrateEmptyBottles2", min=0, max=1, weightChance=100},
				{name="CrateEmptyMixed", min=0, max=1, weightChance=100},
				{name="CrateEmptyTinCans", min=0, max=1, weightChance=100},
				{name="CrateFootwearRandom", min=0, max=1, weightChance=40},
				{name="CrateInstruments", min=0, max=1, weightChance=10},
				{name="CrateLinens", min=0, max=1, weightChance=10},
				{name="CrateMagazines", min=0, max=1, weightChance=40},
				{name="CrateNewspapers", min=0, max=1, weightChance=40},
				{name="CratePetSupplies", min=0, max=1, weightChance=10},
				{name="CratePhotos", min=0, max=1, weightChance=10},
				{name="CrateTailoring", min=0, max=1, weightChance=10},
				{name="CrateToys", min=0, max=1, weightChance=10},
				{name="CrateVHSTapes", min=0, max=1, weightChance=10},
				{name="EngineerTools", min=0, max=1, weightChance=20},
				{name="FitnessTrainer", min=0, max=1, weightChance=20},
				{name="Gifts", min=0, max=1, weightChance=10},
				{name="Hiker", min=0, max=1, weightChance=20},
				{name="Hobbies", min=0, max=1, weightChance=20},
				{name="HolidayStuff", min=0, max=1, weightChance=20},
				{name="Homesteading", min=0, max=1, weightChance=20},
				{name="Hunter", min=0, max=1, weightChance=20},
				{name="ImprovisedCrafts", min=0, max=1, weightChance=20},
				{name="JunkHoard", min=0, max=1, weightChance=40},
				{name="MechanicSpecial", min=0, max=1, weightChance=20},
				{name="Photographer", min=0, max=1, weightChance=20},
				{name="PlumbingSupplies", min=0, max=1, weightChance=20},
				{name="ScienceMisc", min=0, max=1, weightChance=20},
				{name="SurvivalGear", min=0, max=1, weightChance=20},
				{name="Trapper", min=0, max=1, weightChance=20},
				{name="VacationStuff", min=0, max=1, weightChance=20},
			}
		},
	},
	
	gardenstore = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateAnimalFeed", min=0, max=99, weightChance=20},
				{name="CrateClayBricks", min=0, max=99, weightChance=10},
				{name="CrateFertilizer", min=0, max=99, weightChance=40},
				{name="CrateGravelBags", min=0, max=99, weightChance=20},
				{name="CrateLargeStone", min=0, max=99, weightChance=10},
				{name="CrateLimestoneCrushed", min=0, max=1, weightChance=5},
				{name="CrateSandBags", min=0, max=99, weightChance=40},
				{name="CrateStoneBlocks", min=0, max=99, weightChance=10},
				{name="GardenStoreTools", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreCounterBags", min=0, max=1, weightChance=100},
				{name="GardenStoreMisc", min=0, max=99, weightChance=100},
			}
		},
		clothingrack = {
			procedural = true,
			procList = {
				{name="CampingStoreClothes", min=0, max=99, weightChance=100},
				{name="CampingStoreLegwear", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateAnimalFeed", min=0, max=99, weightChance=20},
				{name="CrateClayBricks", min=0, max=99, weightChance=10},
				{name="CrateFertilizer", min=0, max=99, weightChance=40},
				{name="CrateGravelBags", min=0, max=99, weightChance=20},
				{name="CrateLargeStone", min=0, max=99, weightChance=10},
				{name="CrateLimestoneCrushed", min=0, max=1, weightChance=5},
				{name="CrateSandBags", min=0, max=99, weightChance=40},
				{name="CrateStoneBlocks", min=0, max=99, weightChance=10},
				{name="GardenStoreTools", min=0, max=99, weightChance=100},
			}
		},
		doghouse = {
			rolls = 1,
			items = {
				
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateAnimalFeed", min=0, max=2, weightChance=20},
				{name="CrateClayBricks", min=0, max=1, weightChance=10},
				{name="CrateFertilizer", min=0, max=4, weightChance=40},
				{name="CrateGravelBags", min=0, max=1, weightChance=20},
				{name="CrateSandBags", min=0, max=1, weightChance=40},
				{name="CrateStoneBlocks", min=0, max=1, weightChance=10},
				{name="GardenStoreTools", min=0, max=99, weightChance=100},
				{name="GardenStoreMisc", min=0, max=99, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="CrateAnimalFeed", min=0, max=2, weightChance=20},
				{name="CrateClayBricks", min=0, max=1, weightChance=10},
				{name="CrateFertilizer", min=0, max=4, weightChance=40},
				{name="CrateGravelBags", min=0, max=1, weightChance=20},
				{name="CrateSandBags", min=0, max=1, weightChance=40},
				{name="CrateStoneBlocks", min=0, max=1, weightChance=10},
				{name="GardenStoreTools", min=0, max=99, weightChance=100},
				{name="GardenStoreMisc", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateAnimalFeed", min=0, max=1, weightChance=20},
				{name="CrateFertilizer", min=0, max=1, weightChance=40},
				{name="GardenStoreMisc", min=0, max=99, weightChance=100},
			}
		},
	},
	
	gas2go = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99, weightChance=80},
				{name="GasStorageMechanics", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_fossoil_01_10;location_shop_fossoil_01_11;location_shop_accessories_01_10;location_shop_accessories_01_11;location_shop_accessories_01_8;location_shop_accessories_01_9;location_shop_accessories_01_12;location_shop_accessories_01_13"},
				{name="Gas2GoCounterCleaning", min=0, max=1, weightChance=100},
				{name="StoreCounterBags", min=0, max=4, weightChance=20},
				{name="StoreCounterTobacco", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99, weightChance=80},
				{name="GasStorageMechanics", min=0, max=99, weightChance=100},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="FreezerIceCream", min=0, max=99, forceForTiles="appliances_refrigeration_01_20;appliances_refrigeration_01_21;appliances_refrigeration_01_38;appliances_refrigeration_01_39"},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeOther", min=1, max=99, weightChance=40},
				{name="FridgeSnacks", min=1, max=99, weightChance=100},
				{name="FridgeSoda", min=1, max=99, weightChance=100},
				{name="FridgeWater", min=1, max=99, weightChance=60},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99, weightChance=80},
				{name="GasStorageMechanics", min=0, max=99, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="GasStoreEmergency", min=1, max=1, weightChance=20},
				{name="GasStoreToiletries", min=0, max=1, weightChance=40},
				{name="GigamartCleaning", min=0, max=1, weightChance=20},
				{name="MovieRentalShelves", min=0, max=99, forceForTiles="location_entertainment_theatre_01_120;location_entertainment_theatre_01_121;location_entertainment_theatre_01_122;location_entertainment_theatre_01_123;location_entertainment_theatre_01_124;location_entertainment_theatre_01_125;location_entertainment_theatre_01_126;location_entertainment_theatre_01_127;location_entertainment_theatre_01_128;location_entertainment_theatre_01_129;location_entertainment_theatre_01_130;location_entertainment_theatre_01_131;location_entertainment_theatre_01_132;location_entertainment_theatre_01_133;location_entertainment_theatre_01_134;location_entertainment_theatre_01_135"},
				{name="StoreCounterTobacco", min=0, max=99, forceForTiles="location_shop_generic_01_28;location_shop_generic_01_29;location_shop_generic_01_30;location_shop_generic_01_31"},
				{name="StoreShelfCombo", min=0, max=99, forceForTiles="location_shop_generic_01_0;location_shop_generic_01_1"},
				{name="StoreShelfDrinks", min=0, max=99, weightChance=100},
				{name="StoreShelfMechanics", min=0, max=99, forceForTiles="location_shop_generic_01_3;location_shop_generic_01_4"},
				{name="StoreShelfMedical", min=0, max=1, weightChance=20},
				{name="StoreShelfSnacks", min=0, max=99, weightChance=100},
			}
		},
		shelvesmag = {
			procedural = true,
			procList = {
				{name="MagazineRackMaps", min=1, max=4, weightChance=40},
				{name="MagazineRackMixed", min=1, max=99, weightChance=100},
				{name="MagazineRackNewspaper", min=1, max=4, weightChance=40},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99, weightChance=80},
				{name="GasStorageMechanics", min=0, max=99, weightChance=100},
			}
		},
	},
	
	gasstorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="GasStorageMechanics", min=1, max=99, weightChance=100},
				{name="GasStorageCombo", min=0, max=99, weightChance=80},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="JanitorChemicals", min=0, max=99, weightChance=100},
				{name="JanitorCleaning", min=0, max=1, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="JanitorMisc", min=1, max=1, weightChance=100},
				{name="JanitorTools", min=0, max=1, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="GasStorageMechanics", min=1, max=99, weightChance=100},
				{name="GasStorageCombo", min=0, max=99, weightChance=80},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="GasStorageMechanics", min=1, max=99, weightChance=100},
				{name="GasStorageCombo", min=0, max=99, weightChance=80},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="GasStorageMechanics", min=1, max=99, weightChance=100},
				{name="GasStorageCombo", min=0, max=99, weightChance=80},
			}
		},
	},
	
	gasstore = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99, weightChance=80},
				{name="GasStorageMechanics", min=1, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_fossoil_01_10;location_shop_fossoil_01_11;location_shop_accessories_01_10;location_shop_accessories_01_11;location_shop_accessories_01_8;location_shop_accessories_01_9;location_shop_accessories_01_12;location_shop_accessories_01_13"},
				{name="GasStoreCounterCleaning", min=0, max=1, weightChance=100},
				{name="StoreCounterBags", min=0, max=1, weightChance=20},
				{name="StoreCounterTobacco", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="GasStoreSpecial", min=0, max=1, weightChance=10},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99, weightChance=80},
				{name="GasStorageMechanics", min=1, max=99, weightChance=100},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="FreezerIceCream", min=0, max=99, forceForTiles="appliances_refrigeration_01_20;appliances_refrigeration_01_21;appliances_refrigeration_01_38;appliances_refrigeration_01_39"},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeOther", min=1, max=99, weightChance=40},
				{name="FridgeSnacks", min=1, max=99, weightChance=100},
				{name="FridgeSoda", min=1, max=99, weightChance=100},
				{name="FridgeWater", min=1, max=99, weightChance=60},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateCigarettes", min=0, max=1, weightChance=1},
				{name="CrateCandyPackage", min=0, max=1, weightChance=40},
				{name="CrateChips", min=0, max=1, weightChance=100},
				{name="CrateChocolate", min=0, max=1, weightChance=40},
				{name="CrateGum", min=0, max=1, weightChance=40},
				{name="CratePeanuts", min=0, max=1, weightChance=40},
				{name="CrateSodaBottles", min=0, max=1, weightChance=100},
				{name="CrateSodaCans", min=0, max=1, weightChance=100},
				{name="CrateSunflowerSeeds", min=0, max=1, weightChance=40},
				{name="CrateTortillaChips", min=0, max=1, weightChance=40},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="GasStoreEmergency", min=1, max=1, weightChance=20},
				{name="GasStoreToiletries", min=0, max=1, weightChance=40},
				{name="GigamartCleaning", min=0, max=1, weightChance=20},
				{name="MovieRentalShelves", min=0, max=99, forceForTiles="location_entertainment_theatre_01_120;location_entertainment_theatre_01_121;location_entertainment_theatre_01_122;location_entertainment_theatre_01_123;location_entertainment_theatre_01_124;location_entertainment_theatre_01_125;location_entertainment_theatre_01_126;location_entertainment_theatre_01_127;location_entertainment_theatre_01_128;location_entertainment_theatre_01_129;location_entertainment_theatre_01_130;location_entertainment_theatre_01_131;location_entertainment_theatre_01_132;location_entertainment_theatre_01_133;location_entertainment_theatre_01_134;location_entertainment_theatre_01_135"},
				{name="StoreCounterTobacco", min=0, max=99, forceForTiles="location_shop_generic_01_28;location_shop_generic_01_29;location_shop_generic_01_30;location_shop_generic_01_31"},
				{name="StoreShelfCombo", min=0, max=99, forceForTiles="location_shop_generic_01_0;location_shop_generic_01_1"},
				{name="StoreShelfDrinks", min=0, max=99, weightChance=100},
				{name="StoreShelfMechanics", min=0, max=99, forceForTiles="location_shop_generic_01_3;location_shop_generic_01_4"},
				{name="StoreShelfMedical", min=0, max=1, weightChance=20},
				{name="StoreShelfSnacks", min=0, max=99, weightChance=100},
			}
		},
		shelvesmag = {
			procedural = true,
			procList = {
				{name="MagazineRackMaps", min=1, max=4, weightChance=40},
				{name="MagazineRackMixed", min=1, max=99, weightChance=100},
				{name="MagazineRackNewspaper", min=1, max=4, weightChance=40},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99, weightChance=80},
				{name="GasStorageMechanics", min=1, max=99, weightChance=100},
			}
		},
	},
	
	generalstore = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateCigarettes", min=0, max=1, weightChance=1},
				{name="GigamartCrisps", min=0, max=99, weightChance=25},
				{name="GigamartCandy", min=0, max=99, weightChance=25},
				{name="GigamartCannedFood", min=0, max=99, weightChance=100},
				{name="GigamartSauce", min=0, max=99, weightChance=10},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreCounterBags", min=0, max=1, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateCigarettes", min=0, max=1, weightChance=1},
				{name="GigamartCrisps", min=0, max=99, weightChance=25},
				{name="GigamartCandy", min=0, max=99, weightChance=25},
				{name="GigamartCannedFood", min=0, max=99, weightChance=100},
				{name="GigamartSauce", min=0, max=99, weightChance=10},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeSnacks", min=0, max=99, weightChance=100},
				{name="FridgeSoda", min=0, max=99, weightChance=100},
				{name="FridgeWater", min=0, max=99, weightChance=40},
				{name="FridgeOther", min=1, max=99, weightChance=60},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="GigamartTools", min=0, max=99, weightChance=100},
				{name="GigamartFarming", min=0, max=99, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="GigamartBakingMisc", min=1, max=4, weightChance=60},
				{name="GigamartBedding", min=1, max=2, weightChance=40},
				{name="GigamartBottles", min=2, max=4, weightChance=60},
				{name="GigamartCandy", min=1, max=4, weightChance=60},
				{name="GigamartCannedFood", min=0, max=99, weightChance=20},
				{name="GigamartCleaning", min=1, max=2, weightChance=40},
				{name="GigamartCrisps", min=1, max=4, weightChance=60},
				{name="GigamartDryGoods", min=1, max=4, weightChance=60},
				{name="GigamartFarming", min=1, max=4, weightChance=60},
				{name="GigamartHouseElectronics", min=1, max=2, weightChance=60},
				{name="GigamartHousewares", min=1, max=2, weightChance=60},
				{name="GigamartLightbulb", min=0, max=1, weightChance=20},
				{name="GigamartPaper", min=1, max=2, weightChance=40},
				{name="GigamartPots", min=1, max=2, weightChance=60},
				{name="GigamartSauce", min=1, max=2, weightChance=80},
				{name="GigamartSchool", min=0, max=2, weightChance=40},
				{name="GigamartToiletries", min=1, max=2, weightChance=40},
				{name="GigamartTools", min=1, max=4, weightChance=60},
				{name="GigamartToys", min=0, max=2, weightChance=40},
				{name="MovieRentalShelves", min=0, max=99, forceForTiles="location_entertainment_theatre_01_120;location_entertainment_theatre_01_121;location_entertainment_theatre_01_122;location_entertainment_theatre_01_123;location_entertainment_theatre_01_124;location_entertainment_theatre_01_125;location_entertainment_theatre_01_126;location_entertainment_theatre_01_127;location_entertainment_theatre_01_128;location_entertainment_theatre_01_129;location_entertainment_theatre_01_130;location_entertainment_theatre_01_131;location_entertainment_theatre_01_132;location_entertainment_theatre_01_133;location_entertainment_theatre_01_134;location_entertainment_theatre_01_135"},
				{name="StoreCounterTobacco", min=0, max=99, forceForTiles="location_shop_generic_01_28;location_shop_generic_01_29;location_shop_generic_01_30;location_shop_generic_01_31"},
				{name="StoreShelfCombo", min=0, max=99, forceForTiles="location_shop_generic_01_0;location_shop_generic_01_1"},
				{name="StoreShelfMechanics", min=1, max=2, weightChance=20},
				{name="StoreShelfMedical", min=1, max=2, weightChance=20},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateCigarettes", min=0, max=1, weightChance=1},
				{name="GigamartCrisps", min=0, max=99, weightChance=25},
				{name="GigamartCandy", min=0, max=99, weightChance=25},
				{name="GigamartCannedFood", min=0, max=99, weightChance=100},
				{name="GigamartSauce", min=0, max=99, weightChance=10},
			}
		},
	},
	
	generalstorestorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="GigamartBakingMisc", min=0, max=99, weightChance=40},
				{name="GigamartCannedFood", min=0, max=99, weightChance=100},
				{name="GigamartDryGoods", min=0, max=99, weightChance=60},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreCounterTobacco", min=1, max=2, weightChance=100},
				{name="StoreCounterBags", min=0, max=1, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="GigamartBakingMisc", min=0, max=99, weightChance=40},
				{name="GigamartCannedFood", min=0, max=99, weightChance=100},
				{name="GigamartDryGoods", min=0, max=99, weightChance=60},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="GigamartTools", min=0, max=99, weightChance=100},
				{name="GigamartFarming", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="GigamartBakingMisc", min=0, max=99, weightChance=40},
				{name="GigamartCannedFood", min=0, max=99, weightChance=100},
				{name="GigamartDryGoods", min=0, max=99, weightChance=60},
			}
		},
	},
	
	giftstorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="GiftStoreCards", min=1, max=4, weightChance=40},
				{name="GiftStoreFancy", min=1, max=4, weightChance=20},
				{name="GiftStoreToys", min=1, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="GiftStoreCards", min=1, max=4, weightChance=40},
				{name="GiftStoreFancy", min=1, max=4, weightChance=20},
				{name="GiftStoreToys", min=1, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="GiftStoreCards", min=1, max=4, weightChance=40},
				{name="GiftStoreFancy", min=1, max=4, weightChance=20},
				{name="GiftStoreToys", min=1, max=99, weightChance=100},
			}
		},
	},
	
	giftstore = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="GiftStoreCards", min=1, max=4, weightChance=40},
				{name="GiftStoreFancy", min=1, max=4, weightChance=20},
				{name="GiftStoreToys", min=1, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="GiftStoreToys", min=0, max=99, weightChance=100},
				{name="StoreCounterBagsFancy", min=0, max=1, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="GiftStoreCards", min=1, max=4, weightChance=40},
				{name="GiftStoreFancy", min=1, max=4, weightChance=20},
				{name="GiftStoreToys", min=1, max=99, weightChance=100},
			}
		},
		displaycase = {
			procedural = true,
			procList = {
				{name="StoreDisplayWatches", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="GiftStoreFancy", min=0, max=4, weightChance=60},
				{name="GiftStoreToys", min=0, max=99, weightChance=100},
				{name="StoreShelfCombo", min=0, max=99, forceForTiles="location_shop_generic_01_0;location_shop_generic_01_1"},
			}
		},
		shelvesmag = {
			procedural = true,
			procList = {
				{name="GiftStoreCards", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="GiftStoreCards", min=1, max=4, weightChance=40},
				{name="GiftStoreFancy", min=1, max=4, weightChance=20},
				{name="GiftStoreToys", min=1, max=99, weightChance=100},
			}
		},
	},
	
	gigamart = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="GroceryStorageCrate1", min=0, max=99, weightChance=100},
				{name="GroceryStorageCrate2", min=0, max=99, weightChance=40},
				{name="GroceryStorageCrate3", min=0, max=99, weightChance=40},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreCounterBags", min=0, max=1, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="GroceryStorageCrate1", min=0, max=99, weightChance=100},
				{name="GroceryStorageCrate2", min=0, max=99, weightChance=40},
				{name="GroceryStorageCrate3", min=0, max=99, weightChance=40},
			}
		},
		displaycasebakery = {
			procedural = true,
			procList = {
				{name="BakeryBread", min=1, max=99, weightChance=100},
				{name="BakeryPie", min=1, max=99, weightChance=40},
				{name="BakeryCake", min=1, max=99, weightChance=100},
				{name="BakeryMisc", min=1, max=99, weightChance=40},
			}
		},
		displaycasebutcher = {
			procedural = true,
			procList = {
				{name="ButcherChops", min=1, max=99, weightChance=100},
				{name="ButcherGround", min=1, max=99, weightChance=50},
				{name="ButcherChicken", min=1, max=99, weightChance=100},
				{name="ButcherSmoked", min=1, max=99, weightChance=50},
				{name="ButcherFish", min=1, max=99, weightChance=25},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="FreezerFrozenFood", min=0, max=99, forceForTiles="appliances_refrigeration_01_20;appliances_refrigeration_01_21;appliances_refrigeration_01_38;appliances_refrigeration_01_39"},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeSnacks", min=0, max=99, weightChance=100},
				{name="FridgeSoda", min=0, max=99, weightChance=80},
				{name="FridgeWater", min=0, max=99, weightChance=40},
				{name="FridgeOther", min=1, max=99, forceForTiles="location_shop_generic_01_64;location_shop_generic_01_65;location_shop_generic_01_66;location_shop_generic_01_67;location_shop_generic_01_68;location_shop_generic_01_69;"},
			}
		},
		grocerstand = {
			procedural = true,
			procList = {
				{name="GroceryStandVegetables1", min=1, max=99, weightChance=100},
				{name="GroceryStandVegetables2", min=1, max=99, weightChance=100},
				{name="GroceryStandVegetables3", min=1, max=99, weightChance=100},
				{name="GroceryStandVegetables4", min=1, max=99, weightChance=100},
				{name="GroceryStandVegetables5", min=1, max=99, weightChance=100},
				{name="GroceryStandFruits1", min=1, max=99, weightChance=100},
				{name="GroceryStandFruits2", min=1, max=99, weightChance=100},
				{name="GroceryStandFruits3", min=1, max=99, weightChance=100},
				{name="GroceryStandLettuce", min=1, max=99, weightChance=25},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="GigamartBakingMisc", min=1, max=99, weightChance=40},
				{name="GigamartBathing", min=1, max=2, weightChance=20},
				{name="GigamartBBQ", min=1, max=2, weightChance=20},
				{name="GigamartBedding", min=1, max=2, weightChance=20},
				{name="GigamartBottles", min=1, max=99, weightChance=20},
				{name="GigamartCandy", min=1, max=99, weightChance=40},
				{name="GigamartCannedFood", min=1, max=99, weightChance=100},
				{name="GigamartCleaning", min=1, max=2, weightChance=20},
				{name="GigamartCosmetics", min=1, max=99, weightChance=20},
				{name="GigamartCrisps", min=1, max=99, weightChance=40},
				{name="GigamartDryGoods", min=1, max=99, weightChance=100},
				{name="GigamartFarming", min=1, max=99, weightChance=10},
				{name="GigamartHouseElectronics", min=1, max=99, weightChance=10},
				{name="GigamartHousewares", min=1, max=99, weightChance=20},
				{name="GigamartLightbulb", min=1, max=99, weightChance=10},
				{name="GigamartLiterature", min=1, max=2, weightChance=40},
				{name="GigamartPaper", min=1, max=2, weightChance=20},
				{name="GigamartPots", min=1, max=99, weightChance=20},
				{name="GigamartSauce", min=1, max=99, weightChance=20},
				{name="GigamartSpices", min=1, max=99, weightChance=20},
				{name="GigamartSchool", min=1, max=99, weightChance=20},
				{name="GigamartToiletries", min=1, max=2, weightChance=20},
				{name="GigamartTools", min=1, max=99, weightChance=10},
				{name="GigamartToys", min=1, max=99, weightChance=20},
				{name="StoreShelfCombo", min=0, max=99, forceForTiles="location_shop_generic_01_0;location_shop_generic_01_1"},
			}
		},
		shelvesmag = {
			procedural = true,
			procList = {
				{name="MagazineRackMaps", min=1, max=2, weightChance=40},
				{name="MagazineRackMixed", min=1, max=99, weightChance=100},
				{name="MagazineRackNewspaper", min=1, max=2, weightChance=40},
				{name="MagazineRackPaperback", min=1, max=2, weightChance=40},
			}
		},
		smallbox = {
			rolls = 1,
			items = {
				"GroceryBag1", 50,
				"GroceryBag1", 20,
				"GroceryBag1", 10,
				"GroceryBag1", 10,
				"GroceryBag2", 8,
				"GroceryBag3", 8,
				"GroceryBag4", 8,
				"GroceryBag5", 8,
			}
		},
	},
	
	gigamartkitchen = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="StoreKitchenBaking", min=0, max=99, weightChance=100},
				{name="StoreKitchenButcher", min=1, max=99, weightChance=100},
				{name="StoreKitchenPots", min=0, max=1, weightChance=20},
			}
		},
		displaycasebutcher = {
			procedural = true,
			procList = {
				{name="ButcherChops", min=1, max=4, weightChance=100},
				{name="ButcherGround", min=1, max=2, weightChance=100},
				{name="ButcherChicken", min=1, max=1, weightChance=100},
				{name="ButcherSmoked", min=1, max=4, weightChance=100},
				{name="ButcherFish", min=0, max=1, weightChance=100},
			}
		},
	},
	
	glassesstore = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreCounterBagsFancy", min=0, max=1, weightChance=100},
				{name="OptometristGlasses", min=0, max=99, weightChance=20},
			}
		},
		displaycase = {
			procedural = true,
			procList = {
				{name="OptometristGlasses", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="OptometristGlasses", min=0, max=99},
			}
		},
	},
	
	golffactory = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateGolfClubs", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="GolfFactoryTools", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="ToolFactoryBarStock", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="GolfFactoryTools", min=0, max=99, forceForTiles="furniture_storage_02_0;furniture_storage_02_1;furniture_storage_02_2;furniture_storage_02_3"},
				{name="ToolFactoryBarStock", min=0, max=99, weightChance=100},
				{name="CrateGolfClubs", min=0, max=99, weightChance=40},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateGolfBalls", min=0, max=99},
			}
		},
	},
	
	golfshipping = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateGolfClubs", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateGolfClubs", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateGolfClubs", min=0, max=99, weightChance=40},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateGolfBalls", min=0, max=99},
			}
		},
	},
	
	golfstore = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateGolfClubs", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="GolfStoreLiterature", min=0, max=1, weightChance=100},
			}
		},
		clothingrack = {
			procedural = true,
			procList = {
				{name="GolfStoreClothingRack", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateGolfClubs", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="GolfStoreBags", min=1, max=4, weightChance=80},
				{name="GolfStoreLiterature", min=1, max=2, weightChance=20},
				{name="CrateGolfClubs", min=0, max=99, weightChance=60},
				{name="GolfStoreAccessories", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateGolfBalls", min=0, max=99},
			}
		},
	},
	
	grocery = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="GroceryStorageCrate1", min=0, max=99, weightChance=100},
				{name="GroceryStorageCrate2", min=0, max=99, weightChance=40},
				{name="GroceryStorageCrate3", min=0, max=99, weightChance=40},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreCounterBags", min=0, max=1, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="GroceryStorageCrate1", min=0, max=99, weightChance=100},
				{name="GroceryStorageCrate2", min=0, max=99, weightChance=40},
				{name="GroceryStorageCrate3", min=0, max=99, weightChance=40},
			}
		},
		displaycasebakery = {
			procedural = true,
			procList = {
				{name="BakeryBread", min=1, max=99, weightChance=100},
				{name="BakeryPie", min=1, max=99, weightChance=40},
				{name="BakeryCake", min=1, max=99, weightChance=100},
				{name="BakeryMisc", min=1, max=99, weightChance=40},
			}
		},
		displaycasebutcher = {
			procedural = true,
			procList = {
				{name="ButcherChops", min=1, max=99, weightChance=100},
				{name="ButcherGround", min=1, max=99, weightChance=50},
				{name="ButcherChicken", min=1, max=99, weightChance=100},
				{name="ButcherSmoked", min=1, max=99, weightChance=50},
				{name="ButcherFish", min=1, max=99, weightChance=25},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="FreezerFrozenFood", min=0, max=99, forceForTiles="appliances_refrigeration_01_20;appliances_refrigeration_01_21;appliances_refrigeration_01_38;appliances_refrigeration_01_39"},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeSnacks", min=0, max=99, weightChance=100},
				{name="FridgeSoda", min=0, max=99, weightChance=80},
				{name="FridgeWater", min=0, max=99, weightChance=40},
				{name="FridgeOther", min=1, max=99, forceForTiles="location_shop_generic_01_64;location_shop_generic_01_65;location_shop_generic_01_66;location_shop_generic_01_67;location_shop_generic_01_68;location_shop_generic_01_69;"},
			}
		},
		grocerstand = {
			procedural = true,
			procList = {
				{name="GroceryStandVegetables1", min=1, max=99, weightChance=100},
				{name="GroceryStandVegetables2", min=1, max=99, weightChance=100},
				{name="GroceryStandVegetables3", min=1, max=99, weightChance=100},
				{name="GroceryStandVegetables4", min=1, max=99, weightChance=100},
				{name="GroceryStandVegetables5", min=1, max=99, weightChance=100},
				{name="GroceryStandFruits1", min=1, max=99, weightChance=100},
				{name="GroceryStandFruits2", min=1, max=99, weightChance=100},
				{name="GroceryStandFruits3", min=1, max=99, weightChance=100},
				{name="GroceryStandLettuce", min=1, max=99, weightChance=25},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="GigamartBakingMisc", min=1, max=99, weightChance=40},
				{name="GigamartBBQ", min=1, max=2, weightChance=20},
				{name="GigamartBottles", min=1, max=99, weightChance=20},
				{name="GigamartCandy", min=1, max=99, weightChance=40},
				{name="GigamartCannedFood", min=1, max=99, weightChance=100},
				{name="GigamartCleaning", min=1, max=99, weightChance=100},
				{name="GigamartCrisps", min=1, max=99, weightChance=40},
				{name="GigamartDryGoods", min=1, max=99, weightChance=100},
				{name="GigamartSauce", min=1, max=99, weightChance=20},
				{name="GigamartSpices", min=1, max=99, weightChance=20},
				{name="GigamartPaper", min=1, max=99, weightChance=100},
				{name="GigamartToiletries", min=1, max=99, weightChance=100},
				{name="StoreShelfCombo", min=0, max=99, forceForTiles="location_shop_generic_01_0;location_shop_generic_01_1"},
			}
		},
		shelvesmag = {
			procedural = true,
			procList = {
				{name="MagazineRackMaps", min=1, max=2, weightChance=40},
				{name="MagazineRackMixed", min=1, max=99, weightChance=100},
				{name="MagazineRackNewspaper", min=1, max=2, weightChance=40},
				{name="MagazineRackPaperback", min=1, max=2, weightChance=40},
			}
		},
		smallcrate = {
			procedural = true,
			procList = {
				{name="GroceryStorageCrate1", min=0, max=99, weightChance=100},
				{name="GroceryStorageCrate2", min=0, max=99, weightChance=40},
				{name="GroceryStorageCrate3", min=0, max=99, weightChance=40},
			}
		},
		smallbox = {
			rolls = 1,
			items = {
				"GroceryBag1", 50,
				"GroceryBag1", 20,
				"GroceryBag1", 10,
				"GroceryBag1", 10,
				"GroceryBag2", 8,
				"GroceryBag3", 8,
				"GroceryBag4", 8,
				"GroceryBag5", 8,
			}
		},
	},
	
	grocerystorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="GroceryStorageCrate1", min=0, max=99, weightChance=100},
				{name="GroceryStorageCrate2", min=0, max=99, weightChance=40},
				{name="GroceryStorageCrate3", min=0, max=99, weightChance=40},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="GroceryStorageCrate1", min=0, max=99, weightChance=100},
				{name="GroceryStorageCrate2", min=0, max=99, weightChance=40},
				{name="GroceryStorageCrate3", min=0, max=99, weightChance=40},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="FreezerFrozenFood", min=0, max=99, forceForTiles="appliances_refrigeration_01_20;appliances_refrigeration_01_21;appliances_refrigeration_01_38;appliances_refrigeration_01_39;appliances_refrigeration_01_48;appliances_refrigeration_01_49;appliances_refrigeration_01_50;appliances_refrigeration_01_51"},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeSnacks", min=0, max=99, weightChance=100},
				{name="FridgeSoda", min=0, max=99, weightChance=80},
				{name="FridgeWater", min=0, max=99, weightChance=40},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="GroceryStorageCrate1", min=0, max=99, weightChance=100},
				{name="GroceryStorageCrate2", min=0, max=99, weightChance=40},
				{name="GroceryStorageCrate3", min=0, max=99, weightChance=40},
			}
		},
		smallbox = {
			rolls = 1,
			items = {
				"GroceryBag1", 50,
				"GroceryBag1", 20,
				"GroceryBag1", 10,
				"GroceryBag1", 10,
				"GroceryBag2", 8,
				"GroceryBag3", 8,
				"GroceryBag4", 8,
				"GroceryBag5", 8,
			}
		},
		smallcrate = {
			procedural = true,
			procList = {
				{name="GroceryStorageCrate1", min=0, max=99, weightChance=100},
				{name="GroceryStorageCrate2", min=0, max=99, weightChance=40},
				{name="GroceryStorageCrate3", min=0, max=99, weightChance=40},
			}
		},
	},
	
	gunstore = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="GunStoreAmmunition", min=0, max=99, weightChance=100},
				{name="GunStoreBodyArmor", min=0, max=1, weightChance=1},
			},
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="GunStoreAmmunition", min=0, max=99, weightChance=100},
				{name="GunStoreBodyArmor", min=0, max=1, weightChance=20},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="GunStoreAmmunition", min=0, max=99, weightChance=100},
				{name="GunStoreBodyArmor", min=0, max=1, weightChance=5},
			},
		},
		displaycase = {
			procedural = true,
			procList = {
				{name="GunStorePistols", min=1, max=1, weightChance=100},
				{name="GunStoreRifles", min=1, max=1, weightChance=100},
				{name="GunStoreShotguns", min=1, max=1, weightChance=100},
				{name="GunStoreKnives", min=0, max=1, weightChance=80},
				{name="GunStoreMagsAmmo", min=0, max=99, weightChance=20},
				{name="GunStoreAccessories", min=0, max=99, weightChance=20},
			},
			dontSpawnAmmo = true,
		},
		locker = {
			procedural = true,
			procList = {
				{name="GunStoreAmmunition", min=0, max=99, weightChance=100},
				{name="GunStoreBodyArmor", min=0, max=1, weightChance=1},
			},
			dontSpawnAmmo = true,
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="GunStoreAmmunition", min=0, max=99, weightChance=100},
				{name="GunStoreBodyArmor", min=0, max=1, weightChance=1},
			}
		},
		militarycrate = {
			procedural = true,
			procList = {
				{name="ArmySurplusAmmoBoxes", min=0, max=99},
			}
		},
		militarycrate = {
			procedural = true,
			procList = {
				{name="ArmySurplusCases", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="GunStoreCases", min=0, max=1, weightChance=100},
				{name="GunStoreLiterature", min=1, max=2, weightChance=40},
				{name="GunStoreBodyArmor", min=0, max=1, weightChance=1},
				{name="GunStoreAmmunition", min=0, max=99, weightChance=100},
			}
		},
		shelvesmag = {
			procedural = true,
			procList = {
				{name="GunStoreMagazineRack", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="GunStoreLiterature", min=0, max=99, weightChance=100},
				{name="GunStoreMagazineRack", min=0, max=99, weightChance=100},
			}
		},
	},
	
	gunstorestorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="GunStoreAmmunition", min=0, max=99, weightChance=100},
				{name="GunStoreBodyArmor", min=0, max=1, weightChance=5},
			},
			dontSpawnAmmo = true,
		},
		crate = {
			procedural = true,
			procList = {
				{name="GunStoreAmmunition", min=0, max=99, weightChance=100},
				{name="GunStoreBodyArmor", min=0, max=1, weightChance=5},
			},
			dontSpawnAmmo = true,
		},
		locker = {
			procedural = true,
			procList = {
				{name="GunStoreAmmunition", min=0, max=99, weightChance=100},
				{name="GunStoreBodyArmor", min=0, max=1, weightChance=5},
			}
		},
		militarycrate = {
			procedural = true,
			procList = {
				{name="GunStoreAmmunition", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="GunStoreAmmunition", min=0, max=99, weightChance=100},
				{name="GunStoreBodyArmor", min=0, max=1, weightChance=5},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="GunStoreAmmunition", min=0, max=99, weightChance=100},
				{name="GunStoreCases", min=0, max=1, weightChance=100},
				{name="GunStoreLiterature", min=1, max=2, weightChance=40},
				{name="GunStoreBodyArmor", min=0, max=1, weightChance=5},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="GunStoreLiterature", min=0, max=99, weightChance=100},
				{name="GunStoreMagazineRack", min=0, max=99, weightChance=100},
			}
		},
	},
	
	gym = {
		metal_shelves = {
			procedural = true,
			procList = {
				{name="GymWeights", min=0, max=99, forceForRooms="fitness;gym"},
			}
		},
	},
	
	gymstorage = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="SportStorageBats", min=0, max=1, weightChance=60},
				{name="SportStorageBalls", min=0, max=1, weightChance=100},
				{name="SportStorageHelmets", min=0, max=1, weightChance=40},
				{name="SportStoragePaddles", min=0, max=1, weightChance=10},
				{name="SportStorageRacquets", min=0, max=1, weightChance=20},
				{name="SportStorageSticks", min=0, max=1, weightChance=80},
				{name="SportStorageWeights", min=0, max=1, weightChance=20},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="BowlingAlleyShoes", min=0, max=99, forceForRooms="bowlingalley"},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="SportStorageBats", min=0, max=1, weightChance=60},
				{name="SportStorageBalls", min=0, max=1, weightChance=100},
				{name="SportStorageHelmets", min=0, max=1, weightChance=40},
				{name="SportStoragePaddles", min=0, max=1, weightChance=10},
				{name="SportStorageRacquets", min=0, max=1, weightChance=20},
				{name="SportStorageSticks", min=0, max=1, weightChance=80},
				{name="SportStorageWeights", min=0, max=1, weightChance=20},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="BarCratePool", min=0, max=2, forceForRooms="gameroom"},
				{name="GolfStorage", min=0, max=2, forceForRooms="golf"},
				{name="SportStorageBats", min=0, max=1, weightChance=60},
				{name="SportStorageHelmets", min=0, max=1, weightChance=40},
				{name="SportStoragePaddles", min=0, max=1, weightChance=10},
				{name="SportStorageRacquets", min=0, max=1, weightChance=20},
				{name="SportStorageSticks", min=0, max=1, weightChance=80},
				{name="SportStorageSticks", min=0, max=1, weightChance=80},
				{name="SportStorageWeights", min=0, max=1, weightChance=20},
			}
		},
	},
	
	hall = {
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="RandomFiller", min=0, max=99, weightChance=100},
			}
		},
		displaycasebakery = {
			procedural = true,
			procList = {
				{name="BakeryDoughnuts", min=0, max=99, forceForRooms="donut_kitchen"},
			}
		},
		clothingdryerbasic = {
			procedural = true,
			procList = {
				{name="GymTowels", min=0, max=99, forceForRooms="fitness;gym"},
				{name="LaundryHospital", min=0, max=99, forceForZones="Doctor;NursingHome"},
			}
		},
		locker = {
			procedural = true,
			procList = {
				{name="SchoolLockersBad", min=1, max=1, forceForRooms="classroom"},
				{name="SchoolLockers", min=0, max=99, forceForRooms="classroom"},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="ArmyStorageElectronics", min=0, max=99, forceForRooms="controlroom"},
			}
		},
		shelvesmag = {
			procedural = true,
			procList = {
				{name="MagazineRackBrochure", min=0, max=99},
			}
		},
	},
	
	homecinema = {
		shelves = {
			procedural = true,
			procList = {
				{name="HomeCinemaFilm", min=1, max=99, weightChance=100},
				{name="HomeCinemaLiterature", min=1, max=2, weightChance=40},
			}
		}
	},
	
	hoopgame = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="CarnivalPrizes", min=0, max=4, weightChance=100},
			}
		}
	},
	
	hospitalhallway = {
		bin = {
			procedural = true,
			procList = {
				{name="BinHospital", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="MedicalOfficeCounter", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="HospitalRoomShelves", min=0, max=99},
			}
		},
		shelvesmag = {
			procedural = true,
			procList = {
				{name="HospitalMagazineRack", min=0, max=99},
			}
		},
	},
	
	hospitalroom = {
		bin = {
			procedural = true,
			procList = {
				{name="BinHospital", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="HospitalRoomCounter", min=0, max=99, weightChance=100},
				{name="HospitalRoomCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
			}
		},
		desk = {
			procedural = true,
			procList = {
				{name="MedicalOfficeDesk", min=0, max=99},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			},
		},
		fridge = {
			procedural = true,
			procList = {
				{name="HospitalRoomFridge", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="HospitalRoomShelves", min=0, max=99},
			}
		},
		sidetable = {
			procedural = true,
			procList = {
				{name="HospitalRoomWardrobe", min=0, max=99},
			}
		},
	},
	
	hospitalstorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="MedicalStorageDrugs", min=0, max=6, weightChance=100},
				{name="MedicalStorageTools", min=0, max=4, weightChance=80},
				{name="MedicalStorageOutfit", min=0, max=2, weightChance=40},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="MedicalStorageDrugs", min=0, max=6, weightChance=100},
				{name="MedicalStorageTools", min=0, max=4, weightChance=80},
				{name="MedicalStorageOutfit", min=0, max=2, weightChance=40},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="MedicalStorageDrugs", min=0, max=6, weightChance=100},
				{name="MedicalStorageTools", min=0, max=4, weightChance=80},
				{name="MedicalStorageOutfit", min=0, max=2, weightChance=40},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="MedicalStorageDrugs", min=0, max=6, weightChance=100},
				{name="MedicalStorageTools", min=0, max=4, weightChance=80},
				{name="MedicalStorageOutfit", min=0, max=2, weightChance=40},
			}
		},
	},
	
	hotdogstand = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="HotdogStandDrinks", min=0, max=2, weightChance=100},
				{name="HotdogStandToppings", min=0, max=2, weightChance=100},
			}
		}
	},
	
	housewarestore = {
		isShop = true,
		shelves = {
			procedural = true,
			procList = {
				{name="GigamartHousewares", min=1, max=12, weightChance=100},
				{name="GigamartBedding", min=0, max=2, weightChance=100},
				{name="GigamartPots", min=1, max=6, weightChance=100},
				{name="GigamartLightbulb", min=1, max=2, weightChance=100},
				{name="GigamartHouseElectronics", min=1, max=2, weightChance=100},
			}
		}
	},
	
	hunting = {
		isShop = true,
		clothingrack = {
			procedural = true,
			procList = {
				{name="CampingStoreClothes", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreCounterBags", min=0, max=1, weightChance=10},
				{name="CampingStoreBooks", min=0, max=4, weightChance=80},
				{name="CampingStoreLegwear", min=0, max=2, weightChance=60},
				{name="CampingStoreBackpacks", min=0, max=2, weightChance=40},
				{name="CampingStoreGear", min=0, max=4, weightChance=100},
				{name="FishingStoreGear", min=0, max=2, weightChance=20},
			}
		},
		displaycase = {
			procedural = true,
			procList = {
				{name="GunStoreRifles", min=0, max=99}, 
			},
			dontSpawnAmmo = true,
		},
		locker = {
			procedural = true,
			procList = {
				{name="GunStoreRifles", min=0, max=99, weightChance=20},
				{name="GunStoreAmmunition", min=0, max=99, weightChance=100},
			}
		},
		
		metal_shelves = {
			procedural = true,
			procList = {
				{name="GunStoreAmmunition", min=0, max=99, weightChance=40},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="FishingStoreGear", min=0, max=1, weightChance=20},
				{name="CampingStoreTents", min=1, max=4, weightChance=20},
				{name="CampingStoreLegwear", min=0, max=4, weightChance=60},
				{name="CampingStoreBackpacks", min=0, max=4, weightChance=40},
				{name="CampingStoreBooks", min=0, max=2, weightChance=80},
				{name="CampingStoreGear", min=0, max=99, weightChance=100},
			}
		},
		shelvesmag = {
			procedural = true,
			procList = {
				{name="GunStoreMagazineRack", min=0, max=99},
			}
		}
	},
	
	icecream = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreKitchenDishes", min=0, max=2, weightChance=100},
				{name="StoreKitchenPots", min=0, max=2, weightChance=100},
			}
		},
		displaycasebakery = {
			procedural = true,
			procList = {
				{name="FreezerIceCream", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="GroceryStandFruits1", min=0, max=99, weightChance=100},
				{name="GroceryStandFruits2", min=0, max=99, weightChance=100},
				{name="GroceryStandFruits3", min=0, max=99, weightChance=100},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="FreezerIceCream", min=0, max=99},
			}
		},
		restaurantdisplay = {
			procedural = true,
			procList = {
				{name="FreezerIceCream", min=0, max=99},
			}
		}
	},
	
	icecreamkitchen = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateConesIceCream", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateConesIceCream", min=0, max=99},
			}
		},
		displaycasebakery = {
			procedural = true,
			procList = {
				{name="CrateConesIceCream", min=0, max=99},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="FreezerIceCream", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="GroceryStandFruits1", min=0, max=99, weightChance=100},
				{name="GroceryStandFruits2", min=0, max=99, weightChance=100},
				{name="GroceryStandFruits3", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateConesIceCream", min=0, max=99},
			}
		},
		restaurantdisplay = {
			procedural = true,
			procList = {
				{name="FreezerIceCream", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateConesIceCream", min=0, max=99},
			}
		},
	},
	
	interrogationroom = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="PoliceFileBox", min=0, max=99},
			}
		},
		filingcabinet = {
			procedural = true,
			procList = {
				{name="PoliceFilingCabinet", min=0, max=99},
			}
		},
	},
	
	italiankitchen = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateCannedTomato", min=0, max=2, weightChance=100},
				{name="CrateFlour", min=0, max=1, weightChance=40},
				{name="CrateMacaroni", min=0, max=1, weightChance=60},
				{name="CrateOilOlive", min=0, max=1, weightChance=80},
				{name="CratePasta", min=0, max=1, weightChance=60},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="ItalianKitchenBaking", min=0, max=1, weightChance=100},
				{name="ItalianKitchenButcher", min=1, max=1, weightChance=100},
				{name="ItalianKitchenSauce", min=0, max=1, weightChance=100},
				{name="StoreKitchenCutlery", min=0, max=1, weightChance=20},
				{name="StoreKitchenDishes", min=0, max=1, weightChance=20},
				{name="StoreKitchenGlasses", min=0, max=1, weightChance=20},
				{name="StoreKitchenPots", min=0, max=1, weightChance=20},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateCannedTomato", min=0, max=2, weightChance=100},
				{name="CrateFlour", min=0, max=1, weightChance=40},
				{name="CrateMacaroni", min=0, max=1, weightChance=60},
				{name="CrateOilOlive", min=0, max=1, weightChance=80},
				{name="CratePasta", min=0, max=1, weightChance=60},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="ItalianKitchenFreezer", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="ItalianKitchenFridge", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateFlour", min=0, max=1, weightChance=100},
				{name="CrateMarinara", min=0, max=2, weightChance=100},
				{name="CrateOilOlive", min=0, max=1, weightChance=100},
				{name="CratePasta", min=0, max=2, weightChance=100},
				{name="CrateYeast", min=0, max=1, weightChance=100},
			}
		},
		restaurantdisplay = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="ServingTrayPizza", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateCannedTomato", min=0, max=2, weightChance=100},
				{name="CrateFlour", min=0, max=1, weightChance=40},
				{name="CrateMacaroni", min=0, max=1, weightChance=60},
				{name="CrateOilOlive", min=0, max=1, weightChance=80},
				{name="CratePasta", min=0, max=1, weightChance=60},
			}
		},
	},
	
	italianrestaurant = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
			}
		},
		displaycase = {
			procedural = true,
			procList = {
				{name="ServingTrayPizza", min=0, max=99},
			}
		},
		restaurantdisplay = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="ServingTrayPizza", min=0, max=99},
			}
		},
	},
	
	jackiejayeoffice = {
		desk = {
			procedural = true,
			procList = {
				{name="JackiesDesk", min=0, max=99},
			}
		},
		filingcabinet = {
			rolls = 1,
			items = {
				
			}
		},
	},
	
	jackiejayestudio = {
		desk = {
			procedural = true,
			procList = {
				{name="JackiesDesk", min=0, max=99},
			}
		},
		filingcabinet = {
			rolls = 1,
			items = {
				
			}
		},
	},
	
	janitor = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="JanitorChemicals", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="JanitorChemicals", min=0, max=99, weightChance=100},
				{name="JanitorCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="JanitorMisc", min=0, max=1, weightChance=100},
				{name="JanitorTools", min=0, max=1, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="JanitorChemicals", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="JanitorTools", min=1, max=1, weightChance=100},
				{name="JanitorCleaning", min=1, max=1, weightChance=100},
				{name="JanitorChemicals", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="JanitorChemicals", min=0, max=99},
			}
		},
	},
	
	jayschicken_dining = {
		isShop = true,
		bin = {
			isTrash = true,
			procedural = true,
			procList = {
				{name="BinJays", min=0, max=99},
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateFountainCups", min=0, max=1, weightChance=100},
				{name="CratePaperNapkins", min=0, max=1, weightChance=100},
				{name="CratePaperBagJays", min=0, max=1, weightChance=100},
				{name="CratePlasticTrays", min=0, max=1, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="Empty", min=0, max=99, forceForTiles="location_shop_accessories_01_8;location_shop_accessories_01_9;location_shop_accessories_01_10;location_shop_accessories_01_11;location_shop_accessories_01_11;location_shop_accessories_01_12"},
				{name="JaysDiningCounter", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateFountainCups", min=0, max=1, weightChance=100},
				{name="CratePaperNapkins", min=0, max=1, weightChance=100},
				{name="CratePaperBagJays", min=0, max=1, weightChance=100},
				{name="CratePlasticTrays", min=0, max=1, weightChance=100},
			}
		},
		restaurantdisplay = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="ServingTrayGravy", min=0, max=1, weightChance=20},
				{name="ServingTrayCornbread", min=0, max=1, weightChance=40},
				{name="ServingTrayFries", min=0, max=1, weightChance=60},
				{name="ServingTrayChicken", min=1, max=2, weightChance=80},
				{name="ServingTrayChickenNuggets", min=1, max=2, weightChance=80},
				{name="ServingTrayChickenWings", min=1, max=2, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateFountainCups", min=0, max=1, weightChance=100},
				{name="CratePaperNapkins", min=0, max=1, weightChance=100},
				{name="CratePaperBagJays", min=0, max=1, weightChance=100},
				{name="CratePlasticTrays", min=0, max=1, weightChance=100},
			}
		},
	},
	
	jayschicken_kitchen = {
		bin = {
			isTrash = true,
			procedural = true,
			procList = {
				{name="BinJays", min=0, max=99},
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateCornflour", min=0, max=1, weightChance=40},
				{name="CrateFlour", min=0, max=1, weightChance=40},
				{name="CrateGravyMix", min=0, max=1, weightChance=20},
				{name="CrateOilVegetable", min=0, max=1, weightChance=100},
				{name="FryFactoryPotatoes", min=0, max=2, weightChance=80},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="JaysKitchenBags", min=0, max=1, weightChance=20},
				{name="JaysKitchenBaking", min=0, max=1, weightChance=100},
				{name="JaysKitchenButcher", min=0, max=1, weightChance=100},
				{name="JaysKitchenSauce", min=0, max=1, weightChance=100},
				{name="StoreKitchenCups", min=0, max=1, weightChance=20},
				{name="StoreKitchenPotatoes", min=0, max=1, weightChance=100},
				{name="StoreKitchenPots", min=0, max=1, weightChance=20},
				{name="StoreKitchenTrays", min=0, max=1, weightChance=20},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateCornflour", min=0, max=1, weightChance=40},
				{name="CrateFlour", min=0, max=1, weightChance=40},
				{name="CrateGravyMix", min=0, max=1, weightChance=20},
				{name="CrateOilVegetable", min=0, max=1, weightChance=100},
				{name="FryFactoryPotatoes", min=0, max=2, weightChance=80},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="JaysKitchenFreezer", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="JaysKitchenFridge", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateCornflour", min=0, max=1, weightChance=40},
				{name="CrateFlour", min=0, max=1, weightChance=40},
				{name="CrateGravyMix", min=0, max=1, weightChance=20},
				{name="CrateOilVegetable", min=0, max=1, weightChance=100},
				{name="FryFactoryPotatoes", min=0, max=2, weightChance=80},
			}
		},
		restaurantdisplay = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="ServingTrayGravy", min=0, max=1, weightChance=20},
				{name="ServingTrayCornbread", min=0, max=1, weightChance=40},
				{name="ServingTrayFries", min=0, max=1, weightChance=60},
				{name="ServingTrayChicken", min=1, max=2, weightChance=80},
				{name="ServingTrayChickenNuggets", min=1, max=2, weightChance=80},
				{name="ServingTrayChickenWings", min=1, max=2, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateFountainCups", min=0, max=1, weightChance=100},
				{name="CratePaperNapkins", min=0, max=1, weightChance=100},
				{name="CratePaperBagJays", min=0, max=1, weightChance=100},
				{name="CratePlasticTrays", min=0, max=1, weightChance=100},
			}
		},
	},
	
	jerkycoldroom = {
		isShop = true,
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="JerkyFactoryMeat", min=0, max=99},
			}
		},
	},
	
	jerkyfactory = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="JerkyFactoryCrate", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="JerkyFactoryTools", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="JerkyFactorySpices", min=0, max=99},
			}
		},
	},
	
	jerkyshipping = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="JerkyFactoryCrate", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="JerkyFactorySpices", min=0, max=99},
			}
		},
	},
	
	-- Empty till the smoking mechanics are sorted.
	jerkysmoker = {
		metal_shelves = {
			rolls = 1,
			items = {
				
			}
		},
	},
	
	jewelrystorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="JewelryStorageAll", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="JewelerTools", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="JewelryStorageAll", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="JewelryStorageAll", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="JewelryStorageAll", min=0, max=99},
			}
		},
	},
	
	jewelrystore = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreCounterBags", min=0, max=1, weightChance=20},
				{name="JewelerTools", min=0, max=99, weightChance=100},
			}
		},
		displaycase = {
			procedural = true,
			procList = {
				{name="JewelryGems", min=0, max=99, weightChance=10},
				{name="JewelryGold", min=1, max=99, weightChance=100},
				{name="JewelrySilver", min=1, max=99, weightChance=100},
				{name="JewelryNavelRings", min=0, max=99, weightChance=20},
				{name="JewelryOthers", min=0, max=99, weightChance=40},
				{name="JewelryWeddingRings", min=1, max=99, weightChance=100},
				{name="JewelryWrist", min=0, max=99, weightChance=40},
			}
		},
	},
	
	joanstudio = {
		counter = {
			rolls = 1,
			items = {
				
			}
		},
		desk = {
			rolls = 1,
			items = {
				
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateElectronics", min=1, max=99, weightChance=40},
				{name="BackstageRigging", min=1, max=99, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="LivingRoomShelf", min=0, max=99},
			}
		},
	},
	
	judgematthassset = {
		counter = {
			procedural = true,
			procList = {
				{name="JudgeMattHassCounter", min=1, max=1, forceForTiles="location_restaurant_bar_01_57"},
				{name="Empty", min=0, max=99, weightChance=100},
			}
		},
	},
	
	kennels = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="CratePetSupplies", min=1, max=10, weightChance=100},
				{name="MedicalClinicTools", min=1, max=10, weightChance=80},
				{name="MedicalClinicDrugs", min=1, max=10, weightChance=70},
				{name="MedicalClinicOutfit", min=1, max=10, weightChance=20},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeMedical", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="MedicalStorageDrugs", min=1, max=6, weightChance=100},
				{name="MedicalStorageTools", min=1, max=4, weightChance=100},
				{name="MedicalStorageOutfit", min=1, max=2, weightChance=100},
			}
		}
	},
	
	kidsbedroom = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateBooks", min=0, max=1, weightChance=100},
				{name="CrateClothesRandom", min=0, max=1, weightChance=20},
				{name="CrateComics", min=0, max=1, weightChance=80},
				{name="CrateCompactDiscs", min=0, max=1, weightChance=80},
				{name="CrateLinens", min=0, max=1, weightChance=40},
				{name="CrateToys", min=0, max=1, weightChance=40},
				{name="CrateVHSTapes", min=0, max=1, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateBooks", min=0, max=1, weightChance=100},
				{name="CrateClothesRandom", min=0, max=1, weightChance=20},
				{name="CrateComics", min=0, max=1, weightChance=80},
				{name="CrateCompactDiscs", min=0, max=1, weightChance=80},
				{name="CrateLinens", min=0, max=1, weightChance=40},
				{name="CrateToys", min=0, max=1, weightChance=40},
				{name="CrateVHSTapes", min=0, max=1, weightChance=100},
			}
		},
		dresser = {
			procedural = true,
			procList = {
				{name="BedroomDresserChild", min=1, max=99},
			}
		},
		sidetable = {
			procedural = true,
			procList = {
				{name="BedroomSidetableChild", min=1, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateBooks", min=0, max=1, weightChance=100},
				{name="CrateClothesRandom", min=0, max=1, weightChance=20},
				{name="CrateComics", min=0, max=1, weightChance=80},
				{name="CrateCompactDiscs", min=0, max=1, weightChance=80},
				{name="CrateLinens", min=0, max=1, weightChance=40},
				{name="CrateToys", min=0, max=1, weightChance=40},
				{name="CrateVHSTapes", min=0, max=1, weightChance=100},
			}
		},
		wardrobe = {
			procedural = true,
			procList = {
				{name="WardrobeChild", min=1, max=99},
			}
		}
	},
	
	kitchen = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="ArtSupplies", min=0, max=1, weightChance=10},
				{name="CrateCannedFood", min=0, max=1, weightChance=60},
				{name="CrateDishes", min=0, max=1, weightChance=80},
				{name="CrateTools", min=0, max=1, weightChance=20},
				{name="CrateToolsOld", min=0, max=1, weightChance=80},
				{name="Hobbies", min=0, max=1, weightChance=10},
				{name="Homesteading", min=0, max=1, weightChance=10},
				{name="ImprovisedCrafts", min=0, max=1, weightChance=10},
				{name="JunkHoard", min=0, max=1, weightChance=10},
				{name="KitchenBook", min=0, max=1, weightChance=100},
				{name="PlumbingSupplies", min=0, max=1, weightChance=10},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="KitchenBottles", min=0, max=1, weightChance=40},
				{name="KitchenBaking", min=0, max=1, weightChance=40},
				{name="KitchenBreakfast", min=0, max=1, weightChance=80},
				{name="KitchenCannedFood", min=0, max=1, weightChance=100},
				{name="KitchenDishes", min=0, max=1, weightChance=80},
				{name="KitchenDryFood", min=0, max=1, weightChance=100},
				{name="KitchenPots", min=0, max=1, weightChance=80},
				{name="KitchenRandom", min=0, max=1, weightChance=20}, -- this has a lot of useful stuff in it, crafting, collectibles, rarities, flashlights, candles, batteries, sparklers, etc., and probably should have a much greater weight
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="ArtSupplies", min=0, max=1, weightChance=10},
				{name="CrateCannedFood", min=0, max=1, weightChance=60},
				{name="CrateDishes", min=0, max=1, weightChance=80},
				{name="CrateTools", min=0, max=1, weightChance=20},
				{name="CrateToolsOld", min=0, max=1, weightChance=80},
				{name="Hobbies", min=0, max=1, weightChance=10},
				{name="Homesteading", min=0, max=1, weightChance=10},
				{name="ImprovisedCrafts", min=0, max=1, weightChance=10},
				{name="JunkHoard", min=0, max=1, weightChance=10},
				{name="KitchenBook", min=0, max=1, weightChance=100},
				{name="PlumbingSupplies", min=0, max=1, weightChance=10},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="FreezerGeneric", min=0, max=99, weightChance=100},
				{name="FreezerRich", min=0, max=99, forceForZones="Rich"},
				{name="FreezerTrailerPark", min=0, max=99, forceForZones="TrailerPark"},
			}
		},
		overhead = {
			procedural = true,
			procList = {
				{name="KitchenBaking", min=0, max=1, weightChance=40},
				{name="KitchenBottles", min=0, max=1, weightChance=40},
				{name="KitchenBreakfast", min=0, max=1, weightChance=80},
				{name="KitchenCannedFood", min=0, max=2, weightChance=100},
				{name="KitchenDishes", min=1, max=1, weightChance=100},
				{name="KitchenDryFood", min=0, max=4, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="KitchenCannedFood", min=0, max=1, weightChance=100},
				{name="KitchenDryFood", min=0, max=1, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="KitchenBook", min=0, max=99, forceForTiles="furniture_shelving_01_19;furniture_shelving_01_23;furniture_shelving_01_51;furniture_shelving_01_55"},
				{name="KitchenBottles", min=0, max=1, weightChance=40},
				{name="KitchenCannedFood", min=0, max=1, weightChance=100},
				{name="KitchenDishes", min=0, max=1, weightChance=80},
				{name="KitchenDryFood", min=0, max=1, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="ArtSupplies", min=0, max=1, weightChance=10},
				{name="CrateComics", min=0, max=1, weightChance=10},
				{name="CrateCompactDiscs", min=0, max=1, weightChance=10},
				{name="CrateDishes", min=0, max=1, weightChance=100},
				{name="CrateEmptyBottles1", min=0, max=1, weightChance=80},
				{name="CrateEmptyBottles2", min=0, max=1, weightChance=80},
				{name="CrateEmptyMixed", min=0, max=1, weightChance=80},
				{name="CrateEmptyTinCans", min=0, max=1, weightChance=80},
				{name="CrateLinens", min=0, max=1, weightChance=20},
				{name="CrateMagazines", min=0, max=1, weightChance=40},
				{name="CrateNewspapers", min=0, max=1, weightChance=10},
				{name="CrateNewspapers", min=0, max=1, weightChance=20},
				{name="CratePetSupplies", min=0, max=1, weightChance=10},
				{name="CrateTailoring", min=0, max=1, weightChance=10},
				{name="CrateToys", min=0, max=1, weightChance=10},
				{name="CrateVHSTapes", min=0, max=1, weightChance=10},
				{name="Hobbies", min=0, max=1, weightChance=10},
				{name="Homesteading", min=0, max=1, weightChance=10},
				{name="ImprovisedCrafts", min=0, max=1, weightChance=10},
				{name="JunkHoard", min=0, max=1, weightChance=10},
				{name="KitchenBook", min=0, max=1, weightChance=100},
				{name="PlumbingSupplies", min=0, max=1, weightChance=10},
			}
		},
		stove = {
			--TODO: Find a way to make forceFor entries play nicely with each other.
			procedural = true,
			procList = {
				{name="StoveClassy", min=98, max=99, forceForZones="Rich"},
				{name="StoveGeneric", min=98, max=99, weightChance=100},
				{name="StoveRedneck", min=98, max=99, forceForZones="TrailerPark"},
			}
		},
	},
	
	kitchen_crepe = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateButter", min=0, max=1, weightChance=20},
				{name="CrateMapleSyrup", min=0, max=2, weightChance=80},
				{name="CrateOilVegetable", min=0, max=1, weightChance=40},
				{name="CratePancakeMix", min=0, max=4, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="CrepeKitchenBaking", min=0, max=1, weightChance=100},
				{name="CrepeKitchenSauce", min=0, max=1, weightChance=100},
				{name="StoreKitchenCafe", min=0, max=1, weightChance=100},
				{name="StoreKitchenCutlery", min=0, max=1, weightChance=20},
				{name="StoreKitchenDishes", min=0, max=1, weightChance=20},
				{name="StoreKitchenGlasses", min=0, max=1, weightChance=20},
				{name="StoreKitchenPotatoes", min=0, max=1, weightChance=100},
				{name="StoreKitchenPots", min=0, max=1, weightChance=20},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateButter", min=0, max=1, weightChance=20},
				{name="CrateMapleSyrup", min=0, max=2, weightChance=80},
				{name="CrateOilVegetable", min=0, max=1, weightChance=40},
				{name="CratePancakeMix", min=0, max=4, weightChance=100},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="CrepeKitchenFridge", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateButter", min=0, max=1, weightChance=100},
				{name="CrateMapleSyrup", min=0, max=2, weightChance=100},
				{name="CrateOilVegetable", min=0, max=1, weightChance=100},
				{name="CratePancakeMix", min=0, max=4, weightChance=100},
			}
		},
		restaurantdisplay = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="ServingTrayOmelettes", min=1, max=2, weightChance=60},
				{name="ServingTrayPancakes", min=1, max=4, weightChance=100},
				{name="ServingTrayPotatoPancakes", min=1, max=4, weightChance=100},
				{name="ServingTrayScrambledEggs", min=1, max=2, weightChance=60},
				{name="ServingTrayWaffles", min=1, max=4, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateButter", min=0, max=1, weightChance=20},
				{name="CrateMapleSyrup", min=0, max=2, weightChance=80},
				{name="CrateOilVegetable", min=0, max=1, weightChance=40},
				{name="CratePancakeMix", min=0, max=4, weightChance=100},
			}
		},
	},
	
	kitchenwares = {
		isShop = true,
		shelves = {
			procedural = true,
			procList = {
				{name="GigamartHousewares", min=1, max=12, weightChance=100},
				{name="GigamartBedding", min=0, max=2, weightChance=100},
				{name="GigamartPots", min=1, max=6, weightChance=100},
				{name="GigamartLightbulb", min=1, max=2, weightChance=100},
				{name="GigamartHouseElectronics", min=1, max=2, weightChance=100},
			}
		},
	},
	
	knifefactory = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="KnifeFactoryMeatCleaverBlades", min=0, max=99, weightChance=10},
				{name="KnifeFactoryKitchenKnifeBlades", min=0, max=99, weightChance=80},
				{name="KnifeFactoryHandles", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="KnifeFactoryTools", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="KnifeFactoryMeatCleaverBlades", min=0, max=99, weightChance=10},
				{name="KnifeFactoryKitchenKnifeBlades", min=0, max=99, weightChance=80},
				{name="KnifeFactoryHandles", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="KnifeFactoryMeatCleaverBlades", min=0, max=99, weightChance=10},
				{name="KnifeFactoryKitchenKnifeBlades", min=0, max=99, weightChance=80},
				{name="KnifeFactoryHandles", min=0, max=99, weightChance=100},
			}
		},
		toolcabinet = {
			procedural = true,
			procList = {
				{name="KnifeFactoryTools", min=0, max=99},
			}
		},
	},
	
	knifeshipping = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="KnifeFactorySushiKnife", min=0, max=99, weightChance=5},
				{name="KnifeFactoryMeatCleaver", min=0, max=99, weightChance=20},
				{name="KnifeFactoryKitchenKnife", min=0, max=99, weightChance=80},
				{name="KnifeFactoryCutlery", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="KnifeFactorySushiKnife", min=0, max=99, weightChance=5},
				{name="KnifeFactoryMeatCleaver", min=0, max=99, weightChance=20},
				{name="KnifeFactoryKitchenKnife", min=0, max=99, weightChance=80},
				{name="KnifeFactoryCutlery", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="KnifeFactorySushiKnife", min=0, max=99, weightChance=5},
				{name="KnifeFactoryMeatCleaver", min=0, max=99, weightChance=20},
				{name="KnifeFactoryKitchenKnife", min=0, max=99, weightChance=80},
				{name="KnifeFactoryCutlery", min=0, max=99, weightChance=100},
			}
		},
	},
	
	knifestore = {
		isShop = true,
		shelves = {
			procedural = true,
			procList = {
				{name="KnifeStoreCutlery", min=0, max=99},
			}
		},
	},
	
	laboratory = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="Chemistry", min=1, max=99, weightChance=100},
				{name="ScienceMisc", min=1, max=99, weightChance=100},
				{name="TestingLab", min=1, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="Chemistry", min=1, max=99, weightChance=100},
				{name="ScienceMisc", min=1, max=99, weightChance=100},
				{name="TestingLab", min=1, max=99, weightChance=100},
			}
		},
		desk = {
			procedural = true,
			procList = {
				{name="Chemistry", min=1, max=99, weightChance=100},
				{name="ScienceMisc", min=1, max=99, weightChance=100},
				{name="TestingLab", min=1, max=99, weightChance=100},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeMedical", min=0, max=99},
			}
		},
		locker = {
			procedural = true,
			procList = {
				{name="LaboratoryGasStorage", min=0, max=99, forceForTiles="furniture_storage_02_8;furniture_storage_02_9;furniture_storage_02_10;furniture_storage_02_11"},
				{name="LaboratoryLockers", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="Chemistry", min=1, max=99, weightChance=100},
				{name="ScienceMisc", min=1, max=99, weightChance=100},
				{name="TestingLab", min=1, max=99, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="LaboratoryBooks", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="Chemistry", min=1, max=99, weightChance=100},
				{name="ScienceMisc", min=1, max=99, weightChance=100},
				{name="TestingLab", min=1, max=99, weightChance=100},
			}
		},
	},
	
	lasertag = {
		isShop = true,
		crate = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	laundry = {
		clothingdryer = {
			procedural = true,
			procList = {
				{name="GymLaundry", min=0, max=99, forceForRooms="fitness"},
				{name="DryerEmpty", min=0, max=99, weightChance=100},
				{name="LaundryHospital", min=0, max=99, forceForRooms="hospitalroom"},
				{name="LaundryLoad1", min=0, max=1, weightChance=10},
				{name="LaundryLoad2", min=0, max=1, weightChance=10},
				{name="LaundryLoad3", min=0, max=1, weightChance=10},
				{name="LaundryLoad4", min=0, max=1, weightChance=10},
				{name="LaundryLoad5", min=0, max=1, weightChance=10},
				{name="LaundryLoad6", min=0, max=1, weightChance=10},
				{name="LaundryLoad7", min=0, max=1, weightChance=10},
				{name="LaundryLoad8", min=0, max=1, weightChance=10},
			}
		},
		clothingdryerbasic = {
			procedural = true,
			procList = {
				{name="GymLaundry", min=0, max=99, forceForRooms="fitness"},
				{name="DryerEmpty", min=0, max=99, weightChance=100},
				{name="LaundryHospital", min=0, max=99, forceForRooms="hospitalroom"},
				{name="LaundryLoad1", min=0, max=1, weightChance=10},
				{name="LaundryLoad2", min=0, max=1, weightChance=10},
				{name="LaundryLoad3", min=0, max=1, weightChance=10},
				{name="LaundryLoad4", min=0, max=1, weightChance=10},
				{name="LaundryLoad5", min=0, max=1, weightChance=10},
				{name="LaundryLoad6", min=0, max=1, weightChance=10},
				{name="LaundryLoad7", min=0, max=1, weightChance=10},
				{name="LaundryLoad8", min=0, max=1, weightChance=10},
			}
		},
		clothingwasher = {
			procedural = true,
			procList = {
				{name="GymLaundry", min=0, max=99, forceForRooms="fitness"},
				{name="Empty", min=0, max=99, weightChance=100},
				{name="LaundryHospital", min=0, max=99, forceForRooms="hospitalroom"},
				{name="LaundryLoad1", min=0, max=1, weightChance=10},
				{name="LaundryLoad2", min=0, max=1, weightChance=10},
				{name="LaundryLoad3", min=0, max=1, weightChance=10},
				{name="LaundryLoad4", min=0, max=1, weightChance=10},
				{name="LaundryLoad5", min=0, max=1, weightChance=10},
				{name="LaundryLoad6", min=0, max=1, weightChance=10},
				{name="LaundryLoad7", min=0, max=1, weightChance=10},
				{name="LaundryLoad8", min=0, max=1, weightChance=10},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="Empty", min=0, max=99, weightChance=80},
				{name="LaundryCleaning", min=0, max=99, weightChance=100},
				{name="LaundryLoad1", min=0, max=1, weightChance=10},
				{name="LaundryLoad2", min=0, max=1, weightChance=10},
				{name="LaundryLoad3", min=0, max=1, weightChance=10},
				{name="LaundryLoad4", min=0, max=1, weightChance=10},
				{name="LaundryLoad5", min=0, max=1, weightChance=10},
				{name="LaundryLoad6", min=0, max=1, weightChance=10},
			}
		},
		locker = {
			procedural = true,
			procList = {
				{name="FactoryLockers", min=0, max=99, forceForRooms="batteryfactory"},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="LaundryCleaning", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="LaundryCleaning", min=0, max=99},
			}
		},
	},
	
	leatherclothesstore = {
		isShop = true,
		displaycase = {
			procedural = true,
			procList = {
				{name="StoreDisplayWatches", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="ClothingStoresBoots", min=0, max=99, weightChance=60},
				{name="ClothingStoresGlovesLeather", min=0, max=99, weightChance=10},
				{name="ClothingStoresHolsters", min=0, max=99, weightChance=10},
				{name="ClothingStoresPantsLeather", min=0, max=99, weightChance=100},
				{name="ClothingStoresShoesLeather", min=0, max=99, weightChance=100},
			}
		},
		clothingrack = {
			procedural = true,
			procList = {
				{name="ClothingStoresJacketsLeather", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="ClothingStoresGlovesLeather", min=0, max=4, weightChance=100},
				{name="ClothingStoresHolsters", min=0, max=4, weightChance=60},
				{name="StoreCounterBagsFancy", min=0, max=1, weightChance=100},
			}
		}
	},
	
	library = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="LibraryBooks", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="LibraryCounter", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="LibraryBooks", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="LibraryArt", min=0, max=1, weightChance=40},
				{name="LibraryBiography", min=0, max=1, weightChance=40},
				{name="LibraryBooks", min=1, max=99, weightChance=20},
				{name="LibraryBusiness", min=0, max=1, weightChance=20},
				{name="LibraryChilds", min=1, max=1, weightChance=100},
				{name="LibraryCinema", min=0, max=1, weightChance=20},
				{name="LibraryComputer", min=0, max=1, weightChance=20},
				{name="LibraryCrimeFiction", min=0, max=1, weightChance=20},
				{name="LibraryFantasySciFi", min=1, max=1, weightChance=100},
				{name="LibraryFashion", min=0, max=1, weightChance=20},
				{name="LibraryGeneralReference", min=0, max=1, weightChance=80},
				{name="LibraryHistory", min=0, max=1, weightChance=80},
				{name="LibraryHorror", min=0, max=1, weightChance=40},
				{name="LibraryLegal", min=0, max=1, weightChance=20},
				{name="LibraryLiteraryFiction", min=1, max=1, weightChance=100},
				{name="LibraryMagazines", min=1, max=99, weightChance=20},
				{name="LibraryMedical", min=0, max=1, weightChance=100},
				{name="LibraryMilitaryHistory", min=0, max=1, weightChance=20},
				{name="LibraryMusic", min=0, max=1, weightChance=60},
				{name="LibraryNewAge", min=0, max=1, weightChance=20},
				{name="LibraryNonFiction", min=0, max=1, weightChance=100},
				{name="LibraryOccult", min=0, max=1, weightChance=10},
				{name="LibraryOutdoors", min=1, max=1, weightChance=100},
				{name="LibraryPhilosophy", min=0, max=1, weightChance=80},
				{name="LibraryPolitics", min=0, max=1, weightChance=80},
				{name="LibraryReligion", min=0, max=1, weightChance=20},
				{name="LibraryRomance", min=0, max=1, weightChance=20},
				{name="LibraryScience", min=0, max=1, weightChance=80},
				{name="LibrarySports", min=0, max=1, weightChance=40},
				{name="LibraryThriller", min=0, max=1, weightChance=20},
				{name="LibraryTravel", min=0, max=1, weightChance=20},
				{name="LibraryWestern", min=0, max=1, weightChance=20},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="LibraryBooks", min=0, max=99},
			}
		},
	},
	
	lingeriestore = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="LingerieStoreOutfits", min=0, max=99, weightChance=100},
				{name="LingerieStoreAccessories", min=0, max=99, weightChance=100},
				{name="LingerieStoreBras", min=0, max=99, weightChance=100},
				{name="LingerieStoreUnderwear", min=0, max=99, weightChance=100},
			}
		},
		clothingrack = {
			procedural = true,
			procList = {
				{name="LingerieStoreOutfits", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreCounterBagsFancy", min=0, max=1, weightChance=100},
				{name="LingerieStoreAccessories", min=0, max=99, weightChance=100},
				{name="LingerieStoreBras", min=0, max=99, weightChance=100},
				{name="LingerieStoreUnderwear", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="LingerieStoreOutfits", min=0, max=99, weightChance=100},
				{name="LingerieStoreAccessories", min=0, max=99, weightChance=100},
				{name="LingerieStoreBras", min=0, max=99, weightChance=100},
				{name="LingerieStoreUnderwear", min=0, max=99, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="LingerieStoreOutfits", min=0, max=99, weightChance=100},
				{name="LingerieStoreAccessories", min=0, max=99, weightChance=100},
				{name="LingerieStoreBras", min=0, max=99, weightChance=100},
				{name="LingerieStoreUnderwear", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="LingerieStoreOutfits", min=0, max=99, weightChance=100},
				{name="LingerieStoreAccessories", min=0, max=99, weightChance=100},
				{name="LingerieStoreBras", min=0, max=99, weightChance=100},
				{name="LingerieStoreUnderwear", min=0, max=99, weightChance=100},
			}
		},
	},
	
	liquorstore = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateLiquor", min=0, max=99, weightChance=40},
				{name="CrateWine", min=0, max=99, weightChance=60},
				{name="CrateBeer", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="LiquorStoreBags", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="GasStoreSpecial", min=0, max=1, weightChance=5},
				{name="StoreCounterTobacco", min=0, max=1, weightChance=20},
				{name="StoreCounterBagsPaper", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateLiquor", min=0, max=99, weightChance=40},
				{name="CrateWine", min=0, max=99, weightChance=60},
				{name="CrateBeer", min=0, max=99, weightChance=100},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeBeer", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="LiquorStoreGin", min=1, max=4, weightChance=40},
				{name="LiquorStoreRum", min=1, max=4, weightChance=40},
				{name="LiquorStoreTequila", min=1, max=4, weightChance=40},
				{name="LiquorStoreVodka", min=1, max=4, weightChance=40},
				{name="LiquorStoreWhiskey", min=1, max=4, weightChance=40},
				{name="LiquorStoreWine", min=1, max=4, weightChance=60},
				{name="LiquorStoreBeerFancy", min=0, max=4, weightChance=60},
				{name="LiquorStoreBeer", min=0, max=12, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="LiquorStoreWineFancy", min=0, max=1, weightChance=10},
				{name="LiquorStoreBrandy", min=0, max=1, weightChance=20},
				{name="LiquorStoreScotch", min=0, max=1, weightChance=20},
				{name="LiquorStoreMix", min=1, max=2, weightChance=40},
				{name="LiquorStoreGin", min=1, max=4, weightChance=40},
				{name="LiquorStoreRum", min=1, max=4, weightChance=40},
				{name="LiquorStoreTequila", min=1, max=4, weightChance=40},
				{name="LiquorStoreVodka", min=1, max=4, weightChance=40},
				{name="LiquorStoreWhiskey", min=1, max=4, weightChance=40},
				{name="LiquorStoreWine", min=1, max=4, weightChance=60},
				{name="LiquorStoreBeerFancy", min=0, max=4, weightChance=60},
				{name="LiquorStoreBeer", min=0, max=12, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateLiquor", min=0, max=99, weightChance=40},
				{name="CrateWine", min=0, max=99, weightChance=60},
				{name="CrateBeer", min=0, max=99, weightChance=100},
			}
		},
	},
	
	livingroom = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="Antiques", min=0, max=1, weightChance=20},
				{name="ArtSupplies", min=0, max=1, weightChance=20},
				{name="BurglarTools", min=0, max=1, weightChance=5},
				{name="Chemistry", min=0, max=1, weightChance=10},
				{name="ClothingStorageWinter", min=0, max=1, weightChance=10},
				{name="CrateBooks", min=0, max=1, weightChance=40},
				{name="CrateBooks", min=0, max=1, weightChance=60},
				{name="CrateCanning", min=0, max=1, weightChance=20},
				{name="CrateCanning", min=0, max=1, weightChance=5},
				{name="CrateClothesRandom", min=0, max=1, weightChance=20},
				{name="CrateComics", min=0, max=1, weightChance=40},
				{name="CrateComics", min=0, max=1, weightChance=60},
				{name="CrateCompactDiscs", min=0, max=1, weightChance=10},
				{name="CrateCompactDiscs", min=0, max=1, weightChance=40},
				{name="CrateComputer", min=0, max=1, weightChance=10},
				{name="CrateCostume", min=0, max=1, weightChance=10},
				{name="CrateDishes", min=0, max=1, weightChance=10},
				{name="CrateElectronics", min=0, max=1, weightChance=40},
				{name="CrateFitnessWeights", min=0, max=1, weightChance=10},
				{name="CrateFootwearRandom", min=0, max=1, weightChance=10},
				{name="CrateInstruments", min=0, max=1, weightChance=10},
				{name="CrateLinens", min=0, max=1, weightChance=10},
				{name="CrateMagazines", min=0, max=1, weightChance=80},
				{name="CrateNewspapers", min=0, max=1, weightChance=60},
				{name="CratePetSupplies", min=0, max=1, weightChance=10},
				{name="CratePhotos", min=0, max=1, weightChance=20},
				{name="CrateTailoring", min=0, max=1, weightChance=10},
				{name="CrateTools", min=0, max=1, weightChance=60},
				{name="CrateToolsOld", min=0, max=1, weightChance=80},
				{name="CrateToys", min=0, max=1, weightChance=10},
				{name="CrateTV", min=0, max=1, weightChance=10},
				{name="CrateTVWide", min=0, max=1, weightChance=10},
				{name="CrateVHSTapes", min=0, max=1, weightChance=80},
				{name="EngineerTools", min=0, max=1, weightChance=5},
				{name="FitnessTrainer", min=0, max=1, weightChance=10},
				{name="Gifts", min=0, max=1, weightChance=10},
				{name="Hiker", min=0, max=1, weightChance=5},
				{name="Hobbies", min=0, max=1, weightChance=20},
				{name="HolidayStuff", min=0, max=1, weightChance=10},
				{name="Homesteading", min=0, max=1, weightChance=5},
				{name="Hunter", min=0, max=1, weightChance=5},
				{name="ImprovisedCrafts", min=0, max=1, weightChance=20},
				{name="JunkHoard", min=0, max=1, weightChance=20},
				{name="MechanicSpecial", min=0, max=1, weightChance=5},
				{name="Photographer", min=0, max=1, weightChance=10},
				{name="PlumbingSupplies", min=0, max=1, weightChance=5},
				{name="ScienceMisc", min=0, max=1, weightChance=5},
				{name="SurvivalGear", min=0, max=1, weightChance=5},
				{name="Trapper", min=0, max=1, weightChance=5},
				{name="VacationStuff", min=0, max=1, weightChance=20},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="KitchenDishes", min=1, max=1, weightChance=100},
				{name="KitchenPots", min=1, max=1, weightChance=100},
				{name="KitchenCannedFood", min=1, max=1, weightChance=100},
				{name="KitchenDryFood", min=0, max=1, weightChance=100},
				{name="KitchenBreakfast", min=0, max=1, weightChance=100},
				{name="KitchenBottles", min=0, max=1, weightChance=100},
				{name="KitchenRandom", min=0, max=1, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="Antiques", min=0, max=1, weightChance=20},
				{name="ArtSupplies", min=0, max=1, weightChance=20},
				{name="BurglarTools", min=0, max=1, weightChance=5},
				{name="Chemistry", min=0, max=1, weightChance=10},
				{name="ClothingStorageWinter", min=0, max=1, weightChance=10},
				{name="CrateBooks", min=0, max=1, weightChance=40},
				{name="CrateBooks", min=0, max=1, weightChance=60},
				{name="CrateCanning", min=0, max=1, weightChance=20},
				{name="CrateCanning", min=0, max=1, weightChance=5},
				{name="CrateClothesRandom", min=0, max=1, weightChance=20},
				{name="CrateComics", min=0, max=1, weightChance=40},
				{name="CrateComics", min=0, max=1, weightChance=60},
				{name="CrateCompactDiscs", min=0, max=1, weightChance=10},
				{name="CrateCompactDiscs", min=0, max=1, weightChance=40},
				{name="CrateComputer", min=0, max=1, weightChance=10},
				{name="CrateCostume", min=0, max=1, weightChance=10},
				{name="CrateDishes", min=0, max=1, weightChance=10},
				{name="CrateElectronics", min=0, max=1, weightChance=40},
				{name="CrateFitnessWeights", min=0, max=1, weightChance=10},
				{name="CrateFootwearRandom", min=0, max=1, weightChance=10},
				{name="CrateInstruments", min=0, max=1, weightChance=10},
				{name="CrateLinens", min=0, max=1, weightChance=10},
				{name="CrateMagazines", min=0, max=1, weightChance=80},
				{name="CrateNewspapers", min=0, max=1, weightChance=60},
				{name="CratePetSupplies", min=0, max=1, weightChance=10},
				{name="CrateTailoring", min=0, max=1, weightChance=10},
				{name="CrateTools", min=0, max=1, weightChance=60},
				{name="CrateToolsOld", min=0, max=1, weightChance=80},
				{name="CrateToys", min=0, max=1, weightChance=10},
				{name="CrateTV", min=0, max=1, weightChance=10},
				{name="CrateTVWide", min=0, max=1, weightChance=10},
				{name="CrateVHSTapes", min=0, max=1, weightChance=80},
				{name="EngineerTools", min=0, max=1, weightChance=5},
				{name="FitnessTrainer", min=0, max=1, weightChance=10},
				{name="Gifts", min=0, max=1, weightChance=10},
				{name="Hiker", min=0, max=1, weightChance=5},
				{name="Hobbies", min=0, max=1, weightChance=20},
				{name="HolidayStuff", min=0, max=1, weightChance=10},
				{name="Homesteading", min=0, max=1, weightChance=5},
				{name="Hunter", min=0, max=1, weightChance=5},
				{name="ImprovisedCrafts", min=0, max=1, weightChance=20},
				{name="JunkHoard", min=0, max=1, weightChance=20},
				{name="MechanicSpecial", min=0, max=1, weightChance=5},
				{name="Photographer", min=0, max=1, weightChance=10},
				{name="PlumbingSupplies", min=0, max=1, weightChance=5},
				{name="ScienceMisc", min=0, max=1, weightChance=5},
				{name="SurvivalGear", min=0, max=1, weightChance=5},
				{name="Trapper", min=0, max=1, weightChance=5},
				{name="VacationStuff", min=0, max=1, weightChance=20},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="FreezerGeneric", min=0, max=99, weightChance=100},
				{name="FreezerRich", min=0, max=99, forceForZones="Rich"},
				{name="FreezerTrailerPark", min=0, max=99, forceForZones="TrailerPark"},
				{name="Empty", min=0, max=99, forceForZones="University"},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeGeneric", min=0, max=99, weightChance=100},
				{name="FridgeRich", min=0, max=99, forceForZones="Rich"},
				{name="FridgeTrailerPark", min=0, max=99, forceForZones="TrailerPark"},
				{name="UniversityFridge", min=0, max=99, forceForZones="University"},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="LivingRoomShelf", min=98, max=99, weightChance=100},
				{name="LivingRoomShelfClassy", min=98, max=99, forceForZones="Rich"},
				{name="LivingRoomShelfRedneck", min=98, max=99, forceForZones="TrailerPark"},
			}
		},
		sidetable = {
			procedural = true,
			procList = {
				{name="LivingRoomSideTable", min=98, max=99, weightChance=100},
				{name="LivingRoomSideTableClassy", min=98, max=99, forceForZones="Rich"},
				{name="LivingRoomSideTableRedneck", min=98, max=99, forceForZones="TrailerPark"},
				{name="UniversitySideTable", min=98, max=99, forceForZones="University"},
			}
		},
		overhead = {
			procedural = true,
			procList = {
				{name="KitchenDishes", min=1, max=1, weightChance=100},
				{name="KitchenCannedFood", min=1, max=1, weightChance=100},
				{name="KitchenDryFood", min=0, max=1, weightChance=100},
				{name="KitchenBreakfast", min=0, max=1, weightChance=100},
				{name="KitchenBottles", min=0, max=1, weightChance=100},
				{name="KitchenBook", min=0, max=1, weightChance=100},
			}
		},
		wardrobe = {
			procedural = true,
			procList = {
				{name="Antiques", min=0, max=1, weightChance=1},
				{name="ArtSupplies", min=0, max=1, weightChance=1},
				{name="Hobbies", min=0, max=1, weightChance=1},
				{name="LivingRoomWardrobe", min=0, max=99, weightChance=100},
				{name="UniversityWardrobe", min=0, max=99, forceForZones="University"},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="Antiques", min=0, max=1, weightChance=20},
				{name="ArtSupplies", min=0, max=1, weightChance=20},
				{name="BurglarTools", min=0, max=1, weightChance=5},
				{name="Chemistry", min=0, max=1, weightChance=10},
				{name="ClothingStorageWinter", min=0, max=1, weightChance=10},
				{name="CrateBooks", min=0, max=1, weightChance=60},
				{name="CrateCanning", min=0, max=1, weightChance=5},
				{name="CrateClothesRandom", min=0, max=1, weightChance=20},
				{name="CrateComics", min=0, max=1, weightChance=40},
				{name="CrateComics", min=0, max=1, weightChance=60},
				{name="CrateCompactDiscs", min=0, max=1, weightChance=10},
				{name="CrateCompactDiscs", min=0, max=1, weightChance=40},
				{name="CrateCostume", min=0, max=1, weightChance=10},
				{name="CrateDishes", min=0, max=1, weightChance=10},
				{name="CrateElectronics", min=0, max=1, weightChance=40},
				{name="CrateFootwearRandom", min=0, max=1, weightChance=10},
				{name="CrateLinens", min=0, max=1, weightChance=10},
				{name="CrateMagazines", min=0, max=1, weightChance=80},
				{name="CrateNewspapers", min=0, max=1, weightChance=60},
				{name="CratePetSupplies", min=0, max=1, weightChance=10},
				{name="CratePhotos", min=0, max=1, weightChance=20},
				{name="CrateTailoring", min=0, max=1, weightChance=10},
				{name="CrateToys", min=0, max=1, weightChance=10},
				{name="CrateVHSTapes", min=0, max=1, weightChance=80},
				{name="EngineerTools", min=0, max=1, weightChance=5},
				{name="FitnessTrainer", min=0, max=1, weightChance=10},
				{name="Gifts", min=0, max=1, weightChance=10},
				{name="Hiker", min=0, max=1, weightChance=5},
				{name="Hobbies", min=0, max=1, weightChance=20},
				{name="HolidayStuff", min=0, max=1, weightChance=10},
				{name="Homesteading", min=0, max=1, weightChance=5},
				{name="Hunter", min=0, max=1, weightChance=5},
				{name="ImprovisedCrafts", min=0, max=1, weightChance=20},
				{name="JunkHoard", min=0, max=1, weightChance=20},
				{name="MechanicSpecial", min=0, max=1, weightChance=5},
				{name="Photographer", min=0, max=1, weightChance=10},
				{name="PlumbingSupplies", min=0, max=1, weightChance=5},
				{name="ScienceMisc", min=0, max=1, weightChance=5},
				{name="SurvivalGear", min=0, max=1, weightChance=5},
				{name="Trapper", min=0, max=1, weightChance=5},
				{name="VacationStuff", min=0, max=1, weightChance=20},
			}
		},
	},
	
	lobby = {
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="RandomFiller", min=0, max=99, weightChance=100},
			}
		}
	},
	
	loggingfactory = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateCarpentry", min=0, max=99, weightChance=100},
				{name="CrateHeavyChains", min=0, max=99, weightChance=60},
				{name="CrateTools", min=0, max=99, weightChance=40},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="CrateHeavyChains", min=0, max=99, weightChance=20},
				{name="LoggingFactoryTools", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateLongStick", min=0, max=99, weightChance=20},
				{name="CrateLumber", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateCarpentry", min=0, max=99, weightChance=100},
				{name="CrateHeavyChains", min=0, max=99, weightChance=60},
				{name="CrateTools", min=0, max=99, weightChance=40},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateCarpentry", min=0, max=99, weightChance=100},
				{name="CrateHeavyChains", min=0, max=99, weightChance=60},
				{name="CrateTools", min=0, max=99, weightChance=40},
			}
		},
	},
	
	loggingtruck = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateLongStick", min=0, max=99, weightChance=10},
				{name="CrateLumber", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateLongStick", min=0, max=99, weightChance=10},
				{name="CrateLumber", min=0, max=99, weightChance=100},
			}
		},
	},
	
	loggingwarehouse = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateCarpentry", min=0, max=99, weightChance=100},
				{name="CrateHeavyChains", min=0, max=99, weightChance=60},
				{name="CrateTools", min=0, max=99, weightChance=40},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="CrateHeavyChains", min=0, max=99, weightChance=20},
				{name="LoggingFactoryTools", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateCarpentry", min=0, max=99, weightChance=40},
				{name="CrateLongStick", min=0, max=99, weightChance=10},
				{name="CrateLumber", min=0, max=99, weightChance=100},
				{name="CrateTools", min=0, max=99, weightChance=20},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateCarpentry", min=0, max=99, weightChance=100},
				{name="CrateHeavyChains", min=0, max=99, weightChance=60},
				{name="CrateTools", min=0, max=99, weightChance=40},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateCarpentry", min=0, max=99, weightChance=100},
				{name="CrateHeavyChains", min=0, max=99, weightChance=60},
				{name="CrateTools", min=0, max=99, weightChance=40},
			}
		},
	},
	
	mannequinfactory = {
		counter = {
			rolls = 1,
			items = {
				
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="MannequinFactoryTools", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="MannequinFactoryTools", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="MannequinFactoryTools", min=0, max=4, weightChance=80},
				{name="CrateLumber", min=0, max=99, weightChance=100},
			}
		},
		overhead = {
			rolls = 1,
			items = {
				
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="MannequinFactoryTools", min=0, max=99},
			}
		},
	},
	
	mapfactory = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateMaps", min=0, max=99, weightChance=100},
				{name="CrateMapsLarge", min=0, max=4, weightChance=80},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateMaps", min=0, max=99, weightChance=100},
				{name="CrateMapsLarge", min=0, max=4, weightChance=80},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateMaps", min=0, max=99},
			}
		},
	},
	
	mayorwestpointoffice = {
		desk = {
			procedural = true,
			procList = {
				{name="MayorWestPointDesk", min=1, max=1},
			}
		},
		safe = {
			procedural = true,
			procList = {
				{name="MayorWestPointSafe", min=1, max=1},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="MayorWestPointBooks", min=0, max=99},
			}
		},
	},
	
	mechanic = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="MechanicSpecial", min=0, max=1, weightChance=5},
				{name="CarLightbars", min=0, max=1, weightChance=5},
				{name="CarTiresModern1", min=0, max=1, weightChance=10},
				{name="CarTiresModern2", min=0, max=1, weightChance=5},
				{name="CarTiresModern3", min=0, max=1, weightChance=1},
				{name="CarTiresNormal1", min=0, max=1, weightChance=20},
				{name="CarTiresNormal2", min=0, max=1, weightChance=10},
				{name="CarTiresNormal3", min=0, max=1, weightChance=5},
				{name="CarMufflerModern1", min=0, max=1, weightChance=10},
				{name="CarMufflerModern2", min=0, max=1, weightChance=5},
				{name="CarMufflerModern3", min=0, max=1, weightChance=1},
				{name="CarMufflerNormal1", min=0, max=1, weightChance=20},
				{name="CarMufflerNormal2", min=0, max=1, weightChance=10},
				{name="CarMufflerNormal3", min=0, max=1, weightChance=5},
				{name="CarBrakesModern1", min=0, max=1, weightChance=10},
				{name="CarBrakesModern2", min=0, max=1, weightChance=5},
				{name="CarBrakesModern3", min=0, max=1, weightChance=1},
				{name="CarBrakesNormal1", min=0, max=1, weightChance=20},
				{name="CarBrakesNormal2", min=0, max=1, weightChance=10},
				{name="CarBrakesNormal3", min=0, max=1, weightChance=5},
				{name="CarSuspensionModern1", min=0, max=1, weightChance=10},
				{name="CarSuspensionModern2", min=0, max=1, weightChance=5},
				{name="CarSuspensionModern3", min=0, max=1, weightChance=1},
				{name="CarSuspensionNormal1", min=0, max=1, weightChance=20},
				{name="CarSuspensionNormal2", min=0, max=1, weightChance=10},
				{name="CarSuspensionNormal3", min=0, max=1, weightChance=5},
				{name="CarWindows1", min=0, max=1, weightChance=20},
				{name="CarWindows2", min=0, max=1, weightChance=10},
				{name="CarWindows3", min=0, max=1, weightChance=5},
				{name="ToolCabinetMechanics", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="MechanicSpecial", min=0, max=1, weightChance=5},
				{name="CarLightbars", min=0, max=1, weightChance=5},
				{name="CarTiresModern1", min=0, max=1, weightChance=10},
				{name="CarTiresModern2", min=0, max=1, weightChance=5},
				{name="CarTiresModern3", min=0, max=1, weightChance=1},
				{name="CarTiresNormal1", min=0, max=1, weightChance=20},
				{name="CarTiresNormal2", min=0, max=1, weightChance=10},
				{name="CarTiresNormal3", min=0, max=1, weightChance=5},
				{name="CarMufflerModern1", min=0, max=1, weightChance=10},
				{name="CarMufflerModern2", min=0, max=1, weightChance=5},
				{name="CarMufflerModern3", min=0, max=1, weightChance=1},
				{name="CarMufflerNormal1", min=0, max=1, weightChance=20},
				{name="CarMufflerNormal2", min=0, max=1, weightChance=10},
				{name="CarMufflerNormal3", min=0, max=1, weightChance=5},
				{name="CarBrakesModern1", min=0, max=1, weightChance=10},
				{name="CarBrakesModern2", min=0, max=1, weightChance=5},
				{name="CarBrakesModern3", min=0, max=1, weightChance=1},
				{name="CarBrakesNormal1", min=0, max=1, weightChance=20},
				{name="CarBrakesNormal2", min=0, max=1, weightChance=10},
				{name="CarBrakesNormal3", min=0, max=1, weightChance=5},
				{name="CarSuspensionModern1", min=0, max=1, weightChance=10},
				{name="CarSuspensionModern2", min=0, max=1, weightChance=5},
				{name="CarSuspensionModern3", min=0, max=1, weightChance=1},
				{name="CarSuspensionNormal1", min=0, max=1, weightChance=20},
				{name="CarSuspensionNormal2", min=0, max=1, weightChance=10},
				{name="CarSuspensionNormal3", min=0, max=1, weightChance=5},
				{name="CarWindows1", min=0, max=1, weightChance=20},
				{name="CarWindows2", min=0, max=1, weightChance=10},
				{name="CarWindows3", min=0, max=1, weightChance=5},
				{name="CrateMechanics", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="MechanicSpecial", min=0, max=1, weightChance=5},
				{name="MechanicShelfTools", min=1, max=2, weightChance=10},
				{name="MechanicShelfOutfit", min=0, max=1, weightChance=10},
				{name="MechanicShelfBrakes", min=0, max=1, weightChance=20},
				{name="MechanicShelfSuspension", min=0, max=1, weightChance=20},
				{name="MechanicShelfElectric", min=0, max=1, weightChance=20},
				{name="MechanicShelfMufflers", min=0, max=1, weightChance=60},
				{name="MechanicShelfWheels", min=0, max=2, weightChance=80},
				{name="MechanicShelfBooks", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="MechanicSpecial", min=0, max=1, weightChance=20},
				{name="CrateMechanics", min=0, max=99, weightChance=100},
			}
		},
		wardrobe = {
			procedural = true,
			procList = {
				{name="MechanicSpecial", min=0, max=1, weightChance=5},
				{name="MechanicShelfMisc", min=0, max=1, weightChance=10},
				{name="MechanicShelfBooks", min=0, max=1, weightChance=20},
				{name="MechanicShelfOutfit", min=1, max=2, weightChance=100},
			}
		},
	},
	
	medical = {
		isShop = true,
		bin = {
			procedural = true,
			isTrash = true,
			procList = {
				{name="BinHospital", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="MedicalClinicDrugs", min=1, max=99, weightChance=100},
				{name="MedicalClinicTools", min=1, max=99, weightChance=100},
				{name="MedicalOfficeBooks", min=0, max=1, weightChance=20},
			}
		},
		dresser = {
			procedural = true,
			procList = {
				{name="MedicalClinicTools", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="MedicalStorageDrugs", min=1, max=99, weightChance=100},
				{name="MedicalStorageTools", min=1, max=99, weightChance=100},
				{name="MedicalStorageOutfit", min=0, max=99, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="MedicalOfficeBooks", min=0, max=99, weightChance=100},
			}
		},
		sidetable = {
			procedural = true,
			procList = {
				{name="MedicalStorageOutfit", min=0, max=99, weightChance=100},
			}
		},
		wardrobe = {
			procedural = true,
			procList = {
				{name="MedicalStorageOutfit", min=0, max=99, weightChance=100},
			}
		},
	},
	
	medicaloffice = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateWaterDispenserBottle", min=0, max=1, weightChance=5},
				{name="CrateOfficeSupplies", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateWaterDispenserBottle", min=0, max=1, weightChance=5},
				{name="CrateOfficeSupplies", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="MedicalOfficeCounter", min=0, max=99}
			}
		},
		desk = {
			procedural = true,
			procList = {
				{name="MedicalOfficeDesk", min=0, max=99},
			}
		},
		filingcabinet = {
			procedural = true,
			procList = {
				{name="FilingCabinetGeneric", min=0, max=99},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeOffice", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="OfficeShelfSupplies", min=0, max=99},
			}
		},
		overhead = {
			procedural = true,
			procList = {
				{name="MedicalOfficeCounter", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="MedicalOfficeBooks", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateOfficeSupplies", min=0, max=99},
			}
		},
	},
	
	medicalstorage = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="MedicalClinicDrugs", min=1, max=4, weightChance=100},
				{name="MedicalClinicTools", min=1, max=2, weightChance=100},
				{name="MedicalClinicOutfit", min=1, max=2, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="MedicalStorageDrugs", min=1, max=6, weightChance=100},
				{name="MedicalStorageTools", min=1, max=4, weightChance=100},
				{name="MedicalStorageOutfit", min=1, max=2, weightChance=100},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeMedical", min=0, max=12},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="MedicalOfficeBooks", min=0, max=99, weightChance=100},
			}
		},
	},
	
	metalshipping = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateSheetMetal", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateSheetMetal", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="MetalShopTools", min=0, max=99, weightChance=80},
				{name="CrateSheetMetal", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateSheetMetal", min=0, max=99},
			}
		},
	},
	
	metalshop = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="MetalShopTools", min=0, max=99, weightChance=80},
				{name="CrateSheetMetal", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			rolls = 1,
			items = {
				
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="MetalShopTools", min=0, max=99, weightChance=80},
				{name="CrateSheetMetal", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="MetalShopTools", min=0, max=99, weightChance=80},
				{name="CrateSheetMetal", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="MetalShopTools", min=0, max=99, weightChance=80},
				{name="CrateSheetMetal", min=0, max=99, weightChance=100},
			}
		},
	},
	
	mexicankitchen = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateCornflour", min=0, max=1, weightChance=80},
				{name="CrateFlour", min=0, max=1, weightChance=40},
				{name="CrateHotsauce", min=0, max=1, weightChance=100},
				{name="CrateOilVegetable", min=0, max=1, weightChance=60},
				{name="CrateTacoShells", min=0, max=2, weightChance=100},
				{name="CrateTortillaChips", min=0, max=2, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="MexicanKitchenBaking", min=1, max=1, weightChance=100},
				{name="MexicanKitchenButcher", min=1, max=1, weightChance=100},
				{name="MexicanKitchenSauce", min=0, max=1, weightChance=100},
				{name="StoreKitchenBags", min=0, max=1, weightChance=20},
				{name="StoreKitchenCups", min=0, max=1, weightChance=20},
				{name="StoreKitchenPots", min=0, max=99, weightChance=20},
				{name="StoreKitchenTrays", min=0, max=1, weightChance=20},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateCornflour", min=0, max=1, weightChance=80},
				{name="CrateFlour", min=0, max=1, weightChance=40},
				{name="CrateHotsauce", min=0, max=1, weightChance=100},
				{name="CrateOilVegetable", min=0, max=1, weightChance=60},
				{name="CrateTacoShells", min=0, max=2, weightChance=100},
				{name="CrateTortillaChips", min=0, max=2, weightChance=100},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="MexicanKitchenFreezer", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="MexicanKitchenFridge", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateFlour", min=0, max=1, weightChance=100},
				{name="CrateHotsauce", min=0, max=1, weightChance=100},
				{name="CrateOilVegetable", min=0, max=1, weightChance=100},
				{name="CrateTacoShells", min=0, max=2, weightChance=100},
				{name="CrateTortillaChips", min=0, max=2, weightChance=100},
			}
		},
		restaurantdisplay = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="ServingTrayTaco", min=1, max=4, weightChance=100},
				{name="ServingTrayBurritos", min=1, max=4, weightChance=100},
				{name="ServingTrayRefriedBeans", min=1, max=2, weightChance=20},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateCornflour", min=0, max=1, weightChance=80},
				{name="CrateFlour", min=0, max=1, weightChance=40},
				{name="CrateHotsauce", min=0, max=1, weightChance=100},
				{name="CrateOilVegetable", min=0, max=1, weightChance=60},
				{name="CrateTacoShells", min=0, max=2, weightChance=100},
				{name="CrateTortillaChips", min=0, max=2, weightChance=100},
			}
		},
	},
	
	motelroom = {
		bin = {
			isTrash = true,
			rolls = 1,
			items = {
				
			}
		},
		counter = {
			rolls = 1,
			items = {
				"HairDryer", 10,
			}
		},
		dresser = {
			procedural = true,
			procList = {
				{name="MotelSideTable", min=1, max=1, weightChance=100},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			rolls = 1,
			items = {
				
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="MotelTowels", min=0, max=1, weightChance=80},
				{name="Empty", min=0, max=99, weightChance=100},
			}
		},
		overhead = {
			procedural = true,
			procList = {
				{name="MotelTowels", min=0, max=1, weightChance=20},
				{name="Empty", min=0, max=99, weightChance=100},
			}
		},
		shelves = {
			rolls = 1,
			items = {
				
			}
		},
		sidetable = {
			procedural = true,
			procList = {
				{name="MotelSideTable", min=1, max=1, weightChance=100},
			}
		},
		stove = {
			rolls = 1,
			items = {
				
			}
		},
		wardrobe = {
			procedural = true,
			procList = {
				{name="MotelTowels", min=0, max=1, weightChance=20},
				{name="Empty", min=0, max=99, weightChance=100},
			}
		},
	},
	
	motelroomoccupied = {
		bin = {
			isTrash = true,
			procedural = true,
			procList = {
				{name="BinGeneric", min=0, max=99},
			}
		},
		counter = {
			rolls = 1,
			items = {
				"HairDryer", 10,
			}
		},
		dresser = {
			rolls = 1,
			items = {
				"Bag_DuffelBagTINT", 0.5,
				"Bag_Schoolbag", 0.5,
				"Bag_NormalHikingBag", 0.2,
				"Bag_BigHikingBag", 0.2,
			}
		},
		freezer = {
			rolls = 1,
			items = {
				"IcePick", 0.01,
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="MotelFridge", min=1, max=1},
			}
		},
		sidetable = {
			rolls = 1,
			items = {
				"Book_Bible", 200,
				"Comb", 2,
				"GenericMail", 1,
				"Headphones", 2,
				"LetterHandwritten", 1,
				"Magazine", 2,
				"Newspaper", 2,
				"Newspaper_Recent", 0.5,
				"Notebook", 2,
				"ComicBook", 2,
				"HottieZ", 0.1,
				"Paperback", 2,
				"Pencil", 2,
				"Pen", 2,
				"BluePen", 1,
				"RedPen", 1,
				"Phonebook", 200,
				"Pills", 1,
				"PillsBeta", 1,
				"PillsAntiDep", 1,
				"PillsVitamins", 1,
				"TVMagazine", 2,
			}
		},
		wardrobe = {
			procedural = true,
			procList = {
				{name="MotelLinens", min=1, max=1, weightChance=100},
				{name="MotelTowels", min=1, max=1, weightChance=100},
			}
		},
	},
	
	morgue = {
		counter = {
			procedural = true,
			procList = {
				{name="MorgueTools", min=0, max=99, weightChance=100},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			rolls = 1,
			items = {
				
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="MorgueChemicals", min=1, max=99, weightChance=100},
				{name="MorgueOutfit", min=1, max=99, weightChance=100},
			}
		},
	},
	
	movierental = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateVHSTapes", min=0, max=99},
			}
		},
		clothingrack = {
			procedural = true,
			procList = {
				{name="MovieRentalShelves", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreCounterBags", min=0, max=1, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateVHSTapes", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateVHSTapes", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="MovieRentalShelves", min=0, max=99},
				{name="StoreShelfCombo", min=0, max=99, forceForTiles="location_shop_generic_01_0;location_shop_generic_01_1"},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateVHSTapes", min=0, max=99},
			}
		},
	},
	
	musicstore = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="MusicStoreBass", min=0, max=1, weightChance=10},
				{name="MusicStoreBrass", min=0, max=1, weightChance=10},
				{name="MusicStoreGuitar", min=0, max=1, weightChance=10},
				{name="MusicStoreStringed", min=0, max=1, weightChance=10},
				{name="MusicStoreOthers", min=0, max=1, weightChance=10},
				{name="MusicStoreCases", min=0, max=1, weightChance=5},
				{name="ElectronicStoreCases", min=0, max=1, weightChance=5},
				{name="MusicStoreLiterature", min=0, max=99, weightChance=100},
				{name="MusicStoreCDs", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreCounterBags", min=0, max=1, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="MusicStoreBass", min=0, max=1, weightChance=10},
				{name="MusicStoreBrass", min=0, max=1, weightChance=10},
				{name="MusicStoreDrums", min=0, max=1, weightChance=10},
				{name="MusicStoreGuitar", min=0, max=1, weightChance=10},
				{name="MusicStoreSpeaker", min=0, max=1, weightChance=10},
				{name="MusicStoreStringed", min=0, max=1, weightChance=10},
				{name="MusicStoreOthers", min=0, max=1, weightChance=10},
				{name="MusicStoreCases", min=0, max=1, weightChance=5},
				{name="ElectronicStoreCases", min=0, max=1, weightChance=5},
				{name="MusicStoreLiterature", min=0, max=99, weightChance=100},
				{name="MusicStoreCDs", min=0, max=99, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="MusicStoreBass", min=1, max=1, weightChance=40},
				{name="MusicStoreBrass", min=1, max=1, weightChance=40},
				{name="MusicStoreCases", min=0, max=1, weightChance=100},
				{name="MusicStoreCDs", min=0, max=99, weightChance=10},
				{name="MusicStoreDrums", min=1, max=1, weightChance=40},
				{name="MusicStoreGuitar", min=1, max=1, weightChance=40},
				{name="MusicStoreLiterature", min=0, max=4, weightChance=20},
				{name="MusicStoreOthers", min=0, max=1, weightChance=40},
				{name="MusicStoreSpeaker", min=1, max=2, weightChance=40},
				{name="MusicStoreStringed", min=1, max=2, weightChance=40},
				{name="ElectronicStoreCases", min=1, max=1, weightChance=100},
				{name="StoreShelfCombo", min=0, max=99, forceForTiles="location_shop_generic_01_0;location_shop_generic_01_1"},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="MusicStoreOthers", min=0, max=1, weightChance=10},
				{name="MusicStoreLiterature", min=0, max=99, weightChance=100},
				{name="MusicStoreCDs", min=0, max=99, weightChance=100},
			}
		},
	},
	
	newspaperprint = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateNewspapersNew", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateNewspapersNew", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateNewspapersNew", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateNewspapersNew", min=0, max=99},
			}
		},
	},
	
	newspapershipping = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateNewspapersNew", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateNewspapersNew", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateNewspapersNew", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateNewspapersNew", min=0, max=99},
			}
		},
	},
	
	newspaperstorage = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateNewspapersNew", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateNewspapersNew", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateNewspapersNew", min=0, max=99},
			}
		},
	},
	
	nolansoffice = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateWaterDispenserBottle", min=0, max=1, weightChance=5},
				{name="CrateOfficeSupplies", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateWaterDispenserBottle", min=0, max=1, weightChance=5},
				{name="CrateOfficeSupplies", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="OfficeCounter", min=0, max=99},
			}
		},
		desk = {
			procedural = true,
			procList = {
				{name="NolansDesk", min=0, max=99},
			}
		},
		filingcabinet = {
			procedural = true,
			procList = {
				{name="NolansFilingCabinet", min=0, max=99},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="NolansFridge", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="OfficeShelfSupplies", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="ShelfGeneric", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateOfficeSupplies", min=0, max=99},
			}
		},
	},
	
	office = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateWaterDispenserBottle", min=0, max=1, weightChance=5},
				{name="CrateOfficeSupplies", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateWaterDispenserBottle", min=0, max=1, weightChance=5},
				{name="CrateOfficeSupplies", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="MedicalOfficeCounter", min=0, max=99, forceForRooms="hospitalroom"},
				{name="OfficeCounter", min=0, max=99},
			}
		},
		desk = {
			procedural = true,
			procList = {
				{name="MedicalOfficeDesk", min=0, max=99, forceForRooms="hospitalroom"},
				{name="OfficeDesk", min=0, max=99, weightChance=100},
				{name="OfficeDeskSecretary", min=0, max=1, weightChance=20},
				{name="OfficeDeskStressed", min=0, max=1, weightChance=10},
				{name="PoliceDesk", min=0, max=99, forceForRooms="policestorage"},
				{name="SpiffosDesk", min=0, max=99, forceForRooms="spiffoskitchen"},
			}
		},
		filingcabinet = {
			procedural = true,
			procList = {
				{name="FilingCabinetGeneric", min=0, max=99},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeOffice", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="OfficeShelfSupplies", min=0, max=99},
			}
		},
		militarycrate = {
			procedural = true,
			procList = {
				{name="ArmyStorageElectronics", min=0, max=99},
			}
		},
		overhead = {
			procedural = true,
			procList = {
				{name="BreakRoomCounter", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="MedicalOfficeBooks", min=0, max=99, forceForRooms="hospitalroom"},
				{name="ShelfGeneric", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateOfficeSupplies", min=0, max=99},
			}
		},
	},
	
	officechurch = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateWaterDispenserBottle", min=0, max=1, weightChance=5},
				{name="CrateOfficeSupplies", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateWaterDispenserBottle", min=0, max=1, weightChance=5},
				{name="CrateOfficeSupplies", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="OfficeCounter", min=0, max=99},
			}
		},
		desk = {
			procedural = true,
			procList = {
				{name="OfficeDesk", min=0, max=99},
			}
		},
		filingcabinet = {
			procedural = true,
			procList = {
				{name="FilingCabinetGeneric", min=0, max=99},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeOffice", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="OfficeShelfSupplies", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="ShelfGeneric", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateOfficeSupplies", min=0, max=99},
			}
		},
	},
	
	officestorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateWaterDispenserBottle", min=0, max=1, weightChance=5},
				{name="CrateOfficeSupplies", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateWaterDispenserBottle", min=0, max=1, weightChance=5},
				{name="CrateOfficeSupplies", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateOfficeSupplies", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateOfficeSupplies", min=0, max=99},
			}
		},
	},
	
	oldarmy = {
		bin = {
			rolls = 1,
			items = {
				
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="ArmyBunkerKitchen", min=0, max=99, weightChance=20},
				{name="Empty", min=0, max=99, weightChance=100},
			}
		},
		locker = {
			procedural = true,
			procList = {
				{name="ArmyBunkerLockers", min=0, max=99, weightChance=20},
				{name="Empty", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="ArmyBunkerStorage", min=0, max=99, weightChance=20},
				{name="Empty", min=0, max=99, weightChance=100},
			}
		},
	},
	
	oldmedical = {
		bin = {
			rolls = 1,
			items = {
				
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="ArmyBunkerMedical", min=0, max=99, weightChance=20},
				{name="Empty", min=0, max=99, weightChance=100},
			}
		},
		medicine = {
			rolls = 1,
			items = {
				
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="ArmyBunkerMedical", min=0, max=99, weightChance=20},
				{name="Empty", min=0, max=99, weightChance=100},
			}
		},
	},
	
	optometrist = {
		isShop = true,
		desk = {
			procedural = true,
			procList = {
				{name="OptometristDesk", min=0, max=99},
			}
		},
		dresser = {
			procedural = true,
			procList = {
				{name="OptometristGlasses", min=0, max=99},
			}
		},
	},
	
	paintershop = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CratePaint", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CratePaint", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CratePaint", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CratePaint", min=0, max=99},
			}
		},
	},
	
	pawnshop = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="ArmySurplusFootwear", min=0, max=1, weightChance=100},
				{name="ArmySurplusHeadwear", min=0, max=1, weightChance=100},
				{name="ArmySurplusOutfit", min=0, max=1, weightChance=100},
				{name="BookstoreBooks", min=0, max=99, weightChance=100},
				{name="CampingStoreGear", min=0, max=1, weightChance=100},
				{name="ClothingStorageAllJackets", min=0, max=1, weightChance=100},
				{name="ClothingStorageAllShirts", min=0, max=1, weightChance=100},
				{name="ClothingStorageLegwear", min=0, max=1, weightChance=100},
				{name="ClothingStorageWinter", min=0, max=1, weightChance=100},
				{name="ClothingStoresDress", min=0, max=1, weightChance=100},
				{name="ClothingStoresJacketsFormal", min=0, max=1, weightChance=100},
				{name="ClothingStoresPantsFormal", min=0, max=1, weightChance=100},
				{name="ClothingStoresShirtsFormal", min=0, max=1, weightChance=100},
				{name="CrateCompactDiscs", min=0, max=99, weightChance=100},
				{name="CrateElectronics", min=0, max=99, weightChance=100},
				{name="CrateSports", min=0, max=99, weightChance=100},
				{name="CrateVHSTapes", min=0, max=99, weightChance=100},
				{name="PawnShopTools", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="ArmyStorageElectronics", min=0, max=1, weightChance=20},
				{name="ArmyStorageOutfit", min=0, max=1, weightChance=40},
				{name="ArmySurplusBackpacks", min=0, max=1, weightChance=40},
				{name="ArmySurplusHeadwear", min=0, max=1, weightChance=40},
				{name="ArmySurplusTools", min=0, max=1, weightChance=20},
				{name="ElectronicStoreMusic", min=0, max=1, weightChance=40},
				{name="StoreCounterBags", min=0, max=1, weightChance=100},
				{name="PawnShopTools", min=0, max=99, weightChance=10},
			}
		},
		clothingrack = {
			procedural = true,
			procList = {
				{name="ArmySurplusOutfit", min=0, max=4, weightChance=100},
				{name="ClothingStorageAllJackets", min=0, max=99, weightChance=10},
				{name="ClothingStorageAllShirts", min=0, max=99, weightChance=10},
				{name="ClothingStorageLegwear", min=0, max=99, weightChance=10},
				{name="ClothingStoresDress", min=0, max=2, weightChance=40},
				{name="ClothingStoresJacketsFormal", min=0, max=2, weightChance=40},
				{name="ClothingStoresPantsFormal", min=0, max=2, weightChance=40},
				{name="ClothingStoresShirtsFormal", min=0, max=2, weightChance=40},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="ArmySurplusFootwear", min=0, max=1, weightChance=100},
				{name="ArmySurplusHeadwear", min=0, max=1, weightChance=100},
				{name="ArmySurplusOutfit", min=0, max=1, weightChance=100},
				{name="BookstoreBooks", min=0, max=99, weightChance=100},
				{name="CampingStoreGear", min=0, max=1, weightChance=100},
				{name="ClothingStorageAllJackets", min=0, max=1, weightChance=100},
				{name="ClothingStorageAllShirts", min=0, max=1, weightChance=100},
				{name="ClothingStorageLegwear", min=0, max=1, weightChance=100},
				{name="ClothingStorageWinter", min=0, max=1, weightChance=100},
				{name="ClothingStoresDress", min=0, max=1, weightChance=100},
				{name="ClothingStoresJacketsFormal", min=0, max=1, weightChance=100},
				{name="ClothingStoresPantsFormal", min=0, max=1, weightChance=100},
				{name="ClothingStoresShirtsFormal", min=0, max=1, weightChance=100},
				{name="CrateCompactDiscs", min=0, max=99, weightChance=100},
				{name="CrateElectronics", min=0, max=99, weightChance=100},
				{name="CrateSports", min=0, max=99, weightChance=100},
				{name="CrateVHSTapes", min=0, max=99, weightChance=100},
				{name="PawnShopTools", min=0, max=99, weightChance=100},
			}
		},
		displaycase = {
			procedural = true,
			procList = {
				{name="Antiques", min=1, max=2, weightChance=100},
				{name="DepartmentStoreWatches", min=0, max=2, weightChance=100},
				{name="JewelryGold", min=0, max=1, weightChance=80},
				{name="JewelrySilver", min=0, max=1, weightChance=80},
				{name="JewelryWeddingRings", min=0, max=1, weightChance=80},
				{name="OptometristGlasses", min=0, max=1, weightChance=80},
				{name="PawnShopGuns", min=1, max=99, weightChance=10},
				{name="PawnShopKnives", min=1, max=99, weightChance=10},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="ArmyStorageElectronics", min=0, max=1, weightChance=20},
				{name="ArmySurplusHeadwear", min=0, max=1, weightChance=20},
				{name="ArmyStorageOutfit", min=0, max=1, weightChance=10},
				{name="ArmySurplusBackpacks", min=0, max=1, weightChance=80},
				{name="ArmySurplusFootwear", min=0, max=1, weightChance=80},
				{name="ArmySurplusOutfit", min=0, max=1, weightChance=20},
				{name="CampingStoreGear", min=0, max=1, weightChance=20},
				{name="ClothingStorageWinter", min=0, max=1, weightChance=40},
				{name="PawnShopCases", min=0, max=1, weightChance=40},
				{name="PawnShopTools", min=0, max=99, weightChance=10},
				{name="ClothingStorageAllJackets", min=0, max=99, weightChance=10},
				{name="ClothingStorageAllShirts", min=0, max=99, weightChance=10},
				{name="ClothingStorageLegwear", min=0, max=99, weightChance=10},
				{name="CrateSports", min=0, max=99, weightChance=20},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="ArmyStorageElectronics", min=0, max=1, weightChance=20},
				{name="ArmySurplusHeadwear", min=0, max=1, weightChance=20},
				{name="ArmyStorageOutfit", min=0, max=1, weightChance=20},
				{name="ArmySurplusBackpacks", min=0, max=1, weightChance=80},
				{name="ArmySurplusFootwear", min=0, max=1, weightChance=80},
				{name="ArmySurplusOutfit", min=0, max=1, weightChance=80},
				{name="BookstoreBooks", min=0, max=99, forceForTiles="furniture_shelving_01_40;furniture_shelving_01_41;furniture_shelving_01_42;furniture_shelving_01_43"},
				{name="CampingStoreGear", min=0, max=1, weightChance=20},
				{name="ClothingStorageWinter", min=0, max=1, weightChance=40},
				{name="CrateSports", min=0, max=99, weightChance=20},
				{name="ElectronicStoreMisc", min=0, max=99, weightChance=10},
				{name="MovieRentalShelves", min=0, max=99, forceForTiles="location_entertainment_theatre_01_120;location_entertainment_theatre_01_121;location_entertainment_theatre_01_122;location_entertainment_theatre_01_123;location_entertainment_theatre_01_124;location_entertainment_theatre_01_125;location_entertainment_theatre_01_126;location_entertainment_theatre_01_127;location_entertainment_theatre_01_128;location_entertainment_theatre_01_129;location_entertainment_theatre_01_130;location_entertainment_theatre_01_131;location_entertainment_theatre_01_132;location_entertainment_theatre_01_133;location_entertainment_theatre_01_134;location_entertainment_theatre_01_135"},
				{name="MusicStoreBass", min=0, max=1, weightChance=40},
				{name="MusicStoreCDs", min=0, max=99, weightChance=10},
				{name="MusicStoreGuitar", min=0, max=1, weightChance=40},
				{name="MusicStoreOthers", min=0, max=1, weightChance=40},
				{name="PawnShopCases", min=0, max=1, weightChance=40},
				{name="StoreShelfCombo", min=0, max=99, forceForTiles="location_shop_generic_01_0;location_shop_generic_01_1"},
				{name="PawnShopTools", min=0, max=99, weightChance=10},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="ArmySurplusFootwear", min=0, max=1, weightChance=100},
				{name="ArmySurplusHeadwear", min=0, max=1, weightChance=100},
				{name="ArmySurplusOutfit", min=0, max=1, weightChance=100},
				{name="BookstoreBooks", min=0, max=99, weightChance=100},
				{name="CampingStoreGear", min=0, max=1, weightChance=100},
				{name="ClothingStorageAllJackets", min=0, max=1, weightChance=100},
				{name="ClothingStorageAllShirts", min=0, max=1, weightChance=100},
				{name="ClothingStorageLegwear", min=0, max=1, weightChance=100},
				{name="ClothingStorageWinter", min=0, max=1, weightChance=100},
				{name="ClothingStoresDress", min=0, max=1, weightChance=100},
				{name="ClothingStoresJacketsFormal", min=0, max=1, weightChance=100},
				{name="ClothingStoresPantsFormal", min=0, max=1, weightChance=100},
				{name="ClothingStoresShirtsFormal", min=0, max=1, weightChance=100},
				{name="CrateCompactDiscs", min=0, max=99, weightChance=100},
				{name="CrateElectronics", min=0, max=99, weightChance=100},
				{name="CrateSports", min=0, max=99, weightChance=100},
				{name="CrateVHSTapes", min=0, max=99, weightChance=100},
				{name="PawnShopTools", min=0, max=99, weightChance=100},
			}
		},
	},
	
	pawnshopcooking = {
		all = {
			rolls = 1,
			items = {
				
			}
		},
	},
	
	pawnshopoffice = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="ArmyStorageElectronics", min=0, max=1, weightChance=100},
				{name="ArmyStorageOutfit", min=0, max=1, weightChance=100},
				{name="ArmySurplusTools", min=0, max=1, weightChance=100},
				{name="CrateCompactDiscs", min=0, max=99, weightChance=100},
				{name="CrateElectronics", min=0, max=99, weightChance=100},
				{name="CrateVHSTapes", min=0, max=99, weightChance=100},
				{name="GunStoreAmmunition", min=0, max=99, weightChance=100},
				{name="GunStoreGuns", min=0, max=99, weightChance=100},
				{name="JewelryStorageAll", min=0, max=99, weightChance=100},
				{name="PoliceStorageOutfit", min=0, max=1, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="ArmyStorageElectronics", min=0, max=1, weightChance=100},
				{name="ArmyStorageOutfit", min=0, max=1, weightChance=100},
				{name="ArmySurplusTools", min=0, max=1, weightChance=100},
				{name="CrateCompactDiscs", min=0, max=99, weightChance=100},
				{name="CrateElectronics", min=0, max=99, weightChance=100},
				{name="CrateVHSTapes", min=0, max=99, weightChance=100},
				{name="GunStoreAmmunition", min=0, max=99, weightChance=100},
				{name="GunStoreGuns", min=0, max=99, weightChance=100},
				{name="JewelryStorageAll", min=0, max=99, weightChance=100},
				{name="PoliceStorageOutfit", min=0, max=1, weightChance=100},
			}
		},
		locker = {
			procedural = true,
			procList = {
				{name="ArmyStorageOutfit", min=0, max=99, weightChance=100},
				{name="PawnShopGunsSpecial", min=0, max=99, forceForTiles="furniture_storage_02_8;furniture_storage_02_9;furniture_storage_02_10;furniture_storage_02_11"},
				{name="PoliceStorageOutfit", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="ArmyStorageElectronics", min=0, max=1, weightChance=100},
				{name="ArmyStorageOutfit", min=0, max=99, weightChance=100},
				{name="ArmySurplusTools", min=0, max=1, weightChance=100},
				{name="GunStoreAmmunition", min=0, max=99, weightChance=100},
				{name="GunStoreGuns", min=0, max=99, weightChance=100},
				{name="PoliceStorageOutfit", min=0, max=1, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="BookstoreBooks", min=0, max=99, forceForTiles="furniture_shelving_01_40;furniture_shelving_01_41;furniture_shelving_01_42;furniture_shelving_01_43"},
				{name="GunStoreAmmunition", min=0, max=99, weightChance=100},
				{name="GunStoreGuns", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="ArmyStorageElectronics", min=0, max=1, weightChance=100},
				{name="ArmyStorageOutfit", min=0, max=1, weightChance=100},
				{name="ArmySurplusTools", min=0, max=1, weightChance=100},
				{name="CrateCompactDiscs", min=0, max=99, weightChance=100},
				{name="CrateElectronics", min=0, max=99, weightChance=100},
				{name="CrateVHSTapes", min=0, max=99, weightChance=100},
				{name="GunStoreAmmunition", min=0, max=99, weightChance=100},
				{name="GunStoreGuns", min=0, max=99, weightChance=100},
				{name="JewelryStorageAll", min=0, max=99, weightChance=100},
				{name="PoliceStorageOutfit", min=0, max=1, weightChance=100},
			}
		},
	},
	
	pawnshopstorage = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="ArmyStorageElectronics", min=0, max=1, weightChance=100},
				{name="ArmyStorageOutfit", min=0, max=1, weightChance=100},
				{name="ArmySurplusTools", min=0, max=1, weightChance=100},
				{name="CrateElectronics", min=0, max=99, weightChance=100},
				{name="CrateInstruments", min=0, max=99, weightChance=100},
				{name="CrateVHSTapes", min=0, max=99, weightChance=100},
				{name="GunStoreAmmunition", min=0, max=99, weightChance=100},
				{name="PawnShopTools", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="ArmyStorageElectronics", min=0, max=1, weightChance=100},
				{name="ArmyStorageOutfit", min=0, max=1, weightChance=100},
				{name="ArmySurplusTools", min=0, max=1, weightChance=100},
				{name="CrateElectronics", min=0, max=99, weightChance=100},
				{name="CrateInstruments", min=0, max=99, weightChance=100},
				{name="CrateVHSTapes", min=0, max=99, weightChance=100},
				{name="GunStoreAmmunition", min=0, max=99, weightChance=100},
				{name="PawnShopTools", min=0, max=99, weightChance=100},
			}
		},
		locker = {
			procedural = true,
			procList = {
				{name="ArmyStorageOutfit", min=0, max=99, weightChance=100},
				{name="PawnShopGunsSpecial", min=0, max=99, forceForTiles="furniture_storage_02_8;furniture_storage_02_9;furniture_storage_02_10;furniture_storage_02_11"},
				{name="PoliceStorageOutfit", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="ArmyStorageElectronics", min=0, max=1, weightChance=100},
				{name="ArmyStorageOutfit", min=0, max=1, weightChance=100},
				{name="ArmySurplusTools", min=0, max=1, weightChance=100},
				{name="CrateElectronics", min=0, max=99, weightChance=100},
				{name="CrateInstruments", min=0, max=99, weightChance=100},
				{name="CrateVHSTapes", min=0, max=99, weightChance=100},
				{name="GunStoreAmmunition", min=0, max=99, weightChance=100},
				{name="PawnShopTools", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="ArmyStorageElectronics", min=0, max=1, weightChance=100},
				{name="ArmyStorageOutfit", min=0, max=1, weightChance=100},
				{name="ArmySurplusTools", min=0, max=1, weightChance=100},
				{name="CrateElectronics", min=0, max=99, weightChance=100},
				{name="CrateInstruments", min=0, max=99, weightChance=100},
				{name="CrateVHSTapes", min=0, max=99, weightChance=100},
				{name="GunStoreAmmunition", min=0, max=99, weightChance=100},
				{name="PawnShopTools", min=0, max=99, weightChance=100},
			}
		},
	},
	
	pharmacy = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="MedicalClinicDrugs", min=0, max=99, weightChance=100},
				{name="StoreCounterBags", min=0, max=1, weightChance=10},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeSnacks", min=0, max=2, weightChance=20},
				{name="FridgeSoda", min=0, max=6, weightChance=80},
				{name="FridgeWater", min=0, max=4, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="MedicalStorageDrugs", min=1, max=6, weightChance=100},
				{name="MedicalStorageTools", min=1, max=4, weightChance=100},
				{name="MedicalStorageOutfit", min=1, max=2, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="GigamartCleaning", min=1, max=4, weightChance=40},
				{name="GigamartPaper", min=1, max=4, weightChance=40},
				{name="PharmacyCosmetics", min=1, max=4, weightChance=60},
				{name="StoreShelfCombo", min=0, max=99, forceForTiles="location_shop_generic_01_0;location_shop_generic_01_1"},
				{name="StoreShelfDrinks", min=1, max=4, weightChance=40},
				{name="StoreShelfSnacks", min=1, max=4, weightChance=40},
				{name="StoreShelfMedical", min=4, max=24, weightChance=100},
			}
		},
		shelvesmag = {
			procedural = true,
			procList = {
				{name="MagazineRackCards", min=1, max=99, weightChance=100},
				{name="MagazineRackMixed", min=1, max=4, weightChance=40},
				{name="MagazineRackNewspaper", min=1, max=4, weightChance=40},
				{name="MagazineRackPaperback", min=1, max=2, weightChance=40},
			}
		},
	},
	
	pharmacystorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="MedicalClinicDrugs", min=0, max=99, weightChance=100},
				{name="MedicalClinicTools", min=0, max=99, weightChance=80},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="MedicalClinicDrugs", min=0, max=99, weightChance=100},
				{name="MedicalClinicTools", min=0, max=99, weightChance=80},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="MedicalClinicDrugs", min=0, max=99, weightChance=100},
				{name="MedicalClinicTools", min=0, max=99, weightChance=80},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			},
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeMedical", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="MedicalClinicDrugs", min=0, max=99, weightChance=100},
				{name="MedicalClinicTools", min=0, max=99, weightChance=80},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="MedicalClinicDrugs", min=0, max=99, weightChance=100},
				{name="MedicalClinicTools", min=0, max=99, weightChance=80},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="MedicalClinicDrugs", min=0, max=99, weightChance=100},
				{name="MedicalClinicTools", min=0, max=99, weightChance=80},
			}
		},
	},
	
	photoroom = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="CrateCameraFilm", min=0, max=99, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="CrateCameraFilm", min=0, max=99, weightChance=100},
			}
		},
	},
	
	picnic = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateEmptyBottles1", min=0, max=1, weightChance=60},
				{name="CrateEmptyBottles2", min=0, max=1, weightChance=60},
				{name="CrateEmptyMixed", min=0, max=1, weightChance=60},
				{name="CrateEmptyTinCans", min=0, max=1, weightChance=60},
				{name="CrateNewspapers", min=0, max=1, weightChance=20},
				{name="CrateToolsOld", min=0, max=1, weightChance=10},
				{name="Empty", min=0, max=1, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateToolsOld", min=0, max=1, weightChance=20},
				{name="Empty", min=0, max=1, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateEmptyBottles1", min=0, max=1, weightChance=60},
				{name="CrateEmptyBottles2", min=0, max=1, weightChance=60},
				{name="CrateEmptyMixed", min=0, max=1, weightChance=60},
				{name="CrateEmptyTinCans", min=0, max=1, weightChance=60},
				{name="CrateNewspapers", min=0, max=1, weightChance=20},
				{name="Empty", min=0, max=1, weightChance=100},
			}
		},
	},
	
	pileocrepe = {
		isShop = true,
		bin = {
			isTrash = true,
			procedural = true,
			procList = {
				{name="BinCrepe", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
			}
		},
		restaurantdisplay = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="ServingTrayOmelettes", min=1, max=99, weightChance=60},
				{name="ServingTrayPancakes", min=1, max=99, weightChance=100},
				{name="ServingTrayPotatoPancakes", min=1, max=99, weightChance=100},
				{name="ServingTrayScrambledEggs", min=1, max=99, weightChance=60},
				{name="ServingTrayWaffles", min=1, max=99, weightChance=100},
			}
		},
	},
	
	pizzakitchen = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateFlour", min=0, max=1, weightChance=100},
				{name="CrateOilOlive", min=0, max=1, weightChance=100},
				{name="CrateTomatoPaste", min=0, max=2, weightChance=100},
				{name="CrateYeast", min=0, max=1, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="PizzaKitchenBaking", min=1, max=1, weightChance=100},
				{name="PizzaKitchenButcher", min=1, max=1, weightChance=100},
				{name="PizzaKitchenCheese", min=1, max=1, weightChance=100},
				{name="PizzaKitchenSauce", min=1, max=1, weightChance=100},
				{name="StoreKitchenBags", min=0, max=1, weightChance=20},
				{name="StoreKitchenCups", min=0, max=1, weightChance=20},
				{name="StoreKitchenTrays", min=0, max=1, weightChance=20},
				{name="StoreKitchenPots", min=0, max=1, weightChance=20},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateFlour", min=0, max=1, weightChance=100},
				{name="CrateOilOlive", min=0, max=1, weightChance=100},
				{name="CrateTomatoPaste", min=0, max=2, weightChance=100},
				{name="CrateYeast", min=0, max=1, weightChance=100},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="PizzaKitchenFridge", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateFlour", min=0, max=1, weightChance=100},
				{name="CrateTomatoPaste", min=0, max=2, weightChance=100},
				{name="CrateOilOlive", min=0, max=1, weightChance=100},
				{name="CrateYeast", min=0, max=1, weightChance=100},
			}
		},
		restaurantdisplay = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="ServingTrayPizza", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateFlour", min=0, max=1, weightChance=100},
				{name="CrateOilOlive", min=0, max=1, weightChance=100},
				{name="CrateTomatoPaste", min=0, max=2, weightChance=100},
				{name="CrateYeast", min=0, max=1, weightChance=100},
			}
		},
		stove = {
			rolls = 4,
			items = {
				"PizzaWhole", 0.1,
			},
			junk = {
				rolls = 1,
				items = {
					
				}
			}
		},
		wardrobe = {
			procedural = true,
			procList = {
				{name="CrateFlour", min=0, max=1, weightChance=100},
				{name="CrateTomatoPaste", min=0, max=2, weightChance=100},
				{name="CrateOilOlive", min=0, max=1, weightChance=100},
				{name="CrateYeast", min=0, max=1, weightChance=100},
			}
		},
	},
	
	pizzawhirled = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
			}
		},
		restaurantdisplay = {
			procedural = true,
			procList = {
				{name="ServingTrayPizza", min=0, max=99},
			}
		},
		wardrobe = {
			rolls = 1,
			items = {
				
			},
		},
	},
	
	pizzawhirledcounter = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeSoda", min=1, max=99, weightChance=100},
			}
		},
		restaurantdisplay = {
			procedural = true,
			procList = {
				{name="ServingTrayPizza", min=0, max=99},
			}
		},
	},
	
	plazastore1 = {
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreCounterBags", min=0, max=1, weightChance=100},
				{name="RandomFiller", min=0, max=99, weightChance=20},
			}
		}
	},
	
	policearchive = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="PoliceFileBox", min=0, max=99},
			}
		},
		filingcabinet = {
			procedural = true,
			procList = {
				{name="PoliceFilingCabinet", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="PoliceFileBox", min=0, max=99},
			}
		},
	},
	
	policegarage = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="PoliceStorageMechanics", min=0, max=99},
			},
		},
		crate = {
			procedural = true,
			procList = {
				{name="PoliceStorageMechanics", min=0, max=99},
			},
		},
		counter = {
			procedural = true,
			procList = {
				{name="PoliceStorageMechanics", min=0, max=99},
			},
		},
		locker = {
			procedural = true,
			procList = {
				{name="PoliceStorageOutfit", min=0, max=99},
			},
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="PoliceStorageMechanics", min=0, max=99},
			},
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="PoliceStorageMechanics", min=0, max=99},
			},
		},
		toolcabinet = {
			procedural = true,
			procList = {
				{name="PoliceStorageMechanics", min=0, max=99},
			}
		},
	},
	
	policelocker = {
		locker = {
			procedural = true,
			procList = {
				{name="PoliceLockers", min=0, max=99},
			},
		},
		counter = {
			procedural = true,
			procList = {
				{name="ChangeroomCounters", min=0, max=99},
			},
		},
		clothingdryerbasic = {
			procedural = true,
			procList = {
				{name="GymTowels", min=0, max=99, weightChance=100},
			}
		},
	},
	
	policeoffice = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="PoliceFileBox", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="OfficeCounter", min=0, max=99},
			}
		},
		desk = {
			procedural = true,
			procList = {
				{name="PoliceDesk", min=0, max=99},
			}
		},
		filingcabinet = {
			procedural = true,
			procList = {
				{name="PoliceFilingCabinet", min=0, max=99},
			}
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeOffice", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="OfficeShelfSupplies", min=0, max=99},
			}
		},
	},
	
	policegunstorage = { -- note: it is significantly harder for players to get into these rooms in b42 versus previous builds are the doors are much stronger and cannot be dismantled
		filingcabinet = {
			procedural = true,
			procList = {
				{name="PoliceEvidence", min=0, max=99},  -- these need to have something worthwhile or interesting spawning in them; these containers exist in the roomdef on the map
		    },
			dontSpawnAmmo = true,
		},
		locker = {
			procedural = true,
			procList = {
				{name="PoliceStorageGuns", min=0, max=99, forceForTiles="furniture_storage_02_8;furniture_storage_02_9;furniture_storage_02_10;furniture_storage_02_11"},
				{name="PoliceStorageOutfit", min=0, max=99, forceForTiles="furniture_storage_02_4;furniture_storage_02_5;furniture_storage_02_6;furniture_storage_02_7"},
			},
			dontSpawnAmmo = true,
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="PoliceStorageGuns", min=0, max=99, weightChance=100}, -- these need to have something worthwhile or interesting spawning in them; these containers exist in the roomdef on the map
			}
		},
		militarylocker = {
			procedural = true,
			procList = {
				{name="PoliceStorageGuns", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="PoliceEvidence", min=0, max=99}, -- these need to have something worthwhile or interesting spawning in them; these containers exist in the roomdef on the map
		    },
			dontSpawnAmmo = true,
		},
	},
	
	policestorage = {
		-- DEPRECATED
	},
	
	pool = {
		locker = {
			procedural = true,
			procList = {
				{name="PoolLockers", min=0, max=99, weightChance=100},
			}
		},
	},
	
	post = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="PostOfficeBooks", min=0, max=99, weightChance=100},
				{name="PostOfficeMagazines", min=0, max=99, weightChance=100},
				{name="PostOfficeNewspapers", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="PostOfficeParcels", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="PostOfficeSupplies", min=1, max=99, weightChance=100},
				{name="PostOfficeBoxes", min=1, max=4, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="PostOfficeSupplies", min=1, max=99, weightChance=100},
				{name="PostOfficeBoxes", min=1, max=4, weightChance=100},
			}
		},
	},
	
	poststorage = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="PostOfficeBooks", min=0, max=99, weightChance=100},
				{name="PostOfficeMagazines", min=0, max=99, weightChance=100},
				{name="PostOfficeNewspapers", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="PostOfficeParcels", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="PostOfficeParcels", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="PostOfficeSupplies", min=1, max=99, weightChance=100},
				{name="PostOfficeBoxes", min=1, max=4, weightChance=100},
			}
		},
	},
	
	potatostorage = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="FryFactoryPotatoes", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="FryFactoryPotatoes", min=0, max=99, weightChance=100},
			}
		},
		clothingdryerbasic = {
			procedural = true,
			procList = {
				{name="FryFactoryPotatoes", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="FryFactoryPotatoes", min=0, max=99, weightChance=100},
			}
		},
	},
	
	prisoncells = {
		sidetable = {
			procedural = true,
			procList = {
				{name="PrisonCellRandom", min=0, max=99, weightChance=100},
				{name="PrisonCellRandomClassy", min=0, max=99, forceForTiles="appliances_television_01_8;appliances_television_01_9;appliances_television_01_10;appliances_television_01_11"},
			}
		}
	},

	prisonstorage = { -- this needs to have worthwhile and interesting stuff in all of the containers, especially it is significantly harder for players to get into these rooms in b42 versus previous builds are the doors are much stronger and cannot be dismantled
		locker = {
			procedural = true,
			procList = {
				{name="PrisonArmoryShotguns", min=0, max=99, forceForTiles="furniture_storage_02_8;furniture_storage_02_9;furniture_storage_02_10;furniture_storage_02_11"},
				{name="PrisonRiotStorage", min=0, max=99, forceForTiles="furniture_storage_02_4;furniture_storage_02_5;furniture_storage_02_6;furniture_storage_02_7"},
			},
			dontSpawnAmmo = true,
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="PrisonStorageArmor", min=1, max=99, weightChance=100},
				{name="CrateBootsArmy", min=1, max=4, weightChance=60},
			}
		},
		militarylocker = {
			procedural = true,
			procList = {
				{name="PrisonArmoryShotguns", min=0, max=99},
			}
		},
	},
	
	producestorage = {
		cardboardbox = {
			procedural = true,
			procList = {
				-- Packed Produce
				{name="ProduceStorageApples", min=0, max=1, weightChance=5},
				{name="ProduceStorageBellPeppers", min=0, max=1, weightChance=5},
				{name="ProduceStorageBroccoli", min=0, max=1, weightChance=5},
				{name="ProduceStorageCabbages", min=0, max=1, weightChance=5},
				{name="ProduceStorageCarrots", min=0, max=1, weightChance=5},
				{name="ProduceStorageCherry", min=0, max=1, weightChance=5},
				{name="ProduceStorageCorn", min=0, max=1, weightChance=5},
				{name="ProduceStorageEggplant", min=0, max=1, weightChance=5},
				{name="ProduceStorageGrapes", min=0, max=1, weightChance=5},
				{name="ProduceStorageLeeks", min=0, max=1, weightChance=5},
				{name="ProduceStorageLettuce", min=0, max=1, weightChance=5},
				{name="ProduceStorageOnions", min=0, max=1, weightChance=5},
				{name="ProduceStoragePeaches", min=0, max=1, weightChance=5},
				{name="ProduceStoragePears", min=0, max=1, weightChance=5},
				{name="ProduceStoragePotatoes", min=0, max=1, weightChance=5},
				{name="ProduceStorageRadishes", min=0, max=1, weightChance=5},
				{name="ProduceStorageStrawberries", min=0, max=1, weightChance=5},
				{name="ProduceStorageTomatoes", min=0, max=1, weightChance=5},
				{name="ProduceStorageWatermelons", min=0, max=1, weightChance=5},
				-- Loose Produce: Stale
				{name="ProduceStorageRottenFruit", min=0, max=4, weightChance=20},
				{name="ProduceStorageRottenVeg", min=0, max=4, weightChance=20},
				-- Loose Produce: Rotten
				{name="ProduceStorageRottenFruit", min=0, max=4, weightChance=40},
				{name="ProduceStorageRottenVeg", min=0, max=4, weightChance=40},
				-- Empty Boxes
				{name="ProduceStorageEmptyBoxes", min=0, max=8, weightChance=60},
				-- Empty
				{name="Empty", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="ProduceStorageEquipment", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				-- Packed Produce
				{name="ProduceStorageApples", min=0, max=1, weightChance=5},
				{name="ProduceStorageBellPeppers", min=0, max=1, weightChance=5},
				{name="ProduceStorageBroccoli", min=0, max=1, weightChance=5},
				{name="ProduceStorageCabbages", min=0, max=1, weightChance=5},
				{name="ProduceStorageCarrots", min=0, max=1, weightChance=5},
				{name="ProduceStorageCherry", min=0, max=1, weightChance=5},
				{name="ProduceStorageCorn", min=0, max=1, weightChance=5},
				{name="ProduceStorageEggplant", min=0, max=1, weightChance=5},
				{name="ProduceStorageGrapes", min=0, max=1, weightChance=5},
				{name="ProduceStorageLeeks", min=0, max=1, weightChance=5},
				{name="ProduceStorageLettuce", min=0, max=1, weightChance=5},
				{name="ProduceStorageOnions", min=0, max=1, weightChance=5},
				{name="ProduceStoragePeaches", min=0, max=1, weightChance=5},
				{name="ProduceStoragePears", min=0, max=1, weightChance=5},
				{name="ProduceStoragePotatoes", min=0, max=1, weightChance=5},
				{name="ProduceStorageRadishes", min=0, max=1, weightChance=5},
				{name="ProduceStorageStrawberries", min=0, max=1, weightChance=5},
				{name="ProduceStorageTomatoes", min=0, max=1, weightChance=5},
				{name="ProduceStorageWatermelons", min=0, max=1, weightChance=5},
				-- Loose Produce: Stale
				{name="ProduceStorageRottenFruit", min=0, max=4, weightChance=20},
				{name="ProduceStorageRottenVeg", min=0, max=4, weightChance=20},
				-- Loose Produce: Rotten
				{name="ProduceStorageRottenFruit", min=0, max=4, weightChance=40},
				{name="ProduceStorageRottenVeg", min=0, max=4, weightChance=40},
				-- Empty Boxes
				{name="ProduceStorageEmptyBoxes", min=0, max=8, weightChance=60},
				-- Empty
				{name="Empty", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="ProduceStorageEmptyBoxes", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="ProduceStorageEquipment", min=0, max=99, weightChance=100},
			}
		},
	},
	
	radiofactory = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="RadioFactoryComponents", min=0, max=99},
			},
		},
		counter = {
			rolls = 1,
			items = {
				
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="RadioFactoryComponents", min=0, max=99},
			},
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="RadioFactoryComponents", min=0, max=99},
			},
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="RadioFactoryComponents", min=0, max=99},
			},
		},
	},
	
	radioshipping = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="RadioFactoryComponents", min=0, max=99},
			},
		},
		crate = {
			procedural = true,
			procList = {
				{name="RadioFactoryComponents", min=0, max=99},
			},
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="RadioFactoryComponents", min=0, max=99},
			},
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="RadioFactoryComponents", min=0, max=99},
			},
		},
	},
	
	radiostorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="RadioFactoryComponents", min=0, max=99},
			},
		},
		crate = {
			procedural = true,
			procList = {
				{name="RadioFactoryComponents", min=0, max=99},
			},
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="RadioFactoryComponents", min=0, max=99},
			},
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="RadioFactoryComponents", min=0, max=99},
			},
		},
	},
	
	railroadrepair = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="RailYardSpikes", min=0, max=99, weightChance=100},
				{name="RailYardTools", min=0, max=99, weightChance=40},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="RailYardTools", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="RailYardSpikes", min=0, max=99, weightChance=40},
				{name="RailYardTools", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="RailYardSpikes", min=0, max=99, weightChance=20},
				{name="RailYardTools", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="RailYardSpikes", min=0, max=99, weightChance=100},
				{name="RailYardTools", min=0, max=99, weightChance=20},
			}
		},
	},
	
	railroadstorage = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="RailYardSpikes", min=0, max=99, weightChance=100},
				{name="RailYardTools", min=0, max=99, weightChance=40},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="RailYardSpikes", min=0, max=99, weightChance=40},
				{name="RailYardTools", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="RailYardSpikes", min=0, max=99, weightChance=20},
				{name="RailYardTools", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="RailYardSpikes", min=0, max=99, weightChance=100},
				{name="RailYardTools", min=0, max=99, weightChance=20},
			}
		},
	},
	
	recreation = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateOfficeSupplies", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateOfficeSupplies", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateOfficeSupplies", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="RecRoomShelf", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateOfficeSupplies", min=0, max=99},
			}
		},
	},
	
	restaurantdining = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="RestaurantMenus", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="BarCounterLiquor", min=0, max=99, forceForTiles="location_restaurant_bar_01_0;location_restaurant_bar_01_1;location_restaurant_bar_01_2;location_restaurant_bar_01_3;location_restaurant_bar_01_4;location_restaurant_bar_01_5;location_restaurant_bar_01_6;location_restaurant_bar_01_7;location_restaurant_bar_01_16;location_restaurant_bar_01_17;location_restaurant_bar_01_18;location_restaurant_bar_01_19;location_restaurant_bar_01_20;location_restaurant_bar_01_21;location_restaurant_bar_01_22;location_restaurant_bar_01_23;location_restaurant_bar_01_56;location_restaurant_bar_01_57;location_restaurant_bar_01_58;location_restaurant_bar_01_59;location_restaurant_bar_01_60;location_restaurant_bar_01_61;location_restaurant_bar_01_62;location_restaurant_bar_01_63"},
			}
		},
		overhead = {
			rolls = 1,
			items = {
				
			}
		},
		restaurantdisplay = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="ServingTrayBurgers", min=0, max=1, weightChance=80},
				{name="ServingTrayBurritos", min=0, max=1, weightChance=20},
				{name="ServingTrayChicken", min=0, max=1, weightChance=80},
				{name="ServingTrayChickenFried", min=0, max=1, weightChance=100},
				{name="ServingTrayChickenNuggets", min=0, max=1, weightChance=100},
				{name="ServingTrayChickenWings", min=0, max=1, weightChance=100},
				{name="ServingTrayFishFingers", min=0, max=1, weightChance=100},
				{name="ServingTrayFries", min=0, max=1, weightChance=100},
				{name="ServingTrayHam", min=0, max=1, weightChance=80},
				{name="ServingTrayHotdogs", min=0, max=1, weightChance=80},
				{name="ServingTrayOnionRings", min=0, max=1, weightChance=100},
				{name="ServingTrayPerogies", min=0, max=1, weightChance=20},
				{name="ServingTrayPizza", min=0, max=1, weightChance=20},
				{name="ServingTrayPorkChops", min=0, max=1, weightChance=80},
				{name="ServingTrayPotatoPancakes", min=0, max=1, weightChance=20},
				{name="ServingTraySausage", min=0, max=1, weightChance=80},
				{name="ServingTraySteak", min=0, max=1, weightChance=60},
				{name="ServingTrayTatoDots", min=0, max=1, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="BarShelfLiquor", min=0, max=99, forceForTiles="location_restaurant_bar_01_29;location_restaurant_bar_01_30;location_restaurant_bar_01_31;location_restaurant_bar_01_37;location_restaurant_bar_01_38;location_restaurant_bar_01_39;location_restaurant_bar_01_64;location_restaurant_bar_01_65;location_restaurant_bar_01_66;location_restaurant_bar_01_72;location_restaurant_bar_01_73;location_restaurant_bar_01_74"},
			}
		},
	},
	
	restaurantkitchen = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateOilVegetable", min=0, max=1, weightChance=80},
				{name="FryFactoryPotatoes", min=0, max=1, weightChance=100},
				{name="CrateCoffee", min=0, max=1, weightChance=60},
				{name="CrateCondiments", min=0, max=1, weightChance=100},
				{name="CrateFlour", min=0, max=1, weightChance=80},
				{name="CrateGravyMix", min=0, max=1, weightChance=20},
				{name="CrateTea", min=0, max=1, weightChance=60},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="StoreKitchenBaking", min=0, max=1, weightChance=100},
				{name="StoreKitchenButcher", min=0, max=1, weightChance=100},
				{name="StoreKitchenCafe", min=1, max=1, weightChance=80},
				{name="StoreKitchenPotatoes", min=0, max=1, weightChance=60},
				{name="StoreKitchenSauce", min=0, max=1, weightChance=60},
				{name="StoreKitchenPots", min=0, max=1, weightChance=40},
				{name="StoreKitchenDishes", min=0, max=1, weightChance=20},
				{name="StoreKitchenGlasses", min=0, max=1, weightChance=20},
				{name="StoreKitchenCutlery", min=0, max=1, weightChance=20},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateCoffee", min=0, max=1, weightChance=60},
				{name="CrateCondiments", min=0, max=1, weightChance=100},
				{name="CrateFlour", min=0, max=1, weightChance=80},
				{name="CrateGravyMix", min=0, max=1, weightChance=20},
				{name="CrateOilVegetable", min=0, max=1, weightChance=80},
				{name="CrateSugar", min=0, max=1, weightChance=80},
				{name="CrateTea", min=0, max=1, weightChance=60},
				{name="CrateYeast", min=0, max=1, weightChance=10},
				{name="FryFactoryPotatoes", min=0, max=2, weightChance=100},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="RestaurantKitchenFreezer", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="RestaurantKitchenFridge", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateCoffee", min=0, max=1, weightChance=100},
				{name="CrateFlour", min=0, max=1, weightChance=100},
				{name="CrateGravyMix", min=0, max=1, weightChance=100},
				{name="CrateOilVegetable", min=0, max=1, weightChance=100},
				{name="CrateSugar", min=0, max=1, weightChance=100},
				{name="CrateTea", min=0, max=1, weightChance=100},
				{name="CrateYeast", min=0, max=1, weightChance=100},
				{name="FryFactoryPotatoes", min=0, max=2, weightChance=100},
			}
		},
		restaurantdisplay = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="ServingTrayBurgers", min=0, max=1, weightChance=80},
				{name="ServingTrayChicken", min=0, max=1, weightChance=80},
				{name="ServingTrayChickenFried", min=0, max=1, weightChance=100},
				{name="ServingTrayChickenNuggets", min=0, max=1, weightChance=100},
				{name="ServingTrayChickenWings", min=0, max=1, weightChance=100},
				{name="ServingTrayFishFingers", min=0, max=1, weightChance=100},
				{name="ServingTrayFries", min=0, max=1, weightChance=100},
				{name="ServingTrayHam", min=0, max=1, weightChance=80},
				{name="ServingTrayHotdogs", min=0, max=1, weightChance=80},
				{name="ServingTrayOnionRings", min=0, max=1, weightChance=100},
				{name="ServingTrayPerogies", min=0, max=1, weightChance=20},
				{name="ServingTrayPizza", min=0, max=1, weightChance=20},
				{name="ServingTrayPorkChops", min=0, max=1, weightChance=80},
				{name="ServingTrayPotatoPancakes", min=0, max=1, weightChance=20},
				{name="ServingTraySausage", min=0, max=1, weightChance=80},
				{name="ServingTraySteak", min=0, max=1, weightChance=60},
				{name="ServingTrayTatoDots", min=0, max=1, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateCoffee", min=0, max=1, weightChance=60},
				{name="CrateCondiments", min=0, max=1, weightChance=100},
				{name="CrateFlour", min=0, max=1, weightChance=80},
				{name="CrateGravyMix", min=0, max=1, weightChance=20},
				{name="CrateOilVegetable", min=0, max=1, weightChance=80},
				{name="CrateSugar", min=0, max=1, weightChance=80},
				{name="CrateTea", min=0, max=1, weightChance=60},
				{name="CrateYeast", min=0, max=1, weightChance=10},
				{name="FryFactoryPotatoes", min=0, max=2, weightChance=100},
			}
		},
	},
	
	revpeterwattsbathroom = {
		counter = {
			procedural = true,
			procList = {
				{name="BathroomCounterEmpty", min=0, max=99},
			}
		},
	},
	
	ringtossgame = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="CarnivalPrizes", min=0, max=4, weightChance=100},
			}
		}
	},
	
	schoolgymstorage = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="GymMats", min=0, max=1, weightChance=40},
				{name="CrateBasketballs", min=0, max=1, weightChance=60},
				{name="CrateSoccerBalls", min=0, max=1, weightChance=60},
				{name="SchoolGymSportsGear", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="GymMats", min=0, max=1, weightChance=40},
				{name="CrateBasketballs", min=0, max=1, weightChance=60},
				{name="CrateSoccerBalls", min=0, max=1, weightChance=60},
				{name="SchoolGymSportsGear", min=0, max=99, weightChance=100},
			}
		},
		clothingdryerbasic = {
			procedural = true,
			procList = {
				{name="CrateBasketballs", min=0, max=99, weightChance=100},
				{name="CrateSoccerBalls", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="GymMats", min=1, max=1, weightChance=100},
				{name="SchoolGymSportsGear", min=1, max=99, weightChance=100},
			}
		},
	},
	
	schoolstorage = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateSkeletonDisplay", min=0, max=1, weightChance=40},
				{name="CrateClayBags", min=0, max=1, weightChance=80},
				{name="CrateBooksSchool", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="JanitorMisc", min=1, max=1, weightChance=100},
				{name="JanitorTools", min=0, max=1, weightChance=100},
				{name="JanitorCleaning", min=0, max=1, weightChance=100},
				{name="JanitorChemicals", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateSkeletonDisplay", min=0, max=1, weightChance=40},
				{name="CrateClayBags", min=0, max=1, weightChance=80},
				{name="CrateBooksSchool", min=0, max=99, weightChance=100},
			}
		},
		desk = {
			rolls = 1,
			items = {
				
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateClayBags", min=0, max=1, weightChance=80},
				{name="CrateBooksSchool", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateClayBags", min=0, max=1, weightChance=80},
				{name="CrateBooksSchool", min=0, max=99, weightChance=100},
			}
		},
	},
	
	seafoodkitchen = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateFlour", min=0, max=1, weightChance=100},
				{name="CrateOilVegetable", min=0, max=1, weightChance=100},
				{name="FryFactoryPotatoes", min=0, max=2, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="SeafoodKitchenSauce", min=0, max=1, weightChance=100},
				{name="JaysKitchenBaking", min=0, max=1, weightChance=100},
				{name="SeafoodKitchenButcher", min=1, max=2, weightChance=100},
				{name="StoreKitchenBags", min=0, max=1, weightChance=20},
				{name="StoreKitchenCups", min=0, max=1, weightChance=20},
				{name="StoreKitchenPotatoes", min=1, max=1, weightChance=100},
				{name="StoreKitchenPots", min=0, max=1, weightChance=20},
				{name="StoreKitchenTrays", min=0, max=1, weightChance=20},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateFlour", min=0, max=1, weightChance=100},
				{name="CrateOilVegetable", min=0, max=1, weightChance=100},
				{name="FryFactoryPotatoes", min=0, max=2, weightChance=100},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="SeafoodKitchenFreezer", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="SeafoodKitchenFridge", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateFlour", min=0, max=1, weightChance=100},
				{name="CrateOilVegetable", min=0, max=1, weightChance=100},
				{name="CrateYeast", min=0, max=1, weightChance=100},
				{name="FryFactoryPotatoes", min=0, max=2, weightChance=100},
			}
		},
		restaurantdisplay = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="ServingTrayBiscuits", min=0, max=1, weightChance=100},
				{name="ServingTrayFish", min=0, max=2, weightChance=80},
				{name="ServingTrayFishFingers", min=0, max=1, weightChance=100},
				{name="ServingTrayFishFried", min=0, max=2, weightChance=100},
				{name="ServingTrayFries", min=0, max=1, weightChance=100},
				{name="ServingTrayLobster", min=0, max=1, weightChance=60},
				{name="ServingTrayMussels", min=0, max=2, weightChance=80},
				{name="ServingTrayOysters", min=0, max=2, weightChance=80},
				{name="ServingTrayOystersFried", min=0, max=2, weightChance=100},
				{name="ServingTraySalmon", min=0, max=1, weightChance=60},
				{name="ServingTrayShrimp", min=0, max=2, weightChance=80},
				{name="ServingTrayShrimpFried", min=0, max=2, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateFlour", min=0, max=1, weightChance=100},
				{name="CrateOilVegetable", min=0, max=1, weightChance=100},
				{name="FryFactoryPotatoes", min=0, max=2, weightChance=100},
			}
		},
	},
	
	-- TODO: Set up specific containers for these.
	secondaryclassroom = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateSkeletonDisplay", min=0, max=1, weightChance=1},
				{name="CrateBooksSchool", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="ClassroomSecondaryMisc", min=0, max=99},
			}
		},
		desk = {
			procedural = true,
			procList = {
				{name="ClassroomSecondaryDesk", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="ClassroomSecondaryShelves", min=0, max=99, weightChance=100},
				{name="ScienceMisc", min=0, max=1, weightChance=10},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="ClassroomSecondaryShelves", min=0, max=99},
			}
		}
	},
	
	-- TODO: Set up specific containers for these.
	secondaryhall = {
		locker = {
			procedural = true,
			procList = {
				{name="SchoolLockersBad", min=0, max=1, weightChance=10},
				{name="SchoolLockers", min=0, max=99},
			}
		}
	},
	
	security = {
		counter = {
			procedural = true,
			procList = {
				{name="SecurityDesk", min=0, max=99, weightChance=100},
			},
			dontSpawnAmmo = true,
		},
		desk = {
			procedural = true,
			procList = {
				{name="SecurityDesk", min=0, max=99, weightChance=100},
			},
			dontSpawnAmmo = true,
		},
		locker = {
			procedural = true,
			procList = {
				{name="SecurityLockers", min=0, max=99, weightChance=100},
			},
			dontSpawnAmmo = true,
		},
		freezer = {
			rolls = 1,
			items = {
				
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeOffice", min=0, max=99},
			}
		},
		medicine = {
			procedural = true,
			procList = {
				{name="MedicalCabinet", min=0, max=99},
			}
		},
	},
	
	sewingstorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="SewingStoreDye", min=0, max=99, weightChance=100},
				{name="SewingStoreTools", min=0, max=99, weightChance=100},
				{name="SewingStoreFabric", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="SewingStoreDye", min=0, max=99, weightChance=100},
				{name="SewingStoreTools", min=0, max=99, weightChance=100},
				{name="SewingStoreFabric", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="SewingStoreDye", min=0, max=99, weightChance=100},
				{name="SewingStoreTools", min=0, max=99, weightChance=100},
				{name="SewingStoreFabric", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="SewingStoreDye", min=0, max=99, weightChance=100},
				{name="SewingStoreTools", min=0, max=99, weightChance=100},
				{name="SewingStoreFabric", min=0, max=99, weightChance=100},
			}
		},
	},
	
	sewingstore = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreCounterBagsFancy", min=0, max=1, weightChance=100},
				{name="BookstoreFashion", min=1, max=2, weightChance=100},
				{name="SewingStoreTools", min=1, max=99, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="SewingStoreDye", min=0, max=99, weightChance=100},
				{name="SewingStoreTools", min=1, max=99, weightChance=100},
				{name="SewingStoreFabric", min=1, max=99, weightChance=100},
			}
		},
		clothingrack = {
			procedural = true,
			procList = {
				{name="ClothingStoresDress", min=0, max=99},
			}
		}
	},
	
	shed = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateAnimalFeed", min=0, max=1, weightChance=10},
				{name="CrateBlackBBQ", min=0, max=1, weightChance=40},
				{name="CrateCamping", min=0, max=1, weightChance=80},
				{name="CrateCarpentry", min=0, max=1, weightChance=100},
				{name="CrateClayBricks", min=0, max=1, weightChance=10},
				{name="CrateConcrete", min=0, max=1, weightChance=10},
				{name="CrateElectronics", min=0, max=1, weightChance=80},
				{name="CrateFarming", min=0, max=1, weightChance=100},
				{name="CrateFertilizer", min=0, max=1, weightChance=20},
				{name="CrateFishing", min=0, max=1, weightChance=100},
				{name="CrateGravelBags", min=0, max=1, weightChance=20},
				{name="CrateLimestoneCrushed", min=0, max=1, weightChance=5},
				{name="CrateLumber", min=0, max=1, weightChance=40},
				{name="CrateMetalwork", min=0, max=1, weightChance=100},
				{name="CratePaint", min=0, max=1, weightChance=60},
				{name="CratePlaster", min=0, max=1, weightChance=20},
				{name="CrateRandomJunk", min=0, max=1, weightChance=80},
				{name="CrateRedBBQ", min=0, max=1, weightChance=40},
				{name="CrateTools", min=0, max=1, weightChance=60},
				{name="CrateToolsOld", min=0, max=1, weightChance=100},
				{name="CrateTV", min=0, max=1, weightChance=40},
				{name="CrateTVWide", min=0, max=1, weightChance=40},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="GarageCarpentry", min=0, max=2, weightChance=100},
				{name="CrateFarming", min=0, max=1, weightChance=100},
				{name="GarageMetalwork", min=0, max=2, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateAnimalFeed", min=0, max=1, weightChance=10},
				{name="CrateAntiqueStove", min=0, max=1, weightChance=5},
				{name="CrateBlackBBQ", min=0, max=1, weightChance=40},
				{name="CrateCamping", min=0, max=1, weightChance=80},
				{name="CrateCarpentry", min=0, max=1, weightChance=100},
				{name="CrateClayBricks", min=0, max=1, weightChance=10},
				{name="CrateConcrete", min=0, max=1, weightChance=10},
				{name="CrateElectronics", min=0, max=1, weightChance=100},
				{name="CrateFarming", min=0, max=1, weightChance=100},
				{name="CrateFertilizer", min=0, max=1, weightChance=20},
				{name="CrateFishing", min=0, max=1, weightChance=100},
				{name="CrateGravelBags", min=0, max=1, weightChance=20},
				{name="CrateLimestoneCrushed", min=0, max=1, weightChance=5},
				{name="CrateLumber", min=0, max=1, weightChance=40},
				{name="CrateMechanics", min=0, max=1, weightChance=100},
				{name="CrateMetalwork", min=0, max=1, weightChance=100},
				{name="CratePaint", min=0, max=1, weightChance=60},
				{name="CratePlaster", min=0, max=1, weightChance=20},
				{name="CrateRedBBQ", min=0, max=1, weightChance=40},
				{name="CrateTools", min=0, max=1, weightChance=100},
			}
		},
		locker = {
			procedural = true,
			procList = {
				{name="GarageTools", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateFarming", min=0, max=1, weightChance=100},
				{name="GarageCarpentry", min=0, max=1, weightChance=100},
				{name="GarageTools", min=0, max=1, weightChance=100},
				{name="GarageMetalwork", min=0, max=1, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="Antiques", min=0, max=1, weightChance=10},
				{name="ArtSupplies", min=0, max=1, weightChance=20},
				{name="BurglarTools", min=0, max=1, weightChance=10},
				{name="Chemistry", min=0, max=1, weightChance=10},
				{name="ClothingStorageWinter", min=0, max=1, weightChance=40},
				{name="CrateBooks", min=0, max=1, weightChance=40},
				{name="CrateCanning", min=0, max=1, weightChance=20},
				{name="CrateClothesRandom", min=0, max=1, weightChance=40},
				{name="CrateComics", min=0, max=1, weightChance=40},
				{name="CrateCompactDiscs", min=0, max=1, weightChance=10},
				{name="CrateCostume", min=0, max=1, weightChance=10},
				{name="CrateDishes", min=0, max=1, weightChance=10},
				{name="CrateEmptyBottles1", min=0, max=1, weightChance=100},
				{name="CrateEmptyBottles2", min=0, max=1, weightChance=100},
				{name="CrateEmptyMixed", min=0, max=1, weightChance=100},
				{name="CrateEmptyTinCans", min=0, max=1, weightChance=100},
				{name="CrateFootwearRandom", min=0, max=1, weightChance=40},
				{name="CrateInstruments", min=0, max=1, weightChance=10},
				{name="CrateLinens", min=0, max=1, weightChance=10},
				{name="CrateMagazines", min=0, max=1, weightChance=40},
				{name="CrateNewspapers", min=0, max=1, weightChance=40},
				{name="CratePetSupplies", min=0, max=1, weightChance=10},
				{name="CrateTailoring", min=0, max=1, weightChance=10},
				{name="CrateToys", min=0, max=1, weightChance=10},
				{name="CrateVHSTapes", min=0, max=1, weightChance=10},
				{name="EngineerTools", min=0, max=1, weightChance=20},
				{name="FitnessTrainer", min=0, max=1, weightChance=20},
				{name="Gifts", min=0, max=1, weightChance=10},
				{name="Hiker", min=0, max=1, weightChance=20},
				{name="Hobbies", min=0, max=1, weightChance=20},
				{name="HolidayStuff", min=0, max=1, weightChance=20},
				{name="Homesteading", min=0, max=1, weightChance=20},
				{name="Hunter", min=0, max=1, weightChance=20},
				{name="ImprovisedCrafts", min=0, max=1, weightChance=20},
				{name="JunkHoard", min=0, max=1, weightChance=40},
				{name="MechanicSpecial", min=0, max=1, weightChance=20},
				{name="Photographer", min=0, max=1, weightChance=20},
				{name="PlumbingSupplies", min=0, max=1, weightChance=20},
				{name="ScienceMisc", min=0, max=1, weightChance=20},
				{name="SurvivalGear", min=0, max=1, weightChance=20},
				{name="Trapper", min=0, max=1, weightChance=20},
				{name="VacationStuff", min=0, max=1, weightChance=20},
			}
		},
	},
	
	shoestore = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="ClothingStorageFootwear", min=0, max=99},
			}
		},
		clothingrack = {
			procedural = true,
			procList = {
				{name="ClothingStoresDress", min=0, max=99, weightChance=20},
				{name="ClothingStoresJackets", min=0, max=99, weightChance=40},
				{name="ClothingStoresJacketsFormal", min=0, max=99, weightChance=10},
				{name="ClothingStoresJumpers", min=0, max=99, weightChance=60},
				{name="ClothingStoresOvershirts", min=0, max=99, weightChance=80},
				{name="ClothingStoresPants", min=0, max=99, weightChance=100},
				{name="ClothingStoresPantsFormal", min=0, max=99, weightChance=10},
				{name="ClothingStoresShirts", min=0, max=99, weightChance=100},
				{name="ClothingStoresShirtsFormal", min=0, max=99, weightChance=10},
				{name="ClothingStoresSport", min=0, max=99, weightChance=40},
				{name="ClothingStoresSummer", min=0, max=99, weightChance=40},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="ClothingStoresGloves", min=0, max=99, weightChance=40},
				{name="ClothingStoresEyewear", min=0, max=99, weightChance=100},
				{name="ClothingStoresHeadwear", min=0, max=99, weightChance=60},
				{name="ClothingStoresSocks", min=0, max=99, weightChance=20},
				{name="ClothingStoresUnderwearWoman", min=0, max=99, weightChance=20},
				{name="ClothingStoresUnderwearMan", min=0, max=99, weightChance=20},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="ClothingStorageFootwear", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="ClothingStorageFootwear", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="ClothingStoresBoots", min=0, max=99, weightChance=40},
				{name="ClothingStoresShoes", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="ClothingStorageFootwear", min=0, max=99},
			}
		},
	},
	
	smokingroom = {
		shelves = {
			procedural = true,
			procList = {
				{name="SmokingRoomPipes", min=0, max=99, weightChance=40},
				{name="SmokingRoomCigars", min=0, max=99, weightChance=100},
			}
		}
	},
	
	sodatruck = {
		isShop = true,
		all = {
			procedural = true,
			procList = {
				{name="CrateSodaBottles", min=0, max=99, weightChance=100},
				{name="CrateSodaCans", min=0, max=99, weightChance=100},
			}
		},
	},
	
	spiffo_dining = {
		isShop = true,
		bin = {
			isTrash = true,
			procedural = true,
			procList = {
				{name="BinSpiffos", min=0, max=99},
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateFountainCups", min=0, max=1, weightChance=100},
				{name="CratePaperNapkins", min=0, max=1, weightChance=100},
				{name="CratePaperBagSpiffos", min=0, max=1, weightChance=100},
				{name="CratePlasticTrays", min=0, max=1, weightChance=100},
				{name="CrateSpiffoMerch", min=0, max=1, weightChance=1},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="Empty", min=0, max=99, forceForTiles="location_shop_accessories_01_8;location_shop_accessories_01_9;location_shop_accessories_01_10;location_shop_accessories_01_11;location_shop_accessories_01_12"},
				{name="SpiffosDiningCounter", min=0, max=99,weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateFountainCups", min=0, max=1, weightChance=100},
				{name="CratePaperNapkins", min=0, max=1, weightChance=100},
				{name="CratePaperBagSpiffos", min=0, max=1, weightChance=100},
				{name="CratePlasticTrays", min=0, max=1, weightChance=100},
				{name="CrateSpiffoMerch", min=0, max=1, weightChance=1},
			}
		},
		restaurantdisplay = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="ServingTrayBurgers", min=1, max=8, weightChance=100},
				{name="ServingTrayChickenNuggets", min=0, max=99, weightChance=100},
				{name="ServingTrayFries", min=1, max=4, weightChance=60},
				{name="ServingTrayOnionRings", min=1, max=4, weightChance=60},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateFountainCups", min=0, max=1, weightChance=100},
				{name="CratePaperNapkins", min=0, max=1, weightChance=100},
				{name="CratePaperBagSpiffos", min=0, max=1, weightChance=100},
				{name="CratePlasticTrays", min=0, max=1, weightChance=100},
				{name="CrateSpiffoMerch", min=0, max=1, weightChance=1},
			}
		},
	},
	
	spiffoskitchen = {
		bin = {
			isTrash = true,
			procedural = true,
			procList = {
				{name="BinSpiffos", min=0, max=99},
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateBunsBurger", min=0, max=2, weightChance=100},
				{name="CrateCondiments", min=0, max=2, weightChance=80},
				{name="CrateSpiffoMerch", min=0, max=1, weightChance=5},
				{name="FryFactoryPotatoes", min=0, max=2, weightChance=80},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="SpiffosKitchenButcher", min=0, max=1, weightChance=100},
				{name="SpiffosKitchenSauce", min=0, max=1, weightChance=100},
				{name="SpiffosKitchenBags", min=0, max=1, weightChance=20},
				{name="SpiffosKitchenSpecial", min=0, max=1, weightChance=1},
				{name="StoreKitchenBaking", min=0, max=1, weightChance=100},
				{name="StoreKitchenCups", min=0, max=1, weightChance=20},
				{name="StoreKitchenPots", min=0, max=1, weightChance=20},
				{name="SpiffosKitchenTrays", min=0, max=1, weightChance=20},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateBunsBurger", min=0, max=2, weightChance=100},
				{name="CrateCondiments", min=0, max=2, weightChance=80},
				{name="CrateSpiffoMerch", min=0, max=1, weightChance=5},
				{name="FryFactoryPotatoes", min=0, max=2, weightChance=80},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="SpiffosKitchenFreezer", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="SpiffosKitchenFridge", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateBunsBurger", min=0, max=2, weightChance=100},
				{name="CrateCondiments", min=0, max=2, weightChance=80},
				{name="CrateSpiffoMerch", min=0, max=1, weightChance=5},
				{name="FryFactoryPotatoes", min=0, max=2, weightChance=80},
			}
		},
		restaurantdisplay = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="ServingTrayBurgers", min=1, max=8, weightChance=100},
				{name="ServingTrayChickenNuggets", min=0, max=99, weightChance=100},
				{name="ServingTrayFries", min=1, max=4, weightChance=60},
				{name="ServingTrayOnionRings", min=1, max=4, weightChance=60},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateFountainCups", min=0, max=1, weightChance=100},
				{name="CratePaperNapkins", min=0, max=1, weightChance=100},
				{name="CratePaperBagSpiffos", min=0, max=1, weightChance=100},
				{name="CratePlasticTrays", min=0, max=1, weightChance=100},
				{name="CrateSpiffoMerch", min=0, max=1, weightChance=5},
			}
		},
		stove = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="StoveSpiffos", min=1, max=99, forceForTiles="appliances_cooking_20;appliances_cooking_21;appliances_cooking_22;appliances_cooking_23;appliances_cooking_24"},
			}
		},
	},
	
	spiffosstorage = {
		bin = {
			isTrash = true,
			procedural = true,
			procList = {
				{name="BinSpiffos", min=0, max=99},
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateBunsBurger", min=0, max=2, weightChance=100},
				{name="CrateCondiments", min=0, max=2, weightChance=80},
				{name="CrateSpiffoMerch", min=0, max=1, weightChance=5},
				{name="FryFactoryPotatoes", min=0, max=2, weightChance=80},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateBunsBurger", min=0, max=2, weightChance=100},
				{name="CrateCondiments", min=0, max=2, weightChance=80},
				{name="CrateSpiffoMerch", min=0, max=1, weightChance=5},
				{name="FryFactoryPotatoes", min=0, max=2, weightChance=80},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="SpiffosKitchenFreezer", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="SpiffosKitchenFridge", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateBunsBurger", min=0, max=2, weightChance=100},
				{name="CrateCondiments", min=0, max=2, weightChance=80},
				{name="CrateSpiffoMerch", min=0, max=1, weightChance=5},
				{name="FryFactoryPotatoes", min=0, max=2, weightChance=80},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateFountainCups", min=0, max=1, weightChance=100},
				{name="CratePaperNapkins", min=0, max=1, weightChance=100},
				{name="CratePaperBagSpiffos", min=0, max=1, weightChance=100},
				{name="CratePlasticTrays", min=0, max=1, weightChance=100},
				{name="CrateSpiffoMerch", min=0, max=1, weightChance=5},
			}
		},
	},
	
	sportstorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="SportStorageBats", min=0, max=2, weightChance=100},
				{name="SportStorageBalls", min=0, max=2, weightChance=20},
				{name="SportStorageHelmets", min=0, max=2, weightChance=80},
				{name="SportStoragePaddles", min=0, max=1, weightChance=10},
				{name="SportStorageRacquets", min=0, max=4, weightChance=20},
				{name="SportStorageSticks", min=0, max=4, weightChance=80},
				{name="SportStorageWeights", min=0, max=1, weightChance=10},
			}
		},
		clothingrack = {
			procedural = true,
			procList = {
				{name="ClothingStoresSport", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreCounterBagsFancy", min=0, max=1, weightChance=20},
				{name="ClothingStoresEyewear", min=0, max=2, weightChance=60},
				{name="ClothingStoresHeadwear", min=0, max=4, weightChance=100},
				{name="SportStoreSneakers", min=0, max=99, weightChance=80},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="SportStorageBats", min=0, max=2, weightChance=100},
				{name="SportStorageBalls", min=0, max=2, weightChance=20},
				{name="SportStorageHelmets", min=0, max=2, weightChance=80},
				{name="SportStoragePaddles", min=0, max=1, weightChance=10},
				{name="SportStorageRacquets", min=0, max=4, weightChance=20},
				{name="SportStorageSticks", min=0, max=4, weightChance=80},
				{name="SportStorageWeights", min=0, max=1, weightChance=10},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="SportStorageBats", min=0, max=2, weightChance=100},
				{name="SportStorageHelmets", min=0, max=2, weightChance=80},
				{name="SportStoragePaddles", min=0, max=1, weightChance=10},
				{name="SportStorageRacquets", min=0, max=4, weightChance=20},
				{name="SportStorageSticks", min=0, max=4, weightChance=80},
				{name="SportStorageWeights", min=0, max=1, weightChance=10},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="SportStoreSneakers", min=0, max=99, weightChance=100},
				{name="SportStorageBats", min=0, max=2, weightChance=100},
				{name="SportStorageHelmets", min=0, max=2, weightChance=80},
				{name="SportStoragePaddles", min=0, max=1, weightChance=10},
				{name="SportStorageRacquets", min=0, max=4, weightChance=20},
				{name="SportStorageSticks", min=0, max=4, weightChance=80},
				{name="SportStorageWeights", min=0, max=1, weightChance=10},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="SportStorageBalls", min=0, max=2, weightChance=60},
				{name="SportStorageHelmets", min=0, max=2, weightChance=100},
				{name="SportStorageRacquets", min=0, max=4, weightChance=60},
				{name="SportStorageWeights", min=0, max=1, weightChance=40},
			}
		},
	},
	
	sportstore = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="SportStorageBats", min=0, max=1, weightChance=10},
				{name="SportStorageHelmets", min=0, max=1, weightChance=10},
				{name="SportStoragePaddles", min=0, max=1, weightChance=10},
				{name="SportStorageRacquets", min=0, max=1, weightChance=10},
				{name="SportStorageSticks", min=0, max=1, weightChance=10},
				{name="SportStorageWeights", min=0, max=1, weightChance=10},
				{name="SportStorageBalls", min=0, max=99, weightChance=100},
			}
		},
		clothingrack = {
			procedural = true,
			procList = {
				{name="ClothingStoresSport", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreCounterBagsFancy", min=0, max=1, weightChance=100},
				{name="SportStoreAccessories", min=1, max=4, weightChance=40},
				{name="SportStoreSneakers", min=1, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="SportStorageBats", min=0, max=1, weightChance=10},
				{name="SportStorageHelmets", min=0, max=1, weightChance=10},
				{name="SportStoragePaddles", min=0, max=1, weightChance=10},
				{name="SportStorageRacquets", min=0, max=1, weightChance=10},
				{name="SportStorageSticks", min=0, max=1, weightChance=10},
				{name="SportStorageWeights", min=0, max=1, weightChance=10},
				{name="SportStorageBalls", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="SportStoreBadminton", min=1, max=2, weightChance=10},
				{name="SportStoreBaseball", min=1, max=2, weightChance=20},
				{name="SportStoreBoxing", min=1, max=2, weightChance=10},
				{name="SportStoreFootball", min=1, max=2, weightChance=20},
				{name="SportStoreIceHockey", min=1, max=2, weightChance=10},
				{name="SportStoreGolf", min=1, max=2, weightChance=10},
				{name="SportStorePadding", min=1, max=2, weightChance=10},
				{name="SportStoreTennis", min=1, max=2, weightChance=20},
				{name="SportStoreSneakers", min=0, max=99, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="SportStoreBadminton", min=1, max=2, weightChance=10},
				{name="SportStoreBaseball", min=1, max=2, weightChance=20},
				{name="SportStoreBoxing", min=1, max=2, weightChance=10},
				{name="SportStoreFootball", min=1, max=2, weightChance=20},
				{name="SportStoreIceHockey", min=1, max=2, weightChance=10},
				{name="SportStoreGolf", min=1, max=2, weightChance=10},
				{name="SportStorePadding", min=1, max=2, weightChance=10},
				{name="SportStoreTennis", min=1, max=2, weightChance=20},
				{name="SportStoreSneakers", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="SportStoreAccessories", min=0, max=1, weightChance=10},
				{name="SportStorageHelmets", min=0, max=1, weightChance=10},
				{name="SportStorageRacquets", min=0, max=1, weightChance=10},
				{name="SportStorageBalls", min=0, max=99, weightChance=100},
			}
		},
	},

	-- Most basements use this roomdef at the moment. This is a placeholder that uses the old 'outdoor generic crates' list.
	storage = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateToolsOld", min=0, max=99, weightChance=5},
				{name="CratePaint", min=0, max=99, weightChance=20},
				{name="CrateWallFinish", min=0, max=99, weightChance=20},
				{name="CrateCarpentry", min=0, max=99, weightChance=40},
				{name="CrateMetalwork", min=0, max=99, weightChance=40},
				{name="CrateTools", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateToolsOld", min=0, max=99, weightChance=5},
				{name="CratePaint", min=0, max=99, weightChance=20},
				{name="CrateWallFinish", min=0, max=99, weightChance=20},
				{name="CrateCarpentry", min=0, max=99, weightChance=40},
				{name="CrateMetalwork", min=0, max=99, weightChance=40},
				{name="CrateTools", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateToolsOld", min=0, max=99, weightChance=5},
				{name="CratePaint", min=0, max=99, weightChance=20},
				{name="CrateWallFinish", min=0, max=99, weightChance=20},
				{name="CrateCarpentry", min=0, max=99, weightChance=40},
				{name="CrateMetalwork", min=0, max=99, weightChance=40},
				{name="CrateTools", min=0, max=99, weightChance=100},
			}
		},
	},
	
	storageunit = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="Antiques", min=0, max=1, weightChance=1},
				{name="BurglarTools", min=0, max=1, weightChance=1},
				{name="CrateCamping", min=0, max=1, weightChance=1},
				{name="CrateCostume", min=0, max=1, weightChance=1},
				{name="CrateMannequins", min=0, max=1, weightChance=1},
				{name="Hiker", min=0, max=1, weightChance=1},
				{name="Homesteading", min=0, max=1, weightChance=1},
				{name="Hunter", min=0, max=1, weightChance=1},
				{name="MechanicSpecial", min=0, max=1, weightChance=1},
				{name="SurvivalGear", min=0, max=1, weightChance=1},
				{name="Trapper", min=0, max=1, weightChance=1},
				{name="ArtSupplies", min=0, max=1, weightChance=5},
				{name="Chemistry", min=0, max=1, weightChance=5},
				{name="CrateCanning", min=0, max=1, weightChance=5},
				{name="CrateDishes", min=0, max=1, weightChance=5},
				{name="CrateInstruments", min=0, max=1, weightChance=5},
				{name="CrateLinens", min=0, max=1, weightChance=5},
				{name="CratePetSupplies", min=0, max=1, weightChance=5},
				{name="CratePhotos", min=0, max=1, weightChance=5},
				{name="CrateSports", min=0, max=1, weightChance=5},
				{name="CrateToys", min=0, max=1, weightChance=5},
				{name="EngineerTools", min=0, max=1, weightChance=5},
				{name="FitnessTrainer", min=0, max=1, weightChance=5},
				{name="Gifts", min=0, max=1, weightChance=5},
				{name="Hobbies", min=0, max=1, weightChance=5},
				{name="HolidayStuff", min=0, max=1, weightChance=5},
				{name="ImprovisedCrafts", min=0, max=1, weightChance=5},
				{name="JunkHoard", min=0, max=1, weightChance=5},
				{name="Photographer", min=0, max=1, weightChance=5},
				{name="PlumbingSupplies", min=0, max=1, weightChance=5},
				{name="ScienceMisc", min=0, max=1, weightChance=5},
				{name="VacationStuff", min=0, max=1, weightChance=5},
				{name="WallDecor", min=0, max=1, weightChance=5},
				{name="CrateComputer", min=0, max=1, weightChance=10},
				{name="CrateTV", min=0, max=1, weightChance=10},
				{name="CrateTVWide", min=0, max=1, weightChance=10},
				{name="CrateElectronics", min=0, max=1, weightChance=10},
				{name="ClothingStorageWinter", min=0, max=1, weightChance=10},
				{name="CrateClothesRandom", min=0, max=1, weightChance=10},
				{name="CrateFootwearRandom", min=0, max=1, weightChance=10},
				{name="CrateBlacksmithing", min=0, max=1, weightChance=1},
				{name="CrateCarpentry", min=0, max=1, weightChance=10},
				{name="CrateFarming", min=0, max=1, weightChance=10},
				{name="CrateFishing", min=0, max=1, weightChance=10},
				{name="CrateMechanics", min=0, max=1, weightChance=10},
				{name="CrateMetalwork", min=0, max=1, weightChance=10},
				{name="CrateTailoring", min=0, max=1, weightChance=10},
				{name="CrateTools", min=0, max=1, weightChance=10},
				{name="CrateToolsOld", min=0, max=1, weightChance=20},
				{name="CrateBluePlasticChairs", min=0, max=1, weightChance=20},
				{name="CrateWhiteWoodenChairs", min=0, max=1, weightChance=20},
				{name="CrateWoodenChairs", min=0, max=1, weightChance=20},
				{name="CrateWoodenStools", min=0, max=1, weightChance=20},
				{name="CratePlasticChairs", min=0, max=1, weightChance=20},
				{name="CrateFitnessWeights", min=0, max=1, weightChance=20},
				{name="CrateFoldingChairs", min=0, max=1, weightChance=20},
				{name="CrateFabric_Cotton", min=0, max=1, weightChance=1},
				{name="CrateFabric_DenimBlack", min=0, max=1, weightChance=1},
				{name="CrateFabric_DenimBlue", min=0, max=1, weightChance=1},
				{name="CrateFabric_DenimDarkBlue", min=0, max=1, weightChance=1},
				{name="CrateRandomJunk", min=0, max=4, weightChance=60},
				{name="CrateBooks", min=0, max=1, weightChance=20},
				{name="CrateMagazines", min=0, max=4, weightChance=80},
				{name="CrateNewspapers", min=0, max=4, weightChance=100},
			}
		},
		counter = {
			rolls = 1,
			items = {
				
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateAntiqueStove", min=0, max=1, weightChance=1},
				{name="Antiques", min=0, max=1, weightChance=1},
				{name="BurglarTools", min=0, max=1, weightChance=1},
				{name="CrateCamping", min=0, max=1, weightChance=1},
				{name="CrateCostume", min=0, max=1, weightChance=1},
				{name="CrateMannequins", min=0, max=1, weightChance=1},
				{name="Hiker", min=0, max=1, weightChance=1},
				{name="Homesteading", min=0, max=1, weightChance=1},
				{name="Hunter", min=0, max=1, weightChance=1},
				{name="MechanicSpecial", min=0, max=1, weightChance=1},
				{name="SurvivalGear", min=0, max=1, weightChance=1},
				{name="Trapper", min=0, max=1, weightChance=1},
				{name="ArtSupplies", min=0, max=1, weightChance=5},
				{name="Chemistry", min=0, max=1, weightChance=5},
				{name="CrateCanning", min=0, max=1, weightChance=5},
				{name="CrateDishes", min=0, max=1, weightChance=5},
				{name="CrateInstruments", min=0, max=1, weightChance=5},
				{name="CrateLinens", min=0, max=1, weightChance=5},
				{name="CratePetSupplies", min=0, max=1, weightChance=5},
				{name="CratePhotos", min=0, max=1, weightChance=5},
				{name="CrateSports", min=0, max=1, weightChance=5},
				{name="CrateToys", min=0, max=1, weightChance=5},
				{name="EngineerTools", min=0, max=1, weightChance=5},
				{name="FitnessTrainer", min=0, max=1, weightChance=5},
				{name="Gifts", min=0, max=1, weightChance=5},
				{name="Hobbies", min=0, max=1, weightChance=5},
				{name="HolidayStuff", min=0, max=1, weightChance=5},
				{name="ImprovisedCrafts", min=0, max=1, weightChance=5},
				{name="JunkHoard", min=0, max=1, weightChance=5},
				{name="Photographer", min=0, max=1, weightChance=5},
				{name="PlumbingSupplies", min=0, max=1, weightChance=5},
				{name="ScienceMisc", min=0, max=1, weightChance=5},
				{name="VacationStuff", min=0, max=1, weightChance=5},
				{name="WallDecor", min=0, max=1, weightChance=5},
				{name="CrateComputer", min=0, max=1, weightChance=10},
				{name="CrateTV", min=0, max=1, weightChance=10},
				{name="CrateTVWide", min=0, max=1, weightChance=10},
				{name="CrateElectronics", min=0, max=1, weightChance=10},
				{name="ClothingStorageWinter", min=0, max=1, weightChance=10},
				{name="CrateClothesRandom", min=0, max=1, weightChance=10},
				{name="CrateFootwearRandom", min=0, max=1, weightChance=10},
				{name="CrateBlacksmithing", min=0, max=1, weightChance=1},
				{name="CrateCarpentry", min=0, max=1, weightChance=10},
				{name="CrateFarming", min=0, max=1, weightChance=10},
				{name="CrateFishing", min=0, max=1, weightChance=10},
				{name="CrateMechanics", min=0, max=1, weightChance=10},
				{name="CrateMetalwork", min=0, max=1, weightChance=10},
				{name="CrateTailoring", min=0, max=1, weightChance=10},
				{name="CrateTools", min=0, max=1, weightChance=10},
				{name="CrateToolsOld", min=0, max=1, weightChance=20},
				{name="CrateBluePlasticChairs", min=0, max=1, weightChance=20},
				{name="CrateWhiteWoodenChairs", min=0, max=1, weightChance=20},
				{name="CrateWoodenChairs", min=0, max=1, weightChance=20},
				{name="CrateWoodenStools", min=0, max=1, weightChance=20},
				{name="CratePlasticChairs", min=0, max=1, weightChance=20},
				{name="CrateFitnessWeights", min=0, max=1, weightChance=20},
				{name="CrateFoldingChairs", min=0, max=1, weightChance=20},
				{name="CrateFabric_Cotton", min=0, max=1, weightChance=1},
				{name="CrateFabric_DenimBlack", min=0, max=1, weightChance=1},
				{name="CrateFabric_DenimBlue", min=0, max=1, weightChance=1},
				{name="CrateFabric_DenimDarkBlue", min=0, max=1, weightChance=1},
				{name="CrateRandomJunk", min=0, max=4, weightChance=60},
				{name="CrateBooks", min=0, max=1, weightChance=20},
				{name="CrateMagazines", min=0, max=4, weightChance=80},
				{name="CrateNewspapers", min=0, max=4, weightChance=100},
			}
		},
		dresser = {
			rolls = 1,
			items = {
				
			}
		},
		dishescabinet = {
			rolls = 1,
			items = {
				
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="Antiques", min=0, max=1, weightChance=1},
				{name="BurglarTools", min=0, max=1, weightChance=1},
				{name="CrateCamping", min=0, max=1, weightChance=1},
				{name="CrateCostume", min=0, max=1, weightChance=1},
				{name="Hiker", min=0, max=1, weightChance=1},
				{name="Homesteading", min=0, max=1, weightChance=1},
				{name="Hunter", min=0, max=1, weightChance=1},
				{name="MechanicSpecial", min=0, max=1, weightChance=1},
				{name="SurvivalGear", min=0, max=1, weightChance=1},
				{name="Trapper", min=0, max=1, weightChance=1},
				{name="ArtSupplies", min=0, max=1, weightChance=5},
				{name="Chemistry", min=0, max=1, weightChance=5},
				{name="CrateCanning", min=0, max=1, weightChance=5},
				{name="CrateDishes", min=0, max=1, weightChance=5},
				{name="CrateInstruments", min=0, max=1, weightChance=5},
				{name="CrateLinens", min=0, max=1, weightChance=5},
				{name="CratePetSupplies", min=0, max=1, weightChance=5},
				{name="CratePhotos", min=0, max=1, weightChance=5},
				{name="CrateSports", min=0, max=1, weightChance=5},
				{name="CrateToys", min=0, max=1, weightChance=5},
				{name="EngineerTools", min=0, max=1, weightChance=5},
				{name="FitnessTrainer", min=0, max=1, weightChance=5},
				{name="Gifts", min=0, max=1, weightChance=5},
				{name="Hobbies", min=0, max=1, weightChance=5},
				{name="HolidayStuff", min=0, max=1, weightChance=5},
				{name="ImprovisedCrafts", min=0, max=1, weightChance=5},
				{name="JunkHoard", min=0, max=1, weightChance=5},
				{name="Photographer", min=0, max=1, weightChance=5},
				{name="PlumbingSupplies", min=0, max=1, weightChance=5},
				{name="ScienceMisc", min=0, max=1, weightChance=5},
				{name="VacationStuff", min=0, max=1, weightChance=5},
				{name="WallDecor", min=0, max=1, weightChance=5},
				{name="CrateComputer", min=0, max=1, weightChance=10},
				{name="CrateTV", min=0, max=1, weightChance=10},
				{name="CrateTVWide", min=0, max=1, weightChance=10},
				{name="CrateElectronics", min=0, max=1, weightChance=10},
				{name="ClothingStorageWinter", min=0, max=1, weightChance=10},
				{name="CrateClothesRandom", min=0, max=1, weightChance=10},
				{name="CrateFootwearRandom", min=0, max=1, weightChance=10},
				{name="CrateBlacksmithing", min=0, max=1, weightChance=1},
				{name="CrateCarpentry", min=0, max=1, weightChance=10},
				{name="CrateFarming", min=0, max=1, weightChance=10},
				{name="CrateFishing", min=0, max=1, weightChance=10},
				{name="CrateMechanics", min=0, max=1, weightChance=10},
				{name="CrateMetalwork", min=0, max=1, weightChance=10},
				{name="CrateTailoring", min=0, max=1, weightChance=10},
				{name="CrateTools", min=0, max=1, weightChance=10},
				{name="CrateToolsOld", min=0, max=1, weightChance=20},
				{name="CrateFabric_Cotton", min=0, max=1, weightChance=1},
				{name="CrateFabric_DenimBlack", min=0, max=1, weightChance=1},
				{name="CrateFabric_DenimBlue", min=0, max=1, weightChance=1},
				{name="CrateFabric_DenimDarkBlue", min=0, max=1, weightChance=1},
				{name="CrateRandomJunk", min=0, max=4, weightChance=60},
				{name="CrateBooks", min=0, max=1, weightChance=20},
				{name="CrateMagazines", min=0, max=4, weightChance=80},
				{name="CrateNewspapers", min=0, max=4, weightChance=100},
			}
		},
		overhead = {
			rolls = 1,
			items = {
				
			}
		},
		shelves = {
			rolls = 1,
			items = {
				
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="Antiques", min=0, max=1, weightChance=1},
				{name="BurglarTools", min=0, max=1, weightChance=1},
				{name="CrateCamping", min=0, max=1, weightChance=1},
				{name="CrateCostume", min=0, max=1, weightChance=1},
				{name="Hiker", min=0, max=1, weightChance=1},
				{name="Homesteading", min=0, max=1, weightChance=1},
				{name="Hunter", min=0, max=1, weightChance=1},
				{name="MechanicSpecial", min=0, max=1, weightChance=1},
				{name="SurvivalGear", min=0, max=1, weightChance=1},
				{name="Trapper", min=0, max=1, weightChance=1},
				{name="ArtSupplies", min=0, max=1, weightChance=5},
				{name="Chemistry", min=0, max=1, weightChance=5},
				{name="CrateCanning", min=0, max=1, weightChance=5},
				{name="CrateDishes", min=0, max=1, weightChance=5},
				{name="CrateInstruments", min=0, max=1, weightChance=5},
				{name="CrateLinens", min=0, max=1, weightChance=5},
				{name="CratePetSupplies", min=0, max=1, weightChance=5},
				{name="CratePhotos", min=0, max=1, weightChance=5},
				{name="CrateSports", min=0, max=1, weightChance=5},
				{name="CrateToys", min=0, max=1, weightChance=5},
				{name="EngineerTools", min=0, max=1, weightChance=5},
				{name="FitnessTrainer", min=0, max=1, weightChance=5},
				{name="Gifts", min=0, max=1, weightChance=5},
				{name="Hobbies", min=0, max=1, weightChance=5},
				{name="HolidayStuff", min=0, max=1, weightChance=5},
				{name="ImprovisedCrafts", min=0, max=1, weightChance=5},
				{name="JunkHoard", min=0, max=1, weightChance=5},
				{name="Photographer", min=0, max=1, weightChance=5},
				{name="PlumbingSupplies", min=0, max=1, weightChance=5},
				{name="ScienceMisc", min=0, max=1, weightChance=5},
				{name="VacationStuff", min=0, max=1, weightChance=5},
				{name="WallDecor", min=0, max=1, weightChance=5},
				{name="CrateElectronics", min=0, max=1, weightChance=10},
				{name="ClothingStorageWinter", min=0, max=1, weightChance=10},
				{name="CrateClothesRandom", min=0, max=1, weightChance=10},
				{name="CrateFootwearRandom", min=0, max=1, weightChance=10},
				{name="CrateBlacksmithing", min=0, max=1, weightChance=1},
				{name="CrateCarpentry", min=0, max=1, weightChance=10},
				{name="CrateFarming", min=0, max=1, weightChance=10},
				{name="CrateFishing", min=0, max=1, weightChance=10},
				{name="CrateMechanics", min=0, max=1, weightChance=10},
				{name="CrateMetalwork", min=0, max=1, weightChance=10},
				{name="CrateTailoring", min=0, max=1, weightChance=10},
				{name="CrateTools", min=0, max=1, weightChance=10},
				{name="CrateToolsOld", min=0, max=1, weightChance=20},
				{name="CrateFabric_Cotton", min=0, max=1, weightChance=1},
				{name="CrateFabric_DenimBlack", min=0, max=1, weightChance=1},
				{name="CrateFabric_DenimBlue", min=0, max=1, weightChance=1},
				{name="CrateFabric_DenimDarkBlue", min=0, max=1, weightChance=1},
				{name="CrateRandomJunk", min=0, max=4, weightChance=60},
				{name="CrateBooks", min=0, max=1, weightChance=20},
				{name="CrateMagazines", min=0, max=4, weightChance=80},
				{name="CrateNewspapers", min=0, max=4, weightChance=100},
			}
		},
		toolcabinet = {
			procedural = true,
			procList = {
				{name="ToolCabinetMechanics", min=0, max=1, weightChance=40},
				{name="Empty", min=0, max=99, weightChance=100},
			}
		},
		wardrobe = {
			rolls = 1,
			items = {
				
			}
		},
	},
	
	stripclub = {
		dresser = {
			procedural = true,
			procList = {
				{name="StripClubDressers", min=0, max=99, weightChance=100},
			}
		},
	},
	
	studio = {
		counter = {
			rolls = 1,
			items = {
				
			}
		},
		dresser = {
			rolls = 1,
			items = {
				
			}
		},
		locker = {
			rolls = 1,
			items = {
				
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateCarpentry", min=0, max=99, weightChance=100},
				{name="CrateFarming", min=0, max=99, weightChance=60},
				{name="CrateMetalwork", min=0, max=99, weightChance=100},
				{name="CratePaint", min=0, max=99, weightChance=40},
				{name="CrateSheetMetal", min=0, max=99, weightChance=20},
				{name="CrateTools", min=0, max=99, weightChance=100},
				{name="CrateWallFinish", min=0, max=99, weightChance=40},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="LivingRoomShelf", min=0, max=99},
			}
		},
	},
	
	sushidining = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
			}
		},
		displaycase = {
			procedural = true,
			procList = {
				{name="ServingTrayMaki", min=0, max=99, weightChance=80},
				{name="ServingTrayOnigiri", min=0, max=99, weightChance=80},
				{name="ServingTraySpringRolls", min=0, max=99, weightChance=40},
				{name="ServingTraySushiEgg", min=1, max=99, weightChance=100},
				{name="ServingTraySushiFish", min=1, max=99, weightChance=100},
			}
		},
	},
	
	sushikitchen = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateRice", min=0, max=4, weightChance=100},
				{name="CrateRiceVinegar", min=0, max=1, weightChance=80},
				{name="CrateSeaweed", min=0, max=2, weightChance=60},
				{name="CrateSoysauce", min=0, max=1, weightChance=80},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="StoreKitchenDishes", min=0, max=1, weightChance=20},
				{name="StoreKitchenGlasses", min=0, max=1, weightChance=20},
				{name="StoreKitchenPots", min=0, max=1, weightChance=20},
				{name="SushiKitchenBaking", min=0, max=1, weightChance=60},
				{name="SushiKitchenButcher", min=0, max=2, weightChance=100},
				{name="SushiKitchenCutlery", min=0, max=1, weightChance=80},
				{name="SushiKitchenSauce", min=0, max=1, weightChance=80},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateRice", min=0, max=4, weightChance=100},
				{name="CrateRiceVinegar", min=0, max=1, weightChance=80},
				{name="CrateSeaweed", min=0, max=2, weightChance=60},
				{name="CrateSoysauce", min=0, max=1, weightChance=80},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="SushiKitchenFreezer", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="SushiKitchenFridge", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateRice", min=0, max=4, weightChance=100},
				{name="CrateRiceVinegar", min=0, max=1, weightChance=80},
				{name="CrateSeaweed", min=0, max=2, weightChance=60},
				{name="CrateSoysauce", min=0, max=1, weightChance=80},
			}
		},
		restaurantdisplay = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="ServingTraySushiEgg", min=1, max=4, weightChance=100},
				{name="ServingTraySushiFish", min=1, max=4, weightChance=100},
				{name="ServingTrayMaki", min=1, max=4, weightChance=60},
				{name="ServingTrayOnigiri", min=1, max=4, weightChance=60},
				{name="ServingTrayTofuFried", min=0, max=2, weightChance=40},
				{name="ServingTraySpringRolls", min=0, max=2, weightChance=40},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateRice", min=0, max=4, weightChance=100},
				{name="CrateRiceVinegar", min=0, max=1, weightChance=80},
				{name="CrateSeaweed", min=0, max=2, weightChance=60},
				{name="CrateSoysauce", min=0, max=1, weightChance=80},
			}
		},
	},
	
	teacherroom = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateBooks", min=0, max=99},
			}
		},
		filingcabinet = {
			procedural = true,
			procList = {
				{name="ClassroomShelves", min=0, max=99, weightChance=100},
				{name="ScienceMisc", min=0, max=1, weightChance=10},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="ClassroomShelves", min=0, max=99},
			}
		}
	},
	
	technical = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="GeneratorRoom", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="GeneratorRoom", min=0, max=99},
			}
		},
		locker = {
			procedural = true,
			procList = {
				{name="GeneratorRoom", min=0, max=99},
			}
		},
	},
	
	theatre = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CratePopcorn", min=0, max=99, weightChance=100},
				{name="CrateSodaBottles", min=0, max=99, weightChance=40},
				{name="CrateSodaCans", min=0, max=99, weightChance=60},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="Empty", min=0, max=99, weightChance=100},
				{name="TheatreLiterature", min=1, max=4, weightChance=20},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CratePopcorn", min=0, max=99, weightChance=100},
				{name="CrateSodaBottles", min=0, max=99, weightChance=40},
				{name="CrateSodaCans", min=0, max=99, weightChance=60},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CratePopcorn", min=0, max=99, weightChance=100},
				{name="CrateSodaBottles", min=0, max=99, weightChance=40},
				{name="CrateSodaCans", min=0, max=99, weightChance=60},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CratePopcorn", min=0, max=99, weightChance=100},
				{name="CrateSodaBottles", min=0, max=99, weightChance=40},
				{name="CrateSodaCans", min=0, max=99, weightChance=60},
			}
		},
	},
	
	theatrekitchen = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CratePopcorn", min=0, max=99, weightChance=100},
				{name="CrateSodaBottles", min=0, max=99, weightChance=40},
				{name="CrateSodaCans", min=0, max=99, weightChance=60},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="TheatreDrinks", min=0, max=99, forceForTiles="location_shop_accessories_01_8;location_shop_accessories_01_9;location_shop_accessories_01_12;location_shop_accessories_01_13"},
				{name="TheatreLiterature", min=1, max=4, weightChance=20},
				{name="TheatrePopcorn", min=0, max=99, forceForTiles="location_entertainment_theatre_01_17"},
				{name="TheatreSnacks", min=0, max=99, forceForTiles="location_entertainment_theatre_01_4;location_entertainment_theatre_01_5;location_entertainment_theatre_01_6;location_entertainment_theatre_01_7"},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CratePopcorn", min=0, max=99, weightChance=100},
				{name="CrateSodaBottles", min=0, max=99, weightChance=40},
				{name="CrateSodaCans", min=0, max=99, weightChance=60},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="TheatreKitchenFreezer", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeSoda", min=1, max=99, weightChance=100},
				{name="FridgeWater", min=1, max=99, weightChance=60},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CratePopcorn", min=0, max=99, weightChance=100},
				{name="CrateSodaBottles", min=0, max=99, weightChance=40},
				{name="CrateSodaCans", min=0, max=99, weightChance=60},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CratePopcorn", min=0, max=99, weightChance=100},
				{name="CrateSodaBottles", min=0, max=99, weightChance=40},
				{name="CrateSodaCans", min=0, max=99, weightChance=60},
			}
		},
	},
	
	theatrestorage = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CratePopcorn", min=0, max=99, weightChance=100},
				{name="CrateSodaBottles", min=0, max=99, weightChance=40},
				{name="CrateSodaCans", min=0, max=99, weightChance=60},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CratePopcorn", min=0, max=99, weightChance=100},
				{name="CrateSodaBottles", min=0, max=99, weightChance=40},
				{name="CrateSodaCans", min=0, max=99, weightChance=60},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CratePopcorn", min=0, max=99, weightChance=100},
				{name="CrateSodaBottles", min=0, max=99, weightChance=40},
				{name="CrateSodaCans", min=0, max=99, weightChance=60},
			}
		},
	},
	
	throwgame = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="CarnivalPrizes", min=0, max=4, weightChance=100},
			}
		}
	},
	
	thundergas = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99, weightChance=80},
				{name="GasStorageMechanics", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_fossoil_01_10;location_shop_fossoil_01_11;location_shop_accessories_01_10;location_shop_accessories_01_11;location_shop_accessories_01_8;location_shop_accessories_01_9;location_shop_accessories_01_12;location_shop_accessories_01_13"},
				{name="StoreCounterBags", min=0, max=1, weightChance=20},
				{name="StoreCounterTobacco", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99, weightChance=80},
				{name="GasStorageMechanics", min=0, max=99, weightChance=100},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="FreezerIceCream", min=0, max=99, forceForTiles="appliances_refrigeration_01_20;appliances_refrigeration_01_21;appliances_refrigeration_01_38;appliances_refrigeration_01_39"},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeOther", min=1, max=99, weightChance=40},
				{name="FridgeSnacks", min=1, max=99, weightChance=100},
				{name="FridgeSoda", min=1, max=99, weightChance=100},
				{name="FridgeWater", min=1, max=99, weightChance=60},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99, weightChance=80},
				{name="GasStorageMechanics", min=0, max=99, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="GasStoreEmergency", min=1, max=1, weightChance=20},
				{name="GasStoreToiletries", min=0, max=1, weightChance=40},
				{name="GigamartCleaning", min=0, max=1, weightChance=20},
				{name="MovieRentalShelves", min=0, max=99, forceForTiles="location_entertainment_theatre_01_120;location_entertainment_theatre_01_121;location_entertainment_theatre_01_122;location_entertainment_theatre_01_123;location_entertainment_theatre_01_124;location_entertainment_theatre_01_125;location_entertainment_theatre_01_126;location_entertainment_theatre_01_127;location_entertainment_theatre_01_128;location_entertainment_theatre_01_129;location_entertainment_theatre_01_130;location_entertainment_theatre_01_131;location_entertainment_theatre_01_132;location_entertainment_theatre_01_133;location_entertainment_theatre_01_134;location_entertainment_theatre_01_135"},
				{name="StoreCounterTobacco", min=0, max=99, forceForTiles="location_shop_generic_01_28;location_shop_generic_01_29;location_shop_generic_01_30;location_shop_generic_01_31"},
				{name="StoreShelfCombo", min=0, max=99, forceForTiles="location_shop_generic_01_0;location_shop_generic_01_1"},
				{name="StoreShelfDrinks", min=0, max=99, weightChance=100},
				{name="StoreShelfMechanics", min=0, max=99, forceForTiles="location_shop_generic_01_3;location_shop_generic_01_4"},
				{name="StoreShelfMedical", min=0, max=1, weightChance=20},
				{name="StoreShelfSnacks", min=0, max=99, weightChance=100},
			}
		},
		shelvesmag = {
			procedural = true,
			procList = {
				{name="MagazineRackMaps", min=1, max=4, weightChance=40},
				{name="MagazineRackMixed", min=1, max=99, weightChance=100},
				{name="MagazineRackNewspaper", min=1, max=4, weightChance=40},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99, weightChance=80},
				{name="GasStorageMechanics", min=0, max=99, weightChance=100},
			}
		},
	},
	
	tobaccostorage = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateCigarettes", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="TobaccoStoreChew", min=0, max=99, weightChance=40},
				{name="TobaccoStoreCigarettes", min=0, max=99, weightChance=80},
				{name="TobaccoStoreCigarillos", min=0, max=99, weightChance=40},
			}
		},
	},
	
	tobaccostore = {
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
			}
		},
		displaycase = {
			procedural = true,
			procList = {
				{name="TobaccoStoreCigars", min=1, max=99, weightChance=100},
				{name="TobaccoStorePipes", min=1, max=99, weightChance=40},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="TobaccoStoreAccessories", min=0, max=99, forceForTiles="location_shop_generic_01_12;location_shop_generic_01_13;location_shop_generic_01_14;location_shop_generic_01_15"},
				{name="TobaccoStoreChew", min=1, max=2, weightChance=60},
				{name="TobaccoStoreCigarettes", min=1, max=4, weightChance=100},
				{name="TobaccoStoreCigarillos", min=1, max=2, weightChance=60},
			}
		},
	},
	
	toolstorestorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateClayBricks", min=0, max=1, weightChance=10},
				{name="CrateConcrete", min=0, max=2, weightChance=10},
				{name="CrateLongStick", min=0, max=2, weightChance=20},
				{name="CrateLumber", min=0, max=4, weightChance=40},
				{name="CratePlaster", min=0, max=4, weightChance=20},
				{name="CrateSheetMetal", min=0, max=4, weightChance=20},
				{name="CrateWallFinish", min=0, max=4, weightChance=20},
				{name="ToolStoreAccessories", min=0, max=12, weightChance=100},
				{name="ToolStoreCarpentry", min=0, max=99, weightChance=100},
				{name="ToolStoreFarming", min=0, max=99, weightChance=80},
				{name="ToolStoreMetalwork", min=0, max=99, weightChance=100},
				{name="ToolStoreMisc", min=0, max=12, weightChance=80},
				{name="ToolStoreOutfit", min=0, max=12, weightChance=80},
				{name="ToolStoreTools", min=0, max=12, weightChance=80},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateClayBricks", min=0, max=1, weightChance=10},
				{name="CrateConcrete", min=0, max=2, weightChance=10},
				{name="CrateLongStick", min=0, max=2, weightChance=20},
				{name="CrateLumber", min=0, max=4, weightChance=40},
				{name="CratePlaster", min=0, max=4, weightChance=20},
				{name="CrateSheetMetal", min=0, max=4, weightChance=20},
				{name="CrateWallFinish", min=0, max=4, weightChance=20},
				{name="ToolStoreAccessories", min=0, max=12, weightChance=100},
				{name="ToolStoreCarpentry", min=0, max=99, weightChance=100},
				{name="ToolStoreFarming", min=0, max=99, weightChance=80},
				{name="ToolStoreMetalwork", min=0, max=99, weightChance=100},
				{name="ToolStoreMisc", min=0, max=12, weightChance=80},
				{name="ToolStoreOutfit", min=0, max=12, weightChance=80},
				{name="ToolStoreTools", min=0, max=12, weightChance=80},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateClayBricks", min=0, max=1, weightChance=10},
				{name="CrateConcrete", min=0, max=2, weightChance=10},
				{name="CrateLongStick", min=0, max=2, weightChance=20},
				{name="CrateLumber", min=0, max=4, weightChance=40},
				{name="CratePlaster", min=0, max=4, weightChance=20},
				{name="CrateSheetMetal", min=0, max=4, weightChance=20},
				{name="CrateWallFinish", min=0, max=4, weightChance=20},
				{name="ToolStoreAccessories", min=0, max=12, weightChance=100},
				{name="ToolStoreCarpentry", min=0, max=99, weightChance=100},
				{name="ToolStoreFarming", min=0, max=99, weightChance=80},
				{name="ToolStoreMetalwork", min=0, max=99, weightChance=100},
				{name="ToolStoreMisc", min=0, max=12, weightChance=80},
				{name="ToolStoreOutfit", min=0, max=12, weightChance=80},
				{name="ToolStoreTools", min=0, max=12, weightChance=80},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="ToolStoreAccessories", min=0, max=12, weightChance=100},
				{name="ToolStoreMisc", min=0, max=99, weightChance=100},
				{name="ToolStoreOutfit", min=0, max=12, weightChance=80},
				{name="ToolStoreTools", min=0, max=99, weightChance=20},
			}
		},
	},
	
	toolstore = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateClayBricks", min=0, max=1, weightChance=10},
				{name="CrateConcrete", min=0, max=2, weightChance=10},
				{name="CrateLongStick", min=0, max=2, weightChance=20},
				{name="CrateLumber", min=0, max=4, weightChance=40},
				{name="CratePlaster", min=0, max=4, weightChance=20},
				{name="CrateSheetMetal", min=0, max=4, weightChance=20},
				{name="CrateWallFinish", min=0, max=4, weightChance=20},
				{name="ToolStoreAccessories", min=0, max=12, weightChance=100},
				{name="ToolStoreCarpentry", min=0, max=99, weightChance=100},
				{name="ToolStoreFarming", min=0, max=99, weightChance=80},
				{name="ToolStoreMetalwork", min=0, max=99, weightChance=100},
				{name="ToolStoreMisc", min=0, max=12, weightChance=80},
				{name="ToolStoreOutfit", min=0, max=12, weightChance=80},
				{name="ToolStoreTools", min=0, max=12, weightChance=80},
			}
		},
		clothingrack = {
			procedural = true,
			procList = {
				{name="ToolStoreOutfit", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="ToolStoreTools", min=0, max=1, weightChance=10},
				{name="ToolStoreFootwear", min=0, max=2, weightChance=20},
				{name="ToolStoreBooks", min=0, max=2, weightChance=40},
				{name="ToolStoreAccessories", min=0, max=2, weightChance=80},
				{name="ToolStoreKeymaking", min=1, max=1, weightChance=100},
				{name="ToolStoreMisc", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateClayBricks", min=0, max=1, weightChance=10},
				{name="CrateConcrete", min=0, max=2, weightChance=10},
				{name="CrateLongStick", min=0, max=2, weightChance=20},
				{name="CrateLumber", min=0, max=4, weightChance=40},
				{name="CratePlaster", min=0, max=4, weightChance=20},
				{name="CrateSheetMetal", min=0, max=4, weightChance=20},
				{name="CrateWallFinish", min=0, max=4, weightChance=20},
				{name="ToolStoreAccessories", min=0, max=12, weightChance=100},
				{name="ToolStoreCarpentry", min=0, max=4, weightChance=40},
				{name="ToolStoreFarming", min=0, max=4, weightChance=40},
				{name="ToolStoreMetalwork", min=0, max=4, weightChance=40},
				{name="ToolStoreOutfit", min=0, max=2, weightChance=60},
				{name="ToolStoreHandles", min=0, max=2, weightChance=80},
				{name="ToolStoreTools", min=0, max=99, weightChance=80},
			}
		},
		locker = {
			rolls = 1,
			items = {
				
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateClayBricks", min=0, max=1, weightChance=10},
				{name="CrateConcrete", min=0, max=2, weightChance=10},
				{name="CrateLongStick", min=0, max=2, weightChance=20},
				{name="CrateLumber", min=0, max=4, weightChance=40},
				{name="CratePlaster", min=0, max=4, weightChance=20},
				{name="CrateSheetMetal", min=0, max=4, weightChance=20},
				{name="CrateWallFinish", min=0, max=4, weightChance=20},
				{name="ToolStoreCarpentry", min=0, max=4, weightChance=40},
				{name="ToolStoreFarming", min=0, max=4, weightChance=40},
				{name="ToolStoreMetalwork", min=0, max=4, weightChance=40},
				{name="ToolStoreOutfit", min=0, max=2, weightChance=60},
				{name="ToolStoreHandles", min=0, max=2, weightChance=80},
				{name="ToolStoreTools", min=0, max=99, weightChance=80},
				{name="ToolStoreMisc", min=0, max=99, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="FishingStoreGear", min=0, max=99, weightChance=10},
				{name="StoreShelfCombo", min=0, max=99, forceForTiles="location_shop_generic_01_0;location_shop_generic_01_1"},
				{name="ToolStoreBooks", min=0, max=99, forceForTiles="furniture_shelving_01_40;furniture_shelving_01_41;furniture_shelving_01_42;furniture_shelving_01_43"},
				{name="ToolStoreCarpentry", min=1, max=4, weightChance=40},
				{name="ToolStoreFarming", min=1, max=4, weightChance=40},
				{name="ToolStoreMetalwork", min=1, max=4, weightChance=40},
				{name="ToolStoreOutfit", min=1, max=2, weightChance=60},
				{name="ToolStoreHandles", min=1, max=2, weightChance=80},
				{name="ToolStoreTools", min=1, max=99, weightChance=80},
				{name="ToolStoreMisc", min=1, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="ToolStoreAccessories", min=0, max=12, weightChance=100},
				{name="ToolStoreMisc", min=0, max=99, weightChance=100},
				{name="ToolStoreOutfit", min=0, max=12, weightChance=80},
				{name="ToolStoreTools", min=0, max=99, weightChance=20},
			}
		},
		toolcabinet = {
			rolls = 1,
			items = {
				
			}
		},
	},
	
	toystore = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="GiftStoreCards", min=1, max=4, weightChance=40},
				{name="GiftStoreFancy", min=1, max=2, weightChance=20},
				{name="GiftStoreToys", min=1, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="GiftStoreFancy", min=1, max=2, weightChance=20},
				{name="GiftStoreToys", min=0, max=99, weightChance=100},
				{name="StoreCounterBagsFancy", min=0, max=1, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="GiftStoreCards", min=1, max=4, weightChance=40},
				{name="GiftStoreFancy", min=1, max=2, weightChance=20},
				{name="GiftStoreToys", min=1, max=99, weightChance=100},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeSnacks", min=1, max=99, weightChance=100},
				{name="FridgeSoda", min=1, max=2, weightChance=40},
				{name="FridgeWater", min=1, max=2, weightChance=40},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="GiftStoreCards", min=1, max=4, weightChance=40},
				{name="GiftStoreFancy", min=1, max=2, weightChance=20},
				{name="GiftStoreToys", min=1, max=99, weightChance=100},
				{name="StoreShelfCombo", min=0, max=99, forceForTiles="location_shop_generic_01_0;location_shop_generic_01_1"},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="GiftStoreCards", min=1, max=4, weightChance=40},
				{name="GiftStoreFancy", min=1, max=2, weightChance=20},
				{name="GiftStoreToys", min=1, max=99, weightChance=100},
			}
		},
	},
	
	toystorestorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="GiftStoreCards", min=1, max=4, weightChance=40},
				{name="GiftStoreFancy", min=1, max=2, weightChance=20},
				{name="GiftStoreToys", min=1, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="GiftStoreCards", min=1, max=4, weightChance=40},
				{name="GiftStoreFancy", min=1, max=2, weightChance=20},
				{name="GiftStoreToys", min=1, max=99, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="GiftStoreCards", min=1, max=4, weightChance=40},
				{name="GiftStoreFancy", min=1, max=2, weightChance=20},
				{name="GiftStoreToys", min=1, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="GiftStoreCards", min=1, max=4, weightChance=40},
				{name="GiftStoreFancy", min=1, max=2, weightChance=20},
				{name="GiftStoreToys", min=1, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="GiftStoreCards", min=1, max=4, weightChance=40},
				{name="GiftStoreFancy", min=1, max=2, weightChance=20},
				{name="GiftStoreToys", min=1, max=99, weightChance=100},
			}
		},
	},
	
	universitylibrary = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="UniversityLibraryBooks", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="LibraryCounter", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="UniversityLibraryBooks", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="UniversityLibraryArt", min=0, max=1, weightChance=40},
				{name="UniversityLibraryBiography", min=0, max=1, weightChance=40},
				{name="UniversityLibraryBooks", min=2, max=99, weightChance=20},
				{name="UniversityLibraryBusiness", min=0, max=1, weightChance=20},
				{name="UniversityLibraryCinema", min=0, max=1, weightChance=20},
				{name="UniversityLibraryComputer", min=0, max=1, weightChance=20},
				{name="UniversityLibraryGeneralReference", min=0, max=1, weightChance=80},
				{name="UniversityLibraryHistory", min=0, max=1, weightChance=80},
				{name="UniversityLibraryLegal", min=0, max=1, weightChance=20},
				{name="UniversityLibraryMagazines", min=2, max=99, weightChance=20},
				{name="UniversityLibraryMedical", min=0, max=1, weightChance=100},
				{name="UniversityLibraryMilitaryHistory", min=0, max=1, weightChance=20},
				{name="UniversityLibraryMusic", min=0, max=1, weightChance=60},
				{name="UniversityLibraryPhilosophy", min=0, max=1, weightChance=80},
				{name="UniversityLibraryPolitics", min=0, max=1, weightChance=80},
				{name="UniversityLibraryScience", min=0, max=1, weightChance=80},
				{name="UniversityLibrarySports", min=0, max=1, weightChance=40},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="UniversityLibraryBooks", min=0, max=99},
			}
		},
	},
	
	universitystorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="UniversityStorageAnthropology", min=0, max=4, weightChance=40},
				{name="UniversityStorageScience", min=0, max=4, weightChance=80},
				{name="UniversityLibraryBooks", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				
			}
		},
		crate = {
			procedural = true,
			procList = {
				
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				
			}
		},
	},
	
	vacated = {
		-- Empty storefront, not abandoned/derelict property.
		other = {
			rolls = 1,
			items = {
				
			}
		},
	},
	
	viplounge = {
		counter = {
			procedural = true,
			procList = {
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				
			}
		},
		dishescabinet = {
			procedural = true,
			procList = {
				{name="DishCabinetVIPLounge", min=0, max=99, weightChance=100},
			}
		},
		restaurantdisplay = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="ServingTrayChickenWings", min=0, max=1, weightChance=10},
				{name="ServingTrayLobster", min=0, max=1, weightChance=10},
				{name="ServingTrayMaki", min=0, max=1, weightChance=10},
				{name="ServingTrayMeatDumplings", min=0, max=1, weightChance=10},
				{name="ServingTrayMeatSteamBuns", min=0, max=1, weightChance=10},
				{name="ServingTrayMussels", min=0, max=1, weightChance=10},
				{name="ServingTrayOnigiri", min=0, max=1, weightChance=10},
				{name="ServingTrayOysters", min=0, max=1, weightChance=10},
				{name="ServingTrayShrimp", min=0, max=1, weightChance=10},
				{name="ServingTraySpringRolls", min=0, max=1, weightChance=10},
				{name="ServingTraySteak", min=0, max=1, weightChance=10},
				{name="ServingTraySushiEgg", min=0, max=1, weightChance=10},
				{name="ServingTraySushiFish", min=0, max=1, weightChance=10},
			}
		},
	},
	
	waitingroom = {
		desk = {
			procedural = true,
			procList = {
				{name="WaitingRoomDesk", min=0, max=99},
			}
		},
		medicine = {
			procedural = true,
			procList = {
				{name="MedicalCabinet", min=0, max=99},
			}
		},
	},
	
	walletshop = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateWallets", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreCounterBagsFancy", min=0, max=1, weightChance=100},
			}
		},
		clothingrack = {
			procedural = true,
			procList = {
				{name="CrateWallets", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateWallets", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateLeather", min=0, max=99},
			}
		},
		toolcabinet = {
			procedural = true,
			procList = {
				{name="CrateLeather", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateWallets", min=0, max=99},
			}
		},
	},
	
	warehouse = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateCarpentry", min=0, max=99, weightChance=100},
				{name="CrateClayBricks", min=0, max=1, weightChance=10},
				{name="CrateConcrete", min=0, max=99, weightChance=10},
				{name="CrateFarming", min=0, max=99, weightChance=60},
				{name="CrateGravelBags", min=0, max=99, weightChance=20},
				{name="CrateLumber", min=0, max=99, weightChance=40},
				{name="CrateMetalwork", min=0, max=99, weightChance=100},
				{name="CratePaint", min=0, max=99, weightChance=40},
				{name="CratePlaster", min=0, max=99, weightChance=20},
				{name="CrateSandBags", min=0, max=99, weightChance=40},
				{name="CrateSheetMetal", min=0, max=99, weightChance=20},
				{name="CrateTools", min=0, max=99, weightChance=100},
				{name="CrateWallFinish", min=0, max=99, weightChance=40},
			}
		},
		counter = {
			rolls = 1,
			items = {
				
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateAntiqueStove", min=0, max=1, weightChance=5},
				{name="CrateCarpentry", min=0, max=99, weightChance=100},
				{name="CrateClayBricks", min=0, max=1, weightChance=10},
				{name="CrateConcrete", min=0, max=99, weightChance=10},
				{name="CrateFarming", min=0, max=99, weightChance=60},
				{name="CrateGravelBags", min=0, max=99, weightChance=20},
				{name="CrateLumber", min=0, max=99, weightChance=40},
				{name="CrateMetalwork", min=0, max=99, weightChance=100},
				{name="CratePaint", min=0, max=99, weightChance=40},
				{name="CratePlaster", min=0, max=99, weightChance=20},
				{name="CrateSandBags", min=0, max=99, weightChance=40},
				{name="CrateSheetMetal", min=0, max=99, weightChance=20},
				{name="CrateTools", min=0, max=99, weightChance=100},
				{name="CrateWallFinish", min=0, max=99, weightChance=40},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateCarpentry", min=0, max=99, weightChance=100},
				{name="CrateFarming", min=0, max=99, weightChance=60},
				{name="CrateMetalwork", min=0, max=99, weightChance=100},
				{name="CratePaint", min=0, max=99, weightChance=40},
				{name="CrateSheetMetal", min=0, max=99, weightChance=20},
				{name="CrateTools", min=0, max=99, weightChance=100},
				{name="CrateWallFinish", min=0, max=99, weightChance=40},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateCarpentry", min=0, max=99, weightChance=100},
				{name="CrateFarming", min=0, max=99, weightChance=60},
				{name="CrateMetalwork", min=0, max=99, weightChance=100},
				{name="CratePaint", min=0, max=99, weightChance=40},
				{name="CrateSheetMetal", min=0, max=99, weightChance=20},
				{name="CrateTools", min=0, max=99, weightChance=100},
				{name="CrateWallFinish", min=0, max=99, weightChance=40},
			}
		},
	},
	
	weddingstoredress = {
		isShop = true,
		clothingrack = {
			procedural = true,
			procList = {
				{name="WeddingStoreDresses", min=0, max=99},
			}
		},
	},
	
	weddingstorestorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="WeddingStoreSuits", min=0, max=99, weightChance=40},
				{name="WeddingStoreDresses", min=0, max=99, weightChance=100},
			}
		},
		clothingrack = {
			procedural = true,
			procList = {
				{name="WeddingStoreDresses", min=0, max=99},
			}
		},
	},
	
	weddingstoresuit = {
		isShop = true,
		clothingrack = {
			procedural = true,
			procList = {
				{name="WeddingStoreSuits", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="StoreCounterBagsFancy", min=0, max=1, weightChance=100},
			}
		},
	},
	
	weldingstorage = {
		isShop = true,
		metal_shelves = {
			procedural = true,
			procList = {
				{name="WeldingWorkshopFuel", min=0, max=1, weightChance=60},
				{name="WeldingWorkshopMetal", min=0, max=99, weightChance=100},
			}
		},
	},
	
	weldingworkshop = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="WeldingWorkshopTools", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="WeldingWorkshopFuel", min=1, max=4, weightChance=20},
				{name="WeldingWorkshopMetal", min=0, max=99, weightChance=100},
			}
		},
		toolcabinet = {
			procedural = true,
			procList = {
				{name="WeldingWorkshopTools", min=0, max=99},
			}
		},
	},
	
	westerndining = {
		isShop = true,
		woodstove = {
			rolls = 1,
			items = {
				
			}
		},
	},
	
	westernkitchen = {
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CrateFlour", min=0, max=1, weightChance=40},
				{name="CrateCornflour", min=0, max=1, weightChance=40},
				{name="CrateCondiments", min=0, max=1, weightChance=80},
				{name="ButcherSpices", min=0, max=1, weightChance=100},
				{name="FryFactoryPotatoes", min=0, max=1, weightChance=60},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreKitchenCleaning", min=0, max=99, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="StoreKitchenCutlery", min=0, max=99, weightChance=20},
				{name="StoreKitchenDishes", min=0, max=99, weightChance=20},
				{name="StoreKitchenGlasses", min=0, max=99, weightChance=20},
				{name="StoreKitchenPotatoes", min=0, max=1, weightChance=100},
				{name="StoreKitchenPots", min=0, max=99, weightChance=20},
				{name="WesternKitchenBaking", min=0, max=1, weightChance=100},
				{name="WesternKitchenButcher", min=1, max=1, weightChance=100},
				{name="WesternKitchenSauce", min=0, max=1, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CrateFlour", min=0, max=1, weightChance=40},
				{name="CrateCornflour", min=0, max=1, weightChance=40},
				{name="CrateCondiments", min=0, max=1, weightChance=80},
				{name="ButcherSpices", min=0, max=1, weightChance=100},
				{name="FryFactoryPotatoes", min=0, max=1, weightChance=60},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="WesternKitchenFreezer", min=0, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="WesternKitchenFridge", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateFlour", min=0, max=1, weightChance=40},
				{name="CrateCornflour", min=0, max=1, weightChance=40},
				{name="CrateCondiments", min=0, max=1, weightChance=80},
				{name="ButcherSpices", min=0, max=1, weightChance=100},
				{name="FryFactoryPotatoes", min=0, max=1, weightChance=60},
			}
		},
		restaurantdisplay = {
			cookFood = true,
			procedural = true,
			procList = {
				{name="ServingTrayBiscuits", min=1, max=2, weightChance=80},
				{name="ServingTrayCornbread", min=1, max=2, weightChance=80},
				{name="ServingTrayFries", min=1, max=1, weightChance=40},
				{name="ServingTrayGravy", min=1, max=1, weightChance=20},
				{name="ServingTrayOnionRings", min=1, max=1, weightChance=40},
				{name="ServingTraySteak", min=1, max=4, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CrateFlour", min=0, max=1, weightChance=40},
				{name="CrateCornflour", min=0, max=1, weightChance=40},
				{name="CrateCondiments", min=0, max=1, weightChance=80},
				{name="ButcherSpices", min=0, max=1, weightChance=100},
				{name="FryFactoryPotatoes", min=0, max=1, weightChance=60},
			}
		},
	},
	
	whiskeybottling = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="WhiskeyBottlingEmpty", min=0, max=99, weightChance=80},
				{name="WhiskeyBottlingFull", min=0, max=99, weightChance=100},
			},
		},
		counter = {
			rolls = 1,
			items = {
				
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="WhiskeyBottlingEmpty", min=0, max=99, weightChance=80},
				{name="WhiskeyBottlingFull", min=0, max=99, weightChance=100},
			},
		},
		clothingdryerbasic = {
			procedural = true,
			procList = {
				{name="WhiskeyBottlingEmpty", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="WhiskeyBottlingEmpty", min=0, max=99, weightChance=80},
				{name="WhiskeyBottlingFull", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="WhiskeyBottlingEmpty", min=0, max=99, weightChance=80},
				{name="WhiskeyBottlingFull", min=0, max=99, weightChance=100},
			},
		},
	},
	
	wirefactory = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="WireFactoryBarbed", min=0, max=99, weightChance=20},
				{name="WireFactoryBasic", min=0, max=99, weightChance=40},
				{name="WireFactoryElectric", min=0, max=99, weightChance=20},
				{name="ToolFactoryBarStock", min=0, max=99, weightChance=100},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="WireFactoryTools", min=0, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="WireFactoryBarbed", min=0, max=99, weightChance=20},
				{name="WireFactoryBasic", min=0, max=99, weightChance=40},
				{name="WireFactoryElectric", min=0, max=99, weightChance=20},
				{name="ToolFactoryBarStock", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="WireFactoryBarbed", min=0, max=99, weightChance=20},
				{name="WireFactoryBasic", min=0, max=99, weightChance=40},
				{name="WireFactoryElectric", min=0, max=99, weightChance=20},
				{name="WireFactoryTools", min=0, max=99, weightChance=100},
				{name="ToolFactoryBarStock", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="WireFactoryBarbed", min=0, max=99, weightChance=40},
				{name="WireFactoryBasic", min=0, max=99, weightChance=80},
				{name="WireFactoryElectric", min=0, max=99, weightChance=40},
			}
		},
	},
	
	woodcraftset = {
		counter = {
			procedural = true,
			procList = {
				{name="WoodcraftDudeCounter", min=1, max=1, weightChance=100},
				{name="CrateCarpentry", min=0, max=4, weightChance=20},
				{name="Empty", min=0, max=99, weightChance=100},
			}
		},
		woodstove = {
			rolls = 1,
			items = {
				
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CrateCarpentry", min=1, max=1, weightChance=100},
				{name="CrateLumber", min=1, max=1, weightChance=100},
			}
		},
		shelves = {
			rolls = 1,
			items = {
				
			}
		},
	},
	
	ww_bar = {
		counter = {
			procedural = true,
			procList = {
				{name="WildWestBarCounter", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="WildWestBarShelf", min=0, max=99},
			}
		},
		woodstove = {
			procedural = true,
			procList = {
				{name="WildWestWoodStove", min=0, max=99},
			}
		},
	},
	
	ww_aesthetic = {
		counter = {
			procedural = true,
			procList = {
				{name="WildWestBarberCounter", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="WildWestBarberShelves", min=0, max=99},
			}
		},
	},
	
	ww_bedroom = {
		dresser = {
			procedural = true,
			procList = {
				{name="WildWestBedroom", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="WildWestShelves", min=0, max=99},
			}
		},
		sidetable = {
			procedural = true,
			procList = {
				{name="WildWestBedroom", min=0, max=99},
			}
		},
		wardrobe = {
			procedural = true,
			procList = {
				{name="WildWestBedroom", min=0, max=99},
			}
		},
	},
	
	ww_blacksmith = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="WildWestBlacksmith", min=0, max=4, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="WildWestSouveniers", min=0, max=99},
			}
		},
	},
	
	ww_generalstore = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="Empty", min=0, max=99, weightChance=100},
			}
		},
		grocerstand = {
			procedural = true,
			procList = {
				{name="Empty", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="WildWestGeneralStore", min=0, max=99},
			}
		},
	},
	
	ww_hall = {
		shelves = {
			procedural = true,
			procList = {
				{name="WildWestShelves", min=0, max=99},
			}
		},
	},
	
	ww_kitchen = {
		counter = {
			procedural = true,
			procList = {
				{name="WildWestKitchen", min=0, max=99},
			}
		},
		overhead = {
			procedural = true,
			procList = {
				{name="WildWestKitchen", min=0, max=99},
			}
		},
		woodstove = {
			procedural = true,
			procList = {
				{name="WildWestWoodStove", min=0, max=99},
			}
		},
	},
	
	ww_livingroom = {
		fireplace = {
			procedural = true,
			procList = {
				{name="WildWestWoodStove", min=0, max=99},
			}
		},
		locker = {
			procedural = true,
			procList = {
				{name="WildWestBedroom", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="WildWestLivingRoom", min=0, max=99},
			}
		},
		sidetable = {
			procedural = true,
			procList = {
				{name="WildWestLivingRoom", min=0, max=99},
			}
		},
		woodstove = {
			procedural = true,
			procList = {
				{name="WildWestWoodStove", min=0, max=99},
			}
		},
	},
	
	ww_sheriff = {
		desk = {
			procedural = true,
			procList = {
				{name="WildWestSheriffDesk", min=0, max=99},
			}
		},
		locker = {
			procedural = true,
			procList = {
				{name="WildWestSheriffLocker", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="WildWestShelves", min=0, max=99},
			}
		},
		woodstove = {
			procedural = true,
			procList = {
				{name="WildWestWoodStove", min=0, max=1, weightChance=20},
				{name="Empty", min=0, max=99, weightChance=100},
			}
		},
	},
	
	ww_toolstore = {
		isShop = true,
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="WildWestBlacksmith", min=0, max=4, weightChance=20},
				{name="Empty", min=0, max=99, weightChance=100},
			}
		},
		clothingrack = {
			procedural = true,
			procList = {
				{name="WildWestClothing", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="WildWestSouveniers", min=0, max=99},
			}
		},
	},
	
	zippeestorage = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="JanitorChemicals", min=0, max=99, weightChance=100},
				{name="JanitorCleaning", min=0, max=1, forceForTiles="fixtures_sinks_01_0;fixtures_sinks_01_1;fixtures_sinks_01_2;fixtures_sinks_01_3;fixtures_sinks_01_4;fixtures_sinks_01_5;fixtures_sinks_01_6;fixtures_sinks_01_7;fixtures_sinks_01_8;fixtures_sinks_01_9;fixtures_sinks_01_10;fixtures_sinks_01_11;fixtures_sinks_01_16;fixtures_sinks_01_17;fixtures_sinks_01_18;fixtures_sinks_01_19"},
				{name="JanitorMisc", min=1, max=1, weightChance=100},
				{name="JanitorTools", min=0, max=1, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99},
			}
		},
	},
	
	zippeestore = {
		isShop = true,
		cardboardbox = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99},
			}
		},
		clothingrack = {
			procedural = true,
			procList = {
				{name="ZippeeClothing", min=0, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="StoreCounterCleaning", min=0, max=99, forceForTiles="location_shop_accessories_01_0;location_shop_accessories_01_1;location_shop_accessories_01_2;location_shop_accessories_01_3;location_shop_accessories_01_20;location_shop_accessories_01_21;location_shop_accessories_01_22;location_shop_accessories_01_23"},
				{name="Empty", min=0, max=99, forceForTiles="location_shop_accessories_01_8;location_shop_accessories_01_9;location_shop_accessories_01_10;location_shop_accessories_01_11;location_shop_accessories_01_11;location_shop_accessories_01_12;location_shop_fossoil_01_10;location_shop_fossoil_01_11;"},
				{name="StoreCounterBags", min=0, max=2, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="FreezerIceCream", min=0, max=99, forceForTiles="appliances_refrigeration_01_20;appliances_refrigeration_01_21;appliances_refrigeration_01_38;appliances_refrigeration_01_39"},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="FridgeOther", min=1, max=99, weightChance=40},
				{name="FridgeSnacks", min=1, max=99, weightChance=100},
				{name="FridgeSoda", min=1, max=99, weightChance=100},
				{name="FridgeWater", min=1, max=99, weightChance=60},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="GasStoreToiletries", min=1, max=1, weightChance=100},
				{name="GigamartCleaning", min=0, max=1, weightChance=20},
				{name="MovieRentalShelves", min=0, max=99, forceForTiles="location_entertainment_theatre_01_120;location_entertainment_theatre_01_121;location_entertainment_theatre_01_122;location_entertainment_theatre_01_123;location_entertainment_theatre_01_124;location_entertainment_theatre_01_125;location_entertainment_theatre_01_126;location_entertainment_theatre_01_127;location_entertainment_theatre_01_128;location_entertainment_theatre_01_129;location_entertainment_theatre_01_130;location_entertainment_theatre_01_131;location_entertainment_theatre_01_132;location_entertainment_theatre_01_133;location_entertainment_theatre_01_134;location_entertainment_theatre_01_135"},
				{name="StoreCounterTobacco", min=0, max=99, forceForTiles="location_shop_zippee_01_0;location_shop_zippee_01_1;location_shop_zippee_01_2;location_shop_zippee_01_3"},
				{name="StoreShelfCombo", min=0, max=99, forceForTiles="location_shop_generic_01_0;location_shop_generic_01_1"},
				{name="StoreShelfDrinks", min=0, max=99, weightChance=100},
				{name="StoreShelfMechanics", min=0, max=99, forceForTiles="location_shop_zippee_01_4;location_shop_zippee_01_5"},
				{name="StoreShelfMedical", min=0, max=1, weightChance=20},
				{name="StoreShelfSnacks", min=0, max=99, weightChance=100},
			}
		},
		shelvesmag = {
			procedural = true,
			procList = {
				{name="MagazineRackMaps", min=1, max=4, weightChance=40},
				{name="MagazineRackMixed", min=1, max=99, weightChance=100},
				{name="MagazineRackNewspaper", min=1, max=4, weightChance=40},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="GasStorageCombo", min=0, max=99},
			}
		},
	},
	
	-- =====================
	--	BAGS/CONTAINERS
	-- =====================

	-- Chest straps with assorted ammunition types.
	AmmoStrap_Bullets = {
		rolls = 4,
		items = {
			"556Bullets", 50,
			"556Bullets", 20,
			"556Bullets", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	AmmoStrap_Bullets_223 = {
		rolls = 4,
		items = {
			"223Bullets", 50,
			"223Bullets", 20,
			"223Bullets", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	AmmoStrap_Bullets_308 = {
		rolls = 4,
		items = {
			"308Bullets", 50,
			"308Bullets", 20,
			"308Bullets", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	AmmoStrap_Bullets_38 = {
		rolls = 4,
		items = {
			"Bullets38", 50,
			"Bullets38", 20,
			"Bullets38", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	AmmoStrap_Bullets_44 = {
		rolls = 4,
		items = {
			"Bullets44", 50,
			"Bullets44", 20,
			"Bullets44", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	AmmoStrap_Bullets_45 = {
		rolls = 4,
		items = {
			"Bullets45", 50,
			"Bullets45", 20,
			"Bullets45", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	AmmoStrap_Bullets_9mm = {
		rolls = 4,
		items = {
			"Bullets9mm", 50,
			"Bullets9mm", 20,
			"Bullets9mm", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	AmmoStrap_Shells = {
		rolls = 4,
		items = {
			"ShotgunShells", 50,
			"ShotgunShells", 20,
			"ShotgunShells", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	-- Generic large backpack. Hiker-oriented.
	Bag_ALICEpack = {
		rolls = 1,
		items = {
			-- Snacks/Drinks
			"BeefJerky", 4,
			"Chocolate", 2,
			"Crisps", 1,
			"DehydratedMeatStick", 4,
			"GranolaBar", 8,
			"Gum", 10,
			"Peanuts", 2,
			"SunflowerSeeds", 2,
			"Sportsbottle", 1,
			-- Tobacco/Smoking
			"CigarettePack", 1,
			"Lighter", 0.5,
			"LighterDisposable", 1,
			"Matches", 4,
			"TobaccoChewing", 1,
			-- Survival Gear
			"Canteen", 1,
			"CompassDirectional", 8,
			"KnifePocket", 0.5,
			"MetalCup", 1,
			"Multitool", 0.5,
			"P38", 1,
			"Spork", 4,
			"WaterPurificationTablets", 1,
			"Whistle", 4,
			-- Clothing
			"Hat_Bandana", 2,
			"Hat_BandanaTINT", 2,
			"HoodieDOWN_WhiteTINT", 1,
			"PonchoYellowDOWN", 4,
			"ShemaghScarf_Green", 0.1,
			"Socks_Heavy", 2,
			-- Electronics/Music
			"Battery", 1,
			"CDplayer", 1,
			"Disc_Retail", 2,
			"Earbuds", 1,
			-- Medical
			"AlcoholWipes", 4,
			"Bandage", 2,
			"Bandaid", 8,
			"FirstAidKit_Camping", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	Bag_ALICEpack_Army = BagsAndContainers.ALICEpack_Army,

	Bag_ALICEpack_DesertCamo = BagsAndContainers.ALICEpack_Army,

	Bag_ALICE_BeltSus = BagsAndContainers.ALICE_BeltSus,

	-- Metal ammo cans. Used by the army and gun enthusiasts.
	Bag_AmmoBox = {
		rolls = 4,
		items = {
			"556Box", 50,
			"556Box", 20,
			"556Box", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_AmmoBox_223 = {
		rolls = 4,
		items = {
			"223Box", 50,
			"223Box", 20,
			"223Box", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_AmmoBox_308 = {
		rolls = 4,
		items = {
			"308Box", 50,
			"308Box", 20,
			"308Box", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_AmmoBox_38 = {
		rolls = 4,
		items = {
			"Bullets38Box", 50,
			"Bullets38Box", 20,
			"Bullets38Box", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_AmmoBox_44 = {
		rolls = 4,
		items = {
			"Bullets44Box", 50,
			"Bullets44Box", 20,
			"Bullets44Box", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_AmmoBox_45 = {
		rolls = 4,
		items = {
			"Bullets45Box", 50,
			"Bullets45Box", 20,
			"Bullets45Box", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_AmmoBox_9mm = {
		rolls = 4,
		items = {
			"Bullets9mmBox", 50,
			"Bullets9mmBox", 20,
			"Bullets9mmBox", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_AmmoBox_Hunting = {
		rolls = 3,
		items = {
			"223Box", 20,
			"308Box", 20,
			"ShotgunShellsBox", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_AmmoBox_Mixed = {
		rolls = 2,
		items = {
			"223Box", 20,
			"308Box", 10,
			"556Box", 10,
			"Bullets38Box", 20,
			"Bullets44Box", 10,
			"Bullets45Box", 10,
			"Bullets9mmBox", 20,
			"ShotgunShellsBox", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_AmmoBox_ShotgunShells = {
		rolls = 4,
		items = {
			"ShotgunShellsBox", 50,
			"ShotgunShellsBox", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	-- Duffel bag for baseball players.
	Bag_BaseballBag = {
		rolls = 2,
		items = {
			-- Baseball Gear
			"AthleticCup", 20,
			"BaseballBat", 50,
			"BaseballBat", 20,
			"BaseballBat_Metal", 50,
			"BaseballBat_Metal", 20,
			"Baseball", 50,
			"Baseball", 50,
			"Baseball", 20,
			"Baseball", 20,
			"Gloves_FingerlessLeatherGloves", 20,
			"Hat_BaseballHelmet", 10,
			"ShinKneeGuard_L_Baseball", 10,
			"Shoes_TrainerTINT", 20,
			"Trousers_WhiteTEXTURE", 20,
			"Vest_CatcherVest", 10,
			"Whistle", 50,
			-- Snacks/Drinks
			"Flask", 1,
			"Gum", 50,
			"Gum", 50,
			"Gum", 20,
			"Gum", 20,
			"Sportsbottle", 50,
			"TobaccoChewing", 10,
			-- Stationery/Office
			"Clipboard", 20,
			"Notepad", 50,
			"Pencil", 50,
			"Pencil", 20,
			-- Misc.
			"BathTowel", 20,
			"Money", 20,
			"Money", 10,
			"Photo", 4,
			"Medal_Bronze", 1,
			"Medal_Gold", 0.01,
			"Medal_Silver", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	Bag_BigHikingBag = BagsAndContainers.HikingBag,

	Bag_BigHikingBag_Travel = BagsAndContainers.HikingBag,

	-- Gift basket for children.
	Bag_BirthdayBasket = {
		rolls = 1,
		items = {
			"Book_Childs", 10,
			"BorisBadger", 0.01,
			"Bricktoys", 10,
			"CardDeck", 10,
			"Card_Birthday", 80,
			"ComicBook", 20,
			"Crayons", 10,
			"Cube", 10,
			"Diary1", 20,
			"DiceBag", 4,
			"Disc_Retail", 20,
			"Doll", 10,
			"Earbuds", 20,
			"FluffyfootBunny", 0.01,
			"FreddyFox", 0.01,
			"FurbertSquirrel", 0.01,
			"Harmonica", 10,
			"Hat_Pirate", 4,
			"Hat_Wizard", 4,
			"Headphones", 20,
			"JacquesBeaver", 0.01,
			"MoleyMole", 0.01,
			"PancakeHedgehog", 0.01,
			"PanchoDog", 0.01,
			"Paperback_Childs", 20,
			"Plushabug", 0.01,
			"RPGmanual", 4,
			"Spiffo", 0.01,
			"ToyBear", 10,
			"ToyCar", 10,
			"VideoGame", 20,
			"WalkieTalkie1", 20,
			"Yoyo", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	-- Bag for bowling alley patrons.
	Bag_BowlingBallBag = {
		rolls = 2,
		items = {
			-- Bowling Gear
			"Gloves_FingerlessLeatherGloves", 20,
			"Shoes_Bowling", 50,
			"Shirt_Bowling_Blue", 4,
			"Shirt_Bowling_Brown", 4,
			"Shirt_Bowling_Green", 4,
			"Shirt_Bowling_LimeGreen", 4,
			"Shirt_Bowling_Pink", 4,
			"Shirt_Bowling_White", 4,
			-- Stationery/Office
			"Notepad", 50,
			"Pencil", 50,
			"Pencil", 20,
			-- Misc.
			"BathTowel", 20,
			"Money", 20,
			"Money", 10,
			"Photo", 4,
			"Medal_Bronze", 1,
			"Medal_Gold", 0.01,
			"Medal_Silver", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	-- Emergency supply bag for cars, in case of breakdown on the road.
	Bag_BreakdownBag = {
		rolls = 1,
		items = {
			-- Tools
			"Funnel", 50,
			"Jack", 20,
			"LugWrench", 50,
			"Screwdriver", 50,
			"TireIron", 50,
			"TirePump", 50,
			"Wrench", 50,
			-- Emergency Supplies
			"BatteryBox", 10,
			"CandleBox", 20,
			"FirstAidKit_Camping", 10,
			"Matchbox", 20,
			"PetrolCanEmpty", 20,
			"Sheet", 50,
			"ToiletPaper", 50,
			"Whistle", 50,
			-- Snacks/Drinks
			"BeefJerky", 20,
			"DehydratedMeatStick", 20,
			"GranolaBar", 20,
			"Plonkies", 20,
			"SunflowerSeeds", 20,
			"WaterBottle", 20,
			-- Lighting
			"HandTorch", 50,
			"Torch", 20,
			-- Materials
			"ElectricWire", 50,
			"Rope", 50,
			"RubberHose", 50,
			"Tarp", 20,
			-- Maps
			"LouisvilleMap1", 0.01,
			"LouisvilleMap2", 0.01,
			"LouisvilleMap3", 0.01,
			"LouisvilleMap4", 0.01,
			"LouisvilleMap5", 0.01,
			"LouisvilleMap6", 0.01,
			"LouisvilleMap7", 0.01,
			"LouisvilleMap8", 0.01,
			"LouisvilleMap9", 0.01,
			"MarchRidgeMap", 0.4,
			"MuldraughMap", 0.4,
			"RiversideMap", 0.4,
			"RosewoodMap", 0.4,
			"WestpointMap", 0.4,
			-- Literature (Recipes)
			"MechanicMag1", 4,
			"MechanicMag2", 4,
			"MechanicMag3", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	-- Various tools that are perfectly legal to own, officer. I swear!
	Bag_BurglarBag = {
		rolls = 1,
		items = {
			-- Tools
			"BallPeenHammer", 20,
			"BoltCutters", 20,
			"ClubHammer", 20,
			"Crowbar", 100,
			"HandAxe", 10,
			"Hammer", 20,
			"KnifeButterfly", 10,
			"Pliers", 20,
			"Saw", 50,
			"Screwdriver", 20,
			"SwitchKnife", 10,
			"WoodenMallet", 20,
			"Wrench", 20,
			-- Clothing
			"Gloves_LeatherGlovesBlack", 50,
			"Hat_BalaclavaFull", 50,
			"Hat_HalloweenMaskDevil", 0.05,
			"Hat_HalloweenMaskMonster", 0.05,
			"Hat_HalloweenMaskPumpkin", 0.05,
			"Hat_HalloweenMaskSkeleton", 0.05,
			"Hat_HalloweenMaskVampire", 0.05,
			"Hat_HalloweenMaskWitch", 0.05,
			-- Accessories
			"DuctTape", 50,
			"DuctTape", 20,
			"HolsterShoulder", 8,
			"Rope", 50,
			"Rope", 20,
			"Zipties", 20,
			-- Literature
			"ArmorMag3", 4,
			"ArmorMag7", 4,
			"EngineerMagazine2", 4,
			"ExplosiveSchematic", 10,
			"HempMag1", 10,
			"KeyMag1", 8,
			"TrickMag1", 8,
			"WeaponMag3", 4,
			"WeaponMag4", 4,
			"WeaponMag5", 4,
			-- Special
			"Bag_ProtectiveCaseSmall_KeyCutting", 10,
			"IDcard_Blank", 20,
			"IDcard_Blank", 10,
			"GemBag", 1,
			
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	-- Military chest rig.
	Bag_ChestRig = {
		rolls = 1,
		items = {
			
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	-- Duffel bag full of construction tools.
	Bag_ConstructionBag = {
		rolls = 1,
		items = {
			-- Tools
			"BallPeenHammer", 20,
			"CarpentryChisel", 10,
			"ClubHammer", 20,
			"Crowbar", 20,
			"HandAxe", 10,
			"Hammer", 50,
			"HandDrill", 20,
			"KnifePocket", 0.1,
			"PipeWrench", 20,
			"Pliers", 50,
			"Saw", 50,
			"Screwdriver", 50,
			"SheetMetalSnips", 20,
			"Shovel", 10,
			"Shovel2", 10,
			"Sledgehammer", 0.5,
			"Sledgehammer2", 0.5,
			"ViseGrips", 20,
			"WoodenMallet", 20,
			"Wrench", 50,
			-- Equipment
			"Glasses_SafetyGoggles", 50,
			"Hat_BuildersRespirator", 10,
			"Hat_DustMask", 50,
			"Hat_HardHat", 50,
			"RespiratorFilters", 10,
			-- Spare Handles
			"Handle", 10,
			"LongStick", 10,
			"SmallHandle", 10,
			"WoodenStick2", 10,
			-- Materials
			"DuctTape", 50,
			"DuctTape", 20,
			"Epoxy", 10,
			"FiberglassTape", 10,
			"NailsBox", 50,
			"NailsBox", 20,
			"RippedSheets", 50,
			"RippedSheets", 20,
			"Rope", 20,
			"ScrewsBox", 10,
			"Woodglue", 20,
			"Woodglue", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"MeasuringTape", 50,
			}
		}
	},

	-- Professional dancer's bag.
	Bag_Dancer = {
		rolls = 1,
		items = {
			-- Clothing
			"Bikini_Pattern01", 2,
			"Bikini_TINT", 2,
			"BoobTube", 1,
			"BoobTubeSmall", 1,
			"Bra_Strapless_AnimalPrint", 8,
			"Bra_Strapless_Black", 10,
			"Bra_Strapless_FrillyBlack", 4,
			"Bra_Strapless_FrillyPink", 4,
			"Bra_Strapless_RedSpots", 8,
			"Bra_Strapless_White", 10,
			"Bra_Straps_AnimalPrint", 8,
			"Bra_Straps_Black", 10,
			"Bra_Straps_FrillyBlack", 4,
			"Bra_Straps_FrillyPink", 4,
			"Bra_Straps_White", 10,
			"Corset", 2,
			"Corset_Black", 2,
			"FrillyUnderpants_Black", 4,
			"FrillyUnderpants_Pink", 4,
			"FrillyUnderpants_Red", 4,
			"Garter", 2,
			"Hat_BunnyEarsBlack", 4,
			"Hat_BunnyEarsWhite", 4,
			"Hat_Police", 4,
			"Shirt_CropTopNoArmTINT", 1,
			"Shirt_CropTopTINT", 1,
			"Shoes_Fancy", 1,
			"Shoes_Strapped", 1,
			"StockingsBlack", 4,
			"StockingsBlackSemiTrans", 4,
			"StockingsBlackTrans", 4,
			"StockingsWhite", 4,
			"TightsBlack", 4,
			"TightsBlackSemiTrans", 4,
			"TightsBlackTrans", 4,
			"TightsFishnets", 2,
			"Underpants_Black", 10,
			-- Cosmetic
			"Comb", 4,
			"HairDryer", 10,
			"Hairgel", 10,
			"HairIron", 10,
			"Hairspray2", 10,
			"Lipstick", 6,
			"MakeupEyeshadow", 6,
			"MakeupFoundation", 6,
			"Mirror", 8,
			"Perfume", 4,
			"Tweezers", 10,
			-- Tobacco/Smoking
			"CigarettePack", 20,
			"LighterDisposable", 10,
			"Matches", 10,
			-- Misc.
			"Gum", 50,
			"Gum", 50,
			"PillsVitamins", 20,
			"PillsVitamins", 10,
			"SodaCan", 50,
			"SodaCan", 20,
			-- Special
			"Card_Valentine", 10,
			"Diary1", 10,
			"KeyRing_Sexy", 10,
			"Locket", 10,
			"LetterHandwritten", 10,
			"Photo_Racy", 10,
			"Pillow_Heart", 0.01,
			"Postcard", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	-- I don't know what you were expecting?
	Bag_DeadMice = {
		rolls = 12,
		items = {
			"DeadMouse", 50,
			"DeadMouse", 20,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	Bag_DeadRats = {
		rolls = 8,
		items = {
			"DeadRat", 50,
			"DeadRat", 20,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	Bag_DeadRoaches = {
		rolls = 20,
		items = {
			"Cockroach", 50,
			"Cockroach", 20,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	-- Old-school black leather doctor's bag.
	Bag_DoctorBag = {
		rolls = 2,
		items = {
			"AlcoholWipes", 50,
			"AlcoholWipes", 20,
			"AlcoholWipes", 10,
			"AlcoholWipes", 10,
			"Bandage", 20,
			"Bandage", 10,
			"Bandaid", 50,
			"Bandaid", 20,
			"Bandaid", 10,
			"Bandaid", 10,
			"Coldpack", 10,
			"CottonBalls", 10,
			"Gloves_Surgical", 10,
			"Hat_HeadMirrorUP", 2,
			"Hat_SurgicalMask", 10,
			"PenLight", 10,
			"Pills", 20,
			"Pills", 10,
			"PillsAntiDep", 10,
			"PillsSleepingTablets", 10,
			"Scalpel", 10,
			"ScissorsBluntMedical", 10,
			"Stethoscope", 50,
			"SutureNeedle", 20,
			"SutureNeedle", 10,
			"SutureNeedleHolder", 20,
			"TongueDepressor", 50,
			"TongueDepressor", 20,
			"TongueDepressor", 10,
			"TongueDepressor", 10,
			"Tweezers", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	Bag_DoctorBag_Money = BagsAndContainers.MoneyBag,

	Bag_DuffelBag = {
		rolls = 1,
		items = {
			"BathTowel", 2,
			"CDplayer", 1,
			"Disc_Retail", 2,
			"Earbuds", 1,
			"Gum", 10,
			"Hat_BaseballCap", 1,
			"Hat_Sweatband", 1,
			"HoodieDOWN_WhiteTINT", 0.5,
			"Shorts_LongSport", 2,
			"Shorts_ShortSport", 2,
			"Socks_Ankle_White", 2,
			"Trousers_Sport", 2,
			"Tshirt_Sport", 2,
			"Vest_DefaultTEXTURE_TINT", 2,
			"WaterBottle", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	Bag_DuffelBagTINT = {
		rolls = 1,
		items = {
			"BathTowel", 2,
			"CDplayer", 1,
			"Disc_Retail", 2,
			"Earbuds", 1,
			"Gum", 10,
			"Hat_BaseballCap", 1,
			"Hat_Sweatband", 1,
			"HoodieDOWN_WhiteTINT", 0.5,
			"Shorts_LongSport", 2,
			"Shorts_ShortSport", 2,
			"Socks_Ankle_White", 2,
			"Trousers_Sport", 2,
			"Tshirt_Sport", 2,
			"Vest_DefaultTEXTURE_TINT", 2,
			"WaterBottle", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_FannyPackFront = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 10,
			"KeyRing", 10,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Snacks
			"Chocolate", 2,
			"GranolaBar", 2,
			"Gum", 10,
			"Peanuts", 2,
			"SunflowerSeeds", 2,
			-- Medical
			"AlcoholWipes", 4,
			"Bandaid", 4,
			"Pills", 1,
			"PillsAntiDep", 0.01,
			"PillsBeta", 0.01,
			"PillsVitamins", 0.01,
			-- Stationery
			"BluePen", 1,
			"Notepad", 2,
			"Pen", 1,
			"Pencil", 1,
			-- Misc.
			"CardDeck", 2,
			"CDplayer", 1,
			"CigarettePack", 0.1,
			"Comb", 4,
			"Earbuds", 1,
			"KnifePocket", 0.1,
			"Lighter", 1,
			"LighterDisposable", 4,
			"PokerChips", 0.1,
			"Tissue", 8,
		},
		junk = {
			rolls = 1,
			items = {
				"IDcard", 10,
				"Wallet", 20,
			}
		},
	},

	Bag_FannyPackBack = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 10,
			"KeyRing", 10,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Snacks
			"Chocolate", 2,
			"GranolaBar", 2,
			"Gum", 10,
			"Peanuts", 2,
			"SunflowerSeeds", 2,
			-- Medical
			"AlcoholWipes", 4,
			"Bandaid", 4,
			"Pills", 1,
			"PillsAntiDep", 0.01,
			"PillsBeta", 0.01,
			"PillsVitamins", 0.01,
			-- Stationery
			"BluePen", 1,
			"Notepad", 2,
			"Pen", 1,
			"Pencil", 1,
			-- Misc.
			"CardDeck", 2,
			"CDplayer", 1,
			"CigarettePack", 0.1,
			"Comb", 4,
			"Earbuds", 1,
			"KnifePocket", 0.1,
			"Lighter", 1,
			"LighterDisposable", 4,
			"PokerChips", 0.1,
			"Tissue", 8,
		},
		junk = {
			rolls = 1,
			items = {
				"IDcard", 10,
				"Wallet", 20,
			}
		},
	},

	Bag_FishingBasket= {
		rolls = 1,
		items = {
			"BlackCrappie", 10,
			"Bluegill", 10,
			"GreenSunfish", 10,
			"LargemouthBass", 10,
			"RedearSunfish", 10,
			"Sauger", 10,
			"SmallmouthBass", 10,
			"SpottedBass", 10,
			"StripedBass", 10,
			"Walleye", 10,
			"WhiteBass", 10,
			"WhiteCrappie", 10,
			"YellowPerch", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_FluteCase = {
		rolls = 1,
		items = {
			"Flute", 200,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_FoodSnacks = {
		rolls = 2,
		items = {
			"BeefJerky", 20,
			"BeefJerky", 10,
			"ChocoCakes", 10,
			"Chocolate", 20,
			"Chocolate", 10,
			"Crisps", 10,
			"Crisps2", 10,
			"Crisps3", 10,
			"Crisps4", 10,
			"DehydratedMeatStick", 20,
			"DehydratedMeatStick", 10,
			"GranolaBar", 20,
			"GranolaBar", 10,
			"GummyBears", 10,
			"GummyWorms", 10,
			"HiHis", 10,
			"JellyBeans", 10,
			"Jujubes", 10,
			"LicoriceBlack", 10,
			"LicoriceRed", 10,
			"Peanuts", 10,
			"Plonkies", 10,
			"PorkRinds", 8,
			"QuaggaCakes", 10,
			"SnoGlobes", 10,
			"SunflowerSeeds", 10,
			"TortillaChips", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_FoodCanned = {
		rolls = 2,
		items = {
			"CannedBolognese", 20,
			"CannedCarrots2", 20,
			"CannedChili", 20,
			"CannedCorn", 20,
			"CannedCornedBeef", 20,
			"CannedFruitCocktail", 20,
			"CannedMushroomSoup", 20,
			"CannedPeaches", 20,
			"CannedPeas", 20,
			"CannedPineapple", 20,
			"CannedPotato2", 20,
			"CannedSardines", 20,
			"CannedTomato2", 20,
			"TinnedBeans", 20,
			"TinnedSoup", 20,
			"TunaTin", 20,
		},
		junk = {
			rolls = 1,
			items = {
				"TinOpener", 100,
			}
		},
	},

	Bag_FruitBasket = {
		rolls = 2,
		items = {
			"Apple", 20,
			"Apple", 50,
			"Banana", 20,
			"Cherry", 20,
			"Grapefruit", 20,
			"Grapes", 20,
			"Mango", 20,
			"Orange", 20,
			"Orange", 50,
			"Peach", 20,
			"Pear", 20,
			"Pineapple", 10,
			"Strewberrie", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_GardenBasket = BagsAndContainers.Gardening,

	Bag_HospitalBasket = {
		rolls = 1,
		items = {
			"BorisBadger", 0.05,
			"Card_Sympathy", 80,
			"FluffyfootBunny", 0.05,
			"FreddyFox", 0.05,
			"FurbertSquirrel", 0.05,
			"JacquesBeaver", 0.05,
			"MoleyMole", 0.05,
			"PancakeHedgehog", 0.05,
			"PanchoDog", 0.05,
			"Plushabug", 0.05,
			"Spiffo", 0.05,
			"ToyBear", 50,
			"ToyBear", 20,
			"ToyBear", 20,
			"ToyBear", 10,
			"ToyBear", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_GolfBag = {
		rolls = 2,
		items = {
			-- Clubs
			"Golfclub", 200,
			"Golfclub", 50,
			"Golfclub", 20,
			"Golfclub", 10,
			-- Golf Balls
			"GolfBall", 200,
			"GolfBall", 50,
			"GolfBall", 20,
			"GolfBall", 10,
			-- Misc.
			"CigarettePack", 2,
			-- Accessories
			"GolfTee", 200,
			"GolfTee", 50,
			"GolfTee", 50,
			"GolfTee", 20,
			"Notepad", 10,
			"Pencil", 10,
			-- Clothing
			"Gloves_LeatherGloves", 1,
			"Hat_GolfHatTINT", 2,
			"Hat_VisorBlack", 2,
			"Hat_VisorRed", 2,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	-- Bag of sports equipment, and some of the tools that are more suited for melee combat.
	Bag_GolfBag_Melee = {
		rolls = 4,
		items = {
			-- Sports Equipment
			"BaseballBat", 20,
			"BaseballBat_Metal", 20,
			"FieldHockeyStick", 20,
			"Hat_HockeyMask", 1,
			"IceHockeyStick", 20,
			"LaCrosseStick", 20,
			-- Tools
			"Axe", 6,
			"Crowbar", 10,
			"FireplacePoker", 1,
			"HandAxe", 10,
			"GardenFork", 6,
			"GardenFork_Forged", 0.1,
			"GardenHoe", 6,
			"Katana", 0.5,
			"Machete", 6,
			"Shovel", 6,
			"Shovel2", 6,
			"Sledgehammer", 0.5,
			"Sledgehammer2", 0.5,
			"WoodAxe", 4,
			-- Crafted Weapons
			"BaseballBat_Nails", 6,
			"SpearCrafted", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_HikingBag_Travel = BagsAndContainers.HikingBag,

	Bag_InmateEscapedBag = {
		rolls = 1,
		items = {
			-- Weapons/Tools
			"Awl", 10,
			"CrudeKnife", 20,
			"File", 10,
			"GlassShiv", 50,
			"Hammer", 10,
			"IcePick", 20,
			"KnifeShiv", 50,
			"Screwdriver", 10,
			-- Materials
			"DuctTape", 20,
			"RippedSheets", 50,
			"RippedSheets", 20,
			"Rope", 50,
			"SheetRope", 50,
			"SheetRope", 20,
			-- Misc.
			"Belt2", 4,
			"Zipties", 20,
			"LeatherStrips", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	Bag_JanitorToolbox = {
		rolls = 3,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 1,
			"Key1", 2,
			"Key1", 2,
			"Key1", 2,
			-- Tools
			"Crowbar", 20,
			"Hammer", 50,
			"HandAxe", 1,
			"HandTorch", 50,
			"KnifePocket", 0.1,
			"PipeWrench", 100,
			"Pliers", 50,
			"Saw", 50,
			"Screwdriver", 50,
			"ViseGrips", 20,
			"Wrench", 50,
			-- Rags
			"RippedSheets", 20,
			"RippedSheets", 20,
			"RippedSheetsDirty", 20,
			"RippedSheetsDirty", 20,
			-- Chemicals
			"RatPoison", 10,
			-- Materials
			"DuctTape", 20,
			"Epoxy", 4,
			"SteelWool", 10,
			"Twine", 10,
			"Woodglue", 8,
			-- Misc.
			"BottleOpener", 1,
			"Flask", 1,
			"Gum", 10,
			"HottieZ", 1,
			"MarkerBlack", 10,
			"MeasuringTape", 50,
			"TobaccoChewing", 1,
		    "Whetstone", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"CombinationPadlock", 10,
				"Padlock", 10,
			}
		},
	},

	Bag_Laundry = {
		rolls = 4,
		items = {
			"BathTowel", 20,
			"Bikini_Pattern01", 1,
			"Bikini_TINT", 1,
			"BoobTube", 2,
			"BoobTubeSmall", 2,
			"Boxers_Hearts", 0.5,
			"Boxers_RedStripes", 0.5,
			"Boxers_White", 4,
			"Bra_Strapless_AnimalPrint", 1,
			"Bra_Strapless_Black", 1,
			"Bra_Strapless_FrillyBlack", 1,
			"Bra_Strapless_FrillyPink", 1,
			"Bra_Strapless_RedSpots", 1,
			"Bra_Strapless_White", 1,
			"Bra_Straps_AnimalPrint", 1,
			"Bra_Straps_Black", 2,
			"Bra_Straps_FrillyBlack", 1,
			"Bra_Straps_FrillyPink", 1,
			"Bra_Straps_White", 2,
			"Briefs_AnimalPrints", 0.5,
			"Briefs_White", 4,
			"Corset", 1,
			"Corset_Black", 1,
			"Dress_Knees", 4,
			"Dress_Long", 4,
			"Dress_Normal", 4,
			"FrillyUnderpants_Black", 1,
			"FrillyUnderpants_Pink", 1,
			"FrillyUnderpants_Red", 1,
			"HoodieDOWN_WhiteTINT", 4,
			"JacketLong_Random", 0.5,
			"Jacket_Black", 0.5,
			"Jacket_Shellsuit_TINT", 1,
			"Jacket_WhiteTINT", 1,
			"Jumper_DiamondPatternTINT", 1,
			"Jumper_PoloNeck", 2,
			"Jumper_RoundNeck", 2,
			"Jumper_TankTopTINT", 4,
			"Jumper_VNeck", 4,
			"LongCoat_Bathrobe", 2,
			"Sheet", 20,
			"Shirt_CropTopNoArmTINT", 4,
			"Shirt_CropTopTINT", 4,
			"Shirt_Denim", 2,
			"Shirt_FormalTINT", 2,
			"Shirt_FormalWhite", 2,
			"Shirt_FormalWhite_ShortSleeve", 2,
			"Shirt_FormalWhite_ShortSleeveTINT", 2,
			"Shirt_Lumberjack", 2,
			"Shirt_Lumberjack_TINT", 2,
			"Shorts_LongDenim", 2,
			"Shorts_LongSport", 2,
			"Shorts_ShortDenim", 2,
			"Shorts_ShortSport", 2,
			"Skirt_Knees", 8,
			"Skirt_Long", 8,
			"Skirt_Normal", 8,
			"Socks_Ankle", 10,
			"Socks_Ankle_White", 10,
			"Socks_Heavy", 4,
			"Socks_Long", 10,
			"Socks_Long_White", 10,
			"StockingsBlack", 1,
			"StockingsBlackSemiTrans", 1,
			"StockingsBlackTrans", 1,
			"StockingsWhite", 1,
			"SwimTrunks_Blue", 1,
			"SwimTrunks_Green", 1,
			"SwimTrunks_Red", 1,
			"SwimTrunks_Yellow", 1,
			"TightsBlack", 1,
			"TightsBlackSemiTrans", 1,
			"TightsBlackTrans", 1,
			"TightsFishnets", 1,
			"TrousersMesh_DenimLight", 4,
			"Trousers_DefaultTEXTURE", 8,
			"Trousers_DefaultTEXTURE_TINT", 8,
			"Trousers_Denim", 4,
			"Trousers_JeanBaggy", 4,
			"Trousers_Shellsuit_TINT", 2,
			"Trousers_Sport", 2,
			"Trousers_Suit", 0.5,
			"Trousers_SuitTEXTURE", 0.5,
			"Trousers_WhiteTINT", 8,
			"Tshirt_DefaultDECAL_TINT", 1,
			"Tshirt_DefaultTEXTURE_TINT", 10,
			"Tshirt_IndieStoneDECAL", 0.001,
			"Tshirt_LongSleeve_SuperColor", 2,
			"Tshirt_PoloStripedTINT", 4,
			"Tshirt_PoloTINT", 4,
			"Tshirt_Sport", 2,
			"Tshirt_SportDECAL", 2,
			"Tshirt_SuperColor", 2,
			"Tshirt_TieDye", 2,
			"Tshirt_WhiteLongSleeveTINT", 6,
			"Tshirt_WhiteTINT", 10,
			"Underpants_Black", 8,
			"Underpants_White", 8,
			"Vest_DefaultTEXTURE_TINT", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	Bag_LaundryHospital = {
		rolls = 4,
		items = {
			"HospitalGown", 20,
			"HospitalGown", 10,
			"Trousers_Scrubs", 8,
			"Shirt_Scrubs", 8,
			"BathTowel", 20,
			"BathTowel", 10,
			"Sheet", 50,
			"Sheet", 20,
			"Sheet", 20,
			"Sheet", 10,
			"Sheet", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	Bag_LaundryLinen = {
		rolls = 4,
		items = {
			"BathTowel", 50,
			"BathTowel", 20,
			"BathTowel", 20,
			"BathTowel", 10,
			"BathTowel", 10,
			"Sheet", 50,
			"Sheet", 20,
			"Sheet", 20,
			"Sheet", 10,
			"Sheet", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	Bag_Mail = {
		rolls = 4,
		items = {
			"Brochure", 20,
			"Card_Birthday", 1,
			"Card_Sympathy", 1,
			"ComicBook_Retail", 0.5,
			"CookingMag1", 1,
			"CookingMag2", 1,
			"CookingMag3", 1,
			"CookingMag4", 1,
			"CookingMag5", 1,
			"CookingMag6", 1,
			"ElectronicsMag1", 1,
			"ElectronicsMag2", 1,
			"ElectronicsMag3", 1,
			"ElectronicsMag4", 1,
			"ElectronicsMag5", 1,
			"EngineerMagazine1", 1,
			"EngineerMagazine2", 1,
			"FarmingMag1", 1,
			"FarmingMag2", 1,
			"FarmingMag3", 1,
			"FarmingMag4", 1,
			"FarmingMag5", 1,
			"FarmingMag6", 1,
			"FarmingMag7", 1,
			"FarmingMag8", 1,
			"FishingMag1", 1,
			"FishingMag2", 1,
			"Flier", 20,
			"GenericMail", 1,
			"GlassmakingMag1", 1,
			"GlassmakingMag2", 1,
			"GlassmakingMag3", 1,
			"HerbalistMag", 1,
			"HuntingMag1", 1,
			"HuntingMag2", 1,
			"HuntingMag3", 1,
			"KnittingMag1", 1,
			"KnittingMag2", 1,
			"LetterHandwritten", 1,
			"Magazine_New", 20,
			"Magazine_Popular", 5,
			"MagazineCrossword", 2,
			"MagazineWordsearch", 2,
			"MechanicMag1", 1,
			"MechanicMag2", 1,
			"MechanicMag3", 1,
			"MetalworkMag1", 1,
			"MetalworkMag2", 1,
			"MetalworkMag3", 1,
			"MetalworkMag4", 1,
			"Newspaper_New", 10,
			"Parcel_ExtraLarge", 1,
			"Parcel_ExtraSmall", 10,
			"Parcel_Large", 2,
			"Parcel_Medium", 4,
			"Parcel_Small", 8,
			"SmithingMag1", 0.01,
			"SmithingMag2", 0.01,
			"SmithingMag3", 0.01,
			"SmithingMag4", 0.01,
			"SmithingMag5", 0.01,
			"SmithingMag6", 0.01,
			"SmithingMag7", 0.01,
			"SmithingMag8", 0.01,
			"SmithingMag9", 0.01,
			"SmithingMag10", 0.01,
			"SmithingMag11", 0.01,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	MakeupCase_Professional = BagsAndContainers.MakeupCase_Professional,

	Bag_MedicalBag = {
		rolls = 2,
		items = {
			"AlcoholWipes", 50,
			"AlcoholWipes", 20,
			"AlcoholWipes", 10,
			"AlcoholWipes", 10,
			"Bandage", 50,
			"Bandage", 20,
			"Bandage", 10,
			"Bandage", 10,
			"Bandaid", 50,
			"Bandaid", 20,
			"Bandaid", 10,
			"Bandaid", 10,
			"Coldpack", 10,
			"CottonBalls", 20,
			"CottonBalls", 10,
			"Disinfectant", 10,
			"Gloves_Surgical", 10,
			"Hat_SurgicalMask", 10,
			"PenLight", 10,
			"Pills", 20,
			"Pills", 20,
			"Pills", 10,
			"Pills", 10,
			"PillsAntiDep", 10,
			"PillsSleepingTablets", 10,
			"Scalpel", 10,
			"ScissorsBluntMedical", 10,
			"Stethoscope", 50,
			"SutureNeedle", 50,
			"SutureNeedle", 20,
			"SutureNeedle", 10,
			"SutureNeedle", 10,
			"SutureNeedleHolder", 20,
			"TongueDepressor", 20,
			"TongueDepressor", 10,
			"Tweezers", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	Bag_Military = BagsAndContainers.ALICEpack_Army,

	Bag_MoneyBag = BagsAndContainers.MoneyBag,

	Bag_NormalHikingBag = BagsAndContainers.HikingBag,

	Bag_PicnicBasket= {
		rolls = 2,
		items = {
			"Apple", 8,
			"BagelPlain", 8,
			"BagelPoppy", 8,
			"BagelSesame", 8,
			"Baguette", 10,
			"Banana", 8,
			"ButterKnife", 10,
			"CannedFruitBeverage", 4,
			"CinnamonRoll", 8,
			"CookieChocolateChip", 6,
			"CookieJelly", 6,
			"CookiesChocolate", 6,
			"CookiesOatmeal", 6,
			"CookiesShortbread", 6,
			"CookiesSugar", 6,
			"Crisps", 8,
			"Crisps2", 8,
			"Crisps3", 8,
			"Crisps4", 8,
			"CrispyRiceSquare", 8,
			"Croissant", 10,
			"Danish", 8,
			"Fork", 10,
			"GranolaBar", 10,
			"Grapes", 8,
			"JellyRoll", 8,
			"JuiceBox", 6,
			"JuiceBoxApple", 6,
			"JuiceBoxFruitpunch", 6,
			"JuiceBoxOrange", 6,
			"LemonBar", 8,
			"MilkChocolate_Personalsized", 10,
			"Milk_Personalsized", 10,
			"MuffinFruit", 10,
			"MuffinGeneric", 10,
			"Orange", 8,
			"Painauchocolat", 8,
			"Peach", 8,
			"Pop", 6,
			"Pop2", 6,
			"Pop3", 6,
			"PopBottle", 4,
			"PopBottleRare", 0.1,
			"Spoon", 10,
			"Strewberrie", 8,
			"WaterBottle", 4,
			"WatermelonSliced", 8,
			"Yoghurt", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_Police = BagsAndContainers.Bag_Police,

	Bag_ProtectiveCase_Survivalist = {
		rolls = 2,
		items = {
			"Bandaid", 10,
			"BeefJerky", 10,
			"Bullets38Box", 1,
			"Bullets44Box", 1,
			"Bullets45Box", 1,
			"Bullets9mmBox", 1,
			"Candle", 10,
			"CompassDirectional", 10,
			"DehydratedMeatStick", 10,
			"FishingHook", 10,
			"FishingLine", 10,
			"FlashLight_AngleHead_Army", 1,
			"GasmaskFilter", 4,
			"GranolaBar", 10,
			"Handiknife", 0.1,
			"Hat_GasMask", 1,
			"HuntingKnife", 4,
			"KnifePocket", 0.1,
			"MagnesiumFirestarter", 10,
			"Matches", 10,
			"Multitool", 0.01,
			"Needle", 10,
			"P38", 10,
			"PanForged", 10,
			"PotForged", 4,
			"PenLight", 10,
			"Pistol", 4,
			"Pistol2", 2,
			"Pistol3", 1,
			"PonchoGreenDOWN", 1,
			"Revolver", 2,
			"Revolver_Long", 1,
			"Revolver_Short", 4,
			"Thread", 10,
			"WalkieTalkie3", 4,
			"WaterPurificationTablets", 8,
			"Whetstone", 10,
			"Whistle", 2,
			"x2Scope", 2,
			"x4Scope", 1,
			"x8Scope", 0.5,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_ProtectiveCase_Tools = BagsAndContainers.Toolbox,

	Bag_ProtectiveCaseBulky_HAMRadio1 = {
		rolls = 1,
		items = {
			"HamRadio1", 100,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_ProtectiveCaseBulky_SCBA = {
		rolls = 2,
		items = {
			"Oxygen_Tank", 20,
			"Oxygen_Tank", 10,
			"SCBA_notank", 50,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_ProtectiveCaseBulky_Survivalist = {
		rolls = 2,
		items = {
			"Bag_LeatherWaterBag", 1,
			"Bandaid", 10,
			"BeefJerky", 10,
			"BoltCutters", 1,
			"Bullets38Box", 2,
			"Bullets44Box", 2,
			"Bullets45Box", 2,
			"Bullets9mmBox", 2,
			"Candle", 10,
			"CanteenMilitary", 1,
			"CompassDirectional", 10,
			"Crowbar", 1,
			"DehydratedMeatStick", 10,
			"EntrenchingTool", 1,
			"FishingHook", 10,
			"FishingLine", 10,
			"FlashLight_AngleHead_Army", 1,
			"GasmaskFilter", 4,
			"GranolaBar", 10,
			"HandAxe", 1,
			"Handiknife", 0.1,
			"HandTorch", 10,
			"Hat_GasMask", 1,
			"HuntingKnife", 4,
			"KnifePocket", 0.1,
			"Machete", 0.1,
			"MagnesiumFirestarter", 10,
			"Matches", 10,
			"Multitool", 0.01,
			"Needle", 10,
			"P38", 10,
			"PanForged", 10,
			"PotForged", 4,
			"Pistol", 8,
			"Pistol2", 4,
			"Pistol3", 2,
			"PonchoGreenDOWN", 1,
			"Revolver", 4,
			"Revolver_Long", 2,
			"Revolver_Short", 8,
			"SleepingBag_Camo_Packed", 1,
			"TentGreen_Packed", 0.5,
			"Thread", 10,
			"Vest_BulletCivilian", 0.5,
			"WalkieTalkie3", 4,
			"WaterPurificationTablets", 8,
			"Whetstone", 10,
			"Whistle", 2,
			"x2Scope", 4,
			"x4Scope", 2,
			"x8Scope", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_ProtectiveCaseBulkyAmmo = {
		rolls = 1,
		items = {
			"Bag_AmmoBox_Mixed", 50,
			"Bag_AmmoBox_Mixed", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_ProtectiveCaseBulkyAmmo_223 = {
		rolls = 1,
		items = {
			"Bag_AmmoBox_223", 50,
			"Bag_AmmoBox_223", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_ProtectiveCaseBulkyAmmo_308 = {
		rolls = 1,
		items = {
			"Bag_AmmoBox_308", 50,
			"Bag_AmmoBox_308", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_ProtectiveCaseBulkyAmmo_38 = {
		rolls = 1,
		items = {
			"Bag_AmmoBox_38", 50,
			"Bag_AmmoBox_38", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_ProtectiveCaseBulkyAmmo_44 = {
		rolls = 1,
		items = {
			"Bag_AmmoBox_44", 50,
			"Bag_AmmoBox_44", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_ProtectiveCaseBulkyAmmo_45 = {
		rolls = 1,
		items = {
			"Bag_AmmoBox_45", 50,
			"Bag_AmmoBox_45", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_ProtectiveCaseBulkyAmmo_556 = {
		rolls = 1,
		items = {
			"Bag_AmmoBox", 50,
			"Bag_AmmoBox", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_ProtectiveCaseBulkyAmmo_9mm = {
		rolls = 1,
		items = {
			"Bag_AmmoBox_9mm", 50,
			"Bag_AmmoBox_9mm", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_ProtectiveCaseBulkyAmmo_Hunting = {
		rolls = 1,
		items = {
			"Bag_AmmoBox_Hunting", 50,
			"Bag_AmmoBox_Hunting", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_ProtectiveCaseBulkyAmmo_ShotgunShells = {
		rolls = 1,
		items = {
			"Bag_AmmoBox_ShotgunShells", 50,
			"Bag_AmmoBox_ShotgunShells", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_ProtectiveCaseBulky_Audio = {
		rolls = 1,
		items = {
			"ElectricWire", 50,
			"ElectricWire", 20,
			"Headphones", 50,
			"Headphones", 20,
			"Microphone", 100,
			"Microphone", 50,
			"PowerBar", 50,
			"PowerBar", 20,
			"Speaker", 100,
			"Speaker", 50,
			"Speaker", 20,
			"Speaker", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_ProtectiveCaseBulkyHazard = {
		rolls = 1,
		items = {
			"BandageDirty", 50,
			"BandageDirty", 20,
			"BandageDirty", 20,
			"BandageDirty", 10,
			"Coldpack", 50,
			"Coldpack", 20,
			"Scalpel", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_ProtectiveCaseBulkyMilitary_HAMRadio2 = {
		rolls = 1,
		items = {
			"HamRadio2", 100,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_ProtectiveCaseSmall_Armorer = {
		rolls = 1,
		items = {
			"AmmoStrap_Bullets", 20,
			"AmmoStrap_Shells", 20,
			"ChokeTubeFull", 50,
			"ChokeTubeImproved", 20,
			"RecoilPad", 50,
			"RedDot", 50,
			"Screwdriver", 100,
			"Screwdriver", 50,
			"x2Scope", 50,
			"x4Scope", 20,
			"x8Scope", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_ProtectiveCaseSmall_Electronics = {
		rolls = 1,
		items = {
			"Battery", 20,
			"Battery", 20,
			"Battery", 10,
			"Battery", 10,
			"BatteryBox", 4,
			"CDplayer", 20,
			"CordlessPhone", 50,
			"Earbuds", 50,
			"HandTorch", 50,
			"Headphones", 50,
			"PowerBar", 50,
			"VideoGame", 20,
			"WalkieTalkie3", 50,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_ProtectiveCaseSmall_FirstAid = BagsAndContainers.FirstAidKit,

	Bag_ProtectiveCaseSmall_KeyCutting = BagsAndContainers.KeyCutting,

	Bag_ProtectiveCaseSmall_Survivalist = {
		rolls = 1,
		items = {
			"Bandaid", 50,
			"Candle", 50,
			"CompassDirectional", 50,
			"FishingHook", 50,
			"FishingHook", 20,
			"FishingLine", 50,
			"FishingLine", 20,
			"Handiknife", 0.1,
			"KnifePocket", 0.1,
			"MagnesiumFirestarter", 50,
			"Matches", 20,
			"Multitool", 0.01,
			"Needle", 50,
			"Needle", 20,
			"P38", 50,
			"PenLight", 20,
			"SurvivalSchematic", 10,
			"Thread", 50,
			"Thread", 20,
			"WaterPurificationTablets", 10,
			"Whetstone", 10,
			"Whistle", 2,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_ProtectiveCaseSmall_Pistol1 = BagsAndContainers.PistolCase1,

	Bag_ProtectiveCaseSmall_Pistol2 = BagsAndContainers.PistolCase2,

	Bag_ProtectiveCaseSmall_Pistol3 = BagsAndContainers.PistolCase3,

	Bag_ProtectiveCaseSmall_Revolver1 = BagsAndContainers.RevolverCase1,

	Bag_ProtectiveCaseSmall_Revolver2 = BagsAndContainers.RevolverCase2,

	Bag_ProtectiveCaseSmall_Revolver3 = BagsAndContainers.RevolverCase3,

	Bag_ProtectiveCaseSmall_WalkieTalkie = {
		rolls = 1,
		items = {
			"Battery", 20,
			"Battery", 20,
			"Battery", 10,
			"Battery", 10,
			"BatteryBox", 4,
			"WalkieTalkie3", 100,
			"WalkieTalkie3", 50,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_ProtectiveCaseSmall_WalkieTalkiePolice = {
		rolls = 1,
		items = {
			"Battery", 20,
			"Battery", 20,
			"Battery", 10,
			"Battery", 10,
			"BatteryBox", 4,
			"WalkieTalkie4", 100,
			"WalkieTalkie4", 50,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_ProtectiveCaseSmallMilitary_FirstAid = BagsAndContainers.FirstAidKit,

	Bag_ProtectiveCaseSmallMilitary_Pistol1 = BagsAndContainers.PistolCase1,

	Bag_ProtectiveCaseSmallMilitary_WalkieTalkie = {
		rolls = 1,
		items = {
			"Battery", 20,
			"Battery", 20,
			"Battery", 10,
			"Battery", 10,
			"BatteryBox", 4,
			"WalkieTalkie5", 100,
			"WalkieTalkie5", 50,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_ProtectiveCaseMilitary_Tools = BagsAndContainers.Toolbox,

	Bag_RifleCase_Police = BagsAndContainers.RifleCase2,

	Bag_RifleCase_Police2 = BagsAndContainers.RifleCase3,

	Bag_RifleCase_Police3 = BagsAndContainers.RifleCase4,

	Bag_RifleCaseCloth = BagsAndContainers.RifleCase1,

	Bag_RifleCaseCloth2 = BagsAndContainers.RifleCase2,

	Bag_RifleCaseClothCamo = BagsAndContainers.RifleCase2,

	Bag_RifleCaseGreen = BagsAndContainers.RifleCase4,

	Bag_RifleCaseGreen2 = BagsAndContainers.RifleCase3,

	Bag_Satchel = {
		rolls = 1,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Literature (Generic)
			"ComicBook_Retail", 20,
			"ComicBook", 10,
			"Book", 20,
			"Book", 20,
			"Book", 10,
			"Book", 10,
			"Paperback", 10,
			"SheetPaper2", 20,
			"SheetPaper2", 20,
			"SheetPaper2", 10,
			"SheetPaper2", 10,
			"WaterBottle", 1,
			-- Stationery/Office
			"BluePen", 8,
			"Eraser", 6,
			"MarkerBlack", 4,
			"MarkerBlue", 2,
			"MarkerGreen", 2,
			"MarkerRed", 2,
			"Pen", 8,
			"Pencil", 10,
			"RedPen", 8,
			"RubberBand", 6,
			"Scissors", 2,
			"Scotchtape", 4,
			-- Electronics/Music
			"CDplayer", 2,
			"Disc_Retail", 2,
			"Earbuds", 2,
			-- Misc.
			"Gum", 10,
			"KnifePocket", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	Bag_Satchel_Fishing = BagsAndContainers.Tacklebox,

	Bag_Satchel_Leather = {
		rolls = 1,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Stationery
			"BluePen", 8,
			"CompassGeometry", 2,
			"Eraser", 6,
			"Pen", 8,
			"Pencil", 10,
			"RedPen", 8,
			"RubberBand", 6,
			"Scissors", 2,
			"Scotchtape", 4,
			-- Books
			"Book", 20,
			"Book", 20,
			"Book", 10,
			"Book", 10,
			"Paperback", 10,
			-- Paper
			"SheetPaper2", 20,
			"SheetPaper2", 20,
			"SheetPaper2", 10,
			"SheetPaper2", 10,
			-- Misc.
			"CDplayer", 2,
			"ComicBook_Retail", 20,
			"ComicBook", 10,
			"Disc_Retail", 2,
			"Earbuds", 2,
			"Gum", 10,
			"KnifePocket", 0.1,
			"WaterBottle", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_Satchel_Mail = {
		rolls = 4,
		items = {
			"Brochure", 20,
			"Card_Birthday", 1,
			"Card_Sympathy", 1,
			"ComicBook_Retail", 0.5,
			"CookingMag1", 1,
			"CookingMag2", 1,
			"CookingMag3", 1,
			"CookingMag4", 1,
			"CookingMag5", 1,
			"CookingMag6", 1,
			"ElectronicsMag1", 1,
			"ElectronicsMag2", 1,
			"ElectronicsMag3", 1,
			"ElectronicsMag4", 1,
			"ElectronicsMag5", 1,
			"EngineerMagazine1", 1,
			"EngineerMagazine2", 1,
			"FarmingMag1", 1,
			"FarmingMag2", 1,
			"FarmingMag3", 1,
			"FarmingMag4", 1,
			"FarmingMag5", 1,
			"FarmingMag6", 1,
			"FarmingMag7", 1,
			"FarmingMag8", 1,
			"FishingMag1", 1,
			"FishingMag2", 1,
			"Flier", 20,
			"GenericMail", 1,
			"GlassmakingMag1", 1,
			"GlassmakingMag2", 1,
			"GlassmakingMag3", 1,
			"HerbalistMag", 1,
			"HuntingMag1", 1,
			"HuntingMag2", 1,
			"HuntingMag3", 1,
			"KnittingMag1", 1,
			"KnittingMag2", 1,
			"LetterHandwritten", 1,
			"Magazine", 5,
			"Magazine_Popular", 5,
			"MagazineCrossword", 2,
			"MagazineWordsearch", 2,
			"MechanicMag1", 1,
			"MechanicMag2", 1,
			"MechanicMag3", 1,
			"MetalworkMag1", 1,
			"MetalworkMag2", 1,
			"MetalworkMag3", 1,
			"MetalworkMag4", 1,
			"Newspaper", 10,
			"Parcel_ExtraLarge", 1,
			"Parcel_ExtraSmall", 10,
			"Parcel_Large", 2,
			"Parcel_Medium", 4,
			"Parcel_Small", 8,
			"SmithingMag1", 0.01,
			"SmithingMag2", 0.01,
			"SmithingMag3", 0.01,
			"SmithingMag4", 0.01,
			"SmithingMag5", 0.01,
			"SmithingMag6", 0.01,
			"SmithingMag7", 0.01,
			"SmithingMag8", 0.01,
			"SmithingMag9", 0.01,
			"SmithingMag10", 0.01,
			"SmithingMag11", 0.01,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	Bag_Satchel_Medical = {
		rolls = 2,
		items = {
			"AlcoholWipes", 50,
			"AlcoholWipes", 20,
			"AlcoholWipes", 10,
			"AlcoholWipes", 10,
			"Bandage", 50,
			"Bandage", 20,
			"Bandage", 10,
			"Bandage", 10,
			"Bandaid", 50,
			"Bandaid", 20,
			"Bandaid", 10,
			"Bandaid", 10,
			"Coldpack", 10,
			"CottonBalls", 20,
			"CottonBalls", 10,
			"Disinfectant", 10,
			"Gloves_Surgical", 10,
			"Hat_SurgicalMask", 10,
			"PenLight", 10,
			"Pills", 20,
			"Pills", 20,
			"Pills", 10,
			"Pills", 10,
			"PillsAntiDep", 10,
			"PillsSleepingTablets", 10,
			"Scalpel", 10,
			"ScissorsBluntMedical", 10,
			"Stethoscope", 50,
			"SutureNeedle", 50,
			"SutureNeedle", 20,
			"SutureNeedle", 10,
			"SutureNeedle", 10,
			"SutureNeedleHolder", 20,
			"TongueDepressor", 20,
			"TongueDepressor", 10,
			"Tweezers", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	Bag_Satchel_Military = {
		rolls = 1,
		items = {
			"AlcoholWipes", 1,
			"Bandage", 1,
			"CompassDirectional", 1,
			"DehydratedMeatStick", 1,
			"Earbuds", 1,
			"EntrenchingTool", 0.5,
			"FirstAidKit_Military", 4,
			"FlashLight_AngleHead_Army", 1,
			"GasmaskFilter", 2,
			"GranolaBar", 1,
			"Hat_Army", 0.2,
			"Hat_GasMask", 0.5,
			"HolsterSimple_Green", 1,
			"HuntingKnife", 0.5,
			"KnifePocket", 0.1,
			"Lighter", 1,
			"ShemaghScarf_Green", 0.01,
			"Shoes_ArmyBoots", 0.2,
			"Tshirt_ArmyGreen", 1,
			"WalkieTalkie5", 1,
			"WaterBottle", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	Bag_SatchelPhoto = {
		rolls = 1,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Photography
			"Camera", 50,
			"Camera", 50,
			"CameraExpensive", 20,
			"CameraFilm", 50,
			"CameraFilm", 50,
			"CameraFilm", 50,
			"CameraFilm", 50,
			"Photo", 50,
			"Photo", 20,
			"Photo", 20,
			"Photo", 10,
			"PhotoAlbum", 20,
			-- Electronics/Music
			"CDplayer", 2,
			"Pager", 10,
			"Disc_Retail", 2,
			"Earbuds", 2,
			"WalkieTalkie2", 2,
			"WalkieTalkie3", 1,
			-- Literature (Generic)
			"Book_Art", 10,
			"Magazine_Art", 5,
			"Magazine_Fashion", 5,
			-- Stationery/Office
			"BluePen", 8,
			"Eraser", 6,
			"Notebook", 4,
			"Notepad", 10,
			"Pen", 8,
			"Pencil", 10,
			"RedPen", 8,
			"RubberBand", 6,
			"Scissors", 2,
			"Scotchtape", 4,
			"SheetPaper2", 20,
			"SheetPaper2", 10,
			-- Misc.
			"Gum", 10,
			"WaterBottle", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	Bag_SaxophoneCase = {
		rolls = 1,
		items = {
			"Saxophone", 200,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	Bag_Schoolbag = BagsAndContainers.Schoolbag,

	Bag_Schoolbag_Kids = {
		rolls = 1,
		items = {
			"Book_Childs", 10,
			"BorisBadger", 0.001,
			"Bricktoys", 10,
			"CardDeck", 10,
			"ComicBook_Retail", 20,
			"CookieChocolateChip", 4,
			"CookiesOatmeal", 4,
			"Crayons", 20,
			"Doll", 10,
			"DoodleKids", 20,
			"FluffyfootBunny", 0.001,
            "Firecracker", 0.01,
			"FreddyFox", 0.001,
			"GranolaBar", 8,
			"JacquesBeaver", 0.001,
			"JuiceBox", 2,
			"JuiceBoxApple", 2,
			"JuiceBoxFruitpunch", 2,
			"JuiceBoxOrange", 2,
			"Magazine_Childs", 20,
			"MarkerBlack", 4,
			"MarkerBlue", 2,
			"MarkerGreen", 2,
			"MarkerRed", 2,
			"Milk_Personalsized", 2,
			"MilkChocolate_Personalsized", 2,
			"MoleyMole", 0.001,
			"PancakeHedgehog", 0.001,
			"PanchoDog", 0.001,
			"Paperback_Childs", 20,
			"Pencil", 10,
			"PencilCase", 8,
			"PencilSpiffo", 0.01,
			"PenMultiColor", 2,
			"PenSpiffo", 0.01,
			"Plushabug", 0.001,
			"ScissorsBlunt", 8,
			"Spiffo", 0.001,
			"ToyBear", 10,
			"ToyCar", 10,
			"VideoGame", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_Schoolbag_Patches = BagsAndContainers.Schoolbag,

	Bag_Schoolbag_Travel = {
		rolls = 1,
		items = {
			"Bag_LeatherWaterBag", 1,
			"BluePen", 8,
			"Book", 20,
			"Book", 10,
			"CDplayer", 1,
			"Chocolate", 1,
			"ComicBook", 10,
			"Crisps", 1,
			"Disc_Retail", 2,
			"Earbuds", 1,
			"GranolaBar", 1,
			"Gum", 1,
			"Handiknife", 0.01,
			"KnifePocket", 0.01,
			"Lighter", 1,
			"Multitool", 0.001,
			"Paperback", 10,
			"Pen", 8,
			"Pencil", 10,
			"Pop", 1,
			"RedPen", 8,
			"RubberBand", 1,
			"Scissors", 2,
			"SunflowerSeeds", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	-- Basket of knitting supplies grandma uses to uncomfortable sweaters.
	Bag_SewingBasket = {
		rolls = 1,
		items = {
			-- Tools
			"KnittingNeedles", 200,
			"KnittingNeedles", 100,
			"KnittingNeedles", 50,
			-- Materials
			"Yarn", 200,
			"Yarn", 100,
			"Yarn", 50,
			"Yarn", 50,
			"Yarn", 20,
			-- Misc.
			"IndustrialDye", 1,
			"SewingKit", 4,
			"MeasuringTape", 50,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_Sheriff = BagsAndContainers.Bag_Police,

	Bag_ShotgunBag = {
		rolls = 1,
		items = {
			"Shotgun", 200,
			"ShotgunShells", 200,
			"ShotgunShells", 50,
			"ShotgunShells", 20,
			"ShotgunShells", 10,
			"ShotgunShellsBox", 50,
			"ShotgunShellsBox", 20,
			"ShotgunShellsBox", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	Bag_ShotgunCase_Police = BagsAndContainers.ShotgunCase1,

	Bag_ShotgunCaseCloth = BagsAndContainers.ShotgunCase1,

	Bag_ShotgunCaseCloth2 = BagsAndContainers.ShotgunCase2,

	Bag_ShotgunCaseGreen = BagsAndContainers.ShotgunCase1,

	Bag_ShotgunDblBag = {
		rolls = 1,
		items = {
			"DoubleBarrelShotgun", 200,
			"ShotgunShells", 200,
			"ShotgunShells", 50,
			"ShotgunShells", 20,
			"ShotgunShells", 10,
			"ShotgunShellsBox", 50,
			"ShotgunShellsBox", 20,
			"ShotgunShellsBox", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	Bag_ShotgunDblSawnoffBag = {
		rolls = 1,
		items = {
			"DoubleBarrelShotgunSawnoff", 200,
			"ShotgunShells", 200,
			"ShotgunShells", 50,
			"ShotgunShells", 20,
			"ShotgunShells", 10,
			"ShotgunShellsBox", 50,
			"ShotgunShellsBox", 20,
			"ShotgunShellsBox", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	Bag_ShotgunSawnoffBag = {
		rolls = 1,
		items = {
			"ShotgunSawnoff", 200,
			"ShotgunShells", 200,
			"ShotgunShells", 50,
			"ShotgunShells", 20,
			"ShotgunShells", 10,
			"ShotgunShellsBox", 50,
			"ShotgunShellsBox", 20,
			"ShotgunShellsBox", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	Bag_SurvivorBag = BagsAndContainers.SurvivorBag,

	Bag_Skill_Maintenance_DuffelBag = BagsAndContainers.Bag_Skill_Maintenance_DuffelBag,

	Bag_SWAT = BagsAndContainers.Bag_Police,

	Bag_TennisBag = {
		rolls = 1,
		items = {
			"Gum", 1,
			"Shoes_TrainerTINT", 50,
			"Shorts_LongSport", 20,
			"Shorts_ShortSport", 50,
			"TennisBall", 100,
			"TennisBall", 50,
			"TennisBall", 20,
			"TennisBall", 20,
			"TennisRacket", 100,
			"TennisRacket", 50,
			"Trousers_Sport", 10,
			"Tshirt_Sport", 20,
			"WaterBottle", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	Bag_ToolBag = {
		rolls = 3,
		items = {
			"Axe", 0.05,
			"BallPeenHammer", 6,
			"CarpentryChisel", 8,
			"ClubHammer", 4,
			"Crowbar", 4,
			"DuctTape", 4,
			"Funnel", 10,
			"GardenFork", 1,
			"GardenHoe", 2,
			"GardenSaw", 10,
			"Hammer", 8,
			"HandAxe", 1,
			"HandDrill", 4,
			"HandFork", 1,
			"Handle", 2,
			"HandScythe", 1,
			"HandShovel", 10,
			"KnifePocket", 0.1,
			"LeafRake", 10,
			"LugWrench", 3,
			"Machete", 0.01,
			"MeasuringTape", 10,
			"NailsBox", 10,
			"PickAxe", 0.5,
			"PipeWrench", 6,
			"Pliers", 8,
			"Rake", 10,
			"RakeHead", 4,
			"Ratchet", 10,
			"Rope", 10,
			"RubberHose", 10,
			"Saw", 8,
			"Screwdriver", 10,
			"ScrewsBox", 8,
			"Shovel", 4,
			"Shovel2", 4,
			"Sledgehammer", 0.01,
			"Sledgehammer2", 0.01,
			"SmallHandle", 4,
			"SnowShovel", 2,
			"TireIron", 3,
			"TirePump", 6,
			"Twine", 10,
			"ViseGrips", 4,
			"WoodAxe", 0.025,
			"WoodenMallet", 4,
			"Woodglue", 2,
			"Wrench", 6,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	Bag_TrashBag = {
		rolls = 2,
		ignoreZombieDensity = true,
		isTrash = true,
		items = ClutterTables.BinItems,
		junk = ClutterTables.BinJunk,
	},

	Bag_TreasureBag = {
		rolls = 4,
		items = {
			"Bracelet_BangleRightGold", 20,
			"Bracelet_ChainRightGold", 20,
			"Diamond", 50,
			"Earring_LoopLrg_Gold", 20,
			"Earring_LoopMed_Gold", 20,
			"Earring_LoopSmall_Gold_Both", 20,
			"Earring_LoopSmall_Gold_Top", 20,
			"Earring_Stud_Gold", 20,
			"Emerald", 50,
			"GemBag", 4,
			"Goblet", 20,
			"Locket", 20,
			"NecklaceLong_Gold", 20,
			"NecklaceLong_GoldDiamond", 20,
			"Necklace_Gold", 20,
			"Necklace_GoldDiamond", 20,
			"Necklace_GoldRuby", 20,
			"Necklace_SilverCrucifix", 20,
			"Ring_Left_RingFinger_Gold", 50,
			"Ring_Left_RingFinger_GoldDiamond", 20,
			"Ring_Left_RingFinger_GoldRuby", 20,
			"Ruby", 50,
			"Sapphire", 50,
			"TrophyGold", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"MagnifyingGlass", 10,
			}
		},
	},

	Bag_TrumpetCase = {
		rolls = 1,
		items = {
			"Trumpet", 200,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_ViolinCase = {
		rolls = 1,
		items = {
			"Violin", 200,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Bag_WeaponBag = {
		rolls = 2,
		items = {
			"223Box", 10,
			"308Box", 10,
			"44Clip", 8,
			"45Clip", 8,
			"556Clip", 8,
			"9mmClip", 8,
			"AmmoStrap_Bullets", 4,
			"AmmoStrap_Shells", 4,
			"AssaultRifle", 2,
			"AssaultRifle2", 0.1,
			"BaseballBat", 8,
			"Bullets38Box", 10,
			"Bullets44Box", 10,
			"Bullets45Box", 10,
			"Bullets9mmBox", 10,
			"ChokeTubeFull", 6,
			"ChokeTubeImproved", 6,
			"Crowbar", 8,
			"DoubleBarrelShotgun", 8,
			"DoubleBarrelShotgunSawnoff", 8,
			"FirstAidKit_Military", 4,
			"Glasses_Shooting", 8,
			"Gloves_FingerlessGloves", 8,
			"HolsterShoulder", 8,
			"HuntingKnife", 10,
			"HuntingRifle", 4,
			"IDcard_Blank", 0.1,
			"KnifeButterfly", 10,
			"KnifePocket", 0.1,
			"M14Clip", 8,
			"Machete", 4,
			"Pistol", 8,
			"Pistol2", 6,
			"Pistol3", 4,
			"RecoilPad", 6,
			"RedDot", 6,
			"Revolver", 6,
			"Revolver_Long", 4,
			"Revolver_Short", 8,
			"Shotgun", 10,
			"ShotgunSawnoff", 10,
			"ShotgunShellsBox", 10,
			"SwitchKnife", 10,
			"VarmintRifle", 8,
			"Vest_BulletCivilian", 2,
			"x2Scope", 8,
			"x4Scope", 6,
			"x8Scope", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	Bag_WorkerBag = {
		rolls = 1,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Snacks/Drinks
			"Chocolate", 2,
			"Crisps", 1,
			"Gum", 10,
			"Peanuts", 2,
			"SunflowerSeeds", 2,
			"Sportsbottle", 8,
			"Plonkies", 1,
			"Lunchbag", 8,
			"Lunchbox", 8,
			"Lunchbox2", 0.1,
			-- Tobacco/Smoking
			"CigarettePack", 1,
			"Lighter", 0.5,
			"LighterDisposable", 2,
			"Matches", 4,
			"TobaccoChewing", 1,
			-- Electronics/Music
			"CDplayer", 1,
			"Disc_Retail", 2,
			"Earbuds", 1,
			-- Stationery/Office
			"BluePen", 8,
			"Pen", 8,
			"Pencil", 10,
			"RedPen", 8,
			"RubberBand", 1,
			"Scissors", 2,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	Briefcase = {
		rolls = 1,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Literature (Generic)
			"Book_Business", 4,
			"Magazine_Business", 10,
			"Paperback_Business", 8,
			-- Stationery/Office
			"Calculator", 2,
			"Clipboard", 4,
			"CorrectionFluid", 1,
			"HolePuncher", 1,
			"MarkerBlack", 2,
			"Notebook", 4,
			"Notepad", 8,
			"Paperclip", 10,
			"PaperclipBox", 1,
			"Paperwork", 50,
			"Paperwork", 20,
			"Paperwork", 20,
			"Paperwork", 10,
			"Pen", 8,
			"PenFancy", 2,
			"Staples", 1,
			-- Misc.
			"Brochure", 2,
			"BusinessCard", 10,
			"CameraFilm", 0.1,
			"CreditCard", 1,
			"Diary2", 1,
			"Disc_Retail", 2,
			"Flier", 2,
			"Gum", 10,
			"Pager", 8,
			"Photo", 4,
			"Receipt", 1,
			-- Special
			"Money", 4,
			"MoneyBundle", 0.01,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	Briefcase_Money = {
		rolls = 4,
		items = {
			-- Money
			"Money", 100,
			"Money", 100,
			"Money", 100,
			"Money", 100,
			"Money", 50,
			"Money", 50,
			"Money", 50,
			"Money", 50,
			"MoneyBundle", 20,
			"MoneyBundle", 10,
			-- Other Valuables
			"GemBag", 4,
			"StockCertificate", 50,
			"StockCertificate", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	Cashbox = BagsAndContainers.Cashbox,

	CigarBox = BagsAndContainers.CigarBox,

	CookieJar = BagsAndContainers.CookieJar,

	CookieJar_Bear = BagsAndContainers.CookieJar,

	Cooler = {
		rolls = 1,
		items = {
			
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	Cooler_Beer = {
		rolls = 1,
		items = {
			"BeerBottle", 50,
			"BeerBottle", 20,
			"BeerBottle", 20,
			"BeerBottle", 10,
			"BeerBottle", 10,
			"BeerCan", 50,
			"BeerCan", 20,
			"BeerCan", 20,
			"BeerCan", 10,
			"BeerCan", 10,
			"BeerPack", 20,
			"BeerPack", 10,
			"BeerCanPack", 20,
			"BeerCanPack", 10,
			"Coldpack", 10,
			"Coldpack", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	Cooler_Meat = {
		rolls = 2,
		items = {
			"Chicken", 20,
			"Coldpack", 20,
			"Coldpack", 10,
			"HotdogPack", 50,
			"MeatPatty", 50,
			"MeatPatty", 50,
			"PorkChop", 20,
			"Sausage", 20,
			"Steak", 20,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	Cooler_Seafood = {
		rolls = 1,
		items = {
			"BlackCrappie", 1,
			"BlueCatfish", 1,
			"Bluegill", 1,
			"ChannelCatfish", 1,
			"Coldpack", 50,
			"Coldpack", 20,
			"Crayfish", 4,
			"FlatheadCatfish", 1,
			"FreshwaterDrum", 1,
			"LargemouthBass", 1,
			"Lobster", 0.1,
			"Mussels", 8,
			"Oysters", 8,
			"Salmon", 4,
			"Sauger", 1,
			"Shrimp", 8,
			"SmallmouthBass", 1,
			"SpottedBass", 1,
			"Squid", 0.5,
			"StripedBass", 1,
			"Walleye", 1,
			"WhiteBass", 1,
			"WhiteCrappie", 1,
			"YellowPerch", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	Cooler_Soda = {
		rolls = 2,
		items = {
			"Coldpack", 10,
			"Pop", 50,
			"Pop", 20,
			"Pop2", 50,
			"Pop2", 20,
			"Pop3", 50,
			"Pop3", 20,
			"PopBottle", 20,
			"PopBottleRare", 2,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	DiceBag = {
		rolls = 4,
		items = {
			"Dice", 20,
			"Dice", 10,
			"Dice_00", 20,
			"Dice_00", 10,
			"Dice_10", 20,
			"Dice_10", 10,
			"Dice_12", 20,
			"Dice_12", 10,
			"Dice_20", 20,
			"Dice_20", 10,
			"Dice_4", 20,
			"Dice_4", 10,
			"Dice_6", 20,
			"Dice_6", 10,
			"Dice_8", 20,
			"Dice_8", 10,
		},
		junk = {
			rolls = 3,
			items = {
				"Dice_00", 50,
				"Dice_10", 50,
				"Dice_12", 50,
				"Dice_20", 50,
				"Dice_4", 50,
				"Dice_6", 50,
				"Dice_8", 50,
				
			}
		}
	},

	FirstAidKit = BagsAndContainers.FirstAidKit,

	FirstAidKit = BagsAndContainers.FirstAidKit,

	FirstAidKit = BagsAndContainers.FirstAidKit,

	Flightcase = BagsAndContainers.Guitarcase,

	Garbagebag = {
		rolls = 1,
		items = {

		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	GemBag = {
		rolls = 4,
		items = {
			"Diamond", 50,
			"Diamond", 20,
			"Emerald", 50,
			"Emerald", 20,
			"Ruby", 50,
			"Ruby", 20,
			"Sapphire", 50,
			"Sapphire", 20,
		},
		junk = {
			rolls = 1,
			items = {
				"Diamond", 20,
				"Emerald", 20,
				"Loupe", 50,
				"Ruby", 20,
				"Sapphire", 20,
			}
		}
	},

	GroceryBag1 = {
		rolls = 1,
		items = {
			"Apple", 2,
			"Avocado", 1,
			"Bacon", 0.8,
			"BakingSoda", 1,
			"Baloney", 0.8,
			"Banana", 2,
			"BellPepper", 1,
			"BouillonCube", 1,
			"Broccoli", 2,
			"BrusselSprouts", 1,
			"Butter", 2,
			"Cabbage", 2,
			"CandyPackage", 1,
			"CannedBolognese", 1,
			"CannedCarrots2", 0.8,
			"CannedChili", 1,
			"CannedCorn", 0.8,
			"CannedCornedBeef", 1,
			"CannedFruitCocktail", 1,
			"CannedMilk", 0.4,
			"CannedMushroomSoup", 1,
			"CannedPeaches", 0.8,
			"CannedPeas", 0.8,
			"CannedPineapple", 0.8,
			"CannedPotato2", 0.8,
			"CannedSardines", 1,
			"CannedTomato2", 0.8,
			"Carrots", 2,
			"Cereal", 1,
			"Cheese", 2,
			"Cherry", 2,
			"Chicken", 0.8,
			"Chocolate", 1,
			"ChocolateChips", 1,
			"ChocolateCoveredCoffeeBeans", 1,
			"CocoaPowder", 1,
			"Coffee2", 1,
			"Corn", 2,
			"Crackers", 1,
			"Crisps", 1,
			"Crisps2", 1,
			"Crisps3", 1,
			"Crisps4", 1,
			"DriedBlackBeans", 0.8,
			"DriedChickpeas", 0.8,
			"DriedKidneyBeans", 0.8,
			"DriedLentils", 0.8,
			"DriedSplitPeas", 0.8,
			"DriedWhiteBeans", 0.8,
			"EggCarton", 0.8,
			"Eggplant", 2,
			"Flour2", 1,
			"GranolaBar", 1,
			"Grapefruit", 2,
			"Grapes", 2,
			"Gum", 1,
			"GummyBears", 1,
			"GummyWorms", 1,
			"Ham", 0.8,
			"HardCandies", 1,
			"Hotsauce", 0.25,
			"JellyBeans", 1,
			"JuiceBox", 1,
			"JuiceBoxApple", 1,
			"JuiceBoxFruitpunch", 1,
			"JuiceBoxOrange", 4,
			"Jujubes", 1,
			"Ketchup", 0.25,
			"Lard", 1,
			"Leek", 2,
			"Lemon", 2,
			"Lettuce", 2,
			"LicoriceBlack", 1,
			"LicoriceRed", 1,
			"Lime", 2,
			"Macandcheese", 1,
			"MapleSyrup", 0.25,
			"Margarine", 2,
			"MayonnaiseFull", 0.25,
			"MeatPatty", 0.8,
			"Milk", 4,
			"MincedMeat", 0.8,
			"MintCandy", 1,
			"Modjeska", 1,
			"Mustard", 0.25,
			"MuttonChop", 0.5,
			"OatsRaw", 1,
			"OilOlive", 1,
			"OilVegetable", 1,
			"Onion", 2,
			"Orange", 2,
			"Pasta", 1,
			"Peach", 2,
			"Peanuts", 1,
			"Pear", 2,
			"PepperJalapeno", 1,
			"Peppermint", 1,
			"Pickles", 6,
			"Pineapple", 1,
			"Pop", 4,
			"Pop2", 4,
			"Pop3", 4,
			"PopBottle", 2,
			"PopBottleRare", 0.05,
			"Popcorn", 1,
			"PorkChop", 0.8,
			"PorkRinds", 1,
			"Processedcheese", 6,
			"Ramen", 1,
			"RecipeClipping", 0.1,
			"RedRadish", 2,
			"RemouladeFull", 0.25,
			"Rice", 1,
			"RockCandy", 1,
			"Salami", 0.8,
			"Salmon", 0.5,
			"Sausage", 0.8,
			"Soysauce", 0.25,
			"Squash", 1,
			"Steak", 0.5,
			"Strewberrie", 2,
			"Sugar", 1,
			"SugarBrown", 1,
			"SunflowerSeeds", 1,
			"TVDinner", 1,
			"TacoShell", 1,
			"Teabag2", 1,
			"TinnedBeans", 1,
			"TinnedSoup", 1,
			"Tomato", 2,
			"Tortilla", 1,
			"TortillaChips", 1,
			"TunaTin", 1,
			"WaterBottle", 1,
			"WineBox", 1,
			"Yeast", 4,
			"Yoghurt", 1,
			"Zucchini", 2,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	GroceryBag2 = {
		rolls = 1,
		items = {
			"Apple", 4,
			"Avocado", 2,
			"Banana", 4,
			"BellPepper", 2,
			"Broccoli", 4,
			"BrusselSprouts", 1,
			"Cabbage", 4,
			"CannedCarrots2", 4,
			"CannedCorn", 4,
			"CannedFruitCocktail", 4,
			"CannedPeaches", 4,
			"CannedPeas", 4,
			"CannedPineapple", 4,
			"CannedPotato2", 4,
			"CannedTomato2", 4,
			"Carrots", 4,
			"Cherry", 4,
			"Corn", 4,
			"DriedBlackBeans", 4,
			"DriedChickpeas", 4,
			"DriedKidneyBeans", 4,
			"DriedLentils", 4,
			"DriedSplitPeas", 4,
			"DriedWhiteBeans", 4,
			"Eggplant", 4,
			"Grapefruit", 4,
			"Grapes", 4,
			"Leek", 4,
			"Lemon", 4,
			"Lettuce", 4,
			"Lime", 4,
			"OatsRaw", 2,
			"OilOlive", 2,
			"OilVegetable", 2,
			"Onion", 4,
			"Orange", 4,
			"Pasta", 2,
			"Peach", 4,
			"Pear", 4,
			"PepperJalapeno", 2,
			"Pickles", 6,
			"Pineapple", 2,
			"RecipeClipping", 0.1,
			"RedRadish", 4,
			"Rice", 2,
			"Squash", 1,
			"Strewberrie", 4,
			"Tomato", 4,
			"WaterBottle", 2,
			"WineBox", 1,
			"Yoghurt", 2,
			"Zucchini", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	GroceryBag3 = {
		rolls = 1,
		items = {
			"Candycane", 10,
			"CandyPackage", 10,
			"CannedBolognese", 10,
			"CannedChili", 10,
			"CannedFruitCocktail", 10,
			"CannedMushroomSoup", 10,
			"Chocolate", 20,
			"ChocolateCoveredCoffeeBeans", 10,
			"Crisps", 10,
			"Crisps2", 10,
			"Crisps3", 10,
			"Crisps4", 10,
			"GranolaBar", 20,
			"Gum", 20,
			"GummyBears", 10,
			"GummyWorms", 10,
			"HardCandies", 10,
			"JellyBeans", 10,
			"Jujubes", 10,
			"LicoriceBlack", 10,
			"LicoriceRed", 10,
			"MintCandy", 10,
			"Modjeska", 10,
			"Peppermint", 10,
			"Pop", 10,
			"Pop2", 10,
			"Pop3", 10,
			"PopBottle", 10,
			"PopBottleRare", 1,
			"Popcorn", 10,
			"PorkRinds", 8,
			"RecipeClipping", 0.1,
			"RockCandy", 10,
			"SunflowerSeeds", 10,
			"TinnedBeans", 10,
			"TinnedSoup", 10,
			"TortillaChips", 10,
			"TVDinner", 10,
			"WineBox", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	GroceryBag4 = {
		rolls = 1,
		items = {
			"Aluminum", 50,
			"BakingSoda", 50,
			"Butter", 20,
			"ChocolateChips", 50,
			"ChocolateChips", 10,
			"CocoaPowder", 50,
			"CocoaPowder", 10,
			"Flour2", 100,
			"Flour2", 20,
			"Lard", 20,
			"Margarine", 20,
			"OatsRaw", 20,
			"OilOlive", 20,
			"OilVegetable", 20,
			"RecipeClipping", 0.1,
			"Sugar", 50,
			"Sugar", 10,
			"SugarBrown", 20,
			"Yeast", 20,
			"WineBox", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	GroceryBag5 = {
		rolls = 1,
		items = {
			"Bacon", 20,
			"Crisps", 50,
			"Crisps", 10,
			"Crisps2", 50,
			"Crisps2", 10,
			"Crisps3", 50,
			"Crisps3", 10,
			"Crisps4", 50,
			"Crisps4", 10,
			"Ketchup", 50,
			"Lettuce", 20,
			"MayonnaiseFull", 20,
			"MincedMeat", 100,
			"MincedMeat", 100,
			"MincedMeat", 50,
			"MincedMeat", 50,
			"Mustard", 50,
			"Onion", 20,
			"Pickles", 20,
			"Pop", 50,
			"Pop", 10,
			"Pop2", 50,
			"Pop2", 10,
			"Pop3", 50,
			"Pop3", 10,
			"PopBottle", 50,
			"PopBottle", 10,
			"PopBottleRare", 4,
			"PorkRinds", 20,
			"PorkRinds", 10,
			"Processedcheese", 50,
			"Processedcheese", 10,
			"RecipeClipping", 0.1,
			"Steak", 50,
			"Steak", 50,
			"Steak", 20,
			"Steak", 20,
			"Tomato", 20,
			"TortillaChips", 50,
			"TortillaChips", 10,
			"WineBox", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	GroceryBagGourmet = {
		rolls = 1,
		items = {
			"BalsamicVinegar", 8,
			"CannedBellPepper", 10,
			"CannedBroccoli", 10,
			"CannedCabbage", 10,
			"CannedCarrots", 10,
			"CannedEggplant", 10,
			"CannedLeek", 10,
			"CannedPotato", 10,
			"CannedRedRadish", 10,
			"CannedTomato", 10,
			"Capers", 8,
			"GingerRoot", 8,
			"Hotsauce", 10,
			"Olives", 8,
			"RiceVinegar", 6,
			"Seasoning_Basil", 4,
			"Seasoning_Chives", 4,
			"Seasoning_Cilantro", 4,
			"Seasoning_Oregano", 4,
			"Seasoning_Parsley", 4,
			"Seasoning_Rosemary", 4,
			"Seasoning_Sage", 4,
			"Seasoning_Thyme", 4,
			"Soysauce", 8,
			"Wasabi", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	Guitarcase = BagsAndContainers.Guitarcase,

	HalloweenCandyBucket = BagsAndContainers.HalloweenCandyBucket,

	Handbag = BagsAndContainers.HandbagsAndPurses,

	Hatbox = Hatbox,

	HollowBook = {
		rolls = 1,
		items = {
			"Base.HempBagSeed", 10,
			"CigaretteRollingPapers", 10,
			"CreditCard", 50,
			"CreditCard", 20,
			"KnifeButterfly", 10,
			"Locket", 10,
			"MilitaryMedal", 0.1,
			"Money", 100,
			"Money", 50,
			"Money", 50,
			"Money", 50,
			"Photo", 50,
			"Photo", 20,
			"PillsVitamins", 10,
			"Revolver_Short", 10,
			"SmokingPipe", 10,
			"SwitchKnife", 10,
			"Whiskey", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	HollowBook_Handgun = {
		rolls = 10,
		items = {
			"MilitaryMedal", 0.001,
			"Revolver_Short", 50,
			"Pistol", 20,
			"Revolver", 20,
			"Revolver_Long", 20,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	HollowBook_Kids = {
		rolls = 1,
		items = {
			"Bracelet_LeftFriendshipTINT", 10,
			"CardDeck", 20,
			"ChessBlack", 10,
			"ChessWhite", 10,
			"ComicBook", 50,
			"ComicBook", 20,
			"Cube", 10,
			"DiceBag", 10,
			"Doll", 10,
			"DoodleKids", 50,
			"DoodleKids", 20,
			"Firecracker", 10,
			"Frog", 0.01,
			"GamePieceRed", 10,
			"GamePieceWhite", 10,
			"Harmonica", 10,
			"HottieZ", 1,
			"MagnifyingGlass", 20,
			"Money", 100,
			"Money", 50,
			"Money", 50,
			"Money", 50,
			"Photo", 50,
			"Photo", 20,
			"RubberSpider", 10,
			"VideoGame", 20,
			"WalkieTalkie1", 10,
			"Yoyo", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	-- Hidden contraband cache.
	HollowBook_Prison = {
		rolls = 1,
		items = {
			-- Money
			"Money", 100,
			"Money", 50,
			"Money", 50,
			"Money", 50,
			"Notepad", 50,
			-- Tobacco/Smoking
			"CigarettePack", 20,
			"CigaretteRollingPapers", 10,
			"Lighter", 10,
			"LighterDisposable", 20,
			"TobaccoChewing", 10,
			"TobaccoLoose", 10,
			-- Contraband
			"File", 50,
			"Flask", 20,
			"Pager", 50,
			"Pills", 20,
			"Pills", 50,
			"PillsVitamins", 50,
			"PillsVitamins", 20,
			-- Weapons
			"CrudeKnife", 10,
			"GlassShiv", 20,
			"IcePick", 10,
			"KnifeButterfly", 10,
			"KnifePocket", 0.1,
			"KnifeShiv", 50,
			"SwitchKnife", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	-- Hidden stash of stolen goods.
	HollowBook_Valuables = {
		rolls = 1,
		items = {
			-- Money
			"Money", 100,
			"Money", 100,
			"Money", 100,
			"Money", 100,
			"Money", 100,
			"Money", 100,
			-- Stolen Goods
			"CreditCard_Stolen", 100,
			"CreditCard_Stolen", 50,
			"CreditCard_Stolen", 20,
			"CreditCard_Stolen", 20,
			"Diamond", 1,
			"Emerald", 1,
			"GemBag", 1,
			"IDcard_Blank", 1,
			"Ruby", 1,
			"Sapphire", 1,
			"StockCertificate", 20,
			"StockCertificate", 10,
			-- Misc.
			"Flask", 10,
			"PillsVitamins", 10,
			"PokerChips", 10,
			"Revolver_Short", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	-- I don't have a drinking problem, I swear!
	HollowBook_Whiskey = {
		rolls = 1,
		items = {
			"Whiskey", 200,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	Humidor = BagsAndContainers.CigarBox,

	JewelleryBox = BagsAndContainers.JewelleryBox,

	JewelleryBox_Fancy = BagsAndContainers.JewelleryBox_Fancy,

	KeyRing = BagsAndContainers.KeyRing,

	-- Keyring with keys for various cars around the lot.
	KeyRing_CarDealer = {
		rolls = 2,
		items = {
			"CarKey", 50,
			"CarKey", 50,
			"CarKey", 50,
			"CarKey", 50,
			"CarKey", 50,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	-- Same as above, but unique.
	KeyRing_Nolans = {
		rolls = 2,
		items = {
			"CarKey", 50,
			"CarKey", 50,
			"CarKey", 50,
			"CarKey", 50,
			"CarKey", 50,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	KeyRing_Bass = BagsAndContainers.KeyRingOutdoors,

	KeyRing_BlueFox = BagsAndContainers.KeyRing,

	KeyRing_Bug = BagsAndContainers.KeyRing,

	KeyRing_Clover = BagsAndContainers.KeyRing,

	KeyRing_EagleFlag = BagsAndContainers.KeyRingOutdoors,

	KeyRing_EightBall = BagsAndContainers.KeyRing,

	KeyRing_Hotdog = BagsAndContainers.KeyRing,

	KeyRing_Kitty = BagsAndContainers.KeyRing,

	KeyRing_Large = BagsAndContainers.KeyRing,

	KeyRing_Panther = BagsAndContainers.KeyRing,

	KeyRing_PineTree = BagsAndContainers.KeyRingOutdoors,

	KeyRing_PrayingHands = BagsAndContainers.KeyRing,

	KeyRing_RabbitFoot = BagsAndContainers.KeyRing,

	KeyRing_RainbowStar = BagsAndContainers.KeyRing,

	KeyRing_RubberDuck = BagsAndContainers.KeyRing,

	KeyRing_SecurityPass = BagsAndContainers.KeyRing,

	KeyRing_Sexy = BagsAndContainers.KeyRing,

	KeyRing_Spiffos = BagsAndContainers.KeyRing,

	KeyRing_StinkyFace = BagsAndContainers.KeyRing,

	KeyRing_WestMaple = BagsAndContainers.KeyRing,

	Lunchbag = BagsAndContainers.Lunchbox,

	Lunchbox = BagsAndContainers.Lunchbox,

	Lunchbox2 = BagsAndContainers.Lunchbox,

	MakeupCase_Professional = BagsAndContainers.MakeupCase_Professional,

	-- Empty paper bag for lunches or whatever.
	PaperBag = {
		rolls = 1,
		items = {
			
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	-- Paper bag with fried chicken and sides.
	Paperbag_Jays = {
		rolls = 1,
		items = {
			-- Fried Chicken
			"ChickenFried", 200,
			"ChickenFried", 50,
			"ChickenFried", 20,
			"ChickenFried", 10,
			-- Side Dishes
			"Fries", 50,
			"Fries", 20,
			"Fries", 10,
			"Cornbread", 50,
			"Cornbread", 20,
			"Cornbread", 10,
			-- Misc.
			"PaperNapkins2", 200,
			"PaperNapkins2", 50,
			"PlasticKnife", 50,
			"PlasticFork", 50,
			"Straw2", 100,
			"Straw2", 50,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	-- Ten Gallon Burger. Pure Beef.
	Paperbag_Spiffos = {
		rolls = 1,
		items = {
			-- Burgers
			"Burger", 200,
			"Burger", 50,
			"Burger", 20,
			"Burger", 10,
			-- Side Dishes
			"Fries", 50,
			"Fries", 20,
			"Fries", 10,
			"FriedOnionRings", 50,
			"FriedOnionRings", 20,
			"FriedOnionRings", 10,
			-- Misc.
			"PaperNapkins2", 200,
			"PaperNapkins2", 50,
			"Straw2", 100,
			"Straw2", 50,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	Parcel_ExtraLarge = BagsAndContainers.Parcel_ExtraLarge,

	Parcel_ExtraSmall = BagsAndContainers.Parcel_ExtraSmall,

	Parcel_Large = BagsAndContainers.Parcel_Large,

	Parcel_Medium = BagsAndContainers.Parcel_Medium,

	Parcel_Small = BagsAndContainers.Parcel_Small,

	PencilCase = BagsAndContainers.PencilCase,

	-- Photo album with photos of past moments from people's lives.
	PhotoAlbum = {
		rolls = 4,
		items = {
			-- Photos
			"Photo", 50,
			"Photo", 20,
			"Photo", 20,
			"Photo", 10,
			"Photo_VeryOld", 1,
			-- Memorabilia
			"Postcard", 10,
			"Doodle", 10,
			"LetterHandwritten", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	-- Same as above but with even older photos.
	PhotoAlbum_Old = {
		rolls = 4,
		items = {
			-- Photos
			"Photo_VeryOld", 50,
			"Photo_VeryOld", 20,
			"Photo_VeryOld", 20,
			"Photo_VeryOld", 10,
			-- Memorabilia
			"Postcard", 20,
			"LetterHandwritten", 20,
			"Locket", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	PistolCase1 = BagsAndContainers.PistolCase1,

	PistolCase2 = BagsAndContainers.PistolCase2,

	PistolCase3 = BagsAndContainers.PistolCase3,

	-- Empty plastic bag.
	Plasticbag = {
		rolls = 1,
		items = {

		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	Plasticbag_Bags = BagsAndContainers.Plasticbags,

	Plasticbag_Clothing = BagsAndContainers.Clothing_Generic,

	Present_ExtraLarge = BagsAndContainers.Parcel_ExtraLarge,

	Present_ExtraSmall = BagsAndContainers.Parcel_ExtraSmall,

	Present_Large = BagsAndContainers.Parcel_Large,

	Present_Medium = BagsAndContainers.Parcel_Medium,

	Present_Small = BagsAndContainers.Parcel_Small,

	Purse = BagsAndContainers.HandbagsAndPurses,

	RevolverCase1 = BagsAndContainers.RevolverCase1,

	RevolverCase2 = BagsAndContainers.RevolverCase2,

	RevolverCase3 = BagsAndContainers.RevolverCase3,

	RifleCase1 = BagsAndContainers.RifleCase1,

	RifleCase2 = BagsAndContainers.RifleCase2,

	RifleCase3 = BagsAndContainers.RifleCase3,

	RifleCase4 = BagsAndContainers.RifleCase4,

	-- Generic seedbag. Weighted towards garden herbs.
	SeedBag = {
		rolls = 4,
		items = {
			-- Herbs
			"BasilBagSeed", 2,
			"ChamomileBagSeed", 2,
			"ChivesBagSeed", 2,
			"CilantroBagSeed", 2,
			"LemonGrassBagSeed", 2,
			"MarigoldBagSeed", 2,
			"MintBagSeed", 2,
			"OreganoBagSeed", 2,
			"ParsleyBagSeed", 2,
			"RosemaryBagSeed", 2,
			"SageBagSeed", 2,
			"ThymeBagSeed", 2,
			-- Fruits
			"StrewberrieBagSeed2", 2,
			"WatermelonBagSeed", 0.5,
			-- Vegetables
			"BellPepperBagSeed", 1,
			"BroccoliBagSeed2", 2,
			"CabbageBagSeed2", 2,
			"CarrotBagSeed2", 2,
			"CauliflowerBagSeed", 2,
			"CucumberBagSeed", 2,
			"GarlicBagSeed", 2,
			"GreenpeasBagSeed", 2,
			"HabaneroBagSeed", 0.5,
			"JalapenoBagSeed", 1,
			"KaleBagSeed", 1,
			"LeekBagSeed", 1,
			"LettuceBagSeed", 1,
			"OnionBagSeed", 2,
			"PotatoBagSeed2", 2,
			"PumpkinBagSeed", 0.5,
			"RedRadishBagSeed2", 2,
			"SpinachBagSeed", 1,
			"SugarBeetBagSeed", 0.5,
			"SweetPotatoBagSeed", 0.5,
			"TomatoBagSeed2", 2,
			"TurnipBagSeed", 1,
			"ZucchiniBagSeed", 2,
			-- Seed Crops
			"CornBagSeed", 1,
			"FlaxBagSeed", 0.5,
			"HopsBagSeed", 0.1,
			"RyeBagSeed", 0.5,
			"BarleyBagSeed", 0.5,
			"WheatBagSeed", 0.5,
			-- Misc.
			"TobaccoBagSeed", 0.1,
			"SunflowerBagSeed", 2,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	-- Farmer's seedbag. Weighted towards seed crops.
	SeedBag_Farming = {
		rolls = 4,
		items = {
			-- Seed Crops
			"CornBagSeed", 8,
			"FlaxBagSeed", 4,
			"HopsBagSeed", 2,
			"RyeBagSeed", 4,
			"BarleyBagSeed", 4,
			"WheatBagSeed", 8,
			-- Herbs
			"BasilBagSeed", 0.1,
			"ChamomileBagSeed", 0.1,
			"ChivesBagSeed", 0.1,
			"CilantroBagSeed", 0.1,
			"LemonGrassBagSeed", 0.1,
			"MarigoldBagSeed", 0.1,
			"MintBagSeed", 0.1,
			"OreganoBagSeed", 0.1,
			"ParsleyBagSeed", 0.1,
			"RosemaryBagSeed", 0.1,
			"SageBagSeed", 0.1,
			"ThymeBagSeed", 0.1,
			-- Fruits
			"StrewberrieBagSeed2", 2,
			"WatermelonBagSeed", 2,
			-- Vegetables
			"BellPepperBagSeed", 1,
			"BroccoliBagSeed2", 1,
			"CabbageBagSeed2", 1,
			"CarrotBagSeed2", 1,
			"CauliflowerBagSeed", 1,
			"CucumberBagSeed", 1,
			"GarlicBagSeed", 1,
			"GreenpeasBagSeed", 1,
			"HabaneroBagSeed", 0.5,
			"JalapenoBagSeed", 1,
			"KaleBagSeed", 1,
			"LeekBagSeed", 1,
			"LettuceBagSeed", 1,
			"OnionBagSeed", 2,
			"PotatoBagSeed2", 2,
			"PumpkinBagSeed", 2,
			"RedRadishBagSeed2", 1,
			"SpinachBagSeed", 1,
			"SugarBeetBagSeed", 2,
			"SweetPotatoBagSeed", 2,
			"TomatoBagSeed2", 1,
			"TurnipBagSeed", 1,
			"ZucchiniBagSeed", 1,
			-- Misc.
			"TobaccoBagSeed", 1,
			"SunflowerBagSeed", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	-- Small kit with needle and thread. Usually has other sewing-related tools.
	SewingKit = {
		rolls = 1,
		items = {
			-- Tools
			"Awl", 10,
			"Needle", 200,
			"Needle", 100,
			"Needle", 50,
			"Needle", 20,
			"Scissors", 10,
			"Thimble", 50,
			"Thimble", 20,
			-- Buckles/Buttons
			"Buckle", 20,
			"Buckle", 10,
			"Button", 50,
			"Button", 50,
			"Button", 20,
			"Button", 20,
			-- Materials
			"Thread", 200,
			"Thread", 50,
			"Thread", 50,
			"Thread", 20,
			-- Misc.
			"IndustrialDye", 4,
			"MeasuringTape", 20,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	Shoebox = BagsAndContainers.Shoebox,

	ShotgunCase1 = BagsAndContainers.ShotgunCase1,

	ShotgunCase2 = BagsAndContainers.ShotgunCase2,

	Suitcase = BagsAndContainers.Clothing_Generic,

	Tacklebox = BagsAndContainers.Tacklebox,

	TakeoutBox_Chinese = BagsAndContainers.TakeoutBox_Chinese,

	TakeoutBox_Styrofoam = BagsAndContainers.TakeoutBox_Styrofoam,

	Toolbox = BagsAndContainers.Toolbox,

	Toolbox_Wooden = BagsAndContainers.Toolbox,

	Toolbox_Farming = BagsAndContainers.Farming,

	Toolbox_Fishing = BagsAndContainers.Tacklebox,

	Toolbox_Gardening = BagsAndContainers.Gardening,

	Toolbox_Mechanic = {
		rolls = 3,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing_Bass", 0.001,
			"KeyRing_EagleFlag", 0.001,
			"KeyRing_EightBall", 0.001,
			"KeyRing_Hotdog", 0.001,
			"KeyRing_Panther", 0.001,
			"KeyRing_PineTree", 0.001,
			"KeyRing_PrayingHands", 0.001,
			"KeyRing_Sexy", 0.001,
			"KeyRing", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Tools
			"Calipers", 4,
			"HandDrill", 2,
			"Jack", 4,
			"LugWrench", 8,
			"Pliers", 4,
			"Ratchet", 8,
			"Screwdriver", 8,
			"TireIron", 8,
			"TirePump", 4,
			"ViseGrips", 2,
			"Wrench", 8,
			-- Materials
			"DuctTape", 1,
			"ElectricWire", 8,
			"Epoxy", 4,
			"FiberglassTape", 4,
			"Funnel", 8,
			"KnifePocket", 0.1,
			"NutsBolts", 2,
			"RippedSheets", 2,
			"RippedSheetsDirty", 8,
			"RubberHose", 8,
			-- Accessories
			"ElbowPad_Left_Workman", 0.5,
			"FlashLight_AngleHead", 4,
			"Glasses_SafetyGoggles", 4,
			"HandTorch", 2,
			"Hat_BuildersRespirator", 2,
			"Kneepad_Left_Workman", 2,
			"PenLight", 6,
			-- Misc.
			"Flask", 1,
			"HottieZ", 1,
			"TobaccoChewing", 1,
			-- Literature (Skills/Recipe)
			"BookMechanic1", 8,
			"BookMechanic2", 4,
			"BookMechanic3", 2,
			"MechanicMag1", 2,
			"MechanicMag2", 2,
			"MechanicMag3", 2,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},

	ToolRoll_Leather = BagsAndContainers.Toolbox,
	
	-- Professional kitchen tools for skilled chefs.
	ToolRoll_Fabric = {
		rolls = 3,
		items = {
			-- Slicing/Chopping
			"KitchenKnife", 20,
			"KitchenKnifeForged", 10,
			"KnifeFillet", 20,
			"KnifeParing", 20,
			"KnifeSushi", 10,
			-- Grilling
			"BastingBrush", 8,
			"CarvingFork2", 8,
			"GrillBrush", 8,
			"KitchenTongs", 8,
			"Spatula", 8,
			-- Misc.
			"Whetstone", 10,
			"Ladle", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	-- Empty tote bag for fancy stores.
	Tote = {
		rolls = 1,
		items = {
			
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	Tote_Bags = BagsAndContainers.Plasticbags,

	Tote_Clothing = BagsAndContainers.Clothing_Generic,

	Wallet = BagsAndContainers.Wallet,

	Wallet_Female = BagsAndContainers.Wallet_Female,

	Wallet_Male = BagsAndContainers.Wallet_Male,
	
	-- Sack of dried wheat sheaves.
	WheatSack = {
		rolls = 6,
		items = {
			"WheatSheafDried", 100,
			"WheatSheafDried", 100,
			"WheatSheafDried", 100,
			"WheatSheafDried", 100,
			"WheatSheafDried", 100,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Sack of wheat seeds.
	WheatSeedSack = {
		rolls = 10,
		items = {
			"WheatSeed", 100,
			"WheatSeed", 100,
			"WheatSeed", 100,
			"WheatSeed", 100,
			"WheatSeed", 100,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- =====================
	--	  PROFESSIONS
	-- =====================
	
--	AmbulanceDriver = {
--		vehicleChance = 50,
--		professionChanceInt = 20,
--		outfit = "AmbulanceDriver",
--		vehicle = "Base.VanAmbulance",
--		vehicleDistribution = "VehicleDistributions.Ambulance",
--		roomTypes = "bathroom;bedroom;closet;kitchen",
--		containerChance = "70",
--		bagType = "Base.Bag_MedicalBag",
--		body = {
--			rolls = 3,
--			items = {
--				"AlcoholWipes", 20,
--				"AlcoholWipes", 20,
--				"Bandage", 20,
--				"Bandage", 20,
--				"Bandaid", 20,
--				"Bandaid", 20,
--				"BookFirstAid1", 6,
--				"BookFirstAid2", 4,
--				"BookFirstAid3", 2,
--				"BookFirstAid4", 1,
--				"BookFirstAid5", 0.5,
--				"FirstAidKit", 2,
--				"PenLight", 10,
--				"Pills", 20,
--				"Pills", 20,
--				"TongueDepressor", 10,
--				"Tweezers", 10,
--			}
--		},
--		cardboardbox = {
--			procedural = true,
--			procList = {
--				{name="AmbulanceDriverTools", min=1, max=4},
--			}
--		},
--		counter = {
--			procedural = true,
--			procList = {
--				{name="AmbulanceDriverTools", min=1, max=4},
--			}
--		},
--		crate = {
--			procedural = true,
--			procList = {
--				{name="AmbulanceDriverTools", min=1, max=4},
--			}
--		},
--		dresser = {
--			procedural = true,
--			procList = {
--				{name="AmbulanceDriverOutfit", min=1, max=1},
--			}
--		},
--		medicine = {
--			rolls = 3,
--			items = {
--				"AlcoholWipes", 10,
--				"AlcoholWipes", 10,
--				"Bandage", 20,
--				"Bandage", 20,
--				"Bandaid", 20,
--				"Bandaid", 20,
--				"Disinfectant", 20,
--				"PenLight", 10,
--				"Pills", 20,
--				"Pills", 20,
--				"TongueDepressor", 10,
--				"Tweezers", 10,
--			}
--		},
--		metal_shelves = {
--			procedural = true,
--			procList = {
--				{name="AmbulanceDriverTools", min=1, max=4},
--			}
--		},
--		wardrobe = {
--			procedural = true,
--			procList = {
--				{name="AmbulanceDriverOutfit", min=1, max=2},
--			}
--		},
--		smallbox = cardboardbox,
--	},
--
	BandPractice = {
		roomTypes = "closet;garage",
		cardboardbox = {
			procedural = true,
			procList = {
				{name="BandPracticeClothing", min=0, max=99, weightChance=100},
				{name="BandPracticeInstruments", min=0, max=99, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="BandPracticeClothing", min=0, max=99, weightChance=100},
				{name="BandPracticeInstruments", min=0, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="BandPracticeClothing", min=0, max=99, weightChance=100},
				{name="BandPracticeInstruments", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="BandPracticeClothing", min=0, max=99, weightChance=100},
				{name="BandPracticeInstruments", min=0, max=99, weightChance=100},
			}
		},
	},

	Carpenter = {
		-- this is the default value that the original code used, when is house is initialized, a random profession is chosen and there a 20% chance of it being applied
		vehicleChance = 50, -- this is the default value
		professionChanceInt = 20,
		outfit = "ConstructionWorker",
		outfitMale = "ConstructionWorker",
		outfitChance = "100", -- currently unused
		femaleOdds = "0",
		-- vehicle = "Base.PickUpVan",
		vehicle = "trades",
		-- vehicles = "Base.Van;Base.StepVan;Base.PickUpVan;Base.PickUpTruck",
		vehicleDistribution = "Carpenter",
		roomTypes = "bedroom;closet;garage;kitchen",
		containerChance = "70", -- this is the default value that the original code used
		bagType = "Base.Toolbox",
		body = {
			rolls = 4,
			items = {
				"BookCarpentry1", 6,
				"BookCarpentry2", 4,
				"BookCarpentry3", 2,
				"BookCarpentry4", 1,
				"BookCarpentry5", 0.5,
				"DuctTape", 2,
				"Glue", 2,
				"Hammer", 20,
				"Nails", 10,
				"Nails", 10,
				"NailsBox", 4,
				"Saw", 10,
				"Screwdriver", 8,
				"Twine", 2,
				"Woodglue", 10,
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="CarpenterTools", min=1, max=4},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="CarpenterTools", min=1, max=4},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="CarpenterTools", min=1, max=4},
			}
		},
		dresser = {
			procedural = true,
			procList = {
				{name="CarpenterOutfit", min=1, max=1},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="CarpenterTools", min=1, max=4},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="CarpenterTools", min=1, max=4},
			}
		},
		wardrobe = {
			procedural = true,
			procList = {
				{name="CarpenterOutfit", min=1, max=2},
			}
		},
	},

	Chef = {
		-- this is the default value that the original code used, when is house is initialized, a random profession is chosen and there a 20% chance of it being applied
		vehicleChance = 50, -- this is the default value
		professionChanceInt = 20,
		outfit = "Chef",
		outfitFemale = "Chef",
		outfitMale = "Chef",
		outfitChance = "100", -- currently unused
		femaleOdds = "50",
		-- vehicle = "Base.StepVan",
		vehicle = "middleClass",
		-- vehicles = "Base.CarNormal;Base.SmallCar;Base.SmallCar02;Base.CarStationWagon;Base.CarStationWagon2;Base.StepVan;Base.Van;Base.VanSeats;Base.SUV",
		vehicleDistribution = "Groceries",
		roomTypes = "bedroom;closet;kitchen",
		containerChance = "70", -- this is the default value that the original code used
		bagType = "Base.GroceryBag4",
		body = {
			rolls = 4,
			items = {
				"BookCooking1", 6,
				"BookCooking2", 4,
				"BookCooking3", 2,
				"BookCooking4", 1,
				"BookCooking5", 0.5,
				"CookingMag1", 0.5,
				"CookingMag2", 0.5,
				"CookingMag3", 0.5,
				"CookingMag4", 0.5,
				"CookingMag5", 0.5,
				"CookingMag6", 0.5,
				"RecipeClipping", 20,
				"KnifeFillet", 10,
				"KitchenKnife", 10,
				"KnifeSushi", 1,
				"KnifeParing", 10,
				"MeatCleaver", 10,
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="ChefTools", min=1, max=4},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="ChefTools", min=1, max=4},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="ChefTools", min=1, max=4},
			}
		},
		dresser = {
			procedural = true,
			procList = {
				{name="ChefOutfit", min=1, max=1},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="ChefTools", min=1, max=4},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="ChefTools", min=1, max=4},
			}
		},
		wardrobe = {
			procedural = true,
			procList = {
				{name="ChefOutfit", min=1, max=2},
			}
		},
	},

--	ConstructionWorker = {
--		vehicleChance = 50,
--		professionChanceInt = 20,
--		outfit = "ConstructionWorker",
--		outfitMale = "ConstructionWorker",
--		outfitChance = "100",
--		femaleOdds = "0",
--		vehicle = "trades",
--		vehicleDistribution = "ConstructionWorker",
--		roomTypes = "closet;garage;kitchen",
--		containerChance = "70",
--		bagType = "Base.Toolbox",
--		body = {
--			rolls = 4,
--			items = {
--				"BookCarpentry1", 3,
--				"BookCarpentry2", 2,
--				"BookCarpentry3", 1,
--				"BookCarpentry4", 0.5,
--				"BookCarpentry5", 0.25,
--				"BookMetalWelding1", 3,
--				"BookMetalWelding2", 2,
--				"BookMetalWelding3", 1,
--				"BookMetalWelding4", 0.5,
--				"BookMetalWelding5", 0.25,
--				"DuctTape", 4,
--				"Glue", 2,
--				"BallPeenHammer", 20,
--				"Nails", 10,
--				"Nails", 10,
--				"NailsBox", 4,
--				"NailsBox", 4,
--				"Saw", 10,
--				"Screwdriver", 10,
--				"Twine", 2,
--				"Woodglue", 10,
--			}
--		},
--		cardboardbox = {
--			procedural = true,
--			procList = {
--				{name="ConstructionWorkerTools", min=1, max=4},
--			}
--		},
--		counter = {
--			procedural = true,
--			procList = {
--				{name="ConstructionWorkerTools", min=1, max=4},
--			}
--		},
--		crate = {
--			procedural = true,
--			procList = {
--				{name="ConstructionWorkerTools", min=1, max=4},
--			}
--		},
--		dresser = {
--			procedural = true,
--			procList = {
--				{name="ConstructionWorkerOutfit", min=1, max=1},
--			}
--		},
--		metal_shelves = {
--			procedural = true,
--			procList = {
--				{name="ConstructionWorkerTools", min=1, max=4},
--			}
--		},
--		smallbox = cardboardbox,
--		wardrobe = {
--			procedural = true,
--			procList = {
--				{name="ConstructionWorkerOutfit", min=1, max=2},
--			}
--		},
--	},
--
--	Doctor = {
--		vehicleChance = 50, -- this is the default value
--		-- this is the default value that the original code used, when is house is initialized, a random profession is chosen and there a 20% chance of it being applied
--		professionChanceInt = 20,
--		outfit = "Doctor",
--		outfitFemale = "Doctor",
--		outfitMale = "Doctor",
--		outfitChance = "100", -- currently unused
--		-- vehicle = "Base.SmallCar02",
--		vehicle = "middleClass",
--		-- vehicles = "Base.CarNormal;Base.SmallCar;Base.SmallCar02;Base.CarStationWagon;Base.CarStationWagon2;Base.VanSeats;Base.SUV",
--		vehicleDistribution = "Doctor",
--		roomTypes = "bathroom;bedroom;closet;kitchen",
--		-- femaleOdds = "75",
--		containerChance = "70", -- this is the default value that the original code used
--		bagType = "Base.Bag_MedicalBag",
--		body = {
--			rolls = 4,
--			items = {
--				"AlcoholWipes", 20,
--				"AlcoholWipes", 20,
--				"Bandage", 20,
--				"Bandage", 20,
--				"Bandaid", 20,
--				"Bandaid", 20,
--				"BookFirstAid1", 6,
--				"BookFirstAid2", 4,
--				"BookFirstAid3", 2,
--				"BookFirstAid4", 1,
--				"BookFirstAid5", 0.5,
--				"FirstAidKit", 2,
--				"Gloves_Surgical", 10,
--				"Hat_SurgicalMask", 10,
--				"PenLight", 10,
--				"Pills", 20,
--				"Pills", 20,
--				"PillsAntiDep", 20,
--				"PillsBeta", 20,
--				"PillsSleepingTablets", 20,
--				"Scalpel", 10,
--				"SutureNeedle", 10,
--				"SutureNeedle", 10,
--				"SutureNeedleHolder", 10,
--				"TongueDepressor", 10,
--				"Tweezers", 10,
--			}
--		},
--		cardboardbox = {
--			procedural = true,
--			procList = {
--				{name="DoctorTools", min=1, max=4},
--			}
--		},
--		counter = {
--			procedural = true,
--			procList = {
--				{name="DoctorTools", min=1, max=4},
--			}
--		},
--		crate = {
--			procedural = true,
--			procList = {
--				{name="DoctorTools", min=1, max=4},
--			}
--		},
--		dresser = {
--			procedural = true,
--			procList = {
--				{name="DoctorOutfit", min=1, max=1},
--			}
--		},
--		medicine = {
--			rolls = 3,
--			items = {
--				"AlcoholWipes", 20,
--				"AlcoholWipes", 20,
--				"Bandage", 20,
--				"Bandage", 20,
--				"Bandaid", 20,
--				"Bandaid", 20,
--				"Disinfectant", 20,
--				"PenLight", 10,
--				"Pills", 20,
--				"Pills", 20,
--				"TongueDepressor", 10,
--				"Tweezers", 10,
--			}
--		},
--		metal_shelves = {
--			procedural = true,
--			procList = {
--				{name="DoctorTools", min=1, max=4},
--			}
--		},
--		smallbox = cardboardbox,
--		wardrobe = {
--			procedural = true,
--			procList = {
--				{name="DoctorOutfit", min=1, max=2},
--			}
--		},
--	},
--
--	Electrician = {
--		-- this is the default value that the original code used, when is house is initialized, a random profession is chosen and there a 20% chance of it being applied
--		vehicleChance = 50, -- this is the default value
--		professionChanceInt = 20,
--		outfit = "ConstructionWorker",
--		outfitMale = "ConstructionWorker",
--		outfitChance = "100", -- currently unused
--		femaleOdds = "0",
--		-- vehicle = "Base.Van",
--		vehicle = "trades",
--		-- vehicles = "Base.Van;Base.StepVan;Base.PickUpVan;Base.PickUpTruck",
--		vehicleDistribution = "Electrician",
--		roomTypes = "bedroom;closet;garage;kitchen",
--		containerChance = "70", -- this is the default value that the original code used
--		bagType = "Base.Toolbox",
--		body = {
--			rolls = 4,
--			items = {
--				"Aluminum", 8,
--				"Amplifier", 8,
--				"BookElectrician1", 6,
--				"BookElectrician2", 4,
--				"BookElectrician3", 2,
--				"BookElectrician4", 1,
--				"BookElectrician5", 0.5,
--				"DuctTape", 4,
--				"ElectricWire", 10,
--				"ElectronicsMag1", 2,
--				"ElectronicsMag2", 2,
--				"ElectronicsMag3", 2,
--				"ElectronicsMag4", 1,
--				"ElectronicsMag5", 2,
--				"ElectronicsScrap", 10,
--				"ElectronicsScrap", 10,
--				"EngineerMagazine1", 2,
--				"EngineerMagazine2", 2,
								
--				"MetalPipe", 6,
--				"MotionSensor", 8,
--				"RadioMag1", 3,
--				"RadioMag2", 2,
--				"RadioMag3", 1,
--				"RemoteCraftedV1", 8,
--				"RemoteCraftedV2", 4,
--				"RemoteCraftedV3", 2,
--				"ScrapMetal", 4,
--				"Screwdriver", 5,
--				"Sparklers", 10,
--				"TimerCrafted", 8,
--				"TriggerCrafted", 8,
--				"Twine", 10,
--			}
--		},
--		cardboardbox = {
--			procedural = true,
--			procList = {
--				{name="ElectricianTools", min=1, max=4},
--			}
--		},
--		counter = {
--			procedural = true,
--			procList = {
--				{name="ElectricianTools", min=1, max=4},
--			}
--		},
--		crate = {
--			procedural = true,
--			procList = {
--				{name="ElectricianTools", min=1, max=4},
--			}
--		},
--		dresser = {
--			procedural = true,
--			procList = {
--				{name="ElectricianOutfit", min=1, max=1},
--			}
--		},
--		metal_shelves = {
--			procedural = true,
--			procList = {
--				{name="ElectricianTools", min=1, max=4},
--			}
--		},
--		smallbox = cardboardbox,
--		wardrobe = {
--			procedural = true,
--			procList = {
--				{name="ElectricianOutfit", min=1, max=2},
--			}
--		},
--	},
--
	Farmer = { -- this also includes landscapers and gardeners
		-- this is the default value that the original code used, when is house is initialized, a random profession is chosen and there a 20% chance of it being applied
		vehicleChance = 50, -- this is the default value
		professionChanceInt = 20,
		outfit = "Farmer",
		outfitFemale = "Farmer",
		outfitMale = "Farmer",
		outfitChance = "100", -- currently unused
		femaleOdds = "50",
		-- vehicle = "Base.PickUpVan",
		vehicle = "trades",
		-- vehicles = "Base.PickUpVan;Base.PickUpTruck",
		vehicleDistribution = "Farmer",
		roomTypes = "bedroom;closet;garage;kitchen",
		containerChance = "70", -- this is the default value that the original code used
		bagType = "Base.SeedBag",
		body = {
			rolls = 4,
			items = {
				"Base.BasilBagSeed", 8,
				"Base.BroccoliBagSeed2", 8,
				"Base.CabbageBagSeed2", 8,
				"Base.CarrotBagSeed2", 8,
				"Base.ChivesBagSeed", 8,
				"Base.CilantroBagSeed", 8,
				"Base.CornBagSeed", 8,
				"Base.GarlicBagSeed", 8,
				"Base.GreenpeasBagSeed", 8,
				"Base.KaleBagSeed", 8,
				"Base.OnionBagSeed", 8,
				"Base.OreganoBagSeed", 8,
				"Base.ParsleyBagSeed", 8,
				"Base.PotatoBagSeed2", 8,
				"Base.RedRadishBagSeed2", 8,
				"Base.RosemaryBagSeed", 8,
				"Base.SageBagSeed", 8,
				"Base.StrewberrieBagSeed2", 8,
				"Base.SweetPotatoBagSeed", 8,
				"Base.ThymeBagSeed", 8,
				"Base.TomatoBagSeed2", 8,
				"BookFarming1", 6,
				"BookFarming2", 4,
				"BookFarming3", 2,
				"BookFarming4", 1,
				"BookFarming5", 0.5,
				"BookHusbandry1", 6,
				"BookHusbandry2", 4,
				"BookHusbandry3", 2,
				"BookHusbandry4", 1,
				"BookHusbandry5", 0.5,
				"FarmingMag1", 2,
				"FarmingMag2", 2,
				"FarmingMag3", 2,
				"FarmingMag4", 2,
				"FarmingMag5", 2,
				"FarmingMag6", 2,
				"FarmingMag7", 2,
				"FarmingMag8", 2,
				"HandShovel", 6,
				"SeedBag", 10,
				"Shovel", 6,
				"WateredCan", 6,
			}
		},
		counter = {
			rolls = 4,
			items = {
				"Base.BasilBagSeed", 8,
				"Base.BroccoliBagSeed2", 8,
				"Base.CabbageBagSeed2", 8,
				"Base.CarrotBagSeed2", 8,
				"Base.ChivesBagSeed", 8,
				"Base.CilantroBagSeed", 8,
				"Base.CornBagSeed", 8,
				"Base.GarlicBagSeed", 8,
				"Base.GreenpeasBagSeed", 8,
				"Base.KaleBagSeed", 8,
				"Base.OnionBagSeed", 8,
				"Base.OreganoBagSeed", 8,
				"Base.ParsleyBagSeed", 8,
				"Base.PotatoBagSeed2", 8,
				"Base.RedRadishBagSeed2", 8,
				"Base.RosemaryBagSeed", 8,
				"Base.SageBagSeed", 8,
				"Base.StrewberrieBagSeed2", 8,
				"Base.SweetPotatoBagSeed", 8,
				"Base.ThymeBagSeed", 8,
				"Base.TomatoBagSeed2", 8,
				"BookFarming1", 6,
				"BookFarming2", 4,
				"BookFarming3", 2,
				"BookFarming4", 1,
				"BookFarming5", 0.5,
				"BookHusbandry1", 6,
				"BookHusbandry2", 4,
				"BookHusbandry3", 2,
				"BookHusbandry4", 1,
				"BookHusbandry5", 0.5,
				"BoxOfJars", 1,
				"CannedBellPepper", 6,
				"CannedBroccoli", 6,
				"CannedCabbage", 6,
				"CannedCarrots", 6,
				"CannedEggplant", 6,
				"CannedLeek", 6,
				"CannedPotato", 6,
				"CannedRedRadish", 6,
				"CannedTomato", 6,
				"FarmingMag1", 2,
				"FarmingMag2", 2,
				"FarmingMag3", 2,
				"FarmingMag4", 2,
				"FarmingMag5", 2,
				"FarmingMag6", 2,
				"FarmingMag7", 2,
				"FarmingMag8", 2,
				"HandShovel", 6,
				"HerbalistMag", 2,
				"SeedBag", 10,
				"SlugRepellent", 10,
				"TrapMouse", 8,
				"Vinegar_Jug", 1,
				"WateredCan", 6,
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="FarmerTools", min=1, max=4},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="FarmerTools", min=1, max=4},
			}
		},
		dresser = {
			procedural = true,
			procList = {
				{name="FarmerOutfit", min=1, max=1},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="FarmerTools", min=1, max=4},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="FarmerTools", min=1, max=4},
			}
		},
		wardrobe = {
			procedural = true,
			procList = {
				{name="FarmerOutfit", min=1, max=2},
			}
		},
	},

--	Fisherman = {
--		vehicleChance = 50, -- this is the default value
--		professionChanceInt = 20,
--		outfit = "Fisherman",
--		outfitMale = "Fisherman",
--		outfitChance = "100", -- currently unused
--		femaleOdds = "0",
--		vehicle = "Base.PickUpTruck",
--		-- vehicles = "Base.Van;Base.StepVan;Base.PickUpVan;Base.PickUpTruck",
--		vehicleDistribution = "Fisherman",
--		roomTypes = "bedroom;closet;garage;kitchen",
--		containerChance = "70", -- this is the default value that the original code used
--		bagType = "Base.Bag_Satchel_Fishing",
--		body = {
--			rolls = 4,
--			items = {
--				"BookFishing1", 6,
--				"BookFishing2", 4,
--				"BookFishing3", 2,
--				"BookFishing4", 1,
--				"BookFishing5", 0.5,
--				"FishingHook", 20,
--				"FishingHook", 20,
--				"FishingHookBox", 4,
--				"FishingLine", 20,
--				"FishingLine", 20,
--				"FishingMag1", 2,
--				"FishingMag2", 2,
--				"FishingNet", 10,
--				"FishingRod", 10,
--				"FishingTackle", 10,
--				"FishingTackle2", 10,
--				"JigLure", 10,
--				"MinnowLure", 10,
--				"Pliers", 10,
--				"PremiumFishingLine", 4,
--				"WaterPurificationTablets", 1,
--			}
--		},
--		cardboardbox = {
--			procedural = true,
--			procList = {
--				{name="FishermanTools", min=1, max=4},
--			}
--		},
--		counter = {
--			procedural = true,
--			procList = {
--				{name="FishermanTools", min=1, max=4},
--			}
--		},
--		crate = {
--		cardboardbox = {
--			procedural = true,
--			procList = {
--				{name="FishermanTools", min=1, max=4},
--			}
--		},
--		dresser = {
--			procedural = true,
--			procList = {
--				{name="FishermanOutfit", min=1, max=1},
--			}
--		},
--		metal_shelves = {
--			procedural = true,
--			procList = {
--				{name="FishermanTools", min=1, max=4},
--			}
--		},
--		smallbox = {
--			procedural = true,
--			procList = {
--				{name="FishermanTools", min=1, max=4},
--			}
--		},
--		wardrobe = {
--			procedural = true,
--			procList = {
--				{name="FishermanOutfit", min=1, max=2},
--			}
--		},
--	},
--
--	Fireman = {
--		vehicleChance = 50, -- this is the default value
--		professionChanceInt = 20,
--		outfit = "Fireman",
--		outfitMale = "Fireman",
--		outfitChance = "100", -- currently unused
--		femaleOdds = "0",
--		vehicle = "Base.PickUpTruckLightsFire",
--		-- vehicles = "Base.Van;Base.StepVan;Base.PickUpVan;Base.PickUpTruck",
--		vehicleDistribution = "Fire",
--		roomTypes = "bedroom;closet;garage;kitchen",
--		containerChance = "70", -- this is the default value that the original code used
--		bagType = "Base.Toolbox",
--		body = {
--			rolls = 4,
--			items = {
--				"Axe", 10,
--				"Extinguisher", 10,
--				"BucketEmpty"
--			}
--		},
--		cardboardbox = {
--			procedural = true,
--			procList = {
--				{name="FiremanTools", min=1, max=4},
--			}
--		},
--		counter = {
--			procedural = true,
--			procList = {
--				{name="FiremanTools", min=1, max=4},
--			}
--		},
--		crate = {
--			procedural = true,
--			procList = {
--				{name="FiremanTools", min=1, max=4},
--			}
--		},
--		dresser = {
--			procedural = true,
--			procList = {
--				{name="FiremanOutfit", min=1, max=1},
--			}
--		},
--		metal_shelves = {
--			procedural = true,
--			procList = {
--				{name="FiremanTools", min=1, max=4},
--			}
--		},
--		smallbox = cardboardbox,
--		wardrobe = {
--			procedural = true,
--			procList = {
--				{name="FiremanOutfit", min=1, max=2},
--			}
--		},
--	},
--
--	Gardener = {
--		-- this is the default value that the original code used, when is house is initialized, a random profession is chosen and there a 20% chance of it being applied
--		vehicleChance = 50, -- this is the default value
--		professionChanceInt = 20,
--		outfit = "Gardener",
--		outfitFemale = "Farmer",
--		outfitMale = "Farmer",
--		outfitChance = "100", -- currently unused
--		femaleOdds = "50",
--		-- vehicle = "Base.PickUpVan",
--		vehicle = "trades",
--		-- vehicles = "Base.PickUpVan;Base.PickUpTruck",
--		vehicleDistribution = "Gardener",
--		roomTypes = "bedroom;closet;garage;kitchen",
--		containerChance = "70", -- this is the default value that the original code used
--		bagType = "Base.Bag_WorkerBag",
--		body = {
--			rolls = 4,
--			items = {
--				"GardenHoe", 4,
--				"HandAxe", 2,
--				"HandFork", 10,
--				"HandScythe", 4,
--				"LeafRake", 10,
--				"Machete", 0.5,
--				"Rake", 10,
--				"Scythe", 4,
--				"Shovel", 6,
--				"WateredCan", 6,
--			}
--		},
--		cardboardbox = {
--			procedural = true,
--			procList = {
--				{name="GardenerTools", min=1, max=4},
--			}
--		},
--		counter = {
--			procedural = true,
--			procList = {
--				{name="GardenerTools", min=1, max=4},
--			}
--		},
--		crate = {
--			procedural = true,
--			procList = {
--				{name="GardenerTools", min=1, max=4},
--			}
--		},
--		dresser = {
--			procedural = true,
--			procList = {
--				{name="GardenerOutfit", min=1, max=1},
--			}
--		},
--		metal_shelves = {
--			procedural = true,
--			procList = {
--				{name="GardenerTools", min=1, max=4},
--			}
--		},
--		smallbox = cardboardbox,
--		wardrobe = {
--			procedural = true,
--			procList = {
--				{name="GardenerOutfit", min=1, max=2},
--			}
--		},
--	},
--
--	Mechanic = {
--		vehicleChance = 50, -- this is the default value
--		professionChanceInt = 20,
--		outfit = "Mechanic",
--		outfitMale = "Mechanic",
--		outfitChance = "100", -- currently unused
--		femaleOdds = "0",
--		vehicle = "trades",
--		-- vehicles = "Base.Van;Base.StepVan;Base.PickUpVan;Base.PickUpTruck",
--		vehicleDistribution = "Mechanic",
--		roomTypes = "bedroom;closet;garage;kitchen",
--		containerChance = "70", -- this is the default value that the original code used
--		bagType = "Base.Toolbox",
--		body = {
--			rolls = 4,
--			items = {
--				"BoltCutters", 8,
--				"BookMechanic1", 6,
--				"BookMechanic2", 4,
--				"BookMechanic3", 2,
--				"BookMechanic4", 1,
--				"BookMechanic5", 0.5,
--				"Funnel", 10,
--				"LugWrench", 10,
--				"RubberHose", 10,
--				"Screwdriver", 8,
--				"TireIron", 4,
--				"TirePump", 8,
--				"Wrench", 20,
--			}
--		},
--		cardboardbox = {
--			procedural = true,
--			procList = {
--				{name="MechanicTools", min=1, max=4},
--			}
--		},
--		counter = {
--			procedural = true,
--			procList = {
--				{name="MechanicTools", min=1, max=4},
--			}
--		},
--		crate = {
--			procedural = true,
--			procList = {
--				{name="MechanicTools", min=1, max=4},
--			}
--		},
--		dresser = {
--			procedural = true,
--			procList = {
--				{name="MechanicOutfit", min=1, max=1},
--			}
--		},
--		metal_shelves = {
--			procedural = true,
--			procList = {
--				{name="MechanicTools", min=1, max=4},
--			}
--		},
--		smallbox = cardboardbox,
--		wardrobe = {
--			procedural = true,
--			procList = {
--				{name="MechanicOutfit", min=1, max=2},
--			}
--		},
--	},
--
--	MetalWorker = {
--		vehicleChance = 50, -- this is the default value
--		professionChanceInt = 20,
--		outfit = "MetalWorker",
--		outfitMale = "MetalWorker",
--		outfitChance = "100", -- currently unused
--		femaleOdds = "0",
--		vehicle = "trades",
--		-- vehicles = "Base.Van;Base.StepVan;Base.PickUpVan;Base.PickUpTruck",
--		vehicleDistribution = "MetalWelder",
--		roomTypes = "bedroom;closet;garage;kitchen",
--		containerChance = "70", -- this is the default value that the original code used
--		bagType = "Base.Toolbox",
--		body = {
--			rolls = 4,
--			items = {
--				"BallPeenHammer", 20,
--				"BlowTorch", 10,
--				"BoltCutters", 8,
--				"BookMetalWelding1", 6,
--				"BookMetalWelding2", 4,
--				"BookMetalWelding3", 2,
--				"BookMetalWelding4", 1,
--				"BookMetalWelding5", 0.5,
--				"NutsBolts", 10,
--				"Screwdriver", 8,
--				"Screws", 10,
--				"ScrewsBox", 4,
--				"WeldingRods", 10,
--				"Wire", 10,
--			}
--		},
--		cardboardbox = {
--			procedural = true,
--			procList = {
--				{name="MetalWorkerTools", min=1, max=4},
--			}
--		},
--		counter = {
--			procedural = true,
--			procList = {
--				{name="MetalWorkerTools", min=1, max=4},
--			}
--		},
--		crate = {
--			procedural = true,
--			procList = {
--				{name="MetalWorkerTools", min=1, max=4},
--			}
--		},
--		dresser = {
--			procedural = true,
--			procList = {
--				{name="MetalWorkerOutfit", min=1, max=1},
--			}
--		},
--		metal_shelves = {
--			procedural = true,
--			procList = {
--				{name="MetalWorkerTools", min=1, max=4},
--			}
--		},
--		smallbox = cardboardbox,
--		wardrobe = {
--			procedural = true,
--			procList = {
--				{name="MetalWorkerOutfit", min=1, max=2},
--			}
--		},
--	},
--
	Nurse = {
		vehicleChance = 50, -- this is the default value
		-- this is the default value that the original code used, when is house is initialized, a random profession is chosen and there a 20% chance of it being applied
		professionChanceInt = 20,
		outfit = "Nurse",
		outfitFemale = "Nurse",
		outfitMale = "Nurse",
		outfitChance = "100", -- currently unused
		-- vehicle = "Base.SmallCar02",
		vehicle = "middleClass",
		-- vehicles = "Base.CarNormal;Base.SmallCar;Base.SmallCar02;Base.CarStationWagon;Base.CarStationWagon2;Base.VanSeats;Base.SUV",
		vehicleDistribution = "Nurse",
		roomTypes = "bathroom;bedroom;closet;kitchen",
		-- femaleOdds = "75",
		containerChance = "70", -- this is the default value that the original code used
		bagType = "Base.Bag_MedicalBag",
		body = {
			rolls = 4,
			items = {
				"AlcoholWipes", 20,
				"AlcoholWipes", 20,
				"Bandage", 20,
				"Bandage", 20,
				"Bandaid", 20,
				"Bandaid", 20,
				"BookFirstAid1", 6,
				"BookFirstAid2", 4,
				"BookFirstAid3", 2,
				"BookFirstAid4", 1,
				"BookFirstAid5", 0.5,
				"FirstAidKit", 2,
				"Gloves_Surgical", 10,
				"Hat_SurgicalCap", 10,
				"Hat_SurgicalMask", 10,
				"PenLight", 10,
				"Pills", 20,
				"Pills", 20,
				"SutureNeedle", 10,
				"TongueDepressor", 10,
				"Tweezers", 10,
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="NurseTools", min=1, max=4},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="NurseTools", min=1, max=4},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="NurseTools", min=1, max=4},
			}
		},
		dresser = {
			procedural = true,
			procList = {
				{name="NurseOutfit", min=1, max=1},
			}
		},
		medicine = {
			rolls = 3,
			items = {
				"AlcoholWipes", 20,
				"AlcoholWipes", 20,
				"Bandage", 20,
				"Bandage", 20,
				"Bandaid", 20,
				"Bandaid", 20,
				"Disinfectant", 20,
				"PenLight", 10,
				"Pills", 20,
				"Pills", 20,
				"TongueDepressor", 10,
				"Tweezers", 10,
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="NurseTools", min=1, max=4},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="NurseTools", min=1, max=4},
			}
		},
	},

--	Police = {
--		vehicleChance = 50,
--		professionChanceInt = 5,
--		outfit = "Police",
--		vehicle = "Base.CarLightsPolice",
--		vehicleDistribution = "Police",
--		roomTypes = "bedroom;closet;garage;kitchen",
--		containerChance = "70",
--		bagType = "Base.Bag_Police",
--		body = {
--			rolls = 4,
--			items = {
--				"9mmClip", 10,
--				"Bullets9mmBox", 10,
--				"Bullets9mmBox", 10,
--				"Bullets9mmBox", 10,
--				"HolsterDouble", 1,
--				"HolsterSimple", 4,
--				"Nightstick", 10,
--				"Pistol", 10,
--				"Shotgun", 8,
--				"Zipties", 10,
--			}
--		},
--		cardboardbox = {
--			procedural = true,
--			procList = {
--				{name="PoliceTools", min=1, max=4},
--			}
--		},
--		counter = {
--			procedural = true,
--			procList = {
--				{name="PoliceTools", min=1, max=4},
--			}
--		},
--		crate = {
--			procedural = true,
--			procList = {
--				{name="PoliceTools", min=1, max=4},
--			}
--		},
--		dresser = {
--			procedural = true,
--			procList = {
--				{name="PoliceOutfit", min=1, max=1},
--			}
--		},
--		metal_shelves = {
--			procedural = true,
--			procList = {
--				{name="PoliceTools", min=1, max=4},
--			}
--		},
--		smallbox = cardboardbox,
--		wardrobe = {
--			procedural = true,
--			procList = {
--				{name="PoliceOutfit", min=1, max=2},
--			}
--		},
--	},
--
--	PoliceState = {
--		vehicleChance = 50,
--		professionChanceInt = 5,
--		outfit = "PoliceState",
--		vehicle = "Base.CarLightsPolice",
--		vehicleDistribution = "Police",
--		roomTypes = "bedroom;closet;garage;kitchen",
--		containerChance = "70",
--		bagType = "Base.Bag_Police",
--		body = {
--			rolls = 4,
--			items = {
--				"45Clip", 10,
--				"Bullets38Box", 10,
--				"Bullets44Box", 10,
--				"Bullets45Box", 10,
--				"HolsterDouble", 1,
--				"HolsterSimple", 4,
--				"Nightstick", 10,
--				"Pistol2", 4,
--				"Revolver_Long", 6,
--				"Revolver_Short", 10,
--				"Shotgun", 8,
--				"Zipties", 10,
--			}
--		},
--		cardboardbox = {
--			procedural = true,
--			procList = {
--				{name="PoliceStateTools", min=1, max=4},
--			}
--		},
--		counter = {
--			procedural = true,
--			procList = {
--				{name="PoliceStateTools", min=1, max=4},
--			}
--		},
--		crate = {
--			procedural = true,
--			procList = {
--				{name="PoliceStateTools", min=1, max=4},
--			}
--		},
--		dresser = {
--			procedural = true,
--			procList = {
--				{name="PoliceStateOutfit", min=1, max=1},
--			}
--		},
--		metal_shelves = {
--			procedural = true,
--			procList = {
--				{name="PoliceStateTools", min=1, max=4},
--			}
--		},
--		smallbox = cardboardbox,
--		wardrobe = {
--			procedural = true,
--			procList = {
--				{name="PoliceStateOutfit", min=1, max=2},
--			}
--		},
--	},
--
--	Ranger = {
--		vehicleChance = 50,
--		professionChanceInt = 5,
--		outfit = "Ranger",
--		vehicle = "Base.CarLightsRanger",
--		vehicleDistribution = "Ranger",
--		roomTypes = "bedroom;closet;garage;kitchen",
--		containerChance = "70",
--		bagType = "Base.Bag_Police",
--		body = {
--			rolls = 4,
--			items = {
--				"223Box", 10,
--				"308Box", 10,
--				"BookTrapping1", 6,
--				"BookTrapping2", 4,
--				"BookTrapping3", 2,
--				"BookTrapping4", 1,
--				"BookTrapping5", 0.5,
--				"Bullets45Box", 10,
--				"Revolver", 6,
--				"Revolver_Long", 4,
--				"ShotgunShellsBox", 10,
--				"WaterPurificationTablets", 4,
--			}
--		},
--		cardboardbox = {
--			procedural = true,
--			procList = {
--				{name="RangerTools", min=1, max=4},
--			}
--		},
--		counter = {
--			procedural = true,
--			procList = {
--				{name="RangerTools", min=1, max=4},
--			}
--		},
--		crate = {
--			procedural = true,
--			procList = {
--				{name="RangerTools", min=1, max=4},
--			}
--		},
--		dresser = {
--			procedural = true,
--			procList = {
--				{name="RangerOutfit", min=1, max=1},
--			}
--		},
--		metal_shelves = {
--			procedural = true,
--			procList = {
--				{name="RangerTools", min=1, max=4},
--			}
--		},
--		smallbox = {
--			procedural = true,
--			procList = {
--				{name="RangerTools", min=1, max=4},
--			}
--		},
--		wardrobe = {
--			procedural = true,
--			procList = {
--				{name="RangerOutfit", min=1, max=2},
--			}
--		},
--	},

--	-- =====================
--	--		CACHES
--	-- =====================

	BombCache1 = {
		BombBox = {
			rolls = 8,
			items = {
				"Aerosolbomb", 6,
				"AerosolbombRemote", 2,
				"AerosolbombSensorV2", 2,
				"AerosolbombTriggered", 2,
				"FlameTrap", 4,
				"FlameTrapRemote", 1,
				"FlameTrapSensorV2", 1,
				"FlameTrapTriggered", 1,
				"Molotov", 20,
				"PipeBomb", 6,
				"PipeBombRemote", 2,
				"PipeBombSensorV2", 2,
				"PipeBombTriggered", 2,
				"SmokeBomb", 10,
				"SmokeBombRemote", 6,
				"SmokeBombSensorV2", 6,
				"SmokeBombTriggered", 6,
			},
			junk = {
				rolls = 1,
				items = {
					"CopperScrap", 10,
					"DuctTape", 4,
					"ElectricWire", 4,
					"ElectronicsScrap", 10,
					"MotionSensor", 1,
					"Pliers", 10,
					"RemoteCraftedV1", 1,
					"RemoteCraftedV2", 0.5,
					"RemoteCraftedV3", 0.1,
					"ScrapMetal", 10,
					"Screwdriver", 10,
					"TimerCrafted", 1,
					"TriggerCrafted", 1,
					"Twine", 10,
				}
			}
		}
	},

	BoozeCache1 = {
		BoozeBox = {
			rolls = 12,
			items = {
				"BeerBottle", 4,
				"Brandy", 10,
				"Cider", 2,
				"CoffeeLiquer", 2,
				"Curacao", 2,
				"Gin", 10,
				"Grenadine", 2,
				"Port", 2,
				"Rum", 10,
				"Scotch", 10,
				"Sherry", 2,
				"Tequila", 10,
				"Vermouth", 2,
				"Vodka", 10,
				"Whiskey", 10,
				"Wine", 4,
				"Wine2", 4,
				"WineBox", 4,
			},
			junk = {
				rolls = 1,
				items = {
					"BottleOpener", 20,
					"Corkscrew", 10,
				}
			}
		},
		plankstash = {
			rolls = 4,
			items = {
				"BeerBottle", 4,
				"Brandy", 10,
				"Cider", 2,
				"CoffeeLiquer", 2,
				"Curacao", 2,
				"Gin", 10,
				"Grenadine", 2,
				"Port", 2,
				"Rum", 10,
				"Scotch", 10,
				"Sherry", 2,
				"Tequila", 10,
				"Vermouth", 2,
				"Vodka", 10,
				"Whiskey", 10,
				"Wine", 4,
				"Wine2", 4,
				"WineBox", 4,
			},
			junk = {
				rolls = 1,
				items = {
					"BottleOpener", 20,
					"Corkscrew", 10,
				}
			}
		},
	},

	FoodCache1 = {
		FoodBox = {
			rolls = 12,
			items = {
				-- Alcohol
				"BeerBottle", 1,
				"BeerCan", 1,
				"Whiskey", 1,
				"Wine", 1,
				"Wine2", 1,
				"WineBox", 1,
				-- Candy
				"CandyCaramels", 2,
				"CandyFruitSlices", 2,
				"CandyGummyfish", 2,
				"CandyNovapops", 2,
				"Chocolate", 4,
				"ChocolateCoveredCoffeeBeans", 2,
				"Chocolate_Butterchunkers", 2,
				"Chocolate_Candy", 4,
				"Chocolate_Crackle", 2,
				"Chocolate_Deux", 2,
				"Chocolate_GalacticDairy", 2,
				"Chocolate_RoysPBPucks", 2,
				"Chocolate_Smirkers", 2,
				"Chocolate_SnikSnak", 2,
				"Gum", 4,
				"GummyBears", 2,
				"GummyWorms", 2,
				"HardCandies", 2,
				"JellyBeans", 2,
				"Jujubes", 2,
				"LicoriceBlack", 1,
				"LicoriceRed", 2,
				"MintCandy", 1,
				"Modjeska", 2,
				"Peppermint", 1,
				"RockCandy", 1,
				-- Cans
				"CannedBolognese", 6,
				"CannedBolognese_Box", 0.06,
				"CannedCarrots2", 4,
				"CannedCarrots_Box", 0.04,
				"CannedChili", 6,
				"CannedChili_Box", 0.06,
				"CannedCorn", 4,
				"CannedCornedBeef", 6,
				"CannedCornedBeef_Box", 0.06,
				"CannedCorn_Box", 0.04,
				"CannedFruitBeverage", 6,
				"CannedFruitBeverage_Box", 0.06,
				"CannedFruitCocktail", 6,
				"CannedFruitCocktail_Box", 0.06,
				"CannedMilk", 2,
				"CannedMilk_Box", 0.02,
				"CannedMushroomSoup", 6,
				"CannedMushroomSoup_Box", 0.06,
				"CannedPeaches", 4,
				"CannedPeaches_Box", 0.04,
				"CannedPeas", 4,
				"CannedPeas_Box", 0.04,
				"CannedPineapple", 4,
				"CannedPineapple_Box", 0.04,
				"CannedPotato2", 4,
				"CannedPotato_Box", 0.04,
				"CannedSardines", 6,
				"CannedSardines_Box", 0.06,
				"CannedTomato2", 4,
				"CannedTomato_Box", 0.04,
				"TinnedBeans", 6,
				"TinnedBeans_Box", 0.06,
				"TinnedSoup", 6,
				"TinnedSoup_Box", 0.06,
				"TomatoPaste", 8,
				"TunaTin", 0.06,
				"TunaTin", 6,
				-- Drinks
				"CannedFruitBeverage", 8,
				"Pop", 8,
				"Pop2", 8,
				"Pop3", 8,
				"PopBottle", 4,
				"PopBottleRare", 0.1,
				"WaterBottle", 4,
				"WaterRationCan_Box", 1,
				-- Jars
				"CannedBellPepper", 10,
				"CannedBroccoli", 10,
				"CannedCabbage", 10,
				"CannedCarrots", 10,
				"CannedEggplant", 10,
				"CannedLeek", 10,
				"CannedPotato", 10,
				"CannedRedRadish", 10,
				"CannedTomato", 10,
				-- Non-Perishables
				"BouillonCube", 10,
				"Cereal", 8,
				"Crackers", 10,
				"DriedApricots", 8,
				"DriedBlackBeans", 4,
				"DriedChickpeas", 4,
				"DriedKidneyBeans", 4,
				"DriedLentils", 4,
				"DriedSplitPeas", 4,
				"DriedWhiteBeans", 4,
				"Macandcheese", 8,
				"Macaroni", 4,
				"OatsRaw", 4,
				"PancakeMix", 4,
				"Pasta", 4,
				"Popcorn", 8,
				"Ramen", 8,
				"Rice", 4,
				"TortillaChips", 8,
				-- Sauces/Spices
				"Honey", 2,
				"Hotsauce", 4,
				"JamFruit", 4,
				"JamMarmalade", 1,
				"MapleSyrup", 1,
				"Margarine", 2,
				"Marinara", 8,
				"OilOlive", 2,
				"OilVegetable", 2,
				"PeanutButter", 4,
				"Pepper", 1,
				"Salt", 1,
				"SeasoningSalt", 1,
				"Soysauce", 2,
				"Sugar", 2,
				"SugarBrown", 2,
				-- Snacks
				"BeefJerky", 10,
				"ChocoCakes", 2,
				"Crisps", 4,
				"Crisps2", 4,
				"Crisps3", 4,
				"Crisps4", 4,
				"DehydratedMeatStick", 10,
				"GranolaBar", 8,
				"HiHis", 2,
				"Peanuts", 4,
				"Plonkies", 2,
				"PorkRinds", 2,
				"QuaggaCakes", 2,
				"SnoGlobes", 2,
				"SunflowerSeeds", 4,
				-- Special
				"CigaretteCarton", 0.1,
				"WaterDispenserBottle", 0.1,
			},
			junk = {
				rolls = 1,
				items = {
					"TinOpener", 20,
					"Corkscrew", 10,
				}
			}
		}
	},

	GunCache1 = {
		GunBox = {
			rolls = 8,
			items = {
				"223Box", 20,
				"223Box", 10,
				"308Box", 20,
				"308Box", 10,
				"44Clip", 2,
				"45Clip", 2,
				"9mmClip", 2,
				"AmmoStrap_Bullets", 4,
				"AmmoStrap_Shells", 4,
				"AssaultRifle2", 0.1,
				"Bullets38Box", 20,
				"Bullets38Box", 10,
				"Bullets44Box", 20,
				"Bullets44Box", 10,
				"Bullets45Box", 20,
				"Bullets45Box", 10,
				"Bullets9mmBox", 20,
				"Bullets9mmBox", 10,
				"ChokeTubeFull", 0.5,
				"ChokeTubeImproved", 0.5,
				"DoubleBarrelShotgun", 2,
				"HuntingRifle", 1,
				"HolsterDouble", 0.5,
				"HolsterShoulder", 0.5,
				"HolsterSimple", 2,
				"KeyRing", 0.1,
				"Key1", 0.5,
				"Key1", 0.5,
				"Key1", 0.5,
				"KnifeButterfly", 1,
				"M14Clip", 2,
				"Money", 20,
				"Money", 10,
				"Pistol", 4,
				"Pistol2", 2,
				"Pistol3", 1,
				"RecoilPad", 0.5,
				"RedDot", 0.5,
				"Revolver", 2,
				"Revolver_Long", 1,
				"Revolver_Short", 4,
				"Shotgun", 4,
				"ShotgunShellsBox", 20,
				"ShotgunShellsBox", 10,
				"SwitchKnife", 1,
				"VarmintRifle", 8,
				"x2Scope", 4,
				"x4Scope", 2,
				"x8Scope", 1,
			},
			junk = {
				rolls = 1,
				items = {
					"Screwdriver", 4,
				}
			},
			dontSpawnAmmo = true,
		},

		counter = {
			rolls = 4,
			items = {
				"HolsterDouble", 1,
				"HolsterShoulder", 1,
				"HolsterSimple", 4,
				"Pistol", 8,
				"Pistol2", 6,
				"Pistol3", 4,
				"RedDot", 1,
				"Revolver", 6,
				"Revolver_Long", 4,
				"Revolver_Short", 8,
			},
			junk = {
				rolls = 1,
				items = {

				}
			}
		},

		plankstash = {
			rolls = 4,
			items = {
				"44Clip", 4,
				"45Clip", 4,
				"9mmClip", 4,
				"Bullets38Box", 20,
				"Bullets38Box", 10,
				"Bullets44Box", 20,
				"Bullets44Box", 10,
				"Bullets45Box", 20,
				"Bullets45Box", 10,
				"Bullets9mmBox", 20,
				"Bullets9mmBox", 10,
				"CigarettePack", 8,
				"HolsterDouble", 1,
				"HolsterShoulder", 1,
				"HolsterSimple", 4,
				"KeyRing", 0.1,
				"Key1", 0.5,
				"Key1", 0.5,
				"Key1", 0.5,
				"KnifeButterfly", 1,
				"Money", 20,
				"Money", 10,
				"Pistol", 20,
				"Pistol2", 10,
				"Pistol3", 8,
				"RedDot", 1,
				"Revolver", 10,
				"Revolver_Long", 8,
				"Revolver_Short", 20,
				"SwitchKnife", 1,
			},
			junk = {
				rolls = 1,
				items = {
					"Screwdriver", 4,
				}
			}
		},

		Bag_DuffelBagTINT = {
			rolls = 4,
			items = {
				"223Box", 10,
				"308Box", 10,
				"44Clip", 4,
				"45Clip", 4,
				"9mmClip", 4,
				"AmmoStrap_Bullets", 4,
				"AmmoStrap_Shells", 4,
				"AssaultRifle2", 0.1,
				"Bullets38Box", 10,
				"Bullets44Box", 10,
				"Bullets45Box", 10,
				"Bullets9mmBox", 10,
				"ChokeTubeFull", 1,
				"ChokeTubeImproved", 1,
				"DoubleBarrelShotgun", 8,
				"HolsterDouble", 1,
				"HolsterShoulder", 1,
				"HolsterSimple", 4,
				"HuntingRifle", 4,
				"M14Clip", 4,
				"Pistol", 20,
				"Pistol2", 10,
				"Pistol3", 8,
				"RecoilPad", 1,
				"RedDot", 1,
				"Revolver", 10,
				"Revolver_Long", 8,
				"Revolver_Short", 20,
				"Shotgun", 8,
				"ShotgunShellsBox", 10,
				"VarmintRifle", 8,
				"x2Scope", 4,
				"x4Scope", 2,
				"x8Scope", 1,
			},
			junk = {
				rolls = 1,
				items = {
					"Screwdriver", 4,
				}
			},
			fillRand = 1,
		}
	},

	GunCache2 = {
		GunBox = {
			rolls = 12,
			items = {
				"223Box", 20,
				"223Box", 10,
				"308Box", 20,
				"308Box", 10,
				"44Clip", 2,
				"45Clip", 2,
				"9mmClip", 2,
				"AmmoStrap_Bullets", 4,
				"AmmoStrap_Shells", 4,
				"AssaultRifle2", 0.1,
				"Bullets38Box", 20,
				"Bullets38Box", 10,
				"Bullets44Box", 20,
				"Bullets44Box", 10,
				"Bullets45Box", 20,
				"Bullets45Box", 10,
				"Bullets9mmBox", 20,
				"Bullets9mmBox", 10,
				"ChokeTubeFull", 0.5,
				"ChokeTubeImproved", 0.5,
				"DoubleBarrelShotgun", 2,
				"HuntingRifle", 1,
				"HolsterDouble", 0.5,
				"HolsterShoulder", 0.5,
				"HolsterSimple", 2,
				"M14Clip", 2,
				"Pistol", 4,
				"Pistol2", 2,
				"Pistol3", 1,
				"RecoilPad", 0.5,
				"RedDot", 0.5,
				"Revolver", 2,
				"Revolver_Long", 1,
				"Revolver_Short", 4,
				"Shotgun", 4,
				"ShotgunShellsBox", 20,
				"ShotgunShellsBox", 10,
				"VarmintRifle", 8,
				"x2Scope", 4,
				"x4Scope", 2,
				"x8Scope", 1,
			},
			junk = {
				rolls = 1,
				items = {
					"Screwdriver", 4,
				}
			},
			dontSpawnAmmo = true,
		},

		Bag_DuffelBagTINT = {
			rolls = 4,
			items = {
				"223Box", 10,
				"308Box", 10,
				"44Clip", 4,
				"45Clip", 4,
				"9mmClip", 4,
				"AmmoStrap_Bullets", 4,
				"AmmoStrap_Shells", 4,
				"AssaultRifle2", 0.1,
				"Bullets38Box", 10,
				"Bullets44Box", 10,
				"Bullets45Box", 10,
				"Bullets9mmBox", 10,
				"ChokeTubeFull", 1,
				"ChokeTubeImproved", 1,
				"DoubleBarrelShotgun", 8,
				"HolsterDouble", 1,
				"HolsterShoulder", 1,
				"HolsterSimple", 4,
				"HuntingRifle", 4,
				"M14Clip", 4,
				"Pistol", 20,
				"Pistol2", 10,
				"Pistol3", 8,
				"RecoilPad", 1,
				"RedDot", 1,
				"Revolver", 10,
				"Revolver_Long", 8,
				"Revolver_Short", 20,
				"Shotgun", 8,
				"ShotgunShellsBox", 10,
				"VarmintRifle", 8,
				"x2Scope", 4,
				"x4Scope", 2,
				"x8Scope", 1,
			},
			junk = {
				rolls = 1,
				items = {
					"Screwdriver", 4,
				}
			},
			fillRand = 1,
		}
	},

	MedicalCache1 = {
		MedicalBox = {
			rolls = 8,
			items = {
				"Antibiotics", 20,
				"Antibiotics", 10,
				"Bandage", 20,
				"Bandage", 20,
				"Bandage", 10,
				"Bandage", 10,
				"Bleach", 4,
				"BookFirstAid1", 6,
				"BookFirstAid2", 4,
				"BookFirstAid3", 2,
				"BookFirstAid4", 1,
				"BookFirstAid5", 0.5,
				"Disinfectant", 8,
				"Gloves_Surgical", 4,
				"Hat_SurgicalMask", 4,
				"Pills", 20,
				"Pills", 10,
				"PillsAntiDep", 10,
				"PillsBeta", 10,
				"PillsSleepingTablets", 10,
				"RippedSheets", 4,
				"RippedSheets", 4,
				"Scalpel", 8,
				"ScissorsBluntMedical", 8,
				"Stethoscope", 1,
				"SutureNeedle", 10,
				"SutureNeedleHolder", 10,
				"TongueDepressor", 4,
				"Tweezers", 8,
				"Whiskey", 20,
				"Whiskey", 10,
			},
			junk = {
				rolls = 1,
				items = {

				}
			}
		}
	},

	SafehouseLoot = {
		bin = {
			procedural = true,
			procList = {
				{name="SafehouseBin", min=1, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="CrateEmptyBottles2", min=0, max=1, weightChance=20},
				{name="FirearmWeapons", min=1, max=2, weightChance=40},
				{name="MeleeWeapons", min=1, max=2, weightChance=60},
				{name="SafehouseMedical", min=0, max=1, weightChance=80},
				{name="SafehouseFood", min=1, max=8, weightChance=100},
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="SafehouseBooze", min=0, max=1, weightChance=5},
				{name="SafehouseLighting", min=0, max=1, weightChance=5},
				{name="CrateVHSTapes", min=0, max=1, weightChance=10},
				{name="Antiques", min=0, max=1, weightChance=10},
				{name="CrateCamping", min=0, max=1, weightChance=10},
				{name="CrateEmptyBottles2", min=0, max=1, weightChance=20},
				{name="FirearmWeapons", min=1, max=1, weightChance=40},
				{name="SafehouseArmor", min=0, max=1, weightChance=60},
				{name="SafehouseTraps", min=0, max=2, weightChance=80},
				{name="MeleeWeapons", min=1, max=2, weightChance=100},
			}
		},
		clothingdryer = {
			procedural = true,
			procList = {
				{name="SafehouseDryer", min=1, max=99},
			}
		},
		clothingwasher = {
			procedural = true,
			procList = {
				{name="SafehouseWasher", min=1, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="SafehouseBooze", min=0, max=1, weightChance=5},
				{name="SafehouseLighting", min=0, max=1, weightChance=5},
				{name="CrateVHSTapes", min=0, max=1, weightChance=10},
				{name="Antiques", min=0, max=1, weightChance=10},
				{name="CrateCamping", min=0, max=1, weightChance=10},
				{name="CrateEmptyBottles2", min=0, max=1, weightChance=10},
				{name="FirearmWeapons", min=1, max=1, weightChance=40},
				{name="SafehouseArmor", min=0, max=1, weightChance=60},
				{name="SafehouseTraps", min=0, max=2, weightChance=80},
				{name="MeleeWeapons", min=1, max=2, weightChance=100},
			}
		},
		dresser = {
			procedural = true,
			procList = {
				{name="SafehouseArmor", min=1, max=99},
			}
		},
		fireplace = {
			procedural = true,
			procList = {
				{name="SafehouseFireplace", min=1, max=99},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="SafehouseFreezer", min=1, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="SafehouseFridge", min=1, max=99},
			}
		},
		medicine = {
			procedural = true,
			procList = {
				{name="SafehouseMedical", min=1, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="FirearmWeapons", min=1, max=2, weightChance=20},
				{name="MeleeWeapons", min=1, max=2, weightChance=80},
				{name="SafehouseTraps", min=0, max=1, weightChance=60},
				{name="CrateTools", min=0, max=99, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="SafehouseBookShelf", min=1, max=99, weightChance=10},
				{name="LivingRoomShelf", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="SafehouseBooze", min=0, max=1, weightChance=5},
				{name="SafehouseLighting", min=0, max=1, weightChance=5},
				{name="CrateVHSTapes", min=0, max=1, weightChance=10},
				{name="Antiques", min=0, max=1, weightChance=10},
				{name="CrateCamping", min=0, max=1, weightChance=10},
				{name="CrateEmptyBottles2", min=0, max=1, weightChance=20},
				{name="FirearmWeapons", min=1, max=1, weightChance=40},
				{name="SafehouseArmor", min=0, max=1, weightChance=60},
				{name="SafehouseTraps", min=0, max=2, weightChance=80},
				{name="MeleeWeapons", min=1, max=2, weightChance=100},
			}
		},
		stove = {
			procedural = true,
			procList = {
				{name="SafehouseStove", min=1, max=99},
			}
		},
		wardrobe = {
			procedural = true,
			procList = {
				{name="FirearmWeapons", min=1, max=1, weightChance=10},
				{name="MeleeWeapons", min=1, max=1, weightChance=40},
				{name="SafehouseArmor", min=1, max=99, weightChance=100},
			}
		},
	},

	SafehouseLoot_Mid = {
		bin = {
			procedural = true,
			procList = {
				{name="SafehouseBin_Mid", min=1, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="CrateEmptyBottles2", min=0, max=1, weightChance=20},
				{name="FirearmWeapons_Mid", min=1, max=2, weightChance=20},
				{name="MeleeWeapons_Mid", min=1, max=2, weightChance=80},
				{name="SafehouseMedical_Mid", min=0, max=1, weightChance=40},
				{name="SafehouseFood_Mid", min=1, max=8, weightChance=100},
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="SafehouseBooze", min=0, max=1, weightChance=5},
				{name="SafehouseLighting", min=0, max=1, weightChance=5},
				{name="CrateVHSTapes", min=0, max=1, weightChance=10},
				{name="Antiques", min=0, max=1, weightChance=10},
				{name="CrateCamping", min=0, max=1, weightChance=10},
				{name="CrateEmptyBottles2", min=0, max=1, weightChance=20},
				{name="FirearmWeapons_Mid", min=1, max=2, weightChance=20},
				{name="MeleeWeapons_Mid", min=1, max=2, weightChance=80},
				{name="SafehouseArmor_Mid", min=0, max=2, weightChance=40},
				{name="SafehouseTraps", min=0, max=1, weightChance=60},
			}
		},
		clothingdryer = {
			procedural = true,
			procList = {
				{name="SafehouseDryer", min=1, max=99},
			}
		},
		clothingwasher = {
			procedural = true,
			procList = {
				{name="SafehouseWasher", min=1, max=99},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="SafehouseBooze", min=0, max=1, weightChance=5},
				{name="SafehouseLighting", min=0, max=1, weightChance=5},
				{name="CrateVHSTapes", min=0, max=1, weightChance=10},
				{name="Antiques", min=0, max=1, weightChance=10},
				{name="CrateCamping", min=0, max=1, weightChance=10},
				{name="CrateEmptyBottles2", min=0, max=1, weightChance=20},
				{name="FirearmWeapons_Mid", min=1, max=2, weightChance=20},
				{name="MeleeWeapons_Mid", min=1, max=2, weightChance=80},
				{name="SafehouseArmor_Mid", min=0, max=2, weightChance=40},
				{name="SafehouseTraps", min=0, max=1, weightChance=60},
			}
		},
		dresser = {
			procedural = true,
			procList = {
				{name="SafehouseArmor_Mid", min=1, max=99},
			}
		},
		fireplace = {
			procedural = true,
			procList = {
				{name="SafehouseFireplace", min=1, max=99},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="SafehouseFreezer_Mid", min=1, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="SafehouseFridge_Mid", min=1, max=99},
			}
		},
		medicine = {
			procedural = true,
			procList = {
				{name="SafehouseMedical_Mid", min=1, max=99},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="FirearmWeapons_Mid", min=1, max=2, weightChance=20},
				{name="MeleeWeapons_Mid", min=1, max=2, weightChance=80},
				{name="SafehouseTraps", min=0, max=1, weightChance=60},
				{name="CrateTools", min=0, max=99, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="SafehouseBookShelf", min=1, max=99, weightChance=10},
				{name="LivingRoomShelf", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="SafehouseBooze", min=0, max=1, weightChance=5},
				{name="SafehouseLighting", min=0, max=1, weightChance=5},
				{name="CrateVHSTapes", min=0, max=1, weightChance=10},
				{name="Antiques", min=0, max=1, weightChance=10},
				{name="CrateCamping", min=0, max=1, weightChance=10},
				{name="CrateEmptyBottles2", min=0, max=1, weightChance=20},
				{name="FirearmWeapons_Mid", min=1, max=2, weightChance=20},
				{name="MeleeWeapons_Mid", min=1, max=2, weightChance=80},
				{name="SafehouseArmor_Mid", min=0, max=2, weightChance=40},
				{name="SafehouseTraps", min=0, max=1, weightChance=60},
			}
		},
		stove = {
			procedural = true,
			procList = {
				{name="SafehouseStove_Mid", min=1, max=99},
			}
		},
		wardrobe = {
			procedural = true,
			procList = {
				{name="FirearmWeapons_Mid", min=1, max=1, weightChance=10},
				{name="MeleeWeapons_Mid", min=1, max=1, weightChance=40},
				{name="SafehouseArmor_Mid", min=1, max=99, weightChance=100},
			}
		},
	},

	SafehouseLoot_Late = {
		bin = {
			procedural = true,
			procList = {
				{name="SafehouseBin_Late", min=1, max=99},
			}
		},
		cardboardbox = {
			procedural = true,
			procList = {
				{name="SafehouseLighting_Late", min=0, max=1, weightChance=1},
				{name="CrateVHSTapes", min=0, max=1, weightChance=10},
				{name="Antiques", min=0, max=1, weightChance=10},
				{name="CrateCamping", min=0, max=1, weightChance=10},
				{name="CrateEmptyBottles2", min=0, max=1, weightChance=20},
				{name="FirearmWeapons_Late", min=1, max=2, weightChance=20},
				{name="MeleeWeapons_Late", min=1, max=2, weightChance=80},
				{name="SafehouseArmor_Late", min=0, max=2, weightChance=40},
				{name="SafehouseTraps", min=0, max=1, weightChance=60},
			}
		},
		clothingdryer = {
			procedural = true,
			procList = {
				{name="SafehouseDryer", min=1, max=99},
			}
		},
		clothingwasher = {
			procedural = true,
			procList = {
				{name="SafehouseWasher", min=1, max=99},
			}
		},
		counter = {
			procedural = true,
			procList = {
				{name="CrateEmptyBottles2", min=0, max=1, weightChance=20},
				{name="FirearmWeapons_Late", min=1, max=2, weightChance=20},
				{name="MeleeWeapons_Late", min=1, max=2, weightChance=80},
				{name="SafehouseMedical_Late", min=0, max=1, weightChance=40},
				{name="SafehouseFood_Late", min=1, max=8, weightChance=100},
			}
		},
		crate = {
			procedural = true,
			procList = {
				{name="SafehouseLighting_Late", min=0, max=1, weightChance=1},
				{name="CrateVHSTapes", min=0, max=1, weightChance=10},
				{name="Antiques", min=0, max=1, weightChance=10},
				{name="CrateCamping", min=0, max=1, weightChance=10},
				{name="CrateEmptyBottles2", min=0, max=1, weightChance=20},
				{name="FirearmWeapons_Late", min=1, max=2, weightChance=20},
				{name="MeleeWeapons_Late", min=1, max=2, weightChance=80},
				{name="SafehouseArmor_Late", min=0, max=2, weightChance=40},
				{name="SafehouseTraps", min=0, max=1, weightChance=60},
			}
		},
		dresser = {
			procedural = true,
			procList = {
				{name="SafehouseArmor_Late", min=1, max=99},
			}
		},
		fireplace = {
			procedural = true,
			procList = {
				{name="SafehouseFireplace_Late", min=1, max=99},
			}
		},
		freezer = {
			procedural = true,
			procList = {
				{name="SafehouseFreezer_Late", min=1, max=99},
			}
		},
		fridge = {
			procedural = true,
			procList = {
				{name="SafehouseFridge_Late", min=1, max=99},
			}
		},
		medicine = {
			procedural = true,
			procList = {
				{name="SafehouseMedical_Mid", min=1, max=99, weightChance=20},
				{name="Empty", min=1, max=99, weightChance=100},
			}
		},
		metal_shelves = {
			procedural = true,
			procList = {
				{name="FirearmWeapons_Late", min=1, max=2, weightChance=20},
				{name="MeleeWeapons_Late", min=1, max=2, weightChance=80},
				{name="SafehouseTraps", min=0, max=1, weightChance=60},
				{name="CrateTools", min=0, max=99, weightChance=100},
			}
		},
		shelves = {
			procedural = true,
			procList = {
				{name="SafehouseBookShelf", min=1, max=99, weightChance=10},
				{name="LivingRoomShelf", min=0, max=99, weightChance=100},
			}
		},
		smallbox = {
			procedural = true,
			procList = {
				{name="SafehouseLighting", min=0, max=1, weightChance=1},
				{name="CrateVHSTapes", min=0, max=1, weightChance=10},
				{name="Antiques", min=0, max=1, weightChance=10},
				{name="CrateCamping", min=0, max=1, weightChance=10},
				{name="CrateEmptyBottles2", min=0, max=1, weightChance=20},
				{name="FirearmWeapons_Late", min=1, max=2, weightChance=20},
				{name="MeleeWeapons_Late", min=1, max=2, weightChance=80},
				{name="SafehouseArmor_Late", min=0, max=2, weightChance=40},
				{name="SafehouseTraps", min=0, max=1, weightChance=60},
			}
		},
		stove = {
			procedural = true,
			procList = {
				{name="SafehouseStove_Late", min=1, max=99},
			}
		},
		wardrobe = {
			procedural = true,
			procList = {
				{name="FirearmWeapons_Late", min=1, max=1, weightChance=10},
				{name="MeleeWeapons_Late", min=1, max=1, weightChance=40},
				{name="SafehouseArmor_Late", min=1, max=99, weightChance=100},
			}
		},
	},

	ShotgunCache1 = {
		ShotgunBox = {
			rolls = 8,
			items = {
				"AmmoStrap_Shells", 1,
				"ChokeTubeFull", 1,
				"ChokeTubeImproved", 1,
				"RecoilPad", 1,
				"ShotgunShellsBox", 50,
				"ShotgunShellsBox", 20,
				"ShotgunShellsBox", 20,
				"ShotgunShellsBox", 10,
				"ShotgunShellsBox", 10,
			},
			junk = {
				rolls = 1,
				items = {
					"Screwdriver", 4,
					"Shotgun", 100,
				}
			}
		},

		plankstash = {
			rolls = 4,
			items = {
				"AmmoStrap_Shells", 1,
				"ChokeTubeFull", 1,
				"ChokeTubeImproved", 1,
				"KeyRing", 0.1,
				"Key1", 0.5,
				"Key1", 0.5,
				"Key1", 0.5,
				"KnifeButterfly", 1,
				"Money", 20,
				"Money", 10,
				"RecoilPad", 1,
				"ShotgunShells", 50,
				"ShotgunShells", 20,
				"ShotgunShells", 10,
				"ShotgunShells", 10,
				"ShotgunShellsBox", 20,
				"ShotgunShellsBox", 10,
				"SwitchKnife", 1,
			},
			junk = {
				rolls = 1,
				items = {
					"Screwdriver", 4,
					"Shotgun", 100,
				}
			}
		},

		Bag_DuffelBagTINT = {
			rolls = 1,
			items = {
				"AmmoStrap_Shells", 10,
				"ChokeTubeFull", 10,
				"ChokeTubeImproved", 10,
				"RecoilPad", 10,
				"ShotgunSawnoff", 200,
				"ShotgunShells", 200,
				"ShotgunShells", 50,
				"ShotgunShells", 20,
				"ShotgunShells", 10,
				"ShotgunShellsBox", 50,
				"ShotgunShellsBox", 20,
				"ShotgunShellsBox", 10,
			},
			junk = {
				rolls = 1,
				items = {
					"Screwdriver", 4,
				}
			},
			fillRand = 0,
		}
	},

	ShotgunCache2 = {
		ShotgunBox = {
			rolls = 8,
			items = {
				"AmmoStrap_Shells", 0.5,
				"ChokeTubeFull", 1,
				"ChokeTubeImproved", 1,
				"DoubleBarrelShotgun", 8,
				"RecoilPad", 1,
				"Shotgun", 8,
				"ShotgunShellsBox", 50,
				"ShotgunShellsBox", 20,
				"ShotgunShellsBox", 20,
				"ShotgunShellsBox", 10,
				"ShotgunShellsBox", 10,
			},
			junk = {
				rolls = 1,
				items = {
					"Screwdriver", 4,
					"Shotgun", 100,
				}
			}
		},

		counter = {
			rolls = 4,
			items = {
				"AmmoStrap_Shells", 1,
				"ChokeTubeFull", 1,
				"ChokeTubeImproved", 1,
				"DoubleBarrelShotgun", 8,
				"RecoilPad", 1,
				"Shotgun", 8,
				"ShotgunShells", 50,
				"ShotgunShells", 20,
				"ShotgunShells", 10,
				"ShotgunShellsBox", 20,
				"ShotgunShellsBox", 10,
			},
			junk = {
				rolls = 1,
				items = {
					"Screwdriver", 4,
				}
			}
		},
	},

	SurvivorCache1 = {
		counter = {
			procedural = true,
			procList = {
				{name="KitchenCannedFood", min=1, max=7, weightChance=100},
				{name="KitchenDryFood", min=1, max=2, weightChance=100},
				{name="MeleeWeapons", min=1, max=2, weightChance=100},
				{name="FirearmWeapons", min=1, max=1, weightChance=100},
			}
		},

		SurvivorCrate = {
			rolls = 4,
			items = {
				-- Bags
				"Bag_ALICEpack", 1,
				"Bag_BigHikingBag", 2,
				-- Drink/Drink Accessories
				"CanteenMilitary", 4,
				"WaterBottle", 20,
				"WaterBottle", 10,
				"WaterDispenserBottle", 1,
				"WaterRationCan_Box", 1,
				"WaterPurificationTablets", 10,
				-- Food - Candy
				"Gum", 10,
				-- Food - Cans
				"CannedBolognese", 6,
				"CannedBolognese_Box", 0.06,
				"CannedCarrots2", 4,
				"CannedCarrots_Box", 0.04,
				"CannedChili", 6,
				"CannedChili_Box", 0.06,
				"CannedCorn", 4,
				"CannedCornedBeef", 6,
				"CannedCornedBeef_Box", 0.06,
				"CannedCorn_Box", 0.04,
				"CannedFruitBeverage", 6,
				"CannedFruitBeverage_Box", 0.06,
				"CannedFruitCocktail", 6,
				"CannedFruitCocktail_Box", 0.06,
				"CannedMilk", 2,
				"CannedMilk_Box", 0.02,
				"CannedMushroomSoup", 6,
				"CannedMushroomSoup_Box", 0.06,
				"CannedPeaches", 4,
				"CannedPeaches_Box", 0.04,
				"CannedPeas", 4,
				"CannedPeas_Box", 0.04,
				"CannedPineapple", 4,
				"CannedPineapple_Box", 0.04,
				"CannedPotato2", 4,
				"CannedPotato_Box", 0.04,
				"CannedSardines", 6,
				"CannedSardines_Box", 0.06,
				"CannedTomato2", 4,
				"CannedTomato_Box", 0.04,
				"TinnedBeans", 6,
				"TinnedBeans_Box", 0.06,
				"TinnedSoup", 6,
				"TinnedSoup_Box", 0.06,
				"TomatoPaste", 8,
				"TunaTin", 0.06,
				"TunaTin", 6,
				-- Food - Jars
				"CannedBellPepper", 10,
				"CannedBroccoli", 10,
				"CannedCabbage", 10,
				"CannedCarrots", 10,
				"CannedEggplant", 10,
				"CannedLeek", 10,
				"CannedPotato", 10,
				"CannedRedRadish", 10,
				"CannedTomato", 10,
				-- Food - Snacks
				"BeefJerky", 10,
				"Crisps", 4,
				"Crisps2", 4,
				"Crisps3", 4,
				"Crisps4", 4,
				"DehydratedMeatStick", 10,
				"GranolaBar", 10,
				"Peanuts", 4,
				"PorkRinds", 2,
				"SunflowerSeeds", 4,
				-- Survival Gear
				"Base.CampingTentKit2", 1,
				"Candle", 10,
				"CompassDirectional", 10,
				"DryFirestarterBlock", 10,
				"FirstAidKit_New", 8,
				"FlashLight_AngleHead_Army", 1,
				"HandTorch", 8,
				"InsectRepellent", 10,
				"Matchbox", 10,
				"PanForged", 4,
				"PotForged", 1,
				"Torch", 4,
				"WaterPurificationTablets", 1,
				"Whistle", 2,
				-- Weapons
				"Axe", 0.1,
				"BaseballBat", 8,
				"BoltCutters", 1,
				"EntrenchingTool", 1,
				"FireplacePoker", 1,
				"HandAxe", 0.5,
				"HuntingKnife", 10,
				"IceAxe", 1,
				"KnifeButterfly", 10,
				"KnifePocket", 0.1,
				"KnifeShiv", 10,
				"Machete", 0.01,
				"SwitchKnife", 10,
				-- Special
				"CigaretteCarton", 1,
				"MoneyBundle", 10,
			},
			junk = {
				rolls = 1,
				items = {

				}
			}
		}
	},

	SurvivorCache2 = {
		counter = {
			procedural = true,
			procList = {
				{name="KitchenCannedFood", min=1, max=7, weightChance=100},
				{name="KitchenDryFood", min=1, max=2, weightChance=100},
				{name="MeleeWeapons", min=1, max=2, weightChance=100},
				{name="FirearmWeapons", min=1, max=1, weightChance=100},
			}
		},

		SurvivorCrate = {
			rolls = 8,
			items = {
				-- Bags
				"Bag_ALICEpack", 1,
				"Bag_BigHikingBag", 2,
				-- Drink/Drink Accessories
				"CanteenMilitary", 4,
				"WaterBottle", 20,
				"WaterBottle", 10,
				"WaterDispenserBottle", 1,
				"WaterRationCan_Box", 1,
				"WaterPurificationTablets", 10,
				-- Food - Candy
				"Gum", 10,
				-- Food - Cans
				"CannedBolognese", 6,
				"CannedBolognese_Box", 0.06,
				"CannedCarrots2", 4,
				"CannedCarrots_Box", 0.04,
				"CannedChili", 6,
				"CannedChili_Box", 0.06,
				"CannedCorn", 4,
				"CannedCornedBeef", 6,
				"CannedCornedBeef_Box", 0.06,
				"CannedCorn_Box", 0.04,
				"CannedFruitBeverage", 6,
				"CannedFruitBeverage_Box", 0.06,
				"CannedFruitCocktail", 6,
				"CannedFruitCocktail_Box", 0.06,
				"CannedMilk", 2,
				"CannedMilk_Box", 0.02,
				"CannedMushroomSoup", 6,
				"CannedMushroomSoup_Box", 0.06,
				"CannedPeaches", 4,
				"CannedPeaches_Box", 0.04,
				"CannedPeas", 4,
				"CannedPeas_Box", 0.04,
				"CannedPineapple", 4,
				"CannedPineapple_Box", 0.04,
				"CannedPotato2", 4,
				"CannedPotato_Box", 0.04,
				"CannedSardines", 6,
				"CannedSardines_Box", 0.06,
				"CannedTomato2", 4,
				"CannedTomato_Box", 0.04,
				"TinnedBeans", 6,
				"TinnedBeans_Box", 0.06,
				"TinnedSoup", 6,
				"TinnedSoup_Box", 0.06,
				"TomatoPaste", 8,
				"TunaTin", 0.06,
				"TunaTin", 6,
				-- Food - Jars
				"CannedBellPepper", 10,
				"CannedBroccoli", 10,
				"CannedCabbage", 10,
				"CannedCarrots", 10,
				"CannedEggplant", 10,
				"CannedLeek", 10,
				"CannedPotato", 10,
				"CannedRedRadish", 10,
				"CannedTomato", 10,
				-- Food - Snacks
				"BeefJerky", 10,
				"Crisps", 4,
				"Crisps2", 4,
				"Crisps3", 4,
				"Crisps4", 4,
				"DehydratedMeatStick", 10,
				"GranolaBar", 10,
				"Peanuts", 4,
				"PorkRinds", 2,
				"SunflowerSeeds", 4,
				-- Survival Gear
				"Base.CampingTentKit2", 1,
				"Candle", 10,
				"CompassDirectional", 10,
				"DryFirestarterBlock", 10,
				"FirstAidKit_New", 8,
				"FlashLight_AngleHead_Army", 1,
				"HandTorch", 8,
				"InsectRepellent", 10,
				"Matchbox", 10,
				"PanForged", 4,
				"PotForged", 1,
				"Torch", 4,
				"WaterPurificationTablets", 1,
				"Whistle", 2,
				-- Weapons
				"Axe", 0.1,
				"BaseballBat", 8,
				"BoltCutters", 1,
				"EntrenchingTool", 1,
				"FireplacePoker", 1,
				"HandAxe", 0.5,
				"HuntingKnife", 10,
				"IceAxe", 1,
				"KnifeButterfly", 10,
				"KnifePocket", 0.1,
				"KnifeShiv", 10,
				"Machete", 0.01,
				"SwitchKnife", 10,
				-- Special
				"CigaretteCarton", 1,
				"MoneyBundle", 10,
			},
			junk = {
				rolls = 1,
				items = {

				}
			}
		},
	},

	SurvivorCacheBigBuilding = {
		counter = {
			procedural = true,
			procList = {
				{name="KitchenCannedFood", min=0, max=7, weightChance=100},
				{name="KitchenDryFood", min=0, max=1, weightChance=100},
				{name="KitchenRandom", min=0, max=1, weightChance=100},
				{name="MeleeWeapons", min=0, max=1, weightChance=20},
				{name="FirearmWeapons", min=0, max=1, weightChance=10},
			}
		},

		SurvivorCrate = {
			rolls = 4,
			items = {
				-- Bags
				"Bag_ALICEpack", 1,
				"Bag_BigHikingBag", 2,
				-- Drink/Drink Accessories
				"CanteenMilitary", 4,
				"WaterBottle", 20,
				"WaterBottle", 10,
				"WaterDispenserBottle", 1,
				"WaterRationCan_Box", 1,
				"WaterPurificationTablets", 10,
				-- Food - Candy
				"Gum", 10,
				-- Food - Cans
				"CannedBolognese", 6,
				"CannedBolognese_Box", 0.06,
				"CannedCarrots2", 4,
				"CannedCarrots_Box", 0.04,
				"CannedChili", 6,
				"CannedChili_Box", 0.06,
				"CannedCorn", 4,
				"CannedCornedBeef", 6,
				"CannedCornedBeef_Box", 0.06,
				"CannedCorn_Box", 0.04,
				"CannedFruitBeverage", 6,
				"CannedFruitBeverage_Box", 0.06,
				"CannedFruitCocktail", 6,
				"CannedFruitCocktail_Box", 0.06,
				"CannedMilk", 2,
				"CannedMilk_Box", 0.02,
				"CannedMushroomSoup", 6,
				"CannedMushroomSoup_Box", 0.06,
				"CannedPeaches", 4,
				"CannedPeaches_Box", 0.04,
				"CannedPeas", 4,
				"CannedPeas_Box", 0.04,
				"CannedPineapple", 4,
				"CannedPineapple_Box", 0.04,
				"CannedPotato2", 4,
				"CannedPotato_Box", 0.04,
				"CannedSardines", 6,
				"CannedSardines_Box", 0.06,
				"CannedTomato2", 4,
				"CannedTomato_Box", 0.04,
				"TinnedBeans", 6,
				"TinnedBeans_Box", 0.06,
				"TinnedSoup", 6,
				"TinnedSoup_Box", 0.06,
				"TomatoPaste", 8,
				"TunaTin", 0.06,
				"TunaTin", 6,
				-- Food - Jars
				"CannedBellPepper", 10,
				"CannedBroccoli", 10,
				"CannedCabbage", 10,
				"CannedCarrots", 10,
				"CannedEggplant", 10,
				"CannedLeek", 10,
				"CannedPotato", 10,
				"CannedRedRadish", 10,
				"CannedTomato", 10,
				-- Food - Snacks
				"BeefJerky", 10,
				"Crisps", 4,
				"Crisps2", 4,
				"Crisps3", 4,
				"Crisps4", 4,
				"DehydratedMeatStick", 10,
				"GranolaBar", 10,
				"Peanuts", 4,
				"PorkRinds", 2,
				"SunflowerSeeds", 4,
				-- Survival Gear
				"Base.CampingTentKit2", 1,
				"Candle", 10,
				"CompassDirectional", 10,
				"DryFirestarterBlock", 10,
				"FirstAidKit_New", 8,
				"FlashLight_AngleHead_Army", 1,
				"HandTorch", 8,
				"InsectRepellent", 10,
				"Matchbox", 10,
				"PanForged", 4,
				"PotForged", 1,
				"Torch", 4,
				"WaterPurificationTablets", 1,
				"Whistle", 2,
				-- Weapons
				"Axe", 0.1,
				"BaseballBat", 8,
				"BoltCutters", 1,
				"EntrenchingTool", 1,
				"FireplacePoker", 1,
				"HandAxe", 0.5,
				"HuntingKnife", 10,
				"IceAxe", 1,
				"KnifeButterfly", 10,
				"KnifePocket", 0.1,
				"KnifeShiv", 10,
				"Machete", 0.01,
				"SwitchKnife", 10,
				-- Special
				"CigaretteCarton", 1,
				"MoneyBundle", 10,
			},
			junk = {
				rolls = 1,
				items = {

				}
			}
		}
	},

	ToolsCache1 = {
		ToolsBox = {
			rolls = 8,
			items = {
				"Axe", 0.5,
				"BallPeenHammer", 6,
				"BlowTorch", 8,
				"BoltCutters", 8,
				"CarpentryChisel", 8,
				"ClubHammer", 4,
				"Crowbar", 4,
				"DuctTape", 8,
				"Funnel", 10,
				"GardenSaw", 10,
				"Glue", 8,
				"Hammer", 8,
				"HandAxe", 1,
				"KnifePocket", 0.1,
				"LeadPipe", 10,
				"LugWrench", 4,
				"Machete", 0.1,
				"MeasuringTape", 10,
				"NailsBox", 20,
				"NailsBox", 10,
				"NutsBolts", 8,
				"PickAxe", 0.5,
				"PipeWrench", 6,
				"PlasterTrowel", 8,
				"Pliers", 8,
				"Ratchet", 10,
				"Rope", 10,
				"RubberHose", 10,
				"Saw", 8,
				"Screwdriver", 10,
				"ScrewsBox", 8,
				"Sledgehammer", 0.01,
				"Sledgehammer2", 0.01,
				"SteelWool", 10,
				"Tarp", 10,
				"TireIron", 4,
				"TirePump", 8,
				"Twine", 10,
				"ViseGrips", 4,
				"WoodAxe", 0.2,
				"WoodenMallet", 6,
				"Woodglue", 8,
				"Wrench", 10,
			},
			junk = {
				rolls = 1,
				items = {

				}
			}
		},

		counter = {
			rolls = 4,
			items = {
				"BallPeenHammer", 6,
				"BlowTorch", 8,
				"BoltCutters", 8,
				"CarpentryChisel", 8,
				"ClubHammer", 4,
				"Crowbar", 4,
				"Funnel", 10,
				"GardenSaw", 10,
				"Hammer", 8,
				"KnifePocket", 0.1,
				"LeadPipe", 10,
				"LugWrench", 4,
				"MeasuringTape", 10,
				"NailsBox", 20,
				"NailsBox", 10,
				"NutsBolts", 8,
				"PipeWrench", 6,
				"PlasterTrowel", 8,
				"Pliers", 8,
				"Ratchet", 10,
				"RubberHose", 10,
				"Saw", 8,
				"Screwdriver", 10,
				"ScrewsBox", 8,
				"TireIron", 4,
				"TirePump", 8,
				"Twine", 10,
				"ViseGrips", 4,
				"WoodenMallet", 6,
				"Wrench", 10,
			},
			junk = {
				rolls = 1,
				items = {

				}
			}
		},

		Bag_DuffelBagTINT = {
			rolls = 4,
			items = {
				"Axe", 0.5,
				"BallPeenHammer", 6,
				"BlowTorch", 8,
				"BoltCutters", 8,
				"CarpentryChisel", 8,
				"ClubHammer", 4,
				"Crowbar", 4,
				"DuctTape", 8,
				"Funnel", 10,
				"GardenSaw", 10,
				"Glue", 8,
				"Hammer", 8,
				"HandAxe", 1,
				"KnifePocket", 0.1,
				"LeadPipe", 10,
				"LugWrench", 4,
				"Machete", 0.1,
				"MeasuringTape", 10,
				"NailsBox", 20,
				"NailsBox", 10,
				"NutsBolts", 8,
				"PickAxe", 0.5,
				"PipeWrench", 6,
				"PlasterTrowel", 8,
				"Pliers", 8,
				"Ratchet", 10,
				"Rope", 10,
				"RubberHose", 10,
				"Saw", 8,
				"Screwdriver", 10,
				"ScrewsBox", 8,
				"Sledgehammer", 0.01,
				"Sledgehammer2", 0.01,
				"SteelWool", 10,
				"Tarp", 10,
				"TireIron", 4,
				"TirePump", 8,
				"Twine", 10,
				"ViseGrips", 4,
				"WoodAxe", 0.2,
				"WoodenMallet", 6,
				"Woodglue", 8,
				"Wrench", 10,
			},
			junk = {
				rolls = 1,
				items = {

				}
			},
			fillRand = 1,
		}
	},
}

table.insert(Distributions, 1, distributionTable);

--for mod compat:
SuburbsDistributions = distributionTable;