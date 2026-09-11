this.legend_gold_ore_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = "misc.gold_nugget";
		this.m.Name = "Gold Ore";
		this.m.Description = "A sizeable nugget of gold, traders will pay good coin for this.";
		this.m.Icon = "trade/inventory_trade_gold_nugget.png";
		this.m.Culture = ::Const.World.Culture.Neutral;
		this.m.ProducingBuildings = [
			"attached_location.gold_mine"
		];
		this.m.Value = 720;
		this.m.ResourceValue = 3;
	}

});

