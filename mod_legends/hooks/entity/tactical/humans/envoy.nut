::mods_hookExactClass("entity/tactical/humans/envoy", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		if (this.randomizeHumanGender() == 1) { // this is the envoy used in the contract
			this.setGender(1);
		}
	}

	o.getPlaceInFormation = function () {
		return this.m.PlaceInFormation;
	}

	o.assignRandomEquipment = function () {}
});
