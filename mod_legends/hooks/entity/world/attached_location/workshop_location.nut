::mods_hookExactClass("entity/world/attached_location/workshop_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "The workshop is proficient in making all kinds of tools and other supplies needed to keep carts and machines working. Contributes armor parts, ironmongers and blacksmiths to the local town";
	}

	local onUpdateProduce = o.onUpdateProduce;
	o.onUpdateProduce = function ( _list )
	{
		onUpdateProduce(_list);
		_list.push("supplies/legend_armor_parts_small_item");
		_list.push("supplies/armor_parts_item");
		_list.push("supplies/legend_armor_parts_small_item");
	}

	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _list )
	{
		_list.push("legend_ironmonger_background");
		_list.push("legend_ironmonger_background");
		_list.push("legend_ironmonger_background");
		_list.push("legend_ironmonger_background");
		_list.push("legend_blacksmith_background");
		_list.push("legend_blacksmith_background");
		onUpdateDraftList(_list);
	}

	local onUpdateShopList = o.onUpdateShopList;
	o.onUpdateShopList = function ( _id, _list )
	{
		onUpdateShopList(_id, _list);
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/legend_saw"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/legend_hammer"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "supplies/legend_armor_parts_small_item"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "supplies/legend_armor_parts_small_item"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "supplies/armor_parts_item"
			});
		}
		else if (_id == "building.weaponsmith")
		{
			_list.push({
				R = 95,
				P = 1.0,
				S = "weapons/named/legend_named_blacksmith_hammer"
			});
		}
	}
});
