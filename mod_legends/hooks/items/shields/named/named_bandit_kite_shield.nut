::mods_hookExactClass("items/shields/named/named_bandit_kite_shield", function(o) {
	o.randomizeValues <- function ()
	{
		this.m.Variants = [
			1
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.Condition = 60;
		this.m.ConditionMax = 60;
		this.named_shield.randomizeValues();
	}
});
