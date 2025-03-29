::mods_hookExactClass("entity/world/attached_location/mushroom_grove_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Hidden in the mud and reed, the expert gatherer can find groves and caves full of precious mushrooms like these. Contributes spices, mushrooms, cultists, herbalists, wildmen and their tools to the local town.";
	}

	local onUpdateProduce = o.onUpdateProduce;
	o.onUpdateProduce = function ( _list )
	{
		onUpdateProduce(_list);
		_list.push("trade/legend_cooking_spices_trade_item");
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
				S = "weapons/legend_sickle"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "tents/legend_tent_gather"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "weapons/legend_shovel"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "accessory/berserker_mushrooms_item"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "accessory/legend_apothecary_mushrooms_item"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "weapons/legend_cat_o_nine_tails"
			});
		}

		else if (_id == "building.weaponsmith")
		{
			_list.push({
				R = 30,
				P = 1.0,
				S = "weapons/named/legend_named_sickle"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "weapons/named/legend_named_shovel"
			});
		}
	}
});
