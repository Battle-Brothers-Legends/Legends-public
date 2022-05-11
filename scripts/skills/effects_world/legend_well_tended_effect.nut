this.legend_well_tended_effect <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "effects.legend_well_tended";
		this.m.Name = "Well Tended";
		this.m.Description = "This mercenary has been tended at a temple, and is feeling much more capable thanks to well treated wounds and some rest.";
		this.m.Icon = "skills/legend_status_effect_well_tended.png";
		this.m.Type = this.m.Type | this.Const.SkillType.StatusEffect;
		this.m.IsHealingMentioned = false;
		this.m.IsTreatable = false;
		this.m.IsContentWithReserve = true;
		this.m.HealingTimeMin = 3;
		this.m.HealingTimeMax = 4;
	}

	function getTooltip()
	{
		local ret = [
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
				id = 13,
				type = "text",
				icon = "ui/icons/health.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] Health"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] Resolve"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] Fatigue"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] Melee skill"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] Ranged skill"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] Melee defence"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] Ranged defence"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Is content with being in reserve"
			}
		];
		this.addTooltipHint(ret);
		return ret;
	}

	function onUpdate( _properties )
	{
		this.injury.onUpdate(_properties);
		_properties.HitpointsMult *= 1.15;
		_properties.BraveryMult *= 1.10;
		_properties.StaminaMult *= 1.10;
		_properties.MeleeSkillMult *= 1.05;
		_properties.RangedSkillMult *= 1.05;
		_properties.MeleeDefenseMult *= 1.15;
		_properties.RangedDefenseMult *= 1.15;
	}

});

