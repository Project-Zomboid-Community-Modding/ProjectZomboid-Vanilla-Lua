ClutterTables = ClutterTables or {}

ClutterTables.ShelfItems = {
	-- Stationery
	"BluePen", 2,
	"Clipboard", 1,
	"Eraser", 4,
	"GreenPen", 0.5,
	"MarkerBlack", 1,
	"MarkerBlue", 0.5,
	"MarkerGreen", 0.5,
	"MarkerRed", 0.5,
	"Pen", 4,
	"Pencil", 8,
	"RedPen", 2,
	-- Literature (Generic)
	"Newspaper", 2,
	"Newspaper_Recent", 2,
	"Notebook", 4,
	"Notepad", 8,
	"SheetPaper2", 10,
	-- Special
	"BobPic", 0.001,
	"CaseyPic", 0.001,
	"ChrisPic", 0.001,
	"CortmanPic", 0.001,
	"HankPic", 0.001,
	"JamesPic", 0.001,
	"KatePic", 0.001,
	"MariannePic", 0.001,
}

ClutterTables.ShelfJunk = {
		rolls = 1,
		ignoreZombieDensity = true,
		items = ClutterTables.ShelfItems,
	}