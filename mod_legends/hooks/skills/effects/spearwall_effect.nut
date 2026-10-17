::mods_hookExactClass("skills/effects/spearwall_effect", function (o) {
	o.m.TurnsLeft <- 1;

	o.getDescription = function () {
		return "Has %their% spear readied.";
	}

	o.getTooltip <- function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Automatically attacks any opponent trying to enter the Zone of Control"
			}
		]);
		return tooltip;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Automatically attacks any opponent trying to enter the Zone of Control";
	}
});