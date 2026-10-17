::mods_hookExactClass("skills/effects/orc_warrior_potion_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%positive%]33%[/color] to resist Dazed, Staggered, Stunned, Distracted or Withered";
	}
});
