::mods_hookExactClass("entity/world/attached_location/wheat_fields_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Golden wheat can be seen glistening in the sun from afar. Many people from the nearby settlement work here. Contributes bread, grains, poridge, farmhands, daytalers, millers and bakers to the local town.";
	}

	local onUpdateProduce = o.onUpdateProduce;
	o.onUpdateProduce = function ( _list )
	{
		onUpdateProduce(_list);
		_list.push("supplies/ground_grains_item");
	}

	local onUpdateShopList = o.onUpdateShopList;
	o.onUpdateShopList = function ( _id, _list )
	{
		onUpdateShopList(_id, _list);
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 1,
				P = 1.0,
				S = "supplies/ground_grains_item"
			});
			_list.push({
				R = 5,
				P = 1.0,
				S = "supplies/legend_porridge_item"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/legend_wooden_pitchfork"
			});
			_list.push({
				R = 25,
				P = 1.0,
				S = "weapons/legend_scythe"
			});
		}
	}

	o.getNewResources <- function ()
	{
		return 2;
	}
});
