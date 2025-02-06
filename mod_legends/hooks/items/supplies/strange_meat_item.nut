::mods_hookExactClass("items/supplies/strange_meat_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Provisions. Meat of indefinable origin. Eating this may seem risky, but is preferable to starving.";
		this.m.Value = 20;
		this.m.Amount = 15.0;
		this.m.GoodForDays = 4;
	}
});