this.legend_holding_the_line <- this.inherit("scripts/skills/effects/legend_commander_abstract_effect", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendHoldingTheLine);
		this.m.Description = "You WILL hold! An inspirational leader has encouraged this character to hold their ground.";
		this.m.Icon = "ui/perks/holdtheline_circle.png";
		this.m.IconMini = "mini_holdtheline_circle";
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
				icon = "ui/icons/melee_defense.png",
				text = "[color=%positive%]+10[/color] Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%positive%]+10[/color] Ranged Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Receive only [color=%positive%]90%[/color] of any damage"
			}
		]);

		return tooltip;
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDefense += 10;
		_properties.RangedDefense += 10;
		_properties.DamageReceivedTotalMult *= 0.9;
	}
});
