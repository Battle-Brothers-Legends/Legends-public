this.legend_iron_ingots_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = "misc.legend_iron_ingots";
		this.m.Name = "Iron Ingots";
		this.m.Description = "Iron smolten and cast into ingots for easy transportation. Traders will pay good coin for this.";
		this.m.Icon = "trade/inventory_trade_iron_bars.png";
		this.m.Culture = this.Const.World.Culture.Neutral;
		this.m.ProducingBuildings = [
			"attached_location.surface_iron_vein"
		];
		this.m.Value = 300;
		this.m.ResourceValue = 1;
	}

});

