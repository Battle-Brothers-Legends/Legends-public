::mods_hookExactClass("entity/world/attached_location/brewery_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "This brewery produces large quantities of beer for both local taverns and traders. Contributes beer, brawlers, monks and gamblers to the local town";
	}

	local onUpdateProduce = o.onUpdateProduce;
	o.onUpdateProduce = function ( _list )
	{
		onUpdateProduce(_list);
		_list.push("supplies/beer_item");
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
				S = "supplies/beer_item"
			});
		}
	}
});
