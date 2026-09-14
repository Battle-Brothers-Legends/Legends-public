this.legend_iron_ore_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},

	function create() {
		this.trading_good_item.create();
		this.m.ID = "misc.legend_iron_ore";
		this.m.Name = "Iron Ore";
		this.m.Description = "A chunk of iron ore, unshaped and unguided.";
		this.m.Icon = "trade/legend_iron_ore.png";
		this.m.Culture = ::Const.World.Culture.Neutral;
		this.m.ProducingBuildings = [
			"attached_location.surface_iron_vein"
		];
		this.m.Value = 30;
		this.m.ResourceValue = 1;
	}
});
