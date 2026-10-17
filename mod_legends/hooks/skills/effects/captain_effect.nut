//tbd, since this one is a bit fucked if im not mistaken when it comes to refreshing the icon
::mods_hookExactClass("skills/effects/captain_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%positive%]+" + this.m.Difference + "[/color] " + ::Legends.S.inlineIcon("bravery");
	}
});
