::mods_hookExactClass("items/weapons/greataxe", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Value = 2725;
	}
});
