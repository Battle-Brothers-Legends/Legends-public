::mods_hookExactClass("items/shields/named/named_rider_on_horse_shield", function(o) {
	o.randomizeValues <- function ()
	{
		this.m.Condition = 50;
		this.m.ConditionMax = 50;
		this.m.Block = 20;
		this.m.RegularDamage = 15;
		this.m.RegularDamage = 30;
		this.named_shield.randomizeValues();
	}
});
