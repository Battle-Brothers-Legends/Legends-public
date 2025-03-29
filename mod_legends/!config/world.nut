::Const.World.TerrainType.SwampGreen <- 19;
::Const.World.TerrainType.SwampForest <- 20;
::Const.World.TerrainType.COUNT = 21;

::Const.World.AllTerrainTypes <- []; // Added by Legends
for (local i = 0; i < ::Const.World.TerrainType.COUNT; i++)
{
	::Const.World.AllTerrainTypes.push(i);
}

::Const.World.getAllTerrainTypesExcept <- function ( _types )
{
	local ret = clone ::Const.World.AllTerrainTypes;
	local garbage = clone _types;
	::MSU.Array.sortDescending(garbage);
	foreach( i in garbage )
		ret.remove(i);
	return ret;
}

::Const.World.TerrainLocation <- [
	"at an impassable location",
	"at sea",
	"on the plains",
	"in the swamps",
	"on the hills",
	"in the forests",
	"in the snowy forests",
	"in the leafy forests",
	"in the autumn forests",
	"in the mountains",
	"in an urban location",
	"in the farmlands",
	"in the snow",
	"in the badlands",
	"in the tundra",
	"in the steppes",
	"by the shore",
	"in the desert",
	"in the oasis",
	"in the green swamps",
	"in the forested swamps"
];

::Const.World.TerrainTacticalType.SwampGreen <- 25;
::Const.World.TerrainTacticalType.SwampForest <- 26;
::Const.World.TerrainTacticalType.COUNT = 27;

::Const.World.FootprintsType.Basilisks <- 26;
::Const.World.FootprintsType.COUNT = 27;

::Const.World.Buildings.Stables <- 0;
::Const.World.Buildings.Blackmarket <- 0;

::Const.World.settingsUpdate <- function ()
{
	this.Const.World.Settings.LandMassMult = 1.0 + (::Legends.Mod.ModSettings.getSetting("LandRatio").getValue() / 100.0);
	this.Const.World.Settings.WaterConnectivity = ::Legends.Mod.ModSettings.getSetting("Water").getValue();
	this.Const.World.Settings.Snowline = ::Legends.Mod.ModSettings.getSetting("Snowline").getValue() / 100.0;
};


::Const.World.SettlementsUpdate <- function (_val)
{
	local total = 0.0;
	foreach(s in ::Const.World.Settlements.Master)
	{
		total = total + s.Amount;
	}

	foreach(s in ::Const.World.Settlements.Master)
	{
		s.Percentage <- s.Amount / total;
		s.Amount = Math.ceil(_val * (s.Amount / total));
	}
};


::Const.World.Settlements.LegendsWorldMaster <- [
	{
		Ratio = 0.20,
		Types = this.Const.World.Settlements.Legends_villages_coast,
		Sizes = [
			{
				Ratio = 5,
				MinAmount = 1,
				Size = 1
			},
			{
				Ratio = 3,
				MinAmount = 1,
				Size = 2
			},
			{
				Ratio = 2,
				MinAmount = 1,
				Size = 3
			}
		]
	},
	{
		Ratio = 0.50,
		Types = Const.World.Settlements.Legends_villages,
		Sizes = [
			{
				Ratio = 5,
				MinAmount = 1,
				Size = 1
			},
			{
				Ratio = 3,
				MinAmount = 1,
				Size = 2,
			},
			{
				Ratio = 2,
				MinAmount = 2,
				Size = 3
			}
		]
	},
	{
		Ratio = 0.30,
		Types = Const.World.Settlements.Legends_fortifications,
		Sizes = [
			{
				Ratio = 5,
				MinAmount = 1,
				Size = 1
			},
			{
				Ratio = 3,
				MinAmount = 1,
				Size = 2
			},
			{
				Ratio = 2,
				MinAmount = 2,
				Size = 3
			}
		]
	},
	{
		Ratio = 0.0,
		Types = Const.World.Settlements.Legends_citystates,
		IgnoreSide = true,
		AdditionalSpace = 13,
		Sizes = [
			{
				Ratio = 10,
				MinAmount = 3,
				Size = 3
			}
		]
	}
];

::Const.World.LegendaryContract <-
{
	WhiteWolf = 0,
	RedSpider = 0,
	GreenSchrat = 0,
	DemonAlp = 0,
	BossHexe = 0,
	RockUnhold = 0,
	Stollwurm = 0,
	SkinGhoul = 0,
	BarbPrison = 0,
	BanditArmy = 0
}

::Const.World.ContractCost <-
{
	WhiteWolf = 200,
	RedSpider = 200,
	GreenSchrat = 200,
	DemonAlp = 200,
	BossHexe = 200,
	RockUnhold = 200,
	StollWurm = 200,
	SkinGhoul = 200,
	BarbPrison = 200,
	BanditArmy = 200
};
