::mods_hookExactClass("skills/effects/taunted_effect", function (o) {
	o.m.TurnsLeft <- 1;

	o.getDescription <- function () {
		return "Taunted into attacking a character instead of taking defensive actions or attacking another, potentially more vulnerable target.";
	}

	o.getTooltip <- function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Encouraged to attack the taunting character"
			}
		]);
		return tooltip;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Encouraged to attack the taunting character";
	}
});
