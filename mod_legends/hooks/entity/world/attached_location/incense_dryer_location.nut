::mods_hookExactClass("entity/world/attached_location/incense_dryer_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Tree sap is gathered from the surrounding trees and dried in the sun to create valuable incense. Contributes incense, spices, medicine and daytalers to the local town";
	}

	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _list )
	{
		_list.push("legend_dervish_background");
		_list.push("legend_alchemist_background");
		onUpdateDraftList(_list);
	}

	local onUpdateShopList = o.onUpdateShopList;
	o.onUpdateShopList = function ( _id, _list )
	{
		onUpdateShopList(_id, _list);
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 0,
				P = 1.0,
				S = "trade/legend_cooking_spices_trade_item"
			});
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/legend_armor_parts_small_item"
			});
			_list.push({
				R = 95,
				P = 1.0,
				S = "tents/legend_tent_enchant"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "tents/legend_tent_craft"
			});
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/legend_medicine_small_item"
			});
		}
	}
});
