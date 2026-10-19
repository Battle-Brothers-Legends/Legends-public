this.legend_parried_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendParried);
		this.m.Description = "Overextended and vulnerable to attack.";
		this.m.Order = ::Const.SkillOrder.VeryLast;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%negative%]-10[/color] Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%negative%]-10[/color] Ranged Defense"
			}
		]);
		return tooltip;
	}

	function onUpdate(_properties) {
		_properties.MeleeDefense -= 10;
		_properties.RangedDefense -= 10;
	}

	function onTurnStart() {
		this.removeSelf();
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%negative%]-10[/color] " + ::Legends.S.inlineIcon(["melee_defense", "ranged_defense"]);
	}
});
