::mods_hookExactClass("skills/effects/killing_frenzy_effect", function (o) {
	o.getDescription = function () {
		return "RAAAARGH!";
	}

	o.getTooltip = function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=%positive%]+25%[/color] Damage"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Makes enemies more likely to attack you instead of an ally."
			}
		]);
		return tooltip;
	}

	o.resetTime <- function () {
		if (this.m.TurnsLeft != 2) {
			this.m.TurnsLeft = 2;
			if (this.getContainer().getActor().isPlacedOnMap()) {
				this.spawnIcon("perk_36", this.getContainer().getActor().getTile());
			}
		}
	}

	o.reset = function () {}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%positive%]+25%[/color] " + ::Legends.S.inlineIcon("damage_dealt") + ", more likely to be targeted";
	}
});
