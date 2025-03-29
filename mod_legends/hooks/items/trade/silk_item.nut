::mods_hookExactClass("items/trade/silk_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.ResourceValue = 2;
	}
});