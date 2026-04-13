this.legend_well_tended_effect <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendWellTended);
		this.m.Description = "This mercenary has been tended at a temple, and is feeling much more capable thanks to well treated wounds and some rest.";
		this.m.Icon = "skills/legend_status_effect_well_tended.png";
		this.m.Type = this.m.Type | this.Const.SkillType.StatusEffect;
		this.m.IsHealingMentioned = false;
		this.m.IsTreatable = false;
		this.m.IsContentWithReserve = true; //tooltip will appear automatically
		this.m.HealingTimeMin = 4;
		this.m.HealingTimeMax = 7;
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
				text = "[color=%positive%]+5%[/color] Health"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%positive%]+5[/color] Resolve"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=%positive%]+3%[/color] Fatigue"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%positive%]+5%[/color] Melee skill"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%positive%]+5%[/color] Ranged skill"
			}
		];
		this.addTooltipHint(ret);
		return ret;
	}

	function onUpdate( _properties )
	{
		this.injury.onUpdate(_properties);
		_properties.HitpointsMult *= 1.05;
		_properties.Bravery += 5;
		_properties.StaminaMult *= 1.03;
		_properties.MeleeSkillMult *= 1.05;
		_properties.RangedSkillMult *= 1.05;
	}

});

