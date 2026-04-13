::mods_hookExactClass("entity/world/attached_location/gold_mine_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "A deep mine built atop a gold ore vein. This rare metal has a tendency to bring out the worst in people. Contributes gold and silver ingots, miners, caravan hands, sellswords and thieves to the local town";
	}

	o.onUpdateProduce <- function ( _list )
	{
		this.attached_location.onUpdateProduce(_list);
		_list.push("trade/legend_gold_dust_item");
		_list.push("trade/legend_gold_nugget_item");
		_list.push("trade/legend_silver_ingots_item");
	}

	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _list )
	{
		_list.push("legend_ironmonger_background");
		_list.push("peddler_background");
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
				S = "weapons/legend_hammer"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "trade/legend_gold_nugget_item"
			});
			_list.push({
				R = 0,
				P = 1.0,
				S = "trade/legend_gold_dust_item"
			});
			_list.push({
				R = 95,
				P = 1.0,
				S = "trade/legend_gold_ingots_item"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "loot/golden_chalice_item"
			});
			_list.push({
				R = 94,
				P = 1.0,
				S = "trade/legend_silver_ingots_item"
			});
		}
	}

	o.getNewResources <- function ()
	{
		return 2;
	}
});
