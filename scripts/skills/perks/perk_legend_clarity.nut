this.perk_legend_clarity <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendClarity);
		this.m.Description = "A well honed mind can perceive more in each moment, making time appear slower in key instants of need.";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "[color=%positive%]+10%[/color] of any damage ignores armor"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Immune to being [color=%status%]Dazed[/color] or [color=%status%]Taunted[/color]"
			}
		]);
		return tooltip;
	}

	function onUpdate(_properties) {
		_properties.DamageDirectAdd += 0.1;
		_properties.IsImmuneToDaze = true;
		_properties.IsImmuneToTaunt = true;
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+10%[/color] " + ::Legends.Text.inlineIcons("direct_damage") + ", immune to Daze and Taunt";
	}
});
