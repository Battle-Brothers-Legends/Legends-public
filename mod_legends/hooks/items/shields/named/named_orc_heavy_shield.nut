::mods_hookExactClass("items/shields/named/named_orc_heavy_shield", function(o) {
	o.randomizeValues <- function ()
	{
		this.m.Variants = [
			1,
			2,
			3
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.Condition = 100;
		this.m.ConditionMax = 100;
		this.m.Block = 30;
		this.m.RegularDamage = 15;
		this.m.RegularDamage = 30;
		this.named_shield.randomizeValues();
	}
});
