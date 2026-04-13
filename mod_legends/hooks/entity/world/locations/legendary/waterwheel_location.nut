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
});
