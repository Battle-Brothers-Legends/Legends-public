::mods_hookExactClass("skills/actives/tail_slam_big_skill", function(o)
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

			_target.getSkills().add(this.new("scripts/skills/effects/dazed_effect"));

			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has dazed " + this.Const.UI.getColorizedEntityName(_target) + " for two turns");
			}
		}
		else if (applyEffect == 2)
		{
			if (_target.isNonCombatant() || _target.getCurrentProperties().IsImmuneToKnockBackAndGrab || _target.getCurrentProperties().IsRooted)
			{
				return;
			}

			local knockToTile = this.findTileToKnockBackTo(_user.getTile(), _targetTile);

			if (knockToTile == null)
			{
				return;
			}

			this.m.TilesUsed.push(knockToTile.ID);

			if (!_user.isHiddenToPlayer() && (_targetTile.IsVisibleForPlayer || knockToTile.IsVisibleForPlayer))
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has knocked back " + this.Const.UI.getColorizedEntityName(_target));
			}

			if (!_target.getSkills().hasSkill("effects.legend_break_stance"))
				_target.getSkills().add(this.new("scripts/skills/effects/legend_break_stance_effect"));

			_target.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
			local damage = this.Math.max(0, this.Math.abs(knockToTile.Level - _targetTile.Level) - 1) * this.Const.Combat.FallingDamage;

			if (damage == 0)
			{
				this.Tactical.getNavigator().teleport(_target, knockToTile, null, null, true);
			}
			else
			{
				local p = this.getContainer().getActor().getCurrentProperties();
				local tag = {
					Attacker = _user,
					Skill = this,
					HitInfo = clone this.Const.Tactical.HitInfo
				};
				tag.HitInfo.DamageRegular = damage;
				tag.HitInfo.DamageDirect = 1.0;
				tag.HitInfo.BodyPart = this.Const.BodyPart.Body;
				tag.HitInfo.BodyDamageMult = 1.0;
				tag.HitInfo.FatalityChanceMult = 1.0;
				this.Tactical.getNavigator().teleport(_target, knockToTile, this.onKnockedDown, tag, true);
			}
		}
		else
		{
			if (_target.isNonCombatant() || _target.getCurrentProperties().IsImmuneToStun || _target.getCurrentProperties().IsStunned)
			{
				return;
			}

			_target.getSkills().add(this.new("scripts/skills/effects/stunned_effect"));

			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has stunned " + this.Const.UI.getColorizedEntityName(_target) + " for one turn");
			}
		}
	}
});
