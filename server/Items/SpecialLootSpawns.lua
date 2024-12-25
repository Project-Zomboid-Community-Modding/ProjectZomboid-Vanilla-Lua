SpecialLootSpawns = SpecialLootSpawns or {}

-- STOCK CERTIFICATES
SpecialLootSpawns.OnCreateStockCertificate = function(item)
    if not item then return; end;
	local text = getText(item:getDisplayName()) .. ": "
	if ZombRand(2) == 0 then
		text = text .. getText("IGUI_" .. SpecialLootSpawns.StockCertificate1[ZombRand(#SpecialLootSpawns.StockCertificate1)+1])
		item:setTexture(getTexture("media/textures/Item_StockCertificate2.png"))
		item:setWorldStaticModel("StockCertificate2")
	else
		text = text .. getText("IGUI_" .. SpecialLootSpawns.StockCertificate2[ZombRand(#SpecialLootSpawns.StockCertificate2)+1])
	end
	item:setName(text)
end
-- PAPERWORK
SpecialLootSpawns.OnCreatePaperwork = function(item)
    if not item then return; end;
    local num = tostring(ZombRand(6)+1)
	item:setTexture(getTexture("media/textures/Item_Paperwork" .. num .. ".png"))
	item:setWorldStaticModel("Paperwork" .. num)
end

-- Monograms
SpecialLootSpawns.OnCreateMonogram = function(item)
    if not item then return; end;

	local name = SurvivorFactory.getRandomForename(true):sub(1, 1) .. SurvivorFactory.getRandomSurname():sub(1, 1)
	item:setName(getText(item:getDisplayName()) .. ": " .. name)
end

-- ID CARDS
SpecialLootSpawns.OnCreateIDcard = function(item)
    if not item then return; end;
	if ZombRand(2) == 0 then
	    SpecialLootSpawns.OnCreateIDcard_Female(item)
	else
	    SpecialLootSpawns.OnCreateIDcard_Male(item)
	end
end

SpecialLootSpawns.OnCreateIDcard_Female = function(item)
    if not item then return; end;
	local name = SurvivorFactory.getRandomForename(true) .. " " .. SurvivorFactory.getRandomSurname()
	item:setName(getText(item:getDisplayName()) .. ": " .. name)
	if item:IsLiterature() then item:setLockedBy(tostring(ZombRand(1000000))) end
end

SpecialLootSpawns.OnCreateIDcard_Male = function(item)
    if not item then return; end;
	local name = SurvivorFactory.getRandomForename(false) .. " " .. SurvivorFactory.getRandomSurname()
	item:setName(getText(item:getDisplayName()) .. ": " ..name)
	if item:IsLiterature() then item:setLockedBy(tostring(ZombRand(1000000))) end
end
-- Dog Tags
SpecialLootSpawns.OnCreateDogTag = function(item)
    if not item then return; end;
	if ZombRand(2) == 0 then
	    SpecialLootSpawns.OnCreateDogTag_Female(item)
	else
	    SpecialLootSpawns.OnCreateDogTag_Male(item)
	end
end

SpecialLootSpawns.OnCreateDogTag_Female = function(item)
    if not item then return; end;
	local name = SurvivorFactory.getRandomForename(true) .. " " .. SurvivorFactory.getRandomSurname()
	item:setName(getText(item:getDisplayName()) .. ": " .. name)
end

SpecialLootSpawns.OnCreateDogTag_Male = function(item)
    if not item then return; end;
	local name = SurvivorFactory.getRandomForename(false) .. " " .. SurvivorFactory.getRandomSurname()
	item:setName(getText(item:getDisplayName()) .. ": " ..name)
end
-- NOTES
-- SpecialLootSpawns.OnCreateNote = function(item)
--     if not item then return; end;
-- 	if ZombRand(2) == 0 then
-- 		item:setTexture(getTexture("media/textures/Item_Note2.png"))
-- 		item:setWorldStaticModel("Note2")
-- 	end
-- end
-- PHOTOS
SpecialLootSpawns.OnCreatePhoto = function(item)
    if not item then return; end;
-- 	if ZombRand(2) == 0 then
-- 		item:setTexture(getTexture("media/textures/Item_Photo_Old2.png"))
-- 		item:setWorldStaticModel("Photo2")
-- 	end
	local list = SpecialLootSpawns.OldPhotos
	local photo = list[ZombRand(#list)+1]
    local title = getText("IGUI_Photo_" .. photo)
    local text =  getText(item:getScriptItem():getDisplayName()) .. " " .. getText("IGUI_PhotoOf") .. " " .. title
    item:setName(text)
    item:getModData().literatureTitle = "Photo_" .. photo .. tostring(ZombRand(1000000))
end
SpecialLootSpawns.OnCreatePhoto_Secret = function(item)
    if not item then return; end;
	local list = SpecialLootSpawns.SecretPhotos
	local photo = list[ZombRand(#list)+1]
    local title = getText("IGUI_Photo_" .. photo)
    local text =  getText(item:getScriptItem():getDisplayName()) .. " " .. getText("IGUI_PhotoOf") .. " " .. title
    item:setName(text)
    item:getModData().literatureTitle = "SecretPhoto_" .. photo .. tostring(ZombRand(1000000))
end
SpecialLootSpawns.OnCreatePhoto_Racy = function(item)
    if not item then return; end;
	local list = SpecialLootSpawns.RacyPhotos
	local photo = list[ZombRand(#list)+1]
    local title = getText("IGUI_Photo_" .. photo)
    local text =  getText(item:getScriptItem():getDisplayName()) .. " " .. getText("IGUI_PhotoOf") .. " " .. title
    item:setName(text)
    item:getModData().literatureTitle = "SecretPhoto_" .. photo .. tostring(ZombRand(1000000))
end
SpecialLootSpawns.OnCreatePhoto_VeryOld = function(item)
    if not item then return; end;
-- 	if ZombRand(2) == 0 then
-- 		item:setTexture(getTexture("media/textures/Item_Photo_Old2.png"))
-- 		item:setWorldStaticModel("Photo2")
-- 	end
	local list = SpecialLootSpawns.VeryOldPhotos
	local photo = list[ZombRand(#list)+1]
    local title = getText("IGUI_Photo_" .. photo)
    local text =  getText(item:getScriptItem():getDisplayName()) .. " " .. getText("IGUI_PhotoOf") .. " " .. title
    item:setName(text)
    item:getModData().literatureTitle = "VeryOldPhoto_" .. photo .. tostring(ZombRand(1000000))
end

-- BOOKS
SpecialLootSpawns.OnCreateSubjectBook = function(item, subject)
    if not item then return; end;
    local hardcover = item:hasTag("Hardcover") or item:hasTag("HollowBook") or item:hasTag("FancyBook") or item:getType():contains("Book")
    local softcover = item:hasTag("Softcover")  or item:getType():contains("Paperback")
    local cover
	local bookList = SpecialLootSpawns.BookTitles[subject]
	local book = bookList[ZombRand(#bookList)+1]
	local rightCover = false
	local details = SpecialLootSpawns.BookDetails[book]
    if details and details.cover then cover = details.cover end
    rightCover = (cover and ((cover == "both") or (cover == "hardcover" and hardcover) or (cover == "softcover" and softcover))) or not details or not cover
-- we check if the book has the right cover and if not generate a new book
    if rightCover then
        local title = getTextOrNull("IGUI_BookTitle_" .. book) or book
        local text = getText(item:getScriptItem():getDisplayName()) .. ": " .. title
        item:setName(text)
        item:getModData().literatureTitle = book
        return
    end
    SpecialLootSpawns.GetCoverFromList(item, hardcover, bookList)
end
SpecialLootSpawns.OnCreateSpecialBook = function(item, subject)
    if not item then return; end;
	local bookList = SpecialLootSpawns.BookTitles[subject]
	local book = bookList[ZombRand(#bookList)+1]
    local title = getTextOrNull("IGUI_BookTitle_" .. book) or book
    local text = getText(item:getScriptItem():getDisplayName()) .. ": " .. title
    item:setName(text)
    item:getModData().literatureTitle = book
end
SpecialLootSpawns.GetCoverFromList = function(item, hardcover, oldBookList)
    local bookList = {}
    local book
    local softcover = not hardcover
    local rightCover = false
    local canDo
    -- we copy the book list so we can remove invalid entries without breaking the root list
    local j = 1
    for i = 1, #oldBookList + 1 do
        book = oldBookList[i]
        details = SpecialLootSpawns.BookDetails[book]
        if details and details.cover and ((details.cover == "both")  or (details.cover == "hardcover" and hardcover) or (details.cover == "softcover" and softcover))then
		    bookList[j] = oldBookList[i]
		    j = j + 1
		    canDo = true
		end
    end
-- if a proper cover is not possible a new random book is generated
    if not canDo  then
        SpecialLootSpawns.OnCreateBook(item)
        return
    end
    while rightCover == false do
        book = bookList[ZombRand(#bookList)+1]
        details = SpecialLootSpawns.BookDetails[book]
        if details and details.cover and ((details.cover == "both")  or (details.cover == "hardcover" and hardcover) or (details.cover == "softcover" and softcover)) then
            local title = getTextOrNull("IGUI_BookTitle_" .. book) or book
            local text = getText(item:getScriptItem():getDisplayName()) .. ": " .. title
            item:setName(text)
            item:getModData().literatureTitle = book
            rightCover = true
            return
        end
    end
end
SpecialLootSpawns.OnCreateAdventureNonFictionBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "AdventureNonFiction")
end
SpecialLootSpawns.OnCreateArtBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Art")
end
SpecialLootSpawns.OnCreateBaseballBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Baseball")
end
SpecialLootSpawns.OnCreateBibleBook = function(item)
    if not item then return; end;
    local title = getTextOrNull("IGUI_BookTitle_TheBible") or book
    local text = getText(item:getScriptItem():getDisplayName()) .. ": " .. title
    item:setName(text)
    item:getModData().literatureTitle = "TheBible"
end
SpecialLootSpawns.OnCreateBiographyBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Biography")
end
SpecialLootSpawns.OnCreateBusinessBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Business")
end
SpecialLootSpawns.OnCreateChildsBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Childs")
end
SpecialLootSpawns.OnCreateComputerBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Computer")
end
SpecialLootSpawns.OnCreateConspiracyBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Conspiracy")
end
SpecialLootSpawns.OnCreateCrimeFictionBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "CrimeFiction")
end
SpecialLootSpawns.OnCreateCinemaBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Cinema")
end
SpecialLootSpawns.OnCreateClassicBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Classic")
end
SpecialLootSpawns.OnCreateClassicFictionBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "ClassicFiction")
end
SpecialLootSpawns.OnCreateClassicNonfictionBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Classic")
end
SpecialLootSpawns.OnCreateDietBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Diet")
end
SpecialLootSpawns.OnCreateFantasyBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Fantasy")
end
SpecialLootSpawns.OnCreateFarmingBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Farming")
end
SpecialLootSpawns.OnCreateFashionBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Fashion")
end
SpecialLootSpawns.OnCreateFictionBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, SpecialLootSpawns.BookSubjectsFictionGenres[ZombRand(#SpecialLootSpawns.BookSubjectsFictionGenres)+1])
end
SpecialLootSpawns.OnCreateGeneralNonFictionBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, SpecialLootSpawns.BookSubjectsNonFiction[ZombRand(#SpecialLootSpawns.BookSubjectsNonFiction)+1])
end
SpecialLootSpawns.OnCreateGeneralReferenceBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "GeneralReference")
end
SpecialLootSpawns.OnCreateGolfBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Golf")
end
SpecialLootSpawns.OnCreateHassBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Hass")
end
SpecialLootSpawns.OnCreateHistoryBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "History")
end
SpecialLootSpawns.OnCreateHorrorBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Horror")
end
SpecialLootSpawns.OnCreateLegalBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Legal")
end
SpecialLootSpawns.OnCreateLiteraryFictionBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "GeneralFiction")
end
SpecialLootSpawns.OnCreateMedicalBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Medical")
end
SpecialLootSpawns.OnCreateMilitaryBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Military")
end
SpecialLootSpawns.OnCreateMilitaryHistoryBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "MilitaryHistory")
end
SpecialLootSpawns.OnCreateMusicBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Music")
end
SpecialLootSpawns.OnCreateNatureBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Nature")
end
SpecialLootSpawns.OnCreateNewAgeBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "NewAge")
end
SpecialLootSpawns.OnCreateOccultBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Occult")
end
SpecialLootSpawns.OnCreatePhilosophyBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Philosophy")
end
SpecialLootSpawns.OnCreatePlayBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Play")
end
SpecialLootSpawns.OnCreatePolicingBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Policing")
end
SpecialLootSpawns.OnCreatePoliticsBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Politics")
end
SpecialLootSpawns.OnCreatePoorBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, SpecialLootSpawns.BookSubjectsPoor[ZombRand(#SpecialLootSpawns.BookSubjectsPoor)+1])
end
SpecialLootSpawns.OnCreateQuackeryBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Quackery")
end
SpecialLootSpawns.OnCreateQuigleyBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Quigley")
end
SpecialLootSpawns.OnCreateRelationshipBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Relationship")
end
SpecialLootSpawns.OnCreateReligionBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Religion")
end
SpecialLootSpawns.OnCreateRichBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, SpecialLootSpawns.BookSubjectsRich[ZombRand(#SpecialLootSpawns.BookSubjectsRich)+1])
end
SpecialLootSpawns.OnCreateRomanceBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Romance")
end
SpecialLootSpawns.OnCreateSadNonFictionBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "SadNonFiction")
end
SpecialLootSpawns.OnCreateScaryBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, SpecialLootSpawns.BookSubjectsScary[ZombRand(#SpecialLootSpawns.BookSubjectsScary)+1])
end
SpecialLootSpawns.OnCreateSchoolTextbookBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "SchoolTextbook")
end
SpecialLootSpawns.OnCreateScienceBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Science")
end
SpecialLootSpawns.OnCreateSciFiBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "SciFi")
end
SpecialLootSpawns.OnCreateSelfHelpBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "SelfHelp")
end
SpecialLootSpawns.OnCreateSexyBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Sexy")
end
SpecialLootSpawns.OnCreateSportsBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Sports")
end
SpecialLootSpawns.OnCreateTeensBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Teens")
end
SpecialLootSpawns.OnCreateThrillerBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Thriller")
end
SpecialLootSpawns.OnCreateTravelBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Travel")
end
SpecialLootSpawns.OnCreateTrueCrimeBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "TrueCrime")
end
SpecialLootSpawns.OnCreateWesternBook = function(item)
    if not item then return; end;
    SpecialLootSpawns.OnCreateSubjectBook(item, "Western")
end
SpecialLootSpawns.OnCreateBook = function(item)
    if not item then return end
--     local cover
--     local hardcover = item:hasTag("Hardcover") or item:getType():contains("Book")
--     local softcover = item:hasTag("Softcover")  or item:getType():contains("Paperback")
--     if hardcover then cover = "Hardcover" end
--     if softcover then cover = "Softcover" end
    SpecialLootSpawns.OnCreateSubjectBook(item, SpecialLootSpawns.BookSubjects[ZombRand(#SpecialLootSpawns.BookSubjects)+1])
--     SpecialLootSpawns.OnCreateSubjectBook(item, SpecialLootSpawns.BookSubjects[ZombRand(#SpecialLootSpawns.BookSubjects.Hardcover)+1])
end
-- COMIC BOOK
SpecialLootSpawns.OnCreateComicBook = function(item)
    if not item then return; end;
	local text
	local bookList = SpecialLootSpawns.ComicBooks
	local comic = bookList[ZombRand(#bookList)+1]
	local details = SpecialLootSpawns.ComicBookDetails[comic]
	local issue = 0
	if details.issues == 0 then issue = 0
	else
	    local maxIssue = details.issues
	    local roll = ZombRand(details.issues) +1
	    local roll2 = ZombRand(details.issues) +1
	    local roll3 = ZombRand(details.issues) +1
	    if roll2 > roll then roll = roll2 end
	    if roll3 > roll then roll = roll3 end
	    issue = roll +1
	end

	local comic2 = "IGUI_ComicTitle_" .. comic

	if issue == 0 then
		text = getText(item:getDisplayName()) .. ": " .. getText(comic2)
	elseif issue <= 9 and details.issues >= 100 then
		text = getText(item:getDisplayName()) .. ": " .. getText(comic2) .. " #00" .. tostring(issue)
	elseif issue <= 9 and details.issues >= 10 then
		text = getText(item:getDisplayName()) .. ": " .. getText(comic2) .. " #0" .. tostring(issue)
	elseif issue <= 99 and details.issues >= 100 then
		text = getText(item:getDisplayName()) .. ": " .. getText(comic2) .. " #0" .. tostring(issue)
	else
		text = getText(item:getDisplayName()) .. ": " .. getText(comic2) .. " #" .. tostring(issue)
	end
	item:setName(text)
    item:getModData().literatureTitle = comic .. "#" .. tostring(issue)
end

SpecialLootSpawns.OnCreateComicBookRetail = function(item)
    if not item then return; end;
	local text
	local bookList = SpecialLootSpawns.ComicBooks
	local comic = bookList[ZombRand(#bookList)+1]
	local details = SpecialLootSpawns.ComicBookDetails[comic]
	local inPrint = details.inPrint
	while inPrint == false do
        details = SpecialLootSpawns.ComicBookDetails[comic]
        inPrint = details.inPrint
        if inPrint == false then comic = bookList[ZombRand(#bookList)+1] end
	end
	local issue = 0
	local maxIssues = details.issues or 0
	if details.issues == 0 then issue = 0
	elseif ZombRand(3) == 0 then issue = details.issues
	else
	    issue = ZombRand(maxIssues - 4, maxIssues) +1
	    if issue < 1 then issue = maxIssues end
	end
	local comic2 = "IGUI_ComicTitle_" .. comic
	if issue == 0 then
		text = getText(item:getDisplayName()) .. ": " .. getText(comic2)
	elseif issue <= 9 and details.issues >= 100 then
		text = getText(item:getDisplayName()) .. ": " .. getText(comic2) .. " #00" .. tostring(issue)
	elseif issue <= 9 and details.issues >= 10 then
		text = getText(item:getDisplayName()) .. ": " .. getText(comic2) .. " #0" .. tostring(issue)
	elseif issue <= 99 and details.issues >= 100 then
		text = getText(item:getDisplayName()) .. ": " .. getText(comic2) .. " #0" .. tostring(issue)
	else
		text = getText(item:getDisplayName()) .. ": " .. getText(comic2) .. " #" .. tostring(issue)
	end
	item:setName(text)
    item:getModData().literatureTitle = comic .. "#" .. tostring(issue)
end
-- PACKED FIRST AID KITS
SpecialLootSpawns.FirstAidKit_New = function(item)
    item:getItemContainer():AddItem("Base.AlcoholWipes")
    item:getItemContainer():AddItem("Base.Bandage")
    item:getItemContainer():AddItem("Base.Bandage")
    item:getItemContainer():AddItem("Base.Bandaid")
    item:getItemContainer():AddItem("Base.Bandaid")
    item:getItemContainer():AddItem("Base.CottonBalls")
    item:getItemContainer():AddItem("Base.ScissorsBlunt")
    item:getItemContainer():AddItem("Base.Scotchtape")
    item:getItemContainer():AddItem("Base.Tweezers")
end

SpecialLootSpawns.FirstAidKit_NewPro = function(item)
    item:getItemContainer():AddItem("Base.AlcoholBandage")
    item:getItemContainer():AddItem("Base.AlcoholBandage")
    item:getItemContainer():AddItem("Base.AlcoholWipes")
    item:getItemContainer():AddItem("Base.Bandaid")
    item:getItemContainer():AddItem("Base.Bandaid")
    item:getItemContainer():AddItem("Base.Coldpack")
    item:getItemContainer():AddItem("Base.CottonBalls")
    item:getItemContainer():AddItem("Base.Gloves_Surgical")
    item:getItemContainer():AddItem("Base.Gloves_Surgical")
    item:getItemContainer():AddItem("Base.Pills")
    item:getItemContainer():AddItem("Base.Scalpel")
    item:getItemContainer():AddItem("Base.ScissorsBluntMedical")
    item:getItemContainer():AddItem("Base.Scotchtape")
    item:getItemContainer():AddItem("Base.SutureNeedle")
    item:getItemContainer():AddItem("Base.SutureNeedle")
    item:getItemContainer():AddItem("Base.SutureNeedleHolder")
    item:getItemContainer():AddItem("Base.Tweezers")
end
-- MAGAZINES

SpecialLootSpawns.OnCreateMagazine = function(item)
    SpecialLootSpawns.OnCreateMagazine2(item)
end
SpecialLootSpawns.OnCreateMagazine2 = function(item)
    if not item then return; end;
	local text
	local bookList = SpecialLootSpawns.Magazines
	SpecialLootSpawns.OnCreateMagazine3(item, subject, bookList)
end
SpecialLootSpawns.OnCreateSubjectMagazine = function(item, subject)
    if not item then return; end;
	local text
	local bookList = SpecialLootSpawns.MagazineSubjects[subject]
	SpecialLootSpawns.OnCreateMagazine3(item, subject, bookList)
end
SpecialLootSpawns.OnCreateMagazine3 = function(item, subject, bookList)
    if not item then return; end;
	local text
-- 	local bookList = SpecialLootSpawns.MagazineSubjects[subject]
	local book = bookList[ZombRand(#bookList)+1]
-- 	print("OnCreateMagazine3 - " .. tostring(book))
	local details = SpecialLootSpawns.MagazineDetails[book]
-- 	print("Details3 - " .. tostring(details))
	local year = 1993
	local month = 7
	if not item:hasTag("New") then
        local minYear = details.firstYear or 1970
        local die = 1993 - minYear
        local roll = ZombRand(die)
        local roll2 = ZombRand(die)
        local roll3 = ZombRand(die)
        if roll2 > roll then roll = roll2 end
        if roll3 > roll then roll = roll3 end
        if die >= 100 then
            local roll4 = ZombRand(die)
            if roll4 > roll then roll = roll4 end
        end
        if die >= 50 then
            local roll4 = ZombRand(die)
            if roll4 > roll then roll = roll4 end
        end
        if die >= 20 then
            local roll4 = ZombRand(die)
            if roll4 > roll then roll = roll4 end
        end
        if die >= 10 then
            local roll4 = ZombRand(die)
            if roll4 > roll then roll = roll4 end
        end
        year = roll + minYear
        month = ZombRand(12) +1
        if year == 1993 then month = ZombRand(7) +1 end
    end

	text = getText(item:getDisplayName()) .. ": " .. getText("IGUI_MagazineTitle_" .. book) .. " - " .. getText("Sandbox_StartMonth_option" .. tostring(month)) .. " " .. tostring(year)
	item:setName(text)
    item:getModData().literatureTitle = book .. "_" .. tostring(month) .. "_" .. tostring(year)
end

SpecialLootSpawns.OnCreateArtMagazine = function(item)
    if not item then return; end;
	SpecialLootSpawns.OnCreateSubjectMagazine(item, "Art")
end

SpecialLootSpawns.OnCreateBusinessMagazine = function(item)
    if not item then return; end;
	SpecialLootSpawns.OnCreateSubjectMagazine(item, "Business")
end

SpecialLootSpawns.OnCreateCarMagazine = function(item)
    if not item then return; end;
	SpecialLootSpawns.OnCreateSubjectMagazine(item, "Cars")
end

SpecialLootSpawns.OnCreateChildsMagazine = function(item)
    if not item then return; end;
	SpecialLootSpawns.OnCreateSubjectMagazine(item, "Childs")
end

SpecialLootSpawns.OnCreateCinemaMagazine = function(item)
    if not item then return; end;
	SpecialLootSpawns.OnCreateSubjectMagazine(item, "Cinema")
end

SpecialLootSpawns.OnCreateCrimeMagazine = function(item)
    if not item then return; end;
	SpecialLootSpawns.OnCreateSubjectMagazine(item, "Crime")
end

SpecialLootSpawns.OnCreateFashionMagazine = function(item)
    if not item then return; end;
	SpecialLootSpawns.OnCreateSubjectMagazine(item, "Fashion")
end

SpecialLootSpawns.OnCreateFirearmMagazine = function(item)
    if not item then return; end;
	SpecialLootSpawns.OnCreateSubjectMagazine(item, "Firearm")
end

SpecialLootSpawns.OnCreateGamingMagazine = function(item)
    if not item then return; end;
	SpecialLootSpawns.OnCreateSubjectMagazine(item, "Gaming")
end

SpecialLootSpawns.OnCreateGolfMagazine = function(item)
    if not item then return; end;
	SpecialLootSpawns.OnCreateSubjectMagazine(item, "Golf")
end

SpecialLootSpawns.OnCreateHealthMagazine = function(item)
    if not item then return; end;
	SpecialLootSpawns.OnCreateSubjectMagazine(item, "Health")
end

SpecialLootSpawns.OnCreateHobbyMagazine = function(item)
    if not item then return; end;
	SpecialLootSpawns.OnCreateSubjectMagazine(item, "Hobby")
end

SpecialLootSpawns.OnCreateHorrorMagazine = function(item)
    if not item then return; end;
	SpecialLootSpawns.OnCreateSubjectMagazine(item, "Horror")
end

SpecialLootSpawns.OnCreateHumorMagazine = function(item)
    if not item then return; end;
	SpecialLootSpawns.OnCreateSubjectMagazine(item, "Humor")
end

SpecialLootSpawns.OnCreateMilitaryMagazine = function(item)
    if not item then return; end;
	SpecialLootSpawns.OnCreateSubjectMagazine(item, "Military")
end

SpecialLootSpawns.OnCreateMusicMagazine = function(item)
    if not item then return; end;
	SpecialLootSpawns.OnCreateSubjectMagazine(item, "Music")
end

SpecialLootSpawns.OnCreateOutdoorsMagazine = function(item)
    if not item then return; end;
	SpecialLootSpawns.OnCreateSubjectMagazine(item, "Outdoors")
end

SpecialLootSpawns.OnCreatePoliceMagazine = function(item)
    if not item then return; end;
	SpecialLootSpawns.OnCreateSubjectMagazine(item, "Police")
end

SpecialLootSpawns.OnCreatePopularMagazine = function(item)
    if not item then return; end;
	SpecialLootSpawns.OnCreateSubjectMagazine(item, "Popular")
end

SpecialLootSpawns.OnCreateRichMagazine = function(item)
    if not item then return; end;
	SpecialLootSpawns.OnCreateSubjectMagazine(item, "Rich")
end

SpecialLootSpawns.OnCreateScienceMagazine = function(item)
    if not item then return; end;
	SpecialLootSpawns.OnCreateSubjectMagazine(item, "Science")
end

SpecialLootSpawns.OnCreateSportsMagazine = function(item)
    if not item then return; end;
	SpecialLootSpawns.OnCreateSubjectMagazine(item, "Sports")
end

SpecialLootSpawns.OnCreateTechMagazine = function(item)
    if not item then return; end;
	SpecialLootSpawns.OnCreateSubjectMagazine(item, "Tech")
end

SpecialLootSpawns.OnCreateTeensMagazine = function(item)
    if not item then return; end;
	SpecialLootSpawns.OnCreateSubjectMagazine(item, "Teens")
end

SpecialLootSpawns.OnCreateHottieZ = function(item)
    if not item then return; end;
--     local hunkZ = false
	if ZombRand(20) == 0 then
-- 	    hunkZ = true
	    SpecialLootSpawns.OnCreateHunkZ(item)
	    return
    end
	local year = 1993
	local month = 7
	if not item:hasTag("New") then

        local minYear = 1953
--         if hunkZ then minYear = 1973 end

        local die = 1993 - minYear
        local roll = ZombRand(die)
        local roll2 = ZombRand(die)
        local roll3 = ZombRand(die)
        if roll2 > roll then roll = roll2 end
        if roll3 > roll then roll = roll3 end
        if die >= 100 then
            local roll4 = ZombRand(die)
            if roll4 > roll then roll = roll4 end
        end
        if die >= 50 then
            local roll4 = ZombRand(die)
            if roll4 > roll then roll = roll4 end
        end
        if die >= 20 then
            local roll4 = ZombRand(die)
            if roll4 > roll then roll = roll4 end
        end
        if die >= 10 then
            local roll4 = ZombRand(die)
            if roll4 > roll then roll = roll4 end
        end
        year = roll + minYear
        month = ZombRand(12) +1
        if year == 1993 then month = ZombRand(7) +1 end
    end
    local name = getText(item:getDisplayName())
    local book = "HottieZ"
-- 	if hunkZ then
-- 		item:setTexture(getTexture("media/textures/Item_MagazineNudie2.png"))
-- 		item:setWorldStaticModel("HottieZGround2")
-- 		item:setStaticModel("HottieZ2")
-- 		name = getText("IGUI_MagazineTitle_HunkZ")
-- 		book = "HunkZ"
-- 	end
	text = name .. " - " .. getText("Sandbox_StartMonth_option" .. tostring(month)) .. " " .. tostring(year)
	item:setName(text)
    item:getModData().literatureTitle = book .. "_" .. tostring(month) .. "_" .. tostring(year)
end

SpecialLootSpawns.OnCreateHunkZ = function(item)
    if not item then return; end;
    local hunkZ = true
	local year = 1993
	local month = 7
	if not item:hasTag("New") then

        local minYear = 1973

        local die = 1993 - minYear
        local roll = ZombRand(die)
        local roll2 = ZombRand(die)
        local roll3 = ZombRand(die)
        if roll2 > roll then roll = roll2 end
        if roll3 > roll then roll = roll3 end
        if die >= 100 then
            local roll4 = ZombRand(die)
            if roll4 > roll then roll = roll4 end
        end
        if die >= 50 then
            local roll4 = ZombRand(die)
            if roll4 > roll then roll = roll4 end
        end
        if die >= 20 then
            local roll4 = ZombRand(die)
            if roll4 > roll then roll = roll4 end
        end
        if die >= 10 then
            local roll4 = ZombRand(die)
            if roll4 > roll then roll = roll4 end
        end
        year = roll + minYear
        month = ZombRand(12) +1
        if year == 1993 then month = ZombRand(7) +1 end
    end
    local name = getText(item:getDisplayName())
    local book = "HunkZ"
--     name = getText("IGUI_MagazineTitle_HunkZ")
	text = name .. " - " .. getText("Sandbox_StartMonth_option" .. tostring(month)) .. " " .. tostring(year)
	item:setName(text)
    item:getModData().literatureTitle = book .. "_" .. tostring(month) .. "_" .. tostring(year)
end

SpecialLootSpawns.OnCreateScratchTicketWinner = function(result)
    local name = getText(result:getDisplayName())
    local rollMax = #Recipe.ScratchTicketWinnings
    local roll = ZombRand(rollMax)
    local roll2 = ZombRand(rollMax)
    if roll2 < roll then roll = roll2 end
    local roll2 = ZombRand(rollMax)
    if roll2 < roll then roll = roll2 end
    local roll2 = ZombRand(rollMax)
    if roll2 < roll then roll = roll2 end
    local roll2 = ZombRand(rollMax)
    if roll2 < roll then roll = roll2 end
    local roll2 = ZombRand(rollMax)
    if roll2 < roll then roll = roll2 end
    roll = roll + 1
    local sum = Recipe.ScratchTicketWinnings[roll]
    result:setName(name  .. " " .. sum)
end

SpecialLootSpawns.OnCreateSealedParcel = function(item)
    local mData = item:getModData()
    mData.SealedParcel = true
end

-- SpecialLootSpawns.OnCreateCard_Christmas = function(item)
--     if not item then return; end;
-- 	if ZombRand(2) == 0 then
-- 		item:setTexture(getTexture("media/textures/Item_Card_Christmas2.png"))
-- 		item:setWorldStaticModel("Card_Christmas2")
-- 	end
-- end

SpecialLootSpawns.OnCreateOldNewspaper = function(item)
    if not item then return; end;
 	local text
 	local bookList = PrintMediaDefinitions.OldNewspapers
 	local text = getText(item:getDisplayName()) .. ": " .. getText("IGUI_NewspaperTitle_" .. bookList[ZombRand(#bookList)+1])
 	item:setName(text)
end

SpecialLootSpawns.OnCreateRecentNewspaper = function(item)
    if not item then return; end;
 	local bookList = PrintMediaDefinitions.Newspapers
 	local book = bookList[ZombRand(#bookList)+1]
 	local details = PrintMediaDefinitions.NewspaperDetails[book]
    if not details then
        print("ERROR: Unknown print media " .. book)
        return
    end
 	local issues = details.issues
 	local issue = issues[ZombRand(#issues)+1]
    local text = getText(item:getDisplayName()) .. ": " .. getText("IGUI_NewspaperTitle_" .. book) .. " - " .. getText("IGUI_NewspaperDate_".. issue)
 	item:setName(text)
    item:getModData().printMedia = book .. "_" .. issue
end

SpecialLootSpawns.OnCreateNewNewspaper = function(item)
    if not item then return; end;
 	local bookList = PrintMediaDefinitions.Newspapers
 	local book = bookList[ZombRand(#bookList)+1]
 	local details = PrintMediaDefinitions.NewspaperDetails[book]
    if not details then
        print("ERROR: Unknown print media " .. book)
        return
    end
 	local issues = details.issues
 	local issue = issues[#issues]
    local text = getText(item:getDisplayName()) .. ": " .. getText("IGUI_NewspaperTitle_" .. book) .. " - " .. getText("IGUI_NewspaperDate_".. issue)
 	item:setName(text)
    item:getModData().printMedia = book .. "_" .. issue
end

SpecialLootSpawns.OnCreateDispatchNewNewspaper = function(item)
    if not item then return; end;
 	local book = "NationalDispatch"
 	local details = PrintMediaDefinitions.NewspaperDetails[book]
 	local issues = details.issues
 	local issue = issues[#issues]
    local text = getText(item:getDisplayName()) .. ": " .. getText("IGUI_NewspaperTitle_" .. book) .. " - " .. getText("IGUI_NewspaperDate_".. issue)
 	item:setName(text)
    item:getModData().printMedia = book .. "_" .. issue
end

SpecialLootSpawns.OnCreateHeraldNewNewspaper = function(item)
    if not item then return; end;
 	local book = "KentuckyHerald"
 	local details = PrintMediaDefinitions.NewspaperDetails[book]
 	local issues = details.issues
 	local issue = issues[#issues]
    local text = getText(item:getDisplayName()) .. ": " .. getText("IGUI_NewspaperTitle_" .. book) .. " - " .. getText("IGUI_NewspaperDate_".. issue)
 	item:setName(text)
    item:getModData().printMedia = book .. "_" .. issue
end

SpecialLootSpawns.OnCreateKnewsNewNewspaper = function(item)
    if not item then return; end;
 	local book = "KnoxKnews"
 	local details = PrintMediaDefinitions.NewspaperDetails[book]
 	local issues = details.issues
 	local issue = issues[#issues]
    local text = getText(item:getDisplayName()) .. ": " .. getText("IGUI_NewspaperTitle_" .. book) .. " - " .. getText("IGUI_NewspaperDate_".. issue)
 	item:setName(text)
    item:getModData().printMedia = book .. "_" .. issue
end

SpecialLootSpawns.OnCreateTimesNewNewspaper = function(item)
    if not item then return; end;
 	local book = "LouisvilleSunTimes"
 	local details = PrintMediaDefinitions.NewspaperDetails[book]
 	local issues = details.issues
 	local issue = issues[#issues]
    local text = getText(item:getDisplayName()) .. ": " .. getText("IGUI_NewspaperTitle_" .. book) .. " - " .. getText("IGUI_NewspaperDate_".. issue)
 	item:setName(text)
    item:getModData().printMedia = book .. "_" .. issue
end

SpecialLootSpawns.OnCreateTVMagazine = function(item)
    if not item then return; end;
	local year = 1993
	local month = 7
	if not item:hasTag("New") then
        local minYear = 1953
        local die = 1993 - minYear

        local roll = ZombRand(die)
        for i = 0, 12 do
            local roll2 = ZombRand(die)
            if roll2 > roll then roll = roll2 end
        end

        year = roll + minYear + 1
        month = ZombRand(12) +1
        if year == 1993 then
            month = ZombRand(7) +1
            month2 = ZombRand(7) +1
            month3 = ZombRand(7) +1
            if month2 > month then month = month2 end
            if month3 > month then month = month3 end
        end
    end
    local book = "TVMagazine"
	text = getText(item:getDisplayName()) .. " - " .. getText("Sandbox_StartMonth_option" .. tostring(month)) .. " " .. tostring(year)
	item:setName(text)
    item:getModData().literatureTitle = book .. "_" .. tostring(month) .. "_" .. tostring(year)
end

SpecialLootSpawns.OnCreateBrochure = function(item)
    if not item then return; end;
	local text
	local bookList = PrintMediaDefinitions.Brochures
	local book = bookList[ZombRand(#bookList)+1]
	local text = getText(item:getDisplayName()) .. ": " .. getText("Print_Media_" .. book .. "_title" )
	item:setName(text)
    item:getModData().printMedia = book
end

SpecialLootSpawns.OnCreateFlier = function(item)
    if not item then return; end;
	local text
	local bookList = PrintMediaDefinitions.Fliers
	local book = bookList[ZombRand(#bookList)+1]
	local text = getText(item:getDisplayName()) .. ": " .. getText("Print_Media_" .. book .. "_title" )
	item:setName(text)
    item:getModData().printMedia = book
end

SpecialLootSpawns.OnCreateFlier_Nolans = function(item)
    if not item then return; end;
	local text
	local book = "NolansUsedCars"
	local text = getText(item:getDisplayName()) .. ": " .. getText("Print_Media_" .. book .. "_title" )
	item:setName(text)
    item:getModData().printMedia = book
end

SpecialLootSpawns.OnCreateBusinessCard = function(item)
    if not item then return; end;
    local name
	if ZombRand(2) == 0 then
	    name = SurvivorFactory.getRandomForename(true) .. " " .. SurvivorFactory.getRandomSurname()
	else
	    name = SurvivorFactory.getRandomForename(false) .. " " .. SurvivorFactory.getRandomSurname()
	end
	local list = SpecialLootSpawns.BusinessCards
	if ZombRand(2) == 0 then list = SpecialLootSpawns.JobTitles end
	local title = list[ZombRand(#list)+1]
	item:setName(getText(item:getDisplayName()) .. ": " .. name .. " - " .. getText("IGUI_" .. title))
end

SpecialLootSpawns.OnCreateBusinessCard_Nolans = function(item)
    if not item then return; end;
	item:setName(getText(item:getDisplayName()) .. ": "  .. getText("IGUI_NolansUsedCars"))
end

SpecialLootSpawns.OnCreateCatalogue = function(item)
    if not item then return; end;
	local list = SpecialLootSpawns.Catalogues
	local title = list[ZombRand(#list)+1]
	item:setName(getText(item:getDisplayName()) .. ": ".. getText("IGUI_" .. title))
    item:getModData().literatureTitle = item:getType() .. "_" .. title
end

SpecialLootSpawns.OnCreateRPGmanual = function(item)
    if not item then return; end;
	local list = SpecialLootSpawns.RPGs
	local title = list[ZombRand(#list)+1]
	item:setName(getText(item:getDisplayName()) .. ": ".. getText("IGUI_RPG_" .. title))
    item:getModData().literatureTitle = item:getType() .. "_" .. title
end

SpecialLootSpawns.OnCreateRegion = {}

SpecialLootSpawns.OnCreateRegion.Newspaper_Recent = function(item, region)
    if not item then return; end;
 	local bookList = PrintMediaDefinitions.RegionalPapers[region]
 	if not bookList then bookList = PrintMediaDefinitions.RegionalPapers.General end
 	local book = bookList[ZombRand(#bookList)+1]
 	local details = PrintMediaDefinitions.NewspaperDetails[book]
    if not details then
        print("ERROR: Unknown print media " .. book)
        return
    end
 	local issues = details.issues
 	local issue = issues[ZombRand(#issues)+1]
    local text = getText(item:getScriptItem():getDisplayName()) .. ": " .. getText("IGUI_NewspaperTitle_" .. book) .. " - " .. getText("IGUI_NewspaperDate_".. issue)
 	item:setName(text)
    item:getModData().printMedia = book .. "_" .. issue
end

SpecialLootSpawns.OnCreateRegion.Newspaper_New = function(item, region)
    if not item then return; end;
 	local bookList = PrintMediaDefinitions.RegionalPapers[region]
 	if not bookList then bookList = PrintMediaDefinitions.RegionalPapers.General end
 	local book = bookList[ZombRand(#bookList)+1]
--  	print("Newspaper " .. tostring(book))
 	local details = PrintMediaDefinitions.NewspaperDetails[book]
    if not details then
        print("ERROR: Unknown print media " .. book)
        return
    end
 	local issues = details.issues
 	local issue = issues[#issues]
    local text = getText(item:getScriptItem():getDisplayName()) .. ": " .. getText("IGUI_NewspaperTitle_" .. book) .. " - " .. getText("IGUI_NewspaperDate_".. issue)
 	item:setName(text)
    item:getModData().printMedia = book .. "_" .. issue
end
SpecialLootSpawns.OnCreateGenericMail = function(item)
    if not item then return; end;
    text = getText("IGUI_" .. SpecialLootSpawns.GenericMail[ZombRand(#SpecialLootSpawns.GenericMail)+1])
	item:setName(text)
end
-- LETTERS
SpecialLootSpawns.OnCreateLetterHandwritten = function(item)
    if not item then return; end;
-- 	if ZombRand(2) == 0 then
-- 		item:setTexture(getTexture("media/textures/Item_LetterHandwritten2.png"))
-- 		item:setWorldStaticModel("LetterHandwritten2")
-- 		item:setStaticModel("LetterHandwritten2")
-- 	end
--     item:getModData().literatureTitle = "LetterHandwritten_"  .. tostring(ZombRand(1000000))
    text = getText("IGUI_" .. SpecialLootSpawns.LetterHandwritten[ZombRand(#SpecialLootSpawns.LetterHandwritten)+1])
	item:setName(text)
end
SpecialLootSpawns.OnCreateScarecrow = function(item)
	local spriteName = "location_shop_mall_01_68"
	local obj = IsoMannequin.new(getCell(), nil, getSprite(spriteName))
	obj:setMannequinScriptName("MannequinScarecrow02")
	obj:setCustomSettingsToItem(item)
end
SpecialLootSpawns.OnCreateSkeletonDisplay = function(item)
	local spriteName = "location_shop_mall_01_68"
	local obj = IsoMannequin.new(getCell(), nil, getSprite(spriteName))
	obj:setMannequinScriptName("MannequinSkeleton01")
	obj:setCustomSettingsToItem(item)
end
SpecialLootSpawns.OnCreateLocket = function(item)
    if not item then return end
-- L

	local list = SpecialLootSpawns.Locket
	local photo = list[ZombRand(#list)+1]
    local title = getText("IGUI_Photo_" .. photo)

-- 	local list = SpecialLootSpawns.VeryOldPhotos
-- 	local photo = list[ZombRand(#list)+1]
--     local title = getText("IGUI_Photo_" .. photo)
    local text = getText(item:getScriptItem():getDisplayName()) .. " " .. getText("IGUI_LocketText") .. " " .. title
	item:setName(text)
end

SpecialLootSpawns.OnCreateDoodle = function(item)
    if not item then return; end;
	local list = SpecialLootSpawns.Doodle
	local photo = list[ZombRand(#list)+1]
    local title = getText("IGUI_Photo_" .. photo)
    local text =  getText(item:getScriptItem():getDisplayName()) .. " " .. getText("IGUI_PhotoOf") .. " " .. title
    item:setName(text)
    item:getModData().literatureTitle = "Doodle_" .. photo .. tostring(ZombRand(1000000))
end

SpecialLootSpawns.OnCreateDoodleKids = function(item)
    if not item then return; end;
	local list = SpecialLootSpawns.DoodleKids
	local photo = list[ZombRand(#list)+1]
    local title = getText("IGUI_Doodle_" .. photo)
    local text =  getText(item:getScriptItem():getDisplayName()) .. " " .. getText("IGUI_PhotoOf") .. " " .. title
    item:setName(text)
    item:getModData().literatureTitle = "Doodle_" .. photo .. tostring(ZombRand(1000000))
end

SpecialLootSpawns.OnCreateGasMask = function(item)
    if not item then return; end;
    local mData = item:getModData()
    mData.filterType = "Base.GasmaskFilter"
    local value = ZombRand(1000)/1000.0
    mData.usedDelta = value;
    item:setUsedDelta(ZombRand(1000)/1000.0)
--     mData.usedDelta = ZombRand(1000)/1000.0
--:getClothingItem()
end

SpecialLootSpawns.OnCreateRespirator = function(item)
    if not item then return; end;
    local mData = item:getModData()
    mData.filterType = "Base.RespiratorFilters"
    local value = ZombRand(1000)/1000.0
    mData.usedDelta = value;
    item:setUsedDelta(ZombRand(1000)/1000.0)
--     mData.usedDelta = ZombRand(1000)/1000.0
--:getClothingItem()
end

SpecialLootSpawns.OnCreateSCBA = function(item)
    if not item then return; end;
    local mData = item:getModData()
    mData.tankType = "Base.Oxygen_Tank"
    local value = ZombRand(1000)/1000.0
    mData.usedDelta = value;
    item:setUsedDelta(ZombRand(1000)/1000.0)
--     mData.usedDelta = ZombRand(1000)/1000.0
--:getClothingItem()
end

-- SpecialLootSpawns.OnCreateCanteenMilitary = function(item)
--     if not item then return; end;
--     local num = ZombRand(3)
--     if num == 0 then return
--     elseif num == 1 then
--         item:setStaticModel("CanteenMilitaryUS")
--         item:setWorldStaticModel("CanteenMilitaryUS_Ground")
-- 		item:setTexture(getTexture("media/textures/Item_Canteen_Military_Green.png"))
--     else
--         item:setStaticModel("CanteenMilitaryCamo")
--         item:setWorldStaticModel("CanteenMilitaryCamo_Ground")
-- 		item:setTexture(getTexture("media/textures/Item_Canteen_Military_Camo.png"))
--     end
-- end
--
-- SpecialLootSpawns.OnCreateCanteen = function(item)
--     if not item then return; end;
--     local num = ZombRand(5)
--     if num == 0 then return
--     elseif num == 1 then
--         item:setStaticModel("CanteenMilitaryUS")
--         item:setWorldStaticModel("CanteenMilitaryUS_Ground")
-- 		item:setTexture(getTexture("media/textures/Item_Canteen_Military_Green.png"))
--     elseif num == 2 then
--         item:setStaticModel("CanteenMilitaryCamo")
--         item:setWorldStaticModel("CanteenMilitaryCamo_Ground")
-- 		item:setTexture(getTexture("media/textures/Item_Canteen_Military_Camo.png"))
--     elseif num == 3 then
--         item:setStaticModel("CanteenMilitaryBlack")
--         item:setWorldStaticModel("CanteenMilitaryBlack_Ground")
-- 		item:setTexture(getTexture("media/textures/Item_Canteen_Black.png"))
--     elseif num == 4 then
--         item:setStaticModel("CanteenMilitaryMetal")
--         item:setWorldStaticModel("CanteenMilitaryMetal_Ground")
-- 		item:setTexture(getTexture("media/textures/Item_Canteen_Metal.png"))
--     end
-- end

SpecialLootSpawns.OnCreateHairDyeBottle = function(item)
    if not item then return; end;
	if not item:getFluidContainer() then return end;
	local fluid = item:getFluidContainer():getPrimaryFluid();
	if fluid then
		local color	= item:getFluidContainer():getColor();
		local r, g, b = color:getR(), color:getG(), color:getB();
		item:setColorRed(r);
		item:setColorGreen(g);
		item:setColorBlue(b);
	end
end

SpecialLootSpawns.OnCreatePopBottle = function(item)
    if not item then return; end;
	if not item:getFluidContainer() then return end;
	local fluid = item:getFluidContainer():getPrimaryFluid();
	if fluid:getFluidTypeString() == "SodaPop" then
		item:setModelIndex(1);	
	else
		item:setModelIndex(0);
	end

	local fluidColor = item:getFluidContainer():getColor();
	local r, g, b = fluidColor:getR(), fluidColor:getG(), fluidColor:getB();
	
	if fluid:getFluidTypeString() == "Cola" then
		r, g, b = 1.0, 0.0, 0.0;
	elseif fluid:getFluidTypeString() == "GingerAle" then
		r, g, b = 0.0, 0.0, 1.0;
	elseif fluid:getFluidTypeString() == "SodaLime" then
		r, g, b = 0.0, 1.0, 0.0;			
	elseif fluid:getFluidTypeString() == "SodaPop" then
		r, g, b = 1.0, 0.8, 0.0;	
	end

	item:setColorRed(r);
	item:setColorGreen(g);
	item:setColorBlue(b);
	item:setColor(Color.new(r, g, b));
	item:setCustomColor(true);
end

SpecialLootSpawns.OnCreatePopCan = function(item)
    if not item then return; end;
	if not item:getFluidContainer() then return end;
	local fluid = item:getFluidContainer():getPrimaryFluid();
	if fluid:getFluidTypeString() == "ColaDiet" then
		item:setModelIndex(0);
	elseif fluid:getFluidTypeString() == "Cola" then
		item:setModelIndex(1);	
	elseif fluid:getFluidTypeString() == "GingerAle" then
		item:setModelIndex(2);			
	else
		item:setModelIndex(0);
	end
end

SpecialLootSpawns.OnCreateColorFromDefinition = function(item)
    if not item then return; end;
	if not RandomTint[item:getType()] then return; end;
	
	local colorTable = RandomTint[item:getType()];
	if #colorTable == 0 then return; end;

	local rgbTable = colorTable[ZombRand(1, #RandomTint[item:getType()] + 1)];
	local r, g, b = rgbTable.r, rgbTable.g, rgbTable.b;

	item:setColorRed(r);
	item:setColorGreen(g);
	item:setColorBlue(b);
	item:setColor(Color.new(r, g, b));
	item:setCustomColor(true);
end

SpecialLootSpawns.OnCreateRandomColor = function(item)
    if not item then return; end;
	if item:isCustomColor() == true then return; end;

	local r, g, b = ZombRandFloat(0.0, 1.0), ZombRandFloat(0.0, 1.0), ZombRandFloat(0.0, 1.0);

	item:setColorRed(r);
	item:setColorGreen(g);
	item:setColorBlue(b);
	item:setColor(Color.new(r, g, b));
	item:setCustomColor(true);
end

SpecialLootSpawns.OnCreateSodaCan = function(item)
    if not item then return; end;
	if not item:getFluidContainer() then return end;
	local color = item:getFluidContainer():getColor();
	local r, g, b = color:getR(), color:getG(), color:getB();

	item:setColorRed(r);
	item:setColorGreen(g);
	item:setColorBlue(b);
	item:setColor(color);
	item:setCustomColor(true);
end

SpecialLootSpawns.OnCreateWaterBottle = function(item)
    if not item then return; end;
	if not item:getFluidContainer() then return end;
	local fluid = item:getFluidContainer():getPrimaryFluid();
	local r, g, b;
	
	if fluid:getFluidTypeString() == "Water" then
		r, g, b = 0.0, 0.0, 1.0;
	elseif fluid:getFluidTypeString() == "CarbonatedWater" then
		r, g, b = 0.0, 1.0, 1.0;
	end

	item:setColorRed(r);
	item:setColorGreen(g);
	item:setColorBlue(b);
	item:setColor(Color.new(r, g, b));
	item:setCustomColor(true);
end

SpecialLootSpawns.OnCreateDogTag_Pet = function(item)
    if not item then return; end;
	local text = getText(item:getDisplayName()) .. ": "
    text = text .. getText("IGUI_PetName_" .. SpecialLootSpawns.DogTags[ZombRand(#SpecialLootSpawns.DogTags)+1])
	item:setName(text)
end

SpecialLootSpawns.OnCreatePostcard = function(item)
    if not item then return; end;
    local card = SpecialLootSpawns.Postcards[ZombRand(#SpecialLootSpawns.Postcards)+1]
    local text = getText("IGUI_Photo_" .. card)
    text =  getText(item:getScriptItem():getDisplayName()) .. " " .. getText("IGUI_PhotoOf") .. " " .. text
	item:setName(text)
    item:getModData().literatureTitle = "IGUI_Postcard_" .. card
end
-- RECIPES
SpecialLootSpawns.OnCreateRecipeClipping = function(item)
    if not item then return; end;
	local list = SpecialLootSpawns.FoodRecipes
	local roll = ZombRand(#list)+1
	local recipe = list[roll]
	local recipeName = Translator.getRecipeName(recipe)
	local itemName = getText(item:getDisplayName())
    item:getModData().teachedRecipe = recipe
    local text = itemName .. ": " .. recipeName
	item:setName(text)
end

-- Modify a book to teach recipe according to a list, can have multiple teached recipes.
SpecialLootSpawns.CreateSchematic = function(item, list, multipleChance)
    if not item then return; end;
    if multipleChance and ZombRand(100) < multipleChance then
        local nb = ZombRand(2, #list+1);
        -- still limit the number of taught recipes for balance reason
        if nb > 5 then
            nb = 5;
        end
        local alreadyAdded = {};
        item:setTeachedRecipes(ArrayList.new());
        for i=0,nb do
            local recipe = list[ZombRand(#list)+1];
            if not alreadyAdded[recipe] then
                item:getTeachedRecipes():add(recipe);
                alreadyAdded[recipe] = true;
            end
        end
    else
        local roll = ZombRand(#list)+1
        local recipe = list[roll]
        local recipeName = Translator.getRecipeName(recipe)
        local itemName = getText(item:getDisplayName())
        item:getModData().teachedRecipe = recipe
        local text = itemName .. ": " .. recipeName
        item:setName(text)
    end
end
SpecialLootSpawns.OnCreateExplosivesSchematic = function(item)
    SpecialLootSpawns.CreateSchematic(item, SpecialLootSpawns.ExplosiveSchematics, 40);
end
SpecialLootSpawns.OnCreateMeleeWeaponSchematic = function(item)
    SpecialLootSpawns.CreateSchematic(item, SpecialLootSpawns.MeleeWeaponSchematics, 30);
end
SpecialLootSpawns.OnCreateBSToolsSchematic = function(item)
    SpecialLootSpawns.CreateSchematic(item, SpecialLootSpawns.BSToolsSchematics, 50);
end
SpecialLootSpawns.OnCreateArmorSchematic = function(item)
    SpecialLootSpawns.CreateSchematic(item, SpecialLootSpawns.ArmorSchematics, 30);
end
SpecialLootSpawns.OnCreateCookwareSchematic = function(item)
    SpecialLootSpawns.CreateSchematic(item, SpecialLootSpawns.CookwareSchematic, 40);
end
SpecialLootSpawns.OnCreatePhotoBook = function(item)
    if not item then return end
    SpecialLootSpawns.OnCreateSpecialBook(item, "Photo_Special")
end
SpecialLootSpawns.OnCreateChildsPictureBook = function(item)
    if not item then return end
    SpecialLootSpawns.OnCreateSpecialBook(item, "ChildsPicture_Special")
end