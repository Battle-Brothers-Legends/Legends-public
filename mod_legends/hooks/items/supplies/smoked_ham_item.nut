::mods_hookExactClass("items/supplies/smoked_ham_item", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "Provisions. There are many ways to preserve food. This piece of ham has been treated in a smoking hut.";
		this.m.Value = 90;
		this.m.Amount = 30.0;
		this.m.GoodForDays = 7;
	}
});
