::mods_hookExactClass("entity/world/attached_location/plantation_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "All kinds of wonderous spices and herbs are cultivated in this plantation. A small and rare fruitful spot in the barren desert. Contributes spices, dates and slaves to the nearby town";
	}

	local onUpdateProduce = o.onUpdateProduce;
	o.onUpdateProduce = function ( _list )
	{
		onUpdateProduce(_list);
		_list.push("supplies/legend_medicine_small_item");
	}

	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _list )
	{
		if (::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled")
			_list.push("legend_qiyan_background");
		
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
				S = "supplies/legend_fresh_dates_item"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "tents/legend_tent_heal"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "tents/legend_tent_gather"
			});
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/legend_medicine_small_item"
			});
		}
	}

	o.getNewResources <- function ()
	{
		return 2;
	}
});
