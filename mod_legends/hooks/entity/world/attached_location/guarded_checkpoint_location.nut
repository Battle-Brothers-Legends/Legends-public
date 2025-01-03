::mods_hookExactClass("entity/world/attached_location/guarded_checkpoint_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "A road checkpoint manned by professional soldiers. Contributes military weapons, armor and soldiers to the local town.";
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
				_list.push({
				R = 80,
				P = 1.0,
				S = "tents/legend_tent_scout"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "weapons/legend_tipstaff"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "weapons/legend_northern_sling"
			});
		}
	}

	o.getNewResources <- function ()
	{
		return 0;
	}
});
