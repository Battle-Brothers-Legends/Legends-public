::mods_hookExactClass("entity/world/settlements/stronghold_hamlet", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Sprite = "stronghold_01";
		this.m.Lighting = "stronghold_01_light";
	}
});
