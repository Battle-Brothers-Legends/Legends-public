::mods_hookExactClass("entity/world/attached_location/orchard_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Dense rows of trees with ripe fruit frame a small warehouse where everything is stored until offered on local markets. Contributes fruit, blades and laborers to the local town.";
	}

	local onUpdateProduce = o.onUpdateProduce;
	o.onUpdateProduce = function ( _list )
	{
		onUpdateProduce(_list);
		_list.push("supplies/legend_fresh_fruit_item");
	}

	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _list )
	{
		_list.push("daytaler_background");
		_list.push("farmhand_background");
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
				P = 0.9,
				S = "supplies/legend_fresh_fruit_item"
			});
			_list.push({
				R = 0,
				P = 0.9,
				S = "supplies/legend_fresh_fruit_item"
			});
			_list.push({
				R = 10,
				P = 0.9,
				S = "supplies/legend_pie_item"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "weapons/legend_shiv"
			});
				_list.push({
				R = 30,
				P = 1.0,
				S = "weapons/legend_sickle"
			});
		}
	}
});
