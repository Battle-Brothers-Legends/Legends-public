::mods_hookExactClass("entity/world/attached_location/gatherers_hut_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Even in sparse environments an experienced gatherer can find berries, roots and other edible things. Although not the most delicious, it can still keep a man fed. Contributes roots, berries, spices, sickles, puddings, herbalists and daytalers to the local town";
	}

	local onUpdateProduce = o.onUpdateProduce;
	o.onUpdateProduce = function ( _list )
	{
		onUpdateProduce(_list);
		_list.push("trade/legend_cooking_spices_trade_item");
	}

	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _list )
	{
		_list.push("legend_herbalist_background");
		_list.push("legend_herbalist_background");
		_list.push("daytaler_background");
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
				S = "trade/legend_cooking_spices_trade_item"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "misc/legend_mistletoe_item"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "supplies/legend_pudding_item"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/legend_sickle"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "tents/legend_tent_gather"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "tents/legend_tent_heal"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "supplies/legend_medicine_small_item"
			});
		}
		else if (_id == "building.weaponsmith")
		{
			_list.push({
				R = 99,
				P = 1.0,
				S = "weapons/named/legend_named_sickle"
			});
			_list.push({
				R = 99,
				P = 1.0,
				S = "weapons/named/legend_named_shovel"
			});
		}
	}
});
