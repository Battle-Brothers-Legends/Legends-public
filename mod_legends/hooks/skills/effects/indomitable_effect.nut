::mods_hookExactClass("skills/effects/indomitable_effect", function (o) {
	o.m.TurnsLeft <- 1;

	o.getTooltip = function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "[color=%negative%]-50%[/color] Damage Received"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Immune to being stunned"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Immune to being knocked back or grabbed"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Makes enemies less likely to attack you instead of an ally."
			}
		]);
		return tooltip;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		::Legends.S.inlineIcon("immunity") + " to Stun, Knockback and Grab, [color=%negative%]-50%[/color] " + ::Legends.S.inlineIcon("damage_received") + ", less likely to be targeted";
	}
});
