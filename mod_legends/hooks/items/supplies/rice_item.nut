::mods_hookExactClass("items/supplies/rice_item", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.Description = "Provisions. Rice is cheap and readily available in the south. Spiced up with various herbs it becomes a tasty dish.";
		this.m.Amount = 20.0;
	}
});
