::mods_hookExactClass("skills/effects/nachzehrer_potion_effect", function (o) {
	o.getTooltip = function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/days_wounded.png",
				text = "Reduces the time it takes to heal from any injury by one day, down to a minimum of one day"
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "Further mutations will cause a longer period of sickness"
			}
		]);
		return tooltip;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Reduces Injury recovery time by [color=%negative%]1[/color]";
	}
});
