::mods_hookExactClass("skills/effects/distracted_effect", function (o) {
	o.getDescription = function () {
		return "Slowed and distracted, having a harder time landing clean strikes after being on the receiving end of a dirty trick.";
	}

	o.getTooltip = function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=%negative%]-35%[/color] Damage"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-35%[/color] Initiative"
			}
		]);
		return tooltip;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-35%[/color] " + ::Legends.S.inlineIcon(["damage_dealt", "initiative"]);
	}
});
