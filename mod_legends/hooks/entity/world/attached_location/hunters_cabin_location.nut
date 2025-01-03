::mods_hookExactClass("entity/world/attached_location/hunters_cabin_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Hunters take shelter in these small huts while on the hunt. Chopped up game, venison and hides hung up to dry in the sun surround the huts. Contributes meat, furs, bows, poachers and hunters to the local town";
	}

	local onUpdateProduce = o.onUpdateProduce;
	o.onUpdateProduce = function ( _list )
	{
		onUpdateProduce(_list);
		_list.push("trade/furs_item");
		_list.push("trade/legend_small_furs_item");
	}

	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _list )
	{
		_list.push("poacher_background");
		_list.push("poacher_background");
		_list.push("legend_taxidermist_background");

		if (this.Math.rand(0, 9) == 1)
			_list.push("legend_master_archer_background");

		// todo delete it - chopeks
//		if(this.LegendsMod.Configs().LegendMagicEnabled())
//		{
//			local r;
//
//			if  ( this.World.Assets.getOrigin().getID() == "scenario.legends_rangers")
//			{
//				r = this.Math.rand(0, 9);
//				if (r == 1)
//				{
//				_list.push("legend_master_archer_background");
//				_list.push("legend_ranger_background");
//				}
//			}
//			else
//			{
//			r = this.Math.rand(0, 9);
//				if (r == 1)
//				{
//				_list.push("legend_master_archer_background");
//				}
//			}
//
//		}
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
				S = "supplies/legend_fresh_meat_item"
			});
			_list.push({
				R = 10,
				P = 1.2,
				S = "supplies/ammo_item"
			});
			_list.push({
				R = 30,
				P = 1.2,
				S = "misc/werewolf_pelt_item"
			});
			_list.push({
				R = 20,
				P = 1.1,
				S = "trade/furs_item"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "weapons/war_bow"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "weapons/greenskins/goblin_bow"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/knife"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "tents/legend_tent_hunter"
			});
		}
	}
});
