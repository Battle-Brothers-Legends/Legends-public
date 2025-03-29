::mods_hookExactClass("skills/actives/thresh", function(o)
{
	o.m.IsChain <- false;

	o.setItem <- function (_item)
	{
		if (this.m.IsChain)
		{
			this.m.Name = "Chain Thresh";
			this.m.Description = "Threshing all the targets around you, foe and friend alike, with a reckless round swing. Not hard to evade because it is not aimed at anything. Has a chance to daze targets hit for one turn. Be careful around your own men unless you want to relieve your payroll!";
			this.m.KilledString = "Threshed";
			this.m.ChanceDisembowel = 10;
			this.m.ChanceSmash = 33;
		}
		this.skill.setItem(_item);
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local ret = getTooltip();

		if (this.m.IsChain)
		{
			foreach (tooltip in ret)
			{
				if (tooltip.id == 8)
				{
					tooltip.text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.StunChance + "%[/color] chance to daze on a hit"
				}
			}
		}
		return ret;
	}

	o.onUse = function ( _user, _targetTile )
	{
		local ret = false;
		local ownTile = this.m.Container.getActor().getTile();
		local soundBackup = [];
		local skillToApply = this.m.IsChain ? "dazed_effect" : "stunned_effect";
		this.spawnAttackEffect(ownTile, this.Const.Tactical.AttackEffectThresh);

		for( local i = 0; i != 6; i = ++i )
		{
			if (!ownTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = ownTile.getNextTile(i);

				if (!tile.IsEmpty && tile.getEntity().isAttackable() && this.Math.abs(tile.Level - ownTile.Level) <= 1)
				{
					if (ret && soundBackup.len() == 0)
					{
						soundBackup = this.m.SoundOnHit;
						this.m.SoundOnHit = [];
					}

					local success = this.attackEntity(_user, tile.getEntity());
					ret = success || ret;

					if (_user.isAlive() && !_user.isDying())
					{
						if (this.m.IsChain && success && tile.IsOccupiedByActor && this.Math.rand(1, 100) <= this.m.StunChance && !tile.getEntity().getCurrentProperties().IsImmuneToBleeding && !tile.getEntity().getSkills().hasEffect(::Legends.Effect.Dazed))
						{
							::Legends.Effects.grant(tile.getEntity(), ::Legends.Effect.Dazed);

							if (!_user.isHiddenToPlayer() && tile.IsVisibleForPlayer)
							{
								this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has grazed " + this.Const.UI.getColorizedEntityName(tile.getEntity()));
							}
						}
						else if (success && tile.IsOccupiedByActor && this.Math.rand(1, 100) <= this.m.StunChance && !tile.getEntity().getCurrentProperties().IsImmuneToStun && !tile.getEntity().getSkills().hasEffect(::Legends.Effect.Stunned))
						{
							::Legends.Effects.grant(tile.getEntity(), ::Legends.Effect.Stunned);

							if (!_user.isHiddenToPlayer() && tile.IsVisibleForPlayer)
							{
								this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has stunned " + this.Const.UI.getColorizedEntityName(tile.getEntity()) + " for one turn");
							}
						}
					}
				}
			}
		}

		if (ret && this.m.SoundOnHit.len() == 0)
		{
			this.m.SoundOnHit = soundBackup;
		}

		return ret;
	}
});
