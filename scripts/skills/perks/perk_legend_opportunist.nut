this.perk_legend_opportunist <- this.inherit("scripts/skills/skill", {
	m = {},

	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendOpportunist);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		// must from a skill
		if (_skill != null)

		// the target must still alive
		if (!_targetEntity.isAlive() || _targetEntity.isDying() || _targetEntity.isAlliedWith(this.getContainer().getActor())) return;

		// don't have resistance
		if (_targetEntity.getCurrentProperties().IsImmuneToDaze) return;

		foreach (id in [
			// status effects
			"effects.legend_grazed_effect",
			"effects.bleeding",
			"effects.goblin_poison",
			"effects.spider_poison",
			"effects.legend_redback_spider_poison",
			"effects.legend_zombie_poison",
			"effects.legend_rat_poison",

			// injuries
			"injury.cut_artery",
			"injury.cut_throat",
			"injury.grazed_neck",
		])
		{
			if (!_targetEntity.getSkills().hasSkill(id)) continue;

			_targetEntity.getSkills().add(this.new("scripts/skills/effects/dazed_effect"));
			break;
		}
	}

	function onUpdate(_properties)
	{
		//local actor = this.getContainer().getActor();
		if (this.getContainer().hasSkill("effects.smoke"))
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

