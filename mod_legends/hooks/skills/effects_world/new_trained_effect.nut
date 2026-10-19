::mods_hookExactClass("skills/effects_world/new_trained_effect", function (o) {
	local onUpdate = o.onUpdate;
	o.onUpdate = function (_properties) {
		if (this.getContainer().getActor().isPlacedOnMap()) {
			return onUpdate(_properties);
		}
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%positive%]+" + (this.m.XPGainMult * 100 - 100) + "%[/color] " + ::Legends.S.inlineIcon("xp_received");
	}
});
