::mods_hookExactClass("items/trade/copper_ingots_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.ResourceValue = 1;
	}
});