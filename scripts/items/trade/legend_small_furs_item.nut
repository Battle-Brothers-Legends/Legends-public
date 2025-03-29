this.legend_small_furs_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = "misc.furs";
		this.m.Name = "Fur Scraps";
		this.m.Description = "Furs from small wild animals, and offcuts from larger skins";
		this.m.Icon = "trade/inventory_trade_small_furs.png";
		this.m.Culture = this.Const.World.Culture.Northern;
		this.m.ProducingBuildings = [
			"attached_location.trapper"
		];
		this.m.Value = 30;
		this.m.ResourceValue = 2;
	}

});

