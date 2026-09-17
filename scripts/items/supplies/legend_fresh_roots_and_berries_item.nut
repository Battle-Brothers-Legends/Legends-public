this.legend_fresh_roots_and_berries_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},

	function create() {
		this.food_item.create();
		this.m.ID = "supplies.legend_fresh_roots_and_berries";
		this.m.Name = "Fresh Roots and Berries";
		this.m.Description = "Provisions. Fresh roots and berries are easy to find and fairly common, but require preservation to last longer.";
		this.m.Icon = "supplies/inventory_provisions_04.png";
		this.m.Amount = 15;
		this.m.Value = 20;
		this.m.GoodForDays = 2;
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
