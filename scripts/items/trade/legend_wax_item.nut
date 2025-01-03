this.legend_wax_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = "misc.wax";
		this.m.Name = "Wax";
		this.m.Description = "Beeswax has a variety of uses in food preservation and candle making. Traders will pay good coin for this.";
		this.m.Icon = "supplies/legend_wax.png"; // credit to Evie
		this.m.Culture = this.Const.World.Culture.Neutral;
		this.m.ProducingBuildings = [
			"attached_location.beekeeper"
		];
		this.m.Value = 33;
		this.m.ResourceValue = 1;
	}

	function getSellPriceMult()
	{
		return this.World.State.getCurrentTown().getModifiers().BuildingPriceMult;
	}

	function getBuyPriceMult()
	{
		return this.World.State.getCurrentTown().getModifiers().BuildingPriceMult;
	}

});

