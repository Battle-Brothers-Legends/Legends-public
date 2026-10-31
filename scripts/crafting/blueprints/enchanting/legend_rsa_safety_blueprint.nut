this.legend_rsa_safety_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendRsaSafety);
		this.legend_rune.create();
	}
});
