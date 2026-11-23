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

		if (::FU.GetTown() != null)
		{
			local isBuildingPresent = ::FU.GetTown().hasAttachedLocation("attached_location.wooden_watchtower");
			return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.getPriceMult() * ::FU.GetTown().getBuyPriceMult() * (isBuildingPresent ? this.Const.World.Assets.BaseBuyPrice : this.Const.World.Assets.BuyPriceNotProducedHere)));
		}

		return this.item.getBuyPrice();
	}

	function getSellPrice()
	{
		if (this.m.IsBought)
		{
			return this.getBuyPrice();
		}

		if (::FU.GetTown() != null)
		{
			local isBuildingPresent = ::FU.GetTown().hasAttachedLocation("attached_location.wooden_watchtower");
			return this.Math.floor(this.item.getSellPrice() * (isBuildingPresent ? this.Const.World.Assets.BaseSellPrice : this.Const.World.Assets.SellPriceNotProducedHere));
		}

		return this.item.getSellPrice();
	}

});
