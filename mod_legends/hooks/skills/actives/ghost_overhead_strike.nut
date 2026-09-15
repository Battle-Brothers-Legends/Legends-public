::mods_hookExactClass("skills/actives/ghost_overhead_strike", function(o)
{
	o.onUse = function ( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectBash);
		local target = _targetTile.getEntity();
		local success = this.attackEntity(_user, target);

		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}

		if (success && _targetTile.IsOccupiedByActor && ::Math.rand(1, 100) <= this.m.StunChance && !target.getCurrentProperties().IsImmuneToStun && !target.getSkills().hasEffect(::Legends.Effect.Stunned))
		{
			::Legends.Effects.grant(target, ::Legends.Effect.Stunned);

			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " has stunned " + ::Const.UI.getColorizedEntityName(target) + " for one turn");
			}
		}

		return success;
	}
});
