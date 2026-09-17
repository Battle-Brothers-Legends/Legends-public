::mods_hookExactClass("items/supplies/cured_venison_item", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "Provisions. A cured chunk of venison preserved by salt. Fine food for a travelling sellsword.";
		this.m.Value = 100;
		this.m.Amount = 30.0;
		this.m.GoodForDays = 8;
	}
});
