::mods_hookExactClass("entity/tactical/humans/envoy", function (o) {
	// this is the envoy used in the contract
	o.getPlaceInFormation = function () {
		return this.m.PlaceInFormation;
	}

	o.assignRandomEquipment = function () {}
});
