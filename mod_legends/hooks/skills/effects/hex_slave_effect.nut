::mods_hookExactClass("skills/effects/hex_slave_effect", function (o) {
	o.m.TurnsLeft <- 1;

	o.getDescription <- function () {
		return "Has been cursed to feel the same pain and receive the same wounds as another.";
	}

	o.getTooltip <- function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Receives the same damage as another"
			},
		]);
		return tooltip;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Receives the same " + ::Legends.S.inlineIcon("damage_received") + " as another";
	}
});
