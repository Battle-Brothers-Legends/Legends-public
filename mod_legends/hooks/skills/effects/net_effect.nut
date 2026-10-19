::mods_hookExactClass("skills/effects/net_effect", function (o) {
	o.getDescription <- function () {
		return "A large net holds this character in place and hampers their ability to defend %themselves%. To break free, the net will have to be cut.";
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		"[color=%negative%]-45%[/color] " + ::Legends.S.inlineIcon(["melee_defense", "ranged_defense", "initiative"]) + ", unable to move";
	}
});
