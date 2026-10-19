this.legend_bracing_for_impact_effect <- this.inherit("scripts/skills/legend_commander_abstract_effect", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendBracingForImpact);
		this.m.Description = "This mercenary has received clear instructions to seek cover, and is coordinating accordingly.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%positive%]+5[/color] Ranged Skill"
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
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%positive%]+10[/color] Ranged Defense"
			}
		]);
		return tooltip;
	}

	function onUpdate(_properties) {
		_properties.RangedSkill += 5;
		_properties.Bravery += 5;
		_properties.RangedDefense += 10;
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+5[/color] " + ::Legends.S.inlineIcon(["ranged_skill", "bravery"]) + ", [color=%positive%]+10[/color] " + ::Legends.S.inlineIcon("ranged_defense");
	}
});
