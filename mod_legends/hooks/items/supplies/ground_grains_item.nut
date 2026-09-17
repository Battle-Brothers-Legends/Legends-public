::mods_hookExactClass("items/supplies/ground_grains_item", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "Provisions. Various kinds of grounded grain that will be cooked up with water or milk for a daily meal. It is satiating but tasteless.";
		this.m.Amount = 15.0;
	}
});
