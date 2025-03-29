this.legend_gold_ingots_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = "misc.legend_gold_ingots";
		this.m.Name = "Gold Ingots";
		this.m.Description = "Gold smolten and cast into ingots for easy transportation. Traders will pay good coin for this.";
		this.m.Icon = "trade/inventory_trade_gold_bars.png";
		this.m.Culture = this.Const.World.Culture.Neutral;
		this.m.ProducingBuildings = [
			"attached_location.gold_mine"
		];
		this.m.Value = 7200;
		this.m.ResourceValue = 6;
	}

});

