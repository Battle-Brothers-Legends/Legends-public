::mods_hookExactClass("items/shields/named/named_rider_on_horse_shield", function(o) {
	o.randomizeValues <- function ()
	{
		this.m.Condition = 40;
		this.m.ConditionMax = 40;
		this.named_shield.randomizeValues();
	}
});
