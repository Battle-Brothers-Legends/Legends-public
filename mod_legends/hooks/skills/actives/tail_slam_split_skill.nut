::mods_hookExactClass("skills/actives/tail_slam_split_skill", function(o)
{
	o.applyEffectToTarget = function ( _user, _target, _targetTile )
	{
		local applyEffect = this.Math.rand(1, 3);

		if (applyEffect == 1)
		{
			if (_target.isNonCombatant() || _target.getCurrentProperties().IsImmuneToStun || _target.getCurrentProperties().IsImmuneToDaze)
			{
				return;
			}

			::Legends.Effects.grant(_target, ::Legends.Effect.Dazed);

			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has dazed " + this.Const.UI.getColorizedEntityName(_target) + " for two turns");
			}
		}
		else if (applyEffect == 2)
		{
			return;
		}
		else
		{
			if (_target.isNonCombatant() || _target.getCurrentProperties().IsImmuneToStun || _target.getCurrentProperties().IsStunned)
			{
				return;
			}

			::Legends.Effects.grant(_target, ::Legends.Effect.Stunned);

			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has stunned " + this.Const.UI.getColorizedEntityName(_target) + " for one turn");
			}
		}
	}
});
