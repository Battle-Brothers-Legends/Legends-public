::mods_hookExactClass("entity/world/attached_location/amber_collector_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "The collectors living in these huts search for valuable amber shards along the shore.";
	}

	local onUpdateProduce = o.onUpdateProduce;
	o.onUpdateProduce = function ( _list )
	{
		onUpdateProduce(_list);
		_list.push("trade/legend_seashells_item");
	}

	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _list )
	{
		onUpdateDraftList(_list);

		_list.push("peddler_background");
		_list.push("caravan_hand_background");
		_list.push("thief_background");
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
				S = "trade/legend_seashells_item"
			});
			_list.push({
				R = 95,
				P = 1.0,
				S = "tents/legend_tent_enchant"
			});
		}
	}
});
