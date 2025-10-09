::mods_hookExactClass("entity/world/attached_location/blast_furnace_location", function(o)
{
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
				R = 25,
				P = 1.0,
				S = "supplies/armor_parts_item"
			});
		}
		else if (_id == "building.armorsmith")
		{
			_list.push({
				R = 90,
				P = 1.0,
				S = "helmets/legend_helm_breathed"
			});
			_list.push({
				R = 95,
				P = 1.0,
				S = "helmets/legend_helm_full"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "helmets/legend_helm_point"
			});
			_list.push({
				R = 85,
				P = 1.0,
				S = "helmets/legend_helm_snub"
			});
			_list.push({
				R = 95,
				P = 1.0,
				S = "helmets/legend_helm_wings"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "helmets/legend_helm_curved"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "helmets/legend_helm_sharp"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "helmets/great_jaw_helmet_00"
			});
		}
	}
});
