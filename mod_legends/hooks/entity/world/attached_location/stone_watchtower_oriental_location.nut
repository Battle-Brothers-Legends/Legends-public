::mods_hookExactClass("entity/world/attached_location/stone_watchtower_oriental_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "A stone watchtower occupied by well trained soldiers on guard duty. Contributes soldiers, nomads, shield, weapons and armor to the local town.";
	}

	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _list )
	{
		_list.push("nomad_background");
		_list.push("nomad_background");

		if (this.Math.rand(0, 6) == 1)
			_list.push("legend_conscript_background");
		
		if (this.Math.rand(0, 6) == 1)
			_list.push("legend_conscript_ranged_background");
		
		onUpdateDraftList(_list);
	}

	local onUpdateShopList = o.onUpdateShopList;
	o.onUpdateShopList = function ( _id, _list )
	{
		onUpdateShopList(_id, _list);
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 90,
				P = 1.0,
				S = "tents/legend_tent_train"
			});
				_list.push({
				R = 90,
				P = 1.0,
				S = "tents/legend_tent_scout"
			});
		}
		else if (_id == "building.armorsmith")
		{
			_list.push({
				R = 35,
				P = 1.0,
				S = "legend_armor/tabard/legend_southern_tabard"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "legend_armor/cloak/legend_armor_cloak_common"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "legend_armor/cloak/legend_armor_cloak_heavy"
			});
			_list.push({
				R = 99,
				P = 2.0,
				S = "legend_armor/named/legend_armor_cloak_rich"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "legend_armor/cloak/legend_sash"
			});
			_list.push({
				R = 99,
				P = 2.0,
				S = "legend_armor/named/legend_armor_named_tabard"
			});
		}
	}
});
