this.perk_legend_vala_premonition <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendValaPremonition);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast + 9;
	}

	function isHidden()
	{
		return false;
	}

	function getBonus()
	{
		return this.Math.min(33.0, this.Math.round(9.0 + this.getContainer().getActor().getLevel() * 2.0));
	}

	function getTooltip()
	{
		local bonus = this.getBonus();
		local ret = this.getDefaultUtilityTooltip();
		ret.pop(); // pop cost

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=%positive%]+" + bonus + "%[/color] chance to have any attacker require two successful attack rolls in order to hit"
		});

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Makes enemies less likely to attack you instead of an ally by [color=%negative%]" + bonus + "%[/color]"
		});

		return ret;
	}


	function onUpdate (_properties)
	{
		local bonus = this.getBonus();
		_properties.RerollDefenseChance += bonus;
		_properties.TargetAttractionMult *= 1.0 - ((bonus + 0.0) / 100.0);
	}
});
