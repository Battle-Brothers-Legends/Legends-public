::mods_hookExactClass("skills/effects/sleeping_effect", function (o) {
	o.getDescription = function () {
		return "This character has fallen into unnatural sleep.";
	}

	o.getTooltip = function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 9,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-100[/color] Initiative"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Is unable to act"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Can be awoken by a nearby ally or by taking damage from a different source than Alps"
			}
		]);
		return tooltip;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Unable to act, [color=%negative%]-100[/color] " + ::Legends.S.inlineIcon("initiative");
	}
});
