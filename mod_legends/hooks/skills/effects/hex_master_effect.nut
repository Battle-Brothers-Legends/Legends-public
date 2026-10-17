::mods_hookExactClass("skills/effects/hex_master_effect", function (o) {
	o.getDescription <- function () {
		return "Has cursed another to feel the same pain and receive the same wounds as %themselves%.";
	}

	o.getTooltip <- function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Mirrors damage received to another"
			},
		]);
		return tooltip;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Mirrors " + ::Legends.S.inlineIcon("damage_received") + " to another";
	}
});
