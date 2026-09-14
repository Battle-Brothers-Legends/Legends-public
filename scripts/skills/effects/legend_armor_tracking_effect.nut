this.legend_armor_tracking_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendArmorTracking);
		this.m.Description = "to do";
		this.m.Icon = "ui/perks/feint_circle.png";
		this.m.IconMini = "feint_circle_mini";
		this.m.Overlay = "feint_circle_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsHidden = true;
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
				id = 12,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=%negative%]-50%[/color] Fatigue Cost for [color=#400080]Round Swing[/color], [color=#400080]Swing[/color], [color=#400080]Thresh[/color], [color=#400080]Reap[/color], [color=#400080]Castigate[/color]"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=%negative%]-50%[/color] Action Point cost for [color=#400080]Round Swing[/color], [color=#400080]Swing[/color], [color=#400080]Thresh[/color], [color=#400080]Reap[/color], [color=#400080]Castigate[/color]"
			},
			{
				id = 14,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=%negative%]-50%[/color] Damage for [color=#400080]Round Swing[/color], [color=#400080]Thresh[/color], [color=#400080]Reap[/color], [color=#400080]Castigate[/color]"
			},
			{
				id = 15,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=%negative%]-25%[/color] Damage for [color=#400080]Swing[/color]"
			}
		];
		return ret;
	}
});
