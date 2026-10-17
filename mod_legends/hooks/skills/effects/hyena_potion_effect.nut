::mods_hookExactClass("skills/effects/hyena_potion_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-50%[/color] " + ::Legends.S.inlineIcon("damage_received") + " from Bleeding";
	}
});
