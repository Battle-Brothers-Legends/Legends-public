::mods_hookExactClass("entity/world/attached_location/fletchers_hut_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "The arrow makers in these sheds produce all kinds of ranged ammunition which they then sell at the nearest settlement. Contributes bows, crossbows, arrows, bolts, bowyers and archers to the local town";
	}

	local onUpdateProduce = o.onUpdateProduce;
	o.onUpdateProduce = function ( _list )
	{
		onUpdateProduce(_list);
		_list.push("supplies/legend_ammo_small_item");
		_list.push("supplies/legend_ammo_small_item");
		_list.push("supplies/ammo_item");
	}

	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _list )
	{
		_list.push("hunter_background");
		_list.push("poacher_background");
		onUpdateDraftList(_list);
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
				S = "weapons/legend_saw"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "ammo/legend_armor_piercing_arrows"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "ammo/legend_armor_piercing_bolts"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "ammo/legend_broad_head_arrows"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "ammo/legend_broad_head_bolts"
			});
		}
		else if (_id == "building.fletcher")
		{
			_list.push({
				R = 20,
				P = 1.0,
				S = "weapons/legend_dilapitated_sling"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "weapons/legend_sturdy_sling"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "ammo/legend_huge_quiver_of_arrows"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "ammo/legend_huge_quiver_of_bolts"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "ammo/legend_large_armor_piercing_arrows"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "ammo/legend_large_armor_piercing_bolts"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "ammo/legend_large_broad_head_arrows"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "ammo/legend_large_broad_head_bolts"
			});
		}
		else if (_id == "building.weaponsmith")
		{
			_list.push({
				R = 50,
				P = 1.0,
				S = "weapons/war_bow"
			});
			_list.push({
				R = 99,
				P = 3.0,
				S = "weapons/legend_hand_crossbow"
			});
		}
	}
});
