::mods_hookExactClass("entity/world/attached_location/peat_pit_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "These peat pits produce a valuable fuel source once the peat has been dug up and dried. Contributes peat bricks, daytalers, peddlers and farming tools to the local town";
	}

	local onUpdateProduce = o.onUpdateProduce;
	o.onUpdateProduce = function ( _list )
	{
		onUpdateProduce(_list);
		_list.push("trade/peat_bricks_item");
	}

	local onUpdateShopList = o.onUpdateShopList;
	o.onUpdateShopList = function ( _id, _list )
	{
		onUpdateShopList(_id, _list);
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/legend_hoe"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "weapons/legend_shovel"
			});
		}
	}
});
