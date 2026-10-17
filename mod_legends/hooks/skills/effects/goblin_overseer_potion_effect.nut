::mods_hookExactClass("skills/effects/goblin_overseer_potion_effect", function (o) {
	o.getTooltip <- function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "An additional [color=" + this.Const.UI.Color.PositiveValue + "]5%[/color] of damage ignores armor when using bows, slings or crossbows"
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
		return "[color=%positive%]+5%[/color] bows, slings or crossbow " + ::Legends.S.inlineIcon("direct_damage");
	}
});
