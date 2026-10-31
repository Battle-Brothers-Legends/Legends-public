this.legend_rsw_feeding_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendRswFeeding);
		this.legend_rune.create();
	}
});
