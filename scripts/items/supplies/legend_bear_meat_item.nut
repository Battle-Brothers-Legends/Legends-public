this.legend_bear_meat_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},

	function create() {
		this.food_item.create();
		this.m.ID = "supplies.legend_bear_meat";
		this.m.Name = "Bear Meat";
		this.m.Description = "Provisions. Large chunks of foul smelling meat from a ferocious bear.";
		this.m.Icon = "supplies/legend_bear_meat.png";
		this.m.Amount = 20;
		this.m.Value = 45;
		this.m.GoodForDays = 1;
		this.m.IsUndesirable = true;
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
