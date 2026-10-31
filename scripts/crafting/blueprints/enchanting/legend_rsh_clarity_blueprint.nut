this.legend_rsh_clarity_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendRshClarity);
		this.legend_rune.create();
	}
});
