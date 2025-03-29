::mods_hookNewObject("ai/tactical/strategy", function(o)
{
	o.compileKnownOpponents = function ()
	{
		local instances = this.Tactical.Entities.getAllInstances();

		for( local f = 0; f != instances.len(); f = ++f )
		{
			if (this.Tactical.State.isScenarioMode())
			{
				if (this.Const.FactionAlliance[this.m.Faction].find(f) != null)
				{
					continue;
				}
			}
			else if (this.World.FactionManager.isAllied(this.m.Faction, f))
			{
				continue;
			}

			for( local p = 0; p != instances[f].len(); p = ++p )
			{
				if (instances[f][p].isHidden())
				{
					continue;
				}

				if (!instances[f][p].isAttackable())
				{
					continue;
				}

				if (instances[f][p].getTile().IsHidingEntity && !instances[f][p].isVisibleToEntity())
				{
					continue;
				}

				this.onOpponentSighted(instances[f][p]);

			}
		}
	}

	o.cleanUpKnownOpponents = function()
	{
		local garbage = [];

		foreach( i, o in this.m.KnownOpponents )
		{
			if (o.Actor == null || o.Actor.isNull() || !o.Actor.isAlive() || !o.Actor.isPlacedOnMap() || this.Tactical.State.isScenarioMode() && this.Const.FactionAlliance[this.m.Faction].find(o.Actor.getFaction()) != null || !this.Tactical.State.isScenarioMode() && this.World.FactionManager.isAllied(this.m.Faction, o.Actor.getFaction()))
			{
				garbage.push(i);
				continue
			}

			if (o.Actor.isHidden())
			{
				garbage.push(i)
			}
		}

		garbage.reverse();

		foreach( i in garbage )
		{
			this.m.KnownOpponents.remove(i);
		}
	}
});
