::mods_hookExactClass("entity/world/attached_location/silk_farm_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "In these huts the precious silk is spun from cocoons of small insects by secret methods. Contributes silk, daytalers and qiyan to the local town.";
	}

	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _list )
	{
		if (::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled"){
			_list.push("legend_qiyan_background");
			_list.push("legend_qiyan_background");
		}

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
				S = "tents/legend_tent_scrap"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "tents/legend_tent_repair"
			});
		}
	}

	o.getNewResources <- function ()
	{
		return 2;
	}
});
