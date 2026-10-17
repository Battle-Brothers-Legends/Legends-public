::mods_hookExactClass("skills/effects/orc_young_potion_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%positive%]+10%[/color] " + ::Legends.S.inlineIcon("armor_damage");
	}
});
