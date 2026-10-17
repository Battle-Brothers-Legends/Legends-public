::mods_hookExactClass("skills/effects/wiederganger_potion_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%positive%]+33%[/color] threshold to sustain Injuries";
	}
});
