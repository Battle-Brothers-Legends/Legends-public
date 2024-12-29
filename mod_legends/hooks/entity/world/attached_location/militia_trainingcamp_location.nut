::mods_hookExactClass("entity/world/attached_location/militia_trainingcamp_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "A large compound of militia barracks. This camp will turn ordinary peasants into somewhat able soldiers that can defend their home and their loved ones. Contributes weapons, armor and militia to the local town.";
	}

	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _list )
	{
		_list.push("militia_background");
		_list.push("militia_background");
		_list.push("retired_soldier_background");
		onUpdateDraftList(_list);
	}

	local onUpdateShopList = o.onUpdateShopList;
	o.onUpdateShopList = function ( _id, _list )
	{
		onUpdateShopList(_id, _list);
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 50,
				P = 1.0,
				S = "armor/basic_mail_shirt"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "tents/legend_tent_train"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "tents/legend_tent_scout"
			});
			_list.push({
				R = 65,
				P = 1.0,
				S = "shields/legend_tower_shield"
			});
		}
		else if (_id == "building.weaponsmith")
		{
			_list.push({
				R = 70,
				P = 1.0,
				S = "weapons/legend_infantry_axe"
			});
			_list.push({
				R = 70,
				P = 1.0,
				S = "weapons/fighting_spear"
			});
		}
		else if (_id == "building.armorsmith")
		{
			_list.push({
				R = 30,
				P = 1.0,
				S = "armor/basic_mail_shirt"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "legend_armor/cloak/legend_armor_cloak_common"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "legend_armor/cloak/legend_armor_cloak_heavy"
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
	}

	o.getNewResources <- function ()
	{
		return 0;
	}
});
