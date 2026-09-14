::mods_hookExactClass("items/trade/furs_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.ProducingBuildings.push("attached_location.hunters_cabin");
		this.m.ResourceValue = 2;
	}
});