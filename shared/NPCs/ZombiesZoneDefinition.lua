ZombiesZoneDefinition = ZombiesZoneDefinition or {};

-- name of the zone for the zone type ZombiesType (in worldzed)
ZombiesZoneDefinition.Wedding = {
	-- you have a 50% chance of having this zone spawning, to bring more randomness to the world
	chanceToSpawn = 50,
	-- max 1 wedding per map
	toSpawn = 1,
	-- Mandatory zed
	WeddingDress = {
		-- name of the outfit
		name="WeddingDress",
		-- number to spawn
		toSpawn=1,
		-- The wedding dress is only on female
		gender="female",
		-- we will be forced to spawn this one
		mandatory="true",
		-- need to be in that exact room
		room="church",
	},
	Groom = {
		name="Groom",
		toSpawn=1,
		gender="male",
		mandatory="true",
		room="church",
	},
	Priest = {
		name="Priest",
		toSpawn=1,
		gender="male",
		mandatory="true",
		room="church",
	},
	-- Others
	Classy = {
		name="Classy",
		-- Chance at 75 means 75% of the zombies spawning (except mandatory) will have this outfit, the other 10% will have generic, the total chance of them all should be <= 100
		chance=75,
		-- no gender selected because we have Classy outfit for both gender
	},
	Waiter = {
		name="Waiter_Classy",
		chance=15,
	}
};

ZombiesZoneDefinition.TrailerPark = {
	Veteran = {
		name="Veteran",
		chance=10,
		gender="male",
	},
	Redneck = {
		name="Redneck",
		chance=35,
-- 		chance=65,
	},
	Thug = {
		name="Thug",
		chance=15,
		gender="male",
	},
-- 	Goth = {
-- 		name="Goth",
-- 		chance=1,
-- 	},
	Rocker = {
		name="Rocker",
		chance=5,
	},
	Trucker = {
		name="Trucker",
		chance=5,
	},
-- 	ExterminatorSuited = {
-- 		name="ExterminatorSuited",
-- 		chance=1,
-- 	},
	Retiree = {
		name="Retiree",
		chance=20,
	},
}

ZombiesZoneDefinition.Pharmacist = {
	-- We ensure we have at least one pharmacist
	PharmacistM = {
		name="Pharmacist",
		toSpawn=1,
		mandatory="true",
	},
	Pharmacist = {
		name="Pharmacist",
		chance=30,
	},
}

ZombiesZoneDefinition.Bowling = {
	Bowling = {
		name="Bowling",
		chance=90,
	},
}

ZombiesZoneDefinition.Doctor = {
	DoctorM = {
		name="Doctor",
		toSpawn=1,
		mandatory="true",
	},
	Doctor = {
		name="Doctor",
		chance=7,
	},
	Nurse = {
		name="Nurse",
		chance=15,
	},
}

ZombiesZoneDefinition.Spiffo = {
	Spiffo = {
		name="Spiffo",
		chance=1,
	},
	Waiter_SpiffoM = {
		name="Waiter_Spiffo",
		toSpawn=1,
		mandatory="true",
	},
	Waiter_Spiffo = {
		name="Waiter_Spiffo",
		chance=15,
	},
	Cook_SpiffosM = {
		name="Cook_Spiffos",
		toSpawn=1,
		mandatory="true",
		room="spiffoskitchen",
	},
	Cook_Spiffos = {
		name="Cook_Spiffos",
		chance=50,
		room="spiffoskitchen",
	},
}

ZombiesZoneDefinition.Jays = {
-- 	Jay = {
-- 		name="Jay",
-- 		chance=1,
-- 	},
	Waiter_JaysM = {
		name="Waiter_Jays",
		toSpawn=1,
		mandatory="true",
	},
	Waiter_Jays = {
		name="Waiter_Jays",
		chance=15,
	},
	Cook_JaysM = {
		name="Cook_Jays",
		toSpawn=1,
		mandatory="true",
		room="jayschicken_kitchen",
	},
	Cook_Jays = {
		name="Cook_Jays",
		chance=50,
		room="jayschicken_kitchen",
	},
}

ZombiesZoneDefinition.Gigamart = {
	GigaMart_EmployeeM = {
		name="GigaMart_Employee",
		toSpawn=1,
		mandatory="true",
	},
	GigaMart_Employee = {
		name="GigaMart_Employee",
		chance=20,
	},
	Cook_GenericM = {
		name="Cook_Generic",
		toSpawn=1,
		mandatory="true",
		room="gigamartkitchen",
	},
	Cook_Generic = {
		name="Cook_Generic",
		chance=50,
		room="gigamartkitchen",
	},
	OfficeWorkerSkirt = {
		name="OfficeWorkerSkirt",
		gender="female",
		chance=20,
		room="office",
	},
	OfficeWorker = {
		name="OfficeWorker",
		gender="male",
		chance=20,
		room="office",
		beardStyles="null:80",
	},
}

ZombiesZoneDefinition.PizzaWhirled = {
	Waiter_PizzaWhirledM = {
		name="Waiter_PizzaWhirled",
		toSpawn=1,
		mandatory="true",
	},
	Waiter_PizzaWhirled = {
		name="Waiter_PizzaWhirled",
		chance=15,
	},
	Cook_GenericM = {
		name="Cook_Generic",
		toSpawn=1,
		mandatory="true",
		room="restaurantkitchen",
	},
	Cook_Generic = {
		name="Cook_Generic",
		chance=50,
		room="restaurantkitchen",
	},
}

ZombiesZoneDefinition.Dinner = {
	Waiter_DinerM = {
		name="Waiter_Diner",
		toSpawn=1,
		mandatory="true",
	},
	Waiter_Diner = {
		name="Waiter_Diner",
		chance=15,
	},
	Cook_GenericM = {
		name="Cook_Generic",
		toSpawn=1,
		mandatory="true",
		room="restaurantkitchen",
	},
	Cook_Generic = {
		name="Cook_Generic",
		chance=50,
		room="restaurantkitchen",
	},
}

ZombiesZoneDefinition.PileOCrepe = {
	Waiter_PileOCrepeM = {
		name="Waiter_PileOCrepe",
		toSpawn=1,
		mandatory="true",
	},
	Waiter_PileOCrepe = {
		name="Waiter_PileOCrepe",
		chance=15,
	},
	ChefM = {
		name="Chef",
		toSpawn=1,
		mandatory="true",
		room="restaurantkitchen",
	},
	Chef = {
		name="Chef",
		chance=50,
		room="restaurantkitchen",
	},
}

ZombiesZoneDefinition.CoffeeShop = {
	Waiter_RestaurantM = {
		name="Waiter_Restaurant",
		toSpawn=1,
		mandatory="true",
	},
	Waiter_Restaurant = {
		name="Waiter_Restaurant",
		chance=15,
	},
	ChefM = {
		name="Chef",
		toSpawn=1,
		mandatory="true",
		room="restaurantkitchen",
	},
	Chef = {
		name="Chef",
		chance=50,
		room="restaurantkitchen",
	},
}

ZombiesZoneDefinition.Coffeshop = ZombiesZoneDefinition.CoffeeShop

ZombiesZoneDefinition.Coffeeshop = ZombiesZoneDefinition.CoffeeShop

ZombiesZoneDefinition.SeaHorse = {
	Waiter_RestaurantM = {
		name="Waiter_Restaurant",
		toSpawn=1,
		mandatory="true",
	},
	Waiter_Restaurant = {
		name="Waiter_Restaurant",
		chance=15,
	},
	ChefM = {
		name="Chef",
		toSpawn=1,
		mandatory="true",
		room="restaurantkitchen",
	},
	Chef = {
		name="Chef",
		chance=50,
		room="restaurantkitchen",
	},
}

ZombiesZoneDefinition.SeaHorses = ZombiesZoneDefinition.SeaHorse

ZombiesZoneDefinition.Seahorse = ZombiesZoneDefinition.SeaHorse

ZombiesZoneDefinition.Restaurant = {
	Waiter_RestaurantM = {
		name="Waiter_Restaurant",
		toSpawn=1,
		mandatory="true",
	},
	Waiter_Restaurant = {
		name="Waiter_Restaurant",
		chance=15,
	},
	ChefM = {
		name="Chef",
		toSpawn=1,
		mandatory="true",
		room="restaurantkitchen",
	},
	Chef = {
		name="Chef",
		chance=50,
		room="restaurantkitchen",
	},
}

ZombiesZoneDefinition.Survivalist = {
	Survivalist = {
		name="Survivalist",
		chance=10,
	},
	Hunter = {
		name="Hunter",
		chance=10,
		beardStyles="Long:10;Chops:10;Goatee:10;Moustache:10;Full:10;BeardOnly:10",
	},
}

ZombiesZoneDefinition.StreetPoor = {
	Hobbo = {
		name="Hobbo",
		chance=15,
		beardStyles="Long:15;Moustache:15;Full:15;BeardOnly:15",
	},
	Punk = {
		name="Punk",
		chance=15,
		beardStyles="null:90",
	},
	Biker = {
		name="Biker",
		chance=15,
		beardStyles="Long:10;Chops:10;Goatee:10;Moustache:10;Full:10;BeardOnly:10",
	},
	Bandit_Early = {
		name="Bandit_Early",
		chance=5,
	},
	Backpacker = {
		name="Backpacker",
		chance=1,
	},
	Evacuee = {
		name="Evacuee",
		chance=1,
	},
	GuitarGuy = {
		name="GuitarGuy",
		chance=1,
	},
	Rocker = {
		name="Rocker",
		chance=5,
	},
	ClubGoer = {
		name="ClubGoer",
		chance=1,
	},
	Trucker = {
		name="Trucker",
		chance=5,
	},
	Sanitation = {
		name="Sanitation",
		chance=1,
	},
-- 	ExterminatorSuited = {
-- 		name="ExterminatorSuited",
-- 		chance=1,
-- 	},
}

ZombiesZoneDefinition.Rocker = {
	Student = {
		name="Student",
		chance=10,
		beardStyles="null:100",
	},
	Punk = {
		name="Punk",
		chance=20,
-- 		chance=40,
		beardStyles="null:90",
	},
	Rocker = {
		name="Rocker",
		chance=20,
		beardStyles="null:90",
	},
	Goth = {
		name="Goth",
		chance=5,
		beardStyles="null:90",
	},
	Grunge = {
		name="Grunge",
		chance=20,
		beardStyles="null:90",
	},
	Young = {
		name="Young",
		chance=10,
		beardStyles="null:100",
	},
}

-- TODO: Not sure yet
ZombiesZoneDefinition.Theatre = {

}

ZombiesZoneDefinition.Shelter = {
	Hobbo = {
		name="Hobbo",
		chance=50,
	},
	Punk = {
		name="Punk",
		chance=20,
		beardStyles="null:90",
	},
	Backpacker = {
		name="Backpacker",
		chance=0.25,
	},
	Evacuee = {
		name="Evacuee",
		chance=1,
	},
}

-- TODO: 2 team (blue/red?)
ZombiesZoneDefinition.LaserTag = {

}

--[[ FIXME: Defined above, was this for something else?
ZombiesZoneDefinition.StreetPoor = {
	Tourist = {
		name="Tourist",
		chance=10,
	},
	Golfer = {
		name="Golfer",
		chance=10,
	},
	Classy = {
		name="Classy",
		chance=20,
	},
}
--]]

ZombiesZoneDefinition.Rich = {
	Tourist = {
		name="Tourist",
		chance=20,
	},
	Golfer = {
		name="Golfer",
		chance=15,
	},
	Classy = {
		name="Classy",
		chance=30,
-- 		chance=40,
	},
	ClubGoer = {
		name="ClubGoer",
		chance=1,
	},
	Gaudy = {
		name="Gaudy",
		chance=5,
	},
	Trader = {
		name="Trader",
		chance=5,
	},
	Retiree = {
		name="Retiree",
		chance=20,
	},
}

ZombiesZoneDefinition.StreetRich = ZombiesZoneDefinition.Rich

ZombiesZoneDefinition.HotelRich = {
	Tourist = {
		name="Tourist",
		chance=20,
	},
	Golfer = {
		name="Golfer",
		chance=15,
	},
	Classy = {
		name="Classy",
		chance=20,
	},
	ClubGoer = {
		name="ClubGoer",
		chance=1,
	},
	Gaudy = {
		name="Gaudy",
		chance=5,
	},
	Retiree = {
		name="Retiree",
		chance=20,
	},
}

ZombiesZoneDefinition.BaseballFan = {
	BaseballFan_Z = {
		name="BaseballFan_Z",
		chance=20,
	},
	BaseballFan_Rangers = {
		name="BaseballFan_Rangers",
		chance=20,
	},
	BaseballFan_KY = {
		name="BaseballFan_KY",
		chance=20,
	},
}

-- TODO: how bad can i do an "old zombies" outfit?
ZombiesZoneDefinition.NursingHome = {
	Classy = {
		name="Classy",
		chance=20,
	},
	Nurse = {
		name="Nurse",
		chance=15,
	},
	Bathrobe = {
		name="Bathrobe",
		chance=10,
	},
	HospitalPatient = {
		name="HospitalPatient",
		chance=10,
	},
	Retiree = {
		name="Retiree",
		chance=20,
	},
	Resident = {
		name="Resident",
		chance=20,
	},
}

-- TODO: gonna need bit more clothing, but should be kinda like the nightclub
ZombiesZoneDefinition.Young = {
	ClubGoer = {
		name="ClubGoer",
		chance=20,
	},
	Goth = {
		name="Goth",
		chance=1,
	},
	Varsity = {
		name="Varsity",
		chance=20,
	},
	Thug = {
		name="Thug",
		chance=5,
		gender="male",
	},
	Gaudy = {
		name="Gaudy",
		chance=20,
	},
	MannequinLeather = {
		name="MannequinLeather",
		chance=1,
	},
}
ZombiesZoneDefinition.Nightclub = {
	ClubGoer = {
		name="ClubGoer",
		chance=20,
	},
	Goth = {
		name="Goth",
		chance=10,
	},
	Thug = {
		name="Thug",
		chance=5,
		gender="male",
	},
	Tourist = {
		name="Tourist",
		chance=5,
	},
	Varsity = {
		name="Varsity",
		chance=5,
	},
	Gaudy = {
		name="Gaudy",
		chance=5,
	},
	MannequinLeather = {
		name="MannequinLeather",
		chance=1,
	},
-- 	CostumeVampire = {
-- 		name="CostumeVampire",
-- 		chance=1,
-- 	},
}

-- TODO: checkout screenshot mb
ZombiesZoneDefinition.Tennis = {

}


ZombiesZoneDefinition.VariousFoodMarket = {
	Waiter_MarketM = {
		name="Waiter_Market",
		toSpawn=1,
		mandatory="true",
	},
	Waiter_Market = {
		name="Waiter_Market",
		chance=15,
	},
}

ZombiesZoneDefinition.FarmingStore = {
	Waiter_MarketM = {
		name="Waiter_Market",
		toSpawn=1,
		mandatory="true",
	},
	Waiter_Market = {
		name="Waiter_Market",
		chance=10,
	},
	Farmer = {
		name="Farmer",
		chance=10,
	},
	Trucker = {
		name="Trucker",
		chance=1,
	},
}

ZombiesZoneDefinition.Athletic = {
	FitnessInstructor = {
		name="FitnessInstructor",
		chance=70,
	},
}

ZombiesZoneDefinition.StreetSports = {
	StreetSports = {
		name="StreetSports",
		chance=80,
	},
}

-- not used yet
ZombiesZoneDefinition.Pony = {
	Jockey01 = {
		name="Jockey01",
		chance=10,
		gender="male",
	},
	Jockey02 = {
		name="Jockey02",
		chance=10,
		gender="male",
	},
	Jockey03 = {
		name="Jockey03",
		chance=10,
		gender="male",
	},
	Jockey06 = {
		name="Jockey06",
		chance=10,
		gender="male",
	},
	Jockey04 = {
		name="Jockey04",
		chance=10,
		gender="female",
	},
	Jockey05 = {
		name="Jockey05",
		chance=10,
		gender="female",
	},
}

ZombiesZoneDefinition.Baseball = {
	BaseballPlayer_KY = {
		name="BaseballPlayer_KY",
		chance=20,
	},
	BaseballPlayer_Z = {
		name="BaseballPlayer_Z",
		chance=20,
	},
	BaseballPlayer_Rangers = {
		name="BaseballPlayer_Rangers",
		chance=20,
	},
}

ZombiesZoneDefinition.Farm = {
	Farmer = {
		name="Farmer",
		chance=80,
		beardStyles="Long:15;Moustache:15;Full:15;BeardOnly:15",
	},
	Trucker = {
		name="Trucker",
		chance=1,
	},
}

ZombiesZoneDefinition.CarRepair = {
	Mechanic = {
		name="Mechanic",
		chance=15,
		gender="male",
		beardStyles="Chops:10;Goatee:10;Moustache:10;Full:10;BeardOnly:10",
	},
	MetalWorker = {
		name="MetalWorker",
		chance=15,
		gender="male",
		beardStyles="Chops:10;Goatee:10;Moustache:10;Full:10;BeardOnly:10",
	},
	Trucker = {
		name="Trucker",
		chance=1,
	},
}

ZombiesZoneDefinition.Fossoil = {
	Fossoil = {
		name="Fossoil",
		chance=15,
	},
	Trucker = {
		name="Trucker",
		chance=1,
	},
}

ZombiesZoneDefinition.Gas2Go = {
	Gas2Go = {
		name="Gas2Go",
		chance=15,
	},
	Trucker = {
		name="Trucker",
		chance=1,
	},
}

ZombiesZoneDefinition.ThunderGas = {
	ThunderGas = {
		name="ThunderGas",
		chance=15,
	},
	Trucker = {
		name="Trucker",
		chance=1,
	},
}

ZombiesZoneDefinition.McCoys = {
	maleChance = 80,
	McCoys = {
		name="McCoys",
		chance=50,
		gender="male",
		beardStyles="Long:20;Chops:10;Goatee:10;Moustache:10;Full:10;BeardOnly:10",
	},
	Foreman = {
		name="Foreman",
		chance=10,
		gender="male",
	},
	OfficeWorkerSkirt = {
		name="OfficeWorkerSkirt",
		gender="female",
		chance=30,
	},
	OfficeWorker = {
		name="OfficeWorker",
		gender="male",
		chance=5,
		beardStyles="null:80",
	},
	Trucker = {
		name="Trucker",
		chance=5,
	},
}

ZombiesZoneDefinition.Factory = {
	OfficeWorkerSkirt = {
		name="OfficeWorkerSkirt",
		gender="female",
		toSpawn=1,
		mandatory="true",
	},
	OfficeWorker = {
		name="OfficeWorker",
		gender="male",
		toSpawn=1,
		mandatory="true",
		beardStyles="null:80",
	},
	ConstructionWorker = {
		name="ConstructionWorker",
		chance=50,
		gender="male",
		beardStyles="Long:10;Chops:10;Goatee:10;Moustache:10;Full:10;BeardOnly:10",
	},
	Foreman = {
		name="Foreman",
		chance=10,
		gender="male",
	},
	Mechanic = {
		name="Mechanic",
		chance=10,
		gender="male",
		beardStyles="Chops:10;Goatee:10;Moustache:10;Full:10;BeardOnly:10",
	},
	MetalWorker = {
		name="MetalWorker",
		chance=10,
		gender="male",
		beardStyles="Chops:10;Goatee:10;Moustache:10;Full:10;BeardOnly:10",
	},
	Trucker = {
		name="Trucker",
		chance=1,
	},
}

ZombiesZoneDefinition.ConstructionSite = {
	ConstructionWorker = {
		name="ConstructionWorker",
		chance=60,
		gender="male",
		beardStyles="Long:10;Chops:10;Goatee:10;Moustache:10;Full:10;BeardOnly:10",
	},
	Foreman = {
		name="Foreman",
		chance=20,
		gender="male",
	},
	MetalWorker = {
		name="MetalWorker",
		chance=5,
		gender="male",
		beardStyles="Chops:10;Goatee:10;Moustache:10;Full:10;BeardOnly:10",
	},
	Trucker = {
		name="Trucker",
		chance=1,
	},
}

ZombiesZoneDefinition.Offices = {
	OfficeWorkerSkirt = {
		name="OfficeWorkerSkirt",
		chance=35,
		gender="female",
	},
	OfficeWorker = {
		name="OfficeWorker",
		chance=35,
		gender="male",
		beardStyles="null:80",
	},
	Trader = {
		name="Trader",
		chance=15,
		beardStyles="null:80",
	},
}

ZombiesZoneDefinition.Bank = {
	OfficeWorkerSkirt = {
		name="OfficeWorkerSkirt",
		chance=25,
		gender="female",
	},
	OfficeWorker = {
		name="OfficeWorker",
		chance=25,
		gender="male",
		beardStyles="null:80",
	},
	Trader = {
		name="Trader",
		chance=10,
		beardStyles="null:80",
	},
}

ZombiesZoneDefinition.SwimmingPool = {
	Swimmer = {
		name="Swimmer",
		chance=100,
	}
}

ZombiesZoneDefinition.Swimmer = ZombiesZoneDefinition.SwimmingPool

ZombiesZoneDefinition.FancyHotel = {
	Tourist = {
		name="Tourist",
		chance=40,
	},
	Bathrobe = {
		name="Bathrobe",
		chance=10,
	},
	Swimmer = {
		name="Swimmer",
		chance=10,
	},
	Waiter_Restaurant = {
		name="Waiter_Restaurant",
		chance=5,
	},
	ClubGoer = {
		name="ClubGoer",
		chance=1,
	},
	Gaudy = {
		name="Gaudy",
		chance=5,
	},
}

ZombiesZoneDefinition.CountryClub = {
	Tourist = {
		name="Tourist",
		chance=20,
	},
	Waiter_Restaurant = {
		name="Waiter_Restaurant",
		chance=10,
	},
	Golfer = {
		name="Golfer",
		chance=15,
	},
	Classy = {
		name="Classy",
		chance=20,
	},
	Gym = {
		name="FitnessInstructor",
		chance=150,
		room="gym",
	},
	Ballroom = {
		name="Classy",
		chance=150,
		room="ballroom",
	},
	Classy = {
		name="Classy",
		chance=150,
		room="ballroom",
	},
	Gaudy = {
		name="Gaudy",
		chance=5,
	},
	Retiree = {
		name="Retiree",
		chance=20,
	},
}

ZombiesZoneDefinition.Spa = {
	Tourist = {
		name="Tourist",
		chance=20,
	},
	Bathrobe = {
		name="Bathrobe",
		chance=30,
	},
	Swimmer = {
		name="Swimmer",
		chance=15,
	},
	Waiter_Restaurant = {
		name="Waiter_Restaurant",
		chance=10,
	},
	ClubGoer = {
		name="ClubGoer",
		chance=1,
	},
	Gaudy = {
		name="Gaudy",
		chance=5,
	},
	Retiree = {
		name="Retiree",
		chance=10,
	},
}

ZombiesZoneDefinition.Golf = {
	Golfer = {
		name="Golfer",
		chance=40,
	},
	Tourist = {
		name="Tourist",
		chance=20,
	},
	Waiter_Restaurant = {
		name="Waiter_Restaurant",
		chance=5,
	},
	Gaudy = {
		name="Gaudy",
		chance=5,
	},
	Retiree = {
		name="Retiree",
		chance=20,
	},
}

ZombiesZoneDefinition.Police = {
	Police = {
		name="Police",
		chance=40,
	},
	Detective = {
		name="Detective",
		chance=10,
	},
	OfficeWorkerSkirt = {
		name="OfficeWorkerSkirt",
		chance=15,
		gender="female",
	},
	OfficeWorker = {
		name="OfficeWorker",
		chance=15,
		gender="male",
		beardStyles="null:80",
	},
	Agent = {
		name="Agent",
		chance=1,
	},
}

ZombiesZoneDefinition.PoliceState = {
	Police = {
		name="PoliceState",
		chance=40,
	},
	Detective = {
		name="Detective",
		chance=1,
	},
	OfficeWorkerSkirt = {
		name="OfficeWorkerSkirt",
		chance=15,
		gender="female",
	},
	OfficeWorker = {
		name="OfficeWorker",
		chance=15,
		gender="male",
		beardStyles="null:80",
	},
	Agent = {
		name="Agent",
		chance=10,
	},
}

ZombiesZoneDefinition.Prison = {
	-- Gonna force male zombies in prison
	maleChance = 80,
	Doctor = {
		name="Doctor",
		chance=2,
	},
	Priest = {
		name="Priest",
		toSpawn=1,
		gender="male",
		mandatory="true",
	},
	Doctor2 = {
		name="Doctor",
		chance=20,
		room="medicalstorage",
	},
	Nurse = {
		name="Nurse",
		chance=30,
		room="medicalstorage",
	},
	Waiter_Diner = {
		name="Waiter_Diner",
		chance=2,
	},
	PrisonGuard = {
		name="PrisonGuard",
		chance=20,
		gender="male",
	},
	OfficeWorkerSkirt = {
		name="OfficeWorkerSkirt",
		gender="female",
		chance=30,
		room="office",
	},
	OfficeWorker = {
		name="OfficeWorker",
		gender="male",
		chance=30,
		room="office",
		beardStyles="null:80",
	},
	Agent = {
		name="Agent",
		chance=1,
		room="office",
	},
	Security = {
		name="PrisonGuard",
		gender="male",
		chance=100,
		room="security",
	},
	Inmate = {
		name="Inmate",
		chance=76,
		gender="male",
		room="prisoncells;hall;cafeteria;classroom;laundry;janitor",
	},
	-- this one is used for lower chance of inmate in some rooms
	InmateLowerZone = {
		name="Inmate",
		chance=30,
		gender="male",
		room="bathroom;kitchen;medicalstorage;library",
	},
	Naked = {
		name="Naked",
		chance=50,
		gender="male",
		room="bathroom",
	},
	Cook_Generic = {
		name="Cook_Generic",
		chance=30,
		gender="male",
		room="kitchen",
	},
}

ZombiesZoneDefinition.FireDept = {
	Fireman = {
		name="Fireman",
		chance=80,
	},
}

ZombiesZoneDefinition.Army = {
	ArmyInstructorM = {
		name="ArmyInstructor",
		toSpawn=1,
		mandatory="true",
		gender="male",
	},
	ArmyInstructor = {
		name="ArmyInstructor",
		chance=2,
		gender="male",
	},
	Ghillie = {
		name="Ghillie",
		chance=2,
		gender="male",
	},
	ArmyCamoDesert = {
		name="ArmyCamoDesert",
		chance=5
	},
	ArmyCamoGreen = {
		name="ArmyCamoGreen",
		chance=5,
	},
	Agent = {
		name="Agent",
		chance=1,
	},
}

ZombiesZoneDefinition.SecretBase = {
	Priest = {
		name="Priest",
		toSpawn=1,
		gender="male",
		mandatory="true",
	},
	ArmyInstructor = {
		name="ArmyInstructor",
		chance=5,
		gender="male",
	},
	ArmyCamoGreen = {
		name="ArmyCamoGreen",
		chance=20,
	},
	OfficeWorkerSkirt = {
		name="OfficeWorkerSkirt",
		chance=10,
		gender="female",
	},
	OfficeWorker = {
		name="OfficeWorker",
		chance=10,
		gender="male",
		beardStyles="null:80",
	},
	Doctor = {
		name="Doctor",
		chance=10,
	},
	Agent = {
		name="Agent",
		chance=1,
	},
}

ZombiesZoneDefinition.Bar = {
	Biker = {
		name="Biker",
		chance=30,
-- 		chance=25,
		beardStyles="Long:10;Chops:10;Goatee:10;Moustache:10;Full:10;BeardOnly:10",
	},
	Veteran = {
		name="Veteran",
		chance=10,
		gender="male",
	},
	Redneck = {
		name="Redneck",
		chance=35,
-- 		chance=50,
	},
	Varsity = {
		name="Varsity",
		chance=5,
	},
	Rocker = {
		name="Rocker",
		chance=5,
	},
	Trucker = {
		name="Trucker",
		chance=5,
	},
	Gaudy = {
		name="Gaudy",
		chance=1,
	},
	Thug = {
		name="Thug",
		chance=5,
		gender="male",
	},
}

ZombiesZoneDefinition.Beach = {
	Tourist = {
		name="Tourist",
		chance=15,
-- 		chance=30,
	},
	Swimmer = {
		name="Swimmer",
		chance=65,
	},
	Backpacker = {
		name="Backpacker",
		chance=5,
	},
	ClubGoer = {
		name="ClubGoer",
		chance=5,
	},
	Gaudy = {
		name="Gaudy",
		chance=5,
	},
}

ZombiesZoneDefinition.School = {
	HonorStudent = {
		name="HonorStudent",
		chance=5,
	},
	ShellSuit_Black = {
		name="ShellSuit_Black",
		chance=3,
	},
	ShellSuit_Blue = {
		name="ShellSuit_Blue",
		chance=3,
	},
	ShellSuit_Green = {
		name="ShellSuit_Green",
		chance=3,
	},
	ShellSuit_Pink = {
		name="ShellSuit_Pink",
		chance=3,
	},
	ShellSuit_Teal = {
		name="ShellSuit_Teal",
		chance=3,
	},
	Young = {
		name="Young",
		chance=15,
	},
	Student = {
		name="Student",
		chance=50,
	},
	Teacher = {
		name="Teacher",
		chance=15,
	},
	Varsity = {
		name="Varsity",
		chance=5,
	},
}

ZombiesZoneDefinition.University = {
	HonorStudent = {
		name="HonorStudent",
		chance=5,
	},
	Young = {
		name="Young",
		chance=15,
	},
	Student = {
		name="Student",
		chance=40,
-- 		chance=50,
	},
	Teacher = {
		name="Teacher",
		chance=15,
	},
	Backpacker = {
		name="Backpacker",
		chance=1,
	},
	Hobbyist = {
		name="Hobbyist",
		chance=1,
	},
	Punk = {
		name="Punk",
		chance=1,
	},
	GuitarGuy = {
		name="GuitarGuy",
		chance=1,
	},
	ClubGoer = {
		name="ClubGoer",
		chance=1,
	},
	Goth = {
		name="Goth",
		chance=1,
	},
	Varsity = {
		name="Varsity",
		chance=5,
	},
	Grunge = {
		name="Grunge",
		chance=5,
	},
	IT= {
		name="IT",
		toSpawn=1,
		mandatory="true",
	},
}

ZombiesZoneDefinition.Boxing = {
	chanceToSpawn = 100,
	RedBoxer = {
		name="BoxingRed",
		toSpawn=1,
		gender="male",
		mandatory="true",
	},
	BlueBoxer = {
		name="BoxingBlue",
		toSpawn=1,
		gender="male",
		mandatory="true",
	},
	Classy = {
		name="Classy",
		chance=75,
	},
	Retiree = {
		name="Retiree",
		chance=10,
	},
};

ZombiesZoneDefinition.Nav = {
	Backpacker = {
		name="Backpacker",
		chance=0.25,
	},
	Evacuee = {
		name="Evacuee",
		chance=0.25,
	},
	Trucker = {
		name="Trucker",
		chance=0.25,
	},
	Sanitation = {
		name="Sanitation",
		chance=0.25,
	},
}



ZombiesZoneDefinition.cornmaze = {
	HonorStudent = {
		name="HonorStudent",
		chance=5,
	},
	Young = {
		name="Young",
		chance=15,
	},
	Student = {
		name="Student",
		chance=40,
-- 		chance=50,
	},
	Hobbyist = {
		name="Hobbyist",
		chance=1,
	},
	Varsity = {
		name="Varsity",
		chance=5,
	},
	Grunge = {
		name="Grunge",
		chance=1,
	},
	CostumeScarecrow = {
		name="CostumeScarecrow",
		chance=5,
	},
	Retiree = {
		name="Retiree",
		chance=10,
	},
}

ZombiesZoneDefinition.CornMaze = ZombiesZoneDefinition.cornmaze

-- Wild West! Yee Haw!
ZombiesZoneDefinition.Cowboy = {
	CostumeWildWestBoss = {
		name="CostumeWildWestBoss",
		chance=1,
	},
	CostumeWildWestClown = {
		name="CostumeWildWestClown",
		chance=4,
	},
	CostumeWildWestCowpoke = {
		name="CostumeWildWestCowpoke",
		chance=5,
	},
	CostumeWildWestFancy = {
		name="CostumeWildWestFancy",
		chance=10,
	},
	CostumeWildWestCowpoke = {
		name="CostumeWildWestLawman",
		chance=5,
	},
	CostumeWildWestMayor = {
		name="CostumeWildWestMayor",
		chance=5,
	},
	CostumeWildWestMountainPerson = {
		name="CostumeWildWestMountainPerson",
		chance=5,
	},
	CostumeWildWestOutlaw = {
		name="CostumeWildWestOutlaw",
		toSpawn=10,
	},
	Retiree = {
		name="Retiree",
		chance=10,
	},
	Student = {
		name="Student",
		chance=10,
-- 		chance=50,
	},
	Tourist = {
		name="Tourist",
		chance=10,
	},
	Varsity = {
		name="Varsity",
		chance=1,
	},
	Young = {
		name="Young",
		chance=10,
	},
	YoungCowpoke = {
		name="YoungCowpoke",
		chance=5,
	},
}

-- Not used yet
ZombiesZoneDefinition.PonyRoama = {
	CostumeWildWestCowpoke = {
		name="CostumeWildWestCowpoke",
		chance=5,
	},
	Student = {
		name="Student",
		chance=10,
	},
	Tourist = {
		name="Tourist",
		chance=10,
	},
	Varsity = {
		name="Varsity",
		chance=1,
	},
	Young = {
		name="Young",
		chance=10,
	},
	YoungCowpoke = {
		name="YoungCowpoke",
		chance=25,
	},
}


ZombiesZoneDefinition.Stripclub = {
	Gaudy = {
		name="Gaudy",
		chance=25,
	},
	Trucker = {
		name="Trucker",
		chance=15,
	},
	CowboyStripper = {
		name="CowboyStripper",
		chance=1,
	},
	FiremanStripper = {
		name="FiremanStripper",
		chance=1,
	},
	PoliceStripper = {
		name="PoliceStripper",
		chance=1,
	},
	FiremanStripper = {
		name="StripperBlack",
		chance=1,
	},
	FiremanStripper = {
		name="StripperNaked",
		chance=1,
	},
	FiremanStripper = {
		name="StripperWhite",
		chance=1,
	},
	WaiterStripper = {
		name="WaiterStripper",
		chance=1,
	},
}

ZombiesZoneDefinition.Mob = {
	Classy = {
		name="Classy",
		chance=10,
		gender="male",
	},
	Clubgoer = {
		name="Clubgoer",
		chance=15,
		gender="female",
	},
	Gaudy = {
		name="Gaudy",
		chance=15,
	},
	Mob = {
		name="Mob",
		chance=15,
		gender="male",
	},
	MobCasual = {
		name="MobCasual",
		chance=15,
		gender="male",
	},
	Thug = {
		name="Mob",
		chance=15,
		gender="male",
	},
	Waiter_Classy = {
		name="Waiter_Classy",
		chance=15,
	}
}

ZombiesZoneDefinition.Cultists = {
	Cultist = {
		name="Cultist",
		chance=100,
	},
}

ZombiesZoneDefinition.SecretLab = {
	ArmyInstructor = {
		name="ArmyInstructor",
		chance=5,
		gender="male",
	},
	ArmyCamoGreen = {
		name="ArmyCamoGreen",
		chance=20,
	},
	OfficeWorkerSkirt = {
		name="OfficeWorkerSkirt",
		chance=10,
		gender="female",
	},
	OfficeWorker = {
		name="OfficeWorker",
		chance=10,
		gender="male",
		beardStyles="null:80",
	},
	Doctor = {
		name="Doctor",
		chance=10,
	},
	Agent = {
		name="Agent",
		chance=5,
	},
	HazardSuit = {
		name="HazardSuit",
		chance=20,
	},
}

-- total chance can be over 100% we don't care as we'll roll on the totalChance and not a 100 (unlike the specific outfits on top of this)
ZombiesZoneDefinition.Default = {};

--table.insert(ZombiesZoneDefinition.Default,{name = "FitnessInstructor", chance=20000});
table.insert(ZombiesZoneDefinition.Default,{name = "Generic01", chance=20});
table.insert(ZombiesZoneDefinition.Default,{name = "Generic02", chance=20});
table.insert(ZombiesZoneDefinition.Default,{name = "Generic03", chance=20});
table.insert(ZombiesZoneDefinition.Default,{name = "Generic_Skirt", gender="female", chance=20});
table.insert(ZombiesZoneDefinition.Default,{name = "Generic04", chance=20});
table.insert(ZombiesZoneDefinition.Default,{name = "Generic05", chance=20});
table.insert(ZombiesZoneDefinition.Default,{name = "Biker", chance=0.3});
table.insert(ZombiesZoneDefinition.Default,{name = "Cyclist", chance=0.5});
table.insert(ZombiesZoneDefinition.Default,{name = "DressLong", chance=3, gender="female"});
table.insert(ZombiesZoneDefinition.Default,{name = "DressNormal", chance=3, gender="female"});
table.insert(ZombiesZoneDefinition.Default,{name = "DressShort", chance=3, gender="female"});
table.insert(ZombiesZoneDefinition.Default,{name = "Golfer", chance=0.2});
table.insert(ZombiesZoneDefinition.Default,{name = "Young", chance=2});
table.insert(ZombiesZoneDefinition.Default,{name = "OfficeWorker", chance=2, gender="male"});
table.insert(ZombiesZoneDefinition.Default,{name = "OfficeWorkerSkirt", chance=2, gender="female"});
-- reduced as they are quite commonplace and also have good gear
table.insert(ZombiesZoneDefinition.Default,{name = "Police", chance=0.25});
table.insert(ZombiesZoneDefinition.Default,{name = "PoliceState", chance=0.1});
table.insert(ZombiesZoneDefinition.Default,{name = "Ranger", chance=0.25});
-- table.insert(ZombiesZoneDefinition.Default,{name = "Police", chance=0.5});
-- table.insert(ZombiesZoneDefinition.Default,{name = "PoliceState", chance=0.5});
-- table.insert(ZombiesZoneDefinition.Default,{name = "Ranger", chance=1});
table.insert(ZombiesZoneDefinition.Default,{name = "ConstructionWorker", chance=0.5, gender="male"});
table.insert(ZombiesZoneDefinition.Default,{name = "Farmer", chance=0.5});
table.insert(ZombiesZoneDefinition.Default,{name = "Student", chance=1});
table.insert(ZombiesZoneDefinition.Default,{name = "Foreman", chance=0.5, gender="male"});
table.insert(ZombiesZoneDefinition.Default,{name = "Bathrobe", chance=10, room="bathroom"});
table.insert(ZombiesZoneDefinition.Default,{name = "Naked", chance=10, room="bathroom"});
table.insert(ZombiesZoneDefinition.Default,{name = "Priest", chance=10, room="church", gender="male"});
table.insert(ZombiesZoneDefinition.Default,{name = "Bedroom", chance=10, room="bedroom"});
-- table.insert(ZombiesZoneDefinition.Default,{name = "Backpacker", chance=0.25});
table.insert(ZombiesZoneDefinition.Default,{name = "Evacuee", chance=0.25});
table.insert(ZombiesZoneDefinition.Default,{name = "Hobbyist", chance=50, room="comicstore"});
table.insert(ZombiesZoneDefinition.Default,{name = "HonorStudent", chance=25, room="comicstore"});
table.insert(ZombiesZoneDefinition.Default,{name = "Goth", chance=10, room="comicstore"});
table.insert(ZombiesZoneDefinition.Default,{name = "IT", chance=1, room="comicstore"});
-- table.insert(ZombiesZoneDefinition.Default,{name = "CostumeVampire", chance=1, room="comicstore"});
table.insert(ZombiesZoneDefinition.Default,{name = "Varsity", chance=0.5});
table.insert(ZombiesZoneDefinition.Default,{name = "Sanitation", chance=0.1});
table.insert(ZombiesZoneDefinition.Default,{name = "ExterminatorSuited", chance=0.01});
table.insert(ZombiesZoneDefinition.Default,{name = "Retiree", chance=1});
table.insert(ZombiesZoneDefinition.Default,{name = "HospitalPatient", chance=50, room="hospitalroom"});
table.insert(ZombiesZoneDefinition.Default,{name = "HospitalPatientBathrobe", chance=50, room="hospitalroom"});
table.insert(ZombiesZoneDefinition.Default,{name = "Hobbo", chance=5, room="derelict"});
table.insert(ZombiesZoneDefinition.Default,{name = "Bandit", chance=1, room="derelict"});


