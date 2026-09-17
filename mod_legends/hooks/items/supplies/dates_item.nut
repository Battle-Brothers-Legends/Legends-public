::mods_hookExactClass("items/supplies/dates_item", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Name = "Dried Dates";
		this.m.Description = "Provisions. Dried dates are common in the south. These sweet, dried fruits are high energy and well preserved. They are dried to preserve them longer.";
		this.m.Amount = 20.0;
	}
});
