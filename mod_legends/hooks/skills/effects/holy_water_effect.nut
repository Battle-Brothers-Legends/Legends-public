::mods_hookExactClass("skills/effects/holy_water_effect", function (o) {
	o.getDescription <- function () {
		return "Sprayed with holy water.";
	}

	o.getTooltip <- function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "[color=%negative%]20[/color] Hitpoints Damage Received every turn"
			}
		]);
		return tooltip;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]" + (20 * _stacks) + "[/color] " + ::Legends.S.inlineIcon("damage_received") + " every turn";
	}
});
