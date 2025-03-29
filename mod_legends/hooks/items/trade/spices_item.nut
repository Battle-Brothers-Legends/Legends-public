::mods_hookExactClass("items/trade/spices_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.ResourceValue = 2;
	}
});