this.legend_forceful_swings_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendForcefulSwings);
		this.m.Description = "Use the power of your hips and core to imbue more force into your swings.";
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/damage_dealt.png",
			text = "[color=%positive%]+10%[/color] Area of Effect Damage"
		});
		return tooltip;
	}

	function onAnySkillUsed(_skill, _targetEntity, _properties) {
		if (!_skill.isRanged() && _skill.isAOE() && _skill.isAttack()) {
			_properties.DamageTotalMult *= 1.1;
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+10%[/color] Area of Effect " + ::Legends.S.inlineIcon("damage_dealt");
	}
});
