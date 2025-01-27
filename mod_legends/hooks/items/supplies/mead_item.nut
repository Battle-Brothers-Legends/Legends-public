::mods_hookExactClass("items/supplies/mead_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Provisions. An alcoholic beverage made from honey. Both durable and tasty. Can be drunk in battle to grant +9% resolve, melee and ranged skill. At the expense of -36% initiative and -18% melee defense and ranged defense, the effect lasts for three turns. Will be used as provisions while travelling if left in the company stash.";
		this.m.Value = 210;
		this.m.Amount = 45.0;
		this.m.GoodForDays = 16;
	}

	o.getBuyPrice = function ()
	{
		if (this.m.IsSold)
		{
			return this.getSellPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			local isBuildingPresent = this.World.State.getCurrentTown().hasAttachedLocation("attached_location.beekeeper");
			return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.getPriceMult() * this.World.State.getCurrentTown().getFoodPriceMult() * this.World.State.getCurrentTown().getBuyPriceMult() * (isBuildingPresent ? this.Const.World.Assets.BaseBuyPrice : this.Const.World.Assets.BuyPriceNotProducedHere)));
		}

		return this.item.getBuyPrice();
	}

	o.onPutIntoBag <- function ()
	{
		this.onEquip();
	}

	o.onEquip <- function ()
	{
		this.food_item.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendDrinkMead, function (_skill) {
			_skill.setItem(this);
		}.bindenv(this));
	}
});
