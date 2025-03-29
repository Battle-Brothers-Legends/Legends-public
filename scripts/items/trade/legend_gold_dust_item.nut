this.legend_gold_dust_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = "misc.gold_dust";
		this.m.Name = "Gold Dust";
		this.m.Description = "A small pile of gold dust used for decoration or smelting, worth something to the right buyer";
		this.m.Icon = "trade/inventory_trade_gold_dust.png";
		this.m.Culture = this.Const.World.Culture.Neutral;
		this.m.ProducingBuildings = [
			"attached_location.gold_mine"
		];
		this.m.Value = 72;
		this.m.ResourceValue = 3;
	}

});

