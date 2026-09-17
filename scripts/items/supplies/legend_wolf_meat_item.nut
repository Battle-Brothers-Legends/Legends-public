this.legend_wolf_meat_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},

	function create() {
		this.food_item.create();
		this.m.ID = "supplies.legend_wolf_meat";
		this.m.Name = "Wolf Meat";
		this.m.Description = "Provisions. Foul smelling meat from the howling bane of shepherds.";
		this.m.Icon = "supplies/legend_fresh_meat.png"; // credit to Emo
		this.m.Amount = 15;
		this.m.Value = 30;
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
