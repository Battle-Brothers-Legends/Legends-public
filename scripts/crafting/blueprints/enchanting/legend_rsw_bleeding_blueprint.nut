this.legend_rsw_bleeding_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendRswBleeding);
		this.legend_rune.create();
	}
});
