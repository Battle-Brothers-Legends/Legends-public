::mods_hookExactClass("items/shields/wooden_shield_old", function(o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Block = 10;
		this.m.RegularDamage = 10;
		this.m.RegularDamageMax = 25;
	}
});
