::mods_hookExactClass("items/shields/faction_wooden_shield", function(o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Block = 10;
		this.m.RegularDamage = 10;
		this.m.RegularDamageMax = 25;
	}
});