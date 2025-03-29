::mods_hookExactClass("items/trade/uncut_gems_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.ResourceValue = 3;
	}
});