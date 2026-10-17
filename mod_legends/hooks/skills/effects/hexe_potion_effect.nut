::mods_hookExactClass("skills/effects/hexe_potion_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Reflect [color=%positive%]100%[/color] health " + ::Legends.S.inlineIcon("damage_received") + " to attacker";
	}
});
