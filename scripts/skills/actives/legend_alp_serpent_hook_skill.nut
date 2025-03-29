this.legend_alp_serpent_hook_skill <- this.inherit("scripts/skills/actives/serpent_hook_skill", {
	m = {},
	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local pullToTile;

		if (this.m.DestinationTile != null)
		{
			pullToTile = this.m.DestinationTile;
			this.m.DestinationTile = null;
		}
		else
		{
			pullToTile = this.getPulledToTile(_user.getTile(), _targetTile);
		}

		if (pullToTile == null)
		{
			return false;
		}

		if (target.getCurrentProperties().IsImmuneToKnockBackAndGrab)
		{
			return false;
		}

		if (!_user.isHiddenToPlayer() && pullToTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " drags in " + this.Const.UI.getColorizedEntityName(_targetTile.getEntity()));
		}

		if (!_user.isHiddenToPlayer() || !target.isHiddenToPlayer())
		{
			local scaleBackup = target.getSprite("status_rooted").Scale;
			_user.fadeOut(50);
			local rooted_front = target.getSprite("status_rooted");
			rooted_front.Scale = 1.0;
			rooted_front.setBrush("alp_snake_ensnare_front");
			rooted_front.Visible = true;
			rooted_front.Alpha = 0;
			rooted_front.fadeIn(50);
			local rooted_back = target.getSprite("status_rooted_back");
			rooted_back.Scale = 1.0;
			rooted_back.setBrush("alp_snake_ensnare_back");
			rooted_back.Visible = true;
			rooted_back.Alpha = 0;
			rooted_back.fadeIn(50);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 900, this.onDone, {
				User = _user,
				Target = target,
				ScaleBackup = scaleBackup,
				Skill = this
			});
		}

		target.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
		local damage = this.Math.max(0, this.Math.abs(pullToTile.Level - _targetTile.Level) - 1) * this.Const.Combat.FallingDamage;

		if (damage == 0)
		{
			this.Tactical.getNavigator().teleport(_targetTile.getEntity(), pullToTile, null, null, true);
		}
		else
		{
			local tag = {
				Attacker = _user,
				Skill = this,
				HitInfo = clone this.Const.Tactical.HitInfo
			};
			tag.HitInfo.DamageRegular = damage;
			tag.HitInfo.DamageFatigue = this.Const.Combat.FatigueReceivedPerHit;
			tag.HitInfo.DamageDirect = 1.0;
			tag.HitInfo.BodyPart = this.Const.BodyPart.Body;
			this.Tactical.getNavigator().teleport(_targetTile.getEntity(), pullToTile, this.onPulledDown, tag, true);
		}

		::Legends.Effects.grant(target, ::Legends.Effect.Staggered);

		if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has staggered " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
		}

		return true;
	}

});

