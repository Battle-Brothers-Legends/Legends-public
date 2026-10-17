::mods_hookExactClass("skills/effects/battle_standard_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%positive%]+" + this.m.Difference + "[/color] " + ::Legends.S.inlineIcon("bravery");
	}
});
