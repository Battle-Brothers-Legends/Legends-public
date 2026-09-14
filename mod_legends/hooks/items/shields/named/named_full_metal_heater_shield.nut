::mods_hookExactClass("items/shields/named/named_full_metal_heater_shield", function(o) {
	o.randomizeValues <- function ()
	{
		this.m.Condition = 75;
		this.m.ConditionMax = 75;
		this.m.Block = 25;
		this.m.RegularDamage = 20;
		this.m.RegularDamage = 35;
		this.named_shield.randomizeValues();
	}
});
