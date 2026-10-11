::mods_hookExactClass("items/shields/named/named_golden_round_shield", function(o) {
	o.randomizeValues <- function ()
	{
		this.m.Condition = 75;
		this.m.ConditionMax = 75;
		this.m.Block = 15;
		this.m.RegularDamage = 10;
		this.m.RegularDamageMax = 25;
		this.named_shield.randomizeValues();
	}
});
