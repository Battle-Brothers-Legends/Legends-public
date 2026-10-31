this.legend_rsw_poison_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendRswPoison);
		this.legend_rune.create();
	}
});
