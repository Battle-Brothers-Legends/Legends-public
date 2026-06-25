::mods_hookExactClass("entity/world/settlements/small_mountains_fort", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.StablesList = [
			::Legends.Background.LegendDonkey,
			::Legends.Background.LegendHorseRouncey
		];
	}
});
