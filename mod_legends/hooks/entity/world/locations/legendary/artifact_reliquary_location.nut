::mods_hookExactClass("entity/world/locations/legendary/artifact_reliquary_location", function (o) {
	o.onDropLootForPlayer = function ( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropTreasure(2, [
			"loot/marble_bust_item"
		], _lootTable);
		_lootTable.push(::Legends.Items.pickHelmet([
			[1, ::Legends.Helmet.Legendary.grand_diviner_headdress]
		]));
		_lootTable.push(::Legends.Items.pickArmor([
			[1, ::Legends.Armor.Legendary.grand_diviner_robes]
		]));
	}

});
