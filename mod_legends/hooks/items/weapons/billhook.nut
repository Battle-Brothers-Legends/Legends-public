::mods_hookExactClass("items/weapons/billhook", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Value = 1875;
	}
});
