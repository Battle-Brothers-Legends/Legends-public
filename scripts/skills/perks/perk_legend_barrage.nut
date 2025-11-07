this.perk_legend_barrage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendBarrage);
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == null)
			return;

		if (::Legends.S.skillEntityAliveCheck(_targetEntity))
			return false;

		if (_targetEntity.isNonCombatant())
			return false;

		local headshot = _bodyPart == this.Const.BodyPart.Head;
		local user = this.getContainer().getActor();

		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.SlingStone))
		{
			if (headshot)
				this.grantEffect(::Legends.Effect.Debilitated, "debilitated", _targetEntity, user)
			else
				this.grantEffect(::Legends.Effect.LegendBaffled, "baffled", _targetEntity, user)

		}

		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.LegendSlingHeavyStone) && headshot && !_targetEntity.getCurrentProperties().IsImmuneToStun)
		{
			this.grantEffect(::Legends.Effect.Stunned, "stunned", _targetEntity, user)
		}

		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.FireHandgonne) && headshot)
		{
			this.grantEffect(::Legends.Effect.Shellshocked, "shellshocked", _targetEntity, user)
		}

	}

	function grantEffect(_effect, _string, _targetEntity, _user)
	{
		local targetTile = _targetEntity.getTile();
		::Legends.Effects.grant(_targetEntity, _effect);
		if (!_user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " struck a hit that leaves " + this.Const.UI.getColorizedEntityName(_targetEntity) + " " + _string);
	}
});
