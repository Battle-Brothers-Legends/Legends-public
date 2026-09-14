this.legend_copper_ore_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},

	function create() {
		this.trading_good_item.create();
		this.m.ID = "misc.legend_copper_ore";
		this.m.Name = "Copper Ore";
		this.m.Description = "A coarse lump of unrefined brassy ore, waiting to be smelted.";
		this.m.Icon = "trade/legend_copper_ore.png";
		this.m.Culture = ::Const.World.Culture.Neutral;
		this.m.ProducingBuildings = [
			"attached_location.surface_iron_vein"
		];
		this.m.Value = 15;
		this.m.ResourceValue = 1;
	}
});
