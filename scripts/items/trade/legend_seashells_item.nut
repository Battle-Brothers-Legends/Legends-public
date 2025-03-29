this.legend_seashells_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = "misc.legend_seashells_shards";
		this.m.Name = "Sea shells";
		this.m.Description = "Pretty sea shells used in cheap necklaces and rings, often collected while looking for amber on beaches. Folks inland will pay something for these";
		this.m.Icon = "trade/inventory_trade_seashells.png";
		this.m.Culture = this.Const.World.Culture.Neutral;
		this.m.ProducingBuildings = [
			"attached_location.amber_collector"
		];
		this.m.Value = 26;
		this.m.ResourceValue = 1;
	}

});

