::mods_hookExactClass("items/shields/named/named_bandit_heater_shield", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [
			1,
			2,
			3
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.m.Condition = 40;
		this.m.ConditionMax = 40;
	}
});
