this.perk_legend_perfect_fit <- this.inherit("scripts/skills/skill", {
	m = {
		BonusMin = 0,
		BonusMax = 30
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPerfectFit);
		this.m.Description = "Leveraging the superior fit of %their% armor, %name% is gaining increased speed and endurance.";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
	}

	function getBonus()
	{
		local actor = this.getContainer().getActor();

		local bodyitem = actor.getBodyItem();

		if (bodyitem == null)
		{
			return 0;
		}

		local armorFatPen = -1 * actor.getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]);
		local maxFat = actor.getFatigueMax();
		local armorFatPenMult = 0;

		if (armorFatPen * 2 <= maxFat)
		{
			armorFatPenMult = 1;
		}
		else
		{
			armorFatPenMult = this.Math.maxf(0, 1 - 0.01 * this.Math.pow(armorFatPen - maxFat / 2.0, 2.44));
		}

		return this.m.BonusMax * armorFatPenMult;
	}

	function getInitiativeBonus(_bonus)
	{
		return this.Math.floor(_bonus);
	}

	function getFatCostReductionBonus(_bonus)
	{
		return this.Math.floor(_bonus / 2);
	}

	function getTooltip()
	{
		local bonus = this.getBonus();
		local tooltip = this.skill.getTooltip();

		if (bonus > this.m.BonusMin)
		{
			tooltip.extend([
				{
					id = 6,
					type = "text",
					icon = "ui/icons/initiative.png",
					text = "[color=%positive%]+" + this.getInitiativeBonus(bonus) + "%[/color] Initiative"
				},
				{
					id = 6,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = "Fatigue cost of skills reduced by [color=%positive%]" + this.getFatCostReductionBonus(bonus) + "%[/color]"
				}
			]);
		}

		if (this.getContainer().getActor().getBodyItem() == null)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "This character is not wearing any body armor and hence receives no bonus from this perk"
			});
		}

		return tooltip;
	}

	function getUnactivatedPerkTooltipHints()
	{
		local bonus = this.getBonus();
		local tooltip = [];

		if (bonus > this.m.BonusMin)
		{
			tooltip.extend([
				{
					id = 6,
					type = "text",
					icon = "ui/icons/initiative.png",
					text = "[color=%positive%]+" + this.getInitiativeBonus(bonus) + "%[/color] Initiative"
				},
				{
					id = 6,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = "Fatigue cost of skills reduced by [color=%positive%]" + this.getFatCostReductionBonus(bonus) + "%[/color]"
				}
			]);
		}

		if (this.getContainer().getActor().getBodyItem() == null)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "This character is not wearing any body armor and hence receives no bonus from this perk"
			});
		}

		return tooltip;
	}

	function onUpdate( _properties )
	{
		local bonus = this.getBonus();
		_properties.InitiativeMult *= 1.0 + 0.01 * this.getInitiativeBonus(bonus);
		_properties.FatigueEffectMult *= 1.0 - 0.01 * this.getFatCostReductionBonus(bonus);
	}
});
