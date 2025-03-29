::mods_hookExactClass("items/shields/named/named_lindwurm_shield", function(o) {
	o.randomizeValues <- function ()
	{
		this.named_shield.randomizeValues();
		this.resetStats();
	}

	o.resetStats <- function ()
	{
		this.m.MeleeDefense = 17;
		this.m.RangedDefense = 25;
		this.m.StaminaModifier = -14;
		this.m.Condition = 64;
		this.m.ConditionMax = 64;
	}
});
