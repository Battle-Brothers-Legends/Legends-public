::mods_hookExactClass("items/supplies/dried_lamb_item", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "Provisions. Dried Lamb is a specialty and a highly sought-after food in the south. A real treat for any hungry mercenary.";
		this.m.Amount = 30.0;
	}
});
