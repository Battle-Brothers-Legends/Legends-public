::mods_hookExactClass("items/trade/cloth_rolls_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.ResourceValue = 1;
	}
});