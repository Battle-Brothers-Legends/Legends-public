::mods_hookExactClass("items/shields/greenskins/orc_heavy_shield", function(o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Condition = 100;
		this.m.ConditionMax = 100;
		this.m.Block = 30;
		this.m.RegularDamage = 15;
		this.m.RegularDamage = 30;
	}
});
