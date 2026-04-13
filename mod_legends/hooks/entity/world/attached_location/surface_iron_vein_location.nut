::mods_hookExactClass("entity/world/attached_location/surface_iron_vein_location", function(o)
{
	o.onUpdateProduce <- function ( _list )
	{
		this.attached_location.onUpdateProduce(_list);
		_list.push("trade/legend_iron_ingots_item");
	}

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
				R = 0,
				P = 1.0,
				S = "weapons/pickaxe"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "trade/legend_iron_ingots_item"
			});
		}
		else if (_id == "building.weaponsmith")
		{
			_list.push({
				R = 60,
				P = 1.0,
				S = "weapons/legend_tipstaff"
			});
			_list.push({
				R = 97,
				P = 1.0,
				S = "trade/legend_silver_ingots_item"
			});
		}
	}
});
