::mods_hookExactClass("items/shields/named/named_dragon_shield", function(o) {
	o.randomizeValues <- function ()
	{
		this.m.Condition = 60;
		this.m.ConditionMax = 60;
		this.named_shield.randomizeValues();
	}
});
