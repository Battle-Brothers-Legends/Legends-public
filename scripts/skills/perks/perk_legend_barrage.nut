this.perk_legend_barrage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendBarrage);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
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
				this.grantEffect(::Legends.Effect.LegendBaffled, "baffled", _targetEntity, user)
			else
				this.grantEffect(::Legends.Effect.Debilitated, "debilitated")
		}

		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.LegendSlingHeavyStone) && headshot && !_targetEntity.getCurrentProperties().IsImmuneToStun)
		{
			this.grantEffect(::Legends.Effect.LegendBaffled, "stunned", _targetEntity, user)
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
		if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " struck a hit that leaves " + this.Const.UI.getColorizedEntityName(_targetEntity) + " " + _string);
	}
});
