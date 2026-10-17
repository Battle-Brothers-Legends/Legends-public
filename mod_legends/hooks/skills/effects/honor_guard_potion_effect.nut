::mods_hookExactClass("skills/effects/honor_guard_potion_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-25%[/color] to [color=%negative%]-50%[/color] " + ::Legends.S.inlineIcon("damage_received") + " from piercing attacks";
	}
});
