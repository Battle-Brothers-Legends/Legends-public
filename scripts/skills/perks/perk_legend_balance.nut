this.perk_legend_balance <- this.inherit("scripts/skills/skill", {
	m = {
		BonusMax = 15
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendBalance);
		this.m.Description = "%name% gains increased Melee and Ranged defense by balancing %their% armor weight.";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getTooltip ()
	{
		local bonus = this.getBonus();
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + (this.Math.max(0, this.m.BonusMax - bonus)) + "[/color] Ranged Defense"
			}
		];
	}

	function getBonus()
	{
		local actor = this.getContainer().getActor();
		local armorFatPen = actor.getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]) * -1;
		local bonus = this.Math.floor(armorFatPen / 5);
		return this.Math.min(this.m.BonusMax, bonus);
	}

	function onAfterUpdate( _properties )
	{
		local bonus = this.getBonus();
		_properties.MeleeDefense += bonus;
		_properties.RangedDefense += this.Math.max(0, this.m.BonusMax - bonus);
	}
});
