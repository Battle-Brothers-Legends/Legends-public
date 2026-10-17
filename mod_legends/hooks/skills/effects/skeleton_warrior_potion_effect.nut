::mods_hookExactClass("skills/effects/skeleton_warrior_potion_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-" + ::Const.Combat.WeaponSpecFatigueMult + "%[/color]" + ::Legends.S.inlineIcon("fatigue") + " cost of Shieldwall";
	}
});
