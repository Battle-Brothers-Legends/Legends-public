::mods_hookExactClass("skills/effects/fake_charmed_effect", function (o) {
	o.getDescription <- function () {
		return "Charmed, and no longer in control over their actions, a puppet that has no choice but to obey a master.";
	}

	// not mentioning the 20 resolve so it looks like real charm
	o.getTooltip <- function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "This character is under the control of a master"
			},
		]);
		return tooltip;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Under the control of a master";
	}
});
