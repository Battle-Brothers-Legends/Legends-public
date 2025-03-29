::mods_hookExactClass("entity/world/attached_location/gem_mine_location", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "The shiny gems found in this mine are usually brought directly to the next settlement in well-guarded caravans for further refinement. Contributes gems, miners, pickaxes, sellswords, caravan hands and thieves to the local town.";
	}

	local onUpdateProduce = o.onUpdateProduce;
	o.onUpdateProduce = function ( _list )
	{
		onUpdateProduce(_list);
		_list.push("trade/legend_gem_shards_item");
	}

	local onUpdateShopList = o.onUpdateShopList;
	o.onUpdateShopList = function ( _id, _list )
	{
		onUpdateShopList(_id, _list);
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 20,
				P = 1.0,
				S = "weapons/pickaxe"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "tents/legend_tent_enchant"
			});
			_list.push({
				R = 30,
				P = 1.1,
				S = "loot/gemstones_item"
			});
			_list.push({
				R = 80,
				P = 1.2,
				S = "loot/glittering_rock_item"
			});
			_list.push({
				R = 95,
				P = 1.3,
				S = "loot/jeweled_crown_item"
			});
			_list.push({
				R = 95,
				P = 1.3,
				S = "loot/signet_ring_item"
			});
		}
	}

	o.getNewResources <- function ()
	{
		return 2;
	}
});
