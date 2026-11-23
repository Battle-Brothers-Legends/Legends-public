::mods_hookExactClass("entity/tactical/humans/envoy", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		if (this.Math.rand(1, 100) <= 25) {
            this.setGender(1);
		}
	}

	o.getPlaceInFormation = function () {
		return this.m.PlaceInFormation;
	}

	o.assignRandomEquipment = function () {}
});
