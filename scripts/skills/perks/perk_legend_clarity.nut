this.perk_legend_clarity <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendClarity);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		// local actor = this.getContainer().getActor();
		// if (!actor.getSkills().hasSkill("perk.berserk") && !actor.getSkills().hasSkill("effects.dazed") && !actor.getSkills().hasSkill("effects.drunk") && !actor.getSkills().hasSkill("effects.taunted") && !actor.getSkills().hasSkill("effects.hangover") && !actor.getSkills().hasSkill("effects.staggered") && !actor.getSkills().hasSkill("effects.horrified") && !actor.getSkills().hasSkill("injury.severe_concussion") && this.getContainer().getActor().getMoraleState() >= this.Const.MoraleState.Wavering)
		// {
		// _properties.ActionPoints += 1;
		// _properties.FatigueEffectMult *= 1.2;
		// }

		// if (actor.getSkills().hasSkill("effects.iron_will") || actor.getSkills().hasSkill("effects.recovery_potion") || actor.getSkills().hasSkill("effects.lionheart_potion") || actor.getSkills().hasSkill("effects.cat_potion") || actor.getSkills().hasSkill("effects.legend_hexe_ichor_potion"))
		// {
		// _properties.ActionPoints += 1;
		// _properties.FatigueEffectMult *= 1.2;
		// }

		local actor = this.getContainer().getActor();
		if (!actor.getSkills().hasSkill("effects.dazed") && !actor.getSkills().hasSkill("effects.drunk") && !actor.getSkills().hasSkill("effects.taunted") && !actor.getSkills().hasSkill("effects.hangover") && !actor.getSkills().hasSkill("effects.staggered") && !actor.getSkills().hasSkill("effects.horrified") && !actor.getSkills().hasSkill("injury.severe_concussion") && this.getContainer().getActor().getMoraleState() >= this.Const.MoraleState.Wavering)
		{
			_properties.DamageDirectAdd += 0.1
		}

		if (actor.getSkills().hasSkill("effects.iron_will") || actor.getSkills().hasSkill("effects.recovery_potion") || actor.getSkills().hasSkill("effects.lionheart_potion") || actor.getSkills().hasSkill("effects.cat_potion") || actor.getSkills().hasSkill("effects.legend_hexe_ichor_potion"))
		{
			_properties.DamageDirectAdd += 0.1
		}

	}

});

