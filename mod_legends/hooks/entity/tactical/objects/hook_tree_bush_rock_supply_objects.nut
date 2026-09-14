local rocks = [
	"autumn_boulder1",
	"autumn_boulder2",
	"barbarian_camp_altar",
	"boulder",
	"boulder_bloody",
	"boulder_forest",
	"desert_boulder1",
	"desert_boulder2",
	"desert_boulder3",
	"graveyard_ruins",
	"graveyard_ruins_big",
	"graveyard_wall",
	"human_camp_wall",
	"orc_camp_idol",
	"snow_boulder1",
	"southern_ruins",
	"southern_ruins_big",
	"southern_ruins_wall",
	"steppe_boulder1",
	"steppe_boulder2",
	"steppe_boulder3",
	"tundra_boulder1",
	"tundra_boulder2"
];

local trees = [
	"autumn_tree1",
	"autumn_tree2",
	"desert_cactus1",
	"desert_cactus2",
	"desert_camp_furniture",
	"orc_camp_wall",
	"swamp_tree1",
	"swamp_tree2",
	"swamp_tree_trunk",
	"tree_cypress",
	"tree_dead_steppe",
	"tree_desert_large",
	"tree_forest",
	"tree_lush",
	"tree_lush_small",
	"tree_lush_smaller",
	"tree_needle1",
	"tree_needle2",
	"tree_needle1_snow",
	"tree_needle2_snow",
	"tree_needle2_smaller",
	"tree_olive",
	"tree_olive_dry",
	"tree_swamp",
	"tree_trunk",
	"tree_trunk_forest",
	"tree_trunk_forest_leaves"
];

local bushes = [
	"autumn_brush",
	"brush_forest",
	"brush_green",
	"desert_plant",
	"steppe_brush",
	"tundra_brush"
];

local supplies = [
	"barbarian_camp_nithing_pole",
	"desert_camp_supplies",
	"goblin_camp_supplies",
	"human_camp_supplies",
	"orc_camp_supplies"
];

foreach (rock in rocks)
{
	::mods_hookExactClass("entity/tactical/objects/" + rock, function(o)
	{
		o.m.isRock <- true;
	});
};

foreach (tree in trees)
{
	::mods_hookExactClass("entity/tactical/objects/" + tree, function(o)
	{
		o.m.isTree <- true;
	});
};

foreach (bush in bushes)
{
	::mods_hookExactClass("entity/tactical/objects/" + bush, function(o)
	{
		o.m.isBush <- true;
	});
};

foreach (supply in supplies)
{
	::mods_hookExactClass("entity/tactical/objects/" + supply, function(o)
	{
		o.m.isSupplies <- true;
	});
};
