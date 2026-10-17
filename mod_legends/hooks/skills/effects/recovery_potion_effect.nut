::mods_hookExactClass("skills/effects/rallied_effect", function (o) {
	o.getTooltip <- function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 10,
				type = "hint",
				icon = "ui/icons/turns_left.png",
				text = "Will be gone after 1 more battle"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue_recovery_up.png",
				text = "[color=%positive%]+4[/color] Fatigue Recovery per turn"
			}
		]);
		return tooltip;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%positive%]+4[/color] " + ::Legends.S.inlineIcon("fatigue_recovery_up") + " per turn";
	}
});
