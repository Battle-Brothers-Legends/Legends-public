::mods_hookExactClass("skills/effects/lorekeeper_potion_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Once per battle, regain full health instead of dying";
	}
});
