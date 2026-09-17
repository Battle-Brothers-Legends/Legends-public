this.legend_crab_meat_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},

	function create() {
		this.food_item.create();
		this.m.ID = "supplies.legend_crab_meat";
		this.m.Name = "Crab";
		this.m.Description = "Provisions. Strange shelled fish with eight legs and a pair of claws. Tough but tasty once cooked.";
		this.m.Icon = "supplies/legend_crab_meat.png";
		this.m.Amount = 15;
		this.m.Value = 30;
		this.m.GoodForDays = 1;
		this.m.IsUndesirable = false;
	}

	function getBuyPrice() {
		if (this.m.IsSold) {
			return this.getSellPrice();
		}

		if (("State" in ::World) && ::World.State != null && ::World.State.getCurrentTown() != null) {
			return ::Math.max(this.getSellPrice(), ::Math.ceil(this.getValue() * this.getPriceMult() * ::World.State.getCurrentTown().getFoodPriceMult() * ::World.State.getCurrentTown().getBuyPriceMult()));
		}

		return this.item.getBuyPrice();
	}

	function getSellPrice() {
		if (this.m.IsBought) {
			return this.getBuyPrice();
		}

		if (("State" in ::World) && ::World.State != null && ::World.State.getCurrentTown() != null) {
			return ::Math.floor(this.getValue() * ::World.State.getCurrentTown().getFoodPriceMult() * ::World.State.getCurrentTown().getSellPriceMult());
		}

		return this.item.getSellPrice();
	}
});
