this.perk_legend_back_to_basics <- this.inherit("scripts/skills/skill", {
	m = {
		BasicsStacks = 0
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendBackToBasics);
		this.m.Description = "Years of practice lead this character to fall back to %their% instincts and basic training under extreme stress.";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		if (this.m.BasicsStacks != 0)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "Gaining an additional [color=%positive%]" + this.m.BasicsStacks * 5 + "[/color] melee defense."
			});
		}
		if (this.getContainer().getActor().getMoraleState() == ::Const.MoraleState.Fleeing)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "If this character take damage, they have a chance to rally. The chance is equal to half their resolve."
			});
		}
		return tooltip;
	}

	function onUpdate( _properties )
	{
		_properties.IsAffectedByLosingHitpoints = false;
		_properties.MeleeDefense += 5 * this.m.BasicsStacks;
		_properties.Modifiers.Training += 0.1;
		this.m.IsHidden = (this.m.BasicsStacks == 0 || this.getContainer().getActor().getMoraleState() == ::Const.MoraleState.Fleeing);
	}

	function onTurnStart()
	{
		this.m.BasicsStacks = 0;
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (_attacker == null) return;

		this.m.BasicsStacks += 1;

		local a = this.getContainer().getActor();
		if (!a.getSkills().hasEffect(::Legends.Effect.Rallied))
		{
			local difficulty = ::Math.floor(a.getCurrentProperties().getBravery() * 0.5);
			local morale = a.getMoraleState();

			if (a.getMoraleState() == ::Const.MoraleState.Fleeing)
			{
				a.checkMorale(::Const.MoraleState.Wavering - ::Const.MoraleState.Fleeing, difficulty, ::Const.MoraleCheckType.Default, "status_effect_56");
			}

			if (morale != a.getMoraleState())
			{
				::Legends.Effects.grant(a, ::Legends.Effect.Rallied);
			}
		}
	}

	function onCombatFinished()
	{
		this.m.BasicsStacks = 0;
	}
});
