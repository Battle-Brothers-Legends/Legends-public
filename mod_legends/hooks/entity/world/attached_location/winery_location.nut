::mods_hookExactClass("entity/world/attached_location/winery_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Golden wheat can be seen glistening in the sun from afar. Many people from the nearby settlement work here. Contributes bread, grains, poridge, farmhands, daytalers, millers and bakers to the local town.";
	}

	local onUpdateProduce = o.onUpdateProduce;
	o.onUpdateProduce = function ( _list )
	{
		onUpdateProduce(_list);
		_list.push("supplies/legend_fresh_fruit_item");
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
				S = "supplies/legend_fresh_fruit_item"
			});
				_list.push({
				R = 10,
				P = 1.0,
				S = "supplies/roots_and_berries_item"
			});
				_list.push({
				R = 20,
				P = 1.0,
				S = "weapons/legend_sickle"
			});
		}
	}
});
