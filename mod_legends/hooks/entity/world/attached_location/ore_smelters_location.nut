::mods_hookExactClass("entity/world/attached_location/ore_smelters_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "The burning hot ore smelters produce high quality metal ingots used by able weapon smiths to create the most sophisticated of arms. Contributes blacksmiths, ingots and hammers to the local town.";
	}

	o.onUpdateProduce <- function ( _list )
	{
		this.attached_location.onUpdateProduce(_list);
		_list.push("trade/copper_ingots_item");
		_list.push("trade/legend_tin_ingots_item");
		_list.push("trade/legend_silver_ingots_item");
	}

	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _list )
	{
		_list.push("legend_blacksmith_background");
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
				S = "trade/legend_iron_ingots_item"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "trade/copper_ingots_item"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "trade/legend_tin_ingots_item"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "trade/legend_gold_nugget_item"
			});
			_list.push({
				R = 85,
				P = 1.0,
				S = "trade/legend_silver_ingots_item"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/legend_hammer"
			});
		}
		else if (_id == "building.weaponsmith")
		{
			_list.push({
				R = 45,
				P = 1.0,
				S = "weapons/legend_tipstaff"
			});
		}
	}
});
