::mods_hookExactClass("skills/actives/warcry", function(o)
{
	o.m.IsUpgraded <- false;

	o.onDelayedEffect = function ( _tag )
	{
		local mytile = _tag.User.getTile();
		local actors = ::Tactical.Entities.getAllInstances();
		local skill = ::Legends.Actives.get(_tag.User, ::Legends.Active.Warcry);

		foreach( i in actors )
		{
			foreach( a in i )
			{
				if (a.getID() == _tag.User.getID())
				{
					continue;
				}

				if (a.getFaction() == _tag.User.getFaction())
				{
					local difficulty = 10 - ::Math.pow(a.getTile().getDistanceTo(mytile), ::Const.Morale.EnemyKilledDistancePow);

					if (a.getMoraleState() == ::Const.MoraleState.Fleeing)
					{
						a.checkMorale(::Const.MoraleState.Wavering - ::Const.MoraleState.Fleeing, difficulty);
					}
					else
					{
						a.checkMorale(1, difficulty);
					}

					a.setFatigue(a.getFatigue() - 20);
					local rage = ::Legends.Effects.get(a, ::Legends.Effect.BerserkerRage);
					if (rage != null) {
						rage.addRage(5);
					}
					if (!skill.m.IsUpgraded)
						continue;

					local allySkill = ::Legends.Actives.get(a, ::Legends.Active.Warcry);
					if (allySkill != null && !allySkill.m.IsUpgraded)
						allySkill.useForFree(a.getTile());
				}
				else if (!a.isAlliedWith(_tag.User))
				{
					local difficulty = 5 + ::Math.pow(a.getTile().getDistanceTo(mytile), ::Const.Morale.AllyKilledDistancePow);
					a.checkMorale(-1, difficulty, ::Const.MoraleCheckType.MentalAttack);
				}
			}
		}
	}
});
