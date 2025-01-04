this.perk_legend_wind_reader <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendWindReader);
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
			return 3;
		}

		local actor = this.getContainer().getActor();

		if (actor == null)
		{
			return 3;
		}

		local rdef = actor.getBaseProperties().RangedDefense;
		local bonus = rdef / 3;
		return this.Math.max(3, this.Math.floor(bonus));
	}


	function getTooltip()
	{
		local bonus = this.getBonus();
		local tooltip = this.skill.getTooltip();

			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "You are gaining [color=" + this.Const.UI.Color.PositiveValue + "]" + bonus + "[/color] ranged skill due to wind reading"
			});


		return tooltip;
	}

	function onUpdate( _properties )
	{
		local bonus = this.getBonus();
		_properties.RangedSkill += bonus;

	}


});

