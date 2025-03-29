::mods_hookExactClass("items/supplies/pickled_mushrooms_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Provisions. Swampy regions offer little food, but pickled mushrooms are a favoured provision for travelers in these areas.";
		this.m.Amount = 25.0;
	}
});
