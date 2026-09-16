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
		actor.setHitpoints(::Math.min(actor.getHitpoints() + 200, actor.getHitpointsMax()));
		local skills = _effect.getContainer().getAllSkillsOfType(::Const.SkillType.Injury);

		foreach( s in skills )
		{
			if(s.isType(::Const.SkillType.PermanentInjury)) continue;	// Prevents the Legends-Nacho-Mask from healing permanent Injuries. Nachos never receive permanent injuries anyways
			s.removeSelf();
		}
	}

	o.onUse = function ( _user, _targetTile )
	{
		_targetTile = _user.getTile();

		if (_targetTile.IsVisibleForPlayer)
		{
			if (::Const.Tactical.GruesomeFeastParticles.len() != 0)
			{
				for( local i = 0; i < ::Const.Tactical.GruesomeFeastParticles.len(); i = ++i )
				{
					::Tactical.spawnParticleEffect(false, ::Const.Tactical.GruesomeFeastParticles[i].Brushes, _targetTile, ::Const.Tactical.GruesomeFeastParticles[i].Delay, ::Const.Tactical.GruesomeFeastParticles[i].Quantity, ::Const.Tactical.GruesomeFeastParticles[i].LifeTimeQuantity, ::Const.Tactical.GruesomeFeastParticles[i].SpawnRate, ::Const.Tactical.GruesomeFeastParticles[i].Stages);
				}
			}

			if (_user.isDiscovered() && (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer))
			{
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " feasts on a corpse");
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
