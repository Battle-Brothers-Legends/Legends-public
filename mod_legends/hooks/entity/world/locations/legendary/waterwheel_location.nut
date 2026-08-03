::mods_hookExactClass("entity/world/locations/legendary/waterwheel_location", function(o)
{
	o.onSpawned = function ()
	{
		this.m.Name = "Watermill";
		this.location.onSpawned();

		this.Const.World.Common.addTroop(this, {
			Type = this.Const.World.Spawn.Troops.ZombieBoss
		}, false);

		for( local i = 0; i < 2; i = ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.ZombieKnightBodyguard
			}, false, 100);
		}

		local count = 9;
		if(::Legends.isLegendaryDifficulty())
			count += 3;
		for( local i = 0; i < 9; i = ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.ZombieBetrayer
			}, false, 100);
		}
	}

	o.onDropLootForPlayer = function( _lootTable ){
		this.location.onDropLootForPlayer(_lootTable);
		local helmet = ::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Named.ghost_knight_helmet],
		]);
		local ornament = this.new("scripts/items/legend_helmets/vanity/legend_helmet_rotten_faction_helmet");
		ornament.setVariant(8);
		ornament.updateVariant();
		helmet.setUpgrade(ornament);
		_lootTable.push(helmet);
	}
});
