::mods_hookExactClass("skills/effects/nightmare_effect", function (o) {
	o.getDescription <- function () {
		return "Consumed by unnatural nightmares and unable to act.";
	}

	o.getTooltip = function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 8,
				type = "text",
				icon = "ui/icons/damage_received",
				text = "[color=%negative%]" + this.m.Damage + "[/color] Hitpoints Damage Received every turn"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-300[/color] Initiative"
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
				text = "Can be awoken by a nearby ally"
			}

		]);
		return tooltip;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Unable to act, [color=%negative%]-300[/color] " + ::Legends.S.inlineIcon("initiative") + ", [color=%negative%]" + this.m.Damage + "[/color] " + ::Legends.S.inlineIcon("damage_received") + " every turn";
	}
});
