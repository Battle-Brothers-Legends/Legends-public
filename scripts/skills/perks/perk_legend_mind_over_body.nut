this.perk_legend_mind_over_body <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_mind_over_body";
		this.m.Name = this.Const.Strings.PerkName.LegendMindOverBody;
		this.m.Description = this.Const.Strings.PerkDescription.LegendMindOverBody;
		this.m.Icon = "ui/perks/relax_circle.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getBonus()
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
		local fraction = resolve / 75;
		local normal = this.Math.floor(fraction * 100);
		local bonus = normal / 100;

		return bonus;
	}

	function getTooltip()
	{
		local bonus = this.getBonus();
		local tooltip = this.skill.getTooltip();

		if (bonus > 1)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "All your fatigue costs are divided by [color=" + this.Const.UI.Color.PositiveValue + "]" + bonus + "%[/color]."
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
		local bonus = this.getBonus();
		if (bonus > 1)
		{
		_properties.FatigueEffectMult *= 1.0 / bonus;
		}
	}

});

