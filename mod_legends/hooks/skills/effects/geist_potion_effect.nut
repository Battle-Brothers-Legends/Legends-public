::mods_hookExactClass("skills/effects/geist_potion_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%positive%]+5%[/color] melee " + ::Legends.S.inlineIcon("direct_damage");
	}
});
