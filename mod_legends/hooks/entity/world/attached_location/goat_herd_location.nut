::mods_hookExactClass("entity/world/attached_location/goat_herd_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "The goats held here are mainly used for their milk which is then turned into cheese to make it more durable. Contributes cheese, staves, slings, shepherds, farmhands and butchers to the local town.";
	}

	local onUpdateProduce = o.onUpdateProduce;
	o.onUpdateProduce = function ( _list )
	{
		onUpdateProduce(_list);
		_list.push("supplies/legend_fresh_milk_item");
	}
	
	local onUpdateShopList = o.onUpdateShopList;
	o.onUpdateShopList = function ( _id, _list )
	{
		onUpdateShopList(_id, _list);
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/goat_cheese_item"
			});
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/goat_cheese_item"
			});
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/legend_fresh_milk_item"
			});
			_list.push({
				R = 0,
				P = 1.0,
				S = "weapons/legend_dilapitated_sling"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "weapons/legend_sturdy_sling"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/legend_staff"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "weapons/legend_tipstaff"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "weapons/legend_northern_sling"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "armor/leather_tunic"
			});
		}
	}
});
