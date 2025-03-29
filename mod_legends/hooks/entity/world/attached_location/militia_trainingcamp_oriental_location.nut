::mods_hookExactClass("entity/world/attached_location/militia_trainingcamp_oriental_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "A large compound of militia barracks. This camp will turn ordinary peasants into somewhat able soldiers that can defend their home and their loved ones. Contributes ammo, conscripts and dervish to the local town.";
	}

	o.onUpdateProduce <- function ( _list )
	{
		this.attached_location.onUpdateProduce(_list);
		_list.push("supplies/legend_ammo_small_item");
	}

	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _list )
	{
		_list.push("legend_dervish_background");
		_list.push("legend_dervish_background");

		if (this.Math.rand(0, 4) == 1)
			_list.push("legend_conscript_background");
		
		if (this.Math.rand(0, 4) == 1)
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
				R = 30,
				P = 1.0,
				S = "supplies/legend_ammo_small_item"
			});
				_list.push({
				R = 90,
				P = 1.0,
				S = "tents/legend_tent_fletcher"
			});
		}
		else if (_id == "building.armorsmith")
		{
			_list.push({
				R = 60,
				P = 1.0,
				S = "legend_armor/cloak/legend_armor_cloak_common"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "legend_armor/tabard/legend_southern_tabard"
			});
		}
	}
});
