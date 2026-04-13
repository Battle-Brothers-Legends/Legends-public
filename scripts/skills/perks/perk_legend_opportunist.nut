this.perk_legend_opportunist <- this.inherit("scripts/skills/skill", {
	m = {},

	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendOpportunist);
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		// must be from a skill
		if (_skill == null)
			return;

		if (::Legends.S.skillEntityAliveCheck(_targetEntity))
			return;

		if (_targetEntity.isAlliedWith(this.getContainer().getActor()))
			return;

		// don't have resistance
		if (_targetEntity.getCurrentProperties().IsImmuneToDaze)
			return;

		local hasEffectOrInjury = false;
		foreach (id in [
			::Legends.Effect.LegendGrazedEffect,
			::Legends.Effect.Bleeding,
			::Legends.Effect.GoblinPoison,
			::Legends.Effect.SpiderPoison,
			::Legends.Effect.LegendRedbackSpiderPoison,
			::Legends.Effect.LegendZombiePoison,
			::Legends.Effect.LegendRatPoison,
		]) {
			if (!_targetEntity.getSkills().hasEffect(id))
				continue;
			hasEffectOrInjury = true;
			break;
		}
		foreach (id in [
			"injury.cut_artery",
			"injury.cut_throat",
			"injury.grazed_neck",
		])
		{
			if (!_targetEntity.getSkills().hasSkill(id))
				continue;
			hasEffectOrInjury = true;
			break;
		}
		if (hasEffectOrInjury) {
			::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Dazed);
		}
	}

	function onUpdate(_properties)
	{
		//local actor = this.getContainer().getActor();
		if (this.getContainer().hasEffect(::Legends.Effect.Smoke))
		{
			_properties.RangedSkillMult *= 1.5; //Offsets the -50% from smoke_effect.nut
			_properties.MeleeSkillMult *= 1.10;
	//If you are within a smoke cloud gain +2 maximum action points.
			//_properties.ActionPoints = 10; //default = 9. 9+2 = 11.
		}

		//if (!this.getContainer().getActor().isPlacedOnMap())
		//{
		//	// this.m.IsHidden = true;
		//	return;
		//}
	}

	// function onUpdate(_properties)
	// {
	// 	local effect = new("scripts/skills/effects/smoke_effect");
	// 	if(this.getContainer().getActor().hasSkill(effect))
	// 	{
	// 		_properties.RangedSkillMult *= 1.5; //Offsets the -50% from smoke_effect.nut
	// 		_properties.MeleeSkillMult *= 1.25;
	// 	}
	// }
});

