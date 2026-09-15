this.legend_cured_rations_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},

	function create() {
		this.food_item.create();
		this.m.ID = "supplies.legend_cured_rations";
		this.m.Name = "Poorly Cured Rations";
		this.m.Description = "These rations have been hastily made for the purpose of survival, not taste. They will serve the same purpose but are unlikely to get much of a price at a market. Can be eaten in battle to provide up to 5 healing and fatigue recovery over ten turns, based on the amount remaining. Will be used as provisions if left in the company stash.";
		this.m.Icon = "supplies/inventory_provisions_16.png";
		this.m.Value = 75;
		this.m.Amount = 50.0;
		this.m.GoodForDays = 14;
	}

	function getBuyPrice() {
		if (this.m.IsSold) {
			return this.getSellPrice();
		}

		if (("State" in ::World) && ::World.State != null && ::World.State.getCurrentTown() != null) {
			local isBuildingPresent = false;
			return ::Math.max(this.getSellPrice(), ::Math.ceil(this.getValue() * this.getPriceMult() * ::World.State.getCurrentTown().getFoodPriceMult() * ::World.State.getCurrentTown().getBuyPriceMult() * (isBuildingPresent ? ::Const.World.Assets.BaseBuyPrice : ::Const.World.Assets.BuyPriceNotProducedHere)));
		}

		return this.item.getBuyPrice();
	}

	function getSellPrice() {
		if (this.m.IsBought) {
			return this.getBuyPrice();
		}

		if (("State" in ::World) && ::World.State != null && ::World.State.getCurrentTown() != null) {
			local isBuildingPresent = false;
			return ::Math.floor(this.getValue() * ::World.State.getCurrentTown().getFoodPriceMult() * ::World.State.getCurrentTown().getSellPriceMult() * (isBuildingPresent
				? ::Const.World.Assets.BaseSellPrice
				: ::Const.World.Assets.SellPriceNotProducedHere));
		}

		return this.item.getSellPrice();
	}
});
