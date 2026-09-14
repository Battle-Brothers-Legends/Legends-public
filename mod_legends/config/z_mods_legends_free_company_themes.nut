::Const.FreeCompanyDefaultLootTable <- ["trade/amber_shards_item", "trade/furs_item", "trade/legend_tin_ingots_item", "trade/spices_item", "trade/silk_item", "trade/peat_bricks_item", "trade/cloth_rolls_item"];

//Anything custom is technically optional, although you'll mostly want to change the UnitOutfits certainly.
//Spawnlist highly doubt you'd want to change unless you're creating your own spawnlist
//You can get away with having a very simple table such as the following
/*
{
	ID = "MyList",
	UnitOutfits = [
		{
			ID = this.Const.EntityType.FreeCompanyLeader,
			Outfits = ["my_leader_outfit_00", "my_leader_outfit_01"]
		}
	]
}
*/
//Any entity not in the unitoutfit selection will simply have default, so if you only add in an entry for freecompanyleader's you'll only have a custom outfit on them + full default everyone else

::Const.FreeCompanyCoordinationList <- [
	{
		ID = "Default",															//ID doesn't matter really but it's good to have
		Names = this.Const.Strings.FreeCompanyNames,							   //Custom name array
		Description = "An ordinary mercenary company, out for their own crowns.",  //Custom description
		FootprintsType = "Mercenaries",											//custom footprints type (think raiders having beast tracks)
		Spawn = "FreeCompany",													 //custom spawnlist
		LootTable = clone this.Const.FreeCompanyDefaultLootTable				   //Custom loot tables
		UnitOutfits = [															//Unit outfits each need a type and an array of outfits
			// {
			//	 Type = this.Const.EntityType.FreeCompanyLeader,
			//	 Outfits = [ [1, ::Legends.Outfit.mercenary_archer_outfit_00] ]
			// }
		]														   //Leave this for default outfits
	},
	// {
	// 	ID = "BanditRoamers",
	// 	Names = ["Bandits1", "Bandits2", "Bandits3", "Bandits4"],
	// 	Description = "A group of ex-bandits looking for extra coin.",
	// 	FootprintsType = "Brigands",
	// 	Spawn = "BanditRoamers"
	// },
	// {
	// 	ID = "green",
	// 	Names = [
	// 		"Green Power Rangers", "Etc"
	// 	], //Alternatively can store this in a const in strings and reference this.Const.Strings.GreenCompanyNames
	// 	UnitOutfits = [
	// 		{
	// 			Type = this.Const.EntityType.FreeCompanyLeader,
	// 			Outfits = [ "green_leader_outfit_00" ]
	// 			// Outfits = this.Const.Outfits.GreenFreeCompanyLeader //alternatively can store the outfits elsewhere to keep this clean
	// 		}
	// 	]
	// }
];

::Const.FreeCompanyOneTimeList <-
[
	{
		ID = "Gilded",
		Names = [
			"Gilded Wraiths"
		], //Alternatively can store this in a const in strings
		Spawn = "GildedCompany",
		UnitOutfits = [
			{
				Type = this.Const.EntityType.FreeCompanyLeader,
				Outfits = [
					::Legends.Outfit.mercenary_leader_outfit_gilded_00
				]
				// Outfits = this.Const.Outfits.GildedFreeCompanyLeader //alternatively can store the outfits elsewhere to keep this clean
			}
		]
	}
]
