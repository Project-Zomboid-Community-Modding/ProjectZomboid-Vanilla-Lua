KeyNamer.clear()

-- dont use any of these zone names for keys
KeyNamer.badZones:add("Athletic");
KeyNamer.badZones:add("Rich");
KeyNamer.badZones:add("StreetSports");
KeyNamer.badZones:add("StreetPoor");
KeyNamer.badZones:add("StreetRich");
KeyNamer.badZones:add("Rocker");

-- check for a match here first. if the building has any of these rooms
KeyNamer.BigBuildingRooms:add("hospitalroom");
KeyNamer.BigBuildingRooms:add("Gallery");
KeyNamer.BigBuildingRooms:add("motelroom");
KeyNamer.BigBuildingRooms:add("armyhanger");
KeyNamer.BigBuildingRooms:add("batfactory");
KeyNamer.BigBuildingRooms:add("batteryfactory");
KeyNamer.BigBuildingRooms:add("brewery");
KeyNamer.BigBuildingRooms:add("cabinetfactory");
KeyNamer.BigBuildingRooms:add("dogfoodfactoryfactory");
KeyNamer.BigBuildingRooms:add("knifefactory");
KeyNamer.BigBuildingRooms:add("mapfactory");
KeyNamer.BigBuildingRooms:add("metalshop");
KeyNamer.BigBuildingRooms:add("potatostorage");
KeyNamer.BigBuildingRooms:add("producestorage");
KeyNamer.BigBuildingRooms:add("radiofactory");
KeyNamer.BigBuildingRooms:add("stripclub");
KeyNamer.BigBuildingRooms:add("theatre");
KeyNamer.BigBuildingRooms:add("warehouse");
KeyNamer.BigBuildingRooms:add("wirefactory");
KeyNamer.BigBuildingRooms:add("whiskeybottling");
KeyNamer.BigBuildingRooms:add("storageunit");
KeyNamer.BigBuildingRooms:add("church");

-- then check for any of these rooms
KeyNamer.Rooms:add("armysurplus");
KeyNamer.Rooms:add("artstore");
KeyNamer.Rooms:add("bakery");
KeyNamer.Rooms:add("baseballstore");
KeyNamer.Rooms:add("bar");
KeyNamer.Rooms:add("barbecuestore");
KeyNamer.Rooms:add("barkitchen");
KeyNamer.Rooms:add("barstorage");
KeyNamer.Rooms:add("beergarden");
KeyNamer.Rooms:add("bookstore");
KeyNamer.Rooms:add("butcher");
KeyNamer.Rooms:add("cafe");
KeyNamer.Rooms:add("cafekitchen");
KeyNamer.Rooms:add("camerastore");
KeyNamer.Rooms:add("camping");
KeyNamer.Rooms:add("conveniencestore");
KeyNamer.Rooms:add("deepfry_kitchen");
KeyNamer.Rooms:add("fishchipskitchen");
KeyNamer.Rooms:add("gardenstore");
KeyNamer.Rooms:add("generalstore");
KeyNamer.Rooms:add("housewarestore");
KeyNamer.Rooms:add("kitchenwares");
KeyNamer.Rooms:add("knifestore");
KeyNamer.Rooms:add("laboratory");
KeyNamer.Rooms:add("leatherclothesstore");
KeyNamer.Rooms:add("library");
KeyNamer.Rooms:add("lingeriestore");
KeyNamer.Rooms:add("liquorstore");
KeyNamer.Rooms:add("movierental");
KeyNamer.Rooms:add("musicstore");
KeyNamer.Rooms:add("newspaper");
KeyNamer.Rooms:add("optometrist");
KeyNamer.Rooms:add("paintershop");
KeyNamer.Rooms:add("pizzakitchen");
KeyNamer.Rooms:add("restaurant");
KeyNamer.Rooms:add("restaurantkitchen");
KeyNamer.Rooms:add("seafoodkitchen");
KeyNamer.Rooms:add("shed");
KeyNamer.Rooms:add("shoestore");
KeyNamer.Rooms:add("sodatruck");
KeyNamer.Rooms:add("walletshop");
KeyNamer.Rooms:add("warehouse");
KeyNamer.Rooms:add("westernkitchen");

-- then check if any rooms in the building have any of these substrings
KeyNamer.RoomSubstrings:add("aesthetic");
KeyNamer.RoomSubstrings:add("bank");
KeyNamer.RoomSubstrings:add("burger");
KeyNamer.RoomSubstrings:add("cafeteria");
KeyNamer.RoomSubstrings:add("chinese");
KeyNamer.RoomSubstrings:add("clothingstore");
KeyNamer.RoomSubstrings:add("cornerstore");
KeyNamer.RoomSubstrings:add("departmentstore");
KeyNamer.RoomSubstrings:add("donut_");
KeyNamer.RoomSubstrings:add("electronicsstore");
KeyNamer.RoomSubstrings:add("furniturestore");
KeyNamer.RoomSubstrings:add("gasstore");
KeyNamer.RoomSubstrings:add("generalstore");
KeyNamer.RoomSubstrings:add("giftstore");
KeyNamer.RoomSubstrings:add("grocery");
KeyNamer.RoomSubstrings:add("gunstore");
KeyNamer.RoomSubstrings:add("gym");
KeyNamer.RoomSubstrings:add("icecream");
KeyNamer.RoomSubstrings:add("italian");
KeyNamer.RoomSubstrings:add("jayschicken_");
KeyNamer.RoomSubstrings:add("jewelrystore");
KeyNamer.RoomSubstrings:add("mexicankitchen");
KeyNamer.RoomSubstrings:add("office");
KeyNamer.RoomSubstrings:add("pawnshop");
KeyNamer.RoomSubstrings:add("post");
KeyNamer.RoomSubstrings:add("sewingstore");
KeyNamer.RoomSubstrings:add("sportstore");
KeyNamer.RoomSubstrings:add("sushi");
KeyNamer.RoomSubstrings:add("toolstore");
KeyNamer.RoomSubstrings:add("toystore");
KeyNamer.RoomSubstrings:add("zippeestore");


-- Then check for these restaurant rooms
KeyNamer.Restaurants:add("bar");
KeyNamer.Restaurants:add("barbecuestore");
KeyNamer.Restaurants:add("barkitchen");
KeyNamer.Restaurants:add("barstorage");
KeyNamer.Restaurants:add("beergarden");
KeyNamer.Restaurants:add("cafe");
KeyNamer.Restaurants:add("cafekitchen");
KeyNamer.Restaurants:add("deepfry_kitchen");
KeyNamer.Restaurants:add("fishchipskitchen");
KeyNamer.Restaurants:add("pizzakitchen");
KeyNamer.Restaurants:add("seafoodkitchen");
KeyNamer.Restaurants:add("sodatruck");

-- Finally restaurant room substrings
KeyNamer.RestaurantSubstrings:add("burger");
KeyNamer.RestaurantSubstrings:add("cafeteria");
KeyNamer.RestaurantSubstrings:add("chinese");
KeyNamer.RestaurantSubstrings:add("donut_");
KeyNamer.RestaurantSubstrings:add("icecream");
KeyNamer.RestaurantSubstrings:add("italian");
KeyNamer.RestaurantSubstrings:add("jayschicken_");
KeyNamer.RestaurantSubstrings:add("mexicankitchen");
KeyNamer.RestaurantSubstrings:add("sushi");

