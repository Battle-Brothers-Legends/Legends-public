this.legend_silver_ingots_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = "misc.legend_silver_ingots";
		this.m.Name = "Silver Ingots";
		this.m.Description = "Silver smolten and cast into ingots for easy transportation. Traders will pay good coin for this.";
		this.m.Icon = "trade/inventory_trade_silver_bars.png";
		this.m.Culture = this.Const.World.Culture.Neutral;
		this.m.ProducingBuildings = [
			"attached_location.gold_mine",
			"attached_location.surface_iron_vein"
		];
		this.m.Value = 1800;
		this.m.ResourceValue = 3;
	}

});


