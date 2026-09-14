::mods_hookExactClass("entity/world/settlements/medium_mining_village", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.StablesList = [
			::Legends.Background.LegendDonkey
		];
	}
});
