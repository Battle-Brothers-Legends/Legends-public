::mods_hookExactClass("skills/effects/insect_swarm_effect", function (o) {
	o.getDescription = function () {
		return "A thousand black flies buzz around this character, trying to crawl into every small opening of armor, into every orifice of the body. A terrible curse that makes it nigh impossible to fight.";
	}

	o.getTooltip = function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%negative%]-50%[/color] Melee Skill"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%negative%]-50%[/color] Ranged Skill"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%negative%]-50%[/color] Melee Defense"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%negative%]-50%[/color] Ranged Defense"
			},
			{
				id = 14,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-50%[/color] Initiative"
			}
		]);
		return tooltip;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		"[color=%negative%]-50%[/color] " + ::Legends.S.inlineIcon("melee_skill") + ::Legends.S.inlineIcon("ranged_skill") + ::Legends.S.inlineIcon("melee_defense") + ::Legends.S.inlineIcon("ranged_defense") + ::Legends.S.inlineIcon("initiative");
	}
});
