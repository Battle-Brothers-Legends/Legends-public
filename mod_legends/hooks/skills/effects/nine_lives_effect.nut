::mods_hookExactClass("skills/effects/nine_lives_effect", function (o) {

	local create = o.create;
	o.create = function () {
		create();
		::Legends.Effects.onCreate(this, ::Legends.Effect.NineLives);
	}
});
