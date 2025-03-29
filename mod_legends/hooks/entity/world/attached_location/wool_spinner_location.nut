::mods_hookExactClass("entity/world/attached_location/wool_spinner_location", function(o)
{
	local onUpdateProduce = o.onUpdateProduce;
	o.onUpdateProduce = function ( _list )
	{
		onUpdateProduce(_list);
		_list.push("trade/salt_item");
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
				S = "supplies/legend_fresh_milk_item"
			});
			_list.push({
				R = 95,
				P = 1.0,
				S = "tents/legend_tent_heal"
			});
			_list.push({
				R = 95,
				P = 1.0,
				S = "tents/legend_tent_fletcher"
			});
			_list.push({
				R = 95,
				P = 1.0,
				S = "tents/legend_tent_enchant"
			});
			_list.push({
				R = 95,
				P = 1.0,
				S = "tents/legend_tent_craft"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "legend_armor/cloth/legend_tunic_collar_thin"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "legend_armor/cloth/legend_tunic_wrap"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "legend_armor/cloth/legend_tunic_collar_deep"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "legend_armor/cloth/legend_peasant_dress"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "legend_armor/cloth/legend_robes"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "legend_armor/cloth/legend_ancient_cloth_restored"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "legend_armor/cloth/legend_thick_tunic"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "legend_armor/cloth/legend_robes_nun"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "legend_armor/cloth/legend_gambeson"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "legend_armor/cloth/legend_robes_magic"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "legend_armor/cloak/legend_armor_cloak_common"
			});
			_list.push({
				R = 45,
				P = 1.0,
				S = "legend_armor/cloak/legend_sash"
			});
			_list.push({
				R = 45,
				P = 1.0,
				S = "legend_armor/tabard/legend_common_tabard"
			});
		}
		else if (_id == "building.armorsmith")
		{
			_list.push({
				R = 50,
				P = 1.0,
				S = "legend_armor/cloak/legend_armor_cloak_common"
			});
			_list.push({
				R = 95,
				P = 1.0,
				S = "legend_armor/cloak/legend_armor_cloak_noble"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "legend_armor/cloak/legend_armor_cloak_heavy"
			});
			_list.push({
				R = 99,
				P = 2.0,
				S = "legend_armor/named/legend_armor_cloak_rich"
			});
			_list.push({
				R = 45,
				P = 1.0,
				S = "legend_armor/cloak/legend_sash"
			});
			_list.push({
				R = 45,
				P = 1.0,
				S = "legend_armor/tabard/legend_common_tabard"
			});
			_list.push({
				R = 99,
				P = 2.0,
				S = "legend_armor/named/legend_armor_named_tabard"
			});
		}
	}
});
