this.legend_rsh_bravery_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendRshBravery);
		this.legend_rune.create();
	}
});
