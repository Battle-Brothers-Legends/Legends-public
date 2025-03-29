::mods_hookExactClass("items/weapons/fencing_sword", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Condition = 56.0;
		this.m.ConditionMax = 56.0;
	}
});
