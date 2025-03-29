::mods_hookExactClass("items/armor/named/named_plated_fur_armor", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Condition = 155;
		this.m.ConditionMax = 155;
		this.m.StaminaModifier = -17;
	}
});