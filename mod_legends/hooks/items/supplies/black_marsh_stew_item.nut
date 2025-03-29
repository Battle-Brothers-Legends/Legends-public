::mods_hookExactClass("items/supplies/black_marsh_stew_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Amount = 30.0;
	}
});