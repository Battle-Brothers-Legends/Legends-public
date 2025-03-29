this.legend_gem_shards_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = "misc.legend_gem_shards";
		this.m.Name = "Gem Shards";
		this.m.Description = "Rough gemstones too broken to be cut and polished. ";
		this.m.Icon = "trade/inventory_trade_gem_shards.png";
		this.m.Culture = this.Const.World.Culture.Neutral;
		this.m.ProducingBuildings = [
			"attached_location.gem_mine"
		];
		this.m.Value = 50;
		this.m.ResourceValue = 1;
	}

});

