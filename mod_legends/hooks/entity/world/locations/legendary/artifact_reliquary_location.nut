::mods_hookExactClass("entity/world/locations/legendary/artifact_reliquary_location", function (o) {
	o.onDropLootForPlayer = function ( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropTreasure(2, [
			"loot/marble_bust_item"
		], _lootTable);
		_lootTable.push(::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Legendary.grand_diviner_headdress]
		]));
		_lootTable.push(::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Legendary.grand_diviner_robes]
		]));
	}

});
