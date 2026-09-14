this.perk_legend_clarity <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendClarity);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	function onUpdate( _properties )
	{
		// local actor = this.getContainer().getActor();
		// if (!actor.getSkills().hasSkill("perk.berserk") && !actor.getSkills().hasEffect(::Legends.Effect.Dazed) && !actor.getSkills().hasEffect(::Legends.Effect.Drunk) && !actor.getSkills().hasEffect(::Legends.Effect.Taunted) && !actor.getSkills().hasEffect(::Legends.Effect.Hangover) && !actor.getSkills().hasEffect(::Legends.Effect.Staggered) && !actor.getSkills().hasEffect(::Legends.Effect.Horrified) && !actor.getSkills().hasSkill("injury.severe_concussion") && this.getContainer().getActor().getMoraleState() >= this.Const.MoraleState.Wavering)
		// {
		// _properties.ActionPoints += 1;
		// _properties.FatigueEffectMult *= 1.2;
		// }

		// if (actor.getSkills().hasEffect(::Legends.Effect.IronWill) || actor.getSkills().hasEffect(::Legends.Effect.RecoveryPotion) || actor.getSkills().hasEffect(::Legends.Effect.LionheartPotion) || actor.getSkills().hasEffect(::Legends.Effect.CatPotion) || actor.getSkills().hasEffect(::Legends.Effect.LegendHexeIchorPotion))
		// {
		// _properties.ActionPoints += 1;
		// _properties.FatigueEffectMult *= 1.2;
		// }

		local actor = this.getContainer().getActor();
		if (!actor.getSkills().hasEffect(::Legends.Effect.Dazed) && !actor.getSkills().hasEffect(::Legends.Effect.Drunk) && !actor.getSkills().hasEffect(::Legends.Effect.Taunted) && !actor.getSkills().hasEffect(::Legends.Effect.Hangover) && !actor.getSkills().hasEffect(::Legends.Effect.Staggered) && !actor.getSkills().hasEffect(::Legends.Effect.Horrified) && !actor.getSkills().hasSkill("injury.severe_concussion") && this.getContainer().getActor().getMoraleState() >= this.Const.MoraleState.Wavering)
		{
			_properties.DamageDirectAdd += 0.1
		}

		if (actor.getSkills().hasEffect(::Legends.Effect.IronWill) || actor.getSkills().hasEffect(::Legends.Effect.RecoveryPotion) || actor.getSkills().hasEffect(::Legends.Effect.LionheartPotion) || actor.getSkills().hasEffect(::Legends.Effect.CatPotion) || actor.getSkills().hasEffect(::Legends.Effect.LegendHexeIchorPotion))
		{
			_properties.DamageDirectAdd += 0.1
		}

	}

});

