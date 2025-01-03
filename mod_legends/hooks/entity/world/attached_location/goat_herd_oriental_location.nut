::mods_hookExactClass("entity/world/attached_location/goat_herd_oriental_location", function(o)
{
	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _list )
	{
		onUpdateDraftList(_list);
		_list.push("legend_muladi_background");
		_list.push("legend_muladi_background");
	}

	local onUpdateShopList = o.onUpdateShopList;
	o.onUpdateShopList = function ( _id, _list )
	{
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
				S = "supplies/dried_lamb_item"
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
				R = 70,
				P = 1.0,
				S = "supplies/legend_curry_item"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "weapons/legend_northern_sling"
			});
				_list.push({
				R = 90,
				P = 1.0,
				S = "tents/legend_tent_hunter"
			});
		}
	}
});
