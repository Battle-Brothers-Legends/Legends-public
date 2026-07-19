::mods_hookExactClass("items/shields/named/named_red_white_shield", function(o) {
	o.randomizeValues <- function ()
	{
		this.m.MeleeDefense = 25;
		this.m.RangedDefense = 25;
		this.m.StaminaModifier = -20;
		this.m.Condition = 96;
		this.m.ConditionMax = 96;
		this.m.Block = 30;
		this.m.RegularDamage = 10;
		this.m.RegularDamage = 25;
		this.m.Value = 1400;
		this.named_shield.randomizeValues();
	}
});
