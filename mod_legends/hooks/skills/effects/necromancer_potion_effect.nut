::mods_hookExactClass("skills/effects/necromancer_potion_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%positive%]+20%[/color] " + ::Legends.S.inlineIcon("xp_received");
	}
});
