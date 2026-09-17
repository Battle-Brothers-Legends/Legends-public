::mods_hookExactClass("items/supplies/dried_fish_item", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "Provisions. Fish is a common and filling food in coastal regions. It is dried to preserve it.";
		this.m.Amount = 20.0;
	}
});
