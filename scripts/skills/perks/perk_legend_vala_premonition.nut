this.perk_legend_vala_premonition <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendValaPremonition);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast + 9;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
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

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + bonus + "%[/color] chance to have any attacker require two successful attack rolls in order to hit"
		});

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Makes enemies less likely to attack you instead of an ally by [color=" + this.Const.UI.Color.NegativeValue + "]" + bonus + "%[/color]"
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
