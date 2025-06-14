::mods_hookExactClass("items/shields/named/named_sipar_shield", function(o) {
	o.randomizeValues <- function ()
	{
		this.m.Variants = [
			1,
			2,
			3
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.Condition = 75;
		this.m.ConditionMax = 75;
		this.named_shield.randomizeValues();
	}
});
