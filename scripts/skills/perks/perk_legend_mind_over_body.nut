this.perk_legend_mind_over_body <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMindOverBody);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Last;
	}

	function getBonus( unactivated )
	{
		if (this.getContainer() == null)
		{
			return 0;
		}

		local actor = this.getContainer().getActor();

		if (actor == null)
		{
			return 0;
		}

		local resolve = actor.getCurrentProperties().getBravery();
		if(unactivated)
		{
			if(actor.getSkills().hasSkill("perk.fortified_mind"));
			resolve *= 1.25
		}
		local fraction = resolve / 60.0;
		local normal = this.Math.floor(fraction * 100);
		local bonus = normal * 0.01;

		return bonus;
	}

	function getTooltip()
	{
		local bonus = this.getBonus(false);
		if (bonus > 1)
		{
			bonus = this.Math.pow(bonus, 0.5);
		}
		local reduction = this.Math.round((1 - 1 / bonus) * 100);
		local tooltip = this.skill.getTooltip();

		if (bonus > 1)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "All your fatigue costs are reduced by [color=%positive%]" + reduction + "%[/color]"
			});
		}
		else
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "This character does not have enough resolve to benefit from Mind Over Body."
			});
		}

		return tooltip;
	}

	function getUnactivatedPerkTooltipHints()
	{
		local bonus = this.getBonus(true);
		if (bonus > 1)
		{
			bonus = this.Math.pow(bonus, 0.5);
		}
		local reduction = this.Math.round((1 - 1 / bonus) * 100);
		local tooltip = [];
		if (bonus > 1)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "All your fatigue costs are reduced by [color=%positive%]" + reduction + "%[/color]"
			});
		}
		else
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "This character does not have enough resolve to benefit from Mind Over Body."
			});
		}

		return tooltip;
	}

	function onUpdate( _properties )
	{
		local bonus = this.getBonus(false);
		if (bonus > 1)
		{
			bonus = this.Math.pow(bonus, 0.5);
			_properties.FatigueEffectMult *= 1.0 / bonus;
		}
	}

});

