::mods_hookExactClass("entity/world/locations/legendary/sunken_library_location", function(o) 
{
	o.onDropLootForPlayer <- function ( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropArmorParts(this.Math.rand(0, 60), _lootTable);
		this.dropTreasure(this.Math.rand(3, 4), [
			"loot/white_pearls_item",
			"loot/jeweled_crown_item",
			"loot/gemstones_item",
			"loot/golden_chalice_item",
			"loot/ancient_gold_coins_item",
			"misc/legend_masterwork_metal",
			"misc/legend_masterwork_fabric",
			"misc/legend_masterwork_tools"
		], _lootTable);
		local hasHistorian = false;
		foreach (bro in this.World.getPlayerRoster().getAll())
		{
			if (bro.getSkills().hasSkill("perk.legend_scholar"))
			{
				hasHistorian = true;
			}
		}
		local n = 1 + (hasHistorian ? 1 : 0);

		for( local i = 0; i < n; i = ++i )
		{
			for ( local v = 0; v < 2; ++v )
			{
				_lootTable.push(this.new("scripts/items/misc/legend_ancient_scroll_item"));
			}
		}
		// _lootTable.push(this.Const.World.Common.pickArmor([
		// 	[1, "legendary/legend_emperors_armor"]
		// ]))
	}
});