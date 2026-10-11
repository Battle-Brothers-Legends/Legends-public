::mods_hookExactClass("items/shields/named/named_wing_shield", function(o) {
	o.randomizeValues <- function ()
	{
		this.m.Condition = 50;
		this.m.ConditionMax = 50;
		this.m.Block = 13;
		this.m.RegularDamage = 15;
		this.m.RegularDamageMax = 30;
		this.named_shield.randomizeValues();
	}
});
