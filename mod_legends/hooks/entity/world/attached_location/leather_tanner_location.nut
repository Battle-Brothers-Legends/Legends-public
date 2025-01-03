::mods_hookExactClass("entity/world/attached_location/leather_tanner_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "This leather tanner\'s workshop produces durable leather pieces from hides. The supply of this leather will increase the availability of light armor in the nearest settlement.";
	}

	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _list )
	{
		_list.push("legend_taxidermist_background");
		_list.push("legend_taxidermist_background");
		_list.push("butcher_background");
		onUpdateDraftList(_list);
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
				S = "weapons/legend_chain"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "tents/legend_tent_hunter"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "tents/legend_tent_craft"
			});
		}
	}
});
