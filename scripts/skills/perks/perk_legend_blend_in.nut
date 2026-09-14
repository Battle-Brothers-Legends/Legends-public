this.perk_legend_blend_in <- this.inherit("scripts/skills/skill", {
	m = {
		MeekStacks = 1,
		MeekCounter = 0
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendBlendIn);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	function getDescription()
	{
		return "Hold yourself in a way that makes you seem more trouble than its worth, lean into trees, place objects between you and an enemy, and hide behind allies.";
	}

	function onUpdate( _properties )
	{
		_properties.TargetAttractionMult *= 0.50;
		_properties.MeleeDefense += 3;
		_properties.RangedDefense += 5;
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
				text = "[color=%positive%]+3[/color] Melee Defense."
			},
			{
				id = 7,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "[color=%positive%]+5[/color] Ranged Defense."
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
