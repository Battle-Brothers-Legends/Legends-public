this.legend_resin_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},

	function create() {
		this.trading_good_item.create();
		this.m.ID = "misc.legend_resin";
		this.m.Name = "Resin";
		this.m.Description = "High quality resin used in coatings and adhesives. Traders will pay good coin for this.";
		this.m.Icon = "supplies/legend_resin.png";
		this.m.Culture = ::Const.World.Culture.Neutral;
		this.m.ProducingBuildings = [
			"attached_location.lumber_camp"
		];
		this.m.Value = 200;
		this.m.ResourceValue = 2;
	}
});
