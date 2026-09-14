::mods_hookExactClass("entity/world/settlements/city_state", function(o) {
	local create = o.create;
	o.create = function () {
		// just use legends bladedancer instead
		create();
		foreach (idx, item in this.m.DraftList) {
			if (item == "blade_dancer_background")
				this.m.DraftList[idx] = "legend_bladedancer_background"
		}
	}
});
