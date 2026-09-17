::mods_hookExactClass("items/supplies/dried_fruits_item", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "Provisions. Fruits from orchards are both tasty and nutritious. They are dried to preserve them longer.";
		this.m.Amount = 30.0;
	}
});
