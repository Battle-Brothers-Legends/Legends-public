this.legend_porridge_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},

	function create() {
		this.food_item.create();
		this.m.ID = "supplies.legend_porridge";
		this.m.Name = "Porridge";
		this.m.Description = "Provisions. A staple meal that can be made from whatever ingredients are to hand.";
		this.m.Icon = "supplies/legend_nut_soup.png"; // credit to Emo
		this.m.Value = 150;
		this.m.Amount = 40.0;
		this.m.GoodForDays = 9;
	}

	function getBuyPrice() {
		if (this.m.IsSold) {
			return this.getSellPrice();
		}

		if (("State" in ::World) && ::World.State != null && ::World.State.getCurrentTown() != null) {
			local isBuildingPresent = ::World.State.getCurrentTown().hasAttachedLocation("attached_location.wheat_fields");
			return ::Math.max(this.getSellPrice(), ::Math.ceil(this.getValue() * this.getPriceMult() * ::World.State.getCurrentTown().getFoodPriceMult() * ::World.State.getCurrentTown().getBuyPriceMult() * (isBuildingPresent ? ::Const.World.Assets.BaseBuyPrice : ::Const.World.Assets.BuyPriceNotProducedHere)));
		}

		return this.item.getBuyPrice();
	}

	function getSellPrice() {
		if (this.m.IsBought) {
			return this.getBuyPrice();
		}

		if (("State" in ::World) && ::World.State != null && ::World.State.getCurrentTown() != null) {
			local isBuildingPresent = ::World.State.getCurrentTown().hasAttachedLocation("attached_location.wheat_fields");
			return ::Math.floor(this.item.getSellPrice() * (isBuildingPresent ? ::Const.World.Assets.BaseSellPrice : ::Const.World.Assets.SellPriceNotProducedHere));
		}

		return this.item.getSellPrice();
	}
});
