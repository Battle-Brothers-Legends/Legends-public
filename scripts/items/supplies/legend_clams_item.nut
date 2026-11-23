this.legend_clams_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.legend_clams";
		this.m.Name = "Clams";
		this.m.Description = "Provisions. Shelled fish, a bit slimy but a filling meal favored by fishmongers. Can be eaten in battle to provide up to 1 healing and fatigue recovery over ten turns, based on the amount remaining. Will be gradually used as provisions if left in the company stash.";
		this.m.Icon = "supplies/legend_white_clams.png"; // credit to Emo
		this.m.Amount = 10;
		this.m.Value = 15;
		this.m.GoodForDays = 1;
		this.m.IsUndesirable = false;
	}

	function getBuyPrice()
	{
		if (this.m.IsSold)
		{
			return this.getSellPrice();
		}

		if (::FU.GetTown() != null)
		{
			return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.getPriceMult() * ::FU.GetTown().getFoodPriceMult() * ::FU.GetTown().getBuyPriceMult()));
		}

		return this.item.getBuyPrice();
	}

	function getSellPrice()
	{
		if (this.m.IsBought)
		{
			return this.getBuyPrice();
		}

		if (::FU.GetTown() != null)
		{
			return this.Math.floor(this.getValue() * ::FU.GetTown().getFoodPriceMult() * ::FU.GetTown().getSellPriceMult());
		}

		return this.item.getSellPrice();
	}

	function onPutIntoBag()
	{
		this.onEquip();
	}

	function onEquip()
	{
		this.food_item.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendEatRations, function (_skill) {
			_skill.setItem(this);
			_skill.setAmount(this.m.Amount);
		}.bindenv(this));
	}
});
