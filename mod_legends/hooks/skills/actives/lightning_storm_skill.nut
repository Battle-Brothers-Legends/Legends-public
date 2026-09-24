::mods_hookExactClass("skills/actives/lightning_storm_skill", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.MinRange = 0;
	}
});
