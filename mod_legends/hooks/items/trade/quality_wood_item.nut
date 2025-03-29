::mods_hookExactClass("items/trade/quality_wood_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.ResourceValue = 1;
	}
});