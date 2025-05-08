::mods_hookExactClass("skills/perks/perk_coup_de_grace", function(o) {
	o.m.HighBonus <- [
		::Legends.Effect.Debilitated,
		::Legends.Effect.LegendTackled
	];
	o.m.LowBonus <- [
		::Legends.Effect.Dazed,
		::Legends.Effect.Distracted,
		::Legends.Effect.LegendBaffled,
		::Legends.Effect.LegendParried,
		::Legends.Effect.LegendGrappled,
		::Legends.Effect.Net,
		::Legends.Effect.Rooted,
		::Legends.Effect.Shellshocked,
		::Legends.Effect.Sleeping,
		::Legends.Effect.Staggered,
		::Legends.Effect.Stunned,
		::Legends.Effect.Web,
		::Legends.Effect.Withered
	];

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
			return;

		local bonus = this.calculateBonus(_targetEntity);
		_properties.DamageAgainstMult[this.Const.BodyPart.Head] += 0.01 * bonus;
		_properties.HitChance[this.Const.BodyPart.Head] += bonus;
	}

	o.onBeforeTargetHit = function ( _skill, _targetEntity, _hitInfo )
	{
		if (_targetEntity != null && this.calculateBonus() != 0)
		{
			this.spawnIcon("perk_16", this.getContainer().getActor().getTile());
		}
	}

	o.calculateBonus <- function ( _targetEntity )
	{
		local bonus = 0;

		if (_targetEntity.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
			bonus += 10;

		foreach (effect in this.m.HighBonus)
		{
			if (_targetEntity.getSkills().hasEffect(effect))
			{
				bonus += 10;
			}
		}
		foreach (effect in this.m.LowBonus)
		{
			if (_targetEntity.getSkills().hasEffect(effect))
			{
				bonus += 5;
			}
		}

		return bonus;
	}
});
