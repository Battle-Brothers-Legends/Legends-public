this.perk_legend_blend_in <- this.inherit("scripts/skills/skill", {
	m = {
		MeekStacks = 1,
		MeekCounter = 0
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendBlendIn);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getDescription()
	{
		return "Hold yourself in a way that makes you seem more trouble than its worth, lean into trees, place objects between you and an enemy, and hide behind allies.";
	}

	function onUpdate( _properties )
	{
		_properties.TargetAttractionMult *= 0.50;
	}

	function checkEntities()
	{

	}

	function getTooltip()
	{
		local tooltip = [
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
				id = 6,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+3[/color] Melee Defense."
			},
			{
				id = 7,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Ranged Defense."
			},
			{
				id = 6,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Makes enemies less likely to attack you instead of an ally."
			}
		];

		return tooltip;
	}
});
