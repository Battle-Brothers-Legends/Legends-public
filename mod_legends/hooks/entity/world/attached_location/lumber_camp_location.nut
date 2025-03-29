::mods_hookExactClass("entity/world/attached_location/lumber_camp_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "This lumber camp is used as a base for lumberjacks on the search for the most precious and durable materials in the nearby woods. Contributes wood, wood products and lumberjacks to the local town";
	}

	local onUpdateProduce = o.onUpdateProduce;
	o.onUpdateProduce = function ( _list )
	{
		onUpdateProduce(_list);
		_list.push("trade/legend_raw_wood_item");
	}

	local onUpdateShopList = o.onUpdateShopList;
	o.onUpdateShopList = function ( _id, _list )
	{
		onUpdateShopList(_id, _list);
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 95,
				P = 1.0,
				S = "weapons/greenskins/goblin_staff"
			});
			_list.push({
				R = 85,
				P = 1.0,
				S = "weapons/legend_mystic_staff"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/legend_wooden_pitchfork"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/legend_wooden_spear"
			});
			_list.push({
				R = 70,
				P = 1.0,
				S = "weapons/legend_ranged_wooden_flail"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "weapons/two_handed_wooden_hammer"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "weapons/two_handed_wooden_flail"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "weapons/legend_staff"
			});
			_list.push({
				R = 95,
				P = 1.0,
				S = "weapons/legend_staff_gnarled"
			});
			_list.push({
				R = 15,
				P = 1.0,
				S = "weapons/legend_saw"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "weapons/legend_infantry_axe"
			});
			_list.push({
				R = 5,
				P = 1.0,
				S = "weapons/legend_wooden_stake"
			});
			_list.push({
				R = 1,
				P = 1.0,
				S = "weapons/wooden_stick"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "trade/legend_raw_wood_item"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "misc/ancient_wood_item"
			});
		}
		else if (_id == "building.weaponsmith" || _id == "building.weaponsmith_oriental")
		{
			_list.push({
				R = 50,
				P = 1.0,
				S = "weapons/throwing_axe"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "weapons/legend_infantry_axe"
			});
		}
		else if (_id == "building.fletcher")
		{
			_list.push({
				R = 98,
				P = 1.0,
				S = "weapons/masterwork_bow"
			});
			_list.push({
				R = 85,
				P = 1.0,
				S = "ammo/legend_huge_quiver_of_arrows"
			});
			_list.push({
				R = 85,
				P = 1.0,
				S = "ammo/legend_huge_quiver_of_bolts"
			});

		}

	}
});
