::mods_hookExactClass("items/armor/named/named_skull_and_chain_armor", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Condition = 210;
		this.m.ConditionMax = 210;
		this.m.StaminaModifier = -27;
	}
});