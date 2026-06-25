::mods_hookExactClass("entity/world/settlements/small_fishing_village", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.DraftList.extend([
			::Legends.Background.Butcher,
			::Legends.Background.Butcher
		]);
	}
});
