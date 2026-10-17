::mods_hookExactClass("skills/effects/disarmed_effect", function (o) {
	o.getDescription = function () {
		return "Temporarily disarmed, having fumbled %their% weapon.";
	}

	o.getTooltip <- function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Cannot use weapon skills"
			}
		]);
		return tooltip;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Cannot use weapon skills";
	}
});
