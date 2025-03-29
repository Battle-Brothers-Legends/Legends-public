::mods_hookExactClass("items/shields/named/named_full_metal_heater_shield", function(o) {
	o.randomizeValues <- function ()
	{
		this.m.Condition = 75;
		this.m.ConditionMax = 75;
		this.named_shield.randomizeValues();
	}
});
