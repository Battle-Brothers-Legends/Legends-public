::mods_hookExactClass("entity/world/attached_location/stone_watchtower_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "A stone watchtower occupied by well trained soldiers on guard duty. Contributes soldiers, shield, weapons and armor to the local town.";
	}

	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _list )
	{
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
				R = 65,
				P = 1.0,
				S = "shields/legend_tower_shield"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "weapons/legend_tipstaff"
			});
				_list.push({
				R = 50,
				P = 1.0,
				S = "weapons/legend_northern_sling"
			});
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
				R = 90,
				P = 1.0,
				S = "tents/legend_tent_train"
			});
				_list.push({
				R = 90,
				P = 1.0,
				S = "tents/legend_tent_scout"
			});
			_list.push({
				R = 45,
				P = 1.0,
				S = "legend_armor/tabard/legend_common_tabard"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "legend_helmets/vanity/legend_helmet_faction_helmet"
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
