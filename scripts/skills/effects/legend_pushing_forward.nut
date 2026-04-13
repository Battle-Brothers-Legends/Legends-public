this.legend_pushing_forward <- this.inherit("scripts/skills/effects/legend_commander_abstract_effect", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendPushingForward);
		this.m.Description = "This mercenary has received clear instructions to push forward, and is coordinating accordingly.";
		this.m.Icon = "ui/perks/spears_circle.png";
		this.m.IconMini = "mini_spears_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%positive%]+10[/color] Melee Skill"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%positive%]+5[/color] Resolve"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%positive%]+3[/color] Melee Defence"
			}
		]);
		return tooltip;
	}

	function onUpdate( _properties )
	{
		_properties.MeleeSkill += 10;
		_properties.Bravery += 5;
		_properties.MeleeDefense += 3;
	}
});
