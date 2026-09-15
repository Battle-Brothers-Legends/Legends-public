this.legend_stone_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},

	function create() {
		this.trading_good_item.create();
		this.m.ID = "misc.legend_stone";
		this.m.Name = "Stone";
		this.m.Description = "Heavy blocks of stone, often used as a building material.";
		this.m.Icon = "supplies/legend_stone.png";
		this.m.Culture = ::Const.World.Culture.Neutral;
		this.m.ProducingBuildings = [
			"attached_location.surface_copper_vein",
			"attached_location.surface_iron_vein",
			"attached_location.salt_mine",
			"attached_location.gem_mine",
			"attached_location.gold_mine"
		];
		this.m.Value = 25;
		this.m.ResourceValue = 1;
	}
});
