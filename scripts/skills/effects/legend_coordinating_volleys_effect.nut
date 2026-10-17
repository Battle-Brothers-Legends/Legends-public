this.legend_coordinating_volleys_effect <- this.inherit("scripts/skills/legend_commander_abstract_effect", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendCoordinatingVolleys);
		this.m.Description = "Fire on my mark! An inspirational leader is guiding this character\'s shots.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%positive%]+10[/color] Ranged Skill"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=%positive%]+5%[/color] Ranged Damage"
			}
		]);

		return tooltip;
	}

	function onUpdate(_properties) {
		_properties.RangedSkill += 10;
		_properties.RangedDamageMult *= 1.05;
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+10[/color] " + ::Legends.S.inlineIcon("ranged_skill") + ", [color=%positive%]+5%[/color] Ranged " + ::Legends.S.inlineIcon("damage_dealt");
	}
});
