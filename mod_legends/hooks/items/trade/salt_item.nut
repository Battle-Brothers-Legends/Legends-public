::mods_hookExactClass("items/trade/salt_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.ResourceValue = 1;
	}
});