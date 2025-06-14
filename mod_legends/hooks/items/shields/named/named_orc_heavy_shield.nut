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
		this.m.Condition = 80;
		this.m.ConditionMax = 80;
		this.named_shield.randomizeValues();
	}
});
