::mods_hookExactClass("entity/world/attached_location/beekeeper_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Surrounded by humming bees, these small huts are home to beekeepers. The honey they produce is a precious ingredient to sweeten pastries and other foods. Contributes mead and farmhands to the local town";
	}

	local onUpdateProduce = o.onUpdateProduce;
	o.onUpdateProduce = function ( _list )
	{
		onUpdateProduce(_list);
		_list.push("supplies/mead_item");
		_list.push("trade/legend_wax_item");
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
				S = "trade/legend_wax_item"
			});
		}
	}
});
