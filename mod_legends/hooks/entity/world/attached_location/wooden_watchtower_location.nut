::mods_hookExactClass("entity/world/attached_location/wooden_watchtower_location", function(o) 
{
	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		
		onUpdateDraftList(_list, _gender);
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
				R = 10,
				P = 1.0,
				S = "weapons/legend_sling"
			});
				_list.push({
				R = 50,
				P = 1.0,
				S = "weapons/legend_staff"
			});
			_list.push({
				R = 65,
				P = 1.0,
				S = "shields/legend_tower_shield"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "tents/tent_scout"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "weapons/legend_wooden_spear"
			});
		}
	}

	o.getNewResources <- function ()
	{
		return 0;
	}
});