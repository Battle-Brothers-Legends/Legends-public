::mods_hookExactClass("entity/world/attached_location/salt_mine_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "A mine in which precious rock salt is extracted and shipped off to only the most trustworthy traders. Contributes salt, pickaxes and miners to the local town";
	}

	local onUpdateProduce = o.onUpdateProduce;
	o.onUpdateProduce = function ( _list )
	{
		onUpdateProduce(_list);
		_list.push("trade/salt_item");
	}

	local onUpdateShopList = o.onUpdateShopList;
	o.onUpdateShopList = function ( _id, _list )
	{
		onUpdateShopList(_id, _list);
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 20,
				P = 1.0,
				S = "weapons/legend_hammer"
			});
		}
	}
});
