this.legend_restored_ancient_helm_01_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendRestoredAncientHelm01);
		this.blueprint.create();
	}
});
