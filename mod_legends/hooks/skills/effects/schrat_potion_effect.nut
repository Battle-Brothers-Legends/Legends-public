::mods_hookExactClass("skills/effects/schrat_potion_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return ::Legends.Text.inlineIcons("immunity") + " to Knockback and Grab";
	}
});
