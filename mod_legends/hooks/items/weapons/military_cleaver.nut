::mods_hookExactClass("items/weapons/military_cleaver", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Value = 2500;
	}
});
