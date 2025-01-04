::mods_hookExactClass("entity/world/attached_location/dye_maker_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "This dye maker creates precious dies from all kinds of ingredients. The recipes for these expensive goods are well-kept secrets. Contributes dyes, paints and colourful clothes to the local town";
	}

	local onUpdateProduce = o.onUpdateProduce;
	o.onUpdateProduce = function ( _list )
	{
		onUpdateProduce(_list);
		_list.push("trade/dies_item");
	}

	# completely replaced due to my dye renaming shennanigans
	o.onUpdateShopList = function ( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 0,
				P = 1.0,
				S = "trade/dies_item"
			});
		   _list.push({
				R = 0,
				P = 1.0,
				S = "weapons/legend_wooden_pitchfork"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "helmets/jesters_hat"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "helmets/jesters_hat"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "helmets/legend_noble_floppy_hat"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "helmets/legend_noble_hat"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "helmets/legend_noble_hood"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "misc/legend_paint_set_item"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "misc/legend_paint_black_item"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "misc/legend_paint_red_item"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "misc/legend_paint_orange_red_item"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "misc/legend_paint_white_blue_item"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "misc/legend_paint_white_green_yellow_item"
			});
		}
		else if (_id == "building.specialized_trader")
		{
		}
		else if (_id == "building.armorsmith")
		{
			_list.push({
				R = 0,
				P = 1.0,
				S = "helmets/named/jugglers_hat"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "helmets/named/jugglers_padded_hat"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "helmets/named/death_jesters_helm"
			});
		}
	}
});
