::mods_hookExactClass("skills/effects/ifrit_potion_effect", function (o) {
	o.getTooltip = function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/armor_body.png",
				text = "[color=%positive%]+25[/color] Body armor"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/armor_head.png",
				text = "[color=%positive%]+25[/color] Head armor"
			},
			{
				id = 13,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "Further mutations will cause a longer period of sickness"
			}
		]);
		return tooltip;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%positive%]+25[/color] " + ::Legends.S.inlineIcon("armor_body") + ::Legends.S.inlineIcon("armor_head");
	}
});
