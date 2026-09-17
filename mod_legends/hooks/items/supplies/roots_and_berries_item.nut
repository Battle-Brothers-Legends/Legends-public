::mods_hookExactClass("items/supplies/roots_and_berries_item", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Name = "Dried Roots and Berries";
		this.m.Description = "Provisions. Dried roots and berries are not the most exciting of rations but easy to come by and durable.";
		this.m.Icon = "supplies/legend_dried_roots_and_berries.png";
		this.m.Amount = 15.0;
	}
});
