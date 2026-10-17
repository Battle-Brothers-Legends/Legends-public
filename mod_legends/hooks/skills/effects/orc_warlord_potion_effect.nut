::mods_hookExactClass("skills/effects/orc_warlord_potion_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "No extra " + ::Legends.S.inlineIcon("fatigue") + " costs while using orc weapons";
	}
});
