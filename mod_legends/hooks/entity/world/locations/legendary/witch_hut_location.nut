::mods_hookExactClass("entity/world/locations/legendary/witch_hut_location", function(o) 
{
	o.onSpawned = function ()
	{
		this.m.Name = "Witch Hut";
		this.location.onSpawned();

		for( local i = 0; i < 3; i = ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.Hexe
			}, false);
		}

		for( local i = 0; i < 1; i = ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.LegendHexeLeader
			}, false);
		}

		for( local i = 0; i < 1; i = ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.LegendWhiteDirewolfBodyguard
			}, false);
		}

		for( local i = 0; i < 2; i = ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.LegendRedbackSpiderBodyguard
			}, false);
		}

		for( local i = 0; i < 4; i = ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.DirewolfHIGH
			}, false);
		}

		for( local i = 0; i < 1; i = ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.LegendRockUnhold
			}, false);
		}

		for( local i = 0; i < 1; i = ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.Unhold
			}, false);
		}

		for( local i = 0; i < 3; i = ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.LegendSkinGhoulLOW
			}, false);
		}

		for( local i = 0; i < 1; i = ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.LegendGreenwoodSchrat
			}, false);
		}
	}

	o.onDropLootForPlayer <- function ( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropTreasure(this.Math.rand(1, 2), [
			"misc/legend_masterwork_metal",
			"misc/legend_masterwork_fabric"
		], _lootTable);
	}
});