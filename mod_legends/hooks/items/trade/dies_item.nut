::mods_hookExactClass("items/trade/dies_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Valuable dyes made from various plants or minerals. Could be used to make other things. Traders will pay good coin for this.";
		this.m.Value = 175;
		this.m.ResourceValue = 2;
	}
});