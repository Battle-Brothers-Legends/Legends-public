::mods_hookExactClass("skills/effects/dazed_effect", function (o) {
	o.getDescription = function () {
		return "Dazed, confused and gasping for air after receiving a heavy blow.";
	}

	o.getTooltip = function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=%negative%]-25%[/color] Damage"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=%negative%]-25%[/color] Max Fatigue"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-25%[/color] Initiative"
			}
		]);
		return tooltip;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-25%[/color] " + ::Legends.S.inlineIcon("damage_dealt") + ::Legends.S.inlineIcon("fatigue") + ::Legends.S.inlineIcon("initiative");
	}
});
