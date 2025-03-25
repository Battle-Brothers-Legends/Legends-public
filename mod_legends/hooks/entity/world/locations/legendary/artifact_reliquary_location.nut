::mods_hookExactClass("entity/world/locations/legendary/artifact_reliquary_location", function (o) {
	o.onDropLootForPlayer = function ( _lootTable )
	{
		::logInfo("waaaaaaaaaaaaagh");
		// TODO does it even work??
		this.location.onDropLootForPlayer(_lootTable);
		this.dropTreasure(2, [
			"loot/marble_bust_item"
		], _lootTable);
//		_lootTable.push(this.new("scripts/items/helmets/golems/grand_diviner_headdress"));
		_lootTable.push(::Const.World.Common.pickArmor([
			[1, "grand_diviner_robes"]
		]));
	}

});
