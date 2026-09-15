this.legend_tent_scout <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = ::Legends.Camp.Tent.Scout;
		this.m.Name = "Scout\'s station";
		this.m.Description = "A station for organising scouting parties, comes with maps, compasses and spyglasses. Having this in your stash upgrades your camp.";
		this.m.Icon = "tents/tent_scout_70x70.png";
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
			local isBuildingPresent = ::World.State.getCurrentTown().hasAttachedLocation("attached_location.wooden_watchtower");
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
			local isBuildingPresent = ::World.State.getCurrentTown().hasAttachedLocation("attached_location.wooden_watchtower");
			return ::Math.floor(this.item.getSellPrice() * (isBuildingPresent ? ::Const.World.Assets.BaseSellPrice : ::Const.World.Assets.SellPriceNotProducedHere));
		}

		return this.item.getSellPrice();
	}

});
