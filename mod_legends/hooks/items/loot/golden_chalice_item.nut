::mods_hookExactClass("items/loot/golden_chalice_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "A drinking cup made from glinting gold. Should be worth a lot if you can find a buyer.";
	}
});
