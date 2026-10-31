this.legend_rsw_blazing_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendRswBlazing);
		this.legend_rune.create();
	}
});
