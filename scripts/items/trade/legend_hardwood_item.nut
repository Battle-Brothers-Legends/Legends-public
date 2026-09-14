this.legend_hardwood_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},

	function create() {
		this.trading_good_item.create();
		this.m.ID = "misc.legend_hardwood";
		this.m.Name = "Hardwood";
		this.m.Description = "High quality raw product used all over the known world.";
		this.m.Icon = "trade/legend_rough_wood.png";
		this.m.Culture = ::Const.World.Culture.Neutral;
		this.m.ProducingBuildings = [
			"attached_location.lumber_camp"
		];
		this.m.Value = 110;
		this.m.ResourceValue = 1;
	}

	function getBuyPrice() {
		if (this.m.IsSold) {
			return this.getSellPrice();
		}

		if (("State" in this.World) && ::World.State != null && ::World.State.getCurrentTown() != null)
		{
			local isBuildingPresent = ::World.State.getCurrentTown().hasAttachedLocation("attached_location.lumber_camp");
			return ::Math.max(this.getSellPrice(), ::Math.ceil(this.getValue() * this.getPriceMult() * ::World.State.getCurrentTown().getBuyPriceMult() * ::World.State.getCurrentTown().getModifiers().BuildingPriceMult * (isBuildingPresent ? ::Const.World.Assets.BaseBuyPrice : ::Const.World.Assets.BuyPriceNotProducedHere)));
		}

		return this.item.getBuyPrice();
	}

	function getSellPrice() {
		if (this.m.IsBought) {
			return this.getBuyPrice();
		}

		if (("State" in ::World) && ::World.State != null && ::World.State.getCurrentTown() != null) {
			local isBuildingPresent = ::World.State.getCurrentTown().hasAttachedLocation("attached_location.lumber_camp");
			return ::Math.floor(this.getValue() * ::World.State.getCurrentTown().getSellPriceMult() * ::World.State.getCurrentTown().getModifiers().BuildingPriceMult * (isBuildingPresent ? ::Const.World.Assets.BaseSellPrice : ::Const.World.Assets.SellPriceNotProducedHere));
		}

		return this.item.getSellPrice();
	}
});
