this.legend_rsh_patience_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendRshPatience);
		this.legend_rune.create();
	}
});
