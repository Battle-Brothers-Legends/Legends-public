this.legend_tower_shield_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendTowerShield);
		this.blueprint.create();
		this.m.PreviewCraftable.m.Name = "Company Tower Shield";
	}

	function onCraft(_stash) {
		local item = this.new("scripts/items/shields/legend_tower_shield");
		item.onPaintInCompanyColors();
		_stash.add(item);
	}
});
