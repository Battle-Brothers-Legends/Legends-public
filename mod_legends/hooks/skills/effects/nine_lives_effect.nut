::mods_hookExactClass("skills/effects/nine_lives_effect", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Effects.onCreate(this, ::Legends.Effect.NineLives);
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		"[color=%negative%]+15[/color] " + ::Legends.S.inlineIcon("melee_defense") + ::Legends.S.inlineIcon("ranged_defense") + ::Legends.S.inlineIcon("bravery") + ::Legends.S.inlineIcon("initiative");
	}
});
