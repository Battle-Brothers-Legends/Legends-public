::mods_hookExactClass("items/supplies/fermented_unhold_heart_item", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "Provisions. Once a delicacy for barbarian kings of the north who wished to embolden their virility, fermented unhold heart tastes distinctively awful.";
		this.m.IsUndesirable = true;
		this.m.Amount = 40.0;
	}
});
