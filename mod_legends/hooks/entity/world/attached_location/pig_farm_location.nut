::mods_hookExactClass("entity/world/attached_location/pig_farm_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "The smell of this pig farm is just as distinct as the squeeking sounds coming from the muddy pits. The pork chops produced here are usually sold in the nearby settlement.";
	}

	local onUpdateProduce = o.onUpdateProduce;
	o.onUpdateProduce = function ( _list )
	{
		onUpdateProduce(_list);
		_list.push("supplies/legend_fresh_meat_item");
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
				S = "supplies/legend_fresh_meat_item"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/legend_shiv"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/legend_chain"
			});
		}
	}
});
