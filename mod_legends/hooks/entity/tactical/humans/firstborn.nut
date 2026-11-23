::mods_hookExactClass("entity/tactical/humans/firstborn", function (o) {
	o.getPlaceInFormation = function () {
		return this.m.PlaceInFormation;
	}

	o.assignRandomEquipment = function () {}
});
