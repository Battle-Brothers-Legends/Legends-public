::mods_hookExactClass("entity/world/attached_location/fortified_outpost_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Large barracks housing a host of professional soldiers. Contributes military weapons, armor, soldiers and knights to the local town";
	}

	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _list )
	{
		_list.push("legend_blacksmith_background");
		_list.push("legend_ironmonger_background");

		if (this.Math.rand(0, 9) == 1)
			_list.push("legend_master_archer_background");

		if (this.Math.rand(0, 9) == 1)
			_list.push("legend_noble_shield");
		
		if (this.Math.rand(0, 9) == 1)
			_list.push("legend_noble_2h");
		
		if (this.Math.rand(0, 9) == 1)
			_list.push("legend_noble_ranged");
		
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
				R = 80,
				P = 1.0,
				S = "tents/legend_tent_train"
			});
		}
		else if (_id == "building.weaponsmith")
		{
			_list.push({
				R = 20,
				P = 1.0,
				S = "weapons/legend_infantry_axe"
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
				R = 45,
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

	o.getNewResources <- function () {
		return 0;
	}
});
