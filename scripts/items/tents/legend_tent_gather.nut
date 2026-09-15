this.legend_tent_gather <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = ::Legends.Camp.Tent.Gather;
		this.m.Name = "Gatherer\'s tools";
		this.m.Description = "A collection of tools for gathering plants, comes with shelves, woven baskets, sickles, drying racks and bags. Having this in your stash upgrades your camp.";
		this.m.Icon = "tents/tent_gather_70x70.png";
		this.m.Value = 3000;
	}

	function getBuyPrice()
	{
		if (this.m.IsSold)
		{
			return this.getSellPrice();
		}

		if (("State" in ::World) && ::World.State != null && ::World.State.getCurrentTown() != null)
		{
			local isBuildingPresent = ::World.State.getCurrentTown().hasAttachedLocation("attached_location.gatherers_hut");
			return ::Math.max(this.getSellPrice(), ::Math.ceil(this.getValue() * this.getPriceMult() * ::World.State.getCurrentTown().getBuyPriceMult() * (isBuildingPresent ? ::Const.World.Assets.BaseBuyPrice : ::Const.World.Assets.BuyPriceNotProducedHere)));
		}

		return this.item.getBuyPrice();
	}

	function getSellPrice()
	{
		if (this.m.IsBought)
		{
			return this.getBuyPrice();
		}

		if (("State" in ::World) && ::World.State != null && ::World.State.getCurrentTown() != null)
		{
			local isBuildingPresent = ::World.State.getCurrentTown().hasAttachedLocation("attached_location.gatherers_hut");
			return ::Math.floor(this.item.getSellPrice() * (isBuildingPresent ? ::Const.World.Assets.BaseSellPrice : ::Const.World.Assets.SellPriceNotProducedHere));
		}

		return this.item.getSellPrice();
	}

});

