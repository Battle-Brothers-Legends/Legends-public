::mods_hookExactClass("items/shields/ancient/tower_shield", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [
			1,
			2,
			3,
			4,
			5
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.m.MeleeDefense = 25;
		this.m.RangedDefense = 20;
		this.m.Condition = 48;
		this.m.ConditionMax = 48;
		this.m.Block = 30;
		this.m.RegularDamage = 10;
		this.m.RegularDamage = 25;
	}
});
