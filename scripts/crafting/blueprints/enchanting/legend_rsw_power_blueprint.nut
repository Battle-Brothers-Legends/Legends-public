this.legend_rsw_power_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendRswPower);
		this.legend_rune.create();
	}
});
