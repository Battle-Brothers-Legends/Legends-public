this.legend_petrified_wood_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},

	function create() {
		this.trading_good_item.create();
		this.m.ID = "misc.legend_petrified_wood";
		this.m.Name = "Petrified Wood";
		this.m.Description = "An ancient chunk of wood that has turned to stone in its entirety. Traders will pay good coin for this.";
		this.m.Icon = "supplies/legend_petrified_wood.png";
		this.m.Culture = ::Const.World.Culture.Neutral;
		this.m.ProducingBuildings = [
			"attached_location.gatherers_hut"
		];
		this.m.Value = 250;
		this.m.ResourceValue = 2;
	}
});
