::mods_hookExactClass("skills/effects/nine_lives_effect", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Effects.onCreate(this, ::Legends.Effect.NineLives);
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]+15[/color] " + ::Legends.Text.inlineIcons(["melee_defense", "ranged_defense", "bravery", "initiative"]);
	}
});
