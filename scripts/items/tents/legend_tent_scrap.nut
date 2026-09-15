this.legend_tent_scrap <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = ::Legends.Camp.Tent.Scrap;
		this.m.Name = "Scrap Tent";
		this.m.Description = "One mercenary\'s trash is another\'s treasure. This collection of spare parts will help you turn broken armor and weapons into usable armor scraps and tools. Having this in your stash upgrades your camp.";
		this.m.Icon = "tents/tent_scrap_70x70.png";
		this.m.Value = 2000;
	}

	function getBuyPrice()
	{
		if (this.m.IsSold)
		{
			return this.getSellPrice();
		}

		if (("State" in ::World) && ::World.State != null && ::World.State.getCurrentTown() != null)
		{
			local isBuildingPresent = ::World.State.getCurrentTown().hasAttachedLocation("attached_location.ore_smelters");
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
			local isBuildingPresent = ::World.State.getCurrentTown().hasAttachedLocation("attached_location.ore_smelters");
			return ::Math.floor(this.item.getSellPrice() * (isBuildingPresent ? ::Const.World.Assets.BaseSellPrice : ::Const.World.Assets.SellPriceNotProducedHere));
		}

		return this.item.getSellPrice();
	}

});
