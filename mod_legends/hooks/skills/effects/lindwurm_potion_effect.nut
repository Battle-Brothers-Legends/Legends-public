::mods_hookExactClass("skills/effects/lindwurm_potion_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Sprays adjacent melee attackers with Acidic blood";
	}
});
