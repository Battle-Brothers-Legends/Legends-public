::mods_hookExactClass("skills/actives/gruesome_feast", function(o)
{
	o.isUsable <- function ()
	{
		return this.skill.isUsable() && !this.getContainer().getActor().getCurrentProperties().IsRooted;
	}

	o.onFeasted = function ( _effect )
	{
		local actor = _effect.getContainer().getActor();
		_effect.addFeastStack();
		_effect.getContainer().update();
		actor.setHitpoints(this.Math.min(actor.getHitpoints() + 200, actor.getHitpointsMax()));
		local skills = _effect.getContainer().getAllSkillsOfType(this.Const.SkillType.Injury);

		foreach( s in skills )
		{
			if(s.isType(this.Const.SkillType.PermanentInjury)) continue;	// Prevents the Legends-Nacho-Mask from healing permanent Injuries. Nachos never receive permanent injuries anyways
			s.removeSelf();
		}
	}

	o.onUse = function ( _user, _targetTile )
	{
		_targetTile = _user.getTile();

		if (_targetTile.IsVisibleForPlayer)
		{
			if (this.Const.Tactical.GruesomeFeastParticles.len() != 0)
			{
				for( local i = 0; i < this.Const.Tactical.GruesomeFeastParticles.len(); i = ++i )
				{
					this.Tactical.spawnParticleEffect(false, this.Const.Tactical.GruesomeFeastParticles[i].Brushes, _targetTile, this.Const.Tactical.GruesomeFeastParticles[i].Delay, this.Const.Tactical.GruesomeFeastParticles[i].Quantity, this.Const.Tactical.GruesomeFeastParticles[i].LifeTimeQuantity, this.Const.Tactical.GruesomeFeastParticles[i].SpawnRate, this.Const.Tactical.GruesomeFeastParticles[i].Stages);
				}
			}

			if (_user.isDiscovered() && (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer))
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " feasts on a corpse");
			}
		}

		if (!_user.isHiddenToPlayer())
		{
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, this.onRemoveCorpse, _targetTile);
		}
		else
		{
			this.onRemoveCorpse(_targetTile);
		}

		this.spawnBloodbath(_targetTile);

		local effect = ::Legends.Effects.grant(_user, ::Legends.Effect.GruesomeFeast);

		if (!_user.isHiddenToPlayer())
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, this.onFeasted, effect);
		else
			this.onFeasted(effect);

		return true;
	}
});
