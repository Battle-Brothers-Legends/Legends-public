::mods_hookExactClass("skills/effects/unhold_potion_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Heal [color=%positive%]10%[/color]" + ::Legends.S.inlineIcon("health") + " every turn";
	}
});
