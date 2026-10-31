this.legend_rsw_accuracy_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendRswAccuracy);
		this.legend_rune.create();
	}
});
