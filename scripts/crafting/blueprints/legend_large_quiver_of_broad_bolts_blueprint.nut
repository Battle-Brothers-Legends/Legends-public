this.legend_large_quiver_of_broad_bolts_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendLargeQuiverOfBroadBolts);
		this.blueprint.create();
	}
});
