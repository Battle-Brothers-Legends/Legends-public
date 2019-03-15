this.legend_vala_premonition <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_vala_premonition";
		this.m.Name = "Premonition";
		this.m.Description = "";
		this.m.Icon = "ui/perks/legend_vala_premonition.png";
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


	function getTooltip()
	{
		if (!this.isHidden())
		{
			local bonus = this.Math.round(10.0 + ((this.getContainer().getActor().getLevel() * 10.0) / this.Const.LevelXP.len()));

			return [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 10,
					type = "text",
					icon = "ui/icons/special.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + bonus + "%[/color] chance to have any attacker require two successful attack rolls in order to hit."
				}
//				{
//					id = 11,
//					type = "text",
//					icon = "ui/icons/special.png",
//					text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + bonus + "%[/color] less likely to get targeted by enemies."
//				}
			];
		}
		else
		{
			return;
		}
	}


	function onUpdate (_properties)
	{
		local RerollBonus = 10.0 + ((this.getContainer().getActor().getLevel() * 10.0) / this.Const.LevelXP.len());

		if (RerollBonus >= 20)
		{
			RerollBonus = 20;
		}

		local Attraction = 10.0 + ((this.getContainer().getActor().getLevel() * 10.0) / this.Const.LevelXP.len());
		local AttractionMult = 1.0 - ((Attraction + 0.0) / 100.0);

		if (AttractionMult <= 0.8)
		{
			AttractionMult = 0.8;
		}

		_properties.RerollDefenseChance += RerollBonus;
		_properties.TargetAttractionMult *= AttractionMult;
	}
});
