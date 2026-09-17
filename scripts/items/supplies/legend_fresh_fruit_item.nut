this.legend_fresh_fruit_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},

	function create() {
		this.food_item.create();
		this.m.ID = "supplies.legend_fresh_fruit";
		this.m.Name = "Fresh Fruit";
		this.m.Description = "Provisions. Freshly picked, this fruit tastes great but will not last long.";
		this.m.Icon = "supplies/legend_fresh_fruit.png";
		this.m.Value = 20;
		this.m.Amount = 15.0;
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
