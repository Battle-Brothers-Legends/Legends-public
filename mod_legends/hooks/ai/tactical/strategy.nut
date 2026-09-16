::mods_hookNewObject("ai/tactical/strategy", function(o)
{
	o.compileKnownOpponents = function ()
	{
		local instances = ::Tactical.Entities.getAllInstances();

		for( local f = 0; f != instances.len(); f = ++f )
		{
			if (::Tactical.State.isScenarioMode())
			{
				if (::Const.FactionAlliance[this.m.Faction].find(f) != null)
				{
					continue;
				}
			}
			else if (::World.FactionManager.isAllied(this.m.Faction, f))
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

		foreach( i, opponent in this.m.KnownOpponents )
		{
			if (opponent.Actor == null || opponent.Actor.isNull() || !opponent.Actor.isAlive() || !opponent.Actor.isPlacedOnMap() || ::Tactical.State.isScenarioMode() && ::Const.FactionAlliance[this.m.Faction].find(opponent.Actor.getFaction()) != null || !::Tactical.State.isScenarioMode() && ::World.FactionManager.isAllied(this.m.Faction, opponent.Actor.getFaction()))
			{
				garbage.push(i);
				continue;
			}

			if (opponent.Actor.isHidden())
			{
				garbage.push(i);
			}
		}

		garbage.reverse();

		foreach( i in garbage )
		{
			this.m.KnownOpponents.remove(i);
		}
	}
});
