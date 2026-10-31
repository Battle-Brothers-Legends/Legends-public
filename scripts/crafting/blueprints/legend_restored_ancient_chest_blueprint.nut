this.legend_restored_ancient_chest_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendRestoredAncientChest);
		this.blueprint.create();
	}
});
