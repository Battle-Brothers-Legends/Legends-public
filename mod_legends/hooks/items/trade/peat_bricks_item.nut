::mods_hookExactClass("items/trade/peat_bricks_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.ResourceValue = 1;
	}
});