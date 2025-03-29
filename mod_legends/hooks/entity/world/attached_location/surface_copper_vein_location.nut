::mods_hookExactClass("entity/world/attached_location/surface_copper_vein_location", function(o)
{
	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _list )
	{
		 _list.push("legend_ironmonger_background");
		onUpdateDraftList(_list);
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
			_list.push({
				R = 25,
				P = 1.0,
				S = "supplies/legend_armor_parts_small_item"
			});
		}
	}
});
