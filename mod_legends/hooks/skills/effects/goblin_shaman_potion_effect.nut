::mods_hookExactClass("skills/effects/goblin_shaman_potion_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Always able to successfully escape from snares";
	}
});
