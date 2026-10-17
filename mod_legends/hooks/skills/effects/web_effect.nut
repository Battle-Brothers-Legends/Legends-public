::mods_hookExactClass("skills/effects/web_effect", function (o) {
	o.getDescription <- function () {
		return "A large and sticky web holds this character in place and hampers %their% ability to defend %themselves% and to put real force behind any blows. To break free, the web will have to be cut.";
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-50%[/color] " + ::Legends.S.inlineIcon("damage_dealt") + ::Legends.S.inlineIcon("melee_defense") + ::Legends.S.inlineIcon("ranged_defense") + ::Legends.S.inlineIcon("initiative") + ", [color=%negative%]+100%[/color]" + ::Legends.S.inlineIcon("damage_received") + ", from webknechts, unable to move, more likely to get attacked";
	}
});
