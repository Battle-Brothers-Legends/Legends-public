this.legend_pie_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},

	function create() {
		this.food_item.create();
		this.m.ID = "supplies.legend_pie";
		this.m.Name = "Pie";
		this.m.Description = "A large pie made from freshly sourced ingredients. Can be eaten in battle to provide up to 4 healing and fatigue recovery each turn for five turns, based on the amount remaining. Will be used as provisions if left in the company stash.";
		this.m.Icon = "supplies/legend_pie.png";
		this.m.Value = 250;
		this.m.GoodForDays = 11;
		this.m.Amount = 40.0;
	}

	function getBuyPrice() {
		if (this.m.IsSold) {
			return this.getSellPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null) {
			local isBuildingPresent = this.World.State.getCurrentTown().hasAttachedLocation("attached_location.wheat_fields");
			return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.getPriceMult() * this.World.State.getCurrentTown().getFoodPriceMult() * this.World.State.getCurrentTown().getBuyPriceMult() * (isBuildingPresent ? this.Const.World.Assets.BaseBuyPrice : this.Const.World.Assets.BuyPriceNotProducedHere)));
		}

		return this.item.getBuyPrice();
	}

	function getSellPrice() {
		if (this.m.IsBought) {
			return this.getBuyPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null) {
			local isBuildingPresent = this.World.State.getCurrentTown().hasAttachedLocation("attached_location.wheat_fields");
			return this.Math.floor(this.item.getSellPrice() * (isBuildingPresent ? this.Const.World.Assets.BaseSellPrice : this.Const.World.Assets.SellPriceNotProducedHere));
		}

		return this.item.getSellPrice();
	}
});
