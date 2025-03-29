::mods_hookExactClass("entity/world/attached_location/trapper_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Small huts provide shelter for the trappers living here and setting traps for animals with valuable furs. Contributes furs, meat and poachers to the town";
	}

	local onUpdateProduce = o.onUpdateProduce;
	o.onUpdateProduce = function ( _list )
	{
		onUpdateProduce(_list);
		_list.push("trade/legend_small_furs_item");
	}

	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _list )
	{
		_list.push("poacher_background");
		onUpdateDraftList(_list);
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
				S = "trade/legend_small_furs_item"
			});
			_list.push({
				R = 0,
				P = 1.1,
				S = "supplies/legend_fresh_meat_item"
			});
			_list.push({
				R = 0,
				P = 1.1,
				S = "supplies/cured_venison_item"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "weapons/legend_shiv"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/legend_wooden_stake"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "tools/throwing_net"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "tents/legend_tent_hunter"
			});
				_list.push({
				R = 30,
				P = 1.0,
				S = "weapons/legend_chain"
			});
		}
	}
});
