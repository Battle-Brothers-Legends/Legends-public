this.legend_silver_ore_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},

	function create() {
		this.trading_good_item.create();
		this.m.ID = "misc.legend_silver_ore";
		this.m.Name = "Silver Ore";
		this.m.Description = "This rock shines brightly with fine silver. Traders will pay good coin for this.";
		this.m.Icon = "trade/legend_silver_ore.png";
		this.m.Culture = ::Const.World.Culture.Neutral;
		this.m.ProducingBuildings = [
			"attached_location.gold_mine",
			"attached_location.surface_iron_vein"
		];
		this.m.Value = 180;
		this.m.ResourceValue = 2;
	}
});
