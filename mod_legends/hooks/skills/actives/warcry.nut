::mods_hookExactClass("skills/actives/warcry", function(o)
{
	o.m.IsUpgraded <- false;

	o.onDelayedEffect = function ( _tag )
	{
		local mytile = _tag.User.getTile();
		local actors = this.Tactical.Entities.getAllInstances();
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
					local difficulty = 10 - this.Math.pow(a.getTile().getDistanceTo(mytile), this.Const.Morale.EnemyKilledDistancePow);

					if (a.getMoraleState() == this.Const.MoraleState.Fleeing)
					{
						a.checkMorale(this.Const.MoraleState.Wavering - this.Const.MoraleState.Fleeing, difficulty);
					}
					else
					{
						a.checkMorale(1, difficulty);
					}

					a.setFatigue(a.getFatigue() - 20);
					if (!skill.m.IsUpgraded)
						continue;

					local allySkill = ::Legends.Actives.get(a, ::Legends.Active.Warcry);
					if (allySkill != null && !allySkill.m.IsUpgraded)
						allySkill.useForFree(a.getTile());
				}
				else if (!a.isAlliedWith(_tag.User))
				{
					local difficulty = 5 + this.Math.pow(a.getTile().getDistanceTo(mytile), this.Const.Morale.AllyKilledDistancePow);
					a.checkMorale(-1, difficulty, this.Const.MoraleCheckType.MentalAttack);
				}
			}
		}
	}
});
