this.legend_coal_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},

	function create() {
		this.trading_good_item.create();
		this.m.ID = "misc.legend_coal";
		this.m.Name = "Coal";
		this.m.Description = "A dense lump of black carbon, valued for its forge fire fueling ability.";
		this.m.Icon = "supplies/legend_coal.png";
		this.m.Culture = ::Const.World.Culture.Neutral;
		this.m.ProducingBuildings = [
			"attached_location.surface_iron_vein"
		];
		this.m.Value = 25;
		this.m.ResourceValue = 1;
	}
});
